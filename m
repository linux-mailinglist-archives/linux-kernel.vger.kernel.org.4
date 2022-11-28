Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9434263B4BE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 23:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbiK1WUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 17:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbiK1WUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 17:20:17 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5514430563
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 14:20:16 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CA9BB1EC042F;
        Mon, 28 Nov 2022 23:20:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669674014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9Q9szGNYMhSiNNSee04BnD1hzRz/IY1kCkdyOYUCGbg=;
        b=mN4PUamxtBk87PLqiviOcquAwrDbZHger8qcXMamDAsH6joWG444klQJ7ma162U30THJwh
        Xpsk0TESRHV6Jk2uG026Vbbo5aPXT2Hj0A+54Z6N3G+vDxXCAdctsi6psqzawdyBwF30aq
        pQMj7FytIK6FqB5F5Y8XcGhMUPQ0e9s=
Date:   Mon, 28 Nov 2022 23:20:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/boot: Remove x86_32 PIC using ebx workaround
Message-ID: <Y4U0GwlLgAuxu3WF@zn.tnic>
References: <20221104124546.196077-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221104124546.196077-1-ubizjak@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 01:45:46PM +0100, Uros Bizjak wrote:
> Current minimum required version of GCC is version 5.1 which allows
> reuse of PIC hard register on x86/x86-64 targets [1]. Remove
> obsolete workaround that was needed for earlier GCC versions.
> 
> [1] https://gcc.gnu.org/gcc-5/changes.html

Thanks for the doc pointer.

Lemme see if I understand this commit message correctly:

SysV i386 ABI says that %ebx is used as the base reg in PIC. gcc 5 and
newer can handle all possible cases properly where inline asm could
clobber the PIC reg. I.e., it is able to deal with the "=b" constraint
where an insn can overwrite %ebx and it'll push and pop around that
statement.

So far so good.

Why then does this matter for x86-64 where PIC addressing is done
rip-relative so %rbx is normal reg there?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
