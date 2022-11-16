Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3765C62C95A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 20:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbiKPT6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 14:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiKPT6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 14:58:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56CB1A814;
        Wed, 16 Nov 2022 11:58:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BA2E61F73;
        Wed, 16 Nov 2022 19:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 225DFC433C1;
        Wed, 16 Nov 2022 19:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668628720;
        bh=Yz+Dxpi1MFBxgPccc7T3ie8G4yMfa1+9isd3G42R52E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ix6PNTTSj0Yaf5lEGeNCr5WQXAXA7422feYXu+m6sm7R8pGhPUKRPODf4LHvsumfp
         1x+6J70vK+Kzb3uQwcaeaHIoSaxJdJRnKgK4NHMxB+oehsMlb8ZxEkgkD2xf802iFw
         PHAsPd5QAVmx9/f6l/Ot0VBuiqMy6Wmm+xS8koq5U+6ch1Q2h7bukNl0SrnSiDY+lm
         Eba2Lxt0jJJb9gg4g/2B0H7undnLHxem+dl7xrK2Nui5HEgLZseeQJTXra56rGqAo4
         jOMb9QSL7I8f8vTypq4JXcCEhu/VLgqX578HAQ6N9H30tWb7EGM5cnMcvMH6cbIpKp
         oBoRi9OHafsbg==
Date:   Wed, 16 Nov 2022 12:58:38 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] cpufreq: ACPI: Remove unused variables
 'acpi_cpufreq_online' and 'ret'
Message-ID: <Y3VA7spvoOBCMnD0@dev-arch.thelio-3990X>
References: <20221108170103.3375832-1-nathan@kernel.org>
 <Y3U7MWezkc8aizuo@dev-arch.thelio-3990X>
 <CAJZ5v0iJ0quqN2ErfmPmiN0YRTTfJcC5BiCq+joe_RKBkfYCng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iJ0quqN2ErfmPmiN0YRTTfJcC5BiCq+joe_RKBkfYCng@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 08:50:41PM +0100, Rafael J. Wysocki wrote:
> On Wed, Nov 16, 2022 at 8:34 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > Hi all,
> >
> > Small ping, was there an issue with this change? It seems pretty
> > straight forward to me and it is wreaking havoc on our build matrix due
> > to -Werror.
> 
> Applied now, thanks!

Thanks a lot!

> > On Tue, Nov 08, 2022 at 10:01:03AM -0700, Nathan Chancellor wrote:
> > > Clang warns:
> > >
> > >   drivers/cpufreq/acpi-cpufreq.c:970:24: error: variable 'ret' is uninitialized when used here [-Werror,-Wuninitialized]
> > >           acpi_cpufreq_online = ret;
> > >                                 ^~~
> > >   drivers/cpufreq/acpi-cpufreq.c:960:9: note: initialize the variable 'ret' to silence this warning
> > >           int ret;
> > >                 ^
> > >                   = 0
> > >   1 error generated.
> > >
> > > Both ret and acpi_cpufreq_online are now unused so they can be safely
> > > removed, clearing up the warning.
> > >
> > > Fixes: 13fdbc8b8da6 ("cpufreq: ACPI: Defer setting boost MSRs")
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/1757
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > > ---
> > >  drivers/cpufreq/acpi-cpufreq.c | 6 ------
> > >  1 file changed, 6 deletions(-)
> > >
> > > diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> > > index c8fdfcf659e6..74ef0e05ff7b 100644
> > > --- a/drivers/cpufreq/acpi-cpufreq.c
> > > +++ b/drivers/cpufreq/acpi-cpufreq.c
> > > @@ -953,12 +953,8 @@ static struct cpufreq_driver acpi_cpufreq_driver = {
> > >       .attr           = acpi_cpufreq_attr,
> > >  };
> > >
> > > -static enum cpuhp_state acpi_cpufreq_online;
> > > -
> > >  static void __init acpi_cpufreq_boost_init(void)
> > >  {
> > > -     int ret;
> > > -
> > >       if (!(boot_cpu_has(X86_FEATURE_CPB) || boot_cpu_has(X86_FEATURE_IDA))) {
> > >               pr_debug("Boost capabilities not present in the processor\n");
> > >               return;
> > > @@ -966,8 +962,6 @@ static void __init acpi_cpufreq_boost_init(void)
> > >
> > >       acpi_cpufreq_driver.set_boost = set_boost;
> > >       acpi_cpufreq_driver.boost_enabled = boost_state(0);
> > > -
> > > -     acpi_cpufreq_online = ret;
> > >  }
> > >
> > >  static int __init acpi_cpufreq_init(void)
> > >
> > > base-commit: 21cdb6c18f85fe538ca8740bc79f11fbe08d0197
> > > --
> > > 2.38.1
> > >
