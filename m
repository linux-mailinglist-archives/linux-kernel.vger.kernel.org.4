Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF6A73D0C4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 14:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjFYMJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 08:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjFYMJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 08:09:17 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB1B115;
        Sun, 25 Jun 2023 05:09:15 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-98df3dea907so142939566b.3;
        Sun, 25 Jun 2023 05:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687694954; x=1690286954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rChxnAXMaSHbRRLN9toEKoGtUl6ImkX+I0WVCcUIoLk=;
        b=TQMRm+mjXcmmuALstJjrxPECT2q/MrrTROIH8PvxdtJmhz/R3Bko6R98hrhAjnatrJ
         eh/kAIekvDvOgI44RuTEmKGaE+IALTNd3bWcDQ9vvWvc1pArdYRa5u5jRsOmAfnxzywU
         +zgH3DBVysYoqY4y4/sL/Akt5n8UTy0nU6vjWDGPkCn1qTRk3b7xr2goNCjcNeaQOVRl
         ih9mX62JrZPXoeqFBBguMUfrbRfPG2zVWBSxT21+/Eu0KYuBn6MuQ99/YmgBdtYMxkIP
         yw0MkUEMFpSdG9xYQOjUlmewqA2vGBtA2QMnV4nZG6VsNVR1HjtQNUqR2OD4MdJRhmOz
         bhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687694954; x=1690286954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rChxnAXMaSHbRRLN9toEKoGtUl6ImkX+I0WVCcUIoLk=;
        b=gOvs1dDXHPfUj+GN2r8iMt60gdEW5hTKcLqz15OlvcDcwj32AsyBHATMJjoAUqNXKd
         KNKmbYN6TZv2gaj1fIny+mMe0FSxSsD/QMVnaprYv0XjjvbOjKeXQaTM60Y5NkrsSXW7
         PmvjMnjr94b8ceji0UxCzP2SA1nxYIQoIGIflFjI/iJuRyOSGwIqztc+xuO22MOgCA/9
         H8VHjZHB2+KYt6wIVY8O6qXW/zLTX0nso9dET+hsDcBb7knpN0xThJSueb+xeO8WT/E+
         JIJLIqy32nOZhN9tXYJDLe66RV6Jn0yKdyXQYrLJPTT/lD5fChsKxeCoe5ih0hkjqKhA
         3PDg==
X-Gm-Message-State: AC+VfDwN7VCU8fpfRk0tg+oZCT/d5OSgHhoQG6sb5b66ffJMXPmS4t2a
        V1nFjZGqjdPtnrfrTAg/DY4=
X-Google-Smtp-Source: ACHHUZ6hvHH9EfDj2LVrSdlj/14MJuY0XUn4EdCjliWUutmrh0P4xwk4jzuZEmLHNw6noisjZFDWqQ==
X-Received: by 2002:a17:907:9453:b0:987:47b3:6e34 with SMTP id dl19-20020a170907945300b0098747b36e34mr19442555ejc.67.1687694953767;
        Sun, 25 Jun 2023 05:09:13 -0700 (PDT)
Received: from skbuf ([188.25.159.134])
        by smtp.gmail.com with ESMTPSA id kq2-20020a170906abc200b009887bb956e0sm1995795ejb.103.2023.06.25.05.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 05:09:13 -0700 (PDT)
Date:   Sun, 25 Jun 2023 15:09:11 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/7] net: dsa: vsc73xx: add
 port_stp_state_set function
Message-ID: <20230625120911.ws6eiywonoo5et7b@skbuf>
References: <20230625115343.1603330-1-paweldembicki@gmail.com>
 <20230625115343.1603330-3-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230625115343.1603330-3-paweldembicki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 01:53:38PM +0200, Pawel Dembicki wrote:
> This isn't fully functional implementation of 802.1D, but
> port_stp_state_set is required for future tag8021q operations.
> 
> This implementation handle properly all states, but vsc 73xx don't

handles

vsc73xx doesn't

> forward STP packets.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
> v2:
>   - fix kdoc
> 
>  drivers/net/dsa/vitesse-vsc73xx-core.c | 51 +++++++++++++++++++++++---
>  drivers/net/dsa/vitesse-vsc73xx.h      |  2 +
>  2 files changed, 47 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
> index 221672b9e17f..f123ce2ed244 100644
> --- a/drivers/net/dsa/vitesse-vsc73xx-core.c
> +++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
> @@ -164,6 +164,10 @@
>  #define VSC73XX_AGENCTRL	0xf0
>  #define VSC73XX_CAPRST		0xff
>  
> +#define VSC73XX_SRCMASKS_CPU_COPY		BIT(27)
> +#define VSC73XX_SRCMASKS_MIRROR			BIT(26)
> +#define VSC73XX_SRCMASKS_PORTS_MASK		GENMASK(7, 0)
> +
>  #define VSC73XX_MACACCESS_CPU_COPY		BIT(14)
>  #define VSC73XX_MACACCESS_FWD_KILL		BIT(13)
>  #define VSC73XX_MACACCESS_IGNORE_VLAN		BIT(12)
> @@ -620,15 +624,17 @@ static int vsc73xx_setup(struct dsa_switch *ds)
>  	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GMIIDELAY,
>  		      VSC73XX_GMIIDELAY_GMII0_GTXDELAY_2_0_NS |
>  		      VSC73XX_GMIIDELAY_GMII0_RXDELAY_2_0_NS);
> -	/* Enable reception of frames on all ports */
> -	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_RECVMASK,
> -		      0x5f);
>  	/* IP multicast flood mask (table 144) */
>  	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_IFLODMSK,
>  		      0xff);
>  
>  	mdelay(50);
>  
> +	/*configure forward map to CPU <-> port only*/
> +	for (i = 0; i < vsc->ds->num_ports; i++)
> +		vsc->forward_map[i] = VSC73XX_SRCMASKS_PORTS_MASK & BIT(CPU_PORT);
> +	vsc->forward_map[CPU_PORT] = VSC73XX_SRCMASKS_PORTS_MASK & ~BIT(CPU_PORT);
> +
>  	/* Release reset from the internal PHYs */
>  	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GLORESET,
>  		      VSC73XX_GLORESET_PHY_RESET);
> @@ -871,9 +877,6 @@ static void vsc73xx_phylink_mac_link_up(struct dsa_switch *ds, int port,
>  	if (duplex == DUPLEX_FULL)
>  		val |= VSC73XX_MAC_CFG_FDX;
>  
> -	/* Enable port (forwarding) in the receieve mask */
> -	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> -			    VSC73XX_RECVMASK, BIT(port), BIT(port));
>  	vsc73xx_adjust_enable_port(vsc, port, val);
>  }
>  
> @@ -1040,6 +1043,41 @@ static int vsc73xx_get_max_mtu(struct dsa_switch *ds, int port)
>  	return 9600;
>  }
>  
> +static void vsc73xx_port_stp_state_set(struct dsa_switch *ds, int port,
> +				       u8 state)
> +{
> +	struct vsc73xx *vsc = ds->priv;

Blank link after variable declarations; this affects comments too.
You can either put that comment above the function, or right above the
first "if" block (to me it makes more sense above the function).

> +	/* FIXME: STP frames isn't forwarded at this moment. BPDU frames are

s/isn't/aren't/

> +	 * forwarded only from to PI/SI interface. For more info see chapter

s/from to/from and to/

> +	 * 2.7.1 (CPU Forwarding) in datasheet.
> +	 * This function is required for tag8021q operations.
> +	 */
> +
> +	if (state == BR_STATE_BLOCKING)

state == BR_STATE_BLOCKING || state == BR_STATE_DISABLED

> +		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +				    VSC73XX_RECVMASK, BIT(port), 0);
> +	else
> +		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +				    VSC73XX_RECVMASK, BIT(port), BIT(port));
> +
> +	if (state == BR_STATE_LEARNING || state == BR_STATE_FORWARDING)
> +		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +				    VSC73XX_LEARNMASK, BIT(port), BIT(port));
> +	else
> +		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +				    VSC73XX_LEARNMASK, BIT(port), 0);
> +
> +	if (state == BR_STATE_FORWARDING)
> +		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +				    VSC73XX_SRCMASKS + port,
> +				    VSC73XX_SRCMASKS_PORTS_MASK,
> +				    vsc->forward_map[port]);
> +	else
> +		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
> +				    VSC73XX_SRCMASKS + port,
> +				    VSC73XX_SRCMASKS_PORTS_MASK, 0);
> +}
> +
>  static const struct dsa_switch_ops vsc73xx_ds_ops = {
>  	.get_tag_protocol = vsc73xx_get_tag_protocol,
>  	.setup = vsc73xx_setup,
> @@ -1056,6 +1094,7 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
>  	.port_disable = vsc73xx_port_disable,
>  	.port_change_mtu = vsc73xx_change_mtu,
>  	.port_max_mtu = vsc73xx_get_max_mtu,
> +	.port_stp_state_set = vsc73xx_port_stp_state_set,
>  };
>  
>  static int vsc73xx_gpio_get(struct gpio_chip *chip, unsigned int offset)
> diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
> index 30b1f0a36566..c4d5398edeeb 100644
> --- a/drivers/net/dsa/vitesse-vsc73xx.h
> +++ b/drivers/net/dsa/vitesse-vsc73xx.h
> @@ -5,6 +5,7 @@
>  
>  /**
>   * struct vsc73xx - VSC73xx state container
> + * @forward_map: Forward table cache
>   */
>  struct vsc73xx {
>  	struct device			*dev;
> @@ -15,6 +16,7 @@ struct vsc73xx {
>  	u8				addr[ETH_ALEN];
>  	const struct vsc73xx_ops	*ops;
>  	void				*priv;
> +	u8				forward_map[8];

Can we have this 8 and the one from the vsc->ds->num_ports assignment
consolidated into a single macro, VSC73XX_MAX_NUM_PORTS?

>  };
>  
>  struct vsc73xx_ops {
> -- 
> 2.34.1
> 
