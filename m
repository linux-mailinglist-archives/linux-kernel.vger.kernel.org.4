Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B9260DF95
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbiJZLbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbiJZLah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:30:37 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1991F3D592
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:30:31 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so3257245pjh.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfJZOEZUcigJa5MAkTFt0GQw8t62BAN+ikSaaiyKqzg=;
        b=Hk7CS3au15tpcnLWnpgWC0Rnc801I8tY9u+HaqWxqlYNuxpQN/yv0Fy4xMMEg4wiFp
         P1cmYme01LnaBIZiGnBSDg11RxQ6kx8NOUMHePDUSScdBnB4S+SETARYJdvD2HbhOKXH
         71mfQKa3CRGhmyw1+LSbb4hFSYGLyJycxikyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfJZOEZUcigJa5MAkTFt0GQw8t62BAN+ikSaaiyKqzg=;
        b=fj0mhjKRwTdJBwB5rmRuetmoxx+K+HpsGo/Da2sf/aN4PaaibtEI2Cu/iOYkyT+EZQ
         fQ8NzbNncJ7k0RKoR+N6FbJWVXnvdqAR1tkeE/O8hz3Qj3i5kzH2FHSSVbasN1hGHdyE
         xLezCQrfJLsfmlpeqn6ov8Fpnk7naARh/TUopD9ViW7ZeRAbmdf41D3tmtUxaeGQFE7+
         tqQSzqmpk8KLRAsa73VKyKqtJM/W0fARlkvvi9EX8kScZ0dEd0/YSBunaaY65y1X481D
         CAVhwXSPJDLkJ+vgqFrVz1lMRiMookNiovtUfuEgCdVMilynenHI1ajEuUtFQL2KEyWU
         /8Iw==
X-Gm-Message-State: ACrzQf1fuL8nk3JkwW+Tb2j90OwIRqiYcEwhn1fW/WwF1kwFjH+GEsx2
        L2Qfp9gAf2gJ4h84qWMhhExjBQ==
X-Google-Smtp-Source: AMsMyM6pFzr/Nn/uvAjan7oO4hayW5IPIevd8ht+/9uN4dYdxV1aG5KBcN/L1bDFkLxcnNYJrtvF0A==
X-Received: by 2002:a17:90b:380b:b0:20b:8dd:4f5f with SMTP id mq11-20020a17090b380b00b0020b08dd4f5fmr3788594pjb.158.1666783830341;
        Wed, 26 Oct 2022 04:30:30 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:749c:f7f5:1a8e:d0be])
        by smtp.gmail.com with ESMTPSA id x127-20020a626385000000b005627868e27esm2814919pfb.127.2022.10.26.04.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 04:30:30 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 8/9] Documentation: document zram pages_per_pool_page attribute
Date:   Wed, 26 Oct 2022 20:29:32 +0900
Message-Id: <20221026112933.4122957-9-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221026112933.4122957-1-senozhatsky@chromium.org>
References: <20221026112933.4122957-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
2.38.0.135.g90850a2211-goog

