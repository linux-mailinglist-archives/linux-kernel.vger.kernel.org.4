Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68C06CD1FA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 08:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjC2GPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 02:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjC2GPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 02:15:46 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C07C1FE0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 23:15:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDowc0namSWLauELoITnrOO0LYY266Tj+XUxG8e+mra6qHZURK8Mmrc/oDSUS1XHyFB650cQ41Zc8IGeO+EHrh6V/xmpiCwLn3YXu6mr7N+SGrAIJH1eYzzcm/TJ5+NEbyC8zHXVSWeXeI9aY5QcvyAk8v4p+/WVggWUNjIbrd9Im8LFydxYC+ZbO77+M0ZsTGbQiYFBNkIecMojwNLVd9VRlzZFI7gfodYHK/C1LSMcPFncTxiZAqVakevthIXGoJ+jGEFiW5J/zhMkV1hzkl6RkSdnnWyrgVQoP3YsNz5boYMTxL8zPGHahDev5SCWKMO376318kvna0uN3s5waA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LdIteT3aPbWxKlbBNfJtTmbI1j95TE+lPuub7NJThM=;
 b=Aiah4QNX1tqDXoYTxoVPUbZPYVXFa13snRQLWgBsGSs+aJrBpPQ+TBAFFgMkJIMJamHPBMo27b8Z7iSFsqVY68g1Ei2pacQgCRAxFbE0AVeK3z2YIR5rh8fUrs86TQzXycyNXWLhjAYOcWfF2eoFecCpLUAJFmO+15FnOuDZLSPFYFVvIUqktKGCPDsFh7D4ir/mj0vl1yh0h2dKUFAAztiup1IQVEy4mj6jiPrsIiAFaXJsvdTi9JKYc8mIuYu2CAPnL2q0SBOnStvJOCLgKJa9xVZvKNNSlSiD+zEmxjdLdLLj/ynYwKZdQ4kf0gPkn4EUYw30VbwYRmz1cHeu6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LdIteT3aPbWxKlbBNfJtTmbI1j95TE+lPuub7NJThM=;
 b=XbKkgALH1pWm+DRHeHrHUTdkIMUUKPpBqfKGBvVrXRGUermIMeu49xEXGACNL/hcFHXZkZ0+4SM129ktrb+3gl/evc3ts3t/3+FIa/iPOhP3Bvj8QFjN/oRGTiSQcPaTFDNDxrWQkO3HjN1RvakjgFChBXHCMesYJpBfxE60G44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by IA0PR12MB8695.namprd12.prod.outlook.com (2603:10b6:208:485::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Wed, 29 Mar
 2023 06:15:41 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::7dbe:aa65:96f1:836f]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::7dbe:aa65:96f1:836f%5]) with mapi id 15.20.6222.033; Wed, 29 Mar 2023
 06:15:40 +0000
Message-ID: <754c6d00-97fe-d53b-5a1d-eac11d718b03@amd.com>
Date:   Wed, 29 Mar 2023 11:45:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 2/2] drm/amd/pm: vangogh: send the SMT enable message
 to pmfw
Content-Language: en-US
To:     Wenyou Yang <WenYou.Yang@amd.com>, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, evan.quan@amd.com,
        mario.limonciello@amd.com, bp@suse.de, peterz@infradead.org,
        jpoimboe@kernel.org, kim.phillips@amd.com, tglx@linutronix.de
Cc:     weiyuan2@amd.com, ying.li@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, gpiccoli@igalia.com,
        kunliu13@amd.com, richardqi.liang@amd.com
References: <20230329015149.870132-1-WenYou.Yang@amd.com>
 <20230329015149.870132-3-WenYou.Yang@amd.com>
From:   "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20230329015149.870132-3-WenYou.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0005.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::10) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|IA0PR12MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b8e136e-c942-4601-c1d1-08db301d0518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b8NNCcI1G7dZYgKQMhA4/EbuhRTUdjWZo55VoM06bM4Nb7EolWCl24BWU2IsYEY9O8Gh7DOaIcFkuLtop9CsdYJm4mqRfyzlGXxmOp1o8hm/bc3ICqUZfpKLmKqE0YUnXjTrC3bWeO/L4MfQk4dkSk2DEKW3DsidlPI7g+R4xXoSKNP5LmRY2UTBm3C/0z9qDEnOdZHyVqKobUoNhTDQu6bmSiUrO6BvlIo8BiT1J/kVD8lyCm9Vt4XtaT1c5WgBTyy5LAXNLog1nR8eSPv08WRo2K1fgtHHYmlIgzKkypR5MzF/sdSytTqWv639AZoLptIKiJxdSs3OwvOwTrI63Dz8EDJa0vjdSrRd3S81CWJhqzjD+7ffqpvRSXFgjZBeSEm+JKn5xzf/HPIxmU1KUyoJZKqoMzYIc4wwPJUoHqyIe9syJL/IwHK4rTLSGMxhAHEk+uevFxAU1twm+2tOzM1uE6uU9pPXjJvwEx2SmHBEikIkvsli+nLVt9RqqjSypjQ6AH8/wKlphIIeVESL8gBgbAH+C8I+B34jMcFFlTHPOl7C3yV3B9pBYK7j/zSdbNUzj/TxvsOKBBvjGdU7bNRdG/WeTCCvzAo0PzhHQ+SwXqAAiQ0JmXaadNXrtZUnKIlv0ANQ0sAk+1aruyi3r6wurOubbPCgBwGNNr5MIb4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199021)(53546011)(6512007)(26005)(6506007)(41300700001)(6666004)(186003)(6486002)(83380400001)(2616005)(31686004)(478600001)(316002)(4326008)(38100700002)(66476007)(15650500001)(66556008)(2906002)(8676002)(66946007)(31696002)(921005)(86362001)(5660300002)(36756003)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2VwT05ZUXprY2Z5cTFUSUlpVDkwR0JDZTZPTFVtdUJROVJmRjNGWE4xaURV?=
 =?utf-8?B?ZTRkMSthSHV1RmdVRHcrUTNMSGtqVVIwT0ppSmFLNG9KM2twekJTZ2FwdjJy?=
 =?utf-8?B?M1dHZHlmK2hmenpiMTNPZXU2aG1IN0FqTUFjbTUxRE1xTU12cUh5eEQ5QXdj?=
 =?utf-8?B?b2FqT1h3bkIrbVY1Y0Y0N2VKNVAvWDJobExMSXo2ZGNjOXU5RUIwT1pXR1I5?=
 =?utf-8?B?NkJtNk1KdU9lcHh1VS94ajBqMFZBaCtlUzBFd01wZ1RURjZyT2l0cHJ3VDdi?=
 =?utf-8?B?R2pSSWJuQXdIRFdkQVRTMnE0TlVaZm9IcnZMaVB2S2lxQ0dFU2xaYi9lL1M3?=
 =?utf-8?B?Q1V2Q1dGbUZhOUFtOG96aTk2clAwcTlOVFVxS01DTngvNk9pWGdKV21BQy9a?=
 =?utf-8?B?N0ZJWEFBM1BiT05jeGRGTTRxNXJrbWlLR3lCTkdYdTN1aTc0T01BdlpCeEpn?=
 =?utf-8?B?Zi9XNkRneDJySis3cnl4aFRSSDdFdVU5SnMzQ0JEQmpmQTVwZTZDcVFKSkUv?=
 =?utf-8?B?V2tJUkxka2ZWa200V0F4UWFYek1pM0xnRmUwQlhaVGpDLzJXV25pbnZiK2NX?=
 =?utf-8?B?TWErbVZYYlluVndRT3lEV0VYWUhVdTBubXcyTzBvY1BlRzR5M1B1MG1uT0xO?=
 =?utf-8?B?M05HNG54MWI2UGVobHNBRjNsazdjbW55SUlLUTM3dUtCNUxCT1pMSzV2ak5U?=
 =?utf-8?B?OHJJeGE4VjZBR3V3KytXVk8xcjNWZ3ZBWDVaQy9BcXRqNzE2UFh2NVZsd3hY?=
 =?utf-8?B?TThDUUhOMnJwTDdvdkc1SFJ4S3g2MUtISERKbHlUOGFFR2wveTd3Z05wMXp1?=
 =?utf-8?B?R0FUcVZDNW5zUm5Udm5tRjhpL1FTRHIzY0dFRDlwM0J6Y0dMbkxiTU9Pd1JZ?=
 =?utf-8?B?MjRhR1E4RnFqc2tDN3U1QnYwTUdrWlJ4c2dlYzFoMHJEbmR6bWs1cVdKaEFI?=
 =?utf-8?B?L05KRzR2YUVGTlFPd2szd0wydkNONThXNDkzbFc0cit0QVgxaE1pcnlmMnVy?=
 =?utf-8?B?dlA0NUZicENCTzFVck41djE5enZQSWRQTmprQ1d5L3VqeGswQzc3QWExN1p0?=
 =?utf-8?B?LzhnZVJWdTFhUlZVbGRheXkrOGQwayt5b3Q3VDYzNVU4dy9kTUlHenRpei9K?=
 =?utf-8?B?NDg5eUEyd3Z0cnpHQk1kWVBJWWNLY0ZIaVEvRGpQS1pmdFp6Q2hQS3V6UVE1?=
 =?utf-8?B?ZmxpR1FZZHBiU0ZEei9WajM2ZGlDUEprcGhBUERTdmpPMTRqQ0tXOHpZRXdT?=
 =?utf-8?B?MjBDaGE1OWhIMkhlYXo2bDZpc3BSbHVmMWdTZWJocmNOVXJWVXN0dENuSWdW?=
 =?utf-8?B?R21hMWZLeTc0UXhMM25hYS84aUZRUXRlMCt2TERWQXNCOVJkdUNEejdiTkVt?=
 =?utf-8?B?VVFtVHo5c1BCRXRUcjRHWnlENVVnTUZjRWxJTFRmaEhYdUFta1haVXhZWVFX?=
 =?utf-8?B?Sk5saHplRXJBZWp4Q09XaktXaWFiWVZTYlpLRFEyMk1aektVeTUvcWFGR29w?=
 =?utf-8?B?Z0xSdFo1ZWFRdU1XNFd4d3FxRjNVaHV4aGRWZSs4SnlNbzl4OHFQbTErV1NR?=
 =?utf-8?B?RkluWHZLRGVqUk1ab0V4TUNsMkxBR1FaWEJPVnRXOEdISFRabHdIbElMZHRu?=
 =?utf-8?B?dXViZHVINjZzUzJQK2ZSSWhkRm4xZGRaaU9GQlMxOU90SU1jazJ3VklpZEFH?=
 =?utf-8?B?YVdFM0tLME9wWExwS3Mrb2dJU0hZV2d5RGYxSEJLSFljWS8vKzQyeWZVWkZw?=
 =?utf-8?B?YUtSWS9USGZEMjVGYno1dGJLaDlud0dwUDZXc2VOWUdLNExia09NMTROY203?=
 =?utf-8?B?Q0RIWE1ocCt2eUJLMittMGNabjBBL1U5aDdXYzlBaVlVS1dNak81QjhiMlBm?=
 =?utf-8?B?dENYVWx5Y01SLzRaN1phOXlUV3Juam9OL2d1U04rQUdyWWNLU0JxZnphdXB3?=
 =?utf-8?B?cXVnSXZzMmljbG0vUGJXTnZNQ2JYZk5XRm9JT1JFaE4xYjM5TWdrOFdJNWZn?=
 =?utf-8?B?WjZwN2tpV25rZDdMaVFFamhqd3VUOGhHcW5zbUNjREJPTlJRZ1lSc2NJWDFO?=
 =?utf-8?B?SGdUY1doT21HelQwZTAvUXlRdmNYYitDTzl6YmFGUXg3blY3VWdlcWZtYWN4?=
 =?utf-8?Q?B93sX+U6dXt4GeZ/7hXeD66/4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8e136e-c942-4601-c1d1-08db301d0518
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 06:15:40.5419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJOXlCR6QxQPT/HswtGMEEA8PDgpWzZzCTaFwTBT0vNh7IVtRuEZglUhyp/+G2e/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8695
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/29/2023 7:21 AM, Wenyou Yang wrote:
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

This and the one above can be moved to smu_cmn.c as they are generic ones.

Thanks,
Lijo

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
