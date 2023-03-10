Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B666B3A80
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjCJJbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjCJJbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:31:19 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93C17DF91
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:28:47 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id l18so5055494qtp.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678440526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZdy1P0udAVGBEEd8jG6Z8VoqMNmC2jFqJ+/rO79irE=;
        b=hBoWSQxXZavr/bzcwRGuJs6ela9Gpp/99bp2sG4/TAlA4P0HB4/+7toBSTm4fifGZr
         qGRCpAGcLpeNN3kQ+FpTAHHKI5G7nIaeinncywb69w+yYkUKS9UYXep3yrXA7N8wl4x5
         BonBtWu3kAyCZJW3lcE40PA1nMF+iU7WLn+kHNA9Dp2CC7/IEnGq69E5NHWpUqS+wUIl
         tAe3tE3IFQAJsSpHxCDew/cVrM9NQSdPIJkky7bt0lU6Zb07HLEZTJhuOVRJwquw77o/
         eFAsRKNtq8y47tuzz4UDm0GCzz1ljfse5ImTfj9AQQLO3LojsF3C2XWnGd6Dpy51lDxU
         9zMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678440526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZdy1P0udAVGBEEd8jG6Z8VoqMNmC2jFqJ+/rO79irE=;
        b=I3N195PrweFEET9R9SlJit2NxMU2s513SH6B21DtmSZoIiDIkaMG+5duczutLxjvz6
         dCuDiV1gz5P4n2AD9W03kRK8vyjuaYdfJWOgE46DmD9c2kx5Gv5nk+z3/rleKI5zgnf2
         cCtdMbR1ROS9HrYEI8fPkYOq8ZgnzWAk8tNK1MdAQanNoDX0DaiB6rnETkq3ERu/cH7t
         +Rr8+d2H41SnWSJlgsKbY4c5XoNmRFC1hTINlzXhjASZRi7X52JHlDD+VN9rv5o48q7M
         7OZdoxIGGhsGuHEmCk2FqfvK405rrB6H5rLF2KbZQ2P7znSSkMRNFz+oV+i7LxZrm5h6
         03og==
X-Gm-Message-State: AO0yUKW0U7toz2GjnMEtY+M6IP36lNRjqOJHJ+pZRQ1Hh8fzpRi6PxH1
        QhaVphf2jZStC5T1J6NDEWPOgmkfLMQQbp0K/97AmJKKDT2YLAsiiTWt39yw
X-Google-Smtp-Source: AK7set8SI6hqiihFH9OfdhL0vFvBV/9qw/caFH3w5z4HbTMUjYRtF7WqrmH5Rgr8cODmG8iGcxY022/07zKT6HE+Mtc=
X-Received: by 2002:ac8:410c:0:b0:3c0:3c09:a4a3 with SMTP id
 q12-20020ac8410c000000b003c03c09a4a3mr3512358qtl.6.1678440526500; Fri, 10 Mar
 2023 01:28:46 -0800 (PST)
MIME-Version: 1.0
References: <20230113175459.14825-1-james.morse@arm.com> <20230113175459.14825-10-james.morse@arm.com>
 <CALPaoCg4T52ju5XJC-BVX-EuZUtc67LruWbgyH5s8CoiEwOUPw@mail.gmail.com>
 <c3ca6d66-e58c-8ace-e88e-45ded5de836f@arm.com> <CALPaoCik0j7ATCv-He5HWVqbL+3njpqO1fhF5FQJO7qqT1zR3w@mail.gmail.com>
 <c8d85eae-e291-99a6-509c-94c41514ac16@arm.com> <CALPaoCgEaT2oax35ezRydUZwL9bMmMFFr2wRqPe4VYAnEQ-GGg@mail.gmail.com>
 <f8a25b5f-4a7d-0891-1152-33f349059b5d@arm.com>
In-Reply-To: <f8a25b5f-4a7d-0891-1152-33f349059b5d@arm.com>
From:   Peter Newman <peternewman@google.com>
Date:   Fri, 10 Mar 2023 10:28:35 +0100
Message-ID: <CALPaoCim-QkHbm=dXzpfh1N5mx-4u=d21SUrjnBk2OU=R4apbA@mail.gmail.com>
Subject: Re: [PATCH v2 09/18] x86/resctrl: Allow resctrl_arch_rmid_read() to sleep
To:     James Morse <james.morse@arm.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        Stephane Eranian <eranian@google.com>
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

Hi James,

On Thu, Mar 9, 2023 at 6:35=E2=80=AFPM James Morse <james.morse@arm.com> wr=
ote:
> On 09/03/2023 13:41, Peter Newman wrote:
> > However, I do want to be sure that MBWU counters will never be silently
> > deallocated because we will never be able to trust the data unless we
> > know that the counter has been watching the group's tasks for the
> > entirety of the measurement window.
>
> Absolutely.
>
> The MPAM driver requires the number of monitors to match the value of
> resctrl_arch_system_num_rmid_idx(), otherwise 'mbm_local' won't be offere=
d via resctrl.
> (see class_has_usable_mbwu() in [0])
>
> If the files exist in resctrl, then a monitor was reserved for this PARTI=
D+PMG, and won't
> get allocated for anything else.
>
>
> [0]
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?h=
=3Dmpam/snapshot/v6.2&id=3Df28d3fefdcf7022a49f62752acbecf180ea7d32f
>
>
> > Unlike on AMD, MPAM allows software to control which PARTID+PMG the
> > monitoring hardware is watching. Could we instead make the user
> > explicitly request the mbm_{total,local}_bytes events be allocated to
> > monitoring groups after creating them? Or even just allocating the
> > events on monitoring group creation only when they're available could
> > also be marginably usable if a single user agent is managing rdtgroups.
>
> Hmmmm, what would that look like to user-space?
>
> I'm against inventing anything new here until there is feature-parity whe=
re possible
> upstream. It's a walk, then run kind of thing.
>
> I worry that extra steps to setup the monitoring on MPAM:resctrl will be =
missing or broken
> in many (all?) software projects if they're not also required on Intel:re=
sctrl.
>
> My plan for hardware with insufficient counters is to make the counters a=
ccessible via
> perf, and do that in a way that works on Intel and AMD too.

In the interest of enabling MPAM functionality, I think the low-effort
approach is to only allocate an MBWU monitor to a newly-created MON or
CTRL_MON group if one is available. On Intel and AMD, the resources are
simply always available.

The downside on monitor-poor (or PARTID-rich) hardware is the user gets
maximually-featureful monitoring groups first, whether they want them or
not, but I think it's workable. Perhaps in a later change we can make an
interface to prevent monitors from being allocated to new groups or one
to release them when they're not needed after group creation.

At least in this approach there's still a way to use MBWU with resctrl
when systems have more PARTIDs than monitors.

This also seems like less work than making resctrl able to interface
with the perf subsystem.

-Peter
