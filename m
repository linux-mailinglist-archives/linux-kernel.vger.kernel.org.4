Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA84682D10
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjAaM5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjAaM4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:56:45 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09AFF4C0DC
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:56:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kC+3TUcVKxVI6cycSMISZPJxnby7RNhL8AKffqBVMtwaXwwnnrzZOukop+bQG52lkaeXVoogatBUgRWzkkrlcNDK66hBTugOO7xmdXfc4KWfYqd9t2WW9M1nMYN9BuZOQfD/aq8NrBLyRSQzOHI8M8COfyeO1/Gh/vzcChgm7hez5D7g4FByz8YEpEPrhamkVmUQBNiw4WifYIBqnyk2xHphIwlIpO9Jallh4J9dhWVCUWkSYCKJsqn2UnvdKmAJXXgknypHRdtPkBPfUmoqNfBxqclkPsyBn5wK0wVyXcUmhYnxExL1PfZt2BCZZ3stNRy1OJ5Ism99ugeGa6KuBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9vX97l+BetjArX9E/ChQpr5Zt87hs1Y634H+z7iOTo=;
 b=aio7LD+zjpgjTfQcNrQYFQ0Mgock/cRNfvvLtjxPZ2XYWiORKRbzvw08gUJdai4So+/pouC2pvO60rF0lkeoxItTUM5EWrWYHAmEJZ73gHJzd+PU7Mv6KDTt1iXSQbPo2KQL4Im532hqVXyraBOqU1QKY20OEMI4ECCgktAg/CcHYTSbqEUf2RhHs3OZ6GxtOjnUFx8iBHkPCyUmnAaMFyfKrSIw8hfh3VYzxgkhED6Sh9quIUbxONnM1Sml9L0w9xFNKzFrBuhv64q0Corv81pGRB6SIU1Zi7slU725Li9giqtaH9MSB0FSxufFZp1aIlk0lxuVhUrQGJ3N1ZHw5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9vX97l+BetjArX9E/ChQpr5Zt87hs1Y634H+z7iOTo=;
 b=A7OJPsXku8D5C5xwmBpcvs9wXxA74+3Wd3NgYBMLhyc6ycw1nNDIBCFajG25yn8jFkqRms++/VgZtsjoTMGlp5iSOAB3AvlhHJ/K0WBdzcUpxewtpRixd0cBqshW8qYVDx5CFHHMibDqO5fO/ZdtSdFRcCHEX2HdyzWnfuGH+JR7tTEWVU0797sIVhQicVxKKZ9JvT+hiKyQqsTM8iNT5LboORY7lD91ct5YvtL7zpownlb7CCKQMlgfP+PbTHmzSwWkFKYp6dP5adgwI/QaPgrZxeZ2QMXOGMYu6/+8+8PEXLSgHbH3Xruzira/LLowI2g5Omx9c4T0IWbOqMTWZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 DM4PR12MB7719.namprd12.prod.outlook.com (2603:10b6:8:101::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.36; Tue, 31 Jan 2023 12:56:42 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::9344:d2ae:739a:a358]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::9344:d2ae:739a:a358%7]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 12:56:42 +0000
Message-ID: <0b1f2898-e49d-9cb5-2913-382c9a04170f@nvidia.com>
Date:   Tue, 31 Jan 2023 14:56:34 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 6/6] vdpa/mlx5: support device features provisioning
Content-Language: en-US
To:     Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com,
        jasowang@redhat.com, parav@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1675110643-28143-1-git-send-email-si-wei.liu@oracle.com>
 <1675110643-28143-7-git-send-email-si-wei.liu@oracle.com>
From:   Eli Cohen <elic@nvidia.com>
In-Reply-To: <1675110643-28143-7-git-send-email-si-wei.liu@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0060.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::20) To DM8PR12MB5400.namprd12.prod.outlook.com
 (2603:10b6:8:3b::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5400:EE_|DM4PR12MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bb68550-0c6d-4d4d-6d0f-08db038a99af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m4dqZKM+QOVtdxsAy9uCGeQ5yskxk9C1lFLY74c+LAmL0oDVizUQ0InLWPtcJlibTpqjeOvSO2G5+0ts5YmdPnNLsS0vktRgN9QjPSlyVYaqrhjNgV2h3pI8k0sZSTeaiElTZr/0SZasYERunFNehkwSQnCwsS1XndGcvlOpFTKrxfeqzPKgETb4OyYHDl3tlXg6VF66oX3TwlJFUS3sfT6h2whd+0MNi0dC7UaebJ8akpRO7EXyWsZRhUjOVnuKAqiski4oCfIDvG9QwiG+7TvJN5DczlNHFgY5j01aE6523tBQNCMqZg13fjCMaR2ANdY2J+0QTN5n2TWcQCj9hrNwW9yjKU3qJHCGq5+kM+kzygKu9D+JbELa5cp+yidOUNh1kgwSqV/F+ddEMHgG2k4U9zp7kpgqahIXsY6/YCLIm35fBiFXLUazjYVTmPt2B+VkQdWPnmA47tUROCBlqxBltIh+qVIppVmsL3GWuH7G8ab0lfEBDOhjHrD/bWOePWcX8DkQEV0YjktAQj0aZbWydwqbZe/66osJgPTCg7xhslqsN6WBFxRimjnU/SSH++v1JknNvR7fLpHNGQ4REjKNhDv+3rrIn5KD9f/cRHSk32wLGNSvqMyHTVG7sKWaFYBIGMb8Z0YBqew/E6eVMaujN8wsWpuK9UYYVzomSQN1l+IBrgRxdAUsl/q8gKaxCfkYEHwNMfI4pAEBE/NczR99CyNv3geJ8NfGB7F7mT0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199018)(36756003)(5660300002)(2906002)(38100700002)(31686004)(2616005)(6486002)(6512007)(478600001)(6506007)(53546011)(26005)(31696002)(186003)(86362001)(83380400001)(6636002)(8676002)(66556008)(4326008)(6666004)(66946007)(66476007)(8936002)(316002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVErVmQvVFptNHUzMHNDMWg4N2ZsRm5qVi9IcW0vNHN5UGxjSkd2WlRTNERH?=
 =?utf-8?B?em50aStIWVFEUnBjdStpa2lKYnU4c1BMbklTTVRrM3U2dkZTbUZrN0FFYmF5?=
 =?utf-8?B?ZE8vYUIycDZoK0JzTXpyT2V1cTRuUUxnclJycXpOaWExN2RLenArZnR3Um9q?=
 =?utf-8?B?VWhYSHBVQlpNeEI4c3RXMnNnNnljQTR5NmNjaENpekxkelE2WXZKM0w1bzli?=
 =?utf-8?B?U2pQSEcrbWw0SDRIUTBQc283NlJBWHQ2UjR3bjdsN2dmbWNrbTkybU8zejg1?=
 =?utf-8?B?TStPODlaeTNHRHpsaEtmYVdOay92NW5TR0pReVNyS3ljdGY2K2xvU0lwOEpp?=
 =?utf-8?B?V2xkemd3VlUwM1NlZ25SeVNuYkNaa1REdnJTTTN4VUM2TzhoNHVtTi94L0V1?=
 =?utf-8?B?elN5d09vaUdZZWowYTlHOEhDN2pETjFPUU9hTU1tbnp0UXgzWlluZ3JUU1pL?=
 =?utf-8?B?amEvMXJJWENvWmo5aXZaMythYnFUeS9Zd1V2c2RhK2cvekZtUk1lNDNUbUhM?=
 =?utf-8?B?ZHFXMlUwSytYc29mdGxwWldJeUZmdldhZEtPU2llVVRsSStqTk94eHVKMzFa?=
 =?utf-8?B?cnFiNVZWTjN3MzkyWVNkNG4zaFdWSk5oZlZBdjZ0dmZNM3VuV2g1dkNYQjdF?=
 =?utf-8?B?M0tWRE5tbnBhaXhaM09hYS9zNSs0a3pGQ3lJMGJCbGx2bTVweXVRNEhVbStP?=
 =?utf-8?B?bXhUZU5YeFRDV3NYZG8yWXVTSGRoeG1YU094R1Vad0Q4cFlYV09yc2U5Misw?=
 =?utf-8?B?dzFhVkxnQ0JidG4rb2xpTmRZUkhVTjZQMnJGcW45cWIvNWM2YmU3dmlWYUU3?=
 =?utf-8?B?eFQ4SFpGdmNqVm0wUm1RL1VsamVoMjZrYW0wQ3JrME12YWppWlkwanQwYmJW?=
 =?utf-8?B?YWNxZlVVNkxiRXk2alFHWEZOSjRoZ0t0MjEwbGZGK3l3aXlLYWttMktlc1Mz?=
 =?utf-8?B?dWl6Qzg3NHAzVS9IbS9Rd1krQ3YzQS9tNWhSUFl3NjNxcU5SZEJrb1VPdW5i?=
 =?utf-8?B?VW9PQ1dvMzEvbFVxaDArS0tKL2xtY1NDS0FmMEJXTE5aTVlGMXk3ZTBRSUtJ?=
 =?utf-8?B?dC9uSWRwQWpTYU10VnkzNGprQU5ueVJhT2pGWG9pS0JQQ1JKSEVCa0tlVGd4?=
 =?utf-8?B?T0ozL0FhY3BONng4QVhORWsxM3pVMzBQV1FFb0RxVDVtM21Oam03WG5YZHdU?=
 =?utf-8?B?Q213L0lJWUx2TDJVY3F3VytTOVppM2RaSld0QXdseTFqSnNyS0ZabmkvZC85?=
 =?utf-8?B?WHR3bVZJRUNlYjVzdnd2dER2dDkxZytnelROaGE2OHVJRitadTU0N29GeG94?=
 =?utf-8?B?eUtDbU0vR3hRNVVtQXE5bElwTXJBUDd4QUFpMlA0S0xmU0VrbjZNZkthSlo1?=
 =?utf-8?B?cU9hWlkwaVVFSHk3dERma3J6SFd5bWpHaUN5WUFoMnlid2FsVEVEd0Zzdi8r?=
 =?utf-8?B?TjY3V1Z2Y3Z1Vnkrb2hId3ZvVUhXRS84akJpV3BkMnd0bjUvQUlxcElMZWhG?=
 =?utf-8?B?MGR1c3AzSkhjeFgva3BvVTBiaFpHWDkwZGx4VFJQU1FSMDBTZGNvL0NWQ2VE?=
 =?utf-8?B?SU5jL0prYm1VSzlPdHVvT3VEdWdVYldDSmFQQ215Rm51VVFDQWtQaXVvbXlt?=
 =?utf-8?B?UXdqWWpXWWoxRG9NQ0tkaDBYN2NvcE0xd2QwTUpBZnlONlRkTXEvVlVEaGVh?=
 =?utf-8?B?ZUVKWUxMSzFhb3Y1d2l1NEVBSWtYYW9RM3BCd2N6NDJsZnZVcXV1eWlHa2pV?=
 =?utf-8?B?WnFmWHlWQ3B6TlVTbUJVSTdQK0FSUlJOR3hFbXY4OHEvUHRVZTQrRzFybTQy?=
 =?utf-8?B?QzV3ZkdFeVNmQVRrNVo3cjhpejFHQUllZURaM29kU09WZzJaOFpxUUR2R0V5?=
 =?utf-8?B?b0FZRm50UU9MMWQrUlNWTWpPRkNsSmFCQkhVVytSLzNPdThnYlprSU9ZY1Q0?=
 =?utf-8?B?NzBQMHJsa29FWEhGVDdIVkl2T3lwUi85cWhiWUFuNzhJRjZVMVV4TlJMeHNY?=
 =?utf-8?B?a0tlVzBDVnpQVkFpREVReDkzM3BPS1lxUHEvU0toc0VnN3FwSy8rMW5tUDR6?=
 =?utf-8?B?bmNiNkh1b1FjVU55dGhzc25WRG9JUjdXN2Y2SlJYc3JXQmpRVzNhQTVVQnNS?=
 =?utf-8?Q?RI5sHgDDlI59mAQ61aqaTEygp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb68550-0c6d-4d4d-6d0f-08db038a99af
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 12:56:42.4805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIz9OqxUVLmJdPNCmiXTstv29qffWOvjtjMmyKk2A+EoVkneW4RkbCAYBtqCbmsA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7719
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
> This patch implements features provisioning for mlx5_vdpa.
>
> 1) Validate the provisioned features are a subset of the parent
>     features.
> 2) Clearing features that are not wanted by userspace.
> 3) Set config space field only when the corresponding feature is
>     provisioned.
>
> For example:
>
>     # vdpa mgmtdev show
>     pci/0000:41:04.2:
>       supported_classes net
>       max_supported_vqs 65
>       dev_features CSUM GUEST_CSUM MTU MAC HOST_TSO4 HOST_TSO6 STATUS CTRL_VQ CTRL_VLAN MQ CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM
>
> 1) Provision vDPA device with all features derived from the parent
>
>     # vdpa dev add name vdpa1 mgmtdev pci/0000:41:04.2
>     # vdpa dev config show
>     vdpa1: mac e4:11:c6:d3:45:f0 link up link_announce false max_vq_pairs 1 mtu 1500
>       negotiated_features CSUM GUEST_CSUM MTU HOST_TSO4 HOST_TSO6 STATUS CTRL_VQ CTRL_VLAN MQ CTRL_MAC_ADDR VERSION_1 ACCESS_PLATFORM
>
> 2) Provision vDPA device with a subset of parent features
>
>     # vdpa dev add name vdpa1 mgmtdev pci/0000:41:04.2 device_features 0x300020000
>     # vdpa dev config show
>     vdpa1:
>       negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 72 +++++++++++++++++++++++++++++++--------
>   1 file changed, 58 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 3a6dbbc6..5d6dfd2 100644
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
> @@ -3009,6 +3010,8 @@ static int event_handler(struct notifier_block *nb, unsigned long event, void *p
>   	struct mlx5_vdpa_wq_ent *wqent;
>   
>   	if (event == MLX5_EVENT_TYPE_PORT_CHANGE) {
> +		if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_STATUS)))
> +			return NOTIFY_DONE;
Does not belong in this patch
>   		switch (eqe->sub_type) {
>   		case MLX5_PORT_CHANGE_SUBTYPE_DOWN:
>   		case MLX5_PORT_CHANGE_SUBTYPE_ACTIVE:
> @@ -3060,6 +3063,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>   	struct mlx5_vdpa_dev *mvdev;
>   	struct mlx5_vdpa_net *ndev;
>   	struct mlx5_core_dev *mdev;
> +	u64 device_features;
>   	u32 max_vqs;
>   	u16 mtu;
>   	int err;
> @@ -3068,6 +3072,25 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
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
> +	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES) &&
This looks redundant.
> +	    !(device_features & BIT_ULL(VIRTIO_F_VERSION_1) &&
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
> @@ -3096,7 +3119,6 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>   	if (IS_ERR(ndev))
>   		return PTR_ERR(ndev);
>   
> -	ndev->mvdev.mlx_features = mgtdev->mgtdev.supported_features;
>   	ndev->mvdev.max_vqs = max_vqs;
>   	mvdev = &ndev->mvdev;
>   	mvdev->mdev = mdev;
> @@ -3118,20 +3140,26 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>   			goto err_alloc;
>   	}
>   
> -	err = query_mtu(mdev, &mtu);
> -	if (err)
> -		goto err_alloc;
> +	if (device_features & BIT_ULL(VIRTIO_NET_F_MTU)) {
> +		err = query_mtu(mdev, &mtu);
> +		if (err)
> +			goto err_alloc;
>   
> -	ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
> +		ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
> +	}
>   
> -	if (get_link_state(mvdev))
> -		ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
> -	else
> -		ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, ~VIRTIO_NET_S_LINK_UP);
> +	if (device_features & BIT_ULL(VIRTIO_NET_F_STATUS)) {
> +		if (get_link_state(mvdev))
> +			ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
> +		else
> +			ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, ~VIRTIO_NET_S_LINK_UP);
> +	}
Doesn't belong in this patch
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
> @@ -3142,11 +3170,26 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
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
> @@ -3243,7 +3286,8 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>   	mgtdev->mgtdev.id_table = id_table;
>   	mgtdev->mgtdev.config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR) |
>   					  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP) |
> -					  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU);
> +					  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU) |
> +					  BIT_ULL(VDPA_ATTR_DEV_FEATURES);
>   	mgtdev->mgtdev.max_supported_vqs =
>   		MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues) + 1;
>   	mgtdev->mgtdev.supported_features = get_supported_features(mdev);
