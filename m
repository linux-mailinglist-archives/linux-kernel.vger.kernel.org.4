Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C35D6FD33A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 02:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjEJAIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 20:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEJAIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 20:08:23 -0400
X-Greylist: delayed 488 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 09 May 2023 17:08:22 PDT
Received: from vulcan.kevinlocke.name (vulcan.kevinlocke.name [107.191.43.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864E5273D;
        Tue,  9 May 2023 17:08:22 -0700 (PDT)
Received: from kevinolos.kevinlocke.name (071-015-196-093.res.spectrum.com [71.15.196.93])
        (Authenticated sender: kevin@kevinlocke.name)
        by vulcan.kevinlocke.name (Postfix) with ESMTPSA id DD959395E4EB;
        Wed, 10 May 2023 00:00:10 +0000 (UTC)
Received: by kevinolos.kevinlocke.name (Postfix, from userid 1000)
        id AC700130072A; Tue,  9 May 2023 18:00:07 -0600 (MDT)
Date:   Tue, 9 May 2023 18:00:07 -0600
From:   Kevin Locke <kevin@kevinlocke.name>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org,
        pmladek@suse.com, mcgrof@kernel.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ACPI: cpufreq: use a platform device to load ACPI PPC
 and PCC drivers
Message-ID: <ZFreh8SDMX67EaB6@kevinlocke.name>
Mail-Followup-To: Petr Pavlu <petr.pavlu@suse.com>, rafael@kernel.org,
        lenb@kernel.org, viresh.kumar@linaro.org, pmladek@suse.com,
        mcgrof@kernel.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230316151036.10181-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316151036.10181-1-petr.pavlu@suse.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-03-16 at 16:10 +0100, Petr Pavlu wrote:
> The patch extends the ACPI parsing logic to check the ACPI namespace if
> the PPC or PCC interface is present and creates a virtual platform
> device for each if it is available. The acpi-cpufreq and pcc-cpufreq
> drivers are then updated to map to these devices.
> 
> This allows to try loading acpi-cpufreq and pcc-cpufreq only once during
> boot and only if a given interface is available in the firmware.

As a result of this patch (691a637123470bfe63bccf5836ead40fac4c7fab)
my ThinkPad T430 with an i5-3320M CPU configured with
CONFIG_X86_INTEL_PSTATE=y and CONFIG_X86_ACPI_CPUFREQ=m (Debian's
amd64 kernel config) now logs

kernel: acpi-cpufreq: probe of acpi-cpufreq failed with error -17

during boot.  Presumably this occurs because loading acpi-cpufreq
returns -EEXIST when intel-pstate is already loaded (or built-in, as
in this case).  I'm unsure why the message was not printed before;
perhaps a difference between driver probing for platform and cpu bus
types?  Although the error message is not wrong, it may lead to
unnecessary investigation by sysadmins, as it did for me.  I thought
it was worth reporting so you can consider whether the change is
desirable.

Cheers,
Kevin
