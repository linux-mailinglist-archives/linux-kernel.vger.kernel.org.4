Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7EF64A609
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 18:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbiLLRhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 12:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbiLLRh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 12:37:26 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A964814D37
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 09:36:41 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id f11-20020a5b01cb000000b0070374b66537so13697817ybp.14
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 09:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ot6rJQL1Rzw69bl9jRl78iLkHK/SfMjklkW/EQiP94c=;
        b=JccWdQv4VAyFgzQGAdL6+A3nIm+r2+ibGydTLIO4WAHIyaLwaRiSwtzfoPfzfCp7/k
         6qmsDSrUGI+BArAgHsf59yx74GSi0UNRHubP/IU8lReeKHblMwEp2uLvcwfC9stvnuoh
         9Tt3B24B9lyHr5iLru1gsSEjvj7gC1enij8BziH4Hb3rSCPPT1juAaFuJHk363hrdAPA
         XtJFwGeS/qniBuTq6ULsCFEUrwC5AzLjGdW2HJFvRMZrYPtPdmBz2/ZdaiRGWUQo3a0v
         TsEivJB0JVe79mV1MR7Jza6jPHxCoSs/MytaAsgWuTJN8ppyS9OvAMqDtqpo0dEx/P9L
         bTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ot6rJQL1Rzw69bl9jRl78iLkHK/SfMjklkW/EQiP94c=;
        b=UCY43R7fTFB9wYtmXcrNWcrfY4X86vS6cv4BK1QTNE1iRWCW1CGEK7fwDnS9dusSIW
         EoSOilZTTn/It+lo4WDCk27Yvb0A/T7hUIEmWE7dBj0DEavK4ytN6etzeBVMGwEjPyWl
         WyVL+OfL79oiNzv7RAu/V04SMi0xYW+luCPWwN4eTWhnFxQw8orkwwF/PXiU2jn31GiL
         rD0CFi7U21gsjMTgDGN4rTUuLraV+m+V2/jcMO1Dy+KfSxxT+oBLCu/wH+qogQJ8FKMO
         z4scOuFJibBsXdsB9BBaGu7qzI7dBZffoqFQJPkfnD4HtPfh6yagM6R/+/xJUvu4rUgu
         eOaw==
X-Gm-Message-State: ANoB5pkBOrcUTfnBGBbDfmdxgYY/HMJBIsfhQDUfJKJCzIoqLPVFAtyJ
        hpfJ38x865KLQF5c1d1enyYbvkh96ADOIHiqTg==
X-Google-Smtp-Source: AA0mqf5ht5GF2FoDhmQGRpba9ju47rxJAVAPrCpDMCnv+JhktbgXhuCpXEDild68V1sCsNfqzcGolBBZ6osyQXDOcA==
X-Received: from peternewman10.zrh.corp.google.com ([2a00:79e0:9d:6:f5e8:db2f:ea60:4a62])
 (user=peternewman job=sendgmr) by 2002:a25:34d8:0:b0:6f0:eb40:fca4 with SMTP
 id b207-20020a2534d8000000b006f0eb40fca4mr67687262yba.391.1670866600914; Mon,
 12 Dec 2022 09:36:40 -0800 (PST)
Date:   Mon, 12 Dec 2022 18:36:38 +0100
In-Reply-To: <cdcfcd64-c76f-0d2d-6653-0229c956f2bc@intel.com>
Mime-Version: 1.0
References: <cdcfcd64-c76f-0d2d-6653-0229c956f2bc@intel.com>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221212173638.1858573-1-peternewman@google.com>
Subject: Re: [PATCH v4 1/2] x86/resctrl: Update task closid/rmid with task_call_func()
From:   Peter Newman <peternewman@google.com>
To:     reinette.chatre@intel.com
Cc:     bp@alien8.de, derkling@google.com, eranian@google.com,
        fenghua.yu@intel.com, hpa@zytor.com, james.morse@arm.com,
        jannh@google.com, kpsingh@google.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peternewman@google.com, tglx@linutronix.de,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On Sat, Dec 10, 2022 at 12:54 AM Reinette Chatre <reinette.chatre@intel.com=
> wrote:
> On 12/8/2022 2:30 PM, Peter Newman wrote:
> > Based on this, I'll just sketch out the first scenario below and drop
> > (2) from the changelog. This also implies that the group update cases
>
> ok, thank you for doing that analysis.
>
> > can use a single smp_mb() to provide all the necessary ordering, becaus=
e
> > there's a full barrier on context switch for it to pair with, so I don'=
t
> > need to broadcast IPI anymore. =C2=A0I don't know whether task_call_fun=
c() is
>
> This is not clear to me because rdt_move_group_tasks() seems to have the
> same code as shown below as vulnerable to re-ordering. Only difference
> is that it uses the "//false" checks to set a bit in the cpumask for a
> later IPI instead of an immediate IPI.

An smp_mb() between writing the new task_struct::{closid,rmid} and
calling task_curr() would prevent the reordering I described, but I
was worried about the cost of executing a full barrier for every
matching task.

I tried something like this:

for_each_process_thread(p, t) {
	if (!from || is_closid_match(t, from) ||
	    is_rmid_match(t, from)) {
		WRITE_ONCE(t->closid, to->closid);
		WRITE_ONCE(t->rmid, to->mon.rmid);
		/* group moves are serialized by rdt */
		t->resctrl_dirty =3D true;
	}
}
if (IS_ENABLED(CONFIG_SMP) && mask) {
	/* Order t->{closid,rmid} stores before loads in task_curr() */
	smp_mb();
	for_each_process_thread(p, t) {
		if (t->resctrl_dirty) {
			if (task_curr(t))
				cpumask_set_cpu(task_cpu(t), mask);
			t->resctrl_dirty =3D false;
		}
	}
}

I repeated the `perf bench sched messaging -g 40 -l100000 ` benchmark
from before[1] to compare this with the baseline, and found that it
only increased the time to delete the benchmark's group from 1.65ms to
1.66ms, so it's an alternative to what I last posted.

I could do something similar in the single-task move, but I don't think
it makes much of a performance difference in that case. It's only a win
for the group move because the synchronization cost doesn't grow with
the group size.

[1] https://lore.kernel.org/lkml/20221129111055.953833-3-peternewman@google=
.com/


>
> > faster than an smp_mb(). I'll take some measurements to see.
> >
> > The presumed behavior is __rdtgroup_move_task() not seeing t1 running
> > yet implies that it observes the updated values:
> >
> > CPU 0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPU 1
> > ----- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -----
> > (t1->{closid,rmid} -> {1,1}) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(=
rq->curr -> t0)
> >
> > __rdtgroup_move_task():
> > =C2=A0 t1->{closid,rmid} <- {2,2}
> > =C2=A0 curr <- t1->cpu->rq->curr
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __sch=
edule():
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 rq->curr <- t1
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resct=
rl_sched_in():
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 t1->{closid,rmid} -> {2,2}
> > =C2=A0 if (curr =3D=3D t1) // false
> > =C2=A0 =C2=A0 IPI(t1->cpu)
>
> I understand that the test is false when it may be expected to be true, b=
ut
> there does not seem to be a problem because of that. t1 was scheduled in =
with
> the correct CLOSID/RMID and its CPU did not get an unnecessary IPI.

Yes, this one was reminding the reader of the correct behavior. I can
just leave it out.

-Peter
