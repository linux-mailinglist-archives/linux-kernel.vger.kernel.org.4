Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D55743551
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 08:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjF3Gv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 02:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjF3GvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 02:51:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6621E2D70
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 23:51:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04DF560FA6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 06:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C62CC433C8;
        Fri, 30 Jun 2023 06:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688107881;
        bh=k5e9uS8wK6DF17vzHcXE1VgFRnGn9fSubOCS5ZPoAl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hw5F5rVnQL0XF6rJqlkmXVY0T7kCE+XCyG7peIg5HLkZuoZEvItPxnrTJmWltiZ5J
         xQCfZ5ScoSp490jD4Kuv3ebaddT2cExwcL1n3FdlRWVJzKPE98RtkpKJDGjAbGZmz7
         jHuo3mOMDk3fWlB6nOOTWsNSoODqTuLbTlXdGgV+zm4+DtVke2OOf0QGF1IRaxIGFm
         FESLWDoyzvVVNXYliLEJvztNvX5/ys+qOQYkIAtKg7URxbiAQwC9riDSAU2tGGGb2I
         WFB/gvFBNL7Kfq2vDYWjikks1eRRMrTddgRsos5FswxNFii9LihlVOFUCQh78L2o5T
         qkJfPE9I8/NVg==
Date:   Fri, 30 Jun 2023 08:51:17 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] pid: use flex array
Message-ID: <20230630-testphasen-orangen-0e54486a267d@brauner>
References: <20230628-pokal-puzzeln-5199c679b051@brauner>
 <CAHk-=wiBXJOzkez2Rd=cQ5ckttJq6OdYtArFmCtVQHyeuQBGrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wiBXJOzkez2Rd=cQ5ckttJq6OdYtArFmCtVQHyeuQBGrw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 04:52:43PM -0700, Linus Torvalds wrote:
> On Wed, 28 Jun 2023 at 03:37, Christian Brauner <brauner@kernel.org> wrote:
> >
> > This contains Kees' work to make struct upid in struct pid a proper
> > flexible array and thus gets rid of a bunch of syzbot UBSAN warnings.
> 
> Hmm. Of this, about half were replacing "array + index" with "&array[index]".
> 
> Honestly, it makes no difference, but the reverse is also true: the
> "array + index" is *very* traditional, and if people have problems
> with that simple syntax I really don't know what to say. It's kind of
> core C. It's *literally* how arrays work, and what the '[]' operator
> means.

I have no preference for either syntax. Both work. But this is probably
more an objection to this being mixed in with the flex array change in
the first place.

> 
> And of the remaining half, half again is using a truly disgusting
> 
>     struct_size((struct pid *)0, numbers, X)

I did react to that in the original review here:
https://lore.kernel.org/all/20230518-zuneigen-brombeeren-0a57cd32b1a7@brauner
but then I grepped for it and saw it done in a few other places already
which is why I didn't ask for it to be changed. See commits
48658213202c ("scsi: megaraid_sas: Use struct_size() in code related to struct MR_PD_CFG_SEQ_NUM_SYNC") 
5b12a568cc6f ("scsi: hptiop: Use struct_size() helper in code related to struct hpt_iop_request_scsi_command"
as examples.

> 
> thing. That is *GARBAGE*. It's garbage for too many reasons for me to
> actually pull this sh*t, but let me just name them:
> 
>  - 0 isn't a pointer. Stop doing that.
> 
>  - dammit, we have 'struct_size_t' that does the above disgusting cast
> without getting that simple thing wrong.
> 
> In other words, this pull request contained half pointless and
> unrelated churn, and 25% actual garbage.
> 
> In other words, I'm not pulling this to just get the remaining 25%.

Sure. @Kees, I'd appreciate it if you could change the patch according
to the comments here.
