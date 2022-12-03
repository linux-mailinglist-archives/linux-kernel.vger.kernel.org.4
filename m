Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6BC641899
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 20:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiLCTiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 14:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiLCTiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 14:38:00 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBE61145C
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 11:37:58 -0800 (PST)
Received: from zn.tnic (p200300ea9733e766329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e766:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 44B2C1EC06AC;
        Sat,  3 Dec 2022 20:37:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1670096276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=51jhFlXJaAwTYZ4hjT4NE5fe0FNuTRMhfglVIz/F+xw=;
        b=ovEuVdEn0wpQRN1l61ZfkaESeMe+W2+dQyZyTlPSCNFv3uXa+2PRunLSvxtHW55fY/aC0x
        befweI7vryo/xMfheEzgXSn0KUsgndqO0P5vvmqwBZKOIBoeZMB5qrBQlGcLf8ykQSFaHl
        l6FHn3mC+ApQ84aMOuxb7Q5YTrK+1lo=
Date:   Sat, 3 Dec 2022 20:37:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dionna Amalie Glaze <dionnaglaze@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Gonda <pgonda@google.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirsky <luto@kernel.org>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v8 1/4] crypto: ccp - Name -1 return value as
 SEV_RET_NO_FW_CALL
Message-ID: <Y4ulj38eMr1NiRdX@zn.tnic>
References: <20221104230040.2346862-1-dionnaglaze@google.com>
 <20221104230040.2346862-2-dionnaglaze@google.com>
 <Y4tAX580jEGHOU9d@zn.tnic>
 <CAAH4kHYz-46syE4wKPzo1N9P34wLHcs85obOCjqb6eQ=iv=n3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAH4kHYz-46syE4wKPzo1N9P34wLHcs85obOCjqb6eQ=iv=n3w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2022 at 10:58:39AM -0800, Dionna Amalie Glaze wrote:
> It doesn't always overwrite psp_ret, such as the initial error checking.
> The value remains uninitialized for -ENODEV, -EBUSY, -EINVAL.
> Thus *error in __sev_platform_init_locked can be set to uninitialized
> memory if psp_ret is not first initialized.

Lemme see if I understand it correctly: you wanna signal that all early
return cases in __sev_do_cmd_locked() are such that no firmware was
called?

I.e., everything before the first iowrite into the command buffer?

But then the commit message says:

"The PSP can return a "firmware error" code of -1 in circumstances where
the PSP is not actually called."

which is confusing. How can the PSP return something if it wasn't called?

Or you mean those cases above where it would fail on some of the checks
before issuing a SEV command? I think you do...

So I see Tom has ACKed this but I have to ask: is the SEV spec not going
to use -1 ever?

Also, if this behavior is going to be user-visible, where are we
documenting it? Especially if nothing in the kernel is looking at
that value but only assigning it to a retval which gets looked at by
userspace. Especially then this should be documented.

Dunno, maybe somewhere in Documentation/x86/amd-memory-encryption.rst or
maybe Tom would have a better idea.

> That error points to the kernel copy of the user's argument struct,
> which the ioctl always copies back. In the case of those error codes
> then, without SEV_RET_NO_FW_CALL, user space will get uninitialized
> kernel memory.

Right, but having a return value which means "firmware wasn't called"
sounds weird. Why does userspace care?

I mean, you can just as well return any of the negative values -ENODEV,
-EBUSY, -EINVAL too, depending on where you exit. Having three different
retvals could tell you where exactly it failed, even.

But the question remains: why does userspace needs to know that the
failure happened and firmware wasn't called, as long as it is getting
something negative to signal an error?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
