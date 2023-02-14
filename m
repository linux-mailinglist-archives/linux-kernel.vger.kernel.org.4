Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA94695625
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 02:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjBNBv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 20:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBNBv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 20:51:56 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611CD1A959;
        Mon, 13 Feb 2023 17:51:51 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id cr22so16056597qtb.10;
        Mon, 13 Feb 2023 17:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkTJn3uf21EPg3MCnyz6TOTyxt2iX4bK5WgtTSJgg68=;
        b=pS9JjTQn+zbd6S7TKJ0l48sZsS9i1CW7jAtb0ej9pBly7xntBS41dlf6Crfsv2FbYs
         c4I/bW+IJFzo/s/E1XhiutMJ8/B92gcg8fb8pDlykMoEZi57m4tTs0ja+JLja5bMhtWK
         YZpwD6WJLBaa8kyT4T85GFidLvEGn4z/2aeBqeSY83ZSzuiy55rg0GhpYK+vipDFWzR1
         F74hgYK5vGlYtGQBNObC+ZT4e2tCr1CV2vKrweqCRZpdKN0qiV0g2QGZ4QV41j4wcSWS
         M0IOG/tG59TOs2HvVOnQ8xf2Q1JIfhKdWI0BgWi/9OfmiiEEYpxHKordiM1JCVslgaOn
         Mhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkTJn3uf21EPg3MCnyz6TOTyxt2iX4bK5WgtTSJgg68=;
        b=5OQr5Oj5JqxT1EXdS2xTlQbu05WDKk6PoLs4otlg/YJVwE0/lSO/ZuYVokTGTOtcDs
         TPck5QZd7/RCmPQxjihMY89KZ/4zz6X6SWnpqFn+cg7U5uqE6oZthhRijyiljo9hAISN
         btch54ukYAyOfe3K+OZOq0YqSNiSgSt4Zc0G9gCAybJ/XBIYmNHNRL1zaY7N33qkeyM1
         WbExGrFVH2MOOiXK8fkYRLLULwFFpt1xPBN0kGB6fAHoHwptHnw2qxyUbV4vX0kli4pZ
         fJiHGbn/ElK01fYoEvFuVZLPs7DMIPYXbfOho4M+Dtx/i7qEW5tLYwTX17gZv5HZQkeU
         rn9A==
X-Gm-Message-State: AO0yUKVKuaSQp82HoUAFFDWIwJTyfXy01dwSOizAgT8jXozxRN5wPaeb
        UkQnFUCTDfIvp2szffq7E38=
X-Google-Smtp-Source: AK7set/ikbkswNwkHvhfsKdXsZgKvpHwyDe8/sLMv0oPpU8NqdAVbfoXXalFUiEdZDs9DT0J7U0YJg==
X-Received: by 2002:ac8:5f83:0:b0:3b9:bd75:9415 with SMTP id j3-20020ac85f83000000b003b9bd759415mr892786qta.41.1676339510542;
        Mon, 13 Feb 2023 17:51:50 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id y13-20020a05622a164d00b003b860983973sm10523148qtj.60.2023.02.13.17.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 17:51:49 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id E0F4A27C0054;
        Mon, 13 Feb 2023 20:51:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 13 Feb 2023 20:51:48 -0500
X-ME-Sender: <xms:M-nqYzhpTKeEx6dk4oN7-b_8w0tLs8HAGPU7_J6s1FXRIOfMFInU9A>
    <xme:M-nqYwA5p7kltI6ZtmGXC81G2Hk3C3mEKr5wKPNoSGiaZuSDqrMMFZtoMRQXIVMb8
    jfKSi-onlQhDzq2gg>
X-ME-Received: <xmr:M-nqYzGdyczyfc5WJzK6v8DRm79y3ttots8ofoWklBCZVvfr29m1SJIJ9pE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeivddgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:M-nqYwRgIQGgIp3RJsS9mkX5yH599nyKOAk8sqDwl9VI58B6hDgeGA>
    <xmx:M-nqYww-ba-ev5JoQNlqi_NlOVgA8VjKfBr9IAFVk3LceOu1ByRPzw>
    <xmx:M-nqY27POPO-O2iPuORIc1ko8cmJa-mCytuhH_cw9iBwY5HYwR6-zQ>
    <xmx:NOnqY1Iqh6DsVTiv1Gpih_ETroi3ymlPNheb3IYeDfLUrDl9NjJ3Ew>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Feb 2023 20:51:46 -0500 (EST)
Date:   Mon, 13 Feb 2023 17:51:11 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Coly Li <colyli@suse.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller <syzkaller@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH RFC] drivers/core: Replace lockdep_set_novalidate_class()
 with unique class keys
Message-ID: <Y+rpD7QPheQQ8Lxj@boqun-archlinux>
References: <109c3cc0-2c13-7452-4548-d0155c1aba10@gmail.com>
 <Y+gjuqJ5RFxwLmht@moria.home.lan>
 <Y+hRurRwm//1+IcK@rowland.harvard.edu>
 <Y+hTEtCKPuO0zGIt@moria.home.lan>
 <Y+hW74TAVzCpSv7c@rowland.harvard.edu>
 <Y+hYn6uzIUBaxDdV@moria.home.lan>
 <Y+kEgDLSRwdODRdD@rowland.harvard.edu>
 <Y+oBveWO2z6xdTW/@hirez.programming.kicks-ass.net>
 <Y+pWhyFJeE93nlWd@rowland.harvard.edu>
 <Y+plfZnEqw6mG+XH@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+plfZnEqw6mG+XH@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 05:29:49PM +0100, Peter Zijlstra wrote:
> On Mon, Feb 13, 2023 at 10:25:59AM -0500, Alan Stern wrote:
> > On Mon, Feb 13, 2023 at 10:24:13AM +0100, Peter Zijlstra wrote:
> > > On Sun, Feb 12, 2023 at 10:23:44AM -0500, Alan Stern wrote:
> > > > Provided it acquires the parent device's lock first, this is 
> > > > utterly safe no matter what order the children are locked in.  Try 
> > > > telling that to lockdep! 
> > > 
> > > mutex_lock_next_lock(child->lock, parent->lock) is there to express this
> > > exact pattern, it allows taking multiple child->lock class locks (in any
> > > order) provided parent->lock is held.
> > 
> > Ah, this is news to me.  Is this sort of thing documented somewhere?

Basically if you have two lock instances A and B with the same class,
and you know that locking ordering is always A -> B, then you can do

	mutex_lock(A);
	mutex_lock_nest_lock(B, A); // lock B.

to tell the lockdep this is not deadlock, plus lockdep will treat the
acquisition of A and the precondition of acquisition B, so the following
is not a deadlock as well:

T1:
	mutex_lock(A);
	mutex_lock(C);
	mutex_lock_nest_lock(B, A);

T2:
	mutex_lock(A);
	mutex_lock_nest_lock(B, A);
	mutex_lock(C);

Regards,
Boqun

> 
> Probably not :/

