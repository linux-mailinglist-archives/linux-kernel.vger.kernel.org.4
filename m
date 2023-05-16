Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFC9704AFE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjEPKoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbjEPKok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:44:40 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA572D5F
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:44:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5I4pKGcj3ns/VC6cCkO/7kmZIG/B3Pr4rQtLJW06OX9j5cILU3UWzB5KeLsG5OLbif/6B09z78neltWFxMfchZ6SUT2xjFeFl/fuiHX7TfWll0zcny9K8uab5NdS17cODkXvarUOAJ6+Qx99EWixKCk8Vnq3TqwmmhaFDcGjQqk68PRvc4vAcuCM/3CktDtnM/QpOLRcbETY7laEXiZiNzA4UC79gcwQTUkFENDkBUrIQ5JNBaFz3O0GtClvR8EU5pi8GhtW9VKeyg665kicMPsPb79ZMiFrZBMs3GwC1N2FEGr4ODZACjvyd+priOe2c6KmvrYc52zm80u7DTKqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94bWn0Bo8G03fqIXzrR5CUVXG0TLSseebwK6liSw8S0=;
 b=SEw3oDCH6Du+2jIb3Bm7kMfgq1RLYTbdWGVVt0t6XQ4uRIh940Qe+RDPLf+19zKgojtDjfYXzqffwjFj0XgUNmSsltxmDVAsAT+Z4g+upqZnO3R0aJBTA8IWSIn5CTSMcgCzPe+rgjzx3PeZVpl3EdMyOp7OQmMh4DaWM5PH3WIefM8enTSAWywJKQdTC9nsm5AXgU+uiIQWZlVAAbhWz39jr/hw0mpu0hn9t0UzDnQk0f53AifL/mmbCo7RugQyeoTlO7Dnxb80H0sFRZKLrYzU9wf5ttXml4R0fE3y9sVngc/MZQ9cviGskGVgSoM+vkSIqM8z9ZBMCivk2lVHUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94bWn0Bo8G03fqIXzrR5CUVXG0TLSseebwK6liSw8S0=;
 b=grJl8F9vq2xcwQmMLiWql9TpJ/B/8xdvQJXYtQxd9eLqQDGQi0opyu88xy7l7sZ0BjQcUUVv8lM410OEFB6Ovi4WqABqrsJsjcIxc7clh2+gW5m5KthNepXEQ4JdwsCwRMAcP7WwhNesAKak2/qUwPNm+fUIqzUJMKoLwWptj62Hd7atZBb/PRY42m7BATRcLnPRLSZWQb4Dy4e9+X1M/wD4Rgs2caNLxwUS4c6vKv8GjzSR6Kwp87TMCNP2gS0KkmJL8qhCIm+be5hXhQCMLH33W6fZFAttJ2p8ErnYs8ciJp/hu49HR4z99KwK5qpsduRAGz1Cqt0nlVzp+CnmSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6018.namprd12.prod.outlook.com (2603:10b6:208:3d6::6)
 by PH8PR12MB7303.namprd12.prod.outlook.com (2603:10b6:510:220::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 10:44:26 +0000
Received: from IA1PR12MB6018.namprd12.prod.outlook.com
 ([fe80::df02:1c55:a9c3:5750]) by IA1PR12MB6018.namprd12.prod.outlook.com
 ([fe80::df02:1c55:a9c3:5750%3]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 10:44:26 +0000
Message-ID: <6aebdc1e-e8cd-7dbd-48f3-97ba432c471d@nvidia.com>
Date:   Tue, 16 May 2023 13:44:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] vdpa/mlx5: Fix hang when cvq commands are triggered
 during device unregister
Content-Language: en-US
To:     Dragos Tatulea <dtatulea@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eli Cohen <elic@nvidia.com>
Cc:     gal@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20230516095800.3549932-1-dtatulea@nvidia.com>
From:   Tariq Toukan <tariqt@nvidia.com>
In-Reply-To: <20230516095800.3549932-1-dtatulea@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0053.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34a::17) To IA1PR12MB6018.namprd12.prod.outlook.com
 (2603:10b6:208:3d6::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6018:EE_|PH8PR12MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b34ff9-c840-430b-b03c-08db55fa84be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7NXdY+pH1vki8yOu78rgYWDrW4lUlCbb69c78R22lez4ysvHXcGIDlwa/9u7Gbc/nsRTyveqvDRSwT1JfZnLh8n1UhicslYnO/fcD9807Z7vqpm87mniG8j8DQResAStIvEaXSHSrOrHRdo8t8z5SBFIwP29rtaUDL7jfyH+dmT0X92IkatfFK0tvDZG4COdQtt4eBukBPZolZk3SOn/r2eAVubawUt1qjZqP9Et9fyxkjzAoxHzktE0+rGrYMy7MmXXIoctnxdE0p2vyjpJGmpfMY2pLodVEYeS0J0ncyQ9m4PT/qhVeE7v0+Oevek4olsFx066UpzdBn4k/2wd8RgEcw1IFjo3CerIoyi/vFGUPXIyiQNfEThDGYz8At5c50mvsWZLZzd+SjEnjI0y8P43tM2FbbRDqV9JDF83aT2AHY3/xuRu8RgSBVT31B+5IlAjdvv7oP4ZHfj+Tp4XScJ44V/8IAw8rHVic8qJ/qK7G5t0m94On783VCTwIt1M2fodtO2AaaFB9tHPuPAvmYYrhOqCPZ8XwQSDbNmbcMfCtK/r0uVX5P1Yccq70RKPK4g/MAnvRDaY9ACxAbnZMTtd3FETf3/GQbUOWHBftUSzncVbkDWpYH1+KrnDRLIcaDrt+XCn5EIgAYa9vdm/OQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6018.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(376002)(39860400002)(451199021)(36756003)(110136005)(316002)(478600001)(66476007)(66946007)(6636002)(66556008)(4326008)(6486002)(86362001)(2616005)(5660300002)(8676002)(8936002)(6666004)(2906002)(31696002)(41300700001)(38100700002)(6512007)(26005)(186003)(53546011)(6506007)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MURyWmpzR0dnbk1EZmhjVUlsS3ZWRDhwWTh0Yjc4U1FDaTFKcVlJVWs1Z0pv?=
 =?utf-8?B?NXh0aGNsTE5MMzV0QUY3UGR0b0pCeUI3dElPY1hJL3h0TkFBUU9xa1NmWVZr?=
 =?utf-8?B?Nk5XQ1FYcjhEdFlqdlVUVDFhdHZCUVhlSWROVHk4YTdldVFpRXZyVmxnUjY3?=
 =?utf-8?B?c3QxSURDOHQxc2ZZUHNPd3pqMWJSR0ltb2ZIQjB5andZb3lEcjRUc1hVT1No?=
 =?utf-8?B?anlqdnZCTU8zQ2ZHRlpKaTQ5U0dmNWYvNStkOTRJK2Vqamc4S0oyb2xvWjlM?=
 =?utf-8?B?NGU1Y3VPNXk2ZVZkN3FUS05wdEU0UzRWK2hYL2RNeVFrbzdFR1BBb0s4STY4?=
 =?utf-8?B?TVlpOG9MWVJzdmhTWDN1UDNqTVVKeWpDVEZRNktvOWpDZ0ovRXhNc2t2TVlM?=
 =?utf-8?B?dFhWYXVwT2taSWxEcnc3U05XelNJVktGZ0VaRXQwbjhVQ3pVK2hBNWtOUGZI?=
 =?utf-8?B?a0IvSEc0NVNUaFgxRTZHUE1UQXBlOS9XTGlLY2QveVVrWGZuTnNTVUhKdkxS?=
 =?utf-8?B?cDlxUXMwVHd1YnpkbHpOSzhSVGRsaEhNSVROR3BoSGpvNlRBM1lHV2hRMGNh?=
 =?utf-8?B?MWpGT05idk1LUEFQR0EzeHkxVUlvTVNDUVlwcWpMalBJK3dZMXhnSTMzNVJr?=
 =?utf-8?B?OEhBamIyOGlyaDlsd1h2RUw3Y1AwMFBqTlFpTXZRZzVSRlZsZG9JSnBUQ3dX?=
 =?utf-8?B?VjdqZ2p4cFlUQzhWWlRRS1lvdWlPQ0FrMUovMElVbmNCNFA4b1hWV1NjcGp1?=
 =?utf-8?B?VStiMXBDNy9SV05ZdktqanJ6T2xoWFo2cXdyZ2NUQUxMWE9iYVM5S3JRL3B4?=
 =?utf-8?B?K0MwYzJCRTQycGo5VzNKYXk4QldLTXZFNFFXVVZqTURjSUtDV0Y3RC9HNGtC?=
 =?utf-8?B?dTR6OSs2TVRxV3NyYWl6TTllYlo2REdaeGt0ek5tUEN4SkFFeXI5V2dzc1Fn?=
 =?utf-8?B?THlVZ3RJTklMeXBac1p6QlBrMVcrT3lISW14VlRBY2R4NThCMFRnS0xnTDVv?=
 =?utf-8?B?R2FFdURMZmh6b1VZdHAzeVpjVTBEUWJkQ2lKemwraVNPcmNINXJnT2I1MDJC?=
 =?utf-8?B?MnRoWkFzNlhndGtKTG84RjBlM3ZBKzNRandSczZWVU5LS2YrMm9mVVlUaHVj?=
 =?utf-8?B?V3F5amx2NTNPWllYL2tnSUE2clZIeVNLV0VLcVlxL1R5R2Jtd0hHRmNjdCtX?=
 =?utf-8?B?ZkR3WkcyMmVpZHVKYTB0QjYzWW9RMkNZVlArMlM3bVprWVR4Z1lkeWVWTTI1?=
 =?utf-8?B?bXVVc2hpR1ZFN01FWnFmNHA3d2hieFp3U0daSmpTeWNtdzlJbnEydWdaS1BR?=
 =?utf-8?B?bW1BaWtzUUJGSklzeHJVa3FDUnJtV0x6akhzdHlxZkZpWS9OR1pscU5VVGoy?=
 =?utf-8?B?L3ZmVTh6QzJpZFkzcGQvbTBQTjJwSFhvaTJrVUNXblJjZlpiYjhONmg3TnNQ?=
 =?utf-8?B?Qy92dHMxMjd4U3VHaGprRUY1bGcyaFl4Si9BZ0k1TWV2SWZnbTFsSzVEUkE3?=
 =?utf-8?B?SHRiNjBaMGhqN2RFYlhHRFNKeTdmLzJpeldBK2xneUVDTnllaGpEZVFuMCtW?=
 =?utf-8?B?a3NUSUVXcFBGR3p4MlZnVHJ0MkJhZCt3cVdpQ0lteTdmWXNJV0xpQ1V2Y2Qx?=
 =?utf-8?B?VWtPZ2c4ekdpb2VGZTBCa3hkQmZRN1ViUlIveFNjZEhEeVMyNWVyUTJYMkkw?=
 =?utf-8?B?d0YrQjFZTVhhVnZFUHdueHJzTHlRaDBwUGRLNWs2QlZQKzgvcnNlcHJ1ZE1K?=
 =?utf-8?B?dHVRR2FmQzQyaGhRZ0RuUzRqcFkzNXZUaVlKNGZScFVtRm1RelZhTnd0S2Rx?=
 =?utf-8?B?a1NMSEN3a3RNSVJ4R3Bja3F1YjJJdlp0R0VLcExmRVNHN1A5SHZnd2tMQUZn?=
 =?utf-8?B?T1NPVlNiY25xT2dvN21mUk54MktXWXRKWjRlcWxlTFhiY1dtcFNqOU5DNzgr?=
 =?utf-8?B?Kzk5ZDFJNnUwaTZXczZURnpURGdEVXhPZkZGcmkwVllScXRrTmZUN1p2Q2xo?=
 =?utf-8?B?V0U3aUI3cXhDYVJXS0xXWW5TYWF4TGJiUEdLb1FZSkFETEFrbTE5WnJZWlNr?=
 =?utf-8?B?YlZZNkdJa0NvdXFMdUV3LzFMTG1vZTk3NTFlZ2lLSzRZUE9lelBLL2QvMjlW?=
 =?utf-8?Q?RcQ5f1IzjDV3HZh7er8BDUaph?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b34ff9-c840-430b-b03c-08db55fa84be
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6018.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 10:44:26.2821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: opCbY8p8+M8kMWM41EFvd9NnBqVrb1giuPrBQeanziPdOI66PjiN5XF7eKAGFM33hdNNTAVMervOcvzA3kCjww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7303
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/05/2023 12:58, Dragos Tatulea wrote:
> Currently the vdpa device is unregistered after the workqueue that
> processes vq commands is disabled. However, the device unregister
> process can still send commands to the cvq (a vlan delete for example)
> which leads to a hang because the handing workqueue has been disabled
> and the command never finishes:
> 
>   [ 2263.095764] rcu: INFO: rcu_sched self-detected stall on CPU
>   [ 2263.096307] rcu:        9-....: (5250 ticks this GP) idle=dac4/1/0x4000000000000000 softirq=111009/111009 fqs=2544
>   [ 2263.097154] rcu:        (t=5251 jiffies g=393549 q=347 ncpus=10)
>   [ 2263.097648] CPU: 9 PID: 94300 Comm: kworker/u20:2 Not tainted 6.3.0-rc6_for_upstream_min_debug_2023_04_14_00_02 #1
>   [ 2263.098535] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>   [ 2263.099481] Workqueue: mlx5_events mlx5_vhca_state_work_handler [mlx5_core]
>   [ 2263.100143] RIP: 0010:virtnet_send_command+0x109/0x170
>   [ 2263.100621] Code: 1d df f5 ff 85 c0 78 5c 48 8b 7b 08 e8 d0 c5 f5 ff 84 c0 75 11 eb 22 48 8b 7b 08 e8 01 b7 f5 ff 84 c0 75 15 f3 90 48 8b 7b 08 <48> 8d 74 24 04 e8 8d c5 f5 ff 48 85 c0 74 de 48 8b 83 f8 00 00 00
>   [ 2263.102148] RSP: 0018:ffff888139cf36e8 EFLAGS: 00000246
>   [ 2263.102624] RAX: 0000000000000000 RBX: ffff888166bea940 RCX: 0000000000000001
>   [ 2263.103244] RDX: 0000000000000000 RSI: ffff888139cf36ec RDI: ffff888146763800
>   [ 2263.103864] RBP: ffff888139cf3710 R08: ffff88810d201000 R09: 0000000000000000
>   [ 2263.104473] R10: 0000000000000002 R11: 0000000000000003 R12: 0000000000000002
>   [ 2263.105082] R13: 0000000000000002 R14: ffff888114528400 R15: ffff888166bea000
>   [ 2263.105689] FS:  0000000000000000(0000) GS:ffff88852cc80000(0000) knlGS:0000000000000000
>   [ 2263.106404] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [ 2263.106925] CR2: 00007f31f394b000 CR3: 000000010615b006 CR4: 0000000000370ea0
>   [ 2263.107542] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   [ 2263.108163] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   [ 2263.108769] Call Trace:
>   [ 2263.109059]  <TASK>
>   [ 2263.109320]  ? check_preempt_wakeup+0x11f/0x230
>   [ 2263.109750]  virtnet_vlan_rx_kill_vid+0x5a/0xa0
>   [ 2263.110180]  vlan_vid_del+0x9c/0x170
>   [ 2263.110546]  vlan_device_event+0x351/0x760 [8021q]
>   [ 2263.111004]  raw_notifier_call_chain+0x41/0x60
>   [ 2263.111426]  dev_close_many+0xcb/0x120
>   [ 2263.111808]  unregister_netdevice_many_notify+0x130/0x770
>   [ 2263.112297]  ? wq_worker_running+0xa/0x30
>   [ 2263.112688]  unregister_netdevice_queue+0x89/0xc0
>   [ 2263.113128]  unregister_netdev+0x18/0x20
>   [ 2263.113512]  virtnet_remove+0x4f/0x230
>   [ 2263.113885]  virtio_dev_remove+0x31/0x70
>   [ 2263.114273]  device_release_driver_internal+0x18f/0x1f0
>   [ 2263.114746]  bus_remove_device+0xc6/0x130
>   [ 2263.115146]  device_del+0x173/0x3c0
>   [ 2263.115502]  ? kernfs_find_ns+0x35/0xd0
>   [ 2263.115895]  device_unregister+0x1a/0x60
>   [ 2263.116279]  unregister_virtio_device+0x11/0x20
>   [ 2263.116706]  device_release_driver_internal+0x18f/0x1f0
>   [ 2263.117182]  bus_remove_device+0xc6/0x130
>   [ 2263.117576]  device_del+0x173/0x3c0
>   [ 2263.117929]  ? vdpa_dev_remove+0x20/0x20 [vdpa]
>   [ 2263.118364]  device_unregister+0x1a/0x60
>   [ 2263.118752]  mlx5_vdpa_dev_del+0x4c/0x80 [mlx5_vdpa]
>   [ 2263.119232]  vdpa_match_remove+0x21/0x30 [vdpa]
>   [ 2263.119663]  bus_for_each_dev+0x71/0xc0
>   [ 2263.120054]  vdpa_mgmtdev_unregister+0x57/0x70 [vdpa]
>   [ 2263.120520]  mlx5v_remove+0x12/0x20 [mlx5_vdpa]
>   [ 2263.120953]  auxiliary_bus_remove+0x18/0x30
>   [ 2263.121356]  device_release_driver_internal+0x18f/0x1f0
>   [ 2263.121830]  bus_remove_device+0xc6/0x130
>   [ 2263.122223]  device_del+0x173/0x3c0
>   [ 2263.122581]  ? devl_param_driverinit_value_get+0x29/0x90
>   [ 2263.123070]  mlx5_rescan_drivers_locked+0xc4/0x2d0 [mlx5_core]
>   [ 2263.123633]  mlx5_unregister_device+0x54/0x80 [mlx5_core]
>   [ 2263.124169]  mlx5_uninit_one+0x54/0x150 [mlx5_core]
>   [ 2263.124656]  mlx5_sf_dev_remove+0x45/0x90 [mlx5_core]
>   [ 2263.125153]  auxiliary_bus_remove+0x18/0x30
>   [ 2263.125560]  device_release_driver_internal+0x18f/0x1f0
>   [ 2263.126052]  bus_remove_device+0xc6/0x130
>   [ 2263.126451]  device_del+0x173/0x3c0
>   [ 2263.126815]  mlx5_sf_dev_remove+0x39/0xf0 [mlx5_core]
>   [ 2263.127318]  mlx5_sf_dev_state_change_handler+0x178/0x270 [mlx5_core]
>   [ 2263.127920]  blocking_notifier_call_chain+0x5a/0x80
>   [ 2263.128379]  mlx5_vhca_state_work_handler+0x151/0x200 [mlx5_core]
>   [ 2263.128951]  process_one_work+0x1bb/0x3c0
>   [ 2263.129355]  ? process_one_work+0x3c0/0x3c0
>   [ 2263.129766]  worker_thread+0x4d/0x3c0
>   [ 2263.130140]  ? process_one_work+0x3c0/0x3c0
>   [ 2263.130548]  kthread+0xb9/0xe0
>   [ 2263.130895]  ? kthread_complete_and_exit+0x20/0x20
>   [ 2263.131349]  ret_from_fork+0x1f/0x30
>   [ 2263.131717]  </TASK>
> 
> The fix is to disable and destroy the workqueue after the device
> unregister. It is expected that vhost will not trigger kicks after
> the unregister. But even if it would, the wq is disabled already by
> setting the pointer to NULL (done so in the referenced commit).
> 
> Fixes: ad6dc1daaf29 ("vdpa/mlx5: Avoid processing works if workqueue was destroyed")
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

