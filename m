Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D3E68319C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbjAaPga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjAaPg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:36:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9CD4C6FF
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:36:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09E6861548
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 15:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDC2C433D2;
        Tue, 31 Jan 2023 15:36:25 +0000 (UTC)
Date:   Tue, 31 Jan 2023 10:36:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, chensong_2000@189.cn
Subject: Re: [PATCH v15 0/4] trace: Introduce objtrace trigger to trace the
 kernel object
Message-ID: <20230131103623.53a4e3a3@gandalf.local.home>
In-Reply-To: <CAEr6+EB89otsHVOnYNGQ_gbo_g=2fNiU4+3pk06YWFrpZDy=kQ@mail.gmail.com>
References: <20220819032706.695212-1-xiehuan09@gmail.com>
        <20221017154057.78babf40@gandalf.local.home>
        <CAEr6+ECqn7rABE0cJP_oPr6g37B1kXu2xpge7Pg67hxywqyO0g@mail.gmail.com>
        <20221129113006.0d745fae@gandalf.local.home>
        <CAEr6+EArZtwJPwZnKAB_61a=khPpC1=6ogqEC8r4npaaX0WvjA@mail.gmail.com>
        <CAEr6+EB89otsHVOnYNGQ_gbo_g=2fNiU4+3pk06YWFrpZDy=kQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2023 17:55:16 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

>  Hi Steve,
> 
> On Sat, Dec 17, 2022 at 4:27 PM Jeff Xie <xiehuan09@gmail.com> wrote:
> >
> > On Wed, Nov 30, 2022 at 12:30 AM Steven Rostedt <rostedt@goodmis.org> wrote:  
> > >
> > > On Wed, 30 Nov 2022 00:09:51 +0800
> > > Jeff Xie <xiehuan09@gmail.com> wrote:
> > >  
> > > > > Now instead of searching the function arguments for "obj", we should just
> > > > > read the obj value at every function and report when it changed, as well as
> > > > > the last function it was still the same. The report will be like the
> > > > > "func_repeats" entry. And instead we can print when the object changes,
> > > > > something like this:
> > > > >
> > > > >               cat-117     [002] ...2.     1.602245: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x2000 (last value:0x1000 at [002] __bio_add_page <-bio_add_page ts: 1.602245)  
> > > >
> > > >
> > > > I'm just curious if we'll see this rewritten version in the next merge
> > > > window  ;-)  
> > >
> > > Unfortunately, this ended up getting dropped in priority, as my workload
> > > increased internally. :-/  
> >  
> 
> I would like to ask if there is any hope that this patchset can be
> merged into the linux kernel in the end.
> 
> We spent a lot of time on this patchset, I don't want to give up so easily ;-)
> 

I think we were near the end, but it wasn't quite done, as I want it to be
integrated with the kprobes indirection interface:

  https://lore.kernel.org/all/20220924160136.5029e942@rorschach.local.home/

Which I started to work on but didn't have time to finish, nor even get
very far with it.

I think once we can get that implemented, then this can get in. I don't
want to give up on it either.

-- Steve
