Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C630673E677
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjFZRb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjFZRbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:31:13 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B444610D9;
        Mon, 26 Jun 2023 10:31:00 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f9189228bcso34032165e9.3;
        Mon, 26 Jun 2023 10:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687800659; x=1690392659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9I5CSQefAYnEheRCjIYTIX/i4V5d1nLcZ/eSXpElMnc=;
        b=Or6x3P7QwaFt9ue7ZCwKwCwdeiH3Inr9LofHbuMxRKcfD7CmFJao0sH2DHILpGUjO1
         QSh/TARpBCBjwYpuYZ1EK6BxCGPY8sHIvSDQIWlfOmhU8kdrw8vX+eGLyP7O6xv315aI
         xTr48AjawkIzE+sVKu9WOrGTuF7AIGLbEKpvtS0yD3mfJm5YpPbxGMEPcoBSpvj6R9tj
         4H/pzM9Cn6SRlFG/Ljw7ssHFatzLYYZCVnUYABgWp0nSyUEszerRA0/BfTg1G0yI1MSG
         xIAGKEvIbMTLSN5MKZTdi0tPcNqXP4naElCojT0Yv++svSJKf+KCuP0w6bzyP/0GXSw3
         DI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687800659; x=1690392659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9I5CSQefAYnEheRCjIYTIX/i4V5d1nLcZ/eSXpElMnc=;
        b=ijb65/SCoz7w+RZdvmP7P6a+MQL/tLaOHI59NNym9yyOULDcqvjbjCVspVToHpSxaU
         B8numdE5WBMENrl4aeQegcC/SEnhQG4Odwxr1N8t1AmzP1vmMnh7k0/KLQ/R1HV9AfC7
         YS7A9zq0IP72PTxwM8sksFFBJqdm305xAifD1YZo7iSiIoSHHHtKlL3nmnYweN75q6Lj
         EYGx8dlJF8M7GyFCNPmvajBTbVRMmVID1J3Vm8BMS2Z8aJgeYy+hdLRQvKOEX3orBsKx
         O2CVZucpAQ0B1ThB1guJxu49SAtLlu5sEhm3lYZOfJ65jAqr9hGisiiGWP123/1OTQdP
         wPZg==
X-Gm-Message-State: AC+VfDyWXl29WVDxrIYxCpZrGGrVPZ4Ufb1knBzEAcDI9yty+QrrJkNk
        R52jS8RiqHiP/gE2memYZrg=
X-Google-Smtp-Source: ACHHUZ7QziWk+bPjWhcFnR7b/abxuMbW7fTuc+nG+lDyC/B6fcQFaa0V7tIZwDJ5bpDF7k60X7NNcA==
X-Received: by 2002:a05:600c:b44:b0:3fa:82ae:3577 with SMTP id k4-20020a05600c0b4400b003fa82ae3577mr4986128wmr.9.1687800658728;
        Mon, 26 Jun 2023 10:30:58 -0700 (PDT)
Received: from skbuf ([188.25.159.134])
        by smtp.gmail.com with ESMTPSA id v14-20020a05600c214e00b003f7f60203ffsm11263229wml.25.2023.06.26.10.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 10:30:58 -0700 (PDT)
Date:   Mon, 26 Jun 2023 20:30:56 +0300
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
Message-ID: <20230626173056.zq77nilzrr5djns5@skbuf>
References: <20230623114005.9680-1-ansuelsmth@gmail.com>
 <20230623114005.9680-1-ansuelsmth@gmail.com>
 <20230625115803.6xykp4wiqqdwwzv4@skbuf>
 <6499c31c.df0a0220.e2acb.5549@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6499c31c.df0a0220.e2acb.5549@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 06:41:50PM +0200, Christian Marangi wrote:
> > Once that basic precondition passes, you should be able to start looking
> > at tools/testing/selftests/drivers/net/dsa/ and run those one by one.
> > An interesting one would be local_termination.sh, which monitors the way
> > in which frames reach the CPU. Though be aware that some sub-tests from
> > that suite will fail on misconfigurations that are non-fatal (and don't
> > impact functionality), just sub-optimal (affecting performance). Like
> > sending unknown packets to the CPU when the port is non-promiscuous and
> > software would drop those packets anyway.
> > 
> 
> Lots of difficult to run the selftests on a light fw but step at times
> I'm managing to make use of them (could be helpfull to add some comments
> in the .config saying that the testing port needs to be declared in the
> struct) (and maybe some additional checks on the kind of device type are
> required for the test to actually work (vrf, dummy, macvlan...)

Yeah, that doesn't sound like a bad idea at all. AFAIK,
tools/testing/selftests/net/forwarding/lib.sh doesn't check
"zcat /proc/config.gz" at all. Maybe it would be nice if it did, and to
guard that behavior based on some REQUIRE_* variables that are true by
default (but can be set to false by scripts).

> Anyway a run of local_termination.sh produce the following output.
> # selftests: drivers/net/dsa: local_termination.sh
> # TEST: lan1: Unicast IPv4 to primary MAC address                     [FAIL]
> #       reception failed

Hmm, so ping works but this doesn't? That's strange, because send_uc_ipv4()
also pings. Have you run with bash -x to see why it fails?

> # TEST: lan1: Unicast IPv4 to macvlan MAC address                     [FAIL]
> #       reception failed
> # TEST: lan1: Unicast IPv4 to unknown MAC address                     [ OK ]

So the only reason why this test passes is because in this case, the
unicast drops are okay?

> # TEST: lan1: Unicast IPv4 to unknown MAC address, promisc            [FAIL]
> #       reception failed
> # TEST: lan1: Unicast IPv4 to unknown MAC address, allmulti           [ OK ]

Similar here. Packet should have been dropped; the test detects a drop => okay.
Passes for the wrong reason, most likely, because this driver doesn't react
on IFF_PROMISC or IFF_ALLMULTI.

> # TEST: lan1: Multicast IPv4 to joined group                          [ OK ]
> # TEST: lan1: Multicast IPv4 to unknown group                         [FAIL]
> #       reception succeeded, but should have failed

"reception succeeded, but should have failed" is the okay kind of failure.
"reception failed" is what's bothering.

> # TEST: lan1: Multicast IPv4 to unknown group, promisc                [FAIL]
> #       reception failed
> # TEST: lan1: Multicast IPv4 to unknown group, allmulti               [ OK ]
> # TEST: lan1: Multicast IPv6 to joined group                          [ OK ]
> # TEST: lan1: Multicast IPv6 to unknown group                         [FAIL]
> #       reception succeeded, but should have failed
> # TEST: lan1: Multicast IPv6 to unknown group, promisc                [FAIL]
> #       reception failed

This I cannot explain. For the test right above, "Multicast IPv6 to unknown group",
it said that reception succeeded. This is sending the same packet, only
the IFF_PROMISC flag of the device changes (this is also propagated to
the DSA master). I've no idea why it fails. Again, bash -x will say more.

> # TEST: lan1: Multicast IPv6 to unknown group, allmulti               [ OK ]
> # TEST: br0: Unicast IPv4 to primary MAC address                      [FAIL]
> #       reception failed
> # TEST: br0: Unicast IPv4 to macvlan MAC address                      [FAIL]
> #       reception failed
> # TEST: br0: Unicast IPv4 to unknown MAC address                      [ OK ]
> # TEST: br0: Unicast IPv4 to unknown MAC address, promisc             [FAIL]
> #       reception failed
> # TEST: br0: Unicast IPv4 to unknown MAC address, allmulti            [ OK ]
> # TEST: br0: Multicast IPv4 to joined group                           [ OK ]
> # TEST: br0: Multicast IPv4 to unknown group                          [FAIL]
> #       reception succeeded, but should have failed
> # TEST: br0: Multicast IPv4 to unknown group, promisc                 [FAIL]
> #       reception failed
> # TEST: br0: Multicast IPv4 to unknown group, allmulti                [ OK ]
> # TEST: br0: Multicast IPv6 to joined group                           [ OK ]
> # TEST: br0: Multicast IPv6 to unknown group                          [FAIL]
> #       reception succeeded, but should have failed
> # TEST: br0: Multicast IPv6 to unknown group, promisc                 [FAIL]
> #       reception failed
> # TEST: br0: Multicast IPv6 to unknown group, allmulti                [ OK ]
> 
> Things doesn't look good to me or I am wrong?

Nope, doesn't look good at all. Looks like an incomplete setup.
