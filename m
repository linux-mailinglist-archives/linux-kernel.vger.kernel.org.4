Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB3874F5A1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjGKQgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjGKQgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:36:20 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B361994;
        Tue, 11 Jul 2023 09:35:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WphhKk9L+pfbv4hIs9eyG1xHsblMGMg7oJ5upq0aRO3jn7a308H/4cqYb7N8dqoKd6dU56Hnqk3Vz91yoT9qhEYj4nU11KH7kffRnNE/sZsJylyUbn2NHAH5ZCSY3IIy1cYsjTq58gXsMSAEoXc6mQDkg0XeU+eTp4v7I93A4Uy7p4Swc35ymq0V14RBpsbkxfYtQbJYJ/O2hgts1QgsIjlrQQj+6VrlO7vMDS+11pVNMM+A/va38WOmil7r93Yjj/A4ScsKAa56OkorKebpDg2jH5eRy97SLffYY0vRy5VYJno4jiOIzdr48pUsghaMP8vG/AyzjzDk7Vs60VcywA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZa2NQF4CStIOyB2wVa0HXIzs0NENlBhuvNbVoolay8=;
 b=Uc7DzzCk4DSkIAAtPZBcwVUMaZpfIo+Uxkk7eAbw1aJTrak1t/VshZupNTZKetvYZxiG0zuMQga7vf32936dP3vBYnxi27lwuweq3tysL2w/cdfibHYLjC5zJduz4emkro3TEwG77GiP8uo3nlMI9M4b3UShYwVaDaUZg1VdxQFRyJJ0mLGRrHXvQxMIbMICbGcoBLQcNICBrbh78hvUNl7Yffo95VYFUpUBRfE4YRkguSUcwHKoK8uMwokYMWVUzwczE824EavtLQEHtsQ8Af9F/DbKI5PzC6wHSUrpJx5VZ5RL4eCLJpq6TY1RLwHF0ICR5gAIqtb+OSR5ELLIHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZa2NQF4CStIOyB2wVa0HXIzs0NENlBhuvNbVoolay8=;
 b=ZpE1nRdqClWmvHkM/Ghzct1sH8kU+w29AYYZQfcPyEn8BFzd09upSn86aTJWy0p4xO1rwC2GdxYyYiu2dc7z0fCWQ/VJ1lQtwWYL8+MRFfjEhQR9FYJDs2INEEzoFg2Xuuv/aYj33rSwlkcTNwOFwJJv87SKY6XL4h1X1RODtnM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ2PR12MB8832.namprd12.prod.outlook.com (2603:10b6:a03:4d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Tue, 11 Jul
 2023 16:34:43 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f870:5325:36eb:e741]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f870:5325:36eb:e741%2]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 16:34:43 +0000
Message-ID: <829a066f-f16d-f787-6127-b208ddef2619@amd.com>
Date:   Tue, 11 Jul 2023 11:34:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 0/8] x86/resctrl: Miscellaneous resctrl features
To:     "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
        "'corbet@lwn.net'" <corbet@lwn.net>,
        "'reinette.chatre@intel.com'" <reinette.chatre@intel.com>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'mingo@redhat.com'" <mingo@redhat.com>,
        "'bp@alien8.de'" <bp@alien8.de>
Cc:     "'fenghua.yu@intel.com'" <fenghua.yu@intel.com>,
        "'dave.hansen@linux.intel.com'" <dave.hansen@linux.intel.com>,
        "'x86@kernel.org'" <x86@kernel.org>,
        "'hpa@zytor.com'" <hpa@zytor.com>,
        "'paulmck@kernel.org'" <paulmck@kernel.org>,
        "'akpm@linux-foundation.org'" <akpm@linux-foundation.org>,
        "'quic_neeraju@quicinc.com'" <quic_neeraju@quicinc.com>,
        "'rdunlap@infradead.org'" <rdunlap@infradead.org>,
        "'damien.lemoal@opensource.wdc.com'" 
        <damien.lemoal@opensource.wdc.com>,
        "'songmuchun@bytedance.com'" <songmuchun@bytedance.com>,
        "'peterz@infradead.org'" <peterz@infradead.org>,
        "'jpoimboe@kernel.org'" <jpoimboe@kernel.org>,
        "'pbonzini@redhat.com'" <pbonzini@redhat.com>,
        "'chang.seok.bae@intel.com'" <chang.seok.bae@intel.com>,
        "'pawan.kumar.gupta@linux.intel.com'" 
        <pawan.kumar.gupta@linux.intel.com>,
        "'jmattson@google.com'" <jmattson@google.com>,
        "'daniel.sneddon@linux.intel.com'" <daniel.sneddon@linux.intel.com>,
        "'sandipan.das@amd.com'" <sandipan.das@amd.com>,
        "'tony.luck@intel.com'" <tony.luck@intel.com>,
        "'james.morse@arm.com'" <james.morse@arm.com>,
        "'linux-doc@vger.kernel.org'" <linux-doc@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'bagasdotme@gmail.com'" <bagasdotme@gmail.com>,
        "'eranian@google.com'" <eranian@google.com>,
        "'christophe.leroy@csgroup.eu'" <christophe.leroy@csgroup.eu>,
        "'jarkko@kernel.org'" <jarkko@kernel.org>,
        "'adrian.hunter@intel.com'" <adrian.hunter@intel.com>,
        "'quic_jiles@quicinc.com'" <quic_jiles@quicinc.com>,
        "'peternewman@google.com'" <peternewman@google.com>
References: <168564586603.527584.10518315376465080920.stgit@bmoger-ubuntu>
 <TYAPR01MB63304C114A2C0E8B7BB537DA8B24A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <TYAPR01MB63304C114A2C0E8B7BB537DA8B24A@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0102.namprd05.prod.outlook.com
 (2603:10b6:8:56::22) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ2PR12MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: 2569976c-8a7c-43a5-c834-08db822cbae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2RBfbtW92Hdh3ITG9o9haTSWpChhPJ9IeKlJN7vlPOoRei9qkpnJngI5qjM2bHigI2kSVlEY9EmtE734DF2XxC7YGcYbKIxPyA+u82o8M7Dgpd1OLNMUgvsrMv45Z2faBESOJQIXbJRjRtQkclA8EAugrmjbEUSGr27ygHgFTAyFMJEYFH5Fv3H7GfEJohDYgQRnc/x4LbyuhCQTxS6rfdvZlsqYm/UsHpJHkMQ/iL3MnBSr4sxTdls+CgdnjrSLzWqOLmdl/eXW9AvPPfeAW7mIbeT1UbzOqpL4TgU3ZKBqTe4KyIFrez6qNC6t7IJAxnBDw0/FtiFD5pECeZgRaI2AEzb0I/cqidWnLdtfOhh/beBNR8AZGdf4910joMx2FoL6kNfP+JXjM08xD1a2O/S4sZJNHLYs8Y3s37+bHz2sXosm2wqXTpKIohQXYuCLeogzTtRu75IUrkRHyI1Acu3NMoMNBoddbyuDrDWvGURMIqYSNYESCICLxKJWTGALI8H6XDoQ2GZkWQe7+ERpc61F9EXugf4iQDsRcQ04Z6VmQE9+giHtLhyxLPYRZ8m6NBPgW9jNzY9REian99WoU40+Ja5if4LC4WTR95/BF4oWgQw/CMGLUcKM82NvwtK4tXL+b31R3XqXn+itIryZNzasCznlGQ2eyaYx7NnZ9vrzxvrMace+Xk7HCvs8yFuNt3s84G6KVC7h/RVsEZXWzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199021)(478600001)(38100700002)(54906003)(110136005)(6486002)(26005)(6506007)(6512007)(53546011)(186003)(6666004)(36756003)(31696002)(86362001)(66556008)(4326008)(66476007)(66946007)(8936002)(2616005)(3450700001)(8676002)(5660300002)(31686004)(2906002)(316002)(4744005)(41300700001)(7406005)(7416002)(491001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUY5RFg3Nk5pV21nVzNoQ3J0LzROWExIRU9Sa3hReXlkRU5yUVkwZy9OdS9i?=
 =?utf-8?B?RENpVFUrTEFqQm5wY0N6Y0FzcjFTbWk1VS9UUy81aE5ET2F0RDVNc1h0Yldn?=
 =?utf-8?B?Z0ZkUzN3cFNUU3VYVlpsWFphaDQzQUNIclg5aUNtbG5zQmpKZ2JuRjNCOFkv?=
 =?utf-8?B?dXRUWkplQzJ3NEg1RmMwOS9QTG9xU2RSQ2IvdXppcmpEdWVJMnd4U2I3Y1Jj?=
 =?utf-8?B?cTZoZVlkMytYL2dNUmJ6eHh4a3RsWnB2V3BUcFFOdmZLUEkxUm11Z3pyVUhi?=
 =?utf-8?B?VlNWREhZQ0Zqb3hZdWVOcm16QWxrcTZvLzRibUhoM3JDSDJvSjV0aVNvcXh3?=
 =?utf-8?B?QWQ4M3BNeGJSSEt0cDgzVHNweE80RytwWXFlNERRSWRpSmcxUHhsTmJUblZJ?=
 =?utf-8?B?eVdZWEw0eitmVDNZdUEvbGkyY2s1YWRSVE1jQmxLNENZOXB2aTZmdzNTaWVQ?=
 =?utf-8?B?Y2RZNm9YNFpmN2x4K3ZoZ3ZpWFdwS0hNc3hWa0N3Sm1uN0VYR0o5d2FDWk5J?=
 =?utf-8?B?ZmxSK1plZDFOVG5TcitpUjJhRFhtS2U1Q1lRMkpYdFQ2bGYwOHFzb05OblBE?=
 =?utf-8?B?bVNyeXN5ZXpNeHJmUU5xaHI5RnRLM3AzRHJWajN5Z0F0S29ReGNDRjFIb3N0?=
 =?utf-8?B?cDVsVUx5cVF0RUZudnhJOWZlekpESEpLemxHYzJzL1FINWt3V1JRMWFZQmJW?=
 =?utf-8?B?QmpXQ1VlRXZTZjVaM1UzWEtZOVM0eldFS2FpTW5YdlJ5V2pBUjliZUMzTVVT?=
 =?utf-8?B?Umg0eFN4bjZLekozYXVCcnM0QXA3S1RGaXkvRTNJN0hpVlFaa3htNmlVNk4y?=
 =?utf-8?B?cVJwc043RklvOGlRbnhQYjd4TlJxT1E4WXBITE9vd2hQUklQNWxNUnFoRXdQ?=
 =?utf-8?B?Wk4vS2R0UEhvejBGVDhJQUJuRW52T1dETU85N0FWM1RJSzdjT3JrM1VQK1NV?=
 =?utf-8?B?MjZ5VGtEbWhZSzVJSnd6c28rZCtvdWFsOHJ1TE03NGExdVFMaytwdVo0SCta?=
 =?utf-8?B?cktyMkJtUGlPZmRMQmdtTkpPWFlwdzlJMkJJaCtwZlo5QjFxMXhXanAyWTVj?=
 =?utf-8?B?L0h6akJDcTRCalNZek5DdjVsZ3RCdjgvUkNjTjdPMGJleU1nQlBseUxPSkhV?=
 =?utf-8?B?U29SOXVMb20zRjJxenlJQmkxbTJHbXdrZTJYTm1Mbkx2UFFKSFdBVlNBUnlY?=
 =?utf-8?B?V1kxUkd6djJZampBQzZZVmFMUUZCeXlUc0Mwb0k3YWltYXpQa1pqTklNK1RS?=
 =?utf-8?B?MFVNTVZhRE5zYVcvZm5nemFocVhnZXJ1N1cvVHkxTm5MSHdLODZ0amdSK2NO?=
 =?utf-8?B?a0xUamRVUERUcE1ZTmpvZW5TRm1YbkxTWFZjVUtKYUd6YVhKMXVmaGlFUlZR?=
 =?utf-8?B?alZlTkt3bW0vMWRKTFVCRXI1YWZPUVRnNFpMVTlwRDZ5N0Y4NEpXbDF2L0Ny?=
 =?utf-8?B?bGZoRURzTE9pTEVLM2NXaWlOZjIxU1FEN1B4ZGdYMVQ0QTIrbTIxNzVrRW1n?=
 =?utf-8?B?b2hzQS9oV2tqQnRoMzI2SElyNE16M2FNOHNUeVNhSGR0VkxLRHN0QUI0bkxy?=
 =?utf-8?B?SjhOZXlYZ1I1NHd5UEZEYXcvejdlRDR6SU5GSFJLelo2dzdiQVdRMExmWFVW?=
 =?utf-8?B?NnREYlhZMXU3WEFTR3dzcmpkZmxMK2NyRk14NytQY0ZlMHBKaGlnL1l3ZFZF?=
 =?utf-8?B?VnBRaTR4VW5VUGpxbmhIZTNmaFdYaDZpUmsyTUtxTW5CYzVRY3JQZk5YcTFY?=
 =?utf-8?B?NlRzVTIvcm9ndlRlODNSZGhUNUhLLzNaZVcyRGtYL1VGVCsrNnFPU2pTNUE1?=
 =?utf-8?B?SlIyVzVrSFNKYnRhbHJrczVkdUI0WjR1N2xZQmRYNEFkSWxmei9nOWUvOUdC?=
 =?utf-8?B?Q0NxTlQzMnZod3I5NytqYWx6SjRBekh1alFPRWUxbzZ6RGR5bEQxek51V1R6?=
 =?utf-8?B?K2UrR2FvdHZHb09nR3l0dVB4QnI2NkMyNE5rS0ZoMFU5SEY1ZTVHYWtseGFs?=
 =?utf-8?B?RFBvNnVnaEVKWVZkVkFHVWJWNjdaV2tjNVRSSFIzclZTMFJZZEVjdFlUTjlj?=
 =?utf-8?B?RU1CMGdDcEhFV0NuV0NBZDkrZUVySHVxWENhS2gzNVFycnR5ckxDK1U1bFlt?=
 =?utf-8?Q?HuVY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2569976c-8a7c-43a5-c834-08db822cbae4
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 16:34:43.1513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fm21WECba7k8hKaY66eSlbGhGXtoCPxU2SvXWYDEH7hGR4+SFqg9EfuJ+fp6KCOP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8832
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



On 6/27/23 21:13, Shaopeng Tan (Fujitsu) wrote:
> Hi Babu,
> 
> I reviewed this patch series and it looks fine.
> I tested these features and ran the selftests/resctrl test set,
> and there is no problem.
> 
> <Reviewed-by:tan.shaopeng@jp.fujitsu.com>
> <Tested-by:tan.shaopeng@jp.fujitsu.com>
> 

Thanks Tan. I will add Reviewed and Tested by to the patches that are final.
-- 
Thanks
Babu Moger
