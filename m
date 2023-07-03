Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3305A746090
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 18:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjGCQQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 12:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjGCQQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:16:30 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375BF138;
        Mon,  3 Jul 2023 09:16:29 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-313f1085ac2so5168072f8f.1;
        Mon, 03 Jul 2023 09:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688400987; x=1690992987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=emz1HIV2tyNFo2hArR9ZPEIeA7lrKk5Ps7qtJRPJU8g=;
        b=NZbrqNLB3/D1/vqL9+ua23t9NTymPEx7vZDYV5avp0vAeJqOEgk88IglhhQbKCEGvL
         YjwnUxOXDHmh/O6zjQqTKSfGZWRwWmPa/u8d6qCMmiAoIsmJq9KlMwGBKHcxk2LYxCij
         3k+K7NGhSIgN6vZ3ldzPPA7oxjCIM9KaY52WcR8Aa0WHHmdfz8+o87r7oJ+NXD7Dhz/Z
         bPmuMe9MUxqHAT5Yp0pX0IBu5iCpWC/zZs1VY32j1GjEHVm0JBgJIo58teAG/3f4nS38
         a+ZUMJNUyH97Hca8F9kQ/KR6xg++/7zKEa5z/ibSWmu/TIoFs43hb13iABLkxEqTpuce
         4iQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688400987; x=1690992987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emz1HIV2tyNFo2hArR9ZPEIeA7lrKk5Ps7qtJRPJU8g=;
        b=KfRUnVhkB/C6UalFCeu+5Jnp4PKssLDHOsLrcaid56XUKHIluZRo5HBuGPxB1tX8W1
         zK3YqwitpOJw8HDPwiJRwE5kmSvQUsblJn26662Oe5eVc9RRkLZUTSnw3A+cooGJANMD
         xk7SIZ1bVX1La1NoncqzaXUBBmGDJiPm2f0JezaP48t4NuNFsnAFUcjMbgxiB0MYuRfk
         efL/EKPb3Q92aV6YtEIyaTnVOM+FYKQhCkGjgPQE+SrLQ7vEkMz+aSsSd137ir78p+Nd
         TX6HY+hw8T2HqS3EZbs4HXfEsRqKLOO1lejoBGeVYw5NOULsOPU4qvAht3GOuD5rlADG
         rHjg==
X-Gm-Message-State: ABy/qLYNNywby7qiimChQ61IrXtnQ4ZkwqGPyGmQ8OVD51jDJyznQ5y7
        WsXEyY4YYJhpXal7tW4zlTAM58JV2kzGFQ==
X-Google-Smtp-Source: APBJJlEEdDYquF5fdrKav7BwnoXGF4jr8UxVX71loXtHYsuIpyVAWuNYEygZn39KpbFUEBIqnUpcrw==
X-Received: by 2002:adf:f003:0:b0:313:e2ca:bceb with SMTP id j3-20020adff003000000b00313e2cabcebmr8101641wro.26.1688400987392;
        Mon, 03 Jul 2023 09:16:27 -0700 (PDT)
Received: from skbuf ([188.25.159.134])
        by smtp.gmail.com with ESMTPSA id l6-20020adff486000000b00313fd294d6csm17934060wro.7.2023.07.03.09.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 09:16:27 -0700 (PDT)
Date:   Mon, 3 Jul 2023 19:16:24 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/7] net: dsa: vsc73xx: Add dsa tagging based
 on 8021q
Message-ID: <20230703161624.wjuq35etp7ggeqwt@skbuf>
References: <20230625115343.1603330-1-paweldembicki@gmail.com>
 <20230625115343.1603330-4-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625115343.1603330-4-paweldembicki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 01:53:39PM +0200, Pawel Dembicki wrote:
> This patch is simple implementation of 8021q tagging in vsc73xx driver.
> At this moment devices with DSA_TAG_PROTO_NONE are useless. VSC73XX
> family doesn't provide any tag support for external ethernet ports.
> 
> The only way is vlan-based tagging. It require constant hardware vlan
> filtering. VSC73XX family support provider bridging but QinQ only without
> fully implemented 802.1AD. It allow only doubled 0x8100 TPID.
> 
> In simple port mode QinQ is enabled to preserve forwarding vlan tagged
> frames.
> 
> Tag driver introduce most simple funcionality required for proper taging
> support.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
> diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
> index 3ed5391bb18d..4cf0166fef7b 100644
> --- a/drivers/net/dsa/Kconfig
> +++ b/drivers/net/dsa/Kconfig
> @@ -125,7 +125,7 @@ config NET_DSA_SMSC_LAN9303_MDIO
>  
>  config NET_DSA_VITESSE_VSC73XX
>  	tristate
> -	select NET_DSA_TAG_NONE
> +	select NET_DSA_TAG_VSC73XX

typo: "select NET_DSA_TAG_VSC73XX_8021Q". This does not do anything, and
Kconfig still asks for a prompt for the config option that does exist.

>  	select FIXED_PHY
>  	select VITESSE_PHY
>  	select GPIOLIB
