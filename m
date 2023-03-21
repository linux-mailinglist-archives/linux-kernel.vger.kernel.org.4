Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631136C3706
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjCUQgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjCUQgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:36:00 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB2050F9F;
        Tue, 21 Mar 2023 09:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PltMRGGsZfhtJPDUS38hoVLDdEs859D87NRW397FwYM=;
  b=QtQyHPr1eQVmpYQ71t7jnWNP4fMdOHEKjdVjsfZk1Ux7/IkSFZmmf4cP
   7xlSy6FOJwB22fAAX7JV18hu0bhtTrAYzUUkfXPeF57EXVVFpcMa08Z4z
   y748Q0HLNKw24X9s2dhp36LwCTTKusPpJoKmK3HFRvdCVQnSocyATO2T2
   A=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,279,1673910000"; 
   d="scan'208";a="98351872"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 17:35:54 +0100
Date:   Tue, 21 Mar 2023 17:35:54 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>,
        gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, vireshk@kernel.org,
        thierry.reding@gmail.com, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/3] staging: greybus: use inline function for macros
In-Reply-To: <20230321162629.rjmivzhbdy4pcgii@pengutronix.de>
Message-ID: <9a775966-29d4-12b3-e67d-4327194f972@inria.fr>
References: <cover.1679352669.git.eng.mennamahmoud.mm@gmail.com> <1274302b52ae905dab6f75377d625598facbbdf1.1679352669.git.eng.mennamahmoud.mm@gmail.com> <20230321154728.3r7ut3rl2pccmo2e@pengutronix.de> <82a4e5f1-a1f2-c70-3645-9464ccb17bab@inria.fr>
 <20230321162629.rjmivzhbdy4pcgii@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1503685233-1679416554=:10740"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1503685233-1679416554=:10740
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Tue, 21 Mar 2023, Uwe Kleine-König wrote:

> On Tue, Mar 21, 2023 at 04:59:49PM +0100, Julia Lawall wrote:
> >
> >
> > On Tue, 21 Mar 2023, Uwe Kleine-König wrote:
> >
> > > Hello,
> > >
> > > just some nitpicks:
> > >
> > > On Tue, Mar 21, 2023 at 01:04:33AM +0200, Menna Mahmoud wrote:
> > > > Convert `to_gbphy_dev` and `to_gbphy_driver` macros into a
> > > > static inline function.
> > > >
> > > > it is not great to have macro that use `container_of` macro,
> > >
> > > s/it/It/; s/macro/macros/; s/use/use the/;
> > >
> > > > because from looking at the definition one cannot tell what type
> > > > it applies to.
> > > > [...]
> > > > -#define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
> > > > +static inline struct gbphy_device *to_gbphy_dev(const struct device *d)
> > >
> > > drivers/staging/greybus/gbphy.c always passes a variable named
> > > "dev" to this macro. So I'd call the parameter "dev", too, instead of
> > > "d". This is also a more typical name for variables of that type.
> >
> > I argued against that.  Because then there are two uses of dev
> > in the argument of container_of, and they refer to completely different
> > things.  It's true that by the way container_of works, it's fine, but it
> > may be misleading.
>
> Hmm, that seems to be subjective, but I have less problems with that
> than with using "d" for a struct device (or a struct device_driver).
> I'd even go so far as to consider it nice if they are identical.
>
> Maybe that's because having the first and third argument identical is
> quite common:
>
> 	$ git grep -P 'container_of\((?<ident>[A-Za-z_0-9-]*)\s*,[^,]*,\s*\g{ident}\s*\)' | wc -l
> 	5940
>
> which is >44% of all the usages
>
> 	$ git grep -P 'container_of\((?<ident>[A-Za-z_0-9-]*)\s*,[^,]*,\s*(?&ident)\s*\)' | wc -l
> 	13362

OK, if people like that, then why not.  But it's dangerous if the call to
container_of is in a macro, rather than in a function.

julia
--8323329-1503685233-1679416554=:10740--
