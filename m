Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C399640DCF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbiLBStk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiLBSti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:49:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC0ACC65A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 10:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670006915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7vPA2vMS6+jrxhjeSX8HqN1ZJyABBu3j4HE8v22a5/Q=;
        b=IPO3oBPy9sBioZII7TZEJ3WN1pjqFxoICgbNhG39sOwuB4NamTECOTmoQThJecEDIr41of
        LDOPkhPWFFlDAu0cs/132+J/GFcKO8feAgdYpSMy92kUHnFzCRjbfX+y1B5Np2qc58ZKX7
        OMvUPORgpgGjBW+TmD8eInFRIv99DxU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-189-A51K0vazO-uIARW0J2CGZw-1; Fri, 02 Dec 2022 13:48:29 -0500
X-MC-Unique: A51K0vazO-uIARW0J2CGZw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 53758886461;
        Fri,  2 Dec 2022 18:48:29 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B7A2D111E3FA;
        Fri,  2 Dec 2022 18:48:27 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: CET shadow stack app compatibility
References: <7d8133c7e0186bdaeb3893c1c808148dc0d11945.camel@intel.com>
        <CAHk-=wgP5mk3poVeejw16Asbid0ghDt4okHnWaWKLBkRhQntRA@mail.gmail.com>
        <87sfikvfho.fsf@oldenburg.str.redhat.com>
        <3bab52bb0076a4921f824e438488a66d913b4deb.camel@intel.com>
Date:   Fri, 02 Dec 2022 19:48:24 +0100
In-Reply-To: <3bab52bb0076a4921f824e438488a66d913b4deb.camel@intel.com> (Rick
        P. Edgecombe's message of "Tue, 15 Nov 2022 16:57:16 +0000")
Message-ID: <87a645prpj.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Rick P. Edgecombe:

> For IBT, which seems to be in worse shape than shadow stack from an
> existing userspace perspective, I have also seen shared objects with
> issues.
>
> For shadow stack, it was just JITing binaries.

Except that the actual JITters are usually in shared objects, too, and
you just assume here that they get loaded by a main program from the
same build. 8-) I think most of them are reusable independently, or are
bundled into applications built with a different toolchain.

> Of course if glibc is compiled in non-permissive mode there is an
> additional category of issues around dlopen()ing that we haven't even
> discussed yet. And the past issues around makecontext() we have
> already worked around from the kernel. If you are aware of any other
> specific compatibility problems, please share so we can discuss the
> extent.

H.J. ran most of the experiments on Fedora.  We did some early
validation many years ago, using the first ABI iteration.  We didn't
have as much reach as we liked in terms of hardening at the time, if I
recall correctly, but there were only very few cases where something did
not work and was also not marked as incompatible.

>>   The posted hack didn't even
>> deal with that case.  If the main executable has the current markers,
>> the kernel will not disable shadow stack, and the process will still
>> crash after loading the incorrectly marked shared object.
>
> The proposed glibc changes would not enable shadow stack unless the
> execing binary has the elf bit marked. So if we block those binaries
> (which the kernel can easily check) from enabling shadow stack, none of
> the linked shared objects will have shadow stack either. So I think we
> are ok to hold this in our back pocket to resolve the known issues if
> anyone complains.

See above, the assumption that the JITter and the main program come from
the same build that is implicit in this is not actually true in
practice.

> Where the shared objects could come into play is, in the event that we
> have to block the old elf bit from the kernel, and a new one is
> properly marked on a new executable, future glibcs could decide to
> honor the old bits when checking shared libraries. So you could have an
> executable with SHSTK2 bit loading a problem SO with just SHSTK1 bit.

Right.  But we can also have policies in userspace to paper over this.
I'm not worried about it.  I want to see how far we can get before
making the flip in an upstream version of glibc, but if the kernel
enforces SHSTK2 (even just on executables), I need a toolchain update
plus a rebuild of a large chunk of the distribution.

So with reusing SHSTK1 markup, it goes like this:

1. Get a Fedora rawhide kernel with userspace SHSTK support.
2. Get the glibc patches from H.J., and gate them behind a tunable
   (off by default).  Kernel behavior should not change with this
   new glibc because the required arch_prctl does not happen
   (and the old ones currently in glibc have different numbers).
3. Run the Fedora graphical desktop with the tunable switched on and a few =
key
   third-party applications to see where we stand in terms of
   compatibility.
3b Do the same thing with RHEL and some enterprise applications
   (using the kernel and glibc from 1 & 2 for a start).
4. (Optional.) Flip the default of the tunable to on.

I don't know how quickly we can get past step 1, but it seems fairly
soon, maybe three months, considering the upcoming end-of-year break.

With SHSTK2 markup required by the kernel, it goes like this:

1. Get a Fedora rawhide kernel with userspace SHSTK support.
2. Get a SHSTK2-enabled toolchain.  GCC is currently freezing for the 13
   release, so this is not a good time of the year for that.  It's
   probably going to be a custom compiler, unless we want to wait a
   couple of months, and even then it's got to be a downstream-only
   backport at first because to upstream, this will have a =E2=80=9Cnot
   finished=E2=80=9D whiff (it's the umpteenth ABI change).
3. Get the glibc patches from H.J.  We would probably put it behind
   a tunable as  well.
4. Rebuild key parts of Fedora, probably directly in rawhide (the
   rolling integration distribution).
5. Run the Fedora rawhide graphical desktop etc.
6. RHEL testing will require a SHSTK2 port to a different compiler
   and another mass rebuild.  ISV application testing is not meaningful
   until the ISVs have switched to a newer compiler.

That's going to take much longer than three months.  Maybe we have to do
this in the end, but even then, we have no way of forcing developers to
test on SHSTK-capable hardware on new-enough before turning on the
SHSTK2 bit.

In the end, we might still need SHSTK2, but we don't know that yet, and
the first approach is quite cheap, so I really want to try it.

Keep in mind that just because some useful interface is provided by the
kernel, we can't necessarily use it in glibc immediately because with
all those seccomp filters out there (and other dependencies on internal
glibc/kernel interface details), too much would break if we exposed it
into existing applications without some coordination.  SHSTK isn't
*that* different, except that we have some binary markup to guide us at
run time.

> But I still don't see why doing the order:
> 1. kernel support
> 2. libc support
> 3. compiler support
>
> ...wouldn't have generated a more normal situation where old binaries
> don't break against new kernels and testing can easily happen to reduce
> issues further. So we could still reset and do exactly that.

No matter in which order you do it, some group will want to change ABI
or semantics.  We actually had multiple different iterations in
different orders, and everybody wanted to put their mark onto this
feature, changing the ABI.  I don't care at all about the internal ABI
between glibc and the kernel, but the markup of the binaries (besides
glibc itself) is quite important to me.

In retrospect, separating SHSTK from IBT from the start would have
helped a lot because I think we could have done that in libc without
compiler support.  But I don't think anyone expected this to take four
to five years to implement (or probably longer for IBT).

>>   Instead, we'd have to
>> wait for a rebuild with the new markers, and of course this rebuild
>> will
>> put is in exactly the same position as before: the incompatibilities
>> will be back because they are no longer masked by the kernel.
>
> People building new apps and testing them against upstream kernels and
> finding issues sounds like business as usual. I'm not trying to solve
> all possible userspace mistakes from the kernel.

They also have to test on the right hardware and with a new/unreleased
glibc.

I think it would be helpful to those developers if we could give them an
existing distribution early on they can use for experiments.  Not just
getting SHSTK going, but also playing with the perf integration (which
to me is the real goal here).

Thanks,
Florian

