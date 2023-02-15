Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD3E697CD0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbjBONJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbjBONJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:09:01 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422FA1B323;
        Wed, 15 Feb 2023 05:08:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLIYB+DbsHFwfkeGFJ+5s6imhi+TkkwiHX8HtowSF1yWWYYiQnwSTwvJyA3y+HCL/wSiE2qLyq8y/N7pP4GU/ltmrnzpnTXozCgCgWbJNebV17k7iLoqyZcW38qGiuAZZqLimWKHKZejOl7OR4C10xh+4Hnm0KBy4GjEw/SIocCbdI6g2MIBC+q/KIYVuXoDrXF0s3Ymyp1W9pGz0nB1pGCtFg1lrZ5NascSeNWziIheQkufc0S1L8GEqafdFaQdEo2OXYlt5JrOUXEtnCXu2lQoYcWBNZM7wfAJfiB8ZGW1rry1pgVuuNu8LbO/9DrMLKMkSu4PAFlUTscJVLq+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iiNWca0U2JAn90vB41ExVkooylJ029HpveQ8lMUnos=;
 b=VvvKaiGMQXOQoid28iXQr5SaqlGB/vPlGpLcNZ9GOfiKEKtFwHp/zQ3yp1FE+/YbLl2rPqBe3HinDTXo6piBn+8bkaPbyOB28YFL/YOrh1yDumWoJ3a39Er+HHbDy3L/yahquho5IDaKkqpuoGT7IbhT4AoxSpUnrVqZ5H2uEQG/rPJqKIp5nJDSLPseXG4KlrfKOi6l641vgK80lGf5qqTOYyz6ScnKvDVJo6eUM0HtVcupfZPGkh4pGfqJeWMtUls9crH9v3jQQ0WdK300RqGAq0e+/xDMJPkQESOpf30piHgxHGgbJwf7ykNhPbYwCR+UNwn2wLc9938B6QZ5ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iiNWca0U2JAn90vB41ExVkooylJ029HpveQ8lMUnos=;
 b=oYfkM2v436Wx9EYerfsWho5msj/EX/AoXvtC01IrqPWU1ODSjcwAuTW5nNSP6hLBQeQO0ur//e4sxcwCOayeLjWQ4mKTxQT6FljGuO9VBSzF1wOfVB1OkEwYJKzdRojQD1ZqEeolxO/C09Rl8+hjpUgf51lJTQfxaaEtP6vaGRE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) by
 CH2PR12MB5001.namprd12.prod.outlook.com (2603:10b6:610:61::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.19; Wed, 15 Feb 2023 13:08:44 +0000
Received: from DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::93f9:c1df:8ca3:fc5b]) by DM5PR12MB2504.namprd12.prod.outlook.com
 ([fe80::93f9:c1df:8ca3:fc5b%7]) with mapi id 15.20.6086.024; Wed, 15 Feb 2023
 13:08:44 +0000
Date:   Wed, 15 Feb 2023 21:08:17 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Karny, Wyes" <Wyes.Karny@amd.com>
Cc:     Rafael J Wysocki <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "Yuan, Perry" <Perry.Yuan@amd.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Shukla, Santosh" <Santosh.Shukla@amd.com>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "Narayan, Ananth" <Ananth.Narayan@amd.com>,
        "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
        Tor Vic <torvic9@mailbox.org>
Subject: Re: [PATCH v6 1/6] acpi: cppc: Add min and max perf reg writing
 support
Message-ID: <Y+zZQV+63uGnQbUA@amd.com>
References: <20230206172157.49887-1-wyes.karny@amd.com>
 <20230206172157.49887-2-wyes.karny@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206172157.49887-2-wyes.karny@amd.com>
X-ClientProxiedBy: SG3P274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::28)
 To DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR12MB2504:EE_|CH2PR12MB5001:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f7121bc-43db-4ccd-3a98-08db0f55c3e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MGYDs3sql2U93aBswfXiuFYCZTIKQmXLgq2QN6XmRlJwx1EW34LLYqO2n+ttLWRnAmoEBujaNagz5tusCPHSfyp4h0fbEUdGP/sAuv9UgJis4DqImNb0jkoUfToeTdCL4E/zYuuXAOzbCf9a7PCdCjnS2+R67iPYftLOy4KSoGiE+2gjBM/+3tAVkzU3U5hyb4U/PHM2sxDiPZ7UOP0NWvotawDMUkDMCfhtVYcxRk1ahwKSuTsNLVMEzKliI2p9C9zu5QMjUGp/VnsoK8Hy0MNNIQ7Q4GHrP3V2KF1mLauJVdmdB/RoUugdenfo/URF9fYUUBySIgULyffgTIxF2s0VpfaB8kfdKY2hDmALxsotBUEMquP6aSum3FVn67qeE+VaD5h5SQzP0Q/rcYICj5RTTMJPkxeSM7hHXcjycW2duc5lF+lMjHmn+UJvWJcCDwiZnbr46wTsaN8md/70ACBxPRWotA8VsV7W56kQ4/+LqFYV9+AwSw7wJ8xYCov+TGaxSotTJcCacZw1xfLzT4L4tD+T6FVkdUJg61X7ruMTJl4P6gfH8gdofXmlqNPoUtSYUcAlF4f/TFVPmurOpyMuyhVv9WjiZIiyvWAmPyCDFLnLzhCPkScf1Wf3q47J1exnp+n1f1+JDNgo0hMZBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2504.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199018)(37006003)(6666004)(2906002)(36756003)(6486002)(6862004)(6636002)(7416002)(316002)(38100700002)(41300700001)(8936002)(5660300002)(26005)(6512007)(2616005)(478600001)(54906003)(83380400001)(86362001)(66556008)(6506007)(186003)(66476007)(8676002)(4326008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rLP6vonKFkkEAZsZ1E8iMRN5P+wGNIMHWKTshFtW9J8LVi1UEvVRl88RHUq/?=
 =?us-ascii?Q?u0otb0PExTofi8yAtTctICh27FjL2GkYA1Z5CnnYuNnCVGEbabl8uXFWdxz5?=
 =?us-ascii?Q?Vxba+WYA4E/styZyU28NjphVU/Tteqkc5+WwdIK8WqvRqANtuIA2AgShm0re?=
 =?us-ascii?Q?GGEBNCzgndYuJ/+fWyqoCs2Dw7owD2DMdGkGw/WLZs33Ia6vuo3rLSgcZlTp?=
 =?us-ascii?Q?WR+HSKwuHIDY5oyJ3eufN1prig/dBVO6wV5NWdILznsIAXJ/sResqVC/Tx/8?=
 =?us-ascii?Q?7yxx+CwpeuK5HXHu4SEHEWPo4UeaJ/6RHGuM+8+w4jkPD2CBK7UmrDpnWkDV?=
 =?us-ascii?Q?nO9bS2N5s1eShXaIOTNmp6BDzwJIZxZgabTs9AGXpR7MYPBjik8o7hgsnQjF?=
 =?us-ascii?Q?WiJb/XAuvM7Xq0QhWuoLj/RszaF8x1CG5kybAeRCOt+lO3+mvM5tAYn9EjJm?=
 =?us-ascii?Q?qWUehcQiLGQEKk510L15AtrXnVEI0y5dH8bLRyq+x7ykWEmVyj6t5vnmDwFz?=
 =?us-ascii?Q?7x5cO+nA1X/AbfqzYJQLjGGmpWhcp6G0EWae+Ti3MkLYpMfP0IsSbJow44JS?=
 =?us-ascii?Q?Lgn4kvu0t+AMr5x7Si3uP/GDeClVesKU5mlB+iFHO2IXUfUIEo4RCb/WBSq0?=
 =?us-ascii?Q?HpC4/B618XTzkC7Z9E2GdVPUHd4+BhcErBHHthjlSa8XY1/XbXXQCunfIBMg?=
 =?us-ascii?Q?xnRTZnbjoXz0iEZnSJZ/omO90ZmTqcwv+FMWcPfSoh6mGDS1FUNEsXRAoh8J?=
 =?us-ascii?Q?pREUVGpUTic0I5KZbc9ztXo/gLXIY9m0r4NMKGZbXFNroEVKf+y7H17fAVK2?=
 =?us-ascii?Q?nBcjr+RhOQEZ2EXXMwwzJNcY+r74SxFKy79m3Tf6BSEd35DM/X1qDBxGCGfz?=
 =?us-ascii?Q?dJdS535u8gfaPtHJ7xF5gkbktb3gGxWfZHIf1hdn9cbmgL8EbsV8EiOytp37?=
 =?us-ascii?Q?XTX67OA/IlXK05rQJEsVz9uRgxNXhO6LjjhFxQeOYL58TrTTbx8bSb6wz+KB?=
 =?us-ascii?Q?tozYd1o/eo85kzmbFGziRa9mxvA1WzRPVfziOjqPA+EYoGb/Hl6Td4JeYsJj?=
 =?us-ascii?Q?FtTwOXDrC+jB2We9cx+vJyv5mM8Xavg+gmUyfAGNv55FrXGLlyWbKIcjp2Al?=
 =?us-ascii?Q?RoIn4LnV8Yx4lTmgRtjypZLnpxUsoxrGvW/6zdSGk0+y61kqHaYF58xMimWz?=
 =?us-ascii?Q?0SX0fgbKGcz6vumZUljRDkrr4Jv9t5dRcTVNYH9JLiNvQYoAAgfFvmnfG2Hy?=
 =?us-ascii?Q?pNTA7vrkg3M4EoAObRhpZ8dc8ZzBe1MIhW3uMP7AmEuxCqwYXdjnkAR6Q3oi?=
 =?us-ascii?Q?VHAvWrN5kpQAJbXBKsgIuoIkiraZPdotWpCIDmsOKdm6HzM7C4LE5PFyphDO?=
 =?us-ascii?Q?/d57ZOph3/cS4xYy6Thm/xCkKBZr7vonAHnLUK+C/c8qMgsNQgYDlpX41563?=
 =?us-ascii?Q?kVMBwc3CSFpgVA3VPc2b6ZDvz6L9Fy150hACO1PKgSRuhmEyBBVxdQA/1jt7?=
 =?us-ascii?Q?SFtnX9pDHsdw03MaXUaO2Wjev8XWCH6mnUa9SePrIoY1fBWC3dDlMuJk8PcQ?=
 =?us-ascii?Q?wuWznrADcSvwLMvxmKo8Hde9ttB1twfJISRzHYl7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7121bc-43db-4ccd-3a98-08db0f55c3e8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2504.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 13:08:43.8970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AmHWiX7pDdoD5bsIXX6kr1uDmJM5mF8Pn1uCcc3fzRcVAQD2gvatkRF2syT+bazMITIQHdLHK5AJmv1oBQvTcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5001
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 01:21:52AM +0800, Karny, Wyes wrote:
> Currently writing of min and max perf register is deferred in
> cppc_set_perf function. In CPPC guided mode, these registers needed to
> be written to guide the platform about min and max perf levels. Add this support
> to make guided mode work properly on AMD shared memory systems.
> 
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/acpi/cppc_acpi.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 02d83c807271..91f9ef75f7de 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1487,7 +1487,7 @@ EXPORT_SYMBOL_GPL(cppc_set_enable);
>  int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>  {
>  	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpu);
> -	struct cpc_register_resource *desired_reg;
> +	struct cpc_register_resource *desired_reg, *min_perf_reg, *max_perf_reg;
>  	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
>  	struct cppc_pcc_data *pcc_ss_data = NULL;
>  	int ret = 0;
> @@ -1498,6 +1498,8 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>  	}
>  
>  	desired_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
> +	min_perf_reg = &cpc_desc->cpc_regs[MIN_PERF];
> +	max_perf_reg = &cpc_desc->cpc_regs[MAX_PERF];
>  
>  	/*
>  	 * This is Phase-I where we want to write to CPC registers
> @@ -1506,7 +1508,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>  	 * Since read_lock can be acquired by multiple CPUs simultaneously we
>  	 * achieve that goal here
>  	 */
> -	if (CPC_IN_PCC(desired_reg)) {
> +	if (CPC_IN_PCC(desired_reg) || CPC_IN_PCC(min_perf_reg) || CPC_IN_PCC(max_perf_reg)) {
>  		if (pcc_ss_id < 0) {
>  			pr_debug("Invalid pcc_ss_id\n");
>  			return -ENODEV;
> @@ -1529,13 +1531,19 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>  		cpc_desc->write_cmd_status = 0;
>  	}
>  
> -	/*
> -	 * Skip writing MIN/MAX until Linux knows how to come up with
> -	 * useful values.
> -	 */
>  	cpc_write(cpu, desired_reg, perf_ctrls->desired_perf);
>  
> -	if (CPC_IN_PCC(desired_reg))
> +	/**
> +	 * Only write if min_perf and max_perf not zero. Some drivers pass zero
> +	 * value to min and max perf, but they don't mean to set the zero value,
> +	 * they just don't want to write to those registers.
> +	 */
> +	if (perf_ctrls->min_perf)
> +		cpc_write(cpu, min_perf_reg, perf_ctrls->min_perf);
> +	if (perf_ctrls->max_perf)
> +		cpc_write(cpu, max_perf_reg, perf_ctrls->max_perf);
> +
> +	if (CPC_IN_PCC(desired_reg) || CPC_IN_PCC(min_perf_reg) || CPC_IN_PCC(max_perf_reg))
>  		up_read(&pcc_ss_data->pcc_lock);	/* END Phase-I */
>  	/*
>  	 * This is Phase-II where we transfer the ownership of PCC to Platform
> @@ -1583,7 +1591,7 @@ int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls)
>  	 * case during a CMD_READ and if there are pending writes it delivers
>  	 * the write command before servicing the read command
>  	 */
> -	if (CPC_IN_PCC(desired_reg)) {
> +	if (CPC_IN_PCC(desired_reg) || CPC_IN_PCC(min_perf_reg) || CPC_IN_PCC(max_perf_reg)) {
>  		if (down_write_trylock(&pcc_ss_data->pcc_lock)) {/* BEGIN Phase-II */
>  			/* Update only if there are pending write commands */
>  			if (pcc_ss_data->pending_pcc_write_cmd)
> -- 
> 2.34.1
> 
