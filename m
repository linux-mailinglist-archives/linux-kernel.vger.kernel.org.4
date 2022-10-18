Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3B36023D1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 07:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiJRFff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 01:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiJRFfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 01:35:32 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D799DFA7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 22:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WGHCb8AIms3d2souoSL3bwIlmxeeKPQhnaBM5CbNDV0=;
  b=bNhjvKjCd3c3h7qxU85bvJ8uoaX5ATWLQD7BT0kpOjeB7G9TqpB119Jv
   +h2I3W5tz3GrpvfBsjHKBMySx24Cn+AecEd58YIVSZu/Vc1ut0HKWaw2+
   8X03yWH1S+BMw+YR65nlsD9o/XSL2/67rksT970bVUfLWnY+wQfotyWQE
   k=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,193,1661810400"; 
   d="scan'208";a="65619245"
Received: from 51.123.68.85.rev.sfr.net (HELO hadrien) ([85.68.123.51])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 07:35:29 +0200
Date:   Tue, 18 Oct 2022 07:35:29 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Deepak R Varma <drv@mailo.com>
cc:     outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kumarpraveen@linux.microsoft.com, saurabh.truth@gmail.com
Subject: Re: [PATCH] staging: most: dim2: read done_buffers count locally
 from HDM channel
In-Reply-To: <Y03DpMMiOsedm6Dl@lion2204>
Message-ID: <alpine.DEB.2.22.394.2210180733330.2938@hadrien>
References: <Y022wjdPGYwyx7lB@debian-BULLSEYE-live-builder-AMD64> <alpine.DEB.2.22.394.2210172255250.16433@hadrien> <Y03DpMMiOsedm6Dl@lion2204>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 18 Oct 2022, Deepak R Varma wrote:

> On Mon, Oct 17, 2022 at 10:56:03PM +0200, Julia Lawall wrote:
> >
> >
> > On Tue, 18 Oct 2022, Deepak R Varma wrote:
> >
> > > The done_buffer count can be directly read from HDM channel instead of
> > > calling the dim_get_channel_state function. This change also results in
> > > obsoleting the dim_channel_state local structure variable.
> > >
> > > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > > ---
> > >
> > > PLEASE NOTE: I have only built the module on my machine, but have not tested it.
> > > I am not sure how to test this change. I am willing to test it with appropriate
> > > guidance provided I have the necessary hardware.
> >
> > For non experts, maybe it would be helpful to explain what motivated you
> > to do this?
>
> I was actually trying to understand the implementation of this module to
> determine if I can replace BUG_ON calls by WARN_ON_ONCE. A "ctrl+]" navigation
> took me to this function and I started wondering about why the function call
> would be necessary. Hence the change.

OK, I agree with you that this story might not be super interesting.

But the log message still seems too concise.  You have acquired some
knowledge about why this changeis correct, but that knowledge is not at
all reflected in the log message.  Try to explain in more detail why the
function call is not necessary.

julia

>
> While reading the Documentation under dim2 directory, I realised this module may
> need a specialised hardware for testing [automotive???]. Hence I was not sure
> how to test the same.
>
> Are you suggesting I mention this in the patch description (the motivation)?
>
> Thank you,
> ./drv
>
> >
> > julia
> >
> > >
> > >  drivers/staging/most/dim2/dim2.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
> > > index ab72e11ac5ab..4c1f27898a29 100644
> > > --- a/drivers/staging/most/dim2/dim2.c
> > > +++ b/drivers/staging/most/dim2/dim2.c
> > > @@ -259,7 +259,6 @@ static void retrieve_netinfo(struct dim2_hdm *dev, struct mbo *mbo)
> > >  static void service_done_flag(struct dim2_hdm *dev, int ch_idx)
> > >  {
> > >  	struct hdm_channel *hdm_ch = dev->hch + ch_idx;
> > > -	struct dim_ch_state_t st;
> > >  	struct list_head *head;
> > >  	struct mbo *mbo;
> > >  	int done_buffers;
> > > @@ -271,7 +270,7 @@ static void service_done_flag(struct dim2_hdm *dev, int ch_idx)
> > >
> > >  	spin_lock_irqsave(&dim_lock, flags);
> > >
> > > -	done_buffers = dim_get_channel_state(&hdm_ch->ch, &st)->done_buffers;
> > > +	done_buffers = hdm_ch->ch.done_sw_buffers_number;
> > >  	if (!done_buffers) {
> > >  		spin_unlock_irqrestore(&dim_lock, flags);
> > >  		return;
> > > --
> > > 2.30.2
> > >
> > >
> > >
> > >
> > >
>
>
>
