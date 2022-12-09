Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A746486B7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 17:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiLIQpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 11:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLIQpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 11:45:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EA52E6A1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 08:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670604277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=58/VjDZZoily/fkCPVeQuHIo3U3CJ3NHBYhVURQ6msE=;
        b=J5C5+129e/lwdOjFPRGGMn6I85KCuuUhHQa08lRKB3I1aEAAydeF0Er+ofdQ43+IIhE8HN
        stMTWWlD7ggpioIy/8ESmdlnLwAEinKJ0QpZv9TxrKz90vRzuvnbrZBO61B6mk44b8KaOf
        iZ2q0x7n1b+R2yzxzd7yVfqIbr8DPR0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-443-AIJfFFZPM6euiMNhKmsTxA-1; Fri, 09 Dec 2022 11:44:28 -0500
X-MC-Unique: AIJfFFZPM6euiMNhKmsTxA-1
Received: by mail-ej1-f72.google.com with SMTP id qb2-20020a1709077e8200b007bf01e43797so3431320ejc.13
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 08:44:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=58/VjDZZoily/fkCPVeQuHIo3U3CJ3NHBYhVURQ6msE=;
        b=CVntjfkAT1FkBYwbiDjfS7dN0/QcJUWEn2ItPK4maNDKBUH+Q7scsJTU4n8betEgrj
         kQV5xzZgi4BRPpfF+/gZ8wa5oJ3hvSBGxoRe373Pff/YQJYwyla79lbyevZduL4vZVXb
         YaS1nxXyLNeOZKF4+NMngpZof/bbaS+X9po6ibu6Lsj2/8k8kDCgKsYoIzx5hVvgwmd6
         crm3sm1mxFCIpFZU8FCkFVhnTaCphvbAU7e64FPjUZ2rhYRlDYZY3wlXbkCScCAFBw5f
         6MWdhC9lDMYg4Tn1EdWtWuWALNyW+RETDQLDh67gy8PAPDXkeJvFwI4+ARyVN+hwWpY4
         EIOA==
X-Gm-Message-State: ANoB5pn5Vy6WTULfp0NsrI+pT3I8uEQ2rgyv0oLOzmhsqlakvi9di5Dp
        ydML5d9VLioYTWjaD3ihPKS3CDkwGp1u/fTSS9Y2u8bxDlBUnzqacuqqWK4u4dcBMpiGVol3Aoe
        aUbOzH9HXOpx2CJYX302+YpE9
X-Received: by 2002:a17:906:d922:b0:7c1:31c:e884 with SMTP id rn2-20020a170906d92200b007c1031ce884mr5297335ejb.17.1670604267891;
        Fri, 09 Dec 2022 08:44:27 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6sOrFT1Dy7qofyt7/dF4dvCQavTcB/nflqFBCIwEfJJ9SkPN3Lgfjdbp7iCrpqqFOYh+boyA==
X-Received: by 2002:a17:906:d922:b0:7c1:31c:e884 with SMTP id rn2-20020a170906d92200b007c1031ce884mr5297324ejb.17.1670604267713;
        Fri, 09 Dec 2022 08:44:27 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-105-105.dyn.eolo.it. [146.241.105.105])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709063e5200b007c1175334basm113194eji.78.2022.12.09.08.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 08:44:27 -0800 (PST)
Message-ID: <59973b017cbd927b69d24f32cbac15f8245cc29c.camel@redhat.com>
Subject: Re: [PATCH v1 3/3] net: simplify sk_page_frag
From:   Paolo Abeni <pabeni@redhat.com>
To:     Benjamin Coddington <bcodding@redhat.com>, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Date:   Fri, 09 Dec 2022 17:44:25 +0100
In-Reply-To: <79b1009812b753c3a82d09271c4d655d644d37a6.1669036433.git.bcodding@redhat.com>
References: <cover.1669036433.git.bcodding@redhat.com>
         <79b1009812b753c3a82d09271c4d655d644d37a6.1669036433.git.bcodding@redhat.com>
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

On Mon, 2022-11-21 at 08:35 -0500, Benjamin Coddington wrote:
> Now that in-kernel socket users that may recurse during reclaim have benn
> converted to sk_use_task_frag = false, we can have sk_page_frag() simply
> check that value.
> 
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
> ---
>  include/net/sock.h | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index ffba9e95470d..fac24c6ee30d 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -2539,19 +2539,14 @@ static inline void sk_stream_moderate_sndbuf(struct sock *sk)
>   * Both direct reclaim and page faults can nest inside other
>   * socket operations and end up recursing into sk_page_frag()
>   * while it's already in use: explicitly avoid task page_frag
> - * usage if the caller is potentially doing any of them.
> - * This assumes that page fault handlers use the GFP_NOFS flags or
> - * explicitly disable sk_use_task_frag.
> + * when users disable sk_use_task_frag.
>   *
>   * Return: a per task page_frag if context allows that,
>   * otherwise a per socket one.
>   */
>  static inline struct page_frag *sk_page_frag(struct sock *sk)
>  {
> -	if (sk->sk_use_task_frag &&
> -	    (sk->sk_allocation & (__GFP_DIRECT_RECLAIM | __GFP_MEMALLOC |
> -				  __GFP_FS)) ==
> -	    (__GFP_DIRECT_RECLAIM | __GFP_FS))
> +	if (sk->sk_use_task_frag)
>  		return &current->task_frag;
>  
>  	return &sk->sk_frag;

To make the above as safe as possible I think we should double-check
the in-kernel users explicitly setting sk_allocation to GFP_ATOMIC, as
that has the side effect of disabling the task_frag usage, too.

Patch 2/3 already catches some of such users, and we can safely leave
alone few others, (specifically l2tp, fou and inet_ctl_sock_create()).

Even wireguard and tls looks safe IMHO.

So the only left-over should be espintcp, I suggest updating patch 2/3
clearing sk_use_task_frag even in espintcp_init_sk().

Other than that LGTM.

Cheers,

Paolo

