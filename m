Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3F35FEBD1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiJNJjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiJNJi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:38:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0221C19E8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 02:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665740337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SBiaK/S0Bk1BtoBMbirhrmT4dSvIqzdjqMg7h+NAlCc=;
        b=gER0gkTjPZMzqVBpyzHQFmkeROi6JpvNz1URA/vdGTjN+obK/JCZnSTwTncVe+o+R8QRU+
        kpjr863/fiYZgw5Y9bewcqo5Hg3qZdAzqFoJdIu8h8wd+mb21UAEpy6qd9+xoqmsYebN8x
        5IIwIKRw1ZvXIIyLjBpLGaUGteZG7Sw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-313-DV7XySSxOSaBhn2PBGDiug-1; Fri, 14 Oct 2022 05:38:56 -0400
X-MC-Unique: DV7XySSxOSaBhn2PBGDiug-1
Received: by mail-wr1-f70.google.com with SMTP id i1-20020adfa501000000b0022cd1e1137bso1727282wrb.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 02:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBiaK/S0Bk1BtoBMbirhrmT4dSvIqzdjqMg7h+NAlCc=;
        b=I1r+HyYiUBECzia5z51rU+JMXJfB/F+5u3QvtJKVnLfsbeL4nLKfCqB5c86UQ1kQ4I
         a0OCBWM+BA3X/UbpS/z4OlCRE9+XGmzqgf9Y5qVabcFkH4dptUh3adS8gIAXWd7T0d8y
         qANfbQ3KocL9Mv++722mTMZalM5ON5aJeMCTmjbXxoovcpC1fCuwbpJ4unkajJAVTaed
         iBlT3Utg7uZYgSstJ3c0yB8qpBqOHrrkIvNbpyNOWfVT/z6/n7B9GH9GyleXLDW18gpX
         hSezVLYBsyXkUVXooPxy9X7htFfydWzZKThM35VLZM/5J7Y5Fe78XjQrgW5M8Se6Qxfi
         goXA==
X-Gm-Message-State: ACrzQf2xzK6cDtL1KDWcpv+yuNN7dpkKabUBRVZRAHCfsBuRK/Jr17ih
        RPwma7RQXgi4vMQUWQFz78KC3EQLhsa91DJuglsuc0hud1CrGig47+qNjoSAD50C8s4CqrzGA2G
        Y62JHxOQc9P13vaKc7VT8earA
X-Received: by 2002:a1c:7906:0:b0:3c6:235f:5904 with SMTP id l6-20020a1c7906000000b003c6235f5904mr2904923wme.83.1665740333638;
        Fri, 14 Oct 2022 02:38:53 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6ugOCG7McERH0v64bIpOWIbqCZhrlY99EXjNUJy1g+D4caPXaFlwkU7ZzIDHiEE6pf0wqZMA==
X-Received: by 2002:a1c:7906:0:b0:3c6:235f:5904 with SMTP id l6-20020a1c7906000000b003c6235f5904mr2904898wme.83.1665740333230;
        Fri, 14 Oct 2022 02:38:53 -0700 (PDT)
Received: from redhat.com ([2.54.162.123])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0ac700b003c6bd12ac27sm1680397wmr.37.2022.10.14.02.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 02:38:52 -0700 (PDT)
Date:   Fri, 14 Oct 2022 05:38:49 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Menglong Dong <imagedong@tencent.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Petr Machata <petrm@nvidia.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] net: fix opencoded for_each_and_bit() in
 __netif_set_xps_queue()
Message-ID: <20221014053814-mutt-send-email-mst@kernel.org>
References: <20221013234349.1165689-1-yury.norov@gmail.com>
 <20221013234349.1165689-5-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013234349.1165689-5-yury.norov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 04:43:48PM -0700, Yury Norov wrote:
> Replace opencoded bitmap traversing and drop unused
> netif_attrmask_next*() functions
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

I think you want to document, here, that this fixes a warning.
Additionally, add a Fixes: tag.


> ---
>  include/linux/netdevice.h | 46 ---------------------------------------
>  net/core/dev.c            |  3 +--
>  2 files changed, 1 insertion(+), 48 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 53d738f66159..5db2b6de7308 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3648,52 +3648,6 @@ static inline bool netif_attr_test_online(unsigned long j,
>  
>  	return (j < nr_bits);
>  }
> -
> -/**
> - *	netif_attrmask_next - get the next CPU/Rx queue in a cpu/Rx queues mask
> - *	@n: CPU/Rx queue index
> - *	@srcp: the cpumask/Rx queue mask pointer
> - *	@nr_bits: number of bits in the bitmask
> - *
> - * Returns >= nr_bits if no further CPUs/Rx queues set.
> - */
> -static inline unsigned int netif_attrmask_next(int n, const unsigned long *srcp,
> -					       unsigned int nr_bits)
> -{
> -	/* n is a prior cpu */
> -	cpu_max_bits_warn(n + 1, nr_bits);
> -
> -	if (srcp)
> -		return find_next_bit(srcp, nr_bits, n + 1);
> -
> -	return n + 1;
> -}
> -
> -/**
> - *	netif_attrmask_next_and - get the next CPU/Rx queue in \*src1p & \*src2p
> - *	@n: CPU/Rx queue index
> - *	@src1p: the first CPUs/Rx queues mask pointer
> - *	@src2p: the second CPUs/Rx queues mask pointer
> - *	@nr_bits: number of bits in the bitmask
> - *
> - * Returns >= nr_bits if no further CPUs/Rx queues set in both.
> - */
> -static inline int netif_attrmask_next_and(int n, const unsigned long *src1p,
> -					  const unsigned long *src2p,
> -					  unsigned int nr_bits)
> -{
> -	/* n is a prior cpu */
> -	cpu_max_bits_warn(n + 1, nr_bits);
> -
> -	if (src1p && src2p)
> -		return find_next_and_bit(src1p, src2p, nr_bits, n + 1);
> -	else if (src1p)
> -		return find_next_bit(src1p, nr_bits, n + 1);
> -	else if (src2p)
> -		return find_next_bit(src2p, nr_bits, n + 1);
> -
> -	return n + 1;
> -}
>  #else
>  static inline int netif_set_xps_queue(struct net_device *dev,
>  				      const struct cpumask *mask,
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 8049e2ff11a5..b0fb592d51da 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -2592,8 +2592,7 @@ int __netif_set_xps_queue(struct net_device *dev, const unsigned long *mask,
>  		copy = true;
>  
>  	/* allocate memory for queue storage */
> -	for (j = -1; j = netif_attrmask_next_and(j, online_mask, mask, nr_ids),
> -	     j < nr_ids;) {
> +	for_each_and_bit(j, online_mask, mask ? : online_mask, nr_ids) {
>  		if (!new_dev_maps) {
>  			new_dev_maps = kzalloc(maps_sz, GFP_KERNEL);
>  			if (!new_dev_maps)
> -- 
> 2.34.1

