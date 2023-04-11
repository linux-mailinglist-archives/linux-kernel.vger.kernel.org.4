Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166896DE265
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjDKRXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjDKRW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:22:59 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DCBE55
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:22:57 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 60-20020a17090a09c200b0023fcc8ce113so11615762pjo.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681233777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=28t9ljw3dxSMctDXd2sUTJmBDzILsgHACRxjFVxLS2g=;
        b=WCYj8t8ny0LdlrIG9tCjxh22vn5C3Q1UkHnVNm8DV4PFWXeiab3ZWUu0JKZqDFS3hb
         dhJ7vg8LHyCJvizfoGzTjdkm1WIjegUYCj0yMkjNqwmi7W/gwjkGWG2QwlAFeeJc5tt5
         ZPwz1NPP3y7nsYx292pI1mDz3ETQpdKB0VLzEpDpMVjxOWmnOHAEmNCevVUpLO7/AJp/
         6+YoEk+Uq25jEk2mS1XNWdtdDgMjz3rasye7pLXjolWaJkRa3OGAgMGtLBQd55+H6/Bq
         HfekeQ01+kmoh16PO6oI6vhY96ATh1utiyIQWMwjsopk/PZ7OAUvVwSX+XpNftmABfc7
         Xqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681233777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28t9ljw3dxSMctDXd2sUTJmBDzILsgHACRxjFVxLS2g=;
        b=qxGBVJWmQRZ+wIsNTw+IJSHAFiPSEsXYMS+LJ9kveTPZOo1/IkfPZoSSoVdqSEJwhE
         H6nSzADosJ2L8lEutt/m9k1JhWmkar1ldr18CO1X1gbS7mKk5Gb/oUHoLD2fbXmH9ws5
         exTg1ipKqwHKoTelgF5Dxx9jauVgFssHWeqFLyxP56vpjC8o4LcmqRi+t3GxVnoMsDgw
         Nyn13/O0RoOImPKNcPnaQfNlxcFRyDFMfackR+byjIPQnbDQLMQPb7UK1EEJjIrGReOi
         R4aTIpquv62tFobZhbuxgyhvD2mJkQnMJXCj2lT7SGoALCpGC/q+whcVk5X7LvhF2s6H
         wGjw==
X-Gm-Message-State: AAQBX9f2ZEepa7gd2dFzF8OylsCDk7IqS+Sd6vGuv0f7PorVMIAvd0CW
        8vBCNw2YZGXkARQkKWDrkQTnQQ==
X-Google-Smtp-Source: AKy350a5XwVObtMkbzt9yXV+8X+TW6NImWGouirRf5xPMJ8qYuLtf9KoU1ulzFiARg3bdoF+HAZX7Q==
X-Received: by 2002:a17:90a:7e89:b0:240:ce2f:5fc1 with SMTP id j9-20020a17090a7e8900b00240ce2f5fc1mr18668803pjl.46.1681233777152;
        Tue, 11 Apr 2023 10:22:57 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:f795:eecb:467b:d183])
        by smtp.gmail.com with ESMTPSA id x14-20020a17090a1f8e00b0023b3179f0fcsm11412320pja.6.2023.04.11.10.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 10:22:56 -0700 (PDT)
Date:   Tue, 11 Apr 2023 11:22:53 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     andersson@kernel.org, linux-remoteproc@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: imx_dsp_rproc: Fix kernel test robot sparse
 warning
Message-ID: <20230411172253.GA38361@p14s>
References: <20230407161429.3973177-1-mathieu.poirier@linaro.org>
 <bbd3ad38-6a2d-e81f-0d72-7181674fafb5@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbd3ad38-6a2d-e81f-0d72-7181674fafb5@nxp.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 02:28:34AM +0300, Iuliana Prodan wrote:
> On 4/7/2023 7:14 PM, Mathieu Poirier wrote:
> > This patch fixes the kernel test robot warning reported here:
> > 
> > https://lore.kernel.org/bpf/642f916b.pPIKZ%2Fl%2F%2Fbw8tvIH%25lkp@intel.com/T/
> > 
> > Fixes: 408ec1ff0caa ("remoteproc: imx_dsp_rproc: Add custom memory copy implementation for i.MX DSP Cores")
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> Tested-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
>

Applied

> Thanks,
> Iulia
> 
> 
> > ---
> > 
> > Iuliana - please thest this on your side
> > 
> > ---
> >   drivers/remoteproc/imx_dsp_rproc.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
> > index 21759d9e5b7b..c805cb83cacc 100644
> > --- a/drivers/remoteproc/imx_dsp_rproc.c
> > +++ b/drivers/remoteproc/imx_dsp_rproc.c
> > @@ -750,12 +750,12 @@ static void imx_dsp_rproc_kick(struct rproc *rproc, int vqid)
> >    * The IRAM is part of the HiFi DSP.
> >    * According to hw specs only 32-bits writes are allowed.
> >    */
> > -static int imx_dsp_rproc_memcpy(void *dest, const void *src, size_t size)
> > +static int imx_dsp_rproc_memcpy(void *dst, const void *src, size_t size)
> >   {
> > +	void __iomem *dest = (void __iomem *)dst;
> >   	const u8 *src_byte = src;
> >   	const u32 *source = src;
> >   	u32 affected_mask;
> > -	u32 *dst = dest;
> >   	int i, q, r;
> >   	u32 tmp;
> > @@ -768,7 +768,7 @@ static int imx_dsp_rproc_memcpy(void *dest, const void *src, size_t size)
> >   	/* copy data in units of 32 bits at a time */
> >   	for (i = 0; i < q; i++)
> > -		writel(source[i], &dst[i]);
> > +		writel(source[i], dest + i * 4);
> >   	if (r) {
> >   		affected_mask = GENMASK(8 * r, 0);
> > @@ -799,8 +799,8 @@ static int imx_dsp_rproc_memcpy(void *dest, const void *src, size_t size)
> >    */
> >   static int imx_dsp_rproc_memset(void *addr, u8 value, size_t size)
> >   {
> > +	void __iomem *tmp_dst = (void __iomem *)addr;
> >   	u32 tmp_val = value;
> > -	u32 *tmp_dst = addr;
> >   	u32 affected_mask;
> >   	int q, r;
> >   	u32 tmp;
