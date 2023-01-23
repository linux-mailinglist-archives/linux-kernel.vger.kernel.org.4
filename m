Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF46677D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjAWNzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjAWNzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:55:09 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC63728F
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:55:05 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id q10so9082796qvt.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GCrbTWFv0PB4tjtFLRNFjVirQU27dq8xw/gojrDcg+k=;
        b=K81N02O6w/HJBW7IqpZ18RmsxWZpWICZuwc7YjTBFBupTB7bF89yA5Ce7+MgSzLAKF
         vg+7tSetsuzMhvoOPSJ2sQKGddfGNmh8igoCWde+/qOz2cXMm6Luqr30EV0xpIE8z0In
         UricPKaWgbOeVOWjUqLRjeQ+Q121Klzk2yL240Z58fCduhvDDbhmdxJgYd3xgVYFBIT2
         OYRRkVDXfmsCB1eX/QwoG0Sb9ANoO7ZScFNqKqid3isxYLBb2VSPCQX7W0nkjYgZIJKf
         a819Icu12bNhzcq01jhPioJZ+s3E9aOM6xHYAdosIExPwUZqSiOWcfYiXSOYY4YPVAtM
         W72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GCrbTWFv0PB4tjtFLRNFjVirQU27dq8xw/gojrDcg+k=;
        b=foq3HKV9nT+ctEoQlb4o2esndBYQPPy4eQeHduJ9QSaofOVgUksi6fucWPIi27AhyY
         NORuHaAX9B1M3LEWm/3S6wjQhq4UtqwKSQKtrIx33HE2qk0O5LyOryafMHX9eqgn0/oM
         VH1DjJSMor6Lmz9rPQVQqwcDWSyZ3j3f3IosvyoU3jTb3aXUIi5ZosUwv+GfMtXsPCx/
         aVRbDul1aa9yAJ7DZJMIxS2u/oyw5kMDRoowTUuKn3Y0Y5AQk+5NazHmIqzk7ZvwPur6
         /0MenOdOeErJ3DuFA58YTalLjZ9S/grNUtY3z9sIO0ISHwwo6iOz06jGQwZxH5eVyKvM
         +T6g==
X-Gm-Message-State: AFqh2kovxOwUC9BGtHFDV23C4Bud2P3W2Yxrv2uusS3+7BTRFydJW8be
        zZ0obUYBOYOgpj5tccGZqbidehiFtblWdqBWapZtew==
X-Google-Smtp-Source: AMrXdXvWEfqrYYqnDdQWq4204l66UoKTFn90iorODQrKh2f/BjMcNJ2/ohct79BJxCOXqHvZG93v1EFqd9p2DOJ+/1M=
X-Received: by 2002:a05:6214:3308:b0:531:be01:979c with SMTP id
 mo8-20020a056214330800b00531be01979cmr1121720qvb.50.1674482104020; Mon, 23
 Jan 2023 05:55:04 -0800 (PST)
MIME-Version: 1.0
References: <20230113175459.14825-1-james.morse@arm.com> <20230113175459.14825-10-james.morse@arm.com>
In-Reply-To: <20230113175459.14825-10-james.morse@arm.com>
From:   Peter Newman <peternewman@google.com>
Date:   Mon, 23 Jan 2023 14:54:53 +0100
Message-ID: <CALPaoCisUdTzSP6E+9VVa4okjvcCjs6p7MhyLYpzxVGs7+8nNA@mail.gmail.com>
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
        Xin Hao <xhao@linux.alibaba.com>
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

Hi James,

On Fri, Jan 13, 2023 at 6:56 PM James Morse <james.morse@arm.com> wrote:
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index d309b830aeb2..d6ae4b713801 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -206,17 +206,19 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr, unsigned int width)
>         return chunks >> shift;
>  }
>
> -int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
> -                          u32 closid, u32 rmid, enum resctrl_event_id eventid,
> -                          u64 *val)
> +struct __rmid_read_arg
>  {
> -       struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> -       struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
> -       struct arch_mbm_state *am;
> -       u64 msr_val, chunks;
> +       u32 rmid;
> +       enum resctrl_event_id eventid;
>
> -       if (!cpumask_test_cpu(smp_processor_id(), &d->cpu_mask))
> -               return -EINVAL;
> +       u64 msr_val;
> +};
> +
> +static void __rmid_read(void *arg)
> +{
> +       enum resctrl_event_id eventid = ((struct __rmid_read_arg *)arg)->eventid;
> +       u32 rmid = ((struct __rmid_read_arg *)arg)->rmid;
> +       u64 msr_val;
>
>         /*
>          * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
> @@ -229,6 +231,28 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
>         wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
>         rdmsrl(MSR_IA32_QM_CTR, msr_val);
>
> +       ((struct __rmid_read_arg *)arg)->msr_val = msr_val;
> +}
> +
> +int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain *d,
> +                          u32 closid, u32 rmid, enum resctrl_event_id eventid,
> +                          u64 *val)
> +{
> +       struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> +       struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
> +       struct __rmid_read_arg arg;
> +       struct arch_mbm_state *am;
> +       u64 msr_val, chunks;
> +       int err;
> +
> +       arg.rmid = rmid;
> +       arg.eventid = eventid;
> +
> +       err = smp_call_function_any(&d->cpu_mask, __rmid_read, &arg, true);
> +       if (err)
> +               return err;
> +
> +       msr_val = arg.msr_val;

These changes are conflicting now after v6.2-rc4 due to my recent
changes in resctrl_arch_rmid_read(), which include my own
reintroduction of __rmid_read():

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=2a81160d29d65b5876ab3f824fda99ae0219f05e

Fortunately it looks like our respective versions of __rmid_read()
aren't too much different from the original, but __rmid_read() does
have a new call site in resctrl_arch_reset_rmid() to record initial
event counts.

-Peter
