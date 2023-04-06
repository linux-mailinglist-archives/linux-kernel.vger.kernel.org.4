Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431026DA4C7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 23:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbjDFVgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 17:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDFVgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:36:47 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583E2C2;
        Thu,  6 Apr 2023 14:36:46 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D24411EC0445;
        Thu,  6 Apr 2023 23:36:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680817004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references;
        bh=1AgX+xA/QrwttP1+uxdKVZqOyhulcBpBNHIemaQcGQI=;
        b=qWdW8YiPmXwh3gDHa8XI2U3QRCsbhl8DLBizei54QAaWU4af4xZuLTfB+zGemSayWz1XD4
        aAdqueyYxSbWtdVJyehNxRJzDV4XJ+sDIGHoEAcXyKtPaOeOMM/MFIIScVVdwtYQyAz275
        uAjPp5XMnuQ17O/rUD+BXbB/chzQraU=
Date:   Thu, 6 Apr 2023 23:36:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-pm@vger.kernel.org
Subject: Re: [BUG?] unchecked MSR access error: WRMSR to 0x19c
Message-ID: <20230406213640.GBZC87aMhjL8LN6NUI@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALjTZvakMZQsqzzjjXh_fw4+Zra5y5o-fhc5gDVTYM1uM40RNQ@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CCing more appropiate people and quoting the whole mail...

On Wed, Apr 05, 2023 at 11:14:45PM +0100, Rui Salvaterra wrote:
> Hi, everyone,
> 
> I have a Haswell (Core i7-4770R) machine running Linux 6.3-rc5 on
> which, after a while under load (say, compiling the kernel), I get
> this trace…
> 
> [  832.549630] unchecked MSR access error: WRMSR to 0x19c (tried to
> write 0x000000000000aaa8) at rIP: 0xffffffff816f66a6
> (throttle_active_work+0xa6/0x1d0)
> [  832.549652] Call Trace:
> [  832.549654]  <TASK>
> [  832.549655]  process_one_work+0x1ab/0x300
> [  832.549661]  worker_thread+0x4b/0x340
> [  832.549664]  ? process_one_work+0x300/0x300
> [  832.549676]  kthread+0xac/0xc0
> [  832.549679]  ? kthread_exit+0x20/0x20
> [  832.549682]  ret_from_fork+0x1f/0x30
> [  832.549693]  </TASK>
> 
> … after which I get these from time to time in dmesg.
> 
> [  836.709562] CPU7: Core temperature is above threshold, cpu clock is
> throttled (total events = 219)
> [  836.709569] CPU3: Core temperature is above threshold, cpu clock is
> throttled (total events = 219)
> [ 1272.792138] CPU2: Core temperature is above threshold, cpu clock is
> throttled (total events = 1)
> [ 1272.792156] CPU6: Core temperature is above threshold, cpu clock is
> throttled (total events = 1)
> 
> This is the microcode revision on the CPU.
> 
> [    0.000000] microcode: updated early: 0xe -> 0x1c, date = 2019-11-12
> 
> Note that I have the exact same issue on an Ivy Bridge (Core
> i7-3720QM) machine, but not on an Ivy Bridge laptop (Celeron 1007U).
> Maybe this is a legitimate warning, but please note that I've
> thorughly cleaned the machines before retesting to see if, by
> coincidence, I had any airway/cooling issues. The fact that it started
> happening recently (since Linux 6.1, I believe), and the fact that
> running stress-ng --cpu 16 before the unchecked WRMSR error happens
> doesn't cause any thermal throttling events, lead me to believe this
> is possibly some unintended oversight.
> 
> Please let me know if you need any additional information (.config, or
> anything else).
> 
> Thanks in advance,
> Rui

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
