Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE3B66D6A7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 08:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbjAQHIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 02:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbjAQHIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:08:07 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1034965BE
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 23:08:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3rQMkz+icZdAEWsjQJwnteCTApRQgBaCqYCWNo6zeZPp8aqvnGyAOu+M62f2d9fuHSjx++dx4IyxNwcKfuof7/ZCERRLSmmDh2dSEZWn5U9PLzU2O0E0SzSM0N/FFrXRkLKAdR4hFyCapkC5gRZGyFYHeUWj21uAkmZoRPLr0GroXdLovpazMgbB1B/Rr5jAULq+T8WVBO7AXq06HRRxDal3ixcnp8g4wQ2v4+zE9dLejREdmVLjtBuV/QiZd7dGaYCFp3Z4rKBXge2kkOXo0ObZh7qeJMbwZdW/gPHc98zbARm09Dd3DgqAK2BXeQa/o1gkhRkFj+8KIb3/oRHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvRORy/F1ys/5rlZNT8iyQPejwdSI/b96lqUDX77I80=;
 b=KHHBCcfAPLt+M32KvC6dW0Jz8gh1xQmZ2BBPUjBoKuJwTptMkYSO6zmlHfg4rHHjYjCeNCFyTw4vsRO2J7mp/Jv0gM3wCrDRiT2NlXHVPhsQ8qqcuVUUoa/GBRRIQuKUbWJcgm6ADvSkGfnL0QSGIgmJQdRB2rXXE7aXfJeHZlT4L+j72b3LPu9c85pEzxqYwQVs28hWBGl3bMhZyQ34f9ZcB1i+G0EtZ5d0Y5A7NtKMDI7f8RCFoYF+oXbTFqNz0+3ewxrbYWnk8EtWA2utsWzdaH1D/TMaouyTCDiTnNAmiDKLpi3vxRxAEroIXhO7Rq8sIJ6iGWEF85Rr6zaVcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvRORy/F1ys/5rlZNT8iyQPejwdSI/b96lqUDX77I80=;
 b=M9nu3IDvwdaoktxDamJMEMHdkPm919F3ZEv0ipe7h/0Qo8jNuJIQNHjlAqhBlQBHlG4rl6zxa2prGFQtzhamlfib18+xRu4ZvDf8rblx6g6dA7MiNtmOoQGSRgAcs+4jxRgf3peRlbVtwmmD32BZ1OCAgJzNP8T5qn0XbkIGajGoSQgpo5pDz2RHduEgQbekY0MJpEnDLGWMXH1Xk8oVgT+HgC7Fpnz8/q4Ze/lQeTMpwP6TJI0OOjvqZg8w+j+/tkb2dYDkJbf0DMckX3QButvyI2lKy/6MCaxvOrv6B8Ki+P6zXxKRfgxlhvGYeZ8aEL0y7XCXd9fYK9rtxFZg9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5400.namprd12.prod.outlook.com (2603:10b6:8:3b::12) by
 CH0PR12MB5059.namprd12.prod.outlook.com (2603:10b6:610:e2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13; Tue, 17 Jan 2023 07:08:04 +0000
Received: from DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::70c6:a62a:4199:b8ed]) by DM8PR12MB5400.namprd12.prod.outlook.com
 ([fe80::70c6:a62a:4199:b8ed%4]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 07:08:04 +0000
Message-ID: <521e9601-b9b1-19f0-24cb-89fb2e7ed164@nvidia.com>
Date:   Tue, 17 Jan 2023 09:07:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC 2/3] vdpa/mlx5: conditionally delete cvq iotlb in destroy_mr
To:     Eugenio Perez Martin <eperezma@redhat.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Parav Pandit <parav@nvidia.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "sgarzare@redhat.com" <sgarzare@redhat.com>,
        "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>
References: <20230112142218.725622-1-eperezma@redhat.com>
 <20230112142218.725622-3-eperezma@redhat.com>
 <DM8PR12MB5400B2FF15EA6DB00AB840EBABC19@DM8PR12MB5400.namprd12.prod.outlook.com>
 <CAJaqyWeJOwcAj=mr5R4qHqWSjK1dQ-SxMNVF0HYkPtdoO2BaGQ@mail.gmail.com>
Content-Language: en-US
From:   Eli Cohen <elic@nvidia.com>
In-Reply-To: <CAJaqyWeJOwcAj=mr5R4qHqWSjK1dQ-SxMNVF0HYkPtdoO2BaGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::16) To DM8PR12MB5400.namprd12.prod.outlook.com
 (2603:10b6:8:3b::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5400:EE_|CH0PR12MB5059:EE_
X-MS-Office365-Filtering-Correlation-Id: 160763ce-cea7-4344-ae3e-08daf85993a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2aNlP4WMwPauHBcX4cZeVBq2olCaHFYVqb79KUvMASek2OOqlss5d3eHg8KB1xZapfcrbgXDpBDkEWBx9rUQwhdgWypXc9GA/u3Z0hnd7a82QVkX6yE7ksMCu1lfQ6R7tZBJYovaq3+XsCgMrD2Fqqgt729BhiC7Jn7CKq4XojBOIcaTE0jyGDZ7uOluPbumKh6EleSntFi6H3TuaMo1vAzLJy2Hpd72LOaVIoQ2lqL2QZdxxL1rjD8FgNE45I+DkizPHY/QDvPRCAzsABbCKdFX6FMvkPstPlLoIVxQCfF3BR5NPfaNVH1Eh+SSzcEGOjoHL44TRrSjH/EHUOyHBNnQZaaJDhXXjSosUgbi00a5obXroudFvDNekqYOM1e/PLf5t885qye4LmqHfSTXhPbIuN3EfqCAMKd7zJ7JMiV4Ujbd9cVBu+LM0GHKn0m992ZAjGDDTvzC87vl6VL3WrCLFPch6dvK+EjJlU8lVSw4cQa4tu6c/ALkM7bts3Rz8mKLd7xetyhMxzzt3DSJHGZQx/KPsiUVviWoNmSpGzsOe9ChJbVGdRc0fEyeGReK45jp/1KmKa3Mcry3CUF7LwmToj+M7tajW0nBk7nPZHzuM99JLuBD9/uXagkNl7pSsvR/odV1e1saSm7TQWH++2lYdsZ2qz699DJc2a0jjFouOHsnuwI51PcC3IBDxTAifV5vmMm8unDsXUprx2czuJbdE9L4kChm9ZMCOJ/N3Bg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5400.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199015)(8936002)(31686004)(6666004)(8676002)(41300700001)(66476007)(66556008)(4326008)(66946007)(6916009)(316002)(478600001)(54906003)(2616005)(36756003)(2906002)(5660300002)(26005)(6486002)(31696002)(6512007)(53546011)(86362001)(6506007)(186003)(38100700002)(66574015)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHJQL0JOUGsvSmZ6U2xrZzdWalVGLzc4eE5oeVU2M0htTlpEQU4wdEFEQVkx?=
 =?utf-8?B?ZDU0Ung0QWtoa1JjelgxVmkzMWdHK3l3bGNpU1hRcnBkNTRsM0FhM1ZaYUMw?=
 =?utf-8?B?MmlOcXpUUkJWNVh6am85WklQL2RKRHU4NVpqUkwvUlR1SXp2dm9Uc05FY2h4?=
 =?utf-8?B?aXJJNjhpZktMVWNweExMd1hsMHRsUk5aK0l6aklTbmJxU0hEdHUrdlNGeWQ5?=
 =?utf-8?B?K2JqZmJrRjFOOW9YWi9NcC9aWTBneFUzRi9PMHhaSGsxNHBCbXlhRWh2c3Zx?=
 =?utf-8?B?bDBiSkF4T21YUnM4R3hxZEs4NUdZcmFGMmNzdlBnajJlL1dKcjNZT1pNa3VI?=
 =?utf-8?B?aVNIT3lTcXJJbHZ3dkFqdlQrVEVGcmtVSDJNbThwQWVvZVg4VVJnQ0tGSEJ3?=
 =?utf-8?B?WmliVGpGa3p2U3dsR3VpcUJNUitLQzFGbTgzM0xyUWlvTWlBQ0l6YnhtNmJo?=
 =?utf-8?B?cTZGQUJQZk0vVjdXL2lodEpibUY0RnFFY2dRZnJyNkg5YWgrem9OV2JGaDlz?=
 =?utf-8?B?eXl0TjQwL2s1Y0MxNDY5dmxCZHhTamRnc244RUNrVEhBeXVrYTdJWm5MNVQ4?=
 =?utf-8?B?dUpwZ2Z0Nk54K0JaSzNmeUk5d2RQMWlCa0tlM3hRa3N0TmFiVjd2SUFmalRy?=
 =?utf-8?B?YW9BVmJZVmt5cWlSWktrdXF0cDduY1pWa1V6M25IZndjdFBxQldITGRzcTdV?=
 =?utf-8?B?Y2pFZzhKRnRLSStVRjNtOGVOc1hsUGZ1Q2Z0b3dSUUo0ZGtvMUg2SlUvNU8r?=
 =?utf-8?B?djNyL0hjNHZ6RUppNDdhQjgvK3NvblZnNFZPL1VRZXpYVkxtbnJsSGthNWlC?=
 =?utf-8?B?K2NJbGdzTmw2amJqYXJ6ekxnSDBVcTc4V1RZUFpsYUwzdzY0NUpMZEhWTDZ5?=
 =?utf-8?B?VDZ4L2ExQ0xHVFI3STN4R0liUGdGdXhrUkV0Lzl1ZnZYZ3YxMHBIbnl5WjZK?=
 =?utf-8?B?RU1WWG0wQTNlaVhjL3loUFhJcXJQRXR1ZFhLSGxTVDRpMVN1Vk9CbXFvVmp5?=
 =?utf-8?B?U3MwZzREeU9OU2RWTXdqTDZrVWZnMWlhd1owYnpkQUMvQ0NxcmJsendVcEFN?=
 =?utf-8?B?VGsxMUxKdXdkdmVlRENDUVZ2MXRtVjFReGtpZG5QR0ZwYnFJZDhZZS82Z3k2?=
 =?utf-8?B?ZDBkR2l1eFBrVFVvOE4reVZ1aEltQm50ZDRtdk83dlAvdTE0WHRBcmx1c2hh?=
 =?utf-8?B?MnN2eTFqa3V1eXh6L0E0aWVyc2dqc1hyeERGUHpNSVZKQm91TXg1RllyZll1?=
 =?utf-8?B?WnZrMlpWM290YTUxcGNyQktyalU1cURtMFNaYWVWdFdCSHoxdmkyOTF3TlAr?=
 =?utf-8?B?SUYyd2ZqTnNOK3RKR1pZa3JmNU1BaVY1bmxJRjB5Tjlub1pNNXNDY0VMTFND?=
 =?utf-8?B?UHRPaFN3ZWJoS2Q1WE1lWkd3NEN6K3Eycy9MT2d2N2xhNE1weE95cDVqZ3Vx?=
 =?utf-8?B?N2lLMWExUW5mZ3VGZmhLaFNJQWlnLzZMdG5WSmVyQUczRTFSUHFPcVJacGhL?=
 =?utf-8?B?N2xmbVJsTnphZzNqTk1KZ3pDZTNwNjFDUHVYT0FzbnJaTWtrVmxFYlUrbDQ1?=
 =?utf-8?B?UG5vN3A4bWRjTFNIcmF1MFIwd2w5TUp0N1RteFlTZ08ycmR5ZlNKV2loQVhl?=
 =?utf-8?B?Q0F3UHBkb2ppVFovY1pzSjAvVmVUb2JoSzlacXpBQmhZek5sRGoyeUJuMGpK?=
 =?utf-8?B?OGZndlZjdHdPRmU5RlFwRTFaTkxjejd5ODlBN25Pd04zOEVXQTEzRmdodjhv?=
 =?utf-8?B?Smd3am9lZll5TUFVSmRaYkVqenNZNXgvd21BR0pueTY4cWVXVDZ2cUZwd1hU?=
 =?utf-8?B?dndSOXAzdllJSDk5cFhVcjlLV3lxSEVJbHJGZ3lCUVlvdi82K3JpYU1nV25r?=
 =?utf-8?B?Q0NqdnVSN0Y0eWFpRWl5K2NiWTFmRE9kRzEzU0EycDMrOUR2MXJFeFB1MkI0?=
 =?utf-8?B?WUNnMkoyclN2cUhOYTFCaXl5TStCb0t5MVZWajJJbTQrK3FDNEd3ZzJFb0Rj?=
 =?utf-8?B?bXI1RkRJQ01JRTE3ZGZPSXlxK0lxM1ExUTFkOTI5RTZLUUEzYXA5TTkxdUZP?=
 =?utf-8?B?ZTV0d2hnVCthKzBLZlhxT2dnZk9LRDhtVU1EZFdLM0ZVRG9yM2Jkd21jU1Ji?=
 =?utf-8?Q?Of9tzz9kbv8qicwIPH9JoYGVl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 160763ce-cea7-4344-ae3e-08daf85993a7
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5400.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 07:08:04.1864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUGlBZYkJ7/3S1UVVkYbE/54DL4tfiFFkmOLgw+8MytWPhAc+Nx+Q/xoUulYG8mr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5059
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/01/2023 20:03, Eugenio Perez Martin wrote:
> On Mon, Jan 16, 2023 at 8:03 AM Eli Cohen <elic@nvidia.com> wrote:
>>> From: Eugenio Pérez <eperezma@redhat.com>
>>> Sent: Thursday, 12 January 2023 16:22
>>> To: mst@redhat.com; Eli Cohen <elic@nvidia.com>
>>> Cc: linux-kernel@vger.kernel.org; Parav Pandit <parav@nvidia.com>;
>>> lulu@redhat.com; jasowang@redhat.com; virtualization@lists.linux-
>>> foundation.org; sgarzare@redhat.com; si-wei.liu@oracle.com
>>> Subject: [RFC 2/3] vdpa/mlx5: conditionally delete cvq iotlb in destroy_mr
>>>
>>> mlx5_vdpa_destroy_mr can be called by setting a map to data ASID after
>>> populating control virtqueue ASID iotlb.  Control vq iotlb must not be
>>> cleared, since it will not be populated again.
>>>
>>> Adding a conditional in the function so the caller specifies if it is
>>> resetting, cleaning, or just changing data memory.
>>>
>>> Fixes: 8fcd20c30704 ("vdpa/mlx5: Support different address spaces for
>>> control and data")
>>> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
>>> ---
>>>   drivers/vdpa/mlx5/core/mlx5_vdpa.h |  2 +-
>>>   drivers/vdpa/mlx5/core/mr.c        |  5 +++--
>>>   drivers/vdpa/mlx5/net/mlx5_vnet.c  | 12 ++++++------
>>>   3 files changed, 10 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>>> b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>>> index 058fbe28107e..000b144019ec 100644
>>> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>>> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>>> @@ -119,7 +119,7 @@ int mlx5_vdpa_handle_set_map(struct
>>> mlx5_vdpa_dev *mvdev, struct vhost_iotlb *io
>>>                             bool *change_map, unsigned int asid);
>>>   int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
>>> *iotlb,
>>>                        unsigned int asid);
>>> -void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev);
>>> +void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev, bool
>>> delete_cvq_iotlb);
>>>
>>>   #define mlx5_vdpa_warn(__dev, format, ...)
>>> \
>>>        dev_warn((__dev)->mdev->device, "%s:%d:(pid %d) warning: "
>>> format, __func__, __LINE__,     \
>>> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
>>> index ae34dcac9a3f..878ee94efa78 100644
>>> --- a/drivers/vdpa/mlx5/core/mr.c
>>> +++ b/drivers/vdpa/mlx5/core/mr.c
>>> @@ -491,7 +491,7 @@ static void destroy_user_mr(struct mlx5_vdpa_dev
>>> *mvdev, struct mlx5_vdpa_mr *mr
>>>        }
>>>   }
>>>
>>> -void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
>>> +void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev, bool
>>> delete_cvq_iotlb)
>>>   {
>>>        struct mlx5_vdpa_mr *mr = &mvdev->mr;
>>>
>>> @@ -499,7 +499,8 @@ void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev
>>> *mvdev)
>>>        if (!mr->initialized)
>>>                goto out;
>>>
>>> -     prune_iotlb(mvdev);
>>> +     if (delete_cvq_iotlb)
>>> +             prune_iotlb(mvdev);
>>>        if (mr->user_mr)
>>>                destroy_user_mr(mvdev, mr);
>>>        else
>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> index 6632651b1e54..1f1f341f602b 100644
>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> @@ -2433,7 +2433,7 @@ static int mlx5_vdpa_change_map(struct
>>> mlx5_vdpa_dev *mvdev,
>>>                goto err_mr;
>>>
>>>        teardown_driver(ndev);
>>> -     mlx5_vdpa_destroy_mr(mvdev);
>>> +     mlx5_vdpa_destroy_mr(mvdev, mvdev-
>>>> group2asid[MLX5_VDPA_CVQ_GROUP] == asid);
>> Looks to me we need to handle this in a more generic manner. The asid should be used conditionally for either CVQ or data VQ updates. You are protecting CVQ but same thing should hold also for data VQs iotlb.
> I agree. Maybe the best option is to replace the boolean indicating
> the ASID we want to destroy mr? Then, at cleanup, we can iterate by
> all vq groups / ASID.

I think mlx5_vdpa_destroy_mr() should get the asid as an argument and 
have a logic such as:

if (asid == data asid)

     destroy_data_mr


if (asid == ctrl_vq_asid)

     prune_iotlb()


return

Since we have only two groups, one for data and for control, I don't 
think we need to iterate.

>
>> Meaning, if qemu wants to update only CVQ than data VQ translation must not be affected.
> _mlx5_vdpa_create_mr. is the one that checks it If I recall correctly.
> It is not obvious in this change though.
>
> Thanks!
>
>>>        err = mlx5_vdpa_create_mr(mvdev, iotlb, asid);
>>>        if (err)
>>>                goto err_mr;
>>> @@ -2449,7 +2449,7 @@ static int mlx5_vdpa_change_map(struct
>>> mlx5_vdpa_dev *mvdev,
>>>        return 0;
>>>
>>>   err_setup:
>>> -     mlx5_vdpa_destroy_mr(mvdev);
>>> +     mlx5_vdpa_destroy_mr(mvdev, mvdev-
>>>> group2asid[MLX5_VDPA_CVQ_GROUP] == asid);
>>>   err_mr:
>>>        return err;
>>>   }
>>> @@ -2578,7 +2578,7 @@ static void mlx5_vdpa_set_status(struct
>>> vdpa_device *vdev, u8 status)
>>>        return;
>>>
>>>   err_setup:
>>> -     mlx5_vdpa_destroy_mr(&ndev->mvdev);
>>> +     mlx5_vdpa_destroy_mr(&ndev->mvdev, true);
>>>        ndev->mvdev.status |= VIRTIO_CONFIG_S_FAILED;
>>>   err_clear:
>>>        up_write(&ndev->reslock);
>>> @@ -2604,7 +2604,7 @@ static int mlx5_vdpa_reset(struct vdpa_device
>>> *vdev)
>>>        down_write(&ndev->reslock);
>>>        teardown_driver(ndev);
>>>        clear_vqs_ready(ndev);
>>> -     mlx5_vdpa_destroy_mr(&ndev->mvdev);
>>> +     mlx5_vdpa_destroy_mr(&ndev->mvdev, true);
>>>        ndev->mvdev.status = 0;
>>>        ndev->cur_num_vqs = 0;
>>>        ndev->mvdev.cvq.received_desc = 0;
>>> @@ -2691,7 +2691,7 @@ static void mlx5_vdpa_free(struct vdpa_device
>>> *vdev)
>>>        ndev = to_mlx5_vdpa_ndev(mvdev);
>>>
>>>        free_resources(ndev);
>>> -     mlx5_vdpa_destroy_mr(mvdev);
>>> +     mlx5_vdpa_destroy_mr(mvdev, true);
>>>        if (!is_zero_ether_addr(ndev->config.mac)) {
>>>                pfmdev = pci_get_drvdata(pci_physfn(mvdev->mdev->pdev));
>>>                mlx5_mpfs_del_mac(pfmdev, ndev->config.mac);
>>> @@ -3214,7 +3214,7 @@ static int mlx5_vdpa_dev_add(struct
>>> vdpa_mgmt_dev *v_mdev, const char *name,
>>>   err_res2:
>>>        free_resources(ndev);
>>>   err_mr:
>>> -     mlx5_vdpa_destroy_mr(mvdev);
>>> +     mlx5_vdpa_destroy_mr(mvdev, true);
>>>   err_res:
>>>        mlx5_vdpa_free_resources(&ndev->mvdev);
>>>   err_mpfs:
>>> --
>>> 2.31.1
