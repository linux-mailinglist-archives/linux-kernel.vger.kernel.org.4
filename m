Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E496CD128
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 06:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjC2ESi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 00:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjC2ESe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 00:18:34 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E344A2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 21:18:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2Z/x3V1Q+Byq/hIEro0WjKFxspJ/56qxtNTbSdMYn0v98kzEOn0355mjHhaIgMs0fcrXh8YVr5/phFmQu/OILBTgFsXrHuNWzKaOBOZnQxbluZamJ2D+UZQlxCStAi9B1+wSYdAxtE2GNWxbs0QukJq/me6v9qpZzV27Mp6jKRZqPMCk/i0sRjfJpBtJ/agSq1cGLSYF9iw+f8+5L8ZoAd9NCAGgVWKOFOxp8HX64Edgvts1j/tX9otzaQ3pW8TApwUdvNgw4qeS9G8zsvhXaKNUiyKD6RaW2VXJmKkt5ThyucakVLiqgIa947LhnHbclQT44gkXjNqmw6+YIMsEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTBEgHoIKkL+FjXSHA9KM3LorGv/aPLczS4xpRswqY4=;
 b=bUy8TIlWNljX7OzjJxGFRQj1zmEkdb7JGZB4a7cvH5dAhdSI/7dYk1grfmfqx1QctvCDQ22Ol6prFpxxEQVjWbdCuDqWi/cVVQ2jTUpyvMteAvHq2NPZ8PhLMglrhqAM3lZZgdvuPg3gqys/nyVB0DotMl9sqKQ5bBDicvMRqKh7OesG/wLeMo5pHVM85XbWhGqDuxn9EURjUtMISrqw+Ig1TTVS4Jdeh2zQIBjnyF0tLK7hM99U8JCYC4xkNbCzxfiu11b9cRLiqW+JxM7A33RejevNV/LucUHAdvQK+Tkj7p9muI9xi4ZVFh+fxXJfu6FbjLAexyCM87Ls41dN3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTBEgHoIKkL+FjXSHA9KM3LorGv/aPLczS4xpRswqY4=;
 b=bC7khS4Br7iVm2NkPDzITUweOYqC25au9+pKizawHrrYmM++YwMcqLEJkfgOxuxP4Qa8nnqb34sJpNh3ySvG19clHR6nMoPxeV3Wb7kHoQqLpkWzW4O4caEa6Cyw6p8yCn9L6syVTZICiJdz0O7F/oVlimoT9CB8eMAybY9xE4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW4PR12MB6780.namprd12.prod.outlook.com (2603:10b6:303:20e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Wed, 29 Mar
 2023 04:18:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6222.028; Wed, 29 Mar 2023
 04:18:25 +0000
Message-ID: <a41fac45-7ff5-7fe9-ad17-e9a049b65168@amd.com>
Date:   Tue, 28 Mar 2023 23:18:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/2] drm/amd/pm: vangogh: send the SMT enable message
 to pmfw
Content-Language: en-US
To:     Wenyou Yang <WenYou.Yang@amd.com>, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, evan.quan@amd.com,
        bp@suse.de, peterz@infradead.org, jpoimboe@kernel.org,
        kim.phillips@amd.com, tglx@linutronix.de
Cc:     weiyuan2@amd.com, richardqi.liang@amd.com, ying.li@amd.com,
        kunliu13@amd.com, gpiccoli@igalia.com,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230329015149.870132-1-WenYou.Yang@amd.com>
 <20230329015149.870132-3-WenYou.Yang@amd.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230329015149.870132-3-WenYou.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:408:70::16) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW4PR12MB6780:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ec48713-776c-4fc8-54bf-08db300ca3e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L7qrOb+4YX0fjhEx/hQ/7yL7wDWoyok4SBhR4tyXECvcrHp3BcqjWSFwTcWvIXrOdE341l3+db8uKCkDrEpghywkkxTptwVUC2dBgVqhir7fP7sJHMNiVLExSlsioiMCEr/fCTNxhSNi2Aqh9F+S8DYrQf08cW0lFIy5izUNbbRBSiYtYKvO0vCSAGzCF+/XFOifxzDUQ8UcsC92tC1f1UxURGU2G+CNzRgl9WncdsNYqlHmNE1saUFnRb1qN1W4F4TAISn2Od7scwcivJalUcn1mjbPO/3RouL3I2cQEAWLCW4V3Z0M32f0maisN3D5BAj6Q7REkLrY6Qpngk0W34CV4qr5is+ctjR8f5y+p3vZLD9a7RtJZOr/fxWERnY20MhlvIoMVsjav9SRG0881bG3IeV9kmGBHU4hGsZGzwpZxhMw1pOUj/efzlsmcutVJLOBbgmtgFKCHotxTKFZ95i/nmKeil8rCuknBii7K+18eE61De7ZkllxHpP3ZBEd9VU+YcfPeXiyZDSP/+DQUDXoeFm75m1jE3rOsU2eK8PFXBLt8cy2g8daQB9d8Pbg5SRy5ze8lJua6Eqz1PFpypE0All5sVbHhSlcRFucA5SLp5pMgLEF1FtbN7/5jkqIDpEt8sygyl2DJy9zrvqZXax086GbGxIMvM+tuwIe/tc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199021)(8936002)(31696002)(316002)(31686004)(41300700001)(15650500001)(2906002)(5660300002)(44832011)(8676002)(4326008)(478600001)(921005)(66946007)(66556008)(66476007)(2616005)(38100700002)(86362001)(6486002)(186003)(83380400001)(53546011)(6506007)(36756003)(6666004)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDI5SlhSRm5GR2tzYUxhSG5PM1lUbUhMQVpYYXZBc0pBR2ZueUV1TndDcEgw?=
 =?utf-8?B?ZENMNlZyMW81cFZvdDkvY1RUMVQ2akc0bHViVnhkSGttYWpsQXVTeE5BZElO?=
 =?utf-8?B?aCt1bU14WVVJNjZWcks4c1krLzdDME5tY3l2ejRON09FZWFHdGNlWHpJR2Rr?=
 =?utf-8?B?RjB3YjNXQnNjMjFPQ2Z0V3pERWpJTEladDk2NTU0dkU3TExPeDUzNWtnT21w?=
 =?utf-8?B?ZUtzR2pqS0t3VU5DTElOWW9BUURTNkZpa3E0dHhZTXVzL05TREZPVDlqYTRy?=
 =?utf-8?B?UTMxMnphcGhuelF2SzVZVUI4aHk5SGVEZ2hxNllKdFdma0JLc0FKUTZoM3NH?=
 =?utf-8?B?TDVZNWV0Ri8vQ1Zaa3VOTDNVK1pYUzlmTGk0MXh6U2NNZXlxYnVyK004TzR5?=
 =?utf-8?B?RHV6S0xDeFB6MzFuWnJsekg3VzhHYlBsZFgzbEUrODFGbXVENWd1aW5rK2hx?=
 =?utf-8?B?bE8rWkEveXVEK2JsMUtDdGlGTjZVSEZ6K1ZjZVBtd21FMzNUNHdqOGthOElU?=
 =?utf-8?B?WE01Mk5GVlUxemppNmFNbzk2NHVqVGZRKzBGK0VwVVBYcmkxTkEvdWJySGhT?=
 =?utf-8?B?VzdXNHlueStsdkxVTFd1dVNuYU5KV0ZuQWZudFhyYXJIZ0JYU1h2UFUzSjZY?=
 =?utf-8?B?NHNlYXQ5V1JEMHo1OEg2TWdvOFJueHdPT2MvUTRSZW4xYzBoK3BsL2d3anJW?=
 =?utf-8?B?dmVCVmRkL1lCVHQ3YjZhVVRTbmtBOW5BR2VpalpqK1VQbDVPU2JydDJZbEQ5?=
 =?utf-8?B?TjROUkJZNzBYQ04zaUJNYnJaeGpaK2RPVXgydlpVcU1MN2FyeklObnZGOEFI?=
 =?utf-8?B?Ry84T2l6RVNwRXVqSVJKYkh3OFJBeVRjdHFFMzFRWVBQaHE1MmxSVTdENVZt?=
 =?utf-8?B?Y2t5RmgwL25LMmc3S0dPK0V0Z0pQcjRQcjFJem1WeTNlbVU4Nml4ZFpGb3BO?=
 =?utf-8?B?ZFpMNUd5b3dpVnhTanZPbGEwNlJFWkRMSWsyZUlmUE1JSEpVYXpaVHF4UXlw?=
 =?utf-8?B?aGVsWGg5ZWhHNzJZcmgwa1ZWcWVmc2craWZza0RYMFBabStMdFhZUXVNbTBa?=
 =?utf-8?B?VFl5RkpTUWpXN3FVQW43RnFSeTR3cG03NkVYRHZRbGJRdHo4UTIyN3JzaHBU?=
 =?utf-8?B?bkJtb04rQTNlVnFBWUZXUkZxU1BPUmFtd1N4ZDZaTDFUY2xBRGFYN1VUVG5L?=
 =?utf-8?B?WGxFMzdleThIdWVZbThtS1d2OXJJeHBDRmlqNUgvZ3FDVFZNdlp0Rm9weTVQ?=
 =?utf-8?B?VHBSUmd3SmNlVG0yWjJTTlVHWW9mcTIwVm9jRUxEUmp6eXRDSXAxcS9PL2Jh?=
 =?utf-8?B?SUtUVHNDV2owOVh0R1NSbGtZU3ZqUXNlT09GeHpMSDllK2tUYkp0dXl1c1lr?=
 =?utf-8?B?SE16VE91MTd2RHhpUWNaeDBDTk9KYUdmdzRJaUl6bTJTWS9VRzhpYWMvazEr?=
 =?utf-8?B?WnpsNVV1ZG45cmd2dUJKV0V4d0dYM3BkR1d0aTJrUmVqS09FZVFFd1NnaVBX?=
 =?utf-8?B?cmorejRFQ1QxcHh0NjhzU2h6TWVYaGxXTE1VcnhsQ3IvMXpQeVhaKzJtM0pn?=
 =?utf-8?B?SUVEbjFGeE9QZDVLTHFoY1JQZndkY3YyZGF4b21SamxDVytGM1dua3FoVSta?=
 =?utf-8?B?L2hMaVpwbmZNV0xEc2FGa3BiV0ppL2VZODJrVlMyQjV5cENYRG5Ib09DZDlv?=
 =?utf-8?B?c0NuWHhkMVFpckt2V1YxYThEVHNPd3paWjNiVm1VOGYvZUMrYjMzOGNMUWJU?=
 =?utf-8?B?UUNGUnEwNlFneVdYVGFOYURJL0dvZ3p3MHluWUk1eW1qRTErOEs5eHFsZVFR?=
 =?utf-8?B?MTZFaEl5U1ZaaWlWNUIrVVpqQlFSY0tvVHZ0T1d6TDRBQ1o1Nm1pVmR2ZzJT?=
 =?utf-8?B?aGZJQVR6NTljYWI0VkpQL1ZNOVpxLytmQ0VQZm9IcG8yT3J5Zk9XSjI3MDRU?=
 =?utf-8?B?Q2QyVXRpYlY3YnlQdzhoWElUZ2xuOTR5NmZOT2hFMzcyR1ZvdkNoMUt3RUxT?=
 =?utf-8?B?Umo5R2xPamFaaWdublFpUDd5Vks0WmlGVzlqdjkvWEpUWm9hci9TNTdiaU9m?=
 =?utf-8?B?WnhaQjE5RnBva0ExbmtMQlZ1Z2g0V3FKY0hhSlZEOTBwa093UVR4WFhYeHF4?=
 =?utf-8?B?WnRTWU1oK3lvQlVoeGdIeEhRK2FXVXlPc2xRMDBYUTlNekVzNjNZaFZudk5i?=
 =?utf-8?Q?XnFBk5muQ+Nr/btJYvkiXeaW+AOap1uFXY/XZlkKrfB/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec48713-776c-4fc8-54bf-08db300ca3e4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 04:18:25.2269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdPTgqhXmdulkn6FiTOsDNx4GGRRO69FO9PuUBZa5OkInKGJnY+h1iSvK/cqhNm3N60s0FqKZwXvkaCa2SyaLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6780
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/28/23 20:51, Wenyou Yang wrote:
> When the CPU SMT status is changed in the fly, sent the SMT enable
> message to pmfw to notify it that the SMT status changed.
>
> Add the support to send PPSMC_MSG_SetCClkSMTEnable(0x58) message
> to pmfw for vangogh.
>
> Signed-off-by: Wenyou Yang <WenYou.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  5 +++
>   drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  7 +++
>   .../pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h    |  3 +-
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h  |  3 +-
>   .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 43 +++++++++++++++++++
>   5 files changed, 59 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index b5d64749990e..d53d2acc9b46 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -69,6 +69,8 @@ static int smu_set_fan_speed_rpm(void *handle, uint32_t speed);
>   static int smu_set_gfx_cgpg(struct smu_context *smu, bool enabled);
>   static int smu_set_mp1_state(void *handle, enum pp_mp1_state mp1_state);
>   
> +extern struct raw_notifier_head smt_notifier_head;
> +
>   static int smu_sys_get_pp_feature_mask(void *handle,
>   				       char *buf)
>   {
> @@ -1122,6 +1124,9 @@ static int smu_sw_fini(void *handle)
>   
>   	smu_fini_microcode(smu);
>   
> +	if (smu->nb.notifier_call != NULL)
> +		raw_notifier_chain_unregister(&smt_notifier_head, &smu->nb);
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 09469c750a96..4d51ac5ec8ba 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -566,6 +566,8 @@ struct smu_context
>   
>   	struct firmware pptable_firmware;
>   
> +	struct notifier_block nb;
> +
>   	u32 param_reg;
>   	u32 msg_reg;
>   	u32 resp_reg;
> @@ -1354,6 +1356,11 @@ struct pptable_funcs {
>   	 * @init_pptable_microcode: Prepare the pptable microcode to upload via PSP
>   	 */
>   	int (*init_pptable_microcode)(struct smu_context *smu);
> +
> +	/**
> +	 * @set_cpu_smt_enable: Set the CPU SMT status.
> +	 */
> +	int (*set_cpu_smt_enable)(struct smu_context *smu, bool smt_enable);
>   };
>   
>   typedef enum {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> index 7471e2df2828..a6bfa1912c42 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v11_5_ppsmc.h
> @@ -111,7 +111,8 @@
>   #define PPSMC_MSG_GetGfxOffStatus		       0x50
>   #define PPSMC_MSG_GetGfxOffEntryCount		       0x51
>   #define PPSMC_MSG_LogGfxOffResidency		       0x52
> -#define PPSMC_Message_Count                            0x53
> +#define PPSMC_MSG_SetCClkSMTEnable		       0x58
> +#define PPSMC_Message_Count                            0x59
>   
>   //Argument for PPSMC_MSG_GfxDeviceDriverReset
>   enum {
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> index 297b70b9388f..820812d910bf 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
> @@ -245,7 +245,8 @@
>   	__SMU_DUMMY_MAP(AllowGpo),	\
>   	__SMU_DUMMY_MAP(Mode2Reset),	\
>   	__SMU_DUMMY_MAP(RequestI2cTransaction), \
> -	__SMU_DUMMY_MAP(GetMetricsTable),
> +	__SMU_DUMMY_MAP(GetMetricsTable), \
> +	__SMU_DUMMY_MAP(SetCClkSMTEnable),
>   
>   #undef __SMU_DUMMY_MAP
>   #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 7433dcaa16e0..07f8822f2eb0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -35,6 +35,7 @@
>   #include "asic_reg/gc/gc_10_3_0_offset.h"
>   #include "asic_reg/gc/gc_10_3_0_sh_mask.h"
>   #include <asm/processor.h>
> +#include <linux/cpu.h>
>   
>   /*
>    * DO NOT use these for err/warn/info/debug messages.
> @@ -70,6 +71,8 @@
>   	FEATURE_MASK(FEATURE_DCFCLK_DPM_BIT)| \
>   	FEATURE_MASK(FEATURE_GFX_DPM_BIT))
>   
> +extern struct raw_notifier_head smt_notifier_head;
> +
>   static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
>   	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,			0),
>   	MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,		0),
> @@ -141,6 +144,7 @@ static struct cmn2asic_msg_mapping vangogh_message_map[SMU_MSG_MAX_COUNT] = {
>   	MSG_MAP(GetGfxOffStatus,		    PPSMC_MSG_GetGfxOffStatus,						0),
>   	MSG_MAP(GetGfxOffEntryCount,		    PPSMC_MSG_GetGfxOffEntryCount,					0),
>   	MSG_MAP(LogGfxOffResidency,		    PPSMC_MSG_LogGfxOffResidency,					0),
> +	MSG_MAP(SetCClkSMTEnable,		    PPSMC_MSG_SetCClkSMTEnable,						0),
>   };
>   
>   static struct cmn2asic_mapping vangogh_feature_mask_map[SMU_FEATURE_COUNT] = {
> @@ -221,6 +225,9 @@ static const uint8_t vangogh_throttler_map[] = {
>   	[THROTTLER_STATUS_BIT_TDC_CVIP]	= (SMU_THROTTLER_TDC_CVIP_BIT),
>   };
>   
> +static int smt_notifier_callback(struct notifier_block *nb,
> +				 unsigned long action, void *data);
> +
>   static int vangogh_tables_init(struct smu_context *smu)
>   {
>   	struct smu_table_context *smu_table = &smu->smu_table;
> @@ -477,6 +484,9 @@ static int vangogh_init_smc_tables(struct smu_context *smu)
>   	smu->cpu_core_num = 4;
>   #endif
>   
> +	smu->nb.notifier_call = smt_notifier_callback;
> +	raw_notifier_chain_register(&smt_notifier_head, &smu->nb);
> +
>   	return smu_v11_0_init_smc_tables(smu);
>   }
>   
> @@ -2428,6 +2438,12 @@ static u32 vangogh_get_gfxoff_entrycount(struct smu_context *smu, uint64_t *entr
>   	return ret;
>   }
>   
> +static int vangogh_set_cpu_smt_enable(struct smu_context *smu, bool enable)
> +{
> +	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetCClkSMTEnable,
> +					       enable ? 1 : 0, NULL);
> +}
> +
>   static const struct pptable_funcs vangogh_ppt_funcs = {
>   
>   	.check_fw_status = smu_v11_0_check_fw_status,
> @@ -2474,6 +2490,7 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
>   	.get_power_limit = vangogh_get_power_limit,
>   	.set_power_limit = vangogh_set_power_limit,
>   	.get_vbios_bootup_values = smu_v11_0_get_vbios_bootup_values,
> +	.set_cpu_smt_enable = vangogh_set_cpu_smt_enable,
>   };
>   
>   void vangogh_set_ppt_funcs(struct smu_context *smu)
> @@ -2486,3 +2503,29 @@ void vangogh_set_ppt_funcs(struct smu_context *smu)
>   	smu->is_apu = true;
>   	smu_v11_0_set_smu_mailbox_registers(smu);
>   }
> +
> +static int smu_set_cpu_smt_enable(struct smu_context *smu, bool enable)
> +{
> +	int ret = -EINVAL;
> +
> +	if (smu->ppt_funcs && smu->ppt_funcs->set_cpu_smt_enable)
> +		ret = smu->ppt_funcs->set_cpu_smt_enable(smu, enable);
> +
> +	return ret;
> +}
> +
> +static int smt_notifier_callback(struct notifier_block *nb,
> +				 unsigned long action, void *data)
> +{
> +	struct smu_context *smu = container_of(nb, struct smu_context, nb);
> +	int ret;
> +
> +	smu = container_of(nb, struct smu_context, nb);
> +
> +	ret = smu_set_cpu_smt_enable(smu, action == SMT_ENABLED);
> +
> +	dev_dbg(smu->adev->dev, "failed to set cclk_pd_limit for SMT %sabled: %d\n",
> +		action == SMT_ENABLED ?	"en" : "dis", ret);
> +
> +	return ret ? NOTIFY_BAD : NOTIFY_OK;
> +}

Is there a particular PMFW version requirement for this message to work?

Perhaps you should only register/unregister for this notifier when that
minimum PMFW is present.

Otherwise this is going to lead to smu_set_cpu_smt_enable always failing
on older PMFW and the notifier callback will return NOTIFY_BAD every time.

