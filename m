Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3659868B5CE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 07:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjBFGw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 01:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjBFGww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 01:52:52 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0DC72B7
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 22:52:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkcjH70x0QjKyu8l08zSeTF9iRg5M4VPF/7WN0hsXyr/a3A+zk8FptV9OBBo1I3HPOvDPSK7m4PJQHvJ2a/8yjazKsFQAaGj1n7AH/XIKk/EsXPqcMQBqX+OazTrrwJupjvTqyc6y7DokrASWPbm/rb1DrNW8s1TOC8w5MApMqUb89EM1DsgQpscKDnp8dueXDqNGY9bntMax50VUkjwQEDP8zPzwTtccczQQyAP3i3sFdph+gx3RTr+vvBJmDNYGpCpWWPgzDll5vxH/rlrxF4MaPI1YK1nomL/LZCY7xUIkOCSD8tre4jE+Eqftcy/J6xlxHUXsfyW8fRJefelmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQarx5NqzDTUlx8jsmaQkFTiMtw8vNuIh4o6+SsgPGQ=;
 b=ZoL5aXv9W7U0uQ6+rSIIhfz9gYEDfsp1OriNf0jebYyrzQvqKZFg/cck4ZHM8MyieeO/KirVaCbM4tFndcf0t01DnBc2TbKEy4Uuy6p6kBhZc0WPp3JHwy3fKFGbqPfVGwXvMRPNalxhokeHUvcv4A2u7F7T+k9AYI4TRQoBX1JDI7dF7IfRueGxsfqxt0+nPiK+EnLGWwCsq7518irb1U0fIAK2eCAXF6jWpfsXG0ikqp8ZRHjA9V6LMedHXPC52C0KHhaJKFH0SySwq+j0px/7Kez0KZXNnW/1ASaFDnutKy8NUlBHfVCfEmJi6Az5X0FdkMVQfC/C76GbBAKr2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQarx5NqzDTUlx8jsmaQkFTiMtw8vNuIh4o6+SsgPGQ=;
 b=C6bEkb6Z3hxZp9VRCiB7iQWmcbYHZOtX1cHHuPThCSbaHZ5F3Ok2LVfSEmF9Um+ZkKkbVSxrNtGnKSl54FDk9HRLlO3QOqrO4pSUC9fIsomJ+1YlDv8pWVTZfdTSv6tHSj1FGLyEGa34lwyOpIOy7f7pSHjOMxz4lCTu03L8hhuGwy/HPODeJyVKjr707ZLFSXyFfGid04k/5RxydGckSPYI93V5TdGNI7USWBqgsfjrsrxT0X2tvJWNosjBQhfs7DUQu6h9hkUNOoNdadAxNDFR3zqaaWXD6+ntVuVoFzKPdV59L7AYtpsQnab8JCC7otS1SFxG6hE4JvOccdVR7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 SA0PR12MB4574.namprd12.prod.outlook.com (2603:10b6:806:94::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.34; Mon, 6 Feb 2023 06:52:48 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::9344:d2ae:739a:a358]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::9344:d2ae:739a:a358%4]) with mapi id 15.20.6064.034; Mon, 6 Feb 2023
 06:52:48 +0000
Message-ID: <6037e4db-43fb-253a-7036-9c10317bef45@nvidia.com>
Date:   Mon, 6 Feb 2023 08:52:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 5/6] vdpa/mlx5: conditionally show MTU and STATUS in
 config space
Content-Language: en-US
To:     Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com,
        jasowang@redhat.com, parav@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1675400523-12519-1-git-send-email-si-wei.liu@oracle.com>
 <1675400523-12519-6-git-send-email-si-wei.liu@oracle.com>
 <d6265719-a423-2798-4cd0-b4b57a34878b@nvidia.com>
 <92e5a001-a17f-9d05-5412-355e1c436b30@oracle.com>
From:   Eli Cohen <elic@nvidia.com>
In-Reply-To: <92e5a001-a17f-9d05-5412-355e1c436b30@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::13) To DM8PR12MB5400.namprd12.prod.outlook.com
 (2603:10b6:8:3b::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5400:EE_|SA0PR12MB4574:EE_
X-MS-Office365-Filtering-Correlation-Id: e177c979-0d5e-49cd-7e51-08db080ec1c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VZNjQOSlkZIpsbfl60icpg+L3QhHpLTfa2x9mMvFrj9/BNMPSef9FVrCDCMGe0q6tmrKCYV7m5KMCYakU4WRx3EtgI8nCho7+PoWai8/Zt6Y0TSdHHIe6DpYQkLDTyqV93aDcz+0UiXVkT5HCy+zgZZ7/0K2l8KMjU/OX7YkMa5vot8WzKcqP+DPGFmtb51QE+VTYrD7NrlYoHaHeeZ0RXEBc3hLfBCqiVUtsJzY8kzYC1y9DdVv/BVlKYzYP9ZuU9h6NZ1k1xhaYyx+tKAoX9+Relio8QtODQ8F9YLc8mn9MvrhUuXjcv5ij+FDX5vMaiJnfCVa7n6pJU8DmJkD2usAfx4wYncxU6m2buY3viQoI9jSticqcAIABPXOfRYu7l+xYUbcF2o7AAQLbKTxV68W6yIIwE/B/ZadWn6YYTpNtBlMFaSvHFjSdjYpcbgNUKdyagsZV3Pb/GLAw82Z5DdnyJEsM8JEc3zxHj/8AILQigFmF+tzTIpwq1T4jINZ/n+55YUrqWiCCVJjoz54WBh+pajXPN3rAcNDPRPB0EyZ2Mixal476DQWk92Iy2yYNztqMTrr3qXYWubMp8SvBntnuboqdcqIJH+GUbgq4Teul/gJd2p2sNxH3/y8FdkpJTrp3T+CFlDnncsFQbqMsvKdAke/BqBJv2/y03ron0o4uIZmvNck45tXatj1eiJBU2Gwa+/hTigne5rys0HX+6GB0D3DLSOOwUbQWF2birk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199018)(31686004)(2906002)(66899018)(53546011)(36756003)(6506007)(5660300002)(8936002)(41300700001)(66556008)(8676002)(66476007)(66946007)(86362001)(31696002)(316002)(6636002)(478600001)(4326008)(38100700002)(6486002)(26005)(186003)(83380400001)(6512007)(6666004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3NnMm9YTnBuQS9zdE9MeU03TjhxTzZrVWFiNXNLUzlRRzhQY3B5RHRYM01o?=
 =?utf-8?B?czlvcVlJSU1sM0RpazBtSDRBazllMVBWY091bXdiTndxWEVpd1AyMUQ4QXdJ?=
 =?utf-8?B?eDhwampvbEV3cEtWL1IreDZOVnA5UVQ1VWZMZEFHV01BSC9oQi9UT0RNaCtq?=
 =?utf-8?B?U1U4YVVQOXM2S2lCTDFIblVpMEIrUzc0M2p2WXM1bEdVcTJtRGYzckZSNUZ2?=
 =?utf-8?B?Z3QzcGlLbFI5c0dLQVNvK2RVaXlEUy9oU3pod1ZSN3lnT0JONTlPZmtPVnpr?=
 =?utf-8?B?V1BmVnpaYnpZTi9leEZtZHVuTnN5bE50UU5tbkxSYldDb1NSVlA0TEF5alZt?=
 =?utf-8?B?eW81aVQ3b1grRGNjNkE5Yk1vMEtZSUFPcytFdHo2cjd2cDg0aVBhL3VkdU01?=
 =?utf-8?B?bXNPYVY0N3NaNVRBTU04b2NWK0IrRmRlUC90emFIUzJrVVVVSVFBdlRQeVlv?=
 =?utf-8?B?S0ZkdkIxMEpzQVo2MWpqS1pHRXNxdkwxSER0eUdYUEhpWGJtRUVFdCt3eTlk?=
 =?utf-8?B?eGU0ZnAyR0NRb1JOS3RoQk1PVTVnYlYwWWM1NDU1LytBYUxhQjRsYko4WWc3?=
 =?utf-8?B?d3ZNM1dINVJXZVd3ZzRBWUt4cTdPZTZDWmFUSFgxV0VLVTVOOW5MSmdSa3dF?=
 =?utf-8?B?TDBVMUp6MkZOZ1doNGRkUW1RbXo2cm1qcWZqdTlzR1FMb1JjeEdMM1ZWZGJz?=
 =?utf-8?B?QnAyY216SnVWUVNYQmliM1haU0ltKytDSFZrODZ2MVNETDZwbW4rbmtKZkFO?=
 =?utf-8?B?UXZibFpFTENqNUpYZnhId0JYZHd0R2JsTi9uZ1RXQWl5elpWRERzUVY1aVZ3?=
 =?utf-8?B?QU84Z05MYnhxRUVQSXZ5MHQwOURXbndNUW4vS3ErVDVjVGpCK29haVFxbHV5?=
 =?utf-8?B?MFFzM2laZjNQdVFjSVg1eVRzY0E5Z0lmTDc5T3QwL1lUWWprZ3hEZ3lBZ21q?=
 =?utf-8?B?bUZseVgwVXJuUWE2OHNOeWZFQnowWlp2U2h6VmQ2cWN6djdhaDhJUlB1OVJN?=
 =?utf-8?B?bVJtOCtNd3pGZWYya21tM3ljZU4zQ2hXeUltbnhWRFRJd0xYVTBjMitkSGJS?=
 =?utf-8?B?Mytyc3lYUUhBNGhsZ1I3Q0FxRkdORUwyZUVaZ0drSU1nVTdnWWk0ZDljR3pk?=
 =?utf-8?B?U2pseVN3U2RRdm5odFJWekExRFhUaktOU05rUVk3MnlqUGUwSGFWVUZWdHFq?=
 =?utf-8?B?Sk52MEJTcjVvakZWZmZ3aTIzQW52NklOZmZiZU02N2FqM2liQjJ0M21hbXFP?=
 =?utf-8?B?bEJYQ2w1TGpobmZNVnVvbTFXbzJPMFMyaDZ0MUtaSmZUV1J3WmVxd0ZMZE1u?=
 =?utf-8?B?bXcxcTRiQTU4MllpYmJOazdZb2srQWc4bnNoTGhkUnp0L25CWmhjandIQm40?=
 =?utf-8?B?WnlxNE1MSFFBZFdWNzAwT1hTZTQ5enY2Y09LRmw4TTdLSW10ZjZZdjV2UkpS?=
 =?utf-8?B?RkxqeUZmTEhFUkp5NlkyeExleDRmdlUwSGxRZnNzQjJ2MWdSUnZ4Q1JhMDNp?=
 =?utf-8?B?MGkrcWRWS1JFR1NZb2ZxN05LakpMSzNDRXFqcDJoNnFJVlJCc3dRSGd4a2Zu?=
 =?utf-8?B?ZHdCakFQVlJzQ2l6bERUVEZFNkM3aCtvUVpDZnNxZE00cVFCQzVEYTczaHU0?=
 =?utf-8?B?YVdraTlRd05PQ2F2STBqbElZeERRMUkrSElQZXN0dW1xV0hOR0czVitoUzFw?=
 =?utf-8?B?eGpVNjU4M1RVeUNUYkJZR0xjdjluTnhsaFpjNTdDNngzU2grT0F6ZjhKQyt3?=
 =?utf-8?B?N2ZCaGZ1R2NoYXVzUlVEcXlrK0NkS3hNa015R1RsYjRmZFBPTm10bXNHVlo4?=
 =?utf-8?B?VjRHaEtreVo2dTFFb09zVzRIR2lhMUxGbG02ZXNuL3dwNGprZ0pTRjJUVE1F?=
 =?utf-8?B?OTkxTlVuUlkwU2pkQlFnaS9VcVIyeTdCSUhnRjhCQ1JtdHhDOHRwOHRNSnoy?=
 =?utf-8?B?c0lNSW13a3NqYzJsa0t6eHdueUI4TVY4NXErb2dwQzJLOVlhUnRTZlA4QjhB?=
 =?utf-8?B?dC91VkhpWW41U2p5K3Y1RXNZTDc4Q213ZVMvNVNjc2h3eXFPME5mc1hXK0Zs?=
 =?utf-8?B?NDVjemdJUXUwNDV5bGRJT0hzS1ZUaWVma3l3TndlZW5JK2tWUFA0VEtqQmV2?=
 =?utf-8?Q?EF4hINM+/4HJsLk7b2CgIgMCJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e177c979-0d5e-49cd-7e51-08db080ec1c3
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 06:52:47.9259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JHKl8zPUnwb5HmWIyTb/Nk5LrQmXjt5Ykndv5y6TZ5oEttdU+jpNUR+JQgR8bs2v
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


On 06/02/2023 6:53, Si-Wei Liu wrote:
>
>
> On 2/5/2023 1:36 AM, Eli Cohen wrote:
>>
>> On 03/02/2023 7:02, Si-Wei Liu wrote:
>>> The spec says:
>>>      mtu only exists if VIRTIO_NET_F_MTU is set
>>>      status only exists if VIRTIO_NET_F_STATUS is set
>>>
>>> We should only show MTU and STATUS conditionally depending on
>>> the feature bits.
>>>
>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>> ---
>>>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 22 ++++++++++++++--------
>>>   1 file changed, 14 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c 
>>> b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> index 3a6dbbc6..867ac18 100644
>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> @@ -3009,6 +3009,8 @@ static int event_handler(struct notifier_block 
>>> *nb, unsigned long event, void *p
>>>       struct mlx5_vdpa_wq_ent *wqent;
>>>         if (event == MLX5_EVENT_TYPE_PORT_CHANGE) {
>>> +        if (!(ndev->mvdev.actual_features & 
>>> BIT_ULL(VIRTIO_NET_F_STATUS)))
>>> +            return NOTIFY_DONE;
>>>           switch (eqe->sub_type) {
>>>           case MLX5_PORT_CHANGE_SUBTYPE_DOWN:
>>>           case MLX5_PORT_CHANGE_SUBTYPE_ACTIVE:
>>> @@ -3118,16 +3120,20 @@ static int mlx5_vdpa_dev_add(struct 
>>> vdpa_mgmt_dev *v_mdev, const char *name,
>>>               goto err_alloc;
>>>       }
>>>   -    err = query_mtu(mdev, &mtu);
>>> -    if (err)
>>> -        goto err_alloc;
>>> +    if (ndev->mvdev.mlx_features & BIT_ULL(VIRTIO_NET_F_MTU)) {
>>
>> VIRTIO_NET_F_MTU is offered by the device. So conditional is always 
>> true. 
> With the next patch in series that selectively provisions device 
> features to mlx5_vdpa, this conditional will not be always true. That 
> was the reason why I made patch 5 and 6 in a single commit, as this 
> conditional will only be needed until feature provisioning is 
> supported. Basically patch 5 and 6 are logically connected and 
> technically should be separated out. I'm now puzzled, what was your 
> thought then the change in patch 5 shouldn't be part of patch 6?

No, I think breaking into two patches is the right way to go.

I missed the fact the for setting MTU and MAC you need the device to 
*offer* the feature and does not depend on negotiation.

>
>> We are not done with feature negotiation at this stage so you
> 'You' are who? device, driver or guest user?
>
>> may still set a value to device mtu if MTU won't be negotiated 
>> eventually. But that is not a problem because the spec says:
>>
>>  VIRTIO_NET_F_MTU(3) Device maximum MTU reporting is supported. If 
>> offered by the device, device
>> advises driver about the value of its maximum MTU. If negotiated, the 
>> driver uses mtu as the maximum
>>
>> MTU value.
>>
>> So the driver will use whatever value is there only if negotiated.
> My understanding is that 'vdpa dev config' now displays user 
> provisioned config, or default config value advertised by the device, 
> rather than what config driver will actually use.
Reviewed-by: Eli Cohen <elic@nvidia.com>
>
>>
>>> +        err = query_mtu(mdev, &mtu);
>>> +        if (err)
>>> +            goto err_alloc;
>>>   -    ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
>>> +        ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
>>> +    }
>>>   -    if (get_link_state(mvdev))
>>> -        ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, 
>>> VIRTIO_NET_S_LINK_UP);
>>> -    else
>>> -        ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, 
>>> ~VIRTIO_NET_S_LINK_UP);
>>> +    if (ndev->mvdev.mlx_features & BIT_ULL(VIRTIO_NET_F_STATUS)) {
>>> +        if (get_link_state(mvdev))
>>> +            ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, 
>>> VIRTIO_NET_S_LINK_UP);
>>> +        else
>>> +            ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, 
>>> ~VIRTIO_NET_S_LINK_UP);
>>> +    }
>> Same thing here. Feature negotiation is not complete yet and if
>>
>> VIRTIO_NET_F_STATUS ends up not being negotiated, the driver will 
>> ignore this value.
> See above. With feature provisioning, whether the VIRTIO_NET_F_STATUS 
> feature is advertised by device is subject to the device_features 
> value provisioned by the host admin users.
>
> -Siwei
>
>>
>>>         if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
>>>           memcpy(ndev->config.mac, add_config->net.mac, ETH_ALEN);
>
