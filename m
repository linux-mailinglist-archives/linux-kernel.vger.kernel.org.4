Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91CB600B32
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 11:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiJQJoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 05:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiJQJoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 05:44:11 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDF33BC53;
        Mon, 17 Oct 2022 02:44:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLUjjA46VCFHypOuasZEj0EQLaoDm85pNkoz9RL7w0TaNs+44wIsmkmqr+emvS77qv/MykGEhaJbiYlWNeoURR340807i7YwlV7mGEQyPQa1t3JOLeuJ+aYVeKwuAj21vpiQVE+kXXrqGlNrXSpfcj8Pre7bjNn7vE/784VZ9j5/qZcyyKU19QXQ040Df7mBjucY10YCDNNj/U8b+rLz2E1rGiYFtHNzzAbu8j/Riv+E67wJ40sVMSbVAmaRxZRLGzB4ogkFlfwEmYbM2Jb9oHoexhBzOAh233i0cKlFL2GBUaDagBV+a+1VcdjHzBkWwfIQ5iRB4IpYJsyYkGpYzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VfD79jXLB2SCjW57HevwLxyu/ZTAjF4ErNxEd0JVrM=;
 b=izWths9ggbmniMr2W23QEPy3FaviE26qoQ/1gRLlQfYjUlNJvhEjNUDLQBBdBUIUaapkI2XZts+rqUjEYSvNNban6bs1Qyz2mua2OfYskEEnZdfnR04LR9laI8qrEOczrCki7D71+HYOxnAY0wNpfPppwioxnndzpb3zF5UBt1cYjVnR6Ko/Hj/LE2wabpn3tPDOPYfcTWscPCPx15/ks66WTCLInzkaReantT+MrQjVIha3j5qHW7gHvLUJprGENHp1cJZt0jkfNhLriSQDJiIKrZ2o5Xj28nKQ9GpyhGiAF2iTBJdywkOlt06MBtqafUO80yRpBEu5jx+s4oNrAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VfD79jXLB2SCjW57HevwLxyu/ZTAjF4ErNxEd0JVrM=;
 b=3m/ZCEHP5uy22zUNZNCAlQUqFc283XFvnJlue8/0WQa8cfuEbSiXraCalhkdZfgBwEj3dmgCSQSgdWPi7yzfrfRZpvaC/hTskJoqQ9hcKkDbiXQXWeMWzbYpAg0hxhQoara7fRW+gAxz2qd6H+XxF+iZO04R+5HPu71dFIFxLmA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 MN0PR12MB5761.namprd12.prod.outlook.com (2603:10b6:208:374::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20; Mon, 17 Oct 2022 09:44:06 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::739e:43cb:7ff0:9b08]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::739e:43cb:7ff0:9b08%7]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 09:44:06 +0000
Date:   Mon, 17 Oct 2022 17:43:44 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Yuan, Perry" <Perry.Yuan@amd.com>
Cc:     "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH V2 1/9] ACPI: CPPC: Add AMD pstate energy
 performance preference cppc control
Message-ID: <Y00j0FjodH5+yawN@amd.com>
References: <20221010162248.348141-1-Perry.Yuan@amd.com>
 <20221010162248.348141-2-Perry.Yuan@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010162248.348141-2-Perry.Yuan@amd.com>
X-ClientProxiedBy: TYCP286CA0149.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::12) To DM5PR12MB2504.namprd12.prod.outlook.com
 (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|MN0PR12MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: 461d5577-531c-4e64-f8d1-08dab02421e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v2FWObo5UpkrhKEnP1GppxZAWwSnVFYal5RXJGQC7J3vMmW7VjMC0au2eezKJNRwwcVsDUFpYM2/wq5NRNPLfMrQMepURd2WP7cjXQNsAFNXwGr0Sqqa7G1TXfEhuzsluqih1O9X+NzeQ+RBQUm3EtgLvvWYBTuylFMltwXLAN1EyySNbEjUVu4EDc6nFyEU60ABbLDgA4UaZgIQpC/7O/PkXgKu39dYgFIVwJgHX6uF6APvK8Li99yl08tH4m3/FBrvTRuv2B4/o2TeM7Ye/mkaU1ONlRnv9XAxynb2Yca93t36vGgHGWxxxQSVAk/LGTq3hgglgOVXSczZMlxZ2x38tpMk0SwQz4QPp37PiOzHIGM5S1Qab63YB4Wdm+ux/FCcKnSpTC6VPaRYJgwtsOlMUS4PrEUxxUi1jYhSLz7DKhntMqcc12FLLRt1aO6VMBFo0D0QyW5or8q+tHXJYyr2HlwBhLCYCEw2FI0Ovqt7u7MTEMAgH+WMfDuY7stPFlD3VMp59wZlcH1rBYY2fqdyb0suzELmWcUyUzonmJgEgtFnhT88tVjgmiMbpdiUw1oxDBPauP+qft6MWkhatgR87h9+Mt47jR50SkDdqOyB+VNDtgtB1N8lc1HbprJey/LoreAXnIt2EH3007JErpUW07/El0lwkIwlqyK6tSwe/eCb+c4RxgvOlS/Jd7pDoAZQPxe9AvgFoxE8CgMxrxsbR6uFpkvt+DTqM88ChGcD4uI9dhwBPRhAL7ownxJ9jHMgkUHL0TEDoXDqnoAh73Q9AvFiRVkP75pyhz8bTLwtax8Mo2e59BnvIdOP4fIE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199015)(36756003)(6486002)(86362001)(5660300002)(37006003)(2906002)(38100700002)(186003)(2616005)(83380400001)(6506007)(316002)(26005)(478600001)(6512007)(54906003)(6636002)(66946007)(66556008)(66476007)(41300700001)(6862004)(4326008)(8936002)(6666004)(8676002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VQh1mqouEG1ObCBJ9dPPKG6Vezwb1vsW3eQjIOtsHUJ4nDXWqXeJj8GUbRA3?=
 =?us-ascii?Q?uiyMNVqtM4BQ/+C0B4BHHFjwjVVlYE3+NkGERc9ohhwi6JI1859H5AUUQ96T?=
 =?us-ascii?Q?ATT3Z9uOJJz7ha8mjdHIyf9d7FOH2X0FzfyK1Bj6986STrjMOB/TXR7IuOms?=
 =?us-ascii?Q?tL6QGpKdOjN/cd+rtjJsew5cFNrdavFTCzAXXnBvuC/7fEr9z5oYlztJ9xQ0?=
 =?us-ascii?Q?cNQ6lYJL5psw/kJIat2TgypCpxIR/D5qB5j7xSldXR+sNAnmwfD0YJdgcPbt?=
 =?us-ascii?Q?73e8X5rjHpYv60tjg/5cOX9twuAy8BX+tPMIzVbNAFnj1AHlyuXQOS/IXe62?=
 =?us-ascii?Q?6Bo/zws9ptIm48rjSa6KhOaINmaFT7DgWhOvTvozS+ONktMDHGtzw1utDkGZ?=
 =?us-ascii?Q?GUBelXs1ZXFbCcbStRl2EfCOv0c8DiIfRLTYnotxOGivrFNLxNYra+q5/jG8?=
 =?us-ascii?Q?eCRCEPoZZkGUsfgRUXCpbL8N/N3mlqwF/0ChHJLjAbaymlhDetYufM9zbXie?=
 =?us-ascii?Q?jzjf1DsD/iJocLRGBF4vmzkOLMswuwdW/dpAsxSZyE7YbzGB8Svq4df7QBZx?=
 =?us-ascii?Q?OXWde3m0QgJcs9j+oCM2XVDC/xtKJ/O/wFIqLYQ3KCyU6IlkoArRtu+OmgKp?=
 =?us-ascii?Q?bjT/7Dg8clxGNGoNyu85+Tx/e8eKgn6inCkTjyHXZGyhsb8UmiePqF8H/2bp?=
 =?us-ascii?Q?UXCpq9TcCiFjttQDsstgsHz4b7S2OOp+CI8JVOE6D9FhikzW/wuHVT34u3lu?=
 =?us-ascii?Q?SWea9y1yag90u4CuaOUH4WkgcWA9BA0uIY4G+bzIQnTSjej1N+jkJxXabWr8?=
 =?us-ascii?Q?di1q6qAbVzDPMxxApkPYWgVFMgEe2RzK+Z4kCfUpxrBcbKzYHFGzG0jzEmCA?=
 =?us-ascii?Q?ITS7KxBXpYGXWnH8LU5vgxlVeN7tJ6A4gO8NJo2zWFbUmmzizjm4GxV5XH+u?=
 =?us-ascii?Q?Xziv5qFLW9fAxNlQxB5dX5K1Y44nQswR4oHFY373dTG9DAziEAfA4FA7kdp+?=
 =?us-ascii?Q?Dtd7ZUiesiSCfujcYFic7j88ONfe7nyI2tSOMPmv86GwcQ6AF1MgdGqP2RMs?=
 =?us-ascii?Q?IYH9A+WjIbtt9RAl7whj+etL8+5IJwYmPhpvgX6qWzT0D3O9YJ1Y7gBPcAtG?=
 =?us-ascii?Q?dPigCZIR6VwpxptVo81aWrTp6xOLYb9QvqAL8X3LEp4dGxuQngiQd2KBiW1d?=
 =?us-ascii?Q?8dFVTvBwGNY9+pRPVbCJI9DaMXKA5RjTYbkkjRMHc/S4R8otTLJLj5NqDRik?=
 =?us-ascii?Q?7DGaFHKKYNzF41o+IF5JXmD+FbY7k67CV9wpyE322awAZbZ4C3oyFaa+ifng?=
 =?us-ascii?Q?OZEe3vKSxd6Ivy9TvVNqD8g+9kFFIiAdOzvvlV2vL5X/6BrkMifOwTnGKlQi?=
 =?us-ascii?Q?2AFkb1d8KpiJ0rgPL/5McxKC/TuULNtg6D881smpTxsCY8ugR5nSEF4RfHAP?=
 =?us-ascii?Q?BgFkd4rzwWGWUAwmdsSgsJvp1t0gXuIPGcXCcnEAVJJUhTZWx8qUcdatCOzx?=
 =?us-ascii?Q?gnq3rNKZqCiIM4bsqVI8Ck9JSRplrAiWtZhvTMHFwAl4X1P4vvmef7t/drna?=
 =?us-ascii?Q?mM4NkkSqRgLyJtuh5QdPCqAh6mSXrJ34mKGvi+Nw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 461d5577-531c-4e64-f8d1-08dab02421e4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 09:44:06.2655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dqt6a65iki7JzzFZlwc8fvhFhMMtCL376tid5aN01kTqOwwobE3YHYytCJlRC82VWTlCRsZdK5vZ9Djlo9nXrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5761
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 12:22:40AM +0800, Yuan, Perry wrote:
> Add the EPP(Energy Performance Preference) support for the
> AMD SoCs without the dedicated CPPC MSR, those SoCs need to add this
> cppc acpi functions to update EPP values and desired perf value.
> 

The energy performance preference register is actually defined by ACPI, so
it's not the AMD specific stuff. It's correct to define a general function
in cppc_acpi lib not only for AMD processors. We won't need to mention "AMD
P-State" energy performance preference whatever it is implemented with MSR
or SystemMemory in the subject and commit message here.

> In order to get EPP worked, cppc_get_epp_caps() will query EPP preference
> value and cppc_set_epp_perf() will set EPP new value.
> Before the EPP works, pstate driver will use cppc_set_auto_epp() to
> enable EPP function from firmware firstly.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/acpi/cppc_acpi.c | 128 ++++++++++++++++++++++++++++++++++++++-
>  include/acpi/cppc_acpi.h |  17 ++++++
>  2 files changed, 144 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 093675b1a1ff..b0e7817cb97f 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1365,6 +1365,132 @@ int cppc_get_perf_ctrs(int cpunum, struct cppc_perf_fb_ctrs *perf_fb_ctrs)
>  }
>  EXPORT_SYMBOL_GPL(cppc_get_perf_ctrs);
>  
> +/**
> + * cppc_get_epp_caps - Get the energy preference register value.
> + * @cpunum: CPU from which to get epp preference level.
> + * @perf_caps: Return address.
> + *
> + * Return: 0 for success, -EIO otherwise.
> + */
> +int cppc_get_epp_caps(int cpunum, struct cppc_perf_caps *perf_caps)
> +{
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
> +	struct cpc_register_resource *energy_perf_reg;
> +	u64 energy_perf;
> +
> +	if (!cpc_desc) {
> +		pr_warn("No CPC descriptor for CPU:%d\n", cpunum);
> +		return -ENODEV;
> +	}
> +
> +	energy_perf_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
> +
> +	if (!CPC_SUPPORTED(energy_perf_reg))
> +		pr_warn("energy perf reg update is unsupported!\n");
> +
> +	if (CPC_IN_PCC(energy_perf_reg)) {
> +		int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
> +		struct cppc_pcc_data *pcc_ss_data = NULL;
> +		int ret = 0;
> +
> +		if (pcc_ss_id < 0)
> +			return -EIO;

Should be -ENODEV. That means no subspace.

> +
> +		pcc_ss_data = pcc_data[pcc_ss_id];
> +
> +		down_write(&pcc_ss_data->pcc_lock);
> +
> +		if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0) {
> +			cpc_read(cpunum, energy_perf_reg, &energy_perf);
> +			perf_caps->energy_perf = energy_perf;
> +		} else {
> +			ret = -EIO;
> +		}
> +
> +		up_write(&pcc_ss_data->pcc_lock);
> +
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cppc_get_epp_caps);
> +
> +int cppc_set_auto_epp(int cpu, bool enable)
> +{
> +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> +	struct cpc_register_resource *auto_sel_reg;
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +	struct cppc_pcc_data *pcc_ss_data = NULL;
> +	int ret = -EINVAL;
> +
> +	if (!cpc_desc) {
> +		pr_warn("No CPC descriptor for CPU:%d\n", cpu);
> +		return -EINVAL;
> +	}
> +
> +	auto_sel_reg = &cpc_desc->cpc_regs[AUTO_SEL_ENABLE];
> +
> +	if (CPC_IN_PCC(auto_sel_reg)) {
> +		if (pcc_ss_id < 0)
> +			return -EIO;

The same comment with above, should be -ENODEV.

> +
> +		ret = cpc_write(cpu, auto_sel_reg, enable);
> +		if (ret)
> +			return ret;
> +
> +		pcc_ss_data = pcc_data[pcc_ss_id];
> +
> +		down_write(&pcc_ss_data->pcc_lock);
> +		/* after writing CPC, transfer the ownership of PCC to platform */
> +		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
> +		up_write(&pcc_ss_data->pcc_lock);
> +		return ret;
> +	}
> +
> +	return cpc_write(cpu, auto_sel_reg, enable);
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_auto_epp);
> +
> +/*
> + * Set Energy Performance Preference Register value through
> + * Performance Controls Interface
> + */
> +int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
> +{
> +	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
> +	struct cpc_register_resource *epp_set_reg;
> +	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> +	struct cppc_pcc_data *pcc_ss_data = NULL;
> +	int ret = -EINVAL;
> +
> +	if (!cpc_desc) {
> +		pr_warn("No CPC descriptor for CPU:%d\n", cpu);
> +		return -EINVAL;
> +	}
> +
> +	epp_set_reg = &cpc_desc->cpc_regs[ENERGY_PERF];
> +
> +	if (CPC_IN_PCC(epp_set_reg)) {
> +		if (pcc_ss_id < 0)
> +			return -EIO;

The same comment with above, should be -ENODEV.

> +
> +		ret = cpc_write(cpu, epp_set_reg, perf_ctrls->energy_perf);
> +		if (ret)
> +			return ret;
> +
> +		pcc_ss_data = pcc_data[pcc_ss_id];
> +
> +		down_write(&pcc_ss_data->pcc_lock);
> +		/* after writing CPC, transfer the ownership of PCC to platform */
> +		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
> +		up_write(&pcc_ss_data->pcc_lock);
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(cppc_set_epp_perf);
> +

Most of cppc_set_auto_epp and cppc_set_epp_perf implementations are
duplicated. Could you use one general function?

>  /**
>   * cppc_set_enable - Set to enable CPPC on the processor by writing the
>   * Continuous Performance Control package EnableRegister field.
> @@ -1400,7 +1526,7 @@ int cppc_set_enable(int cpu, bool enable)
>  		pcc_ss_data = pcc_data[pcc_ss_id];
>  
>  		down_write(&pcc_ss_data->pcc_lock);
> -		/* after writing CPC, transfer the ownership of PCC to platfrom */
> +		/* after writing CPC, transfer the ownership of PCC to platform */

There is no change with this line.

Thanks,
Ray

>  		ret = send_pcc_cmd(pcc_ss_id, CMD_WRITE);
>  		up_write(&pcc_ss_data->pcc_lock);
>  		return ret;
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
> index c5614444031f..10d91aeedaca 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -108,12 +108,14 @@ struct cppc_perf_caps {
>  	u32 lowest_nonlinear_perf;
>  	u32 lowest_freq;
>  	u32 nominal_freq;
> +	u32 energy_perf;
>  };
>  
>  struct cppc_perf_ctrls {
>  	u32 max_perf;
>  	u32 min_perf;
>  	u32 desired_perf;
> +	u32 energy_perf;
>  };
>  
>  struct cppc_perf_fb_ctrs {
> @@ -149,6 +151,9 @@ extern bool cpc_ffh_supported(void);
>  extern bool cpc_supported_by_cpu(void);
>  extern int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val);
>  extern int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val);
> +extern int cppc_set_auto_epp(int cpu, bool enable);
> +extern int cppc_get_epp_caps(int cpunum, struct cppc_perf_caps *perf_caps);
> +extern int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
>  #else /* !CONFIG_ACPI_CPPC_LIB */
>  static inline int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
>  {
> @@ -202,6 +207,18 @@ static inline int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
>  {
>  	return -ENOTSUPP;
>  }
> +static inline int cppc_set_auto_epp(int cpu, bool enable)
> +{
> +	return -ENOTSUPP;
> +}
> +static inline int cppc_set_epp_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
> +{
> +	return -ENOTSUPP;
> +}
> +static inline int cppc_get_epp_caps(int cpunum, struct cppc_perf_caps *perf_caps)
> +{
> +	return -ENOTSUPP;
> +}
>  #endif /* !CONFIG_ACPI_CPPC_LIB */
>  
>  #endif /* _CPPC_ACPI_H*/
> -- 
> 2.34.1
> 
