Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20B273D0BB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 13:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjFYL6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 07:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjFYL6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 07:58:10 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F2ADA;
        Sun, 25 Jun 2023 04:58:08 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so2813820e87.3;
        Sun, 25 Jun 2023 04:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687694287; x=1690286287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sIwGonOq36GaVS+H1DUiLEFsm2Rip2kBsbIno4UEQXA=;
        b=qeyPUwCScU+C3CsEAsAfmRs95c9zpnUpXMby3j+wUTgekw+h2Z9see16Vq10XC99in
         o/GaKLGjqCejqVqbRFlJot53VK+qGAmMmRuqwD3sdKFmWId6xmLgWXBM52PDLFmBeUIJ
         IicnIzL5xZsM/FLH/zIzT4UYUhKWuDVBiHB1ux+kn+pQ0SEAB82L5co700dnoSScbYQp
         BONIReDtuzsoaAGeIMx7XLXuYRSn/k2diNAQVI0mHFnrAqVH7SHecru+l9BZuyH+DhJH
         tdkU7XRXOtVYktrVxNTonKLJVX3RYe6lqyi5dQK/Is0qgzYHTpcFRXf/FE3WHwtohfBy
         /Wrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687694287; x=1690286287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIwGonOq36GaVS+H1DUiLEFsm2Rip2kBsbIno4UEQXA=;
        b=IgTSnsdN0MBFAIeb+aPx17pY/lzH/IGeptDxfYB672hKVGQf76RdLhzxj8Rhafmoaj
         fpAirRRdG9CO5AWyKZHsXJPMdx0C4uHzr5tverDHI/qJJatgjYuyr7MxWX5TMosIzBzj
         DnsZqy+Na+noETcN3MvpdfxHAKTvXLBkExpwvG8XcHLPOePf7QhCGNAirj7OVuGSgvyS
         q0F/1OwYuyeNI2lwGVuhQQ1YZhun7vmHjLPi3SPtCCK7r/5xMxDhxSHDa72FawaLQHqV
         EQRhfKdlyltMngG+BokhEwmzWiTMHd9HdAS0A4jG8Enxg26z+pnoeVPcxtBeX8rhgasq
         t7ag==
X-Gm-Message-State: AC+VfDwbPA02BZ2tCjB25u6O2mqyVDC/Ge0ApM3avfPXGccHmXXLJm1+
        ovbGzbCp780Ki1Q7dGFUovM=
X-Google-Smtp-Source: ACHHUZ7I12kd5+S0HDR2KdCOSiFVeYje3PXTekKdb7Ytwzr2/WtxZygEwkefHTiLx/sxkfSD1gVdIQ==
X-Received: by 2002:a05:6512:10c5:b0:4f9:5c89:5b08 with SMTP id k5-20020a05651210c500b004f95c895b08mr9991360lfg.21.1687694286412;
        Sun, 25 Jun 2023 04:58:06 -0700 (PDT)
Received: from skbuf ([188.25.159.134])
        by smtp.gmail.com with ESMTPSA id u22-20020aa7d996000000b0051a26ce312dsm1680104eds.71.2023.06.25.04.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 04:58:05 -0700 (PDT)
Date:   Sun, 25 Jun 2023 14:58:03 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Atin Bainada <hi@atinb.me>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH RFC] net: dsa: qca8k: make learning configurable
 and keep off if standalone
Message-ID: <20230625115803.6xykp4wiqqdwwzv4@skbuf>
References: <20230623114005.9680-1-ansuelsmth@gmail.com>
 <20230623114005.9680-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623114005.9680-1-ansuelsmth@gmail.com>
 <20230623114005.9680-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 01:40:05PM +0200, Christian Marangi wrote:
> Address learning should initially be turned off by the driver for port
> operation in standalone mode, then the DSA core handles changes to it
> via ds->ops->port_bridge_flags().
> 
> Currently this is not the case for qca8k where learning is enabled
> unconditionally in qca8k_setup for every user port.
> 
> Handle ports configured in standalone mode by making the learning
> configurable and not enabling it by default.
> 
> Implement .port_pre_bridge_flags and .port_bridge_flags dsa ops to
> enable learning for bridge that request it and tweak
> .port_stp_state_set to correctly disable learning when port is
> configured in standalone mode.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
> 
> Posting as RFC as I would love some comments from Vladimir for correct
> implementation of this. This was suggested to be on par with offload
> bridge API and I used as example [1] (commit that does the same thing
> with a microchip switch)
> 
> I didn't want to bloat the priv struct with additional info with the
> port state and from what I can see it seems using dp->learning is enough
> to understand if learning is currently enabled for the port or not but I
> would love to have some confirmation about this. (from what I notice
> when port is set in standalone mode, flags are cleared so it should be
> correct)

In principle you can use dp->learning, but in this case you are using it
incorrectly (more below).

> 
> I also verified this working by dumping the fdb in a bridge
> configuration and in a standalone configuration. Traffic works in both
> configuration.
> 
> Dump WITH BRIDGE CONFIGURATION:
> 01:00:5e:00:00:01 dev eth0 self permanent
> 33:33:00:00:00:02 dev eth0 self permanent
> 33:33:00:00:00:01 dev eth0 self permanent
> 33:33:ff:f2:5d:50 dev eth0 self permanent
> 33:33:ff:00:00:00 dev eth0 self permanent
> dc:ef:09:f2:5d:4f dev eth1 self permanent
> 33:33:00:00:00:01 dev eth1 self permanent
> 33:33:00:00:00:02 dev eth1 self permanent
> 01:00:5e:00:00:01 dev eth1 self permanent
> 33:33:ff:f2:5d:4f dev eth1 self permanent
> 33:33:ff:00:00:00 dev eth1 self permanent
> c0:3e:ba:c1:d7:47 dev lan1 master br-lan
> dc:ef:09:f2:5d:4f dev lan1 vlan 1 master br-lan permanent
> dc:ef:09:f2:5d:4f dev lan1 master br-lan permanent
> c0:3e:ba:c1:d7:47 dev lan1 vlan 1 self
> 33:33:00:00:00:01 dev wlan0 self permanent
> 33:33:00:00:00:02 dev wlan0 self permanent
> 33:33:00:00:00:01 dev wlan1 self permanent
> 33:33:00:00:00:02 dev wlan1 self permanent
> 33:33:00:00:00:01 dev br-lan self permanent
> 33:33:00:00:00:02 dev br-lan self permanent
> 01:00:5e:00:00:01 dev br-lan self permanent
> 33:33:ff:00:00:01 dev br-lan self permanent
> 33:33:ff:f2:5d:4f dev br-lan self permanent
> 33:33:00:01:00:02 dev br-lan self permanent
> 33:33:00:01:00:03 dev br-lan self permanent
> 33:33:ff:00:00:00 dev br-lan self permanent
> 
> Dump WITH STANDALONE CONFIGURATION:
> 01:00:5e:00:00:01 dev eth0 self permanent
> 33:33:00:00:00:02 dev eth0 self permanent
> 33:33:00:00:00:01 dev eth0 self permanent
> 33:33:ff:f2:5d:50 dev eth0 self permanent
> 33:33:ff:00:00:00 dev eth0 self permanent
> 33:33:00:00:00:01 dev eth1 self permanent
> 33:33:00:00:00:02 dev eth1 self permanent
> 01:00:5e:00:00:01 dev eth1 self permanent
> 33:33:ff:f2:5d:4f dev eth1 self permanent
> 33:33:ff:00:00:01 dev eth1 self permanent
> 33:33:ff:00:00:00 dev eth1 self permanent
> 33:33:00:01:00:02 dev eth1 self permanent
> 33:33:00:01:00:03 dev eth1 self permanent
> 33:33:00:00:00:01 dev wlan0 self permanent
> 33:33:00:00:00:02 dev wlan0 self permanent
> 33:33:00:00:00:01 dev wlan1 self permanent
> 33:33:00:00:00:02 dev wlan1 self permanent

The information from these dumps is pretty much irrelevant.

> From what I can see there isn't any self entry with the MAC address of
> the connected device and this should confirm that learning is actually
> disabled.
> 
> Hope this is enough to test this feature and I would ask what would be
> the next step to reach a point where port_change_master can be
> implemented.

The way to test this patch would be to connect in loopback 2 standalone
qca8k ports having the same MAC address, and ping from one to the other.

ip netns add ns0
ip link set lan1 netns ns0 && ip -n ns0 link set lan1 up
ip -n ns0 addr add 192.168.100.1/24 dev lan1
ip link set lan2 up && ip addr add 192.168.100.2/24 dev lan2
ping 192.168.100.1

Before, it shouldn't have worked, now it should.

Once that basic precondition passes, you should be able to start looking
at tools/testing/selftests/drivers/net/dsa/ and run those one by one.
An interesting one would be local_termination.sh, which monitors the way
in which frames reach the CPU. Though be aware that some sub-tests from
that suite will fail on misconfigurations that are non-fatal (and don't
impact functionality), just sub-optimal (affecting performance). Like
sending unknown packets to the CPU when the port is non-promiscuous and
software would drop those packets anyway.

> (would also love to see what are the criteria to enable offload_fwd_mask
> on the targget for rcv and eventually for xmit)

For RX, skb->offload_fwd_mark = true (mark not mask) means that the software
bridge shouldn't flood packets received on lanX towards other lanY ports that
are part of the same hwdom, because the hardware already took care of
that.

[ the hardware domain is determined by dev_get_port_parent_id() ->
  devlink_compat_switch_id_get() and populated by dsa_port_devlink_setup() ]

Obviously, the requirement is for the hardware to indeed take care of that :)
Currently it doesn't flood to the other user ports that are part of the
same bridge and have egress flooding enabled for that traffic type. It
just floods to the CPU and software decides where to flood. It's a
matter of implementing other brport flags, like BR_FLOOD and friends.

For TX, skb->offload_fwd_mark means that the driver should be able to
send a skb potentially towards multiple TX ports at the same time, as a
result of an FDB lookup. This makes the bridge avoid cloning that skb
and calling dev_queue_xmit() towards every individual port that it must
reach. I would concentrate on RX and leave TX for later.

> Thanks for any response and sorry for the long comments.
> 
> 
> [1] https://github.com/torvalds/linux/commit/15f7cfae912e
> 
>  drivers/net/dsa/qca/qca8k-8xxx.c   |  8 ++----
>  drivers/net/dsa/qca/qca8k-common.c | 40 ++++++++++++++++++++++++++++++
>  drivers/net/dsa/qca/qca8k.h        |  6 +++++
>  3 files changed, 48 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> index f08086ac2261..a9af270a03ce 100644
> --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> @@ -1963,12 +1963,6 @@ qca8k_setup(struct dsa_switch *ds)
>  			if (ret)
>  				return ret;
>  
> -			/* Enable ARP Auto-learning by default */
> -			ret = regmap_set_bits(priv->regmap, QCA8K_PORT_LOOKUP_CTRL(i),
> -					      QCA8K_PORT_LOOKUP_LEARN);
> -			if (ret)
> -				return ret;
> -
>  			/* For port based vlans to work we need to set the
>  			 * default egress vid
>  			 */
> @@ -2071,6 +2065,8 @@ static const struct dsa_switch_ops qca8k_switch_ops = {
>  	.port_change_mtu	= qca8k_port_change_mtu,
>  	.port_max_mtu		= qca8k_port_max_mtu,
>  	.port_stp_state_set	= qca8k_port_stp_state_set,
> +	.port_pre_bridge_flags	= qca8k_port_pre_bridge_flags,
> +	.port_bridge_flags	= qca8k_port_bridge_flags,
>  	.port_bridge_join	= qca8k_port_bridge_join,
>  	.port_bridge_leave	= qca8k_port_bridge_leave,
>  	.port_fast_age		= qca8k_port_fast_age,
> diff --git a/drivers/net/dsa/qca/qca8k-common.c b/drivers/net/dsa/qca/qca8k-common.c
> index 8c2dc0e48ff4..f93defbd8b66 100644
> --- a/drivers/net/dsa/qca/qca8k-common.c
> +++ b/drivers/net/dsa/qca/qca8k-common.c
> @@ -559,8 +559,24 @@ int qca8k_get_mac_eee(struct dsa_switch *ds, int port,
>  	return 0;
>  }
>  
> +static int qca8k_port_configure_learning(struct dsa_switch *ds, int port,
> +					 bool learning)
> +{
> +	struct qca8k_priv *priv = ds->priv;
> +
> +	if (learning)
> +		return regmap_set_bits(priv->regmap,
> +				       QCA8K_PORT_LOOKUP_CTRL(port),
> +				       QCA8K_PORT_LOOKUP_LEARN);
> +	else
> +		return regmap_clear_bits(priv->regmap,
> +					 QCA8K_PORT_LOOKUP_CTRL(port),
> +					 QCA8K_PORT_LOOKUP_LEARN);
> +}
> +
>  void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
>  {
> +	struct dsa_port *dp = dsa_to_port(ds, port);
>  	struct qca8k_priv *priv = ds->priv;
>  	u32 stp_state;
>  
> @@ -585,6 +601,30 @@ void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
>  
>  	qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port),
>  		  QCA8K_PORT_LOOKUP_STATE_MASK, stp_state);
> +
> +	qca8k_port_configure_learning(ds, port, dp->learning);

Learning should be enabled only if we're in an STP state compatible with
learning: BR_STATE_LEARNING, BR_STATE_FORWARDING. The dp->learning flag
does not follow the STP state, it is just an override for that.

So, the condition should be:
"(state == BR_STATE_LEARNING || state == BR_STATE_FORWARDING) && dp->learning"

> +}
> +
> +int qca8k_port_pre_bridge_flags(struct dsa_switch *ds, int port,
> +				struct switchdev_brport_flags flags,
> +				struct netlink_ext_ack *extack)
> +{
> +	if (flags.mask & ~BR_LEARNING)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +int qca8k_port_bridge_flags(struct dsa_switch *ds, int port,
> +			    struct switchdev_brport_flags flags,
> +			    struct netlink_ext_ack *extack)
> +{
> +	int ret;
> +
> +	ret = qca8k_port_configure_learning(ds, port,
> +					    flags.mask & ~BR_LEARNING);

flags.mask contains the bits that have changed.
flags.val contains the current value of all bits.

Passing flags.mask & ~BR_LEARNING (the mask of changed flags except for
BR_LEARNING) to qca8k_port_configure_learning() makes absolutely no sense.

> +
> +	return ret;
>  }
>  
>  int qca8k_port_bridge_join(struct dsa_switch *ds, int port,
> diff --git a/drivers/net/dsa/qca/qca8k.h b/drivers/net/dsa/qca/qca8k.h
> index c5cc8a172d65..8f88b7db384d 100644
> --- a/drivers/net/dsa/qca/qca8k.h
> +++ b/drivers/net/dsa/qca/qca8k.h
> @@ -522,6 +522,12 @@ int qca8k_get_mac_eee(struct dsa_switch *ds, int port, struct ethtool_eee *e);
>  
>  /* Common bridge function */
>  void qca8k_port_stp_state_set(struct dsa_switch *ds, int port, u8 state);
> +int qca8k_port_pre_bridge_flags(struct dsa_switch *ds, int port,
> +				struct switchdev_brport_flags flags,
> +				struct netlink_ext_ack *extack);
> +int qca8k_port_bridge_flags(struct dsa_switch *ds, int port,
> +			    struct switchdev_brport_flags flags,
> +			    struct netlink_ext_ack *extack);
>  int qca8k_port_bridge_join(struct dsa_switch *ds, int port,
>  			   struct dsa_bridge bridge,
>  			   bool *tx_fwd_offload,
> -- 
> 2.40.1
> 

