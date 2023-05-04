Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617126F7171
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjEDRrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEDRrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:47:35 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA03719A
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:47:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhpGY2AaZa8gFgs6VbStqKGRHyM9g2Eojd/XV95OZUucwWmHQJSIFXjcCcNQ7NXTdqxLJWQuYFGj42oSQ0p2xLYCBKnSZfaYsAoXprntmTtBQt945haBMZdKaCzTCHU8EawTMl8DQSuCJ+zwjqEHSI9kjuVzzyCW9Vmgh4RHwb0TI40TzJEu/69zALn68hbgtiO8U0f5XKKFrLaXt8DH7JOOFFZTRTP8CLPZ09Xyk0cFAgfAH51kc9gXsRLDFANnYU/Mx7sGfzdDHmArM4V5NIDjdJpwNHnq0qlGbfhJqF5530whl1nzrE8btlh1kMX5Y4YSjszmTnlo2BlbEzTZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRYKPLT81VvNiAYOVrs3EaoxYofR7m+WGEI76MAgZ9o=;
 b=edYbIl68ynrHS08ZlK+TKWkDQFPVJvymAMEu5O2eRaRqfwxhUMpM8jeYvuZzduOP1rbTbkB6Kvibte5D+nyVzbNkqyakDy6ONNzl/WLqU1+dCrJgMYz118XZwguFofJy9EUwZyGlBtMEJm+gHrql7QL1h9fEKDG6emBCIvoUr2erwgxHmwl881OjcjBKqcgkCCnS8UNnmrrclXssvh0OwWLdriDmSv2M2NYHH6j8Ms7D4R/73qKhnVl6OQBuLJimtpPJhMHGm4zEE2Cd3aoxdQhgcyW0ckxh0pCG4tlkbwgk742OiWS8/zlTLWEac8pMB0YeyIRHCmBwbvo4uTyHgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRYKPLT81VvNiAYOVrs3EaoxYofR7m+WGEI76MAgZ9o=;
 b=Jm9aTL04WZqxZ8f7SSDPR1QGoQjuRNIRff4S23ECL2WvrkxV0jB69f7wjXy/1mU7Ug7Bq+fr8017HxMHKi6M9HusK81lMoNiUW9JqE71matIaA2leIp/SSmcF0M8aIsQk1B+SJDRQ9DLLoXdQjN1dkE63scPDtdYWBimpEu14iQBl57JM9v1vY0J23PVpGzLSGmtgQrvOujFoubEJOAmZuGrpUaXNldtvNjGi4HtC1mW8/uQ8+pcuOtiFDpw3daIDaouZMrCaus78OiBCYzJfzm9S1kT6cKsW/U+TaEH1b3bU2yNyCSrd99a7YGNtbYcQ79O4WtqAQi1r5Vve0NdMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Thu, 4 May
 2023 17:47:26 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::a7a3:1d9d:1fa:5136]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::a7a3:1d9d:1fa:5136%6]) with mapi id 15.20.6363.020; Thu, 4 May 2023
 17:47:26 +0000
Message-ID: <a886b0f7-26f1-d616-589d-75e6e5151188@nvidia.com>
Date:   Thu, 4 May 2023 13:47:22 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] virtio-vdpa: Fix unchecked call to NULL set_vq_affinity
To:     Dragos Tatulea <dtatulea@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Xie Yongji <xieyongji@bytedance.com>
Cc:     Gal Pressman <gal@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20230504135053.2283816-1-dtatulea@nvidia.com>
From:   Feng Liu <feliu@nvidia.com>
In-Reply-To: <20230504135053.2283816-1-dtatulea@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0035.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::48) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|MW5PR12MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: 203f76cc-5558-47f9-c8d8-08db4cc79f55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x0bDkD0L7HXDVOFRo1nXDlVQoEtB53Rvxuf9FRwL6NVSD3ZO+BR+c7tiYMf7monuXMO/gRxIxAZE2qODoak9ehIHXSCrYiwQOifLPj6UERJthduuvBDlfXdwyT9yYJhCDsF3XqsGypOjjEiptgGCq5GeD+SCVyxU4Gl+lJNKPeDZIYvkyTorBMEabv1ZZ2/9i+MIJcI+OWbfCum/HHY9dYt3dYX06RPLw+SCeLVlujPBwN3qbfamvalrWOaeW1k3UIdmHmvTRcSMJ9sCPUfoDIL7NWmCUUAy7W3lHUpbYz6hj5xnp6TiCxsMnwp4HV56Daanc8k2grwKrxkYItdocir6QNoVnvyUC/GoSB42A8QutrVp7FbUtkjDowIVVczzrcub2sK+9nr6mAChl8CEh/E0rHfTZXLoLfdPNuUlmgEZPJLbVDDwYJrrCj2k5LvWOzi9QXWObf9ZIjimwBsw1Z61oCugzVNzKyAEj2Gm4Tu90ogrFkn88qWty/UMWaWGTXVHeskgZmDDgQyAvLw+nPefFdsX2PSEH9Sx/t9vht8mqFyZCrefloQLZsHdD8mt4qA1yNgc8wrg+SGgZ+oxh4n3qRpnmqeXPVLXPy22umVYX4NpaI+eczCsWAJEziiCTz6H858L/BNeAFv4pa+cIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(6666004)(6486002)(83380400001)(6512007)(36756003)(186003)(2616005)(31696002)(38100700002)(86362001)(6506007)(26005)(5660300002)(110136005)(2906002)(66556008)(4326008)(8676002)(66476007)(66946007)(316002)(8936002)(478600001)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2thblA0M2g0eHZiVVR1dDNJeVUzR0ZCNlBpdEpUZnVrTjNyZE5vUGYra3dI?=
 =?utf-8?B?RCtqR1FpcEJkbXAvTVJrOVo4SFpCbnFmS0VqT2c0K0hNQ3NtKzRiUE02QlhR?=
 =?utf-8?B?UkdIY2lkMnI4UWFxOStOclpzUkF5Qmx4ajFHak5HYkFyQUxGSFM0YjgyY2JQ?=
 =?utf-8?B?TExZUWhxc0dsNG5NV0VTKzJsUEVXSlk5Y1pWUEdXUDBrUnA1TXArcUxBQUto?=
 =?utf-8?B?YWpFRWJ3ZnBUSW50WDF3eEJKdUFKMXpuNTcrM2JDWWNjd2tiVUZxdXVBMUZS?=
 =?utf-8?B?bS9MTG84aGxjVXlndVZMSjNzVm1PKzYyRHVKKytvclN3cFZhREFiUnFWY2s0?=
 =?utf-8?B?UC9YS0RNZVN3QWZ5ZXB1RU1pYWJCY3JYS0tCbGU2a2lKL2IzNWJkb1EwZmEw?=
 =?utf-8?B?SXQzaTJjNnFRSjg0VjgyLy9qZXNVYWFyOStPSkJRQ21NaDBSSnpOZlM2b2Yv?=
 =?utf-8?B?QlNCcWgrVGNrWmhSTnBTN1Q4ejRCamtXcHRJeDdhNlcvdFpGeUlHc1p1ZHRq?=
 =?utf-8?B?QTdrT1hST1Y2WWd3N1VhTFhlcmZqK3djUFlBZHdnZWRRcmg1bUhMbzBsVFBD?=
 =?utf-8?B?UDJDeVprS0dpVWtQZ3hJeWxad1ErY240ZnFuWGpUWEpLZS9lakI3bnlyWlZa?=
 =?utf-8?B?enJ5VkZEWVVTaDF2aXlZRGo1VDcwWXRqdHVERmlOaTJheDdERUw4ZGZZaXh1?=
 =?utf-8?B?c2hocjlaSUs5NEh4a1VQNEt2eEwrQzNNWS9NUHJRY0xtcmVURnlybTRhSjRr?=
 =?utf-8?B?eU8rVUJpR0FERDNIc2F6dWNKZjVsUEZ0dmQzM05VR0t2d1VBVjdMTzBPbXRj?=
 =?utf-8?B?Qmp1T2ZOK1VvSGdOdXdWaXlzQU5PYVc4ZjRkTWMwNWFxVlU0UmhIb0Qvem0w?=
 =?utf-8?B?YnJ1KzkwMU9tcENBdWJ4QUY0L2JFb21Xd0ZzUlNGaEdiQTNQcWpQWVZ6eFFR?=
 =?utf-8?B?d2h4UG9UdHJNTnhITDRsdmVFNEFzeFErb0dRRUJIMS9YQlM4S0I1TzFWdEx4?=
 =?utf-8?B?NnlZZ0N3ajBKbDF4ZmxwaWtqNWVTOE82Q0QyT0VoeDQ5TE5vNzU5N2xRM20v?=
 =?utf-8?B?VXN2Y3JyZHBCa1EwRDhpanE3cnlWUGlEZkplVmRTTi92OEJOL0lZaWNXK21U?=
 =?utf-8?B?M051dDRZUGtWNEw1eGRPU2lrTmU0VDljNkpZN1E2S2VPa21jOWU0QnN4UEFU?=
 =?utf-8?B?VHd0ZkRtaHBlS09LeE0wV083MkNpYldlanRSR3FEYjNEY285UXRIcnNtVDhk?=
 =?utf-8?B?WUJiOTJZNVM2U0NYSmRtMnVrZUFEbzRNc0tqMTJQWTR5dEhIRWNDcTNXUlF2?=
 =?utf-8?B?WW1xVk5VNEFJMzF3ZERXT1dxSEdmMit6dDdoYnFuR0J1Q2dVcFQyVWpuOW1m?=
 =?utf-8?B?Unh2OTBSdFVmTm50OUhyUEVpaGFQY1JrYTFkS3doUWgrdzQrbEl5WkxucnZN?=
 =?utf-8?B?Y1FrdHJkM3J0S1BteFlxckQ1ZWZLaHB1YXB2SE4yU2JoSHR0Rjh3djRKOGZh?=
 =?utf-8?B?SHd5c0ZwMGRGV3VlNkVtUHA4WlN3dU1aR0hZMWdUdC8xVXF2T1RjeUJ1cm1X?=
 =?utf-8?B?bE9zMW5MOFNwMmRiUGFWWm01RzhSRTR0UXMweFhhakpBYnFhU3NvdFRHN09L?=
 =?utf-8?B?VUpQZmwxYmowK2xlejdmUmZmcTVWU0puQ3hjbE40Y3RLMEp6a3ErK2k5YTJz?=
 =?utf-8?B?a3FrMGd5OE9vZ0ZPUVNTSG9GQ0JUYlRnYTRTTThOVFR5d1pvT2N2dm5tdThU?=
 =?utf-8?B?Z0tQUTdEY05JM1ptWGQ2Y25RQmNiWUZaUDBUdGhCaks5K2dsb1Q1M0JPdzZp?=
 =?utf-8?B?UW5XYjhRR2pWdFg4TzU0U25lWG5GWUtoNS9VYlZrUlhEV2ZWeDc5b3lrZ3Yw?=
 =?utf-8?B?dFdZaTNqNFAxYUxFRldTZHZvc0VnT0JxUWJwSk1PeXo1VnNHWHJLMC9Kb0JM?=
 =?utf-8?B?QzJFYU5ES3g0S1oxdW9KWWg0ck9Qc09tZ2lIazh1RHRaVnFQYVZ4bTYzeVJl?=
 =?utf-8?B?b1hCVG1vdVkvVVVDV2ZmOWpJMGFjajJpRzBONTl0ZGpRYnRjS1kzenVVZDQ3?=
 =?utf-8?B?enpPay9rcWVhc2ZWc1MzbzFYMWgxZ3F5cWhSRW51L1JLdU9jVDdKcXZEbEpy?=
 =?utf-8?Q?3gq+myWIHI0VU4Jw3z5mIyv6u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 203f76cc-5558-47f9-c8d8-08db4cc79f55
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 17:47:25.9811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2UsGnzOTRdcmZscntOBXwBw8K28puNsOxV4UzufYNLUKBIKZptXZ1O+yoAtRuaRxKkPHmne8oDVkJJ5BCypKNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-05-04 a.m.9:50, Dragos Tatulea wrote:
> External email: Use caution opening links or attachments
> 
> 
> The referenced patch calls set_vq_affinity without checking if the op is
> valid. This patch adds the check.
> 
> Fixes: 3dad56823b53 ("virtio-vdpa: Support interrupt affinity spreading mechanism")
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
Reviewed-by: Feng Liu <feliu@nvidia.com>

>   drivers/virtio/virtio_vdpa.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index eb6aee8c06b2..989e2d7184ce 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -385,7 +385,9 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
>                          err = PTR_ERR(vqs[i]);
>                          goto err_setup_vq;
>                  }
> -               ops->set_vq_affinity(vdpa, i, &masks[i]);
> +
> +               if (ops->set_vq_affinity)
> +                       ops->set_vq_affinity(vdpa, i, &masks[i]);
>          }
> 
>          cb.callback = virtio_vdpa_config_cb;
> --
> 2.40.1
> 
