Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2A373A8A0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjFVSzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 14:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjFVSzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:55:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3BF186
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687460072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fcFPpQeDwI/GvuqShemurkup3+TWysI+P7nO7FR3o9o=;
        b=e9cttiuUsk6BSEyz7R+CBGaLOlvoa6Ljo+gzGhfdoBpYi7+oAN8EK1n3AEIdLAmVy6/0ze
        SvyQLwWhUvfvc8p29x9FEu2dTg6YgkLGElYaWCL47+vUZhptX8iWGXSwmhxMRA2yphlSRR
        rqBEDHTBROVNIlb1dVx2dbQFnp2J2O4=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-PWq9Z4CVMde2AG_HewSL3w-1; Thu, 22 Jun 2023 14:54:30 -0400
X-MC-Unique: PWq9Z4CVMde2AG_HewSL3w-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6b4c372f5aaso4409876a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687460068; x=1690052068;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcFPpQeDwI/GvuqShemurkup3+TWysI+P7nO7FR3o9o=;
        b=Gvx5AiUHEjNiRG7s+Dhww+SoTB4tL+OF5NxxXWo1fq5/jbLhZ0LgOHCrYIW0FZk6jv
         hKZ7fkgzeDnRYfl/0g9nAqgUckIdUney319S0N5jajndoq/E6TZ9Xn0kkjpUm2VSDaoj
         H9hiOz2CCk09hO2tOxv+nLlfimrNtLJwIJDPlv6x7I99fYiQtnVJoGjkqm2aMyYm+oAQ
         Vcz2DxeMtKldZUoD5SB5EH8H9DzF2NXoR7qejxY7vrkcgsr+TkFjVN+4vWc+xtwh4c+/
         ByJPUjiD8/Ig4kVzNhbCDWdf7rJrTy1r9NN4osaK5sw4mHOHBUl1tWB0jvuntg8psSq8
         vsiQ==
X-Gm-Message-State: AC+VfDxboBAo+APtU7Rep5xpwtJ74gMZ7qY3is0UIAM0FXFn2vK9uuvX
        CrOzbbHZVNpCwdpaiROM30j4MxhuyEdI9qB1W1+9rrFzCWYC16jxcLiKLbUqr2nWtLH2aub93iF
        SOK0iaWnnez0c31KTwJCoA+ZX
X-Received: by 2002:a9d:7985:0:b0:6b4:27e8:fb3e with SMTP id h5-20020a9d7985000000b006b427e8fb3emr14096445otm.27.1687460068405;
        Thu, 22 Jun 2023 11:54:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7uPvTcOIYG9gzSLYiwB8j1p2qMb9rwBj1K/JGUAcjwcI3+cPgyeiiPBlkDDEg+NeB7FiW5CA==
X-Received: by 2002:a9d:7985:0:b0:6b4:27e8:fb3e with SMTP id h5-20020a9d7985000000b006b427e8fb3emr14096429otm.27.1687460068144;
        Thu, 22 Jun 2023 11:54:28 -0700 (PDT)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::f])
        by smtp.gmail.com with ESMTPSA id d19-20020a056830139300b006ac98aae2d3sm3137110otq.40.2023.06.22.11.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 11:54:27 -0700 (PDT)
Date:   Thu, 22 Jun 2023 13:54:25 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Junxiao Chang <junxiao.chang@intel.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net] net: stmmac: fix double serdes powerdown
Message-ID: <20230622185425.vfewm2qgxqpndfyf@halaney-x13s>
References: <20230621135537.376649-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621135537.376649-1-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 03:55:37PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Commit 49725ffc15fc ("net: stmmac: power up/down serdes in
> stmmac_open/release") correctly added a call to the serdes_powerdown()
> callback to stmmac_release() but did not remove the one from
> stmmac_remove() which leads to a doubled call to serdes_powerdown().
> 
> This can lead to all kinds of problems: in the case of the qcom ethqos
> driver, it caused an unbalanced regulator disable splat.
> 
> Fixes: 49725ffc15fc ("net: stmmac: power up/down serdes in stmmac_open/release")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com>

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 10e8a5606ba6..4727f7be4f86 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -7461,12 +7461,6 @@ void stmmac_dvr_remove(struct device *dev)
>  	netif_carrier_off(ndev);
>  	unregister_netdev(ndev);
>  
> -	/* Serdes power down needs to happen after VLAN filter
> -	 * is deleted that is triggered by unregister_netdev().
> -	 */
> -	if (priv->plat->serdes_powerdown)
> -		priv->plat->serdes_powerdown(ndev, priv->plat->bsp_priv);
> -
>  #ifdef CONFIG_DEBUG_FS
>  	stmmac_exit_fs(ndev);
>  #endif
> -- 
> 2.39.2
> 

