Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6E972F9B1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244304AbjFNJqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243929AbjFNJpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:45:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46AC19A7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686735855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QiTpKaNcHheuAqTHACBRzRCRFnuRr4rkUQEm8xv8v/4=;
        b=av17rmKcXSxkmJtFmCNLyf4/p3xs0tlEo6MjIo519F6KsSy4BUpXpCpJmvh+IFm6ntSXQO
        5D/0U69SkYy+T/OxKTg1OsLbTuwi2wTcmid9DLW/FwOxapCzJ7Ygd2dzp/zgbtAYCtJHQ1
        q2wcCBWT9TFevzp7dlRqUMDXq/I1b7g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-Jxd2YuesMPie1JKsU7EUBQ-1; Wed, 14 Jun 2023 05:44:13 -0400
X-MC-Unique: Jxd2YuesMPie1JKsU7EUBQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30fb7b82e15so722118f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686735852; x=1689327852;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QiTpKaNcHheuAqTHACBRzRCRFnuRr4rkUQEm8xv8v/4=;
        b=hO88IVFoUlmf4jP/VgDxTlhU304faKviRFjUqP/bpLlp2EFsS4pMKlnKJaYXye24k1
         dyJC32IPgU3KEdFxQXvTVaXtAVUEzWqe1HUyjuWZX6n7gn+1qwR3xH6JGGqXrAdw8pDM
         tBXwUA5TE693skzxoswFNrQ5hQJLMVgKFsrNIKXIufcM6upaMWNyx+jRUHSznXOocvcj
         K6AhcdcQtsDQoldYWA0FkwFqbN1nxsa1C0Jz1AaN2w30XsVOzhIM0XI9GxJtp304hogM
         nguoKudHImKYuAyokAiUGNe07o3rIPB8OzkY/rnwI8XyCD9PaMKGN1mBsmemwZiuTwZs
         +PNQ==
X-Gm-Message-State: AC+VfDxweHbhMPzZLHINApS0hzJHxom3cmiwWFhMU05kguRmpJkFrnPY
        5O5hxzfDCR3ylKmPFM6cYFBnD9BGq91KWkVgyENm73oOqalF2aYe9ggBqV99HNsuhWM5Jy37KGD
        XdNeAZXhkJpOrth19hXPnvVqCoLSbVj7a
X-Received: by 2002:adf:fd84:0:b0:2c7:1c72:699f with SMTP id d4-20020adffd84000000b002c71c72699fmr10931934wrr.4.1686735852571;
        Wed, 14 Jun 2023 02:44:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6baYkWtu4XCSjrdY+uCwNL6ExilJb4E+AbjWjAaRwYvFRzKEYN1SVr37wObHtahf29dJp9pA==
X-Received: by 2002:adf:fd84:0:b0:2c7:1c72:699f with SMTP id d4-20020adffd84000000b002c71c72699fmr10931922wrr.4.1686735852275;
        Wed, 14 Jun 2023 02:44:12 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-244-67.dyn.eolo.it. [146.241.244.67])
        by smtp.gmail.com with ESMTPSA id y22-20020a7bcd96000000b003f7f2a1484csm16980813wmj.5.2023.06.14.02.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 02:44:11 -0700 (PDT)
Message-ID: <f50ad11eb5ca3cb777e7150ad6a8347e575f1667.camel@redhat.com>
Subject: Re: [PATCH] net: hsr: Disable promiscuous mode in offload mode
From:   Paolo Abeni <pabeni@redhat.com>
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, bigeasy@linutronix.de
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        rogerq@kernel.org
Date:   Wed, 14 Jun 2023 11:44:10 +0200
In-Reply-To: <dffbf0474b1352f1eac63125a973c8f8cd7b3e8d.camel@redhat.com>
References: <20230612093933.13267-1-r-gunasekaran@ti.com>
         <dffbf0474b1352f1eac63125a973c8f8cd7b3e8d.camel@redhat.com>
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

On Wed, 2023-06-14 at 11:42 +0200, Paolo Abeni wrote:
> On Mon, 2023-06-12 at 15:09 +0530, Ravi Gunasekaran wrote:
> > When port-to-port forwarding for interfaces in HSR node is enabled,
> > disable promiscuous mode since L2 frame forward happens at the
> > offloaded hardware.
> >=20
> > Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> > ---
> >  net/hsr/hsr_device.c |  5 +++++
> >  net/hsr/hsr_main.h   |  1 +
> >  net/hsr/hsr_slave.c  | 15 +++++++++++----
> >  3 files changed, 17 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> > index 5a236aae2366..306f942c3b28 100644
> > --- a/net/hsr/hsr_device.c
> > +++ b/net/hsr/hsr_device.c
> > @@ -531,6 +531,11 @@ int hsr_dev_finalize(struct net_device *hsr_dev, s=
truct net_device *slave[2],
> >  	if (res)
> >  		goto err_add_master;
> > =20
> > +	/* HSR forwarding offload supported in lower device? */
> > +	if ((slave[0]->features & NETIF_F_HW_HSR_FWD) &&
> > +	    (slave[1]->features & NETIF_F_HW_HSR_FWD))
> > +		hsr->fwd_offloaded =3D true;
> > +
> >  	res =3D register_netdevice(hsr_dev);
> >  	if (res)
> >  		goto err_unregister;
> > diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
> > index 5584c80a5c79..0225fabbe6d1 100644
> > --- a/net/hsr/hsr_main.h
> > +++ b/net/hsr/hsr_main.h
> > @@ -195,6 +195,7 @@ struct hsr_priv {
> >  	struct hsr_self_node	__rcu *self_node;	/* MACs of slaves */
> >  	struct timer_list	announce_timer;	/* Supervision frame dispatch */
> >  	struct timer_list	prune_timer;
> > +	unsigned int            fwd_offloaded : 1; /* Forwarding offloaded to=
 HW */
>=20
> Please use plain 'bool' instead.
>=20
> Also there is an hole in 'struct hsr_priv' just after 'net_id', you
> could consider moving this new field there.

Oops, I almost forgot! Please include the target tree (net-next in this
case) in the subj prefix on your next submission.

Thanks,

Paolo

