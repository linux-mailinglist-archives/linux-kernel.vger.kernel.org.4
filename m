Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C326EE95A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 23:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbjDYVHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 17:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbjDYVHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 17:07:01 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D6516186
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 14:06:59 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 542E71EC056D;
        Tue, 25 Apr 2023 23:06:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1682456818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=aYEG3s29bEMINEEMcsxnboCa0Df1QW92P8NWJ27Cooc=;
        b=JbVMULhnGQJE7u/lglvhfmEb/BGcv7o6Eir9RvTkWsn5VXytZERsI4VhGmkkQdfo91fBT8
        A4CEcTmZ/Z1nQZJtAcHmfrsxH1yWK30K4xgL5PjHNoEEbPMx8p6ZeDU/81XzjgtrW3Kfpd
        95FZQT5Y6CB0pgvgm8XAPIRUUteqlPs=
Date:   Tue, 25 Apr 2023 23:06:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Tony Battersby <tonyb@cybernetics.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] x86/cpu: fix intermittent lockup on poweroff
Message-ID: <20230425210654.GFZEhA7p7p/FXht76v@fat_crate.local>
References: <3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com>
 <f5c7a104-d422-bd02-d361-e9e9f433d41d@intel.com>
 <1955637d-b7ab-20a8-558a-6b909b7069a9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1955637d-b7ab-20a8-558a-6b909b7069a9@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 01:34:48PM -0700, Dave Hansen wrote:
> >    0x0000000b 0x00: eax=0x00000001 ebx=0x00000002 ecx=0x00000100 edx=0x00000000
> 
> which does have BIT(0) set.

Yeah, or the last basic leaf

  0x0000000b 0x01: eax=0x00000005 ebx=0x0000000c ecx=0x00000201 edx=0x00000000

but that one has bit 0 set too, so yeah, patch is correct. I'll queue it
after -rc1.

But Tony, please change your commit message to say something like this:

"Check the maximum supported extended CPUID level because on Intel,
querying an invalid extended CPUID leaf returns the values of the
maximum basic CPUID leaf and if bit  0 in EAX is set, the check falsely
evaluates to true and WBINVD is wrongly executed where it shouldn't."

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
