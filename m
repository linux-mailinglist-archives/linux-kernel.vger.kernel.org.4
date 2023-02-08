Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB2C68F458
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjBHRX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBHRX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:23:27 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E6D2C665;
        Wed,  8 Feb 2023 09:23:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEsRjOAhUPYRJHcFhsH1B+gy/f5IhnF0fYPF0W3RLvhVRJ74kiN5v/Px/GFHpVDNysKR4aTCfhiFxYJWf+Ovskfa0HOh5a8W8tj+SJHrlajKqy7gMSpWvJB4LyquILg+7/DKQCgOdWLpn0m9LoRpMMAioG5aIH7ir+3kh3NHZJvcQMD2beZPRGKBMcfge2C/4c2HXKHlTYch5hJmKsEkNUzc1LmLbD1fI2tWKn2UBQFim6qvnhTIazEdvKKTH1ttmFmgkEYyo8UR9yAUuiSqXIKkSc4L+g4K295Shi63FIlMPaQHTacvAkKimJWdhy5SdxZkBvq47nmpVfPZ/F59Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3HNotVm0//elBHC9sb+StMZMLNE0N45VrniG0O7IHZc=;
 b=NK4etEj63u8mZPQ0wSmY+2dAssF64MqbheMEtrMTWGrAOvC9orICVrX1CI6nHWbMMU0sSGENMOwYRyUubALUYHdY79ZGyEEsGrfrOkDQiNfQXOWXtLwE8gQmzwUNO9Bes2FAs1SashS6aOhZ7SblIqH58RxD97uCI2zSX+6LI1loR5TrV+Z+3rwzrzbpw0XwKu/Ag3F361ksJ+3B18Kw0XLEYLslplJfSOvphngROcSpD4HsU5ABwwGpiKBgsnZWJEWlzrm6mEL7NvZlnNalbC8NClE0vPitlh1+WURFfFGqjo+wwApRM/cUBQ9Csoe5P09AOU2J1wtdksPAbO9r9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3HNotVm0//elBHC9sb+StMZMLNE0N45VrniG0O7IHZc=;
 b=l5MNBIffumCTHsZbsFBX9VGzBOrJBi3JcCA40Kn4Xg4+/dlhZZlEjfYUSZy+r6nbyDc6CyufJepcfNQbRZDnpfhE7rJ7ljfOs9L3AyT5HTxTLAme+PHayZqFPs0maFUBRiy+lqxJ3ICxtAzPtMASkoISsGOEkcrEMSxlwNTE2G8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by PH7PR12MB7330.namprd12.prod.outlook.com (2603:10b6:510:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Wed, 8 Feb
 2023 17:23:22 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::6cc0:9c7a:bd00:441c%5]) with mapi id 15.20.6064.036; Wed, 8 Feb 2023
 17:23:22 +0000
Message-ID: <505e7b7c-11dc-b932-09b0-93b47b031750@amd.com>
Date:   Wed, 8 Feb 2023 11:23:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 6/8] crypto: ccp - Add vdata for platform device
Content-Language: en-US
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        linux-crypto@vger.kernel.org
References: <20230123152250.26413-1-jpiotrowski@linux.microsoft.com>
 <20230123152250.26413-7-jpiotrowski@linux.microsoft.com>
 <6f76fe2b-63ea-8c45-87d8-3de30d3d76c2@amd.com>
 <20230201192409.GA14074@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <b4b8e49c-ea5d-916c-5808-7c6aefa44dd2@amd.com>
 <3ed3234e-e811-71ef-41f9-d7999066b62d@linux.microsoft.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <3ed3234e-e811-71ef-41f9-d7999066b62d@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0094.namprd03.prod.outlook.com
 (2603:10b6:208:32a::9) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|PH7PR12MB7330:EE_
X-MS-Office365-Filtering-Correlation-Id: 7452d821-5003-472f-167f-08db09f92de0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DHIVeBMJ+foFpWbXDvZ3I56kBYAxEXyUttbToKbW5WVpzfZpvrH9XkDlcNFliHW1kOQQIncsDa/q8S27T1703XBXciF4HqxRoeG2QQZOPCdspGmS1No04vOESqcZtuGgutP6SNpEeICrcnJsPvbFMWmcq1jG6utaK42eAm99I2cDWo5tjcABWLaniuecUkGSVa9z9oeYwQI5FiZmn+iCvWqBnmxa7mbeAPouHS+ZwXI/7hQfMNnZh0v0JW28TFO9AtJ8GcPuovZVm+L4hFHSKZiUxZYP8WWOqcvK4MAPMGd+NFtmO8JpSwsmtkici3um5oPJYDUmhsWz7yq27wU9acX3Q0U8q8jo5dsMiFMzEe5FAU5vjO8E0iM7Qgg9MhF9YW/z5mzYxM/ef5lmj1zVN04/cghlp0YKW2wb1wMxfdccfvSNPpszNYjwefvK8UiGbNXeN0XGfa3GDTaYY+6B8YrpGXCG10gJEkasEEHvsJxw9SQ2FBijdnLJetlPALlx4iItBi7Mzda1BcerVQV6YkQKqCZcJ7J5pKIOG1+izIBO7QSO+u47A6pZZiJkL9kTwX9OltDRa75ySzlzJYw/LkqDsn2FGdEpCnEv67LEra6Cn++YdlTAdGW1hKvs33zaJW7gyYZbXHx/PJM4GrIg7jRQlSzu0FzncFX36SFJ1ARSUyWY+cey3UgdfGu+8tmooL+r5PY0b+Xf5+pS9Bas8catn3I+hcAfnHLlTb55zwI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199018)(6506007)(6512007)(26005)(36756003)(53546011)(186003)(478600001)(8936002)(66556008)(8676002)(4326008)(5660300002)(66476007)(6916009)(66946007)(38100700002)(41300700001)(2616005)(2906002)(86362001)(31696002)(54906003)(316002)(83380400001)(31686004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXJFN1FrbCtLZTlNTUduSFM2NCtDNSt1NllPRWoxZmJaVWtVcHlrWFQ0ZWxp?=
 =?utf-8?B?NWEreGk0b20wZ1paNk9yaE0reUErSTJWdXBZeHloMmpOSUYvVFJvMzNTY29C?=
 =?utf-8?B?YXNNSE1XRVRXSnlTem9QaTV4VkYxVmVIaWEyTUhuNms0cTJkVitoTE5JelUx?=
 =?utf-8?B?dkJ3WVBaaEpuc0FUTzRLVjFRUFJnek5kWGpWcDhsemJWVmhUUDhiTlJON0xQ?=
 =?utf-8?B?RU5kTUcvamY4YXoyNjFFdkQwbmRONDJ1UDMyS0lPYVFVVU9FdUdtVWQxMHha?=
 =?utf-8?B?eWROekZ5Z3NCKzUzNStWRzJpQmh6dWRQNTRKTVVXY2hMQzgxMFoybDVVRC9L?=
 =?utf-8?B?bUYwRlRpeTRSNXdyK1VReEM4bDNDYnFyYkFVMUhRL0toNmxQT2M0MThsdHBj?=
 =?utf-8?B?bGFrTnlnVGJrS0VEQllHNUhvZi9IMVlydnVTMWdBWTlOUkNnaUdRN0R1R2ZQ?=
 =?utf-8?B?TVVHOStUOU9IYmJlRjE4YVlyc2VMNEVGTVFnaWJ2a0NqdlZNNXg3bUtUN2pG?=
 =?utf-8?B?VCtQdUFvZGxDNzg4dm1tRnNtV0pXM1VXVWdwMCswQWR2bUk3MjF1KzJlYWI0?=
 =?utf-8?B?eW1pYUNiU09kOVBZZm1uVkdyY1hyNXpsMFF2aTFlWW55Y0w1c1JMQmZCSlRq?=
 =?utf-8?B?L00vNmZlVUZOSXYybDU0bE5CZlI1aG1jZnRUejNPem44NTRlWnlhUTBBcUhq?=
 =?utf-8?B?MEJoeTV2V3hTc2Z4ZXR2Ry96WHV6aGZUY2t3eVZLajdKK3hRV1JQMy9EdHVI?=
 =?utf-8?B?RHY3Rm5qTXdSU3FaS2pFMnZnN2tnNkp0R1VVeWt4VTJ4b3JzZjJJRWcrNGJV?=
 =?utf-8?B?V3hFOWRRMS8vRi9XVVQybXUwRkVkSVQrYTg3VjdhV2xxRTBlUXpaV0JiVDh0?=
 =?utf-8?B?YVFxN3dtZUlRL1YvbzVoVi9VRGQ3Y0dOUDZKMFkveVpMbzhHdk0yWlBUR0Z6?=
 =?utf-8?B?SEtDYm9BdTluV3N3T1BsSm5JNjY3ZHhDdk43d3dtenhuY2dHdHBBUTZoNXo3?=
 =?utf-8?B?NzZnbTZncjN1QWtrZmhiSjFUNGxtMjdrdFEzcGxYV2VnYXR2U3R2UHdRcnRh?=
 =?utf-8?B?bXZOTDhRdDZLd3IzWmxZUFQwb2gzQkRYTzYvMm1RZDQ3bXlyUlp0Y2M2Smha?=
 =?utf-8?B?Q0NqSTRTVkxoNTBOWGxTeUxXdXdqOENEdG1KOVRBVDBXZzZSckpXUlhNSHFW?=
 =?utf-8?B?c3NKbFZCaW43ZElXZFUvZmNzK2d3Yk9mN085d2RVSHc2VjVQTGloQ2V1VUlN?=
 =?utf-8?B?ckpneW5qZWNRQ1N1SlQ1ZGNhNWRQYlczNFlYdHZZSmZqcXB5OTE2UmJ1dkVO?=
 =?utf-8?B?MGlsMEJzWVAxZnpncjNBL01CT1ZhZkRya2U4Y1dnVEVOcFQ2SlBIaC9YYVp2?=
 =?utf-8?B?RGNwU2VwZFd0Ri9XN0RvUmk2YUZ3ZU9VWDRibWIzWWVMUEttRUdjSldOUWxq?=
 =?utf-8?B?RURGSi94WGhzclNDclg5UHB1Vm5FVk82TG1ROXZNS3QwaUdncHJidW5jaGtw?=
 =?utf-8?B?Uys3akhYVUdsYW1GQmdlam9zNkg0S2lxRjJSQXFMYURhRE9yOEtwN29RQnhX?=
 =?utf-8?B?Ry9MbUErU1Npci9ubjNqampvQTczMExKMDZYNG9iMStFZmNPV050QUVXSnFG?=
 =?utf-8?B?YUI0c3dyZEpNcU02eUEwWmxTZGo4YXJqV0Zwa1NVWG1Hc3VZR2NNZ0VqRTZW?=
 =?utf-8?B?T0NnR2F1ZHI0MC9FVWZQVmdPMlpzcTlEdVBBZlQ4UHhwMzh3bGpkQlloNUVQ?=
 =?utf-8?B?VGFZZWc3RTJqMnNLTXk5dTJYbThwY2JLYXVqem9adEVkbVQzc09kb2VmNWJp?=
 =?utf-8?B?RFBEMWpaeXFMODN2TVhObjhBcml2aGhMbXNYUHI0ejN3WkV0NEw3Vm5yUUVl?=
 =?utf-8?B?Qkw0ZnJob2tlYjdsbm40dmZiTFJCalJSa2xFTDJQTlFJRk85aDFocmRMNVVp?=
 =?utf-8?B?LzlCNmxhNnY3OGZFVm1tbnA5dzhkUDduZTFlOTNyWktyUWtBamxPK3duRVFJ?=
 =?utf-8?B?NFkxSG9IMElEVXJIaFNxUzcvdE1HcjU2ckxnUEIxZEd0cTVtbEdlT0VyNzVS?=
 =?utf-8?B?c1lna0dGb0VyL3VXL3VkYmZ2TWtlaUN1TE5ZVDdLTE4wUmZ1Zzk2cnFEcWg1?=
 =?utf-8?Q?VjXJb8v1XGwsJfy9YnS4BYZF6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7452d821-5003-472f-167f-08db09f92de0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 17:23:22.6255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gBhmV7bkhDhaVkPrmJ9JsBU6eih6VsZWpR/3LKdZy92VpWEWdgIEBJVNgM7uwq3wxw+3n0NQ53qrUA50KnnIUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7330
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/23 06:45, Jeremi Piotrowski wrote:
> On 06/02/2023 20:13, Tom Lendacky wrote:
>> On 2/1/23 13:24, Jeremi Piotrowski wrote:
>>> On Tue, Jan 31, 2023 at 02:36:01PM -0600, Tom Lendacky wrote:
>>>> On 1/23/23 09:22, Jeremi Piotrowski wrote:
>>>>> When matching the "psp" platform_device, determine the register offsets
>>>>> at runtime from the ASP ACPI table. Pass the parsed register offsets
>>>> >from the ASPT through platdata.
>>>>>
>>>>> To support this scenario, mark the members of 'struct sev_vdata' and
>>>>> 'struct psp_vdata' non-const so that the probe function can write the
>>>>> values. This does not affect the other users of sev_vdata/psp_vdata as
>>>>> they define the whole struct const and the pointer in struct
>>>>> sp_dev_vdata stays const too.
>>>>>
>>>>> Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
>>>>> ---
>>>>>    arch/x86/kernel/psp.c            |  3 ++
>>>>>    drivers/crypto/ccp/sp-dev.h      | 12 +++----
>>>>>    drivers/crypto/ccp/sp-platform.c | 57 +++++++++++++++++++++++++++++++-
>>>>>    3 files changed, 65 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/arch/x86/kernel/psp.c b/arch/x86/kernel/psp.c
>>>>> index 24181d132bae..68511a14df63 100644
>>>>> --- a/arch/x86/kernel/psp.c
>>>>> +++ b/arch/x86/kernel/psp.c
>>>>> @@ -199,6 +199,9 @@ static int __init psp_init_platform_device(void)
>>>>>        if (err)
>>>>>            return err;
>>>>>        err = platform_device_add_resources(&psp_device, res, 2);
>>>>> +    if (err)
>>>>> +        return err;
>>>>> +    err = platform_device_add_data(&psp_device, &pdata, sizeof(pdata));
>>>>>        if (err)
>>>>>            return err;
>>>>> diff --git a/drivers/crypto/ccp/sp-dev.h b/drivers/crypto/ccp/sp-dev.h
>>>>> index 20377e67f65d..aaa651364425 100644
>>>>> --- a/drivers/crypto/ccp/sp-dev.h
>>>>> +++ b/drivers/crypto/ccp/sp-dev.h
>>>>> @@ -40,9 +40,9 @@ struct ccp_vdata {
>>>>>    };
>>>>>    struct sev_vdata {
>>>>> -    const unsigned int cmdresp_reg;
>>>>> -    const unsigned int cmdbuff_addr_lo_reg;
>>>>> -    const unsigned int cmdbuff_addr_hi_reg;
>>>>> +    unsigned int cmdresp_reg;
>>>>> +    unsigned int cmdbuff_addr_lo_reg;
>>>>> +    unsigned int cmdbuff_addr_hi_reg;
>>>>>    };
>>>>>    struct tee_vdata {
>>>>> @@ -56,9 +56,9 @@ struct tee_vdata {
>>>>>    struct psp_vdata {
>>>>>        const struct sev_vdata *sev;
>>>>>        const struct tee_vdata *tee;
>>>>> -    const unsigned int feature_reg;
>>>>> -    const unsigned int inten_reg;
>>>>> -    const unsigned int intsts_reg;
>>>>> +    unsigned int feature_reg;
>>>>> +    unsigned int inten_reg;
>>>>> +    unsigned int intsts_reg;
>>>>>    };
>>>>>    /* Structure to hold SP device data */
>>>>> diff --git a/drivers/crypto/ccp/sp-platform.c b/drivers/crypto/ccp/sp-platform.c
>>>>> index ea8926e87981..281dbf6b150c 100644
>>>>> --- a/drivers/crypto/ccp/sp-platform.c
>>>>> +++ b/drivers/crypto/ccp/sp-platform.c
>>>>> @@ -22,6 +22,7 @@
>>>>>    #include <linux/of.h>
>>>>>    #include <linux/of_address.h>
>>>>>    #include <linux/acpi.h>
>>>>> +#include <linux/platform_data/psp.h>
>>>>>    #include "ccp-dev.h"
>>>>> @@ -30,11 +31,31 @@ struct sp_platform {
>>>>>        unsigned int irq_count;
>>>>>    };
>>>>> +#ifdef CONFIG_CRYPTO_DEV_SP_PSP
>>>>> +static struct sev_vdata sev_platform = {
>>>>> +    .cmdresp_reg = -1,
>>>>> +    .cmdbuff_addr_lo_reg = -1,
>>>>> +    .cmdbuff_addr_hi_reg = -1,
>>>>> +};
>>>>> +static struct psp_vdata psp_platform = {
>>>>> +    .sev = &sev_platform,
>>>>> +    .feature_reg = -1,
>>>>> +    .inten_reg = -1,
>>>>> +    .intsts_reg = -1,
>>>>> +};
>>>>> +#endif
>>>>> +
>>>>>    static const struct sp_dev_vdata dev_vdata[] = {
>>>>>        {
>>>>>            .bar = 0,
>>>>>    #ifdef CONFIG_CRYPTO_DEV_SP_CCP
>>>>>            .ccp_vdata = &ccpv3_platform,
>>>>> +#endif
>>>>> +    },
>>>>> +    {
>>>>> +        .bar = 0,
>>>>> +#ifdef CONFIG_CRYPTO_DEV_SP_PSP
>>>>> +        .psp_vdata = &psp_platform,
>>>>>    #endif
>>>>>        },
>>>>>    };
>>>>> @@ -57,7 +78,7 @@ MODULE_DEVICE_TABLE(of, sp_of_match);
>>>>>    #endif
>>>>>    static const struct platform_device_id sp_plat_match[] = {
>>>>> -    { "psp" },
>>>>> +    { "psp", (kernel_ulong_t)&dev_vdata[1] },
>>>>>        { },
>>>>>    };
>>>>>    MODULE_DEVICE_TABLE(platform, sp_plat_match);
>>>>> @@ -86,6 +107,38 @@ static struct sp_dev_vdata *sp_get_acpi_version(struct platform_device *pdev)
>>>>>        return NULL;
>>>>>    }
>>>>> +static struct sp_dev_vdata *sp_get_plat_version(struct platform_device *pdev)
>>>>> +{
>>>>> +    struct sp_dev_vdata *drvdata = (struct sp_dev_vdata *)pdev->id_entry->driver_data;
>>>>
>>>> s/drvdata/vdata/
>>>>
>>>
>>> ok
>>>
>>>>> +    struct device *dev = &pdev->dev;
>>>>> +
>>>>
>>>> Should check for null vdata and return NULL, e.g.:
>>>>
>>>>      if (!vdata)
>>>>          return NULL;
>>>>
>>>
>>> ok
>>>
>>>>> +    if (drvdata == &dev_vdata[1]) {
>>>>
>>>> This should be a check for vdata->psp_vdata being non-NULL and
>>>> vdata->psp_vdata->sev being non-NULL, e.g.:
>>>>
>>>>      if (vdata->psp_vdata && vdata->psp_vdata->sev) {
>>>>
>>>>> +        struct psp_platform_data *pdata = dev_get_platdata(dev);
>>>>> +
>>>>> +        if (!pdata) {
>>>>> +            dev_err(dev, "missing platform data\n");
>>>>> +            return NULL;
>>>>> +        }
>>>>> +#ifdef CONFIG_CRYPTO_DEV_SP_PSP
>>>>
>>>> No need for this with the above checks
>>>>
>>>>> +        psp_platform.feature_reg = pdata->feature_reg;
>>>>
>>>> These should then be:
>>>>
>>>>          vdata->psp_vdata->inten_reg = pdata->feature_reg;
>>>>          ...
>>>
>>> I see where you're going with this and the above suggestions, but
>>> the psp_vdata pointer is const in struct sp_dev_vdata and so is the
>>> sev pointer in struct psp_vdata. I find these consts to be important
>>> and doing it this way would require casting away the const. I don't
>>> think that's worth doing.
>>
>> Ok, then maybe it would be better to kmalloc a vdata structure that you fill in and then assign that to dev_vdata field for use. That could eliminate the removal of the "const" notations in one of the previous patches. I just don't think you should be changing the underlying module data that isn't expected to be changed.
>>
> 
> I can do that and undo the removal of consts from the
> struct (sev|psp)_vdata members, but the outcome would look something
> like this:
> 
> static void sp_platform_fill_vdata(struct sp_dev_vdata *vdata,
> 					struct psp_vdata *psp,
> 					struct sev_vdata *sev,
> 					const struct psp_platform_data *pdata)
> {
> 	struct sev_vdata sevtmp = {
> 		.cmdbuff_addr_hi_reg = pdata->sev_cmd_buf_hi_reg,
> 		.cmdbuff_addr_lo_reg = pdata->sev_cmd_buf_lo_reg,
> 		.cmdresp_reg = pdata->sev_cmd_resp_reg,
> 	};
> 	struct psp_vdata psptmp = {
> 		.feature_reg = pdata->feature_reg,
> 		.inten_reg = pdata->irq_en_reg,
> 		.intsts_reg = pdata->irq_st_reg,
> 		.sev = sev,
> 	};
> 
> 	memcpy(sev, &sevtmp, sizeof(*sev));
> 	memcpy(psp, &psptmp, sizeof(*psp));
> 	vdata->psp_vdata = psp;
> }
> 
> static struct sp_dev_vdata *sp_get_platform_version(struct sp_device *sp)
> {
> 	struct sp_platform *sp_platform = sp->dev_specific;
> 	struct psp_platform_data *pdata;
> 	struct device *dev = sp->dev;
> 	struct sp_dev_vdata *vdata;
> 	struct psp_vdata *psp;
> 	struct sev_vdata *sev;
> 
> 	pdata = dev_get_platdata(dev);
> 	if (!pdata) {
> 		dev_err(dev, "missing platform data\n");
> 		return NULL;
> 	}
> 
> 	sp_platform->is_platform_device = true;
> 
> 	vdata = devm_kzalloc(dev, sizeof(*vdata) + sizeof(*psp) + sizeof(*sev), GFP_KERNEL);
> 	if (!vdata)
> 		return NULL;
> 
> 	psp = (void *)vdata + sizeof(*vdata);
> 	sev = (void *)psp + sizeof(*psp);
> 	sp_platform_fill_vdata(vdata, psp, sev, pdata);
> 
> 	/* elided debug print */
> 	...
> 
> 	return vdata;
> }
> 
> with the const fields in the struct it's not possible to assign in any
> other way than on initialization, so I need to use the helper function,
> tmp structs and memcpy.

Yeah, not the prettiest, but I prefer this over altering the static data.

> 
> Could you ack that you like this approach before I post a v2?

Yes, please go with this approach.

Thanks,
Tom

