Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADFB60EF04
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 06:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbiJ0E1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 00:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbiJ0E1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 00:27:17 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1F813A7FF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 21:27:16 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id g129so133790pgc.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 21:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfJZOEZUcigJa5MAkTFt0GQw8t62BAN+ikSaaiyKqzg=;
        b=Ha3HWb3QEL2wAUei2E+xdtM/8MgiD5xkJ2+KGW7ASzNP1x7TN4j0HYIFu+8jGt+wPC
         RBWYYxFesKjH5fTCLTVjXR7Bh8OmrCWl/XzgyrX5MUGIKV8GVywLF9wAmH7NijSYHVGG
         QYr7eTqzjKYjJoyp0rodElpITNvzWxYDgPiMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfJZOEZUcigJa5MAkTFt0GQw8t62BAN+ikSaaiyKqzg=;
        b=hMdiYj0vEB3o1OFEgRtlOZV9gV/3qO3kH9Rhc6xJMlde2l/IBxenYx5qh894TKUb07
         E4hrs8tGU+ZJGYuY+C/MLoEw3bYkG6jeGFEUXmASTcv/WrboWLflvtoJwFh0tQmelS4X
         p2sWU8rTJqM3M6BLQTZbs9h4L85K1aVsdA18nFTFBQd+tFTvgx4x4pb4WfhSES9zSPSY
         bAMd37nLyNOtzXZjXH4wiOFQzBAWI9an+RMBnAEcexlZ0vyURrJFqaW/DsL2KezHqo4w
         9TSeFqH/VavW0850GQWhgTNwYariJuglbuXoyXyWesGUjQ0l/fn7kvVMlk226VXJ3tWD
         FvPg==
X-Gm-Message-State: ACrzQf24JX2LCVI6omepY8HBjHT0bFGopdmaYujo8cVGNe5SOH7MDjeJ
        ryuipWo4zjrWNNMpt10vVrLgAA==
X-Google-Smtp-Source: AMsMyM7ThsUAVtRWF4QYvAYelWAHXIMYiM1JSDHU9HcoznhoEpkt3lbidbLFOWqSQq0TVrKr9qB6Kg==
X-Received: by 2002:a05:6a00:150e:b0:56c:83b3:d148 with SMTP id q14-20020a056a00150e00b0056c83b3d148mr3568040pfu.48.1666844836111;
        Wed, 26 Oct 2022 21:27:16 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:30f2:4501:65fa:df12])
        by smtp.gmail.com with ESMTPSA id w23-20020aa79557000000b00565c8634e55sm203140pfq.135.2022.10.26.21.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 21:27:15 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 8/9] Documentation: document zram pages_per_pool_page attribute
Date:   Thu, 27 Oct 2022 13:26:50 +0900
Message-Id: <20221027042651.234524-9-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
In-Reply-To: <20221027042651.234524-1-senozhatsky@chromium.org>
References: <20221027042651.234524-1-senozhatsky@chromium.org>
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

