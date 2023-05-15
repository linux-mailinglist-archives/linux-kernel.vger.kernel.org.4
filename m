Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE53F70212D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 03:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbjEOBeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 21:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjEOBeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 21:34:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B201FE6D;
        Sun, 14 May 2023 18:34:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EAF461C22;
        Mon, 15 May 2023 01:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC76C433EF;
        Mon, 15 May 2023 01:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684114453;
        bh=yEFfMawWA6faS6Ce0SG/FOijcLBaZ/OfoWo2b6rwzE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=olqq25I2ple0yj35L3gH4mm3gElRgVs8RyvR98YmPiEZXU+kQ6e7RWHtmxsU9qIoU
         WwfG46xBP6OLXRv0TGMhanLSy0N0gpqQ+6+9CV5bfkQqwZxPMH7SBUWSOo+ICbeXYI
         WCxrfz4Z3NvY12hvkNsG1qRwk3wvVQ5TdbBG1DCmM5zF+rHFsG7o7HdSMyKH19cIYl
         7dNCCkQKQpaXxKOSaGP5NeZkPik4faB1Mzgqd8W4kmhc7uipESAPHiXiCB4W3YbDu8
         BXaENUNoMfPMuOKlhOwsidQeG2fHa4nFqVwi9M7dbKng19zzzb0mSmyTB/rSCASvPA
         y/Tt2Ur6BHGWA==
Date:   Sun, 14 May 2023 18:38:06 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: qcom: sc8180x: gracefully handle missing IO
 memory resource
Message-ID: <20230515013806.ag2rdswrhdhiahis@ripper>
References: <20230513113510.177666-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230513113510.177666-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2023 at 01:35:10PM +0200, Krzysztof Kozlowski wrote:
> If device was probed with incorrect DT or ACPI tables, the IO memory
> resource would be missing and driver would derefernce NULL pointer in
> sc8180x_pinctrl_add_tile_resources().  Add simplep check if IO memory
> resource was provided to silence Smatch warning:
> 
>   drivers/pinctrl/qcom/pinctrl-sc8180x.c:1664 sc8180x_pinctrl_add_tile_resources() error: potentially dereferencing uninitialized 'mres'.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

> ---
>  drivers/pinctrl/qcom/pinctrl-sc8180x.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-sc8180x.c b/drivers/pinctrl/qcom/pinctrl-sc8180x.c
> index 704a99d2f93c..2fabec096aae 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sc8180x.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sc8180x.c
> @@ -1630,7 +1630,8 @@ static const struct msm_pinctrl_soc_data sc8180x_acpi_pinctrl = {
>  static int sc8180x_pinctrl_add_tile_resources(struct platform_device *pdev)
>  {
>  	int nres_num = pdev->num_resources + ARRAY_SIZE(sc8180x_tiles) - 1;
> -	struct resource *mres, *nres, *res;
> +	struct resource *mres = NULL;
> +	struct resource *nres, *res;
>  	int i, ret;
>  
>  	/*
> @@ -1657,6 +1658,9 @@ static int sc8180x_pinctrl_add_tile_resources(struct platform_device *pdev)
>  			*res++ = *r;
>  	}
>  
> +	if (!mres)
> +		return -EINVAL;
> +
>  	/* Append tile memory resources */
>  	for (i = 0; i < ARRAY_SIZE(sc8180x_tiles); i++, res++) {
>  		const struct tile_info *info = &sc8180x_tile_info[i];
> -- 
> 2.34.1
> 
