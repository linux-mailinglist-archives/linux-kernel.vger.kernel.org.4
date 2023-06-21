Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0177381F2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjFUKZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjFUKZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:25:33 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940431A8;
        Wed, 21 Jun 2023 03:25:31 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-989d03eae11so125662066b.2;
        Wed, 21 Jun 2023 03:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687343130; x=1689935130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YR+wlgHevwg5FuwHcUU1d3cnI2XtiA2vJqFj5alzsro=;
        b=sIQKXgeTqXp98Ny5rPWI0fIMQduVne5oVOC7LR2pcNyp4doH0500kIgdG81SbCKDTj
         vqYLLR6VC37TQT+70txmmLWiUqtr0cOo5l6PlqAv6veCmTjwJSCo6PH43dS8kHrmLEhm
         6KgSczL/RBUqx8ii3+MFH17C9VLCIDTbxCyiQ5BMhJzBAOgPAai1CaCXqUb5EVe5LSzx
         1d6EDrLw1+OCTrCDBBtfyvbFz57M1nQvTYXwhC3gsiDZHppon/h1dyrKngW0mNxC20Kz
         EhpdPnPmPBTV1BLbXaNaH6Ib6pC21XYKrHpVapcO4DCHYzFHp9uN5+mxzSOdCoU5PBWG
         59hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687343130; x=1689935130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YR+wlgHevwg5FuwHcUU1d3cnI2XtiA2vJqFj5alzsro=;
        b=ZtjvmH5+HSb4Fi0hQB0gbVfJEStvuBshMtlpLo9OxaKqjr8KZgyBdQpwxP9LPBcUQ3
         KLDR1oT2YmFSE4V6rIlv/6xiZvHWWs404Y80+M4Aynm77mioqU9CpFzfk9bSTwAw+T9G
         YGMMT5sOX8cze7rHTJJcw1Y8Uw53+eCdjqsG30GkmQU5J3oZpfCENBDymS4VWF5PhIfF
         ajDIFWp0lGhnDv43l8V2RgveEiCeP3VyZVuDKrW4tA95IDWrYvVwcqw/efnQ2Vu72jWu
         H+tFxxv9KK1vj/YHM5CrLyd3v9KCKn+1pF7DP1LSKUw/Owh6jkbu1Y6Yy2W8VGX50UEd
         Z6ew==
X-Gm-Message-State: AC+VfDw28r2AqhbcI7QDbDK1DJT9SDgWSKAqkY6ugeQHAYewcch0bmHz
        ynUyxZ2CB0U2kxCeLYWu8hQ=
X-Google-Smtp-Source: ACHHUZ6gLQ4j36V00vXy9eoVTLuvf0cUol0Ih8iJBMNyK3qmGdS8FTrtOZRwCCMVwX/JD17KQ+0xzQ==
X-Received: by 2002:a17:907:e86:b0:988:9b29:564a with SMTP id ho6-20020a1709070e8600b009889b29564amr8060764ejc.68.1687343129750;
        Wed, 21 Jun 2023 03:25:29 -0700 (PDT)
Received: from skbuf ([188.25.159.134])
        by smtp.gmail.com with ESMTPSA id q9-20020a1709066b0900b009829fcb94fesm2903845ejr.37.2023.06.21.03.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 03:25:29 -0700 (PDT)
Date:   Wed, 21 Jun 2023 13:25:27 +0300
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
Message-ID: <20230621102527.f47kmwminkhe7ttt@skbuf>
References: <20230620063747.19175-1-ansuelsmth@gmail.com>
 <20230620063747.19175-1-ansuelsmth@gmail.com>
 <20230620201227.7sdb3zmwutwtmt2e@skbuf>
 <64921dee.df0a0220.f64e1.72c7@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64921dee.df0a0220.f64e1.72c7@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 03:04:28PM +0200, Christian Marangi wrote:
> > > +			if (dsa_port_is_cpu(dp))
> > > +				cpu_port_mask |= BIT(dp->index);
> > > +	} else {
> > > +		dp = dsa_port_from_netdev(master);
> > 
> > dsa_port_from_netdev() is implemented by calling:
> > 
> > static inline struct dsa_port *dsa_slave_to_port(const struct net_device *dev)
> > {
> > 	struct dsa_slave_priv *p = netdev_priv(dev);
> > 
> > 	return p->dp;
> > }
> > 
> > The "struct net_device *master" does not have a netdev_priv() of the
> > type "struct dsa_slave_priv *". So, this function does not do what you
> > want, but instead it messes through the guts of an unrelated private
> > structure, treating whatever it finds at offset 16 as a pointer, and
> > dereferincing that as a struct dsa_port *. I'm surprised it didn't
> > crash, to be frank.
> > 
> > To find the cpu_dp behind the master, you need to dereference
> > master->dsa_ptr (for which we don't have a helper).
> > 
> 
> I was searching for an helper but no luck. Is it safe to access
> master->dsa_ptr? In theory the caller of port_change_master should
> already check that the passed master is a dsa port?

*that the passed network interface is a master - netdev_uses_dsa()

What is attached to the DSA master through dev->dsa_ptr is the CPU port.

what makes a net_device be a DSA master is dsa_master_setup(), and what
makes it stop being that is dsa_master_teardown(). Both are called under
rtnl_lock(), so as long as you are in a calling context where that lock
is held, you can be sure that the value of netdev_uses_dsa() does not
change for a device - and thus the value of dev->dsa_ptr.

> I see in other context that master->dsa_ptr is checked if not NULL.
> Should I do the same check here?

Nope. DSA takes care of passing a fully set up DSA master as the
"master" argument, and the calling convention is that rtnl_lock() is held.

> > > +	/* Assign the new CPU port in LOOKUP MEMBER */
> > > +	val |= cpu_port_mask;
> > > +
> > > +	ret = qca8k_rmw(priv, QCA8K_PORT_LOOKUP_CTRL(port),
> > > +			QCA8K_PORT_LOOKUP_MEMBER,
> > > +			val);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	/* Fast Age the port to flush FDB table */
> > > +	qca8k_port_fast_age(ds, port);
> > 
> > Why do you have to fast age the (user) port?
> > 
> 
> The 2 CPU port have a different mac address, is it a problem?

But fast ageing the user port (which is what "port" is, here) gets rid
of the FDB entries learned on that port as part of the bridging service,
and which have it as a *destination*. So I'm not sure how that operation
would help. The MAC address of the DSA masters, if learned at all, would
not point towards any user port but towards CPU ports.

FWIW, dsa_port_change_master() takes care of migrating/replaying a lot of
configuration, including the MAC addresses for local address filtering -
dsa_slave_unsync_ha() and dsa_slave_sync_ha().

That being said, those 2 functions are dead code for your switch,
because dsa_switch_supports_uc_filtering() and dsa_switch_supports_mc_filtering()
both return false.

It would be good to hear from you how do you plan the qca8k driver to
send and receive packets. From looking at the code (learning on the CPU
port isn't enabled), I guess that the MAC addresses of the ports are
never programmed in the FDB and thus, they reach the CPU by flooding,
with the usual drawbacks that come with that - packets destined for
local termination will also be flooded to other stations in the bridging
domain. Getting rid of the reliance on flooding will have its own
challenges. You can't enable automatic address learning [ on the CPU
ports ] with multiple active CPU ports, because one FDB entry could ping
pong from one CPU port to the other, leading to packet loss from certain
user ports when the FDB entry points to the CPU port that isn't affine
to the inbound port. So you'd probably need to program some sort of
"multicast" FDB entries that target all CPU ports, and rely on the
PORT_VID_MEMBER field to restrict forwarding to only one of those CPU
ports at a time.

> > > +
> > > +	/* Reenable port */
> > > +	qca8k_port_set_status(priv, port, 1);
> > 
> > or disable/enable it, for that matter?
> > 
> 
> The idea is sto stop any traffic flowing to one CPU to another before
> doing the change.

Both DSA masters are prepared to handle traffic when port_change_master()
is called, so unless there's some limitation in the qca8k driver, there
shouldn't be any in DSA.

> > From my notes in commit eca70102cfb1 ("net: dsa: felix: add support for
> > changing DSA master"), I recall this:
> > 
> >     When we change the DSA master to a LAG device, DSA guarantees us that
> >     the LAG has at least one lower interface as a physical DSA master.
> >     But DSA masters can come and go as lowers of that LAG, and
> >     ds->ops->port_change_master() will not get called, because the DSA
> >     master is still the same (the LAG). So we need to hook into the
> >     ds->ops->port_lag_{join,leave} calls on the CPU ports and update the
> >     logical port ID of the LAG that user ports are assigned to.
> > 
> > Otherwise said:
> > 
> > $ ip link add bond0 type bond mode balance-xor && ip link set bond0 up
> > $ ip link set eth0 down && ip link set eth0 master bond0 # .port_change_master() gets called
> > $ ip link set eth1 down && ip link set eth1 master bond0 # .port_change_master() does not get called
> > $ ip link set eth0 nomaster # .port_change_master() does not get called
> > 
> > Unless something has changed, I believe that you need to handle these as well,
> > and update the QCA8K_PORT_LOOKUP_MEMBER field. In the case above, your
> > CPU port association would remain towards eth0, but the bond's lower interface
> > is eth1.
> > 
> 
> Can you better describe this case?
> 
> In theory from the switch view, with a LAG we just set that an user port
> can receive packet from both CPU port.
> 
> Or you are saying that when an additional memeber is added to the LAG,
> port_change_master is not called and we could face a scenario where:
> 
> - dsa master is LAG
> - LAG have the 2 CPU port
> - user port have LAG as master but QCA8K_PORT_LOOKUP_MEMBER with only
>   one CPU?
> 
> If I got this right, then I get what you mean with the fact that I
> should update the lag_join/leave definition and refresh each
> configuration.

In Documentation/networking/dsa/configuration.rst I gave 2 examples of
changing the DSA master to be a LAG.

In the list of 4 commands I posted in the previous reply, I assumed that
eth0 is the original DSA master, and eth1 is the second (initially inactive)
DSA master.

When eth0 joins a LAG, DSA notices that and implicitly migrates all user
ports affine to eth0 towards bond0 as the new DSA master. At that time,
.port_change_master() will be called for all user ports under eth0, to
be notified that the new DSA master is bond0.

Once all user ports have bond0 as a DSA master, .port_change_master()
will no longer be called as long as bond0 remains their DSA master.
But the lower port configuration of bond0 can still change.

During the command where eth1 also becomes a lower port of bond0, DSA
just calls .port_lag_join() for the CPU port attached to eth1, and you
need to handle that and update the CPU port mask. Same thing when eth0
leaves bond0.
