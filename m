Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2869468B5DA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 07:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjBFGxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 01:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjBFGxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 01:53:23 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF24126ED
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 22:53:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0crDC8TtlzxiDMj1t6ntXFi1gQsSBsBep8odsdDwf+8zJ+JZJ6j3Xgm6+gY9+VtRpPEwl+/S84asumjvD8Pvwim0sD0KMGs+9paLrdelacW9TSaHF6hdkV6K73I5VyLvqHmufaXE8BiFJXhPH+v1PdFS+NUD2xYSPS/zEhM9M82nSBJButmzgH1OjcclFn7l06v6ZZI04YT2A1Kpavh1tllduaEF3orl8kF9Upr8DzI7i0GjOJXEciwtSTiovE4G+TZsRHaMGHqEDKulQiRbh67UhyRmNys2AyMBadLfgRF38ZUHSitlIMyHyairllJTrKHnI2+DkhNYT+AzUmNXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDI8FPK7hrN3JlC4HFlR7tBP31tZW6VS1mA6yJhARBs=;
 b=TOVBsDeT7+imv7vQd2uSXmYKFzXSrsQ7vf5Y/RoB6llN9eyLO9giLZNWDEwD5Dj044oW8FWAzceOzh6UpEBScD095OR74kYroOhK7A6W6a/4WB37Rki+dYzhIK99H9prfek+vwScA4aPYxOL+ERtTqYVhtK7muLw/xkZKCSQjML29yPAoErpDE5t6Og8C/wJal7jK4hoVBMGNkqqrByrRoJ36OvtXBS6syd0+26cY0/Dbyv7jWaO4bi4QssePifXuc0mRgRNH3dhTdZpHPQZQX79uR4m2WXCjI4ICz8gToi649botMW1e/Xu33um7fuFX7uIgK0npYAc1GZoBHolLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDI8FPK7hrN3JlC4HFlR7tBP31tZW6VS1mA6yJhARBs=;
 b=LFunkUsctJSAJ+Cj4sJ4P6Mcctl8jKbN+RqDoZT+QU7GfSNVRMH8bryDx+GkSEfbAN7DmzkSWJYv3cue87INpR+i4W54yRByy7waLaUAWIXcZXxePnGwdKyCGskKWxmIAUfKJz06taq4+L7FXReXTzl8zzkB6ycUTcBq+xDcU5sg8+VYaAc2MdldAn8Gqtyn7mwBUF1pKFRr8jozr3m98itDH2cnI5z+yzroWfRFPHoglPeGKWAtbH6NtD2OkMF8vt0t7QXEcZRwB87yx6FSTtEYudARUgTRJ4tLEYuYbUlnfon6m+Vc0EosSQ6VtkFyl1weTlss62PR2MulffUSmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 SA0PR12MB4574.namprd12.prod.outlook.com (2603:10b6:806:94::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.34; Mon, 6 Feb 2023 06:53:18 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::9344:d2ae:739a:a358]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::9344:d2ae:739a:a358%4]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 06:53:18 +0000
Message-ID: <c52bf774-2e5b-6704-2751-ca6cd5610669@nvidia.com>
Date:   Mon, 6 Feb 2023 08:53:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 6/6] vdpa/mlx5: support device features provisioning
Content-Language: en-US
To:     Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com,
        jasowang@redhat.com, parav@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1675400523-12519-1-git-send-email-si-wei.liu@oracle.com>
 <1675400523-12519-7-git-send-email-si-wei.liu@oracle.com>
From:   Eli Cohen <elic@nvidia.com>
In-Reply-To: <1675400523-12519-7-git-send-email-si-wei.liu@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0041.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::10) To DM8PR12MB5400.namprd12.prod.outlook.com
 (2603:10b6:8:3b::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5400:EE_|SA0PR12MB4574:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a9d6c4-8a96-4fc1-ea9a-08db080ed3e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gg21xzo+p26TxJUTlxMAgEUchBPN9QFDOx8OWcF09Ea7kXw1zJibUlHWqUEu0slxYmCAp+6kaOiRzyNK34wRPzI128c71crj1tjVlentTtTT3E7BXGDanI0FapCp7pSjcprf+on9Z4YEVyHl3PRd+MtbAd4rL+HcVpm6O8FDyyJzIg6379/i9vN0fHNBJAdrjEpO0vjomG0UlHTXnfttgCfEQsk7VpHhmkaLPwvovQpnIpeeafL6Ur8P1uXje6bVlIUGoQW3Lkpu/uVYGgQ8fWMG60ScDb9ELFKPsYSVHAI7tLV8yPs5OreSUJbcbz70xZUf2mHqZmEHm8NdcDx59l1UFZOkgaGPryPwYZhiMZnxm7D1/P/Rb38ouMG2JQjzjIHW1AwMN7lz+Cj4pgVpBsP3i0ahedrDlXFd3vt4BCAMHi99e3v6jIj5Zq8fEeLiuiqfy8K0kPAt+sptnu5zKcU37kfj4GDYqXBOovF/e1AQNdDNsfYLxzGKDTlXvzAzgieQfuQi2xwenhlf1egDBKG7FCwbP8CUE9zeH2/b/qPHmmeGf2tfmcuyZ1spOeUsJdD18htsACkVjGU6g7lmTorHK/kCZRoVdh12VxUxHU4Fjefh3qSOwQJWZnZLUrDajs36dUNLdrFMGmEWktypfrh8Ow9i1bu9M7LruXlTnUPqScScQddke9BHXUB1+9fy5gXEPROKJbt5nvPYsA0raHUTRDygY6iIPn5FgZd3920=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199018)(31686004)(2906002)(53546011)(36756003)(6506007)(5660300002)(8936002)(41300700001)(66556008)(8676002)(66476007)(66946007)(86362001)(31696002)(316002)(6636002)(478600001)(4326008)(38100700002)(6486002)(26005)(186003)(83380400001)(6512007)(6666004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUN6MlE2V2w4OGduNi9uZkJvZ1BXV0ZabHRyVWRjTmR5TCtZaUlNOXprd3Ux?=
 =?utf-8?B?Q0NKK0k2VDJzbStWZW1VNFhTRjFMaWxuWHR2VE5FdXpIeWFmb3JlRStkbjRC?=
 =?utf-8?B?ZTRMNGdwS0tFNUdtU1NDVHVQZUd0ZjhGd2JGdUdYQWJvaXBISXYrZlI3SU84?=
 =?utf-8?B?clRWM2RyTm1RcWtkejlDcGVEbGs4eGRaNWNmdExxNnNucjlMUEl5Nmw2ODhl?=
 =?utf-8?B?d2NUSkJDeTB3Y3NBUkcwUFJ3OWpqdzl6QkN5SEIzaVUvYjlIUUNvT3hSaXVu?=
 =?utf-8?B?RUNOeDZqVnhRSVFENUZ4c3QycTh4QmpFQ3VmODV2dExPMXVVT3F4VmhmaTZM?=
 =?utf-8?B?aGtweXZSclQ2Uko4dDluTDZEcTBOMzU5L2Z0eklqWXZ0Uzh1cEhMaFNLMjJh?=
 =?utf-8?B?TkhLRHJHVm5SNnhGTGpsNEVmVDl1QnJOczBiRjRHM2FmbEhQNnV4aHBFcElu?=
 =?utf-8?B?OHVjK013eCtXWGx5QTR0dFgwSjJPUUt6ZnlqdW9BN09KdWtPajl3dG5wUGY4?=
 =?utf-8?B?Yjl4RW91YzNPVjViOS9iM3RFNHBpNmY3cENCU1plb2s1UUVXcTFUbVd1b0VX?=
 =?utf-8?B?cTQybUpNaGk0SjV4SjhMclFFNkE3elJTNzFBdWZ1cWY3UmVBQmdIbVJjeTlK?=
 =?utf-8?B?aVNyK0dPOWZxUHU4SkhtaEVSYUNPYkIxZFZESEVGR0F3eVJKS0lHMGZ6M25w?=
 =?utf-8?B?T2ZaaGNjRU82QytjUHlpa0ZiVS9CNi8vZ1ROU0lWUkxRa2cwL3YwU3FFay8w?=
 =?utf-8?B?YXpQOXBMNzcxNUNpd05uZHRrSzFoWGl4K1lRcXlpRWVoTmVNU2EyU3BQcWNr?=
 =?utf-8?B?THd3MTNYbndRaHl1eEJXcis0S3g5WU13a3pjTmRGNGNHV0lIMEdFRTVtSDUy?=
 =?utf-8?B?QnNZTUMxcUNsMmpod0VFakVxV2xRQk54VWkvRGFqSVYvaXVBMjVrcXdTK1d2?=
 =?utf-8?B?Q3RtengwRjM2cEN1SWZXbzJldm9kOGRHcTUweWlyNWlSOFJRRThVMlZSaHZu?=
 =?utf-8?B?aXVqcFR2bFNwbVNsTDNkYThnUngwa3pYUlRTMUt6cE9DdzBFM2M0V1A0UUlo?=
 =?utf-8?B?K3FqZ0hnNlh3TFpqd0FMRnFlMHAwcGhuWEcrbURMdUZGSEIxZmlLMVl1RENG?=
 =?utf-8?B?V0p1UkxqQjh2WFZDdmxZZ0pyalJVQ1VDVjl3a2tXYTljV3hDNGNibFdSbmNB?=
 =?utf-8?B?d2l4bjhTeWhnVzNrSHRrUzlNdmZaMlhibU92TGJFVnRmUTZLSVkwUkdEc0Vq?=
 =?utf-8?B?cFYwSmQrOTY1WmZndkJGWVNwQnlhbDVGS09KYnYyZWszMm9DS3VrTFMweXgv?=
 =?utf-8?B?WmZ2N3NUUDhBUkgvM1U4Tmg4NUxEcUVJU1cycHhJZmMyNmU0RTVZbWhqUnFW?=
 =?utf-8?B?WEZJMjVRZERQeGRZSHJ4OXRSREs1SmZTRFpYTVdyeHN5WlNzQ1c3WVJ3ZlJB?=
 =?utf-8?B?VC9naVFkZkJrR3JqenA4TllCVElXZ2tXTWdyYXBBZmlvcDB6MDhTaFZLcUh2?=
 =?utf-8?B?UUJnbCt3OXhvNk1DRS8xZ3U2dFF1cXNUQmlBenhmNkhBclFoa2ptWFJBSFc1?=
 =?utf-8?B?bHQzWVZMSVdHZkd1U01HRitjdzRQaTFzcTNIY01LazBVK1JOdHZqdzA1SzdO?=
 =?utf-8?B?WmZwb2tXZThYU3VHYkZUM3hQQVRkNG52K0N1Y0Jyd2xhNFhSZktIOGJ2d2lp?=
 =?utf-8?B?SVphMGtrbFB6WUM4ZVV0MVV1NE1sSExtcjZEOGpjZkJ2S0FvN25VRkd4VDlO?=
 =?utf-8?B?ejlmSUVZMmhpK25xM0lnWng4T2FCcm9ibkZKWnFVclUwWHlZSlNMTGhaMVRI?=
 =?utf-8?B?VDJydGRkZEtQay96KytubmRwMEZhUm01dG9jdHlHYmg0REZFRkNHVld4aTJ0?=
 =?utf-8?B?ZUEvdmlOcGxveDFXckFsWEgzWDd6aUVpcENFNjdVd1ltZkFXVXVWb25mN21D?=
 =?utf-8?B?TE5rMmZacUhMZmhrSnJkeDRpbk1NUDlHdFA0ZURXeFo2Z2tKckxzTmJ4RCs2?=
 =?utf-8?B?Mk5HKzF3anJVNjZLeFk4VmhIZUszOFlNT00rSmtpVWkvRm91K0lVa3Fmdm5M?=
 =?utf-8?B?dURZMFl1SW1NQnAxMTlLckNOcDFQd2lvNitLakVxNjBwczdKU0lRN2xjanh6?=
 =?utf-8?Q?w3Uo5jnoNc4tL/8IWMt3B3AbB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a9d6c4-8a96-4fc1-ea9a-08db080ed3e5
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 06:53:18.3493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: syHLXPsbx083wGSnn6k/IlwBEEqNansM5TX99gtJRCvZ/P46HC5/MGlpcrNlTHMB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4574
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/02/2023 7:02, Si-Wei Liu wrote:
> This patch implements features provisioning for mlx5_vdpa.
>
> 1) Validate the provisioned features are a subset of the parent
>      features.
> 2) Clearing features that are not wanted by userspace.
>
> For example:
>
>      # vdpa mgmtdev show
>      pci/0000:41:04.2:
>        supported_classes net
>        max_supported_vqs 65
>        dev_features CSUM GUEST_CSUM MTU MAC HOST_TSO4 HOST_TSO6 STATUS CTRL_VQ CTRL_VLAN MQ CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM
>
> 1) Provision vDPA device with all features derived from the parent
>
>      # vdpa dev add name vdpa1 mgmtdev pci/0000:41:04.2
>      # vdpa dev config show
>      vdpa1: mac e4:11:c6:d3:45:f0 link up link_announce false max_vq_pairs 1 mtu 1500
>        negotiated_features CSUM GUEST_CSUM MTU HOST_TSO4 HOST_TSO6 STATUS CTRL_VQ CTRL_VLAN MQ CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM
>
> 2) Provision vDPA device with a subset of parent features
>
>      # vdpa dev add name vdpa1 mgmtdev pci/0000:41:04.2 device_features 0x300020000
>      # vdpa dev config show
>      vdpa1:
>        negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Reviewed-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 53 +++++++++++++++++++++++++++++++++------
>   1 file changed, 45 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 867ac18..b40dd1a 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2183,6 +2183,7 @@ static u64 get_supported_features(struct mlx5_core_dev *mdev)
>   	mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_STATUS);
>   	mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_MTU);
>   	mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_CTRL_VLAN);
> +	mlx_vdpa_features |= BIT_ULL(VIRTIO_NET_F_MAC);
>   
>   	return mlx_vdpa_features;
>   }
> @@ -3062,6 +3063,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>   	struct mlx5_vdpa_dev *mvdev;
>   	struct mlx5_vdpa_net *ndev;
>   	struct mlx5_core_dev *mdev;
> +	u64 device_features;
>   	u32 max_vqs;
>   	u16 mtu;
>   	int err;
> @@ -3070,6 +3072,24 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>   		return -ENOSPC;
>   
>   	mdev = mgtdev->madev->mdev;
> +	device_features = mgtdev->mgtdev.supported_features;
> +	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> +		if (add_config->device_features & ~device_features) {
> +			dev_warn(mdev->device,
> +				 "The provisioned features 0x%llx are not supported by this device with features 0x%llx\n",
> +				 add_config->device_features, device_features);
> +			return -EINVAL;
> +		}
> +		device_features &= add_config->device_features;
> +	}
> +	if (!(device_features & BIT_ULL(VIRTIO_F_VERSION_1) &&
> +	      device_features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM))) {
> +		dev_warn(mdev->device,
> +			 "Must provision minimum features 0x%llx for this device",
> +			 BIT_ULL(VIRTIO_F_VERSION_1) | BIT_ULL(VIRTIO_F_ACCESS_PLATFORM));
> +		return -EOPNOTSUPP;
> +	}
> +
>   	if (!(MLX5_CAP_DEV_VDPA_EMULATION(mdev, virtio_queue_type) &
>   	    MLX5_VIRTIO_EMULATION_CAP_VIRTIO_QUEUE_TYPE_SPLIT)) {
>   		dev_warn(mdev->device, "missing support for split virtqueues\n");
> @@ -3098,7 +3118,6 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>   	if (IS_ERR(ndev))
>   		return PTR_ERR(ndev);
>   
> -	ndev->mvdev.mlx_features = mgtdev->mgtdev.supported_features;
>   	ndev->mvdev.max_vqs = max_vqs;
>   	mvdev = &ndev->mvdev;
>   	mvdev->mdev = mdev;
> @@ -3120,7 +3139,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>   			goto err_alloc;
>   	}
>   
> -	if (ndev->mvdev.mlx_features & BIT_ULL(VIRTIO_NET_F_MTU)) {
> +	if (device_features & BIT_ULL(VIRTIO_NET_F_MTU)) {
>   		err = query_mtu(mdev, &mtu);
>   		if (err)
>   			goto err_alloc;
> @@ -3128,7 +3147,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>   		ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
>   	}
>   
> -	if (ndev->mvdev.mlx_features & BIT_ULL(VIRTIO_NET_F_STATUS)) {
> +	if (device_features & BIT_ULL(VIRTIO_NET_F_STATUS)) {
>   		if (get_link_state(mvdev))
>   			ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
>   		else
> @@ -3137,7 +3156,9 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>   
>   	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
>   		memcpy(ndev->config.mac, add_config->net.mac, ETH_ALEN);
> -	} else {
> +	/* No bother setting mac address in config if not going to provision _F_MAC */
> +	} else if ((add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) == 0 ||
> +		   device_features & BIT_ULL(VIRTIO_NET_F_MAC)) {
>   		err = mlx5_query_nic_vport_mac_address(mdev, 0, 0, config->mac);
>   		if (err)
>   			goto err_alloc;
> @@ -3148,11 +3169,26 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>   		err = mlx5_mpfs_add_mac(pfmdev, config->mac);
>   		if (err)
>   			goto err_alloc;
> -
> -		ndev->mvdev.mlx_features |= BIT_ULL(VIRTIO_NET_F_MAC);
> +	} else if ((add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) == 0) {
> +		/*
> +		 * We used to clear _F_MAC feature bit if seeing
> +		 * zero mac address when device features are not
> +		 * specifically provisioned. Keep the behaviour
> +		 * so old scripts do not break.
> +		 */
> +		device_features &= ~BIT_ULL(VIRTIO_NET_F_MAC);
> +	} else if (device_features & BIT_ULL(VIRTIO_NET_F_MAC)) {
> +		/* Don't provision zero mac address for _F_MAC */
> +		mlx5_vdpa_warn(&ndev->mvdev,
> +			       "No mac address provisioned?\n");
> +		err = -EINVAL;
> +		goto err_alloc;
>   	}
>   
> -	config->max_virtqueue_pairs = cpu_to_mlx5vdpa16(mvdev, max_vqs / 2);
> +	if (device_features & BIT_ULL(VIRTIO_NET_F_MQ))
> +		config->max_virtqueue_pairs = cpu_to_mlx5vdpa16(mvdev, max_vqs / 2);
> +
> +	ndev->mvdev.mlx_features = device_features;
>   	mvdev->vdev.dma_dev = &mdev->pdev->dev;
>   	err = mlx5_vdpa_alloc_resources(&ndev->mvdev);
>   	if (err)
> @@ -3249,7 +3285,8 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>   	mgtdev->mgtdev.id_table = id_table;
>   	mgtdev->mgtdev.config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR) |
>   					  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP) |
> -					  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU);
> +					  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU) |
> +					  BIT_ULL(VDPA_ATTR_DEV_FEATURES);
>   	mgtdev->mgtdev.max_supported_vqs =
>   		MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues) + 1;
>   	mgtdev->mgtdev.supported_features = get_supported_features(mdev);
