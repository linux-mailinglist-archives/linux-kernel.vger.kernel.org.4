Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F2D6378FB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 13:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiKXMie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 07:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKXMid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 07:38:33 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197CB429A2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:38:32 -0800 (PST)
Received: from zn.tnic (p200300ea9733e75b329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e75b:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 757AD1EC0495;
        Thu, 24 Nov 2022 13:38:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669293510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oGY+SaFxUmHB4yk5ENhSmCp96R0pgyfVfBDIlhKAmgo=;
        b=i+LTaHFfT5NqSXCh5wI5NwVBMDnwj7zUR8QX9pqAH31tgIP+5T9/2vQaVAD1Qyi9orZisZ
        Yn2xiNDWL4b0l2Hc04bDYIdLGs0UnAxORJ9rq2YYP55qAeHcqHY+lfhc8P4GpZ2U1XpAda
        ca7kSqADMmRLBeT7G2pm3A38NYxGYrg=
Date:   Thu, 24 Nov 2022 13:38:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, nicolas@fjasle.eu,
        masahiroy@kernel.org, kirill.shutemov@linux.intel.com,
        tony.luck@intel.com, michael.roth@amd.com, nathan@kernel.org,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: Avoid relocation information in final vmlinux
Message-ID: <Y39lwk3itVnsADrP@zn.tnic>
References: <20220927084632.14531-1-petr.pavlu@suse.com>
 <Y34SXeU6JEk+UGfV@zn.tnic>
 <1af5ee66-5ab1-45b2-f229-182f89dc6b94@suse.com>
 <Y35CNdPVwq11NCYN@zn.tnic>
 <765e1e78-c540-0753-7a19-7d335bcc998b@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <765e1e78-c540-0753-7a19-7d335bcc998b@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 10:21:33AM +0100, Petr Pavlu wrote:
> Option CONFIG_RANDOMIZE_BASE=y needs to be enabled. Switching it on should
> automatically select also CONFIG_X86_NEED_RELOCS=y which is what actually
> enables use of --emit-relocs in arch/x86/Makefile.

Yeah, as I said in my previous mail:

"and before and after .configs simply have RANDOMIZE_BASE =n and =y,
respectively."

I just did it again to make sure:

-rwxr-xr-x 1 boris boris 377666112 Nov 24 13:28 vmlinux.before
-rwxr-xr-x 1 boris boris 377718768 Nov 24 13:33 vmlinux.after

With

$ grep -E "(NEED_RELOCS|RANDOMIZE)" .config
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0x0
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y

that second vmlinux file is even a bit larger (~51K) ...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
