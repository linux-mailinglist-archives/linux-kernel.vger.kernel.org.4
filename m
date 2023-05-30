Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7267166ED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjE3PZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjE3PZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:25:37 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DBDB0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:25:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8lE+WUBhQxuWSWutqXnCQzC6rqhPTX4ZsZO01HNihUEMzZ3ow1yGr7ApkV5rKRdvLF3sDnGbZPvdcu+K2C3Ldxk7FWyCvAGml5LhPk1Yi0V5vhfJ6TpMJUBGRgeNPh5FydpL0f3J5D4Rp2nsoO/xS2C39arKG29fQARNxBJ3aJk2WB7ciwbbWYXKYD7YLOHF9Z+7qifIjLAy7mmrhBvT9VZlopdsXyiKhSpMET3mBpQmusTcBWrsPWFL8QKgrGpuH5jmHDVF3OUkBTsycjehvm6nZMGzuQG+1tSBPbGE5tIK1VrD3jZ38C8h/smTcpTGNRzLQCNQeUiv+io1Woy7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dnPSg5Ah7MshylwTE6osVTTdoL/t6YgZc39V9EvP3Q=;
 b=c8GVpw3GrXtKBYoXsWvbUZpJlPYEwE7OuqugRHOD7GmUwID1s//z3AEP4iuowOkMUM+otqRV37nLnm6rHyqlpxRR6xg0z+/9quzpJTrVNKkUkn3nCOoW2m8CyRbjSVBPtc9H1D055zdWcsSdxTZT3zzqt8gwYF0Qis98yFCbH84tn58Q/w8ele0jv7zP/9UEVuXGzU7Xa0ruG+vjZ5zZG49TxUhq/WJuZJmpn5kchmUtPbDtPQls75/6ogIoJa0RAnR0CV13NjcxoGHqGHxMWoCpgyUxDskZLS7UAyCBWsG4HickLAmzizlFG8ZKVT3NDMqgFCK30Yg6k3ZMxYLhXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dnPSg5Ah7MshylwTE6osVTTdoL/t6YgZc39V9EvP3Q=;
 b=eSjdZo/XTuN2iyVMy+twD+7ZpXFp/0go+XXQiCQbs/l8okS8r2Quz+52Lpb6tX3ngvdXeiW9YAyw5dcLx4leUfVJo/Ez+xeUyv3AgnD52TSq//4vpBgLPfn1T+mnJnbnDvk86m6rMGJUYOxXG1bwpJXSGY04NaV9H7OMvNBhjAk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 BN9PR12MB5366.namprd12.prod.outlook.com (2603:10b6:408:103::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 15:25:33 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::fe53:2742:10f9:b8f1]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::fe53:2742:10f9:b8f1%7]) with mapi id 15.20.6433.018; Tue, 30 May 2023
 15:25:33 +0000
Message-ID: <85f47623-5ef1-b817-195b-c4ae39564247@amd.com>
Date:   Tue, 30 May 2023 11:24:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amd/amdgpu: introduce DRM_AMDGPU_WERROR
Content-Language: en-US
To:     amd-gfx@lists.freedesktop.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Kenny Ho <kenny.ho@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        Andrew Davis <afd@ti.com>, Peter Foley <pefoley2@pefoley.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
        James Zhu <James.Zhu@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        Candice Li <candice.li@amd.com>,
        Yang Wang <KevinYang.Wang@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230525163827.548058-1-hamza.mahfooz@amd.com>
From:   Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20230525163827.548058-1-hamza.mahfooz@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0263.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::17) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|BN9PR12MB5366:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb5fb18-42a4-49ef-a737-08db61221c14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LH8Y+XBoFEL4UNYAANGBLkMguSJdvcCMaUAUCMqoIQlYmqGQni7T7ezjwPnZtx75xjPGqdkveMbVsFigrYr9Kn30wtJdq4oZUhuAWYDynn9wRfZRNsa51P+lQ5T2im1Jtcm3mWmt/nOhFiw+rG8spC1OgIvydMk558bgcaI9K+ZzVmrIgGqvbiJ2EA7U16T8D4r8UcQ/3vnFSU32iViIWZm9nFMoC1TjbOMqyFd1A8pt4lEXO9OHvAHvJqR1vYsowOHXTcOhCLcpR2SmMzCOydRdyjVCVROAH/nAP7buHNOcsydG0t5T/2710lBvsW3Txnw5t4FArvdYUcjUOYqrcn2aQHbvOgAsXyehaV3H4IMfMZoxExmjbOGFgb8YdvASVQQCFezQt6I/xkPaE6fp9VUA0nQYIVIh/jf95jDUYIo8ahNzi6ubmcfmRxvDYxTweeqXCyLRIk3O8WF7ZMUHZKUFRlsuqSiLl6/i1J8SJC/51+C08fKY0LlaZ6C8iQYmIF7thQ3ZA6x33tu6czFQYbt49O5F9ahPGbvMhuqQLOh8uRbwjxW6OUNtZobG0v7bH6FY+bAjux7OJwwDbSqancVzHV/UJXQMI6i0Lr9wK5Z30K48KoPozV6on1pHJVpAHSzM4BczsgWzlsI1nUdnCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6280.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199021)(66946007)(4326008)(6916009)(36756003)(66556008)(66476007)(83380400001)(5660300002)(44832011)(31696002)(86362001)(38100700002)(41300700001)(186003)(2616005)(8936002)(8676002)(6486002)(2906002)(31686004)(6666004)(6512007)(6506007)(316002)(26005)(53546011)(478600001)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1Y5TUhuZTVMcEdJaFI4ZVB3b0VPZFJiRS9ud0JMOGFmbVJYYTRTTXFuL2xR?=
 =?utf-8?B?cFpQZUM3TkR4YmwrejZXY2pyNFJrUDkzMWJpOVluSHF3OTBSczZMYmdDSC9I?=
 =?utf-8?B?YlZCaHFEZVRSVkhVaisrZTNjMFVNQnhVOFNXNGZqL3hsbm4vR3FwSXBjZUxR?=
 =?utf-8?B?R1Z5L0ZuVUN2M0IrQW9iZEdVRVh2ekN6dUhuNVRjQU9ZWDNjNmhvZXdVejJG?=
 =?utf-8?B?M0lPOEhhNmNoUitJK3JiRUEzVHhoenFzNE15OW9wMXlySmFCejFPRFFyc1g4?=
 =?utf-8?B?MzA1akVyZTFnK0lIOXB2SWlSWnFSdmRrbWVnQ3FpSWlFWjYrQVdweXplYWVB?=
 =?utf-8?B?Q3FwbmZ1bCtlVDMzRW1qd0M5RjBiVFB3Y09odVVaRWsvK21GU2x2V0FTRVJB?=
 =?utf-8?B?UEpRK3lHMnJzZmYwamZGaDFpYkc4eS8zWlo3RUVXdnVjNGZkZHVjT01HVm1T?=
 =?utf-8?B?cVpRa3RmblIrQUlpTGttaUpoQTFxc2lOZ1B4WjdEMTdlaUtyQTA5RG5UQzVl?=
 =?utf-8?B?VytWTW9FamtVY2dWdUY2Vi9RdGR4bmYzdyt6OXBwZDRDUGZYbUVnbWp4NTNG?=
 =?utf-8?B?SkhqVi84azNwbURmaTJmNGVKUnR3TXZOd2w4ZXJUNXNjcU1Zb2pCeG04dWl4?=
 =?utf-8?B?QmpsVkxCelh3QXpmVmFwYXBpL2o0M09jZWlMalZTN0gxU3VkaXNJZ0tSMUFt?=
 =?utf-8?B?V1oyTG5sVTlncGMvSisxMXdSQll1K2I2MWpHYTludVlUcmhHSVQzMjNGNjBr?=
 =?utf-8?B?Y1c0Z0hmMFlKdk42V3hEQStwNFVLV0Nvd1FPUHhTaUhJTDlUQjc1WmRNaEl5?=
 =?utf-8?B?MTdTUEx1Y2FHVFF2eWZiRmRhQUM3a0lMLzBlMnlCMXl2cjc0K0tweVl0c3pt?=
 =?utf-8?B?SVRad0xiT3pzcSsrTm1SWDhUSGVNSGZaWmlmUmZTVWh4bHdqOVRudE5mR3Nz?=
 =?utf-8?B?dHk3c2pCUjRMVWpaWTV5UTN3S3dOOCtDbXRBcGo2MlZWbk13UTMyY09XNW1m?=
 =?utf-8?B?bUE5cUJPY0NXZDZyOGZYYXF4WEVNd1FqYkhLaHdJSXN2dm04T1Jtd1VIaWl0?=
 =?utf-8?B?VDZaenEweCt4bk9oaHAvVi9VL3p1UjBiYW5IQXQzUDlaUUUvRW9USUJhRzZm?=
 =?utf-8?B?MzRDS0wwOTNydE9kUUF3alN3Qnp2Q0l0V1J2dmJZVEZFZHFWUVUrNEZoQUpV?=
 =?utf-8?B?b0p4NE5WdkxYVlFWZmZJYTg5YlJjdmlsNEFneGhqd2kydW1KK0FsdVFYWkZo?=
 =?utf-8?B?YUlVKzZ2RVNDWm5XcC9JRjNBY1BrQXJwMmVzaml3UmxoSzYrUlhTSUlLM2h3?=
 =?utf-8?B?RU5EMS9DVFlzVnh0Q05zOFV0MEdPem5aQlR6dk9rYk9VVjB6TFhZL3RGMTJM?=
 =?utf-8?B?Y3FVcElTRmNRU2lnVmJTZExEQWJMbE95MTN3d0lFUVp6eUhoMTdDOWJQUGp3?=
 =?utf-8?B?RUhaanlTclFLOHhpTU03L29mZVIrWCtTbUxheU42RGVJWjE4S0w5LzNwRlFR?=
 =?utf-8?B?c1k2N1RNZXF2Ny81UCs2YmRpazZxMjFDQVRiMld4MXJGQ1QwYTJRUHdzdzBQ?=
 =?utf-8?B?YlB4bWlWQVFCUlpWOEhWWkFkQTlLL0c3WWFHS1U1OWorYzlDZXpKcU9tdmg4?=
 =?utf-8?B?TUQ0OXlHRERFTlE0OGlzdThtYUozT3hUSFhTWjJ3Q0ZLYlhrdnFYTXpjNHVr?=
 =?utf-8?B?bjhhTWdjV1lLS0ZnRDBURzhsdUtkUXNub1hpZTVBSlBnTm41SDZYUHkvZkVj?=
 =?utf-8?B?ckJoMHFUZWFrMDJPaGVLQUNnb1JqemtyZWVaSjdIdFZMMWVuMU0vOEhoZVh4?=
 =?utf-8?B?dXRGcW9oS041OFlyK3A2anQ2NnRLbEF1bmViazB1QzdQY054VCtSL0k2T285?=
 =?utf-8?B?YkV2NXlWKzJDWWJoODdUTUN5aGdzczVuMjl6c1Nncmg0bkhYcU10NXB5Mkd4?=
 =?utf-8?B?RTR5QnBwUXZlNWtIbUYwcWE2SWlDMFNlcXg4UXVvdy9KYkZndSt5djRiNEtN?=
 =?utf-8?B?ODJHRHN6a3JtQy9uZlVuT1l1czhpOGErdEV6dWJieUlpb1NzY0NSZXpxSHEw?=
 =?utf-8?B?QWYraUUrdjllSDd3aFd4R3RMb0x6WE1sd2xsM0x3eDVtaEpTZVlhaTlhOVNZ?=
 =?utf-8?Q?soHU4UXIy49EGdLbIqg1PKl84?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb5fb18-42a4-49ef-a737-08db61221c14
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 15:25:33.3535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yhFfc9Jge6NZT+a0IDjKQbsSkHwMqzCf8u/yk2zWXZNVW9rkzUiYMQE7/Kl8m4dQOp+voD2HoAUhjWeuwEO8kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5366
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/23 12:38, Hamza Mahfooz wrote:
> We want to do -Werror builds on our CI. However, non-amdgpu breakages
> have prevented us from doing so thus far. Also, there are a number of
> additional checks that we should enable, that the community cares about
> and are hidden behind -Wextra. So, define DRM_AMDGPU_WERROR to only
> enable -Werror for the amdgpu kernel module and enable -Wextra while
> disabling all of the checks that are too noisy.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Kenny Ho <kenny.ho@amd.com>
> Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

I am able to get clean builds with this enabled on GCC 11-13 and Clang
15, at least as of commit e786aef0869c ("drm/amd/display: remove unused
definition") on amd-staging-drm-next.

> ---
>   drivers/gpu/drm/amd/amdgpu/Kconfig  | 10 ++++++++++
>   drivers/gpu/drm/amd/amdgpu/Makefile |  9 +++++++++
>   2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
> index 07135ffa6d24..334511f331e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig
> +++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
> @@ -66,6 +66,16 @@ config DRM_AMDGPU_USERPTR
>   	  This option selects CONFIG_HMM and CONFIG_HMM_MIRROR if it
>   	  isn't already selected to enabled full userptr support.
>   
> +config DRM_AMDGPU_WERROR
> +	bool "Force the compiler to throw an error instead of a warning when compiling"
> +	depends on DRM_AMDGPU
> +	depends on EXPERT
> +	depends on !COMPILE_TEST
> +	default n
> +	help
> +	  Add -Werror to the build flags for amdgpu.ko.
> +	  Only enable this if you are warning code for amdgpu.ko.
> +
>   source "drivers/gpu/drm/amd/acp/Kconfig"
>   source "drivers/gpu/drm/amd/display/Kconfig"
>   source "drivers/gpu/drm/amd/amdkfd/Kconfig"
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 74a9aa6fe18c..7ee68b1bbfed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -39,6 +39,15 @@ ccflags-y := -I$(FULL_AMD_PATH)/include/asic_reg \
>   	-I$(FULL_AMD_DISPLAY_PATH)/amdgpu_dm \
>   	-I$(FULL_AMD_PATH)/amdkfd
>   
> +subdir-ccflags-y := -Wextra
> +subdir-ccflags-y += -Wunused-but-set-variable
> +subdir-ccflags-y += -Wno-unused-parameter
> +subdir-ccflags-y += -Wno-type-limits
> +subdir-ccflags-y += -Wno-sign-compare
> +subdir-ccflags-y += -Wno-missing-field-initializers
> +subdir-ccflags-y += -Wno-override-init
> +subdir-ccflags-$(CONFIG_DRM_AMDGPU_WERROR) += -Werror
> +
>   amdgpu-y := amdgpu_drv.o
>   
>   # add KMS driver
-- 
Hamza

