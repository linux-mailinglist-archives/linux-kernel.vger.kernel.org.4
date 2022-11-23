Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21058636754
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238362AbiKWRhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238543AbiKWRhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:37:22 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1AF86A7F;
        Wed, 23 Nov 2022 09:37:20 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id fz10so11696253qtb.3;
        Wed, 23 Nov 2022 09:37:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ucnbBqNAI6qAohZYdKrju6FewGcPQWXWkoit1wMZomI=;
        b=gUrIx5mrfYe3pbRUT7kl+a8X2Fe29bPVzUq+ZYqZNq76CLSxlOm82zMUi5yie960Pf
         eMs5nLKKb6gXdqbUuWJcxXFJ6Ox7dAykJcEpXcbVTHDlxSFoNMc92p1G5pDg3CBG8SRS
         FP5slGxOq0tzcISeRGuau/8XHCzk2M5OtRWMJlaVHbJuVHZ4d0FvrhFnzXTn53C+kRBM
         pLAhJ4x8EgAIHSzrNUts8THJOCVNuD4aeeYhXWsRGl0/we+Ebve++AudvRwdn4kZvyq4
         pQ2z+yIYWPC40Hvpx16etapPtNV70JHCFIYUVKv7unRWS+hxoZo88ik45nKOMB7tgn7S
         KJ7A==
X-Gm-Message-State: ANoB5pmxkjFTOPUwBePdsKM+9IdirR/i8BVcp0En7VC8JnyOEb//OoBg
        d3LprTp1Dzgbwkn10uLMSz2uApnliv03bkcaG08=
X-Google-Smtp-Source: AA0mqf5p0ypZ4M2LkUKQQnwcZd6os57hZyPq6HmySD7gjQK1ets8f5CZqfF4fE/DcKTvnbt5CnJR1UwKGuTWyeO6Hxk=
X-Received: by 2002:a05:622a:1989:b0:3a5:7cf8:1a6e with SMTP id
 u9-20020a05622a198900b003a57cf81a6emr27612826qtc.48.1669225040038; Wed, 23
 Nov 2022 09:37:20 -0800 (PST)
MIME-Version: 1.0
References: <20221105174225.28673-1-rui.zhang@intel.com>
In-Reply-To: <20221105174225.28673-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 23 Nov 2022 18:37:08 +0100
Message-ID: <CAJZ5v0gK60=Cya+u_-7qgL5LG5O9j=r+QH+Kwg71VQSGby6=YA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] cpuidle: ladder: Fix bogus comparison between s64
 and u64
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 5, 2022 at 6:40 PM Zhang Rui <rui.zhang@intel.com> wrote:
>
> ladder_device_state.threshold.promotion_time_ns/demotion_time_ns
> are u64 type.
>
> In ladder_select_state(), variable 'last_residency', as calculated by
>
> last_residency = dev->last_residency_ns - drv->states[last_idx].exit_latency_ns
>
> are s64 type, and it can be negative value.

The code changes are fine AFAICS, but the description below could be
more precise.

> When this happens, comparing between 'last_residency' and
> 'promotion_time_ns/demotion_time_ns' become bogus.

IIUC, what happens is that last_residency is converted to u64 in the
comparison expression and that conversion causes it to become a large
positive number if it is negative.

> As a result, the ladder governor promotes or stays with current state errornously.

"promotes or retains the current state erroneously".

>
>           <idle>-0       [001] d..1.   151.893396: ladder_select_state: last_idx 7, last_residency -373033
>           <idle>-0       [001] d..1.   151.893399: ladder_select_state:    dev->last_residency_ns 106967, drv->states[last_idx].exit_latency_ns 480000
>           <idle>-0       [001] d..1.   151.893402: ladder_select_state:    promote, last_state->threshold.promotion_time_ns 480000
>           <idle>-0       [001] d..1.   151.893404: ladder_select_state:    ---> new state 7
>           <idle>-0       [001] d..1.   151.893465: ladder_select_state: last_idx 7, last_residency -463800
>           <idle>-0       [001] d..1.   151.893467: ladder_select_state:    dev->last_residency_ns 16200, drv->states[last_idx].exit_latency_ns 480000
>           <idle>-0       [001] d..1.   151.893468: ladder_select_state:    promote, last_state->threshold.promotion_time_ns 480000
>           <idle>-0       [001] dn.1.   151.893470: ladder_select_state:    ---> new state 8
>
> Given that promotion_time_ns/demotion_time_ns are initialized with
> cpuidle_state.exit_latency_ns, which is s64 type, and they are used to
> compare with 'last_residency', which is also s64 type, there is no

"they are compared with"

> reason to use u64 for promotion_time_ns/demotion_time_ns.

"so change them both to be s64".

> With this patch,
>           <idle>-0       [001] d..1.   523.578531: ladder_select_state: last_idx 8, last_residency -879453
>           <idle>-0       [001] d..1.   523.578531: ladder_select_state:    dev->last_residency_ns 10547, drv->states[last_idx].exit_latency_ns 890000
>           <idle>-0       [001] d..1.   523.578532: ladder_select_state:    demote , last_state->threshold.demotion_time_ns 890000
>           <idle>-0       [001] d..1.   523.578532: ladder_select_state:    ---> new state 7
>           <idle>-0       [001] d..1.   523.580220: ladder_select_state: last_idx 7, last_residency -169629
>           <idle>-0       [001] d..1.   523.580221: ladder_select_state:    dev->last_residency_ns 310371, drv->states[last_idx].exit_latency_ns 480000
>           <idle>-0       [001] d..1.   523.580221: ladder_select_state:    demote , last_state->threshold.demotion_time_ns 480000
>           <idle>-0       [001] d..1.   523.580222: ladder_select_state:    ---> new state 6
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/cpuidle/governors/ladder.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
> index 8e9058c4ea63..fb61118aef37 100644
> --- a/drivers/cpuidle/governors/ladder.c
> +++ b/drivers/cpuidle/governors/ladder.c
> @@ -27,8 +27,8 @@ struct ladder_device_state {
>         struct {
>                 u32 promotion_count;
>                 u32 demotion_count;
> -               u64 promotion_time_ns;
> -               u64 demotion_time_ns;
> +               s64 promotion_time_ns;
> +               s64 demotion_time_ns;
>         } threshold;
>         struct {
>                 int promotion_count;
> --
