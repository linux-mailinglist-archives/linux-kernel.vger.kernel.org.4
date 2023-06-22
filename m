Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796D07396F0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 07:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjFVFo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 01:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjFVFou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 01:44:50 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9374F1996
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 22:44:49 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-34226590ee3so108335ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 22:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687412689; x=1690004689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ql/t9VRdhGArqTlyfNwWjkzUrOPBG+jlwduBESJYm00=;
        b=4qRBOUdcM8O7EsT8IwxdbpRpfIoqXkX2O4pL32iKnGl6/s8PJudz8hSGJiTvvRmZFs
         RyyZTzmTIak2kDLS8yaAtSC6c1fE4qOjgMAxQ0MHxCyXlB8lTbJMqlqWYHae9FjFw05I
         y6nB6sG2fqJ17S3rZoeZCCopxs4xn3TrHoG1SGwg+e3zoNaCl+w48uE9pQ4mD6i2QiZX
         R3DkofZt4XGpWg3hkXEnuoXYBBO27XcLmn9h3RRqMzh65casfrhqUKwasgAGO8ZI5nsI
         vUPtbROa6NtrWwrUYMbsAU7IsaNyD1oN0VsVYWrr2DsLklAPSPhr5HGeutaINgL5dCTw
         RIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687412689; x=1690004689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ql/t9VRdhGArqTlyfNwWjkzUrOPBG+jlwduBESJYm00=;
        b=MhWFJwuw44smWvghmfI/pJJWnlyYc0nxqVNGCK8GXHt7817qTEFk0wbDET+0ArlMyF
         +dDoL8+CXbYslPuO46IbSO/Ywp4V53k7awc7UPFp9IKzuYyvTwhTc8j+Pvpe62LwOmvt
         bCrWoGNTq74hmIr2QPsdVXBQ/F/F0LdPwgY+0KgYR2XMLS500c1RR+kl2yo7L54f2GqK
         XRE0SAEZckdOuHbwGtfxW6kVE9lh54lUCbliZ/wNW+gA/GcjK+DyWFjXpkuKmWf8rO5t
         RsKmOFkAYUgL4g+hXdUAn5sS/Ox948d26MRp90SHXvBMV7YSoPGiZCEzo2+XUiGeGqK1
         3y2A==
X-Gm-Message-State: AC+VfDxsXM6eQyuonqIK7Zf7WMsH/wdZeZtw2pR5MQEh80Ii51RHnCzr
        rY5io4eN/RCya3w2SxaSrp3nq6HRQ3CMP1Ta0ZWlzLj2u9FsHytHrQo=
X-Google-Smtp-Source: ACHHUZ6Nt9K7fAIEFVoOVZRcP88K3VtDYiLWejg8zBXOcT/9hMh1Zb+76Bz4irFA113JtBg9ikCfoZneLyYI3oCCNLo=
X-Received: by 2002:a05:6e02:178f:b0:33a:e716:a76f with SMTP id
 y15-20020a056e02178f00b0033ae716a76fmr1395715ilu.29.1687412688900; Wed, 21
 Jun 2023 22:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230620091603.269-1-ravi.bangoria@amd.com> <CAP-5=fXS726wY1taYEYXDz3YZ4ZwxcL+nhh_yNM7rwamMd8mWg@mail.gmail.com>
 <3b0abd4a-6450-c282-65ff-ec0c7df67b03@amd.com> <CAP-5=fXfTDY9-uDq2BR2QmTP=-1=4RKRK=dvKmz5CF+oXgz+Eg@mail.gmail.com>
 <515f3ad1-3e2e-7c59-5005-1ce6ad83364c@amd.com>
In-Reply-To: <515f3ad1-3e2e-7c59-5005-1ce6ad83364c@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 21 Jun 2023 22:44:37 -0700
Message-ID: <CAP-5=fX3q8eS5yPK2RHFeLDH2LReaiaCOzTQrk+9wsQxZ1g34w@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:39=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd.c=
om> wrote:
>
> Hi Ian,
>
> >> Before:
> >>   $ sudo ./perf record -e "{ibs_op//,ibs_op//}" -C 0
> >>   ^C[ perf record: Woken up 1 times to write data ]
> >>   [ perf record: Captured and wrote 0.540 MB perf.data (531 samples) ]
> >>
> >> After:
> >>   $ sudo ./perf record -e "{ibs_op//,ibs_op//}" -C 0
> >>   Error:
> >>   AMD IBS may only be available in system-wide/per-cpu mode.
> >>   Try using -a, or -C and workload affinity
> >>
> >> The error message is stale and misleading. I have a patch to fix it.
> >> I'll post it separately.
> >
> > Thanks Ravi, so this is a workaround for a PMU driver bug where the
> > perf_event_open should have failed for the sibling event?
>
> This is not a workaround. This kernel patch fixes PMU driver bug. With
> the patch, perf_event_open() will fail for sibling IBS event if either
> group leader or any other sibling is of the same IBS pmu. Or did I
> misread your comment?
>
> >
> > The behavior is somewhat reminiscent of arch_evsel__must_be_in_group:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/too=
ls/perf/arch/x86/util/evsel.c?h=3Dperf-tools-next#n41
> >
> > Normally software events would be valid in the group, should the code
> > ignore these?
>
> Grouping of SW and IBS event will continue to work after this patch.

Sorry Ravi, I've got my head in the clouds. I was reading this as a
tools patch :-)

Thanks,
Ian

> Thanks,
> Ravi
