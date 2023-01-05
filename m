Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D903C65F6A2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbjAEWWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235813AbjAEWWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:22:13 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9FE6951E;
        Thu,  5 Jan 2023 14:22:10 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 377401EC068E;
        Thu,  5 Jan 2023 23:22:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672957329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=czOsQmD34pjViax7atABy4fDrkAQPndgTpUtqjimrFc=;
        b=dwRsEjjz/U8PKiJy/nHt/KsevM+xMAesCHF5IaybVIbL1Cz7WLi8TMwrCmwxEQYapsSxte
        nssirL3xUjhN8lkbuVAhpi+HwnDg6NCPanriRkM39q9fF1dzN5bS9XKi0s0T3m38wDQf5o
        zmOQS5MeXyyLCoXAX2fYHJwVdWb+dzY=
Date:   Thu, 5 Jan 2023 23:22:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Kishon Vijay Abraham I <kvijayab@amd.com>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Santosh Shukla <santosh.shukla@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Borislav Petkov <bpetkov@amd.com>,
        Leo Duran <leo.duran@amd.com>
Subject: Re: [PATCH v2] x86/acpi/boot: Do not register processors that cannot
 be onlined for x2apic
Message-ID: <Y7dNjHXJJwzCtYOY@zn.tnic>
References: <20230105041059.39366-1-kvijayab@amd.com>
 <CAJZ5v0g1Mu8ip68one_gsAR3xmyua+6m1uJqb3n92xxYWeR+FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g1Mu8ip68one_gsAR3xmyua+6m1uJqb3n92xxYWeR+FA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 06:09:59PM +0100, Rafael J. Wysocki wrote:
> On Thu, Jan 5, 2023 at 5:11 AM Kishon Vijay Abraham I <kvijayab@amd.com> wrote:
> >
> > Section 5.2.12.12 Processor Local x2APIC Structure in the ACPI v6.5
> > spec mandates that both "enabled" and "online capable" Local APIC Flags
> > should be used to determine if the processor is usable or not.
> >
> > However, Linux doesn't use the "online capable" flag for x2APIC to
> > determine if the processor is usable. As a result, cpu_possible_mask has
> > incorrect value and results in more memory getting allocated for per_cpu
> > variables than it is going to be used.
> >
> > Make sure Linux parses both "enabled" and "online capable" flags for
> > x2APIC to correctly determine if the processor is usable.
> >
> > Fixes: aa06e20f1be6 ("x86/ACPI: Don't add CPUs that are not online capable")
> > Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
> > Reported-by: Leo Duran <leo.duran@amd.com>
> > Signed-off-by: Kishon Vijay Abraham I <kvijayab@amd.com>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Are you saying, I should take it through tip?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
