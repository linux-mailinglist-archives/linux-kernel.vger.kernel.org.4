Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04F3726015
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbjFGMwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbjFGMwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:52:16 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7589019AE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:51:52 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3f9a81da5d7so205431cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 05:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686142311; x=1688734311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGJqdQiK4MKfPRMFEElKPIlLSoaxgQujZcPcywtmuLE=;
        b=vx9H63ZEKwP8kf2QmtQ5uIY2hNqkPc7muS69VQPvFQvC7m37HvsT/pqFCNYWwt26bY
         ORN9HwT7kORDv951avMLH/QW4H+YjyalvyUuvkjFG7/yaTglyG8Cie0CC9KAzUNqW4cI
         8+HanzbDZPc4noU+1JxQuPiMPJsKROvKQIRAi2/8yDnQCme5V0UhLSp2qpMGYHeL/Iyg
         vV+HXyGrwJz/pFX4ngrVDMEBvpuMh/SJs/cZd3EfISpgHwL52kj/6LjNeLM0y1h2ro/A
         0wLqB2FtqqZhFNmAvjBJY0e12bQbvuq/dADgWwFR2yC1wf7juC7gSY7dZiMrVhYSoD/v
         TJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686142311; x=1688734311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGJqdQiK4MKfPRMFEElKPIlLSoaxgQujZcPcywtmuLE=;
        b=LD+5xMIys583IioMfVEHNdcfNZA0okxMtXX+LwGCAPFBfDyHCQYDnznYvlA5BIF6Uh
         RQvYmp7s2CZ/VoPvlJCmHOgo6EZGnToyTQAMNQcmi82YytMA4g2KcxtZvG+OVAVqJCF5
         +Yu+tub+OZOTYeI07W5YxTV2tQZRQkqgqaTQTzVtaFrZSdor2sC9vTIAe3bUXZXDy6K2
         LQcwBae/d+DWR/L0xImaCLIgu6KiK7JPgJwJxo6DqCFoHCIsaT5XLYUM+eB2oFjjVTLP
         1lVC/jRdVs7A/wHU13SuTuj6lC188WV8JN2CE8LjoAvENpibnfDUxYXJZiczg3G77hpy
         4tuA==
X-Gm-Message-State: AC+VfDzoJkPVdNBk1QBjCJO0ip9loC5iFG1+CMg9r2if25u8yDITqKXP
        e+rvDDBB6ZCfZvDonotR9PBM8Ue2vntp5Mc12E2A8D87ORURBGeLJEekpg==
X-Google-Smtp-Source: ACHHUZ4idIE5V6jUDOkOEJpCWuSjtocPvIAom3pIMftOw5LFmwZj1Dz2NWoN4PhIYlr9xHShBW56wAzZPry7fTm7isQ=
X-Received: by 2002:a05:622a:c5:b0:3f9:6930:1307 with SMTP id
 p5-20020a05622a00c500b003f969301307mr213974qtw.22.1686142311175; Wed, 07 Jun
 2023 05:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230525180209.19497-1-james.morse@arm.com> <20230525180209.19497-13-james.morse@arm.com>
 <CALPaoCjLjngabG32m4X8sSwK-bbZ28oL6BVKSn_dFnDwPzkDkg@mail.gmail.com> <7ff7fcf9-725b-fb3d-43f3-b80a1df3a001@arm.com>
In-Reply-To: <7ff7fcf9-725b-fb3d-43f3-b80a1df3a001@arm.com>
From:   Peter Newman <peternewman@google.com>
Date:   Wed, 7 Jun 2023 14:51:40 +0200
Message-ID: <CALPaoChW=3T2EmrcW+eLEnDUY00rsRSQarTN3c0hSDX-FDRqvw@mail.gmail.com>
Subject: Re: [PATCH v4 12/24] x86/resctrl: Make resctrl_arch_rmid_read() retry
 when it is interrupted
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
        Xin Hao <xhao@linux.alibaba.com>, dfustini@baylibre.com
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

Hi James,

On Tue, Jun 6, 2023 at 7:03=E2=80=AFPM James Morse <james.morse@arm.com> wr=
ote:
> On 06/06/2023 09:49, Peter Newman wrote:
> > It looks like if __rmid_read() is interrupted by an occupancy counter
> > read between writing QM_EVTSEL and reading QM_CTR, it will not perform
> > any update to am->prev_msr, and the interrupted read will return the
> > same counter value as in the interrupting read.
>
> Yup, that's a problem. I was only looking at the mbm state in memory, not=
 the CPU register.
> I think the fix is to read back QM_EVTSEL after reading QM_CTR. I'll do t=
his in
> __rmid_read() to avoid returning -EINTR. It creates two retry loops which=
 is annoying, but
> making the window larger means you're more likely to see false positives.
>
> ----------------------------%<----------------------------
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/=
resctrl
> /monitor.c
> index e24390d2e661..aeba035bb680 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -101,6 +101,7 @@ static inline u64 get_corrected_mbm_count(u32 rmid, u=
nsigned
>  long val)
>
>  static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val=
)
>  {
> +       u32 _rmid, _eventid;
>         u64 msr_val;
>
>         /*
> @@ -110,9 +111,15 @@ static int __rmid_read(u32 rmid, enum resctrl_event_=
id eventid, u64 *val)
>          * IA32_QM_CTR.data (bits 61:0) reports the monitored data.
>          * IA32_QM_CTR.Error (bit 63) and IA32_QM_CTR.Unavailable (bit 62=
)
>          * are error bits.
> +        * QM_EVTSEL is re-read to detect if this function was interrupte=
d by
> +        * another call, meaning the QM_CTR value may belong to a differe=
nt
> +        * event.
>          */
> -       wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
> -       rdmsrl(MSR_IA32_QM_CTR, msr_val);
> +       do {
> +               wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
> +               rdmsrl(MSR_IA32_QM_CTR, msr_val);
> +               rdmsr(MSR_IA32_QM_EVTSEL, _eventid, _rmid);
> +       } while (eventid !=3D _eventid || rmid !=3D _rmid);
>
>         if (msr_val & RMID_VAL_ERROR)
>                 return -EIO;

I happen to be tracking the cost of resctrl_arch_rmid_read() calls, so
I measured the impact of your fix on my AMD EPYC 7B12:

with both this and the soft RMID series[1] applied:

Base switch         7955     0.23%
Hard RMID Switch    8476     6.80%
Soft RMID Switch    10173   28.17%
CLOSID+Soft RMID    10740   35.32%

then adding EVTSEL read-back patch:

Base switch         7985
Hard RMID Switch    8540     6.96%
Soft RMID Switch    11015   37.95%
CLOSID+Soft RMID    11590   45.16%

The Soft RMID switches contain two __rmid_read() calls, so this
implies each QM_EVTSEL read-back is around 420 cycles on this AMD
implementation.

Even if you don't agree with my plan to add resctrl_arch_rmid_read()
calls to context switches, there should be cheaper ways to handle
this.

-Peter

[1] https://lore.kernel.org/lkml/20230421141723.2405942-4-peternewman@googl=
e.com/
