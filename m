Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBF072D0DB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbjFLUmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237807AbjFLUlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:41:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A041172B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686602447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+GICplP/MT1isAH+ok2l+9fKNc3rvvMZkj74HkVOtyg=;
        b=HZb4b7DF1KJD+PD54kOwh8oUXEN1DjN5oyTSoWWcoM6dThxgpjpqgck3J0C9KGjIjAVmWZ
        mWYjyoVs4f74U5YyY4goTjMRDrA7UGAwGy9fIuZ0xQsM1Lalgp4JHNLWo7AQWNLba/niJz
        5Pz08+6aFVkjq1SjCGYDIcltIG/dGLA=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-0oj49lK4Mgy78NyVWqwvzQ-1; Mon, 12 Jun 2023 16:40:46 -0400
X-MC-Unique: 0oj49lK4Mgy78NyVWqwvzQ-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-568a85f180dso68569917b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686602445; x=1689194445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GICplP/MT1isAH+ok2l+9fKNc3rvvMZkj74HkVOtyg=;
        b=NTAkYHzkN5MRGAcn2sjc3JorMPJCbAij8/ynVcf+QNdsZ3NjK5XDp1TKC6/cnPJYuc
         WH6rIVm/XHVlMGwgQ2xrswYb9dptNervGSMQwTpKuj3xmlehWTrG4JMi2qtqRcoM1ji+
         Mj7o7G/y1YtwDfAEXxDOxkl2q1eSyN1CsE0UQ+vq2VrnRpk0TNSuYs95bLDR7pssaOk0
         3+UAxSFDiou6tmXE5KE/MWuD5hceZoKJvOe8G5OpCJRK5tfV2oZvUt9zzPYrWaM+Jvn8
         8PL/vgZskZ8YMbU2ldWNHGrQhS7r4iecxkRaw7h11gnokuXeN2CgD77MIDAxcsvUo14n
         FDUA==
X-Gm-Message-State: AC+VfDwFW920hPwuYFqFF7aCemUrDIV+REF9HKLMFywugAhNv72pyWMO
        zys/jf5FG47JigsSwC5YNc/lwOrXwHwZghiW4J23K/RkM8pTOp8Naovd5TLvJxRSkT2ZqnK3ScD
        9WMn9D3QIYcVdNyIXN2kLCXVY
X-Received: by 2002:a0d:d3c5:0:b0:569:770d:c9be with SMTP id v188-20020a0dd3c5000000b00569770dc9bemr12009519ywd.41.1686602445482;
        Mon, 12 Jun 2023 13:40:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5YAuKjyJv/dyosgPSnG9gP4AwJix4ti1YXmUnmzQLCn8a2Fe9vENV68IYdOSwyVmtTplKXgA==
X-Received: by 2002:a0d:d3c5:0:b0:569:770d:c9be with SMTP id v188-20020a0dd3c5000000b00569770dc9bemr12009500ywd.41.1686602445225;
        Mon, 12 Jun 2023 13:40:45 -0700 (PDT)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::45])
        by smtp.gmail.com with ESMTPSA id k190-20020a0dc8c7000000b0056d51c39c1fsm208496ywd.23.2023.06.12.13.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 13:40:44 -0700 (PDT)
Date:   Mon, 12 Jun 2023 15:40:42 -0500
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
Subject: Re: [PATCH 13/26] net: stmmac: dwmac-qcom-ethqos: make the rgmii
 clock optional
Message-ID: <20230612204042.litbbv23zdb3u5k7@halaney-x13s>
References: <20230612092355.87937-1-brgl@bgdev.pl>
 <20230612092355.87937-14-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612092355.87937-14-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:23:42AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> On sa8775p there's no RGMII clock so make it optional in the driver.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 3438b6229351..252dca400071 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -663,7 +663,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
>  	ethqos->rgmii_config_loopback_en = data->rgmii_config_loopback_en;
>  	ethqos->has_emac3 = data->has_emac3;
>  
> -	ethqos->rgmii_clk = devm_clk_get(dev, "rgmii");
> +	ethqos->rgmii_clk = devm_clk_get_optional(dev, "rgmii");

This makes it optional for older platforms too, but as far as I know on
those platforms it is mandatory.

This can be enforced in dt-binding checks, but should we also enforce
that in the driver still? Honestly I feel like yes, but there's probably
some precedent maintainers follow on this front that I don't know of.


>  	if (IS_ERR(ethqos->rgmii_clk)) {
>  		ret = PTR_ERR(ethqos->rgmii_clk);
>  		goto out_config_dt;
> -- 
> 2.39.2
> 

