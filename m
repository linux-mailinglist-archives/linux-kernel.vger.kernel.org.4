Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7349A6B7BF1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjCMP35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCMP3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:29:54 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF08C6C1A1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:29:49 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-536af432ee5so249612897b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 08:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678721389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5eD97Va3Z+wOXMeE5OCoBSmkVVjvmlNvaKRDMDBXZM=;
        b=iCSQvxft5IiwgnYeKGiv3Q0+DZL6ndBF29jN35kzFRvFCWg0UEcARx0MvfXZ9Qqbyn
         BZgkGUnS/36Rw5gNbq/cL+5HF7De8f6YLiGzDzEfZrSjRVldPHTW9iaaLo3fIfhOikiK
         ukyAt0o73ZyLTU4RzXID82GAvjeaPcZ5nIbDxg4zLDbMeYllZEXfD2kf82jXWleZmqyy
         /MgI6JpbZE2Di4W937HPfLeS9It/ZJx6bQbDH6MwLeTXG1gA8R0J6BJLUs1ig+K7Lqbo
         CoyoO+Sutr2riL+Ont8IW1VGBfq3irhv4LMP4A6HIG3Ihm1dPl2zr4IzKruRYnkccQvT
         qT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678721389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5eD97Va3Z+wOXMeE5OCoBSmkVVjvmlNvaKRDMDBXZM=;
        b=4EUSsZMEce4aT2t+bqnNR29TNZGYWvvIRT4IN0em10K+qrEDOvgQUNCc53EwdRjoM+
         a7R8QZbX4/6pacwOnELQ97xyAJLkxyWOFGGGEzwHjYDf1llbmF27n2bPQX7hWO+W6X3q
         IHoBjUoDiW8wPDu01UYkPAAAY+lNt+M2/vVt7nmCKccOynKzRtTb6+XWaXQkpal6DaIb
         SWe9YHeHm8VrWOfbyN5YxigYgnHxJHQCY3I4KKNrIvQdWCtdafq1qJmEqdERZSegyVzU
         ndaqkYzNwtKBDxNvQJTBjcnuP5LH+1Om+O3Auwtgswy7DJsY55ewH1bUO2P+FxNbXYVz
         w8lw==
X-Gm-Message-State: AO0yUKWgGW/rMps5pRfdYFUH0GpF86Kpl9mNliaBrutRzNZM5VpygpOt
        Gfdh1wpQhYoljaQSd9R1AirbCwQiWUIKR95lmHqjob8qXsnmCyNVfa9FTA==
X-Google-Smtp-Source: AK7set9+hUPKLf0fUMyNc4HbYACQLQ7gwjYye7VeEH9QOgjcdZzNIORa13f2MWMX+57/laBFRhmL3CcPCz4VqOlHsFE=
X-Received: by 2002:a81:a947:0:b0:535:be11:5fe0 with SMTP id
 g68-20020a81a947000000b00535be115fe0mr22178076ywh.1.1678721388834; Mon, 13
 Mar 2023 08:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230309170756.52927-1-cerasuolodomenico@gmail.com>
In-Reply-To: <20230309170756.52927-1-cerasuolodomenico@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 13 Mar 2023 08:29:37 -0700
Message-ID: <CAJuCfpGYrnCoAn+bUdcEZ3OS+5ujDp2iUNXBMRacxNGbJvCY-w@mail.gmail.com>
Subject: Re: [PATCH 0/4] sched/psi: Allow unprivileged PSI polling
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        brauner@kernel.org, chris@chrisdown.name, hannes@cmpxchg.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Mar 9, 2023 at 9:08=E2=80=AFAM Domenico Cerasuolo
<cerasuolodomenico@gmail.com> wrote:
>
> PSI offers 2 mechanisms to get information about a specific resource
> pressure. One is reading from /proc/pressure/<resource>, which gives
> average pressures aggregated every 2s. The other is creating a pollable
> fd for a specific resource and cgroup.
>
> The trigger creation requires CAP_SYS_RESOURCE, and gives the
> possibility to pick specific time window and threshold, spawing an RT
> thread to aggregate the data.
>
> Systemd would like to provide containers the option to monitor pressure
> on their own cgroup and sub-cgroups. For example, if systemd launches a
> container that itself then launches services, the container should have
> the ability to poll() for pressure in individual services. But neither
> the container nor the services are privileged.

This sounds like an interesting usecase. I'll need to take a closer
look once I'm back from vacation later this week.
Thanks!

>
> The series is implemented in 4 steps in order to reduce the noise of
> the change.
>
> Domenico Cerasuolo (4):
>   sched/psi: rearrange polling code in preparation
>   sched/psi: rename existing poll members in preparation
>   sched/psi: extract update_triggers side effect
>   sched/psi: allow unprivileged polling of N*2s period
>
>  Documentation/accounting/psi.rst |   4 +
>  include/linux/psi.h              |   2 +-
>  include/linux/psi_types.h        |  43 ++--
>  kernel/cgroup/cgroup.c           |   2 +-
>  kernel/sched/psi.c               | 412 ++++++++++++++++---------------
>  5 files changed, 250 insertions(+), 213 deletions(-)
>
> --
> 2.34.1
>
