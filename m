Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA226DA5D6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 00:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239048AbjDFWbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 18:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjDFWbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 18:31:11 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9548F9757;
        Thu,  6 Apr 2023 15:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680820270; x=1712356270;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HPptrPGrlbW5+ZJ5t46u3MdY/fpmqmkmyBFrPbNQQMQ=;
  b=E2FAHpicfp8jFay2Mn16aRd5/dU42fCpYcdUyeeFJKWaHPP7UFKr/S89
   ykpDjxp/P8vo2mmqi8bnneoDk13BUm10kVhYnAv0ah1gJLl89d4UHC4vy
   JEYv2d9zUU0e7gNLEiwfAbo6QEEZtZl8OCwavJVs/kayefo/NPRf0KzvG
   O79OZgbNb8yc5nhsHf9pYszCJNR42xjIUQW2O6B1mBs0tB2iYx4vbPK6X
   NBm/Os03Sv5prgX/lQ58Q0PfguPv1l0Y3x5ciTjdXBpX+7YFPj8PCfvah
   2YZa9reoD4/3kFoJi63x1tMBM4vEBjiaenSCtN1/lDFh+3GnRXfap4HBF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="322505542"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="322505542"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 15:31:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="687310665"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="687310665"
Received: from mjjuenem-mobl1.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.81.95])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 15:31:09 -0700
Message-ID: <cdf43fb423368ee3994124a9e8c9b4f8d00712c6.camel@linux.intel.com>
Subject: Re: [BUG?] unchecked MSR access error: WRMSR to 0x19c
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Date:   Thu, 06 Apr 2023 15:31:09 -0700
In-Reply-To: <20230406213640.GBZC87aMhjL8LN6NUI@fat_crate.local>
References: <20230406213640.GBZC87aMhjL8LN6NUI@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rui,

On Thu, 2023-04-06 at 23:36 +0200, Borislav Petkov wrote:
> CCing more appropiate people and quoting the whole mail...
> 
> On Wed, Apr 05, 2023 at 11:14:45PM +0100, Rui Salvaterra wrote:
> > Hi, everyone,
> > 
> > I have a Haswell (Core i7-4770R) machine running Linux 6.3-rc5 on
> > which, after a while under load (say, compiling the kernel), I get
> > this trace…
> > 
> > [  832.549630] unchecked MSR access error: WRMSR to 0x19c (tried to
> > write 0x000000000000aaa8) at rIP: 0xffffffff816f66a6

Please send output of : cpuid -1

Also please try this:

#wrmsr 0x19c 0xaaa8
This should give "wrmsr: CPU 0 cannot set MSR 0x0000019c to
0x000000000000aaa8

#wrmsr 0x19c 0x0aa8

I think this will not return error.

Thanks,
Srinivas

> > (throttle_active_work+0xa6/0x1d0)
> > [  832.549652] Call Trace:
> > [  832.549654]  <TASK>
> > [  832.549655]  process_one_work+0x1ab/0x300
> > [  832.549661]  worker_thread+0x4b/0x340
> > [  832.549664]  ? process_one_work+0x300/0x300
> > [  832.549676]  kthread+0xac/0xc0
> > [  832.549679]  ? kthread_exit+0x20/0x20
> > [  832.549682]  ret_from_fork+0x1f/0x30
> > [  832.549693]  </TASK>
> > 
> > … after which I get these from time to time in dmesg.
> > 
> > [  836.709562] CPU7: Core temperature is above threshold, cpu clock
> > is
> > throttled (total events = 219)
> > [  836.709569] CPU3: Core temperature is above threshold, cpu clock
> > is
> > throttled (total events = 219)
> > [ 1272.792138] CPU2: Core temperature is above threshold, cpu clock
> > is
> > throttled (total events = 1)
> > [ 1272.792156] CPU6: Core temperature is above threshold, cpu clock
> > is
> > throttled (total events = 1)
> > 
> > This is the microcode revision on the CPU.
> > 
> > [    0.000000] microcode: updated early: 0xe -> 0x1c, date = 2019-
> > 11-12
> > 
> > Note that I have the exact same issue on an Ivy Bridge (Core
> > i7-3720QM) machine, but not on an Ivy Bridge laptop (Celeron
> > 1007U).
> > Maybe this is a legitimate warning, but please note that I've
> > thorughly cleaned the machines before retesting to see if, by
> > coincidence, I had any airway/cooling issues. The fact that it
> > started
> > happening recently (since Linux 6.1, I believe), and the fact that
> > running stress-ng --cpu 16 before the unchecked WRMSR error happens
> > doesn't cause any thermal throttling events, lead me to believe
> > this
> > is possibly some unintended oversight.
> > 
> > Please let me know if you need any additional information (.config,
> > or
> > anything else).
> > 
> > Thanks in advance,
> > Rui
> 

