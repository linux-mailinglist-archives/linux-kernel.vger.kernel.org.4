Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3553A5BD7F1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 01:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiISXM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 19:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiISXMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 19:12:40 -0400
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2254B48B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 16:12:20 -0700 (PDT)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4MWgS30pcdz9sxL;
        Mon, 19 Sep 2022 23:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1663629139; bh=DkQmle7xAKgqaESS7YDG2RtCoM4nsxWLLzIMz/A+uxY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EZolbE5VRNlZbaerDP24iNRkHSP4jyVQn5PQNLlgSFBB6KypAch1berozoV2/14bM
         oiQ7TQj9a8ELXbMs4cxY2fVvv+xojPZ+xeQWm7FA3kAuzH1WUCQto4zaR/uvplDFrp
         wP3ZRzyRAXxgKd0wCwC3nbZBrnlBJ0pChwyy1peU=
X-Riseup-User-ID: 606E763E2668B4D71697192CEAF374585F765B2ECD3DCA0E71DB8D89095DAB43
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4MWgRy2wXnz1yPb;
        Mon, 19 Sep 2022 23:12:14 +0000 (UTC)
Message-ID: <cd90693c-7324-5a74-9a5b-794032b9717f@riseup.net>
Date:   Mon, 19 Sep 2022 20:12:12 -0300
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amd/display: remove redundant
 CalculateRemoteSurfaceFlipDelay's
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, harry.wentland@amd.com,
        sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        Nevenko.Stupar@amd.com, Pavle.Kotarac@amd.com, aric.cyr@amd.com
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220919172720.3496405-1-trix@redhat.com>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <20220919172720.3496405-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom

On 9/19/22 14:27, Tom Rix wrote:
> There are several copies of CalculateRemoteSurfaceFlipDelay.
> Reduce to one instance.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Maíra Canal <mairacanal@riseup.net>

Just a minor comment below.

> ---
>  .../dc/dml/dcn20/display_mode_vba_20.c        |  4 +-
>  .../dc/dml/dcn20/display_mode_vba_20v2.c      | 40 +------------------
>  .../dc/dml/dcn21/display_mode_vba_21.c        | 40 +------------------
>  3 files changed, 4 insertions(+), 80 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
> index 4ca080950924..8e5d58336bc5 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
> @@ -158,7 +158,7 @@ double CalculateTWait(
>  		double DRAMClockChangeLatency,
>  		double UrgentLatency,
>  		double SREnterPlusExitTime);
> -static double CalculateRemoteSurfaceFlipDelay(
> +double CalculateRemoteSurfaceFlipDelay(
>  		struct display_mode_lib *mode_lib,
>  		double VRatio,
>  		double SwathWidth,
> @@ -2909,7 +2909,7 @@ double CalculateTWait(
>  	}
>  }
>  
> -static double CalculateRemoteSurfaceFlipDelay(
> +double CalculateRemoteSurfaceFlipDelay(

I guess it would be more clear if this function was placed on the
display_mode_vba20.h and named dml20_CalculateRemoteSurfaceFlipDelay.
Then, it would be clearer that this function is shared over the DCN20s.

Best Regards,
- Maíra Canal

>  		struct display_mode_lib *mode_lib,
>  		double VRatio,
>  		double SwathWidth,
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
> index 2b4dcae4e432..e9ebc81adc71 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
> @@ -182,7 +182,7 @@ double CalculateTWait(
>  		double DRAMClockChangeLatency,
>  		double UrgentLatency,
>  		double SREnterPlusExitTime);
> -static double CalculateRemoteSurfaceFlipDelay(
> +double CalculateRemoteSurfaceFlipDelay(
>  		struct display_mode_lib *mode_lib,
>  		double VRatio,
>  		double SwathWidth,
> @@ -2967,44 +2967,6 @@ static void dml20v2_DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
>  	}
>  }
>  
> -static double CalculateRemoteSurfaceFlipDelay(
> -		struct display_mode_lib *mode_lib,
> -		double VRatio,
> -		double SwathWidth,
> -		double Bpp,
> -		double LineTime,
> -		double XFCTSlvVupdateOffset,
> -		double XFCTSlvVupdateWidth,
> -		double XFCTSlvVreadyOffset,
> -		double XFCXBUFLatencyTolerance,
> -		double XFCFillBWOverhead,
> -		double XFCSlvChunkSize,
> -		double XFCBusTransportTime,
> -		double TCalc,
> -		double TWait,
> -		double *SrcActiveDrainRate,
> -		double *TInitXFill,
> -		double *TslvChk)
> -{
> -	double TSlvSetup, AvgfillRate, result;
> -
> -	*SrcActiveDrainRate = VRatio * SwathWidth * Bpp / LineTime;
> -	TSlvSetup = XFCTSlvVupdateOffset + XFCTSlvVupdateWidth + XFCTSlvVreadyOffset;
> -	*TInitXFill = XFCXBUFLatencyTolerance / (1 + XFCFillBWOverhead / 100);
> -	AvgfillRate = *SrcActiveDrainRate * (1 + XFCFillBWOverhead / 100);
> -	*TslvChk = XFCSlvChunkSize / AvgfillRate;
> -	dml_print(
> -			"DML::CalculateRemoteSurfaceFlipDelay: SrcActiveDrainRate: %f\n",
> -			*SrcActiveDrainRate);
> -	dml_print("DML::CalculateRemoteSurfaceFlipDelay: TSlvSetup: %f\n", TSlvSetup);
> -	dml_print("DML::CalculateRemoteSurfaceFlipDelay: TInitXFill: %f\n", *TInitXFill);
> -	dml_print("DML::CalculateRemoteSurfaceFlipDelay: AvgfillRate: %f\n", AvgfillRate);
> -	dml_print("DML::CalculateRemoteSurfaceFlipDelay: TslvChk: %f\n", *TslvChk);
> -	result = 2 * XFCBusTransportTime + TSlvSetup + TCalc + TWait + *TslvChk + *TInitXFill; // TODO: This doesn't seem to match programming guide
> -	dml_print("DML::CalculateRemoteSurfaceFlipDelay: RemoteSurfaceFlipDelay: %f\n", result);
> -	return result;
> -}
> -
>  static void CalculateActiveRowBandwidth(
>  		bool GPUVMEnable,
>  		enum source_format_class SourcePixelFormat,
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
> index a3ef3638d979..d94aaf899f9b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
> @@ -210,7 +210,7 @@ double CalculateTWait(
>  		double DRAMClockChangeLatency,
>  		double UrgentLatency,
>  		double SREnterPlusExitTime);
> -static double CalculateRemoteSurfaceFlipDelay(
> +double CalculateRemoteSurfaceFlipDelay(
>  		struct display_mode_lib *mode_lib,
>  		double VRatio,
>  		double SwathWidth,
> @@ -2980,44 +2980,6 @@ static void DisplayPipeConfiguration(struct display_mode_lib *mode_lib)
>  	}
>  }
>  
> -static double CalculateRemoteSurfaceFlipDelay(
> -		struct display_mode_lib *mode_lib,
> -		double VRatio,
> -		double SwathWidth,
> -		double Bpp,
> -		double LineTime,
> -		double XFCTSlvVupdateOffset,
> -		double XFCTSlvVupdateWidth,
> -		double XFCTSlvVreadyOffset,
> -		double XFCXBUFLatencyTolerance,
> -		double XFCFillBWOverhead,
> -		double XFCSlvChunkSize,
> -		double XFCBusTransportTime,
> -		double TCalc,
> -		double TWait,
> -		double *SrcActiveDrainRate,
> -		double *TInitXFill,
> -		double *TslvChk)
> -{
> -	double TSlvSetup, AvgfillRate, result;
> -
> -	*SrcActiveDrainRate = VRatio * SwathWidth * Bpp / LineTime;
> -	TSlvSetup = XFCTSlvVupdateOffset + XFCTSlvVupdateWidth + XFCTSlvVreadyOffset;
> -	*TInitXFill = XFCXBUFLatencyTolerance / (1 + XFCFillBWOverhead / 100);
> -	AvgfillRate = *SrcActiveDrainRate * (1 + XFCFillBWOverhead / 100);
> -	*TslvChk = XFCSlvChunkSize / AvgfillRate;
> -	dml_print(
> -			"DML::CalculateRemoteSurfaceFlipDelay: SrcActiveDrainRate: %f\n",
> -			*SrcActiveDrainRate);
> -	dml_print("DML::CalculateRemoteSurfaceFlipDelay: TSlvSetup: %f\n", TSlvSetup);
> -	dml_print("DML::CalculateRemoteSurfaceFlipDelay: TInitXFill: %f\n", *TInitXFill);
> -	dml_print("DML::CalculateRemoteSurfaceFlipDelay: AvgfillRate: %f\n", AvgfillRate);
> -	dml_print("DML::CalculateRemoteSurfaceFlipDelay: TslvChk: %f\n", *TslvChk);
> -	result = 2 * XFCBusTransportTime + TSlvSetup + TCalc + TWait + *TslvChk + *TInitXFill; // TODO: This doesn't seem to match programming guide
> -	dml_print("DML::CalculateRemoteSurfaceFlipDelay: RemoteSurfaceFlipDelay: %f\n", result);
> -	return result;
> -}
> -
>  static void CalculateActiveRowBandwidth(
>  		bool GPUVMEnable,
>  		enum source_format_class SourcePixelFormat,
