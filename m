Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CEA5BB698
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 08:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiIQGIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 02:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIQGIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 02:08:48 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D2D1580D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 23:08:47 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-324ec5a9e97so283042557b3.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 23:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=c4hfMSyn6vzLcnkL436hj34inLcl+MLWoRDO1KPEUb0=;
        b=iXinRsNHJBpMQwn0ySqvU5x3NJCSz8m2qWsPqkWcJTF91TKDUfEQUD+PAr76fi8aMO
         4zkwFtdAPi7A3IupcrlMZ5wIbInblY3ZQVZpIQehtGLQlQQy41QqZrmZ5WvNJflZlAGV
         NFp8cJ8NjTe2kodCmnZPN4Akg58GFlW9njBafNEEfHJHpr31YtFvJWwbNX5O3NCLktm0
         2QjF/m7W5B5vqj8rEzdWF2tJo6t4hf4gOr8Or7Zx3pTGeJY9Q1T/xbtA3k8kLtM2PJkb
         EScMDUW59evYLJw/IgAbPGDmPhxjO6FM3TUyAp9crYjoPtJdqcge0M4ofOrn19PSftFz
         10mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=c4hfMSyn6vzLcnkL436hj34inLcl+MLWoRDO1KPEUb0=;
        b=ZE/rTMDIb1U0oaRUFZoThMyuf7bOEp4vcQUuEQC1LRCPseMZoEE26xq78U5atjnl4d
         VHL8Ret2zYYhumOj4GLF7lmudhM3Xnkfc+oszuvWejndVmLpsyMkEg8YCSfE3dvhgGWs
         4xyvjqIox+5SlX1XPKQkEzRTN66JJyThU1GAOK3kWeLhLvAI13OZU9IemY3r/Q18ywuu
         +XTMFYw0Sxf24D40IiEDRV6CDLw89arMSn+Cw3lVwRUWgMmSxN/4phukDWz2lkHUUPck
         EKsoKmAzAiV6HRiTfj02YmtBlt+TO6vg0jZLR8wYFm5FKem06w04VXg1pH6lFlwKcfe/
         z3Vg==
X-Gm-Message-State: ACrzQf2ECsqf3QxYKNolsmS1AKAkQlELatemo4nO9MU7Aw+OT8xnhKgj
        sMr0BWFP3710IM/8eXd8UkMF/7q29Tfq9DfIZ2cUUoaTI+NGNdIy
X-Google-Smtp-Source: AMsMyM6rzQ6tdkvYiBZ+xsu5kHvftxxBt+uieXGqntYdruMHPt/kcT8TtSgt9FTqFnuW6k3X+eEulDbsZsCWMpqj8KQ=
X-Received: by 2002:a0d:d90f:0:b0:349:e8c1:bac with SMTP id
 b15-20020a0dd90f000000b00349e8c10bacmr7367128ywe.218.1663394925223; Fri, 16
 Sep 2022 23:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220914092959.GA20640@haolee.io>
In-Reply-To: <20220914092959.GA20640@haolee.io>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 16 Sep 2022 23:08:34 -0700
Message-ID: <CAJuCfpFVK3ceHy+ipSbLb0jAgE6tJAsu5=kbJEB9X4OWPnsVxA@mail.gmail.com>
Subject: Re: [PATCH] psi: fix possible missing or delayed pending event
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 2:30 AM Hao Lee <haolee.swjtu@gmail.com> wrote:
>
> When a pending event exists and growth is less than the threshold, the
> current logic is to skip this trigger without generating event. However,
> from e6df4ead85d9 ("psi: fix possible trigger missing in the window"),
> our purpose is to generate event as long as pending event exists and the
> rate meets the limit. This patch fixes the possible pending-event
> missing or delay.
>
> Fixes: e6df4ead85d9 ("psi: fix possible trigger missing in the window")
> Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
> ---
>  kernel/sched/psi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 9711827e3..0bae4ee2b 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -539,7 +539,7 @@ static u64 update_triggers(struct psi_group *group, u64 now)
>
>                         /* Calculate growth since last update */
>                         growth = window_update(&t->win, now, total[t->state]);
> -                       if (growth < t->threshold)
> +                       if (growth < t->threshold && !t->pending_event)

I'm not sure how this additional condition changes things. Current
logic is to set t->pending_event=true whenever growth exceeds the
t->threshold. This patch will change this logic into setting
t->pending_event=true also when t->pending_event=true. But why would
you want to set t->pending_event=true if it's already true? What am I
missing?

>                                 continue;
>
>                         t->pending_event = true;
> --
> 2.21.0
>
