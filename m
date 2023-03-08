Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0956B10AE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 19:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCHSL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 13:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjCHSLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 13:11:25 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FDBCE951
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 10:11:23 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id n2so22412356lfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 10:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678299081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUxEuYTDDFPmIiQ52Uj0fWRRHS1cj4kLqmUnBlO9hic=;
        b=k5RClTV1ehgzeGkeqnum3NnxKO1H/40BDWqZdBjT9gFG3JYjQLUI9wg53Qj+4kDgIw
         VDlOpXXx4XW5naIbWEb9Yc3URh87cxpLPeFtVdNCmXMCLSSD13jzdvitgCoaXBmPERgY
         Q+OfEZp4M6/57zNrbtJsnCzc0/NzzcAeq7MR7lB7HtEm4SBTOzWOlOXI6sKzTYhs9Ubt
         aXwsmP9yhamCOVVZAxJmubaI1LRrAiSfQXOZOoLQLJRRYCaq45t3fQOj+onBbFYgbWNf
         A7RGLYUp8dC9BL0td+/hKH/SmLLztGUz0UWebstWtd73kFVJIDGsXSioZw1cI8SoQqNx
         vMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678299081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUxEuYTDDFPmIiQ52Uj0fWRRHS1cj4kLqmUnBlO9hic=;
        b=KQcV0sDg1rzi4yX/5jQBZeY4YRxwmik7ao5hfpOBbu94aQpKEW/MSsdLeoujw8a7EP
         AVuv4e9RLAH1BwLnyR7enoHwIkQUi7U45lWzPCD0dmoZpgfLsPHmiQdgrcx0J5xJRAzH
         R17c00NOsxLBKjX/Rpwqlp8Xux79WMleQH8GR4vTQrgk+rMCUUO1BZjjm2psFbFmKOXc
         qzGfAKJIO7Ip54yVZdDEqYuhvM9tDa50EBO9nRnrAp/IR58EMwQ6zNeTzmXLVmYcBOto
         PlipX+2n2ZjW2sWkhQteiZz0hSnDqnyMBK/v5JfZSjzdylFB+a26SrVuUvxhsI6ee9YI
         zJNQ==
X-Gm-Message-State: AO0yUKX+t05C6CvGCvFS4BE249bClddTXxwm8yPLUsfdvH8oh1CpcUhG
        ZQ748JOe0gksepmn03WP9b+6CqRVFyYEBIUmvdmcXw==
X-Google-Smtp-Source: AK7set+ciaoF3CvEFldkJQhkB3bYSBOlxM7Ibz+FryApaBM+c78Rhjo2mMZ/r9JoT9X0hnFwqmYZ+CKvyL2RUl+4YDY=
X-Received: by 2002:ac2:4893:0:b0:4d5:ca42:aeec with SMTP id
 x19-20020ac24893000000b004d5ca42aeecmr5859794lfc.12.1678299081396; Wed, 08
 Mar 2023 10:11:21 -0800 (PST)
MIME-Version: 1.0
References: <20230206221428.2125324-1-qyousef@layalina.io> <CA+khW7i_Sc0M4FXzojmQ5PSfkPwk6AdcbN9j0gDXZ9FsOMQAwA@mail.gmail.com>
 <f3a99500-e51c-032f-a0c6-01763f0a5be6@redhat.com> <CA+khW7iWAn6bbXdkJX1Lt4dWUsN6o4KqVQ8OFTs0B+VTtVjBkw@mail.gmail.com>
 <1f2cf8ea-a9d7-5245-0f69-eb8be9f64afc@redhat.com> <CA+khW7jQg6x_j70eARVF0eemP0txU_K9Lc=5kfBmU_KxsfbK2w@mail.gmail.com>
 <315efe55-abaf-c199-673b-95ef76a1e442@redhat.com>
In-Reply-To: <315efe55-abaf-c199-673b-95ef76a1e442@redhat.com>
From:   Hao Luo <haoluo@google.com>
Date:   Wed, 8 Mar 2023 10:11:07 -0800
Message-ID: <CA+khW7hdE=j58R3S8R1iARL9Pd4L_dOVyGLGeDTCukxRiuytBQ@mail.gmail.com>
Subject: Re: [PATCH v3] sched: cpuset: Don't rebuild root domains on suspend-resume
To:     Waiman Long <longman@redhat.com>
Cc:     Qais Yousef <qyousef@layalina.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, tj@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Zefan Li <lizefan.x@bytedance.com>, linux-s390@vger.kernel.org,
        x86@kernel.org
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

On Tue, Mar 7, 2023 at 6:30=E2=80=AFPM Waiman Long <longman@redhat.com> wro=
te:
>
> On 3/7/23 17:17, Hao Luo wrote:
> > On Tue, Mar 7, 2023 at 1:13=E2=80=AFPM Waiman Long <longman@redhat.com>=
 wrote:
> >> On 3/7/23 16:06, Hao Luo wrote:
> >>> On Tue, Mar 7, 2023 at 12:09=E2=80=AFPM Waiman Long <longman@redhat.c=
om> wrote:
> >>>> On 3/7/23 14:56, Hao Luo wrote:
<...>
> >>>>> Hi Qais,
> >>>>>
> >>>>> Thank you for reporting this. We observed the same issue in our
> >>>>> production environment. Rebuild_root_domains() is also called under
> >>>>> cpuset_write_resmask, which handles writing to cpuset.cpus. Under
> >>>>> production workloads, on a 4.15 kernel, we observed the median late=
ncy
> >>>>> of writing cpuset.cpus at 3ms, p99 at 7ms. Now the median becomes
> >>>>> 60ms, p99 at >100ms. Writing cpuset.cpus is a fairly frequent and
> >>>>> critical path in production, but blindly traversing every task in t=
he
> >>>>> system is not scalable. And its cost is really unnecessary for user=
s
> >>>>> who don't use deadline tasks at all.
> >>>> The rebuild_root_domains() function shouldn't be called when updatin=
g
> >>>> cpuset.cpus unless it is a partition root. Is it?
> >>>>
> >>> I think it's because we were using the legacy hierarchy. I'm not
> >>> familiar with cpuset partition though.
> >> In legacy hierarchy, changing cpuset.cpus shouldn't lead to the callin=
g
> >> of rebuild_root_domains() unless you play with cpuset.sched_load_balan=
ce
> >> file by changing it to 0 in the right cpusets. If you are touching
> >> cpuset.sched_load_balance, you shouldn't change cpuset.cpus that often=
.
> >>
> > Actually, I think it's the opposite. If I understand the code
> > correctly[1], it looks like rebuild_root_domains is called when
> > LOAD_BALANCE _is_ set and sched_load_balance is 1 by default. Is that
> > condition a bug?
> >
> > I don't think we updated cpuset.sched_load_balance.
> >
> > [1] https://github.com/torvalds/linux/blob/master/kernel/cgroup/cpuset.=
c#L1677
>
> The only reason rebuild_root_domains() is called is because the the
> scheduling domains were changed. The cpuset.sched_load_balance control
> file is 1 by default. If no one touch it, there is just one global
> scheduling domain that covers all the active CPUs. However, by setting
> cpuset.sched_load_balance to 0 in the right cpusets, you can create
> multiple scheduling domains or disabling load balancing on some CPUs.
> With that setup, changing cpuset.cpus in the right place can cause
> rebuild_root_domains() to be called because the set of scheduling
> domains are changed.
>

Thanks Longman for the explanation.

I believe we don't touch cpuset.sched_load_balance, so I don't know
what's wrong for now. But I've taken note and will go back to debug
further and see if there is any setup that needs to be fixed in our
system.

Hao
