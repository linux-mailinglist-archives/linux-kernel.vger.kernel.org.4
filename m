Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E7D5BC170
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 04:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiISChh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 22:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiISCh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 22:37:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D877719284
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 19:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663555044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7a6Yx196aUqplgt5mT2Q5wrzyl9YUk8UESPewUTSVmI=;
        b=hdhdu20ituQe8ZsFhwMXab0BCk2Zt4TeVCGsQzbJSGZtOcccUxSRWIs6BgtGSr0+QYcBj6
        v0PJOXoz99DJuloHTDwtp9Pl237HtIs0qGPTYMhXreLD4Dpi4uLJitFclqfgNJhWVKVR81
        rOkY/25ev2jgRQaQjPIjUmI6PCLhs2Q=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-564-Dmd9Op-RNT-lNz6Rs2ZN3Q-1; Sun, 18 Sep 2022 22:37:15 -0400
X-MC-Unique: Dmd9Op-RNT-lNz6Rs2ZN3Q-1
Received: by mail-qk1-f199.google.com with SMTP id f12-20020a05620a408c00b006ced53b80e5so5355159qko.17
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 19:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=7a6Yx196aUqplgt5mT2Q5wrzyl9YUk8UESPewUTSVmI=;
        b=5Xuy4vHqqT8g+gxaR2phT4xwBX07hfNgYCO4BRjdVBliXfD0h+/8wXs2R8G2QsOE0e
         DGxrrmDCiQEG3BmoDNVsaUTM9YTdOp4FxoSWiC1Kvb5d3MLicQ0j1FlW8s8nGfWNQHzh
         SkFMYjZDiJXf/o2NcH88vVGiZpATMbufegQ1+R8LMI3MIeXZRfcnW6FxTXzSlPVOjLEy
         SsV2ljRJQsVf11eH1YqCnliMMur95HoD3E6CUJGJ0RFgdmwgo4FnSVS98Lq9Lyq2pCTI
         EdfPC6zP8C5C55p0TVufARN7OuO98MfKcUMdHPQ+qEebGWgMKNuXGFf94LjrCz6rpfVd
         5CFg==
X-Gm-Message-State: ACrzQf3rbEDIFX8g0Y18yvwv3QG0Tfuqw84GOcDNGHKv/lswMAY3Y6CJ
        z0vixIWpOKe3ON9AqZQnBC4yqToqK0+CbexwM7u+vlabh5iId/EmsXkOH397xsJsagRRN8xbNeC
        KyJYdj/eeSY+Af16u9MvumXJU
X-Received: by 2002:ac8:5b4d:0:b0:35b:b5fa:5e24 with SMTP id n13-20020ac85b4d000000b0035bb5fa5e24mr13585975qtw.163.1663555035071;
        Sun, 18 Sep 2022 19:37:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM47VVKyCebEesRkuNHbGB2XW5rQsuVvwBSNGfwnQtWukFFfXPDSFto/cMMKiuqOMdgKSB2s4w==
X-Received: by 2002:ac8:5b4d:0:b0:35b:b5fa:5e24 with SMTP id n13-20020ac85b4d000000b0035bb5fa5e24mr13585954qtw.163.1663555034848;
        Sun, 18 Sep 2022 19:37:14 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id m18-20020a05620a291200b006cf19068261sm743253qkp.116.2022.09.18.19.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 19:37:14 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, aric.cyr@amd.com, Nevenko.Stupar@amd.com,
        Pavle.Kotarac@amd.com, mairacanal@riseup.net,
        aurabindo.pillai@amd.com, Bing.Guo@amd.com, hamza.mahfooz@amd.com,
        nicholas.kazlauskas@amd.com, agustin.gutierrez@amd.com,
        nathan@kernel.org, mdaenzer@redhat.com, Charlene.Liu@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/display: remove redundant CalculateTWait's
Date:   Sun, 18 Sep 2022 22:37:09 -0400
Message-Id: <20220919023709.3447570-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several copies of CalculateTwait.
Reduce to one instance and change local variable name to match common usage.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 .../dc/dml/dcn20/display_mode_vba_20.c        | 16 +++++++-------
 .../dc/dml/dcn20/display_mode_vba_20v2.c      | 21 ++-----------------
 .../dc/dml/dcn21/display_mode_vba_21.c        | 19 +----------------
 .../dc/dml/dcn30/display_mode_vba_30.c        | 18 +---------------
 .../dc/dml/dcn31/display_mode_vba_31.c        | 13 +-----------
 .../dc/dml/dcn314/display_mode_vba_314.c      | 13 +-----------
 6 files changed, 14 insertions(+), 86 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
index 6e9d7e2b5243..4ca080950924 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
@@ -153,10 +153,10 @@ static unsigned int CalculateVMAndRowBytes(
 		bool *PTEBufferSizeNotExceeded,
 		unsigned int *dpte_row_height,
 		unsigned int *meta_row_height);
-static double CalculateTWait(
+double CalculateTWait(
 		unsigned int PrefetchMode,
 		double DRAMClockChangeLatency,
-		double UrgentLatencyPixelDataOnly,
+		double UrgentLatency,
 		double SREnterPlusExitTime);
 static double CalculateRemoteSurfaceFlipDelay(
 		struct display_mode_lib *mode_lib,
@@ -2892,20 +2892,20 @@ static void dml20_DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
 	}
 }
 
-static double CalculateTWait(
+double CalculateTWait(
 		unsigned int PrefetchMode,
 		double DRAMClockChangeLatency,
-		double UrgentLatencyPixelDataOnly,
+		double UrgentLatency,
 		double SREnterPlusExitTime)
 {
 	if (PrefetchMode == 0) {
 		return dml_max(
-				DRAMClockChangeLatency + UrgentLatencyPixelDataOnly,
-				dml_max(SREnterPlusExitTime, UrgentLatencyPixelDataOnly));
+				DRAMClockChangeLatency + UrgentLatency,
+				dml_max(SREnterPlusExitTime, UrgentLatency));
 	} else if (PrefetchMode == 1) {
-		return dml_max(SREnterPlusExitTime, UrgentLatencyPixelDataOnly);
+		return dml_max(SREnterPlusExitTime, UrgentLatency);
 	} else {
-		return UrgentLatencyPixelDataOnly;
+		return UrgentLatency;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index b02dda8ce70f..2b4dcae4e432 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -177,10 +177,10 @@ static unsigned int CalculateVMAndRowBytes(
 		bool *PTEBufferSizeNotExceeded,
 		unsigned int *dpte_row_height,
 		unsigned int *meta_row_height);
-static double CalculateTWait(
+double CalculateTWait(
 		unsigned int PrefetchMode,
 		double DRAMClockChangeLatency,
-		double UrgentLatencyPixelDataOnly,
+		double UrgentLatency,
 		double SREnterPlusExitTime);
 static double CalculateRemoteSurfaceFlipDelay(
 		struct display_mode_lib *mode_lib,
@@ -2967,23 +2967,6 @@ static void dml20v2_DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
 	}
 }
 
-static double CalculateTWait(
-		unsigned int PrefetchMode,
-		double DRAMClockChangeLatency,
-		double UrgentLatencyPixelDataOnly,
-		double SREnterPlusExitTime)
-{
-	if (PrefetchMode == 0) {
-		return dml_max(
-				DRAMClockChangeLatency + UrgentLatencyPixelDataOnly,
-				dml_max(SREnterPlusExitTime, UrgentLatencyPixelDataOnly));
-	} else if (PrefetchMode == 1) {
-		return dml_max(SREnterPlusExitTime, UrgentLatencyPixelDataOnly);
-	} else {
-		return UrgentLatencyPixelDataOnly;
-	}
-}
-
 static double CalculateRemoteSurfaceFlipDelay(
 		struct display_mode_lib *mode_lib,
 		double VRatio,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index 6be14f55c78d..a3ef3638d979 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -205,7 +205,7 @@ static unsigned int CalculateVMAndRowBytes(
 		unsigned int *DPDE0BytesFrame,
 		unsigned int *MetaPTEBytesFrame);
 
-static double CalculateTWait(
+double CalculateTWait(
 		unsigned int PrefetchMode,
 		double DRAMClockChangeLatency,
 		double UrgentLatency,
@@ -2980,23 +2980,6 @@ static void DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
 	}
 }
 
-static double CalculateTWait(
-		unsigned int PrefetchMode,
-		double DRAMClockChangeLatency,
-		double UrgentLatency,
-		double SREnterPlusExitTime)
-{
-	if (PrefetchMode == 0) {
-		return dml_max(
-				DRAMClockChangeLatency + UrgentLatency,
-				dml_max(SREnterPlusExitTime, UrgentLatency));
-	} else if (PrefetchMode == 1) {
-		return dml_max(SREnterPlusExitTime, UrgentLatency);
-	} else {
-		return UrgentLatency;
-	}
-}
-
 static double CalculateRemoteSurfaceFlipDelay(
 		struct display_mode_lib *mode_lib,
 		double VRatio,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 229548733177..74f5d9742f59 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -216,7 +216,7 @@ static unsigned int CalculateVMAndRowBytes(
 		unsigned int *PTERequestSize,
 		unsigned int *DPDE0BytesFrame,
 		unsigned int *MetaPTEBytesFrame);
-static double CalculateTWait(
+double CalculateTWait(
 		unsigned int PrefetchMode,
 		double DRAMClockChangeLatency,
 		double UrgentLatency,
@@ -3191,22 +3191,6 @@ void dml30_CalculateBytePerPixelAnd256BBlockSizes(
 	}
 }
 
-static double CalculateTWait(
-		unsigned int PrefetchMode,
-		double DRAMClockChangeLatency,
-		double UrgentLatency,
-		double SREnterPlusExitTime)
-{
-	if (PrefetchMode == 0) {
-		return dml_max(DRAMClockChangeLatency + UrgentLatency,
-				dml_max(SREnterPlusExitTime, UrgentLatency));
-	} else if (PrefetchMode == 1) {
-		return dml_max(SREnterPlusExitTime, UrgentLatency);
-	} else {
-		return UrgentLatency;
-	}
-}
-
 double dml30_CalculateWriteBackDISPCLK(
 		enum source_format_class WritebackPixelFormat,
 		double PixelClock,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
index 58dc4c046cf4..4563342275f1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_mode_vba_31.c
@@ -230,7 +230,7 @@ static unsigned int CalculateVMAndRowBytes(
 		unsigned int *PTERequestSize,
 		int *DPDE0BytesFrame,
 		int *MetaPTEBytesFrame);
-static double CalculateTWait(unsigned int PrefetchMode, double DRAMClockChangeLatency, double UrgentLatency, double SREnterPlusExitTime);
+double CalculateTWait(unsigned int PrefetchMode, double DRAMClockChangeLatency, double UrgentLatency, double SREnterPlusExitTime);
 static void CalculateRowBandwidth(
 		bool GPUVMEnable,
 		enum source_format_class SourcePixelFormat,
@@ -3323,17 +3323,6 @@ static void DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
 			&dummysinglestring);
 }
 
-static double CalculateTWait(unsigned int PrefetchMode, double DRAMClockChangeLatency, double UrgentLatency, double SREnterPlusExitTime)
-{
-	if (PrefetchMode == 0) {
-		return dml_max(DRAMClockChangeLatency + UrgentLatency, dml_max(SREnterPlusExitTime, UrgentLatency));
-	} else if (PrefetchMode == 1) {
-		return dml_max(SREnterPlusExitTime, UrgentLatency);
-	} else {
-		return UrgentLatency;
-	}
-}
-
 double dml31_CalculateWriteBackDISPCLK(
 		enum source_format_class WritebackPixelFormat,
 		double PixelClock,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
index 7024412fe441..89a80eef42f4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
@@ -244,7 +244,7 @@ static unsigned int CalculateVMAndRowBytes(
 		unsigned int *PTERequestSize,
 		int *DPDE0BytesFrame,
 		int *MetaPTEBytesFrame);
-static double CalculateTWait(unsigned int PrefetchMode, double DRAMClockChangeLatency, double UrgentLatency, double SREnterPlusExitTime);
+double CalculateTWait(unsigned int PrefetchMode, double DRAMClockChangeLatency, double UrgentLatency, double SREnterPlusExitTime);
 static void CalculateRowBandwidth(
 		bool GPUVMEnable,
 		enum source_format_class SourcePixelFormat,
@@ -3547,17 +3547,6 @@ static bool CalculateBytePerPixelAnd256BBlockSizes(
 	return true;
 }
 
-static double CalculateTWait(unsigned int PrefetchMode, double DRAMClockChangeLatency, double UrgentLatency, double SREnterPlusExitTime)
-{
-	if (PrefetchMode == 0) {
-		return dml_max(DRAMClockChangeLatency + UrgentLatency, dml_max(SREnterPlusExitTime, UrgentLatency));
-	} else if (PrefetchMode == 1) {
-		return dml_max(SREnterPlusExitTime, UrgentLatency);
-	} else {
-		return UrgentLatency;
-	}
-}
-
 double dml314_CalculateWriteBackDISPCLK(
 		enum source_format_class WritebackPixelFormat,
 		double PixelClock,
-- 
2.27.0

