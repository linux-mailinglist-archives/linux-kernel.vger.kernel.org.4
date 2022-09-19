Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0E75BD3A9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiISR1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiISR1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:27:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A846415FC9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663608451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7NsGFKg7Zzx4zTkQ2pzi2k9DjtPnYYJNY5qhCGrS9X4=;
        b=cMEs4y9RVQMf+Ng8LGJXxYcejxRUDPHBZPnEecv1dmBcZZtCsNO4jU/yd8ielWE3MPLvM5
        ra199OtHgvGhTek5bShSW6ZMko8pSBlzVV6Xo3qAxcY0SUrzft3H3UMUevpZRiywq6LF/h
        O5sDKgiiKc1w8sb4iWGe96Zx0X1szoM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-595-mNTVViCPMKSNPtJkDxmu0w-1; Mon, 19 Sep 2022 13:27:28 -0400
X-MC-Unique: mNTVViCPMKSNPtJkDxmu0w-1
Received: by mail-qv1-f69.google.com with SMTP id nm17-20020a0562143b1100b004a5a3002d87so184956qvb.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 10:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=7NsGFKg7Zzx4zTkQ2pzi2k9DjtPnYYJNY5qhCGrS9X4=;
        b=vM3cPA7R/4pSFfBSTtpr8SjhZrsfZv7vd9kDm+b+oOkVdOMwvY4fza9UShq3jtFiO0
         oNLiU8ciVWLwLfTAxsdD8x+dXGd0+RHJFE2xSw99j3cdfMch17/mUzIHbYVuupeR5ONm
         DjFgfBOeOH8Zhi21VjwqWodCwC1d/68jeLRIuPhTfdX3AYADPudk1pBA2z3ZmgbuIsWR
         c7/XPXwoJb7hqtK3LZdm0/Uq+EAsZ2ekDdQo8X+xo+oQGGuQ3GIrcCjddl8an3cwUXJZ
         0Hc0sVxdlyei/oLwj3atzKFStzMOr9TnRUH9VrlUMeJ+VZ/t37KHHPpStPZU5c35qZDg
         tfeg==
X-Gm-Message-State: ACrzQf2W3LDRgc05enzi/bZlApfRKT1KgRSo75nVtR48NhONlzIWbo/N
        KRVN0/GQG++eMFG/7MDGPUuUFcovwZAffpEUR9xkcV+VpTTIa8TI0V3oqkjH6ZnrsXKlesblG4d
        Wj8HfShE0R6lluoyfJrtr7hJ2
X-Received: by 2002:ac8:7d55:0:b0:35c:d884:449b with SMTP id h21-20020ac87d55000000b0035cd884449bmr11878618qtb.446.1663608447744;
        Mon, 19 Sep 2022 10:27:27 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4i0rlAyGMYCTEgKC4McJT8796QdIatMpbatt/bB5p0sKvwg1QXcySq88dwTcJrMAFNtAKCAQ==
X-Received: by 2002:ac8:7d55:0:b0:35c:d884:449b with SMTP id h21-20020ac87d55000000b0035cd884449bmr11878594qtb.446.1663608447532;
        Mon, 19 Sep 2022 10:27:27 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w14-20020ac84d0e000000b003436103df40sm10674862qtv.8.2022.09.19.10.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 10:27:27 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, Nevenko.Stupar@amd.com, Pavle.Kotarac@amd.com,
        aric.cyr@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/display: remove redundant CalculateRemoteSurfaceFlipDelay's
Date:   Mon, 19 Sep 2022 13:27:20 -0400
Message-Id: <20220919172720.3496405-1-trix@redhat.com>
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

There are several copies of CalculateRemoteSurfaceFlipDelay.
Reduce to one instance.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 .../dc/dml/dcn20/display_mode_vba_20.c        |  4 +-
 .../dc/dml/dcn20/display_mode_vba_20v2.c      | 40 +------------------
 .../dc/dml/dcn21/display_mode_vba_21.c        | 40 +------------------
 3 files changed, 4 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
index 4ca080950924..8e5d58336bc5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
@@ -158,7 +158,7 @@ double CalculateTWait(
 		double DRAMClockChangeLatency,
 		double UrgentLatency,
 		double SREnterPlusExitTime);
-static double CalculateRemoteSurfaceFlipDelay(
+double CalculateRemoteSurfaceFlipDelay(
 		struct display_mode_lib *mode_lib,
 		double VRatio,
 		double SwathWidth,
@@ -2909,7 +2909,7 @@ double CalculateTWait(
 	}
 }
 
-static double CalculateRemoteSurfaceFlipDelay(
+double CalculateRemoteSurfaceFlipDelay(
 		struct display_mode_lib *mode_lib,
 		double VRatio,
 		double SwathWidth,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
index 2b4dcae4e432..e9ebc81adc71 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
@@ -182,7 +182,7 @@ double CalculateTWait(
 		double DRAMClockChangeLatency,
 		double UrgentLatency,
 		double SREnterPlusExitTime);
-static double CalculateRemoteSurfaceFlipDelay(
+double CalculateRemoteSurfaceFlipDelay(
 		struct display_mode_lib *mode_lib,
 		double VRatio,
 		double SwathWidth,
@@ -2967,44 +2967,6 @@ static void dml20v2_DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
 	}
 }
 
-static double CalculateRemoteSurfaceFlipDelay(
-		struct display_mode_lib *mode_lib,
-		double VRatio,
-		double SwathWidth,
-		double Bpp,
-		double LineTime,
-		double XFCTSlvVupdateOffset,
-		double XFCTSlvVupdateWidth,
-		double XFCTSlvVreadyOffset,
-		double XFCXBUFLatencyTolerance,
-		double XFCFillBWOverhead,
-		double XFCSlvChunkSize,
-		double XFCBusTransportTime,
-		double TCalc,
-		double TWait,
-		double *SrcActiveDrainRate,
-		double *TInitXFill,
-		double *TslvChk)
-{
-	double TSlvSetup, AvgfillRate, result;
-
-	*SrcActiveDrainRate = VRatio * SwathWidth * Bpp / LineTime;
-	TSlvSetup = XFCTSlvVupdateOffset + XFCTSlvVupdateWidth + XFCTSlvVreadyOffset;
-	*TInitXFill = XFCXBUFLatencyTolerance / (1 + XFCFillBWOverhead / 100);
-	AvgfillRate = *SrcActiveDrainRate * (1 + XFCFillBWOverhead / 100);
-	*TslvChk = XFCSlvChunkSize / AvgfillRate;
-	dml_print(
-			"DML::CalculateRemoteSurfaceFlipDelay: SrcActiveDrainRate: %f\n",
-			*SrcActiveDrainRate);
-	dml_print("DML::CalculateRemoteSurfaceFlipDelay: TSlvSetup: %f\n", TSlvSetup);
-	dml_print("DML::CalculateRemoteSurfaceFlipDelay: TInitXFill: %f\n", *TInitXFill);
-	dml_print("DML::CalculateRemoteSurfaceFlipDelay: AvgfillRate: %f\n", AvgfillRate);
-	dml_print("DML::CalculateRemoteSurfaceFlipDelay: TslvChk: %f\n", *TslvChk);
-	result = 2 * XFCBusTransportTime + TSlvSetup + TCalc + TWait + *TslvChk + *TInitXFill; // TODO: This doesn't seem to match programming guide
-	dml_print("DML::CalculateRemoteSurfaceFlipDelay: RemoteSurfaceFlipDelay: %f\n", result);
-	return result;
-}
-
 static void CalculateActiveRowBandwidth(
 		bool GPUVMEnable,
 		enum source_format_class SourcePixelFormat,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index a3ef3638d979..d94aaf899f9b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -210,7 +210,7 @@ double CalculateTWait(
 		double DRAMClockChangeLatency,
 		double UrgentLatency,
 		double SREnterPlusExitTime);
-static double CalculateRemoteSurfaceFlipDelay(
+double CalculateRemoteSurfaceFlipDelay(
 		struct display_mode_lib *mode_lib,
 		double VRatio,
 		double SwathWidth,
@@ -2980,44 +2980,6 @@ static void DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
 	}
 }
 
-static double CalculateRemoteSurfaceFlipDelay(
-		struct display_mode_lib *mode_lib,
-		double VRatio,
-		double SwathWidth,
-		double Bpp,
-		double LineTime,
-		double XFCTSlvVupdateOffset,
-		double XFCTSlvVupdateWidth,
-		double XFCTSlvVreadyOffset,
-		double XFCXBUFLatencyTolerance,
-		double XFCFillBWOverhead,
-		double XFCSlvChunkSize,
-		double XFCBusTransportTime,
-		double TCalc,
-		double TWait,
-		double *SrcActiveDrainRate,
-		double *TInitXFill,
-		double *TslvChk)
-{
-	double TSlvSetup, AvgfillRate, result;
-
-	*SrcActiveDrainRate = VRatio * SwathWidth * Bpp / LineTime;
-	TSlvSetup = XFCTSlvVupdateOffset + XFCTSlvVupdateWidth + XFCTSlvVreadyOffset;
-	*TInitXFill = XFCXBUFLatencyTolerance / (1 + XFCFillBWOverhead / 100);
-	AvgfillRate = *SrcActiveDrainRate * (1 + XFCFillBWOverhead / 100);
-	*TslvChk = XFCSlvChunkSize / AvgfillRate;
-	dml_print(
-			"DML::CalculateRemoteSurfaceFlipDelay: SrcActiveDrainRate: %f\n",
-			*SrcActiveDrainRate);
-	dml_print("DML::CalculateRemoteSurfaceFlipDelay: TSlvSetup: %f\n", TSlvSetup);
-	dml_print("DML::CalculateRemoteSurfaceFlipDelay: TInitXFill: %f\n", *TInitXFill);
-	dml_print("DML::CalculateRemoteSurfaceFlipDelay: AvgfillRate: %f\n", AvgfillRate);
-	dml_print("DML::CalculateRemoteSurfaceFlipDelay: TslvChk: %f\n", *TslvChk);
-	result = 2 * XFCBusTransportTime + TSlvSetup + TCalc + TWait + *TslvChk + *TInitXFill; // TODO: This doesn't seem to match programming guide
-	dml_print("DML::CalculateRemoteSurfaceFlipDelay: RemoteSurfaceFlipDelay: %f\n", result);
-	return result;
-}
-
 static void CalculateActiveRowBandwidth(
 		bool GPUVMEnable,
 		enum source_format_class SourcePixelFormat,
-- 
2.27.0

