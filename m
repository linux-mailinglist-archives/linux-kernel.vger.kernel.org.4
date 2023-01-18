Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5131671C0D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjARM3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjARM2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:28:22 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C79A25A1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 03:46:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJ5PGirOGoMLkK3YVl7UN5RObYtw7Vx8MA/+evnEoEsBBoqpWCQw8mWWtN9pgg7uTPVnkKL6VpkgLc7qFc+QPb9cAyUbK72SMSvrU2vlRje3vnq8SAqavOCWHRvKkpikN62/abnEnn+KB05LUcxi///iMFNVySJEQQro1Su3w/4dPdLc4OysgwQSfvcU4PPxYo3QTSa6rtRhGnOttFnRLeQp3AjBgLWtUFaJMSJBUT+eZGy1L1RpKR4utEVo7OcbKKOGqKh8xXO8khcb6LkRfy/rTi8jx9N2ujANY+1xmXwrZLI8EPKRCZE5cbdEWE78zsdad0NZH0obrLgo4xff4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnVOeMlWFKe0XZMtbGygV+7dJqBO2OcPKxEqbNNO8xw=;
 b=YWbhYW6SnCN+MTpMR3LxHb9RLPL840riavAnOG98dPegITB22+sIhwZyooNRAKt/O5Z56cWcAnvPp7he9Ab827EaoVq/FuaeO68UwCoHQMmSLEmbd84M4TYH0nOCfBrYCleKiR/VO0nsLDdUHLuqorDyD3g5alElsTvanc7SyjSKEnzjDE8uSXUK8YIW+GwnOMr+dgRw1V+BZswKOsW3PjH+puWOvp5yp+aaHj5jjOIA8IOuzai6zteROAqAB2ou55u6PezgftxgxCnE/KUl7hKsPX3b2mYjgkE9Togvx8/+3BS8cP4tq+Qdda4t0IFUGJmbTlVljl3pilmVwdiutQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnVOeMlWFKe0XZMtbGygV+7dJqBO2OcPKxEqbNNO8xw=;
 b=fNyadGlBFyVym1WLdknTJ4xjXn4w+EBv3EwKY4bG+SFa1CpPBv8ElpM+a+PzM0pejZd1GRyRAQZr/gtRXJVTFAwh7i0tHanDnMVE/ArAIAS3b0cwX8OIpR5SBliQz1n/YZG/PGQbr2kRE47w+Q42bstFmL7Wqfc+fqq+w2mk0m5v/HnmSyeAPniBffx9A24MkFfAzEvEpwwFu72tlgaC9rtkGejjrPd5SZ2dcVgC/KqEibcdlMoZ8+HNnrkcGlQKo3SA30ebtXN+gJh/1Pu3IWbRWBqS+tZEgIdVNlBj+IV4+b5pB4Yzfp8sDPkiVfIbPHOm8CqFbZadJP+bEVLLXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23)
 by BL3PR12MB6617.namprd12.prod.outlook.com (2603:10b6:208:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 11:46:19 +0000
Received: from DM6PR12MB4435.namprd12.prod.outlook.com
 ([fe80::cfbd:8dce:2751:6ad5]) by DM6PR12MB4435.namprd12.prod.outlook.com
 ([fe80::cfbd:8dce:2751:6ad5%9]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 11:46:19 +0000
Message-ID: <1afa38ad-716f-49f8-efd1-ed37bd8dbf6e@nvidia.com>
Date:   Wed, 18 Jan 2023 17:16:08 +0530
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
Content-Language: en-US
From:   Mohan Kumar D <mkumard@nvidia.com>
In-Reply-To: <e871dae2-58ac-7ad9-c198-c4e90d26c69b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1P287CA0016.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::33) To DM6PR12MB4435.namprd12.prod.outlook.com
 (2603:10b6:5:2a6::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:EE_|BL3PR12MB6617:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e4fdfa-2c17-426f-6c94-08daf9499d22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8RC7Fk73DFhGUJBvWH1yvCqKqqShSTCwcQFt0BfLv8isUMFoamzQuE0S+IDFZrWuS5uso99jnqmic70tMHqHOObGI7WPkChN9AebqqQxlnD2PVBSCJj28nhCXs7mxPmUT5MBpaXsj7VdwT3I2rppvide6eDAyAUCyk+1sM5+/VGyA9/OhiqM6ZL69nIueltJbRzjbNS5loR2e8iUWGVnfjipBvbHIYsAxFMZ8ic2kd/dJeLQpjU6mghcG6BxHrNZCbsrPSI0Nz6SSrsZ9clUi72XJDlLxXH/TNEkXSM8Rdtdce/5l16PMLtFS+QWQWvHbpG1NNevteLZoE5No8bkzXY98XnoUT1lQFq13SZQXzV7brhC4w+xuZmsseoNn8gNO5fEIO5+gfFTKQYStCz8H6/aDtltub3T0XZriOFx7zY9/cdHdZwV/e3t7ZcedcOAvgeE9Sny07JBl+268xmqtxhZscU0gSTeQIdCR8aZYq6D+TDNfLvAIEIacaFAqDo3D+JASnx6VVPTN6P/jQ/TlTUgShiqcg1kWHMRiuF86OPUYWVv8Ffp2V4iXYV60QCI7mxMTMtEWMcY8RsV7KZOfi5z2IkQsvkNGN2sXDRk93efuOIZYG7Lv7GO1KVgVTv2c3IrBXUalCPU53ejHq1JEbxjFRwe/oPM+ysvawkh1TNf4P4LNzga1UCi79Txjo0DrWrR+kZEES8X/iGU8n98E01WTQkOd6bebmxavHFpYQc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199015)(8676002)(31696002)(86362001)(38100700002)(4744005)(2906002)(8936002)(5660300002)(4326008)(66476007)(66556008)(66946007)(41300700001)(26005)(107886003)(6506007)(53546011)(6512007)(2616005)(186003)(478600001)(316002)(6486002)(6666004)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEhXeXZjeE85ckFnZTNhZDdaYy9ERW56WVVjZTdsOHJNb3BzQWpwT1lpNkRH?=
 =?utf-8?B?Z3k1QXJQUXhXTlhMakdEMm0rMnNLUm9VM1NzUitFcHNzVFBlelJrOVVaSnZl?=
 =?utf-8?B?MGtGUEQ1Y1IzZEtBUGZNZWdoZng5dGxlYnlCazNTd2lEdFpFZEdYZDMzTjhL?=
 =?utf-8?B?bHl4UDdtcm9lakZwY0cvZWNUNkdHTVlRZHFST2R5N3lPOHltZ3lQVDlLQ0Ro?=
 =?utf-8?B?Z3pDQXRJbnFSY3lScmtXYnJDdUcySVZuc2VyMkpJZVFEMXI1c1F6ZjhaUXhS?=
 =?utf-8?B?ekVXNGViR1hPTnU2QjBCMXFuMG9kZ1U1TkZQU2k1ZUhBV2hWUExuaGhab0l1?=
 =?utf-8?B?NjB4U3M3S0RBdDVqS3daZEdNR0tObG1FeW5qbUp1c2FJdnlmUWhkOW43M2Nh?=
 =?utf-8?B?RktEdUorVTU3ZFZuOElhVXVFemx5dlQ1ZHNZL3Q0UzhmcWJNS3h4Q1hTRWxI?=
 =?utf-8?B?bzNFQVNVWGo1c1ZrMmh6bTBrOVRQdTF6ZEh5RmpNUGRwdG1WODFPYkVTa29V?=
 =?utf-8?B?Y21paDNnVGw3WERnMU5vcjM4VzRWM2J1WGhTUURKQVcvYnN4ZWdvMlVYV296?=
 =?utf-8?B?bEFJWmNrMHVzK0dkcEo0ZnZUSUs0YUdwUzlEVmozU3pOM0xsME5YcVNkaGlE?=
 =?utf-8?B?ajc0dFl0RmpEclk2amtNbWFUd2huN29Bb2hialFRdDIwTzBzS2lYaE9ubzNU?=
 =?utf-8?B?cEw3anE4RDAwenpudmhwdW9lMlVZNmQ1NlZwdDRxTTRFTGlweU5XLzAwd1ph?=
 =?utf-8?B?eXh5M1duT1FkMlpXeThhWUpoeTNEQjh6UlpCb0QvSGd6N1A0Y04zZyswRFFk?=
 =?utf-8?B?QXpsZkkwOFFkSGtITXpLOTQrL0RmL1ZXc1VydDNVUk03emRTYk5VOVVKN2xY?=
 =?utf-8?B?LzNBNGtGNk03RFFuYU1vZ3ZQd3RXZjhFdWxCbHUxSHhvQk1DZWw4SlAyMU5a?=
 =?utf-8?B?MnVxQnlQT0EvS3UyZDh3YWVQNDYvWUlWeTlPSXV1RVpyYnU0cUdiQWZwOVIz?=
 =?utf-8?B?NDZnRE04R3R4SjVGaWpBUU5TamJ5bm5QbGtVaWg1NlRDRE1ROC9zbTRESk9C?=
 =?utf-8?B?VFREK3ZGUktIQWRnSHRuYmVOeldXSUtQTGJqZTV0cDFQeFVxdEVxcFVsbmpN?=
 =?utf-8?B?ekdyS2NmZkw1aEN3d0xReVpwWURDZTdMVTFxbTRRaGVhRXJRVStwaWdOeHdC?=
 =?utf-8?B?cVdxVFNmN3FtMUJUYlFuWmdJRzlUdzh5NVF4TEJmZlRNajRUWThSNGl2OXJu?=
 =?utf-8?B?VDEybmI3VHU4a3MyN1FTVUsrTkJ0aFAxSXJqZENSWkYrYXRmYVBJeGIzWlZs?=
 =?utf-8?B?VWkybjIvZVNhVVBtL1VnK0oxL0tXWkNPR2praFhJNjU1ejNJcmoyQURsZ2xL?=
 =?utf-8?B?UlZZL0RPRTlJek44Y3pxcGxjTEw1ODFuNUhldVNpaThGQ1JIWkNvY0JSNDVm?=
 =?utf-8?B?QjVqOW1XM0pCSEI2d1pKeng3R29ER1k3RnhyMWdoMmdGclVvSFlabjNPa05q?=
 =?utf-8?B?L1FtYS9td1piRjQxZ1pycDNMSy85dUtmTzNRQ3pDNyt1UStvU0F0R0phclF4?=
 =?utf-8?B?OFBkNHZWcHZva3lPcnpTZThoZk5TWlQ2c3hldVh3MlpuekNUSWl2dzd2MVl0?=
 =?utf-8?B?bDZPRmU3cHVzNG9PbVJMUnE1Qm13RUxERHZwMWo1c09ON3FTNzJzenVEWG43?=
 =?utf-8?B?S0ZTWE5PL1FreWJjOW1JbTF5V1ZpeFcyaE9RN0x4bmlER3N0eEtHNVB1eG55?=
 =?utf-8?B?RUlvbE9YSkV3STN3OHhwa0VjUGFpWHg2cDhvZGIwaVhrSkVFeXExcHUxb1RI?=
 =?utf-8?B?aDVZakVWcnNNSkJHcjFvMHVRMHZ3dFc1eHBSaFNueWlTQnlFclBSbmdkbWgx?=
 =?utf-8?B?ejUreE9hQmFSVWRGajJlZ1FFbDJuSG1Dc0N6VnhoOFliSm0zWklNSDJTNnl1?=
 =?utf-8?B?Q05lcUNnNExwM3FxNDdqZytzMmc2dVB1dm1ldG5EbXJMMFh3OWIrVWN0ZDMz?=
 =?utf-8?B?QitwN3RSeHFRbjZzY2ZjazVyM0JtRGU0Z2ZvWG9pT1RRWS95djVoWmJGSWx3?=
 =?utf-8?B?WjBtS2tUS3Q1QTlSVG5ERkV5c09nc2RhdG11N24yZzl0OXB4bHh3LzF5S1E3?=
 =?utf-8?Q?edESylaAooJaRuPdXFTr+G35P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e4fdfa-2c17-426f-6c94-08daf9499d22
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 11:46:19.4627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /swNPW+tLXWEgVRS+EMye2DYEeBnAHvRPEmN8G1UV/LupFPbKycujm317j+/M970tIg1CDmnBcBKsI3o2gHHdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6617
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18-01-2023 13:04, Krzysztof Kozlowski wrote:
> External email: Use caution opening links or attachments
>
>
> On 17/01/2023 19:16, Mohan Kumar wrote:
>> Enable CONFIG_SND_HDA_INTEL for NVIDIA PCI based graphics sound card for
>> ARM64 based platforms as Intel PCI driver was used for registering the
>> sound card.
> It's not a part of SoC, not a common device used during debugging or
> development, so I don't think it is reasonable to enable it. We do not
> enable driver just because someone uses them. Otherwise please clarify
> which board has this device embedded (not pluggable by user, but embedded).
This change is required for enabling HDA sound registration for Nvidia 
discrete GPU cards based on PCI and pluggable to Nvidia Jetson Platforms.
>
> Best regards,
> Krzysztof
>
