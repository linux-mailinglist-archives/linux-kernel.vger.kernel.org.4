Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067AF743F11
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjF3PkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbjF3PkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:40:00 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5459E35B6;
        Fri, 30 Jun 2023 08:39:58 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3141f73568fso1358764f8f.3;
        Fri, 30 Jun 2023 08:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688139597; x=1690731597;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zelhy/gt7pwBblQXR4evHMJQvQg1vl9VCgYUOn1TY0M=;
        b=H8nY0xLWWBYOPVqA5dZhoxr/UWxwDJtj7dIhUGfWr/nj5nn7fQJYrw9b/5290MaILn
         rzfoCt5Xceg/tZu3VHf1iqiq//cl2a0dbRSCZNUKwpx9VOzN4o6/f+2ysKwBzrkbz78g
         5P6uf7ovXThI+yCLTUoREyIG3j+CL8gDonCeQi7ccTnFPN/fhfMZoiR+8tuZ5w93r2nj
         XCHwHeRuwfw93McEO/i6jViwVgm8TiZPzLOG+uXC252pESyoYRHi08Fs3tM/NDZbJ3Mx
         d7nAQME5GQrRk5opNoP6hZPTvlG52VwMCKfoejEQeMCXm/gCv3kap3WRi7WiMopMhqfg
         5L/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688139597; x=1690731597;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zelhy/gt7pwBblQXR4evHMJQvQg1vl9VCgYUOn1TY0M=;
        b=RL5IBiY0CUM5TOmXTIQWAMhFWq5JmCxxF+yLQ8VA8IxXiIksdLKYIkidxSSWAHXdnP
         3C09vicmi1ldvYqRHQwr/cvruld5IQAGNlXj9DP3Q5+V/0Go0EPyb7pT9a2WKSzx8kQx
         Pwzy5TCFj6RG/RHESAmhgGVHe9s3srt9wXy2VbPka0dkyvcTg3qMUc7EkBNmwcexjin4
         CPWJ/eB9hXbuHNgyjMpA0cyv/Z2LFLfPRRsdar/PwpxJXuYwmDfnr6FcbXavH4xkJRG2
         Ue+dGadvweFwikrd/j++/wuSdskSN6yXo3YqTgyOO6z6CNe0uZ/0xZ6wdyGLgETchGY5
         +2cA==
X-Gm-Message-State: ABy/qLYjJehlEMZHf56411ajXCK86kBh6y81b2A5vd9IiENr9s8LHTn6
        cL4PYt7i/d/WJvNSdVzb2Is=
X-Google-Smtp-Source: APBJJlG41YF2WG6CuLfS1FEDxOFJqw7H36zIrSg51Ez7HmfdddQXaIGlAAD5sVrInLLsWc3PF1ukOQ==
X-Received: by 2002:adf:ef0c:0:b0:314:1de3:f9e0 with SMTP id e12-20020adfef0c000000b003141de3f9e0mr2810660wro.12.1688139596460;
        Fri, 30 Jun 2023 08:39:56 -0700 (PDT)
Received: from debian ([89.238.191.199])
        by smtp.gmail.com with ESMTPSA id p20-20020a1c7414000000b003fa973e6612sm14193822wmc.44.2023.06.30.08.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 08:39:56 -0700 (PDT)
Date:   Fri, 30 Jun 2023 17:39:25 +0200
From:   Richard Gobert <richardbgobert@gmail.com>
To:     Gal Pressman <gal@nvidia.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, aleksander.lobakin@intel.com,
        lixiaoyan@google.com, lucien.xin@gmail.com, alexanderduyck@fb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] gro: decrease size of CB
Message-ID: <20230630153923.GA18237@debian>
References: <20230601160924.GA9194@debian>
 <20230601161407.GA9253@debian>
 <f83d79d6-f8d7-a229-941a-7d7427975160@nvidia.com>
 <20230629123559.GA12573@debian>
 <431d8445-9593-73df-d431-d5e76c9085cf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431d8445-9593-73df-d431-d5e76c9085cf@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't been able to reproduce it yet, I tried two different setups:
    - 2 VMs running locally on my PC, and a geneve interface for each. Over
      these geneve interfaces, I sent tcp traffic with a similar iperf
      command as yours.
    - A geneve tunnel over veth peers inside two separate namespaces as
      David suggested.

The throughput looked fine and identical with and without my patch in both
setups.

Although I did validate it while working on the patch, a problem may arise
from:
    - Packing CB members into a union, which could've led to some sort of
      corruption.
    - Calling `gro_pull_from_frag0` on the current skb before inserting it
      into `gro_list`.

Could I ask you to run some tests:
    - Running the script I attached here on one machine and checking whether
      it reproduces the problem. 
    - Reverting part of my commit: 
        - Reverting the change to CB struct while keeping the changes to
          `gro_pull_from_frag0`.
        - Checking whether the regression remains.

Also, could you give me some more details:
    - The VMs' NIC and driver. Are you using Qemu? 
    - iperf results.
    - The exact kernel versions (commit hashes) you are using.
    - Did you run the commands (sysctl/ethtool) on the receiving VM?


Here are the commands I used for the namespaces test's setup:
```
ip netns add ns1

ip link add veth0 type veth peer name veth1
ip link set veth1 netns ns1

ip a add 192.168.1.1/32 dev veth0
ip link set veth0 up
ip r add 192.168.1.0/24 dev veth0

ip netns exec ns1 ip a add 192.168.1.2/32 dev veth1
ip netns exec ns1 ip link set veth1 up
ip netns exec ns1 ip r add 192.168.1.0/24 dev veth1

ip link add name gnv0 type geneve id 1000 remote 192.168.1.2
ip a add 10.0.0.1/32 dev gnv0
ip link set gnv0 up
ip r add 10.0.1.1/32 dev gnv0

ip netns exec ns1 ip link add name gnv0 type geneve id 1000 remote 192.168.1.1
ip netns exec ns1 ip a add 10.0.1.1/32 dev gnv0
ip netns exec ns1 ip link set gnv0 up
ip netns exec ns1 ip r add 10.0.0.1/32 dev gnv0

ethtool -K veth0 generic-receive-offload off
ip netns exec ns1 ethtool -K veth1 generic-receive-offload off

# quick way to enable gro on veth devices
ethtool -K veth0 tcp-segmentation-offload off
ip netns exec ns1 ethtool -K veth1 tcp-segmentation-offload off
```

I'll continue looking into it on Monday. It would be great if someone from
your team can write a test that reproduces this issue.

Thanks.
