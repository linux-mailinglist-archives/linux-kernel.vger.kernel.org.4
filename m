Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E01646819
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 05:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiLHEJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 23:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiLHEJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 23:09:30 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA898D655
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 20:09:28 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id 4so408506pli.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 20:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hunJBYHsFf+Z6ONJcd5pZZLsPxJbVZOYvwp3Lj446lM=;
        b=nvQbINZCuWy31KkXFJkiCtfBYXylSRoUyBDiOOmFeROr/jHoahgK6POXLR7S6FHGkB
         OEymcGAjmYB+imapqxfOY3PwwH6c2en7F6vay/6EVqibdKKSgCGQzG3zr0JTnsnjiN2X
         12jaayEN5rBujyCGm7czLnJTpDPKDExxleDFOsaNFkppO7UjnS+n5Qauq867asFr23rU
         Zlrd9HP1Is3rDT/l7PxJx3XPe6N+f9U65/im7Fu+KR1Vw8XvUnW9j51UUUKpNA3jo3lJ
         1Tdd6PlZjh5a0RX9Xge3y67mdcPgEwkJwl6SpRgA9NxvYmZ0Jc+hGT5viyejmbolWpbh
         UbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hunJBYHsFf+Z6ONJcd5pZZLsPxJbVZOYvwp3Lj446lM=;
        b=IiyThAerOT3r7TJ7RY54kde7Was62QM3Xn0D8tPZhCTYUW23j94RhxwmGtyksw4OgE
         DQdr5Rzbtfu06X7HuqinTJhiXKw+kUf6KIzhi/vwfOH1xEf9S02wHaKlCYVnCmEZyNiV
         KMU6hMcHRNB0Ie+BzoZJqK6zh92MczrvxfMLOKDQHocdY/QNUcWLGpsmCelYYbZE2nQY
         q72b3w7m6OTBmqtzetnLXlsmSma33sp60Ia4FWupew1tvzqwIriRRbQE1x0x7rmVgxxS
         gDC0aT07UvJ1CxICDMZluvYOE9Cw+RsjzPD98CKvcbM2w2h+7yO3dZGHkLRaW/cbLT2b
         6U5g==
X-Gm-Message-State: ANoB5pmRi18WXs0PWqPTC7KCeyLwMIAsnz7qeJUYraPgAksFe7v2DsUI
        mXvg7Ur4Qp1itlPlLE2uD48buw==
X-Google-Smtp-Source: AA0mqf4FNeItYeFKIDAzTuEICmoPtdYX09UiHI99shzMqW8aEaO6ly9tJV8a6dWEy4W04xbacdoPIQ==
X-Received: by 2002:a17:90a:5581:b0:219:b015:58d5 with SMTP id c1-20020a17090a558100b00219b01558d5mr22663434pji.199.1670472568310;
        Wed, 07 Dec 2022 20:09:28 -0800 (PST)
Received: from localhost ([122.172.87.149])
        by smtp.gmail.com with ESMTPSA id w10-20020a170902e88a00b001868ed86a95sm15393369plg.174.2022.12.07.20.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 20:09:26 -0800 (PST)
Date:   Thu, 8 Dec 2022 09:39:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, saravanak@google.com,
        wusamuel@google.com, isaacmanjarres@google.com,
        kernel-team@android.com, juri.lelli@redhat.com,
        peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de
Subject: Re: [PATCH v2 2/2] cpufreq: schedutil: Optimize operations with
 single max CPU capacity
Message-ID: <20221208040921.tgwegk7fvdm4nkiu@vireshk-i7>
References: <20221207101705.9460-1-lukasz.luba@arm.com>
 <20221207101705.9460-3-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207101705.9460-3-lukasz.luba@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-12-22, 10:17, Lukasz Luba wrote:
> The max CPU capacity is the same for all CPUs sharing frequency domain
> and thus 'policy' object. There is a way to avoid heavy operations
> in a loop for each CPU by leveraging this knowledge. Thus, simplify
> the looping code in the sugov_next_freq_shared() and drop heavy
> multiplications. Instead, use simple max() to get the highest utilization
> from these CPUs. This is useful for platforms with many (4 or 6) little
> CPUs.
> 
> The max CPU capacity must be fetched every time we are called, due to
> difficulties during the policy setup, where we are not able to get the
> normalized CPU capacity at the right time.
> 
> The stored value in sugov_policy::max is also than used in
> sugov_iowait_apply() to calculate the right boost. Thus, that field is
> useful to have in that sugov_policy struct.
> 
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Looks okay to me.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
