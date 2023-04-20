Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9916E9449
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbjDTMaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbjDTMaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:30:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD9B658B;
        Thu, 20 Apr 2023 05:30:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFE3161647;
        Thu, 20 Apr 2023 12:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46EEC433D2;
        Thu, 20 Apr 2023 12:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681993801;
        bh=VE7EWjRbie5rJybEr6+xbW/1EFmgykY9w+gQ4IWRzQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fd0AjzBesaZOfkihQtIdI1XWLKkZFcQ8C040snGRpbZuiXicincyOqwzgcU6jyxOE
         boa7J6EMQWbHkRsfTLTFGfgWSuudj1+NCK59q7+hS2yR0l3tL+5q14m5dhs/kS5VI3
         ibjH8uvcrLR/qZFI82P8hXNLV+bLyvbVit+ovqW29M2b486ESGULIYgNf9Vvm97M9q
         l0jtc4AgjG1KpDm9o72+IgfMQShsOQcyrU2Iqd821k0dpsvSrvuonXOhicNCPuMj9R
         5udkdqVaSdDIB0ONGTy0J6vpbo1TLJwUr9+OwYwNL7v1C1VSsPiGTMHXYA3dWZHDds
         YTcl3QsNqJ0Hg==
Date:   Thu, 20 Apr 2023 13:29:55 +0100
From:   Lee Jones <lee@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v6 2/7] mfd: core: Ensure disabled devices are skiped
 without aborting
Message-ID: <20230420122955.GA996918@google.com>
References: <20230417171601.74656-1-herve.codina@bootlin.com>
 <20230417171601.74656-3-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230417171601.74656-3-herve.codina@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023, Herve Codina wrote:

> The loop searching for a matching device based on its compatible
> string is aborted when a matching disabled device is found.
> This abort avoid to add devices as soon as one disabled device
> is found.
> 
> Continue searching for an other device instead of aborting on the
> first disabled one fixes the issue.
> 
> Fixes: 22380b65dc70 ("mfd: mfd-core: Ensure disabled devices are ignored without error")
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/mfd/mfd-core.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index 16d1861e9682..7c47b50b358d 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -176,6 +176,7 @@ static int mfd_add_device(struct device *parent, int id,
>  	struct platform_device *pdev;
>  	struct device_node *np = NULL;
>  	struct mfd_of_node_entry *of_entry, *tmp;
> +	bool not_available;
>  	int ret = -ENOMEM;
>  	int platform_id;
>  	int r;
> @@ -211,13 +212,13 @@ static int mfd_add_device(struct device *parent, int id,
>  		goto fail_res;
>  
>  	if (IS_ENABLED(CONFIG_OF) && parent->of_node && cell->of_compatible) {
> +		not_available = false;

Why not do:

		bool disabled = false;

... here instead?

>  		for_each_child_of_node(parent->of_node, np) {
>  			if (of_device_is_compatible(np, cell->of_compatible)) {
> -				/* Ignore 'disabled' devices error free */
> +				/* Skip 'disabled' devices */
>  				if (!of_device_is_available(np)) {
> -					of_node_put(np);

Why are you removing the put?

> -					ret = 0;
> -					goto fail_alias;
> +					not_available = true;
> +					continue;
>  				}
>  
>  				ret = mfd_match_of_node_to_dev(pdev, np, cell);
> @@ -227,10 +228,17 @@ static int mfd_add_device(struct device *parent, int id,
>  				if (ret)
>  					goto fail_alias;
>  
> -				break;
> +				goto match;
>  			}
>  		}
>  
> +		if (not_available) {
> +			/* Ignore 'disabled' devices error free */
> +			ret = 0;
> +			goto fail_alias;
> +		}
> +
> +match:
>  		if (!pdev->dev.of_node)
>  			pr_warn("%s: Failed to locate of_node [id: %d]\n",
>  				cell->name, platform_id);
> -- 
> 2.39.2
> 

-- 
Lee Jones [李琼斯]
