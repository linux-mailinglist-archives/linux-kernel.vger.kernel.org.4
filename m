Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417C074EBA6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjGKKWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGKKWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:22:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1973EDB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 03:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689070878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zxNChGIelKjoLuG8SrdI8P5hWqfFpZJORMAj7Wr1DkU=;
        b=HwvPpfeWb7piwDg0zEqHwIDNijOf0CupwtjCYpPxFHfrVlDa3UaNou2iG8EtEAoq/en95B
        S7EuF9MSj8/9jJR1b3Ur71IpC2civt0zQ6MshGa8otvwPFJ0bBLMVZBK5bTDfvnletQgoW
        FRKqXRYKYa8QbVJjcmtq/UULrcKHL50=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-XGnvxWP4Nh6TKebtbCFyXQ-1; Tue, 11 Jul 2023 06:21:16 -0400
X-MC-Unique: XGnvxWP4Nh6TKebtbCFyXQ-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-40234d83032so11494921cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 03:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689070876; x=1689675676;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zxNChGIelKjoLuG8SrdI8P5hWqfFpZJORMAj7Wr1DkU=;
        b=K4d+PMzRcLSBQknxRWp6qYQFi94o9bU/d3XDxhnd2K4ar4yLLS6UXX2ytI2KwzuEjo
         ntutTuKki7GEhkm2vPASjLkufZhowqXvleMIRtPbRmu4l6ZwSQejRMMwtuXmfiMoFN/A
         0/NuUMauIEUDnRwtuZuAzB4z5mEngxDrNQhVqYyzFn6Yrugb+Aha0rtlIyiXQMJybbse
         1O80VOvIL4qACHV0vCeAuK/Sg8RoGh2L0N3Gc+ZAktEeaoiwcXTV09gx38p0bgJD9x75
         onGsLpKtE9RyCxHYQQkRnj/+49IQyondx1GafyV0jrZM4UNTaAQgwpsW/8V3BOXP0jah
         p2sA==
X-Gm-Message-State: ABy/qLYlVL/fvq8LKrIY4sFWL6IHsGx8xyoBqsfDldjPvqBt3IyFDQ5P
        LleUclaLXbp3/UnwV+suNh/clp4S2ZX/8hu3PPdwnvaYkzIMBymYzvH/+G7hkP3jYjnGqpM/+q5
        a49ww4p4nGt1Lb7vJ1Ci7ECYP
X-Received: by 2002:a05:622a:1007:b0:3fd:eb2f:8627 with SMTP id d7-20020a05622a100700b003fdeb2f8627mr16474671qte.6.1689070876146;
        Tue, 11 Jul 2023 03:21:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE3KtM/WsWfyD0RTFaAra9Jvq2qFoYXTelie53paqoYE7qWLud5Wx2SOGqm6fMhIg5bzlRT5Q==
X-Received: by 2002:a05:622a:1007:b0:3fd:eb2f:8627 with SMTP id d7-20020a05622a100700b003fdeb2f8627mr16474659qte.6.1689070875925;
        Tue, 11 Jul 2023 03:21:15 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-188.dyn.eolo.it. [146.241.235.188])
        by smtp.gmail.com with ESMTPSA id d4-20020ac851c4000000b00403ad6ec2e8sm954982qtn.26.2023.07.11.03.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 03:21:15 -0700 (PDT)
Message-ID: <2a2d55f167a06782eb9dfa6988ec96c2eedb7fba.camel@redhat.com>
Subject: Re: [PATCH net-next][resend v1 1/1] netlink: Don't use int as bool
 in netlink_update_socket_mc()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
Date:   Tue, 11 Jul 2023 12:21:12 +0200
In-Reply-To: <20230711063348.GB41919@unreal>
References: <20230710100624.87836-1-andriy.shevchenko@linux.intel.com>
         <20230711063348.GB41919@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-07-11 at 09:33 +0300, Leon Romanovsky wrote:
> On Mon, Jul 10, 2023 at 01:06:24PM +0300, Andy Shevchenko wrote:
> > The bit operations take boolean parameter and return also boolean
> > (in test_bit()-like cases). Don't threat booleans as integers when
> > it's not needed.
> >=20
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  net/netlink/af_netlink.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> > index 383631873748..d81e7a43944c 100644
> > --- a/net/netlink/af_netlink.c
> > +++ b/net/netlink/af_netlink.c
> > @@ -1623,9 +1623,10 @@ EXPORT_SYMBOL(netlink_set_err);
> >  /* must be called with netlink table grabbed */
> >  static void netlink_update_socket_mc(struct netlink_sock *nlk,
> >  				     unsigned int group,
> > -				     int is_new)
> > +				     bool new)
> >  {
> > -	int old, new =3D !!is_new, subscriptions;
> > +	int subscriptions;
> > +	bool old;
> > =20
> >  	old =3D test_bit(group - 1, nlk->groups);
> >  	subscriptions =3D nlk->subscriptions - old + new;
>=20
> So what is the outcome of "int - bool + bool" in the line above?

FTR, I agree with Leon, the old code is more readable to me/I don't see
a practical gain with this change.

Cheers,

Paolo

