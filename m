Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F17616464
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiKBOFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiKBOFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:05:13 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD77656E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 07:05:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgpsORH7GVebGBR+NDNPZcdVb6Ru2qhLPR3mOeNlSph4ZAbwKQC4tgR8x2D7Wfsy0i3/f6IZ6fXCQjg2EeeVe1PgcUBGtFQE2vbo0op8+JEyXsPwRXCS3l7vVMM1x+W5iQWsWNOJ3BfRp7zUwipYldOdF8nxl71z9PLJ3JXMtDXsQHb7gBNKeqIQhpn9E9CfsVE8zSKALYMWMLgxhEGANgGqNGE7WCub820oBLhoL54Rwd/V376WlbMre9lXP/ifOI7LjMtGi/jMxi3voeLse+6t4esoPFKBnbjM0mqOmBU6iSGo29HKY5LhFd3tJNQy+1MThe8WC5s075PJEvEkGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ekabbNHBk7pV2EdlVZR3kqzTms13XdhRbtip/TdChw=;
 b=Jki7qxlOL+xhrbpTZY+bWhtUJYNPremRNiLOR7Uay6aBU1UHGUMWVZqxunyx6TODzHxOfiumgSJpsZgotf8kUyv266FBlXDR799eVcX2NvbaZ6H8cq76Jkxu7Qwjzk5e7tSYfzu+UieLRNfRHZcTzDRPqttFnqOLn6fOp+WT2pQF0SDAdmzZqZ5kcWRlsw9T9Xy2IlAF411OJQilWYzPxYjlJ5Nqo9ID43jyRo9LO+sygrbU1SRsgE7KF3W0/dBTyWb4uoGdHpKcsrIr1+9ejyW6ajBAHZILMuzHrODaWXJMsvMJoW2SG4onw04BU5tEYRQUnryzUYXHfCAUI97qhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ekabbNHBk7pV2EdlVZR3kqzTms13XdhRbtip/TdChw=;
 b=kSP2oTAnfNbAWbNw6KC1K4H7i/BhIUo8DkAJQGUrNOYZukIYu3ZjWivOQm5pTVSshXgAESOIYfYBpPKghaPhnrRAVmeRMTYNEKi29tUu6k8wccy5bqw56RMp2eTLdUzRgMd8dLvwg1jpG70LzpUQp/sKyH1HET144NWuiYs1NgU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH2PR12MB4312.namprd12.prod.outlook.com (2603:10b6:610:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Wed, 2 Nov
 2022 14:05:08 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2969:1cb0:4e83:5de1]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2969:1cb0:4e83:5de1%9]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 14:05:08 +0000
Message-ID: <5ac5c79f-188f-41f1-11db-1352625e870e@amd.com>
Date:   Wed, 2 Nov 2022 10:05:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amdkfd: Fix error handling in criu_checkpoint
Content-Language: en-US
To:     "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>,
        amd-gfx@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
References: <20221101191559.302884-1-Felix.Kuehling@amd.com>
 <c82b6466-9c2a-777e-eaae-388b8bae4318@amd.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <c82b6466-9c2a-777e-eaae-388b8bae4318@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::33)
 To BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH2PR12MB4312:EE_
X-MS-Office365-Filtering-Correlation-Id: c0bf688b-e942-434f-43cc-08dabcdb3fa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BME70mLiWkHoO5kyH7KmJUOMF/ONyp1xExxcin9ogILRoyrM0rsfLAcsCrZJDh7vCumI27luEa9N6i+WziEVIl7237UzrMpyyXQKwvQr00hoj8v0RGvvMgPtsCpk7ESJYI1xcpuu5BRdbZUEpT4cQ/m64v5eXWL7CCeUX6PDtBiCEhDzOilHiTRF00oFPJumPxda2RPndMKKzCjQ0rJR14VQJLkh3qpwN7YUBUSxM78QKbHdm0yJRtqhzyKdhDO/z+9rGcvLZ9t5xyxK8Sbz4VvVUTf6KH9XYeZSQcNR2gdeKTVj4wGDWhqVlCrZJbQ9ButB0HMc/bdJP1gNAv8HhZWK4NRwocm3KovNo12Fs4VKMadVhfmOJfkw3TfeU/flxLyMhacd0i10X/Tl5Us2mI5QTQ1UlR1XH3TxnkIkBSEmQTOBkFTFpukqcs+ndTjjFjYnUak85zJDXss9Q8a7VqsUzO6JJyWUO3Q+LV1aQwjuP6aMpSmwkayXQOOG9Z02Jr7CX/JmA/4FTrMLp8OCE/TfSukxHe2h/gUSmJmbcgd5VCdKAjtuIe7U5o7Rg9R9LNws3B8z3Da/sfkvyzGbmRedjuTNMhB4ZUCLYqH4vzgpO7/c8MBgXz1CMsjqYrKP1PiBlFEOZyDF3RGuKGUMqQstFWfwqmVshmZotlmBnOVsZA2GMVfZZa0Fc3HE2CHJpI97CGrQcjYuCeNUngCkrqPNxCIrJ4C6/AzywtWYSoFBGrL5vZ4OdIDYeH2WIb0z9yJBFj5BEjym3Inf4vglZlGMmHwBpbBW4I36a4TI5fUyZGtp6XAguSerW/HYOdPNINks+Tj4NG1UeV7LsodH/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199015)(83380400001)(31686004)(2906002)(6666004)(44832011)(966005)(6486002)(86362001)(36756003)(31696002)(38100700002)(4326008)(186003)(6512007)(26005)(53546011)(66946007)(2616005)(5660300002)(66556008)(478600001)(8936002)(41300700001)(316002)(66476007)(19627235002)(8676002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWNJNHROVVo3NTYwb051MmdXb0lrK1ZYYlRnMXdyYXNTaFRUejI4bWwvMjhh?=
 =?utf-8?B?RUZPMi9NM3RxRkJqRHA1Wk05WWU2Sys5UytIY0t4TG55V2hUYWJFTmtEa3Jx?=
 =?utf-8?B?LysvQXdZYTZvN0h6RHdMK3daQ0RmZ1pBazVsZWUrd3orM1hqQ0R3bmlTamdM?=
 =?utf-8?B?aDZSeGNSWnhyZnVYakZ3YTl5cUJETFJibml0dDJWSXgxS1dXaC9sMVFLNzFH?=
 =?utf-8?B?ZUVLd2hnZVc3SUFZVzFKSmJWQlBUbi9pYnJIdkppeElycWk5Z0VJUlA4SXR2?=
 =?utf-8?B?RmQrWWpjbUxVcTYzUmxaajdsMlFEbGtyWUVicXpYRHJIV2x1VkY2MEJHTENx?=
 =?utf-8?B?b1lDWnpDMVBZNFNlMERsRDludjFWU3hZZFpRUWNnc1VkbElnV1V6WDB0OUFU?=
 =?utf-8?B?bkd3WUVYR2d0Y3ExanZXdzNqNjI0MjJnOWNMb1MzNmExTjloY3RuK1dBVC8x?=
 =?utf-8?B?Mm5iRENaT04wSW04ZmFWWEhIVUNQeGl4V3A5Y0hJZEtzRXdVc01jL0NxUmo1?=
 =?utf-8?B?WW9NM3JKZ1VvYUI2Z3B1WlVlSHJsU2FsYXRrWnBoZ3dVWHltWmxmOUMrZHRV?=
 =?utf-8?B?UE9GR2J3L0lrVzg3c3pmZDBBVUFQOU1YZzE2dzhjYUtxN2NrMXBVa3RaajY0?=
 =?utf-8?B?b0hIWmhNbTVCRk5aRWNlYzl6ZkVGTDlENk83QmlLTTl0TXQ4S0N6Mm85SjhX?=
 =?utf-8?B?UDdQaks5NjZYUWFIU1BjQXQ3N09lM1dlODFvZWJDMFJPK2ttZHBOU2o1M2Y1?=
 =?utf-8?B?MU5xRmtzclVKQmd5aThiZ1RibTVnSXZTQ0xJbXJHVTllVFd5VVloSWE1U0Fs?=
 =?utf-8?B?SlFSOFJ5M2hxOWhGbmpsMTB2dVkyRE9hSGhjOEZNc01WaENlTzgwaWJNWWlB?=
 =?utf-8?B?WXIxM3RPOUZHZktnL0pRd3lncTNDbDg3MnJPakUvV0FLZzFZM3FCaHcwNG9V?=
 =?utf-8?B?c1k4RFVPOG5TUmpPU1hEbTVuZ056emxzb0p3SUZqV3pEdVZERlBEb3EzSDhn?=
 =?utf-8?B?RGhFSTNZaUZMVk1leVhvVTNsOTh1b1hFUVladjdjUkg2dEdvek1qbmIzWkoy?=
 =?utf-8?B?RUd2UDh0UEhhMmxCKzFFbzFGNktlRHYrNzY3VEZyMUc5Sm8zc3NJeEs2MnZo?=
 =?utf-8?B?TExEUXc5anJPaXdoNk4wdWZNSFlDQU4rRldzTE1OOC96MGs1TVJOUElKUXYv?=
 =?utf-8?B?MWR0QzkyaUUvOFI3eWVDcFFsVTdIc1lFM1E0aGpWMk9oQkw4QmJjY2xEMjdP?=
 =?utf-8?B?ZnRpVUovcmxVZklJdjNhNFZDUEdzNEVGRVc4ODVmUWxVRGFhZjJEMldTL3dm?=
 =?utf-8?B?NEtJWmRCTmdxTGRhUkJpLzduZGlCWW5wTVlvMHZwLzRMYjVtQnJ1SjM5N25V?=
 =?utf-8?B?NVpsTlFlN3EzRXJ2b3ZJNTJYWHUwSit1ejhKS0VaVW53U2ROWksxc0U2QVYr?=
 =?utf-8?B?TlQrYjlueHlwYXQ1MnlsYXhpZ0dGOEZGTitTUHNyamhDamJ3NGs1NWlnajQ2?=
 =?utf-8?B?MVFkbWpCb0JKK1lyT28rbVFSd0ZtcEp5U205N0Z2b0xtRHh3MVN3S3N0b01k?=
 =?utf-8?B?amU2REtkUTdyaWFmVFZqazhCT1BwVlA0azhnSmc1b3lqSURqNHZLTDZadGxY?=
 =?utf-8?B?Y3hyUmZQYXJka2ZoS2EzS3RHY2JPYnJmVk9yN05XOXVhVEFsYTlWd0doeGhM?=
 =?utf-8?B?WjUwUGd4TEJpTzRHL09MaTAzZHhqU0xZODhYREh5NDB4OGkyTjBFRFBYMi9U?=
 =?utf-8?B?bU9sZG45WXpTN252elJOS3JNNGszOEJQaFYrZS82RURpZzRHZlRKdFhjcFZT?=
 =?utf-8?B?MDBBOHFFLzQ3eEtjNDRtMmZsMGdUMjBsd2E0bGxwSDNYeTluNmV5UG1ET2Q0?=
 =?utf-8?B?TUxLMTVhWE5wTG0wbGQ2RUhoMHE3NjBmbTJOWG5melEyYkF5QWo2SmJtL3JT?=
 =?utf-8?B?RDd0b1BHRUtqWnJkeVlMNFhGS1Y0S242MXZJVUdrcTRkRVhvMkdwYU9seDRu?=
 =?utf-8?B?ekI3QkRGQS9Bb1hCUGFwbjAycGJMeWlpZXdmTWttM2c0MS92UTdaZWdGUEc0?=
 =?utf-8?B?cWIrajRGK0JkQ0s1MG9FOHlGNEJZSGY0L3VzdDJjdXpicnRSVSt1aC9xSHRP?=
 =?utf-8?Q?t1jFMlMsO93wTxFJGrG8ehAz7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0bf688b-e942-434f-43cc-08dabcdb3fa0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 14:05:08.0017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tk277u5ZY4MXNsK8Ep84KFflXBTXd3esjbhbTANVt0zT+7wnK4ogJnCSejRkqEO7CQnPfDycjHsEvezIyJxVCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4312
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-11-01 um 22:19 schrieb Bhardwaj, Rajneesh:
>
> On 11/1/2022 3:15 PM, Felix Kuehling wrote:
>> Checkpoint BOs last. That way we don't need to close dmabuf FDs if
>> something else fails later. This avoids problematic access to user mode
>> memory in the error handling code path.
>>
>> criu_checkpoint_bos has its own error handling and cleanup that does not
>> depend on access to user memory.
>
>
> This seems to be breaking the restore operation. I did a quick pytorch 
> based test and I can confirm that restore operation fails with this 
> change applied.

Ah yes, we need to restore things from the private data area in the same 
order that they were saved. I'll send an updated patch.

What's the cause for the call trace below? Is this a kernel oops or a 
warning? If it's an oops, it's concerning because it could be caused by 
a corrupted checkpoint as well.

Thanks,
   Felix


>
> [  +0.000003] CR2: 000055b6726e0020 CR3: 00000001283fe000 CR4: 
> 00000000003 50ee0
> [  +0.000002] Call Trace:
> [  +0.000002]  <TASK>
> [  +0.000003]  kfd_ioctl_criu+0xd4c/0x1930 [amdgpu]
> [  +0.000185]  ? __might_fault+0x32/0x80
> [  +0.000004]  ? lock_release+0x1fd/0x2b0
> [  +0.000010]  kfd_ioctl+0x29b/0x600 [amdgpu]
> [  +0.000153]  ? kfd_ioctl_get_tile_config+0x130/0x130 [amdgpu]
> [  +0.000158]  __x64_sys_ioctl+0x8b/0xd0
> [  +0.000003]  ? lockdep_hardirqs_on+0x79/0x100
> [  +0.000007]  do_syscall_64+0x34/0x80
> [  +0.000004]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  +0.000005] RIP: 0033:0x7f1c87e7f317
> [  +0.000002] Code: b3 66 90 48 8b 05 71 4b 2d 00 64 c7 00 26 00 00 00 
> 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 
> 0f 05 <4 8> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 41 4b 2d 00 f7 d8 64 89 
> 01 48
> [  +0.000003] RSP: 002b:00007fff630af518 EFLAGS: 00000202 ORIG_RAX: 
> 000000 0000000010
> [  +0.000003] RAX: ffffffffffffffda RBX: 00007f1c89351620 RCX: 
> 00007f1c87e 7f317
> [  +0.000002] RDX: 00007fff630af5c0 RSI: 00000000c0384b22 RDI: 
> 00000000000 00005
> [  +0.000002] RBP: 00007fff630af550 R08: 0000000000000000 R09: 
> 00007f1c87e d7c10
> [  +0.000002] R10: 705f757067646d61 R11: 0000000000000202 R12: 
> 000055a4a05 14c60
> [  +0.000002] R13: 000055a49eb81540 R14: 000055a49e90eea9 R15: 
> 00007fff630 b069c
> [  +0.000010]  </TASK>
> [  +0.000002] irq event stamp: 50181
> [  +0.000002] hardirqs last  enabled at (50187): [<ffffffffb61072a2>] 
> __up _console_sem+0x52/0x60
> [  +0.000003] hardirqs last disabled at (50192): [<ffffffffb6107287>] 
> __up _console_sem+0x37/0x60
> [  +0.000003] softirqs last  enabled at (45940): [<ffffffffb6bd4103>] 
> sock _setsockopt+0x223/0xfa0
> [  +0.000003] softirqs last disabled at (45938): [<ffffffffb6bd3609>] 
> rele ase_sock+0x19/0xa0
> [  +0.000004] ---[ end trace 0000000000000000 ]---
> [  +0.000002] amdgpu: Could not allocate idr
> [  +0.000245] amdgpu: Failed to restore CRIU ret:-12
> [Nov 1 22:11] loop0: detected capacity change from 0 to 8
>
> https://github.com/checkpoint-restore/criu/blob/criu-dev/plugins/amdgpu/amdgpu_plugin.c 
> :
>
>
> (00.093977)     11: Added GPU mapping [0xC093 -> 0xC093]
> (00.093982)     11: ===Maps===============
> (00.093987)     11: GPU: 0xC093 -> 0xC093
> (00.093992)     11: CPU: 00 -> 00
> (00.093997)     11: ======================
> (00.094002)     11: Matched destination node 0xC093
> (00.094007)     11: All nodes mapped successfully
> (00.094012)     11: Matched nodes 0xC093 and after
> (00.094017)     11: Maps after all nodes matched
> (00.094022)     11: ===Maps===============
> (00.094027)     11: GPU: 0xC093 -> 0xC093
> (00.094032)     11: CPU: 00 -> 00
> (00.094037)     11: ======================
> (00.094041)     11: amdgpu_plugin: Restoring 1 devices
> (00.094319)     11: amdgpu_plugin: amdgpu_plugin: passing drm render 
> fd = 10 to driver
> (00.094326)     11: amdgpu_plugin: Restore devices Ok (ret:0)
> (00.094331)     11: amdgpu_plugin: Restoring 184 BOs
> (00.094349)     11: amdgpu_plugin: Restore BOs Ok
> (00.095791)     11: Error (amdgpu_plugin.c:1830): amdgpu_plugin: 
> Restore ioctl failed: Cannot allocate memory
> (00.095916)     11: Error (amdgpu_plugin.c:1850): amdgpu_plugin: 
> amdgpu_plugin: Failed to restore (ret:-1)
> (00.095951)     11: Error (criu/files-ext.c:53): Unable to restore 0x143
> (00.095961)     11: Error (criu/files.c:1213): Unable to open fd=4 
> id=0x143
> (00.096078) Unlink remap /dev/shm/fvKoKz.cr.1.ghost
> (00.096152) Error (criu/cr-restore.c:2531): Restoring FAILED.
> (00.096181) amdgpu_plugin: amdgpu_plugin: finished  amdgpu_plugin 
> (AMDGPU/KFD)
> "restore.log" 4194L, 201090C
>
>>
>> Fixes: be072b06c739 ("drm/amdkfd: CRIU export BOs as prime dmabuf 
>> objects")
>> Reported-by: Jann Horn <jannh@google.com>
>> CC: Rajneesh Bhardwaj <Rajneesh.Bhardwaj@amd.com>
>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 27 +++++++-----------------
>>   1 file changed, 8 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> index 5feaba6a77de..aabab9010812 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
>> @@ -1994,38 +1994,27 @@ static int criu_checkpoint(struct file *filep,
>>       if (ret)
>>           goto exit_unlock;
>>   -    ret = criu_checkpoint_bos(p, num_bos, (uint8_t __user 
>> *)args->bos,
>> -                (uint8_t __user *)args->priv_data, &priv_offset);
>> -    if (ret)
>> -        goto exit_unlock;
>> -
>>       if (num_objects) {
>>           ret = kfd_criu_checkpoint_queues(p, (uint8_t __user 
>> *)args->priv_data,
>>                            &priv_offset);
>>           if (ret)
>> -            goto close_bo_fds;
>> +            goto exit_unlock;
>>             ret = kfd_criu_checkpoint_events(p, (uint8_t __user 
>> *)args->priv_data,
>>                            &priv_offset);
>>           if (ret)
>> -            goto close_bo_fds;
>> +            goto exit_unlock;
>>             ret = kfd_criu_checkpoint_svm(p, (uint8_t __user 
>> *)args->priv_data, &priv_offset);
>>           if (ret)
>> -            goto close_bo_fds;
>> +            goto exit_unlock;
>>       }
>>   -close_bo_fds:
>> -    if (ret) {
>> -        /* If IOCTL returns err, user assumes all FDs opened in 
>> criu_dump_bos are closed */
>> -        uint32_t i;
>> -        struct kfd_criu_bo_bucket *bo_buckets = (struct 
>> kfd_criu_bo_bucket *) args->bos;
>> -
>> -        for (i = 0; i < num_bos; i++) {
>> -            if (bo_buckets[i].alloc_flags & 
>> KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
>> -                close_fd(bo_buckets[i].dmabuf_fd);
>> -        }
>> -    }
>> +    /* This must be the last thing in this function that can fail.
>> +     * Otherwise we leak dmabuf file descriptors.
>> +     */
>> +    ret = criu_checkpoint_bos(p, num_bos, (uint8_t __user *)args->bos,
>> +               (uint8_t __user *)args->priv_data, &priv_offset);
>>     exit_unlock:
>>       mutex_unlock(&p->mutex);
