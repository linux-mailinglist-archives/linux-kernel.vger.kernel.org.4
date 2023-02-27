Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AEA6A466F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjB0PtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjB0PtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:49:02 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF8E12BF8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:49:01 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id h3so6900346lja.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cfHW5ojv22AteVVsYMtnz69sp9W1vKBEAZHjN/RW9vY=;
        b=FrOGczNNhjLIDh6O0mdiRohiUHdf0a2Ja6zgBSOudc4+txLgIvGavUq5Mi6zCr42/o
         tMqHXtzxS5ZAIkxJjmNcmPguxztJvxxhM8+Wh7o9O6vLvvp/8Mwa+mw4J1o+8aruSa/9
         ulhNbo2ucDjkrU88R+6P7647iLVnzKmdrjDyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cfHW5ojv22AteVVsYMtnz69sp9W1vKBEAZHjN/RW9vY=;
        b=WPM9uPKUt3Je0ND7hQdxWveeEa9sWbrFRw56JrLSIiJmWStSnxwE+8k5uO1A6zx0u/
         DfAhpbuAwDsQ3tNX14HYGiqcjp1w61a0DvtDvW+PV4cNx9MvYjxJrtESx0y64blaLn04
         SMqebO+ToYWPrl1bsKm1sG+vVJJFNUrmwZtSmR7AdRvnGZcvNV2fGGhTLmr/xCXFWHzU
         YTVIVrJH1qnF3yYR07hauHEhtNdSOsz4/VDjJGJ+PFIGc2gWwlzdwdUHjDTlKJKhcdXU
         Ua+rsZP7sDlvQqbpIRlLeR8YhcSrjcn+pvaTykJ1Pbg76ZjWtEC45TEnTTvVV/axWBzA
         ZTAQ==
X-Gm-Message-State: AO0yUKULchfkwBV5itiwSZe/YHVCM2F36N8iGLOWmsgYx+7TofPFZdCF
        dGuIPlSiuNFkOIxNZPUXFQiVLl1Tq1G+BD3R9r8QubPGoHKwaA==
X-Google-Smtp-Source: AK7set+pogRt+f/YuCRUdscPhdatqReMSatbngNzOGySavyZz2CKV+EsSY2xRud4XwPYHZ3kQR0m5WghLdwB1NRz17k=
X-Received: by 2002:a05:651c:32d:b0:295:a8d1:8a28 with SMTP id
 b13-20020a05651c032d00b00295a8d18a28mr2914577ljp.3.1677512939498; Mon, 27 Feb
 2023 07:48:59 -0800 (PST)
MIME-Version: 1.0
References: <CAABZP2z+Hk_w7nAhhyhJA9zidQViibMUO_xYianfm3xcG1QQwQ@mail.gmail.com>
 <D59B7575-FAB1-4446-BBA9-DF5EAA1B5DCA@joelfernandes.org> <20230227103257.4b99b6fb@gandalf.local.home>
In-Reply-To: <20230227103257.4b99b6fb@gandalf.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 27 Feb 2023 10:48:48 -0500
Message-ID: <CAEXW_YT6_cSaEODPu3HLWUB5kJhs6U=CQrQ4v4ODKtk-D+Bzug@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in rcu_core
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Sanan Hasanov <sanan.hasanov@knights.ucf.edu>,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller@googlegroups.com,
        contact@pgazz.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Steve,

On Mon, Feb 27, 2023 at 10:33 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 27 Feb 2023 08:15:26 -0500
> Joel Fernandes <joel@joelfernandes.org> wrote:
>
> > >> asm_sysvec_apic_timer_interrupt+0x1a/0x20
> > >> RIP: 0010:default_idle+0xf/0x20
> > >> Code: 89 07 49 c7 c0 08 00 00 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 76 ff ff ff cc cc cc cc f3 0f 1e fa eb 07 0f 00 2d e3 8a 34 00 fb f4 <fa> c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 65
> > >> RSP: 0018:ffffc9000017fe00 EFLAGS: 00000202
> > >> RAX: 0000000000dfbea1 RBX: dffffc0000000000 RCX: ffffffff89b1da9c
> > >> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> > >> RBP: 0000000000000007 R08: 0000000000000001 R09: ffff888119fb6c23
> > >> R10: ffffed10233f6d84 R11: dffffc0000000000 R12: 0000000000000003
> > >> R13: ffff888100833900 R14: ffffffff8e112850 R15: 0000000000000000
> > >> default_idle_call+0x67/0xa0
> > >> do_idle+0x361/0x440
> > >> cpu_startup_entry+0x18/0x20
> > >> start_secondary+0x256/0x300
> > >> secondary_startup_64_no_verify+0xce/0xdb
> > >> </TASK>
> > >> Modules linked in:
> > >> CR2: 0000000000000000
> > >> ---[ end trace 0000000000000000 ]---
> > >> RIP: 0010:0x0
> > >> Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> >
> > I have seen this exact signature when the processor tries to execute a function that has a NULL address. That causes IP to goto 0 and the exception. Sounds like something corrupted rcu_head (Just a guess).
>
> [ Joel, you need to line wrap your emails ;-) ]

Ok I will try. The thing is, I have not figured out yet how to
plaintext-reply from my iPhone without having it wrap :-(

> This looks like a call_rcu() was called on something that later got freed
> or reused. That is, the bug is not with RCU but with something using RCU.

Yes certainly, the rcu_head is allocated on the caller side so it
could have been trampled while the callback was still in flight.

> OR it could be a bug with RCU if the synchronize_rcu() ended before the
> grace periods have finished.

Good point..

Thanks,

 - Joel
