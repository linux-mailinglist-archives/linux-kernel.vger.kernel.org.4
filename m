Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B3A74D958
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbjGJOyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjGJOyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:54:19 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8DEC4;
        Mon, 10 Jul 2023 07:54:18 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbf1b82d9cso48273525e9.2;
        Mon, 10 Jul 2023 07:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689000857; x=1691592857;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvcwHkM7LCO7a024nl7ZUkA0CE5fAJDEqmEoltxDZF8=;
        b=G/qarMcW7fFBzgrDu5zSH8J7IilZkk0efzZgM3OS6gXKXTkj/EzjCMgNYO4z9LhzvP
         zIOdCVpWQxm+gG8mknm1k5ohFJ8fmzqE3p2tON72cH88LPR1BWwspGYCgCtG1izi8fnq
         dXsXPhtiB5OWJ51DPRKUyfYd8cQH1Crr51CYDJBqjwnj+E3DmTFdTYW/YFqXfWsV/Fq1
         yR+S7ZJnqTa8ExenmTLYyjq88/huzG5Au/pxN6VBR7TBq1HkXMwIMT2sKlzxoals2B/W
         NY96aBaHGSckwIzfiAfLWu8OV1V8vYBT7S6Gxzpx2Ys3IPHqo0mg2TdBHa7xBYkRpleb
         A+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689000857; x=1691592857;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvcwHkM7LCO7a024nl7ZUkA0CE5fAJDEqmEoltxDZF8=;
        b=U3gaejIkFpWIaFlxZjXnGzyEfDayvmeyjnojJ98u9LJqMcrEHOYyVsWOXou/J93oqz
         5O2lwQbwJy+S7U2rqjVAv5x4aHrkLY7uNgh51NVSixYmgeynysV42ybK6uwnkVDYwctZ
         5bT4dJNmt4zo0P7Z5TEVl9N2plOir6+t5UlE1y4Hs5Bt4niJ6a08wqFFyzs2FeobIeRF
         fheeaQb5i1p1C2OcaNOrSjWNz2xeKeX03ZGGaKAktLGBEMWz20RcVrx8qQbMP6qOsgV2
         QRTvZCdbfcebt9wptbN89UMY165DXqzTTV+uXiCmv/bzZj211sDVG62M5KxhSazqEV5s
         IHVg==
X-Gm-Message-State: ABy/qLYwiw+BNNSzU73m5H5JYgQWWfDKPhAGC0zZlj77kYrk0FejJIch
        ByNVroYqk/2qvIe9Hxmvoec=
X-Google-Smtp-Source: APBJJlEo2lYuWjQRxe6vAZ11uL6QOzP/K/X4bUawUM2P4R5WwY/eGCznfd28+zuEnX1TtriUzrqhNQ==
X-Received: by 2002:a05:600c:c8:b0:3fb:b05d:f27c with SMTP id u8-20020a05600c00c800b003fbb05df27cmr10986477wmm.34.1689000856477;
        Mon, 10 Jul 2023 07:54:16 -0700 (PDT)
Received: from debian ([89.238.191.199])
        by smtp.gmail.com with ESMTPSA id l22-20020a7bc456000000b003fbb5142c4bsm10509928wmi.18.2023.07.10.07.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 07:54:16 -0700 (PDT)
Date:   Mon, 10 Jul 2023 16:54:05 +0200
From:   Richard Gobert <richardbgobert@gmail.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        willemdebruijn.kernel@gmail.com, dsahern@kernel.org,
        tom@herbertland.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, gal@nvidia.com
Subject: Re: [PATCH 1/1] net: gro: fix misuse of CB in udp socket lookup
Message-ID: <20230710145403.GA22009@debian>
References: <20230707121650.GA17677@debian>
 <20230707122627.GA17845@debian>
 <CANn89i+gm=0J3aR_9ikhroQmAvuQ+-dPMH1em9WrmE1o1pfi7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89i+gm=0J3aR_9ikhroQmAvuQ+-dPMH1em9WrmE1o1pfi7w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I will send a v2 with the fixes.

> ipv6_rcv() inits
> 
> IP6CB(skb)->iif = skb_dst(skb) ?
> ip6_dst_idev(skb_dst(skb))->dev->ifindex : dev->ifindex;
> 
> You chose to always use skb->dev->ifindex instead ?
> 
> You might add a comment why it is okay.

It looks like this assignment ("ip6_dst_idev(skb_dst(skb))->dev->ifindex")
is relevant only in case of sending traffic on loopback.
It does not seem relevant in GRO stack.
That is why I chose to use only the `skb->dev->ifindex` part.
Do you think that's correct?
