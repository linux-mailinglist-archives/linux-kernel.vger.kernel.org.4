Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049D5621C87
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiKHSyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiKHSyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:54:09 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB9066C87;
        Tue,  8 Nov 2022 10:54:07 -0800 (PST)
Received: from zn.tnic (p200300ea9733e764329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e764:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 81AA81EC054E;
        Tue,  8 Nov 2022 19:54:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667933646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Fykpbof85hPvjDu3XRrLFydCselt6tv5CXfYTDs4vg0=;
        b=fcyOf3xPTg2mMNlQMVXTByl1xE5cU+WkAqWPoofSekzThu9YieearPByDivXFkcHR+elCw
        lb5bN7Ne6+9RGJyaO/GKYAIAatBjvxo8NsWG8ORM7lBZRIZk6ENp3mQ4Bdvrdk7X6wPqNb
        IMpJBtJ/4ca7cmxLwJqkkZuSlF1YI7U=
Date:   Tue, 8 Nov 2022 19:54:01 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>, degoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        antonio.gomez.iglesias@linux.intel.com
Subject: Re: [PATCH 2/3] x86/cpu/amd: Add feature bit for MSR_AMD64_LS_CFG
 enumeration
Message-ID: <Y2qlyfRKgIc4KVcx@zn.tnic>
References: <cover.1663025154.git.pawan.kumar.gupta@linux.intel.com>
 <034c7f5ac243ee7b40ba1a8cc3f9b10b1e380674.1663025154.git.pawan.kumar.gupta@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <034c7f5ac243ee7b40ba1a8cc3f9b10b1e380674.1663025154.git.pawan.kumar.gupta@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 04:40:47PM -0700, Pawan Gupta wrote:
> Currently there is no easy way to enumerate MSR_AMD64_LS_CFG. As this
> MSR is supported on AMD CPU families 10h to 18h, set a new feature bit
> on these CPU families. The new bit can be used to detect the MSR
> support.
> 
> Suggested-by: Andrew Cooper <andrew.cooper3@citrix.com>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  arch/x86/kernel/cpu/amd.c          | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index dd173733e40d..90bdb1d98531 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -305,6 +305,7 @@
>  #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime firmware calls */
>  #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit when EIBRS is enabled */
>  #define X86_FEATURE_MSR_TSX_CTRL	(11*32+18) /* "" MSR IA32_TSX_CTRL */
> +#define X86_FEATURE_MSR_LS_CFG		(11*32+19) /* "" MSR AMD64_LS_CFG */

We already have that one:

#define X86_FEATURE_LS_CFG_SSBD         ( 7*32+24)  /* "" AMD SSBD implementation via LS_CFG MSR */

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
