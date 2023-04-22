Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A5E6EBAFD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 21:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjDVT25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 15:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjDVT2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 15:28:55 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14991E76
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 12:28:53 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54fae5e9ec7so32603637b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 12:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1682191732; x=1684783732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCriSCxRgt6c54/aZMrPhGXLFhCTM5p0XMg6TzpIhbY=;
        b=u1zJkinE0WZES7ZbULFAq8kl4b17EZY5F1OHn0mudgK6svMvuoOCAYesMwKC6SOxR7
         JDAlHJI0vNv/xQBkPEsV7b0wSR/161efkefxsl/9owctBXvtKBYROtkl5gA+IWb7mLd9
         G7hUvEo28+bNXV7BGpirnlPB56iw0AJ+DtUvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682191732; x=1684783732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCriSCxRgt6c54/aZMrPhGXLFhCTM5p0XMg6TzpIhbY=;
        b=YHEfNaiveGkzGGyj/zYnVYBictZlwim/FpH5oG3/k6teyDay+kQNDAEZ5qOCxGPH5d
         72S6IaSf+fXELC9BTf7+z4RD2dmk0eFdlnNO0dRigjgw9z54pFRIy80BjxZKOHJdgyH9
         GuyUcdM87MHNTTkD+pwH1r9kOw9FSGwjM7DT4/npSMkXP2P6E8vzrZ8bT6OGMHv/vN+4
         lSwsNlrUU1f6Zv7wD3FTjAoD6tZKrBOtL/1ZBM2uU85O/1EUXxLKi9RuBIMP89ckg+C3
         xkABZb+duAXyo8ubCXKxdke/sI8H3jJq9uo0/wM3sM9fo20mvkvPXiqIa1308l56dR5b
         TPtA==
X-Gm-Message-State: AAQBX9cfMijPVsZ8iz6VT+lFlLRwi4lUwi0PCogmv7CA+UCcgby6plWn
        CY32GL57VoAD2UxWvEarJKJDdUadKQAtkIk6DYU5Fw==
X-Google-Smtp-Source: AKy350YU3Dafxewi46eez9uCVfmHiwtrwjvUGKGw+0XUG+JvN/TpIgW8Bm/wSKo8AdnttnoFwBOUAc+u40ckO2Ik3x8=
X-Received: by 2002:a0d:c4c3:0:b0:552:d36e:e6db with SMTP id
 g186-20020a0dc4c3000000b00552d36ee6dbmr4261843ywd.6.1682191732207; Sat, 22
 Apr 2023 12:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAABZP2xJRGhPmfB-PrfesQKzP7fsuZsj+3TewAiLLW8u=YK4dg@mail.gmail.com>
In-Reply-To: <CAABZP2xJRGhPmfB-PrfesQKzP7fsuZsj+3TewAiLLW8u=YK4dg@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 22 Apr 2023 21:28:39 +0200
Message-ID: <CAEXW_YSSGYgqTpxqbYikCFS9t=2f+L-0phbU+gAAngB5z-FbyA@mail.gmail.com>
Subject: Re: BUG : PowerPC RCU: torture test failed with __stack_chk_fail
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, lance@osuosl.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NORMAL_HTTP_TO_IP,
        NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2023 at 2:47=E2=80=AFPM Zhouyi Zhou <zhouzhouyi@gmail.com> =
wrote:
>
> Dear PowerPC and RCU developers:
> During the RCU torture test on mainline (on the VM of Opensource Lab
> of Oregon State University), SRCU-P failed with __stack_chk_fail:
> [  264.381952][   T99] [c000000006c7bab0] [c0000000010c67c0]
> dump_stack_lvl+0x94/0xd8 (unreliable)
> [  264.383786][   T99] [c000000006c7bae0] [c00000000014fc94] panic+0x19c/=
0x468
> [  264.385128][   T99] [c000000006c7bb80] [c0000000010fca24]
> __stack_chk_fail+0x24/0x30
> [  264.386610][   T99] [c000000006c7bbe0] [c0000000002293b4]
> srcu_gp_start_if_needed+0x5c4/0x5d0
> [  264.388188][   T99] [c000000006c7bc70] [c00000000022f7f4]
> srcu_torture_call+0x34/0x50
> [  264.389611][   T99] [c000000006c7bc90] [c00000000022b5e8]
> rcu_torture_fwd_prog+0x8c8/0xa60
> [  264.391439][   T99] [c000000006c7be00] [c00000000018e37c] kthread+0x15=
c/0x170
> [  264.392792][   T99] [c000000006c7be50] [c00000000000df94]
> ret_from_kernel_thread+0x5c/0x64
> The kernel config file can be found in [1].
> And I write a bash script to accelerate the bug reproducing [2].
> After a week's debugging, I found the cause of the bug is because the
> register r10 used to judge for stack overflow is not constant between
> context switches.
> The assembly code for srcu_gp_start_if_needed is located at [3]:
> c000000000226eb4:   78 6b aa 7d     mr      r10,r13
> c000000000226eb8:   14 42 29 7d     add     r9,r9,r8
> c000000000226ebc:   ac 04 00 7c     hwsync
> c000000000226ec0:   10 00 7b 3b     addi    r27,r27,16
> c000000000226ec4:   14 da 29 7d     add     r9,r9,r27
> c000000000226ec8:   a8 48 00 7d     ldarx   r8,0,r9
> c000000000226ecc:   01 00 08 31     addic   r8,r8,1
> c000000000226ed0:   ad 49 00 7d     stdcx.  r8,0,r9
> c000000000226ed4:   f4 ff c2 40     bne-    c000000000226ec8
> <srcu_gp_start_if_needed+0x1c8>
> c000000000226ed8:   28 00 21 e9     ld      r9,40(r1)
> c000000000226edc:   78 0c 4a e9     ld      r10,3192(r10)
> c000000000226ee0:   79 52 29 7d     xor.    r9,r9,r10
> c000000000226ee4:   00 00 40 39     li      r10,0
> c000000000226ee8:   b8 03 82 40     bne     c0000000002272a0
> <srcu_gp_start_if_needed+0x5a0>
> by debugging, I see the r10 is assigned with r13 on c000000000226eb4,
> but if there is a context-switch before c000000000226edc, a false
> positive will be reported.
>
> [1] http://154.220.3.115/logs/0422/configformainline.txt
> [2] 154.220.3.115/logs/0422/whilebash.sh
> [3] http://154.220.3.115/logs/0422/srcu_gp_start_if_needed.txt
>
> My analysis and debugging may not be correct, but the bug is easily
> reproducible.

If this is a bug in the stack smashing protection as you seem to hint,
I wonder if you see the issue with a specific gcc version and is a
compiler-specific issue. It's hard to say, but considering this I
think it's important for you to mention the compiler version in your
report (along with kernel version, kernel logs etc.)

thanks,

- Joel


 - Joel
