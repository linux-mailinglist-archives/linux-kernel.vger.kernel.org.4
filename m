Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CC9701D93
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 15:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237248AbjENNQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 09:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjENNQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 09:16:55 -0400
Received: from vulcan.kevinlocke.name (vulcan.kevinlocke.name [107.191.43.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A4B1FD2;
        Sun, 14 May 2023 06:16:54 -0700 (PDT)
Received: from kevinolos.kevinlocke.name (2600-6c67-5000-0a52-85af-04d2-04b6-7d55.res6.spectrum.com [IPv6:2600:6c67:5000:a52:85af:4d2:4b6:7d55])
        (Authenticated sender: kevin@kevinlocke.name)
        by vulcan.kevinlocke.name (Postfix) with ESMTPSA id BB78F3986521;
        Sun, 14 May 2023 13:16:51 +0000 (UTC)
Received: by kevinolos.kevinlocke.name (Postfix, from userid 1000)
        id EFACA1306035; Sun, 14 May 2023 07:16:47 -0600 (MDT)
Date:   Sun, 14 May 2023 07:16:47 -0600
From:   Kevin Locke <kevin@kevinlocke.name>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: cpufreq: Prevent a warning when another frequency
 driver is loaded
Message-ID: <ZGDfP6e/Ubgt49YN@kevinlocke.name>
Mail-Followup-To: Kevin Locke <kevin@kevinlocke.name>,
        Petr Pavlu <petr.pavlu@suse.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230511125312.24207-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511125312.24207-1-petr.pavlu@suse.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-05-11 at 14:53 +0200, Petr Pavlu wrote:
> Address it by changing the return code in acpi-cpufreq and pcc-cpufreq
> for this case from -EEXIST to -ENODEV which silences the warning in
> call_driver_probe().
> 
> The change has also a benefit for users of init_module() as this return
> code is propagated out from the syscall. The previous -EEXIST code made
> the callers, such as kmod, wrongly believe that the module was already
> loaded instead of that it failed to load.

Thanks for addressing this issue so quickly!

I can confirm that with this patch applied I no longer receive
kernel: acpi-cpufreq: probe of acpi-cpufreq failed with error -17
at boot.  Additionally, modprobe acpi-cpufreq now produces
modprobe: ERROR: could not insert 'acpi_cpufreq': No such device
rather than silently failing (without --first-time) to load the
module as it did before, which seems good to me.

Tested-by: Kevin Locke <kevin@kevinlocke.name>

Cheers,
Kevin
