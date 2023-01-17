Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1610E66D549
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 05:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbjAQEVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 23:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbjAQEU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 23:20:56 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEDD93FC
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 20:20:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQRUJFPmnH7iHz8fiCLvnjRpLXwBcCixqY3/I9NeV3uo5fQaU+qZ1S0IrDnZAFvHdVx77h6Jc5q4+iVPs4miS3i3sLytP57jNXvlY1NZkHOBp/uqNWCD5SZAf+U/6XKmdgMNv6jB1DDMiLorqbhIedRScPztrLPAXRKQdPBgpMYrgEsJXxKhilFmHvSyhYYADMWP75/eJn6kWIfW+VrczYOHoUJqjJUjBohZboaPL6uhs894tmBj3+SJi2DuHK+Zfhvf4YIMmtAr0pUZcZPR5Hczl2xYMaT+4fP+V18dpK57YjP/ucUcTKJ3LORUtVQGwxT037EjB3iKhoklzg5eGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swNR6rEdQphQwyIwnMSKUo5ribw8VxACZHE0Ri620Lw=;
 b=WZx6krhuC7UCw8P7l2sDoaV4RXDYiiVCanb4eKwPIo0e7cigFk48iphwDvJT0j83ftQgv/yC3vCh2KcG07gmzesZRyuqn5ohfDfbR/aLHsU9C+Dqo+WiOm05nAA+8Ygo+1j1VvYUJdH1KULviQ5ZWxPS6tlrybCx6/jQ58W2JqTYAY6g8s9hvXcKJShKORnBEmjhaoDIu0SoCM2tkG5HjcW8HRVPK95LcKfqZCbt/sFQzcXfjMuKnHWXLPSdKqyAGhbktx9wtHzbcTU3yK7IkbmYr0rkgPAkfT2f4OVtibKYwZNh7F9N18JodZlmvy6XeJpjkwrfkuXUpKeNsgqOXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swNR6rEdQphQwyIwnMSKUo5ribw8VxACZHE0Ri620Lw=;
 b=jthJHg1Zd4Wch7Z8EzMenEwu9EUVjbmDJQ6KchMY6yG4+6e+jHtktI6/NbhPdHgLdKhkMrkIKz3ozSXB8ePezD8FRjUyPjUo0GQFwgTOnGX/n5ofF/zWFeWZ01i9XTlsp3JYoQ0jEtY1+Y9F+KMpLkr7y5uVWuERZLQDY9nDIJI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13; Tue, 17 Jan 2023 04:20:47 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::6add:bbb2:9c75:c013]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::6add:bbb2:9c75:c013%3]) with mapi id 15.20.6002.013; Tue, 17 Jan 2023
 04:20:47 +0000
Message-ID: <04dc1bc9-05ed-f6ed-f01f-7d28600fc0ce@amd.com>
Date:   Tue, 17 Jan 2023 11:20:37 +0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/4] iommu: Introduce IOMMU call-back for processing
 struct KVM assigned to VFIO
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Cc:     joro@8bytes.org, ashish.kalra@amd.com, thomas.lendacky@amd.com,
        vasant.hegde@amd.com, jon.grimm@amd.com
References: <20230110143137.54517-1-suravee.suthikulpanit@amd.com>
 <20230110143137.54517-4-suravee.suthikulpanit@amd.com>
 <e4d5db37-a7b9-9b33-4ecf-c168b6d41a9a@arm.com>
From:   "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <e4d5db37-a7b9-9b33-4ecf-c168b6d41a9a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:194::9) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|CY5PR12MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: d4648155-fcf5-4960-9657-08daf8423522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: snzMrJodOW8Es7YEtOP977JS79zvGxztVqAJF3X+Vk3sVZJnzjEl/XaWIEZXwJ9pGJ6uTMbGjWfWiIwubZxfiTeGMj7Cm9tF4RBx3Jp5BnijURs4hRqQvYPdYdkHVz3cNGjpYlsF+SaQVjMzTSLnh4izumPmj/R6lX97kUBPFRId7ISlMa8/dg1F/9NCqG5Rs4QDalCk0kIUftCxNPTzODc/kvIBJcXrWCGXSUOoFQxHl2v39LSzi2OQod5riwzZ4fsL/snutMDDTw7intDmytypEbY/ATZaTX7TlcxzrPQ7vw39hUqFjWBm5gW1h4UTVQiiphTkWndp8Co9Itqg3OF3k6RKD/Nm7RgvHyyClR4jD4SK+W7N/XXEWkbstttGYS28OV2aQEsLN02YqAvxbUYopVDqXBGm6qV719LXX61A6gb7MOQb3cWBB4jsp/e4O8mKBTsplp6Ul3kVoKuJauA5aiN98Z1LQYbZ3/8UPixG5hh3sTFasD+fjKX/JoF6qDk+O09lj/BzGS6mpY5xihd5zx/IV0bHwRCVxHzg1Dkk7kHbu6GQ7ESk3Ok69dbUu7k9eLR1FmCENYsxslP7DO5d3RVD7hGGUhJEVGWtrjkbs/jRRFtzCh1LXcY6JJkAwJ7Lj88/aUGbgPKGB2fsODcjzxBzd39JwF7KpTf6d2fb4LMCzrzqW6QGX1SYFH8uxY4yatTdOEWTBWbUVojKkbmUuph3b9UB5wrCTKVmZdo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(451199015)(31686004)(8936002)(4744005)(6486002)(478600001)(5660300002)(4326008)(41300700001)(26005)(66556008)(66476007)(53546011)(36756003)(66946007)(8676002)(2906002)(316002)(31696002)(86362001)(38100700002)(6506007)(6666004)(6512007)(186003)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3pQeVB5d0IzeTlvaFdUQjg1RmZvYlo5RUx1S0lxTTRiWThtK0hJOXdMQjFn?=
 =?utf-8?B?ek9HU0NBelEwRDQwcldLTXo4eXFnK2VRSTVlQWZkczRWVTN3MHNyRzc0YmZK?=
 =?utf-8?B?bVBkcGU3ejg0b1hvU25Yejh4NzFpd3AyYytuWXNKV3l0TE5QcTIybmR1TW41?=
 =?utf-8?B?ZSs3NjJJOFVWTkFvaDN1NHhQTjU2Vy9TMEhzdTZ6dElMOXZQd0xaeUFkdHQw?=
 =?utf-8?B?RXdwVHdSNzNPS3dENEQvemVZM3ZaRW9hU3JGZzkyUEt5MnVlamlEWVRiV2pm?=
 =?utf-8?B?YmJYUWhYeUJxTzJySXZGdG8xV0xQb0ZrUjNFT2pWN1RYWVdORlcrTXdub1FX?=
 =?utf-8?B?RStNWjdjazRuZFFwQWxZRzVKNHkvekZicUNSVHdmRmkrYXAvOVJmb2VIdVc4?=
 =?utf-8?B?THduOXJlSGVDcWxaK3pyZDlDWlZQUk9ObXMrQkdoUzAvc21Db3o0YVkvaXM3?=
 =?utf-8?B?NnVPYnVkNDZPSGtRcWwwYUJoUTdHSURZdmZLbXpQTGZwSGdpLys5a200Wita?=
 =?utf-8?B?R1lWU3ZBV01rQXFrdnVPL1BydlJqUFY1T0Y5VDJxL3JNTys3RVhZTThNZVFG?=
 =?utf-8?B?RlZzb1RCRzB0UDJiNDM0bDZqaWFjT050U1lLUHhPV25xMkgyZmZORWJ6K3Rm?=
 =?utf-8?B?YVhpMHQ3bGZXU2YvbkFqUlczSnhjRU9CeVIxR2NwQUVmSSsvY2R5MkEzNW84?=
 =?utf-8?B?bUJjVVl3WUFXeU5ybUlWckFFTFNoaURDc0NML0hhcjRnN1loTDhoZTQ5U0hB?=
 =?utf-8?B?SG8rYTdUaEhiaThKOC9vTHVCZXB5ZUZtcHc3WHRrYm5PUjJXUjF1aklqazF6?=
 =?utf-8?B?Y3o2b0V1VHNJT3lXR2NZSitzRXpNVWl3WDlzUzNYa2NuOWVTZStkZTQ4Zktm?=
 =?utf-8?B?NDdZcjcyaEVNMmlyaUJlTENqWnJTQ3ZwTjFLTHgyS013bnFiUmxFRm9jUG1B?=
 =?utf-8?B?aWJvblpIcHJjSW0zUHBPOFF2blBMUEVkSHdZME4xOUlSWXIzR0dycE9CMTRO?=
 =?utf-8?B?cjZiaHAzbzlMTjgwSVl3YWZXbTZ2Rk00SWFuVm1HbHRVSjhuSWRhbmdWYTdV?=
 =?utf-8?B?bnEzcEtkRWxwajBQVWVGdXQ4cDFGZGkxZmp2Smh4MTl1blJqdGl5RmtTTUly?=
 =?utf-8?B?TUV2aUhuU3ZXSVRXYThlN3NwbWpRbDZ1dDZsNzBoU1VSeXFIdWFvUFl2bkw1?=
 =?utf-8?B?Y1VUQ3BwZms5V2I5TTZabENCcWVpVGFldURHUFlQS1BBV01vUXJDWUVCd2VZ?=
 =?utf-8?B?YkorZ3A5TWEweHYzeE9ncDVhckFHVWhsTGYyT216ajJxZnJUVzJuN1o5Uk16?=
 =?utf-8?B?MjdGb24valNYenpybWV3TjNNdXdvKzdaQi8rZjVFOFo0NmJjRWRqYUd5MlY0?=
 =?utf-8?B?QWd4dlVMTFpGOGRreExySlQ2cTlqZnF6QzFuYVN4OFRZTjh3Z0JwK1FsSnFj?=
 =?utf-8?B?QmJpOC9oOGk4WlQzVkhEeVlrWnJBUHNUeGRYb0I2MUJPNkErcG5GWUh1VkNu?=
 =?utf-8?B?N1hidmVJbGZsYUkwaFE2ejFPL0hlLytSTkJwTXczL0l4Mi8veFhvRWtlRVIz?=
 =?utf-8?B?V2crSGVVbm5EbC83T2o5QlVMY0pJVlluNnhuZUdDZ3R5YTFrQ2pzTzFVN2VN?=
 =?utf-8?B?OW1FUmhqaG9ZMHlDUFJJcE5oN0tFZEFvM1Q0YkhlQm1YK0l3dktVRzFpYVha?=
 =?utf-8?B?c2lYNjJXaE1RaXNzTGhJRVl3VEJoek5yOVhmMHhjNFlsTC9UMjhtdzhDQUNz?=
 =?utf-8?B?di9HTWkvRGVaZzVibUdZWFpQTlAwQkZCbG1QZlpCbXdrMjVZUlZSeXZYSjQ5?=
 =?utf-8?B?ZDRoM0txY3FNL2FtRXNua3B6WVQxbUFxUlAvalNZWit3aUY1VjNOS1hNbG5w?=
 =?utf-8?B?L0o5Z1JlN1R1MnYwbG9vYllRNTNRR0swbmcwamlIU2U1aHNUelV3alV2Yldv?=
 =?utf-8?B?TUY4eGdqbnRtUHdid1d5c2NSelRsSnhWYjZoTm1vKzBzbFhBQWFZR2dKOExK?=
 =?utf-8?B?dWRGMUFiVjZHK0tVVFJDeXZ6c1FJdnpObTcxeHRTK0VkSHBxa1YrbTUzcmVI?=
 =?utf-8?B?SzdXRFpoazg3VDNWVlArNUk3clRYUHBUVkVUcEdiRFU3a3hpOVZWWnkwVENT?=
 =?utf-8?Q?1ZrgaLbZtHXsiYbXN2E1PtYRs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4648155-fcf5-4960-9657-08daf8423522
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 04:20:47.0898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xg8lVj+yJIXLA8D1o7Tj/uHqmRLMQkPMGzyCSpY5mtFlMC6H1JwLdkiTfIkcukP4kO0A510Jm7cfVUezM7xQpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 1/10/2023 10:11 PM, Robin Murphy wrote:
> On 2023-01-10 14:31, Suravee Suthikulpanit wrote:
>> Currently, VFIO provide an kvm_vfio_file_set_kvm() interface for 
>> assigning
>> a KVM structure to a VFIO group. The information in struct KVM is also
>> useful for IOMMU drivers when setting up VFIO domain.
>>
>> Introduce struct iommu_domain_ops.set_kvm call-back function to allow
>> IOMMU drivers to provide call-back to process the struct KVM assigned.
> 
> Hmm, it sounds like this has quite some overlap of intent with the 
> existing "enable_nesting" op, and my gut feeling is that it's not great 
> to have two completely different "this is a VFIO domain" mechanisms... :/
> 
> Robin.

Actually, the intention is to communicate KVM information, which is 
already available to the VFIO down to the AMD IOMMU driver layer. I am 
not sure if the enable_nesting() has enough information or the same 
intention since that only communicates VFIO domain information.

Thanks,
Suravee
