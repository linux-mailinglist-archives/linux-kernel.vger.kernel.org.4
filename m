Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81F36C828D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjCXQox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjCXQov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:44:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF2D15153
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:44:50 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 719531EC0657;
        Fri, 24 Mar 2023 17:44:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679676289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9QA2NK4KvzW8q0qZ7Eqn6oHGcHB6OtTLISFz+Esf1IA=;
        b=DAg2XGyf8oIE1rxxomhhtVQ1unVh2ngOonk6bUTGVcSG7WF53iMBgPJGpFGxeeSQGJMbjO
        VJCZmFIxY7SwHpKQCjqdULStGAn3sE1t85DA6QVH3kodEmFQrNUz5qmtsfYIdxEEh8QQ50
        18Yyxkw0pZ+2wP3negXKGUOvTrW5F7Q=
Date:   Fri, 24 Mar 2023 17:44:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode: move @microcode_mutex definition near
 usage
Message-ID: <20230324164445.GEZB3Tfe7pRV+GgE4f@fat_crate.local>
References: <20230324114720.1756466-1-john.ogness@linutronix.de>
 <20230324120019.GAZB2Q09ODVq0iYz5l@fat_crate.local>
 <87edpenvkh.fsf@jogness.linutronix.de>
 <20230324151933.GCZB2/hUOFuECIF1AG@fat_crate.local>
 <87a602nm74.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a602nm74.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 05:39:35PM +0106, John Ogness wrote:
> Note that an unused mutex is being defined, even when the compiler is
> not warning about it.

Are you sure?

$ make arch/x86/kernel/cpu/microcode/core.s
grep microcode_mutex arch/x86/kernel/cpu/microcode/core.s
$ 
$ make CC=clang arch/x86/kernel/cpu/microcode/core.s
$ grep microcode_mutex arch/x86/kernel/cpu/microcode/core.s
$ 

Looks to me like it gets optimized away.

> OK, but the kernel test robots will probably beat me to it. ;-)

That's exactly the question: they haven't because this is not a new
situation. Their compilers are optimizing unused stuff away too.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
