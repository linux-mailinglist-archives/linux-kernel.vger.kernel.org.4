Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AB9674409
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjASVLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjASVJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:09:39 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C284A1E2;
        Thu, 19 Jan 2023 13:03:22 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ud5so9029475ejc.4;
        Thu, 19 Jan 2023 13:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9xP6tDygDWec39TUUGaeTbssNw3XEC6DgXn0Bd9aJxw=;
        b=DsAnZkH0Wy42aAqahWD7bdan3j9HBvvU93UbXsMLertzZfCBlZEpFGNeZbGxia23P3
         XJWkP4nhfpRdqulg7+VqmteqU2Gf6QTpwLTOYrNkSVLB7MLDAvkPcrh++TQQll6/O8qy
         g5TIbAqsAcFMqP36RITttbqbw09jkz6EbGHVYaMStUqDM8d8MbL0TDTZzBiLP5VA2dJC
         aqjsKOiSOJsHKDuGl+J9q/ntIX52E9ftuFIRIJQAmVM7IvdYsnwRPhz5+Jpdf6Hl6BXX
         WlqVVfyd31flTHc1pnqcXIjTjy+iD4B9kMZ5eonL3A1QH8ZTuLM4tL0grLsJ8KkK0huq
         uqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xP6tDygDWec39TUUGaeTbssNw3XEC6DgXn0Bd9aJxw=;
        b=UYuo0pmzcL2kJKae7LWm/JnsA42cn4D1Uq3rsGHcHozMlNwfCcqkcZtxL3UtMH2jVi
         OVPkKoH/2yRRDSbeS5UvzUl3oIwTFVk69gtBzJRC4z3pnHIOH+KfTDOCahRCFW0foa4E
         GKR3+eaH/dLS1M9v0E9imfLw1UnuPQdzQ8iswvxFN3Vm4ZbJimQfuUnHvTSfbt0a4p/F
         DWpkZLzOcVuMeGyp1lZch3ACHv7dKPul6dm2s8vWiTHLhRKtmUWg4u6yZ4WUn8sDqv7Y
         x7/HFDhQSdsG2OjiQDGMhh1IHv7z2Xk4Czm2N+XEskRBsv0PNWugne71XE1qwtBL4lKP
         SNQw==
X-Gm-Message-State: AFqh2kqAP6SJCqWLcxINYMrXKcvN0MSERMh4Dncw8sY6cgJZmP2w4CCE
        XJqb7Bg6WdxgvQQNvh/aV3I=
X-Google-Smtp-Source: AMrXdXsRnN7PuJq8qJ7ihPQ5nxhJYl6ugaJg6nwnP2IiNW4cdKKuXPzDHGCSGfouqCnwCKc7Uhrq4A==
X-Received: by 2002:a17:906:855:b0:86e:f88:c098 with SMTP id f21-20020a170906085500b0086e0f88c098mr13130517ejd.70.1674162201098;
        Thu, 19 Jan 2023 13:03:21 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id fy5-20020a170906b7c500b0084d3bf4498csm15522924ejb.140.2023.01.19.13.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 13:03:20 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id 81731BE2EE8; Thu, 19 Jan 2023 22:03:19 +0100 (CET)
Date:   Thu, 19 Jan 2023 22:03:19 +0100
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc:     Pavel Machek <pavel@denx.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jeff Brady <jeffreyjbrady@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [ANNOUNCE] 5.10.162-rt78
Message-ID: <Y8mwF0m+M1+e/fz/@eldamar.lan>
References: <Y8VSslRJZpFbo1/u@uudg.org>
 <40de655e-26f3-aa7b-f1ec-6877396a9f1e@ti.com>
 <Y8krsVFguwWLy+zT@duo.ucw.cz>
 <Y8lCspFtQ0wg6uCy@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8lCspFtQ0wg6uCy@uudg.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis, all,

On Thu, Jan 19, 2023 at 10:16:34AM -0300, Luis Claudio R. Goncalves wrote:
> On Thu, Jan 19, 2023 at 12:38:25PM +0100, Pavel Machek wrote:
> > Hi!
> > 
> > > > I'm pleased to announce the 5.10.162-rt78 stable release.
> > > > 
> > > > You can get this release via the git tree at:
> > > > 
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
> > > > 
> > > >   branch: v5.10-rt
> > > >   Head SHA1: 143ef105f40a65f3ddd57121d4b4bc36eb10cc06
> > > > 
> > > > Or to build 5.10.162-rt78 directly, the following patches should be applied:
> > 
> > > I see that vanilla 5.10.162-rt78 fails to build with arm64 defconfig. [0] Full log [1]
> > > Any pointers on what maybe wrong?
> > 
> > We see the same failure. 
> > 
> > >   AS      arch/arm64/kernel/entry.o
> > > arch/arm64/kernel/entry.S: Assembler messages:
> > > arch/arm64/kernel/entry.S:763: Error: immediate out of range at operand 3 -- `and x2,x19,#((1<<1)|(1<<0)|(1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6)|(1<<13)|(1<<7))'
> > > make[2]: *** [scripts/Makefile.build:367: arch/arm64/kernel/entry.o] Error 1
> > > make[1]: *** [scripts/Makefile.build:503: arch/arm64/kernel] Error 2
> > > make: *** [Makefile:1837: arch/arm64] Error 2
> > 
> > The line is:
> > 
> > >        and     x2, x19, #_TIF_WORK_MASK
> 
> I believe this is related to the arch/arm64/include/asm/thread_info.h
> changes in 5.10.162-rt78, specifically:
> 
>     79a9991e87fe arm64: add support for TIF_NOTIFY_SIGNAL
>     1ba44dcf789d Merge tag 'v5.10.162' into v5.10-rt
> 
> The first one is the original change, coming from stable v5.10.162 and the
> second one has the merge conflict I fixed in that file due to the existence
> of TIF_NEED_RESCHED_LAZY in PREEMPT_RT.
> 
> It escaped me that having TIF_NEED_RESCHED_LAZY set to 13 breaks the AND
> statement reported above. Looking at
> 
>     b5a5a01d8e9a arm64: uaccess: remove addr_limit_user_check()
> 
> specially this note
> 
>     To ensure that _TIF_WORK_MASK can be used as an immediate value in an
>     AND instruction (as it is in `ret_to_user`), TIF_MTE_ASYNC_FAULT is
>     renumbered to keep the constituent bits of _TIF_WORK_MASK contiguous.
> 
> I understand that I need to either have to renumber TIF_NEED_RESCHED_LAZY
> to 8, with the risk of breaking something else, or backport commit
> b5a5a01d8e9a in order to remove TIF_FSCHECK and then safely renumber
> TIF_NEED_RESCHED_LAZY.
> 
> Guidance is welcome here :)

Should we loop in here Jens, as having some overview of the needed
changes for io_uring rebase in the 5.10.y version? (doing so in the
mail).

Regards,
Salvatore
