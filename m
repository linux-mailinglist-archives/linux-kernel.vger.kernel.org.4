Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083D66C050A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 21:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjCSU4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 16:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjCSUz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 16:55:57 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B24F14997
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 13:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=s0trZBaUtZw+GHzi7Jh3s/ToygBuTksFbR6LWIkL44o=;
  b=PauKMYuOO6uKB7qJNZu7KSU/pg3LEliHIJDcIUpaQ6gfAGTVmSrgEXwO
   vUZzPqOU4CSqfgI8nTDnrIKz38k1BaA1ciyjs4YZY7GLhjBv1HlcUbCXN
   DkKplr5apThym9StnI/TezHZB98t6eRYTwftt3Ll3guBV1yU2TqNn+Fjl
   A=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,274,1673910000"; 
   d="scan'208";a="50621644"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 21:55:52 +0100
Date:   Sun, 19 Mar 2023 21:55:51 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: greybus: use inline function for macros
In-Reply-To: <0f02a3ff-801b-1e1f-5c03-009a05708709@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2303192151330.2867@hadrien>
References: <20230319201324.253874-1-eng.mennamahmoud.mm@gmail.com> <alpine.DEB.2.22.394.2303192121170.2867@hadrien> <0f02a3ff-801b-1e1f-5c03-009a05708709@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1218776436-1679259352=:2867"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1218776436-1679259352=:2867
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 19 Mar 2023, Menna Mahmoud wrote:

>
> On ١٩/٣/٢٠٢٣ ٢٢:٢١, Julia Lawall wrote:
> >
> > On Sun, 19 Mar 2023, Menna Mahmoud wrote:
> >
> > > Convert `to_gbphy_dev` and `to_gbphy_driver` macros into a
> > > static inline functions.
> > >
> > > it is not great to have macro that use `container_of` macro,
> > > because from looking at the definition one cannot tell what type
> > > it applies to.
> > >
> > > One can get the same benefit from an efficiency point of view
> > > by making an inline function.
> > >
> > > Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> > > Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
> > > ---
> > >   drivers/staging/greybus/gbphy.h | 10 ++++++++--
> > >   1 file changed, 8 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/staging/greybus/gbphy.h
> > > b/drivers/staging/greybus/gbphy.h
> > > index 1de510499480..42c4e3fe307c 100644
> > > --- a/drivers/staging/greybus/gbphy.h
> > > +++ b/drivers/staging/greybus/gbphy.h
> > > @@ -16,7 +16,10 @@ struct gbphy_device {
> > >   	struct device dev;
> > >   };
> > >
> > You have made the patch against your previous patch that added a newline
> > here.  It should be against Greg's tree.
> >
> > julia
>
> you mean I should remove this newline, right?

You should apply your change to the state of Greg's tree, not the state
after your patch.

Assuming that you have committed both the patch adding the new line and
the patch changing the macro to a function, and have made no other
changes, you can do git rebase -i HEAD~2 and the put a d at the beginning
of the line related to the patch adding the newline.  If you have made
more changes, you can adapt the HEAD~ part accordingly.

julia


>
>
> Menna
>
> >
> > > -#define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
> > > +static inline struct gbphy_device *to_gbphy_dev(const struct device *d)
> > > +{
> > > +	return container_of(d, struct gbphy_device, dev);
> > > +}
> > >
> > >   static inline void *gb_gbphy_get_data(struct gbphy_device *gdev)
> > >   {
> > > @@ -45,7 +48,10 @@ struct gbphy_driver {
> > >   	struct device_driver driver;
> > >   };
> > >
> > > -#define to_gbphy_driver(d) container_of(d, struct gbphy_driver, driver)
> > > +static inline struct gbphy_driver *to_gbphy_driver(struct device_driver
> > > *d)
> > > +{
> > > +	return container_of(d, struct gbphy_driver, driver);
> > > +}
> > >
> > >   int gb_gbphy_register_driver(struct gbphy_driver *driver,
> > >   			     struct module *owner, const char *mod_name);
> > > --
> > > 2.34.1
> > >
> > >
>
--8323329-1218776436-1679259352=:2867--
