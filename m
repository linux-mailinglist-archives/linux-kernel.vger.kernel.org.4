Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B21269043D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 10:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjBIJyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 04:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjBIJyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:54:13 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6885FFF2D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 01:53:53 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EF8CB1EC06BD;
        Thu,  9 Feb 2023 10:53:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675936431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4LXgg6eGQ1qH1srtU+U2fOYiBbnpfa32IaXXFfMKKgI=;
        b=WzVRQzzokNidD+nWlWipMdvljGa9V5i9uJOvMmjVVUSBWh4jSmnuwP3o/YefOtSXiXrKDt
        jYAYv5U6TP2I2GgV8Gmc6lUSLlcNVp+WlkSMz2s0C7To7OOV809gs2695SRNcLThthjfLF
        t+NePYOESA7Iqn3LbXqX4RJFnNY46oo=
Date:   Thu, 9 Feb 2023 10:53:47 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Philip Li <philip.li@intel.com>
Cc:     kernel test robot <lkp@intel.com>, Babu Moger <babu.moger@amd.com>,
        llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [tip:x86/cache 9/13]
 arch/x86/kernel/cpu/resctrl/rdtgroup.c:1456:6: warning: variable 'h' set but
 not used
Message-ID: <Y+TCq4k+0AhfjZkL@zn.tnic>
References: <202301242015.kbzkVteJ-lkp@intel.com>
 <Y8/XoT23HVXHSY73@zn.tnic>
 <Y+RjOpXP1Bbv268n@rli9-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+RjOpXP1Bbv268n@rli9-mobl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 11:06:34AM +0800, Philip Li wrote:
> Thanks a lot for the suggestions, we will think of this to continuously optimize the
> service. Right now, we try to build-test the patches that we can find a suitable base
> to apply the patches successfully, some of effort could fail. Then we only test them
> when they appears on repo. We will keep monitoring the patch testing status to see
> anything we can fix as well.

Cool, thanks.

I see you've started doing silly tests like subdirectory builds for W=
warnings, picking one such report at random from lkml:

https://lore.kernel.org/r/202302091432.VgittDjI-lkp@intel.com

COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/spi/

and then it says

drivers/spi/spi-mpc52xx-psc.c:195:5: warning: no previous prototype for 'mpc52xx_psc_spi_transfer_one_message' [-Wmissing-prototypes]

Yes, this is all fine and dandy but such tests should be the lowest prio
eva! If you have a way to schedule by prio, those should wait until all
the other build tests have happened.

I don't know how your resources are spread out and whether you even can
do as many so I'm only reporting from my experience, in case you were
wondering what you could improve:

People push branches to their trees and wait for the robot to test them.
And they wait and wait. But instead, such silly warnings come.

So it would be a lot better if you could expedite such pushed branches'
build tests first and then the rest.

And then if there are no branches, submitted patchsets on the ML.

If you're trying to figure out what base to use, you can put a doc
somewhere telling people how to specify the base for you and they will
start doing it, you will parse the 0th message for that info and use the
base.

And the long-standing feature request we have: a simple web page
somewhere which says how far is it with testing. So that people can go
and look at it and know whether to wait for test results before sending.

The web page doesn't have to be anything special - just a table of
branches being tested at the moment.

Anyway, I thought I should give you some suggestions if you were looking
for some. :-)

Thanks for the testing work - it is appreciated!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
