Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7045A6A5EA5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 19:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjB1SSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 13:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB1SS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:18:28 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B14A12BDF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 10:18:27 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-536bf92b55cso296958437b3.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 10:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nj6X1WFHRdI4Q3AACCYDVRthftHhlUj7/xsgAqZmpTE=;
        b=VzVc+FOzu3EA9RqZ2Ogek7DJf+5Nuk82z84HRnwmtj9XXm7Zg8X8ri5+mz5JPpWui9
         G7Y3N7bH21wwGcVU9F1QJFU859TajgSUFYoy/dUCAjIKJM7Hb4Z57uwjROuQiT6S1lAl
         LSiy5FKv1SCvbsAo+N3olCxuSsIh260mnCu0ClyVl3gJybcxgh5oGpqVIZFw08oU2ql4
         XrQxakcJVpeFAQVaebDGXZ0d7NjS+JlRnLtTgeo0vndRmFp+f6mKdna8rCdimXi2RKlp
         mToRVwBts4sQC8jdaclhoCol9v68xN8n99wY7i/kDwrZ5Z9Eyigv209Fn47NrTaqvHWa
         3jZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nj6X1WFHRdI4Q3AACCYDVRthftHhlUj7/xsgAqZmpTE=;
        b=PuK4s/8a/jqfgigmctnCXf+BM8KO0oTBzSJpUX4ZulzJxmE2/P06HO7jcI47IWesME
         JRqZg8djzN+Ci/Az0ymgJ5wkdxARB76JooJkTBkRwmkouwuQcaX8dVBfHVWXBorpMiPa
         cCZgkGFdbySIFzOM3uHN56pnBxWdkssdjlvz21nNKBDRDBfnXvyIb71z8kdqG58BffoL
         AcCvHpHQt8kVGbOxoBa1kwAj2ow2ikUAmcFO8AYNpn9Y6M+GoGjZeZxuRJc81dl8x5rB
         9eMm2EJVE4zLe6bIxX/hBb/XBOqxU+Mf/DSz6yr688Lh3rPmMXLmLMlmML7syFNZeZ5a
         MXOQ==
X-Gm-Message-State: AO0yUKWnBLibJSoNGESXa/lAiTSRWyTDItkGo4fFYJtiKxgANdoxdYY3
        /SEv8UBuRxn1dqc5xgXlKCHp5E8PcMrjxDGpOPwjaA==
X-Google-Smtp-Source: AK7set+h441uSD8tE7ssieD6grOzuvX0CQcfyGDf9K675mXyrakvaqVHxVlGfEUkdlqyr6sV2Oe2uZEkEKfLkjMm+F8=
X-Received: by 2002:a81:3e0f:0:b0:52e:f66d:b70d with SMTP id
 l15-20020a813e0f000000b0052ef66db70dmr2257709ywa.0.1677608306372; Tue, 28 Feb
 2023 10:18:26 -0800 (PST)
MIME-Version: 1.0
References: <15cd8816-b474-0535-d854-41982d3bbe5c@quicinc.com>
 <CAJuCfpHihLgHCcsAqMJ_o2u7Ux9B5HFGsV2y_L2_5GXYAGYLnw@mail.gmail.com>
 <82406da2-799e-f0b4-bce0-7d47486030d4@quicinc.com> <CAJuCfpHrhO7_fMwNuu2hdQob=MPjZTW8eaJpNhEhPmDMqz2qTA@mail.gmail.com>
 <Y/ix53x8i/ViuBXf@dhcp22.suse.cz> <CAJuCfpG1c5v6qOotPV6t-o1T1p7EbOLs90eFnoEBjts+gafovA@mail.gmail.com>
 <Y/yxSqhpQh9yR7L4@dhcp22.suse.cz> <CAJuCfpHXwbtjdhH_K9r28-LUYtzC6+NaZ+RrKCtiNBk8PfXhLw@mail.gmail.com>
 <Y/0ASztGOwfM6bNK@dhcp22.suse.cz> <CAJuCfpHYMR6O_uJvaeq1f+ZvgW9oN6zTRG=UvTXyLJLSFOV3jw@mail.gmail.com>
 <Y/4GvIMtjVoEozWE@dhcp22.suse.cz>
In-Reply-To: <Y/4GvIMtjVoEozWE@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 28 Feb 2023 10:18:15 -0800
Message-ID: <CAJuCfpEn-W5ffO7sEJPpu3TXeqK-XE1+TTVNnWcTcDBuoNUhGA@mail.gmail.com>
Subject: Re: [PATCH] psi: reduce min window size to 50ms
To:     Michal Hocko <mhocko@suse.com>
Cc:     Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        mark.rutland@arm.com, will@kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Sukadev Bhattiprolu <quic_sukadev@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Patrick Daly <quic_pdaly@quicinc.com>, johunt@akamai.com
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

On Tue, Feb 28, 2023 at 5:50 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 27-02-23 11:50:48, Suren Baghdasaryan wrote:
> > On Mon, Feb 27, 2023 at 11:11 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 27-02-23 09:49:59, Suren Baghdasaryan wrote:
> > > > On Mon, Feb 27, 2023 at 5:34 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Fri 24-02-23 13:07:57, Suren Baghdasaryan wrote:
> > > > > > On Fri, Feb 24, 2023 at 4:47 AM Michal Hocko <mhocko@suse.com> wrote:
> > > [...]
> > > > > > > Btw. it seems that there is is only a limit on a single trigger per fd
> > > > > > > but no limits per user so it doesn't sound too hard to end up with too
> > > > > > > much polling even with a larger timeouts. To me it seems like we need to
> > > > > > > contain the polling thread to be bound by the cpu controller.
> > > > > >
> > > > > > Hmm. We have one "psimon" thread per cgroup (+1 system-level one) and
> > > > > > poll_min_period for each thread is chosen as the min() of polling
> > > > > > periods between triggers created in that group. So, a bad trigger that
> > > > > > causes overly aggressive polling and polling thread being throttled,
> > > > > > might affect other triggers in that cgroup.
> > > > >
> > > > > Yes, and why that would be a problem?
> > > >
> > > > If unprivileged processes are allowed to add new triggers then a
> > > > malicious process can add a bad trigger and affect other legit
> > > > processes. That sounds like a problem to me.
> > >
> > > Hmm, I am not sure we are on the same page. My argument was that the
> > > monitoring kernel thread should be bound by the same cpu controller so
> > > even if it was excessive it would be bound to the cgroup constrains.
> >
> > Right. But if cgroup constraints are violated then the psimon thread's
> > activity will be impacted by throttling. In such cases won't that
> > affect other "good" triggers served by that thread even if they are
> > using higher polling periods?
>
> That is no different from any other part of the workload running within
> the same cpu bound cgroup running overboard with the cpu consumption. I
> do not see why psimon or anything else should be any different.
>
> Actually the only difference here is that the psi monitoring is
> outsourced to a kernel thread which is running ourside of any constrains.
> I am not sure where do we stand with kernel thread cpu cgroup accounting
> and I suspect this is not a trivial thing to do ATM. Hence longer term
> plan.

Yeah, that sounds right.
In the meantime I think the prudent thing to do is to add
CAP_SYS_RESOURCE check for cgroup interface for consistency with
system-wide one. After that we can change the min period to be
anything more than 0 and let userspace privileged services implement
policies to limit trigger cpu consumption (might be via cpu
controller, limiting the number of triggers/their periods, etc).
Sudarshan, I'll post the CAP_SYS_RESOURCE change shortly and you can
follow up with the change to the min trigger period.
Thanks for the input folks!

> --
> Michal Hocko
> SUSE Labs
