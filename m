Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8C9602E27
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiJROTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiJROTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:19:34 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EA81208E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 07:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cCRaxklUvxnSi60g8voGB/anaEKMC6SfCcBfXnQB/rE=;
  b=mvxdlhCbE3VbDXGUFqT+XRrcpxeUAluwLRih+ewFnnEshC7f/aDgYwrr
   UUTlkvczyX8q0irI73Hs/F0/FPc6MJk/UBavmi1Iok6C3m+/keLQ4z3d7
   yhZeBhPn6RgZdxrFitvGQazUy9VEocoJ/mzmLSRqhGDw8rNoEGGPvFnpu
   A=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,193,1661810400"; 
   d="scan'208";a="65773550"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 16:19:30 +0200
Date:   Tue, 18 Oct 2022 16:19:30 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Deepak R Varma <drv@mailo.com>
cc:     outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kumarpraveen@linux.microsoft.com, saurabh.truth@gmail.com
Subject: Re: [PATCH v2] staging: most: dim2: read done_buffers count locally
 from HDM channel
In-Reply-To: <Y06uqcQmtJATZ6YH@debian-BULLSEYE-live-builder-AMD64>
Message-ID: <3791d7e3-177-d8a1-ed22-3767786b19fc@inria.fr>
References: <Y05TNQBXLMJMgQ2r@debian-BULLSEYE-live-builder-AMD64> <1e2a71a9-4ac5-96f3-b875-a063ff62f3ad@inria.fr> <Y06g2llpa5S/025M@debian-BULLSEYE-live-builder-AMD64> <80696861-c73f-cdb9-b4e1-36c29ece78bb@inria.fr>
 <Y06uqcQmtJATZ6YH@debian-BULLSEYE-live-builder-AMD64>
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

> On Tue, Oct 18, 2022 at 02:52:21PM +0200, Julia Lawall wrote:
> >
> >
> > On Tue, 18 Oct 2022, Deepak R Varma wrote:
> >
> > > On Tue, Oct 18, 2022 at 09:39:08AM +0200, Julia Lawall wrote:
> > > >
> > > >
> > > > On Tue, 18 Oct 2022, Deepak R Varma wrote:
> > > >
> > > > > The done_buffer count is already available in the hdm_channel struct.
> > > > > Calling dim_get_channel_state function to source this value out of
> > > > > the same structure is unnecessary.
> > > > > Further, the second parameter struct dim_ch_state_t to this function
> > > > > is filled by using the hdm_channel inside the function. This filled in
> > > > > variable is never used in the caller and can be altogether removed.
> > > > > So, a call to dim_get_channel_state function in this context also
> > > > > deems expensive.
> > > >
> > > > Thanks for the rewrite.
> > > >
> > > > I find "source this value out of" hard to understand.
> > > >
> > > > I would have written something like the following:
> > > >
> > > > The function dim_get_channel_state only serves to initialize the ready and
> > > > done_buffers fields of the structure passed as its second argument.  In
> > > > service_done_flag, this structure is never used again and the only purpose
> > > > of the call is to get the value that is put in the done_buffers field.
> > > > But that value is just the done_sw_buffers_number field of the call's
> > > > first argument.  So the whole call is useless, and we can just replace it
> > > > with an access to this field.
> > > >
> > > > This change implies that the variable st is no longer used, so drop it as
> > > > well.
> > >
> > > This is really well written. Sounds much structured. Now my own log message
> > > sounds a little random :)
> > >
> > > Is it okay for me to use your verbiage as is in my patch log?
> >
> > Yes.
>
> Thank you. Can I convert this into a patch set and include the other suggestion
> from you to correct the dim_ch_state_t struct name? Or should these be separate
> patches now?

You can make a patch set.

julia
