Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F934616454
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiKBOCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiKBOCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:02:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D312DCE21;
        Wed,  2 Nov 2022 07:02:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBD4D1FB;
        Wed,  2 Nov 2022 07:02:21 -0700 (PDT)
Received: from e126311.manchester.arm.com (unknown [10.57.67.104])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EB4A3F534;
        Wed,  2 Nov 2022 07:02:13 -0700 (PDT)
Date:   Wed, 2 Nov 2022 14:01:40 +0000
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, yu.chen.surf@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/2] cpuidle: teo: Introduce util-awareness
Message-ID: <Y2J4RFiOeJ5XymlI@e126311.manchester.arm.com>
References: <20221031121314.1381472-1-kajetan.puchalski@arm.com>
 <20221031121314.1381472-3-kajetan.puchalski@arm.com>
 <CAAYoRsUDxsbexq5KmNTk60Ki7V4q-LxHeCzJmm9DEB6O49ks2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAYoRsUDxsbexq5KmNTk60Ki7V4q-LxHeCzJmm9DEB6O49ks2w@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 11:24:06PM -0700, Doug Smythies wrote:

> Ignoring the metrics is not the correct thing to do.
> Depending on the workflow, it can severely bias the idle states deeper
> than they should be because most of the needed information to select
> the appropriate shallow state is tossed out.

Interesting, thanks for flagging this actually. Arguably it made sense
originally but with v3 changes it probably causes more harm than good.

From testing it on my own side it still looks all right without the
skipping metrics part so I'm fine with just dropping it from the patch.
V4 it is.

I'll include my updated numbers and more tests in the new cover letter.

> Example 1:
> 2 pairs of ping pongs = 4 threads
> Parameters chosen such that idle state 2 would be a most used state.
> CPU frequency governor: Schedutil.
> CPU frequency scaling driver: intel_cpufreq.
> HWP: Disabled
> Processor: i5-10600K (6 cores 12 cpus).
> Kernel: 6.1-rc3
> Run length: 1e8 cycles
> Idle governor:
> teo: 11.73 uSecs/loop ; idle state 1 ~3.5e6 exits/sec
> menu: 12.1 uSecs/loop ; idle state 1 ~3.3e6 exits/sec
> util-v3: 15.2 uSecs/loop ; idle state 1 ~200 exits/sec
> util-v4: 11.63 uSecs/loop ; idle state 1 ~3.5e6 exits/sec
> 
> Where util-v4 is the same as this patch (util-v3) with the above code reverted.
> 
> Note: less time per loop is better.
> 
> Example 2: Same but parameters selected such that idle state 0 would
> be a most used idle state.
> Run Length: 4e8 cycles
> Idle governor:
> teo: 3.1 uSecs/loop ; idle state 0 ~1.2e6 exits/sec
> menu:  3.1 uSecs/loop ; idle state 0 ~1.3e6 exits/sec
> util-v3: 5.1 uSecs/loop ; idle state 0 ~4 exits/sec
> util-v4: ? uSecs/loop ; idle state 0 ~1.2e6 exits/sec (partial result)

Thanks a lot for the testing!

---
Kajetan
