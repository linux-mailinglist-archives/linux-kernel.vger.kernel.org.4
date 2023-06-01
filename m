Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C5A71EF77
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 18:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjFAQs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 12:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjFAQsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 12:48:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B1E18D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 09:48:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E81864789
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 16:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FEDC433EF;
        Thu,  1 Jun 2023 16:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685638101;
        bh=LXnkDTkz1SKqT0x81Y2GOyRdBeWkTbwqHBn8qS6LGFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V9uvnkAwm4gdxD24L445/PkX1e77g1eiZH7cVy6Ob7zFqoG0PPxvERlqorV0WPwc2
         dVdtj5swlzdh9t+51Ic4FBiR92OGrfL2V05l1N1sFThj/OKzzTQwMfY4QcYqtHDphx
         ZXU4IH9X4ee9vUr4wvYi+rJlinI6dbgBHl2zlw6nWq+UwNBgHHD6onV577z8jn/LQS
         LZdyjmSbbHI9wkEaXyA5FAEQRYraT/9diRWXus6KmybCQdjd5+Aij6LRCbxO78Tf80
         cDHZ7YPNA/aKUEdivGQnM9cqDQUHRJeTU3HOaFQPWU2gfp+6huMWBSTE5/SGr5qimL
         sY4vDsOhKz79A==
Date:   Thu, 1 Jun 2023 17:48:17 +0100
From:   Lee Jones <lee@kernel.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>, xiyou.wangcong@gmail.com,
        jiri@resnulli.us, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH 1/1] net/sched: cls_u32: Fix reference counter leak
 leading to overflow
Message-ID: <20230601164817.GH449117@google.com>
References: <20230531141556.1637341-1-lee@kernel.org>
 <CANn89iJw2N9EbF+Fm8KCPMvo-25ONwba+3PUr8L2ktZC1Z3uLw@mail.gmail.com>
 <CAM0EoMnUgXsr4UBeZR57vPpc5WRJkbWUFsii90jXJ=stoXCGcg@mail.gmail.com>
 <20230601140640.GG449117@google.com>
 <CANn89i+j7ymO2-wyZtavCotwODdgOAcJ5O_GFjLkegqAsx4F5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+j7ymO2-wyZtavCotwODdgOAcJ5O_GFjLkegqAsx4F5A@mail.gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2023, Eric Dumazet wrote:

> On Thu, Jun 1, 2023 at 4:06 PM Lee Jones <lee@kernel.org> wrote:
> >
> > On Wed, 31 May 2023, Jamal Hadi Salim wrote:
> >
> > > On Wed, May 31, 2023 at 11:03 AM Eric Dumazet <edumazet@google.com> wrote:
> > > >
> > > > On Wed, May 31, 2023 at 4:16 PM Lee Jones <lee@kernel.org> wrote:
> > > > >
> > > > > In the event of a failure in tcf_change_indev(), u32_set_parms() will
> > > > > immediately return without decrementing the recently incremented
> > > > > reference counter.  If this happens enough times, the counter will
> > > > > rollover and the reference freed, leading to a double free which can be
> > > > > used to do 'bad things'.
> > > > >
> > > > > Cc: stable@kernel.org # v4.14+
> > > >
> > > > Please add a Fixes: tag.
> >
> > Why?
> 
> How have you identified v4.14+ ?
> 
> Probably you did some research/"git archeology".
> 
> By adding the Fixes: tag, you allow us to double check immediately,
> and see if other bugs need to be fixed at the same time.
> 
> You can also CC blamed patch authors, to get some feedback.
> 
> Otherwise, we (people reviewing this patch) have to also do this
> research from scratch.
> 
> In this case, it seems bug was added in
> 
> commit 705c7091262d02b09eb686c24491de61bf42fdb2
> Author: Jiri Pirko <jiri@resnulli.us>
> Date:   Fri Aug 4 14:29:14 2017 +0200
> 
>     net: sched: cls_u32: no need to call tcf_exts_change for newly
> allocated struct
> 
> 
> A nice Fixes: tag would then be
> 
> Fixes: 705c7091262d ("net: sched: cls_u32: no need to call
> tcf_exts_change for newly allocated struct")

Thanks for digging this out.  I will add it.

-- 
Lee Jones [李琼斯]
