Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448EC61F4F7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbiKGOJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiKGOJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:09:13 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FB71A382
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:09:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clyrkvXgFuDU96D0rmAgOUk55Vxls1L61GMJanj17SQcIo35KWfGXjdmJQOJh8Pe2gOZNgc8U8lNJ7cPRwij/l1zqGsFldpy20LLWfzPylIJW3fCdmaKtlaPnT3c/2umTgPP3UD2nddw0+Eljs/7dwjjQYejB8kvpKZ7ZWUjar4oGtykzrwsi6ta9ho0ZBAh3Y6VSJK5JhZar9dt31mKtBCzAe17+B+3HorzMjG2KLAt1hJrpZJA7r7+kHPTlgux6dAteAi2ibyMQtx15OtZ0x4aXT9ZLf+NzCKmYoDxDgmcaUcz84Nbl0d+xyjh9Jr3GubK9BFwPnI/HGNb6scGeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=in9EP35SP0KbxWOYrvyEmZd9TZ/jc3DSp5dvJ7FLrOA=;
 b=Qfd1MzcNOXJRyLGmjRFaTpnJqWAP11hTDVzJcD17R6h247kJvOptnFI7FW/A2bDY+ojaVxuD0z5qZcV56YrAoG9YbIu4+sIkCHpIrXX2cn/X9aC1PW2SCCUm/uYjA3md1dDK8gY+EmjZRfwav0B4RmX6FxBLNYg7Pa93k+bd554fe2SxkeDJXvALIflGc88ixS53stny9OsNoWXk+2yhkkhuIwqUg4TORBng8XZ+OWzWr8x6XbYQ2lNZE0HepOwLR2lDEBFK+iplF2HIxKFth4l/3XLS8NA2Z0Y0ROUXxLB5mnAybA+mYwkyh/6rzntb4ZdJ//fl0+3f5USGP+0pCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=in9EP35SP0KbxWOYrvyEmZd9TZ/jc3DSp5dvJ7FLrOA=;
 b=wkQickL0GoCVdreQOOqT1NXER9W14FyDC23o8Npr0Qx6r7/qR0VQn6HKguRS1KWFGf97B3nR27uOnURZtt1CSHfy9fPewvZAvpjCgaHIvG1htLxwtJxQB3gcJwl35VsvCoUu2UcodlTF9Sq927MIqP3cdhUfhfKhSGwPE5tAkUc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by SJ0PR12MB5504.namprd12.prod.outlook.com (2603:10b6:a03:3ad::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 14:09:10 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::4da8:e3eb:20eb:f00%2]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 14:09:10 +0000
Message-ID: <c40b0b21-2a48-ffff-6568-fb55e8f9a15c@amd.com>
Date:   Mon, 7 Nov 2022 08:09:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] virt: sev-guest: Add MODULE_ALIAS
To:     Cole Robinson <crobinso@redhat.com>, Borislav Petkov <bp@suse.de>
Cc:     linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
        brijesh.singh@amd.com
References: <ff480c5e688eb0a72a4db0a29c7b1bb54c45bfd4.1667594253.git.crobinso@redhat.com>
 <Y2V7w6PCUV/IxLBl@zn.tnic> <91c2eaad-92fc-4251-f9e9-7d73cf2b5da5@redhat.com>
Content-Language: en-US
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <91c2eaad-92fc-4251-f9e9-7d73cf2b5da5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0363.namprd03.prod.outlook.com
 (2603:10b6:610:119::32) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|SJ0PR12MB5504:EE_
X-MS-Office365-Filtering-Correlation-Id: 67480747-9488-44cd-5df0-08dac0c9a418
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 19rNX0Aaxh+d3Ml41a1J544lnOEHGL+cZovOwsh89veWw6rgvyo+Im5A4cDegxhqwURLy16wt4Gfp8MjQu7QveN/qQgjn3ZZJhVvaz9lbupOtTptUfirz7xlyA6KYzLHrSg4auLPVJ8gyKvvFV6o3kl9nx7HQafsJ+kKcXD/l+pZTsutOWa4flZJ2NJW/Lh2WGItRW+cDiO9BxQwjHW6pgTfL6ha+UMgfeYz2lJq7Z4qk3oXKUDK4+OjL1GmnG4+ipdSXUm40m2iLQvwkeiDq7BZnAz9X3EpRuTsnVJYw61TrMxM01LpXvxF8sVPCkBKbfy4NwAPsWTJ9O+3DJ6V9h3IcYTaimIEy+E1lL4+b0nyWBrwoKvobablY08RNwhr3s/b0/9xOsl4R8h6HCzxZE8Z6MLzsOXQv9iHB8Sbl9VRqfQPBQ/L5zAdGsZFQE/tH1ffVXEzoSRgp5x/1I5s9ZM9W8gOecyQwibbuKWmFuU2CfpN0BsglkmKHifdeYj4u1Ev0KLp6K605STcWNmazaoTdVSwHrS1acB2G+sb7liLw2yW40xFGXotHRDO8xit4ThiXg5Juo5UZfyj7HkHhooIJOUD8FbQNzf7XX/YS0bilEebUZF496co4+fSq+Cu+6XlXowVMw9Ow/bjv85AL5S8pAVUxsiQ7ypW8ZyIjgniF8ASEts85Fm7SkA4PyL3jAffwA57HzZuanWAPA3fTDgtMj1+g6LW7TsVMzgWeaArHVR6R8yRU5zz7hPtK1ozbTVNHdRDI2I6z56Fvim6plHNrNxKweitXSxj7iXnzxHM2grDCjtIKhvEq7vN9QuVSKZHjPRzVjrF1m91lHXCCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199015)(53546011)(6512007)(26005)(2616005)(186003)(6506007)(4744005)(2906002)(110136005)(478600001)(966005)(6486002)(5660300002)(41300700001)(38100700002)(8936002)(4326008)(316002)(66946007)(66556008)(66476007)(8676002)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUZ0dThnVjFOMktwS2pSNGZ1RHFzaG5wSlZhK2pHb2UvR05yZ1NqZCtnS1d6?=
 =?utf-8?B?ZU4xR0FlMjlvWFBSV20vTmxJRWZyUTN4OHJTcjZsTkhhOEJtZlhtQUhNYnV1?=
 =?utf-8?B?NHVvbndQSDBKVEsvcXltMmViVmFaVFByaDdjQlJWSDNhSVQ4bzJzTXNTU3N5?=
 =?utf-8?B?RzBQRGRzYTB2cnZ0SEovRGlaUzJ2Y2lOZ2JJTTNLMGlxdmdxcXNkVW5xWEhQ?=
 =?utf-8?B?WnZuZngzeW15Y3pSQm8vWDJuUG9pVmdOSGxLVnE4TXVSaW03cXpxTjc3MGt1?=
 =?utf-8?B?UW40QnpHL0JTckM2WU8yMy9WSVl3UVdxWXVDYnBvVEtCSGxCZm5JRExjMDU3?=
 =?utf-8?B?VHNOTEtxcnU4QXRtSkxhZ1JJTzBxRkF5Tk9mY2k4S2l4Rzg4clFCb3luZ0Ji?=
 =?utf-8?B?UndFeW03QVMxQzNreDEvQm1KdXFWOVdkV0tHTWJFZ1I2Y3Q1Sm91ekhVbEx4?=
 =?utf-8?B?VDV2ZnhqNWt5YTYrcmRVTW5nU3VsOHMvVnZDYXBXTW9tNk9DamRCUHYwcUQ2?=
 =?utf-8?B?VFQvQjV2QTl3YmhuU1FSdVNLRU0zOVp3NnREZUc5TnVIVEFzdjVVVWxvMk9K?=
 =?utf-8?B?NjRneEhubzJvZG5DWGFkY0JucnV5YXdCVS94cFdqUlRaMmpmWUhXSUg4Qmhm?=
 =?utf-8?B?Sm9pMjRvbGhDYnVRT0x4V1dQcHVVMms3WFNRcktoeFo4bCtMMlZxMk10dGVj?=
 =?utf-8?B?eXJtOEp3K3pOWjE0OVRTUTBDL3dYZ3MzUE1WaVF1UkpqR3NKZUFRQms0dTJP?=
 =?utf-8?B?ZjNZZnBFWUxzNTk0WVJ1dmk2aTFsU2ZyaEFTc0thK1FvMEN1UkU5S3NYNWpy?=
 =?utf-8?B?cXRXQkVYU0hNS1p3N2JmRElZdlVnSXVtMk5UakVwQ2MyM3ZZOXZEUjM0a05X?=
 =?utf-8?B?UWRSWXdxTFYyajJaU0RuTlltNHJKTHZnSm5zZ0dTdGRPd2V0T3Fwd1BKZytV?=
 =?utf-8?B?SlhIUncxZ2s2NmVxTStYQTJpRnpCRnVDdFNvcEhGWEUzMlNISVFxZUVUTGhE?=
 =?utf-8?B?aFVnODBuWGlsOHBFV1M0YUFUM08zS3ZOMDJMODNaSHFNQkkyY2VGbTBCOWtB?=
 =?utf-8?B?M0pHU01aKzRIWVE5cnQ4MW55V3RONmsrWXEzekJFSHp6TjRNTG1LWllyVUh5?=
 =?utf-8?B?SllXQzF4Vm9MUmxOTEJWc2YwTUdQUFN6ZzZyamJnZno0SENidVRHbEExZDc3?=
 =?utf-8?B?dnNJSzNpTkY4ZWdTQXFJWU1UYW1HRDkzTFc5ZnM1bkVtLzBWMXREMU5PTXpp?=
 =?utf-8?B?SmtJTU56TVZoNEMrUDQvMEtKalRtM3R2ckJXM1FpNU13K29ncDlvd3gvemov?=
 =?utf-8?B?OUduVWtOZzRwN3c4STdBUnR0cWJsK3NVL1B5UFdoUjhtSlBPZmFvMFBUdExr?=
 =?utf-8?B?RkFuc1dyekRWdWZqeEtmK3dKQ2JvQ3V0dWZNVDZqd1VITGd3ZVRBVW16dk1p?=
 =?utf-8?B?bnRGRDRYalRLN056SHAvNnMxMXZYNExDU2g0NUs3N3hHZktoYjYvcmU5OXl3?=
 =?utf-8?B?N0xWZDRlNnpZc3ZqSjltZTE1VytPdHBGYWk2SzIwWm9WZTAyTXlPTmFtZXcr?=
 =?utf-8?B?QUkweWFJNWM5TGNLdU84YjZBdGE4a09JdjZZSW1KMEdXY29PYm10bXNtOTJp?=
 =?utf-8?B?clJGMlA3RUFmR0dVZEdtUlAyUmRMekNHTWdWVkxkeHNjWUorUW00ZlhZZnoz?=
 =?utf-8?B?aURiT202SldzdlMvNkd2UlJtQXZoWk9mN2pFY3Z1eTJOOHRIeU1nNnZTbE1h?=
 =?utf-8?B?YThjejNkRjkyREF2N1hpNStlMWwyVVE5NFExSGFUWUtuMUxvTXBxd3ZlR05a?=
 =?utf-8?B?QjRIeXhDdFB1TWc5WjNxZ2gvM0VRcE9QcUs3NEJISFBjelpQMXl1cVFoSEZr?=
 =?utf-8?B?SzFRSGxyYUVIUy8wRmlCa2U3a2dEZ3hydTA2TDF2L2txSWJBUEtNYVIvekhG?=
 =?utf-8?B?TFUvbVpKNmduQnIwODF4U1Z0eUFXTXEvWHRkR2o5dFpDUmpFMjMzeUpuQXN1?=
 =?utf-8?B?OFRrUGxCMEFtN2VweG9maGpQV0ZqV0huR3o0SmtrTm5lRUlxd0hkWk52dXQ1?=
 =?utf-8?B?bDdCejFRYk5GbFFGbHlXT0RIWHZLa2t5MENNYW5XZzBPdTM5SFlZZjNyQTM4?=
 =?utf-8?Q?Bw2RkV+dmvZygHwTbuHAojfjW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67480747-9488-44cd-5df0-08dac0c9a418
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 14:09:10.1929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s1Zkxxigg/dCsxjsJ1xdYOMEfXGT/V4/AevF/MU7BWmAb06JaYTl06/aTFEUEnAQfphaoaQQA23m4+rSxMIvmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5504
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/22 11:08, Cole Robinson wrote:
> On 11/4/22 4:53 PM, Borislav Petkov wrote:
>> On Fri, Nov 04, 2022 at 04:42:45PM -0400, Cole Robinson wrote:
>>> This fixes driver autoloading
>>
>> What is the scenario where this needs to be autoloaded?
>>
> 
> Any use case that needs /dev/sev-guest, I guess. Saves software from
> having to do the modprobe manually. For example, nothing I can find in
> https://github.com/AMDESE/sev-guest loads the driver, it expects
> /dev/sev-guest to be there already
> 
> Mostly I assumed lack of autoloading was an oversight. Was it
> intentionally omitted?

It probably was an oversight. To me, it makes sense to auto-load the 
module if the SNP support created the platform device as part of SNP 
initialization.

Thanks,
Tom

> 
> Thanks,
> Cole
> 
