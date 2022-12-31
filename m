Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA4265A4B3
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 14:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiLaNoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 08:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiLaNoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 08:44:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F81E5FE6
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 05:44:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02E6EB8010F
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 13:44:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72E8C433D2;
        Sat, 31 Dec 2022 13:44:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="J0VgweoX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1672494251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I3EXbAZF0ZkXHlsBF39+Z27ZqrvJyxmcMZ2q51Q1/4c=;
        b=J0VgweoXjwAHO1a/91Zlb2Q+CTc5BruXxZkyPJ95acGGShgImBWr2aCaY/RCi5SD8viTvq
        LdE+PDwk0i3w43Xxi5jTWdCEeb6b3w7kwWYTrKKjRX04gpQNloMEDNTB3etU5r3ClfF517
        Mc7u19KscXmsJD4jqqCS+C6qcCw0i1c=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id dc77abb8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 31 Dec 2022 13:44:11 +0000 (UTC)
Date:   Sat, 31 Dec 2022 14:44:08 +0100
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, pbonzini@redhat.com,
        ebiggers@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, ardb@kernel.org, kraxel@redhat.com,
        philmd@linaro.org
Subject: Re: [PATCH qemu] x86: don't let decompressed kernel image clobber
 setup_data
Message-ID: <Y7A8qP05B0YRbQIN@zx2c4.com>
References: <AF921575-0968-434A-8B46-095B78C209C1@zytor.com>
 <Y62MdawGaasXmoVL@zn.tnic>
 <Y68Js5b0jW/2nLU4@zx2c4.com>
 <Y68Zf/MKmX3Rr18E@zn.tnic>
 <CAHmME9oPUJemVRvO3HX0q4BJGTFuzbLYANeizuRcNq2=Ykk1Gg@mail.gmail.com>
 <Y69B40T9kWfxZpmf@zn.tnic>
 <E5D0A77E-5ABC-4978-9A66-37B60DA43869@zytor.com>
 <Y69h6ur79SMhu61F@zx2c4.com>
 <46466e54-25c3-3194-8546-a57cd4a80d9d@zytor.com>
 <Y7A76+IBS4fnucrW@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y7A76+IBS4fnucrW@zn.tnic>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 02:40:59PM +0100, Borislav Petkov wrote:
> On Fri, Dec 30, 2022 at 05:06:55PM -0800, H. Peter Anvin wrote:
> > This needs to be something like:
> > 
> > kernel_add_identity_map(sd_addr, sd_addr + sizeof(*sd));
> > kernel_add_identity_map(sd_addr + sizeof(*sd),
> > 	sd_addr + sizeof(*sd) + sd->len);
> 
> It still #PFs with that:
> 
> (gdb) bt
> #0  0xffffffff84738576 in native_halt () at ./arch/x86/include/asm/irqflags.h:57
> #1  halt () at ./arch/x86/include/asm/irqflags.h:98
> #2  early_fixup_exception (regs=regs@entry=0xffffffff84007dc8, trapnr=trapnr@entry=14) at arch/x86/mm/extable.c:340
> #3  0xffffffff846ff465 in do_early_exception (regs=0xffffffff84007dc8, trapnr=14) at arch/x86/kernel/head64.c:424
> #4  0xffffffff846ff14f in early_idt_handler_common () at arch/x86/kernel/head_64.S:483
> #5  0xc149f9894908788d in ?? ()
> #6  0xffffffffff2003fc in ?? ()
> #7  0x0000000000000010 in fixed_percpu_data ()
> #8  0xdffffc0000000000 in ?? ()
> #9  0xffffffff84007ea8 in init_thread_union ()
> #10 0xffffffffff20088d in ?? ()
> #11 0x0000000000000000 in ?? ()
> 
> /me goes to dig more.

Are you using patch v1 minus the 62 MiB thing? If you haven't applied
patch v1 and then removed the 62 MiB limitation in it, then you've
misunderstood the conversation again.

Please see my reproduction steps to Peter:
https://lore.kernel.org/lkml/Y68K4mPuz6edQkCX@zx2c4.com/

Jason
