Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACEB6441C7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbiLFLBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbiLFLAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:00:55 -0500
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F8F24973;
        Tue,  6 Dec 2022 03:00:20 -0800 (PST)
Received: by mail-qk1-f177.google.com with SMTP id g10so7143962qkl.6;
        Tue, 06 Dec 2022 03:00:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBhPqYc/JMCTFIEagYJZEgzKwzycXm8LzBcb9Js+yF4=;
        b=CviNX96YSi8l5ieJGDHjXHpGFKVnm9BlKWsqpB7LDaCKucvDe6DFvpeWt5B8RYSE07
         eyRyUx94DmjmtR0hz9+/V3Z6GXRVVAPDWgiPIHmzUXHphHOFzUyVJ+hNysy7FK2WGGyE
         Y15EHlwBuB9DxQi2zXj4t/PZl9EQwYGTgJAtpVn2ASzAA4agVXngVGhkisYqVWeEBCc1
         6ACjBF3iGy3FD4KCyuOhqp2Ej/PyrM9mBbv7dIPlqOJLgiXJ9ki4kOoeqR+bMQaboWHy
         0LUMiJjhruSuFG3LafMHTCSJ8jjrzbt/+Xo1BEPVw3j618DMDz7hpgbFsRiJEOOCqFhJ
         Ec+Q==
X-Gm-Message-State: ANoB5pnZgAhhrUgeG1HyWWhktnJSdsVpw/UGOlA7JIrsnG/KjezKG1Pj
        UBldA2XTmPm5zuL32t2wCesWD9IPyUCF3DKM4OU=
X-Google-Smtp-Source: AA0mqf5b/hp4GlGZmjpSekpW0gRmUaFcJ+nSiIYlCHbKwn0nXou+S9nnSSJq2OUAjqmI568w8vqneQ0QDd8n2GYee3s=
X-Received: by 2002:a05:620a:4611:b0:6fa:af7e:927c with SMTP id
 br17-20020a05620a461100b006faaf7e927cmr74758208qkb.443.1670324419800; Tue, 06
 Dec 2022 03:00:19 -0800 (PST)
MIME-Version: 1.0
References: <20221206101021.18113-1-lukasz.luba@arm.com> <20221206101629.dbcuv3zdso44w3cq@vireshk-i7>
 <2a97cf28-7e47-04c7-edcb-41adbd20ccd9@arm.com>
In-Reply-To: <2a97cf28-7e47-04c7-edcb-41adbd20ccd9@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 6 Dec 2022 12:00:07 +0100
Message-ID: <CAJZ5v0hRW2Px4LP9OCgFqyUQUiVr0xZL6dYPrWrmGerGqCq1PQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: Optimize operations with single max
 CPU capacity
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, saravanak@google.com,
        wusamuel@google.com, isaacmanjarres@google.com,
        kernel-team@android.com, juri.lelli@redhat.com,
        peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 6, 2022 at 11:30 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 12/6/22 10:16, Viresh Kumar wrote:
> > On 06-12-22, 10:10, Lukasz Luba wrote:
> >> The max CPU capacity is the same for all CPUs sharing frequency domain
> >> and thus 'policy' object. There is a way to avoid heavy operations
> >> in a loop for each CPU by leveraging this knowledge. Thus, simplify
> >> the looping code in the sugov_next_freq_shared() and drop heavy
> >> multiplications. Instead, use simple max() to get the highest utilization
> >> from these CPUs. This is useful for platforms with many (4 or 6) little
> >> CPUs.
> >>
> >> The max CPU capacity must be fetched every time we are called, due to
> >> difficulties during the policy setup, where we are not able to get the
> >> normalized CPU capacity at the right time.
> >>
> >> The stored value in sugov_policy::max is also than used in
> >> sugov_iowait_apply() to calculate the right boost. Thus, that field is
> >> useful to have in that sugov_policy struct.
> >>
> >> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> >
> > Can you please divide this into two patches, one for just moving max
> > and one for looping optimization ? Else we may end up reverting
> > everything once again.
> >
>
> OK, I can do that. Thanks for having a look!

Also, please note that this material is unlikely to go into 6.2, so
I'd prefer going back to it after 6.2-rc1 is out.
