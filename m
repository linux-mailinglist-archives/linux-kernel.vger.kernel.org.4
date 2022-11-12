Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9669B626B39
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 20:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbiKLTUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 14:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKLTUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 14:20:38 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB0617E08;
        Sat, 12 Nov 2022 11:20:37 -0800 (PST)
Received: from zn.tnic (p200300ea9733e71c329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e71c:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 121C91EC01A9;
        Sat, 12 Nov 2022 20:20:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1668280835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/AdiyHE8iCbKGHiIJ8TYugOc5txdC9UeG0+sgmQ4Vfg=;
        b=RF/PTR9TltbKFOeirXR0EeRKZF7BU8NMxxSw5JJOE7vuGpR4HK4PAMnkw2lmSf6+155Ujn
        L8RW/QBjQog7KvNCW67c9sN+BfVpbO8qlvk11jU5iuTYMO4dPnPW9OiYCfFT7+f9Gq5r5G
        PFbc+yeMBYoSRNeo090gVC+9S68lnLY=
Date:   Sat, 12 Nov 2022 20:20:30 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thiago Macieira <thiago.macieira@intel.com>
Cc:     Jithu Joseph <jithu.joseph@intel.com>, hdegoede@redhat.com,
        markgross@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
Subject: Re: [PATCH v2 12/14] platform/x86/intel/ifs: Add current_batch sysfs
 entry
Message-ID: <Y2/x/vdtE0ciuOhE@zn.tnic>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-13-jithu.joseph@intel.com>
 <Y2/JNAmSoYlLKq3A@zn.tnic>
 <208647816.nNe6ejF2h0@tjmaciei-mobl5>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <208647816.nNe6ejF2h0@tjmaciei-mobl5>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 10:21:35AM -0800, Thiago Macieira wrote:
> Not exactly. That's what this file is there for. It allows the algorithm to 
> read the current batch file, add 1, then echo back. If the load succeeds, the 
> the batch exists; if not, then the algorithm should simply go back to 0.

This sounds to me like there's a special order in which those batches
should be executed?

I thought they're simply collections of test sequences which can be run
in any order...

> First, there's the question of the ability to see into /lib/firmware. I'm not a 
> kernel dev but I'm told that request_firmware() only operates on the root 
> container's filesystem view. We're expecting that the application may get 
> deployed as a container (with full privileges so it can write to /sys, sure), 
> so it won't be able to see the host system's /lib to know what files are 
> available. It could "guess" at the file names, based on the current processor's 
> family/model/stepping and a natural number, but that's sub-optimal.

It is not about seeing - you simply give it the filename -
request_firmware* does the "seeing". Either the file's there or it
isn't.

> Unless the driver were allowed to load any file named by the application, from 
> its own view of the filesystem, permitting the firmware files being distributed 
> inside the container.

There's a reason I wrote:

"There will be no requirement on the naming - only on the filename
length and it should be in that directory /lib/firmware/intel/ifs_0/"

Of course the driver should load only from that directory.

> Second, for electrical reasons, we expect that certain processor generations 
> will need a timeout between tests before testing can be done again on a given 
> core, whether the same batch or the next one. This time out can be in the 
> order of many minutes, which is longer than any hyperscaler is willing to 
> allocate for a system self-test hogging a core or the whole system, just 
> waiting. For example, let's say that the timeout is 15 minutes and there are 4 
> batches: this means the whole testing procedure takes one hour, even though 
> the actual downtime for each core was less than 1 second. This is lost 
> revenue.

All that doesn't matter - if the CPU *must* wait 15 minutes between
batches, then that should be enforced by the driver and not relied upon
by userspace to DTRT.

> Instead, they wish the next available maintenance window to simply resume 
> testing at the point where the last one stopped. These windows need not be 
> scheduled; they can also be opportunistic, when the orchestrator determines 
> the machine or a subset of one is going to be idle. That's what the algorithm 
> in the pull request above implements: if the current_batch's result was 
> "untested", it is attempted again, otherwise it tries the next one, rolling 
> back to 0 if the loading failed. This removes the need to know anything about 
> the timeout on the current processor or even whether there is one, or how many 
> batches there are.242

This all has nothing to do with whether you give it a number or a
filename. How you glue your testing around it together is a userspace
issue - all the kernel driver needs to be able to do is load the
sequence and execute it.

Echoing filenames into sysfs is no different from echoing numbers into
it - former is simpler. If the CPU says it cannot execute the sequence
currently, you have to think about how you retry that sequence. How you
specify it doesn't matter.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
