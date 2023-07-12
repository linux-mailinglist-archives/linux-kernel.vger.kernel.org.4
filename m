Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB57750A70
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjGLOHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjGLOHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:07:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2173F1712
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689170815;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8alxMkKTXZ8M6N8qU+cXE7cMzVcGRBUw/7st1qsPwiE=;
        b=F5Jwa0+C+KOIUEmE/O0ImxwlsTmK4Rldt1fGFGd/ZhBGDbbFsIospCQbKTXu4i2Zqruy/H
        4JmrFflei266OxxG5qC3RXRq12rTBMaYuF0QcG814tfr7gbL8q1Y+qwO4ioVG76ifNremr
        vmCs8EjeSmpBgkF4EM9u4BsYc4NAshw=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-on2eahoBMDCQ7Z8HccJyPw-1; Wed, 12 Jul 2023 10:06:51 -0400
X-MC-Unique: on2eahoBMDCQ7Z8HccJyPw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E19B280D5A4;
        Wed, 12 Jul 2023 14:06:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 46BB6C1ED96;
        Wed, 12 Jul 2023 14:06:48 +0000 (UTC)
Date:   Wed, 12 Jul 2023 15:06:46 +0100
From:   Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
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
Message-ID: <ZK6zdsIbnQFUmK69@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20230711154449.1378385-1-eesposit@redhat.com>
 <7E9D397B-439F-484C-B950-9094605A7B4D@zytor.com>
 <5e01b6a5-f993-f99d-41a0-ab671ec598f8@redhat.com>
 <20230712120002.GIZK6Vwga6DlJqdjEh@fat_crate.local>
 <ZK6hLZcuAH9jXKuL@redhat.com>
 <20230712132840.GKZK6qiK70m1O90jFL@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230712132840.GKZK6qiK70m1O90jFL@fat_crate.local>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 03:28:40PM +0200, Borislav Petkov wrote:
> On Wed, Jul 12, 2023 at 01:48:45PM +0100, Daniel P. Berrangé wrote:
> > That doesn't make it useless, as the 3rd/4th/5th fields in the SBAT
> > file are just human targetted metadata. The validation process just
> > works off the 1st/2nd field.
> 
> It's a good thing I asked - feels like I'm just scratching the surface
> on what this thing actually is and the commit message is not explaining
> any of that.
> 
> First, second field, that's what, "linux,1"?

Each sbat CSV file line has following fields:

  component_name: the name we're comparing
  component_generation: the generation number for the comparison
  vendor_name: human readable vendor name
  vendor_package_name: human readable package name
  vendor_version: human readable package version (maybe machine parseable too, not specified here)
  vendor_url: url to look stuff up, contact, whatever.

So 'linux' is 'component_name' and '1' is component_generation

> > From a functional POV, it doesn't have to be unique identified,
> > as it is just a human targetted metadata field. A friendly git
> > version as from 'git describe' is more appropriate than a build
> > ID sha.
> 
> So can you explain what exactly that version is supposed to describe?
> Exact kernel sources the kernel was built from? Or a random, increasing
> number which tools can use to mark as bad?

AFAICT beyond being "human readable package version", it is a fairly
arbitrary decision. A release version number for formal releases, or
a 'git describe' version string for git snapshots both satisfy the
versioning requirement IMHO.

> How do you prevent people from binary-editing that section? Secure boot
> does that because that changes the signed kernel image?

The PE files are signed by the vendor who builds them, using their
SecureBoot signing key. The data covered by the signature includes
the '.sbat' section.

IOW, if you binary edit the section, the SecureBoot signature
verification fails and the kernel won't be booted.

> > > And then why does it have to be a separate section? All those
> > > requirements need to be written down.
> 
> You missed this question.

That's simply what the spec defines as the approach.

The PE file format used by EFI applications has multiple
sections and the spec has declare that the '.sbat' section
is where this data shall live.

> > The first line just identifies the file format and should
> > never change:
> > 
> >   sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
> 
> Why do you even need it then?

First it identifies the data format, and second if a
problem is ever discovered with the  SBAT concept,
a fixed approach can be indicated by changing to
'sbat,2,.....' and thus have the effect of revoking
use of any binaries which declare the 'sbat,1,....'
version. Pretty unlikely this will happen, but a useful
backup plan/safety net.

> > The second line identifies the kernel generation
> > 
> >   linux,1,The Linux Developers,linux,6.5.0-rc1,https://linux.org
> > 
> > The first field 'linux' should never change once decided upon, as it is
> > the name of the upstream project's EFI component - in this case the
> > linux kernel.
> > 
> > The second field '1' is the most important one, as it is the mechanism
> > through which revokation takes places, and the only one a human upstream
> > maintainer should manually change.
> 
> Hold on, how often are those things going to change? And who's going to
> change them? I sure hope we won't start getting patches constantly
> updating those numbers?

It is hard to predict the future, but my gut feeling is very infrequently.

I can't say I recall any specific Linux bugs that would warrant it, but
those involved in Linux/Bootloade/SecureBoot world can probably answer
this better than me. IIUC, the scope of bugs relevent to this is quite
narrow.

> > If there is discovered a flaw in Linux that allows the Secure Boot chain
> > to be broken (eg some flaw allowed linux to be exploited as a mechanism
> > to load an unsigned binary), then this 'generation' number would need
> > to be incremented when a fix is provided in upstream Linux trees.
> 
> Oh boy, there it is. And then when those fixes need to be backported to
> stable, then those patches updating that number would need to be
> backported too. I can already see the mess on the horizon.

If applicable, yes.

> > The SBAT config for shim would be updated to say 'linux,2' was the new
> > baseline, at which point it would refuse to load any binaries that still
> > had 'linux,1' in their sbat PE section.
> 
> Ok, I fetch the latest upstream kernel, it has "linux,1", shim refuses
> to load. I go, edit the sources, increment that to "linux,234" and secure
> boot works. No fixes applied.

Everything involved in the boot path is covered by signatures, so if
SecureBoot is enabled you can't simply build custom binaries. They
won't run unless you modify your EFI firmware config to trust your
own signing keys. If a user wants to compromise their own machine in
that way, that's fine.

> > When a downstream vendor builds the kernel they would actually add a
> > third record, where they append a vendor identifier to the 'linux'
> > component name, so the .sbat PE section might say.
> > 
> >  $ cat linux.sbat
> >  sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
> >  linux,1,The Linux Developers,linux,6.5.0-rc1,https://linux.org
> >  linux.fedora,1,The Fedora Project,linux,6.5.0-rc1,https://fedoraproject.org
> > 
> > this allows Fedora to deal with revokation if they make a downstream
> > only mistake that compromises SecureBoot.
> 
> What does that mean, "allows Fedora to deal with revokation"?

Lets say Fedora applied a non-upstream kernel patch that compromised
SecureBoot. Upstream Linux has no reason to change their SBAT component
generation number. Instead Fedora would change their 'linux.fedora'
component generation number to reflect their own mistake.

> In any case, I think this does not belong in the upstream kernel as this
> will turn us into CVE trackers. Distros sure, ofc, that's more along the
> lines of what they do but not the upstream kernel.

My understanding is that CVEs in general would not apply in this
scenario, the scope of bugs that are impactful is reasonably
narrow. I'll defer to people more experienced in SecureBoot though
if they have a better answer.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

