Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127E9608D30
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 14:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJVMcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 08:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiJVMcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 08:32:00 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04DA2AF65A
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 05:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666441916; x=1697977916;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+vjIbnoMKgyGrNxPpfHtGZFxi0JvcBCo12E4Xx8x//I=;
  b=IfZHi97hWKfrHD7HqsIsps70peUM6cRZSQudF3ku5aQzc+59Rf8Ca5SW
   sJntfdQVU5rVUxLJkS2eTlfQkS87H8HN+NhJUV35zNS19mrUvekEQTZa0
   cgRrr1kh0m+HgUwCXTvIImzpAwbqH4F4dX9TfEngqUsNbYVeW/0fiC4sv
   87ZLaeHmWAFVOjjuwdSaqQJ7InaEpH6IvzvDnvwEkKSPLu2ef7mTl6eXq
   rMgsOBPEUaUyN0VK2RjaHEMSPhLqPAfwxnCwzUwo1IXeHL81aIgU5sE6T
   wyVi59PVFbZixronjTMDTQhYtII0XK15IWTSd1GhivfKcBEUcZ4KmXkFx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="308277616"
X-IronPort-AV: E=Sophos;i="5.95,205,1661842800"; 
   d="scan'208";a="308277616"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2022 05:31:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="664059268"
X-IronPort-AV: E=Sophos;i="5.95,205,1661842800"; 
   d="scan'208";a="664059268"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 22 Oct 2022 05:31:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 05:31:55 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 22 Oct 2022 05:31:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 22 Oct 2022 05:31:55 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 22 Oct 2022 05:31:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpwIBhG+8l5wvvgv1Pf6pgG0CxmKJqOcIpqQLTnCfnY+ipByMKBYPACdb0VblIX1QDk5aK/i8csQ3QTFYYunb4a2zcDxcHQ9to5TS2Ngm8hVNWW2gvv/w1BS8Ld+AwVSXSycBmsNf+HFZR7xoWXbCfXgUPB88wHBq0FLyZ4D1vwk9QrtE+i2J1WNgCKXwbNNeswn6otcabhv1TbjbYgx+pOUJjgQNkPT0JYSWOPi+mnK1VN15x7wtSQ0d2IpCsFAA4pI5x0s2GJ7PIlsAD2AOUAkibtwFwfiNiMWkt0ortQ3NF+gtUD4+/I2785yYPj4pxKAhbAL80KcZwEySSMK1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZkCcLUWnvx+SPCQ7kLqmoiohkutCANAFcE1thZHslY=;
 b=MUUYmZ6UJW6943XtzheMUR2cGvpNHQS6JMGB//4iuGbNofHsLrljJXsOxoMSpEQfFLB1IHeCzUDCpqzK0298E7ia+dWOXcVfAsBWCyeUf6kvWQXkEM8+SpuVIs165ACr/hhajf3XybLOo9WYQK18J+I8rurgyDCoHUBy6Mcn1R8RwQqQQqyrw8rIx7tXDev6uvyduN96CvpA2/5L1HGGFSto8I//sfIBh7RxUUly/feG8SnStc0cBhJLwWU5a6d8M8+bZ3p6KyDU3hwmNHbRiy8wz4zIADqC2ZO9WSBe0dAL/9XBmr3ZqyJh+4zd7oX0O8ZDS3bwSayYIuILrJdiwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN2PR11MB3870.namprd11.prod.outlook.com (2603:10b6:208:152::11)
 by DM4PR11MB6263.namprd11.prod.outlook.com (2603:10b6:8:a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Sat, 22 Oct
 2022 12:31:53 +0000
Received: from MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::14f:c677:5f1c:bbc2]) by MN2PR11MB3870.namprd11.prod.outlook.com
 ([fe80::14f:c677:5f1c:bbc2%7]) with mapi id 15.20.5746.021; Sat, 22 Oct 2022
 12:31:53 +0000
Message-ID: <0ad83d0b-7b71-7856-333a-ec64ff5360aa@intel.com>
Date:   Sat, 22 Oct 2022 20:31:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.13.1
Subject: Re: [PATCH 2/2] virtio_ring: use helper function is_power_of_2()
Content-Language: en-US
To:     =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
        <mst@redhat.com>, <jasowang@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
References: <20221021062734.228881-1-shaoqin.huang@intel.com>
 <20221021062734.228881-3-shaoqin.huang@intel.com>
 <bc131c94-fc41-a7f5-c378-12742de677a3@linaro.org>
From:   "Huang, Shaoqin" <shaoqin.huang@intel.com>
In-Reply-To: <bc131c94-fc41-a7f5-c378-12742de677a3@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0182.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::20) To MN2PR11MB3870.namprd11.prod.outlook.com
 (2603:10b6:208:152::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3870:EE_|DM4PR11MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: a88ed18c-ce56-4e11-2567-08dab4296663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7pQ6eKXS5ZMeBxwzBMv9hWNINdGExzPdPDTiJQxBP4KEIaraF/dPBOaqEXzPcuMvbAsmol+3xTI+sdhSWeGOOHfeCNTYmK3x+9j/O2u/O0pUy3GAeuK93ahQ62eyJabR/KZjD9ZX20ZEC5MkIemEZcfk/D3UIvgRFLkJlBS3hFiwueC5FpYHfHDqALRIYRBlkiEYY2d0POh6q7JR6yNtv1Z6TUJwBAaBlWNtQC/IKFQWZ9981gZraITa4V4ObyOMaDb4qtleV643kq0U2zQlwi7k6a3uWN/reC4SPYXAcn3MDYUwUEs1/JRfVOehOn+kXXt5lB7ZJs5BELIVtfQG+RvwtNIpR+gSFULw4xV8iPeKat+cjDf4okDD3HC0hTSUnJdNwUfwQE5IttebIMzpXcuB4mgOWnF7UyxnbNUXSVGwW3a8rRRvF0wq8S0DAmO9FKs54dfuipK7xZdZ4thVa6B2EM29UA4NXLLmpffF8cC/BTpit2LyExjN8wZI9K3q2Il59DnKo53GM3/aOP9QcyIedY7wby526j4/W0HqSgmoXURG5/TAx0ZvRN1lVu3Bx1AvVJ0rOXgnkhITH7M1JX5tedwv7R3BDeFzWohHyjhe3tO1qpNs5yn1QQhwe5QD5chwYUlCLEDmSXAaiI7LKORiRXpwI0HzqJ2o+S3n5eXx3ipGhcxb8osg9kXmfSGSShifmq8NHdivp0YhP7V/llx2CxfR82hn3mur+e0kAhCU79juipPXaLfJToo7sCKt+w+BwRjecq0W+7bnuyfNpX7yvqIAkq/XsvtGuj0IsM4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3870.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(39850400004)(396003)(366004)(451199015)(82960400001)(478600001)(38100700002)(6506007)(4326008)(8676002)(53546011)(66946007)(66476007)(2616005)(316002)(186003)(66556008)(6512007)(6486002)(6666004)(26005)(31686004)(41300700001)(8936002)(36756003)(2906002)(86362001)(83380400001)(5660300002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkZUY0MxcVBIM0xpcTlxd25EZ3IvSlI4TzFlOGFkM0VQdE96TTYwYThkdXFW?=
 =?utf-8?B?a3FsQ0pVTkpjVE81RDNTeEFNTEdkS3dMYVp3UlgxWHhnK1ZyTENTUW8rYk9N?=
 =?utf-8?B?Mzc4Q0JiVisvbkJDNlJ4d3hwVmJQUXJ5QlhsR1k5WFBidE1mRS82bGhKQWU1?=
 =?utf-8?B?ZzQyalFZaDFGNlJUQWZTQTNHeFVjaFlLRGNNRldJOTBSeFZ4Ri9YTGtVQ0hJ?=
 =?utf-8?B?bU1heWRCQ2FlS1VpY3VvQUg4MHRsZ0hUSDBIeFNWWFpEejd5T1hSQjBuMTBp?=
 =?utf-8?B?Uk9kaW9yUXpRbm9vREtaQjZRMWE5US91d29kOWNmZFNleXhtQng2dVl3dnpZ?=
 =?utf-8?B?VzFXSWxFU3NiaGRTUHJHTnlSRlM5OWlMck5uM0NueW92VnVsOVhnZEFwWmt2?=
 =?utf-8?B?bm00SlRFWXJCaHFleFVFNFQ0TTc0MDlFeU1MdkZ6SGxZRzNDYzJnV0JFZElj?=
 =?utf-8?B?WVF3M0cyRmFUc3N2bDlCZ3QzUmJ3a3pZUVJYUmRlWUFFc00xejIxbnlyaS95?=
 =?utf-8?B?LzVHNVlvOUFValdha091UlVteWVrUVpJUUVQWDhCcmZiRXdKbEk4MDd4OHhl?=
 =?utf-8?B?UUg2aGtscm9lTDkxeGxJb2VTN05ITHNnTnlaZGJGbEU5YjRhTmFWWCt2Y1RF?=
 =?utf-8?B?L21SRjBMRkNTaFFjWjZqdUpaRVh6WWVzR1RCcThRSk42Q0FjYXh0c01lWkMy?=
 =?utf-8?B?VnhhTHA5SU9Hbm9KczNaMVRlL3JSWnFDYnNiMFdYcnlCWGNmMHJuZkMxb1F5?=
 =?utf-8?B?MGRWbFJ2a0FucHd3MEYvNVV3dnNFL2dFQlBmc1NQc1MzRlVCOVE3SWtzampn?=
 =?utf-8?B?UEJwYW12NmJIZHd4bytlNmdLM0FlVDVhL3BGZ0RUZ1J6Sk9jMExrcS9WTXlY?=
 =?utf-8?B?TnJHTDRBYTdIL0NJY1g3dENqelV4YkRRNFM1QzNxQnhyUFk4QzllSFRsTjhr?=
 =?utf-8?B?LzdyWCsrVXRwei93elZISytieEl3S0M5YmEwM1lROGVGREE0Q0dDUStpTHdB?=
 =?utf-8?B?OTZ3dGNzTnd2bHo2Rzl4R0JGeGRPbmN2Y0tWcnIzenRuQWV5eFNMSURzYXdi?=
 =?utf-8?B?ZnNwT0tLUVo2dkQ4cFpxMVhjQyt3dzNzdmRPdE9TdlI1M0p0NENabTMvSTE5?=
 =?utf-8?B?MjBjRmZ5d2hjRCtSLzhXU2JsRW4xdHFPbm1sWGVoWDhsWVpHMWJvRmlKUTV0?=
 =?utf-8?B?LzZzb1dJVHRNN3FMcWFJdXJCalh1USs1dERnUnkzdTBiRm8yOHl4MDRSbnJW?=
 =?utf-8?B?bUpGdGR0dU1tQ2h4dGdhWEY3bS92T2tBa2dqMzdqWENvSXNhVi9vNVlRT3BV?=
 =?utf-8?B?N1JFTzM1WDAzN01FenJJMTZZL01DVldpY0NEc25MYnpudk80Q1czZFRnSHVi?=
 =?utf-8?B?NnY2Uy9SQlFkV3hnNDZNY1BucWw3NEFYRDFPbVhIamc3RDU0MWJGMXMvLy9N?=
 =?utf-8?B?RS9WWFpTcnRFUDZMYzFtU1dzY3pSMG92ZndDQXloVGxlQVRnQXBtUnhhRWtZ?=
 =?utf-8?B?RlorVUFpckhvNkhvNWJwZnRlUTgzc1lPSnhWeE9xclgrdnlvdGVvRG44QklK?=
 =?utf-8?B?U05pNWFXMmZzWHE0NjY4QjZvWTA4bGlkQnkvVUNXdTFJTjVHOG9WWTRvQjRi?=
 =?utf-8?B?Qm1kSHBiVG9Yc3hHWitOZU9jaGxHS1k2Wmp6cjNTeHVHQnUxNEd4RjVaSTRh?=
 =?utf-8?B?ZUc1VklaVXJ0MnVCNGNHSGhDRDJCTkhKbzV2WXdJdTNkQTFaMHIzQTg1TkpM?=
 =?utf-8?B?TG8wRTErZnRBNlQwVWd6NERCOTQwTVBrM053dncxUEYzU0Rsbjd4aG9nb3dK?=
 =?utf-8?B?RjhmeEtOWnhmUHZJSnNid1BIYzZoWkcxeXZVY2YxNHNSTUwwSFdCOEFNU3dT?=
 =?utf-8?B?YzFiVDFsenJwZG16WjhDUmE0QnNGemc2V3RKRjFLWmJYOXNlbHNoYjhoaUxF?=
 =?utf-8?B?eTRxQXpSQ0ZQQlE2MEV0ZE9LeW5FTmlYR0l0c3lTOUJXdGt5VWtFektocXJh?=
 =?utf-8?B?Q0xlZldwYUhMdHZvUjFEbHdwMFExVGRkT1J1emo4NjFKTUNWb2t5dEFremJV?=
 =?utf-8?B?bXExVXhzdG5BWUt6dFVEVXNHSnA5QTh4QVpmRml4OVIvS0FsWFdUZDlWbHZy?=
 =?utf-8?B?VHFyTzBERG1LcC9ub1pFN3dYVWY5dHdIbzgxVUltdHYwZlBQYnFaa3NZVEN5?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a88ed18c-ce56-4e11-2567-08dab4296663
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3870.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2022 12:31:53.4841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4dG6uc3Q5BZWvUpr3m1e5Z1j9T1szV8wKwhRzzoPsa3Te4TRqQA3tT6hVDc/LEJi95kfCd6YH3cszlOuNgi3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6263
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/21/2022 4:53 PM, Philippe Mathieu-Daudé wrote:
> On 21/10/22 08:27, shaoqin.huang@intel.com wrote:
>> From: Shaoqin Huang <shaoqin.huang@intel.com>
>>
>> Use helper function is_power_of_2() to check if num is power of two.
>> Minor readability improvement.
>>
>> Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
>> ---
>>   drivers/virtio/virtio_ring.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>> index 2e7689bb933b..723c4e29e1d3 100644
>> --- a/drivers/virtio/virtio_ring.c
>> +++ b/drivers/virtio/virtio_ring.c
>> @@ -1052,7 +1052,7 @@ static int vring_alloc_queue_split(struct 
>> vring_virtqueue_split *vring_split,
>>       dma_addr_t dma_addr;
>>       /* We assume num is a power of 2. */
>> -    if (num & (num - 1)) {
>> +    if (!is_power_of_2(num)) {
>>           dev_warn(&vdev->dev, "Bad virtqueue length %u\n", num);
>>           return -EINVAL;
>>       }
> 
> This makes the following code unreachable:
> 
>      if (!num)
>          return -ENOMEM;
> 
> Do we want to move it earlier or remove it?
> 

I think the following code can still be executed if num > 0, and if 
there if no enough memory, the allocation of the vring will failed and 
will decrease the num by divide 2, this will makes num equal to 0. And 
then trigger the check and return -ENOMEM.

> Regards,
> 
> Phil.
