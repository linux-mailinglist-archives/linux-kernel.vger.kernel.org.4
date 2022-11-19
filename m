Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AECE630AD5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 03:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbiKSCtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 21:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbiKSCti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 21:49:38 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5BEA5723
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 18:32:03 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 8213AC009; Sat, 19 Nov 2022 03:32:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1668825128; bh=4Yjd5xMaWArHs/hCZzzkqikKWyQam6jbgmCv2vrnQpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LPqodueTv8W769nsonfh2NGZzhx/lbcySLdAbL/SpUyKbjEE7Y6yRdt5BYzmLiQhv
         Z3xk2Hy/upLOu7/Xa2zGiVECtCF20zVBnFfRYETSnDivcrX2+I/vxUow6CfR6H4d7T
         7+IPinfuQxlBpbNDhaNO9DZUq7dDLXdBnnL/P77l7f/R2T16dXIsl7edpHZeVO1a+J
         PDUKmxo+oRMKjzYAC78Ow2sYGtu+HzXFQDzjOrKzWPs7fykyWBKvGiW5pZPlkyRQFm
         ngkiFOCO4UJNC/sCaT4kNiN22S8AhrLHP3QxGGSoOJfIxP8wrn6G/f29GNDJEsVZtd
         A+z4/nGPTea1w==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 28A2FC009;
        Sat, 19 Nov 2022 03:32:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1668825127; bh=4Yjd5xMaWArHs/hCZzzkqikKWyQam6jbgmCv2vrnQpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IHEs1h6ctHt0nRgXNeQ3yrzm5E2Q5TQ3S57o/LVHvzw39TgT/xz3eUn8IngZl5G2r
         cuTISAGGigVoqiOOfN26H/EaIpLy0dkZwNoQOEmIY3IL9fdLLA0g1bt9l3aEVxU/16
         52bYP4wGmpRvcth1DLRhE3fVd8KsV+/xrYkyr5R7xqGoLELxHLKaOW8Arn4UXIzjwj
         xBoWm+9orPMIi3wPtpwndFiIWhkJGD7DH7aDrvOwSr33GBW6siCklUjuWn8vVk/B5f
         /MLF77j8AZFex3qfzGpswyyMVZMTs4BK2En47LIprm0vUt1Qq0FhhedhicOZVr8/+r
         +DQWvrqwhGDxQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id f316aa44;
        Sat, 19 Nov 2022 02:31:56 +0000 (UTC)
Date:   Sat, 19 Nov 2022 11:31:41 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     GUO Zihua <guozihua@huawei.com>, linux_oss@crudebyte.com,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] 9p/xen: check logical size for buffer size
Message-ID: <Y3hADWgV9JeajmfF@codewreck.org>
References: <20221118135542.63400-1-asmadeus@codewreck.org>
 <alpine.DEB.2.22.394.2211181713420.1049131@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2211181713420.1049131@ubuntu-linux-20-04-desktop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot, that was fast!

Stefano Stabellini wrote on Fri, Nov 18, 2022 at 05:51:46PM -0800:
> On Fri, 18 Nov 2022, Dominique Martinet wrote:
> > trans_xen did not check the data fits into the buffer before copying
> > from the xen ring, but we probably should.
> > Add a check that just skips the request and return an error to
> > userspace if it did not fit
> > 
> > Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> > ---
> > 
> > This comes more or less as a follow up of a fix for trans_fd:
> > https://lkml.kernel.org/r/20221117091159.31533-1-guozihua@huawei.com
> > Where msize should be replaced by capacity check, except trans_xen
> > did not actually use to check the size fits at all.
> > 
> > While we normally trust the hypervisor (they can probably do whatever
> > they want with our memory), a bug in the 9p server is always possible so
> > sanity checks never hurt, especially now buffers got drastically smaller
> > with a recent patch.
> > 
> > My setup for xen is unfortunately long dead so I cannot test this:
> > Stefano, you've tested v9fs xen patches in the past, would you mind
> > verifying this works as well?
> > 
> >  net/9p/trans_xen.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
> > index b15c64128c3e..66ceb3b3ae30 100644
> > --- a/net/9p/trans_xen.c
> > +++ b/net/9p/trans_xen.c
> > @@ -208,6 +208,14 @@ static void p9_xen_response(struct work_struct *work)
> >  			continue;
> >  		}
> >  
> > +		if (h.size > req->rc.capacity) {
> > +			dev_warn(&priv->dev->dev,
> > +				 "requested packet size too big: %d for tag %d with capacity %zd\n",
> > +		                 h.size, h.tag, rreq->rc.capacity);
> 
> "req" instead of "rreq"

ugh, sorry for that. I didn't realize I have NET_9P_XEN=n on this
machine ... /facepalm

I'm lazy so won't bother sending a v2:
https://github.com/martinetd/linux/commit/ebd09c8245aa15f15b273e9733e8ed8991db3682

I'll add your Tested-by tomorrow unless you don't want to :)


> I made this change and tried the two patches together. Unfortunately I
> get the following error as soon as I try to write a file:
> 
> /bin/sh: can't create /mnt/file: Input/output error
> 
> 
> Next I reverted the second patch and only kept this patch. With that, it
> worked as usual. It looks like the second patch is the problem. I have
> not investigated further.

Thanks -- it's now obvious I shouldn't send patches without testing
before bedtime...
I could reproduce easily with virtio as well, this one was silly as well
(>= instead of >). . . With another problem when zc requests get
involved, as we don't actually allocate more than 4k for the rpc itself.

If I adjust it to also check with the zc 'inlen' as follow it appears to
work:
https://github.com/martinetd/linux/commit/162015a0dac40eccc9e8311a5eb031596ad35e82
But that inlen isn't actually precise, and trans_virtio (the only
transport implementing zc rpc) actually takes some liberty with the
actual sg size to better fit hardwre, so that doesn't really make
sense either and we probably should just trust trans_virtio at this
point?

This isn't obvious, so I'll just drop this patch for now.
Checking witih msize isn't any good but it can wait till we sort it out
as transports now all already check this one way or another; I'd like to
get the actual fixes out first.

(Christian, if you have time to look at it and take over I'd appreciate
it, but there's no hurry.)


Thanks again and sorry for the bad patches!
-- 
Dominique
