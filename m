Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285266964E1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjBNNlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjBNNll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:41:41 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F71725956
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 05:41:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOEvXs4wl4Dcbf14MS47GrfKIz6C111oQZCszKXWTUTuQYvDTJBKGJlgAAAZP5NWtWB8CXkeP82FTRmmBv1C9iLUTUEYHh8j++RABiST7UHy/+93uSnEeEovxvuRH8+IV6AXolQqXhqoDbcnkcVJjge4UoAqptrIfGWPL2YVbLhLgTVyXO3GpLNVS/3/agRo0IuYeQ/QLv0nbVAsqabwpqwbWLRPNtwGwr5BmnG4BnZH7NWxxjq7nBN3o/QBROgb3QJQHjhE0yKI4+p1q3/RcSuGiukfSmSpF5ejXitgtKRpeQOjq5c9Jw2fhPJ8wFy0LM4WDE39yLgmAt4Gtqvl9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IF7rIIVUi0KTo+FxQXCtngRN5ABNO4eQpOVlEBqHHOw=;
 b=Pf6I1eW26f9cSfhJ91hKUYA0flkgPnPa2Vd+s2iX3W3CDwzh2Gb/RSrY05uE4RTCRk/1Gcy+peZVNreV2dh8COtAmA0vdw5GU9dX1YstGTCz43O2bZ+WKk/LbksWAuqxaQWCGfkaZ2BeLH5E2GeuSxR4Pri+WcWLV2BRzW5owxdI4DeivjzUQ+4ETZMETJB9CMM0kWqaulEVoOkc6cx2vFk3yAOtkdivw1ZBfFMayPj4PqV5r1a7LHw8aKkGO/1FzB21gYBCKGL9JfxiBuGJfN15KQzvrGatmQuXPgD8qDyye+vDrxqpZ+0t+r5B/QHDWUWiDL/6Lrhx4EU07SJDuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IF7rIIVUi0KTo+FxQXCtngRN5ABNO4eQpOVlEBqHHOw=;
 b=KtBMsdvddH7kuzBPFGlpIRuKWuRncHlbKIlivf/imdYzJINJFrI4ppOB3ryJSKYOhoE+HVUMihHhO5LXjlTNzg9U40UagbAoTqeANeGScVEi/S9Jv99cNi5WhN3uQPM2lgaGYUHS0lgGKS1aQuU6w5RjYtz3Bkxji+/LPXqFDabClhDI59cHR4hwIc256sB/gHheID8gSR8ogl5vUVGGvrxiqHuuAkw+FVeJbZalcan7lh9FHss7aWZXmDj+Vk0+insW2f5n+CSCjzmPYFJE6d9fqTSKJkFoNUlAbySpiyKRAv38D+uIBSVyBo7hM1PfPl2WuS5RdqFAQBo0fDLFiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 IA1PR12MB6603.namprd12.prod.outlook.com (2603:10b6:208:3a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Tue, 14 Feb
 2023 13:41:37 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::e3cb:bdc3:f869:36ae]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::e3cb:bdc3:f869:36ae%8]) with mapi id 15.20.6086.026; Tue, 14 Feb 2023
 13:41:37 +0000
Message-ID: <7401f34a-cd19-b286-c5fd-d27f88b12522@nvidia.com>
Date:   Tue, 14 Feb 2023 15:41:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2] vdpa/mlx5: should not activate virtq object when
 suspended
To:     Jason Wang <jasowang@redhat.com>,
        Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     mst@redhat.com, parav@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, eperezma@redhat.com
References: <1676328489-16842-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEvCCNGeWb0DsExM+fxC23yGOwKuJ24auSujWTQpZEPw7A@mail.gmail.com>
Content-Language: en-US
From:   Eli Cohen <elic@nvidia.com>
In-Reply-To: <CACGkMEvCCNGeWb0DsExM+fxC23yGOwKuJ24auSujWTQpZEPw7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::9) To DM8PR12MB5400.namprd12.prod.outlook.com
 (2603:10b6:8:3b::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5400:EE_|IA1PR12MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: 901e2bad-e8fd-487f-6d34-08db0e9131a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2qqJ+iC8Fadw1wOFhLP9XeGRCYuOk+nTn7JdeEQ11uUH0KH9zlZrP99wf7/SLzy4jP00ZUU5cVx14kBGrD1uTeTomYdF25u374AA9bE7mbdVT37fqH5nn/nccevkryTN7MJqXPNzMNsqKIQBuWopOkI8KaqwYrJAOVAkKrM5GpUw+a9qMxrVm5FV4NHY460rtajZ/HCficgC8bJ/ogU3N7gGTEpx4bHWAN3QQkSGf/ynXHlji+LrXVZ4XMCzz7XJyGSgNaf1sa9MlnqwsQi7Hrpgv/g+mztjr+bqa8GrWdiqTCFoO8sofR3asO3ls0JXAQRyop+C8RO84LQLTLwoetquPhyRTnFh5zZJg38yjr6vzcQqXbS7VKEUgLOJ8FlSrs6I0O3mPlSV5qPqfjgPVPpWQrUn6DSLBNjU5a1Bl2V4BqXoc2ERElixJkcfMl8W6bcpikOdOM6o5xgU5zp/nnUTsqDVL21Shdsgpp/uPmePsPkPy23b9rLkl24E1geqd3/SV0jiMnlcMfWMpc3PfRCWtf3tKN0beMymu7ViMUDAG9A++dq5n9moflyu9AySGpzwhOZ5ANo1Cn7w5iDDGvFNopceGF0Bj4LsKFf/W43ujevdqX2dEc6U2i9YNR7pxmh3djm3n46IJjKE7HzMG1J+idJx5gxJdbKR1C9YFlAFctPpUFdHjteZ1DR+6lm9DyAHiaKXITvi2I2JkeCg33oODO4ZmQ6WAEWN6l2CrKI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199018)(86362001)(31696002)(15650500001)(186003)(26005)(5660300002)(6512007)(83380400001)(38100700002)(2616005)(2906002)(36756003)(4326008)(8676002)(66476007)(66556008)(66946007)(478600001)(6486002)(110136005)(316002)(8936002)(31686004)(6506007)(41300700001)(53546011)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3dpMWtEdXkyMXo2MDRDTW5hd0NxMU9JN3Q1N0Q4TFlSSFRCeE5oUGVBZXVs?=
 =?utf-8?B?eDFxQUJReDMxbGt2ZUpTM0VNUWt3WXlET3YyeHhlckVUOEtHR1hQN2pCb1Js?=
 =?utf-8?B?anJ5bGtBRVJMOHc4UlBXanlFUS9heUQrZHYySmRpa3VqcGwyUmI3UVdHYzZ5?=
 =?utf-8?B?WHZ4VmdVNytVUjJOcmJuZGZJZUNvV2MvRFdHT1QvcGdoK01KMjJuZ2FyaWIz?=
 =?utf-8?B?OFhpR0FQZitOdWR1N0JaWDRhelAwbkxHZURKNWtraXJZc2RHRThEdE9ZaE5L?=
 =?utf-8?B?QjRpKzVBY2FJMnJDRDBoQVh1MW9VSW14MWlPWnNaWFhFd2dNVlpMdmluaDVP?=
 =?utf-8?B?Um1GZVJQSEkwa2V2dGJ2MGoxam5ocndIZ2syWDh6YUJ3ZTlPL0hOM1RYWVhj?=
 =?utf-8?B?Mk45TW5OcVBtZFBYQ0RXVGxWUFJUamdIaVY2T08wempvYlpxeW5LRFBCai9v?=
 =?utf-8?B?S1VBZjg3ZHRSRTVuMWppTTZVTlZ6OFZvMk4xNnZLb3llZFR4NjgrLzdIRisz?=
 =?utf-8?B?QWxXUVV2TWpWMlY5L081SG4rTHM1SS8xWDdNZWE0c0NGc1JicWtIMTNlbStZ?=
 =?utf-8?B?bklEYUdGMXZvNit2VVVmTk51dnJWbmRtbXRpOVQxQmcxTnVndmx4R3lhTjJI?=
 =?utf-8?B?VVVqWG1IMmdWOXBybHJRMHEwU0ozejlick90a0tYcjlId0ZBZjZ4dGNLY0R2?=
 =?utf-8?B?TTFxcjkwaGwzcDFYT0pjcC9abTByTGlhSGswNUxsSXgrZHllQlRKUnZaVllm?=
 =?utf-8?B?MWZvL0M4UDdUTG9PYW02TWdEVGxPRC9kbEdjSWN2cnBROHNHT1lrNkZaZlhi?=
 =?utf-8?B?SGN0N09NWXdZdkxzVzJTZjkwTnlHY2UwQ2ZLeXE4OFNablRhdldiOERCelQz?=
 =?utf-8?B?aFYyQW5uNVUvTDVXcjhrYUl2NG9qNUROTE50czQ3WnlvQjBCZFdtTGpsdEo3?=
 =?utf-8?B?dzViQi9VMFpyb0FlQm1VNnVTZXc0NTY3Q0NLdUQ1NEp5elNwRzk5UFpWZ2Zs?=
 =?utf-8?B?dlJ2OUJFQkV5YjdsODdSUHJuUDRJVlpuU29KcTZVckNGbWdPWld3ODdmZHlW?=
 =?utf-8?B?QWIrclh5Q1RhamtkNndEYkFKaU82RzN2QUplQjBkZm5lVEZldVZTdDB4YWMv?=
 =?utf-8?B?MFVEYm9QTGU3a0YyaitKcURDVjRtM1Q0blVpRGVnSG4wUE9jVWlEeWlSbnZv?=
 =?utf-8?B?RExDU3hCZ2NNd3doZjhDakpJS1AwbVhoYXQrWXpRZ2taa2kwdC91UVpXSy9m?=
 =?utf-8?B?ZzVDTHBZOExpVnF3UlMxNzduVmNVT1FSMmFldlpyL0huVG1hZVdseWFrQ2Uz?=
 =?utf-8?B?d25NQ2xwNGQ5a014RzZJMFl5VE9Ca01DWW5VSEpVRWhTd2lGbXZkNXJ6TzZV?=
 =?utf-8?B?RlN1K29RYVVtcDZocExPMDRRdzYrbnlGcU54Nlc5Nkt0V3FCdU5GeG1DdXZY?=
 =?utf-8?B?eGwvTG1iSE1EQk9iQW12dDJPSVZ5ZnRLSm9sOWR6TnhpMmNMaDFaZnhDajFX?=
 =?utf-8?B?ck11bHk4VWtkc1J6NTkrMWhoRUhtcGh0QjNHQmViTXJJcmNvSGdwZlZud0dh?=
 =?utf-8?B?Zk8zbEdsdFlqQUJuVWt2MDhWOVFOcTh5Yk1KcmxueS9ucEJhcEUybzBlaWsy?=
 =?utf-8?B?M1c2TjlQaGRoalZCWWRDRkxWNGZ5VEF5MUdnWXF6c3ZyY09OSytKbG1lbnBW?=
 =?utf-8?B?dmNjeWVXRmlJTi91cDI3bWFqQUlLWnRSSXIwVW5oRHNhMVhqWGozVGpUQmND?=
 =?utf-8?B?TEZvcnpRUDVnS1psREdBK0FOa1dFOHE4OFIwMExGNk1UbUVrR2NyMms5ak92?=
 =?utf-8?B?TURDb2JYVWNpNmlMRlZMbmNlVlFFaUF3UlpYNUFZb0VKck9HOFFoWEEzTHo2?=
 =?utf-8?B?R0lCek4vRHNNaFh6MWZ1bUNHTE9DcXB3Ly96a3pKUytDVWw3cFE1WUV5L29B?=
 =?utf-8?B?YVJ5S2JKUzAzMXRGbDgzVk40TnRKTU42SFFDWmZYc1hNK0lkQTYxblNFd1Iz?=
 =?utf-8?B?aEZ4ZEJpdDg1cUNsa3d3UmZqUXBDSkluZmdwMFZNS1RVMklmcmdLZ2F6d2hx?=
 =?utf-8?B?QkswNGNWOVdRWHdyL0o0bzE4aUVjNzlFOENPbW5QK1pCUno0TW1lTlh6UFBO?=
 =?utf-8?Q?LavXd8SdNS3ZtvcxXE4CrR1xD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901e2bad-e8fd-487f-6d34-08db0e9131a5
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 13:41:37.2010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Uu9JpCFRqtQ8T0Isyi8Op66cM+L7deILfHFZ/FG79nfENuo7v8/FbZDcHUTWfQX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6603
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/02/2023 8:20, Jason Wang wrote:
> On Tue, Feb 14, 2023 at 6:48 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>> Otherwise the virtqueue object to instate could point to invalid address
>> that was unmapped from the MTT:
>>
>>    mlx5_core 0000:41:04.2: mlx5_cmd_out_err:782:(pid 8321):
>>    CREATE_GENERAL_OBJECT(0xa00) op_mod(0xd) failed, status
>>    bad parameter(0x3), syndrome (0x5fa1c), err(-22)
>>
>> Fixes: cae15c2ed8e6 ("vdpa/mlx5: Implement susupend virtqueue callback")
>> Cc: Eli Cohen <elic@nvidia.com>
>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>
>> ---
>> v2: removed the change for improving warning message
>> ---
>>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index 3a6dbbc6..d7e8ca0 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -165,6 +165,7 @@ struct mlx5_vdpa_net {
>>          u32 cur_num_vqs;
>>          u32 rqt_size;
>>          bool nb_registered;
>> +       bool suspended;
> Any reason we make this net specific? (or is it better to use
> mlx5_vdpa_dev structure?)
>
>
>>          struct notifier_block nb;
>>          struct vdpa_callback config_cb;
>>          struct mlx5_vdpa_wq_ent cvq_ent;
>> @@ -2411,7 +2412,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
>>          if (err)
>>                  goto err_mr;
>>
>> -       if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
>> +       if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK) || ndev->suspended)
>>                  goto err_mr;
>>
>>          restore_channels_info(ndev);
>> @@ -2580,6 +2581,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>>          mlx5_vdpa_destroy_mr(&ndev->mvdev);
>>          ndev->mvdev.status = 0;
>>          ndev->cur_num_vqs = 0;
>> +       ndev->suspended = false;
>>          ndev->mvdev.cvq.received_desc = 0;
>>          ndev->mvdev.cvq.completed_desc = 0;
>>          memset(ndev->event_cbs, 0, sizeof(*ndev->event_cbs) * (mvdev->max_vqs + 1));
>> @@ -2815,6 +2817,8 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
>>          struct mlx5_vdpa_virtqueue *mvq;
>>          int i;
>>
>> +       mlx5_vdpa_info(mvdev, "suspending device\n");
>> +
> Is this better to show the info after the device has been suspended?

Besides this comment of Jason,

Reviewed-by: Eli Cohen <elic@nvidia.com>

>
> Thanks
>
>>          down_write(&ndev->reslock);
>>          ndev->nb_registered = false;
>>          mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
>> @@ -2824,6 +2828,7 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
>>                  suspend_vq(ndev, mvq);
>>          }
>>          mlx5_vdpa_cvq_suspend(mvdev);
>> +       ndev->suspended = true;
>>          up_write(&ndev->reslock);
>>          return 0;
>>   }
>> --
>> 1.8.3.1
>>
