Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DBA6C2B32
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjCUHQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjCUHQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:16:40 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433ED3CE32;
        Tue, 21 Mar 2023 00:16:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxNY/nz69r1lnzMTyyO1S4iVd0IHpDozlwitfnFL28aW52d6f0Of8xl4gqPoFgTMQvhqeooCoCOkMiNPenT4ykXmD7XrcwudjU/sTgOIess7Ld3qbyFUytjtuH12bgBS//jokSHnWHrNUr0B9zgWXet4x6nIProOqeudPXpAOEa4fyHEEowDFOWXJXEYsTWltEOOtbOBJXoyOOeRBUeFzaq8su7aZTUJH3JEVjlQtpA69aiObJwy7AGzAn323q9eOxUWRTBwE4CJ9KQDwL72bHLO1NWxNxlOkmS/M6j0Li2rXbkWC3PZZZCZEEth3TEAWuNdC+sg5L6twTkHT+ucHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kuW6urpxM3dEp8AiK7/l7TVhB2GuYeZ79VcQ7ESNUs=;
 b=bgb3is8HWbE5eTcNBWvNoV9bpH/MBI16oVjfRDnCUtGehQ1sriMJu/47mrcJ9O3+6IKr2cR2ZC0P5YFERQp5ZRy4PbCCrzdfw+NO0NwW0DowcjAcOgc5VjJI0hOuKDomtZ2+vUJwDto1d2SzYH0+phCj8DL47R65v0CU8A6wH3YADFuX9UsVF7I4NVK/5oVkXvrBNOXPjGcy2CrDYZAXJAgvViFhPZM7jk1EygJyf/mg2XT5MiXCh7+v85N/u9EeX/zAvy85DgXd9lfVZ9KX7iJp+mJhHS0Q9ktszJS4HG+6fqaZXuNrB2FGFKD9ohFW8zvdWcnzr9V4kROjhnwq0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kuW6urpxM3dEp8AiK7/l7TVhB2GuYeZ79VcQ7ESNUs=;
 b=tYI2dMOvij5eqAaFzIO5IKeabYX9R0rNvDk6oMxRXQjo7iWpT2e5iYaKmMeagQrggVtL6wi4zU+sDenwa4NobrnltsHLl08oe8J1Ccr+HLjbo7OJRtdbwazKb5gMg2ProBM5ZV6pY3dgC4roUa9jdoYVSkqSoJn/kAot0gb8ptGYVBVMpIkE/5TImkKwiqACE+WLNugxndCagwSL4EO05bC9Q12VM4pTQk3/k6VsXsJM/EE+2FGCYPHCjrr3IS7ckOIA3L6UQMTq8IUcNo492YbjvbAuwCXh2w6MQ9Kqtn3m6Wm175a2pDgoU82T6K020fglL1r+DAktcjTx+3S6DQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CH0PR12MB5105.namprd12.prod.outlook.com (2603:10b6:610:bc::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Tue, 21 Mar 2023 07:16:02 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07%9]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 07:16:02 +0000
Message-ID: <1a7bd64b-7d4e-61fc-797c-816a2fe8d83e@nvidia.com>
Date:   Tue, 21 Mar 2023 07:15:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] usb: xhci: tegra: fix sleep in atomic call
To:     Haotien Hsu <haotienh@nvidia.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     JC Kuo <jckuo@nvidia.com>, Wayne Chang <waynec@nvidia.com>
References: <20230321071339.925636-1-haotienh@nvidia.com>
Content-Language: en-US
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20230321071339.925636-1-haotienh@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0273.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::10) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CH0PR12MB5105:EE_
X-MS-Office365-Filtering-Correlation-Id: d8c7c2df-5e31-4122-3d85-08db29dc20f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4AqReWccaWPBLIZoh26/ozV7Ez6PXEqLADs5A0rDvgjV+IQTbOf/DL3HJxf4ZXz0Q/8k6bvw0jT78y3Cq08/VB5g9uGULJVbVmdxASvpNJ5Xrowe7m5+rjOrhEZc9fwjax6oG+uf6FaLCO8Wsw83zA4QbG7Jh0tIIR1li4NvkYJGZxwAJNofkr0Fy6zJctuwyanmgw4bHjS7aijj5FL47/fTGgXIertqBksumsqVCKu6Wog558XPLK8zXwrk6vWaBI8+f9Rn3A+dkJv+FFIvsqj1154j7gQpL3lv5dA3YAu3m0AzmfgwN6iS+OjKwAktGoonz0944QTjg+H4Pm16Zylg6M5DxhZqnRO7mR40Nu33QltHf6gYrkCfvSKoPXutSA9+8jgaEisYz0S3EPSNebVeVp0OOgMuBkJv+301SLmqdqk+W/CDhrzDycJkDJvLfdxd0GuFpVNS3Pf27o1N6AuONfhd3QNTblPMHxVChGFdbV1RnQGZOrj4qvSjUMJBfNUYM+AQMdpsXGPypT3Pm1/xaiCZMNpWq7jM9EgFAfDqR9YrYaUm/qNzL1gAVqYqUCtd5fxjEoZ9aGG5xhElJc+cWiJdqGrMyIGl9BPmMhF2CCV48wRyI9vPp9AGCnDJ9nXJAa9vjH3On+0Hu8LPqbGOA5SXD2pK2hlrVes1biu9xeRO8HhwSaFHw9VoDcz7jBoDDTxWtTdZNOiyjaR7LyeeT3K1Xb5Zuce56Kudfwo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199018)(31686004)(6666004)(2616005)(107886003)(6486002)(6506007)(186003)(53546011)(110136005)(6512007)(38100700002)(86362001)(31696002)(83380400001)(2906002)(478600001)(316002)(54906003)(8676002)(66946007)(4326008)(8936002)(41300700001)(66476007)(66556008)(36756003)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0R0L05heFFHK1dZN20xZnN6dzIzV2tndGlrby9RMitYUVptWGgzdFozaGxm?=
 =?utf-8?B?RCtTSnNxSUtDTGtxL2NWK01pOFNSZXcxL1lJeWZjdXo2ZEtGTUFnckpyUzVx?=
 =?utf-8?B?LzdyYUI3UTNpclB2WGt4c1hhcjVlTUZlblFLTlRoN0FIRWVjSUJ3L1JQdzNo?=
 =?utf-8?B?cWljOENITElvbGVXWGpzTzhxSGs4NGNpRW81RUdFOWxESVNWc21yelV1YXl3?=
 =?utf-8?B?SVMrbDJxbEdqTmtxZzB1aTNZU0FhQS9mUHpHMjlnSEZrNXF6V0ppTGg1N3hr?=
 =?utf-8?B?QnFCaVRtWTVObjZDTWJENGdaQmMrMTJyMXN3R214ejhzTzd1d2psSE9NRUh5?=
 =?utf-8?B?ekJsTWxWQk5WWXMwNWJyVjJCSk5kWEhvRTVPRnNUOUNWbENJdHRFcDl6dnFR?=
 =?utf-8?B?cDZQRC9qV09IS014VHY1Qng5am9zVU56b3FoTml0YUhEbkx0ZVdPQjBRa3dO?=
 =?utf-8?B?NHphbDYxVFd3TDB3eWFnaDVSeE5Ob0JtMWtnMCtHRXM5QTBBckZXRDNwakcy?=
 =?utf-8?B?NUgrSU1CQXR4QkJjaXhSekFTRXJVbTFmL05ENHloYkIwRStjVzVjWloybXlD?=
 =?utf-8?B?bFhkUkgxUDFqT0taRjM0LzhhQm1QanpqN2ZocytzdDlXZzJGQndNWlA4aHRx?=
 =?utf-8?B?YUE1Z0JCVmdwQlNkUEdhZWlWSm9PR1ZMQ2kxN3E3cDBWNkFMUXk1UmdQQUFu?=
 =?utf-8?B?b1R6RTJON3JkZnJyVGxXMHdkL1NnM20rWEhvTkZYUS9GQzJHbFQraGtWYzVa?=
 =?utf-8?B?dWZaY09vamtPSC9Ec0NCcTY4VDc2Nk1ycVA4d2E1ZkVKaUNRbjdvOHB3S3N5?=
 =?utf-8?B?bDRKRU40cU5sa2VDVEpyV3REN2dRRy9ZblRKTHZVZHp3cGUyY3g4OHFJd3hP?=
 =?utf-8?B?UzJvcFNRSy90U2Zudkk0S29HenVKZjRQNGVRYkRWd0xiOFV1V2FPYUpXYWF5?=
 =?utf-8?B?TjNFTG9SS08wcTUySnkzQnVPUFV5RE13bGY2d1c2ZmlCc2duQkg4N2RDRFFv?=
 =?utf-8?B?S2xYcEtNNWZIR0Z1c1cyclgwcDBadTlPblBDQjZ1NCs5UTltN0xTU1VwOW8z?=
 =?utf-8?B?cldlTW5hMUxNa2RQandQMm9ZMXhOQlVXZDV3TWM3YXkrcFY5M2ZBOXorc2c4?=
 =?utf-8?B?NW0zU3pPcWRxNzA0bHQ4dndJYUdRM0dEOU51R0FReXNlMFZYKzZBR0lJeklZ?=
 =?utf-8?B?eDZtL29yd2VjRDVjenkwdWR6OVc0RmRIeStWa3E4ci9VVWNWOTFBRy9KQml0?=
 =?utf-8?B?UjR2N1VtZWxnU0dDQnY5aE1xQ1pCNlRsb2NIMXpXVjdLZmw2Tzk1c2Q0WnJm?=
 =?utf-8?B?dTVPZ01vU0tMcE40ZGlqelczcUVNQ0VlV2dmNTV0UU5LZGNTa0wzYjdNcFJj?=
 =?utf-8?B?YVpiZDlyUmh1RHpxOWpEOWtkSnlvNGZIQ1prWm5ZRkNSNWF6Y3BVbmJhcDFF?=
 =?utf-8?B?RjFSbUxTNkNkK1NqNDdxcDRndFE3U1M5aHF3VG56MG50REV2YTV3SDNOdFJj?=
 =?utf-8?B?RDAweTFtdmZ0ZUZVWDJlaTM4RkJMd2Z1akw3Lzd1aHo0MHRmOEhUMEl5eG9B?=
 =?utf-8?B?TlJzY1lqNkJiU0NsWXhiM3VKMzlVbCsxNHFtcUhRK3RISjlGQjJxVEY0OGFV?=
 =?utf-8?B?MlRqZzh1emhZWTE2NksyNFdwcUx6dnlvcmJGei94dlRYSU1UOSthOHlYZU9k?=
 =?utf-8?B?Z281TkZ4UFh6ZE5keGF5WThSWm1tUUc1TitFdkQzZ2JVNVU1L2pwNjlNcmVh?=
 =?utf-8?B?T3V4cWI3MmdNVnVjWHdFdUJSS05DeUMzQlRvQnpHZVE4cSt3VmVkS1NabXVU?=
 =?utf-8?B?NnVwRWpVVklmVE1LUGVDUUc4dU9DbXVySXVTbDArYllVNUpMQkorNVlLT3BZ?=
 =?utf-8?B?a2xRVklGK3hlOUM5MlVTdXkzN2ZxMlpka2orRXRUN0hpZEoxVG1QellWTm5l?=
 =?utf-8?B?Z3VZMDMwUkZDWTlOZ01LVERuSldEQ2V4WFc0Q1Njdy9LL1BXeVo5U3ZZN1VO?=
 =?utf-8?B?VkszeFpEVDk2K1RaWkowOEZab0EyZWM3bzY1eWFvTzloaGQwWkdBTUphaGVO?=
 =?utf-8?B?SEx2amhqQnUxUDhNSTdJK3RZODgyTlozUTZwV3Rwd1F3RmoySlpwcVAzemtx?=
 =?utf-8?B?TEtJVlpWTUpYNEI2OW1JQ0hIQXBsYnFCSGRvbmZ6VnBmUEZ3QjFNdEV6cFhu?=
 =?utf-8?B?RHFwU3BBRzEweVZIOGZTMkhxbDRXN20yVXN3Um1BZS9OQnpZRlJGR0M0bll4?=
 =?utf-8?B?cm5xL09xTjI2RVpsRjlLUWxFMElBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c7c2df-5e31-4122-3d85-08db29dc20f0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 07:16:02.7560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YVnuO7VfKoZX/fGLJrayK+teyDqS5+B8c1UDwM3fHUgNOPtwqcIXa6qYsdHCy2we8V/jezsZ0Bnn0nKaG4T5aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5105
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/03/2023 07:13, Haotien Hsu wrote:
> From: Wayne Chang <waynec@nvidia.com>
> 
> When we set the OTG port to Host mode, we observed the following splat:
> [  167.057718] BUG: sleeping function called from invalid context at
> include/linux/sched/mm.h:229
> [  167.057872] Workqueue: events tegra_xusb_usb_phy_work
> [  167.057954] Call trace:
> [  167.057962]  dump_backtrace+0x0/0x210
> [  167.057996]  show_stack+0x30/0x50
> [  167.058020]  dump_stack_lvl+0x64/0x84
> [  167.058065]  dump_stack+0x14/0x34
> [  167.058100]  __might_resched+0x144/0x180
> [  167.058140]  __might_sleep+0x64/0xd0
> [  167.058171]  slab_pre_alloc_hook.constprop.0+0xa8/0x110
> [  167.058202]  __kmalloc_track_caller+0x74/0x2b0
> [  167.058233]  kvasprintf+0xa4/0x190
> [  167.058261]  kasprintf+0x58/0x90
> [  167.058285]  tegra_xusb_find_port_node.isra.0+0x58/0xd0
> [  167.058334]  tegra_xusb_find_port+0x38/0xa0
> [  167.058380]  tegra_xusb_padctl_get_usb3_companion+0x38/0xd0
> [  167.058430]  tegra_xhci_id_notify+0x8c/0x1e0
> [  167.058473]  notifier_call_chain+0x88/0x100
> [  167.058506]  atomic_notifier_call_chain+0x44/0x70
> [  167.058537]  tegra_xusb_usb_phy_work+0x60/0xd0
> [  167.058581]  process_one_work+0x1dc/0x4c0
> [  167.058618]  worker_thread+0x54/0x410
> [  167.058650]  kthread+0x188/0x1b0
> [  167.058672]  ret_from_fork+0x10/0x20
> 
> The function tegra_xusb_padctl_get_usb3_companion eventually calls
> tegra_xusb_find_port and this in turn calls kasprintf which might sleep
> and so cannot be called from an atomic context.
> 
> Fix this by moving the call to tegra_xusb_padctl_get_usb3_companion to
> the tegra_xhci_id_work function where it is really needed.
> 
> Fixes: f836e7843036 ("usb: xhci-tegra: Add OTG support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wayne Chang <waynec@nvidia.com>
> Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
> ---
> V2 -> V3: Add version information
> V1 -> V2: Add "Fixes" and "Cc:" lines and update copyright years
> ---
> 
>   drivers/usb/host/xhci-tegra.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
> index 1ff22f675930..8dbce2cdb7e4 100644
> --- a/drivers/usb/host/xhci-tegra.c
> +++ b/drivers/usb/host/xhci-tegra.c
> @@ -2,7 +2,7 @@
>   /*
>    * NVIDIA Tegra xHCI host controller driver
>    *
> - * Copyright (c) 2014-2020, NVIDIA CORPORATION. All rights reserved.
> + * Copyright (c) 2014-2020,2023, NVIDIA CORPORATION. All rights reserved.

Please drop this from this patch. Greg indicated in V1, that this should 
not be part of this patch.

Jon

-- 
nvpublic
