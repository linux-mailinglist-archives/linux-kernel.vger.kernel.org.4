Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFCF738389
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjFUMRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjFUMRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:17:48 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8C4DD;
        Wed, 21 Jun 2023 05:17:46 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9889952ed18so535798066b.3;
        Wed, 21 Jun 2023 05:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687349865; x=1689941865;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xs3XCZFm3T2rPDgSOEBaVyKqlmn7v3wQKr8iLen+e/E=;
        b=J6GvlOf1mXDQJ6tInoSRr7E4DYRStGjNDGgEzrZMHpTGRZbKWAecW2pCgMmxG6x/Gv
         EInU5yhy6nI+4H27sDsfE2eFErdkCCR5FkCaZs0YUZxv3UNVv6QBgyaERZoQlqcRFSto
         dtFQfGcBa9GxG1fqTzj3Ts2JGCU9KJpzJH6dZ6EvuTZvQtwzAx/46dukI66kn8iZ9Wlb
         du5e0hOICQ+z6k2B5ZJhCpz7P8gCLwNg+ClzyZbqkikHGUmC+vae4emTDFytePF2jrSO
         V00WpGZ0kE2a5kVidYAl+SqoEZdJfEFWcn9l8LFRIrZZyLQMn/f8ODr6FXktqt9xHJPZ
         iRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687349865; x=1689941865;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xs3XCZFm3T2rPDgSOEBaVyKqlmn7v3wQKr8iLen+e/E=;
        b=ec0Q6rli7dhv70f9jrVcCG3TEIvVySB9MCPsE6yF6kk1DD248MtqZNBkEoMwUNn6co
         6NMX3+VipL/Ka7KrZzTiIxmxwgAykPApH5cpwVgeWUWxKnK/xN5A5UAypEQiug5qjNZJ
         tjKw/zL35Mc/tQ1ZNTPgCf26dysJpz79IRHV0hqmZTyvj8+WJpdR7IfA7ajG2+g/yq9E
         p92RXP0PIrn7sPI7MLdA3yer8wxXY2yTnTvNpAxoAiCZLWoAZBrwF+Q9adKbovOo++YD
         2fZ11bpCWhZZ5N3yo6xyX/FN+sWo9SxWZKZMiCCgV/uXrhPoW7GZn0/03TBQfXCV9aeI
         To4Q==
X-Gm-Message-State: AC+VfDw8Y/AuX3jbfK+A2JMkHBQKnPEFu7OZ/KI2UtIljMKg3XlHT0Jx
        QaRl04cAhWuGTHbbqoWcPCbmMmX02Gs=
X-Google-Smtp-Source: ACHHUZ4seKQBmihdJQH7Q93oTXhos89aR0u+OKD0FCN6W+jC0EiFQm+Ttv2bomoFZZgVVlK3MvdTAA==
X-Received: by 2002:a17:907:2da4:b0:988:806c:62da with SMTP id gt36-20020a1709072da400b00988806c62damr9533395ejc.58.1687349865130;
        Wed, 21 Jun 2023 05:17:45 -0700 (PDT)
Received: from skbuf ([188.25.159.134])
        by smtp.gmail.com with ESMTPSA id a7-20020a17090680c700b009786c8249d6sm3043797ejx.175.2023.06.21.05.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 05:17:44 -0700 (PDT)
Date:   Wed, 21 Jun 2023 15:17:42 +0300
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
Message-ID: <20230621121742.bsjtvpjz67bnevoq@skbuf>
References: <20230620201227.7sdb3zmwutwtmt2e@skbuf>
 <64921dee.df0a0220.f64e1.72c7@mx.google.com>
 <20230621102527.f47kmwminkhe7ttt@skbuf>
 <20230620063747.19175-1-ansuelsmth@gmail.com>
 <20230620063747.19175-1-ansuelsmth@gmail.com>
 <20230620201227.7sdb3zmwutwtmt2e@skbuf>
 <64921dee.df0a0220.f64e1.72c7@mx.google.com>
 <20230621102527.f47kmwminkhe7ttt@skbuf>
 <6492df37.7b0a0220.2a67f.9cd7@mx.google.com>
 <6492df37.7b0a0220.2a67f.9cd7@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6492df37.7b0a0220.2a67f.9cd7@mx.google.com>
 <6492df37.7b0a0220.2a67f.9cd7@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 08:52:27PM +0200, Christian Marangi wrote:
> On Wed, Jun 21, 2023 at 01:25:27PM +0300, Vladimir Oltean wrote:
> > > > Why do you have to fast age the (user) port?
> > > > 
> > > 
> > > The 2 CPU port have a different mac address, is it a problem?
> > 
> > But fast ageing the user port (which is what "port" is, here) gets rid
> > of the FDB entries learned on that port as part of the bridging service,
> > and which have it as a *destination*. So I'm not sure how that operation
> > would help. The MAC address of the DSA masters, if learned at all, would
> > not point towards any user port but towards CPU ports.
> > 
> > FWIW, dsa_port_change_master() takes care of migrating/replaying a lot of
> > configuration, including the MAC addresses for local address filtering -
> > dsa_slave_unsync_ha() and dsa_slave_sync_ha().
> > 
> 
> I notice that I require assisted_learning_on_cpu_port to make this
> actually work.
> 
> Wth this false, bridge fdb show still had entry with the MAC of the old
> master. With assisted, they gets correctly updated.

The behavior you're describing does not ring a bell to me.

What assisted_learning_on_cpu_port does is, when DSA is in a bridge with
a foreign device like wlan0, and wlan0 learns (in software, through the
bridge driver) a MAC address from a connected station, DSA calls
port_fdb_add() for that MAC address on the CPU ports associated with all
user ports from that bridge.

So it has nothing to do with the MAC address of the DSA master (100% sure).

Nonetheless, if you implement port_change_master(), you need to make
sure that port_fdb_add() on the CPU port does something sensible in the
presence of multiple simultaneously active CPU ports. Reading some
commit messages from the development of this feature on the felix driver
may give you some ideas.

> > It would be good to hear from you how do you plan the qca8k driver to
> > send and receive packets. From looking at the code (learning on the CPU
> > port isn't enabled), I guess that the MAC addresses of the ports are
> > never programmed in the FDB and thus, they reach the CPU by flooding,
> > with the usual drawbacks that come with that - packets destined for
> > local termination will also be flooded to other stations in the bridging
> > domain. Getting rid of the reliance on flooding will have its own
> > challenges. You can't enable automatic address learning [ on the CPU
> > ports ] with multiple active CPU ports, because one FDB entry could ping
> > pong from one CPU port to the other, leading to packet loss from certain
> > user ports when the FDB entry points to the CPU port that isn't affine
> > to the inbound port. So you'd probably need to program some sort of
> > "multicast" FDB entries that target all CPU ports, and rely on the
> > PORT_VID_MEMBER field to restrict forwarding to only one of those CPU
> > ports at a time.
> > 
> 
> Eh I really think this is not trivial at all and I would love some help.
> 
> With further testing, to make this actually work I had to operate on the
> GLOBAL_FW_CTRL1 regs that handle how to treat unknown frames of all
> kind.
> They are classified as unknown when the DA is not contained in the ARL
> table and are split in IGMP, BROAD (broadcast), MULTI (multicast) and
> UNI (unicast) and just are just the FLOOD option.

The qca8k driver lags a bit (more) behind when it comes to implementing
the bridge offload API efficiently (and correctly).

Namely, it floods everything to the single (first) CPU port and does not
implement any autonomous flooding to other user ports in the same
bridging domain. So it relies on software flooding - tag_qca.c does not
set skb->offload_fwd_mark = true for any kind of packet. Here, I'm
assuming that there isn't any inherent limitation that prevents
autonomous flooding from working, and this would offload some tasks from
the CPU.

In terms of correctness, it enables address learning on all user ports
by default, which is incorrect because user ports should only learn if
they are under a bridge *and* that bridge has learning enabled on that
port. Standalone ports should have address learning disabled, otherwise
learning will lead to packet loss when connecting two standalone user
ports to the same LAN. Commit 15f7cfae912e ("net: dsa: microchip: make
learning configurable and keep it off while standalone") comes to mind
as an example.

I would consider implementing .port_pre_bridge_flags() and .port_bridge_flags()
before jumping straight ahead to such advanced topics like .port_change_master().

In general, see what else there is in Documentation/networking/dsa/dsa.rst,
because the API documentation has been overhauled relatively recently.

> Saddly in the current configuration to make the secondary CPU port work,
> I had to set the flooding to both CPU port and I guess this is extremely
> wrong since I assume linux would receive double the packet for each
> unknown frame.

Not sure if it's "extremely wrong", maybe it isn't. A civilized hardware
implementation would probably restrict the flooding destinations with the
QCA8K_PORT_LOOKUP_MEMBER mask of the inbound port. So as long as a single
CPU port is present in that, then even when the flooding destination masks
contain multiple bits set, each packet goes to a single destination.

With LAG it should be similar, except that the destination mask is further
restricted by a port mask indexed by a hash calculated from packet headers.

It just needs serious testing. Arınç ÜNAL did similar work with mausezahn
and tcpdump for testing flooding, trapping etc on the mt7530 driver,
while adding support for multiple CPU ports.

> And this match what you have theorized about the need of a multicast FDB
> entry I guess? Main problem is that I have some fear the switch doesn't
> support controlling flooding with ARL or ACL (but I have to check this
> better)

Not sure that I understand what you're saying here.

> Just for reference this is the current fdb table 
> 
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

The entries with "master" are present in the software bridge database.

> dc:ef:09:f2:5d:4f dev lan1 vlan 1 master br-lan permanent

The entries with "permanent" (synonym is "local", BR_FDB_LOCAL in the code)
are FDB entries that are intended for local termination. They are
present on a bridge port, but they really mean that packets should go to
software (the CPU) for local termination, not towards that bridge port.

> dc:ef:09:f2:5d:4f dev lan1 master br-lan permanent
> c0:3e:ba:c1:d7:47 dev lan1 vlan 1 self

The entries with "self" are present in the hardware bridge database.

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

So I would guess that dc:ef:09:f2:5d:4f is the MAC address of br-lan,
inherited from the MAC address of the first bridge port (DSA switch
port). In turn, if there is no MAC address for ports in the device tree,
DSA inherits the MAC address from the master. So that's a plausible
avenue for the DSA master's MAC address to reach the bridge FDB.

The bridge notifies local addresses on the switchdev chain with the
fdb_info->is_local bit set, and DSA calls port_fdb_add() on the CPU
ports for them. So that's how they might reach the hardware FDB.
But again, port_fdb_add() programs static FDB entries, and fast ageing
doesn't remove those.
