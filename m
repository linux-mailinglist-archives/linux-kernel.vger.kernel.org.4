Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9697165AD4C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 06:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjABFuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 00:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABFuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 00:50:44 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB024114E
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 21:50:42 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 04F8C1EC04AD;
        Mon,  2 Jan 2023 06:50:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672638641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KNARFvNRF3/uNoEZNfyHRQ1mNp3FRIAd1Kh6JpigTAU=;
        b=EwhAW3ZMQ5mHmamvxGQza8LDPgkAHg2W9i+6MiWrnI1SmyPZXvcR3V/wNJSjhdWFVEs9Eh
        yON4gwl2XO/AnTuZ6o61SoQgppqUAbgm1nJbtaE5vfCCrKi9fbK2z7KkpP3HF2+ZlJ22t7
        9XgvfECl0k/BcwM98LAA/58G602g+8w=
Date:   Mon, 2 Jan 2023 06:50:35 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, pbonzini@redhat.com,
        ebiggers@kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        qemu-devel@nongnu.org, ardb@kernel.org, kraxel@redhat.com,
        philmd@linaro.org
Subject: Re: [PATCH qemu] x86: don't let decompressed kernel image clobber
 setup_data
Message-ID: <Y7Jwq/TzywGtktJy@zn.tnic>
References: <Y69h6ur79SMhu61F@zx2c4.com>
 <46466e54-25c3-3194-8546-a57cd4a80d9d@zytor.com>
 <Y7A76+IBS4fnucrW@zn.tnic>
 <Y7A8qP05B0YRbQIN@zx2c4.com>
 <Y7A9nBud6UeH+wYd@zn.tnic>
 <Y7A+YELM7m5E2PUQ@zx2c4.com>
 <Y7BGIAL4z6o6FEI5@zn.tnic>
 <Y7B993P1+jYB/etX@zx2c4.com>
 <Y7CGzde+qPB7YJP4@zn.tnic>
 <60566f8b-c90f-12e7-c13e-94e9829eee2d@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60566f8b-c90f-12e7-c13e-94e9829eee2d@zytor.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 07:21:06PM -0800, H. Peter Anvin wrote:
> As far as the decompression itself goes, it should only a problem if we are
> using physical KASLR since otherwise the kernel has a guaranteed safe zone
> already allocated by the boot loader. However, if physical KASLR is in use,

No KASLR in Jason's config AFAICT:

$ grep RANDOMIZE .config
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set

> then the decompressor needs to know everything there is to know about the
> memory map.

Yeah, we do have that but as you folks establish later in the thread, those
setup_data regions would need to be avoided too. ;-\
 
> However, there also seems to be some kind of interaction with AMD SEV-SNP.
> 
> 
> The bug appears to have been introduced by:
> 
> b57feed2cc2622ae14b2fa62f19e973e5e0a60cf
> x86/compressed/64: Add identity mappings for setup_data entries
> https://lore.kernel.org/r/TYCPR01MB694815CD815E98945F63C99183B49@TYCPR01MB6948.jpnprd01.prod.outlook.com
> 
> ... which was included in version 5.19, so it is relatively recent.

Right. We need that for the CC blob:

b190a043c49a ("x86/sev: Add SEV-SNP feature detection/setup")

> For a small amount of setup_data, the solution of just putting it next to
> the command line makes a lot of sense, and should be safe indefinitely.

Ok.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
