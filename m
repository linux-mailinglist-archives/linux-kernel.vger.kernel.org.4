Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5928C65DC08
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 19:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239760AbjADSVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 13:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239561AbjADSVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 13:21:19 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023C21BEA5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 10:21:17 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 319C91EC068E;
        Wed,  4 Jan 2023 19:21:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672856476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pOFSXrweTQp5roB0wksByK8Ln4O+0v0oLGFxanlhYoc=;
        b=aLkKz3qIE7BkCGzuPTk5XL88mbW2F/HcGh9agXXfgQ9Gvh5O9cTbN+f+hoejMD7miXFoCd
        anODhqdCfUlxbzIQ+KBU0YBh+nrCao90ZDPIn5ndnrIkNjs05t2MyN/4VFDhixh5irK3Sn
        Iwk8verMyfBcXYS/9G4BAyfH1OzeVdg=
Date:   Wed, 4 Jan 2023 19:21:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 1/6] x86/microcode: Add a parameter to
 microcode_check() to store CPU capabilities
Message-ID: <Y7XDlyHY2kFeMUMI@zn.tnic>
References: <20230103180212.333496-1-ashok.raj@intel.com>
 <20230103180212.333496-2-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230103180212.333496-2-ashok.raj@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 10:02:07AM -0800, Ashok Raj wrote:
> This is a preparation before the next patch uses this to compare CPU

Once a patch is in git, the concept of "subsequent" or "next" patch becomes
ambiguous depending on how you're sorting them.

So you should strive for your commit messages to make sense on their own,
without referencing other "subsequent" or "next" patches.

> capabilities after performing an update.
> 
> Add a parameter to store CPU capabilities before performing a microcode
> update.

	" ... so that code later can do X."

And that is enough for an explanation.

> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 9cfca3d7d0e2..b9c7529c920e 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -2302,25 +2302,23 @@ void cpu_init_secondary(void)
>   * only when microcode has been updated. Caller holds microcode_mutex and CPU
>   * hotplug lock.

<--- I guess you can document that new parameter here.

>   */
> -void microcode_check(void)
> +void microcode_check(struct cpuinfo_x86 *info)

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
