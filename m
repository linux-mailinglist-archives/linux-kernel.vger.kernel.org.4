Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B383670A69A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 11:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjETJL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 05:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjETJL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 05:11:56 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42C0CF
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 02:11:53 -0700 (PDT)
X-QQ-mid: bizesmtp88t1684573905teirhxww
Received: from linux-lab-host.localdomain ( [116.30.125.36])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 20 May 2023 17:11:44 +0800 (CST)
X-QQ-SSF: 01200000000000C0V000000A0000000
X-QQ-FEAT: c342PQuYFhG7xMw63XFqL+acIplrGyQvFi0NXKujRXri9joL6YtUbT86pgfUv
        AuUQKdHKx/FXPQxWniGP6Ir6zfwjOZJWFcEi7s/ZsPZxapfi/LiNDtc9zseCsfW2qXUDJTS
        kSwLKr8TygqKlTQsTyTEyU0hQLDg9Nz1+pw57TUOUmF4/aAEN7tVapiDqbZjG1KOFos2Dg0
        0VStJv2DWl6CobJrJDoTqJ4uhpGMQtF+J4c4LerhQKFKxkINosfFhXPeGMiV4TPtnCWzfpM
        PV4htjs7CPpQ92OwPpe2xZ6UKgWvDZnWkjpCRPUhI73cQdpjKrGuRs98JDdObdLl/moDh3V
        XDsO1kreOVBwNQEkcxejOni7Zp0KA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9067829943763341093
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     aou@eecs.berkeley.edu, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@rivosinc.com, paul.walmsley@sifive.com, paulmck@kernel.org
Subject: Re: Re: [PATCH 1/2] tools/nolibc: riscv: Fix up load/store instructions for rv32
Date:   Sat, 20 May 2023 17:11:44 +0800
Message-Id: <20230520091144.30599-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230520085052.GC27206@1wt.eu>
References: <20230520085052.GC27206@1wt.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Willy

This is a full commit message for this patch:

When compile for rv32, we got such error:

---

nolibc/sysroot/riscv/include/arch.h:190: Error: unrecognized opcode `ld a4,0(a3)'
nolibc/sysroot/riscv/include/arch.h:194: Error: unrecognized opcode `sd a3,%lo(_auxv)(a4)'
nolibc/sysroot/riscv/include/arch.h:196: Error: unrecognized opcode `sd a2,%lo(environ)(a3)'

Refer to arch/riscv/include/asm/asm.h and add REG_L/REG_S macros here to let
rv32 use its own lw/sw instructions.

---

I will send a new version with the above full message for you, wait for a while, very sorry ;-)

Best Regards,
Zhangjin Wu

> Hi Zhangjin,
> 
> On Fri, May 19, 2023 at 01:02:12AM +0800, Zhangjin Wu wrote:
> > Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> > ---
> >  tools/include/nolibc/arch-riscv.h | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> I'm having a comment regarding this one (which for now I've queued so that
> Thomas can rebase his series), please provide a real commit message that
> explains the purpose of the change and the solutions chosen. Feel free
> to copy-paste from your cover letter if that fits, it's just that I do
> want to see some justification for a change in the commit message itself
> (i.e think about the poor person seeing a bisect stop on that one).
> 
> You can send me a paragraph or two and I'll happily copy them into my
> local copy of the rebased commit.
> 
> Thank you!
> Willy
