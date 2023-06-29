Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1571D7426A8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 14:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjF2MkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 08:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjF2MkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 08:40:00 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6BE2703;
        Thu, 29 Jun 2023 05:39:58 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51d9128494cso650258a12.0;
        Thu, 29 Jun 2023 05:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688042397; x=1690634397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J2dN9ob7taL9QJBcrRW7aI5yY4WSVFr5M8CFU6boTMc=;
        b=bEx9xe8urgBhJvk6/xso6ydfOKXKsRyPTw1OtVUfIelec+Mrbr87+yvHnE3/rV7tce
         4H8+nR1WQphr1upMTo23QKxxGnP5HYvVplw8oliKbjUlo0zR5cEVCqM2DE/0231zRDyU
         IJ/6+Tdr5oaAT6kBqYP+5HG1pWjF0NkEwyB9OOvy5l+bN82mzDGurNx6AoxsVrhqDAj0
         RDjLeRDCC0zPUfEHiszyPMjMIEqPiIAcsqNIXccvXYSa7akSOSBbT9V4lg2zr4yvixIl
         M4IxoqABAgPPnQ/ZGCJMm572GOqQOCRjNAwoev/ZhhIpkk8rtw1R/FlreL/PiRyuucgX
         UvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688042397; x=1690634397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2dN9ob7taL9QJBcrRW7aI5yY4WSVFr5M8CFU6boTMc=;
        b=YVaqB3+nT+PaJfyhPGMZRiqzSvAgt490I9ZZPPVwbQae9V+mgIJ51ZCdbH+djr58a/
         /4jrFlU9sqWIhcbXKjRFBSzWYGthMabnvXBF93leFGRulpWmnX35UZeDFeNk/4rPutek
         OKg6LAXgkUkwLrIFYdgj8b/tPUbQm4EvT7hG5Vm1OcgUT3Y+Zff7ailaUCMrANjBt2Gt
         Sk2axgu6ET0keFEbh5HFgHaV3MIElTXIASI1kv3lfzRgHhH7J/1aAwxjvZC3U5OY2d/8
         8PJqfugYAS5CA2VGLN+ncc2fTYT7yzfEAOg2+3JIJybIAGdxYz3BIioDdNbodUqc5mvQ
         femg==
X-Gm-Message-State: ABy/qLYJ1AcM6hS2n0sv/+UbDz2DUQikIr7EBKiaTgeAQhdiblbg3j1N
        xKfKcf+Du+5Fa7sa9G+66H8PNWr8eu6u1g==
X-Google-Smtp-Source: APBJJlFn60iOhe3tnKJrIoFSnPisOJQ86XhivWFwbznr8ZEq6RT5/udhZGjox/eDEOS27qMBsju9YA==
X-Received: by 2002:a05:6402:f25:b0:51d:d568:fa49 with SMTP id i37-20020a0564020f2500b0051dd568fa49mr2197263eda.12.1688042396762;
        Thu, 29 Jun 2023 05:39:56 -0700 (PDT)
Received: from skbuf ([188.25.159.134])
        by smtp.gmail.com with ESMTPSA id m5-20020aa7d345000000b0051495ce23absm5760387edr.10.2023.06.29.05.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 05:39:56 -0700 (PDT)
Date:   Thu, 29 Jun 2023 15:39:54 +0300
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
Message-ID: <20230629123954.jjcz2rfygwnxa6pq@skbuf>
References: <20230623114005.9680-1-ansuelsmth@gmail.com>
 <20230623114005.9680-1-ansuelsmth@gmail.com>
 <20230625115803.6xykp4wiqqdwwzv4@skbuf>
 <6499c31c.df0a0220.e2acb.5549@mx.google.com>
 <20230626173056.zq77nilzrr5djns5@skbuf>
 <6499d3f5.050a0220.3becf.7296@mx.google.com>
 <20230627094916.maywojwztzdek5y2@skbuf>
 <649c3931.df0a0220.136ab.2fb7@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <649c3931.df0a0220.136ab.2fb7@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 02:49:53AM +0200, Christian Marangi wrote:
> Hi, I wasted a day to only notice that the problem was in busybox not
> supporting 0.x value and that is what selfttest script use. Another
> thing to check. Also the confusing part of this is that we don't check
> if ping_do return error and the test just fails (while in reality the
> ping command was never executed)

Interesting. Not sure how you'll check for the specific busybox
implementation. Does it help if you add "check_err $?" after ping_do()
in send_uc_ipv4(), like ping_test() has?

> Anyway I'm fixing all kind of bugs and I even found an even hw
> limitation with the FDB table with mgmt packet...
> 
> Also I implemented fdb_insolation following the implementation done on
> felix with reserving VID at the end...
> About this I wonder if it might be a good idea to expose some generic
> API from DSA?
> 
> qca8k require a reserved VID for VLAN unaware port and with
> fdb_isolation even more VID are reserved. DSA have no idea about this so
> I wonder if there is a chance of VID clash? I feel like we need
> something to declare a range of reserved VID so that they gets rejected
> when applied. (about this I think I should return -EINVAL if fdb/mbd
> insert are asked with a reserved VID)

I don't think that it's possible to get a port_fdb_add() or port_mdb_add()
call for a VID that wasn't accepted through port_vlan_add() first.
At least I don't see how. The VLAN-aware FDB entries come from the
bridge through SWITCHDEV_OBJ_ID_PORT_VLAN and from DSA's private
.ndo_vlan_rx_add_vid() / .ndo_vlan_rx_kill_vid() implementations for
VLAN filters (those that land in dp->user_vlans; refresh your net.git
tree if you don't find those).

If we reject VLANs at those layers, then:
# through the bridge
[root@mox:~] # bridge fdb add 00:01:02:03:04:05 vlan 2000 dev lan21 master static
[ 7611.225227] bridge: RTM_NEWNEIGH with unconfigured vlan 2000 on lan21
RTNETLINK answers: Invalid argument
# bridge bypass, should go through ndo_fdb_add() if DSA had one
[root@mox:~] # bridge fdb add 00:01:02:03:04:05 vlan 2000 dev lan21 self static
[ 7855.532615] mv88e6085 d0032004.mdio-mii:12 lan21: default FDB implementation only supports local addresses
RTNETLINK answers: Invalid argument

So, while we could probably add some API in core DSA for a reserved VID
range, I'm not sure that it will be that useful.

And regarding whether there is a chance of VID class? I guess there is.
I have a board where the felix driver (reserved range 4000-4095) is a
DSA master for the sja1105 driver (reserved range 3072-4095 for tag_8021q).
Since any dsa_tag_8021q_port_setup() call does a vlan_vid_add() call
towards the master, then there's a chance that felix could reject the
tag_8021q setup of the sja1105 ports for tag_8021q VIDs 4000 and upwards.

VID 4000 = 0xfa0 = bitwise 0b1111_1010_0000

Comparing with net/dsa/tag_8021q.c:

 * | 11  | 10  |  9  |  8  |  7  |  6  |  5  |  4  |  3  |  2  |  1  |  0  |
 * +-----------+-----+-----------------+-----------+-----------------------+
 * |    RSV    | VBID|    SWITCH_ID    |   VBID    |          PORT         |
 * +-----------+-----+-----------------+-----------+-----------------------+

So it would be problematic for VBID >= 6, whenever SWITCH_ID >= 6.
However, practical applications of tag_8021q with the sja1105 boards
that I'm aware of do not have 7 switches, so it's a theoretical problem
only.

Though we would need to be rather careful when calculating and enforcing
the reserved ranges in the DSA core, to not cause false positive errors.

> 
> Anyway by fixing that interval problem (enabling support in busybox as
> it's disabled by default in a OpenWRT system)
> This is the new output of the local_termination.sh 
> 
> TAP version 13
> 1..1
> # selftests: drivers/net/dsa: local_termination.sh
> # TEST: lan1: Unicast IPv4 to primary MAC address                     [ OK ]
> # TEST: lan1: Unicast IPv4 to macvlan MAC address                     [ OK ]
> # TEST: lan1: Unicast IPv4 to unknown MAC address                     [FAIL]
> #       reception succeeded, but should have failed
> # TEST: lan1: Unicast IPv4 to unknown MAC address, promisc            [ OK ]
> # TEST: lan1: Unicast IPv4 to unknown MAC address, allmulti           [FAIL]
> #       reception succeeded, but should have failed
> # TEST: lan1: Multicast IPv4 to joined group                          [ OK ]
> # TEST: lan1: Multicast IPv4 to unknown group                         [FAIL]
> #       reception succeeded, but should have failed
> # TEST: lan1: Multicast IPv4 to unknown group, promisc                [ OK ]
> # TEST: lan1: Multicast IPv4 to unknown group, allmulti               [ OK ]
> # TEST: lan1: Multicast IPv6 to joined group                          [ OK ]
> # TEST: lan1: Multicast IPv6 to unknown group                         [FAIL]
> #       reception succeeded, but should have failed
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
> Seems good aside from the reception secceeded that I think the kernel
> just drops right?

Looks good. If you've implemented FDB isolation, then it means that you
get port_fdb_add() and port_mdb_add() calls on the CPU port(s), and you
can now also implement .port_set_host_flood() and that should also make
the following tests pass:

* TEST: lan1: Unicast IPv4 to unknown MAC address                     [FAIL]
* TEST: lan1: Unicast IPv4 to unknown MAC address, allmulti           [FAIL]
* TEST: lan1: Multicast IPv4 to unknown group                         [FAIL]
* TEST: lan1: Multicast IPv6 to unknown group                         [FAIL]

The bridge tests to an unknown address will always fail with the message
"reception succeeded, but should have failed", so it's not you, it's the
test there.

Once you're there, you can re-do these tests with:
- all user ports to CPU port 0
- all user ports to CPU port 6
- user ports statically split between CPU ports 0 and 6
- all user ports to LAG composed of CPU ports 0 and 6

> The switch have a way to control FLOOD per port but maybe the correct
> feature to use is the VLAN leaky? Where the setting can be set by both
> FDB/MBD and per port.

I'm not sure why would the leaky VLAN feature be useful ("enable
specific frames to be forwarded across VLAN boundary"). I really don't
know what you're thinking about.

> Sorry if I described some fix and implementation without proposing the
> patch but I would like some comments on what the tool returned.
> 
> -- 
> 	Ansuel
