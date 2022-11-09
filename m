Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA56B622AFA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiKILwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiKILvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:51:32 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FBA31216
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:51:23 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id v28so16444082pfi.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 03:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78mZXjDUqjc2CGPH2b0kN46OixnL1hoGKm7bE9XBgUM=;
        b=IYn1pZPbT037tiskU40SdcUjr00Tb2lBA9rYT1D2KmHOqM8EdBQ1VdZg5ulYfsHP9S
         6TKjKXb8ojMut+VZdnTW4d1VRfI7CfvfRNdt+nviVa7k35eGqRtMxtMJsHHgyGLW1otC
         FMK6emkiAqsGvvLekKvM1N8+He8/Dg8Ekinew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=78mZXjDUqjc2CGPH2b0kN46OixnL1hoGKm7bE9XBgUM=;
        b=m5BqeFSZQ1nIifPoNaRmpGxe0V4tcuHbZxdTe8x0ogT7mFWawmj1yGw9rwhuy1Wu8g
         /9O8fFzWSgTEm0VH/eWQyW8cm1TC3t0Jeme04FGB7/81FcOADhLT2ABJ4CVKNxktC2tF
         wMNvvu1e6qWOn/kYIIb6/VNHZDo9RZfVEmkub2NKMPxdDY4kHiz/cC+XPucCeHm31Mwb
         Q6vQtAqK9K4fIyo4hbvVkbkohEOUdXRBtJv0BzwOuZ/1pM41CDINj+gHjdMOYX+8QZ5l
         kZBQaadYqvScI1FVi9A+HfVvhSVwRtNc4aUCgIqe8u8EKr/et+N2f5mF3jMBw1d6Zd/x
         fuMQ==
X-Gm-Message-State: ACrzQf1C6OEWTtHa+tF49Q1v8nVzgXzBaYJn2LZiomQvtTQuycWhvRDi
        zGIQoCGGJ9+wsLEmFfJEqr0bZbQaUWM1LQ==
X-Google-Smtp-Source: AMsMyM4evVnWSvLkw+dSHbFX3CGE0wpnSBNFc155E+fkSbYY7z5M05e2ebLt+A3Ah2OBlfptSutn1w==
X-Received: by 2002:a05:6a02:113:b0:43f:3554:ff9c with SMTP id bg19-20020a056a02011300b0043f3554ff9cmr52961284pgb.578.1667994683200;
        Wed, 09 Nov 2022 03:51:23 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:61f1:44d3:3f47:2cdb])
        by smtp.gmail.com with ESMTPSA id f5-20020a655505000000b00434760ee36asm7292311pgr.16.2022.11.09.03.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 03:51:22 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>,
        Suleiman Souhlal <suleiman@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv5 11/13] documentation: Add zram recompression documentation
Date:   Wed,  9 Nov 2022 20:50:45 +0900
Message-Id: <20221109115047.2921851-12-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221109115047.2921851-1-senozhatsky@chromium.org>
References: <20221109115047.2921851-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document user-space visible device attributes that
are enabled by ZRAM_MULTI_COMP.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/admin-guide/blockdev/zram.rst | 81 +++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 177a142c3146..d898b7ace33d 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -401,6 +401,87 @@ budget in next setting is user's job.
 If admin wants to measure writeback count in a certain period, they could
 know it via /sys/block/zram0/bd_stat's 3rd column.
 
+recompression
+-------------
+
+With CONFIG_ZRAM_MULTI_COMP, zram can recompress pages using alternative
+(secondary) compression algorithms. The basic idea is that alternative
+compression algorithm can provide better compression ratio at a price of
+(potentially) slower compression/decompression speeds. Alternative compression
+algorithm can, for example, be more successful compressing huge pages (those
+that default algorithm failed to compress). Another application is idle pages
+recompression - pages that are cold and sit in the memory can be recompressed
+using more effective algorithm and, hence, reduce zsmalloc memory usage.
+
+With CONFIG_ZRAM_MULTI_COMP, zram supports up to 4 compression algorithms:
+one primary and up to 3 secondary ones. Primary zram compressor is explained
+in "3) Select compression algorithm", secondary algorithms are configured
+using recomp_algorithm device attribute.
+
+Example:::
+
+	#show supported recompression algorithms
+	cat /sys/block/zramX/recomp_algorithm
+	#1: lzo lzo-rle lz4 lz4hc [zstd]
+	#2: lzo lzo-rle lz4 [lz4hc] zstd
+
+Alternative compression algorithms are sorted by priority. In the example
+above, zstd is used as the first alternative algorithm, which has priority
+of 1, while lz4hc is configured as a compression algorithm with priority 2.
+Alternative compression algorithm's priority is provided during algorithms
+configuration:::
+
+	#select zstd recompression algorithm, priority 1
+	echo "algo=zstd priority=1" > /sys/block/zramX/recomp_algorithm
+
+	#select deflate recompression algorithm, priority 2
+	echo "algo=deflate priority=2" > /sys/block/zramX/recomp_algorithm
+
+Another device attribute that CONFIG_ZRAM_MULTI_COMP enables is recompress,
+which controls recompression.
+
+Examples:::
+
+	#IDLE pages recompression is activated by `idle` mode
+	echo "type=idle" > /sys/block/zramX/recompress
+
+	#HUGE pages recompression is activated by `huge` mode
+	echo "type=huge" > /sys/block/zram0/recompress
+
+	#HUGE_IDLE pages recompression is activated by `huge_idle` mode
+	echo "type=huge_idle" > /sys/block/zramX/recompress
+
+The number of idle pages can be significant, so user-space can pass a size
+threshold (in bytes) to the recompress knob: zram will recompress only pages
+of equal or greater size:::
+
+	#recompress all pages larger than 3000 bytes
+	echo "threshold=3000" > /sys/block/zramX/recompress
+
+	#recompress idle pages larger than 2000 bytes
+	echo "type=idle threshold=2000" > /sys/block/zramX/recompress
+
+Recompression of idle pages requires memory tracking.
+
+During re-compression for every page, that matches re-compression criteria,
+ZRAM iterates the list of registered alternative compression algorithms in
+order of their priorities. ZRAM stops either when re-compression was
+successful (re-compressed object is smaller in size than the original one)
+and matches re-compression criteria (e.g. size threshold) or when there are
+no secondary algorithms left to try. If none of the secondary algorithms can
+successfully re-compressed the page such a page is marked as incompressible,
+so ZRAM will not attempt to re-compress it in the future.
+
+This re-compression behaviour, when it iterates through the list of
+registered compression algorithms, increases our chances of finding the
+algorithm that successfully compresses a particular page. Sometimes, however,
+it is convenient (and sometimes even necessary) to limit recompression to
+only one particular algorithm so that it will not try any other algorithms.
+This can be achieved by providing a algo=NAME parameter:::
+
+	#use zstd algorithm only (if registered)
+	echo "type=huge algo=zstd" > /sys/block/zramX/recompress
+
 memory tracking
 ===============
 
-- 
2.38.1.431.g37b22c650d-goog

