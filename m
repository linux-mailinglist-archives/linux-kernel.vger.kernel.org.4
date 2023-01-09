Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E739B66282F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237265AbjAIONy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbjAIONY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:13:24 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F91DD2C5;
        Mon,  9 Jan 2023 06:13:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFQ0aa61EpM5pgnUw8rC4i5M1ZM0EIuZokOJuCPqFgif0UvPOfCXQwz2oTm5whfB1qS7X4ca5jzni1/CiQhQv23+0Ud2xeW31v+krpOP6DTqPIxQDCqeD+qsSpSgBtjsOXU9pMH619wwZk/c5u6wmTCpVq+vC5nd+aPaR4lKHX7GJo7s0P8xerfQSeZRmSzPuZSeO1k/xmzdG10SA9H5aT12Pl0mKDvocscdhlPFQTuf8WCGQSPA3DKqBmMSUYL1Dii2Mj3G0vV5bhs3EYNHL6GzlTKwn2o4zHW1g6UYCMH9p3VdQs6Gs94JLduwGVbvAJLHEaFl1iq29Dk9t0aIEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoOqcXHHetFb2z9HMNIEyeWtTI2GrtVKbuEdikm1HaY=;
 b=A3i9y6ZmJTiinZ+UNhIMQI5Z4dFuPUjtdA1ik1ZbmwA8JxLpYEOs/dDeoWD5ysdrqPtpfXpMbNggnvUOzluW3x6mKj9tLlTh5RNbmKFunt0GhxsNGqfQohjyfX7tmpFA2GL5g7Uhh7tpQzPhqSaEqA3MkFFLaQAmrGe/0QUbpCJCmlzVL9Nmk71UbEspZyQsdQFTIxkVZPhhC1+ypNJk2jWJ+k1f4MDto3Bq0kJZyvh7uLJdsCLNrKFgWXD51kp968DuMZlSx+ot4ZG0Q/lChpdvEyeUpmX3IfyrF6H64Yq3zq1Wzop35wRpPbFZyOPK+jjIugmWJFFxcCulccm8vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoOqcXHHetFb2z9HMNIEyeWtTI2GrtVKbuEdikm1HaY=;
 b=0H70/qlOO1HLVuiXHVpeXtWCBOUdMLHAwNs8Ze5FtZmLWbuQqFThzBiCa8Vw+aFx0nVc824oWx2/ZW7Ko+/BxrS12e4UxhLrHmLBKH32loFjvyPK+Toucfx7GwOsmGB4+BLJ4Z3j1HWKnQzCi1IXnqjojjWbcuFxLy3CwWLpbHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by DM4PR12MB7528.namprd12.prod.outlook.com (2603:10b6:8:110::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 14:13:21 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::8200:4042:8db4:63d7%4]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 14:13:21 +0000
Message-ID: <4b3d35d4-112e-9322-f693-9a4984308d34@amd.com>
Date:   Mon, 9 Jan 2023 08:13:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] crypto: ccp - Failure on re-initialization due to
 duplicate sysfs filename
To:     Koba Ko <koba.ko@canonical.com>, John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladis Dronov <vdronov@redhat.com>
References: <20230109021502.682474-1-koba.ko@canonical.com>
Content-Language: en-US
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230109021502.682474-1-koba.ko@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0018.namprd05.prod.outlook.com (2603:10b6:610::31)
 To DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|DM4PR12MB7528:EE_
X-MS-Office365-Filtering-Correlation-Id: f32d9d1d-40fd-48f1-9d19-08daf24ba945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qFU+YfxmiZYq37sq7wtkG31i4adpO2FLQv9/c6iTp3cn16gWrob8Vz/t5lxbr4Ek2T2B3I379m4YpSwBYd/BKzZv+nMktkv3W1Zxu7zHyIx0xOastrDqrLk25rzQ0J//WOr4wTxw5Hk3CXpSTDUf3RA1NaPZUM0fncDFMuEg+V9/v9k+M0vmdrlmYALs0Em6cjrNfpdSmmsOQBakOA3e7/iMO20Hcvjp6dsHaDy7uJ73vzs56qEAbNdwCjJ/jgZoHoEc4kzj0hNj2FHtWt9kz24LXkzoy5PfOO8y17QbVP5Iwsh+YHYDLhBdEjU3vbxhIM6hAAgLMe/mptvRKkFmLNEQvJJgJ//1LxiX4OeexzpxeCGuMZgx/DYk0/n96831AKMnFpA8YnUpwafEV71VxpN29Nzo2yYRiXT4akY1TkyzR88cRVy9uAMbZNVFdycAhGMF5jLiKO7Z1yQftl/glyctkJ4jhecNx+3vWDYJekq9iXKyni9/CApZqBn3vSy6PAlQkJwyOFgoYZBl9MVOqRb9yDG+0JztvinDMvpZMlPyDnoze+zOV9i1wGapIEDJru/J9sSmDsuHCzj2jjJ4lfF7poe8/sTze1z1FdQWA3lqLQT2XhHCIT+bBp23qeVC3uQd8xiXog6gH0iC2923zCZYOJDMwEZdPaVK//S55hcRZH1K9he0VBdvCEXvlb3PfrGU//6kQCwrYub5TvsRMr5xmq962N8Lll8svHjOPgcFzmVonvRb2UWhfUOg7lkUJMuwLF7uLXyO3Yz2UPi6zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199015)(36756003)(31686004)(86362001)(83380400001)(41300700001)(110136005)(66946007)(31696002)(66476007)(66556008)(8676002)(38100700002)(6666004)(53546011)(478600001)(6486002)(186003)(966005)(6506007)(26005)(8936002)(5660300002)(2906002)(316002)(2616005)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXhrK3ZRTkIxOG1QS1FYMTRGQzF5dmV6Z3gydk5YcjVIR2JrSEVoT1VPL1ZJ?=
 =?utf-8?B?Z3VWdUgxWTNOaDVXWEhoMGFHZWRTVDhpWXFDVVI0TmU5Y2FxaWRNRmNETHoz?=
 =?utf-8?B?SXBFR3lGdUFjSWU0aWtBcEFDUk1iZVpMWjlTV3A2K3FzVnZZRTFLc1plaFNC?=
 =?utf-8?B?RkxJU3pIWDVmZWtjMVBZRUNzQlJXc1gxbDRaSVBidTRzNm1CZEsxK2VBUlpn?=
 =?utf-8?B?U0cvbXpIVGxWMDBwU2FBQjRBMmxlWXVEbTNkejJBdVZMOUs2dFNDZ0FDZG1Z?=
 =?utf-8?B?TWVEWWtidXhsckhxL2RuNGFGQTRyTStTNGZlR0Zhai9Wdk1JVjU5R1QxQzBY?=
 =?utf-8?B?OTR0V3VFM2Yyc1RuRDBwUGMzNWhPcFRxNTUrL09SQmY0QU9QSU1lNHhDdWpF?=
 =?utf-8?B?bFFNTSsrWkFhT0NORVhPeFo1OHpSMTRIR2VaNXlLVXpHSzlJclFROWoxMldP?=
 =?utf-8?B?aVJ5M3Q0RFAwNW5sVGNPV3U4QW5KVS9HZ0M2K3ZYT0xPYVUrRzlMYzF2bUU4?=
 =?utf-8?B?WjFIVHVqUTltYUhVbkN0dHRGOGhIMUlyRDBoNnNySGhCSmlVaGNMNFZMSWd0?=
 =?utf-8?B?aWIzZ2REZ3ZYekwrZzk5TjR4aFg4Q0hTV2Q2WGZvaGVreVc2bkdkYmxmOE51?=
 =?utf-8?B?QlFWbUlkcXBKamtvbkZOQVZCVkhXakZqem1GYkpjNUhzMWFIM0UvL1R1VWN2?=
 =?utf-8?B?Y3k0Y1pVNFY0ZVE3ZlBlSXJ3QXhCY01hajg4S21TM3J4TytWMlI1UEUwVzFy?=
 =?utf-8?B?d3dPckozaVhXVm5nQVVKeXl1WG91Tk9Ha01Hd1FKS2RJT0NyTjR3VDFLUzdR?=
 =?utf-8?B?VlhrTnhITmp3OGMwZEJZR1lwdjlqKzhzMzhSY0JFRmZsS3JOYTlZZ2w2dDBO?=
 =?utf-8?B?a0lJMnJWNzFpOHdpQThnWWR5NUVNYVNaQTNsY3pqdUVsM0FKc2tVdWhaRUNw?=
 =?utf-8?B?czJPRDQyL1ZSVGQ2eUhIZ0YvWlBFRGxvWVN2QmVoTVJaYUJlWjZCNEFVcGZ2?=
 =?utf-8?B?RStON3NyZ2RrMVdrMFgvdnpYSnlvNkJ5cXQvTmdRZy90Qm0ycVVpUXZzN3V6?=
 =?utf-8?B?cFdIWDRXa0J3ZytLdFlwbXhVQTlwZXozdXM3MXBSaHZCbHdOaFQ1QnVMcVBh?=
 =?utf-8?B?eHRWWXJ2cGxLYlphVitObGdCR091YVQyVkJYNUhUVjlHZzZ0K1NtWWd5eXBk?=
 =?utf-8?B?aE91VlVzVkU0eEtPRHZBUmREV3daNEJvWVljSlZhREx2c05FMkdlcGk5Q0NY?=
 =?utf-8?B?NkcyZzBXbUQ4cjhQZ2FGN0NudVBoSmc0Tlp6OS9hbDRMbFozRktoUGdGanNo?=
 =?utf-8?B?R1FtaDM3TXFibzRpTzZXNWZEaUtFNm5tbUdpVTBoY0dDYkx2clc4U1JTQmp2?=
 =?utf-8?B?SHgrY2ZvWHRVWWpaMjdqNjBKTXMrMGxCK1VPeU9FRVRqRldLWFE0b3UxR3JH?=
 =?utf-8?B?QU9MTlRlRmpoVjQ4UHU4MW1uS2NqWm9EcG4yRDNuaWRIcGROU2lqd2tZTE01?=
 =?utf-8?B?WU1KWUZSaWJPc3VhZTh6YVZHYmtmblNtUXk4ejdZM01rbzByZndqdEUreWR5?=
 =?utf-8?B?cGNaMkNaeWZybmtIUTVickM4TmI2MmoycnU4SXNlaklQUlNrREsxeGZVSkdo?=
 =?utf-8?B?clRYdlFIdzJFQzAzRnR1VTFTejl0Qlc0N2tnUDQ1aE9OdjZNUFl5ZFZ0U3Ry?=
 =?utf-8?B?R1FqVkh5MENxdzRFMGNaYTd0SElXdk1UdXhubUtwZW1hejdtQTlvQTlxY2I2?=
 =?utf-8?B?U3hZait2M2YrNWttQ1ltNjhsd2xpcEVVcUpqZU1CRXlYR1ZWS3NBaVpUN0xo?=
 =?utf-8?B?YUVsMlE1MUR0RWM2M0FPTmx0UWtJZFFLQmNVRDRabzRpenN4dEJNZUVLWTFi?=
 =?utf-8?B?dWtTNHRUTEZlcitMUnFJUFlwUDNvbWppMDQ0dnM0RUo1Q2wzNndYa1QwVU1I?=
 =?utf-8?B?dUdhTXM2Q01NcFI2VlRFQVJrSUM1R1ByZ0pJd09Qd1RtcC9tcGFhSTlVY3pv?=
 =?utf-8?B?bVdzNDVyN2dKOTA4ZHBxUHhzbVFqd0ZlamQwSTI2bStqcHRsMzNidmh6c29X?=
 =?utf-8?B?VVBUWVNGdmxQNy9rS1NKMWE2a2lrbjdXVytmeFhySjdLSjUrcUx0bnVjajV1?=
 =?utf-8?Q?T1vNoyR8iCAYDPToxKbnuSgcb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f32d9d1d-40fd-48f1-9d19-08daf24ba945
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 14:13:21.3818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTwRehTdsgaGjv1e3BmNiq6rgSZAjGBGCqMzrkUTHTmdZuEKHK1RXzKDvIcK17MtvOoHE4HRJ8twK2qovYNiow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7528
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/23 20:15, Koba Ko wrote:
> From: Koba Ko <koba.taiwan@gmail.com>
> 
> The following warning appears during the CCP module re-initialization:
> 
> [  140.965403] sysfs: cannot create duplicate filename
> '/devices/pci0000:00/0000:00:07.1/0000:03:00.2/dma/dma0chan0'
> [  140.975736] CPU: 0 PID: 388 Comm: kworker/0:2 Kdump: loaded Not
> tainted 6.2.0-0.rc2.18.eln124.x86_64 #1
> [  140.985185] Hardware name: HPE ProLiant DL325 Gen10/ProLiant DL325
> Gen10, BIOS A41 07/17/2020
> [  140.993761] Workqueue: events work_for_cpu_fn
> [  140.998151] Call Trace:
> [  141.000613]  <TASK>
> [  141.002726]  dump_stack_lvl+0x33/0x46
> [  141.006415]  sysfs_warn_dup.cold+0x17/0x23
> [  141.010542]  sysfs_create_dir_ns+0xba/0xd0
> [  141.014670]  kobject_add_internal+0xba/0x260
> [  141.018970]  kobject_add+0x81/0xb0
> [  141.022395]  device_add+0xdc/0x7e0
> [  141.025822]  ? complete_all+0x20/0x90
> [  141.029510]  __dma_async_device_channel_register+0xc9/0x130
> [  141.035119]  dma_async_device_register+0x19e/0x3b0
> [  141.039943]  ccp_dmaengine_register+0x334/0x3f0 [ccp]
> [  141.045042]  ccp5_init+0x662/0x6a0 [ccp]
> [  141.049000]  ? devm_kmalloc+0x40/0xd0
> [  141.052688]  ccp_dev_init+0xbb/0xf0 [ccp]
> [  141.056732]  ? __pci_set_master+0x56/0xd0
> [  141.060768]  sp_init+0x70/0x90 [ccp]
> [  141.064377]  sp_pci_probe+0x186/0x1b0 [ccp]
> [  141.068596]  local_pci_probe+0x41/0x80
> [  141.072374]  work_for_cpu_fn+0x16/0x20
> [  141.076145]  process_one_work+0x1c8/0x380
> [  141.080181]  worker_thread+0x1ab/0x380
> [  141.083953]  ? __pfx_worker_thread+0x10/0x10
> [  141.088250]  kthread+0xda/0x100
> [  141.091413]  ? __pfx_kthread+0x10/0x10
> [  141.095185]  ret_from_fork+0x2c/0x50
> [  141.098788]  </TASK>
> [  141.100996] kobject_add_internal failed for dma0chan0 with -EEXIST,
> don't try to register things with the same name in the same directory.
> [  141.113703] ccp 0000:03:00.2: ccp initialization failed
> 
> The /dma/dma0chan0 sysfs file is not removed since dma_chan object
> has been released in ccp_dma_release() before releasing dma device.
> A correct procedure would be: release dma channels first => unregister
> dma device => release ccp dma object.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216888
> Fixes: 68dbe80f5b51 ("crypto: ccp - Release dma channels before dmaengine unrgister")
> Tested-by: Vladis Dronov <vdronov@redhat.com>
> Signed-off-by: Koba Ko <koba.ko@canonical.com>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   drivers/crypto/ccp/ccp-dmaengine.c | 21 +++++++++++++++++----
>   1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/crypto/ccp/ccp-dmaengine.c b/drivers/crypto/ccp/ccp-dmaengine.c
> index 9f753cb4f5f18..b386a7063818b 100644
> --- a/drivers/crypto/ccp/ccp-dmaengine.c
> +++ b/drivers/crypto/ccp/ccp-dmaengine.c
> @@ -642,14 +642,26 @@ static void ccp_dma_release(struct ccp_device *ccp)
>   		chan = ccp->ccp_dma_chan + i;
>   		dma_chan = &chan->dma_chan;
>   
> -		if (dma_chan->client_count)
> -			dma_release_channel(dma_chan);
> -
>   		tasklet_kill(&chan->cleanup_tasklet);
>   		list_del_rcu(&dma_chan->device_node);
>   	}
>   }
>   
> +static void ccp_dma_release_channels(struct ccp_device *ccp)
> +{
> +	struct ccp_dma_chan *chan;
> +	struct dma_chan *dma_chan;
> +	unsigned int i;
> +
> +	for (i = 0; i < ccp->cmd_q_count; i++) {
> +		chan = ccp->ccp_dma_chan + i;
> +		dma_chan = &chan->dma_chan;
> +
> +		if (dma_chan->client_count)
> +			dma_release_channel(dma_chan);
> +	}
> +}
> +
>   int ccp_dmaengine_register(struct ccp_device *ccp)
>   {
>   	struct ccp_dma_chan *chan;
> @@ -770,8 +782,9 @@ void ccp_dmaengine_unregister(struct ccp_device *ccp)
>   	if (!dmaengine)
>   		return;
>   
> -	ccp_dma_release(ccp);
> +	ccp_dma_release_channels(ccp);
>   	dma_async_device_unregister(dma_dev);
> +	ccp_dma_release(ccp);
>   
>   	kmem_cache_destroy(ccp->dma_desc_cache);
>   	kmem_cache_destroy(ccp->dma_cmd_cache);
