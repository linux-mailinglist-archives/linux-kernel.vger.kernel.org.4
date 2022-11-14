Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BCF627633
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbiKNHBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235126AbiKNHBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:01:34 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D75E17E35
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:01:33 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-381662c78a9so16838617b3.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T8++jjvsG0oXPi9XkXPJNv66frIPVuEbhLDe6tRY0RU=;
        b=Mit4/wrbIr9xEAha0HHHyg2FaGR4UQVpWhD8bV88rdWQLdq8Db1QqDANasjWI4q01k
         GRlCEXpGigu1GxcBuBvX76gXqBqgJB59mC6dEbI1WVjdolbyykQDyO7t4cJhWhY/Cnkv
         vlVzr1FfXCP3c7dchMGAzG+2d/hPW4NIDUFDGqTF3VR69Frld5yLCdjb+uMB2t1YiZrK
         4IJyqZTr0kB5DWIkqmo8R2gffOSL+SqaPwL1QczAtfC6t64YFNvO9B5Lo9uxnP9mn7QA
         wrBI+h3dMRCrt1zodWIRayhOiwZS54qos/Ncq6FqAhakOXiOQGjUmxYex4+L0fthTNDY
         gfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T8++jjvsG0oXPi9XkXPJNv66frIPVuEbhLDe6tRY0RU=;
        b=j/4leyqgss17MB4QYlSmGWDiNq0YfIs+pQe1ZeYrU/Pg0ZTbdBQXmlYwsizQLu7cwE
         +I3NqDpHyi/g2d5CeJ7azEXqPjn6oVeGh+b8aQ+5wTZz4ZFcu+ey9BGAv54cmLPAKJhd
         idfB3ppRQHWut505GiFyaf+kNgvmHTN54NQt/Dsg57yhbVd/yqgBHws9UFOm8/r1vHCN
         F4JtOtsBx3vhCnrh2on+9GVastMMWFJjnTqsrUDJ57y0lYUbELArWzCbOMiGUW2JjHm7
         g/blkyifePnz4aa0H0btUH6K1SIZExLP6WoMFZchN1ef4Jj3zlibQEEynR2nUa4fn+Bs
         Zhsw==
X-Gm-Message-State: ANoB5pm0gfsrLoupAgl42NPljM8jXHVLxTo25UE1WXBc6UUosbCMD7Ph
        IaApoSKg1V3On6Or8BMmgt+8bHWZsfKP0tzBJpouPA==
X-Google-Smtp-Source: AA0mqf7aaJuxLskBjfM+h8wmOFyBzzttsEbh4O1ZiJ/cHfJxEv3XIvoj1jdc+vUp0WOwBJSZLaTG4JS00+8SbZS3hx0=
X-Received: by 2002:a81:13c1:0:b0:373:4460:e8bd with SMTP id
 184-20020a8113c1000000b003734460e8bdmr11548114ywt.11.1668409292543; Sun, 13
 Nov 2022 23:01:32 -0800 (PST)
MIME-Version: 1.0
References: <1667986006-25420-1-git-send-email-quic_pkondeti@quicinc.com>
In-Reply-To: <1667986006-25420-1-git-send-email-quic_pkondeti@quicinc.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 14 Nov 2022 08:00:00 +0100
Message-ID: <CANpmjNNYRg7sYTxKN_YCts7wqGfr-2YZbw+pwdO5nTZp_bBVfg@mail.gmail.com>
Subject: Re: [PATCH] mm/kfence: remove hung_task cruft
To:     Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Wed, 9 Nov 2022 at 10:26, Pavankumar Kondeti
<quic_pkondeti@quicinc.com> wrote:
>
> commit fdf756f71271 ("sched: Fix more TASK_state comparisons") makes
> hung_task not to monitor TASK_IDLE tasks. The special handling to
> workaround hung_task warnings is not required anymore.
>
> Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>

Good riddance, thanks.

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kfence/core.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 1417888..08f5bd6 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -26,7 +26,6 @@
>  #include <linux/random.h>
>  #include <linux/rcupdate.h>
>  #include <linux/sched/clock.h>
> -#include <linux/sched/sysctl.h>
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> @@ -799,16 +798,7 @@ static void toggle_allocation_gate(struct work_struct *work)
>         /* Enable static key, and await allocation to happen. */
>         static_branch_enable(&kfence_allocation_key);
>
> -       if (sysctl_hung_task_timeout_secs) {
> -               /*
> -                * During low activity with no allocations we might wait a
> -                * while; let's avoid the hung task warning.
> -                */
> -               wait_event_idle_timeout(allocation_wait, atomic_read(&kfence_allocation_gate),
> -                                       sysctl_hung_task_timeout_secs * HZ / 2);
> -       } else {
> -               wait_event_idle(allocation_wait, atomic_read(&kfence_allocation_gate));
> -       }
> +       wait_event_idle(allocation_wait, atomic_read(&kfence_allocation_gate));
>
>         /* Disable static key and reset timer. */
>         static_branch_disable(&kfence_allocation_key);
> --
> 2.7.4
>
