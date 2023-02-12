Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1817693863
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 17:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjBLQQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 11:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBLQQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 11:16:02 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368FA11E85;
        Sun, 12 Feb 2023 08:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CHrkE+AO8swdhzwvPAVQ5Sst+Jaxn4Ygk6fRQa3qEuE=;
  b=do8Skm6y8EAbSeycz56sEaX8P3RZO8ufy0wpHzdbA6CkyDOrIeyJp0Lp
   ePzkecQVbqSRNUTQ75Xulfv8P81xrtO0RiWEqf/R8ixxzHm0HKaUGApmH
   aYum46DUiwLplhrZDsUX00ZFdkcj3n7VRfZmWHNi/6/m3Ql9Rc5BwSM1T
   E=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.97,291,1669071600"; 
   d="scan'208";a="92320051"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2023 17:15:58 +0100
Date:   Sun, 12 Feb 2023 17:15:58 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Deepak R Varma <drv@mailo.com>
cc:     Julia Lawall <julia.lawall@inria.fr>,
        Bart Van Assche <bvanassche@acm.org>,
        Michael Reed <mdr@sgi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH] scsi: qla1280: Replace arithmetic addition by bitwise
 OR
In-Reply-To: <Y+kE0oWExkE6sLnH@ubun2204.myguest.virtualbox.org>
Message-ID: <alpine.DEB.2.22.394.2302121715090.9268@hadrien>
References: <Y+I7/QpQYjBXutLf@ubun2204.myguest.virtualbox.org> <aed35866-507c-870c-7e8a-c1868bcaa084@acm.org> <Y+kA1j10JCsLG9mN@ubun2204.myguest.virtualbox.org> <alpine.DEB.2.22.394.2302121611010.9268@hadrien>
 <Y+kE0oWExkE6sLnH@ubun2204.myguest.virtualbox.org>
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



On Sun, 12 Feb 2023, Deepak R Varma wrote:

> On Sun, Feb 12, 2023 at 04:11:58PM +0100, Julia Lawall wrote:
> >
> >
> > On Sun, 12 Feb 2023, Deepak R Varma wrote:
> >
> > > On Sat, Feb 11, 2023 at 03:25:03PM -0800, Bart Van Assche wrote:
> > > > On 2/7/23 03:54, Deepak R Varma wrote:
> > > > > When adding two bit-field mask values, an OR operation offers higher
> > > > > performance over an arithmetic operation. So, convert such addition to
> > > > > an OR based expression.
> > > >
> > > > Where is the evidence that supports this claim? On the following page I read
> > > > that there is no performance difference when using a modern CPU: https://cs.stackexchange.com/questions/75811/why-is-addition-as-fast-as-bit-wise-operations-in-modern-processors
> > > >
> > >
> > > Hello Bart,
> > > You are correct. Modern CPU designs have improved addition and the performance
> > > is at par with the bitwise operation. The document I had read earlier mentioned
> > > a performance improvement for old CPUs and microprocessors, which today is not
> > > the case. Thank you for sharing the link.
> > >
> > > > > Issue identified using orplus.cocci semantic patch script.
> > > >
> > > > Where is that script located? Can it be deleted such that submission of
> > > > patches similar to this patch stops?
> > >
> > > I have added Julia to this email to understand how to best use this semantic
> > > patch. I already discussed with her on improving the Semantic patch such that it
> > > doesn't suggest making change when constants are involved.
> >
> > FWIW, the semantic patch was never motivated by efficiency, but rather
> > with the goal of making the code more understandable.
>
> I think my interpretation of the patch log for [1] was not accurate. The line
> "Running time is divided by 3 ..." made me believe OR'ing would replace "F+A+R"
> instructions by a single operation. My bad.

Ah, interesting.  I have no idea any more the running time of what.

julia


>
> [1] https://lore.kernel.org/all/alpine.DEB.2.20.1711130649370.2483@hadrien/
>
> >
> > julia
>
>
>
