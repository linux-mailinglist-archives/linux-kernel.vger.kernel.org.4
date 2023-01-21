Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2303676794
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 18:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjAURFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 12:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjAURFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 12:05:35 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9492BF19
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 09:05:28 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BEDE01EC03D6;
        Sat, 21 Jan 2023 18:05:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1674320726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/ugdHndkJubVCYiifnWomQkg8SQhyVw94tWxR5BSZtA=;
        b=Q/gXf5eDkD4n7/ga0IaTcZ6fje8i8FzqYiscA4oxZ0bF8n9hf3kIO7cff2WbHlDx1qZvGf
        BcR5kOFLn4Oojk4rLxceXhPIyL5w7GfXps9I9FcJDqmEpbv1r55uANscyLN4qTrzHJs1Zn
        eLEH8z1MgGjXkS7ASSBI44cePKIKSWE=
Date:   Sat, 21 Jan 2023 18:05:22 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dionna Glaze <dionnaglaze@google.com>
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
Message-ID: <Y8wbUotoKnJi90dj@zn.tnic>
References: <20230120214857.835931-1-dionnaglaze@google.com>
 <20230120214857.835931-3-dionnaglaze@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230120214857.835931-3-dionnaglaze@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 09:48:55PM +0000, Dionna Glaze wrote:
> The GHCB specification declares that the firmware error value for a
> guest request will be stored in the lower 32 bits of EXIT_INFO_2.
> The upper 32 bits are for the VMM's own error code. The fw_err argument
> is thus a misnomer, and callers will need access to all 64 bits.
> 
> The type of unsigned long also causes problems, since sw_exit_info2 is
> u64 (unsigned long long) vs the argument's unsigned long*. This type
> is changed for issuing the guest request. The ioctl command struct's
> error field is passed directly instead of a local variable, since an
> incomplete guest request may not set the error code, and uninitialized
> stack memory would be written back to user space.
> 
> The firmware might not even be called, so the call is bookended with
> the no firmware call error and clearing the error.
> 
> Since the "fw_err" field is really exitinfo2 split into the upper bits'
> vmm error code and lower bits' firmware error code, sev-guest.h is
> updated to represent the 64 bit value as a union.
> 
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <Borislav.Petkov@amd.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Venu Busireddy <venu.busireddy@oracle.com>
> Cc: Michael Roth <michael.roth@amd.com>
> Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
> Cc: Michael Sterritt <sterritt@google.com>
> 
> Fixes: d5af44dde546 ("x86/sev: Provide support for SNP guest request NAEs")
> Reviewed-by: Tom Lendacky <Thomas.Lendacky@amd.com>

> Reviewed-by: Borislav Petkov <Borislav.Petkov@amd.com>

Please don't add tags you haven't received. Especially a Reviewed-by. Have a
look here what they mean, if unsure:

Documentation/process/submitting-patches.rst

I've removed it - you don't have to resend just because of that.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
