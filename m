Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852F772D032
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbjFLUIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235128AbjFLUI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:08:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEED118
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686600458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IuHNa6WZpYveQJr9GnIkLeDKCuARWHsJdm0re5kGQrg=;
        b=Y+gpow56zCCdJUFp8ZSslMe8ZohsuQCMblLLSYJeaI3BQ5K0gP7s+CS2MqM/cskhNFxSnw
        YLjnrM8uQZbR8OLUbr+DEEYSkxubNROEETJYfIt0l7MBaEbGZqPs1m7+Esh769BGt9T5IG
        z3G1LclXvhxZ/7aGa0Jf+U97sB5B9as=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-lXtz-rn7PaOfH-y1Iodr2A-1; Mon, 12 Jun 2023 16:07:37 -0400
X-MC-Unique: lXtz-rn7PaOfH-y1Iodr2A-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-558a0f24871so3889148eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686600457; x=1689192457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IuHNa6WZpYveQJr9GnIkLeDKCuARWHsJdm0re5kGQrg=;
        b=QWD9R4902PMPXXdpEBYjfMoV40x5KvsafHAWD3Ys2vY1xbzfdtGH/wluwO0rp2yLiH
         01m+NP5alwvzDIlOM0Opc8UpWDSzijyiOSzQnBTC92qipB5BM3ilWMmsf0tigy/WkBoL
         NxC5g4BcZku2QCf11A0LUeCDAB1SogIgXFik1JZ51sSw2WWRig8KivCRPJgBOE87eHgP
         rJ//38e/X0OczHcgrGMEra/bfRssilHMHegp7hUoamO/hQBScSrnR4xIkQOdU0EKxbKa
         aYHJsUfTWxRjcApA4lroIL6DYdpI2ApbBcOjvU7hJ7uugoGYhDmuKZEDvhfQRnM4ASmK
         LB2w==
X-Gm-Message-State: AC+VfDwi9piUu5ieXVE+ce3nud+V649DUsT4vh/ZyAWAfJEun+BmbIU8
        EGvYAuhmU8weOD3YCGpxqf6xeYVhXWzYaXhOF/ag0bTD67+ofCZ0ZnhCWVd2ac1cCO1b839ClbV
        h1xQfYsw7GW99JfGeTuAHvRrY
X-Received: by 2002:a4a:bd92:0:b0:556:c580:eba6 with SMTP id k18-20020a4abd92000000b00556c580eba6mr5832115oop.4.1686600457018;
        Mon, 12 Jun 2023 13:07:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Sjt0Fg2Ll+XfHA2BponpBIQ9aDoC0AyoTvbdiarG2SXbdj01ZqgXciHHSmeIvp1v/ALCRsQ==
X-Received: by 2002:a4a:bd92:0:b0:556:c580:eba6 with SMTP id k18-20020a4abd92000000b00556c580eba6mr5832088oop.4.1686600456761;
        Mon, 12 Jun 2023 13:07:36 -0700 (PDT)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::45])
        by smtp.gmail.com with ESMTPSA id t14-20020a4ad0ae000000b0054fd0b7af2bsm3509727oor.31.2023.06.12.13.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 13:07:36 -0700 (PDT)
Date:   Mon, 12 Jun 2023 15:07:33 -0500
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
Subject: Re: [PATCH 11/26] net: stmmac: dwmac-qcom-ethqos: remove stray space
Message-ID: <20230612200733.h3323ktcggbeil3q@halaney-x13s>
References: <20230612092355.87937-1-brgl@bgdev.pl>
 <20230612092355.87937-12-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612092355.87937-12-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:23:40AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> There's an unnecessary space in the rgmii_updatel() function, remove it.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 5b56abacbf6b..8ed05f29fe8b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -117,7 +117,7 @@ static void rgmii_updatel(struct qcom_ethqos *ethqos,
>  {
>  	unsigned int temp;
>  
> -	temp =  rgmii_readl(ethqos, offset);
> +	temp = rgmii_readl(ethqos, offset);
>  	temp = (temp & ~(mask)) | val;
>  	rgmii_writel(ethqos, temp, offset);
>  }
> -- 
> 2.39.2
> 

