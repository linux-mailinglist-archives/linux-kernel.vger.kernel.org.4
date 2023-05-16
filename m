Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE415704DF8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjEPMok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjEPMoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:44:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCB4122;
        Tue, 16 May 2023 05:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684241077; x=1715777077;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CXpvYnWfNmrqPATRiUnd01zyP06EI7/8+EoFJle6UVQ=;
  b=RBUmMTAzLxGfXOBKyaWfu4oYLE0WtDxSn4nR5K7/iP/hpc5IFcGVuSIK
   trow6ITquzwF7qW7U43yhHohQ4+SFNewqJBn76Ky+bqcrdm7I98qNMAIx
   cY+894X5QrHVBfpgzrFscjquwpuT8nczxbLm6365xVQLbzr9iRxyyXq21
   Vi7OamZX2eIaRFl/VXs4bptID0E9PqNK9o1B9KhWqWW6cg4pWnMl1Xftx
   He6xfRYZ0Jy8D5QlNMvgMBreuhkOsz2K/AgLEoI0zXQ0ATK15BEvnfArT
   RTDKdcUbvCtUxe9kn5UtwqlixHjk137JDp8Ow+ZNg4XNDvLkwTCrzFgbP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="353746696"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="353746696"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 05:44:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="791063664"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="791063664"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 16 May 2023 05:44:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 05:44:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 05:44:34 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 16 May 2023 05:44:34 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 16 May 2023 05:44:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pbh4XjFu2pzHC4KuKFjP3Edv/gs0Qw4mbFsCGjOFbt67gZ9Chbk336+/hSQ3OyLTtxF2DpzMQfc7JIunQY3K6+cgAK317FoUck/2VvjFgjmomWx3Z7wT2Yg5OtITL6PWeGvCwK47WfGM8JIIVsOtDFVUprD/O7Xs97zlTegPrZq02FiTomOfh4L2A3lh6MeXTjtGc7uwhxnf6EUTDUHrKd28/arePCldHtoNI7NpVF884WlRzub2chIJQQ2ZO8VDQ5PC8TWcWW/ncPAPAphGmvd1CIZ6MCTo8SrEsvtAI2Q7wgLNLceLWYOyMpK6gff2H78KRp2r5/fXumokXhYImA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SorGGaASahStuXgpOcpXM91eloIVK3GCbOTi7W3jSBA=;
 b=L6YedS9qSk4iUMWsaMqcrJ7xQlzxQbbAoP2l5TZyZ98v9FvrCwBiwJ2/xcxqanwJ4p8NpzyVyvbs8jGlWtFwf2vf8WFq/cmg3JoJ+x2hQ+IMwagfYsq1tHhwLlAnR1d1spJhW9J8ZZ1by9nqFEhb1Z71vKCsj+y3idjKF0SqLCe5wA3AW2nC2djzjzLQmw8Er6nGVRYOA13murth9hrhulWuJxhCwYuiDPhXDxaSmtlpp5SSA+eUzi6n4HxIKNcIoAyJGn/TiS7jDb1sLceMtMZkuEfbG0XRRngCAQCuDsjGT4bImBKsMkHv2dUv3bV6b/qQtWKRE256hTcku5Uzxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by MW4PR11MB5889.namprd11.prod.outlook.com (2603:10b6:303:168::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 12:44:31 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::64d9:76b5:5b43:1590]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::64d9:76b5:5b43:1590%2]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 12:44:31 +0000
Message-ID: <45db388c-781b-b6e7-ca9a-fc4526f8fad6@intel.com>
Date:   Tue, 16 May 2023 14:43:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC v2] Randomized slab caches for kmalloc()
Content-Language: en-US
To:     Gong Ruiqi <gongruiqi1@huawei.com>
CC:     <linux-mm@kvack.org>, <linux-hardening@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        <kasan-dev@googlegroups.com>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        "Xiu Jianfeng" <xiujianfeng@huawei.com>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        "David Rientjes" <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20230508075507.1720950-1-gongruiqi1@huawei.com>
 <75179e0d-f62c-6d3c-9353-e97dd5c9d9ad@intel.com>
 <fe79912f-3232-ffba-a191-477c80c703f4@huawei.com>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <fe79912f-3232-ffba-a191-477c80c703f4@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB6PR0801CA0060.eurprd08.prod.outlook.com
 (2603:10a6:4:2b::28) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|MW4PR11MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e300578-bda1-4d54-76b4-08db560b4b14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yV6MR3go9pXgV/Ix2WHuXi7xcjgeYihGdd50+9g/gKQCWzawTAFTst/jU+gtdlFif/+41QFUSsCG4A7U4ycr8ACyGfM4WYD4zkyTSfhkZXlI2ZZBVCiKaxjN0nwzgd2HJ///RHQqfwbQVWsnOq3qS6CyEXGGvIeUqiz5JBKEBg/4L2BHJfogt/g+LylmYZxT0mSWUIe0xFbY8eFOCRgRZMc2eMbD2KCbcPLWc+FhZBy5xfg+wYvAkIvj2RleMvLiMt+lVPOjVSIRBlye8f+1XY0p1CfektJ/Fjh7tBN2TT4QqSzYw+3vpu4RK9P3rM9uy/qHOqTTouyICzyuoYzyABns3pkhInHuhD5yiUgdBlZa1q6aYDp6l1dMo6d14eE9niYONfeRiigkYYoXacljTlmncB2NjpepdEjS9x2QE/AjMQDEAcWZ4d3KQTXD16QuURGbFI3WBoMhOYSdp5S1CcO0IdozQQ9ZSSN8UadOEraOuh2iVB9n1QaWEdKehNpLBigWt387oZT/p5XPRJlGm8aupZaUrdBIhTYbmHECvbHpbCq76jd1tkbH5Pe/hIfAhrZDy8/pRaDSoaMyEFphXyCvEMUe8IaDQGGe8M9U2q8gBT4EA+E7X8QqCYmS9abZ9/CJqS5gzeUBaxEoVAS6ng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(31696002)(36756003)(86362001)(966005)(54906003)(316002)(6916009)(4326008)(66476007)(66556008)(66946007)(478600001)(6666004)(2906002)(5660300002)(41300700001)(8676002)(8936002)(7416002)(82960400001)(38100700002)(186003)(53546011)(6506007)(6512007)(83380400001)(26005)(2616005)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHppTk9SQWNQaytkcGhycWhtRU5wZGgweXdkWWRLNUh3YUZqRTN4bms2Yi9s?=
 =?utf-8?B?Mzh5NW0rOG9tUGYwUEpidHYrSm1DNkoxbi94R1JVVU1oOEc5bzllaGVOWkNm?=
 =?utf-8?B?MlB4Qnl3c2Zkdjl6V2drY3pFNFZOS3hQRlNKUDdVMEhFQUx6VU1xMmhZTWpX?=
 =?utf-8?B?bTVvWmJxZVdOQ0piU0xPa2JqZ0JzVHlGSnNhOHdxOG9YbHpFZ2pCZFFSVDdN?=
 =?utf-8?B?cDQ4dHlYT3RYVmxNVUJSWnZtbW9NeStlb0RRbDRoYU5GYW4zTHhLMUFaaWVn?=
 =?utf-8?B?dFVMTlJXdFhrRXdPZTZPMDdjSnphVlBlLzAyZVp4cFZHa2FaSGFKcWtiNFdU?=
 =?utf-8?B?S3VEdGpxRWhybjRQZWJ4MmdqYmtpMGJHeVN1Y2ZuVXp4b0h5K203YjBLOE8w?=
 =?utf-8?B?T3loNzZKUlFCRXJLWnBtcWxyOVdOZEI0MktPY1ZQUGcxVWh6U2RjRm1pNmxB?=
 =?utf-8?B?bitLdWFNOUdHNWtJYkZkakVjaHRnZjJlSzVhOGE2TkVmQjVLUkF5VnptdUhs?=
 =?utf-8?B?NFlKY2ZGSUFCVE5wU0hKUkJURjVwb2JFTUN4U21jWTJnQ1M1YjNxQUsxemM2?=
 =?utf-8?B?a25ZUEtldUhibTU3RHVOOTVESXhRa2pYa25Tek8wZFR5c0xrNFFOeEpweXdv?=
 =?utf-8?B?WG5QekZzQm5lMFBDa3hQSmRobm1UMU5oSzdlMXQrSDVvcXdiNFZkbWJBVkx0?=
 =?utf-8?B?bEZYYmJaMzhibFpyNmY5cTd0VjhJTURVcC9QblgxQjZvakxHeVJPTUVGaVdo?=
 =?utf-8?B?eE91R055Yjd2dnk1YzlaK2xudnUyNCtRbE1WelhYZ3BtR1Q2b2hQdmRicnNo?=
 =?utf-8?B?SVliSFhkbStnL1oyNFprN1ovMzE2aStTbHRhd2tBSDB5MjBzbWFrdGt0OXNP?=
 =?utf-8?B?bkVmcHlScnphbzhRTEZTdjgyOHV1UHBBTklVZnhQYjNpTW5heUlXTHA5b2k5?=
 =?utf-8?B?bHU5QXpjeWR2K1I2MERqUGpaMDNpZGVKNkd0aWJiUlJuT1BlWjlpZkxGeFdV?=
 =?utf-8?B?UllzMWpQK2lrcFF3NUNjMlVHeGVJRU1jaUFOWG1DWU9aSGwxZDVxT1Y0bjFE?=
 =?utf-8?B?dGNVbDUvUTFGNDFXMld6WDU2NG51eEJhaGFldHFUT3NDN1FZTWFvN3RaV3Jj?=
 =?utf-8?B?eG12RGZpdUREZnhLSlo3bkFRYXlWOUZ4dGx4MmJKTWtDR2NVejh5RWo5VThU?=
 =?utf-8?B?KzZUa0ZlVGFJc2VNWnc3TnltN2k2b1J1blRLWjhOZ3lIdjNhUlA0dU1SNEhM?=
 =?utf-8?B?TUdxQVBPNVo0Qlp4ZHRObDVNVTFUSUlzT0s1M25FdUtycEpMdkJ2SWFxeWN1?=
 =?utf-8?B?dXJVNHZHMnZMbHVvS0xjWlFRaHhaVGF3OHIydjJaZnRJaEg2Skk5MkQyYVFV?=
 =?utf-8?B?azhQOExQd0ZIL3g2bjRXVlZEQVk1UlNBZDJ1S1dMQW1zOGZxQjY0UU9wTHgy?=
 =?utf-8?B?TUJvYnFFVUViOENoa3VpVUxSMml6R1FvOTArY0Irc1dlVUhXK1ZRNFExQzlE?=
 =?utf-8?B?SjN5c0N4dGJvZW02YTEzQjRlT1cwUi9XcHduelhSb0hORXkxT0ZmZG5KM3lR?=
 =?utf-8?B?cnRIWnh4RytybTZWVXFrc1BONzUxVkt5WFlpVUZZYzk4M0U4TWhLNkpQSGhp?=
 =?utf-8?B?RTNwU21IbWttUnFRU2tUbGxiMldkLzB1NkNXSmJXckJpb1M4anlMcVI3a09p?=
 =?utf-8?B?R3pTY3g1d0tYNkt5TVhqaFgxeHZJVTVvdXBidTYvSGNDeURLdXFjaEExOXBk?=
 =?utf-8?B?Zzd3aTJkMWVaRjZaa0tFaE0rcHpZZnB0L1pyRzRHUzJ1U0VUcEJuZWRYbmt6?=
 =?utf-8?B?dERlOW9uenNRd0IwWngrMC9qOE1FcENLWE12SkFFa1pwYnpOd2lEYzNVd21t?=
 =?utf-8?B?T0lzcEI5bVVHa2hLRGNhREdZSFpZcW9Hd2FTcC9TbDRVS3ZjWVpLZWdkUTNR?=
 =?utf-8?B?TjVTWFhpbGNEaURManNsbWd3ZmZJeW5SajFVYmk0ZGxqbHVENi9WQnJrOW5F?=
 =?utf-8?B?UTgvL3pOTlkxaytDQktmQjByVmh1YmJjZ2VoN0ZKZkJJRVNGSGZ6SC9KVjRl?=
 =?utf-8?B?TnVDMXRNa3VZRHQydDRwenJjR3NLOHhYQXFMek5QckNTUE9sWk1JVm9kSXFy?=
 =?utf-8?B?ZFZqeUhlTGF1Mk5BQlAvdGI0TGxWVjdTUzF4cjVUamZBUXR5QSsydHJ3dk5X?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e300578-bda1-4d54-76b4-08db560b4b14
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 12:44:31.0188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2XB7BYioJJV2Kxg0cIYxLje+p7Vc9k1kOB6jOIlaL+M2luG6teUqiBGQ6SRkPFkQQ905JFDppg4pr29CRt/CQHm3pBSf8HGgO+vmxw7Wi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5889
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gong Ruiqi <gongruiqi1@huawei.com>
Date: Mon, 15 May 2023 14:26:31 +0800

> 
> On 2023/05/11 22:54, Alexander Lobakin wrote:

[...]

> I tried this way of implementation but it didn't work: it did not
> propagate from 16 to 1, but stopped in the middle. I think it's because
> the macro is somehow (indirectly) self-referential and the preprocessor
> won't expand it. Check this for more info:
> 
> https://gcc.gnu.org/onlinedocs/cpp/Self-Referential-Macros.html

Ooops, I missed that, sorry. Thanks for the link!

> 
>> Also I'd rather not put commas ',' at the end of each macro, they're
>> usually put outside where the macro is used.
> 
> It seems here we have to put commas at the end. Not only it's to align
> with how KMALLOC_{RCL,CGROUP,DMA}_NAME are implemented, but also
> otherwise the expansion of INIT_KMALLOC_INFO would in some cases be like:
> 
> {
> 	.name[KMALLOC_NORMAL]  = "kmalloc-" #__short_size,
> 	, // an empty entry with a comma
> }
> 
> which would cause compilation error in kmalloc_info[]'s initialization.

+

> 
>>> +#endif
>>> +#else // CONFIG_RANDOM_KMALLOC_CACHES
>>> +#define KMALLOC_RANDOM_NAME(N, sz)
>>> +#endif
>>> +
>>>  #define INIT_KMALLOC_INFO(__size, __short_size)			\
>>>  {								\
>>>  	.name[KMALLOC_NORMAL]  = "kmalloc-" #__short_size,	\
>>>  	KMALLOC_RCL_NAME(__short_size)				\
>>>  	KMALLOC_CGROUP_NAME(__short_size)			\
>>>  	KMALLOC_DMA_NAME(__short_size)				\
>>> +	KMALLOC_RANDOM_NAME(CONFIG_RANDOM_KMALLOC_CACHES_NR, __short_size)	\
>>
>> Can't those names be __initconst and here you'd just do one loop from 1
>> to KMALLOC_CACHES_NR, which would assign names? I'm not sure compilers
>> will expand that one to a compile-time constant and assigning 69
>> different string pointers per one kmalloc size is a bit of a waste to me.
> 
> I'm not sure if I understand the question correctly, but I believe these
> names have been __initconst since kmalloc_info[] is already marked with
> it. Please let me know if it doesn't answer your question.

Ah okay, it's just me trying to show off without looking at the code. I
thought INIT_KMALLOC_INFO() is used somewhere in a function (from its
name), but it's used to initialize const array, okay.

> 
>>>  	.size = __size,						\
>>>  }
[...]

Thanks,
Olek

