Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66AF0618D1B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 01:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiKDAHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 20:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiKDAHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 20:07:17 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4FD1CB30
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 17:07:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EkGGWLlloypyTArk495KRufX7xjXTmhwgTO0qsTXXQDViG/L+N0Jy0/0miSz6NZ9FPx0FB5pW182aBuT+2Lt10tgBuavJiA+BF3gJT1rkpB3pcwZeGZD+zk8ygLFg88sg1w52+nPSMSgVh9PoMB+rUDgZ+ax05YcXLqreZm5asYZVCfz2M4PjoR9UYHwACFP3tEixMBdoqFssogYG3U+9dDi+brp1WMmoOt8+H74JFcchkDbDtdEx161IU5iUOnp3gwrLss/wIWFozB4Ya/53S423U4LQvWF+4jE74jKAlZailAxbuHGPP/uqyXNgro4glEYJ5GSQ2O+xw/s8uTuxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnVbEp0lWRCLvBDb2bsS/R6tLpz/1N+qPlCxYa9SqRI=;
 b=GJcjpM/mCaO0lQ9a+UkBXTCNqiWle9bGvWpOBBuO3VVGFXOsSNalUJnX8WI+nQMrhmgrbngDx1tQe3wbjBNgo8BEKPdDMQx84gfCgzaUX41l6+ma+TAisUA86eIjayuSaeMVJJ0+zVqcRAlojjUOlaMHqWdEIyO+AMDvVizOBj9WsrHU4Ok+AtcXVUDCqBgoPLHwu9ysmqrUo1UWI8m/YSmF6qvbViyILvbWxSBhBrfnDKPqR4f0DBWVEmMgqhebuDqsono6BWdXatJqG7toqK9+SLClz/JEkyayVx14gbrgW4Yxr5NIBfo+ov8iNZAxVcD2zPB4CdJXr/lRdHGwBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnVbEp0lWRCLvBDb2bsS/R6tLpz/1N+qPlCxYa9SqRI=;
 b=N9khEKQgr2mGwylD2F8UKc3l8R6BJ8bOVbOuG8MksJ6hcwpKpEIYFbWHdfeU+lLy8dakVF1qrc17vqKLBE1Fmjqg2wntp4kyNguPIbnkj97MNPLwMhvCAoKWMbiJoZVbGQ+/m6IJqiWnj6bU/jtslC0ByjRydUDIkpobzQLL3AY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5933.namprd12.prod.outlook.com (2603:10b6:8:7c::14) by
 BL1PR12MB5221.namprd12.prod.outlook.com (2603:10b6:208:30b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.22; Fri, 4 Nov 2022 00:07:12 +0000
Received: from DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::8b4b:6c02:e13d:ae00]) by DS7PR12MB5933.namprd12.prod.outlook.com
 ([fe80::8b4b:6c02:e13d:ae00%3]) with mapi id 15.20.5769.015; Fri, 4 Nov 2022
 00:07:12 +0000
Message-ID: <d1007059-358d-37e8-e835-2d7a33143a98@amd.com>
Date:   Thu, 3 Nov 2022 20:07:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v3] drm/amdkfd: Fix error handling in criu_checkpoint
Content-Language: en-CA
To:     Felix Kuehling <Felix.Kuehling@amd.com>,
        amd-gfx@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
References: <20221103231227.916426-1-Felix.Kuehling@amd.com>
From:   "Bhardwaj, Rajneesh" <rajneesh.bhardwaj@amd.com>
In-Reply-To: <20221103231227.916426-1-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0004.namprd16.prod.outlook.com
 (2603:10b6:610:50::14) To DS7PR12MB5933.namprd12.prod.outlook.com
 (2603:10b6:8:7c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5933:EE_|BL1PR12MB5221:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f85a041-5f86-44f5-910e-08dabdf88629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8VwtQn2F80CPkYWaro/RiwJT3VUwgcxLn6bvZzXQGI6TPvcenc53jfmlykvvOOvW8QLUg+RVV4GQ3llieISCoaq/NhN5DqlP56I+nbc9fr00LmBUpgYCsGy6fNMRhQabSAb8UvbJRt944yCswnhHLQzO6jk/FHQxW8gEhK7s3mWIWuVNRWSCkiCvSaJDkhA/QzYpbooqTwGT4c96xpInvvZfKmQKbSs9wcuwaZCFNCupQ9bAVkEFVIPFkndFWfOZkW+MZmqjJn6PRBlbF06ZGhuEkTLs8p7tGCaJfiyRk7OjrVNQMOCzoH1u255dbPk4JJ/otdrW31NYWaA5m0Z7ImTolK3Cl4U+GBAqZOcNygMaTTIHu11Wcn5cHggQhgwXss5FLPqexjI1vfBsXr15MsJYjC8uS3a2Ux3lS4E/Y+Vb5I685R990QtIDE9oZZ2B+Aow9M1le8Adt/fUjP5itjrq1IWmKkUaS5GDA2up4oqsv6dM+6hgWK3ErVBQWkVhYVomqEeMYztog3X4rJYSofbpiMsCgZZP2sN0aH3uUQlOFEBrTnXdjEZ/BylJVwxt3jvE9P3LCe30bQidZzsO7c6m2J7KO1HI3IhbBDaoMcC7EWzCLNahRPl6bfPTe7me8ROuxAfQBWNWin7XRQP5qhaDAsrjHrS9eycAln8bdRmfQ4yMBVvSqFevq2QZ4d/0hTjOXQXyyTQp4m4XVwqfjR7yHGQaYLZdeS/BQIP1HFCEEHivpNuZ182BgzKykg8NVF941fKzEz1g6u4bBqFFTdGO+jTgPJhlivpB/W9GKyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5933.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199015)(4326008)(8676002)(66946007)(66476007)(66556008)(26005)(6512007)(316002)(53546011)(6506007)(36756003)(86362001)(38100700002)(83380400001)(8936002)(31696002)(41300700001)(2906002)(2616005)(5660300002)(186003)(31686004)(6486002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3krVmFWVGVZRlBUY09Fdk9EL21kOVU0WW1SOTlYbDFrMHhyQjhQR0FheWVx?=
 =?utf-8?B?eG9GeUwyZ2tiV3NpRUUvSVE5Ym1ydXA1VllBcTRBbGR5a2JXTyt2VUtZZkJV?=
 =?utf-8?B?ZEIxZkdBcmdQZjNrTW93ZTlWY2pmeks2MG9rRjV5ZmhKTk1HMGZxK0srRW1a?=
 =?utf-8?B?Q1lYU1NXZjVWTTlUZFNvM0lsRHJRMDYrdHFQVW9ZQk1nU1dtcGU3MmRIQzZt?=
 =?utf-8?B?QWwvUm9ha3VpNzgvbWtuc2RicG1YQXh2Rk90aTlyZ1IwdnlST01RQWFnQXVm?=
 =?utf-8?B?UEJlVm95RzlNRDFPeTg3VkxPakZhMmRia2JSYWJFM2FDYlZlSWkvT0xrVGJY?=
 =?utf-8?B?SldXRk9LaHRYeGQwMFhBSW11ekFMZ2dqMkxpVU80QUQ3eG5WOGRwZWhjZWFi?=
 =?utf-8?B?YkQ3V3NVdkpnWG4wRmZxRHV4NzZhM1N6ZFRQam4xNVltTjZqZ2VPY0JiLzkx?=
 =?utf-8?B?SFFsb2VWTkJGMTAvYXVtUERocmkvd0t3QlBuS2s3Z2hLbUtFczJvbHFiTVVR?=
 =?utf-8?B?MlNFMXMzRE56T1BZaDdSOEhlamlyTGZNc3BlRUJVOVVlSlJiZ0hCSEJ3UlJn?=
 =?utf-8?B?WXpRMWFqeVRnd2hFVE1QaEN1UFIxWVphYzhvY3lKMS9rMWxVZGdKbkxjOTBF?=
 =?utf-8?B?NWVGbUJ1ODZDalNsUUppdUE3QzR3eUU2bWNBOHJWbng2V0dNbnZwTFY4RFlt?=
 =?utf-8?B?bG1GeEI0SXVMVGVlLzgzaXVSek9xaVI4d0M4L1RDOHpDY3lHVXUyUlBCQ2ox?=
 =?utf-8?B?WEVPU1NjODJ0ZWZkY2trZGEzckFOZTFLazZ0SXNDVkZxYUhLREIyYTluRzFY?=
 =?utf-8?B?RVRqWjR1RllKVE1WNnFpaWR2ZzYwRXN5aTZBRk5zWk9mTUZlTVFDNy9BRDVO?=
 =?utf-8?B?bE9VUWdwZFJqUXMyL2FCa3MzMWR6RnFaWks3TkFSVFVLcWhqbnltMmVPSmZJ?=
 =?utf-8?B?Y3o0ckJ3cWdVYk03OHBoa3J6NkpCbFdBQnp6YnZpL2Qva0NPbHozUXh4V3NS?=
 =?utf-8?B?Z0xVL08zdXhEQzdYNllGeER4bXcvQmVlVEQ0SU1xT3A0MXluaThaNVQraERm?=
 =?utf-8?B?dlFYZ0JEVmdSTDFCeFRvWFcxWUx3YjdUakt4dVFlUHZxQUhKcFBGZVJMMEpq?=
 =?utf-8?B?d2gwaWRjcU9lQkdGeG9Vc0IrL2hVdHplb1BROU9qUWVMMGpKR0tzalJESFRz?=
 =?utf-8?B?eFNDNUtrOGx6RzN3YU40Y21CVzdnTjkrOEZUNmNQUk56K0tCOU54NzJFS3hN?=
 =?utf-8?B?N1c1QlcyOHFwZi9WSS9STWx1WER1ejU2QVhYZVhsMnRmOGxBaVEzckNFd05s?=
 =?utf-8?B?SU9rYnNUK2hpdlVSSlBtYTVkL3NBQkg3dCtIb2FVa29xZVF1U3lWZC9nWElq?=
 =?utf-8?B?SDJSY29sOGRkZjZhTHpnQ3ZsUDhWVTFwbmM4UzRuL0hFS0tlWHQxU0ZtL0xB?=
 =?utf-8?B?dXpXNTNvb2p4RVl1Y1BLK2NVemszVmVrTDEzc3RkZUNIU3FXODBkNTN1aUwy?=
 =?utf-8?B?VFpMNVp2OE0wZ2RIZmJIN3BYTDdqTFdmZDJtb1dYdXZwK0xxTlZMYnYrSXRZ?=
 =?utf-8?B?QVFBR3NZSnpWZ1Z3ZkRtN2JvYjNZelpjTi9YKzd3Nm9qTkVxTm9TRVhKWG1V?=
 =?utf-8?B?bnZWVzY3bUgwYzhGWEJLdUhSbDE3UTZUcElJc2hTc2l4US9xMHNXZ0NuOGRB?=
 =?utf-8?B?RHgzQlpmUmJGcEpueXJsRGd4Q1RQdUZWVmtIbVpIQnUxdHJUVnU0Wmtyd2pD?=
 =?utf-8?B?V0thckN5SERnaHNWbEhrTjNQRXEybXI0alRIdmwvaVFLTTJyQUJ4TjhHUmZM?=
 =?utf-8?B?V0g5bTlUQnNPOVpEaHFlbVZta21MM2orVmdabGt2cm5HS29icDJxTlAySjg4?=
 =?utf-8?B?b2c2NjZGVktlSVplNk1RbFdPUnFkaUtVbFVpM0YxTUJ2WmhNSEc2L3E2UGxP?=
 =?utf-8?B?MnZHVDd4UnlHRTU1WFBmV005TUw1NldvRnBjUzRJbjMrbEV2SnQ4eWZJM21S?=
 =?utf-8?B?SkFMVmROc2ZtSEwxc1JBb2gxSGdxRlEwVjdvNDd1VXNZb0Z4RmVxaUx1WE1a?=
 =?utf-8?B?SDluY0ExN1lKL0d6eVJlM3FXUEJ3RGtrMkljRFdBdXhlUEdWQnArSno2Z2l4?=
 =?utf-8?Q?g8dAhNDsg6Ig61lg/YpSTeFnd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f85a041-5f86-44f5-910e-08dabdf88629
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5933.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 00:07:12.7693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6IWvhANDLuu+zcWn+SXdpzJ9O4XOb4AZ3YtbZs0wBK1eo8cBQaJv13/YLFO42/yjKHRWhDPQ1p9Ql9xx5spdWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5221
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This one is more elegant. Looks good to me!

Reviewed-and-tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

On 11/3/2022 7:12 PM, Felix Kuehling wrote:
> Checkpoint BOs last. That way we don't need to close dmabuf FDs if
> something else fails later. This avoids problematic access to user mode
> memory in the error handling code path.
>
> criu_checkpoint_bos has its own error handling and cleanup that does not
> depend on access to user memory.
>
> In the private data, keep BOs before the remaining objects. This is
> necessary to restore things in the correct order as restoring events
> depends on the events-page BO being restored first.
>
> Fixes: be072b06c739 ("drm/amdkfd: CRIU export BOs as prime dmabuf objects")
> Reported-by: Jann Horn <jannh@google.com>
> CC: Rajneesh Bhardwaj <Rajneesh.Bhardwaj@amd.com>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
> ---
>
> v3: Keep order of private data and restore order the same.
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 34 +++++++++++-------------
>   1 file changed, 15 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 5feaba6a77de..6d291aa6386b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1950,7 +1950,7 @@ static int criu_checkpoint(struct file *filep,
>   {
>   	int ret;
>   	uint32_t num_devices, num_bos, num_objects;
> -	uint64_t priv_size, priv_offset = 0;
> +	uint64_t priv_size, priv_offset = 0, bo_priv_offset;
>   
>   	if (!args->devices || !args->bos || !args->priv_data)
>   		return -EINVAL;
> @@ -1994,38 +1994,34 @@ static int criu_checkpoint(struct file *filep,
>   	if (ret)
>   		goto exit_unlock;
>   
> -	ret = criu_checkpoint_bos(p, num_bos, (uint8_t __user *)args->bos,
> -			    (uint8_t __user *)args->priv_data, &priv_offset);
> -	if (ret)
> -		goto exit_unlock;
> +	/* Leave room for BOs in the private data. They need to be restored
> +	 * before events, but we checkpoint them last to simplify the error
> +	 * handling.
> +	 */
> +	bo_priv_offset = priv_offset;
> +	priv_offset += num_bos * sizeof(struct kfd_criu_bo_priv_data);
>   
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
> +			   (uint8_t __user *)args->priv_data, &bo_priv_offset);
>   
>   exit_unlock:
>   	mutex_unlock(&p->mutex);
