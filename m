Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8B16167F2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiKBQNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbiKBQL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:11:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4A52B1B1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 09:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667405458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=818fkauCT2wdZz4+yrO04ax3xbhchL67Khz2gBKnDvo=;
        b=cpTfzeMF/jyFZiVa7xy+nMaE24YgZbQYdy4NDwu/hKSuEZTUA1w4eRTQlCYWLUzsS5FGkv
        Rfor/3NvfODt8rah0vGspM5P0ixc58OD5+pzZLV/XepqM0kWk8ss1WBJZ/4e37/ojHr79A
        d9M1cQm3yIXLi1p9xJWRdBD+nh2jlWY=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-44-xMXEu3mrPBCoa2-ZgDs0DA-1; Wed, 02 Nov 2022 12:10:57 -0400
X-MC-Unique: xMXEu3mrPBCoa2-ZgDs0DA-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-131f323c158so9139236fac.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 09:10:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=818fkauCT2wdZz4+yrO04ax3xbhchL67Khz2gBKnDvo=;
        b=qMGvgCDLoyArl9NJsRMTi9EB/GEeWjdC4MbrzEnEBswTCqlBjhw66s2BjoJCu39fj4
         XEFQWLEIvt31+GCR5HfxDtcaHb/EpHu8AFr98MBq8AKbcHBZz29VMhDpWKYNc2/d/xcG
         QwrA8FDxCLvVJ11Z395S1gTdE7Rs3yi0c0jNSel2GYszVJ9yM/sB/o9pgJuGj1xUDiSV
         aSgk7Z4tYF7FbrXphmSNejctJCZMEoZHSHrL05+HuKZ9778R7j+IP/354xZGHgCM8Hsk
         d2x1JXQhuFJwcyLh3tqoZGvywLzoeJBQxZBUylLkBYa57kU61nRy3oMG27U1vMAuXuiJ
         0b2Q==
X-Gm-Message-State: ACrzQf1FZWjhIfeqNK/7fqkeRPdtV0cs63Ea4kKmeATXUbE2+NHgaTsH
        divEtDk9g8uEWuGTe6CfshctkJFj4fA7HsXxudCuC+Sh381kgz0xJYH+19X48sLcWCOzZ4aoRRo
        ZKcplXC/bYdWm1S+nSJReS4tH
X-Received: by 2002:a05:6870:d107:b0:13c:b7de:ed24 with SMTP id e7-20020a056870d10700b0013cb7deed24mr13325206oac.41.1667405455670;
        Wed, 02 Nov 2022 09:10:55 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4FieKkr532FessZ6Ca/K73+gPVeRaDL1sIRNXwQUYUk+qc5sJ3R2bzyDCiDORWw+yibzS7Nw==
X-Received: by 2002:a05:6870:d107:b0:13c:b7de:ed24 with SMTP id e7-20020a056870d10700b0013cb7deed24mr13325186oac.41.1667405455472;
        Wed, 02 Nov 2022 09:10:55 -0700 (PDT)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::41])
        by smtp.gmail.com with ESMTPSA id bx25-20020a056830601900b0066c312b044dsm5207253otb.27.2022.11.02.09.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:10:55 -0700 (PDT)
Date:   Wed, 2 Nov 2022 11:10:52 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: qcom-spmi-adc-tm5: suppress probe-deferral
 error message
Message-ID: <20221102161052.eox4sxhvfzl6dhfn@halaney-x13s>
References: <20221102152630.696-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102152630.696-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 04:26:30PM +0100, Johan Hovold wrote:
> Drivers should not be logging errors on probe deferral. Switch to using
> dev_err_probe() to log failures when parsing the devicetree to avoid
> errors like:
> 
> 	qcom-spmi-adc-tm5 c440000.spmi:pmic@0:adc-tm@3400: get dt data failed: -517
> 
> when a channel is not yet available.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> index a3310bf061cb..c70615d2d771 100644
> --- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> @@ -1031,10 +1031,8 @@ static int adc_tm5_probe(struct platform_device *pdev)
>  		return irq;
>  
>  	ret = adc_tm5_get_dt_data(adc_tm, node);
> -	if (ret) {
> -		dev_err(dev, "get dt data failed: %d\n", ret);
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "get dt data failed\n");
>  
>  	ret = adc_tm->data->init(adc_tm);
>  	if (ret) {
> -- 
> 2.37.3
> 

