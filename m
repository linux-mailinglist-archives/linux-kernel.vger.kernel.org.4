Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33960624669
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiKJPzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiKJPzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:55:44 -0500
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FAE2DA98;
        Thu, 10 Nov 2022 07:55:43 -0800 (PST)
Received: by mail-qk1-f172.google.com with SMTP id x21so1359531qkj.0;
        Thu, 10 Nov 2022 07:55:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5GCcN4ergz49gV4k6gX4iuIWjU767EtX1RSbqmpJ7/k=;
        b=qyItoG5fMIYF9OxwBsR0mZSua90KXQlK5ox8fxOZL264jhrBWa5kpEu6LZK1vge8ZN
         PPSJaA7i6zX07oG7T0UI9BAlZZ1IceUENBAK8OCf+utrrXm60xiiSq19d7syXs2HbpiM
         6q1BWXLvw9jtCsLzBVY0OiR1M+cOBgwsnAF/bs+K+Z8YMkvOfQ5PD/HJn9AVuG+e4lfg
         cSIVmUIvBiD6GPf21mlRyjuAmQbTDgcRT+0p26RA/3/5W6/qtOkZEdxWefBccoQEmEXj
         UZXQMfI45osnubeN7dXKJPdcG9hIse3ZVKW5c/FXXmN1oOCFhzdc9+xBOVA1+xVPg2Mb
         o5jQ==
X-Gm-Message-State: ACrzQf2pfmpbqqtOpKXAbb7YcyF+vBjBvMZHyTjqnkIHPerH5w5L6lXr
        AvRfD7+b628FsWmITP9FOfQMrddmuJEsoWqQmxQ=
X-Google-Smtp-Source: AMsMyM4tf00hWBjlp0FWPVGqv4gll6KoZ03N81DVFRxCBxNPlaipDW8yUmSgHkloBzEhGEOjob45aTPy2ZP1csKHL/I=
X-Received: by 2002:a05:620a:1476:b0:6fa:4c67:83ec with SMTP id
 j22-20020a05620a147600b006fa4c6783ecmr35799979qkl.23.1668095742749; Thu, 10
 Nov 2022 07:55:42 -0800 (PST)
MIME-Version: 1.0
References: <20221107175705.2207842-1-Perry.Yuan@amd.com> <20221107175705.2207842-2-Perry.Yuan@amd.com>
 <64836554-7caa-9a3e-3832-a66e87c83bf9@amd.com> <CAJZ5v0ik68V6D2tipGH4tepaAmy5bpSy2nZUyAHn=Qia9SCLzA@mail.gmail.com>
 <DM4PR12MB527881961B4BE3F74F503CFE9C019@DM4PR12MB5278.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB527881961B4BE3F74F503CFE9C019@DM4PR12MB5278.namprd12.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Nov 2022 16:55:31 +0100
Message-ID: <CAJZ5v0h3HLp8eLeLJXegSQxiiY-+d3eb8UHh1TE00f-EhBnwZg@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] ACPI: CPPC: Add AMD pstate energy performance
 preference cppc control
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 4:52 PM Yuan, Perry <Perry.Yuan@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
>
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rafael@kernel.org>
> > Sent: Thursday, November 10, 2022 10:50 PM
> > To: Limonciello, Mario <Mario.Limonciello@amd.com>; Yuan, Perry
> > <Perry.Yuan@amd.com>
> > Cc: rafael.j.wysocki@intel.com; Huang, Ray <Ray.Huang@amd.com>;
> > viresh.kumar@linaro.org; Sharma, Deepak <Deepak.Sharma@amd.com>;
> > Fontenot, Nathan <Nathan.Fontenot@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Huang, Shimmer
> > <Shimmer.Huang@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Meng,
> > Li (Jassmine) <Li.Meng@amd.com>; linux-pm@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [PATCH v3 1/8] ACPI: CPPC: Add AMD pstate energy
> > performance preference cppc control
> >
> > Caution: This message originated from an External Source. Use proper
> > caution when opening attachments, clicking links, or responding.
> >
> >
> > On Mon, Nov 7, 2022 at 7:44 PM Limonciello, Mario
> > <mario.limonciello@amd.com> wrote:
> > >
> > > On 11/7/2022 11:56, Perry Yuan wrote:
> > > > Add the EPP(Energy Performance Preference) support for the AMD SoCs
> > > > without the dedicated CPPC MSR, those SoCs need to add this cppc
> > > > acpi functions to update EPP values and desired perf value.
> > >
> > > As far as I can tell this is generic code.  Although the reason you're
> > > submitting it is for enabling AMD SoCs, the commit message should be
> > > worded as such.
> > >
> > > >
> > > > In order to get EPP worked, cppc_get_epp_caps() will query EPP
> > > > preference value and cppc_set_epp_perf() will set EPP new value.
> > > > Before the EPP works, pstate driver will use cppc_set_auto_epp() to
> > > > enable EPP function from firmware firstly.
> > >
> > > This could more succinctly say:
> > >
> > > "Add support for setting and querying EPP preferences to the generic
> > > CPPC driver.  This enables downstream drivers such as amd-pstate to
> > > discover and use these values."
> > >
> > > >
> > > > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > > > ---
> > > >   drivers/acpi/cppc_acpi.c | 126
> > +++++++++++++++++++++++++++++++++++++++
> > > >   include/acpi/cppc_acpi.h |  17 ++++++
> > > >   2 files changed, 143 insertions(+)
> > > >
> > > > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > > > index 093675b1a1ff..d9c38dee1f48 100644
> > > > --- a/drivers/acpi/cppc_acpi.c
> > > > +++ b/drivers/acpi/cppc_acpi.c
> > > > @@ -1365,6 +1365,132 @@ int cppc_get_perf_ctrs(int cpunum, struct
> > cppc_perf_fb_ctrs *perf_fb_ctrs)
> > > >   }
> > > >   EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
> > > >
> > > > +/**
> > > > + * cppc_get_epp_caps - Get the energy preference register value.
> > > > + * @cpunum: CPU from which to get epp preference level.
> > > > + * @perf_caps: Return address.
> > > > + *
> > > > + * Return: 0 for success, -EIO otherwise.
> > > > + */
> > > > +int cppc_get_epp_caps(int cpunum, struct cppc_perf_caps *perf_caps)
> > > > +{
> > > > +     struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
> > > > +     struct cpc_register_resource *energy_perf_reg;
> > > > +     u64 energy_perf;
> > > > +
> > > > +     if (!cpc_desc) {
> > > > +             pr_warn("No CPC descriptor for CPU:%d\n", cpunum);
> > > > +             return -ENODEV;
> > > > +     }
> > > > +
> > > > +     energy_perf_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
> > > > +
> > > > +     if (!CPC_SUPPORTED(energy_perf_reg))
> > > > +             pr_warn("energy perf reg update is unsupported!\n");
> > >
> > > No need to add a explanation point at the end.
> > >
> > > As this is a per-CPU message I wonder if this would be better as
> > > pr_warn_once()?  Othewrise some systems with large numbers of cores
> > > might potentially show this message quite a few times.
> >
> > pr_info_once() would suffice IMO.
>
> Fixed in V4.
>
> >
> > > > +
> > > > +     if (CPC_IN_PCC(energy_perf_reg)) {
> > > > +             int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
> > > > +             struct cppc_pcc_data *pcc_ss_data = NULL;
> > > > +             int ret = 0;
> > > > +
> > > > +             if (pcc_ss_id < 0)
> > > > +                     return -ENODEV;
> > > > +
> > > > +             pcc_ss_data = pcc_data[pcc_ss_id];
> > > > +
> > > > +             down_write(&pcc_ss_data->pcc_lock);
> > > > +
> > > > +             if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0) {
> > > > +                     cpc_read(cpunum, energy_perf_reg, &energy_perf);
> > > > +                     perf_caps->energy_perf = energy_perf;
> > > > +             } else {
> > > > +                     ret = -EIO;
> > > > +             }
> > > > +
> > > > +             up_write(&pcc_ss_data->pcc_lock);
> > > > +
> > > > +             return ret;
> > > > +     }
> >
> > What if CPC is not in PCC?
> >
> > Would returning 0 then work for all users?
>
> Fixed in V4
>
> >
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(cppc_get_epp_caps);
> > > > +
> > > > +int cppc_set_auto_epp(int cpu, bool enable) {
> > > > +     int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> > > > +     struct cpc_register_resource *auto_sel_reg;
> > > > +     struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> > > > +     struct cppc_pcc_data *pcc_ss_data = NULL;
> > > > +     int ret = -EINVAL;
> > > > +
> > > > +     if (!cpc_desc) {
> > > > +             pr_warn("No CPC descriptor for CPU:%d\n", cpu);
> > >
> > > Is this actually warn worthy?  I would think it's fine a debug like we
> > > have for the other _CPC missing messages.
> > >
> > > > +             return -EINVAL;
> > > > +     }
> > > > +
> > > > +     auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
> > > > +
> > > > +     if (CPC_IN_PCC(auto_sel_reg)) {
> > > > +             if (pcc_ss_id < 0)
> > > > +                     return -ENODEV;
> > > > +
> > > > +             ret = cpc_write(cpu, auto_sel_reg, enable);
> > > > +             if (ret)
> > > > +                     return ret;
> > > > +
> > > > +             pcc_ss_data = pcc_data[pcc_ss_id];
> > > > +
> > > > +             down_write(&pcc_ss_data->pcc_lock);
> > > > +             /* after writing CPC, transfer the ownership of PCC to platform */
> > > > +             ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
> > > > +             up_write(&pcc_ss_data->pcc_lock);
> > > > +             return ret;
> > > > +     }
> > > > +
> > > > +     return cpc_write(cpu, auto_sel_reg, enable); }
> > > > +EXPORT_SYMBOL_GPL(cppc_set_auto_epp);
> > > > +
> > > > +/*
> > > > + * Set Energy Performance Preference Register value through
> > > > + * Performance Controls Interface
> > > > + */
> > > > +int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
> > > > +{
> > > > +     int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> > > > +     struct cpc_register_resource *epp_set_reg;
> > > > +     struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> > > > +     struct cppc_pcc_data *pcc_ss_data = NULL;
> > > > +     int ret = -EINVAL;
> > > > +
> > > > +     if (!cpc_desc) {
> > > > +             pr_warn("No CPC descriptor for CPU:%d\n", cpu);
> > >
> > > Is this actually warn worthy?  I would think it's fine a debug like we
> > > have for the other _CPC missing messages.
> > >
> > > > +             return -EINVAL;
> > > > +     }
> > > > +
> > > > +     epp_set_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
> > > > +
> > > > +     if (CPC_IN_PCC(epp_set_reg)) {
> > > > +             if (pcc_ss_id < 0)
> > > > +                     return -ENODEV;
> > > > +
> > > > +             ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
> > > > +             if (ret)
> > > > +                     return ret;
> > > > +
> > > > +             pcc_ss_data = pcc_data[pcc_ss_id];
> > > > +
> > > > +             down_write(&pcc_ss_data->pcc_lock);
> > > > +             /* after writing CPC, transfer the ownership of PCC to platform */
> > > > +             ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
> > > > +             up_write(&pcc_ss_data->pcc_lock);
> > >
> > > cppc_set_auto_epp and cppc_set_epp_perf have nearly the same code in
> > > the if block.  I wonder if it's worth having a static helper function
> > > for this purpose that takes "reg" and "value" as arguments?
> > >
> > > > +     }
> >
> > And what about the non-PCC case here?
>
> I merge the  cppc_set_auto_epp and cppc_set_epp_perf in V4.
> For the non-PCC case, we canno set the EPP value to FW, then just returned
> Error code.  Is it Ok ?

Yes, if it cannot be updated, it should be treated the same way as
unsupported IMV.
