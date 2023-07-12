Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4DD750998
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjGLN3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjGLN3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:29:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14AD10E2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:29:05 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 102041EC0786;
        Wed, 12 Jul 2023 15:29:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1689168544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=urjcaXfcwZ1Tr6JZLkw9hFxO9aeIb41RCqU808DqpwQ=;
        b=q/nlb74QBXh8EuHez5gAiQF5EDsb6VUgSOSK4dejt399UMV41VJJnHabwRU7fZjjcRIdpN
        yDjhlm+3wqEGx06oF2hLrjwIhxBAFoOBHc5Hy88EGfxB/bpibhlj8iJil0rWehlDWLG6Yw
        RWcTnL69q3tjmmclZpLd2z7UaCg6icY=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LNt6mIcYUUaC; Wed, 12 Jul 2023 13:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1689168540; bh=1zRxPT6tvLexT98aandMWUc4rA5xRBynPKdz28wI3cc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e78SZE7SkRjFjLsyps5wuTN/p42IF9z+mFnAyoH0lgtqLDmSI6zpLAmKZTQNRi1L6
         OTmhEoH2tclrfW2CPWiepwj2FdLfe2IkgzOiX7hxKkRVVIqRtHyYfS2JTptaFAW2wB
         kR3ybPueVqh4uustYl9ylqf7z1FYiyi8VwyUa9vqxshCE0dLxRxLPfZejSLYjqM9PR
         D7eJUqvg7WBBxJdp1b2J0tT7y3Qn2gI3ubBA8Yo4/eplIgf0TkYKvpDPIE/LLXEBJT
         3lcm0zf9VlzaTQ2mnr9s5dv1KXo2vCc4A4qitbdegPeDJ6BR8Ve0fOOIj5Jl92Tcos
         AX8ScY8TiAIX0vqGWMCpswHmtmsGdNwnqGj09v9my3p/VshMtc1DC6OoPVnB9cjnqi
         Fe8Q6v7+QKvhqOxKMjzHHFFNVkHKa+oRo0DM9096l4FCRShgt/trfBNvf1Lx8bfasU
         eSfxvQoxgJMGyGN7zGZOtNkNRKeQda6jn/bimN50IX1mwW2VUdwc7+hI54PHqn5LII
         3+mcibVOVSWpksie2W2Zyw5/p3OYPiCFoOFBERI4cr5VGQKxmz4H8Cma5n9STSJgw1
         aRYijjqcnaWlKP304oWB7wEdgS8juOK5DD7oGKGeiCgh7wM5wWDS7yG6KCO5ZCCzWB
         Eqi5rae31z0yMZUxd5DGRoDQ=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2D95F40E0140;
        Wed, 12 Jul 2023 13:28:45 +0000 (UTC)
Date:   Wed, 12 Jul 2023 15:28:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, bluca@debian.org,
        lennart@poettering.net, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
Message-ID: <20230712132840.GKZK6qiK70m1O90jFL@fat_crate.local>
References: <20230711154449.1378385-1-eesposit@redhat.com>
 <7E9D397B-439F-484C-B950-9094605A7B4D@zytor.com>
 <5e01b6a5-f993-f99d-41a0-ab671ec598f8@redhat.com>
 <20230712120002.GIZK6Vwga6DlJqdjEh@fat_crate.local>
 <ZK6hLZcuAH9jXKuL@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZK6hLZcuAH9jXKuL@redhat.com>
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 01:48:45PM +0100, Daniel P. Berrang=C3=A9 wrote:
> That doesn't make it useless, as the 3rd/4th/5th fields in the SBAT
> file are just human targetted metadata. The validation process just
> works off the 1st/2nd field.

It's a good thing I asked - feels like I'm just scratching the surface
on what this thing actually is and the commit message is not explaining
any of that.

First, second field, that's what, "linux,1"?

> From a functional POV, it doesn't have to be unique identified,
> as it is just a human targetted metadata field. A friendly git
> version as from 'git describe' is more appropriate than a build
> ID sha.

So can you explain what exactly that version is supposed to describe?
Exact kernel sources the kernel was built from? Or a random, increasing
number which tools can use to mark as bad?

How do you prevent people from binary-editing that section? Secure boot
does that because that changes the signed kernel image?

> > And then why does it have to be a separate section? All those
> > requirements need to be written down.

You missed this question.

> More precisely this is a contract between 'shim' and any other
> EFI binary that is intended to be validated by 'shim' during EFI
> boot, with SecureBoot enabled. Normally 'shim' would be loading
> a bootloader like 'grub', but with unified kernel images (vmlinuz+
> cmdline+initrd bundled in one EFI binary), there's a desire to
> load the kernels directly from shim without an intermediate
> bootloader. IIUC, the sbat info against the kernel would actually
> be relevant even if grub is loading the kernel, as grub would still
> call back into shim todo validation of the binary for secureboot
> compliance.
>=20
> The shim project has defined this format, and the linked git repo
> provided URL is the canonical location for where this is documented.
>=20
> The first doc gives the background and design approach
>=20
>   https://github.com/rhboot/shim/blob/main/SBAT.md

Yeah, tried reading that. That section explaining the prior to
disclosure, after disclosure numbers incrementing is a mess waiting to
happen.

> The first line just identifies the file format and should
> never change:
>=20
>   sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/S=
BAT.md

Why do you even need it then?

> The second line identifies the kernel generation
>=20
>   linux,1,The Linux Developers,linux,6.5.0-rc1,https://linux.org
>=20
> The first field 'linux' should never change once decided upon, as it is
> the name of the upstream project's EFI component - in this case the
> linux kernel.
>=20
> The second field '1' is the most important one, as it is the mechanism
> through which revokation takes places, and the only one a human upstrea=
m
> maintainer should manually change.

Hold on, how often are those things going to change? And who's going to
change them? I sure hope we won't start getting patches constantly
updating those numbers?

> If there is discovered a flaw in Linux that allows the Secure Boot chai=
n
> to be broken (eg some flaw allowed linux to be exploited as a mechanism
> to load an unsigned binary), then this 'generation' number would need
> to be incremented when a fix is provided in upstream Linux trees.

Oh boy, there it is. And then when those fixes need to be backported to
stable, then those patches updating that number would need to be
backported too. I can already see the mess on the horizon.

> The SBAT config for shim would be updated to say 'linux,2' was the new
> baseline, at which point it would refuse to load any binaries that stil=
l
> had 'linux,1' in their sbat PE section.

Ok, I fetch the latest upstream kernel, it has "linux,1", shim refuses
to load. I go, edit the sources, increment that to "linux,234" and secure
boot works. No fixes applied.

So either I'm missing something but if not, that number thing is really
silly.

> When a downstream vendor builds the kernel they would actually add a
> third record, where they append a vendor identifier to the 'linux'
> component name, so the .sbat PE section might say.
>=20
>  $ cat linux.sbat
>  sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SB=
AT.md
>  linux,1,The Linux Developers,linux,6.5.0-rc1,https://linux.org
>  linux.fedora,1,The Fedora Project,linux,6.5.0-rc1,https://fedoraprojec=
t.org
>=20
> this allows Fedora to deal with revokation if they make a downstream
> only mistake that compromises SecureBoot.

What does that mean, "allows Fedora to deal with revokation"?

Anyway, thanks for taking the time to explain.

In any case, I think this does not belong in the upstream kernel as this
will turn us into CVE trackers. Distros sure, ofc, that's more along the
lines of what they do but not the upstream kernel.

And there must be a better way to map "fixes present in the tree" to
a number which shim verifies.

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
