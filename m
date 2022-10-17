Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5216015A0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiJQRpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiJQRpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:45:19 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480E761715
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:45:17 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id a6-20020a17090abe0600b0020d7c0c6650so14981762pjs.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s6Wfy0RYVL3RN1cfoJ/HVQtYpR+YDnGcHz/3eX5V1/k=;
        b=JfzwFAfyinAh0vRLDe9xOnkD+DU5oRWkOSCGmAJkEKihnY2r3nj6gUkN/UXZxCLLNh
         K4lxmUp3bqzN9c3kNCoelbcDolLptdw0aGExFprpJVTyFSmDyBjwbWye8a73T4ACFAB/
         IHXtzTFzLbslj1FPe9V+sIgB5HZWHHKP44E+2s9LOuctEr6bIAR3Dp6tQyDRMrLKdJTQ
         rdNj0RbHkrgvSBxHb8Qsa4YQze2huOKWHqk/KzVftdwIv85h5dwPBuJwnipmQAmWKg2h
         EpHSQ1X7ClkKPb5/jYm/ZnSntxcohHBlTsjQ0+7vpHXPBQ8cnHZuHM3euZ01svAXAm6z
         zHqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6Wfy0RYVL3RN1cfoJ/HVQtYpR+YDnGcHz/3eX5V1/k=;
        b=3rXP/TfsKbIxIS/v7bPBAyAc2dSmMEiN4OdkAzfqglR9ZY5Fp8mF7bSEIeFojya6FQ
         Vk+L691cQL5eZ6mjkgvCtEFCYPmhTp483TUMLGtuE4OC78/PqH5h540uRhEmhyCe+5pK
         v6ZJ+yO0nNACNrxWt8Qgus8DP3vJilgB7VGw5wNtsFM7B6LoG07lTIs/n+GC0iXfagMO
         0r5PJSpYB2IDEWhImdVK0RZb6ZA16jUWQp19Q21zbIrkFt5y7u85i9NZkZN5jLm0jApu
         Dxxau9VcoqTpkVO9iMwrwv0lM03PorG8lCe1IZgjFLYCC7Wn0bopbYkpgLOu6QGeh+/t
         YL0Q==
X-Gm-Message-State: ACrzQf3L4i2N6InXPuzBUZEewXO4vA+z86/hvhYee/cqHBZTgRBUSZm0
        Sa23ZA+qFUO5TgZkmdEOgUk/Jg==
X-Google-Smtp-Source: AMsMyM68sJl2iYftd96ocIS3Mh2Eh9yE0P8YIDsl0O7//LXxkqmlsSGEYr4Sa7+OeSpXwPMzRmb3Mg==
X-Received: by 2002:a17:902:f312:b0:17d:79e9:1181 with SMTP id c18-20020a170902f31200b0017d79e91181mr13331930ple.173.1666028716560;
        Mon, 17 Oct 2022 10:45:16 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id w186-20020a6262c3000000b00561d79f1064sm7379582pfb.57.2022.10.17.10.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 10:45:15 -0700 (PDT)
Date:   Mon, 17 Oct 2022 11:45:14 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     andersson@kernel.org, arnaud.pouliquen@foss.st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com
Subject: Re: [PATCH v2] remoteproc: core: Auto select rproc-virtio device id
Message-ID: <20221017174514.GB121862@p14s>
References: <1665718851-22341-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1665718851-22341-1-git-send-email-shengjiu.wang@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey guys,

On Fri, Oct 14, 2022 at 11:40:51AM +0800, Shengjiu Wang wrote:
> With multiple remoteproc device, there will below error:
> 
> sysfs: cannot create duplicate filename '/bus/platform/devices/rproc-virtio.0'
> 
> The rvdev_data.index is duplicate, that cause issue, so
> need to use the PLATFORM_DEVID_AUTO instead. After fixing
> device name it becomes something like:
> /bus/platform/devices/rproc-virtio.2.auto
> 
> Fixes: 1d7b61c06dc3 ("remoteproc: virtio: Create platform device for the remoteproc_virtio")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
> Tested-by: Peng Fan <peng.fan@nxp.com>
> ---
> changes in v2:
> - update commit message
> 
>  drivers/remoteproc/remoteproc_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 8768cb64f560..03a26498e879 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -509,7 +509,7 @@ static int rproc_handle_vdev(struct rproc *rproc, void *ptr,
>  	rvdev_data.rsc_offset = offset;
>  	rvdev_data.rsc = rsc;
>  
> -	pdev = platform_device_register_data(dev, "rproc-virtio", rvdev_data.index, &rvdev_data,
> +	pdev = platform_device_register_data(dev, "rproc-virtio", PLATFORM_DEVID_AUTO, &rvdev_data,
>  					     sizeof(rvdev_data));

Just to clarify here...  This condition happens on systems where there is more
than one remote processor.  In those cases we get dupliation in sysfs because
virtio devices on each seperate instances of "rproc" are getting the same
rproc->nb_vdev number.

If that is the case, please add a comment in the code that clearly highlight
this condition.

Thanks,
Mathieu


>  	if (IS_ERR(pdev)) {
>  		dev_err(dev, "failed to create rproc-virtio device\n");
> -- 
> 2.34.1
> 
