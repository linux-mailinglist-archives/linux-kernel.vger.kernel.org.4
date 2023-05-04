Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14926F716A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjEDRqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEDRqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:46:19 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F225D12F
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:46:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/zsecVtirusOqmGUHNfqQf0CTVCyETieC/LnJU447rqy6kE/pY7iY2XPsL00aVlfvxFhK/FuBmggNmpvK4sDS6gwCqrCFpDpEsudfilpeSx1WJDOr5tsbSFk+a5kaUwLWO7T0Y4gc9t0Mc/uC3ME7vExs6mzPBCcQ0cxw1tIr71HCXDlytG92KaKFYZLjxgDzZzu9lDe7RyPQqTYKvgC1s57+jwZnQHL55i5e0CHrJ1r/Mudvp4ArSUF1GpqhUvDmyFN9VISBOK/pV31whh8Z1UzthXtZRs1YA4nYvlgw0k5uKvcGoFOoCVYYf1dIBJx5ll9Msq7W3hFfscrYpWvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9QJjqzYF/hWCPzYfBj9M93NtdrC0Qsz+j+pJGzgV4E=;
 b=II3+JKf5oYju8njHbLsUH/5vhgeqRluB4dqLgAQpiy4C2ZQ726H52P6TxXtq4YCdMhEOpjNaSO2O8szKyhe2f4nMePmlWvoPiwtIMaNlNkpzcUM4AgR8fKht+lUcpWZuh9hYarvEqDLmeV5DzigR2hurmIhtbjOK4rh/fI5D6KK7crYRGNDMrFL22CqfTNnAOWAQQ6pCnRwVW13/wR0Ipr+v+cIjcq4/FFkucs0+bbB5MIxCUl8phUFwMKrVLrfk5qXhATOia8H3OgknL6wHi7zFC3HPQOkqHcq/iyX8sXjoGm/XJ5ZG+0F3IMayAF1ukHJuah6DfJDFHx0+2Uf0oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9QJjqzYF/hWCPzYfBj9M93NtdrC0Qsz+j+pJGzgV4E=;
 b=V97VOR3uZFo/CnDe3rKDRpTXQMKKembivJm22Cq+qOlAhtLP5af6wx7fh/TIayI/D3aoXb2HhoJF1mOmTPhCNwwH+ciz8kdM2ktTC9pmueWnRixFPA+Ty7hI6LkT0LCt2NNVG9st4oXabz/yCjEUaMGbTObkFhKIRzzT3uhk6H9u0DWTPIDBHOuhRza972Zir5YsD1WTqIwjmnwIP23KLRNY27Wvx9hUhLqWhZYyaMdUD68RY5Z05DQnNEFkbfVhGaG1Ij4z3gHOcVa9EGFdgmRLkmonsuXMBVgrwVNRjdK+LXZh+eH4Ed7rOhc6X3PTYw9aERSkWqiF0868JtS7cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16)
 by MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Thu, 4 May
 2023 17:46:15 +0000
Received: from CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::a7a3:1d9d:1fa:5136]) by CY5PR12MB6201.namprd12.prod.outlook.com
 ([fe80::a7a3:1d9d:1fa:5136%6]) with mapi id 15.20.6363.020; Thu, 4 May 2023
 17:46:15 +0000
Message-ID: <3465c9cb-670a-cf9c-c366-50dc6c9ae930@nvidia.com>
Date:   Thu, 4 May 2023 13:46:11 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH] virtio-vdpa: Fix unchecked call to NULL set_vq_affinity
To:     Dragos Tatulea <dtatulea@nvidia.com>,
        "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>
Cc:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Gal Pressman <gal@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230504135053.2283816-1-dtatulea@nvidia.com>
 <26ee2c04-7844-14fe-5cba-fe30172f075f@nvidia.com>
 <209b4b364facec3cc26f3d12acd4b466b9278b47.camel@nvidia.com>
From:   Feng Liu <feliu@nvidia.com>
In-Reply-To: <209b4b364facec3cc26f3d12acd4b466b9278b47.camel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0032.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::45) To CY5PR12MB6201.namprd12.prod.outlook.com
 (2603:10b6:930:26::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6201:EE_|MW5PR12MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: 56c424bf-b2dc-43f7-eb07-08db4cc77573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DN3co7dgSVdK+Qn/NBAIOCNNINIG0hT07XrJYWxbEHCx/3feMqOV3jlz7Dw7YB1hwCY6tJHbxdDKmnYYNb3MqakxjXhArPeEHbSS8904HFLQC2e6FsVKnrKeGNDF9w+sl2HL141TXl+dtQxzEQrNady/c3MH6MTp5t/yuC2e8bKvq+0A2fiyR80duo4cv6jivnoePEQfZeO/ud28sYiRMLqZYyg9+v0H+JxW8+FmKVk/wWI9GTKXz5Sgc/XKsxQkAoNfKnDca+EQRW0JmytKIjeAEzQBrRUo3TAGY8+dYgUDdLN33kdgh+vjA2PMNdemxicEiBarhIGmKkhlF6KRS57HWJM6I2Lh+Lp25KDiCbl8t3FB7lgQ7wy/rDinJmXZ+sr6e0kksB6YvQs4c20BMIGPYP8jm2BWIIQpqQbuJaDeNoYVx8TyPm+4vJX/nVBkbMrepruPpaKR7dD2JOiFI67NaNQQ6aJknTc24eMaNXSOuDWiV8yH/KfQEWRpsXfKSsUaY8fONI2Hlr1VQ/rgSTfwydYkdlpiKOLGnd31taJtaRXp/4dVut1n/rHCNcKj5XW2wPYNsvJSLoyHs+K0ovaH0TitGX175OE7OcxlDJXBSnVtjOacPWdpSPwMWtDuTdYo7gsLGaSpRdXliwqY1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(6666004)(6486002)(83380400001)(6512007)(36756003)(186003)(2616005)(31696002)(38100700002)(86362001)(6506007)(26005)(5660300002)(54906003)(110136005)(2906002)(66556008)(4326008)(8676002)(66476007)(66946007)(316002)(8936002)(478600001)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTRCVkRuVDl5VFc4QzJmT0RVUlorZk9BNjdyclZZY0FoNVNBZG96bTFNeUVj?=
 =?utf-8?B?Lzl4dnQwdDY0N0VKekQzcEViKzRmNHhtMm01SjhvWDhaNGVOSUdBL0c1b1pm?=
 =?utf-8?B?eVJWczVyQjk4RlJoNWlwdUxqUDhSZzFCNFR5MlJ0SGZHb2tqRmY3V2VVWkc3?=
 =?utf-8?B?eXdpaC96TzlJdUIyYkFrQ1RhaEthMWRvMWpwTW9ObWVmcHBxcFYzQjloa0w5?=
 =?utf-8?B?OS9LS0EwY29vdDVRa0JCYys3WW4zWXZyUEpFaGpreDRRZWltM2RyUU15bG1r?=
 =?utf-8?B?cnpMeWZiRC9sZjdBSEh6am5RT0ZDem5BamthOGF1clZqZmp5MFl5WXNGTEo5?=
 =?utf-8?B?YnlaaFZCdWdGL29RcklSNWwyK05VUURkTHBSUFh6M0NYVDNlOHZOU0JwR0ky?=
 =?utf-8?B?UWY0dUFySG9WRDRSSHlkM1R3eDBCS04zL0pvNXNPU0g3dzI2VXZSRHlzNzJN?=
 =?utf-8?B?OTNyblorOGZET3RWK1pRYW1pbjZMZnJ2NG9kbFIybGVPY2o0cFNMc3h0bWND?=
 =?utf-8?B?WGg3Q2gydW4rbXFOZy8xUWkvcnJXU0ZOZnlCaEtacTdzUmtSL3ROeWpTRU1p?=
 =?utf-8?B?UlJGVUw3b0p0VkZaKzF6dmJBbTNGY09Tamw4K3F5ditxNmRtWE5CbUI0c2Ex?=
 =?utf-8?B?RVltQU1OYVhFeWVPZXYxQmdNdmRxNUNGTTVDSFZTYVdTNTkxbFJ3TlJXTzdM?=
 =?utf-8?B?TXJleE1MS3FUZWE5R21KSGtITUI4Njh3YThwM2NoRThBTzNjNW15ajRTZzEr?=
 =?utf-8?B?ZmVNMXhRL05MMkdoUUtRQTBuTjRPQTZ4bUk1d1I4YzBZSElSaUMyZHNtMStL?=
 =?utf-8?B?QWJneXZNa0RVSzJTMTFSaWI3YmI0T2JmYTlpMUNCYlp6UlJUY2Rqd3pKWVhE?=
 =?utf-8?B?bVBCWldOWnFtVFphbFdzMFdpOGxkODhwVE9Zb0ZZeVppWEpZTnE1TGpWeVBU?=
 =?utf-8?B?NXRROFIreG55Q2x0cnNJU25MUkZzWGlvaVUvUXVqYlhWa0ZHZ2hRKzFwYU1s?=
 =?utf-8?B?eTVTY0R2eFlJcU1JMEMvcUdnZkpzMEg3VHovUVA4UU5TUzJKc09YbjNLa0F6?=
 =?utf-8?B?N1llbi9JQ0sxdmcyZE1nY3poeWNObnM1bU9Kb0g1YjBORFNGYTlCUGNFeG1Y?=
 =?utf-8?B?dW40TisyeGdkZ2c0VkM5eVQ5dWtsRVdpSkdWaDRwYWxvWUlLQUROSTFPZFpR?=
 =?utf-8?B?ZHFtUGR4aDZxeDg3QXN3UVFvakh1NkRNZlYrNGt5aHR1YlgwOHh6MXA4c1dy?=
 =?utf-8?B?aGdQTFdvN3RVVnB1U3J0VVk3MUliODhocU9FRDQ4SEppbHdpOFJweUpoYUtV?=
 =?utf-8?B?a0hqckNNUENxNDZxb0dWVnVXNTU0YkJPZE1hZ1hoUEtyRVlNYUN2alVVenk3?=
 =?utf-8?B?akVnOGNoZGJUTlkwanorVVlyeHRjbGJOTGxLVFlqY3UxaER2bFhNUjhmMjgr?=
 =?utf-8?B?VmJ2MXBabG5GR2RkNWREdnpIZUVrYTRFVjFGNGtLeENmNHZ6dVFaeUdMRXRr?=
 =?utf-8?B?UXZGdWw4YkkvT1QvNVJzcVpVVWpqZG9mVzZCaExVZWI0aGhjcmpsdzByaXM2?=
 =?utf-8?B?WElIS1E4cm51dFlleWxNc2xIaVY2cHlSTm9id2cwSTc1UDBFNmo4bFhZQlBp?=
 =?utf-8?B?YjBpeHJ2eFJyS0ZhUEJiQklIc2lGYUZKUUJONXFVcTRIYXc0L3F2VDVrekJM?=
 =?utf-8?B?Y2JWVUxoUmVDZit6Mjc1YU9hTGdIQWV6eUlqZ3JVTElIc3dyZitlR2RSVlFu?=
 =?utf-8?B?cmtCWUhSbGhxNVc1SWtrR3daNjRKcXZFNndLYW1jUjBDdXZOVWRRZUlJTlJ5?=
 =?utf-8?B?NjZxZFY5RTJnVWJUVVRKbEdnWnAyUjYrVDRsdFVnRkV0OE1ORkdoL2QzWVpT?=
 =?utf-8?B?eVdnWVltb2tmVEt4REpBOGxXVHlqZEUramZLb2RTVkFYODlvbWRodFdmdWNm?=
 =?utf-8?B?SDhLQi9SVmdWa2ZSM1ZrRzBGSTQ0WVZHbmtoNko3aVJJWkVsWm1xR3d6MmZZ?=
 =?utf-8?B?amVVT2kzek82YS9VWjhZTWFoaWRzcXVSODB6RXhZbkE2Z1VSUldWU2wwRVEy?=
 =?utf-8?B?bHZWQXd2NzBibkpmZEd5d2NxRGhwM0VnZENvcVJ5cVdtREU2MzQyK0x5SXho?=
 =?utf-8?Q?2e3l1NBkHnK/Qkwgr+xCOump2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c424bf-b2dc-43f7-eb07-08db4cc77573
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 17:46:15.7093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+lC3JWMfGVP4dtlulyBQOf6lchHug0vferAnmvlXTkInDENGo0nuKiz24AcBa6DyNlGHzCqM8/EUdBCj5QG3w==
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



On 2023-05-04 p.m.1:19, Dragos Tatulea wrote:
> On Thu, 2023-05-04 at 13:08 -0400, Feng Liu wrote:
>>
>>
>> On 2023-05-04 a.m.9:50, Dragos Tatulea wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> The referenced patch calls set_vq_affinity without checking if the op is
>>> valid. This patch adds the check.
>>>
>>> Fixes: 3dad56823b53 ("virtio-vdpa: Support interrupt affinity spreading
>>> mechanism")
>>> Reviewed-by: Gal Pressman <gal@nvidia.com>
>>> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
>>> ---
>>>    drivers/virtio/virtio_vdpa.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
>>> index eb6aee8c06b2..989e2d7184ce 100644
>>> --- a/drivers/virtio/virtio_vdpa.c
>>> +++ b/drivers/virtio/virtio_vdpa.c
>>> @@ -385,7 +385,9 @@ static int virtio_vdpa_find_vqs(struct virtio_device
>>> *vdev, unsigned int nvqs,
>>>                           err = PTR_ERR(vqs[i]);
>>>                           goto err_setup_vq;
>>>                   }
>>> -               ops->set_vq_affinity(vdpa, i, &masks[i]);
>>> +
>>> +               if (ops->set_vq_affinity)
>>> +                       ops->set_vq_affinity(vdpa, i, &masks[i]);
>> if ops->set_vq_affinity is NULL, should give an error code to err, and
>> return err
>>
> I don't think so: the set_vq_affinity is marked as optional.
> 
Yes, I see
>>>           }
>>>
>>>           cb.callback = virtio_vdpa_config_cb;
>>> --
>>> 2.40.1
>>>
> 
> 
