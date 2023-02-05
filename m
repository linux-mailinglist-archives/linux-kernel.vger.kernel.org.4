Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D79C68AF02
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 10:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjBEJgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 04:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBEJgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 04:36:44 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67B019F0E
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 01:36:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEXcPbL+d7hvcqb5IPKIu19bkG8hVtyyA6B4oF9C4aBGZGIE0/KxvPGztb+tWhodnANwOw5LmQ4hSczSZ7uf5pkCdbsTV2DOuDAQOtKy84Sw8HEo2+Vy1AyOwKQ3Crw1Ar0F0GVpRrxMHm8pN/s+EooRtw4xxvyU3RtIYfQYHCzjdoSKgUlBOffucfbSnO9iYvJ96hbu+APcdliz8WPuvbOz2Az7bUJIipzWVgGImecGf+1VFganPMoGh/jYHBE3xwZFCn8UnZkVlZuwfwmwnfg+SjKUTEHKA2J2+XBd6BRuWlCYx2AFM7Tnv1Rc5V0WiBZOnxVwzO9iCt4rEAkAkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RfkYh36RLPnom08w0YK4LYm/N/x2KaYto9Fnejk+B0=;
 b=ewDrpmMHWOm6G6tvF2zDuKVR6305hx7XMY1I7TOz+0q15LZRTWkpwzztKGzO4fCAFlYb7GwH7J2BPNANHX1L36dDK0zXxFWXebz54fR5YE5B84orPlHQ8TYojvpeXOLzfKB6Kk19qTgkXREjPdqtrrJu9iPZWkj7nPjc9D17bzZP8dTX3aGOaTUKrUh+o3/vrQ/t6gQWVZdWCl34NkXlq4hbzhTQT7q5jPQxtbO6eU91z6ng78JDqZKmbgrTTuNik+r4pKuX4cE2gQqQXZbWue98D2JUi8xC2tkWPYYXhGkVGOC7z0mDS0wRgtPVr+NbThN+KxkzvYUOiFjbJiMyVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RfkYh36RLPnom08w0YK4LYm/N/x2KaYto9Fnejk+B0=;
 b=r1zRwDzP+rSW7uksPeFkGAuc1bm11pgaC5I39XR/GtmsAs2NI3is/8JCjrXxQEqFfSYeM10Btb67mCT0PuSkOj2MSejL6HlgNcHjvniULeWi48jaXwWspeRBybRzX+lppz48mmXxOoi/8yDsKGxmBwd+tKINK8GcJY+OyXnMcTxyonHiO/VUUm/14mb2cZw0RNYTt94KILWRZMYdEEnOsmzipGycmz9lgkotmtXnJaKyMy44xe604x0g6d9KEyBj9rXZyojcHoX7v8ej+JgpoWArD1dM41xnrF0QHF8BZZ7DHj1oG9BEqK0/5cCe7nY1x4wMmtyifGrzgAJWAC/1ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB5401.namprd12.prod.outlook.com (2603:10b6:510:d4::13)
 by DS0PR12MB7605.namprd12.prod.outlook.com (2603:10b6:8:13d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29; Sun, 5 Feb
 2023 09:36:39 +0000
Received: from PH0PR12MB5401.namprd12.prod.outlook.com
 ([fe80::87e4:2a28:53f6:1b89]) by PH0PR12MB5401.namprd12.prod.outlook.com
 ([fe80::87e4:2a28:53f6:1b89%8]) with mapi id 15.20.6064.032; Sun, 5 Feb 2023
 09:36:39 +0000
Message-ID: <d6265719-a423-2798-4cd0-b4b57a34878b@nvidia.com>
Date:   Sun, 5 Feb 2023 11:36:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 5/6] vdpa/mlx5: conditionally show MTU and STATUS in
 config space
To:     Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com,
        jasowang@redhat.com, parav@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1675400523-12519-1-git-send-email-si-wei.liu@oracle.com>
 <1675400523-12519-6-git-send-email-si-wei.liu@oracle.com>
Content-Language: en-US
From:   Eli Cohen <elic@nvidia.com>
In-Reply-To: <1675400523-12519-6-git-send-email-si-wei.liu@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::11) To PH0PR12MB5401.namprd12.prod.outlook.com
 (2603:10b6:510:d4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB5401:EE_|DS0PR12MB7605:EE_
X-MS-Office365-Filtering-Correlation-Id: aa702b33-1f8c-4296-c9a2-08db075c7b7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gSGvolfMkZDrQguz4xIhWWTS145bt/ZK8HcEZg3ZppUajFXlAIjtpHJognEbN8/i4WKW0wZRUTtWskNXLTYicePHL2LD6Z9VBNMaEoB8Tbd6rcmqIIvajCxnYUggOAaiEZzuJ0+9CjP4lOwYBBEBgmmUcMX318RKXxJkMj32fr63Gc1+MQB/L5ymHeGO4QVpU6CqQOBVStHWwlJqAvuL7mUtxoRvWn2KBVqZfl11JzaRwbafAOQuyVTI1d4mWnFjssY91/0vcFpjr5DfUITl5vCNDsTbJg9Jfj7uxfL2Zdbu0yMYo1hg+im9xhBHtePRxLSY8zkxOKxqsSuZR1rcZ/O1OQm3eeSJTLJ8r+FzWyqiDQtik10f0xBqab51GpiZUVgIk6MKsuzsCe9TDI+c7PHCIUm7U2Lc3sOoiVM/NGKqICWu2jAji3SrqIH9cvpDkETgaGxQZTfOTt9mlUCyitJywQHdocRh956iomKPJ2glocbL79w+jwjLkETGy943n1FYfLUfdjgkS5sMPwlr31w2v8fRaBU+tA/XNEAtyIIS1JnT9M82UQoNxfTwtHJ0QsPXSCMbMoMS2q0/DWH8nLS641Hy6dH1I+7TMSi7YUsNg+00mIDBeTq8v55W00D1Oo5vc702ZoDE5GU8n4m8fL4mI+WVQg0wO+jDLl0qNG5cknKGoAeXg1PedBYOOLWr3ewQHVHg4Y4LAxI0Wmwi2dvZzx/VPixBhGnIue37LJI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199018)(66899018)(31686004)(6636002)(316002)(36756003)(31696002)(38100700002)(86362001)(26005)(83380400001)(53546011)(6506007)(2616005)(186003)(6512007)(6666004)(6486002)(8936002)(5660300002)(478600001)(2906002)(41300700001)(66476007)(66946007)(4326008)(66556008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emlyQ09KS0F3bDVLeDVUNTl0MFdob0JEOTVxR0hhMStpS0hPZFpQdHdlMnNF?=
 =?utf-8?B?b2N5eS8wWHk0dkhvUFhBeEV1TkFySzUvRFBWMG5CV2wzaFdVOUpuYVIwR1dS?=
 =?utf-8?B?dWhYVkFqNmpKdG44Y2xNaEhzaDViR1VwQ24vbXd3cnV3cEpIclkwa1R3Qjg1?=
 =?utf-8?B?RTRsWExEZmlKa1RQYm5QQkthVmF3eFcvWnltb2V6WWw3bXp1MHNpRjRkQ0Nu?=
 =?utf-8?B?ZWlrbDc2TWZIQ0VMMDFWcGM4VFNIMWRSQVhFMWhTSmlNdXd6Z3I3ajJheUc3?=
 =?utf-8?B?TVBlOHlSbFhJZ2VqaXBWOEs2VHEwZGFoV0Z0QkZPcjIrUkZIbmpWZUszQXZV?=
 =?utf-8?B?dDVKTCtMQStKaW1BL1ZUQlhadUhZSUVxbUZWakRyaG5MRCtTV0FwNTEvME5I?=
 =?utf-8?B?ckpoSlVrc3JqRU80M1lpeTc4eFd5VmJLc296a2RveFpCaGFmMFhYYlNlOHRy?=
 =?utf-8?B?a0F0bHJOVzc1YnZIK3ViQ08wRlNqc0dJK3RpVVIxTWdDUDRJUkJ6WG93eWh6?=
 =?utf-8?B?OVk4UUdsTytSa0pGcUxyemRCSVFpdnE0YzBXRU9rd203NkdTNkFGZ1p0UW9u?=
 =?utf-8?B?U0p3dGlnUnRZTXE2NUN2bTN2S0M0MXFDbm1jamt5RHJ3Zml2dTZ6UXI5dCtC?=
 =?utf-8?B?bXh0VktzdjV0UmpDbHJxSDhQblA4UkdXR2h2TXlWcGszVzVvMmRSWHh0WnNZ?=
 =?utf-8?B?YWszVzhMa0RTY1dQeXptL24wTVdoSXBSNGhMNFJrKytTWEVyUll6ZzhwdjdZ?=
 =?utf-8?B?Uk1vdVhPZ3MzMjd1dlRDNjF5d21ObzllR1FWMVg4ck9ZbnJZZkZ2dW4rQ0pN?=
 =?utf-8?B?MFFlQWUzQUhZSXZvNW9EZUZoKzJjREl6VE9TQ3l5aEJFRTdCa2hmSXNMSElr?=
 =?utf-8?B?Q0c3UVNTcE54VVRKSXBwNTRxRWFjeXI1a2NEZS9iNWgxYXN6ejZQTmIvS0V5?=
 =?utf-8?B?NzBxa09KZWJnNDNiR2hOcTRTY1BaZHpFYU8wci9xOFhXU0VaK3Z5TUJVY3Fr?=
 =?utf-8?B?eFRVdGo4TWJuOVlnSGZGc1ZrWUg1V3laR01jV1ptUmhUakFjZyttSHF3Y0dz?=
 =?utf-8?B?RUlyMGpHOWFnZS9tZzRzbXV4bFdRd3lXNm5adzdsNW1TSy9YeE1TTVBJamlz?=
 =?utf-8?B?MlNyOUViQ2hpaFQ2MGRMVzlRcFBoT1k0SEE1QXFKSUNwNVhxTEhqSDZjV0JH?=
 =?utf-8?B?WlRaVHI3RG43QjlZSk91bm9vMDlySkNWN21aMzFoUkNDa1plZ2N4MmVZNVNU?=
 =?utf-8?B?R3UrZ0xXdEw3ekNZbUFyUUtvc3g0anV3V0hucUNvVnpsZTFvNXZzMHJmM1Zh?=
 =?utf-8?B?U2NoNFUvWXNEZEZyTUlRQ29wdzhaZHpOZDJTTWR4UDJoZGpmbXVDb2V0U2d3?=
 =?utf-8?B?enMvZ0piZUdlaW1VckdUenhvcTdOYTEyUjYrWStCM3JRamNDVjN4ZlF2Tmg3?=
 =?utf-8?B?UVV1YkE2NVpSUHpKV0ZqcDhzSHNLZVhlRjU2NlB2Z25lYnlYV2l4THdIOGhH?=
 =?utf-8?B?dlZzR2ZnOHcrVHVYTnZVZ0ZsR0s2akZWczlWNmRFQmNVaVZ1SGZac0tlZWdT?=
 =?utf-8?B?WnVsV29iV3g2TlpqeGZpQXVKak4wVW9acFJQclNCQ2FNQTB2S095bWE5dWNy?=
 =?utf-8?B?TUFDV3haN0tyeVlMVXBJV2ZjRFV4SkQ3UkF3U1M0V0dkOFd0OEQ1ZGdwY0ZB?=
 =?utf-8?B?VTg5MjhhMUJFQS9DbXdqTnAzcFVNclFVWFNna3BEQVNaR012dThqcWx4Z0Y5?=
 =?utf-8?B?MzNDU1Q0UVNsUVZyb2F5UG41YzI0NVROVDlMUUJyVENCZzVnbWJNd1VBOFBh?=
 =?utf-8?B?Ty9zQUFzZ1pvRENTTkVLWC81dmRNcjhieDhDOUMwM0NEZFpNS0p1d1BZYk1i?=
 =?utf-8?B?RkdlbTJhQWd4bmgwaW91cEdUSWxGTXkwVGZrYitJN3pFVm9vS1NUakVIclM2?=
 =?utf-8?B?UXl6bDk4SUorL2t2RXgyVzBJTUUzR095SmhES3VtTzlWUHVGNHJCTUZQUkF6?=
 =?utf-8?B?TzYvY1FvZjRpR2JrQ0JqN2RxSnRpc3kxYlFoMnFXZkxOaVBxY2Z2R0tVTjBr?=
 =?utf-8?B?Uzh1cDBDV0J0eGQ3TFZ0R3pkNkRhd2xPZkZ1cDBDM2xBWVlzbmt2VmlxeVY2?=
 =?utf-8?Q?xfQ7kG6k6hl1aEfZpHQHjzLV5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa702b33-1f8c-4296-c9a2-08db075c7b7a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2023 09:36:39.5743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zxKBNaqzJDKjBrqupDq9VqRBvGZlzPouzyoVBzuyTy73+LFZ5cObM1U4OVs7B45u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7605
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
> index 3a6dbbc6..867ac18 100644
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
> +	if (ndev->mvdev.mlx_features & BIT_ULL(VIRTIO_NET_F_MTU)) {

VIRTIO_NET_F_MTU is offered by the device. So conditional is always true. We are not done with feature negotiation at this stage so you may still set a value to device mtu if MTU won't be negotiated eventually. But that is not a problem because the spec says:

  VIRTIO_NET_F_MTU(3) Device maximum MTU reporting is supported. If 
offered by the device, device
advises driver about the value of its maximum MTU. If negotiated, the 
driver uses mtu as the maximum

MTU value.

So the driver will use whatever value is there only if negotiated.

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
> +	if (ndev->mvdev.mlx_features & BIT_ULL(VIRTIO_NET_F_STATUS)) {
> +		if (get_link_state(mvdev))
> +			ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
> +		else
> +			ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, ~VIRTIO_NET_S_LINK_UP);
> +	}
Same thing here. Feature negotiation is not complete yet and if

VIRTIO_NET_F_STATUS ends up not being negotiated, the driver will ignore this value.

>   
>   	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
>   		memcpy(ndev->config.mac, add_config->net.mac, ETH_ALEN);
