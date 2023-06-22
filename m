Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96AC7396AA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 07:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjFVFJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 01:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjFVFJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 01:09:31 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C81E9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 22:09:30 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-34226590ee3so100355ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 22:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687410570; x=1690002570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0dL3Hxcf7SMSp3QLMpn96zaMHkKvz5OHPG1qIUrXmo=;
        b=CGi6bEp+PCHMvcmBDevkqa3SfqJjezP3cXbQmLJ8wtnth6qVt+hC02o5hmeGW4qVTr
         AnbkseKKim3xVlm5r+fzrSyqMNL7m1+w/8G5rtAzz22trvi2F21gAPasw6wbKZIVT4re
         NhQZ+aG/tpDy1r9NawG7NNDxxi15uR4b5qKwc+j/NMH3Q3yvsImZ80hhDKk15aKcT7O8
         wJ130MVHSa730l9sIuG3aWT95JpkDuLwVrUtmzgFsJAETB1jEu113PV/9nW2ZQX6jIc2
         2fMYHEVouB5SEviqJS9SuCLuReNm//EUQXqbReA3qRCmjUDN5pZ6heoBfHXnOxXIdGGF
         VYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687410570; x=1690002570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0dL3Hxcf7SMSp3QLMpn96zaMHkKvz5OHPG1qIUrXmo=;
        b=CIP924yTvpp4dj/h/NIO+/HGcON6w8uSp06JW1dA80OIsKW0Xuq5mlJqRQn14I1jOT
         n6lvLjyuMcXU8UyKsm8kJmg3J04tMWtmmVofkj6ztFEYtic7eeURFSvWU8pqzfcZHnKw
         E0S0FFgVK0/x6C9gnBI1Xz+ZeRKCUS5zBjI0TSjIJAnkyZQeFLQ0p0pE7+H9V21nWtmE
         tPH9d4XvBv6SqyItuZXSFhEac0UlBi5KXNiEWev1h1pmeApCwR73uvTZEu5HasLPtbG9
         7U7Z9xb7MZODC4qTlB8h8AdRxg0uqHbtqGkylkTXLjz8aezGfmeCZG61iyhFzh9Maole
         NjLQ==
X-Gm-Message-State: AC+VfDx/EfGzQnena6GYph9Gavip8iCzrZOaYuK81e4vtpjEZZ3vUily
        ysaVXZhmo8ppOzOnjeWuuhK4i2ji6KXQWWBxoWcFVQ==
X-Google-Smtp-Source: ACHHUZ756lU944VW1uzjoMgYCXf03qwkVa2Fu6R0OMIVdXPPTzPkbXuCX8xG+RYFJK2KXWv3tLMZdl0UPbMowXRGg44=
X-Received: by 2002:a05:6e02:1c84:b0:335:62cc:3972 with SMTP id
 w4-20020a056e021c8400b0033562cc3972mr804600ill.19.1687410569961; Wed, 21 Jun
 2023 22:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230620091603.269-1-ravi.bangoria@amd.com> <CAP-5=fXS726wY1taYEYXDz3YZ4ZwxcL+nhh_yNM7rwamMd8mWg@mail.gmail.com>
 <3b0abd4a-6450-c282-65ff-ec0c7df67b03@amd.com>
In-Reply-To: <3b0abd4a-6450-c282-65ff-ec0c7df67b03@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 21 Jun 2023 22:09:18 -0700
Message-ID: <CAP-5=fXfTDY9-uDq2BR2QmTP=-1=4RKRK=dvKmz5CF+oXgz+Eg@mail.gmail.com>
Subject: Re: [PATCH] perf/amd: Prevent grouping of IBS events
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     peterz@infradead.org, acme@kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, bp@alien8.de, x86@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com,
        santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 8:27=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd.co=
m> wrote:
>
> Hi Ian,
>
> On 20-Jun-23 10:14 PM, Ian Rogers wrote:
> > On Tue, Jun 20, 2023 at 2:16=E2=80=AFAM Ravi Bangoria <ravi.bangoria@am=
d.com> wrote:
> >>
> >> IBS PMUs can have only one event active at any point in time. Restrict
> >> grouping of multiple IBS events.
> >
> > Thanks Ravi,
> >
> > can you provide an example/test for this? Should this be a weak group i=
ssue?
>
> Before:
>   $ sudo ./perf record -e "{ibs_op//,ibs_op//}" -C 0
>   ^C[ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.540 MB perf.data (531 samples) ]
>
> After:
>   $ sudo ./perf record -e "{ibs_op//,ibs_op//}" -C 0
>   Error:
>   AMD IBS may only be available in system-wide/per-cpu mode.
>   Try using -a, or -C and workload affinity
>
> The error message is stale and misleading. I have a patch to fix it.
> I'll post it separately.

Thanks Ravi, so this is a workaround for a PMU driver bug where the
perf_event_open should have failed for the sibling event?

The behavior is somewhat reminiscent of arch_evsel__must_be_in_group:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/p=
erf/arch/x86/util/evsel.c?h=3Dperf-tools-next#n41

Normally software events would be valid in the group, should the code
ignore these?

Thanks,
Ian

> Thanks,
> Ravi
