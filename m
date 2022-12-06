Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3169644128
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 11:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiLFKUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 05:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiLFKUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 05:20:09 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2312B658A;
        Tue,  6 Dec 2022 02:20:08 -0800 (PST)
Received: from zn.tnic (p200300ea9733e7ff329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7ff:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B64801EC064F;
        Tue,  6 Dec 2022 11:20:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1670322006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sl4e+RriZSOsyS4K085UmZxwSNVZxIS3S1lRJkgBgQI=;
        b=pRzA9pRiF2c0RJHu4ytcZU/OtYCGeVKjbSufHl9zu/Lg71N/HsKRNiuffGaoMtBDDvkU9u
        YbafEcQpF4Bf7Py9x2Zf9Gd+zb51B/OEz+Y4VZu0NBC/dexDiNV2n2bL/n+tsJm7ejqw07
        mSxtk4lJXpoLJFMrWc1iPcG24Y1TPYs=
Date:   Tue, 6 Dec 2022 11:20:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     stuart hayes <stuart.w.hayes@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kyle Meyer <kyle.meyer@hpe.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: acpi: Only set boost MSRs on supported CPUs
Message-ID: <Y48XUjSMWVvohIy3@zn.tnic>
References: <20221205175744.9746-1-stuart.w.hayes@gmail.com>
 <e5e024a2-a530-9f4f-76f4-5f239b3608a3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e5e024a2-a530-9f4f-76f4-5f239b3608a3@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 12:07:05PM -0600, stuart hayes wrote:
> 
> 
> On 12/5/2022 11:57 AM, Stuart Hayes wrote:
> > Stop trying to set boost MSRs on CPUs that don't support boost.
> > 
> > This corrects a bug in the recent patch "Defer setting boost MSRs".
> > 
> > Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> > ---
> >   drivers/cpufreq/acpi-cpufreq.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> > index bb58175a8d40..a7c5e312340e 100644
> > --- a/drivers/cpufreq/acpi-cpufreq.c
> > +++ b/drivers/cpufreq/acpi-cpufreq.c
> > @@ -888,7 +888,8 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
> >   	if (perf->states[0].core_frequency * 1000 != freq_table[0].frequency)
> >   		pr_warn(FW_WARN "P-state 0 is not max freq\n");
> > -	set_boost(policy, acpi_cpufreq_driver.boost_enabled);
> > +	if (acpi_cpufreq_driver.set_boost)
> > +		set_boost(policy, acpi_cpufreq_driver.boost_enabled);
> >   	return result;
> 
> My apologies--adding Boris, I forgot to put him on the "to" list.

Yap, that does it.

Reported-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Borislav Petkov (AMD) <bp@alien8.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
