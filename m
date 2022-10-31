Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D352E612FE1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 06:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiJaFmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 01:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiJaFmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 01:42:03 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748B4C75A
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 22:41:37 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d24so9838499pls.4
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 22:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzo+UO6rKhGS8H3i9OK87Ngl18bf6HViCqWtuB03u/E=;
        b=QRDjYTAa+Msioavw2AlKW7FO+YjBklxX0gbCjIerT/q6sgi8l09+WqL5NncXeQx8HR
         PnpF5DB5BqOsiTGvYpsH7rM3Fl8J6lOQwfY44y+wCYfe8j//qW941wMUIO8QV/BUIVpj
         6ckxz/ZqCZaUcEhZmAgLkZHCEIGZ391OlshRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzo+UO6rKhGS8H3i9OK87Ngl18bf6HViCqWtuB03u/E=;
        b=Egu83Qsq6Z/8CB5KtBC6Xsk3Z3ng9BIojrTegf+fexBTWzsYIEEH4sTxHcFaN4Q7Lq
         I1tAM3myCJg6RUKJhy++U/uAFjjwS0wEJ/zrMG+eWLPGi/siOQw9fCtr02vDDFcTtL6p
         LJQ0KStgTUxbyltr76nBTnAI8ZGig7YLFKsDfMhe3Wabuy9ZrxtPshTRgV2MFzhq69tE
         9z0YzvepwDlL+UtyEaV5ACvHVACVnJHPyeFjYGrkpHCHs3USgEZOBhEyRN4jDCLA8a06
         ueMN0bhorjwfWvSUGlkJmB8o4MZDfuAWFDMly7F45bpjS3Xs3whE+NqawRurwSHNj5SG
         chgA==
X-Gm-Message-State: ACrzQf1NyY6FdgJNUcrN1rfzIBWz99lfpIKC8L2047v+fbTDt5Pn+U2T
        Odb6f68OhbsLTIFRQq3tOWU/69GCcuaQ/g==
X-Google-Smtp-Source: AMsMyM7RMqnJKcNesc8xRgpLESfPOrmIQondTpLCG88+n4Qycd5Ej9QZbYthOOomLsB9/+hUELa8gw==
X-Received: by 2002:a17:90b:1c88:b0:203:8400:13a9 with SMTP id oo8-20020a17090b1c8800b00203840013a9mr13324117pjb.46.1667194897457;
        Sun, 30 Oct 2022 22:41:37 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:7616:afe0:ba6c:96f4])
        by smtp.gmail.com with ESMTPSA id w12-20020aa79a0c000000b0056befcd7958sm3573308pfj.84.2022.10.30.22.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 22:41:37 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv4 8/9] Documentation: document zram pages_per_pool_page attribute
Date:   Mon, 31 Oct 2022 14:41:07 +0900
Message-Id: <20221031054108.541190-9-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
In-Reply-To: <20221031054108.541190-1-senozhatsky@chromium.org>
References: <20221031054108.541190-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a simple documentation for pages_per_pool_page ZRAM
device attribute.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/admin-guide/blockdev/zram.rst | 38 ++++++++++++++++-----
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 010fb05a5999..4cb287520d45 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -112,7 +112,29 @@ to list all of them using, for instance, /proc/crypto or any other
 method. This, however, has an advantage of permitting the usage of
 custom crypto compression modules (implementing S/W or H/W compression).
 
-4) Set Disksize
+4) Set pages per-pool page limit: Optional
+==========================================
+
+zsmalloc pages can consist of up to ZS_DEFAULT_PAGES_PER_ZSPAGE (single)
+physical pages. The exact number is calculated for each zsmalloc size
+class during zsmalloc pool creation. ZRAM provides pages_per_pool_page
+device attribute that lets one adjust that limit (maximum possible value
+is ZS_MAX_PAGES_PER_ZSPAGE). The default limit is considered to be good
+enough, so tweak this value only when the changes in zsmalloc size classes
+characteristics are beneficial for your data patterns. The limit on the
+pages per zspages (currently) should be in [1,16] range; default value
+is 4.
+
+Examples::
+
+	#show current zsmalloc pages per-pool page limit
+	cat /sys/block/zramX/pages_per_pool_page
+	4
+
+	#set zsmalloc pages per-pool page limit
+	echo 8 > /sys/block/zramX/pages_per_pool_page
+
+5) Set Disksize
 ===============
 
 Set disk size by writing the value to sysfs node 'disksize'.
@@ -132,7 +154,7 @@ There is little point creating a zram of greater than twice the size of memory
 since we expect a 2:1 compression ratio. Note that zram uses about 0.1% of the
 size of the disk when not in use so a huge zram is wasteful.
 
-5) Set memory limit: Optional
+6) Set memory limit: Optional
 =============================
 
 Set memory limit by writing the value to sysfs node 'mem_limit'.
@@ -151,7 +173,7 @@ Examples::
 	# To disable memory limit
 	echo 0 > /sys/block/zram0/mem_limit
 
-6) Activate
+7) Activate
 ===========
 
 ::
@@ -162,7 +184,7 @@ Examples::
 	mkfs.ext4 /dev/zram1
 	mount /dev/zram1 /tmp
 
-7) Add/remove zram devices
+8) Add/remove zram devices
 ==========================
 
 zram provides a control interface, which enables dynamic (on-demand) device
@@ -182,7 +204,7 @@ execute::
 
 	echo X > /sys/class/zram-control/hot_remove
 
-8) Stats
+9) Stats
 ========
 
 Per-device statistics are exported as various nodes under /sys/block/zram<id>/
@@ -283,15 +305,15 @@ a single line of text and contains the following stats separated by whitespace:
 		Unit: 4K bytes
  ============== =============================================================
 
-9) Deactivate
-=============
+10) Deactivate
+==============
 
 ::
 
 	swapoff /dev/zram0
 	umount /dev/zram1
 
-10) Reset
+11) Reset
 =========
 
 	Write any positive value to 'reset' sysfs node::
-- 
2.38.1.273.g43a17bfeac-goog

