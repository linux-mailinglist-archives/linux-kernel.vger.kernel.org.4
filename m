Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C236D0CE6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjC3Rdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjC3Rdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:33:33 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3344EFAD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 10:33:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOHYcnZRMTcBmP7kvLD2itSGtBM2KBcfwZtNer8fsOD4guW5gLvQZmB3WOR3KBwyaBTCrdcM/35xlpg8ZYIVd4MJiKRkZ7Fzm0UR7RNI4/dvKPhynFk5re8Lsa9ERPgJBYZiLySpX1ufOhT2wnrD+09jVewYQqFO4q/S294dDhcQzi2rJ+4krXX9Zt6WJuzAuAzqXPc++RHPvdvbCIN7T2Mnak72NwyD3HE4WqGrWLjHteXB957x71l70uX6ngJLnwAnAgrx3w24L1fmZ7OfO0L1GI9FoN/pC9/03l3aoyIqWh2eYq9a8YNrUxjf2H6Wlk+GyZzzFCaE/N7Yq8dSpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aChf9SlXY6L7EEzippndC07BkPncWnRPSNPsh9xjGBg=;
 b=YSh+j3azmGaX0qvgu5ontefnM3IH5U9Ry5X+Va00h+kefnE4AuwK84t4XHFaotg+6Mjqxvfga5FwcKeOuA4UR2vy1B01FecnYl/yGfb49IyzjnLG5GXDW9xbQOsZIjvN3vclg+iERU03EvqapVNzoIF30XSOlhZHMq4/SriYCS/8VCNAOcks1495ZIivqXbxbH8BW2DWsLMr1WatoLpLrN0tAy/Dj2xogEMl5o3Yxa7jb7vEkgaksVNbuHmPZwbv7a4K7IBtpDvqZ6EHZe+G+WNJ7aN5T92wc6e207KapR3Cw3m3fbpovGQIV1U34nVMmV1Esohjq0GdX06che2rzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aChf9SlXY6L7EEzippndC07BkPncWnRPSNPsh9xjGBg=;
 b=0opRm+CkN2nEFAB/E8IkZPpa4gFPOLrfrEG9UwdzYgLR7LQ9yJQIga40A7eajwlEC/88+CikiNXUsuxUepmFkF+3GkHNzypPowGkcWTBA++FPRXlGtb1cAluCltYswFrqRFVoixzcnTvO5C2DVzj4VIgbpiGA1+4apWRzh/vDy0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 17:33:29 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::3490:de56:de08:46f6%9]) with mapi id 15.20.6254.021; Thu, 30 Mar 2023
 17:33:29 +0000
Message-ID: <f826dd28-0213-b7ea-494c-8c7a0ff348ce@amd.com>
Date:   Thu, 30 Mar 2023 12:33:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 3/3] Documentation/x86: Documentation for MON group
 move feature
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>, reinette.chatre@intel.com,
        fenghua.yu@intel.com
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, eranian@google.com,
        gupasani@google.com, hpa@zytor.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, skodak@google.com,
        tglx@linutronix.de, tony.luck@intel.com, x86@kernel.org
References: <20230330135558.1019658-1-peternewman@google.com>
 <20230330135558.1019658-4-peternewman@google.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20230330135558.1019658-4-peternewman@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0439.namprd03.prod.outlook.com
 (2603:10b6:610:10e::8) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM6PR12MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: 2081f77a-ce3a-43a1-427b-08db3144dff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M/umWJI6Cnyc1fq8XVhf9Guh8uH1VbbUYLi/jn6UR3TEys2cyfUz9cuEGZqGZ+R6NT8yN2ACc5OP5XtQvU5lk1daFDVsPxA2rP1/K+9ZEyKKeE3ZodqIqqTtlm2XVkgrvM5pE27g98Zqpa4PrKEn2Zuch7aRsXt9UBdt0R3xq9Eq3fncfzV7U0C9Veglm+pcKTYqqaR0fQRthXIPpKMu10C2uMqRQj5I2bIuXyNuzcY4l08HAwxCAmQzL3hpebZG55GqkEB6IM1uUdbkXwEoewYMO5PIevqlNHqumcnPwbYReTd4ALCe4U4J67FbS5IOXJDQVSIH3noWpRDP8eirFQSobDCRkwYm1q1pUINgA7Tnf+n9UsxoGnJ9MI9Rwidzm3YoXr7x57z9qp6g7t3Qs0LZGZuTxnBnv/QYxm/ET7oiNCd/3L0GObINr6pvqpQUcfV9NHbVWJt26prW0CencBQEvlJTBhGZgnXrlgTkmv1FwJYiXaxMkhhakFldfUY2V7U6G5nGt7cfn8BN99+rbC9dtW9YNvXYKPsbYtyChcUcyRU6ssnj1NtD7i6y9d3bYlOxDOGnhR4Y9+93yd9x0EmwkTdFzvSbLs26vrCWDeOMzpeBDPAfqPDiefpJlodgLyxqFhUTh2uIhP6dlh4Glg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199021)(2616005)(186003)(31686004)(36756003)(53546011)(6512007)(6486002)(26005)(6506007)(6666004)(478600001)(66556008)(4326008)(316002)(66476007)(66946007)(8676002)(8936002)(86362001)(41300700001)(38100700002)(5660300002)(7416002)(3450700001)(2906002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3RpakgxTkQ4dlpabGhsajZ2V1NHcDZyRjlrcUNMeFFmZlVocTFXYnc4SjIv?=
 =?utf-8?B?TEE1T0RxVXFGSm9rdUxQR3lVYXYvUVRlaHZtbEFDMTNHNnhySUdmTkRLZ1dJ?=
 =?utf-8?B?ZnEvekNpZUFPbGpXWDVzOEtFMCsxVVVDNWUzcTdmRFlYNFplbmk0L0hFUHMy?=
 =?utf-8?B?VXpOcmExdFNDMU41YjBOSHAzVlhaZndCRWU4V1Y2amNGYVgzN01GVXhkbi9I?=
 =?utf-8?B?RVFOdmlBOEY5TTB0YzBJQU9xZVNIQkRWSEZDSUNZY0I3dmE2ZysvV0JqS0ln?=
 =?utf-8?B?MFgrZzRIOHBSWDRvMS9NSkF2SW1oN05xMzdlK1pJZyt5QW1wZ2d6SXA2Q1Mz?=
 =?utf-8?B?YTVaekROMmNsVGJqVy8xTjJBNUJMa2gwK0swMHo4SjFROWdacHRNNXZlWDZn?=
 =?utf-8?B?dmoxL04yVVlyVmN4S3V3cEpwS1IxMVJNOHl3T3lRVkVlVFBnbVpKUnJtZjBj?=
 =?utf-8?B?TG9DSUVzc3AzbTVZNEIzRW5yTXFxeE5WUTZodkZoWlE4L0E5bGpmL3NuMlY3?=
 =?utf-8?B?Z2pjalVHWklvSERqZGJzT0VvbThVNVdkSHFoc1VMREsvWHUxeVlUSkVBaVRs?=
 =?utf-8?B?d0gzOXJ1UmNEZ0htamgydW5HRHlFcWVQSDROZVE3YU5ldW9adnJlUFlmSHFi?=
 =?utf-8?B?SmpUYnY1c1JTaFVZdXAzK3RBN3dJNW9acXMzaTJHRlJUdm1MR1QxVGhsWUJ3?=
 =?utf-8?B?d0NkSjNHalJrekQva2xCUVRPQVBMTVVTOHM4aWs4MlJmMW8rUUE4L2M5RmNT?=
 =?utf-8?B?b3M1VDgwem9mVDZqR29HMGc5eldiUFA2QmpaNUZCekhkYVNQb0hCZFpFRlE0?=
 =?utf-8?B?RklsVmNnb3ZZcmQ5SmRHS1FzQWlXR2VKQ3V5L2NGS0wweElkWldXU3UweVVB?=
 =?utf-8?B?ak9VWGFtaUs2Y2tLeVk4OG5Cd2MwNjlUdGtoTUppSnI4WUJ4UzlNQSt4Z0lR?=
 =?utf-8?B?OG9jeXdZT3FjVldHOUk4TWZoQVpPM3I3M1daU1pRaXlTdjJBMHU2OWVraVRT?=
 =?utf-8?B?bFd0aVlRc1BRTE5oOWU5MGpEWWlNL3RYNHN1NVVQVjQwTERhSHdaTGNUQXF3?=
 =?utf-8?B?dWI2L1I0TzBTM2IzL0ZPbEwzcVVIMlBHUWgvTHdJT2c5cWJNUyt4RU5qSnVy?=
 =?utf-8?B?V2hhSFdJdVc2Ym96ZXowVDVmcnU0RFNyUmlwZXdGb2xMdUlQeGRhZko3Q2hK?=
 =?utf-8?B?MzRXUEpGc1BPZnpwckVPaFh2K3FZMHJhUWsxK1laVTRoU3NLOUlsZFBSMUpK?=
 =?utf-8?B?VDlYTGkzb096Ry9mSGVpRWZKK1UrZzRUN1hCdTNZNVd4bWRYbVVtSUNHazVo?=
 =?utf-8?B?RUhsZ3F1QjdUK3B5cmZnYWFQY2diWjJwMzRMUWpWRXdqbVFaSnFvMzJmNFRH?=
 =?utf-8?B?SGV4Tm9iRDhwajFvRFNxelRESVBtYUgzTzQxSTl0NUYrL3NJbHhOMlRtb3gz?=
 =?utf-8?B?VVNKVWNUL09RTUNPSXE5ME5YcVhoWVN2UWhJb0Q4Nk91c3pxTlQ2MExITVlX?=
 =?utf-8?B?M2NKR2dSdzFjVnRKWmk0aDBqYloveW83S2RnNzUySjNTOXpsRUp3dTJJTGdO?=
 =?utf-8?B?a2JQS0N2b2FUQmU0R3FneWc4WUhDTGoxd3BBbVJJK3NwdER5eURZSEZ4Z0Y4?=
 =?utf-8?B?aG5UbDNraXkrdUtkb0dGWlk3NU5rK3JJaEJGbFJTT1o5aEVCOER3bkhoMG9m?=
 =?utf-8?B?emNJTzAxMTArcnE3cXJqR0lNang5RzhqeTBSTWtLZ1BmTUtSeUpmSXZaQ2tK?=
 =?utf-8?B?YldPb0g2UHhWNlBZcnRxRXc5R2o4aERwZWRkMnhQaXdZODNQMWEwZkYxMXF2?=
 =?utf-8?B?WEl0NVJwVjArNTF5U3FOWWhicnVDeGJlNFpZSnFhay80Z1d4MCtlWnQvL0wy?=
 =?utf-8?B?bGx1NzFMU1dCY1BiK3U1dElqclAvK2tweWR2NzZGWmM0VXlYRWh5N1hJWjRJ?=
 =?utf-8?B?RzVaS0hob2xZWTRSUFF1MWNvMHBWM2J4Vi9NNUZCZzVwc0FWYjF6U1dJNkxs?=
 =?utf-8?B?YW10Sk8xYzd4eFRoaTc4ZmpPemMvLzhrRjZCcGZUbVpOcTNyczFUenNzdGdG?=
 =?utf-8?B?SEZRQzVGdjF1ZWkrM0pVRjVaTW40K3ZKa2tsTVQ0dXBSRzNMeG80ZkxZTDB1?=
 =?utf-8?Q?d7I5j64+Wr1Z6kGbTLeg7r+mP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2081f77a-ce3a-43a1-427b-08db3144dff9
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 17:33:29.0126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t3TqbC0lsd3oxCUaE5ZfszZ6M2ACgozeRYV/ZOY3pxYmWP2Ly0eJ057MLIseBgrO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4140
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 3/30/23 08:55, Peter Newman wrote:
> Describe new support for moving MON groups to a new parent CTRL_MON
> group and its restrictions.

Sorry for coming in late here. I am planning to test these patches. It
would be helpful to give a simple example to test this feature.
Thanks
Babu

> 
> Signed-off-by: Peter Newman <peternewman@google.com>
> ---
>  Documentation/x86/resctrl.rst | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
> index 387ccbcb558f..cb05d90111b4 100644
> --- a/Documentation/x86/resctrl.rst
> +++ b/Documentation/x86/resctrl.rst
> @@ -287,6 +287,13 @@ Removing a directory will move all tasks and cpus owned by the group it
>  represents to the parent. Removing one of the created CTRL_MON groups
>  will automatically remove all MON groups below it.
>  
> +Moving MON group directories to a new parent CTRL_MON group is supported
> +for the purpose of changing the resource allocations of a MON group
> +without impacting its monitoring data or assigned tasks. This operation
> +is not allowed for MON groups which monitor CPUs. No other move
> +operation is currently allowed other than simply renaming a CTRL_MON or
> +MON group.
> +
>  All groups contain the following files:
>  
>  "tasks":

