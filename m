Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534756626A1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbjAINOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236428AbjAINN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:13:28 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B52F2C;
        Mon,  9 Jan 2023 05:13:27 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso12762973pjt.0;
        Mon, 09 Jan 2023 05:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RUPWQ00I4B+FeAT4uW8sz7LlGf270FM7v3Ovcdol5eo=;
        b=dNoYjm6G2UptA+miOjROgT/3AYYHiuu0qY1GE8xiov6fo0JV/29wYEpFRR0aspzTEM
         Y+3lJ7m+F3vwEsCU9+WSfDH51n7JRARreaSrvHJPegJMlClrsaVkLGQFopidghxYZMAa
         LcojnCYBZ/ndV/8vidGnxhZpjZPQUbHLyLj+raYZFdrFQ8fRIQtfoyZwLoU9fo6KzJkW
         ASe1ES1EyB5CzD+ZdEVbiDhEaU3ktVOrJAQ5KVOyoPhEFXHfoqNBl8ebpgAxKO22jKPZ
         5EGR3oiyYdZKnpNH5peYAVu5P+aR/dhUotlQhHP535ugn7Gm/Ys8B8L+5yjbkv3M291r
         n1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RUPWQ00I4B+FeAT4uW8sz7LlGf270FM7v3Ovcdol5eo=;
        b=SHGvfdUYxCAnAKu1UtFZmwR6iIZ/aD8P+rBzIQehtnHqDvL4gTFoFETkoQMskO2B7k
         qesqMBwh+r+8g3uQPNKqjMAwwfisYczZg5zmOsoR4QHrS1xkY7J1A39lw1pgXaltrDbt
         cDwbEgIIzwfvnr5+owHYVbDCOgfLZ+OiFdCZs6Jvfij652JPRA1u4jzsoLkO/Pu2nAWO
         E/hezRRzaDWpJWuhxVfFY+QOOgHyJHx4GFT4Fb4aNUaze1QigEGNRBMOU3nlk0j1JYfe
         VCf1o3LYAAN5NOPv5ZNUJ/A9QuUVJOwq06Ek9XJxwhDZ0j5q3wcxgUN7UoDeqp2p/gdx
         ZTgw==
X-Gm-Message-State: AFqh2komwUvizQy2eBOqfHcV+6dcoB6UqIyL1AOztxedVBqqOEh4qQGr
        XWVU+z2ocN7K0c1P6LznPh5KJjPZTx/VSFI0tw8=
X-Google-Smtp-Source: AMrXdXuuDHkYzhUBc9S6KSEjjk9PX/agNgN+0E2m+o5wvl3vbiNBnA5cS5FiCpd9n7ObqMiEPfhDR22SERyEQ/gpZb0=
X-Received: by 2002:a17:90a:9b17:b0:226:2a7c:9ba9 with SMTP id
 f23-20020a17090a9b1700b002262a7c9ba9mr2509758pjp.128.1673270001870; Mon, 09
 Jan 2023 05:13:21 -0800 (PST)
MIME-Version: 1.0
References: <20221219052128.18190-1-zhouzhouyi@gmail.com> <Y7wN0TKU1jDyTZs5@lothringen>
In-Reply-To: <Y7wN0TKU1jDyTZs5@lothringen>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Mon, 9 Jan 2023 21:13:10 +0800
Message-ID: <CAABZP2wpc3JB8Yx7+F5jt5HTFwCrCZz4QqO-JXNypp6_7vBF9Q@mail.gmail.com>
Subject: Re: [PATCH linux-next] mark access to tick_do_timer_cpu with READ_ONCE/WRITE_ONCE
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        paulmck@kernel.org, rcu@vger.kernel.org,
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

On Mon, Jan 9, 2023 at 8:51 PM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> On Mon, Dec 19, 2022 at 01:21:28PM +0800, Zhouyi Zhou wrote:
> > mark access to tick_do_timer_cpu with READ_ONCE/WRITE_ONCE to fix concurrency bug
> > reported by KCSAN.
> >
> > Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> > ---
> > During the rcutorture test on linux-next,
> > ./tools/testing/selftests/rcutorture/bin/torture.sh --do-kcsan  --kcsan-kmake-arg "CC=clang-12"
> > following KCSAN BUG is reported:
> > [   35.397089] BUG: KCSAN: data-race in tick_nohz_idle_stop_tick / tick_nohz_next_event^M
> > [   35.400593] ^M
> > [   35.401377] write to 0xffffffffb64b1270 of 4 bytes by task 0 on cpu 3:^M
> > [   35.405325]  tick_nohz_idle_stop_tick+0x14c/0x3e0^M
> > [   35.407162]  do_idle+0xf3/0x2a0^M
> > [   35.408016]  cpu_startup_entry+0x15/0x20^M
> > [   35.409084]  start_secondary+0x8f/0x90^M
> > [   35.410207]  secondary_startup_64_no_verify+0xe1/0xeb^M
> > [   35.411607] ^M
> > [   35.412042] no locks held by swapper/3/0.^M
> > [   35.413172] irq event stamp: 53048^M
> > [   35.414175] hardirqs last  enabled at (53047): [<ffffffffb41f8404>] tick_nohz_idle_enter+0x104/0x140^M
> > [   35.416681] hardirqs last disabled at (53048): [<ffffffffb41229f1>] do_idle+0x91/0x2a0^M
> > [   35.418988] softirqs last  enabled at (53038): [<ffffffffb40bf21e>] __irq_exit_rcu+0x6e/0xc0^M
> > [   35.421347] softirqs last disabled at (53029): [<ffffffffb40bf21e>] __irq_exit_rcu+0x6e/0xc0^M
> > [   35.423685] ^M
> > [   35.424119] read to 0xffffffffb64b1270 of 4 bytes by task 0 on cpu 0:^M
> > [   35.425870]  tick_nohz_next_event+0x233/0x2b0^M
> > [   35.427119]  tick_nohz_idle_stop_tick+0x8f/0x3e0^M
> > [   35.428386]  do_idle+0xf3/0x2a0^M
> > [   35.429265]  cpu_startup_entry+0x15/0x20^M
> > [   35.430429]  rest_init+0x20c/0x210^M
> > [   35.431382]  arch_call_rest_init+0xe/0x10^M
> > [   35.432508]  start_kernel+0x544/0x600^M
> > [   35.433519]  secondary_startup_64_no_verify+0xe1/0xeb^M
> >
> > fix above bug by marking access to tick_do_timer_cpu with READ_ONCE/WRITE_ONCE
>
> This has been discussed before with passion:
>
> http://archive.lwn.net:8080/linux-kernel/1C65422C-FFA4-4651-893B-300FAF9C49DE@lca.pw/T/
>
Thank you for your guidance, yes, the discussion is very passionate
;-) and I learned a lot from the above thread ;-)
> To me data_race() would be more appropriate but that would need a changelog with
> proper analysis of the tick_do_timer_cpu state machine.
I Agree, and also I learned to do more rigorous technology research.
>
> One more thing on my TODO list, but feel free to beat me at it :-)
Thank you for your concern ;-)

Thanks
Zhouyi
>
> Thanks.
