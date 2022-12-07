Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4207646252
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 21:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiLGU0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 15:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLGU0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 15:26:01 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C5C58BFA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 12:26:00 -0800 (PST)
Received: from zn.tnic (p200300ea9733e73d329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e73d:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2E18B1EC0426;
        Wed,  7 Dec 2022 21:25:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1670444759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FN5Arro5cGI7t/lnI9RReHnWb8Kmqs2yj4TIbTdUO00=;
        b=XTjyC1xD6dPYsokY9eeYwTRLhSfHNMnVZwQRwYs9/ZQUU2q57DNHJGRAeNXTTkJkSFuNtO
        YVDDiKbc+iIypc0XMSbFN19CIJjuR2HnSdDmLPl/FLcY9QwCL5RCmtU3FRGTQ0amSMpmaQ
        m8POq8pvlWQiFRUv23ZUoIqaQpql6/I=
Date:   Wed, 7 Dec 2022 21:25:54 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>, alison.schofield@intel.com,
        reinette.chatre@intel.com
Subject: Re: [Patch V1 4/7] x86/microcode/core: Take a snapshot before and
 after applying microcode
Message-ID: <Y5D20qLOmrj4d2w4@zn.tnic>
References: <20221129210832.107850-1-ashok.raj@intel.com>
 <20221129210832.107850-5-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221129210832.107850-5-ashok.raj@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 01:08:29PM -0800, Ashok Raj wrote:
> The kernel caches features about each CPU's features at boot in an
> x86_capability[] structure. The microcode update takes one snapshot and
> compares it with the saved copy at boot.
> 
> However, the capabilities in the boot copy can be turned off as a result of
> certain command line parameters or configuration restrictions. This can
> cause a mismatch when comparing the values before and after the microcode
> update.

Hmm, but if that has happened, the capabilities will be turned off in
your @orig argument below?

Or are you saying that this copy_cpu_caps() read before the update will
overwrite the cleared bits with the their actual values from CPUID so
that what you really wanna compare here is *hardware* CPUID bits before
and after and not our potentially modified copy?

I.e., some bit in CPUID is 1 and we have cleared it in our copy.

Close?

If so, then this should be specifically called out in the commit
message.

> +static void copy_cpu_caps(struct cpuinfo_x86 *info)

If anything, that function should be called

store_cpu_caps()

and store it into its parameter *info.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
