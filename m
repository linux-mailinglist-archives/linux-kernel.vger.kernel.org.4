Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9206D511B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 21:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjDCTNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 15:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDCTNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 15:13:31 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C982117
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 12:13:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CaJOQ/aYjkRmlqBVV+hxYdv4/8N/vGKQAfzoI12Owku0FMF1CjTps1j3qiJzKiL8YBevvKam7OJ6ZHKfv13KdZajZ+ZEXxNKhAvoSOf/7ywo2c9R6VphOp+tJg2pkwiph3dRxrnuMx1dWfEnEAL6rBRZrG/dIy86zLM9ti8sNB5VNzp2R/ILwDyBV6Qupvt9K8rknY783TQffCzwNjaCBVpRUQ4Xgx2WU4iiB0gHWP73sbh7m/EIIu57/ZBSLE7HlyUfNNtX0VfagifDrkVniZIv7Zo32ZwomBnUSRuhqY0yFEORsnFJD+j/eMeNlTwSA+kCVraAQIJ3qsC6TrBMzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzcmbAWKSHbZMOIumrxiQ0SfFwzDkLkhfLty4cT1qYk=;
 b=CdMvgEfN0IDEuqRa0f8GBkY0qw/y2tg/KtqDy8+rqXFkxMvC6en74K2nIIjVZui2iS9RSiCRyDWZun5yxb7A7Tr/7mBmN3w8lM69+ev9peyeLznic5GuPvcuEI/2NSROv4xFNKbwnNgw/ppOwjGO2DQ3T+VJkZN/bWsrByZfUQeICLCoSQfekXuw1XW3ti/jgG8DZH/B8Z1rqY0YReaRboxuqQVzJvvk6QPg5MYP9hqKphb/9vnx8aiF3nKDDzIBDNvr4vFshIjwQ2qZvDOFWy3ueIhQTMyFWrB/VspwXgkzRAEv5DsGRYYEZvNNYuLBW6kjDArYwIJhtxoGx/GleA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzcmbAWKSHbZMOIumrxiQ0SfFwzDkLkhfLty4cT1qYk=;
 b=mQw9q9hnHAG69hdn+WVvONhpib3tpU6+gU8p7cicYHIbvZffUa+ZTEUnqUFF6mka8myfTvuAB+syZRVS3lq90wFtkW0Ve4mDsIoWF4+54VH5I9ylsPEh4PhDmYbiSxHgA8Pw+sEvFEzd2axYAd0yWMD4yAo+yAZNGOcPMs2poB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 19:13:27 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::5b56:bf13:70be:ea60%5]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 19:13:27 +0000
Message-ID: <93800953-b800-960a-f7dc-e517158b68fd@amd.com>
Date:   Mon, 3 Apr 2023 14:13:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 02/11] virt: sev-guest: Move mutex to SNP guest device
 structure
Content-Language: en-US
To:     Nikunj A Dadhania <nikunj@amd.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     bp@alien8.de, dionnaglaze@google.com, pgonda@google.com,
        seanjc@google.com, pbonzini@redhat.com, michael.roth@amd.com,
        ketanch@iitk.ac.in
References: <20230326144701.3039598-1-nikunj@amd.com>
 <20230326144701.3039598-3-nikunj@amd.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20230326144701.3039598-3-nikunj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:610:e5::35) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:EE_|BL1PR12MB5237:EE_
X-MS-Office365-Filtering-Correlation-Id: bd48cc5b-3ffa-4983-dbd8-08db34778126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VecbkhQmA9t/MqrkMXg9oNx2+uLhKcP5YqenqqVy7wzMkerMyvxt9uyzQ/YZ5PtnXttJWvDWXijG6dj3R6DKECpvZfmukTdqXe8QJkz05MbRO8LH+fryVpngn1DJM2GxCmugroTrfy1b7lJ2yUTruPuqCBo15z6mUOGCiKH62zovtLGXWhIED6MfgR8KP4AIMDWfEbbqI10kzYPKVpSJ2qATGgcB/i88j6Z+Zq6wXzeVleAtfzcGkZRP+hFOzXt7O26P3oGqSk+UxSiXxyYiSDNTcAPNiqSdEhAzX2uJmKaqfvflbQ7tBa/+Ceh1lL+MU8YCK5ky3TzYXVf6LEUs3FmEeqtt3J0kQBbqeSvnwzMO+LAiUw9SarLqtdfdsDyaWq9611GemTO8GMgVaFnprFLiGN/NxjdexeWO4iOW10Y+tqrVRjH1BsorgHvNQ/MhxP5cPk28/+zP6IEt182d42pq+WfgEV+xKSPYsdTibK9w6qpUYWGvVBbKxmkCuw8AyRBm4IkgY1/eGKNrZd7QubxneTenoZKoTSw0QllCYE3ctYZ1Oz56HpkdKcHZzMIVgh3hsxqbw/fqd2/dx5jYRKyPpQXgltWEdnr7XB7fl7PdX+2Nu12Gvxqktiu9QCOm2ds5rWPmO56SnJs+NLDxAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199021)(31686004)(2906002)(38100700002)(5660300002)(66476007)(66556008)(66946007)(8936002)(41300700001)(4326008)(8676002)(36756003)(316002)(2616005)(31696002)(83380400001)(53546011)(86362001)(478600001)(186003)(6512007)(6506007)(26005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVp4d3FlS0pQc3NaMlFmOTFERnBLNXkrWnp5RkZtWk4vMGtVTnNYTnBWL1o3?=
 =?utf-8?B?TDk1ZDdwV2Q5TGVwak56c2VHdi9HTTdmMUxkL1E2WEg5T3hUNTFHRS81UTE0?=
 =?utf-8?B?MlhMUnRBQnhlQTN6QWQyVHZsM0dRaEVwWmJFWHdEUU52MCt6SGdrS1ozNXBU?=
 =?utf-8?B?U1FxckcyZW9lMmEvaWQwZW5OdUg2dWcyOWhnaUtjemVQTXkvZTBKbDhQN2xk?=
 =?utf-8?B?dFBkTlg2Vkd0UU0wMkVqY3JyQmVydWtzb3ovMXVEdjd5Q1ROYkVMWkRlMkc3?=
 =?utf-8?B?Nnh1T2c1RlJZSEdScmsxaERCUWN0ejBQODZxdjVvaFVxRmtSUWpRWGxWaXF4?=
 =?utf-8?B?RVVyM0s5OXkrWkZ0WnBkcklDdzFPRWhJcGdYRWFITmZ1L2hMb09QNktyYzE4?=
 =?utf-8?B?ZEdPQ01EUFlXZm54d0ZXYVhZOTNHUDBQWFE4b1k2U0hrVFBOVDNWTkRUUFQw?=
 =?utf-8?B?UmdRS09zSW8zbndXU2NwVi8wN2p4NllEQXdDSnhUQ1BCOG9sTTAzSWFSaDU5?=
 =?utf-8?B?ZFFUMEFxY1JIRnNnRXFaQmR2QXZMUWtsb3pyRWdXaVRtUi9FNEJUV09DMXBo?=
 =?utf-8?B?QnlpNjBFYjN5d1RZTVFsTE5ybzZHd2RTMHFBeUgvMTNxOTRwZ3F0ckk2a2hw?=
 =?utf-8?B?ZHMycjUxSFVtRVhkVkdmTmlPV0htcmhULzZtOEJQYk5LcUpIYTk3WGd2RWhD?=
 =?utf-8?B?cVZ2RUNGQWlUSEtsVTl4VXVXdWg1cEQ2YklITzdGZWh2K1h5NTJ2ZWQwUU51?=
 =?utf-8?B?bEdKZEpVYzlDVGlDYmcvQThrc0t0S0kzOUZQb0RDc3R4K0hGU253MHMvOWdo?=
 =?utf-8?B?Uk14VXo3TzkwcUR2U0pUcG45V21vTEs0azUzaEs3RWZIdE9vRUxCL3VlSW16?=
 =?utf-8?B?M3pQRWNtbjNkaFA3d1lLckJaNkNEc2tZa3dQYXVlYWZyK2hvMkFwTG1WdmFQ?=
 =?utf-8?B?Vm54Sk5yZm9iZGpidE1mNUpKRGUxVXFnTDZxemNzZDM1OTRxb2dLTVM0c0di?=
 =?utf-8?B?V0dUdExZNGJqSTJWUUl3WnYrc3FYazZjWUp2N3FwamhSU252NjBNeXA4R2VT?=
 =?utf-8?B?KzJlY0gwb0VuSEpXa1NqeVNCY3VHQzhIdDJsSGo5MHMyNGgyZGpkazFVdmpP?=
 =?utf-8?B?cG1WbHRiNysxeWwrdHpMN3ZHSzFYWk5Ja2EyNEdIcjZsd1ZYOWJCQUVVN25x?=
 =?utf-8?B?S0YrTXFtVjVNb1c5Y3M3TE1taXlvV3BjRDdGU1h2WnQzUG96SkpjeStpODRa?=
 =?utf-8?B?VTd6V2xucmNySUhLYzN3eTR6SlZCanFyYmpXcGh6cjNDRWV4SCtXMExhWnpH?=
 =?utf-8?B?dit1aCtTTnEyMGs1eGRaUXRlMjJ6UEU1ZVl2b0NuM1ZPdTdnRUtFMEhPbXhi?=
 =?utf-8?B?NWxwazRqaU9WalpFNGl6c2hiRVVPUXE4RVhlVTZCcTlhWkNBOFhVSVpkWmlp?=
 =?utf-8?B?SER3c3FZKzR5bjN2S0tKMlFERkc4eVhSOWdSQ3EwQmppcHBoRk5haXZDelpN?=
 =?utf-8?B?WkMzTFdwZ1h1azBHTm5UYjBxRHdGVjd4UUxhRzRBK2hyZmovbjFpSEVJRDFl?=
 =?utf-8?B?S0l5YjNlN3d3d3lYN0ZWUUpSL2hFYjRlS2xjbk1GUEkvMmo5QlgyNWphdjdx?=
 =?utf-8?B?YllkMUxjNlRBRk85OWg5N1BBV3Fwc1d5MWgrVHJiWmVHSG5uOCs0UnZSdlNC?=
 =?utf-8?B?QW1MSnNweUg0MlN1MXY0REEvZGlDUUYwb1h2NTk0Wk1wV1NnWVNFbDQ5YXla?=
 =?utf-8?B?Y01hb2RJT05jaVIyclVRNUV0c2RUOXZhak1zL1JvYUxhY2R0enYyUldOT2ZQ?=
 =?utf-8?B?aHdjdWlzcXBsSWgrS1pyK3hYS05PdkM1VS9Ta3BoZVJpamlnZHBMaXBQMVBi?=
 =?utf-8?B?K1JtRVE4dVJxMjM0NjVGZVk1Ukl5SmtQWENSVWVCdDlEZERnaXE3MXpEQ3pV?=
 =?utf-8?B?RU1tbDlFSWN1N2NJU1JJMlF3dUJkN1U2a3o3TEtFWXZhTmt5Z0xuL1g3QmRl?=
 =?utf-8?B?bFpUelRPY0d3dXpONk5Wb3RMUDBpcTJValpVQUlaWTM4NzNwdTZtMC9JV2J5?=
 =?utf-8?B?aDdJQitkWGZNUC92MFZqcEZPZDVhaVV0QUpmeEl0ZzdOS1UrTzFqMXF2SGlP?=
 =?utf-8?Q?XP1EGjT+7ujaBcbonkSvbUE3f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd48cc5b-3ffa-4983-dbd8-08db34778126
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 19:13:27.6877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZHNazG49Uf3V4zwC+Uhke75uvbQzdrYgIi0vzYDuyQWIQkYcZBUa6ObnuqvM+hK/Qmt/EdgIL6J3k5lX2QnyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5237
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/23 09:46, Nikunj A Dadhania wrote:
> In preparation to provide new API for sending SNP guest message to the
> sev-guest driver, move the SNP command mutex to the snp_guest_dev
> structure.

In preparation for providing a new API to the sev-guest driver for sending 
an SNP guest message, ...

> 
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>   drivers/virt/coco/sev-guest/sev-guest.c | 21 +++++++++++----------
>   1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> index 57af908bafba..6ae197b57644 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -35,6 +35,9 @@ struct snp_guest_dev {
>   	struct device *dev;
>   	struct miscdevice misc;
>   
> +	/* Mutex to serialize the shared buffer access and command handling. */
> +	struct mutex cmd_mutex;
> +
>   	void *certs_data;
>   	struct aesgcm_ctx *ctx;
>   	struct snp_guest_msg *request, *response;
> @@ -48,9 +51,6 @@ static u32 vmpck_id;
>   module_param(vmpck_id, uint, 0444);
>   MODULE_PARM_DESC(vmpck_id, "The VMPCK ID to use when communicating with the PSP.");
>   
> -/* Mutex to serialize the shared buffer access and command handling. */
> -static DEFINE_MUTEX(snp_cmd_mutex);
> -
>   static inline unsigned int get_ctx_authsize(struct snp_guest_dev *snp_dev)
>   {
>   	if (snp_dev && snp_dev->ctx)
> @@ -99,7 +99,7 @@ static inline u64 __snp_get_msg_seqno(struct snp_guest_dev *snp_dev)
>   {
>   	u64 count;
>   
> -	lockdep_assert_held(&snp_cmd_mutex);
> +	lockdep_assert_held(&snp_dev->cmd_mutex);
>   
>   	/* Read the current message sequence counter from secrets pages */
>   	count = *snp_dev->os_area_msg_seqno;
> @@ -377,7 +377,7 @@ static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_io
>   	struct snp_report_req req;
>   	int rc, resp_len;
>   
> -	lockdep_assert_held(&snp_cmd_mutex);
> +	lockdep_assert_held(&snp_dev->cmd_mutex);
>   
>   	if (!arg->req_data || !arg->resp_data)
>   		return -EINVAL;
> @@ -417,7 +417,7 @@ static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_reque
>   	/* Response data is 64 bytes and max authsize for GCM is 16 bytes. */
>   	u8 buf[64 + 16];
>   
> -	lockdep_assert_held(&snp_cmd_mutex);
> +	lockdep_assert_held(&snp_dev->cmd_mutex);
>   
>   	if (!arg->req_data || !arg->resp_data)
>   		return -EINVAL;
> @@ -456,7 +456,7 @@ static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_reques
>   	struct snp_report_resp *resp;
>   	int ret, npages = 0, resp_len;
>   
> -	lockdep_assert_held(&snp_cmd_mutex);
> +	lockdep_assert_held(&snp_dev->cmd_mutex);
>   
>   	if (!arg->req_data || !arg->resp_data)
>   		return -EINVAL;
> @@ -541,12 +541,12 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
>   	if (!input.msg_version)
>   		return -EINVAL;
>   
> -	mutex_lock(&snp_cmd_mutex);
> +	mutex_lock(&snp_dev->cmd_mutex);
>   
>   	/* Check if the VMPCK is not empty */
>   	if (is_vmpck_empty(snp_dev)) {
>   		dev_err_ratelimited(snp_dev->dev, "VMPCK is disabled\n");
> -		mutex_unlock(&snp_cmd_mutex);
> +		mutex_unlock(&snp_dev->cmd_mutex);
>   		return -ENOTTY;
>   	}
>   
> @@ -564,7 +564,7 @@ static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long
>   		break;
>   	}
>   
> -	mutex_unlock(&snp_cmd_mutex);
> +	mutex_unlock(&snp_dev->cmd_mutex);
>   
>   	if (input.fw_err && copy_to_user(argp, &input, sizeof(input)))
>   		return -EFAULT;
> @@ -683,6 +683,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
>   		goto e_unmap;
>   	}
>   
> +	mutex_init(&snp_dev->cmd_mutex);
>   	platform_set_drvdata(pdev, snp_dev);
>   	snp_dev->dev = dev;
>   	snp_dev->layout = layout;
