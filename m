Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7106665CBE5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 03:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbjADCfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 21:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjADCfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 21:35:20 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E4810EC
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 18:35:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzyaCkDv94CZDuUu3OqrA34LqHL0Ccl9dzKxnVRcqC2LY8KSnt2xzlEGTgtMwko4/4/dRnsp+mMHIZZW3shKgh5ipg2fgh1VcvKKMH0picHODLbMi4HF+bX1K3XoHopT0nzOZ9b+ACCzXQkSsR9ZcFw4Ob2Ld1/t+Nh8rXT8gcUHygDQLewih6+fX1jdyyoQ9/pay9fMkTsAGYZ8LKPaXlF80LvCB0OtV/MIzpRwt6feUN86br5zXKf8Ftjh0Zd15485wIPLaGVDdttrg7Ba+QyKTI7MEkF0MqbU7A3NsKRiAG1l8btW8zGXcaj66X4IVBGLtVQhEb154Oj9EJhc/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/5eV+oQ59zItuF6V1Tgs1gRL6+i8eptjbRJQBrCppU=;
 b=Wzfz7vSAmsZj4oAEnwHMtTifrqQs4bhpAuTEJo1mgK+6QN94M0vgxZkaBjf/hKA9mgMt0NJ5qsUUznRBCN0Dj2FYJYxpS697zyIHV2A5t0YvU6zuXQFC3F4RxzvmJa4TNa8ASYARlqvhAcAqlCyX8CJIu3eQlH9kepbTOLWMPSnjmuWCy/tS/e8znr9Hz+zUYnylUikNTq9RocdBl6hBVCcKJJwgCm815IiefU/7deW5vL2l3z5sl6B7NM7dqn+p/Zz1susNCN7/n7M/fp9kSR6pzymUpU8tyokJ2VI+7lLIdYdaf22dnwB9jZejOPvDGMzEcBlSdqoTCtxxNHq56g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/5eV+oQ59zItuF6V1Tgs1gRL6+i8eptjbRJQBrCppU=;
 b=DY7ndw6nd7r9hCOwmBCFP/3hf0LzVaszLS9og4Sfw/NSL3/PrRDFFgTH/K1JgmSubv5LJvlntCMVpIBT+pcVQ4w110GCWCydGLrKA44XXOrmhJDzNtGM6PnZlUvE09Ts3WSGivOsCzPqXo4Lk0sYZgDnQLPXJVMjft0xlCEV7gBTn4hzftH0Z1CZWBjC8d60oy2IvYeKYtTb4A7Qs6IszpamukF/GMYMdSobPAN8Wb9beQRQGCaSRH/qEjaLuOyzy1PYOg2/Mc6tjwnyKson9AEVu7QudvMUtqIiWj30Fg5UF0L3FjTbmWZs4CbYJFmCIGB2wQvVBH71R/tYluRG2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5762.namprd12.prod.outlook.com (2603:10b6:208:375::12)
 by DM4PR12MB6253.namprd12.prod.outlook.com (2603:10b6:8:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 02:35:18 +0000
Received: from MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f263:d93d:ba53:25fe]) by MN0PR12MB5762.namprd12.prod.outlook.com
 ([fe80::f263:d93d:ba53:25fe%5]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 02:35:17 +0000
Message-ID: <6da077d9-60e7-218d-4fc7-bac59c9e4247@nvidia.com>
Date:   Tue, 3 Jan 2023 20:35:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] arm64: gic: increase the number of IRQ descriptors
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230104012215.1222263-1-sdonthineni@nvidia.com>
From:   Shanker Donthineni <sdonthineni@nvidia.com>
In-Reply-To: <20230104012215.1222263-1-sdonthineni@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:5:40::15) To MN0PR12MB5762.namprd12.prod.outlook.com
 (2603:10b6:208:375::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5762:EE_|DM4PR12MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: 322aadc1-6dac-4ba5-fb55-08daedfc5133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YCWa6CGPtqlfNH3V58PjLOCkAOlMUHficE+Qzw3v7MDKWgSuvFO2HD25Wv9RMsKyT8+meSlMCokShlUjDpfplAf6+/RWipQWjp05zlr8E2vAMFNz+6Vh2qJ3sXCjk0MuNPlMq5QmViZwi2uAyar6U1giGPkX/Eow3c+bSxWkHUFxcuwn+yNVVBa2omA29tRKOgSPMsU9BaYcrIbwhKmh+x3D6lq0PDlXyyEUTw3YZcR5+QV0XzlN+0UVcvRnj9CZdwRkcJf6OYhLdamAzoauLTpAS9oyrYWtRPuR5PIxaTX7TXG8tM0MDXMtgE2VQVeFDMoFnxTPvMP8aadNfn/jWMvhV0KJWIHtmkTPV/eRJHUuHojpKpWRGrjGCtRwUiTNEJTijR6fPTp7fo31NWBXhREnG0UkcuOA3qqZQQjaGPDQoTNgNwa88gnlpTYL4+YcF4blALuW+dL4e80bTsOU/BO6ftaQ8eza/XNGtaiz8GtplmAJLMt41cm/Mc/TisZzPOfGmFZUyHcEIV3Qh2cogkIVuItMK3CbQKI+uMl8AMVbpgqFQF1m3tDXrL776731Q7Wo1HqsJdpo0xMFQ58iNREGbBcvw6YxqG0rvEJ2uAfSVNnZjUNFGwdqijoQn6XSEZH16MuNTTPZlCaxR+e7TT8zfTdC7lJhRhNtaD88HZRKNTygJGwzjmU3dPLzmEAQELsZMqSAfRWKq39gOUIUlCRDNsS3Zjzud6Si/42tguM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5762.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199015)(6506007)(6666004)(53546011)(36756003)(478600001)(110136005)(86362001)(31696002)(38100700002)(6512007)(26005)(186003)(6486002)(2616005)(4744005)(5660300002)(31686004)(66476007)(66556008)(4326008)(66946007)(8676002)(8936002)(316002)(2906002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG5yYXF5ekE4bW1acjlqY0FJNDIzcm8xRWdJc0c0KzhJOFJyeFQxV2NoTUtj?=
 =?utf-8?B?MUFZN3JhWEswRDRUQXpGZDNEcEhxdUFyd3lhTnpqZ2dGQ0hLZ21zTi84dmgr?=
 =?utf-8?B?dUlQMnU2cDdXZ3RBWGp1NVYyemp1d3l0Rld3c1hlMlVCQ2x1ejJRMWdTSXFl?=
 =?utf-8?B?M3haS1NHdTJBL0g4R0RFMG5GZ0xnRkoyRHI3ZWUvVHN1TzA4Mkg5cHJmYXNp?=
 =?utf-8?B?eTZaUHNlOGg2VFhUSTJJcDV3Nys3Mkl0YUJ6YVU4b09wdXNvMDBHKzJGNU9O?=
 =?utf-8?B?Z3R5eU9NNVZpdmtCQk5kSUgzb2pNQ203YjRPcUZScjVJUzdnUUZVQUVoWVhw?=
 =?utf-8?B?bmdCc0VsYW84dU8rQzA3eVBwWEZmbCs1b2N0ME5EeCtHbW9OZ0Z2a3FIV1Rl?=
 =?utf-8?B?RXVsQUtTaldTaVZFdUxneEdUZmZ6UVUzenlVc0c1KzZnYlVwcDU4MVVFNU00?=
 =?utf-8?B?R0dxOFN6Njg0MWx4SmQvNUdobzBLbk5ic0hLRlc0eFA1YmFmV0pxaStSOVgy?=
 =?utf-8?B?NlBkWFJHTTZ5WGIrUnUyM1pvR2d1WGJETjNYYTIxQy9KR0dIcUJ1akJvNExv?=
 =?utf-8?B?bzR1YkRPU0wxOXkrZWROTk9ZeC9BbktXYVI1NGhYVTBPa0o5eUs1NUF5WUh2?=
 =?utf-8?B?Zk9ReHA1VGw3bmxJVlJ2TnhGZXFTUWhpMGFGUS9LTmpsRUVNSDBXN0wwRkFR?=
 =?utf-8?B?ME1yeDdVZTNQT05TVEV3RVNSSUhzRWZBSHl2RlVEeFc4UERtckRCQUdyZWJV?=
 =?utf-8?B?MGZXMzNOcmJGRzl3RmpsK2dNSUZycHg4dUFSR2VhQXZIWCtQc0UxNUM4ZDFy?=
 =?utf-8?B?WEl6VzEyWE5FeUg1RXpaa2U1TVd4RnRuTmt6M1MrOTJGY0xjRmpXQWNlVmQv?=
 =?utf-8?B?MC9KaEVIUldDRUNVbW5MR0NIWElBdlBFYUtqNVl6TktKU0hEUUJOcDRyampR?=
 =?utf-8?B?ZWhDZ0FiM2t5YUd4TTFxRWtvM0lRdUJYQ3JFMlFQTTJrYnA3cHBieEFUL1o2?=
 =?utf-8?B?cERDVGJPTzBySHNDME0yZ1N6TVpjR2VVM2N4OWtoRnF4OHVHWUFMSFU4UDhv?=
 =?utf-8?B?VDNoenl3MkxtemV5M2VGKy8xWCtrQ21ydzlGU1ExclhidTZFaUhydklMakV3?=
 =?utf-8?B?Rm5WNnlXdlFLYm4za0xkbDF5WFBEQ2tQc0NZbHRzUGxGVW9kSDU4Sk55SjRU?=
 =?utf-8?B?OXZiVXFpbFNZT3BwMEd6V0dPSU5TbGRlOG9FZm5wSDlGcGFaSERubm1ZaE1u?=
 =?utf-8?B?Z0lrUHVBWnAvYkhKUERqUjcvMGFOYXpGMlBVN2tKeW0xSnlScFFoSmNkWEl6?=
 =?utf-8?B?dWNLcWJveU51d1o2NE16Q3hPdFMzcGlpR2tJV2FodlVURXRJbXVzdDBXbzhl?=
 =?utf-8?B?dTVtUHJiUWtsdXF6aG93VDFmNFIrSkV6SW4rRFJoZCs1UElNMU90VTZjZzFz?=
 =?utf-8?B?WDVHc3BxYlowQ2tNMGd2MlFWYW1mWk1yWk9Jb0NOdE4zNWEzbnM5VzdpUlFP?=
 =?utf-8?B?alhWTVI1WkR0ZTZ4bXFmVTJXaG52c3NvSTZQYUhaVHBUZ2k3WXNhRDRoMFB3?=
 =?utf-8?B?ZHU4Y2Z3b3ZRRi9SZ2hDSDlMSEw0VDZzNXJMcDdsOW1SRFZ6KytSSEQ3bUp5?=
 =?utf-8?B?a0dTZ3JvbWtjRTJrcHJ6a3k5QVdLdWlKWngwNXRBRzRaM2VoVkllSlc2OXlW?=
 =?utf-8?B?YXRCMUFrc0RNQVdqRmxhUkpvMUpabzkweUhrU0Z1WDVTWGQxMHBHMHFyUDQ0?=
 =?utf-8?B?d0JhUzNMbVhLcGNpanFnRlU1Vy9XUGdTNWp3L21zc09wT3oyS2x5S3IrVmJo?=
 =?utf-8?B?bHNEdUtHcVQya1B2UEM4NFI1TTN2STNKWkt0YTVOUnZHQ3Vyb2V3YkFRdU5r?=
 =?utf-8?B?eGgrU3plNlRUaEtNYXUvN1dMakZIKzlMZUgyaWpSU2duc2h4SGhRQ0x2ZXVF?=
 =?utf-8?B?QldKR3ZNVnczSGl5NHFZdnRtajZadnZFRVgzVC9ZbjkwQ3FmUUNTZFhBb0tL?=
 =?utf-8?B?WGhBVm5PUW44dU9ndDdpSUpHaTEvNVU1bnpvQnIwQmdCNmM0R1JtTnYxWnhs?=
 =?utf-8?B?UU1DQkFGK1d4UHNwZ0plMVBiVk9YK09LRzBVaUJDZEwzc2dxaDdYd3JnV1Uv?=
 =?utf-8?B?VmUwQWhmbFZrSDBUb21nYTJ3K2I0aUJvTFFCTlliRDI3dVZyYTA0WHl5UFVP?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 322aadc1-6dac-4ba5-fb55-08daedfc5133
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5762.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 02:35:17.8748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/wofL/4cPCGnqxQJ0RYHQp7KcPLny4FUkA3WtQn+qfJwWHbnZ2C+WFLeni3oi0I2oZOETP6M6zjjhDXxWnqfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6253
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/3/23 19:22, Shanker Donthineni wrote:
> The default value of NR_IRQS is not sufficient to support GICv4.1
> features and ~64K LPIs. This parameter would be too small for certain
> server platforms where it has many IO devices and is capable of
> direct injection of vSGI and vLPI features.
> 
> Currently, maximum of 64 + 8192 (IRQ_BITMAP_BITS) IRQ descriptors
> are allowed. The vCPU creation fails after reaching count ~400 with
> kvm-arm.vgic_v4_enable=1.
> 
> This patch increases NR_IRQS to 1^19  to cover 64K LPIs and 262144
> vSGIs (16K vPEs x 16).

Sorry, created a patch from the wrong kernel branch.
Please review v2 patch.
