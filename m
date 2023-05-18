Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555F2708414
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjEROlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjEROk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:40:59 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDD4DE;
        Thu, 18 May 2023 07:40:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KB4Titphg+cvJvEoQ3RFkjQGyzeHClDZKQIkx34VDUrAmEF4U8n7oD71RCgP0DpIGqXSfQGFepzPCnHZGzQqG6S0Hax5ZikVBVVM1zX9ijfC19LPY3FhtcFkYZeBezaP1mAtS5Ed4K5qfi9lT/zlyzfk2Enh4ya+m3F9o5YdR+Exbdjz2ZZXW+Ec75g/iZuA87haCuySoI14/25KYnu4l+QA0dZTqrBzQO9uraOCEhAhBe23H7DMg/hcwhHE/lizyzMSZ4mkrxIL2XjI5vzYGLPkEraQ50ATKSogbNo6SNEu+oKSco+5H97C1g6DZWzelqmCgd2/iDtG1/yWn/S6jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOu8iJyhz6P++zJdsKoy1lTvZVjZfH+OzPQNsM3hLGg=;
 b=fk7bAd0vxeydiKXf6IsrNfAzyqL1QXhAO/e+C9mc00k41YrF/JmUAZENu9zvbyIQ21GM30cka1K3BObSCheQ3EWXEmdjqX9ypbuULv8hIRvOtxU/teQw4YDCZoO8QDwlK4u1//vE8ewiz+1p7S0Rq3PN9dK+kb0IMUfBDTrEx1OqZvFDx6eKuk7TzrHi9q3zF+eEjL5QF7KVPPGqeanTn7tjwDHGPzY2shqRcnjQF3qot9qF42+VWlO4kj4YgbgLGAu/Qh2aSKHM8Z11a9ysrOWvM6pSNJnqzC9WRgwESGtg0fpY7kDNzdT6yyJZve87sE/rJ3GOqk8AooRDv4eIWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=os.amperecomputing.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOu8iJyhz6P++zJdsKoy1lTvZVjZfH+OzPQNsM3hLGg=;
 b=lDrBXsQIw/DpzZHqNPbOCEBBNJXNHKmz40Z+a/Ltk0J9b0m/NHcpHTJNHFO2i+A9JwWtdNaZVcJLjiYNkBBP4+SZm820YRPFoeSY7eUAlVxHr39PG4IhbEGLTvxU14UDsg5iIggPg2ZwSEM0ljyvmTDhdN010mS+Q0TB30O+lyTNgSFt/CUqyjcQKinTtIdnTCkWC6xPOeqs6SLktMtAPODdu97u0ot7W9qUaH0KkmUThFrF4pqxAnNsna/m/PeN8rgl1EnHPPlJ8quWUm9pkZiOItqsCVfgUzmjj5CA+jx7A35G3MVQaHxBmwKZxwE3UMBKUgtiBWdgz//VDlDm4w==
Received: from BN9PR03CA0401.namprd03.prod.outlook.com (2603:10b6:408:111::16)
 by DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 14:40:55 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::3f) by BN9PR03CA0401.outlook.office365.com
 (2603:10b6:408:111::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Thu, 18 May 2023 14:40:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.19 via Frontend Transport; Thu, 18 May 2023 14:40:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 18 May 2023
 07:40:42 -0700
Received: from [10.41.21.79] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 18 May
 2023 07:40:39 -0700
Message-ID: <0dc000e3-9b85-0841-03c0-3589e2e5d34b@nvidia.com>
Date:   Thu, 18 May 2023 20:10:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] cpufreq: CPPC: keep target core awake when reading
 its cpufreq rate
To:     Yang Shi <yang@os.amperecomputing.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Zeng Heng <zengheng4@huawei.com>,
        Ionela Voinescu <Ionela.Voinescu@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>, <xiexiuqi@huawei.com>,
        <liwei391@huawei.com>, <linux-acpi@vger.kernel.org>,
        <weiyongjun1@huawei.com>, <lenb@kernel.org>,
        <viresh.kumar@linaro.org>, <rafael@kernel.org>
References: <20230516133248.712242-1-zengheng4@huawei.com>
 <a1075da1-4ff1-4a8b-2902-3954db717ded@arm.com>
 <cde1d8a9-3a21-e82b-7895-40603a14d898@nvidia.com>
 <7caa9878-c910-06f2-6eee-64cc55d8a207@os.amperecomputing.com>
Content-Language: en-US
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <7caa9878-c910-06f2-6eee-64cc55d8a207@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT039:EE_|DM4PR12MB5229:EE_
X-MS-Office365-Filtering-Correlation-Id: ed098f77-f364-45d9-33db-08db57ade302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MNig2gNR7DwWMxJy2j+NpVa2gJAereKmlNuuI30Beso0qphor/cBYXRzrIzLpSiwzN20Dn661Ph4ynia7CNTxqcG7mYXf09pUIE7WDXUxpelWZ3glRD/2qq8M/uq4sXv5eGOvLbJtxpBJoxYuho9+OR1kzK9VppB/2UfYk2XDaG/DtNwNDZwB53RjAZjxd2fooAZuRudCjmsQe/p7P4EFxsxOyiZKoWUaWa2DYakEyt7qjkZOF9kt8lR8UZUzCIG0Z0o8j1v0VJTRsbf8IERjqKcydDVjuxxxRglSYogS0M833zGUHQCtyLmF1bHvWosYPfNrjiLjgL0p2LaR8VKcDJ6kYap7tPZBgmp3P4iPaMmYsvIzO9deees3HrDqf4+eFUQY5PMGXGyDuOah3xIDvpn6zjQRMG94g3aCgPQewtT2yIVauNzVrBkhKFnHNtl4QvRLMY/yVdPXLhoN3WNF60AeB9yR60d0G/LjY7AEXcvr7udCrk5JJfS7+gXGBOEhfpymsOv07xNfajsv6uiSaCo1vxN/cKmf5eIl/Ek/SL5RWppKg/0YS/+uPaMRD/Bk308vGUMw1Dx2c6Sar1mo0VVkryljCCgOl9I3926mGF/hUCDPT7V0FKxJZn1aWaRBazAhnzXZxnbwUSSZM5HEYM2qk6UMDngiii71jkShAyvWFxv+w10VrM7F10pFBm4RfNXp+NOYGoVtbRnqczbBpWVzQASvhvaR4Tf+303Rq+PoRcMrwZR/EQ3Tmr6rgwpka3VTqU4i0P0hE07FWqE5QPIId4wgfiv0phGX66qgfgMnq+detvGvwp/diYNEKuZHs9tzVd5OGa5bx3I9Lo7ZB0E3rTSGNLMRQbuA4tU1jk=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(8676002)(5660300002)(426003)(8936002)(336012)(82310400005)(47076005)(83380400001)(26005)(186003)(7636003)(36860700001)(82740400003)(356005)(16526019)(31696002)(86362001)(2616005)(40460700003)(16576012)(6666004)(478600001)(316002)(966005)(4326008)(36756003)(54906003)(41300700001)(40480700001)(110136005)(2906002)(31686004)(7416002)(70206006)(70586007)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:40:55.0869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed098f77-f364-45d9-33db-08db57ade302
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5229
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>
>>> +Ionela, Sumit, Yang,
>>>
>>> Hello Zeng,
>>>
>>> I think solutions around related issues were suggested at:
>>>
>>> [1]
>>> https://lore.kernel.org/all/20230418113459.12860-7-sumitg@nvidia.com/
>>> [2]
>>> https://lore.kernel.org/all/20230328193846.8757-1-yang@os.amperecomputing.com/
>>> [3] https://lore.kernel.org/all/ZEl1Fms%2FJmdEZsVn@arm.com/
>>>
>>> About this patch, it seems to mean that CPPC counters of CPUx are always
>>> accessed from CPUx, even when they are not AMUs. For instance CPPC
>>> counters could be memory mapped and accessible from any CPU.
>>> cpu_has_amu_feat() should allow to probe if a CPU uses AMUs or not,
>>> and [2] had an implementation using it.
>>>
>>> Another comment about PATCH 2/2 is that if the counters are accessed
>>> through FFH, arm64 version of cpc_read_ffh() is calling
>>> counters_read_on_cpu(), and a comment in counters_read_on_cpu() seems
>>> to specify the function must be called with interrupt enabled.
>>>
>>> I think the best solution so far was the one at [3], suggested by
>>> Ionela,
>>> but it doesn't seem to solve your issue. Indeed, it is not checked
>>> whether
>>> the counters are AMU counters and that they must be remotely read (to
>>> have the CPU awake),
>>>
>>> Regards,
>>> Pierre
>>>
>>
>> I think the solution in [1] is simple and solves all the three cases.
>> Also, it provides better accuracy between the set and get frequency as
>> compared to [3].
> 
> I don't think [1] patches work for our case. We use mmio instead of AMU.
> Increasing delay could help to mitigate it somehow, buyt 25us is not
> good enough for our case. IIRC the fix proposed by Ionela works for both
> yours and mine.
> 

I have added the CPC_IN_SYSTEM_MEMORY check from [2] in [1].
Could you please test if the below change works for you.

-----------------------------------------
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 7ff269a78c20..67aa09b5f15c 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1315,6 +1315,7 @@ int cppc_get_perf_ctrs(int cpunum, struct 
cppc_perf_fb_ctrs *perf_fb_ctrs)
  	struct cppc_pcc_data *pcc_ss_data = NULL;
  	u64 delivered, reference, ref_perf, ctr_wrap_time;
  	int ret = 0, regs_in_pcc = 0;
+	unsigned long flags;

  	if (!cpc_desc) {
  		pr_debug("No CPC descriptor for CPU:%d\n", cpunum);
@@ -1350,8 +1351,17 @@ int cppc_get_perf_ctrs(int cpunum, struct 
cppc_perf_fb_ctrs *perf_fb_ctrs)
  		}
  	}

+	if (CPC_IN_SYSTEM_MEMORY(delivered_reg) &&
+	    CPC_IN_SYSTEM_MEMORY(reference_reg))
+		local_irq_save(flags);
+
  	cpc_read(cpunum, delivered_reg, &delivered);
  	cpc_read(cpunum, reference_reg, &reference);
+
+	if (CPC_IN_SYSTEM_MEMORY(delivered_reg) &&
+	    CPC_IN_SYSTEM_MEMORY(reference_reg))
+		local_irq_restore(flags);
+
  	cpc_read(cpunum, ref_perf_reg, &ref_perf);

  	/*
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 5e6a132a525e..23e690854459 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -46,6 +46,8 @@ static bool boost_supported;
  /* default 2usec delay between sampling */
  static unsigned int sampling_delay_us = 2;

+static bool get_rate_use_wq;
+
  static void cppc_check_hisi_workaround(void);
  static void cppc_nvidia_workaround(void);

@@ -99,6 +101,12 @@ struct cppc_freq_invariance {
  static DEFINE_PER_CPU(struct cppc_freq_invariance, cppc_freq_inv);
  static struct kthread_worker *kworker_fie;

+struct feedback_ctrs {
+	u32 cpu;
+	struct cppc_perf_fb_ctrs fb_ctrs_t0;
+	struct cppc_perf_fb_ctrs fb_ctrs_t1;
+};
+
  static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu);
  static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
  				 struct cppc_perf_fb_ctrs *fb_ctrs_t0,
@@ -851,28 +859,44 @@ static int cppc_perf_from_fbctrs(struct 
cppc_cpudata *cpu_data,
  	return (reference_perf * delta_delivered) / delta_reference;
  }

+static int cppc_get_perf_ctrs_sync(void *fb_ctrs)
+{
+	struct feedback_ctrs *ctrs = fb_ctrs;
+	int ret;
+
+	ret = cppc_get_perf_ctrs(ctrs->cpu, &(ctrs->fb_ctrs_t0));
+	if (ret)
+		return ret;
+
+	udelay(sampling_delay_us);
+
+	ret = cppc_get_perf_ctrs(ctrs->cpu, &(ctrs->fb_ctrs_t1));
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
  static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
  {
-	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
  	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
  	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct feedback_ctrs fb_ctrs = {0};
  	u64 delivered_perf;
  	int ret;

  	cpufreq_cpu_put(policy);
+	fb_ctrs.cpu = cpu;

-	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
-	if (ret)
-		return ret;
-
-	udelay(sampling_delay_us);
-
-	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t1);
+	if (get_rate_use_wq)
+		ret = smp_call_on_cpu(cpu, cppc_get_perf_ctrs_sync, &fb_ctrs, false);
+	else
+		ret = cppc_get_perf_ctrs_sync(&fb_ctrs);
  	if (ret)
  		return ret;

-	delivered_perf = cppc_perf_from_fbctrs(cpu_data, &fb_ctrs_t0,
-					       &fb_ctrs_t1);
+	delivered_perf = cppc_perf_from_fbctrs(cpu_data, &(fb_ctrs.fb_ctrs_t0),
+					       &(fb_ctrs.fb_ctrs_t1));

  	return cppc_cpufreq_perf_to_khz(cpu_data, delivered_perf);
  }
@@ -1002,10 +1026,18 @@ static void cppc_apply_workarounds(void)
  static int __init cppc_cpufreq_init(void)
  {
  	int ret;
+	int cpu;

  	if (!acpi_cpc_valid())
  		return -ENODEV;

+#ifdef CONFIG_ARM64_AMU_EXTN
+	cpu = get_cpu_with_amu_feat();
+
+	if (cpu < nr_cpu_ids)
+		get_rate_use_wq = true;
+#endif

--------------------------------------------

We can add additional check to call smp_call_on_cpu() only when 
CPC_IN_FFH if we want to reduce the scope of calling smp_call_on_cpu.

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 67aa09b5f15c..3d8348911403 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -110,6 +110,11 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
                                 (cpc)->cpc_entry.reg.space_id ==        \
                                 ACPI_ADR_SPACE_SYSTEM_IO)

+/* Check if a CPC register is in FFH */
+#define CPC_IN_FFH(cpc) ((cpc)->type == ACPI_TYPE_BUFFER &&    \
+                               (cpc)->cpc_entry.reg.space_id ==        \
+                               ACPI_ADR_SPACE_FIXED_HARDWARE)
+
  /* Evaluates to True if reg is a NULL register descriptor */
  #define IS_NULL_REG(reg) ((reg)->space_id == 
ACPI_ADR_SPACE_SYSTEM_MEMORY && \
                                 (reg)->address == 0 &&                  \
@@ -437,6 +442,29 @@ bool acpi_cpc_valid(void)
  }
  EXPORT_SYMBOL_GPL(acpi_cpc_valid);

+bool acpi_cpc_in_ffh(void)
+{
+       struct cpc_register_resource *delivered_reg, *reference_reg;
+       struct cpc_desc *cpc_ptr;
+       int cpu;
+
+       if (acpi_disabled)
+               return false;
+
+       for_each_possible_cpu(cpu) {
+               cpc_ptr = per_cpu(cpc_desc_ptr, cpu);
+               delivered_reg = &cpc_ptr->cpc_regs[DELIVERED_CTR];
+               reference_reg = &cpc_ptr->cpc_regs[REFERENCE_CTR];
+
+               if (!CPC_IN_FFH(delivered_reg) ||
+                   !CPC_IN_FFH(reference_reg))
+                       return false;
+       }
+
+       return true;
+}
+EXPORT_SYMBOL_GPL(acpi_cpc_in_ffh);
+
  bool cppc_allow_fast_switch(void)
  {
         struct cpc_register_resource *desired_reg;
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 23e690854459..4109e00b957e 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -1034,7 +1034,7 @@ static int __init cppc_cpufreq_init(void)
  #ifdef CONFIG_ARM64_AMU_EXTN
         cpu = get_cpu_with_amu_feat();

-       if (cpu < nr_cpu_ids)
+       if ((cpu < nr_cpu_ids) && acpi_cpc_in_ffh())
                 get_rate_use_wq = true;
  #endif

>>
>> This can be merged and can later still be improved in Upstream.
>>
>> If OK, I can send new version by changing the patch to apply for all
>> ARM SoC's with AMU and not specific to Tegra.
>>
>> Thank you,
>> Sumit Gupta
