Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D230D6A45B2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjB0POF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjB0POC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:14:02 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF051DBA7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:13:55 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id g18so4676694ljl.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5SXc/jrJchHGzpzKP1x2lxlB1TaPEiUmQT++VSbRtCA=;
        b=r+8t87DyShJslxHxR+uFY25wmxvx8Yh3OHtZpG5rFxAgZRZbBjVhev8HdYsOkkmnCL
         lqMfTppL9+UCgkAUOM/PpVAqIrhPhQMbQBuHUUs8MqAsllF54M3d+mW3ytPxQLuMRrA3
         hg2nZN0jKWfkIQ9iyksVOz3q9C7A7Gb/BS8ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5SXc/jrJchHGzpzKP1x2lxlB1TaPEiUmQT++VSbRtCA=;
        b=5MNcAdGDu4KNvR/qdfPnMWYoAnsEHkOtfJ7+D4dDM6z9QuXSyIw/fgJu0+EMP0zJlk
         zJANiv1TRWbMhYQcR48FpIfox/+19jBweEKp5BsUJsy8oiMrrgRMBjtXF6V0bGJr8zt2
         AyqdMns8ruoqSKtlnK3PNFN5mLeM28K7MsofViSQvWAe4mdmBT19EDsJLzHfsjZKhx7r
         LkA33VuHbfuveZKWCKrbPI4GVX7YqyQM3ZnyENBKyBu0EIUvtKHeg3rsGzYtJEo4GFCE
         Vdgub19HmcFOecMgEaYM9aTKD2/4JppzNU9Gx4O6kmiiAxMwkKfhCPq3F17n8+TupTyw
         YaBA==
X-Gm-Message-State: AO0yUKUZ41IO1w8m+221hej2NTrDU+qq3nuXIzhF/oB+JV5OfGljTsoz
        WC5lYEDyhobthx5cT8DxuPVbVtGqub/masA6VMN7T2qLkAxAcA==
X-Google-Smtp-Source: AK7set+QOfUpw7C+vsmSyLyQyi2wlHKvwOnZJxPyGZdqoQUPOJJfmlR+zFVmJcmR69y/6Dux38STi6YocxFP7dfmDCI=
X-Received: by 2002:a2e:a4b5:0:b0:295:b597:c903 with SMTP id
 g21-20020a2ea4b5000000b00295b597c903mr1392295ljm.3.1677510833310; Mon, 27 Feb
 2023 07:13:53 -0800 (PST)
MIME-Version: 1.0
References: <CAABZP2z+Hk_w7nAhhyhJA9zidQViibMUO_xYianfm3xcG1QQwQ@mail.gmail.com>
 <D59B7575-FAB1-4446-BBA9-DF5EAA1B5DCA@joelfernandes.org>
In-Reply-To: <D59B7575-FAB1-4446-BBA9-DF5EAA1B5DCA@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 27 Feb 2023 10:13:41 -0500
Message-ID: <CAEXW_YS7LAin-Buw6PiG4fwCAtO19aWKNqxBkkqFWFuXkZi=_w@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in rcu_core
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     Sanan Hasanov <sanan.hasanov@knights.ucf.edu>, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, contact@pgazz.com
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

On Mon, Feb 27, 2023 at 8:15 AM Joel Fernandes <joel@joelfernandes.org> wrote:
[..]
> >> RSP: 0018:ffffc900003f8e48 EFLAGS: 00010246
> >>
> >> RAX: 0000000000000000 RBX: ffff888100833900 RCX: 00000000b9582f6c
> >> RDX: 1ffff11020106853 RSI: ffffffff816b2769 RDI: ffff888043f64708
> >> RBP: 000000000000000c R08: 0000000000000000 R09: ffffffff900b895f
> >> R10: fffffbfff201712b R11: 000000000008e001 R12: dffffc0000000000
> >> R13: ffffc900003f8ec8 R14: ffff888043f64708 R15: 000000000000000b
> >> FS:  0000000000000000(0000) GS:ffff888119f80000(0000) knlGS:0000000000000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: ffffffffffffffd6 CR3: 0000000054e64000 CR4: 0000000000350ee0
> >> ----------------
> >> Code disassembly (best guess):
> >>   0:   89 07                   mov    %eax,(%rdi)
> >>   2:   49 c7 c0 08 00 00 00    mov    $0x8,%r8
> >>   9:   4d 29 c8                sub    %r9,%r8
> >>   c:   4c 01 c7                add    %r8,%rdi
> >>   f:   4c 29 c2                sub    %r8,%rdx
> >>  12:   e9 76 ff ff ff          jmp    0xffffff8d
> >>  17:   cc                      int3
> >>  18:   cc                      int3
> >>  19:   cc                      int3
> >>  1a:   cc                      int3
> >>  1b:   f3 0f 1e fa             endbr64
> >>  1f:   eb 07                   jmp    0x28
> >>  21:   0f 00 2d e3 8a 34 00    verw   0x348ae3(%rip)        # 0x348b0b
> >>  28:   fb                      sti
> >>  29:   f4                      hlt
> >> * 2a:   fa                      cli <-- trapping instruction
>
> This probably happened before the crash and it is likely unrelated IMO. cli just means interrupts were enabled, the actual problem happened after softirq fired (likely at the tail end of the interrupt).
>

And just to correct myself for completeness, CLI clears the IF flag,
which ends up *disabling maskable interrupts*, not enabling. Still, I
can't see that as a possible reason for the crash.

 - Joel
