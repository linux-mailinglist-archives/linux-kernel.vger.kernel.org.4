Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B696244AA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 15:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiKJOtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 09:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiKJOtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:49:46 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D907FAD7;
        Thu, 10 Nov 2022 06:49:45 -0800 (PST)
Received: by mail-qv1-f45.google.com with SMTP id u7so1482293qvn.13;
        Thu, 10 Nov 2022 06:49:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xbmjXHL++2K+5ZIw7501es1S9k0HJ7wS/9t8BhBlqrc=;
        b=LEpVhXeb8BY/qx9Y/TCxpIeIqj6nQOfF4E9rL8mMrouZIWjcTD/84fp6fVGT6emvC8
         FQiD1lh2ioJEEhAej/z/yji20ks1iniuXNZ21P1CauaHy/IWns/8Dk5A1tiZaQ+Tf210
         +0qJXpzjwnN6DwxDA0wMzWSKwev76vi4Hk7J0RnipJShomZ1MwZMQts/ksLG6o4oAyz9
         WgL005amFewU/75VvjEUQmYZCaNAh1Kb92KsXpVmbe83+MC17CWOxWfAMG2cP4Q1GNiX
         CyGajJukeg+Xupw4XR5h8ajnozkOo3WVGTVwhq3PFI0E6b605OrfqieMBEqVTRE8uKsE
         RDzQ==
X-Gm-Message-State: ACrzQf2l6iTsR/v6O7Ef5uFx4K/SdNG680NyNeEPpP4xLelaevE1bPvW
        Pn0LJIYvqIenf9qIDgeU6UlQEn+WxaBsomP7cWo=
X-Google-Smtp-Source: AMsMyM6VXYDZO5hyYXgyTwOttYu4j1/n1RIh7BBqjlDbTNeuESISHYzbSDrd0fvvFl2wNaZtdmWwAVMsG30b5+zl878=
X-Received: by 2002:a0c:c684:0:b0:4bb:fc53:5ad9 with SMTP id
 d4-20020a0cc684000000b004bbfc535ad9mr50984823qvj.3.1668091784490; Thu, 10 Nov
 2022 06:49:44 -0800 (PST)
MIME-Version: 1.0
References: <20221107175705.2207842-1-Perry.Yuan@amd.com> <20221107175705.2207842-2-Perry.Yuan@amd.com>
 <64836554-7caa-9a3e-3832-a66e87c83bf9@amd.com>
In-Reply-To: <64836554-7caa-9a3e-3832-a66e87c83bf9@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Nov 2022 15:49:33 +0100
Message-ID: <CAJZ5v0ik68V6D2tipGH4tepaAmy5bpSy2nZUyAHn=Qia9SCLzA@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] ACPI: CPPC: Add AMD pstate energy performance
 preference cppc control
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Perry Yuan <perry.yuan@amd.com>
Cc:     rafael.j.wysocki@intel.com, ray.huang@amd.com,
        viresh.kumar@linaro.org, Deepak.Sharma@amd.com,
        Nathan.Fontenot@amd.com, Alexander.Deucher@amd.com,
        Shimmer.Huang@amd.com, Xiaojian.Du@amd.com, Li.Meng@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Nov 7, 2022 at 7:44 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> On 11/7/2022 11:56, Perry Yuan wrote:
> > Add the EPP(Energy Performance Preference) support for the
> > AMD SoCs without the dedicated CPPC MSR, those SoCs need to add this
> > cppc acpi functions to update EPP values and desired perf value.
>
> As far as I can tell this is generic code.  Although the reason you're
> submitting it is for enabling AMD SoCs, the commit message should be
> worded as such.
>
> >
> > In order to get EPP worked, cppc_get_epp_caps() will query EPP preference
> > value and cppc_set_epp_perf() will set EPP new value.
> > Before the EPP works, pstate driver will use cppc_set_auto_epp() to
> > enable EPP function from firmware firstly.
>
> This could more succinctly say:
>
> "Add support for setting and querying EPP preferences to the generic
> CPPC driver.  This enables downstream drivers such as amd-pstate to discover
> and use these values."
>
> >
> > Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> > ---
> >   drivers/acpi/cppc_acpi.c | 126 +++++++++++++++++++++++++++++++++++++++
> >   include/acpi/cppc_acpi.h |  17 ++++++
> >   2 files changed, 143 insertions(+)
> >
> > diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> > index 093675b1a1ff..d9c38dee1f48 100644
> > --- a/drivers/acpi/cppc_acpi.c
> > +++ b/drivers/acpi/cppc_acpi.c
> > @@ -1365,6 +1365,132 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
> >   }
> >   EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
> >
> > +/**
> > + * cppc_get_epp_caps - Get the energy preference register value.
> > + * @cpunum: CPU from which to get epp preference level.
> > + * @perf_caps: Return address.
> > + *
> > + * Return: 0 for success, -EIO otherwise.
> > + */
> > +int cppc_get_epp_caps(int cpunum, struct cppc_perf_caps *perf_caps)
> > +{
> > +     struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
> > +     struct cpc_register_resource *energy_perf_reg;
> > +     u64 energy_perf;
> > +
> > +     if (!cpc_desc) {
> > +             pr_warn("No CPC descriptor for CPU:%d\n", cpunum);
> > +             return -ENODEV;
> > +     }
> > +
> > +     energy_perf_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
> > +
> > +     if (!CPC_SUPPORTED(energy_perf_reg))
> > +             pr_warn("energy perf reg update is unsupported!\n");
>
> No need to add a explanation point at the end.
>
> As this is a per-CPU message I wonder if this would be better as
> pr_warn_once()?  Othewrise some systems with large numbers of cores
> might potentially show this message quite a few times.

pr_info_once() would suffice IMO.

> > +
> > +     if (CPC_IN_PCC(energy_perf_reg)) {
> > +             int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
> > +             struct cppc_pcc_data *pcc_ss_data = NULL;
> > +             int ret = 0;
> > +
> > +             if (pcc_ss_id < 0)
> > +                     return -ENODEV;
> > +
> > +             pcc_ss_data = pcc_data[pcc_ss_id];
> > +
> > +             down_write(&pcc_ss_data->pcc_lock);
> > +
> > +             if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0) {
> > +                     cpc_read(cpunum, energy_perf_reg, &energy_perf);
> > +                     perf_caps->energy_perf = energy_perf;
> > +             } else {
> > +                     ret = -EIO;
> > +             }
> > +
> > +             up_write(&pcc_ss_data->pcc_lock);
> > +
> > +             return ret;
> > +     }

What if CPC is not in PCC?

Would returning 0 then work for all users?

> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(cppc_get_epp_caps);
> > +
> > +int cppc_set_auto_epp(int cpu, bool enable)
> > +{
> > +     int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> > +     struct cpc_register_resource *auto_sel_reg;
> > +     struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> > +     struct cppc_pcc_data *pcc_ss_data = NULL;
> > +     int ret = -EINVAL;
> > +
> > +     if (!cpc_desc) {
> > +             pr_warn("No CPC descriptor for CPU:%d\n", cpu);
>
> Is this actually warn worthy?  I would think it's fine a debug like we
> have for the other _CPC missing messages.
>
> > +             return -EINVAL;
> > +     }
> > +
> > +     auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
> > +
> > +     if (CPC_IN_PCC(auto_sel_reg)) {
> > +             if (pcc_ss_id < 0)
> > +                     return -ENODEV;
> > +
> > +             ret = cpc_write(cpu, auto_sel_reg, enable);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             pcc_ss_data = pcc_data[pcc_ss_id];
> > +
> > +             down_write(&pcc_ss_data->pcc_lock);
> > +             /* after writing CPC, transfer the ownership of PCC to platform */
> > +             ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
> > +             up_write(&pcc_ss_data->pcc_lock);
> > +             return ret;
> > +     }
> > +
> > +     return cpc_write(cpu, auto_sel_reg, enable);
> > +}
> > +EXPORT_SYMBOL_GPL(cppc_set_auto_epp);
> > +
> > +/*
> > + * Set Energy Performance Preference Register value through
> > + * Performance Controls Interface
> > + */
> > +int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
> > +{
> > +     int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> > +     struct cpc_register_resource *epp_set_reg;
> > +     struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> > +     struct cppc_pcc_data *pcc_ss_data = NULL;
> > +     int ret = -EINVAL;
> > +
> > +     if (!cpc_desc) {
> > +             pr_warn("No CPC descriptor for CPU:%d\n", cpu);
>
> Is this actually warn worthy?  I would think it's fine a debug like we
> have for the other _CPC missing messages.
>
> > +             return -EINVAL;
> > +     }
> > +
> > +     epp_set_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
> > +
> > +     if (CPC_IN_PCC(epp_set_reg)) {
> > +             if (pcc_ss_id < 0)
> > +                     return -ENODEV;
> > +
> > +             ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             pcc_ss_data = pcc_data[pcc_ss_id];
> > +
> > +             down_write(&pcc_ss_data->pcc_lock);
> > +             /* after writing CPC, transfer the ownership of PCC to platform */
> > +             ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
> > +             up_write(&pcc_ss_data->pcc_lock);
>
> cppc_set_auto_epp and cppc_set_epp_perf have nearly the same code in the
> if block.  I wonder if it's worth having a static helper function for
> this purpose that takes "reg" and "value" as arguments?
>
> > +     }

And what about the non-PCC case here?

> > +
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
> > +
> >   /**
> >    * cppc_set_enable - Set to enable CPPC on the processor by writing the
> >    * Continuous Performance Control package EnableRegister field.
> > diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> > index c5614444031f..10d91aeedaca 100644
> > --- a/include/acpi/cppc_acpi.h
> > +++ b/include/acpi/cppc_acpi.h
> > @@ -108,12 +108,14 @@ struct cppc_perf_caps {
> >       u32 lowest_nonlinear_perf;
> >       u32 lowest_freq;
> >       u32 nominal_freq;
> > +     u32 energy_perf;
> >   };
> >
> >   struct cppc_perf_ctrls {
> >       u32 max_perf;
> >       u32 min_perf;
> >       u32 desired_perf;
> > +     u32 energy_perf;
> >   };
> >
> >   struct cppc_perf_fb_ctrs {
> > @@ -149,6 +151,9 @@ extern bool cpc_ffh_supported(void);
> >   extern bool cpc_supported_by_cpu(void);
> >   extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
> >   extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
> > +extern int cppc_set_auto_epp(int cpu, bool enable);
> > +extern int cppc_get_epp_caps(int cpunum, struct cppc_perf_caps *perf_caps);
> > +extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
> >   #else /* !CONFIG_ACPI_CPPC_LIB */
> >   static inline int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
> >   {
> > @@ -202,6 +207,18 @@ static inline int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
> >   {
> >       return -ENOTSUPP;
> >   }
> > +static inline int cppc_set_auto_epp(int cpu, bool enable)
> > +{
> > +     return -ENOTSUPP;
> > +}
> > +static inline int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
> > +{
> > +     return -ENOTSUPP;
> > +}
> > +static inline int cppc_get_epp_caps(int cpunum, struct cppc_perf_caps *perf_caps)
> > +{
> > +     return -ENOTSUPP;
> > +}
> >   #endif /* !CONFIG_ACPI_CPPC_LIB */
> >
> >   #endif /* _CPPC_ACPI_H*/
>
