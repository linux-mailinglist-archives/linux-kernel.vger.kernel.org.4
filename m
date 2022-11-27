Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE74D63993A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 04:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiK0DSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 22:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiK0DSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 22:18:54 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C285911171;
        Sat, 26 Nov 2022 19:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669519132; x=1701055132;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xm7hkghGLyDEoxRiutr4crT1rjHd2FJh/KNtEHvMZQk=;
  b=KhXzznKrqR/4enr34t4erv5NuCyOXTMXJPC0+RwQRkIbB7Q2OnGKXyFZ
   pWQ5RUuin54wdWQ/o7/OwsZfG3fOTB3D0RchITg3ufC6sEoaWm4STWAH/
   5zaXgN9txIa5oLLhG/wGlXUgFmVsJmYEURzeHd1mCYcGy08lRwnMtLMmg
   UsMXae1et6DXavqwtU7m2le6SE7Y1CQ9ifdBPb8IiYsb2GlumqpUQMdgS
   QQHwzwgIPqYlvRTKrYG9ldX+lEuitOP1ICMP3x3UYnIMesqW+OuwZYXke
   FDRxkpC0fatkH1EGN7+vMcJDKosiWfSb/iB5EyhIEkZ1CHycxbEeii0L6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10543"; a="341548007"
X-IronPort-AV: E=Sophos;i="5.96,197,1665471600"; 
   d="scan'208";a="341548007"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2022 19:18:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10543"; a="593530185"
X-IronPort-AV: E=Sophos;i="5.96,197,1665471600"; 
   d="scan'208";a="593530185"
Received: from liyi4-mobl1.ccr.corp.intel.com ([10.254.214.186])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2022 19:18:50 -0800
Message-ID: <3e6c2e1d4008e70b14abc087c87bb80c78769011.camel@intel.com>
Subject: Re: [RFC PATCH 2/3] cpuidle: ladder: Tune promotion/demotion
 threshold
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 27 Nov 2022 11:18:48 +0800
In-Reply-To: <CAJZ5v0gWwqtqezkBapqK4RbefOT2q7R7pWiTb8E4AbptFu7tAg@mail.gmail.com>
References: <20221105174225.28673-1-rui.zhang@intel.com>
         <20221105174225.28673-2-rui.zhang@intel.com>
         <CAJZ5v0gPOUQDb8c_pVYjzBvU3e3U9JoLhJy5vRBF4h2=zvaHHw@mail.gmail.com>
         <5ed329f894bc81f5375303a69c07dee16630503e.camel@intel.com>
         <CAJZ5v0gWwqtqezkBapqK4RbefOT2q7R7pWiTb8E4AbptFu7tAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > I don't have a solid proof for this. But at least for the pure idle
> > scenario, I don't think 30% deep idle residency is the right
> > behavior,
> > and it needs to be tuned anyway.
> 
> Well, have you checked what happens if the counts are set to the same
> value, e.g. 2?

Well, this is embarrassing. I found a problem with my previous data
when I re-evaluate following your suggestion.

In short,
1. the 30% deep idle residency problem was got when I added some
trace_printk() in the ladder_select_state()
2, without those trace_printk(), after patch 1, the ladder governor can
still get 98% CPU%c7 in pure idle scenario.

Currently, my understanding is that trace_printk() can call
__schedule() and this increased the chance that call_cpuidle() returns
immediately. When this happens, dev->last_residency_ns is set to 0 and
results in a real demotion next time.

Anyway, you are right on questioning this approach, because this seems
to be a different problem or even a false alarm.

So, I think I will submit patch 1/3 and 3/3 as they are bug fixes, and
drop this patch for now, and leave the tuning work, if there is any,
for the real ladder governor users. What do you think?

thanks,
rui

