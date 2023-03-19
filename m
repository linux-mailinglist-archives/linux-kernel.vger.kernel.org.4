Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60AA6C05F0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 23:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjCSWGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 18:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCSWGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 18:06:12 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63E21993
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 15:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=sKpc8UoVYkRRATUnZs9aTMR9xUcAPTL6ZVyrzuk+Ees=;
  b=COZEUTvl3savPYtWmuDlyMbuqMWrIgkndWs/gEWYduLxV1T0D2oduLLP
   VNI3MY2OyuOQoskDspGvfqfQCg1nol2ZL4tVFgy5x987oO8zbK7WJzgoq
   nJzrZwisqVHfMjEgMQi9awfeAtI4wxRlTO7LCe5oeIe3aFFDfmBsyffpw
   Y=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,274,1673910000"; 
   d="scan'208";a="50623142"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2023 23:06:08 +0100
Date:   Sun, 19 Mar 2023 23:06:07 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: greybus: use inline function for macros
In-Reply-To: <649afe06-e069-e046-21ec-0d86243a4bfa@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2303192303130.2867@hadrien>
References: <20230319201324.253874-1-eng.mennamahmoud.mm@gmail.com> <alpine.DEB.2.22.394.2303192121170.2867@hadrien> <0f02a3ff-801b-1e1f-5c03-009a05708709@gmail.com> <alpine.DEB.2.22.394.2303192151330.2867@hadrien> <402ffcbe-bb29-7035-68f4-2741532a6d67@gmail.com>
 <alpine.DEB.2.22.394.2303192225590.2867@hadrien> <649afe06-e069-e046-21ec-0d86243a4bfa@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-184533773-1679263568=:2867"
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

--8323329-184533773-1679263568=:2867
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 20 Mar 2023, Menna Mahmoud wrote:

>
> On ١٩/٣/٢٠٢٣ ٢٣:٢٦, Julia Lawall wrote:
> >
> > On Sun, 19 Mar 2023, Menna Mahmoud wrote:
> >
> > > On ١٩/٣/٢٠٢٣ ٢٢:٥٥, Julia Lawall wrote:
> > > > On Sun, 19 Mar 2023, Menna Mahmoud wrote:
> > > >
> > > > > On ١٩/٣/٢٠٢٣ ٢٢:٢١, Julia Lawall wrote:
> > > > > > On Sun, 19 Mar 2023, Menna Mahmoud wrote:
> > > > > >
> > > > > > > Convert `to_gbphy_dev` and `to_gbphy_driver` macros into a
> > > > > > > static inline functions.
> > > > > > >
> > > > > > > it is not great to have macro that use `container_of` macro,
> > > > > > > because from looking at the definition one cannot tell what type
> > > > > > > it applies to.
> > > > > > >
> > > > > > > One can get the same benefit from an efficiency point of view
> > > > > > > by making an inline function.
> > > > > > >
> > > > > > > Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> > > > > > > Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
> > > > > > > ---
> > > > > > >     drivers/staging/greybus/gbphy.h | 10 ++++++++--
> > > > > > >     1 file changed, 8 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/staging/greybus/gbphy.h
> > > > > > > b/drivers/staging/greybus/gbphy.h
> > > > > > > index 1de510499480..42c4e3fe307c 100644
> > > > > > > --- a/drivers/staging/greybus/gbphy.h
> > > > > > > +++ b/drivers/staging/greybus/gbphy.h
> > > > > > > @@ -16,7 +16,10 @@ struct gbphy_device {
> > > > > > >     	struct device dev;
> > > > > > >     };
> > > > > > >
> > > > > > You have made the patch against your previous patch that added a
> > > > > > newline
> > > > > > here.  It should be against Greg's tree.
> > > > > >
> > > > > > julia
> > > > > you mean I should remove this newline, right?
> > > > You should apply your change to the state of Greg's tree, not the state
> > > > after your patch.
> > > >
> > > > Assuming that you have committed both the patch adding the new line and
> > > > the patch changing the macro to a function, and have made no other
> > > > changes, you can do git rebase -i HEAD~2 and the put a d at the
> > > > beginning
> > > > of the line related to the patch adding the newline.
> > >
> > > you mean drop this patch "staging: greybus: remove unnecessary blank
> > > line"?
> > No, the one that removes the blank line looks fine.
> >
> > At some point, you added a blank line below the two structure definitions.
> > That blank line is not in Greg's tree, so you shoulsn't send a patch that
> > assumes that it is there.
>
>
> I'm sorry I mean this patch "staging: greybus: add blank line after struct",
> Julia I understood the issue
>
> but I am confused about how to fix it, should I drop the patch that added the
> newline? then what should I do?

If the git rebase solution is not clear to you, then another simple
solution is just to clone Greg's tree again somewhere else, and make your
changes.

> and version that I have submitted, should I do anything about it as you said
> it is wrong solution?

My concern was the blank line after each of the structure definitions,
which is not in Greg's tree, so he can't apply the patch.  Other than
that, if the code compiles it is at least going in the right direction.

Please fix the newlines issue, and then send the patch again.

julia


>
>
> Menna
>
> > julia
> >
> > > Menna
> > >
> > >
> > > > If you have made
> > > > more changes, you can adapt the HEAD~ part accordingly.
> > > >
> > > > julia
> > > >
> > > >
> > > > > Menna
> > > > >
> > > > > > > -#define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
> > > > > > > +static inline struct gbphy_device *to_gbphy_dev(const struct
> > > > > > > device
> > > > > > > *d)
> > > > > > > +{
> > > > > > > +	return container_of(d, struct gbphy_device, dev);
> > > > > > > +}
> > > > > > >
> > > > > > >     static inline void *gb_gbphy_get_data(struct gbphy_device
> > > > > > > *gdev)
> > > > > > >     {
> > > > > > > @@ -45,7 +48,10 @@ struct gbphy_driver {
> > > > > > >     	struct device_driver driver;
> > > > > > >     };
> > > > > > >
> > > > > > > -#define to_gbphy_driver(d) container_of(d, struct gbphy_driver,
> > > > > > > driver)
> > > > > > > +static inline struct gbphy_driver *to_gbphy_driver(struct
> > > > > > > device_driver
> > > > > > > *d)
> > > > > > > +{
> > > > > > > +	return container_of(d, struct gbphy_driver, driver);
> > > > > > > +}
> > > > > > >
> > > > > > >     int gb_gbphy_register_driver(struct gbphy_driver *driver,
> > > > > > >     			     struct module *owner, const char
> > > > > > > *mod_name);
> > > > > > > --
> > > > > > > 2.34.1
> > > > > > >
> > > > > > >
> > >
>
--8323329-184533773-1679263568=:2867--
