Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD89673E72D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 20:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjFZSH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 14:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjFZSHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:07:54 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F13E106;
        Mon, 26 Jun 2023 11:07:51 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-313f2a24cb6so1338681f8f.0;
        Mon, 26 Jun 2023 11:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687802870; x=1690394870;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YHaGiadj1/XOqlPkGLzbFu74E9MIGjrASNEgHQUgemo=;
        b=Uyl45V6m6U9YHt9wlOOlncRXWyaK4xPJJJfj7xGUG4TiROxIbdxbXkp5iggUC/+Cbc
         gLbPKV7Xf46HUBS2ythvz71UFSfNQQb3VA11KprCCUpVUQBkHhiOKC/xyrw3gDgF1Q2T
         pn1V7qpp6oQSO0ROYW4qRAyfGI0Wffd7e4fQq9j2vH0Wi4iAlDC3H+Lwl94ubElInhjb
         /Xh2AZb1i1kiFRkI1yZo2zwQQb751PJbtZg7pmP6F7BOMMajTs4JEgry7CR4EgjN/nki
         8UBBLGP1qfbKSeSqqAj1g6NqDR90hwmmXjxG0cNFjYijwqQq8em5OdxtFY9AmICjWCs5
         KMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687802870; x=1690394870;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHaGiadj1/XOqlPkGLzbFu74E9MIGjrASNEgHQUgemo=;
        b=lU5K18T5AB+vefoyhCz96f8ygzME1QWCccfbzXU6Z5uwm7uzY5RhDIRq43wysUyW30
         8hjkEsgnierl05Gxs5ePH3JqnCo3BnIzYViVmhYf21OchMlS2MrfmJufmBQn+IrFwTJP
         Eb0I3VQLdh5dEh/CBne0R2za1SdMOsW4eKYFSgaEFGkDp1ksKmVvJAdGN1p3TTnMrv53
         IBOu1IHM/vxMb3bAdVSAvRiLNTG+peD9smcUvJD6/ZGohIcJvbWfen+sn4Uq8gecoL59
         KzJLofvRkGcjWRrGBEabXLpakYRA/o5LlzrOMprVC3mYYxyHb06V//1lVqowC9+mi2hs
         PJNg==
X-Gm-Message-State: AC+VfDyOg7feEm4LF8sjWwtDwIT1iRaBs+hpqbT5D8PhJ6ytCdZBcxmi
        Hq+JENCMEVUKRRyWnvUQ5FQtrey7rWY=
X-Google-Smtp-Source: ACHHUZ4TcWrJ12AxgWebGI+qv9AS5Tpez5g8q3BKsXS9AGYRIvyNMU7eFTXDPc3jP1wfT0/T2rQ6zw==
X-Received: by 2002:a5d:424d:0:b0:313:f2c6:a4f1 with SMTP id s13-20020a5d424d000000b00313f2c6a4f1mr2521853wrr.36.1687802869493;
        Mon, 26 Jun 2023 11:07:49 -0700 (PDT)
Received: from Ansuel-xps. (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.gmail.com with ESMTPSA id cx16-20020a056000093000b00301a351a8d6sm8109818wrb.84.2023.06.26.11.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 11:07:49 -0700 (PDT)
Message-ID: <6499d3f5.050a0220.3becf.7296@mx.google.com>
X-Google-Original-Message-ID: <ZJnSDVCZO/xhySCe@Ansuel-xps.>
Date:   Mon, 26 Jun 2023 19:59:41 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Atin Bainada <hi@atinb.me>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH RFC] net: dsa: qca8k: make learning configurable
 and keep off if standalone
References: <20230623114005.9680-1-ansuelsmth@gmail.com>
 <20230623114005.9680-1-ansuelsmth@gmail.com>
 <20230625115803.6xykp4wiqqdwwzv4@skbuf>
 <6499c31c.df0a0220.e2acb.5549@mx.google.com>
 <20230626173056.zq77nilzrr5djns5@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626173056.zq77nilzrr5djns5@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 08:30:56PM +0300, Vladimir Oltean wrote:
> On Mon, Jun 26, 2023 at 06:41:50PM +0200, Christian Marangi wrote:
> > > Once that basic precondition passes, you should be able to start looking
> > > at tools/testing/selftests/drivers/net/dsa/ and run those one by one.
> > > An interesting one would be local_termination.sh, which monitors the way
> > > in which frames reach the CPU. Though be aware that some sub-tests from
> > > that suite will fail on misconfigurations that are non-fatal (and don't
> > > impact functionality), just sub-optimal (affecting performance). Like
> > > sending unknown packets to the CPU when the port is non-promiscuous and
> > > software would drop those packets anyway.
> > > 
> > 
> > Lots of difficult to run the selftests on a light fw but step at times
> > I'm managing to make use of them (could be helpfull to add some comments
> > in the .config saying that the testing port needs to be declared in the
> > struct) (and maybe some additional checks on the kind of device type are
> > required for the test to actually work (vrf, dummy, macvlan...)
> 
> Yeah, that doesn't sound like a bad idea at all. AFAIK,
> tools/testing/selftests/net/forwarding/lib.sh doesn't check
> "zcat /proc/config.gz" at all. Maybe it would be nice if it did, and to
> guard that behavior based on some REQUIRE_* variables that are true by
> default (but can be set to false by scripts).
>

Some thing can even be checked by simply creating an interface and see
if the thing gives error. I feel this is a better approach than checking
config and kflags since from what I can see the idea of these scripts is
to be system agnostic and sometimes it's handy to ""compile"" or package
these scripts on a different system than the target one (this is true
for every shell script and target specific stuff that needs to be
compiled is not the case)

> > Anyway a run of local_termination.sh produce the following output.
> > # selftests: drivers/net/dsa: local_termination.sh
> > # TEST: lan1: Unicast IPv4 to primary MAC address                     [FAIL]
> > #       reception failed
> 
> Hmm, so ping works but this doesn't? That's strange, because send_uc_ipv4()
> also pings. Have you run with bash -x to see why it fails?
> 

I just run with bash -x and I also mod the script to not delete the
tcpdump. Limiting the script to only this test the dump is just 2 ICMPv6
packet and no output from tcpdump aside from

tcpdump: listening on lan1, link-type EN10MB (Ethernet), snapshot length 65535 bytes
3 packets captured
5 packets received by filter
0 packets dropped by kernel

I feel like this is important so I think I should focus on understanding
why this doesn't work? Any clue?

> > # TEST: lan1: Unicast IPv4 to macvlan MAC address                     [FAIL]
> > #       reception failed
> > # TEST: lan1: Unicast IPv4 to unknown MAC address                     [ OK ]
> 
> So the only reason why this test passes is because in this case, the
> unicast drops are okay?
> 
> > # TEST: lan1: Unicast IPv4 to unknown MAC address, promisc            [FAIL]
> > #       reception failed
> > # TEST: lan1: Unicast IPv4 to unknown MAC address, allmulti           [ OK ]
> 
> Similar here. Packet should have been dropped; the test detects a drop => okay.
> Passes for the wrong reason, most likely, because this driver doesn't react
> on IFF_PROMISC or IFF_ALLMULTI.
> 
> > # TEST: lan1: Multicast IPv4 to joined group                          [ OK ]
> > # TEST: lan1: Multicast IPv4 to unknown group                         [FAIL]
> > #       reception succeeded, but should have failed
> 
> "reception succeeded, but should have failed" is the okay kind of failure.
> "reception failed" is what's bothering.
> 
> > # TEST: lan1: Multicast IPv4 to unknown group, promisc                [FAIL]
> > #       reception failed
> > # TEST: lan1: Multicast IPv4 to unknown group, allmulti               [ OK ]
> > # TEST: lan1: Multicast IPv6 to joined group                          [ OK ]
> > # TEST: lan1: Multicast IPv6 to unknown group                         [FAIL]
> > #       reception succeeded, but should have failed
> > # TEST: lan1: Multicast IPv6 to unknown group, promisc                [FAIL]
> > #       reception failed
> 
> This I cannot explain. For the test right above, "Multicast IPv6 to unknown group",
> it said that reception succeeded. This is sending the same packet, only
> the IFF_PROMISC flag of the device changes (this is also propagated to
> the DSA master). I've no idea why it fails. Again, bash -x will say more.
> 
> > # TEST: lan1: Multicast IPv6 to unknown group, allmulti               [ OK ]
> > # TEST: br0: Unicast IPv4 to primary MAC address                      [FAIL]
> > #       reception failed
> > # TEST: br0: Unicast IPv4 to macvlan MAC address                      [FAIL]
> > #       reception failed
> > # TEST: br0: Unicast IPv4 to unknown MAC address                      [ OK ]
> > # TEST: br0: Unicast IPv4 to unknown MAC address, promisc             [FAIL]
> > #       reception failed
> > # TEST: br0: Unicast IPv4 to unknown MAC address, allmulti            [ OK ]
> > # TEST: br0: Multicast IPv4 to joined group                           [ OK ]
> > # TEST: br0: Multicast IPv4 to unknown group                          [FAIL]
> > #       reception succeeded, but should have failed
> > # TEST: br0: Multicast IPv4 to unknown group, promisc                 [FAIL]
> > #       reception failed
> > # TEST: br0: Multicast IPv4 to unknown group, allmulti                [ OK ]
> > # TEST: br0: Multicast IPv6 to joined group                           [ OK ]
> > # TEST: br0: Multicast IPv6 to unknown group                          [FAIL]
> > #       reception succeeded, but should have failed
> > # TEST: br0: Multicast IPv6 to unknown group, promisc                 [FAIL]
> > #       reception failed
> > # TEST: br0: Multicast IPv6 to unknown group, allmulti                [ OK ]
> > 
> > Things doesn't look good to me or I am wrong?
> 
> Nope, doesn't look good at all. Looks like an incomplete setup.

-- 
	Ansuel
