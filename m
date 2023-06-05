Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1068721DF6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 08:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjFEGSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 02:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjFEGSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 02:18:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80FEDF
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 23:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685945909; x=1717481909;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4KqoE0O5/4yWynmHxJLvd06ScCoUNOVtZnNYMdjnn/w=;
  b=AdASQ/TZGEB8GWlM3w3K5w7wI4T6LyXDPAhg+cpEcwTSEo45OUju2ktz
   nUAgST4mCpFmVD7ltkOsVirk7SWkYZkaw8U/n1GVJrI0tS6vcPydXWL+Z
   hZONbjV9tS0ndn+AB7mH3IQd7vwzmWwWMSyn5HvA3ruk0qhhrwMyRiR1z
   VhEvvlGrlWrOZNP+HF0pqX94qPxNzNXgmA1zpZqpo/HF1QE6Yqx4F+tZv
   MihrHDtirZXmNwh3+sLh9pGxhiLcoiZ1uBtTmmeQ9kU/oVd1TQwevHu2a
   rBLgVw77lt+4LqV7D2bBytd4GarFWtYiPS2MqzXQ8+Ydo8Y1xc3Oo98lT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="355147612"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="355147612"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 23:18:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="741587689"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="741587689"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 04 Jun 2023 23:18:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 4 Jun 2023 23:18:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 4 Jun 2023 23:18:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 4 Jun 2023 23:18:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 4 Jun 2023 23:18:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuP6FOtTB/8YX80uZwb1Kfz28bdhaBpmtYPx2TiClS2SQFufGJOouF5+RRtqVI61YJiNq/98DwUWkoxnDcuEujOD3PcRDKUVBhX7T29GjD6x4U+gr+k3ape1QYgDIEYkXi1PCZyWvshYBgPBb8GAFBU0jZ2b0yi7LnFU/HlXQ7yBsM0+UrC+HC98bsSmFETVk0zyBaLn4T0eSRRKiWWlbYX4R2vVqayViYhDxpx1iDvl0EjWO5OXCSEqZN98dx8sekQSUJ9hjQFa2XGar5zNhj1qFxbIiowa6b1oRiIrHY5dA+WEUsKA5OepZscgUbLaklP2yKCJAPXzOgyROu41Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWssBZJVnXf+zjCtJv1NY4fpUKp80zYk0rGp7vO3RmU=;
 b=dvE9YwJaHNPK/4/SMK89dg85poM/EwIeCG+9ScHke9U190HBOxnaCJ/GysHyR12vttsNcpKCyWuddq9XgbjB58W2MXebWD+79Nwf79/j1oPkn8D/DuiRCnlKLxTEaCDjL6YQxCbuHeyi3JhpxK8nyomzZtSVJzulwqJQk8NwYdegloqnPGWwPHl4jTUdVL2RmiFnnQPUydD1rC/0cOhlOcvhtA99RYjyPt9WbP+uxCN0qGjbW7Fa8WhR4S6+PT+l5nYA7aFaTSjfMnzQItaNckjUucP3Oo3dR5s0c41qvInO58Uyk2CsRHNRbv+JrZD5kzbzAFuo+1X8Eafv9Q9HBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4831.namprd11.prod.outlook.com (2603:10b6:a03:2d2::20)
 by MW6PR11MB8392.namprd11.prod.outlook.com (2603:10b6:303:23a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 06:18:25 +0000
Received: from SJ0PR11MB4831.namprd11.prod.outlook.com
 ([fe80::469d:a7bd:ea05:fade]) by SJ0PR11MB4831.namprd11.prod.outlook.com
 ([fe80::469d:a7bd:ea05:fade%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 06:18:25 +0000
Message-ID: <b5f2d527-8887-eb0b-d3f2-4e7cd8f3c022@intel.com>
Date:   Mon, 5 Jun 2023 14:18:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH 00/14] Reduce preallocations for maple tree
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
CC:     <maple-tree@lists.infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, "Liu, Yujie" <yujie.liu@intel.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230601021605.2823123-1-Liam.Howlett@oracle.com>
 <7a5dc9ce-b58f-e1b3-db1a-d00a8a556ae5@intel.com>
 <fad3c833-1ab3-2d34-aa85-dcc7c40c3587@bytedance.com>
 <a9d2ab1b-23a5-8c06-9f7a-6872c726db03@intel.com>
Content-Language: en-US
In-Reply-To: <a9d2ab1b-23a5-8c06-9f7a-6872c726db03@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To SJ0PR11MB4831.namprd11.prod.outlook.com
 (2603:10b6:a03:2d2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4831:EE_|MW6PR11MB8392:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f48ad9-23d1-41fb-c952-08db658cabdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TS0GiysPbDD6u+wEZMX6bfghrSU0qZ6fwFnuC0N5pjHf0GwcnYmuvOG6JS0H/0b/qyALVvhVR7OiULfiXkKY/duX8NAQXH42Cgdby2NrphSOZ+eZgjKTDNRnZp3fJc4E9RLpfs2UqEQEBtEkZJiF1KdnglWEGDE/cmz6vwG5tRpHMXuRFYVI+sRONWUwCqQ092LfBrltbEV8PX5AvJBYycPGilp6+lyJNPOHSZuRPJSVMrCHuvCIFt/FB5GEeARKs5/DOpiSxUyDcoEUhsvkeij53FOKGtpBZC08YRMr9bRjDHQEHYw61pc4iEd9X1xU1pbvvAMtFOBCVFJtVz1X/v606/+GsijlcshL3y4UTSQhbP+ie6dTA2vwIoVpP/XOekKprahRbf/ZHmpzwXdgdZ+xv+WY+ZYcHnxPcvmwGT6ktPtCinMonb6eIgwS11IxIN4uSQogesCVMfoBs579NzJitLTKvYZTNxcutxv+pOe5riP6qYgcc7NQBmmfr0wMbQ/U6rsEQaLMSntbJfmTfeRRcBfTBf3zMKFgSnHcwBDLuc0QeUT8o7UgSEAi0KRQDnemc4WqWzYURf7iAaJNJ6g7nKKfoAQ4wOFSZXVhAJrR0m+fq3dVAdUn/JOJKoborqLRijOYs51QnG/ggaX02w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4831.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199021)(478600001)(36756003)(2616005)(83380400001)(186003)(53546011)(6512007)(6506007)(26005)(6666004)(6486002)(966005)(316002)(41300700001)(66946007)(66476007)(66556008)(4326008)(6916009)(86362001)(31696002)(2906002)(31686004)(5660300002)(8936002)(8676002)(54906003)(82960400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVYwaTZyZXRjb3Mxd0dUTE5RVGgwclpabEdOSDFSQnNKNUc5Sk9PVlpvRFJY?=
 =?utf-8?B?L2N2cGZvbUltenQ2OGVzYnV2T3dqSktLTEdRT2wwamJNbytXZEsyYm0wM1hM?=
 =?utf-8?B?TElTTVQvQ3hJVTBKdi9GTmxuaG5sVWlocCtETHlocitGY2xGR1cwYWF4T0Fk?=
 =?utf-8?B?MWtJV2k2UVBNeC85a0Y3bFhXUnc1Wkhzdm40SkErZFVpLzBidUZDVXAwTmtp?=
 =?utf-8?B?Z1EvZWdFMC9aK1dWaFdmWlcxUE9DYVRia3Z6ZWltWHJJbGMvem5hY05vUWRO?=
 =?utf-8?B?RzA0eWpPMDRJVFNaZjVnbW9yOGRuUlFnRkRCcGhlTzRrVEFxVlp2NmlzdGV6?=
 =?utf-8?B?T2JGOWtLUUNsODMrdVZRRjU2K080VGtxVCt0UkhxVHpXVE5YN3VGeFV4SVJt?=
 =?utf-8?B?c2lUbkMwNE94dnp1cnhkUTUxd3BsRWJaQ0F3aXhnZjY0dE5icFZlRXFWRVUz?=
 =?utf-8?B?QWN0WFBZdm4zLzZlaGZFN0EwSWpoZ3BqSWZzbEJURUtyaDM4WG5uOUVVZW1t?=
 =?utf-8?B?RjY3NnUvSWdJY1hZcFhSWmhJaHdjM2xHcGIzQnQ0dk9KVVExbHZaL0hmN2dN?=
 =?utf-8?B?bFQ2MVljNVcwdUpKejAxOUdBcFNmK2o4cGQ1czdmNWp1OFBiZldmSmlpQnY2?=
 =?utf-8?B?cmdYcEc2RWhRcVRORWxBSVFqdUZNVTU5NjN6MkFpNk9jQzlMb1kyMXpuSnZH?=
 =?utf-8?B?YUQwdVo3eTlEQXlaa1RXTENib3Z3NnpTMTNIaVRSYVZLWkdqRVFvQTRlWncx?=
 =?utf-8?B?VEpQZWxzYXprSk0zcFZYejVGdDNZdzNVa2JoNEdSVUllMmxudHVhQk43QjF0?=
 =?utf-8?B?aW9NaGZwTWd2WG9kMitkSmtUK3NjbTZwL3JkdnZ4RFV1OFEwa1c5em9VMUN4?=
 =?utf-8?B?NktVVmI2MXdhZVJNZEVEckhXem5BRzh5Z0I5M1FFY2xiRERLaW9iN04xcDF4?=
 =?utf-8?B?V1R5VHhMelVVTFFveVdvVlB3TEF4MjlGVk83aGcrcW43Slk3ek1WZ3kvU2JG?=
 =?utf-8?B?OXJsaDdRYU5hbm1uWldOWURLSlMxbFFQdjJ1RW5PZDhjVFE5VWpLUmYvb1NW?=
 =?utf-8?B?eWhROVJvMTc4MmpOQVJYVGRnWi9MeUZWejBkTTZRa052WHY5L3AvbGtSRDhU?=
 =?utf-8?B?U2VLWTFLMkhvTktrOXFRR3ZjYWVoNm14NnpHVGhQOVJ6R01wUGJLTUJQSDI0?=
 =?utf-8?B?WmZMZ3hJTEIzL0o0T3FMV3ZqQXo4N1ErMDRnc1hBOEtuNmFxWHViMmpjWlBl?=
 =?utf-8?B?ZGdrUnJ1Tks2RnhpciszaXNrWFpuNjQ2VkNTOFV0RUxGUEZpYUNxWGJrYVdw?=
 =?utf-8?B?NVg2VDdhaWpIMkxya1NzdHVOTis0TWEycVl0M3dRWXQvQ0FoVXE1amtqZTRW?=
 =?utf-8?B?cjVBS1NZaGNCdEJRaXM1U0JwbGtkWXpyVVRvOElzYmdBRk1QWUxFaE5PU1hI?=
 =?utf-8?B?Nk5jSmxsMFp4c1BUZ3Z1cW1wRTNQTXN1d1EycmNIUUluSjhhSzBwczg0OS9M?=
 =?utf-8?B?aFM4cDNkMzRqcVlnTEpOS1lnaFdycFh0cE03K0lmSjVUbjBoTkx0QlV4Z3ZZ?=
 =?utf-8?B?MWoyd1o3U29uNjRQME9PSkhydWxUeDdPTTMxcmhTOGFWUXUzMnRwekdLRVBQ?=
 =?utf-8?B?eHVKUFVTZVdpZDc1YjlGS3BBUkpQUFdUY0o1anBBSGtMeE40MUVsejhPblN4?=
 =?utf-8?B?dWYzTm5aY3JSNCtWVUVHUEJkNTJmUS9MRm5wbXJTRnFETlpCNW94dEo5cGdt?=
 =?utf-8?B?cXZab2tqREtyb05rc3BLMDUrUUp6Q1AvNVh1OVQ5MFRVNnY3VXJFeXlva20y?=
 =?utf-8?B?Mk5MSW9uV0JIZmxRcHU5WkpiU09ncll6SG01OFUyRUFQWEs3ZXUvaXA2RkNB?=
 =?utf-8?B?SW1XL1lCUWdONWF4TFZwV3A4ekZvcjkzQkV2S1IyV1ZaSVRWV3ZqalJ2dFpq?=
 =?utf-8?B?UGhnT1JsMTRabElITUd1bXJUZTlDSzNyd1RNUXVIa1hTZGhKdUtRSk9JUkQ4?=
 =?utf-8?B?QUtaNU9PeTA5Rld2aFpRUGc3cnc3ejZVSzlaelBRMEpibTF5R05oM2ovZ0Iv?=
 =?utf-8?B?bUh0S0J1ZUQvaGNFUGs2MjlEVmhWL2NJVGFwbm9ZV1kzemF4bmcveFpuTHJH?=
 =?utf-8?Q?wSJIPA6VDNfqDpJbkdBUBh53q?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f48ad9-23d1-41fb-c952-08db658cabdc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4831.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 06:18:25.7930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNKlBbK7+xv8h15uJj31TAs5octPOixcVW+2ADSm5OMqB3Eh0NrvXVHzJgoG0AzkqgJETkENZkk43bZhn+nNRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8392
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/2023 12:41 PM, Yin Fengwei wrote:
> Hi Peng,
> 
> On 6/5/23 11:28, Peng Zhang wrote:
>>
>>
>> 在 2023/6/2 16:10, Yin, Fengwei 写道:
>>> Hi Liam,
>>>
>>> On 6/1/2023 10:15 AM, Liam R. Howlett wrote:
>>>> Initial work on preallocations showed no regression in performance
>>>> during testing, but recently some users (both on [1] and off [android]
>>>> list) have reported that preallocating the worst-case number of nodes
>>>> has caused some slow down.  This patch set addresses the number of
>>>> allocations in a few ways.
>>>>
>>>> During munmap() most munmap() operations will remove a single VMA, so
>>>> leverage the fact that the maple tree can place a single pointer at
>>>> range 0 - 0 without allocating.  This is done by changing the index in
>>>> the 'sidetree'.
>>>>
>>>> Re-introduce the entry argument to mas_preallocate() so that a more
>>>> intelligent guess of the node count can be made.
>>>>
>>>> Patches are in the following order:
>>>> 0001-0002: Testing framework for benchmarking some operations
>>>> 0003-0004: Reduction of maple node allocation in sidetree
>>>> 0005:      Small cleanup of do_vmi_align_munmap()
>>>> 0006-0013: mas_preallocate() calculation change
>>>> 0014:      Change the vma iterator order
>>> I did run The AIM:page_test on an IceLake 48C/96T + 192G RAM platform with
>>> this patchset.
>>>
>>> The result has a little bit improvement:
>>> Base (next-20230602):
>>>    503880
>>> Base with this patchset:
>>>    519501
>>>
>>> But they are far from the none-regression result (commit 7be1c1a3c7b1):
>>>    718080
>>>
>>>
>>> Some other information I collected:
>>> With Base, the mas_alloc_nodes are always hit with request: 7.
>>> With this patchset, the request are 1 or 5.
>>>
>>> I suppose this is the reason for improvement from 503880 to 519501.
>>>
>>> With commit 7be1c1a3c7b1, mas_store_gfp() in do_brk_flags never triggered
>>> mas_alloc_nodes() call. Thanks.
>> Hi Fengwei,
>>
>> I think it may be related to the inaccurate number of nodes allocated
>> in the pre-allocation. I slightly modified the pre-allocation in this
>> patchset, but I don't know if it works. It would be great if you could
>> help test it, and help pinpoint the cause. Below is the diff, which can
>> be applied based on this pachset.
> I tried the patch, it could eliminate the call of mas_alloc_nodes() during
> the test. But the result of benchmark got a little bit improvement:
>   529040
> 
> But it's still much less than none-regression result. I will also double
> confirm the none-regression result.
Just noticed that the commit f5715584af95 make validate_mm() two implementation
based on CONFIG_DEBUG_VM instead of CONFIG_DEBUG_VM_MAPPLE_TREE). I have
CONFIG_DEBUG_VM but not CONFIG_DEBUG_VM_MAPPLE_TREE defined. So it's not an
apple to apple.


I disable CONFIG_DEBUG_VM and re-run the test and got:
Before preallocation change (7be1c1a3c7b1):
    770100
After preallocation change (28c5609fb236):
    680000
With liam's fix:
    702100
plus Peng's fix:
    725900


Regards
Yin, Fengwei

> 
> 
> Regards
> Yin, Fengwei
> 
>>
>> Thanks,
>> Peng
>>
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index 5ea211c3f186..e67bf2744384 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -5575,9 +5575,11 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
>>          goto ask_now;
>>      }
>>
>> -    /* New root needs a singe node */
>> -    if (unlikely(mte_is_root(mas->node)))
>> -        goto ask_now;
>> +    if ((node_size == wr_mas.node_end + 1 &&
>> +         mas->offset == wr_mas.node_end) ||
>> +        (node_size == wr_mas.node_end &&
>> +         wr_mas.offset_end - mas->offset == 1))
>> +        return 0;
>>
>>      /* Potential spanning rebalance collapsing a node, use worst-case */
>>      if (node_size  - 1 <= mt_min_slots[wr_mas.type])
>> @@ -5590,7 +5592,6 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
>>      if (likely(!mas_is_err(mas)))
>>          return 0;
>>
>> -    mas_set_alloc_req(mas, 0);
>>      ret = xa_err(mas->node);
>>      mas_reset(mas);
>>      mas_destroy(mas);
>>
>>
>>>
>>>
>>> Regards
>>> Yin, Fengwei
>>>
>>>>
>>>> [1] https://lore.kernel.org/linux-mm/202305061457.ac15990c-yujie.liu@intel.com/
>>>>
>>>> Liam R. Howlett (14):
>>>>    maple_tree: Add benchmarking for mas_for_each
>>>>    maple_tree: Add benchmarking for mas_prev()
>>>>    mm: Move unmap_vmas() declaration to internal header
>>>>    mm: Change do_vmi_align_munmap() side tree index
>>>>    mm: Remove prev check from do_vmi_align_munmap()
>>>>    maple_tree: Introduce __mas_set_range()
>>>>    mm: Remove re-walk from mmap_region()
>>>>    maple_tree: Re-introduce entry to mas_preallocate() arguments
>>>>    mm: Use vma_iter_clear_gfp() in nommu
>>>>    mm: Set up vma iterator for vma_iter_prealloc() calls
>>>>    maple_tree: Move mas_wr_end_piv() below mas_wr_extend_null()
>>>>    maple_tree: Update mas_preallocate() testing
>>>>    maple_tree: Refine mas_preallocate() node calculations
>>>>    mm/mmap: Change vma iteration order in do_vmi_align_munmap()
>>>>
>>>>   fs/exec.c                        |   1 +
>>>>   include/linux/maple_tree.h       |  23 ++++-
>>>>   include/linux/mm.h               |   4 -
>>>>   lib/maple_tree.c                 |  78 ++++++++++----
>>>>   lib/test_maple_tree.c            |  74 +++++++++++++
>>>>   mm/internal.h                    |  40 ++++++--
>>>>   mm/memory.c                      |  16 ++-
>>>>   mm/mmap.c                        | 171 ++++++++++++++++---------------
>>>>   mm/nommu.c                       |  45 ++++----
>>>>   tools/testing/radix-tree/maple.c |  59 ++++++-----
>>>>   10 files changed, 331 insertions(+), 180 deletions(-)
>>>>
