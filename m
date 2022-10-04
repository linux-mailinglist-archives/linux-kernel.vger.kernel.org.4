Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728925F40B0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 12:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiJDKVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 06:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiJDKV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 06:21:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F19A2AC7D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 03:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664878884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6DyQbmeggw/WjvvTaQGOOOi3gQOlurk31neDeGCYZtg=;
        b=Wymoio9rAkL8G3m0sTYkKCZt9E3zapYnvMX/tYYW/YDw9pzlpcIriuB2P28Kj5+2eTbLvz
        gI7IjBEVFnTLt2PKlic2dvm6jSKGZzloHFvqGbcgrTBhPgjGzt9orSFxWU5PRrAxYawPSv
        aFlhH6rle4ntreATL3WJa8kp2Qsw/Uo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-321-y9q6JmjMM66xp2XGjsnqRw-1; Tue, 04 Oct 2022 06:21:23 -0400
X-MC-Unique: y9q6JmjMM66xp2XGjsnqRw-1
Received: by mail-wr1-f69.google.com with SMTP id g27-20020adfa49b000000b0022cd5476cc7so3899361wrb.17
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 03:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=6DyQbmeggw/WjvvTaQGOOOi3gQOlurk31neDeGCYZtg=;
        b=FnCAYbWEOziTrdQT7ZM6PAfOcyniFFBhPWGZs/dsMjrUjkVT+mpsxpY9tUj73L7oh5
         wEqpaMSz37A6PDbPCBYiXCv/u+h2E9DsthQwWCeOdbjPzmcvIPaRlbePvMUF6jBPiAO7
         KySEBnjCdvNrtXGrL0x/yYPGwxbB6WDn7yfVeVsKl5eDDwEJD4EdhVlUuGDswMPiupyL
         jTCd2Ki4Nj3etMdmfbHgUoIK6H+DEFnsMFcJEJ72BM2xMhUD9Tqx5Hypi5gDB2+enKPE
         dksfp5UlahrI5GbrEhx6bPYi9VmC+zLfuE8BCSSgl5w5QNTA4USLqb6bvoSYrV+ClgIp
         VNsw==
X-Gm-Message-State: ACrzQf1fzHjrrvBIk2/jTsnKyLTtzWB2POhby0izTPrhQhV32XXIfPMd
        YuDngdht+XM8JyqyuUhjJy8zuAB28yOGlgHx29avPFmmtY2X9z0hJqLM5+9uzNGVyMVRTCoEWcv
        a34fNEZxXntqscnGRxwEUX1S0
X-Received: by 2002:adf:dd8d:0:b0:22e:4675:86c9 with SMTP id x13-20020adfdd8d000000b0022e467586c9mr3775333wrl.643.1664878882130;
        Tue, 04 Oct 2022 03:21:22 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4ztfvE75JILEeMkHe/Pdkqe0YwCCAUyLBkJoDA7EOqWgOg4sfA05rXWfO9PEH4Wto4mV7jCw==
X-Received: by 2002:adf:dd8d:0:b0:22e:4675:86c9 with SMTP id x13-20020adfdd8d000000b0022e467586c9mr3775314wrl.643.1664878881869;
        Tue, 04 Oct 2022 03:21:21 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-97-71.dyn.eolo.it. [146.241.97.71])
        by smtp.gmail.com with ESMTPSA id k5-20020adff5c5000000b0022afbd02c69sm10076524wrp.56.2022.10.04.03.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 03:21:21 -0700 (PDT)
Message-ID: <122af5c891fcc65fb6179ec53a89374daa4600aa.camel@redhat.com>
Subject: Re: [PATCH RESEND v3 net 3/5] tcp/udp: Call inet6_destroy_sock() in
 IPv6 sk->sk_destruct().
From:   Paolo Abeni <pabeni@redhat.com>
To:     Kuniyuki Iwashima <kuniyu@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc:     Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        Vladislav Yasevich <vyasevic@redhat.com>
Date:   Tue, 04 Oct 2022 12:21:20 +0200
In-Reply-To: <20221003154425.49458-4-kuniyu@amazon.com>
References: <20221003154425.49458-1-kuniyu@amazon.com>
         <20221003154425.49458-4-kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, 2022-10-03 at 08:44 -0700, Kuniyuki Iwashima wrote:
[...]
> @@ -1723,7 +1736,7 @@ struct proto udpv6_prot = {
>  	.connect		= ip6_datagram_connect,
>  	.disconnect		= udp_disconnect,
>  	.ioctl			= udp_ioctl,
> -	.init			= udp_init_sock,
> +	.init			= udpv6_init_sock,
>  	.destroy		= udpv6_destroy_sock,
>  	.setsockopt		= udpv6_setsockopt,
>  	.getsockopt		= udpv6_getsockopt,

It looks like even UDPv6 lite can be ADDRFORMed to ipv4, so I guess we
need a similar chunk for udplitev6_prot? With that we can unexport 
udp_init_sock, I guess.

Thanks,

Paolo

