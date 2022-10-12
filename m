Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727315FCA42
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiJLSLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJLSLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:11:11 -0400
Received: from outbound-smtp06.blacknight.com (outbound-smtp06.blacknight.com [81.17.249.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D45D25BE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:11:09 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp06.blacknight.com (Postfix) with ESMTPS id 8174AC2B6E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 19:11:07 +0100 (IST)
Received: (qmail 8216 invoked from network); 12 Oct 2022 18:11:07 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Oct 2022 18:11:07 -0000
Date:   Wed, 12 Oct 2022 19:11:05 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-rtc@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] rtc: rtc-cmos: Fix event handler registration ordering
 issue
Message-ID: <20221012181105.tskfwovexx44kff3@techsingularity.net>
References: <5629262.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <5629262.DvuYhMxLoT@kreacher>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 08:07:01PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because acpi_install_fixed_event_handler() enables the event
> automatically on success, it is incorrect to call it before the
> handler routine passed to it is ready to handle events.
> 
> Unfortunately, the rtc-cmos driver does exactly the incorrect thing
> by calling cmos_wake_setup(), which passes rtc_handler() to
> acpi_install_fixed_event_handler(), before cmos_do_probe(), because
> rtc_handler() uses dev_get_drvdata() to get to the cmos object
> pointer and the driver data pointer is only populated in
> cmos_do_probe().
> 
> This leads to a NULL pointer dereference in rtc_handler() on boot
> if the RTC fixed event happens to be active at the init time.
> 
> To address this issue, change the initialization ordering of the
> driver so that cmos_wake_setup() is always called after a successful
> cmos_do_probe() call.
> 
> While at it, change cmos_pnp_probe() to call cmos_do_probe() after
> the initial if () statement used for computing the IRQ argument to
> be passed to cmos_do_probe() which is cleaner than calling it in
> each branch of that if () (local variable "irq" can be of type int,
> because it is passed to that function as an argument of type int).
> 
> Note that commit 6492fed7d8c9 ("rtc: rtc-cmos: Do not check
> ACPI_FADT_LOW_POWER_S0") caused this issue to affect a larger number
> of systems, because previously it only affected systems with
> ACPI_FADT_LOW_POWER_S0 set, but it is present regardless of that
> commit.
> 
> Fixes: 6492fed7d8c9 ("rtc: rtc-cmos: Do not check ACPI_FADT_LOW_POWER_S0")
> Fixes: a474aaedac99 ("rtc-cmos: move wake setup from ACPI glue into RTC driver")
> Link: https://lore.kernel.org/linux-acpi/20221010141630.zfzi7mk7zvnmclzy@techsingularity.net/
> Reported-by: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Works for me so;

Tested-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
