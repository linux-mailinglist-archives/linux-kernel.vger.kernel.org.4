Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A1862927D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 08:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiKOHep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 02:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiKOHeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 02:34:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A880BA193
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 23:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668497630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ia/tr5uOXIlHww5hNhK8VykvdREZ7zu2X/zBVi2vKPw=;
        b=LV3WlrF4idor6x9G+Ahi2UprQjecQjOVOSyKm1szZgAa+AvTJpR2ZOi6X73UGI0g6hQX7T
        uW5BrQJBy9sRq9eDcZH075q9qBLL7Wk7+CKsE45l/EqAREOZCBwcVEP/XGHx9ramuCvC7m
        HnKK2AoDvIFVkEmxcZwtBHonMPJyOKM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-156-TAjnytUUPsWiyPhNukzE4g-1; Tue, 15 Nov 2022 02:33:45 -0500
X-MC-Unique: TAjnytUUPsWiyPhNukzE4g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07B461C0758E;
        Tue, 15 Nov 2022 07:33:45 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F7CDC15E76;
        Tue, 15 Nov 2022 07:33:43 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: CET shadow stack app compatibility
References: <7d8133c7e0186bdaeb3893c1c808148dc0d11945.camel@intel.com>
        <CAHk-=wgP5mk3poVeejw16Asbid0ghDt4okHnWaWKLBkRhQntRA@mail.gmail.com>
Date:   Tue, 15 Nov 2022 08:33:39 +0100
In-Reply-To: <CAHk-=wgP5mk3poVeejw16Asbid0ghDt4okHnWaWKLBkRhQntRA@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 14 Nov 2022 18:01:46 -0800")
Message-ID: <87sfikvfho.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds:

> I'm disgusted by glibc being willing to just upgrade and break
> existing binaries and take the "you shouldn't upgrade glibc if you
> have old binaries" approach.

We've been in this position for years.  Every time we use a new system
call to implement existing functionality in glibc, some applications
break.  Mostly due to seccomp filters.  They break even if there would
be no observable differences for applictions in the way the new system
calls would be invoked if the seccomp filter wouldn't block them.

I proposed a new ENOSYS handshake between userspace and kernel to reduce
the amount of breakage (but not all of it).  Senior kernel developers
rejected it, so we didn't implement it in glibc.

  [PATCH] syscalls: Document OCI seccomp filter interactions & workaround
  <https://lore.kernel.org/linux-api/87lfer2c0b.fsf@oldenburg2.str.redhat.com/>

(It deals with OCI because it's well-documented, but the same principle
would have applied to browser sandboxes, too.)

Instead, we work with distributions and upstreams to make sure the
applications are ready before the next distribution glibc update.
Fortunately, there seems to be a pretty broad overlap between
seccomp-using applications and applications with frequent, more-or-less
mandatory updates, so the transition periods are relatively short.  You
didn't seem to have noticed, so maybe we aren't doing such a bad job
after all.

I don't see why CET or x86 shadow stack support could not be handled in
the same way.  (There is probably a similar overlap.)  At least we
should try how far we can get with the existing binaries, and if things
turn out not working after all, we will have to start over with
different markers.  But the kernel shouldn't have to care.

Based on what we have seen so far (and since fixed), it's mostly shared
objects that weren't marked up correctly.  The posted hack didn't even
deal with that case.  If the main executable has the current markers,
the kernel will not disable shadow stack, and the process will still
crash after loading the incorrectly marked shared object.  Someone has
to step in and fix things for real (so that they don't break again just
after rebuild with a current toolchain adding the current markers).  The
kernel patch makes this harder because it's not possible anymore to use
an existing distribution for this kind of work.  Instead, we'd have to
wait for a rebuild with the new markers, and of course this rebuild will
put is in exactly the same position as before: the incompatibilities
will be back because they are no longer masked by the kernel.

Fortunately, we are in a way better situation on x86 than where we are
with PAC on AArch64: there you have to reboot with a custom kernel
option to disable PAC and restore compatibility with applications.  (As
far as I know, PAC state isn't process-switched, which I find rather
flabbergasting.)  Furthermore, the way it was deployed in application
and libraries was largely unconditional (hard-coded into hand-written
assembly, without preprocessor conditionals to see of PAC was enabled
during the build).  At least the presence of CET features depends on CET
compiler flags, and we can easily turn it off on a per-process basis if
there are any incompatibilities.

Thanks,
Florian

