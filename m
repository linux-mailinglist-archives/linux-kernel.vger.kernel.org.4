Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F27615775
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 03:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiKBCTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 22:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKBCTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 22:19:18 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0B9BA3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 19:19:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEn5Lvnt5Q8AYFlDQ2rLsfyP1ZxdBf7x4s3Hs57WZKdr8F1zUU7KupcUxMWqTV6qZdK7AaAI3yLWtXFZXuzoEMykbruc2p6PJVlIwbCEaSJwkImgF+IzH6b9LFDP9i2X6zYkGZI1uM3rCgN9JJKsmh9o92/thLIEUvhU9Eq8EXJJB9xHERGmQ1dGWXztIxa0RPt3vvKkHLl2pDDmsZd7eUU+vFoRHxm7f2SMv0mC+xMA3/6EU4tWcyVq3InsOkfRIsSefcw4AA1e+IZYjmkznbYMNc9sS8gC0/E0jbLg3bo3gl1ckX++yJcOBDdBVLZ+YU3E0Jpdu3GriVHwzxuTBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYYSmwiTnsVHQ/vXV7QKDGOzs7DzgZn9d+qSq+BuKwY=;
 b=W+CLP4o6185c1TrA0+KhDZggH0RE14g7Zz6L3Hcn5gVivuyJZGGez/pzYcBPLde1YFxI+ZVPn8GWp9q73PitDT5Q2epBmSyintFHRqkLXlrLr4ujVgaRTUPr7Ft/S0jqg1qxN06S5edxVXjvs1t48hxgJ8LupOm2G3Jd/rlN3DN06KKn/ksoYivSw1Ej1lvUo1O4ZemyPyRwymmOJy31DT3FQMO+1GANw+p+Pw0JyG6rrJbAKsNBBaixjJyx29B3a++nc680hC/R7AeMzRMTiwPc/1j1zRyBpj6FMREzQMFjSyhOSzK/YeWungHJBmp+yfIwGcQ1FsiUVZ3BMf3i3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYYSmwiTnsVHQ/vXV7QKDGOzs7DzgZn9d+qSq+BuKwY=;
 b=42FaOVs0vIfAi/93Rzfg/mGVV4asx/0mmARqLGy038Da5Wk78h/WQ7pL88LEHBC+NuUvVDlztxcR3EpVNFR7GP3TcTFqb1IDO1b3+7x/3MV2+9NNs4U3dE9rF/losHDt7BOlsYuKEpqsJaWpzCQR2oqmTGjeamD8scmMUue0F08=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) by
 CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.16; Wed, 2 Nov 2022 02:19:15 +0000
Received: from DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::8b4b:6c02:e13d:ae00]) by DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::8b4b:6c02:e13d:ae00%3]) with mapi id 15.20.5769.015; Wed, 2 Nov 2022
 02:19:15 +0000
Message-ID: <c82b6466-9c2a-777e-eaae-388b8bae4318@amd.com>
Date:   Tue, 1 Nov 2022 22:19:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amdkfd: Fix error handling in criu_checkpoint
Content-Language: en-CA
To:     Felix Kuehling <Felix.Kuehling@amd.com>,
        amd-gfx@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
References: <20221101191559.302884-1-Felix.Kuehling@amd.com>
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
In-Reply-To: <20221101191559.302884-1-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:610:5b::20) To DS7PR12MB5933.namprd12.prod.outlook.com
 (2603:10b6:8:7c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5933:EE_|CH2PR12MB4181:EE_
X-MS-Office365-Filtering-Correlation-Id: 78226cd3-b70e-4e0d-09da-08dabc78a352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wHIB6qbL/19shKt4kqiyaeSrcPQ7R0r9BMOjFaYyNbWS3KD+K6ryGTexYYZlfoi27feui/zBJMOVSqyGFuM7uAW6oGqOnJ7CNWJobXFrBez61NHCy1NOCILHewAS2i9gK9GX2nYOur6pNz7OWWUh7n9yKGqwTX3ihMSniZ0ujVkazQRfBO9WVq7EbhDXe+jWdjRCA5SsNHOv4wDQmbEKDn3HsA8TlDDVu1bj34E3cXCHVmFCxO06S9weqMpQLOVeWO/7RtUujQZCgfpvCC6URwL8AnUwDV2mtgAIBVMnOMgQeNV5CQ3GBuDNsjsrmAHX8clzEe0Eb8qsVeswiNY1xSwnLlD+MTYaIwlWlwFENMkEhIcY81qYKOxHpIo7fb/pSn7a1+NGY7LaD1sulrkGEIVKvXLMpntTobNd5jc0PJ6RAVx/f8CpLKNMqlp5KeZtjJjDVIU7CUb+eHmcY/0vFRYpcaCm64F6Tkr7EVc17WDosT4u3NN2ImIIN+Z0urnkA/9F4KZWtcLRrPOiLwzrv9DfZXe+BPuVfb2K2cfq8aeHovIwoay42XLjANI8L5diLLCM8bQM4SZoBceXniHO4rsO0WcRMqnFq8r5+K1iDhHysswcF6kDQJD4OCsZy2UF9M+1nuyFDVlcr8JduGWWZkPG4ifmlkE6havQg1dJFmq3dQM6cpleABp5VHe9tJyN5Hycw7nT9zLlNsiMNzXOnhiFQRzc6t1Oz8A9o6Tf0f7wfLlbKspcbrQffVjVbW9TJTZ+0Jy5UtoevKu9n96F+1dxV3g7eZRdr5SOR3C4Okoz86eQDFPL6pVDo4hX8GsR0s+4iGwb9jy3P19RTGm1Iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5933.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199015)(31686004)(478600001)(19627235002)(316002)(966005)(6486002)(31696002)(8676002)(4326008)(6506007)(53546011)(66946007)(2616005)(66476007)(6666004)(2906002)(5660300002)(186003)(8936002)(36756003)(66556008)(6512007)(83380400001)(86362001)(38100700002)(26005)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE9ZV0MxS0RGYnk4YUFsaDRyL0NiTE9vTUhQQU1IMG5sbmN0MkZmMTZWZXho?=
 =?utf-8?B?QkhaSjFSUVAyb3oycUp4WDhHYTJ2SU4rc1RxdExSMXVSdCtFZmpOYnRVTVdK?=
 =?utf-8?B?QVZ4VXN1aTRhQ2pBY2cycjFIM2tkM2xLV2pjNkJJbERMKzR6bXpwQ1BTZE5s?=
 =?utf-8?B?VWF6UERuQUwydVhuTGh6NDhVWkU1ZE5YQ243dUtxeFpNTkdPTXNrc1ZVcUdm?=
 =?utf-8?B?TzJVSy8vOUw0SndqSkpheHJNUUkySmx0Q1BnWkU5U0dnd3VRZENOeStYeW00?=
 =?utf-8?B?VllKcnpjcGVSVFhjbVhqaXZ2OFMyRUdqVEpYcUVGNVU0bGVPdG5mWTFGMWJs?=
 =?utf-8?B?NGVvVXk0VVB2clVkejl4czYyaCtIeDR2bmJ2MmpocXF0WU9CQTQwdEtxekpH?=
 =?utf-8?B?RnVubVhDR1czS0x5b1BJbGZxV3BFMm1CREJ6VXJjOTQ0RUNabGc3elVFdW56?=
 =?utf-8?B?WlQvenpWNzZoWWQ5Z2FDY1E2cHphaGFMYXVUQU84K0dqS3dtZFphcnFyaTI5?=
 =?utf-8?B?WjBDaWU5M1I4SUhhOFdtWndhTDNISGRvajNrMTJQZWFrNll1T2JvY2J3NW9x?=
 =?utf-8?B?Lzd5TExuZlI4ZTM4WXF4eWZaUE81SWwwREFBcUp5S0hDM0l6cjNGaHFoT01E?=
 =?utf-8?B?K0FRQjk3RGdoL21pQWFLdjRZbnlaOEdoOUszNysxUitDUTllemhoWDA4R012?=
 =?utf-8?B?WTlNNlpISzgwV1VRaUttRXJ6a2Y1SnpJMkFZelc3dVp0MWxLRlFLU1RES0U2?=
 =?utf-8?B?T2R5a3g1Ukd0YmRyRXcxT0NBUjhPUkdMZHJzdC9xWkhYZlhnSXg3SVFZU2Js?=
 =?utf-8?B?c2lHV0Y3enlHdjZ0MlZiUmxvYVJWcHBDL1pvWXdIQUlWSGVvZGlEK0VJYWk0?=
 =?utf-8?B?aEVZRlVyVkZEYTUrQWFWTVpuUmFhUnZqc2NZZ1J6SjM2UzJGOENFc0dQUk5u?=
 =?utf-8?B?NE5CSGdZdzVIZ3pVVGlVa2NZei9JZytsbnI4OGdFRStHeG5SVU95OTdnU3VE?=
 =?utf-8?B?RVNvanRiek1oSTFyeVZHclZjc3FJNEZRdUNGb3NHYzBEZkhWNWUxVTNpUXJj?=
 =?utf-8?B?WjhBTEpYd1dKWjU3L3pwSWlBZ3JOUTREQ1VSOE8rT2FKR1ZpWjZ4ek5qOGVV?=
 =?utf-8?B?eWFzUUcxc1lzRDBpRG5YUWhmSTNBRHcyVmNJSDY0RlJGNXI2aitKODJ6b0JL?=
 =?utf-8?B?OEhCL0lhTFgyb2ZycWordWxVQlF2aXJVUWRGcVAwU2trR1VHdk9pSkJpQ1Q1?=
 =?utf-8?B?S1dOWnV0TXZkQXFqdklFemNJME04ajFESHREeHdWNzQxY1hkQlRQbTVUZllx?=
 =?utf-8?B?VzZWRDFRc1JFUlJMZ2QrM3RNTFdKRkZqNytrb0l0eG9pYXcyaFdKRDhYYUpt?=
 =?utf-8?B?MmJyOXNaaktTNUFwVXJnOGRqOSt6Ym8vN044eHc0bmZ0S1Z1U0JldXBsOEZZ?=
 =?utf-8?B?SUNhb2FETVFiUnRnTFQzNmorYWptZm9oakpZV0p5REdUWGVBU242MFlDN3o1?=
 =?utf-8?B?aG9HYnlXRTMybjlhTzNxcksyVS9nUGpMc1pGTzlHZEJMeHQ2eWpuYWtXQUNw?=
 =?utf-8?B?RW1KNkRTOTZZQTk5d1pzN05CTWdYb1Fmek5IdERCc3NFSlRrMk5Rb3FkMGRL?=
 =?utf-8?B?ZGg2d2FlTmE4Q2VmSnowSnJhSFFpTlJha0ZVcUdjZkp2cmFQclBqRlhTYTlH?=
 =?utf-8?B?YnMyMWU2ZUMwa25nQmVTbkJDUUNiTmNhN0h5aVdMN0R6cHRRNDBNaGU1QWhi?=
 =?utf-8?B?YVVZVFgyZjZVcVdWZ2YvV0Jjd3JuMU1CSjZFSGZMTmtaeXE3TFVhQjd4MUY1?=
 =?utf-8?B?NnFQQUdvQ25hKytUb0NOQlJRUGZsc21odFMwcHdqSWlIaW9VaWlRclplT0F6?=
 =?utf-8?B?R3ZxMWFqaEVhRkJ1SDd4NktwTjRtdlFmV1FCQ0NjOHh4V29Xc1Q5MFJkMWVv?=
 =?utf-8?B?UXNqZEcxWHJZK1R5YUM4OVd3WnorMlptVHpGMDVFSHo2ajJMWlVCYU9pRGht?=
 =?utf-8?B?K3BqVDF5U0tETVNZUUx1VDMvWW5aUGlZY2swOTZEa2RCbFdmeDE0UUJOdC9W?=
 =?utf-8?B?aFRmTlhrZW1pQ1Z6bGxIa0czTk8va3RzZUdaLzkwV21XdUxCcUFGRHp4djFq?=
 =?utf-8?Q?1SRQjpmIBF4mQTimXQhwvX7Zg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78226cd3-b70e-4e0d-09da-08dabc78a352
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5933.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 02:19:14.9912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m44L5a3UJBCYYqx1DydEE//pEkW79kv8qVHgR7YEJHg8drjzWRv9rPf+ttxYN15V+F219pIHJ22pcHedhktToA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4181
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/1/2022 3:15 PM, Felix Kuehling wrote:
> Checkpoint BOs last. That way we don't need to close dmabuf FDs if
> something else fails later. This avoids problematic access to user mode
> memory in the error handling code path.
>
> criu_checkpoint_bos has its own error handling and cleanup that does not
> depend on access to user memory.


This seems to be breaking the restore operation. I did a quick pytorch 
based test and I can confirm that restore operation fails with this 
change applied.

[  +0.000003] CR2: 000055b6726e0020 CR3: 00000001283fe000 CR4: 
00000000003 50ee0
[  +0.000002] Call Trace:
[  +0.000002]  <TASK>
[  +0.000003]  kfd_ioctl_criu+0xd4c/0x1930 [amdgpu]
[  +0.000185]  ? __might_fault+0x32/0x80
[  +0.000004]  ? lock_release+0x1fd/0x2b0
[  +0.000010]  kfd_ioctl+0x29b/0x600 [amdgpu]
[  +0.000153]  ? kfd_ioctl_get_tile_config+0x130/0x130 [amdgpu]
[  +0.000158]  __x64_sys_ioctl+0x8b/0xd0
[  +0.000003]  ? lockdep_hardirqs_on+0x79/0x100
[  +0.000007]  do_syscall_64+0x34/0x80
[  +0.000004]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  +0.000005] RIP: 0033:0x7f1c87e7f317
[  +0.000002] Code: b3 66 90 48 8b 05 71 4b 2d 00 64 c7 00 26 00 00 00 
48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 
05 <4 8> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 41 4b 2d 00 f7 d8 64 89 01 48
[  +0.000003] RSP: 002b:00007fff630af518 EFLAGS: 00000202 ORIG_RAX: 
000000 0000000010
[  +0.000003] RAX: ffffffffffffffda RBX: 00007f1c89351620 RCX: 
00007f1c87e 7f317
[  +0.000002] RDX: 00007fff630af5c0 RSI: 00000000c0384b22 RDI: 
00000000000 00005
[  +0.000002] RBP: 00007fff630af550 R08: 0000000000000000 R09: 
00007f1c87e d7c10
[  +0.000002] R10: 705f757067646d61 R11: 0000000000000202 R12: 
000055a4a05 14c60
[  +0.000002] R13: 000055a49eb81540 R14: 000055a49e90eea9 R15: 
00007fff630 b069c
[  +0.000010]  </TASK>
[  +0.000002] irq event stamp: 50181
[  +0.000002] hardirqs last  enabled at (50187): [<ffffffffb61072a2>] 
__up _console_sem+0x52/0x60
[  +0.000003] hardirqs last disabled at (50192): [<ffffffffb6107287>] 
__up _console_sem+0x37/0x60
[  +0.000003] softirqs last  enabled at (45940): [<ffffffffb6bd4103>] 
sock _setsockopt+0x223/0xfa0
[  +0.000003] softirqs last disabled at (45938): [<ffffffffb6bd3609>] 
rele ase_sock+0x19/0xa0
[  +0.000004] ---[ end trace 0000000000000000 ]---
[  +0.000002] amdgpu: Could not allocate idr
[  +0.000245] amdgpu: Failed to restore CRIU ret:-12
[Nov 1 22:11] loop0: detected capacity change from 0 to 8

https://github.com/checkpoint-restore/criu/blob/criu-dev/plugins/amdgpu/amdgpu_plugin.c 
:


(00.093977)     11: Added GPU mapping [0xC093 -> 0xC093]
(00.093982)     11: ===Maps===============
(00.093987)     11: GPU: 0xC093 -> 0xC093
(00.093992)     11: CPU: 00 -> 00
(00.093997)     11: ======================
(00.094002)     11: Matched destination node 0xC093
(00.094007)     11: All nodes mapped successfully
(00.094012)     11: Matched nodes 0xC093 and after
(00.094017)     11: Maps after all nodes matched
(00.094022)     11: ===Maps===============
(00.094027)     11: GPU: 0xC093 -> 0xC093
(00.094032)     11: CPU: 00 -> 00
(00.094037)     11: ======================
(00.094041)     11: amdgpu_plugin: Restoring 1 devices
(00.094319)     11: amdgpu_plugin: amdgpu_plugin: passing drm render fd 
= 10 to driver
(00.094326)     11: amdgpu_plugin: Restore devices Ok (ret:0)
(00.094331)     11: amdgpu_plugin: Restoring 184 BOs
(00.094349)     11: amdgpu_plugin: Restore BOs Ok
(00.095791)     11: Error (amdgpu_plugin.c:1830): amdgpu_plugin: Restore 
ioctl failed: Cannot allocate memory
(00.095916)     11: Error (amdgpu_plugin.c:1850): amdgpu_plugin: 
amdgpu_plugin: Failed to restore (ret:-1)
(00.095951)     11: Error (criu/files-ext.c:53): Unable to restore 0x143
(00.095961)     11: Error (criu/files.c:1213): Unable to open fd=4 id=0x143
(00.096078) Unlink remap /dev/shm/fvKoKz.cr.1.ghost
(00.096152) Error (criu/cr-restore.c:2531): Restoring FAILED.
(00.096181) amdgpu_plugin: amdgpu_plugin: finished  amdgpu_plugin 
(AMDGPU/KFD)
"restore.log" 4194L, 201090C

>
> Fixes: be072b06c739 ("drm/amdkfd: CRIU export BOs as prime dmabuf objects")
> Reported-by: Jann Horn <jannh@google.com>
> CC: Rajneesh Bhardwaj <Rajneesh.Bhardwaj@amd.com>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 27 +++++++-----------------
>   1 file changed, 8 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 5feaba6a77de..aabab9010812 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1994,38 +1994,27 @@ static int criu_checkpoint(struct file *filep,
>   	if (ret)
>   		goto exit_unlock;
>   
> -	ret = criu_checkpoint_bos(p, num_bos, (uint8_t __user *)args->bos,
> -			    (uint8_t __user *)args->priv_data, &priv_offset);
> -	if (ret)
> -		goto exit_unlock;
> -
>   	if (num_objects) {
>   		ret = kfd_criu_checkpoint_queues(p, (uint8_t __user *)args->priv_data,
>   						 &priv_offset);
>   		if (ret)
> -			goto close_bo_fds;
> +			goto exit_unlock;
>   
>   		ret = kfd_criu_checkpoint_events(p, (uint8_t __user *)args->priv_data,
>   						 &priv_offset);
>   		if (ret)
> -			goto close_bo_fds;
> +			goto exit_unlock;
>   
>   		ret = kfd_criu_checkpoint_svm(p, (uint8_t __user *)args->priv_data, &priv_offset);
>   		if (ret)
> -			goto close_bo_fds;
> +			goto exit_unlock;
>   	}
>   
> -close_bo_fds:
> -	if (ret) {
> -		/* If IOCTL returns err, user assumes all FDs opened in criu_dump_bos are closed */
> -		uint32_t i;
> -		struct kfd_criu_bo_bucket *bo_buckets = (struct kfd_criu_bo_bucket *) args->bos;
> -
> -		for (i = 0; i < num_bos; i++) {
> -			if (bo_buckets[i].alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM)
> -				close_fd(bo_buckets[i].dmabuf_fd);
> -		}
> -	}
> +	/* This must be the last thing in this function that can fail.
> +	 * Otherwise we leak dmabuf file descriptors.
> +	 */
> +	ret = criu_checkpoint_bos(p, num_bos, (uint8_t __user *)args->bos,
> +			   (uint8_t __user *)args->priv_data, &priv_offset);
>   
>   exit_unlock:
>   	mutex_unlock(&p->mutex);
