Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9995FE446
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiJMVd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJMVdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:33:52 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED492192B91;
        Thu, 13 Oct 2022 14:33:49 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B1535C0002;
        Thu, 13 Oct 2022 21:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1665696828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eGxDxLpBBc25/zJ1ZGUcp2ZxKbgcRfKEOp9GSqQ62os=;
        b=kSyG2my3bJn2U1WBb+ScVEWIZKdErJ3ke5P/A/G9u+90riJc+oo1Gtxe361+ZD0Mj8QOJn
        0UksTESsxhTrO2DXaxTCXBdLpFQVgvCEXyY7r9h6avedTBLpKg71RxLr1B7vclucLtE71M
        zREYLPCyF1oiqx0Pdh0wi3aOvWvVp9iqiy4l0sy2/V3HkLKrcDV9C+s8vabzG6FSZyvxOs
        jg7d9s19vslAa0oD8JlaxV8CLTungPd/HeI2ZxI8ls20LTBiJWNoKyONr3rcqYcPUkxmRR
        YLwCxIe3To6SVZyvBvXIynK1plBIAWIhIrvmrQx/tQSR2YE4DzMTv2qE78/BMQ==
Date:   Thu, 13 Oct 2022 23:33:47 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-rtc@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH] rtc: rtc-cmos: Fix event handler registration ordering
 issue
Message-ID: <166569680287.1229909.5374051655488244846.b4-ty@bootlin.com>
References: <5629262.DvuYhMxLoT@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5629262.DvuYhMxLoT@kreacher>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2022 20:07:01 +0200, Rafael J. Wysocki wrote:
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
> [...]

Applied, thanks!

[1/1] rtc: rtc-cmos: Fix event handler registration ordering issue
      commit: 4919d3eb2ec0ee364f7e3cf2d99646c1b224fae8

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
