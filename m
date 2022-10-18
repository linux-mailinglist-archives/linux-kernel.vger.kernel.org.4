Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F41602C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiJRMtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiJRMtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:49:47 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06AF1CFC1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666097375; bh=mcNfGViPa1nukJmg0ZHFm4BFzsxE4YBbjOmUN6h9qTM=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=d5NlDzFPCc+RZvZfMaxC1viicgneMGJDK7MF4Bd/MlXQ5tuvoylv/FcNsNzjZ1Jag
         krkhmIdPITycMhC1y8AxBoXCDT5y5Ir0uDj67iGIVZCRxj+WI4EQocYApfC1UAc3gd
         207KJsmqgjE2jU80WSha9B+YTIDHZiGmOflsJuvQ=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via [213.182.55.206]
        Tue, 18 Oct 2022 14:49:35 +0200 (CEST)
X-EA-Auth: +r9ABO60O1ISKSBuuL1Ed8bnbZDXqKhyl7nYD7Ny+EorLFTw7URLzEVIXulCkiyRXhq+29o5AiAM7lyHEeh6STqQ+43r2eXL
Date:   Tue, 18 Oct 2022 18:19:30 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kumarpraveen@linux.microsoft.com, saurabh.truth@gmail.com
Subject: Re: [PATCH v2] staging: most: dim2: read done_buffers count locally
 from HDM channel
Message-ID: <Y06g2llpa5S/025M@debian-BULLSEYE-live-builder-AMD64>
References: <Y05TNQBXLMJMgQ2r@debian-BULLSEYE-live-builder-AMD64>
 <1e2a71a9-4ac5-96f3-b875-a063ff62f3ad@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e2a71a9-4ac5-96f3-b875-a063ff62f3ad@inria.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 09:39:08AM +0200, Julia Lawall wrote:
>
>
> On Tue, 18 Oct 2022, Deepak R Varma wrote:
>
> > The done_buffer count is already available in the hdm_channel struct.
> > Calling dim_get_channel_state function to source this value out of
> > the same structure is unnecessary.
> > Further, the second parameter struct dim_ch_state_t to this function
> > is filled by using the hdm_channel inside the function. This filled in
> > variable is never used in the caller and can be altogether removed.
> > So, a call to dim_get_channel_state function in this context also
> > deems expensive.
>
> Thanks for the rewrite.
>
> I find "source this value out of" hard to understand.
>
> I would have written something like the following:
>
> The function dim_get_channel_state only serves to initialize the ready and
> done_buffers fields of the structure passed as its second argument.  In
> service_done_flag, this structure is never used again and the only purpose
> of the call is to get the value that is put in the done_buffers field.
> But that value is just the done_sw_buffers_number field of the call's
> first argument.  So the whole call is useless, and we can just replace it
> with an access to this field.
>
> This change implies that the variable st is no longer used, so drop it as
> well.

This is really well written. Sounds much structured. Now my own log message
sounds a little random :)

Is it okay for me to use your verbiage as is in my patch log?

Thank you,
./drv


>
> ---
>
> If you want to work some more in this code, the name of the type
> dim_ch_state_t should not have an _t at the end of it.  It looks like it
> used to be a typedef and someone eliminated the typedef but didn't drop
> the _t.
>
> julia
>
>
> >
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > ---
> > Changes in v2:
> >    1. Update patch log message to be more descriptive about the reason for change.
> >       Feedback provided by julia.lawall@inria.fr
> >
> > PLEASE NOTE: I have only built the module on my machine, but have not tested it.
> > I am not sure how to test this change. I am willing to test it with appropriate
> > guidance provided I have the necessary hardware.
> >
> >
> >  drivers/staging/most/dim2/dim2.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
> > index ab72e11ac5ab..4c1f27898a29 100644
> > --- a/drivers/staging/most/dim2/dim2.c
> > +++ b/drivers/staging/most/dim2/dim2.c
> > @@ -259,7 +259,6 @@ static void retrieve_netinfo(struct dim2_hdm *dev, struct mbo *mbo)
> >  static void service_done_flag(struct dim2_hdm *dev, int ch_idx)
> >  {
> >  	struct hdm_channel *hdm_ch = dev->hch + ch_idx;
> > -	struct dim_ch_state_t st;
> >  	struct list_head *head;
> >  	struct mbo *mbo;
> >  	int done_buffers;
> > @@ -271,7 +270,7 @@ static void service_done_flag(struct dim2_hdm *dev, int ch_idx)
> >
> >  	spin_lock_irqsave(&dim_lock, flags);
> >
> > -	done_buffers = dim_get_channel_state(&hdm_ch->ch, &st)->done_buffers;
> > +	done_buffers = hdm_ch->ch.done_sw_buffers_number;
> >  	if (!done_buffers) {
> >  		spin_unlock_irqrestore(&dim_lock, flags);
> >  		return;
> > --
> > 2.30.2
> >
> >
> >
> >
> >


