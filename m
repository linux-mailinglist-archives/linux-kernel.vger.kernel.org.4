Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D3B6CFEB1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjC3ImQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjC3Ilx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:41:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291B47285;
        Thu, 30 Mar 2023 01:41:30 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 05CFD1EC0646;
        Thu, 30 Mar 2023 10:41:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680165688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=IP4G8kUpgLlLYRbFy0NZ3SCiWVx3O+bcbGaEtVDwlGg=;
        b=UB+9z4zAzC8C9DUCm4H+SpyJ+uYMYZyVvQlbCC40cVFCr/IqmsqW1MmAkSDUOmc8qLkg76
        siOQiyk1U0B+IwxB7YFuh3ZAx7IqgCietAPbUlIQLcOF8vFrBN69JDv7HVXrTGEIToJuRJ
        /c+dszw65YhJVqkAliK3SBBdxAZtlME=
Date:   Thu, 30 Mar 2023 10:41:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "Brown, Len" <len.brown@intel.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "mario.limonciello@amd.com" <mario.limonciello@amd.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "eric.devolder@oracle.com" <eric.devolder@oracle.com>
Subject: Re: [PATCH] x86/ACPI/boot: Use FADT version to check support for
 online capable
Message-ID: <20230330084123.GBZCVLM8Wz8fBsKr7z@fat_crate.local>
References: <20230329174536.6931-1-mario.limonciello@amd.com>
 <27c83d42e9cd95a1bfc34fa278315224a63cc062.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27c83d42e9cd95a1bfc34fa278315224a63cc062.camel@intel.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 01:10:07AM +0000, Zhang, Rui wrote:
> In https://uefi.org/sites/default/files/resources/ACPI_6_2.pdf,
> MADT revision is 4.
> 
> In 
> https://uefi.org/sites/default/files/resources/ACPI%206_2_A_Sept29.pdf,
> MADT revision is 45.

This is a hack to fix some ACPI erratum or whatever.

> In 
> https://uefi.org/sites/default/files/resources/ACPI_6_2_B_final_Jan30.pdf
> MADT revision is 5.
> 
> So you probably mean 6.2a has MADT revision "45" here?

No, forget MADT.

The thing should check whether the ACPI revision is 6.3. And this is
what it does below.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
