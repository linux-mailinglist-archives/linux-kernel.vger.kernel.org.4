Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE91662AAE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237293AbjAIP7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237268AbjAIP7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:59:23 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFAB3B902;
        Mon,  9 Jan 2023 07:59:17 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id jl4so9964840plb.8;
        Mon, 09 Jan 2023 07:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gnaAG4YDJhYITmoc4JFALivyXUFRt7jauTm0mQYzMbQ=;
        b=CrmUUFgEgmvDxgs5A/ywFQsggyIunQbSDeV8ufkm1vBRaa/INDWTY+EsCaw8oXK2/S
         FlWVQQPAGncAry0fIZS3oV95zVShMeJ35dEndt4MBH7cH6D/KbzFXwTenGx0e4gN6pz3
         ze1OWOZGTq5BQhKmGfiHESF7eX96nqM1a1Dymd78oGwSKFKxI6wdkpb4hOVqz6aSA6kF
         PlnEEqn7IcEaiemhdsL8KC92Ngjv69jnXx2VCoh/tZuQNIWaVTAI2wXqRIdWIkiglgtU
         fxTq+eUA7d359jNUK4fT4Js77L/+4nz7XNMiNxK21CARbh0+73CPEahjd+lySbtYVRUJ
         /OVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gnaAG4YDJhYITmoc4JFALivyXUFRt7jauTm0mQYzMbQ=;
        b=REPESrHgwJh3g2adS3S3+5i/e4ETH4ASVGFfTOihynKUjt00rrz+YOI1wcThRkQA0E
         Mit32a4pILvQnbUHV+gfZz3+ZFyaHQgeIsfzb15vFZ+jXfhfP3wfvitm1kFQtb9n84cV
         gNzAHvzcpWybtAwrSDyLViJ7CBVnsBsLp30UFH22UqBKH4Gi6/0wcKhyOj2IwrWp9tvL
         1EoJP3j77JZQuKzvn17qT5Ma8wIU8HD80tgIaKZ53cbiDZxQjL94GMRnfs2p1DZq22dn
         egJDM0FOgxATGjs9tdzO+QRRW5oCv1UeT8xM+6l9Gpm2kngvwpB1dNNm3rKQV+mPAEdw
         V/dw==
X-Gm-Message-State: AFqh2komyn9eJZcNU3NcWhwTaFqLto7waOQlfkUUBSFhkpSK39WWoUSK
        RUpbM0k7g0ThwRWPVYctM5WZrOaO4O7D+Bc62d4vnbufnZ0=
X-Google-Smtp-Source: AMrXdXsIHcMFGh8C6JVsndP5O7Yb37EfmTQB1MHMl1BJsI+OTAQfZHN0Hpm0fEvZmMEB9rBptlXxKbpReH1BjBeDTsc=
X-Received: by 2002:a17:90a:4311:b0:214:291f:87b5 with SMTP id
 q17-20020a17090a431100b00214291f87b5mr5835174pjg.115.1673279956980; Mon, 09
 Jan 2023 07:59:16 -0800 (PST)
MIME-Version: 1.0
References: <20221219052128.18190-1-zhouzhouyi@gmail.com> <Y7wN0TKU1jDyTZs5@lothringen>
 <20230109152505.GA4070882@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230109152505.GA4070882@paulmck-ThinkPad-P17-Gen-1>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Mon, 9 Jan 2023 23:59:05 +0800
Message-ID: <CAABZP2waOx0K=qLHmUoQZ2_g9q7LJQbCyYLaQRMPMGhiLTrcPQ@mail.gmail.com>
Subject: Re: [PATCH linux-next] mark access to tick_do_timer_cpu with READ_ONCE/WRITE_ONCE
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>, fweisbec@gmail.com,
        tglx@linutronix.de, mingo@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 9, 2023 at 11:25 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, Jan 09, 2023 at 01:51:29PM +0100, Frederic Weisbecker wrote:
> > On Mon, Dec 19, 2022 at 01:21:28PM +0800, Zhouyi Zhou wrote:
> > > mark access to tick_do_timer_cpu with READ_ONCE/WRITE_ONCE to fix concurrency bug
> > > reported by KCSAN.
> > >
> > > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > > ---
> > > During the rcutorture test on linux-next,
> > > ./tools/testing/selftests/rcutorture/bin/torture.sh --do-kcsan  --kcsan-kmake-arg "CC=clang-12"
> > > following KCSAN BUG is reported:
> > > [   35.397089] BUG: KCSAN: data-race in tick_nohz_idle_stop_tick / tick_nohz_next_event^M
> > > [   35.400593] ^M
> > > [   35.401377] write to 0xffffffffb64b1270 of 4 bytes by task 0 on cpu 3:^M
> > > [   35.405325]  tick_nohz_idle_stop_tick+0x14c/0x3e0^M
> > > [   35.407162]  do_idle+0xf3/0x2a0^M
> > > [   35.408016]  cpu_startup_entry+0x15/0x20^M
> > > [   35.409084]  start_secondary+0x8f/0x90^M
> > > [   35.410207]  secondary_startup_64_no_verify+0xe1/0xeb^M
> > > [   35.411607] ^M
> > > [   35.412042] no locks held by swapper/3/0.^M
> > > [   35.413172] irq event stamp: 53048^M
> > > [   35.414175] hardirqs last  enabled at (53047): [<ffffffffb41f8404>] tick_nohz_idle_enter+0x104/0x140^M
> > > [   35.416681] hardirqs last disabled at (53048): [<ffffffffb41229f1>] do_idle+0x91/0x2a0^M
> > > [   35.418988] softirqs last  enabled at (53038): [<ffffffffb40bf21e>] __irq_exit_rcu+0x6e/0xc0^M
> > > [   35.421347] softirqs last disabled at (53029): [<ffffffffb40bf21e>] __irq_exit_rcu+0x6e/0xc0^M
> > > [   35.423685] ^M
> > > [   35.424119] read to 0xffffffffb64b1270 of 4 bytes by task 0 on cpu 0:^M
> > > [   35.425870]  tick_nohz_next_event+0x233/0x2b0^M
> > > [   35.427119]  tick_nohz_idle_stop_tick+0x8f/0x3e0^M
> > > [   35.428386]  do_idle+0xf3/0x2a0^M
> > > [   35.429265]  cpu_startup_entry+0x15/0x20^M
> > > [   35.430429]  rest_init+0x20c/0x210^M
> > > [   35.431382]  arch_call_rest_init+0xe/0x10^M
> > > [   35.432508]  start_kernel+0x544/0x600^M
> > > [   35.433519]  secondary_startup_64_no_verify+0xe1/0xeb^M
> > >
> > > fix above bug by marking access to tick_do_timer_cpu with READ_ONCE/WRITE_ONCE
> >
> > This has been discussed before with passion:
> >
> > http://archive.lwn.net:8080/linux-kernel/1C65422C-FFA4-4651-893B-300FAF9C49DE@lca.pw/T/
> >
> > To me data_race() would be more appropriate but that would need a changelog with
> > proper analysis of the tick_do_timer_cpu state machine.
>
> Please also an analysis of why the compiler cannot do any destructive
> optimizations in this case.  Maybe also comments.
I want to try the analysis above, as a newbie I have taught myself
LLVM for 3 years in my spare time ;-)
>
> > One more thing on my TODO list, but feel free to beat me at it :-)
Please take your time ;-)   Please don't look my next possible email
as a reminder ;-)
>
> I know that feeling!  ;-)
>
Thanx, Zhouyi
>                                                         Thanx, Paul
