Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D50693652
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 07:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjBLGzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 01:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBLGzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 01:55:49 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910DC14239
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 22:55:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXoeZOl18Gl1jEgqkhbvn/KytVr/TP4xjllMWTT5JKg2Eki1sR7vhy5yhjLdPoKJAof7Q2KZ8bqgUikHT6mhGGGIdxB4dfN2RKX3PyhnSDTft1mmpgdTo0sw9M6NI8cAVW6f95cPYIp5tv99Fci/a9Cf7hCx6O6gpCqh3on86s97EdH6dfpqi3sWmcyuruZZ8on1pgCTBzeN348rOD45kmmA6xnaLf+w+GXwR7suZlL7lFotjtIRl1v/sC/JTBzLZURLP5GeouOZinDD3KlRECbgCRPeSnamK2xBw/b8ZFqsftkeoIQ9M5rCtlP4phQCtlnJmQVoEzaSQd0ynOhkhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpzhQKbGAjq9zvg6ql6ZhiWqnVO9C1J/BQZ0NnikJqM=;
 b=kUxtxmVhSmKBJdc9uIix5xs5j0B4Te2anbfw7TbUck1vYjMs+zA+plEMZvui6TBxjJPXwS6bxAj3tCrmE6gbjnYreRYz/NZQfDM/zPidlhlTZTB46i1wZDWX/ZTJuTB4oslhVlrOyQKw2azIz8ng++Hz0ovbOrmB5Dk4aUtmfE99Co0A6/p/6EwzEwu6TcKBjr4l15QO+UIk5rQzvqnBctKMpz/x32APSw1XgGs076OV0FHFVVkErgInrzySpWVSU2XusERgkzf2XwLf1hFzzKwHq69HT7fiQc0Qz7CgJYwbU1MASOAbq3pDojIMgT53leVFNUh8+MN36FpW9czILQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpzhQKbGAjq9zvg6ql6ZhiWqnVO9C1J/BQZ0NnikJqM=;
 b=fdnU6wfjBmreA5rGqwI0kj+qhgFJuY24guOcn8CLJFpIIcE6bBr49v5bJB2ky0EaqTGRaQxiLinjuwyRiaYyEESMIgIj5oMWct4k4Niv8K3ro9tTLlzqXxYzXxOyLvaI8maC1IiFO4OWtl9bd4JjR4JGTNXlhrsp1tqhK/imWdDTUHGALdOGJRb98SR2QX6mL6SersO+mIpPdZF3Gjjg3UgkEOJ3wEpA0aK0nujBLKK59i5ZKPuADgEZzeAqHxYrTXoBvltV2zEt1U1t3Wx52SWuRruvN9IvTt+ky4K6xOUluqEL4HD1OXUSMLajNN2JhaA1dNJRI7oEbSv7rF3vvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Sun, 12 Feb
 2023 06:55:46 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::e3cb:bdc3:f869:36ae]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::e3cb:bdc3:f869:36ae%8]) with mapi id 15.20.6086.023; Sun, 12 Feb 2023
 06:55:46 +0000
Message-ID: <536e8152-b575-7b8f-d7c9-37975bbedd3d@nvidia.com>
Date:   Sun, 12 Feb 2023 08:55:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] vdpa/mlx5: should not activate virtq object when
 suspended
Content-Language: en-US
To:     Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com,
        jasowang@redhat.com
Cc:     parav@nvidia.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1676095694-15563-1-git-send-email-si-wei.liu@oracle.com>
From:   Eli Cohen <elic@nvidia.com>
In-Reply-To: <1676095694-15563-1-git-send-email-si-wei.liu@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0302.eurprd07.prod.outlook.com
 (2603:10a6:800:130::30) To DM8PR12MB5400.namprd12.prod.outlook.com
 (2603:10b6:8:3b::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5400:EE_|BL1PR12MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: 59ae277c-a255-470e-a6f7-08db0cc62a68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zgzJ6Cs91JUIdm6/YBPy3dm5VwcGydhPHA08mgJ9KAMQcfULzyZnIPIYTheRDfuyNCcFwOx1Uxok5f/2KO4esSjNvYl9MUNOIQW8mq6WNMy2Y8iVoOv6HuvyRnsIxyTe2KZvts6tnE2Q6hNUWwFlT5hi2J330Zq5bRgSU5Ta04pw0Bxd9+BZaRelM0xkb3jjWsElgLwgcsHEgwrSFf9YfC4FOeVFNU1AeZijbxfLyKKLVBxSynIBUi4go14lS03s/4UQzopPLOVUY4iu4Srcqg3Ct8B3dXM48biCC/qutteNlD4QXIJLsYgaF9P2vsudLMg32KPhQ6uKpvqyiMlNvJlKrJvIFA3IT9j8XZB6zLPiuyOsDOa/9EUDBzXImTBYmCG/Y8YNp1KmpCy39ygf8HGPdn5yz9XKYeeyHA0JR39R06LmXHjtjTkQZR+AyILG3WyGx/BzxcqnJ5kV6A/Onx6RAzZUHK3giicsG1phoeNxLqdH+ne3A9QbQzbNjZRx793Us9hJJ6fW21IkHjAtDAkqbwf0gPz0UtHPLpDjMjuFow99WjeGISL7d8ct3I0rMelgrUGy2xttE2zsn0z6hWmodftA8b74v41SQUB7VukExqGWUG6GkzvqEzhB2WeHEjYEv1X9Be2sGm1E5cU6DsXvE4qkHsLmNlZlAy0bhkPWWAXs5C3Texn5/4zg6hnwNL3rffDTSg7GkAwAsjQxzuptYMV8KsDDopdO6WFRcPU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199018)(26005)(186003)(6512007)(53546011)(15650500001)(86362001)(6506007)(6666004)(2906002)(31696002)(2616005)(4326008)(316002)(41300700001)(66556008)(66946007)(66476007)(8676002)(5660300002)(8936002)(478600001)(6486002)(36756003)(38100700002)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzluRENmSWE0OG1nTFZoUlV4ZTVCUHI5YlpsT1hJc3ZyRnQzazlpWVZmSWVY?=
 =?utf-8?B?K2lXNkJSN0V3UTM2SFozdXVOUWgza0Q4U3JTcUNzeXQyc3ZMM3RzQVdGNzht?=
 =?utf-8?B?MHJPek56M0l5eFZYdTMwUG9TSTVmenBTRkd5cTFMeGRDNWZ1VTVuRkxuU2tt?=
 =?utf-8?B?TC9WQ1Q4NExBYkdySFRZN1lQK1hkZ2Q0RjJEWnF1bW12UHdVSXBMS0UxMUN3?=
 =?utf-8?B?UjZQMWYvYlBhZ0tySTdWU21yYjFraVpySmY2S0QzZG1VemNoL2sxaTFSRUVx?=
 =?utf-8?B?K1ZTMithcFFZcU1OdUVYNndPdVJkb3N6QVoyazEvWUdWSDcyMUtFZGs0NlZr?=
 =?utf-8?B?QnNLMXIvdGF0NU9iWndGZ3JYTGswSEhTWVJuL1p0bldaMkdrRllDR2xBaG9E?=
 =?utf-8?B?ekVBNU1YY256NnZqaXE4cWhpMGVqNFQ3NnVFOHlVNDI1SXd3dnM0NkFNYm50?=
 =?utf-8?B?VFNvaDc4WnVLSnRidm5mUEpzWENHb3dkWE9ET3AzMFRIdEhLL3greGRsb1JC?=
 =?utf-8?B?YnNYRE5wWTlmMTRUVzZCOWdaamkzdjUvQTBHLzU5aFR0eGJyN092NmtNd2Uw?=
 =?utf-8?B?VW8zTEJVTmVDQ0VLTnMzeFVyazg3bFpzSEV5cnJKdWtLUS94VFkzV2Myak9E?=
 =?utf-8?B?dHVzQ0Z5OUNYdUI3ejUyUFFsTjRaZlJ0UTZnOVBxZG5JQWJyYklQT2U1NU5O?=
 =?utf-8?B?Zm9VT09wMVN1RWJ5aFdkd1JxYmx4RHdXc1I0NDFJUWVrV2NHZTNoNUZWK2xW?=
 =?utf-8?B?a3RrZXdHR3JrYTVkczlMZ0FOdkZ5STZaK21FViszdm1WTFJzcVh6di9TZG5C?=
 =?utf-8?B?MmRKSXRBRTJ3VkRRYktOSlVRK1llaGZCOGcwd1NhZ1d6Q0c0SjZGRTUyYjZ4?=
 =?utf-8?B?eWVxdGpTaldLcG1IdDRDcE05NmxjSExOVTl5T0xVaUZKdnYzS3JweXNFV0xi?=
 =?utf-8?B?b2RBN09KT0lGR1lTZHhFOXNjLzdhV0tDcEhvZmVGdWphLzdLUlIxQVNnVWZ6?=
 =?utf-8?B?Z3ZlUnh3NVZzcTVwTWVvMFhBT09COTZSaFFQNm1ZMExoRC93cmJQZlo2Lzl0?=
 =?utf-8?B?SXhyaElzWUljNTZjVldGZHhoQktHL1NNUXloamswckYrdkNIbXdOYmFTS0s5?=
 =?utf-8?B?VURpdm5JQUViVENQTkdBOHlyOXRKVjU2UnRZWklGd2IwZk8yY3JYWU9hcUg1?=
 =?utf-8?B?WUZQdDdiY1luc1hnZHpMR2ZiZC9IdW5wb2Vzc0dnTGFmWjNJaEtHTVdtaWx3?=
 =?utf-8?B?WmFaQ25DM3ViL3BkQWd0UU5xL2JJVlpTVkk3R2hCYjFiOEgwb3NpbEJWcTVW?=
 =?utf-8?B?enhjUHR1eGhheDBqQjYvTUkwaUxVdWRLWENqaStDWUxWSEo5Wks4bGRJSWMx?=
 =?utf-8?B?cFRGNWJGVGFZRGJUcmNWMEw0bUptRWtFTUpkczB5djhNaVQ1Y3hYRGx1Z3Ev?=
 =?utf-8?B?d2hYbjROVlltL25RcElFSy9EeHhIQmJxbStNOU5BT3NZZExxMVhXL1dMa09U?=
 =?utf-8?B?TXU1c0pUbEtwU2toQlRKcnlTSnRrQ0l2Q0NRa2ZiZWxranpVelRENFl0cDhQ?=
 =?utf-8?B?KzJVeEFBbnRpUGwyTEdsYXNnMC9QZ2YrUHRMc294ZjFKUWF2bG93YWxvMXd6?=
 =?utf-8?B?UFV0ekl1Yk1PWEc5Zm1HR3Z0M296L1UvUTJDem1ZdWw1V0FKNHJWQWxZUy9X?=
 =?utf-8?B?UmJxT2FQajVtNnpVbnZPWjFBSG4zU25GVG1iVHVGeExuNXAyMldhYmV1S1Zn?=
 =?utf-8?B?a3RGRUcwUUtUaUR1ekh6VEZNcktHUXBrei9RVmQwV3VJYXpEMnZDazl1Zlh2?=
 =?utf-8?B?d2Z3a2JnQVlsVUdXZHZOVU4wblIzUFUzNm4vNlRHUjdLQXRqcml0NGJJUDRy?=
 =?utf-8?B?TG5KYm4wNkV5UStDc0NRdFRmZSsrampWVVU1Q2p3NUI2YnRoOGZNTlVyOVdJ?=
 =?utf-8?B?bzBrcDZsS0ViWWttbXQ4dE1LRVMvd1BScDhNR2lDbEZjb3N4QzB3L3BlaVpp?=
 =?utf-8?B?TWdXc1I1L1d4ekVtRjZUMVJGd3NPdXhhY2ZKNEpxU0hBRFVQWGM1YlNDM2E4?=
 =?utf-8?B?dWt6QlYxT0VIWXpwY3hIKzgydUNvTi9HMEo4NjZEVUJ4Y2k1UVpINnRlVzlB?=
 =?utf-8?Q?W0Q4yd+3H3I4hFQtU4WKZ+1Kx?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ae277c-a255-470e-a6f7-08db0cc62a68
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2023 06:55:46.1053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EaUrRTPtdKNC7t83c2L6tKhgI4yfjc9i/gLStViMSB9WsJmreLZpQvKKM4zlwKb0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5754
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/02/2023 8:08, Si-Wei Liu wrote:
> Otherwise the virtqueue object to instate could point to invalid address
> that was unmapped from the MTT:
>
>    mlx5_core 0000:41:04.2: mlx5_cmd_out_err:782:(pid 8321):
>    CREATE_GENERAL_OBJECT(0xa00) op_mod(0xd) failed, status
>    bad parameter(0x3), syndrome (0x5fa1c), err(-22)
I am familiar with this issue but I think it should be handled at the 
qemu level. This logic just hides the real problem. qemu provides the 
iova and the VQs' addresses so it should not shrink the map while such 
that VQ addresses are out of the iova range.
>
> While at it, add warning message to tell apart which object is
> responsible for the CREATE_GENERAL_OBJECT command failure.
>
> Fixes: cae15c2ed8e6 ("vdpa/mlx5: Implement susupend virtqueue callback")
> Cc: Eli Cohen <elic@nvidia.com>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 3a6dbbc6..c05c7f6 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -165,6 +165,7 @@ struct mlx5_vdpa_net {
>   	u32 cur_num_vqs;
>   	u32 rqt_size;
>   	bool nb_registered;
> +	bool suspended;
>   	struct notifier_block nb;
>   	struct vdpa_callback config_cb;
>   	struct mlx5_vdpa_wq_ent cvq_ent;
> @@ -1245,12 +1246,18 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
>   		goto err_connect;
>   
>   	err = counter_set_alloc(ndev, mvq);
> -	if (err)
> +	if (err) {
> +		mlx5_vdpa_warn(&ndev->mvdev, "failed to alloc counter on vq idx %d(%d)\n",
> +			       idx, err);
Although you mention in the commit log, maybe it's better to have a 
separate patch for improving warning messages.
>   		goto err_counter;
> +	}
>   
>   	err = create_virtqueue(ndev, mvq);
> -	if (err)
> +	if (err) {
> +		mlx5_vdpa_warn(&ndev->mvdev, "failed to create virtqueue idx %d(%d)\n",
> +			       idx, err);
>   		goto err_connect;
> +	}
>   
>   	if (mvq->ready) {
>   		err = modify_virtqueue(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
> @@ -2411,7 +2418,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
>   	if (err)
>   		goto err_mr;
>   
> -	if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> +	if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK) || ndev->suspended)
>   		goto err_mr;
>   
>   	restore_channels_info(ndev);
> @@ -2580,6 +2587,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>   	mlx5_vdpa_destroy_mr(&ndev->mvdev);
>   	ndev->mvdev.status = 0;
>   	ndev->cur_num_vqs = 0;
> +	ndev->suspended = false;
>   	ndev->mvdev.cvq.received_desc = 0;
>   	ndev->mvdev.cvq.completed_desc = 0;
>   	memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
> @@ -2815,6 +2823,8 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
>   	struct mlx5_vdpa_virtqueue *mvq;
>   	int i;
>   
> +	mlx5_vdpa_info(mvdev, "suspending device\n");
> +
>   	down_write(&ndev->reslock);
>   	ndev->nb_registered = false;
>   	mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
> @@ -2824,6 +2834,7 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
>   		suspend_vq(ndev, mvq);
>   	}
>   	mlx5_vdpa_cvq_suspend(mvdev);
> +	ndev->suspended = true;
>   	up_write(&ndev->reslock);
>   	return 0;
>   }
