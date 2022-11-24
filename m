Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2015637621
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiKXKVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiKXKVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:21:01 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20604.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A21146FB0;
        Thu, 24 Nov 2022 02:21:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMpVjjKzBvI4rEM5tVqknMDUOQHiALciZNGBUt3K4UhvzZXCLluFtt2Ah1KaF8fG3Hkqk6mQ+6h44qS4+nEF9sxaB9Lf4q7s22l9SGogIRp7vnNsdZK4hkaMtv+5wqbCM7SzimXjryoM9hEedcrS6Ebt+kJVNwhCIZ7ShE++AstRJF5XTLknCdLhxizdKCRlNTsULAHkxI2CToGnWjONallaS7A+l7/D5/ffwKIZYWc4XypKCkHrpZrX6KBmbamRo4ZxvMHV6u15zrAiEq8xFSMBqq7pybhP+zJwFQx8viyR0geVC68BE98GnjiQNAZViT6vAJtqBfYw6gWq43jNrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXvmhOF7J9qNGdktURHXcsiHx2jfaLu1JzD7N9YoFeE=;
 b=UZuyAq/rSU4ZpnhhITkCxKeN7W24XZF9eifkwbuH24lZ5zwsLSOfXL2zoxZvRYUmm1hG1rzUu5db4KMxZ4VENpAA7ZFWlDFtw0rD++crZ8m0meXUEg/4l+SMo5wmYgB54KgW27IvHc365Zr4luHsj0vNBNLA7ytXi18a0/ObKxAK8Bm4EFCd3zHhdeliW0zTBOczf7ZJMs560s7UhkTWBcnqh4e43RjioQABoqeDRC2tc91qxDvVwFKVsubg+t7DEOjL1vtWv3T8wtCZjmMN/+30O7Jq8BRO9c14j6ayTL4KuvOfl1NkOdtzkrVKZPgefp02ZDm+Bm0i1GyMnMCHGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXvmhOF7J9qNGdktURHXcsiHx2jfaLu1JzD7N9YoFeE=;
 b=HaoYrl5xp80tk1snQ56feR/foiSppchZxLMBX5Zo5DjWjUFZ50yPcOltwJoTSGEXsYCiaxTrJ2/gU6NlpEebNtj6FS6LvveJbZCMf4CK/ZbxZMcGNUZRitWpmNvdz/sLQWI1cv6aVAKnh0OyQo93lwOENw+KGxBxMJy4oNv8y14YuM9m51IBT2iWa2NLVK9oHd76JSPnNVxKiQ0tXxjWgOIyEUJZAPAXfFboewXjfupiuhUmI50rFHQQBPZUorzJ18lVbkPTeU5ndvvcwtxsmOONZd95QJ1rQc69xNQ8T4o2nD2pF4wVdHaEWirJeTSrbCSxloVjJboueOOU5XA2qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21)
 by SN7PR12MB7451.namprd12.prod.outlook.com (2603:10b6:806:29b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.18; Thu, 24 Nov
 2022 10:20:58 +0000
Received: from SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e62f:b3d6:965d:36e4]) by SA0PR12MB4349.namprd12.prod.outlook.com
 ([fe80::e62f:b3d6:965d:36e4%7]) with mapi id 15.20.5857.019; Thu, 24 Nov 2022
 10:20:58 +0000
Message-ID: <df879efe-cbae-603a-1d1c-1ac63ac9c12a@nvidia.com>
Date:   Thu, 24 Nov 2022 15:50:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [Patch V2] memory: tegra: Remove clients SID override programming
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        dmitry.osipenko@collabora.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20221122053103.17895-1-amhetre@nvidia.com>
 <cf5422a7-351a-6780-ff7f-e20bc81f94c7@linaro.org>
From:   Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <cf5422a7-351a-6780-ff7f-e20bc81f94c7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0097.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::15) To SA0PR12MB4349.namprd12.prod.outlook.com
 (2603:10b6:806:98::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4349:EE_|SN7PR12MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: ce42fc66-662f-42b0-ca85-08dace0593e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jn/Us3ebAqPfKpunkZKlcnxzRNsmtDFZ8fGCLfeshWirZB0cVYwDOhkHgXh/16XaHM+6of1iALqT2MKAAmJYEYBfF5zOeC9cQ4AUzUfsdL/YsQz/q8qGsqmTcNDc07aRo4x5mAatRiccdIm4zsjznVKzzCMsV6FQPndENbYHRfSCVJRFmzNzdSvs5LMCMyuhUIt0tav9gYxL6Yz0qIf+ul527IZnRPRQUWyP8A4tdfb65LQRQC7nflvSOdWxCTeuiRYX/k7fV/WUXAcmH3x3IYzhtj1w7TusTNCFC/BPHkFAVJlAyGQLMMtZn0mjE6eOfbhVpzi45YO8UaOPqfDkyAHya3gwr9NU5xAA6fmObGWEXGWgBd6u3Ckv6TwVoXfyA440vCK28888++yyuQsWmsUWF/lCYWgDvYs6YeHe+P2ia0js69x6MABOnL0z3CtboGBdTO68n7nr0Ko15vVZ9JXfOvPeCufnt1yLlkwRdr1LlhP2t8jvrugYcBPYaX+oVbWnZRvj41MX2m+cizeBWnjwLRWoXh/IJyK3E4W9kQ1La+nD0W1ZISYgmLMNuKeg4bqQ6Vx0PiEtT5K9R8315EK0wAZNQ3r1RieC+K2FurNNE5/bqK9LtFgi6UPPV41f7eN2+fQ7eDeXDgd3wj/OHf7bajBtNxFyMwyOsKcbtrOsg1mtZi0Vs+c4dpnX+whJcbycZ3T4cUtHBDv2BvOiOgT6sCY7R4eSInR50XhtiUw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199015)(6666004)(31686004)(478600001)(53546011)(6486002)(6506007)(26005)(8676002)(86362001)(31696002)(83380400001)(316002)(38100700002)(41300700001)(66476007)(66946007)(2906002)(66556008)(36756003)(2616005)(5660300002)(186003)(6512007)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDBlaW5XNnZkUEY4KzF3cXZwRVhhdm80VkhBY0VvZWhoS1FrNnRBSWh3SDJi?=
 =?utf-8?B?YTdvVGx2QjVGTEFld2xNUHE4R2pUOHBzRm41TE5nam9hVCtjUk5uRlhLVExm?=
 =?utf-8?B?amtjT2VpNHlwZThERDY2bDk1QWZxYVhLamhOZXBqbHlrN1Ivc2Q0ejd5Um5v?=
 =?utf-8?B?ZmV5ekNtMGdBLzBDZDZQQ2szV2dsMmNrc3lWWkRrV01YZGhaSHVnL05Tb2M0?=
 =?utf-8?B?a0VOdVZsTTM3OFNiSDdXT3dabnc1dG1xRTU2MC9FVVJydFZjZTFjWHNja2FN?=
 =?utf-8?B?Ti9DOHJsU2lTdDU4NTFQRWFRWkM2QTBLb1NiRDN6Z2hxZlpKWkJmeTVqQWpt?=
 =?utf-8?B?S1o5LzF1bE41TmNhU3cwNkRJd3Y4ZGR5MmlYdG5QUnpMeTlDdlZoMkR0aWFx?=
 =?utf-8?B?TTk4dXJBa1dVU1p5MFI2KzNsZTQrVVIzVkFzSUNONWMvYjZ0bmlsMHB3QnVC?=
 =?utf-8?B?U1Qvdk1wVE9MZi93Z3hWWngxQXFIK1ViVG10V29ISHJoVVk2ZHFYSEMyL3ZK?=
 =?utf-8?B?aXVzVngrMmJkTHRnWGJQQU5YelJ4WlEya1Njako5VXFPY1pmaFB5TWE3MkRm?=
 =?utf-8?B?aVNQU1J0NDZiNWtzYzNobFZwQktCV0FQZEZ6RzkwU1VQR2NYN3BLVHpWQWor?=
 =?utf-8?B?N1plWTdiNGh6VTZqTEJwL0hWUURuMDFDeTV3Mkl6SXI3ODlsdHRMWUlYaFVO?=
 =?utf-8?B?cHhxWjFxZk5NNldFckpJYzFycGxhcHlPR2d5SXRXdGpoRVFzQVpyWDVwMHhD?=
 =?utf-8?B?VlB4emFkOWYvVFdHSDV6WElyWjNjdGZCelEyQndOd0FRZ0w5NjdEUjBwRU8z?=
 =?utf-8?B?cU5YQnIrRlQ4T0lIR1l1QThpb1JRS2UxKzAvNXhlSTZwOEJSamQ2WS95ZHJ0?=
 =?utf-8?B?eHlTSzNBTkFDdmFueU01N1h0YUtYaHpoUG9LZjRNcUtYa1Bkc3k5a1F4L2s3?=
 =?utf-8?B?TGN0dmVSSExyM3NuV0dXVE14VnpWN0dUc2kwYXYyWXlxSVBKL3VFV2ozcCtQ?=
 =?utf-8?B?TXN6OVZEZ1NyMy9QV2dVMlVUMHhHRWtPVXJKL3l3TDNLaFZybENYcVdkZzBa?=
 =?utf-8?B?TXgrQ1VhWVpqb0lzWkFEYVJKTWhPWXcxV3psVzkvWmtoNUxlNXNmV3hVM1Z0?=
 =?utf-8?B?YnRtUnRjcEsyT2ZUbitiTW80c0YvV0VDQlZ3amJMTkhsdzJzU1lIbmxFbFVJ?=
 =?utf-8?B?OXRuZlRzK2NPcnpUd3BnQWZta0ZDcTAzY0NtSmRJUHhQMDZCK2NyZTNGR0hF?=
 =?utf-8?B?NXFNVWI1Ryt0bEVSRFRWRU1TM21rSkljOFNsR1NGQTlWdG5lQ2JIL09UR0JI?=
 =?utf-8?B?NlZhTGxndlR1MXNkWEcySHlXWEl3SG5LOTh4VmxtdGRBOWFSWllHMGd0MXp4?=
 =?utf-8?B?eHJodzJaNCtqNFJETEEvR1d1MUNDRFhqY2l1dm52QmYrVW4vZi9yYmJNNjZi?=
 =?utf-8?B?OFVvNVIwMG9rSkcwODNObTVuN0ljcVNEWmEwN2p0clRVdFRJd0VZazF5VE1W?=
 =?utf-8?B?cEhiaVBWS3lJUCtjTEdkbWhlREVtVllrYWExMjJqUTM5S3NGSlVsTVhiSXFt?=
 =?utf-8?B?QlBIZ1U0QTZtZG14TWRteXdSdURvNjMvQkhtejNMRlMvMEVxbCtRZmNob2Js?=
 =?utf-8?B?QjZmYWY4T0V2dFhodDZUcVV2Ny85cDVCbHBuSWpacU93enVxWmhXL01mbVZl?=
 =?utf-8?B?MVVYVDlsT2p0Y2VjYktxUUNIQWxTdUI5cUFLU3BlTkNZTGtNZXU5S1MrT0hG?=
 =?utf-8?B?UUFMMStsQ1A1Q3dkYnNSRWJobTNxQjI0ZWh3akc1THVZZGRpVHhkNDFNc25O?=
 =?utf-8?B?OUh2K0RibWowY0Z5Y3ArcGFIUkh3dUhFWHBHeDk1TzEvY1NkeU02MXl2Zk1S?=
 =?utf-8?B?VUhkUEZyZkVha0dIV25WdnI4ZGVOMTdPaUZ5cnNXUXFqRkxMd2FLVzdnOVlv?=
 =?utf-8?B?SFZqN3Q4ZzRPVnNjNEdZRHErN1dTMzhDd2E0VkhOQ0p0RFAxUDNuQXhtMTFJ?=
 =?utf-8?B?L1paQXo4dUNKSHowUHR2c3A5MmJIaTdtSzNzNFhxTW1ielNRcjlLYWtmeVdT?=
 =?utf-8?B?Tzlzb3BOTUZzOU42NDVtT3BrdkJaNW4zZkpEQno0TUhSamtIMzlKNStKMGpS?=
 =?utf-8?Q?mrvZDMSDVa2dNhiYC8+XOQ/08?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce42fc66-662f-42b0-ca85-08dace0593e3
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 10:20:58.1134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1z4r33Z0Um0Up6a8IAQpPFETK40cAoCCvH3ThzwIXsJIu8DQdGIdQsqXkTxKqimSNVtF/q0SmfZrn1yPKNDrpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7451
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/22/2022 4:44 PM, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
>
>
> On 22/11/2022 06:31, Ashish Mhetre wrote:
>> On newer Tegra releases, early boot SID override programming and SID
>> override programming during resume is handled by bootloader.
>> Also, SID override is programmed on-demand during probe_finalize() call
>> of IOMMU which is done in tegra186_mc_client_sid_override() in this same
>> file. This function does it more correctly by checking if write is
>> permitted on SID override register. It also checks if SID override
>> register is already written with correct value and skips re-writing it
>> in that case.
>> Hence, removing the SID override programming of all clients.
>>
>> Fixes: 393d66fd2cac ("memory: tegra: Implement SID override programming")
> I could not get from commit msg what is the bug being fixed. You just
> said "more correctly", but usually things are either correct or not.
> What are visible effects of the bug?
>
> Otherwise it sounds more like optimization or a bit better approach, but
> not a bugfix.
>
> Best regards,
> Krzysztof

Thanks for the review. In the function tegra186_mc_program_sid() which is
getting removed, SID override register of all clients is written without
checking if secure firmware has allowed write on it or not. If write is
disabled by secure firmware then it can lead to errors coming from secure
firmware and hang in kernel boot. So, that's a possible bug.
Also, it's an optimization over current approach because it saves time by
removing re-writing of these SID override registers as in new Tegra releases
SID override of all clients is programmed by bootloader. So, MC driver don't
need to program them again.

Thanks,
Ashish Mhetre

