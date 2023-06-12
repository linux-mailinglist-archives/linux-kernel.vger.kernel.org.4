Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E8772D269
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjFLVLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239940AbjFLVJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:09:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8081709
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686603999;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UVvZ3v/vxKNyCI7w7GwLJIJ0X+T6wDAbj+0uoM6y2a8=;
        b=D6Lik9t0QraF9efLXZA4bBBaVwWc4oxwwOj4aIhM/sZS8Rp1bP+/LTjCk5nfCgpFbOKXc+
        g/0b4CsC0K9YdHhATS8292zYhW5xLmcw3XGEFiw58JAIGE3SeIqeZmHL4dXJ2oo6TJS9FC
        IsKSqtY3i0+usJg3Xogp4uWXE32BUbQ=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-tpavn6nEOKuL8_o7en84RA-1; Mon, 12 Jun 2023 17:06:38 -0400
X-MC-Unique: tpavn6nEOKuL8_o7en84RA-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1a663daf3a0so1804552fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686603996; x=1689195996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVvZ3v/vxKNyCI7w7GwLJIJ0X+T6wDAbj+0uoM6y2a8=;
        b=g60geciFn+8EXNNjZ7A5vd3vYEKC92t1RUrnb7/HZjuVAijWPz5i8bl9yGtWYI1Gim
         cYMJl7R7F9a2pMPAncFncSY/LhqYMcGw9mnUh2KlrBOMjut2qUZeXcnT5gENPDaRRv3Z
         Ov1XKLZCqxbLQGoUCerNGN8JdsKllJ85qNvsFw7j2twvW2yiy8YyRqPq0vvLR18eURIl
         pHEuIMLb4JY42zDwI23Igv28ZvgZ45jCAm2yy20oRZKVkpQI5KmQ7J31GQtZLiYYxy1Q
         Qt0HYPMm/jnycmoaPWeqVWXYhF+1oFWyYTwzQjqARZtvZj0lX9lORH3A8Aq3lL/pZPgy
         55AQ==
X-Gm-Message-State: AC+VfDzFhQe0Ugcy/T9hCRzVDUXl9eaOz0c8GtZS0bilz1EQEZhREsnK
        M2WEa+ZmhWglL/+94uwF5x5lZCY9C9q6o95i3Z4u+8mAYjLmqT4d6iJGxLfp5IAprSLder4JEtk
        9WadtjRLVaLycYFxvo0swPrxq
X-Received: by 2002:a05:6870:770d:b0:1a6:7ae5:8e31 with SMTP id dw13-20020a056870770d00b001a67ae58e31mr2707682oab.15.1686603996096;
        Mon, 12 Jun 2023 14:06:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5l8CIOc/fjbn/4dLBsqStqDJVa3ICb/fLC7IjnpwzGvy8FQcOZ753YVKUTI3PaLVSqB/0bAw==
X-Received: by 2002:a05:6870:770d:b0:1a6:7ae5:8e31 with SMTP id dw13-20020a056870770d00b001a67ae58e31mr2707670oab.15.1686603995860;
        Mon, 12 Jun 2023 14:06:35 -0700 (PDT)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::45])
        by smtp.gmail.com with ESMTPSA id nw27-20020a056870bb1b00b001a6825ed5cfsm2251974oab.4.2023.06.12.14.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 14:06:35 -0700 (PDT)
Date:   Mon, 12 Jun 2023 16:06:32 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 15/26] net: stmmac: dwmac-qcom-ethqos: add support for
 the optional phy-supply
Message-ID: <20230612210632.agp4ybeseujblao2@halaney-x13s>
References: <20230612092355.87937-1-brgl@bgdev.pl>
 <20230612092355.87937-16-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612092355.87937-16-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:23:44AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> On sa8775p-ride we need to enable the power supply for the external PHY.

Is this for the external phy? It doesn't seem like it from the board
schematic I have... the regulator never makes it out of the black box that
is the SIP/SOM if I'm reading right.

My (poor) understanding was this was for the serdes phy that's doing the
conversion to SGMII before hitting the board... good chance I'm wrong
though.

> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 2f6b9b419601..21f329d2f7eb 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -8,6 +8,7 @@
>  #include <linux/phy.h>
>  #include <linux/phy/phy.h>
>  #include <linux/property.h>
> +#include <linux/regulator/consumer.h>
>  
>  #include "stmmac.h"
>  #include "stmmac_platform.h"
> @@ -692,6 +693,10 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto out_config_dt;
>  
> +	ret = devm_regulator_get_enable_optional(dev, "phy");
> +	if (ret < 0 && ret != -ENODEV)
> +		goto out_config_dt;
> +
>  	ethqos->serdes_phy = devm_phy_optional_get(dev, "serdes");
>  	if (IS_ERR(ethqos->serdes_phy)) {
>  		ret = PTR_ERR(ethqos->serdes_phy);
> -- 
> 2.39.2
> 

