Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF58966CA42
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 18:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbjAPRAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 12:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbjAPRAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 12:00:22 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46A459E45
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 08:43:05 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id i65so17900408pfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 08:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ikxZNlHUgNrbKf+8U/yVt2M8Gk6i+Q3n7f7a9saNKsI=;
        b=Rtmn/zdGuLDgMj9Slnnpf/54DTVzbMzb9eHnyHiw5BIn7frY+F06y/ZUr7E2DEiGju
         0OLsAEXiAIesVl3aafeOMfq1wvVH5CIgDcXikCoKMenFqkwvcpsnnHIbJlZc2Ng5s6JF
         68+3y6ajiz5CKq+RXJ6oQW7/Yqq6cnXskjOg60jZmKhqcc6FrKjfu3M/jw2yT06dr4Ix
         lKPmxGQnowZBWOFQ3HXiTsLMmZdQcMLExfpj905OpC9K/cnV5MOI3zELibeReHU4OepM
         ZRwUw//CFbaOWL/A68cWT7cbUcuHMztzkjRDfluApD9d2CuSG4LMouUwUkPXwOynzJ6/
         tWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikxZNlHUgNrbKf+8U/yVt2M8Gk6i+Q3n7f7a9saNKsI=;
        b=TmY+W/1aaDKKPyNKnMA2EWDO3WKRddCptMvccaTzSzW0kbUlg7XlTFAM8LaxS5jRYo
         oD2RzSlbHwJU9jXK+DcGNGdWBgrh7hH2nNJB5s4ggkSLuNu7mBxumWYdo7HeL27ATnSP
         1QSKnoNA3iZivT6JJjZzYCz+uRaCoVZ3IOF/3vQQonF0k872pcb3FMngbxijsMZAMG4N
         YwXovYcZgoFD6yfDCGa6rEC0nGdNHccsBNnEo6nh3PXZrJrBqOOWN4WfK/6KLOvZcleQ
         4Wwph4H7HwzeIxIHNTJTlrxgcid8spObgEey6V1lA1GQTV2177xhihca4+IGI+KBvper
         n/sw==
X-Gm-Message-State: AFqh2kpcjNDTzApcW2ac1+L31PgxD1KaiI0+j8PU1KeMP+sFJa5NMJFw
        6xtekv6DkuZGKrbgurNpjV70hw==
X-Google-Smtp-Source: AMrXdXsGM+JKHBOueEKiRd1ruDWOukTMmYx3k3dePs3jQNUQPeyMRIKpRFmIUfTREkNd6WyzHXbCbg==
X-Received: by 2002:a05:6a00:179a:b0:58b:bc3a:622a with SMTP id s26-20020a056a00179a00b0058bbc3a622amr16498632pfg.21.1673887385170;
        Mon, 16 Jan 2023 08:43:05 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:32ab:eb7f:cea:1014])
        by smtp.gmail.com with ESMTPSA id w124-20020a626282000000b005769b23260fsm18932094pfb.18.2023.01.16.08.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 08:43:04 -0800 (PST)
Date:   Mon, 16 Jan 2023 09:43:01 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Devarsh Thakkar <devarsht@ti.com>
Cc:     andersson@kernel.org, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de, linux-remoteproc@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s-anna@ti.com, hnagalla@ti.com,
        praneeth@ti.com, nm@ti.com, vigneshr@ti.com, a-bhatia1@ti.com,
        j-luthra@ti.com
Subject: Re: [PATCH v6 1/3] remoteproc: k3-r5: Simplify single core config set
Message-ID: <20230116164301.GA3239767@p14s>
References: <20230116151906.549384-1-devarsht@ti.com>
 <20230116151906.549384-2-devarsht@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116151906.549384-2-devarsht@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 08:49:04PM +0530, Devarsh Thakkar wrote:
> The config PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE
> is set only when cluster mode is set to
> CLUSTER_MODE_SINGLECPU and cluster mode
> is already configured before setting this config.
> 
> So directly check for cluster mode instead of checking
> soc_data->single_cpu_mode first and then checking
> cluster mode.
> 
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
> V6: No change
> ---
>  drivers/remoteproc/ti_k3_r5_remoteproc.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> index 0481926c6975..036c9dc217f3 100644
> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> @@ -875,15 +875,14 @@ static int k3_r5_rproc_configure(struct k3_r5_rproc *kproc)
>  	boot_vec = 0x0;
>  	if (core == core0) {
>  		clr_cfg = PROC_BOOT_CFG_FLAG_R5_TEINIT;
> -		if (cluster->soc_data->single_cpu_mode) {
> -			/*
> -			 * Single-CPU configuration bit can only be configured
> -			 * on Core0 and system firmware will NACK any requests
> -			 * with the bit configured, so program it only on
> -			 * permitted cores
> -			 */
> -			if (cluster->mode == CLUSTER_MODE_SINGLECPU)
> -				set_cfg = PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE;
> +		/*
> +		 * Single-CPU configuration bit can only be configured
> +		 * on Core0 and system firmware will NACK any requests
> +		 * with the bit configured, so program it only on
> +		 * permitted cores
> +		 */
> +		if (cluster->mode == CLUSTER_MODE_SINGLECPU) {
> +			set_cfg = PROC_BOOT_CFG_FLAG_R5_SINGLE_CORE;

This is exactly the kind of buggy situation I want to avoid by asking to use
soc_data->single_cpu_mode only in probe().

>  		} else {
>  			/*
>  			 * LockStep configuration bit is Read-only on Split-mode
> -- 
> 2.34.1
> 
