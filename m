Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBA7611FEA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 06:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJ2EIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 00:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiJ2EIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 00:08:06 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057371D52D9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 21:08:05 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id o70so8174875yba.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 21:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=57jT6t9LVUQL8F7u3aUIh05FI0bzfei+aamYGlF6GLk=;
        b=Ccb/clKCM4nY15aAxCsOLWHXbpR1FU3Yd+GPcXUDPBhwA0udyOeTue5L3csoLAZrlw
         23D6dWhhXJwUI4m8uE8HoulwusEX4VEg69eMwR7RBfwhBvGtEppNyLJZNb0zBExQBI6p
         XkyCIWxxtEOSkMiLCfQbKhl7eM/Wngq+xpHGEnXUvEctyeypP8rcL6To6+IbmwkMjMl+
         OkjgIcHw92h3TU4StZ6lhufTGkQniV45mzs+ZN7vJr8Lsm2clNT7BpCTjdgqV7jekz4C
         lMXQl3/mA/eopcKkr9ONzuFMnGySKoZeOu4jsoVENY0qt5tl6+82vbf+8dDD1ihmbNLC
         W0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57jT6t9LVUQL8F7u3aUIh05FI0bzfei+aamYGlF6GLk=;
        b=FpDNXC2pXCvSaqootv9WXgoiOxyK2YgTIwyMAsJa0m9+UhxN1oqJbVJBmgdqSsUQ4L
         TBcKemaxbfuacZWje3A92wD67mBtu2OkNTsvFgJYYD5trNpxS/1H6ylVEP5ae8uvNyIT
         36Gtc/bTlGkoudEYKR0Vc+Xa6o8OVcmtpuVIP6i1/4iK/i7PqpXCH3hzX5cqxBVxHxjw
         bpaneBRGhf+i/m2FfcT3ltWCUoLdd/xAaDhIwAFhJcVZVmhzvxk+4m3ImMRdwN1LIKDz
         Of3AFIYqplW0l5lKHosneCRFUn+jP9xluHrcObX/Szc2OENig55En5fPqs93a93ATrwu
         5g2A==
X-Gm-Message-State: ACrzQf0aYKpbug6OFkXRl0Q6ODXLIGcaurZWmdfS3HJDYchCPrPCLy9Y
        2M44nqO/svDM0uJekTnuS1fNrGDsnhPR88LVvxertVd8pMPxkg==
X-Google-Smtp-Source: AMsMyM6r6emOlEEGYPVTlw+PT5Y3MAL9OB5+yrLl2f2Ip/XHTJU0Eq0IsSgGw0oBJjPCU78WHPbArGAKNjt6i76K6f4=
X-Received: by 2002:a25:d914:0:b0:6cb:13e2:a8cb with SMTP id
 q20-20020a25d914000000b006cb13e2a8cbmr2340796ybg.231.1667016483960; Fri, 28
 Oct 2022 21:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221029033243.1577015-1-william.xuanziyang@huawei.com>
In-Reply-To: <20221029033243.1577015-1-william.xuanziyang@huawei.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 28 Oct 2022 21:07:52 -0700
Message-ID: <CANn89iLUMSHPZw0qNPxfoy3=Ao5JsRB8721L40YO48x9PDjWvQ@mail.gmail.com>
Subject: Re: [PATCH net] net: tun: fix bugs for oversize packet when napi
 frags enabled
To:     Ziyang Xuan <william.xuanziyang@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterpenkov96@gmail.com, maheshb@google.com, ast@kernel.org,
        daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 8:32 PM Ziyang Xuan
<william.xuanziyang@huawei.com> wrote:
>
> Recently, we got two syzkaller problems because of oversize packet
> when napi frags enabled.
>
> One of the problems is because the first seg size of the iov_iter
> from user space is very big, it is 2147479538 which is bigger than
> the threshold value for bail out early in __alloc_pages(). And
> skb->pfmemalloc is true, __kmalloc_reserve() would use pfmemalloc
> reserves without __GFP_NOWARN flag. Thus we got a warning as following:
>
> ========================================================
>

> Restrict the packet size less than ETH_MAX_MTU to fix the problems.
> Add len check in tun_napi_alloc_frags() simply. Athough that makes
> some kinds of packets payload size slightly smaller than the length
> allowed by the protocol, for example, ETH_HLEN + sizeof(struct ipv6hdr)
> smaller when the tun device type is IFF_TAP and the packet is IPv6. But
> I think that the effect is small and can be ignored.

I am not sure about ETH_MAX_MTU being completely safe.

napi_get_frags() / napi_alloc_skb() is reserving NET_SKB_PAD +
NET_IP_ALIGN bytes.

transport_header being an offset from skb->head,
we probably want to use (ETH_MAX_MTU - NET_SKB_PAD - NET_IP_ALIGN)

My objection to your initial patch was that you were using PAGE_SIZE,
while Ethernet MTU can easily be ~9000

But 0xFFFF is a bit too much/risky.

Thanks.

>
> Fixes: 90e33d459407 ("tun: enable napi_gro_frags() for TUN/TAP driver")
> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
> ---
>  drivers/net/tun.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 27c6d235cbda..98d3160fcae2 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1459,7 +1459,7 @@ static struct sk_buff *tun_napi_alloc_frags(struct tun_file *tfile,
>         int err;
>         int i;
>
> -       if (it->nr_segs > MAX_SKB_FRAGS + 1)
> +       if (it->nr_segs > MAX_SKB_FRAGS + 1 || len > ETH_MAX_MTU)
>                 return ERR_PTR(-EMSGSIZE);
>
>         local_bh_disable();
> --
> 2.25.1
>
