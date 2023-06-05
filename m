Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5F8722D9F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbjFER0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 13:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjFER0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:26:40 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EC799
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 10:26:39 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b01d912a76so23528485ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 10:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685985998; x=1688577998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oZqfyldacC0XDQdlgcybeOtmpOKByOPh6WjeVTF62fI=;
        b=zHj/glthhqgShaVchA3kSlzmwRY1tu52DszjiLxHcQu4qoc/Guv3EPCzIvWg2KPeNb
         rCXdG49EbGfe+X72cuW9RHxS3QRqLfxGcCZq8RYA2EYEVatWZp3BRIBqZQDGn9CxC0SJ
         1HgYv876+yPQzJGFGojPFisVcd481SL8Lt3Zma1YkYooSEa4Q5VISP0Qt6L3pv8Eg73m
         Ps1PFvKHxIWN+lU+k2XX0cWIhrZomTguaZo76gC/R5JJF+K5do82HWBsPc3r22qXMsv5
         zZAPXxY60v8/pqBiIyMqGSWS12DaYmG0Q3LNmofbCsfK+8IWu+Un/XFnBO0bcm6SaQ6/
         bKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685985998; x=1688577998;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oZqfyldacC0XDQdlgcybeOtmpOKByOPh6WjeVTF62fI=;
        b=U+5RWPJzv2SEMjt/MyPoKjLT5tWjao8KBQQPecZXCIo3S+43Xk1uVaDkyjqZ6ndKzl
         IyAy0FfjRx3tqePEqxyXUS6Ohhycy3CST8sLdBmpzVRyF6KEMOVzma4txh0wUwf6GsV3
         pqwDK2wbEPyoKWuAFu2/MsXjo28fP9vK/xrDjZw/eV4lKjswB/zMIfBB3YJAruoIIQDa
         GwWSA8DtMmXv0QDSqOIAt5Hv8tPej0T3NGMrKvjDzVzFauh7OetT1MYJsvGWNG0E2bKz
         p3XDpaR2HcRnV9UDlMJxBVhNl/gAEZ4qiOYxk7gTjD3n7CNWlH4hktWQAQWTefYcq1mr
         r/7A==
X-Gm-Message-State: AC+VfDyghJDMEjnLWmetcYH67BpRhOSPys4XnKgrjyWn+ksds7tcPXln
        l1xQtHw3pKE2Jgn4DjBb1V/9RA==
X-Google-Smtp-Source: ACHHUZ5JvrGlGppWeBFVmmK+Ax40IK7f9ZR/h7+HCqrLeKIfBaX7AWDP6dUJVCsCnHCuJREMmCBrMQ==
X-Received: by 2002:a17:902:b183:b0:1b2:1a4f:5825 with SMTP id s3-20020a170902b18300b001b21a4f5825mr1249848plr.19.1685985998519;
        Mon, 05 Jun 2023 10:26:38 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:e5f9:abc2:7e8d:5257])
        by smtp.gmail.com with ESMTPSA id 11-20020a170902c20b00b001b061dcdb6bsm6872663pll.28.2023.06.05.10.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 10:26:38 -0700 (PDT)
Date:   Mon, 5 Jun 2023 11:26:35 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     Bjorn Andersson <andersson@kernel.org>, rogerq@kernel.org,
        vigneshr@ti.org, nm@ti.com, srk@ti.com,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] remoteproc: pru: add support for configuring GPMUX based
 on client setup
Message-ID: <ZH4aywQoA9gy2OWU@p14s>
References: <20230601105904.3204260-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601105904.3204260-1-danishanwar@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi MD,

On Thu, Jun 01, 2023 at 04:29:04PM +0530, MD Danish Anwar wrote:
> From: Tero Kristo <t-kristo@ti.com>
> 
> Client device node property ti,pruss-gp-mux-sel can now be used to
> configure the GPMUX config value for PRU.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  drivers/remoteproc/pru_rproc.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
> index 2874c8d324f7..29d3a5a930c1 100644
> --- a/drivers/remoteproc/pru_rproc.c
> +++ b/drivers/remoteproc/pru_rproc.c
> @@ -109,6 +109,7 @@ struct pru_private_data {
>   * @dbg_single_step: debug state variable to set PRU into single step mode
>   * @dbg_continuous: debug state variable to restore PRU execution mode
>   * @evt_count: number of mapped events
> + * @gpmux_save: saved value for gpmux config
>   */
>  struct pru_rproc {
>  	int id;
> @@ -127,6 +128,7 @@ struct pru_rproc {
>  	u32 dbg_single_step;
>  	u32 dbg_continuous;
>  	u8 evt_count;
> +	u8 gpmux_save;
>  };
>  
>  static inline u32 pru_control_read_reg(struct pru_rproc *pru, unsigned int reg)
> @@ -228,6 +230,7 @@ struct rproc *pru_rproc_get(struct device_node *np, int index,
>  	struct device *dev;
>  	const char *fw_name;
>  	int ret;
> +	u32 mux;
>  
>  	rproc = __pru_rproc_get(np, index);
>  	if (IS_ERR(rproc))
> @@ -252,6 +255,22 @@ struct rproc *pru_rproc_get(struct device_node *np, int index,
>  	if (pru_id)
>  		*pru_id = pru->id;
>  
> +	ret = pruss_cfg_get_gpmux(pru->pruss, pru->id, &pru->gpmux_save);
> +	if (ret) {
> +		dev_err(dev, "failed to get cfg gpmux: %d\n", ret);
> +		goto err;
> +	}
> +
> +	ret = of_property_read_u32_index(np, "ti,pruss-gp-mux-sel", index,
> +					 &mux);
> +	if (!ret) {
> +		ret = pruss_cfg_set_gpmux(pru->pruss, pru->id, mux);
> +		if (ret) {
> +			dev_err(dev, "failed to set cfg gpmux: %d\n", ret);
> +			goto err;
> +		}
> +	}
> +

It would have been nice to be told in a cover letter that pruss_cfg_get_gpmux()
is in linux-next so that I don't have to go fish for it...

I am fine with the code in this patch, though the changelog is cryptic and could
be enhanced to say "why" this is needed.  The above could use some comments to
make sure people looking at this code understand that an error from
of_property_read_u32_index() is acceptable for backward compatibility.

Here I have to suppose pruss_cfg_get_gpmux() has been added to Nishanth's tree.
As such the only way for me to apply your patch is if Nishanth sends me a pull
request for the patchset that introduced pruss_cfg_get_gpmux().  You can also
resend this in the next cycle.

Thanks,
Mathieu

>  	ret = of_property_read_string_index(np, "firmware-name", index,
>  					    &fw_name);
>  	if (!ret) {
> @@ -290,6 +309,8 @@ void pru_rproc_put(struct rproc *rproc)
>  
>  	pru = rproc->priv;
>  
> +	pruss_cfg_set_gpmux(pru->pruss, pru->id, pru->gpmux_save);
> +
>  	pru_rproc_set_firmware(rproc, NULL);
>  
>  	mutex_lock(&pru->lock);
> -- 
> 2.34.1
> 
