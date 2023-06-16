Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DD17334A5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344935AbjFPPYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjFPPYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:24:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAF72702
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686929001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lA4WetjOkBjPwCImnk3E1z+blRFlganosEwAAK5HqlQ=;
        b=dB1l6AhXDFPUlEJq2xEfid5BbEArSxOaRSHzQ1u75kzebIfKY4rNDHq0fJIgldwamQViqV
        qTMhNa0qBi8Bz1xHPvOHjSK4zz+EMDlGYgH7kkTt/n2+HjsXT3HTXFKNskQPD3+zRp4YDX
        Hc5Qoe/XBKQi4zoMcU7DJhz5VwCyyNE=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-GhzLCggcP_iEWk0-aazxDg-1; Fri, 16 Jun 2023 11:23:19 -0400
X-MC-Unique: GhzLCggcP_iEWk0-aazxDg-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-5707177ff8aso3997287b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 08:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686928999; x=1689520999;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lA4WetjOkBjPwCImnk3E1z+blRFlganosEwAAK5HqlQ=;
        b=jvYJ2Y/m/8ZNieirUwTy5DLrEpTjnTdA07DOM55Ubgb0QOXVZ+XeDqKT9qpRCWjgzF
         SQEW95O6anXgrT13b0xfs3lYyDrbk+zwO/JdR36hCAERWobX3MnbzsZkybRiDjntWnlD
         bsHORPxkYn200f5iSbUzdbzZm3xuosmO28+pOqYRIwqO91j7dK5kh1Zx8hT1NUf47w+4
         hivZ0ES34RtDOdHIcHAO2OeXG4zSpTGHiNQosLkQB83qN1dd/xe4aLcjvWTNAaxuj6SK
         nvfgk6IimJJT41tC174C4gNFx1qB2iFzODktfK8PHu1w9ugHUMmaDyOAb9KZ+fPVPxPd
         s7Rw==
X-Gm-Message-State: AC+VfDzWK4SttHzyCcDVSkUylIFhWTWDIJZ4i0dqJYUmTas/R4u//D0f
        emtkBVmkfoUEg1d+q8MrGCRjKHOvOL0EHxOQFoY2lx73kkmYU/41Ok5q2+ATcq9bdbl2YXZCj4m
        ZJbIqzPSuEZHcUiryKUzcmLgs
X-Received: by 2002:a0d:dc01:0:b0:55a:18e2:cdf9 with SMTP id f1-20020a0ddc01000000b0055a18e2cdf9mr2220627ywe.49.1686928999375;
        Fri, 16 Jun 2023 08:23:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7NOTCKCTI0yyuQ0+PMG4jd1bn9GV0P6GZZ962o5J8zX2cgNyFC6rRy/x9Cnu6fAalYWPOdIw==
X-Received: by 2002:a0d:dc01:0:b0:55a:18e2:cdf9 with SMTP id f1-20020a0ddc01000000b0055a18e2cdf9mr2220605ywe.49.1686928999136;
        Fri, 16 Jun 2023 08:23:19 -0700 (PDT)
Received: from brian-x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id t66-20020a0dd145000000b0056d2dd6c5bcsm3164519ywd.89.2023.06.16.08.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 08:23:18 -0700 (PDT)
Date:   Fri, 16 Jun 2023 11:23:16 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     robdclark@gmail.com, quic_abhinavk@quicinc.com,
        dmitry.baryshkov@linaro.org, sean@poorly.run, airlied@gmail.com,
        daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org,
        konrad.dybcio@linaro.org, quic_akhilpo@quicinc.com,
        ribalda@chromium.org, joel@joelfernandes.org
Subject: Re: [PATCH] drm/msm/adreno: Update MODULE_FIRMWARE macros
Message-ID: <ZIx+ZHXTRGe3j4sh@brian-x1>
References: <20230616122815.1037425-1-juerg.haefliger@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616122815.1037425-1-juerg.haefliger@canonical.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juerg,

On Fri, Jun 16, 2023 at 02:28:15PM +0200, Juerg Haefliger wrote:
> Add missing MODULE_FIRMWARE macros and remove some for firmwares that
> the driver no longer references.
> 
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> ---
>  drivers/gpu/drm/msm/adreno/adreno_device.c | 23 ++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index 8cff86e9d35c..9f70d7c1a72a 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -364,17 +364,32 @@ MODULE_FIRMWARE("qcom/a330_pm4.fw");
>  MODULE_FIRMWARE("qcom/a330_pfp.fw");
>  MODULE_FIRMWARE("qcom/a420_pm4.fw");
>  MODULE_FIRMWARE("qcom/a420_pfp.fw");
> +MODULE_FIRMWARE("qcom/a506_zap.mdt");
> +MODULE_FIRMWARE("qcom/a508_zap.mdt");
> +MODULE_FIRMWARE("qcom/a512_zap.mdt");
>  MODULE_FIRMWARE("qcom/a530_pm4.fw");
>  MODULE_FIRMWARE("qcom/a530_pfp.fw");
>  MODULE_FIRMWARE("qcom/a530v3_gpmu.fw2");
>  MODULE_FIRMWARE("qcom/a530_zap.mdt");
> -MODULE_FIRMWARE("qcom/a530_zap.b00");
> -MODULE_FIRMWARE("qcom/a530_zap.b01");
> -MODULE_FIRMWARE("qcom/a530_zap.b02");
> +MODULE_FIRMWARE("qcom/a540_gpmu.fw2");
> +MODULE_FIRMWARE("qcom/a540_zap.mdt");
> +MODULE_FIRMWARE("qcom/a615_zap.mdt");
>  MODULE_FIRMWARE("qcom/a619_gmu.bin");
>  MODULE_FIRMWARE("qcom/a630_sqe.fw");
>  MODULE_FIRMWARE("qcom/a630_gmu.bin");
> -MODULE_FIRMWARE("qcom/a630_zap.mbn");
> +MODULE_FIRMWARE("qcom/a630_zap.mdt");
> +MODULE_FIRMWARE("qcom/a640_gmu.bin");
> +MODULE_FIRMWARE("qcom/a640_zap.mdt");
> +MODULE_FIRMWARE("qcom/a650_gmu.bin");
> +MODULE_FIRMWARE("qcom/a650_sqe.fw");
> +MODULE_FIRMWARE("qcom/a650_zap.mdt");
> +MODULE_FIRMWARE("qcom/a660_gmu.bin");
> +MODULE_FIRMWARE("qcom/a660_sqe.fw");
> +MODULE_FIRMWARE("qcom/a660_zap.mdt");
> +MODULE_FIRMWARE("qcom/leia_pfp_470.fw");
> +MODULE_FIRMWARE("qcom/leia_pm4_470.fw");
> +MODULE_FIRMWARE("qcom/yamato_pfp.fw");
> +MODULE_FIRMWARE("qcom/yamato_pm4.fw");

You should rebase this on top of the latest -next since the a690 needs
to be added as well.

Brian

