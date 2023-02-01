Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECE4686A93
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjBAPoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBAPoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:44:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F9A728DA
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675266237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S5Crr6arLnCfcCARGeaiwt5pWggnVd4zfxeJUuRh9Ns=;
        b=TRMbW5Wxe28jndzTaliOriYeCwOL8ChtMybV2Hx5vnvuT+A0xNMq8wOeDbxFn7Cp2xHQVA
        tjVKknVSVmlvM4LbsBimOwAbNKDPIh/vDQ5zC6a/itVhCi4p7gSme3fnJGKzZK0jcrew3l
        KIn0Q5+hi0TdRiamMVo1SEgBV8qE2Ro=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-613-BIlLSqd8PWm_hjQAKjiuMQ-1; Wed, 01 Feb 2023 10:43:56 -0500
X-MC-Unique: BIlLSqd8PWm_hjQAKjiuMQ-1
Received: by mail-pg1-f199.google.com with SMTP id az7-20020a056a02004700b004ec117e57cfso3739116pgb.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 07:43:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5Crr6arLnCfcCARGeaiwt5pWggnVd4zfxeJUuRh9Ns=;
        b=xpzn16x/qQLApatBf4hrS1s4ZNszgRCBKMy+u4WqXtHVop0wfkP30i7dKurfLEwA/p
         6sOK+T+gFLrsBNMKkLRG0hq2oU2k/sww64/VjOJXDG7CHywvE+QDI9nJ+9pBGerm12KQ
         dKcJe+q2NDPJ3ix/blrPfBDxnlcH2oLZvi4hwxd3qt+eZuQtbcFfbG3IsLxX7tTGuf83
         nhf91FZ1U4lBbnVEWZfbZDH9+8SDYSPJK0g1Phed2F9sCVvuixqF3YqUs6CO+9XcrZZj
         /NqyDEHURymLsvza5QDJnI/Yy8c7Ek8iBM0JCnjun2+aczLcP30oUcQgQZqI4pqz7Tnf
         kCgg==
X-Gm-Message-State: AO0yUKX9WdRB+iIvhBC83RU+BUe7o8pKgspnm2kDtsu+vRX0CaaeGXbq
        3gfIRbguNm/o7m2VIPuD6lEqCt9dHXA8sp+ONAMQB4PPJzxmFqRBDUEK2a7s7vgyAAji7Av0DWc
        HOxUTQnPUeTFOU8LNCMBnHsn4
X-Received: by 2002:a17:903:2282:b0:196:7a90:5f48 with SMTP id b2-20020a170903228200b001967a905f48mr3185161plh.24.1675266234718;
        Wed, 01 Feb 2023 07:43:54 -0800 (PST)
X-Google-Smtp-Source: AK7set+SwIAdWwiCD0ElL1XQniEDQeAa6NpDSd0ywIw1JKfzHV7HJzv1REZX9Ff5sCFE5PoSLX3Fsg==
X-Received: by 2002:a17:903:2282:b0:196:7a90:5f48 with SMTP id b2-20020a170903228200b001967a905f48mr3185140plh.24.1675266234434;
        Wed, 01 Feb 2023 07:43:54 -0800 (PST)
Received: from kernel-devel ([240d:1a:c0d:9f00:ca6:1aff:fead:cef4])
        by smtp.gmail.com with ESMTPSA id je7-20020a170903264700b001960735c652sm11975028plb.169.2023.02.01.07.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 07:43:54 -0800 (PST)
Date:   Thu, 2 Feb 2023 00:43:49 +0900
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     Guillaume Nault <gnault@redhat.com>
Cc:     jchapman@katalix.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] l2tp: Avoid possible recursive deadlock in
 l2tp_tunnel_register()
Message-ID: <Y9qItT82LcJdJVlF@kernel-devel>
References: <20230130154438.1373750-1-syoshida@redhat.com>
 <Y9f4eAhcJXhh0+c2@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9f4eAhcJXhh0+c2@debian>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guillaume,

On Mon, Jan 30, 2023 at 06:03:52PM +0100, Guillaume Nault wrote:
> On Tue, Jan 31, 2023 at 12:44:38AM +0900, Shigeru Yoshida wrote:
> > This patch fixes the issue by returning error when a pppol2tp socket
> > itself is passed.
> 
> Fixes: 0b2c59720e65 ("l2tp: close all race conditions in l2tp_tunnel_register()")
> 
> > Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> > ---
> >  net/l2tp/l2tp_ppp.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
> > index db2e584c625e..88d1a339500b 100644
> > --- a/net/l2tp/l2tp_ppp.c
> > +++ b/net/l2tp/l2tp_ppp.c
> > @@ -702,11 +702,14 @@ static int pppol2tp_connect(struct socket *sock, struct sockaddr *uservaddr,
> >  			struct l2tp_tunnel_cfg tcfg = {
> >  				.encap = L2TP_ENCAPTYPE_UDP,
> >  			};
> > +			int dummy = 0;
> 
> There's no need to initialise dummy here. This is just confusing.
> We could even do without any extra variable and reuse error in
> sockfd_lookup().
> 
> >  			/* Prevent l2tp_tunnel_register() from trying to set up
> > -			 * a kernel socket.
> > +			 * a kernel socket.  Also, prevent l2tp_tunnel_register()
> > +			 * from trying to use pppol2tp socket itself.
> >  			 */
> > -			if (info.fd < 0) {
> > +			if (info.fd < 0 ||
> > +			    sock == sockfd_lookup(info.fd, &dummy)) {
> >  				error = -EBADF;
> >  				goto end;
> >  			}
> 
> That should work, but the real problem is calling l2tp_tunnel_register()
> under lock_sock(). We should instead get/create the tunnel before
> locking the pppol2tp socket.

Thank you so much for your comment, and sorry for the late response.

Do you mean we can call l2tp_tunnel_register() without pppol2tp socket
lock?  I've read the source code of pppol2tp_connect(), but I'm not
sure why pppol2tp socket is locked at the beginning of this function.

If we can call l2tp_tunnel_register() without pppol2tp socket lock, I
think we can move lock_sock() after l2tp_tunnel_register().

Thanks,
Shigeru

> 

