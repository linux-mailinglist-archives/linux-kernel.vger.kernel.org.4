Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C54F6EBAF7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 21:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjDVTT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 15:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjDVTT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 15:19:57 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA46A172B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 12:19:55 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-b9963a72fbfso440107276.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 12:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1682191195; x=1684783195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OHJY4Fkh+i9IKg2K8qTc2zv9H9+ffmQTlvrABmh8bQ=;
        b=tsV+XRz6vc6v28gtdYF8Gj99Qpo+XphroXPdLWtFBNnpBNNol6ARzQFBZAJLZYUc/9
         mVicFywL0vgU7dZHJJ8b286loaHazmcmDh1GCUuCP+U/tei92lcLvifueeydbAcr5m0C
         xE0xNy4X8A3TGTFVu+7F/jnmN9ZU+YHAPlh18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682191195; x=1684783195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3OHJY4Fkh+i9IKg2K8qTc2zv9H9+ffmQTlvrABmh8bQ=;
        b=T6F0phPtaWOlVdCdyLQ8TqZy6yxNr6NWEy60JrisaJEhH4PjlgYV77DqqN5TrvuJoG
         ZlHzgpmguhcVafEDu4ltVpj9HAteTyCJeXDc+L6CsnCkQpuYyc0Sk8czWTV91C/u6r/N
         3O6MPVEzGUh0RNPx5lKFGyuSYQ3ikTcaE3hQ/AkYCcJkVrsschhqPJvqMlCdAuEBDaHs
         9qel2UDkYn1gW0mqPtCTSjUecJkNQ9ayT1Q1Kxtv3Fl6qHVoi8YycXxPybrlPPv7mGLY
         o89FYT1tCt/FmdndFQxZDDGHHr/5hQxff/tnZaSGAQGjoelTtVoXiPSKfJatSmQolkRo
         gMSw==
X-Gm-Message-State: AAQBX9f/fSFNt6p2f5qxB0/ybZviiJAHZ+E70AbC9oNxXS33iYL3bdTz
        EQmF9f+kBBmcmyXCYpRv/tz84Ns+DF7Z43dbArN5rw==
X-Google-Smtp-Source: AKy350abbGfzNu9Ezn4OMBp5YhNGQ7AC6quo9KEVhw/AIwmIzl2/hq5vRDRnt/Z4h6Ejw/51Vx77DKi3Wrd7Zr6TarY=
X-Received: by 2002:a81:6604:0:b0:54f:5419:2fa4 with SMTP id
 a4-20020a816604000000b0054f54192fa4mr4608890ywc.50.1682191194837; Sat, 22 Apr
 2023 12:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAABZP2xJRGhPmfB-PrfesQKzP7fsuZsj+3TewAiLLW8u=YK4dg@mail.gmail.com>
In-Reply-To: <CAABZP2xJRGhPmfB-PrfesQKzP7fsuZsj+3TewAiLLW8u=YK4dg@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 22 Apr 2023 21:19:41 +0200
Message-ID: <CAEXW_YQCugPs1bquaA4ZLdsM4S3hWv9OMNTt80tSvjCO0LwiHg@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhouyi,

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

Could you provide the full kernel log? It is not clear exactly from
your attachments, but I think this is a stack overflow issue as
implied by the mention of __stack_chk_fail. One trick might be to turn
on any available stack debug kernel config options, or check the
kernel logs for any messages related to shortage of remaining stack
space.

Additionally, you could also find out where the kernel crash happened
in C code following the below notes [1] I wrote (see section "Figuring
out where kernel crashes happen in C code"). The notes are
x86-specific but should be generally applicable (In the off chance
you'd like to improve the notes, feel free to share them ;-)).

Lastly, is it a specific kernel release from which you start seeing
this issue? You should try git bisect if it is easily reproducible in
a newer release, but goes away in an older one.

I will also join you in your debug efforts soon though I am currently
in between conferences.

[1] https://gist.github.com/joelagnel/ae15c404facee0eb3ebb8aff0e996a68

thanks,

 - Joel




>
> Thanks
> Zhouyi
