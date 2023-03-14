Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6684D6B928A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjCNMCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjCNMCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:02:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E854351F96
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:02:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA21FB81900
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 12:01:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E625C4339B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 12:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678795300;
        bh=cC+3opRtfomBdQkbY8l2F4/DwaxVUxed3uEOtpSCVGY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sy1iAENpbiVb+hSBkxUpo5wbLmjVSm6C/zZm2Qzdm8FzgNcHycuDI1rnh2KjRrUu/
         gg20wOoTC2AqbE7A8ye4m6ewNPd5B11Y7ogZ2B/hL6xrKdI1ZdIp3R9o0jk3qAq5lZ
         RiIAiepGpoyvVsExQyD7vybCtMEwKor4nyxMYAoZT3DTwR/maxSm5vszhTmOjtZH8S
         Wr2qmnhXAu6RJw/qtB5fcTQfqVoCPBlrBDofGyuqjmNXiABi7++GkxIvHvO3UcW6yv
         DnZNTglgvoLkl9u5lT1TnPBkKcPleLJfVI63XsE/QCNFyVCWYGKsparXc46md9CD6x
         okSwKxA0Exmlg==
Received: by mail-lf1-f47.google.com with SMTP id br6so1506034lfb.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:01:40 -0700 (PDT)
X-Gm-Message-State: AO0yUKWI7GOkvOaHGQ9rd6ar576kN4S3fuI9Z2rwBjhj+885M2SsfZY9
        RM9hJXMXopGA00qvbGN8EQEZ6A8nDXGNxB0Ji4g=
X-Google-Smtp-Source: AK7set9YaucDyYslwqHf47x5ktQpZKUm6qYScAZY2ls9L2X7/10DPF1gWXiPE3QiaNyuToFznb2DzIc2s5L23xjGsBQ=
X-Received: by 2002:ac2:5591:0:b0:4dd:98c6:ee3 with SMTP id
 v17-20020ac25591000000b004dd98c60ee3mr655779lfg.4.1678795298502; Tue, 14 Mar
 2023 05:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wii6BZtVKYfvQCQqbE3+t1_yAb-ea80-3PcJ4KxgpfHkA@mail.gmail.com>
 <d915df60-d06b-47d4-8b47-8aa1bbc2aac7@roeck-us.net> <CAHk-=wi8xQw6eTRncbJfWWYHHi0UBG2B_AfHrzZbPr=k0V_WYQ@mail.gmail.com>
 <ZA+ttVOPBvNOYHoC@lothringen> <dc031bc7-8ca4-7ca7-c24f-9db65b5547e4@roeck-us.net>
 <ZBBYCSZUJOWBg1s8@localhost.localdomain> <20230314114018.GF1845660@hirez.programming.kicks-ass.net>
In-Reply-To: <20230314114018.GF1845660@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 14 Mar 2023 13:01:27 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHC+UCaWLRrujEJeqVaQ_4Wn3dQ+Mq+1ryQj6C=Qsb53w@mail.gmail.com>
Message-ID: <CAMj1kXHC+UCaWLRrujEJeqVaQ_4Wn3dQ+Mq+1ryQj6C=Qsb53w@mail.gmail.com>
Subject: Re: Linux 6.3-rc2
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2023 at 12:40, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Mar 14, 2023 at 12:18:33PM +0100, Frederic Weisbecker wrote:
> > How does the following look like as a culprit?
> >
> > 62b95a7b44d1 (ARM: 9282/1: vfp: Manipulate task VFP state with softirqs disabled)
>
> Ooh yeah, that asm implementation of local_bh_{dis,en}able completely
> miss out on the lockdep state tracking. Also I think it breaks RCU, note
> how __local_bh_disable_ip() explicitly does rcu_read_lock() for the
> first bh-disable.
>

Thanks a lot for the diagnosis, doctor :-)

I may need some hand holding getting this fixed - probably better to
run the C implementations wherever feasible, right?
