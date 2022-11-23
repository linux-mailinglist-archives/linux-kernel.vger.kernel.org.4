Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998AD636E9B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 00:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiKWXxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 18:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiKWXxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 18:53:30 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FE0DB859
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:53:28 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id w79so157678pfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xbVYVr0QQE7up62W+h8S7yXFKbxiqK7z6JAjDrkGdqQ=;
        b=T90d24Inan06RdYDFODCWVMOdPaIwPi47Bor8Q8edEdH5+HQ7O67sy8e25gyNZ7Okw
         5YumnFE72hKdDjCQ5H+dXByOhp7FE+SPjoVZ1P9hZvT62pJk+i5/uTZiGdqC7enj//Bp
         ZboQHL5BEXrI5OzXN0o6koU13h+pZcgWoZ8QJ0ix6XoaEx2J/crdT8Qpk+/65s4OBiHg
         1Aym65hzrBwrfBIa28T2N+EClg+PAgcpZxrb2kk4WzBCrEi+yXUz78/e5yAmhE31+SyL
         oZCPRx7k7/0OmnU2sJNjY4gFXhJywwXzx4Qeac+pXS8pWLXxFfOYAY894/WOsYJN6mAo
         1G+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xbVYVr0QQE7up62W+h8S7yXFKbxiqK7z6JAjDrkGdqQ=;
        b=qV4GolUcFavTFiboTMceAsXgXV3UkRYiFkQ4hLmGsQ9KmQ55d2SnU2pViCSGig3WUj
         4GmwvaMU2Z0TOIZsF4+AMOq8TzPFPFsHwpkGvv8YJC+Ee81v+0D+2qOU8tU1vEzIgr2Q
         62D428DD7q6F7+oaTCEkY9heMN8jnJp/xDmB4+vIfgAm5J/+7CcSTf+e44IgsefSSm/7
         Za7cj1VgdCDWWsjxDreC6FjXgzmLKqACXTpZeuXMBtecKIHjMFT+6vwOa8EygrNGLGoQ
         IhSSO9YOkzcqaC+WOh5wJALZ68OK6Huo43q/pfwLRgIzesh3xYXg8YUfaT/e2oxD31gZ
         CXcQ==
X-Gm-Message-State: ANoB5pkKnYxIUGPeM3QWw/fVK+O9+62j9XL+VPvYJO+muOcLXcttDI+V
        w0WIGimwuMJGrAo8/hDhMNWReQ==
X-Google-Smtp-Source: AA0mqf4rtADPJsLcq44Zb+CgaPWpWumh7ZTgT8jktY2uei+qCs0Q1YoX9qH8GnqAtRUeFIr7Lz0WdA==
X-Received: by 2002:a05:6a00:194a:b0:56b:a795:e99c with SMTP id s10-20020a056a00194a00b0056ba795e99cmr20308471pfk.14.1669247607824;
        Wed, 23 Nov 2022 15:53:27 -0800 (PST)
Received: from DougS18 (s173-180-45-4.bc.hsia.telus.net. [173.180.45.4])
        by smtp.gmail.com with ESMTPSA id s10-20020a170902ea0a00b00186c3af9644sm14864230plg.273.2022.11.23.15.53.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Nov 2022 15:53:27 -0800 (PST)
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Rafael J. Wysocki'" <rafael@kernel.org>,
        "'Zhang Rui'" <rui.zhang@intel.com>
Cc:     <rjw@rjwysocki.net>, <daniel.lezcano@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Doug Smythies" <dsmythies@telus.net>
References: <20221105174225.28673-1-rui.zhang@intel.com> <20221105174225.28673-2-rui.zhang@intel.com> <CAJZ5v0gPOUQDb8c_pVYjzBvU3e3U9JoLhJy5vRBF4h2=zvaHHw@mail.gmail.com>
In-Reply-To: <CAJZ5v0gPOUQDb8c_pVYjzBvU3e3U9JoLhJy5vRBF4h2=zvaHHw@mail.gmail.com>
Subject: RE: [RFC PATCH 2/3] cpuidle: ladder: Tune promotion/demotion threshold
Date:   Wed, 23 Nov 2022 15:53:27 -0800
Message-ID: <009601d8ff96$c8ffbc50$5aff34f0$@telus.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHjk5ipFmOQvQsq6YVxKlctUdJTtgKSFjv+AX749gOuF2yYgA==
Content-Language: en-ca
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022.11.23 09:50 Rafael wrote:
> On Sat, Nov 5, 2022 at 6:40 PM Zhang Rui <rui.zhang@intel.com> wrote:
>>
>> After fixing the bogus comparison between u64 and s64, the ladder
>> governor stops making promotion decisions errornously.
>>
>> However, after this, it is found that the ladder governor demotes much
>> easier than promotes.
>
> "After fixing an error related to using signed and unsigned integers
> in the ladder governor in a previous patch, that governor turns out to
> demote much easier than promote"
>
>> Below is captured using turbostat after a 30 seconds runtime idle,
>>
>> Without previous patch,
>> Busy%   IRQ     POLL    C1      C1E     C3      C6      C7s     C8      C9      C10     CPU%c1  CPU%c3  CPU%c6  CPU%c7  PkgWatt
>> 0.30    2373    0       0       0       4       9       25      122     326     2857    0.36    0.04    0.57    98.73   1.48
>
> Why is the above relevant?
>
>> With previous patch,
>> Busy%   IRQ     POLL    C1      C1E     C3      C6      C7s     C8      C9      C10     CPU%c1  CPU%c3  CPU%c6  CPU%c7  PkgWatt
>> 0.42    3071    0       771     838     447     327     336     382     299     344     34.18   16.21   17.69   31.51   2.00
>>
>> And this is caused by the imbalanced PROMOTION_COUNT/DEMOTION_COUNT.
>
> I would explain why/how the imbalanced PROMOTION_COUNT/DEMOTION_COUNT
> imbalance causes this.
>
> I guess more residency in the deeper idle state is expected?  Or desired??
>
>> With this patch,
>> Busy%   IRQ     POLL    C1      C1E     C3      C6      C7s     C8      C9      C10     CPU%c1  CPU%c3  CPU%c6  CPU%c7  PkgWatt
>> 0.39    2436    0       1       72      177     51      194     243     799     1883    0.50    0.32    0.35    98.45   1.53
>>
>> Note that this is an experimental patch to illustrate the problem,
>> and it is checked with idle scenario only for now.
>> I will try to evaluate with more scenarios, and if someone can help
>> evaluate with more scenarios at the same time and provide data for the
>> benefit with different PROMOTION_COUNT/DEMOTION_COUNT values, that
>> would be great.
>
> So yes, this requires more work.
>
> Overall, I think that you are concerned that the previous change might
> be regarded as a regression and are trying to compensate for it with a
> PROMOTION_COUNT/DEMOTION_COUNT change.
>
> I'm not sure I can agree with that approach, because the shallower
> idle states might be preferred by the original ladder design
> intentionally, for performance reasons.

Hi All,

Because I was continuing to test the teo governor with
the util patch version 4, it was fairly easy for me to test
this patch set also. However, I have had difficulties having
enough time to write up my results.

The best improvement was for a slow speed ping-pong
(I did 3 speeds, fast, medium, and slow)
2 pairs of ping pongs, not forced CPU affinity,
schedutil CPU scaling governor,
intel_cpufreq CPU scaling driver,
HWP disabled.

The menu governor was considered the master reference:

Old ladder was 44% slower.
New ladder was 5.9% slower.

Just for reference:
Old teo was 29% slower.
teo util V4 was 13% slower.  

The worst degradation was for a fast speed ping-pong
2 pairs of ping pongs, not forced CPU affinity,
schedutil CPU scaling governor,
intel_cpufreq CPU scaling driver,
HWP disabled.

The menu governor was considered the master reference:

Old ladder was 64% slower.
New ladder was 71% slower.

Interestingly, the old ladder governor outperformed
the menu governor on the slow 2 pair ping-pong
with the performance governor:

Old ladder was 0.56% faster.
New ladder was 0.81% slower.

Disclaimer: Test results using the schedutil
CPU scaling governor are noisy, with
questionable repeatability.

I'll try to get all the test results written up soon.

... Doug


