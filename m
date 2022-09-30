Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7CC5F16A9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 01:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiI3Xax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 19:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbiI3Xat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 19:30:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B43138582;
        Fri, 30 Sep 2022 16:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664580648; x=1696116648;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=06/wQ2Ias7dDHngOPPs82UV6Yh/H4ee7WMyuucTnAJA=;
  b=K8goaRI2QEz2L1do3U3Xumhfmq5KPHNMPbc9c3FFdN0B3g+bXTF2uVVm
   FBaWEOWMdz8Xw8NkHsi1zMCXR+asB/u393qq39DFVM8VsVDr3mau4BtDV
   K/d+CiEZBJEuTk69YBwlLKaI2ughPP6PSvq1yvYslhO5MT2bokwqac/PK
   Jy6HGVe0CaUsI4GSDeKkorlm9RLYsrkoBvVwvFpWe0dCS4aA8allkQwNn
   rYxuQvY2Zx3RCfowTIP7foIYHi7+1I3qyL2rNpBpj0mAps7u96PugI5ZP
   u+lBMv39iAGJiKkx2lpYD1+jhFCBueHswK02BgIppYPxBRPq89kJPkieh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="366359492"
X-IronPort-AV: E=Sophos;i="5.93,359,1654585200"; 
   d="scan'208";a="366359492"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 16:30:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="798127551"
X-IronPort-AV: E=Sophos;i="5.93,359,1654585200"; 
   d="scan'208";a="798127551"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 30 Sep 2022 16:30:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 16:30:47 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 16:30:47 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 30 Sep 2022 16:30:47 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 30 Sep 2022 16:30:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLiu5JSHqdyUlDdPFgqPL208vWnfAVBV5iBDwYrsoNIvzn7hwuXVJpECP2nH/vUF82LS0VmFu/3NGEUHMLN/uvfUkUalYjwa5W0a5bw8d3rLCLmHarvHxXkgDoZeMXBgVw2WlOr71juoh8KFyNRzmolvKZCWm2GVkoYaNV5DKojUpxIcqOQwLnqTsn0ofixwO4gGMTGLpSOEyFBDOuboufF5an3B+SYhiJuvEX+zCMmmhQ7gollQzJnjHg8Q12KRm6gRB4zpjjk3r1DY3mLWXWsz5qB1D1kRBOmlvh7fyOXjwJunrPaelMdiS7VJxzenudsYX5KlicBie3su/iIGIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4ZSBm+lqqXhVFA5WA1PP8implpF2802IsCkpxAi8mM=;
 b=ZGXHeOC5tUyVirfQUDDwTSA7ooDkpU+rFzIXFEXVWvxAG29+qZJygmPMdw10ojKPpDuJRx5U/TLVksZmpL6XqEsM3D5XDVKVREp3LAC+2l5d+lYLKxlSlEwAgtneuc4VkS90v/8gy6GyqkzmG3SXdd/OZRyZqKcYNNGBmEijNqEZ++OtWewAwoxmceZmyZPhVqKpb2A10rQMr6myxUUC9KFh9GFBYrxUiAq4lMFgLH5dmdbZ9foG3/6/XVCFYzdmQOpp2xGomN6xXC1u8aGRI3ctGNYQ14s+HChfNPsPiSJWYhbImNEZhXW8NyiUat0Y91/2IiLkw4gf1t/L9t4rrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4764.namprd11.prod.outlook.com (2603:10b6:303:5a::16)
 by BL1PR11MB5336.namprd11.prod.outlook.com (2603:10b6:208:316::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Fri, 30 Sep
 2022 23:30:38 +0000
Received: from MW3PR11MB4764.namprd11.prod.outlook.com
 ([fe80::e82e:c89f:d355:5101]) by MW3PR11MB4764.namprd11.prod.outlook.com
 ([fe80::e82e:c89f:d355:5101%7]) with mapi id 15.20.5676.023; Fri, 30 Sep 2022
 23:30:38 +0000
Message-ID: <c26e019a-4b31-5b40-6ddf-629df5ab27a0@intel.com>
Date:   Fri, 30 Sep 2022 16:30:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] crypto: tcrypt - fix return value for multiple subtests
Content-Language: en-US
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jarod@redhat.com" <jarod@redhat.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220930214014.37194-1-elliott@hpe.com>
 <ab0d9840-07e3-ec49-a9b3-c4b65d7d61bc@intel.com>
 <MW5PR84MB18425977F8BD6260B5347586AB569@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
From:   Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
In-Reply-To: <MW5PR84MB18425977F8BD6260B5347586AB569@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::44) To MW3PR11MB4764.namprd11.prod.outlook.com
 (2603:10b6:303:5a::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4764:EE_|BL1PR11MB5336:EE_
X-MS-Office365-Filtering-Correlation-Id: da08ca86-0615-42e0-6954-08daa33bc842
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: acErbPShAnT61m04PhO+HmjIZPDlvcFJcklgNHQxvonqd67zd37nS/LQdbPo+nlJWGpJTXS94k70z49xTd35dYzxMX2dbX5zxNFUZLddQOB0rJ5WodEOz6HqpuaD8SAgGoEhXxPi8WKi0Z4xuFIGn6ElP/W40LPH1PIwOf6lWsotLXi4CsjWs18Ynr8mBBgG+lkJ0kMXUgcJRyQ/JonJ+g4GJnM73EKpSfnWV1roqptP+NUEFmzT53fbqnzxxVOtH1e8ryXmjn5dWy/qPydylZdaINzm/lysLhosZqKLu+oah4kPuVy18358YsuNPNquDrobrPb8M9jzKAPwL3AR79j2wtD/Ewod2dZ9xBw+LtO+EokNr/or0nJTGOVeFXtjHfLZdrhJBvQMyhhaHVv8/Yj+pBcPc6Uro71GyCQh5TgfTF0d0X7wf44ldeyhaeqRyoBl4mFmS2dgilnSDyX+HsCWdvNTSTb48rQg+cxuzoYqE26Y1j9Ty6GCZkthDb5YmPrJm4gmDkZuJszgBmbsG5/9dFc1khCC+GAJc0NJQH9TqKjhkegRNAakgRjL1s1o0kSnAEgXjkFbHsuquBmL7NHZq7pwgIfAEN0wDUJWphbV18rHo9wyjKMWdjtDD8DOA4/m9zonkZ9BMnbUWdado2h2dSR7KHIeCqXSZ+xr8j3XXQY60y+ZlwO9A//HyL0WuTL/bk++JfifbRTG3LWH5t7HCOMzdJ4A5A2xW9/Ay4SLNog3W+gZBBZbVnA16QIU9onNOn4xjHdSgDRkLe+6A/LlHzZ8HlgS7fNZmkJTyIg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199015)(44832011)(8676002)(316002)(296002)(66476007)(8936002)(6512007)(5660300002)(6506007)(53546011)(41300700001)(66556008)(66946007)(36756003)(82960400001)(26005)(38100700002)(86362001)(2616005)(2906002)(186003)(31686004)(31696002)(6486002)(478600001)(83380400001)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1c3UHJQQUxzZGRXN3FqcTJlN3o2N3UvckFJbERGRkdqWGdieW43d2RGNEE2?=
 =?utf-8?B?aG12K0RremFpczNqQk0rYm9OMnVSRlBWNWpyOUl2cDRWRHI2MlUvd3RUb3B6?=
 =?utf-8?B?TDVKcDA2OGZqVS9sbUQvdlM5MytkamorWGNjM1pScHZLVVFwZzgwMndaN3ZZ?=
 =?utf-8?B?QmVUQ2JLc3dLNHkydXlYZ2hHaUt1SVRWQVFzcFhDYTdNMndMbDZielFFakht?=
 =?utf-8?B?djFHSHdvbGFsK2thSVk5UmRwdXVvQ0FLZ0hZK1VnTWZXVjhTRDBTVTN1Rktv?=
 =?utf-8?B?L240V1UyL2JYS3N1Zkx6RzJwclZLTnFUV293WHBBbFJ3WHY0UDl3Q0dPc0dE?=
 =?utf-8?B?L2xPK0U4U0Fod093RUwyUHFnczhZeDhzT1lJeldwdnlDYXlaVVg2Sm5HODVK?=
 =?utf-8?B?cHF4Q0I2VnVLQlNZelRYQzBBRCszVkh3dGtpOXlMeEhHZzVHYWxtaVJJWlc0?=
 =?utf-8?B?VlJ5MkxwbHByNkx6U05IY3BCakJoNUFRdE5DZU9WaXdUeTlpK0NEczJDaUY1?=
 =?utf-8?B?WnM5cWVHWVJmZ2QyYWhjWTVqc1VsSXc2amJjdEpXWGFZa3pQalkwNWdkYmd2?=
 =?utf-8?B?SSt3R0lxSEk3M0prL01pK3c1TWJGb1FzTWxOWWJCeVVmb3BTcTNNdFowZXo4?=
 =?utf-8?B?bFB5NzB0aG5FbjFjUjBicGoxTHNFd1JRL3FaVEdqWDNWTVVPZDd5QlBYcTdt?=
 =?utf-8?B?a0RGMGlyM282V2c4SDBKZG5IMFd4WXRjVEptbGozemREU0lES1NmT3B5OXNO?=
 =?utf-8?B?cXl2N0hkbE8rQUlZV20wTUI0OHlsOVYyUGR6QWNkcHhvYTJZcFZzZ3dtbDZs?=
 =?utf-8?B?RXVIUFJ5WGNIVy9QV2xOUXhXVWMrZ3VUWHFXL3pJeXNINDFMdkVDbldZVCtJ?=
 =?utf-8?B?aUk5cHVrSXlEcVpFZ09QZzZlSnZPQnFlYUtKNGdYRmk2SFpGenRaMjZiT0dT?=
 =?utf-8?B?Y3VaaW10bFNGSkh6UzZZTTlwV1lVMUhydEkwSVR3VmoweElKZEpTUkg3b3VR?=
 =?utf-8?B?QVJCVjlHVTFGemY3TWZDVDZCVWE0c20vOCthc0ZpUldoVlFFZ0c5RmZES3hx?=
 =?utf-8?B?WHhUWU5VY2xlWU5HUVJ6ZXNOeURUUWxKTWwyT3QzeWY0TnNzdGtUeFFPVEs4?=
 =?utf-8?B?M2hmaXRxZWhJaGtPblNKRnJndHVBUnY3cmREcWF2VUFYMEhwdDRqNU92VXFT?=
 =?utf-8?B?MlRQeXhQTGdjc3BtYThCL0pueFE0ditOdkFDOTlMenYxL3dpbWNCaFM2ZHFh?=
 =?utf-8?B?VU5ZSjU5WjBQZ2NzQU9pWTFJbW1qWmJQRmNIdGx3VkpvZ2h0cHNrRkRlbER0?=
 =?utf-8?B?UGZJNjJ6SFJaOTZJa1dHa0IyemlabTZPTEp1OVZQZy94aXBZM29RNGhSendj?=
 =?utf-8?B?cGc2RUFkbm51S2VmK294L29wdXhlY2JhMGtIdFpUVCtIUzFiL2F4RmVKaDAw?=
 =?utf-8?B?SkdXMGhOVHZoK2lQQjJOQzZ5SU9NeUNoYXlOWldMMWJaeUhaQlllb1FwOGRy?=
 =?utf-8?B?WnI4L01xbHJ0K2pESFF5TmQzMHMyc21GTCtsQk1YRy8yQzZCUDVmNCttMHZp?=
 =?utf-8?B?S2tkSmcyV2IzYXh4cFBadWpweGQyclhpM2piZjZWUDRFZXNSVkJZSDhwaTNO?=
 =?utf-8?B?c0IxdGNBZUpFazArMTJoQzVDakFpWnF4TUxJazhZSmtSa0xHYlZDQlZwempL?=
 =?utf-8?B?TnIyeEFyT3YvWHVzTTBhbmJCZEdVNTRzOGd0RlV0Y2crY0pmVGVKcUZCNHVY?=
 =?utf-8?B?WHJGMDdGRFIvN05sMWJIZnpNOGpEQjlOMnJnREJpNEJJQkNkME90bnBzNkJK?=
 =?utf-8?B?eTJWR3dJdW96TVROYjNyV3g3bGxYNHlzU3FQeklJQVRublNIWjRVaDUrajE5?=
 =?utf-8?B?Y1JqcXkvSmc4ajQ2UVVONWtxeEc2eTVYWXVwRU11b1NaWXJvcXMzVGhiVG15?=
 =?utf-8?B?cnM5NGhEU3BCQ3RIUFRVYVVkQThWM00rdDhoczF2QnA2OS9hRnhBU3ZDNmx6?=
 =?utf-8?B?V1JzNFBwSk4wendqWUVkMWM0RVNmT1FrYWdFdGhqUE94RHViSm5HVzJmNWZv?=
 =?utf-8?B?V3NzeWd5RUZ3aVdJVUJRa0hrTlh6QW1ESDQ0d21GQkk2ckRRYmtjWG96NUl2?=
 =?utf-8?B?K0xrdGsrWWh3SHpnMVVSeEFFeXVjbFRSVG1RVncrS2o5N0NnK3V3YWZsM1RG?=
 =?utf-8?Q?vg3EQN5bPbEByoZI0ic1Hsk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: da08ca86-0615-42e0-6954-08daa33bc842
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2022 23:30:38.5946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J4zBxdTImC5vQWT22k1ia27Pk4m7bFCBuzofg2Cn0/jc3BcQX6FgSkYSIZRqyqZwZS0zEuMCzsuuMFKVNtWVgJ+NYrRHtCT/LhF9f1tzbdJn7fVrZ+oYb88EH6ZPMW8n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5336
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/2022 3:42 PM, Elliott, Robert (Servers) wrote:
> 
> 
>> -----Original Message-----
>> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
>> Sent: Friday, September 30, 2022 5:10 PM
>> To: Elliott, Robert (Servers) <elliott@hpe.com>; herbert@gondor.apana.org.au;
>> davem@davemloft.net; jarod@redhat.com; linux-crypto@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [PATCH] crypto: tcrypt - fix return value for multiple subtests
>>
>> On 9/30/2022 2:40 PM, Robert Elliott wrote:
>>> When a test mode invokes multiple tests (e.g., mode 0 invokes modes
>>> 1 through 199, and mode 3 tests three block cipher modes with des),
>>> don't keep accumulating the return values with ret += tcrypt_test(),
>>> which results in a bogus value if more than one report a nonzero
>>> value (e.g., two reporting -2 (-ENOENT) end up reporting -4 (-EINTR)).
>>> Instead, keep track of the minimum return value reported by any
>>> subtest.
>>
>> I am assuming this is for the case when fips_enabled is true?
> 
> I have some other unposted patches that print more info on the
> test progress including the return values at various levels.

To what end? What is the problem you're trying to solve?

> The Fedora 36 .config on x86 yields 23 -2 (ENOENT) errors, so
> the overall result is -46 (which is defined as EPFNOSUPPORT).

yeah, but the return value to userspace would always be -EAGAIN (-11) 
unless fips_enabled is true.

> 
>> I agree that returning the cumulative sum or errors isn't particularly
>> useful, but how is returning the minimum error value useful? Wouldn't it
>> be more useful to return the first error return?
> 
> The first error would be more useful, but would require more complex
> changes. Is there any kernel macro that would handle this in one line?

Actually, thinking about this some more, the first error isn't 
particularly useful either, because to find out what failed you have to 
do more digging anyway. Userspace just gets a 0/negative return value, 
and the negative value doesn't mean anything other than "there was an 
error", and that too only if fips_enabled is true.

> 
>    tmp = tcrypt_test();
>    if (tmp && !ret)
>      ret = tmp;
> 
> Since do_test() and tcrypt_test() are static inline functions
> only used within this file, a new argument containing a pointer
> to the return value could be added that lets them handle
> updating it while keeping the callers simple.
> 
>     ret += tcrypt_test("md5");
> could become
>     tcrypt_test("md5", &ret);
> 
> 

