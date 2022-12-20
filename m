Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AB0652614
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbiLTSOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbiLTSN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:13:56 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FBA186A9;
        Tue, 20 Dec 2022 10:13:54 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Nc4TB5pRLz9sc0;
        Tue, 20 Dec 2022 19:13:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1671560030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oBh94zxafkf8iTW1Whfw20TE2z6rdPEY1QkbgbOuVtQ=;
        b=FjllJCc5aV+4Vb4wmDNbcI/umMRd6w96wSaDdSTmt8OIeMZWc+uqcQ3EBZC63eENDn4dx5
        v/wN203UciUlRNvPUsSqrOZpc8iOOd8pSnfXSFz6oA++RuJM8fo+xKpMvy0q+Um8zHalMw
        k05k+P3N/6PLomS5k25kSIDZir+AzZJyXTMVYy085sHzDM1HLUWH8h3mfj39/sRYlcjV3J
        Kn6pt5HWpBcrVdRw6vmZcJM8otvMyXvNAI0J/8ZMSQHx3ZqExL7E/9fOvLaiBVJfHOk7Hn
        Xp06hp1MYIV2YRvdcXY6MUr8If5Lx35SSyzrQiMk0eeEgIM42UeDbl4n48AZ/w==
Message-ID: <73b77acd-813a-458b-61e2-87116720cc38@mailbox.org>
Date:   Tue, 20 Dec 2022 18:13:41 +0000
MIME-Version: 1.0
Subject: Re: [PATCH v8 00/13] Implement AMD Pstate EPP Driver
To:     Perry Yuan <perry.yuan@amd.com>, rafael.j.wysocki@intel.com,
        Mario.Limonciello@amd.com, ray.huang@amd.com,
        viresh.kumar@linaro.org
Cc:     Deepak.Sharma@amd.com, Nathan.Fontenot@amd.com,
        Alexander.Deucher@amd.com, Shimmer.Huang@amd.com,
        Xiaojian.Du@amd.com, Li.Meng@amd.com, wyes.karny@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221219064042.661122-1-perry.yuan@amd.com>
Content-Language: en-US
From:   Tor Vic <torvic9@mailbox.org>
In-Reply-To: <20221219064042.661122-1-perry.yuan@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 661c4c9fef32c1424ae
X-MBO-RS-META: 87fq1ukmy3s3oekqxsiqibqdpwt7uebx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19.12.22 06:40, Perry Yuan wrote:
> Hi all,
> 
> This patchset implements one new AMD CPU frequency driver
> `amd-pstate-epp` instance for better performance and power control.
> CPPC has a parameter called energy preference performance (EPP).
> The EPP is used in the CCLK DPM controller to drive the frequency that a core
> is going to operate during short periods of activity.
> EPP values will be utilized for different OS profiles (balanced, performance, power savings).
> 

Using v8 and clang-15 on 6.1 I get:

---
ld.lld: error: undefined symbol: energy_perf_strings
 >>> referenced by amd-pstate.c:789 
(/tmp/makepkg/linux61-vd/src/linux-stable/drivers/cpufreq/amd-pstate.c:789)
 >>>               vmlinux.o:(show_energy_performance_preference)
 >>> referenced by amd-pstate.c:768 
(/tmp/makepkg/linux61-vd/src/linux-stable/drivers/cpufreq/amd-pstate.c:768)
 >>>               vmlinux.o:(store_energy_performance_preference)
 >>> referenced by amd-pstate.c:749 
(/tmp/makepkg/linux61-vd/src/linux-stable/drivers/cpufreq/amd-pstate.c:749)
 >>>               vmlinux.o:(show_energy_performance_available_preferences)
 >>> referenced 1 more times
 >>> did you mean: energy_perf_strings
 >>> defined in: vmlinux.o

ld.lld: error: undefined symbol: epp_values
 >>> referenced by amd-pstate.c:189 
(/tmp/makepkg/linux61-vd/src/linux-stable/drivers/cpufreq/amd-pstate.c:189)
 >>>               vmlinux.o:(store_energy_performance_preference)
---

and a few warnings:

---
drivers/cpufreq/amd-pstate.c:966:6: warning: variable 'ret' is used 
uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
         if (rc)
             ^~
drivers/cpufreq/amd-pstate.c:1025:9: note: uninitialized use occurs here
         return ret;
                ^~~
drivers/cpufreq/amd-pstate.c:966:2: note: remove the 'if' if its 
condition is always false
         if (rc)
         ^~~~~~~
drivers/cpufreq/amd-pstate.c:962:6: warning: variable 'ret' is used 
uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
         if (!dev)
             ^~~~
drivers/cpufreq/amd-pstate.c:1025:9: note: uninitialized use occurs here
         return ret;
                ^~~
drivers/cpufreq/amd-pstate.c:962:2: note: remove the 'if' if its 
condition is always false
         if (!dev)
         ^~~~~~~~~
drivers/cpufreq/amd-pstate.c:949:66: note: initialize the variable 'ret' 
to silence this warning
         int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
                                                                         ^
 
  = 0
drivers/cpufreq/amd-pstate.c:996:52: warning: variable 'value' is 
uninitialized when used here [-Wuninitialized]
         cpudata->epp_cached = amd_pstate_get_epp(cpudata, value);
                                                           ^~~~~
drivers/cpufreq/amd-pstate.c:953:11: note: initialize the variable 
'value' to silence this warning
         u64 value;
                  ^
                   = 0
drivers/cpufreq/amd-pstate.c:1085:6: warning: variable 'epp' is used 
uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
         if (cpudata->epp_policy == cpudata->policy)
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/cpufreq/amd-pstate.c:1110:30: note: uninitialized use occurs here
         amd_pstate_set_epp(cpudata, epp);
                                     ^~~
drivers/cpufreq/amd-pstate.c:1085:2: note: remove the 'if' if its 
condition is always false
         if (cpudata->epp_policy == cpudata->policy)
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/cpufreq/amd-pstate.c:1064:9: note: initialize the variable 'epp' 
to silence this warning
         s16 epp;
                ^
                 = 0
---

Cheers,

Tor Vic

