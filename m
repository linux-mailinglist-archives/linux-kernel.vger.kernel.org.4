Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AFF66BAE5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjAPJvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjAPJvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:51:37 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A92E14EB7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:51:36 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id p24so29777778plw.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vuZtfqxiKrPezXdmrbbcOWCnjwcTnLNOwXCm2ry7AXw=;
        b=erlfADiX9yeCHPk3RvZgLTufLGlx+vTaafvQTLGRMmo/xWrwLwf08aZnwp8ftSss0T
         jAiwq0AZV7RimT4lLJ9cns35YIyrl8LJycbDkyDrcl374FPplGag5CjldDz25nB7WS3H
         d8jLCSkE0SPy5nSDlZrkO6XehZKtFKP+0fL5j5sDHVxYTvkDZiT7r0Nyww5Lw1gjuYqP
         DdkQHeGgoymE1Vuiz9q6q5TJyH9YvuSfDg37t+PGRNNUIDrbzHXwYUHwwFzuUOs2hHKU
         O5TqXe9Dqfcw6gUvtSlcdpgfuuzsWAAX+v/5QorYirp56drEkbPuCQjXwRnTHJeDOg2p
         Hc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vuZtfqxiKrPezXdmrbbcOWCnjwcTnLNOwXCm2ry7AXw=;
        b=rhkGGXlX8RCnYF1IxZyzXeow0CaLtoiUBP/GE5r3wwk/Y99jXV+o+1/UwJN5ZgH89m
         ZFFkShwWJ46ZeYeB448jsjOvN5wg/4BSdJt9xD3EbxBtWg2PZeuepvqO2q9Djm/PXarc
         qUSYESmry4tJSkWH1fkhmraEebd0ygYPW1N37ss3XwhuriAkeWRtYqT1Iv2DnPMqjRct
         +tMyyqHeG93G0QxiRfAScY/01FKIf6iu9c7qbQqy6Kk7HJPKtO9I64i49/lH9i3J/bjd
         ST+BkUFOVYRi+CUpkRGHJ/S5cUXGC9tPXA9LjNUoILODgYAO/GQsNXelJQTDNheSdWrU
         yJNA==
X-Gm-Message-State: AFqh2kqkdsbkRxxgB5eoC81i+1pQfdDtH7n1x+v1tGTW6zbJSWMmMg1Q
        LnffmwZTIPhdW3zS5Bvc15UJtWl1HAhIfq+caOSlIQ==
X-Google-Smtp-Source: AMrXdXs1mhHm+a2aHqW2oKHDtY1www2WLBrL8nFfrmMfHmdf7JilFzI1Yso1A4qbfaPcQIaiGChQjTHcy7QyO8OX738=
X-Received: by 2002:a17:90a:49c6:b0:227:1f55:158d with SMTP id
 l6-20020a17090a49c600b002271f55158dmr2367451pjm.92.1673862695756; Mon, 16 Jan
 2023 01:51:35 -0800 (PST)
MIME-Version: 1.0
References: <20230112162426.217522-1-bristot@kernel.org> <Y8UQdKx+004a28fL@hirez.programming.kicks-ass.net>
 <Y8USikoCYTBl7VFr@gmail.com> <Y8UYtEepRT3xC8O/@gmail.com>
In-Reply-To: <Y8UYtEepRT3xC8O/@gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 16 Jan 2023 10:51:24 +0100
Message-ID: <CAKfTPtCBn20ECopZoT5iC0by8SgpRN_xi4Q0Q8Uc8VQ6BR=u=Q@mail.gmail.com>
Subject: Re: [PATCH] sched/idle: Make idle poll dynamic per-cpu
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2023 at 10:28, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ingo Molnar <mingo@kernel.org> wrote:
>
> > > Urgh, can we please make this a cpuidle governor thing or so? So that
> > > we don't need to invent new interfaces and such.
> >
> > I think the desired property here would be to make this interface on top
> > of pretty much any governor. Ie. have a governor, but also a way to drop
> > any CPU into idle-poll, overriding that.
>
> ... with the goal of having the best governor for power efficiency by
> default - but also the ability to drop a handful of CPUs into the highest
> performance / lowest latency idle mode.
>
> It's a special kind of nested policy, for workload exceptions.

User can set per cpu latency constraint with
/sys/devices/system/cpu/cpu*/power/pm_qos_resume_latency_us
Which is then used by cpuidle governor when selecting an idle state.
The cpuidle governor should then select the idle state that matches
with the wakeup latency for those CPUs but select the most power
efficient for others. Setting a low value should filter all idle
states except the polling one

Regards
Vincent
>
> Thanks,
>
>         Ingo
