Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223CA679AAD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbjAXNyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbjAXNy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:54:27 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8954A207
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 05:52:24 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 59D7F1EC0622;
        Tue, 24 Jan 2023 14:51:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1674568295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/pJZBw8CRojdPq618JMkjSIeI3qg1shOl5uYNyFA14I=;
        b=Hyk4GkiAh+TJ+n03P9B9VcolXL9wmrHehJSqlnpISZvqS2MKukFFvRob1sRz3a85lNNYXz
        DZaoPUK5dIutokMizzrB1pNhBdgXV8Yx7TmTY71fiFkVkYJLRiMvI2Tki3eqxNEmZuxbvJ
        kvq9L4hPqGXvJIhlNhIj3Ih/8me4IKU=
Date:   Tue, 24 Jan 2023 14:51:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Michael Roth <michael.roth@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michael Sterritt <sterritt@google.com>
Subject: Re: [PATCH v12 2/3] x86/sev: Change snp_guest_issue_request's fw_err
Message-ID: <Y8/iYyGHiPow20NX@zn.tnic>
References: <20230120214857.835931-1-dionnaglaze@google.com>
 <20230120214857.835931-3-dionnaglaze@google.com>
 <Y87s95WNc0QLZ7fn@zn.tnic>
 <CAAH4kHai7oebzWvkKXOU5UatuqF=CiWN32r9bM3Scxnx4P9nhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAH4kHai7oebzWvkKXOU5UatuqF=CiWN32r9bM3Scxnx4P9nhw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 01:22:07PM -0800, Dionna Amalie Glaze wrote:
> This isn't the primary problem that needs fixing, although it is part
> of it.

I'm replying to the 2/3 patch which is addressing this part.

> The problem is that the host can provide a throttling error and
> the guest will need to continue trying the exact same request or else
> end up locking themself out of the vmpck due to the IV reuse patch
> Peter sent.
> 
> I think Sean's request to keep throttling a host problem in user space

+ Sean.

> is not the right one in this case. That would avoid scheduling the
> whole vCPU, but the guest code I'm proposing can do other useful work
> while waiting. There will be no other code that depends on that
> particular control flow.

I know there's another issue but my angle is this:

You have a patch with Fixes tags and they all are fixing some shortcomings. Now,
those are good candidates for stable.

In order to be backportable to stable, those fixes should be as minimal as
possible so that a stable backport does not turn into a nightmare. By the looks
of it, your patches could be simplified to the bare minimum fixes. Cleanups and
improvements can go ontop.

That is, provided we want them in stable and by the looks of it, we probably do.

Which then means, you could do the minimal fixes first and then the cleanups
ontop.

Then, please try to structure your commit messages in a format close to:

Problem is A.

It happens because of B.

Fix it by doing C.

(Potentially do D).

I'm having hard time parsing

https://lore.kernel.org/all/20230120214857.835931-4-dionnaglaze@google.com/

Only in the second paragraph it is talking about what the problem is. And by the
looks of it, if the host throttles, then the guest should not return from that
request.

And adding module params for this are most of the time the wrong solution
because then people would have to *know* how to use them.

And before we add module params, the kernel should try to solve this without any
user interaction, if possible.

But I'm not 100% clear on what exactly we're fixing here so let's start first,
please, with a proper description of what the exact issue is and how it happens.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
