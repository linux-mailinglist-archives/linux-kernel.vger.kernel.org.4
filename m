Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9850460B91F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiJXUEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbiJXUD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:03:57 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC4938A0E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:24:55 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id o64so11672035oib.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+L/wgZJq25QWZOfBJI7Y8G4kNdlVFzsE8gcKEq0Mfs=;
        b=ZT+bcVMBNk7fpdzG51qvU+nw1MQlFcyYzv6wxeZnY1j+dre6v7vQ6lHY5Ifk344dlP
         gdAvAMVQmF+7ROzaIojNXfakKOHyzc9qvCV2j2xBa1B8l4HMqv5zJmx3MP2QUkXEn+gr
         ee7UlBpMa++JOciZw2MCsyIYwsJxjL7k2zx7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+L/wgZJq25QWZOfBJI7Y8G4kNdlVFzsE8gcKEq0Mfs=;
        b=Jjlz1RE4I/lTm/HGBYemcmdE4O+zt7pDtKwvXYQvBlr4Sg9VBcmAqBZAQge3ldkKXb
         9Jng1Ud4jAwDWQUHO6E16yuxACE5CtgnxHCfnBP7mvAxloE98D1leK+q9SLK35UBLnEX
         HqSrhFw1TMxO7xyIYEi+GTntOLkAcx2oQFAshMq2WeV8mFD5b9xTvRsj2EcL3KCTnxcT
         iDcBytMJ+ApIsua5mDhA24SMmAh3T+zJz83wq3f8GRKnw6HVx51nrpLdQ3iq8ZmKe4wi
         9lZQMmNU2BK1FdGgYu4W60R2VsUSHxBBLz+EUQTNz2GcM49kyQRaDYHeZX0lOeV6DMlM
         YW6A==
X-Gm-Message-State: ACrzQf1AbAii47LLWGLotKlOmaZMptnvOfHNvu6qfjoHTS0CeELlzdQU
        olSvfzFSMNgzI2hmX98+pu1d7WYcl3PTUg==
X-Google-Smtp-Source: AMsMyM7QdS4FtEGrBDpWgc9Evd5MJ+xSYAJnNXyqo5gXSJ1mvVH/il24Yx4mUoL6wddj14/oGzHbng==
X-Received: by 2002:a17:90b:2317:b0:213:26a3:246f with SMTP id mt23-20020a17090b231700b0021326a3246fmr3082381pjb.148.1666627955871;
        Mon, 24 Oct 2022 09:12:35 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5f9c:c5bc:902f:3da4])
        by smtp.gmail.com with ESMTPSA id u70-20020a627949000000b0056b8726d2d3sm5162pfc.157.2022.10.24.09.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 09:12:35 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 4/6] Documentation: document zram pool_page_order attribute
Date:   Tue, 25 Oct 2022 01:12:11 +0900
Message-Id: <20221024161213.3221725-5-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221024161213.3221725-1-senozhatsky@chromium.org>
References: <20221024161213.3221725-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a simple documentation for zram pool_page_order
device attribute.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/admin-guide/blockdev/zram.rst | 31 ++++++++++++++++-----
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 010fb05a5999..cd12a5982ae0 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -112,7 +112,24 @@ to list all of them using, for instance, /proc/crypto or any other
 method. This, however, has an advantage of permitting the usage of
 custom crypto compression modules (implementing S/W or H/W compression).
 
-4) Set Disksize
+4) Set maximum pool page order
+==============================
+
+zsmalloc pages can consist of up to 2^N physical pages. The exact size
+is calculated per each zsmalloc size class during zsmalloc pool creation.
+ZRAM provides pool_page_order device attribute to see or change N.
+
+Examples::
+
+	#show current maximum zsmalloc page order
+	cat /sys/block/zramX/pool_page_order
+	2
+
+	#set maximum zsmalloc page order
+	echo 3 > /sys/block/zramX/pool_page_order
+
+
+5) Set Disksize
 ===============
 
 Set disk size by writing the value to sysfs node 'disksize'.
@@ -132,7 +149,7 @@ There is little point creating a zram of greater than twice the size of memory
 since we expect a 2:1 compression ratio. Note that zram uses about 0.1% of the
 size of the disk when not in use so a huge zram is wasteful.
 
-5) Set memory limit: Optional
+6) Set memory limit: Optional
 =============================
 
 Set memory limit by writing the value to sysfs node 'mem_limit'.
@@ -151,7 +168,7 @@ Examples::
 	# To disable memory limit
 	echo 0 > /sys/block/zram0/mem_limit
 
-6) Activate
+7) Activate
 ===========
 
 ::
@@ -162,7 +179,7 @@ Examples::
 	mkfs.ext4 /dev/zram1
 	mount /dev/zram1 /tmp
 
-7) Add/remove zram devices
+8) Add/remove zram devices
 ==========================
 
 zram provides a control interface, which enables dynamic (on-demand) device
@@ -182,7 +199,7 @@ execute::
 
 	echo X > /sys/class/zram-control/hot_remove
 
-8) Stats
+9) Stats
 ========
 
 Per-device statistics are exported as various nodes under /sys/block/zram<id>/
@@ -283,7 +300,7 @@ a single line of text and contains the following stats separated by whitespace:
 		Unit: 4K bytes
  ============== =============================================================
 
-9) Deactivate
+10) Deactivate
 =============
 
 ::
@@ -291,7 +308,7 @@ a single line of text and contains the following stats separated by whitespace:
 	swapoff /dev/zram0
 	umount /dev/zram1
 
-10) Reset
+11) Reset
 =========
 
 	Write any positive value to 'reset' sysfs node::
-- 
2.38.0.135.g90850a2211-goog

