Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65A9747A6B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 01:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjGDXfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 19:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjGDXfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 19:35:03 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221F110F1;
        Tue,  4 Jul 2023 16:35:00 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-992ace062f3so724765966b.2;
        Tue, 04 Jul 2023 16:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688513699; x=1691105699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1c9xD4GRk7/8Sb14iymA40V0VsYFj3rv8CdlZ2MzHws=;
        b=rRT6mAgTTbTz8TtceRh7klaZaM+lIGK96pZgezz3nNEUTu75Sy3ftXwq83/qZx/hX9
         9KNpqFZrHDfCQyiStNvgfBep3ADOSfpfuwXRXpIKHDf9jKrUXW5jLk7KiImyQvxrC4VT
         ttfQli3U5p0bn51h0GaZlIIlTSOSWj6cI9CtnQ+dAIWqlTVMmOBJY7QzjrzA/rKM1XtQ
         M9KVqUUGkTYlEMKngp9bAI0B3DP5L4xeV+XofSVxRaoWeB3Id8jvYHPLTY5obRPsrCi2
         vufNXEdz9lzEj5CPr6gnVT0NWoh6roDKmBmqkuXfXIe+LbMiztgUaHmRJfP0gCJ8UeO4
         wGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688513699; x=1691105699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1c9xD4GRk7/8Sb14iymA40V0VsYFj3rv8CdlZ2MzHws=;
        b=h88W6erSO9QIz4Tv59zrfIjslj5X+B3BOuzSTahcbjtatGqNq5OguqZWR3sq4/hp6B
         HEKTwAm87pcqCtaJdqlDPWodMnhaHtSLs5v4pJrSL+GDxz2HI5avBdRHZTCo423ZUFMI
         xKlrMrpGbb+ZrSaLetf0lEAxU3AF8HYulX2joHY0/2ijSIVRXIVIqFEd0w6vO7NP+bV9
         rznvzJLK0J8xSHNERr4X3oL2VFBqDde0UDNz+P1CGFRHv7BnGrj7xknImNya03f2Ax5M
         ncXBP1ti/+RQ8zoEYbqW+cIOj/AgDc0Sv48eG4NPCU6Ia3VPleIfqraklU//i4ucqPy7
         fdPQ==
X-Gm-Message-State: ABy/qLYSEkp7Mi+8k8oGy7PyT8IJB4WRq9remmrLAxJPPQTGC1oBFnH5
        SwomnA0NV95oWg7Q8ntJLwSQIzD9ySsY1g==
X-Google-Smtp-Source: APBJJlEbuq8daQ7Z9Oc3s+6USWu2dAakmdXxHQXwwOBqqmnnT+9+l9ECMWZNQt4ska30t1R1YN/QzA==
X-Received: by 2002:a17:906:fcba:b0:988:bb33:53b7 with SMTP id qw26-20020a170906fcba00b00988bb3353b7mr11071947ejb.60.1688513698914;
        Tue, 04 Jul 2023 16:34:58 -0700 (PDT)
Received: from skbuf ([188.25.159.134])
        by smtp.gmail.com with ESMTPSA id k23-20020a170906579700b009937dbabbdasm2419412ejq.217.2023.07.04.16.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 16:34:58 -0700 (PDT)
Date:   Wed, 5 Jul 2023 02:34:56 +0300
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
Message-ID: <20230704233456.m4te445nsa6v63kf@skbuf>
References: <20230623114005.9680-1-ansuelsmth@gmail.com>
 <20230623114005.9680-1-ansuelsmth@gmail.com>
 <20230625115803.6xykp4wiqqdwwzv4@skbuf>
 <6499c31c.df0a0220.e2acb.5549@mx.google.com>
 <20230626173056.zq77nilzrr5djns5@skbuf>
 <6499d3f5.050a0220.3becf.7296@mx.google.com>
 <20230627094916.maywojwztzdek5y2@skbuf>
 <649c3931.df0a0220.136ab.2fb7@mx.google.com>
 <20230629123954.jjcz2rfygwnxa6pq@skbuf>
 <64a1caff.050a0220.561f4.7316@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64a1caff.050a0220.561f4.7316@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2023 at 08:25:11PM +0200, Christian Marangi wrote:
> I have bad and good news about this... Bad news is that it seems to be
> qca8k handle flooding in a very interesting and broken way.
> Due to DSA implementation we expect every packet to be flooded to the
> CPU port by default and this is problematic with how the switch works.

To be clear, the network stack understands "flooding" to be something
that takes place for packets that have an unknown MAC DA, or broadcast.
So no, we don't expect that every packet is flooded, nor that all are
flooded to the CPU port. I'm not exactly clear what you mean.

> 
> It seems that enabling flood bit for the CPU results in packet always be
> directed there...

Are you sure? How have you determined this? Can you rephrase this?
Because what I'm understanding is that you're saying that when flooding
towards the CPU is enabled, packets go to the CPU regardless of whether
they're known to the FDB or not. Which can't be correct, because if it
was, then packets sent to a MAC DA statically added as a bridge FDB entry
would be seen twice:

- once, autonomously forwarded by the switch
- twice, due to your claim that "packets are always directed to the CPU",
  (claim which must also hold with the current driver configuration,
  because the driver currently always enables flooding to the CPU)

But if that's the case, it means that the CPU (via the software bridge)
will send a second copy of the packet to the egress port, because
skb->offload_fwd_mark is unset. Someone would have noticed if that was
the case ?!

I have some skepticism towards this claim.

Please try to describe what happens under this scenario:

       br0
     /  |  \
    /   |   \
   /    |    \
 swp0  swp1  swp2
  |     |     |
  A     B     C

# On the switch
ip link add br0 type bridge vlan_filtering 1 && ip link set br0 up
ip link set swp0 master br0 && ip link set br0 up
ip link set swp1 master br0 && ip link set br0 up
ip link set swp2 master br0 && ip link set br0 up
bridge fdb add dev swp1 ${mac_of_B} vlan 1 master static

# On C
tcpdump -i eth0 -e -n

# On A
ping $B

How many ICMP requests do you see on B? How many do you see on C?
How many on the CPU port (br0)?

Correct answers should be:
On B: as many as were sent by A
On C: none
On br0: none on ingress (tcpdump -Q in), none on egress (tcpdump -Q out)

If you're seeing the ICMP requests on station C, see whether they don't
in fact come from br0 having flooded them in software, which means that
the real problem is with the FDB not matching on packets..

I have no idea how you've implemented things, but with reserved VIDs,
you also need to remap VID 0 during port_fdb_add() calls to the reserved
PVID of that bridge, and you've done that, otherwise packets won't match,
right?

> The switch tagger have a way to comunicate that the packet is flooded
> to the cpu.
> 
> With some code in the tagger I manage to reach this state from
> local_termination.sh
> 
> root@OpenWrt:~# /ktests/run_kselftest.sh -t drivers/net/dsa:local_termination.sh
> TAP version 13
> 1..1
> # selftests: drivers/net/dsa: local_termination.sh
> # TEST: lan1: Unicast IPv4 to primary MAC address                     [ OK ]
> # TEST: lan1: Unicast IPv4 to macvlan MAC address                     [ OK ]
> # TEST: lan1: Unicast IPv4 to unknown MAC address                     [ OK ]
> # TEST: lan1: Unicast IPv4 to unknown MAC address, promisc            [ OK ]
> # TEST: lan1: Unicast IPv4 to unknown MAC address, allmulti           [ OK ]
> # TEST: lan1: Multicast IPv4 to joined group                          [ OK ]
> # TEST: lan1: Multicast IPv4 to unknown group                         [ OK ]
> # TEST: lan1: Multicast IPv4 to unknown group, promisc                [ OK ]
> # TEST: lan1: Multicast IPv4 to unknown group, allmulti               [ OK ]
> # TEST: lan1: Multicast IPv6 to joined group                          [ OK ]
> # TEST: lan1: Multicast IPv6 to unknown group                         [ OK ]
> # TEST: lan1: Multicast IPv6 to unknown group, promisc                [ OK ]
> # TEST: lan1: Multicast IPv6 to unknown group, allmulti               [ OK ]
> # TEST: br0: Unicast IPv4 to primary MAC address                      [ OK ]
> # TEST: br0: Unicast IPv4 to macvlan MAC address                      [ OK ]
> # TEST: br0: Unicast IPv4 to unknown MAC address                      [FAIL]
> #       reception succeeded, but should have failed
> # TEST: br0: Unicast IPv4 to unknown MAC address, promisc             [ OK ]
> # TEST: br0: Unicast IPv4 to unknown MAC address, allmulti            [FAIL]
> #       reception succeeded, but should have failed
> # TEST: br0: Multicast IPv4 to joined group                           [ OK ]
> # TEST: br0: Multicast IPv4 to unknown group                          [FAIL]
> #       reception succeeded, but should have failed
> # TEST: br0: Multicast IPv4 to unknown group, promisc                 [ OK ]
> # TEST: br0: Multicast IPv4 to unknown group, allmulti                [ OK ]
> # TEST: br0: Multicast IPv6 to joined group                           [ OK ]
> # TEST: br0: Multicast IPv6 to unknown group                          [FAIL]
> #       reception succeeded, but should have failed
> # TEST: br0: Multicast IPv6 to unknown group, promisc                 [ OK ]
> # TEST: br0: Multicast IPv6 to unknown group, allmulti                [ OK ]
> not ok 1 selftests: drivers/net/dsa: local_termination.sh # exit=1
> 
> The tagger check if the packet type is a flood kind and drop the packet
> (return NULL) if the interface is not promisc or allmulti. If the port
> if bridge type this check is skipped...

Why is the check skipped if the port is under a bridge? Because there
might be foreign interfaces under that bridge (like wlan0) which might
be valid destinations for flooded traffic (through software forwarding)?

> My concern is... Is it ok to implement host_set_flood this way? I tried
> many variant and I wasn't able to make flood work by using those bits...
> 
> With the current implementation, host_set_flood will return always zero
> and everything will be handled in the tagger by dropping packet but I'm
> not sure it's ok to do it.

Well, we should first clarify exactly what it is that you claim to be a
hardware bug.
