Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD64862294D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiKIKza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiKIKzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:55:12 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E0027B08;
        Wed,  9 Nov 2022 02:53:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ichvlteQ81usLGug8hCU0l8UR5TS3j0eSqOpDCaKH4KYd7qNB2JaYh572geu8h5OUn0Al6xNUwbSe1j1gKfoA+1bslGQC4qiBUBfX/Jlrty1dppEhkfk8H+SeoNPJkGrBe2i7AcPlR/XW3sg2Xfj82ShFGkSUoq4GR+J6X4W2Mj5oBLFbBa58bVr330W5xLCc2gqSb4RivC/PO5QqmvH9rZ7gXU1NWeXKjuZHZMvRXNJoVhnKlQX9ARb9p/pJj0po6z1ES738xFhbdzcCDu79xmOzuo8hlDcKE1EdLfBjNF8iED5d+4yvddwWNmb4y8WC+RwIxzzdaH9Ejb9klRsLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nou3G/I/oT8qgiy+yc6G5RSH2BLYdgNdK4NkhSbQjqE=;
 b=eNCsVbITkMNPOKkM+MRDVYqlqmJLf364RmhxDlBD+FccWSZR7K1461GHAIu98ao8lQJ1x9YX0JKOfBh78bCybR6Egp2eXQI98BngTrD+AL7mIejT7T8BOdw/Ir6rvFHp8w7mP7I/SJb+/6c5OiIET3AqnGJkVOY54jV9k6xwgrhTWiaXxb9KkZxyagqsjDjXuqAwaM+toQSvA9GbHm8PhriT8r0PTq3gFxrsxHds9UvReEB55YfpVso0mxMwBER/MxQ23FtH1Pj/sCgxxwBLmaVgPHfSTF+iwiRtvbwK0lqUkJwn5vB1LSSLzIqdgT4O9qPVHanwbv+n4DgdKSxQvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nou3G/I/oT8qgiy+yc6G5RSH2BLYdgNdK4NkhSbQjqE=;
 b=leJCpBzRo86GoOOkVMstqP/i1Y4usonqQFjZfHBS3t6ZUfLagcnSIgW/wb0kPlSOTuAad1nlhZ8lCQYKX/PPpgPpp1arY6QSOzGpQp1LGf4nvjYXIA5zGpSGgeNNEO47ETsgtx8pw4l9UOj/krCNUuXsSJ1woaSswq+zDxZGbPI3ItnyU4jt+Q0PtqigfT48ige9sS+ZP3F1Vmkgn5IEhTqu8delHdgp2M+S0aP6sRxkYqOeNFrDtgHJP3xGT4vRZRGMidkdc41VtEQQbLS7aHM3CoCC14mz5ij4wIatPIpv+JtFMqy3ifVRM49LV9JKDioHIGbYOC8tAELBqkEfNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 PH7PR12MB6609.namprd12.prod.outlook.com (2603:10b6:510:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 10:53:51 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1912:a3a8:1a8d:a960]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1912:a3a8:1a8d:a960%5]) with mapi id 15.20.5791.026; Wed, 9 Nov 2022
 10:53:51 +0000
Message-ID: <44a040d5-529e-e4d6-4745-15a6d59a04f2@nvidia.com>
Date:   Wed, 9 Nov 2022 10:53:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] soc/tegra: fuse: use platform info with soc revision
Content-Language: en-US
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Kartik <kkartik@nvidia.com>, thierry.reding@gmail.com,
        digetx@gmail.com, ndesaulniers@google.com, ulf.hansson@linaro.org,
        arnd@arndb.de, skamble@nvidia.com, windhl@126.com,
        sumitg@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1667975179-11136-1-git-send-email-kkartik@nvidia.com>
 <62cc53ae-a615-e138-e22c-fe3a4018efde@nvidia.com>
In-Reply-To: <62cc53ae-a615-e138-e22c-fe3a4018efde@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0003.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::6) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|PH7PR12MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e8cc6c-2d73-4730-aa53-08dac240b00c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RUFi0hWZf4S2Rj2njref3wE3fP4PhformOB+EzvDy8OUYKpFN+Vp6dPIIoGL1JkQJe1igtCSKIubRZK8jqyPWnWWL5ImXMZZVEz/Eek7YYickaOFqhl0AjvohE6NaD+IB0arvx7Jb/s9mwYRotm1R8MGcmikE/uCyEoxT5OUX2C6gAVlzFv8Wli2pXf/OiDcrJR1al3a3Kd73GI3hiY1Oy7qswlc1dUPs13FqVR7TdbJBM5p76jIyyYNQRTKEu//33G53z2jaTQyVJQzZptiIGxbFdUmZjuK7a4LLohGlQm/Cy4MRCE3UFCBRNORc8H/UP0PD+Ib55Q/m9UTPWWpoNWhfCTwd9gJmIdHMv9CXQxHOKtc2dRsIibxu+Av7d0cZPPCrKhXowvYxkSJivnZTlsTpNQosPziPPdZpcIcWMeX64Im6dFimAmRty6PvaJc0e+Xh4fjiGWt5effMglz3+7cZndZ7eYX06mB+FWcDwWxFrAKYRaoWXyuAxKSLMODqrCGmGZ+20WPEMnoISkz3qn/1VxNcFOgyRUG7AiA6Va1N67w36iQ5TmjFxlzZpomVqmcdDEBODPkmRFfaqPGWFeAWvYf40vcJTAGo8TusAIFgNGn274QU3Gon2ZjtuG8LNm823GWw41NTwwtATASg027/Nup47NroOd9UuNaSnOAez5P3gyM+8VQSjxyG1AmKkuap4x1/WoFxAS0B3dDjN+f9balA1z0xKUTIMzBo8pa6g0oYK/DWLkmL8yuqRrX4p4E7fynjfHxAi60YJKMMPcq88oFBtW1CnHHKR5dK7g9aQ/wQaEPRxuOEcUdMgnS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199015)(5660300002)(186003)(2616005)(8936002)(41300700001)(2906002)(921005)(31696002)(86362001)(36756003)(83380400001)(38100700002)(316002)(6486002)(6666004)(66946007)(66556008)(31686004)(478600001)(6512007)(66476007)(8676002)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnJvQ2pjcVBuTXBQdVhhR0xFWTMveWd5ckc3ZTFyZGRDQVNYeFlsYXRrWWZp?=
 =?utf-8?B?UTloekhKOVYxNVdQbDh1MEswTGhxTDc4VWdtL1hRemZqYXZMTEpNTFVtQjV4?=
 =?utf-8?B?VXJ0ZnlJL0ZMV3lpUTFhSHA3S2R4M1NWVHBHS1NQUVhwaUhBYmJFVDVsY0VW?=
 =?utf-8?B?b3VPN0ZlaGZ6OVVLbi9XeUxEMU12U2RvZVJOZ2kzL201Ykh3bWRSNHFiZlJH?=
 =?utf-8?B?TjFyM0ZwL1g3emZhR3pPaXkrRk5RaE9wakxWRU13SklNbGpHSDZZN0l5Vlc4?=
 =?utf-8?B?SWR6aXVHQVRRN3VjUytpYXNZUVFhRjBTVzFlREpLSWZYWjJBeUF6b2l4OGls?=
 =?utf-8?B?S2xkVmJsenlPbWRLWGVJVFFXTkVMQWhIRE9hQzBLL1pMSTVEeEtDNFh5NFBk?=
 =?utf-8?B?ZHdhODFqZVdMcmJmUVY1TFNqZXc0VXViYVBtcjlESE95UzhNVXo4OWdCc1JM?=
 =?utf-8?B?RmpJY3IvV1ZtZFg5RHpDK1l1cDY2T3RUTDZ6N2o4eWNsTCtDNk5iZ2VnN2Jn?=
 =?utf-8?B?eFlOM2wySzUya3NodzFIVlJMMlBGMWtzU1pmUkMvb1BjdnU5OTBNN2pMMTNQ?=
 =?utf-8?B?MHptZjUxTGl4RFM5dFpMdGpKWisray9FYzI4QmJzUUxyN2c0WlI2Z1F4Y2Fw?=
 =?utf-8?B?eS9OSzhMdFRqNU9NbkhOVHJvTjZkL3hkVWFpZk5RdCtLVERMdWI4d2xGaWNh?=
 =?utf-8?B?YmJTMFlaVzVjM3lRc0tJM3FjTmVXTGdFTittNjQ1NWJGWWFkNlFRMVRrSUI0?=
 =?utf-8?B?MFVLNTRlamd0dm03Slg3dUY1Z1VzREQ4aUtuZTFRaVJUN2VTVEdrNW1YSFYv?=
 =?utf-8?B?V1BOTXBWSFY4ZDZtYzlXWnVDYzkvcnh4MndUKy9ERGF2Zm9nQjZCK0VVY1Jk?=
 =?utf-8?B?ZXdURFBSSXpXeTRkeDduQVUzUWx3WHh5WTg0NjRrZytGaURNUUpPYzZ1d3hW?=
 =?utf-8?B?bDB5NVlhS1FsM3loWEFjVDZvTW1wUHcwMHYySzdMYzZZcytNNDZicWJKZGQw?=
 =?utf-8?B?YVp5cnVTSlVRQk9PczZkMjBpd0lIb3BzaDdTOVlDRUQvdTZDTkt5QVRNZU5V?=
 =?utf-8?B?ODUwRE9xajIyK0hpdlgxUys0Nkp0UUVRc2dld3VYbGVuU1E0bEtCVnExRFZW?=
 =?utf-8?B?UzJoaW9wcWxWR2pKM3VDRktUNXA0aDdUSCs1bUhocG9PT1diUHdjYk4wRUI3?=
 =?utf-8?B?dGF6Y3daMExYQncyUUk0UTNJUng4MUlmdVJjWTFMcXRPc0lNSlZWeTViZEVO?=
 =?utf-8?B?N0dnd0dQZVphUUZsKzZxUXdUbVhac25UU012bjNSNGlDZm55cTR6emE3NEZr?=
 =?utf-8?B?bU5oaFlTTFpjMWpQaTJYVXhZM2s1ZTlQTGhjRXdHc1lQS0c5cnhxZXQ2UzRB?=
 =?utf-8?B?amNFV0IzYW10MThxNXZEVEhrdllFN0MrOC9tU2R1S2VaNThSSGI0RTJnWkNT?=
 =?utf-8?B?ZUFScGRwYUJJQTRSQkl5cFVZcCtFbUNoekZCd1Fzb0Q5dWc1anBYcDhxMlJL?=
 =?utf-8?B?VjlpeTVaZWdHRlBneUh4MlI3bTc0ZlBNdGpZT242YW83ZnZLdXpuN3p4bGJo?=
 =?utf-8?B?Tnd6NEkzRHZ2SUl6K2hxTllTc1RhRTF1M0tCeUZUTXRpSm1nR0IrYjA5Qit3?=
 =?utf-8?B?QjBnREMzU2ZIUjVsU3JqaUN2UTVnTHdDa1U4WC9JYldYemJ3bzFqQ2kvVWUr?=
 =?utf-8?B?R01tSWxJWjZKK1RVa2o3QVU2dHRaNEYya25oOWVkUmxyWDZGT0dOb0xXeTk1?=
 =?utf-8?B?TkVnby9uY0NkOUlDZXFIUStCMElQVmI2a2VNVnFrQWxtZ1cxN2h0MWExSXZ5?=
 =?utf-8?B?K0liQk9qeVdHSWxvckI3QkpjQjZwblpVbnJNU3JJcHpmd016QlJIV1RVMWdo?=
 =?utf-8?B?VmIvK0tOZlZ5czZTN05hS292YmF6cmR6THFsWnZHL284aEJ6dm40RUhUcndQ?=
 =?utf-8?B?RnkxTDlhYldVUkxUeHRvOXQ3bEdud3BSTjMwblgyTkJNK09XVHNSdkR6YlZJ?=
 =?utf-8?B?V0hvVEdnMy9DRzQ2ci9BaU1oSHZIQjFUYjlqeEx2dStVVVNNSDVYaVN5bzV0?=
 =?utf-8?B?TFhnK2RmWXEreStNQXBiRnRRRXNmcmVBZVY1dlMzNUs2akhkYm41TjVLNnhr?=
 =?utf-8?B?c1ZLcVRIMHhNV3c3RUpwc3hCQkJFSVc1YU9NL0QvdEp5ZjZJNzZFNGllMjlB?=
 =?utf-8?B?MnhMajd1eEZKWTNmd09TeVdYYXQrZGhyTE10RVIzNjVJNVJBdVNEUGdDaU94?=
 =?utf-8?B?UVd0SDRoeXduUEFySzFSYUFLbkZBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e8cc6c-2d73-4730-aa53-08dac240b00c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 10:53:51.6005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Vo5qYibFRpdKrOiqebBgwu/OC8T8BBqIBiLGvrXXf8c2xkM2nVCkv01so/vjUwt02TYxPE7Dev5IpZFjA9xdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6609
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/11/2022 10:51, Jon Hunter wrote:
> 
> 
> On 09/11/2022 06:26, Kartik wrote:
>> Tegra pre-silicon platforms do not have chip revisions. This makes the
>> revision soc attribute meaningless on these platforms.
>>
>> Instead, populate the revision soc attribute with
>> "platform name + chip revision" for Silicon. For pre-silicon platforms
>> populate it with "platform name" instead.
>>
>> Signed-off-by: Kartik <kkartik@nvidia.com>
>> ---
>> v1->v2:
>>   * Updated commit message.
>>
>>   drivers/soc/tegra/fuse/fuse-tegra.c    | 23 +++++++++++++++++++++--
>>   drivers/soc/tegra/fuse/tegra-apbmisc.c |  1 +
>>   include/soc/tegra/fuse.h               | 15 +++++++++++++++
>>   3 files changed, 37 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c 
>> b/drivers/soc/tegra/fuse/fuse-tegra.c
>> index ea25a1dcafc2..a20c9e0105dc 100644
>> --- a/drivers/soc/tegra/fuse/fuse-tegra.c
>> +++ b/drivers/soc/tegra/fuse/fuse-tegra.c
>> @@ -35,6 +35,19 @@ static const char 
>> *tegra_revision_name[TEGRA_REVISION_MAX] = {
>>       [TEGRA_REVISION_A04]     = "A04",
>>   };
>> +static const char *tegra_platform_name[TEGRA_PLATFORM_MAX] = {
>> +    [TEGRA_PLATFORM_SILICON]            = "Silicon",
>> +    [TEGRA_PLATFORM_QT]                = "QT",
>> +    [TEGRA_PLATFORM_SYSTEM_FPGA]            = "System FPGA",
>> +    [TEGRA_PLATFORM_UNIT_FPGA]            = "Unit FPGA",
>> +    [TEGRA_PLATFORM_ASIM_QT]            = "Asim QT",
>> +    [TEGRA_PLATFORM_ASIM_LINSIM]            = "Asim Linsim",
>> +    [TEGRA_PLATFORM_DSIM_ASIM_LINSIM]        = "Dsim Asim Linsim",
>> +    [TEGRA_PLATFORM_VERIFICATION_SIMULATION]    = "Verification 
>> Simulation",
>> +    [TEGRA_PLATFORM_VDK]                = "VDK",
>> +    [TEGRA_PLATFORM_VSP]                = "VSP",
>> +};
>> +
>>   static const struct of_device_id car_match[] __initconst = {
>>       { .compatible = "nvidia,tegra20-car", },
>>       { .compatible = "nvidia,tegra30-car", },
>> @@ -370,8 +383,14 @@ struct device * __init 
>> tegra_soc_device_register(void)
>>           return NULL;
>>       attr->family = kasprintf(GFP_KERNEL, "Tegra");
>> -    attr->revision = kasprintf(GFP_KERNEL, "%s",
>> -        tegra_revision_name[tegra_sku_info.revision]);
>> +    if (tegra_is_silicon()) {
> 
> curly braces are not needed.
> 
>> +        attr->revision = kasprintf(GFP_KERNEL, "%s %s",
>> +                       tegra_platform_name[tegra_sku_info.platform],
> 
> Do we need to include platform here? Can't we just print the revision?

Actually, printing something like "Silicon A02" here is fine. No need to 
change.

Jon

-- 
nvpublic
