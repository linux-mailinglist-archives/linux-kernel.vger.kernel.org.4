Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59256D0FDD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 22:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjC3URd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 16:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjC3URb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 16:17:31 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5DAD53B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 13:17:27 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id p203so25030611ybb.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 13:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680207446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gzh6eI1GYxdNdH+4rpYvp9dduxXVCoivN5HMe4ZBEcs=;
        b=UpGdDentEB0loG38lw9t1HqyDxw0B/PKmgViCi/O2YJRQtC0WFl8tCojsLji2dzhqU
         qQrtxoeuhfLx2ZikK0T+Kn6yuD/RyVxTi8dgfoRH7S3gO0MuEwmO7As+sOPC+YM9PKyL
         jeutGkXIbhmS09f9NUD2p1JkJLfC/GRXwnqC5ok/KQO3GUQJfkWbSEvIJuqnoGY32ita
         rHXa9ATFofPvAW0zsOVVYUsmvnRuuh5KxgXJbjodFRmf8TsaF175e1aMhLHj0AXZQvZt
         VtdCZDB9MMxyaCOIIVpiEmygaAclV5Zf9SA+oaDa7NkLAYbYH+ps5MRf1DcjUmkXhXmQ
         je3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680207446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gzh6eI1GYxdNdH+4rpYvp9dduxXVCoivN5HMe4ZBEcs=;
        b=3G1FGOPHVW9BqTc5EAz/cY1pzjvUC6m146ExfZJ0f5eWh8/5FLMf8kKvDvYY6r8q4A
         1XtpOFgodobrjKzROkhrIVVzOcWK3aOZdmY9/jSMkT5gJOnAtVo9MMpGqIBWya8d+xNd
         RAiU29UTnPFBuLzqFtMGbErcjAclVd1sTnq5E4YjCZdqIKM5NIgo+bNNpupEDcVqPJrw
         FvZqHwceiDyf8f7fpifJxJkV7ail6ahz84d72nf8Wux2v7OsAHdU7Q1MiXHKIhA4m+z5
         LDTO6b5Cc7pjnfIyvhysIIP4R1UJMSSEcDwou+7U08ek3KkAGMn6IK7/dPqjZcCjRkrD
         BMxw==
X-Gm-Message-State: AAQBX9dt0GAYNeJDs+dLKH7AuIqTHe5y55Hfl1byNbkGMGKtG3/XHwK7
        pTomVT88yOHQXzEZdMWk3x22MnDZcJYAbrHiLtSvehSCXhB91vvwqhLVlg==
X-Google-Smtp-Source: AKy350a/hRLfpI4hUXINP4+CnKP31C4Bf+8Wp9DUuqP9pQCMEvX6i7imax2gDovTaP0NPJXrcAy6nNbWuSQHKyFAl7E=
X-Received: by 2002:a25:2749:0:b0:a99:de9d:d504 with SMTP id
 n70-20020a252749000000b00a99de9dd504mr16211798ybn.12.1680207445985; Thu, 30
 Mar 2023 13:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230330200614.132354-1-cerasuolodomenico@gmail.com>
In-Reply-To: <20230330200614.132354-1-cerasuolodomenico@gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 30 Mar 2023 13:17:15 -0700
Message-ID: <CAJuCfpGY6=byoSQqNUc9cXHFAdhnY9HGScc+aT9D9qbhGBEu3A@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] sched/psi: Allow unprivileged PSI polling
To:     Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        brauner@kernel.org, chris@chrisdown.name, hannes@cmpxchg.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 1:06=E2=80=AFPM Domenico Cerasuolo
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
>
> The series is implemented in 4 steps in order to reduce the noise of
> the change.

Thanks! For the entire series
Acked-by: Suren Baghdasaryan <surenb@google.com>

>
> V7:
> - fix code style in psi trigger create/destroy aggregators paths
>
> V6:
> - fix trigger creation logic now using proper locks
>
> V5:
> - few suggested code style changes in psi.c and psy_types.h
> - fix trigger destruction logic now using proper locks
>
> V4:
> - fixed psi_open leftover usage in IRQ accounting (patch 4/4)
>
> V3:
> - restored renaming patch (#2 of 4) as suggested in review
> - rebased #3 and #4 on the renaming commit
>
> V2:
> - removed renaming patch (previous 2/4) and applied suggested solution
> - changed update_triggers side effect removal as suggested in review
> - rebased core patch on other V2 changes
>
> Domenico Cerasuolo (4):
>   sched/psi: rearrange polling code in preparation
>   sched/psi: rename existing poll members in preparation
>   sched/psi: extract update_triggers side effect
>   sched/psi: allow unprivileged polling of N*2s period
>
>  Documentation/accounting/psi.rst |   4 +
>  include/linux/psi.h              |   2 +-
>  include/linux/psi_types.h        |  43 +--
>  kernel/cgroup/cgroup.c           |   2 +-
>  kernel/sched/psi.c               | 443 +++++++++++++++++--------------
>  5 files changed, 276 insertions(+), 218 deletions(-)
>
> --
> 2.34.1
>
