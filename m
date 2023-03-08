Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2EA66B099B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjCHNoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjCHNnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:43:47 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E85ED00AF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 05:42:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36767FEC;
        Wed,  8 Mar 2023 05:42:54 -0800 (PST)
Received: from bogus (unknown [10.57.16.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 64EB33F67D;
        Wed,  8 Mar 2023 05:42:09 -0800 (PST)
Date:   Wed, 8 Mar 2023 13:42:02 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rakesh Babu Saladi <rsaladi2@marvell.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        George Cherian <gcherian@marvell.com>,
        Naveen Mamindlapalli <naveenm@marvell.com>
Subject: Re: [EXT] Re: [PATCH] arm64: smccc: Add trace events to SMC calls.
Message-ID: <20230308134202.smd7bfhtu27saaay@bogus>
References: <20230304125850.32687-1-rsaladi2@marvell.com>
 <ZAX9G5mqGqzTZZ5N@FVFF77S0Q05N>
 <CY4PR1801MB1880A1E3C8EE68B5484536238AB49@CY4PR1801MB1880.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR1801MB1880A1E3C8EE68B5484536238AB49@CY4PR1801MB1880.namprd18.prod.outlook.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 12:25:15PM +0000, Rakesh Babu Saladi wrote:
> Hi Mark, 
> 
> 
>   https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_lkml_20210923112058.GA14893-40C02TD0UTHF1T.local_&d=DwIBAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=OrNjoyjPmqlDfiSr6RMDtAJU4gxiGfgzEtgbqDmoQPA&m=fj6aQCqc0xOYgRMw7BGCVRrOEabi2taRuKl63gCdHras-JfpWCGhjp6HqaLZYj9I&s=1_EJt65j5EoyHhcroJxJFMIkTqQY6jKtWypPIzmgYK8&e= 
>

(Nit: You need to fix your email setup, it is spoiling the links and also
flow for reading in general)


> I don't think anything has changed, and this has all the same problems as
> before, so I do not think we should do this.
>
> Rakesh >> Can you please be more specific why the changes are not getting accepted?
>

Have you gone through the link Mark pointed at ?
For starters, you have new v1.2 specific calls that has x0-x17 as the
input and output registers which neither this patch or the earlier one
addressed if we agree to allow tracing SMCCC calls this way.

> Which SMC calls do you want to trace, and why?
> Rakesh >> These traces we would like to have for debugging purposes while calling any SMC call.
>

The main point was why would you want to enable universal tracing of all SMCCC
calls. Remember that means you would trace the most common and fundamental
for boot PSCI calls which cover CPU_SUSPEND and it gets called a *lot* for
obvious reasons. So it is not a good idea to do so.

So, what are you using this trace for ? Is that a specific driver using
SMCCC ? Can't the trace be added in that driver as you could add specifics
there ?

Taking v1.2 SMCCC as example, though the spec and the API itself allows
18 registers to be input and output, it may not be used in most of the
cases and adding them to the trace is just useless. Hence the suggestion
of making it specific to your use-case.

-- 
Regards,
Sudeep
