Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDDF7508B4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjGLMts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjGLMtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:49:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C5F1736
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689166134;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=JQGkWvsmtGZFIai7vA+/XacQ/YCIarTze+p+9ilZLAk=;
        b=DXz4x+NvBgc7f1R9XZ9gwmABNOAm6QsNAKqBEBO9LakYtzRxqx8KriWUNxXOuA1/Zd6kbh
        jsncNOwOHJ5GrufDvB7iwOQle4qMQYM+Jb9RzR4S6ggafKv+ID2hbj7/XzizF9KtqezibF
        2g/8+14VPdrvPQyifdi5X0HPngPw8Rk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-dibJ-QqAPU-xwONe6syHqA-1; Wed, 12 Jul 2023 08:48:50 -0400
X-MC-Unique: dibJ-QqAPU-xwONe6syHqA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F70C185A7AC;
        Wed, 12 Jul 2023 12:48:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 98D971454145;
        Wed, 12 Jul 2023 12:48:47 +0000 (UTC)
Date:   Wed, 12 Jul 2023 13:48:45 +0100
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
Message-ID: <ZK6hLZcuAH9jXKuL@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20230711154449.1378385-1-eesposit@redhat.com>
 <7E9D397B-439F-484C-B950-9094605A7B4D@zytor.com>
 <5e01b6a5-f993-f99d-41a0-ab671ec598f8@redhat.com>
 <20230712120002.GIZK6Vwga6DlJqdjEh@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230712120002.GIZK6Vwga6DlJqdjEh@fat_crate.local>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

On Wed, Jul 12, 2023 at 02:00:02PM +0200, Borislav Petkov wrote:
> On Wed, Jul 12, 2023 at 08:19:32AM +0200, Emanuele Giuseppe Esposito wrote:
> > And any comment on the SBAT string itself? I would like to get an
> > agreement on
> > "linux,1,The Linux Developers,linux,$(KERNELVERSION),https://linux.org"
> > before we use it as semplate also for downstream.
> 
> Yeah, looks useless to me. With your patch I get:
> 
> $ cat linux.sbat
> sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
> linux,1,The Linux Developers,linux,6.5.0-rc1,https://linux.org
> 
> But my branch is:
> 
> $ git describe
> v6.5-rc1-6-g3f01e9fed845

That doesn't make it useless, as the 3rd/4th/5th fields in the SBAT
file are just human targetted metadata. The validation process just
works off the 1st/2nd field.

> So your thing needs to enable CONFIG_LOCALVERSION_AUTO or so which
> allows for uniquely identifying the build. At least I think it did at
> some point. So that you can do stuff like:
> 
> $ file vmlinux
> vmlinux: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, BuildID[sha1]=19f22ac85675ea30042fb703373d97c460bb5a61, with debug_info, not stripped
> 
> and you have a build ID sha there.
> 
> But not even that works because if I change the source, I still get the
> same sha. So it needs to be an mechanism which identifies the kernel
> image uniquely.

From a functional POV, it doesn't have to be unique identified,
as it is just a human targetted metadata field. A friendly git
version as from 'git describe' is more appropriate than a build
ID sha.

> And then why does it have to be a separate section? All those
> requirements need to be written down.
>
> And regardless what you do, this looks like a contract between the
> kernel and userspace tools so it absolutely needs to be documented
> somewhere prominently - not in a commit message with links to flaky URLs
> which would probably change in the future - and explained what the tools
> parse and where one can find that parsing code.

More precisely this is a contract between 'shim' and any other
EFI binary that is intended to be validated by 'shim' during EFI
boot, with SecureBoot enabled. Normally 'shim' would be loading
a bootloader like 'grub', but with unified kernel images (vmlinuz+
cmdline+initrd bundled in one EFI binary), there's a desire to
load the kernels directly from shim without an intermediate
bootloader. IIUC, the sbat info against the kernel would actually
be relevant even if grub is loading the kernel, as grub would still
call back into shim todo validation of the binary for secureboot
compliance.

The shim project has defined this format, and the linked git repo
provided URL is the canonical location for where this is documented.

The first doc gives the background and design approach

  https://github.com/rhboot/shim/blob/main/SBAT.md

The second docs gives an example of how revocation happens

  https://github.com/rhboot/shim/blob/main/SBAT.example.md

shim is also where you'll find the parsing code, though it is
not especially interesting, since this is just a CSV file

  https://github.com/rhboot/shim/blob/main/csv.c

called from

  https://github.com/rhboot/shim/blob/main/sbat.c

> Because if we go and change that, we need to be able to verify whether
> we're not breaking any userspace tools.
>
> Actually, I wouldn't mind even having a small script which does the
> parsing and which we can use to check that we're not breaking things.

The parsing isn't the interesting bit - any trivial CSV parsing
can validate, the semantics of each field are more important.

The first line just identifies the file format and should
never change:

  sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md

The second line identifies the kernel generation

  linux,1,The Linux Developers,linux,6.5.0-rc1,https://linux.org

The first field 'linux' should never change once decided upon, as it is
the name of the upstream project's EFI component - in this case the
linux kernel.

The second field '1' is the most important one, as it is the mechanism
through which revokation takes places, and the only one a human upstream
maintainer should manually change.

If there is discovered a flaw in Linux that allows the Secure Boot chain
to be broken (eg some flaw allowed linux to be exploited as a mechanism
to load an unsigned binary), then this 'generation' number would need
to be incremented when a fix is provided in upstream Linux trees.

The SBAT config for shim would be updated to say 'linux,2' was the new
baseline, at which point it would refuse to load any binaries that still
had 'linux,1' in their sbat PE section.

When a downstream vendor builds the kernel they would actually add a
third record, where they append a vendor identifier to the 'linux'
component name, so the .sbat PE section might say.

 $ cat linux.sbat
 sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
 linux,1,The Linux Developers,linux,6.5.0-rc1,https://linux.org
 linux.fedora,1,The Fedora Project,linux,6.5.0-rc1,https://fedoraproject.org

this allows Fedora to deal with revokation if they make a downstream
only mistake that compromises SecureBoot.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

