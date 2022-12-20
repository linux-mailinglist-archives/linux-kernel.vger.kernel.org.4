Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023E9652152
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 14:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiLTNRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 08:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiLTNRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 08:17:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950AA12607
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 05:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671542176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DS9J7lgOk15cDqTwjWfeKKD/FSaeCVKaKczagIUj+Pc=;
        b=AhHMwURA/zaWBJoCnFg8k5nLs5m6taFw+hXUucNSyscUs5FIlFx6F7J9kwuxMN3K5OULJs
        QOPZAxg1VOZtSQRx4DTGrm1ziphJ2SG5CjSY6cD/JDWqiJt4JzgX0MglPLskZTjg073wMg
        pf93rAAxTxZzohpMz+ROTNfR6Yk1Sqg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-594-3m7qY3vWNzO958gmP8x2eg-1; Tue, 20 Dec 2022 08:16:15 -0500
X-MC-Unique: 3m7qY3vWNzO958gmP8x2eg-1
Received: by mail-wm1-f69.google.com with SMTP id j2-20020a05600c1c0200b003cf7397fc9bso6549129wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 05:16:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DS9J7lgOk15cDqTwjWfeKKD/FSaeCVKaKczagIUj+Pc=;
        b=0MMjY0LQ9Zgv2ESDtPDX1ntzHYhW9qNMjOEslFfHZE7iUXi/h8egfyObyTn+pLpqpM
         FxatIOl/hKDZDFdMgECVqYx7qNW4vKSHWN5cNKshn6lLn+ZHx5Ff374QRQDoc+VnhIR5
         n9Elg8RlvEDfbRsF6HnFMUSRQc+uweKCh+3ULqwkK17RVIEnFtcjYdpSTuCG3AM8HUNA
         hkd5qM30ZCeIlwS/Y/v0GFMbsIXqhRp1d13h1SJtnqPlxy42BQ6Csobp4hs3Y3vQCtjI
         VdpuuZT8H6/QB8G8zxiX5d5zKEUCpIGYn1ctny2pfW5ayGaebSbePfFa4JbNm6x50X5P
         eaQQ==
X-Gm-Message-State: AFqh2krSM7bB7xOjmpM7Z1dXPzcZN1eNf+QL6DKOglRh9pndHMADmHTX
        W1yQP6qwHmWg3cyBUOZ9xSyxhIMaybTwoKeNRqiUxGDGcS+zzViO1ZtpxvxjDckyRJFync9jUCd
        UiUKTcv5yDUE+Y8y7NKi4BdFY
X-Received: by 2002:a05:600c:3d1b:b0:3cf:497c:c59e with SMTP id bh27-20020a05600c3d1b00b003cf497cc59emr1607033wmb.6.1671542174201;
        Tue, 20 Dec 2022 05:16:14 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvGHB0Vm0N+GWclP9xoL00JzHm/gVmyEhL8QABmZbBqz9VMfRNIecyUqwbLPH2ZQv6KIPjUqg==
X-Received: by 2002:a05:600c:3d1b:b0:3cf:497c:c59e with SMTP id bh27-20020a05600c3d1b00b003cf497cc59emr1607018wmb.6.1671542173947;
        Tue, 20 Dec 2022 05:16:13 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-101-173.dyn.eolo.it. [146.241.101.173])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c3b8700b003b492753826sm17549353wms.43.2022.12.20.05.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 05:16:13 -0800 (PST)
Message-ID: <2264ca933c234539774d9ae1d1de5a27dd1c12ae.camel@redhat.com>
Subject: Re: [PATCH 1/2] ip/ip6_gre: Fix changing addr gen mode not
 generating IPv6 link local address
From:   Paolo Abeni <pabeni@redhat.com>
To:     Thomas Winter <Thomas.Winter@alliedtelesis.co.nz>,
        davem@davemloft.net, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        kuba@kernel.org, a@unstable.cc, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 20 Dec 2022 14:16:11 +0100
In-Reply-To: <20221219010619.1826599-2-Thomas.Winter@alliedtelesis.co.nz>
References: <20221219010619.1826599-1-Thomas.Winter@alliedtelesis.co.nz>
         <20221219010619.1826599-2-Thomas.Winter@alliedtelesis.co.nz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-12-19 at 14:06 +1300, Thomas Winter wrote:
> Commit e5dd729460ca changed the code path so that GRE tunnels
> generate an IPv6 address based on the tunnel source address.
> It also changed the code path so GRE tunnels don't call addrconf_addr_gen
> in addrconf_dev_config which is called by addrconf_sysctl_addr_gen_mode
> when the IN6_ADDR_GEN_MODE is changed.
> 
> This patch aims to fix this issue by moving the code in addrconf_notify
> which calls the addr gen for GRE and SIT into a separate function
> and calling it in the places that expect the IPv6 address to be
> generated.
> 
> The previous addrconf_dev_config is renamed to addrconf_eth_config
> since it only expected eth type interfaces and follows the
> addrconf_gre/sit_config format.
> 
> Fixes: e5dd729460ca ("ip/ip6_gre: use the same logic as SIT interfaces when computing v6LL address")
> Signed-off-by: Thomas Winter <Thomas.Winter@alliedtelesis.co.nz>
> ---
>  net/ipv6/addrconf.c | 47 +++++++++++++++++++++++++--------------------
>  1 file changed, 26 insertions(+), 21 deletions(-)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 6dcf034835ec..e9d7ec03316d 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -3355,7 +3355,7 @@ static void addrconf_addr_gen(struct inet6_dev *idev, bool prefix_route)
>  	}
>  }
>  
> -static void addrconf_dev_config(struct net_device *dev)
> +static void addrconf_eth_config(struct net_device *dev)

You are creating a new function with the name of an existing one, while
renaming the latter. IMHO this makes the patch hard to review as there
are some existing call side for the old name, which we likelly want to
explicitly see here.

>  {
>  	struct inet6_dev *idev;
>  
> @@ -3447,6 +3447,30 @@ static void addrconf_gre_config(struct net_device *dev)
>  }
>  #endif
>  
> +static void addrconf_dev_config(struct net_device *dev)
> +{
> +	switch (dev->type) {
> +#if IS_ENABLED(CONFIG_IPV6_SIT)
> +	case ARPHRD_SIT:
> +		addrconf_sit_config(dev);
> +		break;
> +#endif
> +#if IS_ENABLED(CONFIG_NET_IPGRE) || IS_ENABLED(CONFIG_IPV6_GRE)
> +	case ARPHRD_IP6GRE:
> +	case ARPHRD_IPGRE:
> +		addrconf_gre_config(dev);
> +		break;
> +#endif
> +	case ARPHRD_LOOPBACK:
> +		init_loopback(dev);
> +		break;

If I read correctly, this change will cause unneeded attempt to re-add
the loopback address on the loopback device when the lo.addr_gen_mode
sysfs entry is touched. I think such side effect should be avoided.

Thanks,

Paolo

