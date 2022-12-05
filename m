Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C97A642CFE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 17:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbiLEQgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 11:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbiLEQf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 11:35:59 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2218B20BE9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 08:34:44 -0800 (PST)
Received: from zn.tnic (p200300ea9733e72f329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e72f:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 881861EC0674;
        Mon,  5 Dec 2022 17:34:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1670258082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OWySjEls0A0JPnCrAeWGbZQ7X3VTy9vDof3TMx9kHEY=;
        b=e8GtFL74wSJxh4Vv+47mv6GenHmzZQ7umuQKuNjFCDW4XxGA7ViK9lOJ5YMU05Ao0Dbd8S
        sL+k71MS/MENybjP49Acnnkszpo+BJJ9PgRCPFs86NPvG4/VAb+9mreNtpoMT03OUq0g3B
        9b7q78V9VoxQjqE9y1occuFOFpQzwiA=
Date:   Mon, 5 Dec 2022 17:34:42 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dionna Glaze <dionnaglaze@google.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
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
Subject: Re: [PATCH v8 2/4] x86/sev: Change snp_guest_issue_request's fw_err
Message-ID: <Y44dohVKo7MAqmxK@zn.tnic>
References: <20221104230040.2346862-1-dionnaglaze@google.com>
 <20221104230040.2346862-3-dionnaglaze@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221104230040.2346862-3-dionnaglaze@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 11:00:38PM +0000, Dionna Glaze wrote:
> The GHCB specification declares that the firmware error value for a
> guest request will be stored in the lower 32 bits of EXIT_INFO_2.
> The upper 32 bits are for the VMM's own error code. The fw_err argument
> is thus a misnomer, and callers will need access to all 64 bits.
> 
> The type of unsigned long also causes problems, since sw_exit_info2 is
> u64 (unsigned long long) vs the argument's previous unsigned long*.
> The signature change requires the follow-up change to
> drivers/virt/coco/sev-guest to use the new expected type in order to
> compile.
> 
> The firmware might not even be called, so we bookend the call with the

Please use passive voice in your commit message: no "we" or "I",
etc, and describe your changes in imperative mood.

Personal pronouns are ambiguous in text, especially with so many
parties/companies/etc developing the kernel so let's avoid them please.

Otherwise, LGTM.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
