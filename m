Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767D8629500
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiKOJ5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiKOJ5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:57:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B67DF0C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668506211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nu3ArU28TM2hYIfKLCvBtkAP2klHTLMumzmyu1fNa5U=;
        b=a7+sc3viiBz7V72RdTAg61KF/op8xR611D0rI8nqTotJwT+0v+TWH6u/kGHSDbBk45ynOW
        qxwWGsQm2w7GDkBdU0T4S2fcQhzcQqnVRoqeoTIKVoa06SRMPnSh9OVijgYJtfiu9YGUJQ
        XW0oft9F1ZStEDnWpZfh5VfLWAin4Js=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-372-gW-NkHEwPi28KZcrkZaSKA-1; Tue, 15 Nov 2022 04:56:49 -0500
X-MC-Unique: gW-NkHEwPi28KZcrkZaSKA-1
Received: by mail-qk1-f199.google.com with SMTP id h8-20020a05620a284800b006b5c98f09fbso13333484qkp.21
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:56:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nu3ArU28TM2hYIfKLCvBtkAP2klHTLMumzmyu1fNa5U=;
        b=T8LZzSdwDd5PO3/NfScXVyVy67Rq91s6CG206AVH4Pr3XlxmkU57bJ8Qt+cfmKFKPS
         ujRq8S4g0LEaaB3jRsia6Ytf9KBKUx/w/pNhTjn4EkcohSjrgDs+65TivpTJbsNZdlWo
         PB05VcCy6cFJ+ZrcawM+mIJs8cvwbohlR7Frwam/iyon/louaTGyn3FuYtsnPLReCz9w
         pJqS/Kgk9blm9gq5tUOdCx7w4cgK3xdoyoSmCx002kFb58bjf3hrVina5hfaiHTa7qIW
         ymcAKUPGkZUIJYYHkCwSH/hYJP7zU9HkIB2WYXYstSedoWRxpLotWF5PUPNp92oCn4bU
         dNlA==
X-Gm-Message-State: ANoB5pm4oBo8hG8cbwC/VZl+qM83LxdAsrzJDg3jzLxHE9gUj7up4xfE
        Y4z4pCCbHNcU3KdQuM/v98NAak9DpgNDr1WTFStyXyBxqrPy0PJv+AQ+IepUanrkVhW2CtCD3Qs
        9UMt4gfFO8w/zqd2qTYInxqz8
X-Received: by 2002:a0c:eda2:0:b0:4bb:6692:a5a6 with SMTP id h2-20020a0ceda2000000b004bb6692a5a6mr15927764qvr.108.1668506209432;
        Tue, 15 Nov 2022 01:56:49 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5qErtemVdLPkg6MKl6FsmY7VSbcQ3GZi2WzT/IrqnFSATo+99+GcFPnsuSsEzWBObGu5uCDA==
X-Received: by 2002:a0c:eda2:0:b0:4bb:6692:a5a6 with SMTP id h2-20020a0ceda2000000b004bb6692a5a6mr15927757qvr.108.1668506209169;
        Tue, 15 Nov 2022 01:56:49 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id l5-20020ac87245000000b0039cc7ebf46bsm6870110qtp.93.2022.11.15.01.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 01:56:48 -0800 (PST)
Message-ID: <205d812ab74d721f4345eabcf3e5a86a710b40da.camel@redhat.com>
Subject: Re: [PATCH] net: neigh: decrement the family specific qlen
From:   Paolo Abeni <pabeni@redhat.com>
To:     Thomas Zeitlhofer <thomas.zeitlhofer+lkml@ze-it.at>,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        "Denis V. Lunev" <den@openvz.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Yuwei Wang <wangyuweihx@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 15 Nov 2022 10:56:45 +0100
In-Reply-To: <Y295+9+JDjqRWbwU@x1.ze-it.at>
References: <Y295+9+JDjqRWbwU@x1.ze-it.at>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, 2022-11-12 at 11:48 +0100, Thomas Zeitlhofer wrote:
> Commit 0ff4eb3d5ebb ("neighbour: make proxy_queue.qlen limit
> per-device") introduced the length counter qlen in struct neigh_parms.
> There are separate neigh_parms instances for IPv4/ARP and IPv6/ND, and
> while the family specific qlen is incremented in pneigh_enqueue(), the
> mentioned commit decrements always the IPv4/ARP specific qlen,
> regardless of the currently processed family, in pneigh_queue_purge()
> and neigh_proxy_process().
> 
> As a result, with IPv6/ND, the family specific qlen is only incremented
> (and never decremented) until it exceeds PROXY_QLEN, and then, according
> to the check in pneigh_enqueue(), neighbor solicitations are not
> answered anymore. As an example, this is noted when using the
> subnet-router anycast address to access a Linux router. After a certain
> amount of time (in the observed case, qlen exceeded PROXY_QLEN after two
> days), the Linux router stops answering neighbor solicitations for its
> subnet-router anycast address and effectively becomes unreachable.
> 
> Another result with IPv6/ND is that the IPv4/ARP specific qlen is
> decremented more often than incremented. This leads to negative qlen
> values, as a signed integer has been used for the length counter qlen,
> and potentially to an integer overflow.
> 
> Fix this by introducing the helper function neigh_parms_qlen_dec(),
> which decrements the family specific qlen. Thereby, make use of the
> existing helper function neigh_get_dev_parms_rcu(), whose definition
> therefore needs to be placed earlier in neighbour.c. Take the family
> member from struct neigh_table to determine the currently processed
> family and appropriately call neigh_parms_qlen_dec() from
> pneigh_queue_purge() and neigh_proxy_process().
> 
> Additionally, use an unsigned integer for the length counter qlen.
> 
> Fixes: 0ff4eb3d5ebb ("neighbour: make proxy_queue.qlen limit per-device")
> Signed-off-by: Thomas Zeitlhofer <thomas.zeitlhofer+lkml@ze-it.at>
> ---
>  include/net/neighbour.h |  2 +-
>  net/core/neighbour.c    | 58 +++++++++++++++++++++--------------------
>  2 files changed, 31 insertions(+), 29 deletions(-)
> 
> diff --git a/include/net/neighbour.h b/include/net/neighbour.h
> index 20745cf7ae1a..cc0b65b7c829 100644
> --- a/include/net/neighbour.h
> +++ b/include/net/neighbour.h
> @@ -83,7 +83,7 @@ struct neigh_parms {
>  	struct rcu_head rcu_head;
>  
>  	int	reachable_time;
> -	int	qlen;
> +	__u32	qlen;
>  	int	data[NEIGH_VAR_DATA_MAX];
>  	DECLARE_BITMAP(data_state, NEIGH_VAR_DATA_MAX);
>  };

The patch LGTM, but why did you use __u32 above? this is not part of
uAPI, plain u32 should be fine. 

Thanks!

Paolo

