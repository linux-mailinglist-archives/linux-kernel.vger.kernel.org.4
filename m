Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374F17446E8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 08:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjGAG1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 02:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGAG1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 02:27:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A382118
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 23:27:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 044C660E97
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 06:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780A1C433C7;
        Sat,  1 Jul 2023 06:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688192854;
        bh=av0gL1txWFCp5mU6lKrWfy4/ZMa57bFOylnrU67vOO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JuDjpFLymp3OKv9NlRLiTKOBvSe6nvRL8OZfy7V5JaXdVgVCmKl29aB585KzhA4R8
         q06Jj8/4c/IGYn1kiPnp3kWb6PHilLgC2t5ws9d0WUuOwyQONLjAbup8XWtrhPfTjn
         f9Ga//342W34nzSXF+F1FvAJETyjyjsMKGRWJkBkRcLjmS4wSl/NpPJJ+dYtXMkwEu
         8T8Ldq+XW19fZr1WkO4Q4d5FUJI8GDCcp5fenCCc44NI+dkqn7mygBGF29GzbtZohl
         cwCM/KaFc/Y55qr7nvYuXQHRmaoxELsBHR5UJ8dCb9HLsQF09LCsV2c6iCujlfZiVB
         XqeNvvXi7AfZg==
Date:   Sat, 1 Jul 2023 08:27:25 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] pid: use flex array
Message-ID: <20230701-sackgasse-affront-3eb55b35bf62@brauner>
References: <20230628-pokal-puzzeln-5199c679b051@brauner>
 <CAHk-=wiBXJOzkez2Rd=cQ5ckttJq6OdYtArFmCtVQHyeuQBGrw@mail.gmail.com>
 <20230630-testphasen-orangen-0e54486a267d@brauner>
 <CAHk-=whJJbmfBk_8v_vFn1NdJ9O-AKCrjY+EArkzgFp9h-sKHA@mail.gmail.com>
 <20230630-stiefel-rotor-7f2d13fc084f@brauner>
 <202306300950.2BE7567101@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202306300950.2BE7567101@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 09:59:47AM -0700, Kees Cook wrote:
> On Fri, Jun 30, 2023 at 10:04:14AM +0200, Christian Brauner wrote:
> > On Fri, Jun 30, 2023 at 12:12:22AM -0700, Linus Torvalds wrote:
> > > On Thu, 29 Jun 2023 at 23:51, Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > I have no preference for either syntax. Both work. But this is probably
> > > > more an objection to this being mixed in with the flex array change in
> > > > the first place.
> > > 
> > > Yes. I looked at it, and tried to figure out if it was related
> > > somehow, and decided that no, it can't possibly be, and must be just
> > > an unrelated change.
> 
> Yes, those changes were style changes because I was annoyed that a grep
> for 'numbers[' didn't turn anything up. :P Since it's an array I think
> it's just good form to use [] when accessing an element. But yes, it's
> conceptually the same.
> 
> > > > I did react to that in the original review here:
> > > > https://lore.kernel.org/all/20230518-zuneigen-brombeeren-0a57cd32b1a7@brauner
> > > > but then I grepped for it and saw it done in a few other places already
> > > 
> > > Yeah, we do end up growing new uses of 'use 0 as a pointer' almost as
> > > quickly as we get rid of them.
> 
> Apologies on this -- this patch was just before the addition of
> struct_size_t(), so I missed it in the cleanup I did for that:
> https://git.kernel.org/linus/d67790ddf0219aa0ad3e13b53ae0a7619b3425a2
> 
> > I've grepped around a bit and I saw that the
> > struct_size((struct bla *)NULL, ...)
> > pattern seems to be used in most places that have similar needs. Not
> > sure if there's something nicer.
> 
> The above patch fixes them all (excepting struct pid). In retrospect, I
> should have asked to carry the struct pid fix in the hardening tree due
> to that.
> 
> > I gave this thing a stab myself since I have a few minutes and so Kees
> > doesn't have to do it. Authorship retained and dropped the ack. Is the
> > following more acceptable? 
> 
> Thanks for reworking it!
> 
> > [...]
> > [brauner: dropped unrelated changes and remove 0 with NULL cast]
> 
> However, this should use struct_size_t(); I'll send a new patch and
> double check that UBSAN stays happy, etc.

I think Linus already applied it let me quickly send a follow-up
replacing the two open-coded cases with struct_size_t(). I didn't know
this existed and I think when you originally send the patch it didn't.
