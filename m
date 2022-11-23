Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2530F6367A8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239323AbiKWRuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239320AbiKWRuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:50:23 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25BDC6947;
        Wed, 23 Nov 2022 09:50:18 -0800 (PST)
Received: by mail-qk1-f182.google.com with SMTP id x18so12970275qki.4;
        Wed, 23 Nov 2022 09:50:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQYsGbGmWS8mt/3FP6A9FVNi0+7SD4qOBvQM5lVpVvI=;
        b=CW/PRrxZ1jwX84fo3hklMPrIZe+11C9dW+KcChPHnnhskXrbnq5rbQNQeIC8kv4Lza
         cokiME9AACwYhfTAqWHxbK77eH6NAFUNMVz5rq9h5IIz+poiCiikonaHknZSmaCfpMQA
         +d6TCcPDLQ+AIu9K/IAPeWllhGw7tZP8jE+R37ZmhnjHNkfV3TPtC+7nMOBe2YEEF7ob
         QB1YjDCaKTHcaLa33aTi8e0KSEkZ2YYzc6NOGMiFxBR9LFg3UjI6196j01Uu278WaGSP
         8pap5qVUrgU6XUkZGaQeEmuBhqSrap0Y8gvfgkq487bIsXWIdxfne19d/ACstSklXGg4
         TOvw==
X-Gm-Message-State: ANoB5pkPGfig21upI0z/iNs8eGoJ0sQ8gY/8QMk6TCKQd12EwgJ/2Da4
        Dq1/qdomtd5yc3bInjtrsHcmJgEB3qt1NdvcaEc=
X-Google-Smtp-Source: AA0mqf6HPbRFjF5IVh+Lq3apDeNFUsgUn4wIas2IdxYm9NEid9MVUenLzwRwxTQMCtkhpTZk14HykpMuh+FBos6bLoU=
X-Received: by 2002:a05:620a:22fa:b0:6fb:c38e:e5dd with SMTP id
 p26-20020a05620a22fa00b006fbc38ee5ddmr25726838qki.23.1669225818083; Wed, 23
 Nov 2022 09:50:18 -0800 (PST)
MIME-Version: 1.0
References: <20221105174225.28673-1-rui.zhang@intel.com> <20221105174225.28673-2-rui.zhang@intel.com>
In-Reply-To: <20221105174225.28673-2-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Nov 2022 18:50:07 +0100
Message-ID: <CAJZ5v0gPOUQDb8c_pVYjzBvU3e3U9JoLhJy5vRBF4h2=zvaHHw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] cpuidle: ladder: Tune promotion/demotion threshold
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sat, Nov 5, 2022 at 6:40 PM Zhang Rui <rui.zhang@intel.com> wrote:
>
> After fixing the bogus comparison between u64 and s64, the ladder
> governor stops making promotion decisions errornously.
>
> However, after this, it is found that the ladder governor demotes much
> easier than promotes.

"After fixing an error related to using signed and unsigned integers
in the ladder governor in a previous patch, that governor turns out to
demote much easier than promote"

> Below is captured using turbostat after a 30 seconds runtime idle,
>
> Without previous patch,
> Busy%   IRQ     POLL    C1      C1E     C3      C6      C7s     C8      C9      C10     CPU%c1  CPU%c3  CPU%c6  CPU%c7  PkgWatt
> 0.30    2373    0       0       0       4       9       25      122     326     2857    0.36    0.04    0.57    98.73   1.48

Why is the above relevant?

> With previous patch,
> Busy%   IRQ     POLL    C1      C1E     C3      C6      C7s     C8      C9      C10     CPU%c1  CPU%c3  CPU%c6  CPU%c7  PkgWatt
> 0.42    3071    0       771     838     447     327     336     382     299     344     34.18   16.21   17.69   31.51   2.00
>
> And this is caused by the imbalanced PROMOTION_COUNT/DEMOTION_COUNT.

I would explain why/how the imbalanced PROMOTION_COUNT/DEMOTION_COUNT
imbalance causes this.

I guess more residency in the deeper idle state is expected?  Or desired??

> With this patch,
> Busy%   IRQ     POLL    C1      C1E     C3      C6      C7s     C8      C9      C10     CPU%c1  CPU%c3  CPU%c6  CPU%c7  PkgWatt
> 0.39    2436    0       1       72      177     51      194     243     799     1883    0.50    0.32    0.35    98.45   1.53
>
> Note that this is an experimental patch to illustrate the problem,
> and it is checked with idle scenario only for now.
> I will try to evaluate with more scenarios, and if someone can help
> evaluate with more scenarios at the same time and provide data for the
> benefit with different PROMOTION_COUNT/DEMOTION_COUNT values, that
> would be great.

So yes, this requires more work.

Overall, I think that you are concerned that the previous change might
be regarded as a regression and are trying to compensate for it with a
PROMOTION_COUNT/DEMOTION_COUNT change.

I'm not sure I can agree with that approach, because the shallower
idle states might be preferred by the original ladder design
intentionally, for performance reasons.

> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/cpuidle/governors/ladder.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
> index fb61118aef37..4b47aa0a4da9 100644
> --- a/drivers/cpuidle/governors/ladder.c
> +++ b/drivers/cpuidle/governors/ladder.c
> @@ -20,8 +20,8 @@
>  #include <asm/io.h>
>  #include <linux/uaccess.h>
>
> -#define PROMOTION_COUNT 4
> -#define DEMOTION_COUNT 1
> +#define PROMOTION_COUNT 2
> +#define DEMOTION_COUNT 4
>
>  struct ladder_device_state {
>         struct {
> --
