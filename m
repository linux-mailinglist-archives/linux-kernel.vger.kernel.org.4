Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AB872F9A9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbjFNJpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244428AbjFNJpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:45:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157DBDC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686735767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qN+1diYhERNkjXIoa2/XDpR5RGrQlC1FGasx3olZwEM=;
        b=fLTw2CqrB+N3/Yw49xqedBg57oi1XNEjsdrDK15DEtPzIDy621qGALsJQrwGsn+9Al86Lp
        lp1zJ4J5ImdVh6EAIAEMz9cIuRV/B5EhIWqzmbpYygFMy6vXeQ1AoxXGJcWOmvviJ688Hm
        YU8JPlDu4t/bs3Gpuwedxy4FDgX6XiI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-jLugubb-OKiIry1m0NAKaA-1; Wed, 14 Jun 2023 05:42:46 -0400
X-MC-Unique: jLugubb-OKiIry1m0NAKaA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f7ecda6eefso13929195e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686735765; x=1689327765;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qN+1diYhERNkjXIoa2/XDpR5RGrQlC1FGasx3olZwEM=;
        b=BetouMsdi43xMOG+gDL1SZL+zDUz8AMynd9Y3taS0BugMIK2AcWwpOPm1lkDPhUQDh
         rPoJtCTDt3Di60Wsnsycf1WcnoLdL3HQDAFjomNVoHUkwLJb2QFtj5o+VZF1vAthXcH6
         GnSHUtFCwFUPXsDg7+X6P+jZdjeUVybIadNHz5PvsV0X3ZNolEe0M6OdMEK14VdTZg5t
         R8qtRJ6MFIL7c+Huam4hRlGPmeWOu2UVIHU+giSJbaPl/rDnqaYAVG+MvDBrNDMmo6fO
         CY20TmGtUlmxW6wnmcAKVXNX9a63oRsSe6B+qV5d+kiykvDy261FKuB0wTQSG66WosR+
         LnQA==
X-Gm-Message-State: AC+VfDzn26RQJVWX/cqr+nbR37nRzWstVEzun4QDjImmOOYy6IHeWrm8
        ffsli8w97qeR0dhNX1ITTvc8IDzHd/Km3MkvBJcLb61l+9noCGUk/zY0etaeGvA8Kzm+m0mUlHr
        SSevMYaBWFOQV1s94HeNlk2wT
X-Received: by 2002:adf:f642:0:b0:30c:4191:b247 with SMTP id x2-20020adff642000000b0030c4191b247mr10353545wrp.5.1686735765421;
        Wed, 14 Jun 2023 02:42:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ66KndozB3mH6VvltJu6YxrA+IR8sESkB/CE2sAaPLInx38QXIMj0yTlAeCaYNi/KUJG6h8UQ==
X-Received: by 2002:adf:f642:0:b0:30c:4191:b247 with SMTP id x2-20020adff642000000b0030c4191b247mr10353530wrp.5.1686735765049;
        Wed, 14 Jun 2023 02:42:45 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-244-67.dyn.eolo.it. [146.241.244.67])
        by smtp.gmail.com with ESMTPSA id i1-20020adfefc1000000b0030647449730sm17895849wrp.74.2023.06.14.02.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 02:42:44 -0700 (PDT)
Message-ID: <dffbf0474b1352f1eac63125a973c8f8cd7b3e8d.camel@redhat.com>
Subject: Re: [PATCH] net: hsr: Disable promiscuous mode in offload mode
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, bigeasy@linutronix.de
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        rogerq@kernel.org
Date:   Wed, 14 Jun 2023 11:42:43 +0200
In-Reply-To: <20230612093933.13267-1-r-gunasekaran@ti.com>
References: <20230612093933.13267-1-r-gunasekaran@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-06-12 at 15:09 +0530, Ravi Gunasekaran wrote:
> When port-to-port forwarding for interfaces in HSR node is enabled,
> disable promiscuous mode since L2 frame forward happens at the
> offloaded hardware.
>=20
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
>  net/hsr/hsr_device.c |  5 +++++
>  net/hsr/hsr_main.h   |  1 +
>  net/hsr/hsr_slave.c  | 15 +++++++++++----
>  3 files changed, 17 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index 5a236aae2366..306f942c3b28 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -531,6 +531,11 @@ int hsr_dev_finalize(struct net_device *hsr_dev, str=
uct net_device *slave[2],
>  	if (res)
>  		goto err_add_master;
> =20
> +	/* HSR forwarding offload supported in lower device? */
> +	if ((slave[0]->features & NETIF_F_HW_HSR_FWD) &&
> +	    (slave[1]->features & NETIF_F_HW_HSR_FWD))
> +		hsr->fwd_offloaded =3D true;
> +
>  	res =3D register_netdevice(hsr_dev);
>  	if (res)
>  		goto err_unregister;
> diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
> index 5584c80a5c79..0225fabbe6d1 100644
> --- a/net/hsr/hsr_main.h
> +++ b/net/hsr/hsr_main.h
> @@ -195,6 +195,7 @@ struct hsr_priv {
>  	struct hsr_self_node	__rcu *self_node;	/* MACs of slaves */
>  	struct timer_list	announce_timer;	/* Supervision frame dispatch */
>  	struct timer_list	prune_timer;
> +	unsigned int            fwd_offloaded : 1; /* Forwarding offloaded to H=
W */

Please use plain 'bool' instead.

Also there is an hole in 'struct hsr_priv' just after 'net_id', you
could consider moving this new field there.


Thanks!

Paolo

