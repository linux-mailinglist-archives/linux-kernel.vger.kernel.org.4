Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4007375B1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjFTUMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjFTUMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:12:33 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888A810DC;
        Tue, 20 Jun 2023 13:12:31 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-988a2715b8cso500687266b.0;
        Tue, 20 Jun 2023 13:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687291950; x=1689883950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qSw/SCXu/wnu6qjMKwBBX+r1nFV8pgJeyA7HPH8R3O0=;
        b=JpDXvI48t5QEqmsFd6GxH0/TFl+yPgo8W2N8HxQKyD9moCDrFYJZ72UB448R13wVIP
         lRqhJcNnhf3ztX7C2lP0AqzUjkFtCfLcR+SfUx769jkFPdPWopnazs75dWkCcckEzDLj
         KHNnJEbX/HyB01vW28QR0BiFk24qtknS0b+s4yq8WKqR473Km/QRaCYqY7FyV0JN+6iy
         fi9d0vp0uIK0hwOe+AKqFVknUE5XdxHs25KA+6gukeZjU5X51DFVIiR4Borq76L8T5Yv
         AeOCDJN6Et/YYbzS0Gnpf8AN1E8vk9pDh/gSsI/iB0Ki7/2MS9XJxl3obImmT1VnHeqO
         4qDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687291950; x=1689883950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSw/SCXu/wnu6qjMKwBBX+r1nFV8pgJeyA7HPH8R3O0=;
        b=hlR+Nbt2li0p4pw+GHXGll62LGLpJIXzaz9I5ayJ1Rq5AhJatOyMwVfMelJ4WgmpA3
         cKNK1map6t8RUHRm4wXTdGWIJtKxBES4bvqdH6dCTWm/43x2Bc5p7FVRq6ca3+ZZvYiN
         Yr7+66NadWYZXm4tvTArDPVxnFobZn/IdDKqQBsvG8SknKTdlgn8FChoagiwLj3NG+88
         6pR8AI8eMl+BlT8rW7RtgR+d3Sc7g/cG9sNEB1No/NfMsZ2sLC8/h8frf11G71cAg4gk
         cwjgPeQyxTKaUF6IK2RV3Q7U0fCdqWDliZoYDMFijuJsEOrbaIYh818aAbd2QKrfLFlc
         R4OA==
X-Gm-Message-State: AC+VfDwUQ+lp/Xj5uLuCzxXF1wpLlp2+C546jWciIMTIuQb8h5PaYSKz
        OFw9MMcIgIH5TYBiUC4o2Jc=
X-Google-Smtp-Source: ACHHUZ75nBUXi/625xexFsTSayQG+4RpwXbCIcCv7bwTJtlyLtY9HslXNxycxWNdoxEDlacFQeAcnA==
X-Received: by 2002:a17:907:7d86:b0:984:25ab:bb2e with SMTP id oz6-20020a1709077d8600b0098425abbb2emr11437824ejc.3.1687291949739;
        Tue, 20 Jun 2023 13:12:29 -0700 (PDT)
Received: from skbuf ([188.25.159.134])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090685ca00b0098873024c95sm1956175ejy.136.2023.06.20.13.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:12:29 -0700 (PDT)
Date:   Tue, 20 Jun 2023 23:12:27 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: dsa: qca8k: add support for
 port_change_master
Message-ID: <20230620201227.7sdb3zmwutwtmt2e@skbuf>
References: <20230620063747.19175-1-ansuelsmth@gmail.com>
 <20230620063747.19175-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620063747.19175-1-ansuelsmth@gmail.com>
 <20230620063747.19175-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On Tue, Jun 20, 2023 at 08:37:47AM +0200, Christian Marangi wrote:
> Add support for port_change_master to permit assigning an alternative
> CPU port if the switch have both CPU port connected or create a LAG on
> both CPU port and assign the LAG as DSA master.
> 
> On port change master request, we check if the master is a LAG.
> With LAG we compose the cpu_port_mask with the CPU port in the LAG, if
> master is a simple dsa_port, we derive the index.
> 
> Finally we apply the new cpu_port_mask to the LOOKUP MEMBER to permit
> the port to receive packet by the new CPU port setup for the port and
> we reenable the target port previously disabled.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/net/dsa/qca/qca8k-8xxx.c | 54 ++++++++++++++++++++++++++++++++
>  drivers/net/dsa/qca/qca8k.h      |  1 +
>  2 files changed, 55 insertions(+)
> 
> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> index dee7b6579916..435b69c1c552 100644
> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> @@ -1713,6 +1713,59 @@ qca8k_get_tag_protocol(struct dsa_switch *ds, int port,
>  	return DSA_TAG_PROTO_QCA;
>  }
>  
> +static int qca8k_port_change_master(struct dsa_switch *ds, int port,
> +				    struct net_device *master,
> +				    struct netlink_ext_ack *extack)
> +{
> +	struct qca8k_priv *priv = ds->priv;
> +	u32 val, cpu_port_mask = 0;
> +	struct dsa_port *dp;
> +	int ret;
> +
> +	/* With LAG of CPU port, compose the mask for LOOKUP MEMBER */
> +	if (netif_is_lag_master(master)) {
> +		struct dsa_lag *lag;
> +		int id;
> +
> +		id = dsa_lag_id(ds->dst, master);
> +		lag = dsa_lag_by_id(ds->dst, id);
> +
> +		dsa_lag_foreach_port(dp, ds->dst, lag)

I think you use ds->dst often enough that you could assign it to its own
local variable.

> +			if (dsa_port_is_cpu(dp))
> +				cpu_port_mask |= BIT(dp->index);
> +	} else {
> +		dp = dsa_port_from_netdev(master);

dsa_port_from_netdev() is implemented by calling:

static inline struct dsa_port *dsa_slave_to_port(const struct net_device *dev)
{
	struct dsa_slave_priv *p = netdev_priv(dev);

	return p->dp;
}

The "struct net_device *master" does not have a netdev_priv() of the
type "struct dsa_slave_priv *". So, this function does not do what you
want, but instead it messes through the guts of an unrelated private
structure, treating whatever it finds at offset 16 as a pointer, and
dereferincing that as a struct dsa_port *. I'm surprised it didn't
crash, to be frank.

To find the cpu_dp behind the master, you need to dereference
master->dsa_ptr (for which we don't have a helper).

> +		cpu_port_mask |= BIT(dp->index);
> +	}
> +
> +	/* Disable port */
> +	qca8k_port_set_status(priv, port, 0);
> +
> +	/* Connect it to new cpu port */
> +	ret = qca8k_read(priv, QCA8K_PORT_LOOKUP_CTRL(port), &val);
> +	if (ret)
> +		return ret;
> +
> +	/* Reset connected CPU port in LOOKUP MEMBER */
> +	val &= QCA8K_PORT_LOOKUP_USER_MEMBER;

val &= GENMASK(5, 1) practically has the effect of unsetting BIT(0) and BIT(6).
I suppose those are the 2 possible CPU ports? If so, then use ~dsa_cpu_ports(ds),
it's more readable at least for me as a fallback maintainer.

> +	/* Assign the new CPU port in LOOKUP MEMBER */
> +	val |= cpu_port_mask;
> +
> +	ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port),
> +			QCA8K_PORT_LOOKUP_MEMBER,
> +			val);
> +	if (ret)
> +		return ret;
> +
> +	/* Fast Age the port to flush FDB table */
> +	qca8k_port_fast_age(ds, port);

Why do you have to fast age the (user) port?

> +
> +	/* Reenable port */
> +	qca8k_port_set_status(priv, port, 1);

or disable/enable it, for that matter?

> +
> +	return 0;
> +}
> +
>  static void
>  qca8k_master_change(struct dsa_switch *ds, const struct net_device *master,
>  		    bool operational)
> @@ -1996,6 +2049,7 @@ static const struct dsa_switch_ops qca8k_switch_ops = {
>  	.get_phy_flags		= qca8k_get_phy_flags,
>  	.port_lag_join		= qca8k_port_lag_join,
>  	.port_lag_leave		= qca8k_port_lag_leave,
> +	.port_change_master	= qca8k_port_change_master,

From my notes in commit eca70102cfb1 ("net: dsa: felix: add support for
changing DSA master"), I recall this:

    When we change the DSA master to a LAG device, DSA guarantees us that
    the LAG has at least one lower interface as a physical DSA master.
    But DSA masters can come and go as lowers of that LAG, and
    ds->ops->port_change_master() will not get called, because the DSA
    master is still the same (the LAG). So we need to hook into the
    ds->ops->port_lag_{join,leave} calls on the CPU ports and update the
    logical port ID of the LAG that user ports are assigned to.

Otherwise said:

$ ip link add bond0 type bond mode balance-xor && ip link set bond0 up
$ ip link set eth0 down && ip link set eth0 master bond0 # .port_change_master() gets called
$ ip link set eth1 down && ip link set eth1 master bond0 # .port_change_master() does not get called
$ ip link set eth0 nomaster # .port_change_master() does not get called

Unless something has changed, I believe that you need to handle these as well,
and update the QCA8K_PORT_LOOKUP_MEMBER field. In the case above, your
CPU port association would remain towards eth0, but the bond's lower interface
is eth1.

>  	.master_state_change	= qca8k_master_change,
>  	.connect_tag_protocol	= qca8k_connect_tag_protocol,
>  };
> diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
> index c5cc8a172d65..424f851db881 100644
> --- a/drivers/net/dsa/qca/qca8k.h
> +++ b/drivers/net/dsa/qca/qca8k.h
> @@ -250,6 +250,7 @@
>  #define   QCA8K_GLOBAL_FW_CTRL1_MC_DP_MASK		GENMASK(14, 8)
>  #define   QCA8K_GLOBAL_FW_CTRL1_UC_DP_MASK		GENMASK(6, 0)
>  #define QCA8K_PORT_LOOKUP_CTRL(_i)			(0x660 + (_i) * 0xc)
> +#define   QCA8K_PORT_LOOKUP_USER_MEMBER			GENMASK(5, 1)
>  #define   QCA8K_PORT_LOOKUP_MEMBER			GENMASK(6, 0)
>  #define   QCA8K_PORT_LOOKUP_VLAN_MODE_MASK		GENMASK(9, 8)
>  #define   QCA8K_PORT_LOOKUP_VLAN_MODE(x)		FIELD_PREP(QCA8K_PORT_LOOKUP_VLAN_MODE_MASK, x)
> -- 
> 2.40.1
> 

