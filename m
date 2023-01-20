Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614C2674CB7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjATFsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjATFsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:48:22 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E331F1CAE4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 21:48:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBHAbZmaF4bQM9yRELfEeTWyQjGg7ckQ/zJ9q8P4IHs7C9h7hQtHmC54mLn5Bmlf4O4Fyb+O959c60ezKbTp354+5MnoMLBy2l20MvfKfWaTjup93BRG9t0r0gsDKyPyG4DpwrEE7IjQqN4RNBdgtZ0aMo1rJeU7FB0DHh7sbwsADKFWJM1eRV5SRJF3J0bLeZICqcwM0e90dZFZ34xqtcq1SqTIHL0Wv0kx0x5xyIOo8YliBU3InLTFE4UlXG7oQ72JAkE+c155gujqiW2uLfH1Pl26sFAi453rGZVdZOO1na67mt5+1Z7Ocaaf3kF8cnjTjsoe67QvuiGuwhYcSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSD/BOwL8kCSIEF4PcryT3UmNWfYd9+D8ErB4GZeLOk=;
 b=aGggGb+lAnj5nzyZwfx8X2qy3ws39kE62Q0QNQ0P998fBVRud3fOQ4r00BezL0MRd7u/wtyKO94e2HZfc62vhK6+jh5ySad2vIygIRdYHUmXithWDtz8KfGyogqOCG/rkRiOGXA6FsAdy8brBNui3hwAYhYgh046aDtRhhfFwq9oyTQz46sY32loN++eArU3CRNqIEZk0tOC8QUAqgYo+x7kb+O0JqMpZIPPzi5vcbtIAoQiBK4KEdymVpXiDmchwmtuvmK+NUWpDJjLod7z0VmB/me2AySGEnE5Jfj8sqoEK6duxPfPiNdApho0+NhTxc0ES/vMm0KMepJpSSQS9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSD/BOwL8kCSIEF4PcryT3UmNWfYd9+D8ErB4GZeLOk=;
 b=qLMCnTpLntH7e8PIUMifDdVGrXOKqZrI4fLTYVBBY/E/4IJkFcKBr0jb8Sx2nSf8ek0lquKf+KFRIWAd8R0PY97pS07+2KSiGCHqKKBsvf+NUi+sALoGjX/5T2HTRVQGzR17qAZ3oEE6AxnrLAPSzigwJVegijgr1/fdFaZkCcmUtUD7B8eifSk8ttghJZhYIEY5V84BTVdF8Zxcx7tL1ttIOqKAU8fxFhf+XaR9EYeMJsBqK2XoVTcyns3PTasjuGWCClHEnHfIKHVVhtwUCKr+84vivLuUAKBO2dMEEQ3LPhlsvJ7JSYxfCTSYqKpGPeRenEBXNLwiIdgnVbwPIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17)
 by MW4PR12MB7334.namprd12.prod.outlook.com (2603:10b6:303:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Fri, 20 Jan
 2023 05:48:16 +0000
Received: from MN2PR12MB4437.namprd12.prod.outlook.com
 ([fe80::8e19:3ff4:411d:a6d9]) by MN2PR12MB4437.namprd12.prod.outlook.com
 ([fe80::8e19:3ff4:411d:a6d9%5]) with mapi id 15.20.6002.025; Fri, 20 Jan 2023
 05:48:16 +0000
Message-ID: <35eb1396-b91b-8a7f-6585-30d2f2adcf85@nvidia.com>
Date:   Fri, 20 Jan 2023 11:18:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] arm64: defconfig: Enable HDA INTEL config for ARM64
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        catalin.marinas@arm.com, will@kernel.org,
        dmitry.baryshkov@linaro.org, shawnguo@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com
References: <20230117181658.17010-1-mkumard@nvidia.com>
 <e871dae2-58ac-7ad9-c198-c4e90d26c69b@linaro.org>
 <1afa38ad-716f-49f8-efd1-ed37bd8dbf6e@nvidia.com>
 <ec440deb-2970-69b8-e54d-6519c95875a8@linaro.org>
Content-Language: en-US
From:   Mohan Kumar D <mkumard@nvidia.com>
In-Reply-To: <ec440deb-2970-69b8-e54d-6519c95875a8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::14) To MN2PR12MB4437.namprd12.prod.outlook.com
 (2603:10b6:208:26f::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4437:EE_|MW4PR12MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: f2a90b13-0bf2-4158-4913-08dafaa9ed2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YRZFvBH1xQ6l0VBFFeeY4eo5ME288XVHMUDYLXTrpqgjGFtpecnP/82wxzCdM1rIZW/Q807/6zzYu/0/7SOj2SFI4+huJMhftiVUz72bTNIjUI2ZfuRVZRIWtRG6gx7JjwxN+38OGf6TnCQIPtr4dUjsFLb0tvAO/jfS84a5j8qFa2Pw7ZIxkOhWInFW6odUKGJ04zJwl1VOAlgJIKrpIUIXKFAxJBSER+38/IogwrYXH5LnQXAPwzlxqtoN0FGtRc1wFSrkbTncCvJ/uc9J/e5Zx3lUNBmUW9hN2fRw0QcB/dLNJF1LNraa+TCH78NluM8gRPuts3TwuzRs/lShNsdInLVPhQU0u5gsPCSTAE2lTxxuIrEsVcV+9wvybkt082Fi7c3xl4fFJ0r4gB2xOzU/UULHDQxaWJgiBhb8KBoyWqlN6p71CXnbzpFIcVvh0F80bom5YvFmfpykKlfcYeBNVa2VIBZkHDnKI2orLF20nykR25aBKbInXJ21hdrq9aUElrTUyXr3K4XMIdMccGQEBjpk9jOA7uvZIDaMRYCnyLKj5gXmyTWfgZTL58cIfQ68gK4SY3rlwdqKNV0jvLA/o9xcGzCeYOK6RRQOH/0j7NeCQ0i0c1iFa3kkG4Li5vZ+2lJ4HgcWKgh686qw9j/IR/Qiyb6dpHL9JiJwqR6BA2yjmG0brkc+DSiaGuOmgXd8PV7sL4ilp2GRlNPoHA1ruC6QyeVCQx/2bOHIyQk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4437.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(451199015)(6506007)(31686004)(86362001)(66946007)(5660300002)(2906002)(66476007)(8936002)(31696002)(38100700002)(66556008)(316002)(107886003)(53546011)(4326008)(478600001)(6666004)(6486002)(36756003)(41300700001)(8676002)(186003)(26005)(6512007)(83380400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWhqSjVjeWpxVFR5d0tmYzJVNzdzbkNIT1phVmpBREZFOW01TEVxdGM0NlBy?=
 =?utf-8?B?MXJYcmY4UjZHQUJTT1h5aXFOTGh5ZURUSkM3czIyZUVXb0YxbXJVWldwQWlt?=
 =?utf-8?B?Y0JsbHFaWUMyRG9BMGxMZFdkd2lZcVNUcGtvNWV1SWNEK3IxcXlkMkF3eUVB?=
 =?utf-8?B?UDJLcWtWUlNpUGhwKzRlbG1jVGVqSWZRQys2KzM0RGJXU25iV05VTE1EWGJk?=
 =?utf-8?B?WEptaDJweDFFZmRvUE9kSko0eWE2WkMrS29WbDcranZzZnNvUGdJbkI4cUlk?=
 =?utf-8?B?Ym8xdlNxTzRRUlhhYVRDWm0ydHRPdmQveVJ0OXZNeER2eXJmYjBaTGFlWlNl?=
 =?utf-8?B?Y1FpWG9EY0FMYUtFTm1oRGtHdVQyQk5SSktRRFhMN1Rpb2Vha1R6NS9zZHhl?=
 =?utf-8?B?RDM5ZFc0RGNKTzRpV0toZlRXOCszVDk2YmZ3RExjVXdzUnpPRlp0UUwwYU45?=
 =?utf-8?B?cFhMRUJ5TE5tTWc4dHN3YWRiQ09OeDdETUs3SlRzSlF3b0lsUy9EOW50bGtn?=
 =?utf-8?B?QW03aFJoaENTVDV5N0FNZlVyVmNwQzVtMUhLUk1JWktLNVQ0VDQzMmRqZkVl?=
 =?utf-8?B?RVhSSUgvTnhIRms4UWtoSnkxNit0dk43NXZwK1hMbTdKbUxGNDhNdHNjTWNE?=
 =?utf-8?B?TktGQkpRZGMrcnErR0ZPNDE2RXNpZUhoa0xPZldiVElUcVl0S3pxR0F4elN4?=
 =?utf-8?B?cjdjbGk1NU95OEJKSU1pb252OVdJaUdmN1JKWDRCYjAxUFB5UmxLTWZ5dDV4?=
 =?utf-8?B?NDkxMVBkYWljRjRicUZzaE9uaWNWUG03T2Z0VTlIc0JTajB3NTZkL1psdWs1?=
 =?utf-8?B?N2VYemloSjdISTNZM0RzamlPMXc2eU5kTEc4bXJPaUFBN3YvWHdtdjkrQkIr?=
 =?utf-8?B?QzBocmN0ODl5YWdtK2t3S0xjK3B5RisrZTBTN2dmelRjMzhLZ2p5dlhUVEhk?=
 =?utf-8?B?UnV4SHF6KzlpdUpSRjRJUnhaazZ1N2tWYUFJeWNnOWpyRmdaRjFKQ3NobTRN?=
 =?utf-8?B?c2RnR2lyMllvTFZnc3FDSVN6U1RVbXVXUmMvTkdvemI2cTh5YWtPZndzVWZo?=
 =?utf-8?B?cjBtdStMRXdwVkdPUGhZaGZxdFo1WmpTTG51R3VIcE5HdGx1WVZnZldwVTQ2?=
 =?utf-8?B?VlYrSjJBZ0lBczI0WE1Dc3lKRlhQdzZmR1VQa3RuRUVrbFRWMlNRUlNRakNE?=
 =?utf-8?B?VzdzNGNZSU5xZ290SUR5RzlpSDJGdEpIQkswMVMxYWJJQU93aGVaZ2FxZ1Vq?=
 =?utf-8?B?SVN0OGQ5aDRpNiswOWxkUU5zZWhrL1p2WTJYTVZ5aEVTcURwdWtIcHVETHNv?=
 =?utf-8?B?T2w1UWRqbElXeERvUUEraVkrRDZKZjRKSzFGN1NKYnpjNGNuY1UvaDNTRWFU?=
 =?utf-8?B?OVl5OENQb04zeWxKTFpyaVQ0ODBrM1pFcmR5Z2ozREVIWXd6ZGdPSFdlLzRH?=
 =?utf-8?B?WHQrd3NjWWlwWU5aK1N0MHV4TlJFVXdYM0lWWk11RFB4WFBNQms4TWRaMlpL?=
 =?utf-8?B?UVFoSnB3bXY3RjMwTzlnSUN3WkQ2dGgydVB6QnVHcS9rVE9QeTE2VUQ4VGZ2?=
 =?utf-8?B?L3lwNUorRHkzYXp0YzZySDhIR3R1VlVZQk5xbnVScDN1SDd4OUxoZklYdmNx?=
 =?utf-8?B?YmFNQ2UyYngxSUJUT1NNZDhjNlQzam9jN1NOMUNDc1hONUJWOGMzQitmTzFX?=
 =?utf-8?B?blRZN3FMU05abFkrZThQK0l2N25IVWJDTE9sSldCRUJaUFozbVdVMi9ERUI0?=
 =?utf-8?B?ZmtUd0hrOSt1UHJzN1lJK0FQQ2RzRmw1cjVvazBtSUZqQkNYVzlaeVloT3Fm?=
 =?utf-8?B?WFB5bU1lUGxXSy9NYVluMVByeEFXeFRhRC8yaFhmTENzblprdUt4aTdnc3hS?=
 =?utf-8?B?NGtyT1FDMkp4RnJldUlxclVqQWpEYVNzYk1VV21MUVREeHhLaCs1cXhTWjhD?=
 =?utf-8?B?bU84dE9rR1UzMS9kTDJCbTBrc0ZzV2FyTVk5STdsUEVTb1VzQTFYa3FKTVJJ?=
 =?utf-8?B?bFc4ZkI5bWU0TWFjOXhyN05WUU9EQlkzYjh2YVFQeDRyNFdJQjMrdmo4endR?=
 =?utf-8?B?enlxU3JwdEU5bmdEakx3YmcwcE1JRUpEZzJKWUdmY01Wd0hsM20wbVdubW9G?=
 =?utf-8?Q?6xQS/LI6kV/uYRLN2MWLYgan/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a90b13-0bf2-4158-4913-08dafaa9ed2d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4437.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2023 05:48:16.6774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVBHRgvUvHBdHBPbJVO3VGdkwD2x4sYJFx7scCZ807TQvBsSc+aOIeaI5KD5qYlKDpjl4KzHRETubW84wiSLtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7334
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18-01-2023 18:06, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
>
>
> On 18/01/2023 12:46, Mohan Kumar D wrote:
>> On 18-01-2023 13:04, Krzysztof Kozlowski wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 17/01/2023 19:16, Mohan Kumar wrote:
>>>> Enable CONFIG_SND_HDA_INTEL for NVIDIA PCI based graphics sound card for
>>>> ARM64 based platforms as Intel PCI driver was used for registering the
>>>> sound card.
>>> It's not a part of SoC, not a common device used during debugging or
>>> development, so I don't think it is reasonable to enable it. We do not
>>> enable driver just because someone uses them. Otherwise please clarify
>>> which board has this device embedded (not pluggable by user, but embedded).
>> This change is required for enabling HDA sound registration for Nvidia
>> discrete GPU cards based on PCI and pluggable to Nvidia Jetson Platforms.
> You can plug anything to PCI slot and we do not enable every such PCI
> adapter.
Without this config enabled, the Intel hda audio driver won't be built 
and dGPU won't be able to register sound card. Do you have any 
suggestion here?
>
> Best regards,
> Krzysztof
>
