Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28FF5B571B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 11:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiILJWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 05:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiILJWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 05:22:15 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439BE32050
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 02:22:13 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:cc25:8ef2:d433:c52b])
        by andre.telenet-ops.be with bizsmtp
        id JxNB280093GaAlK01xNBG4; Mon, 12 Sep 2022 11:22:11 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oXfdq-004w4j-Ur; Mon, 12 Sep 2022 11:22:10 +0200
Date:   Mon, 12 Sep 2022 11:22:10 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     linux-kernel@vger.kernel.org
cc:     linux-parisc@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.0-rc5
In-Reply-To: <20220912091325.1780524-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2209121120590.1176514@ramsan.of.borg>
References: <CAHk-=wjG0js0MpsoH3-yvp05u_gXHu+uhkvqdAZDVb=9xUmX=g@mail.gmail.com> <20220912091325.1780524-1-geert@linux-m68k.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Sep 2022, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.0-rc5[1] to v6.0-rc4[3], the summaries are:
>  - build errors: +16/-1

   + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.S: Error: .cfi_endproc without corresponding .cfi_startproc:  => 32
   + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.S: Error: bad or irreducible absolute expression:  => 16
   + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.S: Error: junk at end of line, first unrecognized character is `:':  => 16
   + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.S: Error: no such instruction: `be 0x100(%sr2,%r0)':  => 29
   + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.S: Error: no such instruction: `ldi 0,%r20':  => 30
   + /kisskb/src/arch/parisc/kernel/vdso32/restart_syscall.S: Error: no such instruction: `ldw 0(%sp),%r31':  => 26
   + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: no such instruction: `ble 0x100(%sr2,%r0)':  => 46, 51
   + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: no such instruction: `ldi 0,%r25':  => 44
   + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: no such instruction: `ldi 1,%r25':  => 49
   + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: no such instruction: `ldi 173,%r20':  => 45, 50
   + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: unknown pseudo-op: `.callinfo':  => 40
   + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: unknown pseudo-op: `.entry':  => 41
   + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: unknown pseudo-op: `.exit':  => 54
   + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: unknown pseudo-op: `.proc':  => 39
   + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: unknown pseudo-op: `.procend':  => 55
   + /kisskb/src/arch/parisc/kernel/vdso32/sigtramp.S: Error: unknown pseudo-op: `.stringz':  => 76

parisc-gcc8/generic-32bit_defconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/80e78fcce86de0288793a0ef0f6acf37656ee4cf/ (all 135 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/7e18e42e4b280c85b76967a9106a13ca61c16179/ (all 135 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
