Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CD26CAC93
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjC0SCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 14:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjC0SCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:02:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404CDEC;
        Mon, 27 Mar 2023 11:02:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8547B818A4;
        Mon, 27 Mar 2023 18:02:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79A1C4339B;
        Mon, 27 Mar 2023 18:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679940119;
        bh=r3W3CExS6s0aynR90LW9av86zilz2l5bpPiQq8qSgxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e5eKH37trpX6huVMm+kEvfWLbcU5tdQTr1r2ve39BDvGGqv/TSsQSO/2MEhhQqIL5
         hudw/0svA//Q0jC0gCjlzEOaq9YWJOu9Tka09ExBUq7XZ/TatcLyACvJnOGYXkN6AK
         LOL5uLSGXEV9OZ5EnAoCWJNiAK71AGI/TNSaDTCPB0dOgHYxIamMjE0+t6Re4WjWZ0
         1ZrByloe1o0sg0mT6tZDdbw+tH8tg8xXcabHmnRJgmBi4QEBy80jl3Rv2rZ+5J9Sbd
         anijbDoznXNlGRQMpfxYja5jghHDNhB0hgs+khe/fPuMZYJXkMGyU53pf4nfAUuTYR
         /sC19gQf19C/A==
Date:   Mon, 27 Mar 2023 11:01:57 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v4 4/7] soc: qcom: Make the Qualcomm UFS/SDCC ICE a
 dedicated driver
Message-ID: <20230327180157.GC1882@sol.localdomain>
References: <20230327134734.3256974-1-abel.vesa@linaro.org>
 <20230327134734.3256974-5-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327134734.3256974-5-abel.vesa@linaro.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 04:47:31PM +0300, Abel Vesa wrote:
> +	/* For now this driver only supports ICE version 3 and 4. */
> +	if (major != 3 && major != 4) {
> +		dev_warn(dev, "Unsupported ICE version: v%d.%d.%d\n",
> +			 major, minor, step);
> +		return false;
> +	}

Version 4 support was not in the original.  This ought to be mentioned in the
commit message.

> +struct qcom_ice *of_qcom_ice_get(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct qcom_ice *ice = ERR_PTR(-EPROBE_DEFER);
> +	struct device_node *node;
> +	struct resource *res;
> +	void __iomem *base;
> +
> +	if (!dev || !dev->of_node)
> +		return ERR_PTR(-ENODEV);
> +
> +	/* legacy has ice reg range in the consumer DT node */
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ice");
> +	if (res) {
> +		base = devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(base))
> +			return base;
> +
> +		/* create ICE instance using consumer dev */
> +		return qcom_ice_create(pdev, base);
> +	}
> +
> +	node = of_parse_phandle(dev->of_node, "qcom,ice", 0);
> +	if (!node) {
> +		ice = NULL;
> +		goto out;
> +	}

I think a longer comment in this code explaining the legacy implementation vs.
the new implementation would be helpful.

> +	pdev = of_find_device_by_node(node);
> +	if (!pdev) {
> +		dev_err(dev, "Cannot find device node %s\n", node->name);
> +		goto out;
> +	}

It is hard to understand the return value in this case, since
'ice = ERR_PTR(-EPROBE_DEFER)' happens way above.  Maybe do:

	if (!pdev) {
		dev_err(dev, "Cannot find device node %s\n", node->name);
		ice = ERR_PTR(-EPROBE_DEFER);
		goto out;
	}
> +
> +	ice = platform_get_drvdata(pdev);
> +	if (!ice) {
> +		dev_err(dev, "Cannot get ice\n");
> +		put_device(&pdev->dev);
> +		return ERR_PTR(-ENODEV);
> +	}

Can this error message be more descriptive?

Otherwise this patch is looking good, thanks!

- Eric
