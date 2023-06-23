Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0752273C321
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 23:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjFWVp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 17:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjFWVpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 17:45:52 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1645A2139;
        Fri, 23 Jun 2023 14:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CbwxMU596UN3SHXGFCDkR8oQ2050lXlWn2EuGniSkS4=;
  b=EnKI3OerFqRJX9FzejlToSjLEGBQaFe4p1OYUsELEL5mz49EsMp7ZTrL
   0rRfmNl38pAAant36AUp5WyAldBAMH9gGcou0pN731+QmBCeBJ/fMisKG
   BNkUQ/FAz38XkMpHuBvR/jzmTPPzMuBlAOAw+Tqm5JEM5IyQ7cUIrX8cT
   I=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.01,153,1684792800"; 
   d="scan'208";a="59686842"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 23:45:49 +0200
Date:   Fri, 23 Jun 2023 23:45:48 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
cc:     Manivannan Sadhasivam <mani@kernel.org>, keescook@chromium.org,
        kernel-janitors@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/26] bus: mhi: host: use array_size
In-Reply-To: <3b4ff79b-93b4-cf56-1488-113905b3981d@quicinc.com>
Message-ID: <alpine.DEB.2.22.394.2306232340510.3129@hadrien>
References: <20230623211457.102544-1-Julia.Lawall@inria.fr> <20230623211457.102544-11-Julia.Lawall@inria.fr> <3b4ff79b-93b4-cf56-1488-113905b3981d@quicinc.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Jun 2023, Jeffrey Hugo wrote:

> On 6/23/2023 3:14 PM, Julia Lawall wrote:
> > Use array_size to protect against multiplication overflows.
> >
> > The changes were done using the following Coccinelle semantic patch:
> >
> > // <smpl>
> > @@
> >      expression E1, E2;
> >      constant C1, C2;
> >      identifier alloc = {vmalloc,vzalloc};
> > @@
> >      (
> >        alloc(C1 * C2,...)
> > |
> >        alloc(
> > -           (E1) * (E2)
> > +           array_size(E1, E2)
> >        ,...)
> > )
> > // </smpl>
> >
> > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> >
> > ---
> >   drivers/bus/mhi/host/init.c |    4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
> > index f72fcb66f408..34a543a67068 100644
> > --- a/drivers/bus/mhi/host/init.c
> > +++ b/drivers/bus/mhi/host/init.c
> > @@ -759,8 +759,8 @@ static int parse_ch_cfg(struct mhi_controller
> > *mhi_cntrl,
> >   	 * so to avoid any memory possible allocation failures, vzalloc is
> >   	 * used here
> >   	 */
> > -	mhi_cntrl->mhi_chan = vzalloc(mhi_cntrl->max_chan *
> > -				      sizeof(*mhi_cntrl->mhi_chan));
> > +	mhi_cntrl->mhi_chan = vzalloc(array_size(mhi_cntrl->max_chan,
> > +				      sizeof(*mhi_cntrl->mhi_chan)));
> >   	if (!mhi_cntrl->mhi_chan)
> >   		return -ENOMEM;
> >
> >
>
> This doesn't seem like a good fix.
>
> If we've overflowed the multiplication, I don't think we should continue, and
> the function should return an error.  array_size() is going to return
> SIZE_MAX, and it looks like it is possible that vzalloc() may be able to
> allocate that successfully in some scenarios. However, that is going to be
> less memory than parse_ch_cfg() expected to allocate, so later on I expect the
> function will still corrupt memory - basically the same result as what the
> unchecked overflow would do.
>
> I'm not convinced the semantic patch is bringing value as I suspect most of
> the code being patched is in the same situation.

OK, this just brings the code in line with all the calls updated by Kees's
original patch, cited in the cover letter, which were all the
calls containing a multiplication that existed at the time.

42bc47b35320 ("treewide: Use array_size() in vmalloc()")
fad953ce0b22 ("treewide: Use array_size() in vzalloc()")

julia

>
> -Jeff
>
