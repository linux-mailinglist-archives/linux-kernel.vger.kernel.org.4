Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAF2639949
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 05:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiK0E3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 23:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiK0E3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 23:29:51 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D85F11164
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 20:29:50 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id b4so7485939pfb.9
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 20:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DqgH8cmHhfTz1Vd5tEGfh30cXpik/rHUE/AA8MWiYIA=;
        b=QxtOkawsOV8yH3gBwfP3XH7r0/9hh0Xf1MbOjZJPJnwUmxABxSgiKfKds5tVnPf6IP
         FnkzcXfn+/S/Wc8+/OgFtAxWeAleZrGOHS7pLIUwFagdWBi5DyrFHqCitTpZsd9Rzw6h
         omDcExhBorMv9Iq+rFOuku0HQIvLs5EC1a+ifE1Tdu2QiPfUwuehXO76BBE58utnksp0
         3lEMPMcNAH/xIdxeJAqD48uWnep3P41pK4IshNV2sBH0Yyi9xb4z52jSgehGbp1UVLix
         n5VFOcbK4uiR7EhAP2cOoc/vXYAMQjc+GFPAnSpK7g+A8obPe5FrugzfCpY+1QjHzg12
         AFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DqgH8cmHhfTz1Vd5tEGfh30cXpik/rHUE/AA8MWiYIA=;
        b=wkzsE0hYFizMvI/4vLaI4d/TB8C9JhRwnDiZODBNQICs6cnTu1o0dq5Yx+iFjNMcfY
         jf2ItnbRynVsxlnT1B+N22Ap01WMVYPUIzlAev6m96WUAlU2FOKFXvdPHSkXHAL5BiRs
         Sbp3g2YmX1lCVUHWc51tWRA1j6pK+kIZUWv7e1MOxZ4gABO8KXxpJufW7Wj4o9cNx2hI
         ToQqoA334qCDUTx0xZF649v9ImCdSADA8u7fmZPLgwLU79oNHwUo4D+8OjiWmk13d1jv
         oYTUURydSuoXs9cGWI95o6vlmVjpOjduHfbYi/Hu299+IEE2gFm/zJXsmfwWDQQQy+5J
         qWwA==
X-Gm-Message-State: ANoB5plHkgjNUyzurlb13tup3ocoDvmJxEZZda/5EONZMtF9lboaZMlg
        7hl4V9Ou+kLZ9B+CatT36HHFMA==
X-Google-Smtp-Source: AA0mqf5w6Q8t2dnnUcA5QNcjpQJxJ8kEWg+TkaCm7G6FUDiBRGvQjIDHviO3GjIqFnz+XbYO7B3lUA==
X-Received: by 2002:a05:6a00:1741:b0:563:9203:cc53 with SMTP id j1-20020a056a00174100b005639203cc53mr36158170pfc.20.1669523389987;
        Sat, 26 Nov 2022 20:29:49 -0800 (PST)
Received: from DougS18 (s173-180-45-4.bc.hsia.telus.net. [173.180.45.4])
        by smtp.gmail.com with ESMTPSA id h14-20020a056a00000e00b00574ebfdc721sm1904359pfk.16.2022.11.26.20.29.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Nov 2022 20:29:49 -0800 (PST)
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "'Kajetan Puchalski'" <kajetan.puchalski@arm.com>
Cc:     <daniel.lezcano@linaro.org>, <lukasz.luba@arm.com>,
        <Dietmar.Eggemann@arm.com>, <yu.chen.surf@gmail.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <20221031121314.1381472-1-kajetan.puchalski@arm.com> <20221031121314.1381472-3-kajetan.puchalski@arm.com> <CAJZ5v0hHvf-033Oa-nW7UEZq=9cTFzn6e_znccPXBUeNa=YY+Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0hHvf-033Oa-nW7UEZq=9cTFzn6e_znccPXBUeNa=YY+Q@mail.gmail.com>
Subject: RE: [RFC PATCH v3 2/2] cpuidle: teo: Introduce util-awareness
Date:   Sat, 26 Nov 2022 20:29:51 -0800
Message-ID: <004d01d90218$e4631670$ad294350$@telus.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQJ3niu74TkyFjUbsRqSa0N7+FgHagJieOsRAbWVYo2s8+GpAA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022.11.25 10:27 Rafael wrote:
> On Mon, Oct 31, 2022 at 1:14 PM Kajetan wrote:

... [delete some] ...

>>         /*
>>          * Find the deepest idle state whose target residency does not exceed
>>          * the current sleep length and the deepest idle state not deeper than
>> @@ -454,6 +527,11 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>>         if (idx > constraint_idx)
>>                 idx = constraint_idx;
>>
>> +       /* if the CPU is being utilized and C1 is the selected candidate */
>> +       /* choose a shallower non-polling state to improve latency */
>
> Again, the kernel coding style for multi-line comments is different
> from the above.
>
>> +       if (cpu_data->utilized && idx == 1)
>
> I've changed my mind with respect to adding the idx == 1 check to
> this.  If the goal is to reduce latency for the "loaded" CPUs, this
> applies to deeper idle states too.

After taking idle state 0 (POLL) out of it, the energy cost for reducing
the selected idle state by 1 was still high in some cases, at least on my
Intel processor. That was mainly for idle state 2 being bumped to idle
state 1. I don't recall significant differences bumping idle state 3 to idle
state 2, but I don't know about other Intel processors.

So, there is a trade-off here where we might want to accept this higher
energy consumption for no gain in some workflows verses the higher
energy for gain in other workflows, or not.

Example 1: Higher energy, for no benefit:
Workflow: a medium load at 211 work/sleep frequency.
This data is for one thread, but I looked at up to 6 threads.
No performance metric, the work just has to finish before
the next cycle begins.
CPU frequency scaling driver: intel_pstate
CPU frequency scaling governor: powersave
No HWP.
Kernel 6.1-rc3

teo: ~14.8 watts
util-v4 without the "idx == 1" above: 16.1 watts (+8.8%)
More info:
http://smythies.com/~doug/linux/idle/teo-util/consume/dwell-v4/

Example 2: Lower energy, but no loss in performance:
Workflow: 500 threads, light load per thread,
approximately 10 hertz work/sleep frequency per thread.
CPU frequency scaling driver: intel_cpufreq
CPU frequency scaling governor: schedutil
No HWP.
Kernel 6.1-rc3

teo: ~70 watts
util-v4 without the "idx == 1" above: ~59 watts (-16%)
Execution times were the same
More info:
http://smythies.com/~doug/linux/idle/teo-util/waiter/

Note: legend util-v4-1 is util-v4 without the "idx == 1".
I have also added util-v4-1 to some of the previous results.

For reference, my testing processor:

Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz

$ grep . /sys/devices/system/cpu/cpu0/cpuidle/state*/name
/sys/devices/system/cpu/cpu0/cpuidle/state0/name:POLL
/sys/devices/system/cpu/cpu0/cpuidle/state1/name:C1_ACPI
/sys/devices/system/cpu/cpu0/cpuidle/state2/name:C2_ACPI
/sys/devices/system/cpu/cpu0/cpuidle/state3/name:C3_ACPI

$ grep . /sys/devices/system/cpu/cpu0/cpuidle/state*/desc
/sys/devices/system/cpu/cpu0/cpuidle/state0/desc:CPUIDLE CORE POLL IDLE
/sys/devices/system/cpu/cpu0/cpuidle/state1/desc:ACPI FFH MWAIT 0x0
/sys/devices/system/cpu/cpu0/cpuidle/state2/desc:ACPI FFH MWAIT 0x30
/sys/devices/system/cpu/cpu0/cpuidle/state3/desc:ACPI FFH MWAIT 0x60

... Doug

