Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53A86E213C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjDNKsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjDNKse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:48:34 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8145359EA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:48:33 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ED0691EC0691;
        Fri, 14 Apr 2023 12:48:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681469293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3TWGLxyxOgYeVK6FexCzZr9UcM0G4Qqyy7muYzctMI4=;
        b=izVvOO9KW1Sq3Fupbi7J9BC4amlGE3IkcVZ/oWDx/YQqyIa3IkX6ttctXqsh+vRAFIQWcD
        lXDPoXdHoC2L0ru9GKSOrxlPTzCYIREzqAaDmEiPBtJ3c0GRQMFIN358G3Bfe9lpjLAM5d
        2bGtFrPON/pf5DSIdr0m+uDaD7TnPUo=
Date:   Fri, 14 Apr 2023 12:48:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, seanjc@google.com, pbonzini@redhat.com,
        kim.phillips@amd.com, babu.moger@amd.com,
        pawan.kumar.gupta@linux.intel.com, sandipan.das@amd.com,
        CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, LeoLiu-oc@zhaoxin.com
Subject: Re: [PATCH] x86/cpufeatures: extend CPUID leaf 0xc0000001 support
 for Zhaoxin
Message-ID: <20230414104808.GBZDkvaJechZSM+SI9@fat_crate.local>
References: <20230414095334.8743-1-TonyWWang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230414095334.8743-1-TonyWWang-oc@zhaoxin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 05:53:34PM +0800, Tony W Wang-oc wrote:
> Extend CPUID leaf 0xc0000001 to support SM2, SM3, SM4, PARALLAX, TM3,
> RNG2, PHE2, RSA.
> 
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 0]  SM2
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 1]  SM2_EN
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 4]  SM3 SM4
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 5]  SM3_EN SM4_EN
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 16] PARALLAX
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 17] PARALLAX_EN
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 20] TM3
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 21] TM3_EN
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 22] RNG2
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 23] RNG2_EN
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 25] PHE2
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 26] PHE2_EN
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 27] RSA
> CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 28] RSA_EN

None of those flags are used in code, why do we need this patch?

If you want to dump them on the hardware to know what's set or not,
there's tools/arch/x86/kcpuid/ for that.

> SM2/SM3/SM4 imply the instructions support for Chinese cipher security
> algorithm generations 2/3/4.
> PARALLAX is the feature of Zhaoxin CPU that automatically adjusts
> processors's voltage as a function of temperature.
> TM3 is the abbreviation of Thermal Monitor version 3.
> RNG2 is the abbreviation of Random Number Generation version 2.
> PHE2 is the abbreviation of Padlock Hash Engine version 2.
> RSA implies Zhaoxin hardware support for RSA algorithm.
> 
> All these features have two relative CPUID bits, one bit implies the
> existence of the feature and the other bit with postfix "EN" implies
> the availability of this feature.

That's a lot of waste of CPUID bits but that's your decision.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
