Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFC6682C22
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjAaMDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjAaMDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:03:22 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D242E80E
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:03:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcRcI0nJ7Tq1+bo7zWWtmy/s5xx+EavFEKjAOEIDM94ejizcN47jWwvndaiKGS+rSIA2C7iOFanTYl6IKgs41Rz9mTwOOw14SPomEZ/naIHNmAhyu1EeOsGpm46xcQGi51WKUDav1QV9qAKAcTCze5g5ChIgvPvOt05wphFY+dSEpeoc0qoPfXwiEX9lsFCaLPnEt8LPGNMn7tDZCa70py5peHLrEyQezUeSDAamd6LpIqtwTbXdHsH1RucBkrGHSURa8Jn62fyPwTlmk16ldYhERDFO8bhoF/sTgBYysV1RVtD9xqyTNUgneHt7lblJwFFNqBO2UucNBLZyi640OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Qi0lI2a3UtcvLJiOly/4vP+GG8RgKoAWImNDvZUZtE=;
 b=IoN5/UZrV8vb+hTOVwat9rYWtbtBwJxxNMk3hQDq9zoD8E8dqN3b6P0C1erTqUtVbQP79apMJWZhRyWOsPaehNeIH9ljp75KSD0iJiyvU/yAFzLj39FSUqW7haxTNBtYkOamLdfW/sV6Ihw1uMQTJ4e8LxHQt6GKvF9N/exZy6dMhcZgyFXF7NtnJFoRLfml2vC9T7cO3qeA+aqu9DchIzDOWn+6YBjE5hHADq3sIABmF231XU8DTNZFmDmXw6UTOXU1PtpwvD/Iq+UVjG9UBn72B5TB7+nUAXvUIfP2DvOhrGc1kgq7F09HxF7s885P1qx1KKMXaIla9ElZqw2ghw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Qi0lI2a3UtcvLJiOly/4vP+GG8RgKoAWImNDvZUZtE=;
 b=LLjmn7iku/Fpo6cjG+KdsCdqVIR28v/cmL1uq/U6oNkNAQ1/fJdZd+whbNxlSxpUToAjaIidMZYDOgxq14s8XJBhtiwbBrkLAe/Q/vL/i70aYpreiy1zSeIXqyyRLy9A6u8rsd/7PGsUb0mY9yqnbjcsEhatcWEfbcmE7OPTIIOiCnUzxjAX11oUpPJLOh75CUN+n6nzCI7rXkz5/ZJCw7yBotUSfm/JsrH6u/EwAaiS3msiGTBdqnOfC/46R1jlFY9xNb7DbonPjEtS/ilHmQnugxBWZGodZ9MBrGyxlzxmeyeF9JcIBg+fOejc4EZ7BrH0kUCbgIvV2IIEjSW7Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 SA1PR12MB7037.namprd12.prod.outlook.com (2603:10b6:806:24c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 12:03:19 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::9344:d2ae:739a:a358]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::9344:d2ae:739a:a358%7]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 12:03:19 +0000
Message-ID: <f54334f4-a5d6-2cf9-fa28-6486b297d01a@nvidia.com>
Date:   Tue, 31 Jan 2023 14:03:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/6] vdpa: conditionally read STATUS in config space
Content-Language: en-US
To:     Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com,
        jasowang@redhat.com, parav@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1675110643-28143-1-git-send-email-si-wei.liu@oracle.com>
 <1675110643-28143-3-git-send-email-si-wei.liu@oracle.com>
From:   Eli Cohen <elic@nvidia.com>
In-Reply-To: <1675110643-28143-3-git-send-email-si-wei.liu@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0025.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::13) To DM8PR12MB5400.namprd12.prod.outlook.com
 (2603:10b6:8:3b::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5400:EE_|SA1PR12MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c4cbcb5-6025-4f18-b488-08db0383247d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pVQ9Q4RymedwLfy8+ueVZ7SKH5kVaB5wgi2Ne4rBsxvxkxIyud5FaPj3EPvoc8y8Oy5n/uPqTyPwcRn2VXs4VLKZJmkr8FVHJ2GIGgpoxx6ZmIDr9rSZad4FQeNL6MXI/iISw9bxA1qBFLOfz9+DgZz6d+rl3GtkQ/ktSE6HQvxcKSfrVJoOOgAyE+Kn1aVn2iylnvY7UfClIV+9enPIvDZ4K5oaaX29vvJ0C2hzOjYo7kKdbbY1UXX8NbWi79qwrBp+aE2jPtYr5UwJY04EtYsF7iwfZKa2R4doZ0HjCvbhqgPWNLOaIym2gxvc87i3JxcBpYoEUY5bsKLiGCgl8EXzcCqX7P/ydOxoVYnqTBoUMMM62gt76HSIW+QJl+XKNIkQx1WH6Cs4tIKdykVITT2oKxxO0Y1ZzmAZ4O46UwPJaQWklaXsOlcn46Oq9f/HFg/jgIjrCQR/B6plwjTQ8kdpNWGhoyjM1mCuGOjxNGCrwpPHvfJA1DdolNz6NMkDIoCENHIOrKhwm7FRh1vSmmrlJgBGY3YxO+11OktXeDY4lrn4pOgn+kxaSVsdzedV2XqcuV47PA4cXMBudZeRXKgWxTkZW3L/GZMRwWbthsSHEeeOpQYYw+UcECRFMKxSJ+50HAcNzRWD+IvFZKSP0Gx0lFQPmIcRegpx1Nek97RROB57ZG4RwNjwIsBBdMhxKT8vWmFI2lgoNRfvR0jNrIxQGX6Wj5Rp46Kyk0vnhyI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199018)(31686004)(2906002)(66556008)(83380400001)(5660300002)(41300700001)(8936002)(6666004)(53546011)(6506007)(26005)(6512007)(186003)(31696002)(4326008)(86362001)(38100700002)(66476007)(2616005)(8676002)(478600001)(316002)(66946007)(36756003)(6636002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlUyWmY2b0RiQVBIeGxOcHRyeDQ1VnpNTzI1TjRwcFRncDlpeFFKL3NDSWwv?=
 =?utf-8?B?eStsMWttWWtSK3FXOWVESTZUT1hBRk5oVVZPMWowcXVLeWFQN2RxOXNGQ0Vr?=
 =?utf-8?B?N2daOW9HeXVhT3crR2VTSVFCSGk3WjBjSE5pMjZpRElNb0pmZkk5bHU1UkVp?=
 =?utf-8?B?LzA3WUdGR1NFMDc4YVVZVHB2YVhoaG1YU2I5VWdMdGpRUXlWTHp2YlF3d0t0?=
 =?utf-8?B?RE5xZTQzODVhMU9KQ1lWb1NjenZjdVZEais2ZFBhekpIK0pkMzc4SVh2L2RN?=
 =?utf-8?B?WE4wNGRxWmxKLzhDMHRjNlgvQzhUMHdEc1UzSDIyNG5ra3IrMjVnYVRjUHFQ?=
 =?utf-8?B?YzI1ZVRIdnFoMGlrRUM4VUNFeUJ2L0MzaW5QNUVEbkFMZUNDcVYwd2tqRDl3?=
 =?utf-8?B?azFPMy9UREZmZjlNbkhyNEhmRDJkTHhMN0NXS1VLTTZ3dzRaVEFOclJCck1T?=
 =?utf-8?B?MXVvZ3lyam9EbkJLV0d3T2dxV05MQlU0cm15Nmt3ZTdhNXRLOWFtWVVLV2hO?=
 =?utf-8?B?UUtQS2ptSXZ0ZUlVWm5vUzUwWWNmalRyTDh4M0lrV2JJSXZNMXE2ZGtVVFFW?=
 =?utf-8?B?R1FTVWlNTURiMkJUcnFOZmo1RStiM1BOL0dXREwrOHM5L1NqaXhxSTFHUDdj?=
 =?utf-8?B?b0lSM0l2Q2FaMG9SaElRd0Jhc2pwcWo2TG5aRkYrOG91a1F5Y05zeUZSbnlj?=
 =?utf-8?B?SllzWTZ4cFJrcVJiME1oRnpUNjk3L2hrV0NkZHU5VTlwSzNLQkJtVkliVjVL?=
 =?utf-8?B?QjJZYURhNFo0aUFzemxQZHlqTS8zV3NscFJtQmZYdEhNSDN4aWFKZFpGaFBx?=
 =?utf-8?B?MlBucFFZNnIwSG1oeFh6K0U1dFNZUVpCNTUySDVIbzN5eEorUDdnZEcwbEVF?=
 =?utf-8?B?Rm5CbStoV2pwcmhYN2lKR2NNaFIvYXVkcGZFT2lZWWgxMGJwNHJ3ZVhtQ2NR?=
 =?utf-8?B?VisvMms2NzJZMkVRaU11Sk5HTnBXUnZ4ci9wZDdzOTRLMGxpTHcrbHMxUi84?=
 =?utf-8?B?Tkl5RndPWXVweXdTMmNjT2V6S3FPOG8xbVJsWXIrMDN3Z2ZDSndXTHVvME5H?=
 =?utf-8?B?TFpKN0VhNWtRQmg1bU15WWZpMVNvcTJwY0twSTAvb0c3bWRCSUtyVUJia1U4?=
 =?utf-8?B?b1RKZHVoeDViSUlUMFNPWE5NbytheUY3NUs2VUZBUi82ZVZkTkJlMzM5Zk8v?=
 =?utf-8?B?aGZNSWpyYlN3Z0R1d3BYblhOY2c2MUdneWRDSjRaUFR1OU02VVRPbVgxSWZJ?=
 =?utf-8?B?ZXN0WEVVVTdjb1EvZzIwcE5XSVljSUZXdzhLaUJtSG5hTlRqVzM5R2pNS2hY?=
 =?utf-8?B?N1ZyT0xzQlI0M3Vkd2xSYVlmWk1LWGpKZmV6ek83d0JpdmU5TzFkNG04dzEx?=
 =?utf-8?B?MWtsdU1XTWtXYmc3WWJmZjVDRGFVdzhxdEVBbndxN01PYy9kd2xYZXpOTGQ4?=
 =?utf-8?B?aWl3a0tTbFJqK2JCb1JodHBqNmtpblNINVBQOHM0YVp3d3VvdEJTVWlEZkNs?=
 =?utf-8?B?YWcrck5rakVFVW1zb3lYbmgwL25EUjFySTI1L3hnZmhVVVhveWJKcDl2ZzI5?=
 =?utf-8?B?YkZTa1Byd0l1aDVvRHhBY0dqdFFWNXlld1hremRDb2lUM2dZQXQrcGQwblhO?=
 =?utf-8?B?VlRqOS9nZWhhcmExNk5zQ3FXb3FiclVnUmx3cU1uZTdrcW0zSzVxOXVUWjJD?=
 =?utf-8?B?YjhXdG5KcDdRZkxZZE1yTjFFemFibGNBMThvUFBpU05rckZHbVZpQ2RPNHpu?=
 =?utf-8?B?cDZQdHlpaGpjWEZTYmtrUk1NMDJwYmRUeStGaTZjaGpZMXptMjFweUx2dXBS?=
 =?utf-8?B?M0J2bWxPU2JhZmRtQmZCQjZFeUhyTC9jelNvekc0VFc5ajBSN2NGazBsWWFl?=
 =?utf-8?B?b3lVeElMb3hpVWdjUG9sY2FSa0VYd2htU2FYS0l1YUowMXErWnpRU24wT3ZD?=
 =?utf-8?B?R21uT0xRdVg4NldnUy9DSU8wQ2tHLzFLRDdQQS8vb1VjMTZVSHF5OFd2T1FU?=
 =?utf-8?B?NDhJaC8ySGt6bmNXbFUrSHdTcGE5amVSdGVFc0g0Z1dzdWEvZUJ2eWxqalZZ?=
 =?utf-8?B?dFB5WmdkM3IxZStBTCtST3dwTjdpaVhvWUFJNXlNTS83enZjUjhTaGVwa29B?=
 =?utf-8?Q?hhnnX8Fx8yvHQzGjjQV+Ac/0K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c4cbcb5-6025-4f18-b488-08db0383247d
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 12:03:19.3530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n1RsqPTk7DUt0bsZw94DHIB3RB9GYsyEDmtz9v74HXQcVqr71sfuiV4cR7bubCEK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7037
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/01/2023 22:30, Si-Wei Liu wrote:
> The spec says:
>      status only exists if VIRTIO_NET_F_STATUS is set
>
> Similar to MAC and MTU, vdpa_dev_net_config_fill() should read
> STATUS conditionally depending on the feature bits.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Reviewed-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vdpa/vdpa.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 5e57935..5f4883b 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -848,18 +848,25 @@ static int vdpa_dev_net_mac_config_fill(struct sk_buff *msg, u64 features,
>   			sizeof(config->mac), config->mac);
>   }
>   
> +static int vdpa_dev_net_status_config_fill(struct sk_buff *msg, u64 features,
> +					   const struct virtio_net_config *config)
> +{
> +	u16 val_u16;
> +
> +	if ((features & BIT_ULL(VIRTIO_NET_F_STATUS)) == 0)
> +		return 0;
> +
> +	val_u16 = __virtio16_to_cpu(true, config->status);
> +	return nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16);
> +}
> +
>   static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *msg)
>   {
>   	struct virtio_net_config config = {};
>   	u64 features_device;
> -	u16 val_u16;
>   
>   	vdev->config->get_config(vdev, 0, &config, sizeof(config));
>   
> -	val_u16 = __virtio16_to_cpu(true, config.status);
> -	if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16))
> -		return -EMSGSIZE;
> -
>   	features_device = vdev->config->get_device_features(vdev);
>   
>   	if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_FEATURES, features_device,
> @@ -872,6 +879,9 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>   	if (vdpa_dev_net_mac_config_fill(msg, features_device, &config))
>   		return -EMSGSIZE;
>   
> +	if (vdpa_dev_net_status_config_fill(msg, features_device, &config))
> +		return -EMSGSIZE;
> +
>   	return vdpa_dev_net_mq_config_fill(msg, features_device, &config);
>   }
>   
