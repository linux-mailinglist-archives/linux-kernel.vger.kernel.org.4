Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533CF635CEA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 13:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbiKWMbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 07:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbiKWMbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 07:31:00 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F9F53EE2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 04:30:27 -0800 (PST)
Received: from zn.tnic (p200300ea9733e747329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e747:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5E7C71EC064F;
        Wed, 23 Nov 2022 13:30:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669206625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5eDEkiTU4kNbmdw6Mz9QPRO3QMJ/UyuQb9sqHxy2hG4=;
        b=nDDfJLa8Uc0xsjBOnfnXd9qunzKhokgSDeiCwVQJd/VsDSYbtiT21I1JaojWZVVT62Gzmp
        m8hWgB37wTtPeKNwOiMfVh7ISPTHJ4exgvobCZncI6n7QCMyHAxS6FlN17lYxNV2cvKGe3
        iYk/Ad6w3SPJu9wC8Nc8fFW6NDcuCF8=
Date:   Wed, 23 Nov 2022 13:30:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, nicolas@fjasle.eu,
        masahiroy@kernel.org, kirill.shutemov@linux.intel.com,
        tony.luck@intel.com, michael.roth@amd.com, nathan@kernel.org,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: Avoid relocation information in final vmlinux
Message-ID: <Y34SXeU6JEk+UGfV@zn.tnic>
References: <20220927084632.14531-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220927084632.14531-1-petr.pavlu@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 10:46:32AM +0200, Petr Pavlu wrote:
> When building a kernel supporting KASLR with CONFIG_X86_NEED_RELOCS,
> vmlinux contains also relocation information produced by using the
> --emit-relocs linker option. This is utilized by subsequent build steps
> to create vmlinux.relocs and produce a relocatable image. However, the
> information is not needed by debuggers and other standard ELF tooling.

Hm, my ld manpage says:

       -q
       --emit-relocs
           Leave relocation sections and contents in fully linked executables.  Post
	   									^^^^
           link analysis and optimization tools may need this information in order to
	   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

           perform correct modifications of executables.  This results in larger
           executables.

So what's up?

> The issue is then that the collected vmlinux file and hence distribution
> packages end up unnecessarily large because of this extra data. The
> following is a size comparison of vmlinux v6.0-rc5 with and without the
> relocation information:
> | Configuration      | With relocs | Stripped relocs |
> | x86_64_defconfig   |       70 MB |           43 MB |
> | +CONFIG_DEBUG_INFO |      818 MB |          367 MB |

Hmm, I see a different story with my tailored config here:

   text    data     bss     dec     hex filename
17131605        128673450       37339140        183144195       aea8f03 vmlinux.before
17132217        128677706       37363716        183173639       aeb0207 vmlinux.after

361M vmlinux.before
361M vmlinux.after

and

738K vmlinux.relocs

and before and after .configs simply have RANDOMIZE_BASE =n and =y,
respectively.

So how do you see such a big diff, even with defconfig?

> The patch optimizes a resulting vmlinux by adding a postlink step that

Avoid having "This/The patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
