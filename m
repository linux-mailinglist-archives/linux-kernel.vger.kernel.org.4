Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D70633197
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 01:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiKVAtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 19:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKVAtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 19:49:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5943C4044E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 16:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669078102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N1lAtUfxSqu18fCCviIv82tE3o1gDbqJA8/vG7g+Iw4=;
        b=fV8oVXJGP6oqARRZuegRWolSddoyeiVgrf52YY6RDS4NwWq/PvSxKcSDVGPIuu+Lghrgab
        +AU6tPpB4LnGjK2gJxHnnOy7aGxzp28V8JCZ+IBB1emogU55J6OToIvg/buEuZuPS5mZkY
        RWq3jOvqoHkgdJGj3tSgsPNoMLoZUGs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-206-CbXC_njNOPmEDQHDSg2_7A-1; Mon, 21 Nov 2022 19:48:20 -0500
X-MC-Unique: CbXC_njNOPmEDQHDSg2_7A-1
Received: by mail-qk1-f199.google.com with SMTP id bk30-20020a05620a1a1e00b006fb2378c857so17405185qkb.18
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 16:48:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N1lAtUfxSqu18fCCviIv82tE3o1gDbqJA8/vG7g+Iw4=;
        b=xWSc5KDkpXtatXCFtjjB2qd0QPjAC1YdUj3RuCcpoq8Zn63OnZqffRXDi82Rt15j3t
         eG/tVxUeF7t/S8aBgAF2EtV0kwE2i2MAWpKgAxkD9/Wg4SWr6YvbSaqyL1WGE8psAUHT
         xE79RsSL4vRaBuRrK+QRyP4o6xndV9xNTynOfFIZKQPJXuKdVUs8lX1REj9IzmvzTLly
         BQQPiniF3CDRYgY//Q0Mk9rmfYjdxfMQUbVBdLg1BJ7kukBAV/yN3Bm+R1zQe7qX1mDG
         PlnfnoYgFAHUpw+RLBnTgGMOOAOFJoGAqc/6vH+41QoZXBYRC8ihg8cWLQ+Cop4h7cNT
         ZLfg==
X-Gm-Message-State: ANoB5pmsSYm+rdIEXCSJ0S5vUjXf9MwMnv6iBWF4fHDQjdo8VDMjSImG
        BoSyG6MtvEBLbCnN2rk9Q/04706gXp7keClsZfyxZb5kI0uwAcdbYQ524BlkUvdlP/qPeN/Om/y
        X6KciYa1dDKhMhKecZHI5kDk4
X-Received: by 2002:a05:620a:8086:b0:6fa:7b74:1cc1 with SMTP id ef6-20020a05620a808600b006fa7b741cc1mr3318047qkb.144.1669078099765;
        Mon, 21 Nov 2022 16:48:19 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6qV3cnbP4oy61ujmZe64y9rbsAHEhhDhutJO9GEtcu+pUoCPG21F4vHc1eu9t0SH3F6onHJA==
X-Received: by 2002:a05:620a:8086:b0:6fa:7b74:1cc1 with SMTP id ef6-20020a05620a808600b006fa7b741cc1mr3318008qkb.144.1669078099482;
        Mon, 21 Nov 2022 16:48:19 -0800 (PST)
Received: from [10.0.0.96] ([24.225.241.171])
        by smtp.gmail.com with ESMTPSA id t18-20020a05620a451200b006fafc111b12sm9466619qkp.83.2022.11.21.16.48.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 16:48:19 -0800 (PST)
Message-ID: <9c813d3e-96f9-218b-94a7-a5e47615d617@redhat.com>
Date:   Mon, 21 Nov 2022 19:48:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH net] tipc: check skb_linearize() return value in
 tipc_disc_rcv()
Content-Language: en-US
To:     YueHaibing <yuehaibing@huawei.com>, ying.xue@windriver.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221119072832.7896-1-yuehaibing@huawei.com>
From:   Jon Maloy <jmaloy@redhat.com>
In-Reply-To: <20221119072832.7896-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/19/22 02:28, YueHaibing wrote:
> If skb_linearize() fails in tipc_disc_rcv(), we need to free the skb instead of
> handle it.
>
> Fixes: 25b0b9c4e835 ("tipc: handle collisions of 32-bit node address hash values")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   net/tipc/discover.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/tipc/discover.c b/net/tipc/discover.c
> index e8630707901e..e8dcdf267c0c 100644
> --- a/net/tipc/discover.c
> +++ b/net/tipc/discover.c
> @@ -211,7 +211,10 @@ void tipc_disc_rcv(struct net *net, struct sk_buff *skb,
>   	u32 self;
>   	int err;
>   
> -	skb_linearize(skb);
> +	if (skb_linearize(skb)) {
> +		kfree_skb(skb);
> +		return;
> +	}
>   	hdr = buf_msg(skb);
>   
>   	if (caps & TIPC_NODE_ID128)
Acked-by: Jon Maloy <jmaloy@redhat.com>

