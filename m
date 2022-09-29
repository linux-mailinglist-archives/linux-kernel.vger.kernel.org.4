Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FCB5EF012
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbiI2ILZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbiI2ILW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:11:22 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124B313AF37
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:11:20 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id v128so333110ioe.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Y/ouPO+8ggCR5XfiR9vvBUlZSYI49RbT/rsnOPSR8Rg=;
        b=Jd3yUrIuLUuBGk3SrYhc2WzVt+g9kcDw2xlpyLmcctfuqAi4yyhINFoOXVhn7Lw+VM
         xsVuQW/Rqvm2UizfwCBAQp0ZznjKHSm5X4ckphwe5PQ4S03OpNYrVjntnciR/e0tBQ+1
         Q+PZFbNZhpOWK1NHTl42OgE6cWuLVhlTwfYlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Y/ouPO+8ggCR5XfiR9vvBUlZSYI49RbT/rsnOPSR8Rg=;
        b=td0ZvlPtYbbatUQBiSrHDzLzeQFguAVnvhZaTd/I7psT4Xdx43XO0Xt2u3MtUv77wy
         vMfOkWm0xBsyvFTWYRB3PKbKBY5w3GYyF6n77Uyz965PIMHCsRUQAl5LFACzHebwaEcF
         0psf0+Hk4kLEnrYTx/kwDDXVPCGOrVaUVKrNAefRO73JQ3Bx6xRU6YBL+uaKtMoqCsZ0
         Wwt2A1W0E2L9+hyw5bROCbvmmrcXNT/g2IjBGG/eW+JgiOpNO1ZYwuXEtBMIoJEF6YqU
         X15hWxeexI/HDlJ53tWZJb7q9swwWma63LvDK8xEr/c8+8k4yg2R5I1+3k5aIHxfF/07
         2PEg==
X-Gm-Message-State: ACrzQf34/CXz9iJO3DvNYL+w+Ky4AA924b1aI/oN6FaQJHuM+9YzLKka
        P4bcTjdHxOIoJ1VWJnwSiJ6xvVW4JVmV27xjFOx+
X-Google-Smtp-Source: AMsMyM4iB7bqNu9AVpHcTK6CBUrARbJ2zy0wYAW9dBBK8iB9whhsHJj3ZWdUR5CTscix10ClKTdxwkzW4uMEVfgVOEU=
X-Received: by 2002:a05:6602:15c7:b0:6a1:c3fc:98fd with SMTP id
 f7-20020a05660215c700b006a1c3fc98fdmr892233iow.151.1664439079361; Thu, 29 Sep
 2022 01:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220826151556.1708879-1-heiko@sntech.de> <CAOnJCU+e-rEN8AZ+5=owR4hVSq7jbYqcZUNwc7-8JbzgGK1d0Q@mail.gmail.com>
In-Reply-To: <CAOnJCU+e-rEN8AZ+5=owR4hVSq7jbYqcZUNwc7-8JbzgGK1d0Q@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 29 Sep 2022 01:11:08 -0700
Message-ID: <CAOnJCU+qrmTE3OEFhwvnTT6dQjVZn4jn5TEMz=8+TYahW4sdOw@mail.gmail.com>
Subject: Re: [PATCH] drivers/perf: riscv_pmu_sbi: add perf_user_access sysctl
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     anup@brainfault.org, will@kernel.org, mark.rutland@arm.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        paul.walmsley@sifive.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        cmuellner@linux.com, philipp.tomsich@vrull.eu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 3:10 PM Atish Patra <atishp@atishpatra.org> wrote:
>
>
>
> On Fri, Aug 26, 2022 at 8:16 AM Heiko Stuebner <heiko@sntech.de> wrote:
>>
>> Add a sysctl similar to the one on arm64 to enable/disable
>> access to counter CSRs from u-mode on RISC-V.
>>
>> The default is of course set to disabled keeping the current
>> state of access - to only the TIME CSR.
>>
>> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>> ---
>>  Documentation/admin-guide/sysctl/kernel.rst |  6 +--
>>  drivers/perf/riscv_pmu_sbi.c                | 43 ++++++++++++++++++++-
>>  2 files changed, 44 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
>> index ee6572b1edad..efd4bc385e7a 100644
>> --- a/Documentation/admin-guide/sysctl/kernel.rst
>> +++ b/Documentation/admin-guide/sysctl/kernel.rst
>> @@ -894,15 +894,15 @@ enabled, otherwise writing to this file will return ``-EBUSY``.
>>  The default value is 8.
>>
>>
>> -perf_user_access (arm64 only)
>> -=================================
>> +perf_user_access (arm64 and riscv only)
>> +=======================================
>>
>>  Controls user space access for reading perf event counters. When set to 1,
>>  user space can read performance monitor counter registers directly.
>>
>>  The default value is 0 (access disabled).
>>
>> -See Documentation/arm64/perf.rst for more information.
>> +See Documentation/arm64/perf.rst for more information on arm64
>>
>>
>>  pid_max
>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
>> index 6f6681bbfd36..7aab8d673357 100644
>> --- a/drivers/perf/riscv_pmu_sbi.c
>> +++ b/drivers/perf/riscv_pmu_sbi.c
>> @@ -41,6 +41,8 @@ static const struct attribute_group *riscv_pmu_attr_groups[] = {
>>         NULL,
>>  };
>>
>> +static int sysctl_perf_user_access __read_mostly;
>> +
>>  /*
>>   * RISC-V doesn't have hetergenous harts yet. This need to be part of
>>   * per_cpu in case of harts with different pmu counters
>> @@ -640,13 +642,22 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
>>         return IRQ_HANDLED;
>>  }
>>
>> +/*
>> + * Depending on the perf_user_access setting, enable the access
>> + * from usermode either for all counters or for TIME csr only.
>> + */
>> +static void riscv_pmu_update_user_access(void *info)
>> +{
>> +       csr_write(CSR_SCOUNTEREN, sysctl_perf_user_access ? GENMASK(31, 0) :
>> +                                                           0x2);
>> +}
>> +
>>  static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
>>  {
>>         struct riscv_pmu *pmu = hlist_entry_safe(node, struct riscv_pmu, node);
>>         struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
>>
>> -       /* Enable the access for TIME csr only from the user mode now */
>> -       csr_write(CSR_SCOUNTEREN, 0x2);
>> +       riscv_pmu_update_user_access(NULL);
>>
>>         /* Stop all the counters so that they can be enabled from perf */
>>         pmu_sbi_stop_all(pmu);
>> @@ -785,6 +796,32 @@ static void riscv_pmu_destroy(struct riscv_pmu *pmu)
>>         cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
>>  }
>>
>> +static int riscv_pmu_proc_user_access_handler(struct ctl_table *table,
>> +                       int write, void *buffer, size_t *lenp, loff_t *ppos)
>> +{
>> +       int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>> +
>> +       if (ret || !write)
>> +               return ret;
>> +
>> +       on_each_cpu(riscv_pmu_update_user_access, NULL, 1);
>> +
>
>
> This enables all the counter access from the user space. Not the ones that were being monitored through perf system calls.
> Looking at ARM64 code, they clear out all other counters during the start to avoid the leakage.
>
> This is a bit expensive to achieve with the current SBI interface as there is no simpler interface to clear out the mhpmcounter value without starting it.
> We have to start the other counters with 0 value and stop it immediately which is very ugly.
>
> There is a supervisor counter delegation proposal that is in discussion which can write the mhpmevent/mhpmcounter (via a different CSR) directly from S-mode.
> Once that is in place, we can enable such functionality.
>
> I am not sure how commonly this feature is used. Personally, I would prefer to not enable this until supervisor counter delegation is implemented.
> But I would like to hear what others think.
>
> If it is a very common feature that RISC-V should support immediately, we have to resort to the ugly route of enabling/disabling the unused counters.
>

I just realized my above response was never delivered to the mailing
list. In a way that's a good thing as I am trying to retract my above
opinion :)
There are some discussions around enabling cycle/instret for the user
space unconditionally [1] and a patch from palmer[2]
To allow userspace to selectively enable the cycle counter, we need
this patch. Thus, it should be merged asap.

I am still not sure how big the problem is for exposing the previously
used counter values. We can have separate discussions on that and a
follow up patch if required.

[1] https://lore.kernel.org/all/YxEhC%2FmDW1lFt36J@aurel32.net/
[2] https://lore.kernel.org/linux-riscv/YzS0RNzH2CprLSyc@spud/T/#ma8e0034fa9172a66820d6d5fbc3314619ff657a5


>> +       return 0;
>> +}
>> +
>> +static struct ctl_table sbi_pmu_sysctl_table[] = {
>> +       {
>> +               .procname       = "perf_user_access",
>> +               .data           = &sysctl_perf_user_access,
>> +               .maxlen         = sizeof(unsigned int),
>> +               .mode           = 0644,
>> +               .proc_handler   = riscv_pmu_proc_user_access_handler,
>> +               .extra1         = SYSCTL_ZERO,
>> +               .extra2         = SYSCTL_ONE,
>> +       },
>> +       { }
>> +};
>> +
>>  static int pmu_sbi_device_probe(struct platform_device *pdev)
>>  {
>>         struct riscv_pmu *pmu = NULL;
>> @@ -834,6 +871,8 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
>>         if (ret)
>>                 goto out_unregister;
>>
>> +       register_sysctl("kernel", sbi_pmu_sysctl_table);
>> +
>>         return 0;
>>
>>  out_unregister:
>> --
>> 2.35.1
>>
>
>
> --
> Regards,
> Atish



--
Regards,
Atish
