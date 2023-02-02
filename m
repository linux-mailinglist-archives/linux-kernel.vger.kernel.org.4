Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39168687EB2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 14:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjBBNbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 08:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjBBNbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 08:31:36 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1F23A9E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 05:31:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDeJMo82H/JuVl6vLvg+JKTjGLW7WgZeiFgKEwu157i5r0RWaJZ0seSR08VlP3PCjk71ruY1Uk9OO63/6Pr2p0ZkIn2sIX2Z6WjRQAr32yq3x+6MYfliK7gZpw0EnBMqgxYroTgraKo4k1xUTVMS2Hs9LUbhjuv+UNq+6uBUtmndqe1YGOMfmH0LhI4I7yApWT2UaZsohaJftEujJ23b6VMQnQKxRNPKZyyVV/dqPX6sw3tStaFZeHQjvw9tQ6gQlAeeFF2XimI0OfYh7jRK6QT4m6e1O4gTB8tEZv1F5bfqdvkHKO3gnUVNzNak229mLeeN1MkolCs/xNiUvPDEiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/mehXrFZAfedT4M9rIy3Ng30uajTj4+54EQj0tSE0c=;
 b=dNoZ1yyD9VUHBT4LKkDWsmTp397/r2ob9u81c1RSN14+0ALWZfyoNJ41PvimgylBsf78sTPYIOazbHuEdU4vWRkwvkXsvAbe99a5jVL/skiCOpCZYArTQZezfnvaNlYa6YXq3OvdXae3zpwJkVVudxRBr4W3YRQ6raxvXQGI3tjh6ae0uiZf5vbxruXYTRZ9Z2Oo7I5Mi2wxX7vdTa4sCPBxKpeEQ95uBg3mccGCzRscj+TXfCTHJdbk9EO5hepHDBEMNZmruo/PGtu/5YC+M/oy5eebzQmbNsw1ihka4XoiqWhAudnv+COE87fP9x6Ml9+PT0zPfxiYXi2rt/5HYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/mehXrFZAfedT4M9rIy3Ng30uajTj4+54EQj0tSE0c=;
 b=K0LXkM52RKoVNBnUVQhCrPkMOJ6cB8m5+dBoEBHiDAxAf/9Sk4+GjzTXREeV4QG7sJZDaFZvi7nOzqRLoXXX1MzL9LbDlgHn+L61/l1PJtntAx1+LkoxMXLA3u3fP5hI/cqJdGihd5bkTjxp5s/h73wJEGIJmWDWw30ANEb/gykhne1xIuvtb4N+wbGklfKX/MQ7YLclTjjLH7j7lIaqmsCKLgnrN34IcX6rVppj7hkUQ+YBPv+7uqpTjn5j6omf72CFLO0U5AIaOYrm/iMOUIX/0n4xbTgMJtPHim4pBpUo8b2H6ISLjcqXvziB0Rys1TrMouHrEETQj2g5vXZtUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 SA1PR12MB7245.namprd12.prod.outlook.com (2603:10b6:806:2bf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Thu, 2 Feb
 2023 13:31:33 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::9344:d2ae:739a:a358]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::9344:d2ae:739a:a358%8]) with mapi id 15.20.6064.025; Thu, 2 Feb 2023
 13:31:33 +0000
Message-ID: <bad92641-e10e-cb06-179d-2f4bc11c721d@nvidia.com>
Date:   Thu, 2 Feb 2023 15:31:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 6/7] vdpa/mlx5: conditionally show MTU and STATUS in
 config space
Content-Language: en-US
To:     Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com,
        jasowang@redhat.com, parav@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1675207345-22328-1-git-send-email-si-wei.liu@oracle.com>
 <1675207345-22328-7-git-send-email-si-wei.liu@oracle.com>
From:   Eli Cohen <elic@nvidia.com>
In-Reply-To: <1675207345-22328-7-git-send-email-si-wei.liu@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0021.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::11) To DM8PR12MB5400.namprd12.prod.outlook.com
 (2603:10b6:8:3b::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5400:EE_|SA1PR12MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bd0db1c-175e-42f7-af4c-08db0521cd16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gISlVNnB2dRgnmxjs2wD5VFO7z6eTQfOyFhGg40xWXMlOATXg+Dk22yX79/zbu8YRP3eb11WdGFb0UxQ/WsAd4mhlNNe5PXmbIFZF0a8PWB0f452EmQTnFKw6YdL564wuF48/+QV/f8BAEDkWwuxEGpWA3XxOuiHjgWfUyhNoz/85ETVvjMyWCswjkPmPPs4DlBd3zvSSatT29iGM4SVlH08kdQQQoXx423qX5P9vBJrRNL5x4dOuGiXEzrRwG/rksuVSYdiIgFIHVpSJobdba/vcNCRauWqXzEfqEc23XcuJArzhZhcGFkHTitWEC2zyyngK+AbR8knove/0wu5rUBtvsb7Ni6o8KCTkFZzXWtajDzPJosgxImIdKvAFRwLIZOOHpQu4EmwwwDFdPoi90T+CFP2NTAm7MdyL1hBuYJaA4/7wHIdrEpdRaC1M6iiWoPwcSMv3bN0m+rcUbo7CofjMDyz1kAE9sFLIsmqixNtEoR4ScsppggJzgX7g8h/OP7njjSRczjLY8c8OnCsLXu8rPIeowZbcvYv09LGZeye2VDla/4rzH28lB7gHlhZQLTxsiCtoHeO4Dbp4A2xQMyyKchfX/H0xcUHuq/am91HOU3Q4o42as+sPEIensvAN0ppyhooD5A5lgaCKoXohmniZ2Sg7bg46Yb5MBMH2XJ98naAbPi8WlbdOCaENVupQRSMO38UJHOyUQw10gMrSYrXp724wqGWY8eIZWuZhwU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199018)(31696002)(36756003)(38100700002)(86362001)(66946007)(8676002)(6486002)(66476007)(66556008)(6636002)(41300700001)(8936002)(5660300002)(2906002)(478600001)(316002)(4326008)(53546011)(186003)(6506007)(26005)(6512007)(6666004)(83380400001)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHp5TjdOQ0U0L2g3eUNpdnQxMmJSc0h4Vk42bXNmdUMvc3J3NW1sNnVDK09E?=
 =?utf-8?B?RjA2bGYxMjVHL1hYVHE5NWNWdHpLOUxvUk96SmQ2MVh5ME51SU13U3RMVWVB?=
 =?utf-8?B?YUZlYW42RDhKaHZ5VzRBc29kZ1JidXIvT213MEN0eHhXY0pZSk5IcSt0L2sy?=
 =?utf-8?B?SGEvWDZ3eE1ocDFXM2Q1RStlUGFqZ2wwRHRjRmY2b3lnZXVTTUsrYisxNnNG?=
 =?utf-8?B?UFBtenFEREZXR3VBclc5QUpRUUtVUmEzK1hOblRBbG1HOUZjdW5SK0hOcE5p?=
 =?utf-8?B?dG01YVhiajhGYXZzcDJxU0t4b1V1Ymt0RFVvZ3RzaWpIUGhkVDF1TWlWY3Fq?=
 =?utf-8?B?TUtQb3lSem1VVWlIUW9vUU8zaGJrK0tnM1M1bFhDMjlRSThETzFSTWJzSmtF?=
 =?utf-8?B?TVY5L3k4SzA5R2hKZU1jUDIyZ0lteXNFajVkREdPY09nODZqaXY5NEJiVTA1?=
 =?utf-8?B?QWVPRFBsUm5rVWFpRi9xcTBJdnJuYmtJQ0xsM2IycUZTdGRqcUZJU0ZnQ1V2?=
 =?utf-8?B?WUFEQjJhMmhjMzZmcS9MUk5JZFVyN3pRd1d1Z3N1VWphOHRpd1FadDlsTllp?=
 =?utf-8?B?cERHcnpsLy9BOVRSN1lJa2IvNjZCaGFIemNSOGc5RGhjRmZIQmpVc1VCbjha?=
 =?utf-8?B?QVVRZG8rQWh3L1lUMEFnQWpxSXRDRFF3TmJkTGZtNlFSQngxVHhGZ0NjMzlB?=
 =?utf-8?B?bTJvZlVYMkI0d0p4TUlpQ3QyR2loK1lzbTdWdzE5SHpDUmMzaHNhc204Mmh1?=
 =?utf-8?B?RUlFdDM4ZDVjNk9lbTQ3VGRadVZXMDBrcUNESTR2Z0ZTYUx2cXQwQzQrVWQw?=
 =?utf-8?B?TUVwREU1dldHWWVqUEF6NE9nVGM5akFVYVQxTXlTaHcvV0k0RzBERGl3TW5T?=
 =?utf-8?B?YU1aZ3Azc1RxbzdKclJOMUlZRytERDh2VU9qNjBGc2o1ZkJqb0RQUmI4NlFF?=
 =?utf-8?B?dFZVN2ZMUmF0aUZpN3Y2UWRiUXJJeUdOSWFWZTQ1NW9ZUzY1WWFuSDUvM09x?=
 =?utf-8?B?Ykc4US81SDRMc1VHd2xBMjlvL1NOVDlNYnRTY1d1S1BGOUxFYXM3bUloMnJ3?=
 =?utf-8?B?TWNiOVZmRDV2eTdoc2dqVCt0aXA3TWNlZGNxWlAwSklGRHR0cndZa0g5Rk8r?=
 =?utf-8?B?c3N4TEg0ZXgrWmlVb01vandNZ09sUGNDVGplZGJaa3N1MU93ZklLVmpFR2tH?=
 =?utf-8?B?RkhVWjFmUVlUaElUcmZkb0pMUzB6MUNrOFAwNVZDRkFrVWtVbEEvWHg3TmRa?=
 =?utf-8?B?V0w2Y0lmVTMram95VkFpZXdXbnZQTXVSbkxEclV1QzloU1Z3S1N2VWpPQmFZ?=
 =?utf-8?B?NTJqeWtvSlFIeU56ZUY1cGJJaC82a0xOU2xkcWRVMWVBZE0vdnNtdXBJME5Y?=
 =?utf-8?B?emtVdHRKY1Bwck1ia0x5UTZ5SUZnRUMwSDBVQmJNUk0zYmNYS3ZQMjlEaXNs?=
 =?utf-8?B?Z1lIaGZVZTJ3QzRrSTlhMnNmMU5FSFlKRWZIS2NlcDVHcitnVzFUemx1RTg2?=
 =?utf-8?B?bmNlaHd3L1JzVHpiQmxmVS9lWGJNRnZlL0xUdXpJZ3VnOW14a1JCMC9WYVI1?=
 =?utf-8?B?M3ZHa0c0WStoQlAwTUI2SW5EZEVvT0JydVpuOC9yMldWS2NPZ2RnTTVoa2Vj?=
 =?utf-8?B?VmtEN3pOamoxbWdEWTUyR1ZKZkVuencvOTV0dmlQaFFON2o0bFpSNEJvemVU?=
 =?utf-8?B?RHFKcUZ3RUhTWTdVOFBEWlVuUzc5Vjl6azBmUzdScXNHYUNMTVlUT1VkcFQx?=
 =?utf-8?B?RFNkSm9xWVhoMExySURoUVRmeHFoVDlsSjNlRURtR2wxRStDNGE1M3pOdHFv?=
 =?utf-8?B?ekFFUjdrcXpyM2hVN0Vqdjh2Y0lDWUY4Y29lZFJoZDhXYXpzS3loaUxudzJ0?=
 =?utf-8?B?UjNGUTdTYko3anFEMzlmWHFIVW10N05zRnlOL3FIb3JwRVo5djdvVHQyU25q?=
 =?utf-8?B?RlBBamlBaDlPd1pncGdML3hxODdLa3ZMZW53NWUzNWRKeGhvK3BPUlVkN3Iv?=
 =?utf-8?B?R3ZlM3RmenRVekxVZ09DT2NrMGUzR1hRSThORzVxYzR5VFZrRFg4UldFQTkv?=
 =?utf-8?B?eDhycTg0a0FvWHNZbWRmelVyVWZmckJycGtodUY0OHNJZnNHcEhCM0UxYk92?=
 =?utf-8?Q?+FZNXFF8xMcKsP7x+Ve5Xk3E7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bd0db1c-175e-42f7-af4c-08db0521cd16
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 13:31:33.8432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M5h3EH2rIEnFF9K5CFZ3qwXDQlVBM/gVEHcNrxIpd0Av7VlpE/NdbA15JvnHekbm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7245
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/02/2023 1:22, Si-Wei Liu wrote:
> The spec says:
>      mtu only exists if VIRTIO_NET_F_MTU is set
>      status only exists if VIRTIO_NET_F_STATUS is set
>
> We should only show MTU and STATUS conditionally depending on
> the feature bits.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 22 ++++++++++++++--------
>   1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 3a6dbbc6..3d49eae 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3009,6 +3009,8 @@ static int event_handler(struct notifier_block *nb, unsigned long event, void *p
>   	struct mlx5_vdpa_wq_ent *wqent;
>   
>   	if (event == MLX5_EVENT_TYPE_PORT_CHANGE) {
> +		if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_STATUS)))
> +			return NOTIFY_DONE;
>   		switch (eqe->sub_type) {
>   		case MLX5_PORT_CHANGE_SUBTYPE_DOWN:
>   		case MLX5_PORT_CHANGE_SUBTYPE_ACTIVE:
> @@ -3118,16 +3120,20 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
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
device_features is not defined as a local variable. It is defined in the 
next patch.
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
>   
>   	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
>   		memcpy(ndev->config.mac, add_config->net.mac, ETH_ALEN);
