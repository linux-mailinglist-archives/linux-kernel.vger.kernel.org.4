Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465A16D8AB5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 00:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjDEWmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 18:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjDEWmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 18:42:42 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C39319BE
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 15:42:41 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m8so10797898wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 15:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680734559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/29UQfyPK3649jjW1z4gzpOB3plh282v3gXxQIKHoic=;
        b=cxYpBjvEDKBSZZxyHcOrN9u2sjx2SZnjmdun+7EIfLHZGq/zrpf5N9wSeFjOanWILc
         ed/DuOgRuNughqhp1zBSy4GfBY5QE3sruTOIKfcysLp1Io4SrTMV/6Y00exVqreoS8XQ
         6J1i7atnk3uwr8cw1o/c8Cy/7RNmRJGi+sRG20knECzoUdEyMaFyD0G6ueBAFvq5HZgj
         J6n82StK5ZgKcSEErJDmV5gHI4PhKVRdJsojQKcVXLfGypu7tima8tli1+EU0mD6f1d/
         UtY9Gld03Yf6r1XGy9dw3C06eQZILu8kp3S3ApZJYcAcqZAtaiRTsa/JMJ+q6Kd3IBJ4
         sBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680734559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/29UQfyPK3649jjW1z4gzpOB3plh282v3gXxQIKHoic=;
        b=LS99iFKUIRBImvllabyafK6UGWE2/qApX94MB+sN8OpCc/hbH7fHUzMMb1QSq4Xzuw
         JW9/qYVqt1kAULhwDlDLofORkawebipdJFh+8qar/DmE0uBrNtN6kQx1FX0IoICuSflS
         yHPOPAUZDMQrUQS4obPl7KcxXuuMki31uYsEdFOF370BRFruTx9Sed9dcSFsLnZMvjdK
         Lt+1wXs/qsOkD2RJKH2ZoGj/kFHeE2R0/D2vYZ0aKiRpslFCyrkLWEyCmMcziextUL4T
         mnRosUVkgd7lvBpuBBtTEWexrz4pKR0NWpHNJWIZKukzkxB0gF6jBuY0OVizwcjwQ3up
         xczA==
X-Gm-Message-State: AAQBX9fDMpe8JgA8dcjaFHO0Ihdx7ZKEcv8vnIEAOw9UYson63AZcmgI
        kLW1OGfCft7s/zPtbI040xJGEI5AfUEJ+cNN0BqBaQ==
X-Google-Smtp-Source: AKy350YPcYo5SaGc+cl+7YaUouqwMxNCd7dhGQkFBjylvDdYFoz5FtXw5nJElgAypJ5bkJqqE2B6IpqnpeTHFR+ws44=
X-Received: by 2002:a1c:f309:0:b0:3ed:605f:23e0 with SMTP id
 q9-20020a1cf309000000b003ed605f23e0mr2004853wmq.3.1680734559462; Wed, 05 Apr
 2023 15:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230330224348.1006691-1-davidai@google.com> <20230330224348.1006691-7-davidai@google.com>
 <20230405082256.GY4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230405082256.GY4253@hirez.programming.kicks-ass.net>
From:   David Dai <davidai@google.com>
Date:   Wed, 5 Apr 2023 15:42:28 -0700
Message-ID: <CABN1KCJ0Tk5ah33zKpksq4Ftqa8Eh+V3bGZRMRAv-XrmakT1Og@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] cpufreq: add kvm-cpufreq driver
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
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

On Wed, Apr 5, 2023 at 1:23=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Thu, Mar 30, 2023 at 03:43:41PM -0700, David Dai wrote:
>
> > +struct remote_data {
> > +     int ret;
> > +     struct cpufreq_frequency_table *table;
> > +};
> > +
> > +static void remote_get_freqtbl_num_entries(void *data)
> > +{
> > +     struct arm_smccc_res hvc_res;
> > +     u32 freq =3D 1UL;
> > +     int *idx =3D data;
> > +
> > +     while (freq !=3D CPUFREQ_TABLE_END) {
> > +             arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_KVM_GET_CPUFREQ=
_TBL_FUNC_ID,
> > +                             *idx, &hvc_res);
> > +             if (hvc_res.a0) {
> > +                     *idx =3D -ENODEV;
> > +                     return;
> > +             }
> > +             freq =3D hvc_res.a1;
> > +             (*idx)++;
> > +     }
> > +}
> > +
> > +static int kvm_cpufreq_get_freqtbl_num_entries(int cpu)
> > +{
> > +     int num_entries =3D 0;
> > +
> > +     smp_call_function_single(cpu, remote_get_freqtbl_num_entries, &nu=
m_entries, true);
> > +     return num_entries;
> > +}
> > +
> > +static void remote_populate_freqtbl(void *data)
> > +{
> > +     struct arm_smccc_res hvc_res;
> > +     struct remote_data *freq_data =3D data;
> > +     struct cpufreq_frequency_table *pos;
> > +     struct cpufreq_frequency_table *table =3D freq_data->table;
> > +     int idx;
> > +
> > +     cpufreq_for_each_entry_idx(pos, table, idx) {
> > +             arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_KVM_GET_CPUFREQ=
_TBL_FUNC_ID,
> > +                             idx, &hvc_res);
> > +             if (hvc_res.a0) {
> > +                     freq_data->ret =3D -ENODEV;
> > +                     return;
> > +             }
> > +             pos->frequency =3D hvc_res.a1;
> > +     }
> > +     freq_data->ret =3D 0;
> > +}
> > +
> > +static int kvm_cpufreq_populate_freqtbl(struct cpufreq_frequency_table=
       *table, int cpu)
> > +{
> > +     struct remote_data freq_data;
> > +
> > +     freq_data.table =3D table;
> > +     smp_call_function_single(cpu, remote_populate_freqtbl, &freq_data=
, true);
> > +     return freq_data.ret;
> > +}
>

Hi Peter,

Thanks for taking the time to review!

> *WHY* are you sending IPIs to do a hypercall ?!?
>
> You can simply have the hypercall tell what vCPU you're doing this for.
>

We=E2=80=99ll remove all the code that=E2=80=99s making IPI calls and switc=
h over to
populating the frequency tables in the device tree when we move from
RFC to PATCH. It is here for now to make it easier for others to
cherry-pick and test the series without needing more changes to their
VMM.

Thanks,
David
