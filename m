Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB535FE7F7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 06:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiJNE0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 00:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJNE0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 00:26:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAB718C413
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 21:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665721573; x=1697257573;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7yI9aMjaHq5Ge3mZ3uiokjFv6IlvQjSzn3xJnyOGxbg=;
  b=RmuMnS/7lNZQaEDZwnVgTbGx4EYPu4nQSoyWq0E01xxz1c5uBRgW3HpR
   OZM98go2GP3FJAs/D1QRDnwgVtY50cxPbQwx/Diy6AcfYvQExS4+y30ts
   8RJwPWoR50bb9ZZMMR/ZDNZ9/Qs65HKtq6usCAY/WnBkJWWrPpORfq1XK
   FqgeDlFh00oQcAW9NGr4Uv4So+V/+6Mm6p4ZGP834WP5PKQhDQPNz5K3r
   au2Bx2rRWmCneuD8ggVviqZhnpgZw7TX1ZPm3/fi1sflMqLdVcxKFXGom
   6epZREijr/BQLCJOzyXRF3Uj6UqsvURgSppS/VfePGxj370saKXtXY7hO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="369463871"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="369463871"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 21:26:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="627436850"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="627436850"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 13 Oct 2022 21:26:12 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 21:26:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 21:26:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 13 Oct 2022 21:26:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 13 Oct 2022 21:26:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdOuZkxY9bzdaYDA/nR0hw7Gggg23F3Q4TCnLlcMESzV+/NLfjPqKPq2iy3J/G9janDRreGqviRyw11r40/nKIRHlLRDM8pXOeWCmmOsyz0Rqas8Mt9mpu0YxdI2Qj71/FbyX0ZbZhDLt71fwK2/3iev9V1kHCnZ/HGuNV7P15sa2rqJvhAbHtgZGrXSwnMf2ZW0v9QU//sz/P9VwgV/5ZFUq55r48sDZeMXWFD7OrDV7G0wv91/n1hznMBPPY9EWLo2w0Xo7bFWcBJRBgPy1A48sCrIluxTB+lFi9IpThrFtDHGRIs6QTsatxWxT4Wl7f3+K1mHGfXhbuIqmLgWuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6sie8NOTi0iyaFkBc96Rphd55iKSWQFRXZ4dmNtX8Q=;
 b=UT+fbie70CWE4iHJLZDGjAoHxQ2XkNZEBk6SHyHQD921VSdG7mZQILMQoHK8DCG0OZtYWQkEkdOLVvNlvLKawI2/0A2eD4W8t5y6T5XNa9QIz2AYaKX7O7wZryYLP810zZ2obbnVyO41rVfALbi+W1KjML5MpzKe0CmfgozCwKRH11WEyF9Ljb7OhkXkCHW83YASwCVcCBkjpx35TaEUrre3ehl6OrO4pWkHk9tvZACQahQ3Gisbp+5m35KzLJh+TVuv2tYgExp1Pgjz6pmP854o8mAKb395iAT2LR4kjmb45YYO/E25vQPYgvzoKgEC6kDgFadI7GkOtTolruDNWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by BN9PR11MB5547.namprd11.prod.outlook.com (2603:10b6:408:104::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 14 Oct
 2022 04:26:09 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a805:3436:ae38:788e]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::a805:3436:ae38:788e%9]) with mapi id 15.20.5709.022; Fri, 14 Oct 2022
 04:26:09 +0000
Message-ID: <2b596039-578e-be9a-792d-5f706ca9c238@intel.com>
Date:   Thu, 13 Oct 2022 21:26:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] x86/fpu: Remove dynamic features from xcomp_bv for
 init_fpstate
Content-Language: en-CA
To:     "Yao, Yuan" <yuan.yao@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20221011222425.866137-1-dave.hansen@linux.intel.com>
 <BYAPR11MB3717EDEF2351C958F2C86EED95259@BYAPR11MB3717.namprd11.prod.outlook.com>
 <9b198ed3-4b2d-c857-710b-3f7115bbcf74@intel.com>
 <78f2021e-339f-9dfb-2aee-51f58ea77ec9@intel.com>
 <9be1413b-ce30-acf8-86fb-3e302dc98396@intel.com>
 <dd5815fa-ec61-b7d1-c0b3-70cd0f33bbee@intel.com>
 <084b98d1-1021-14fd-0d7b-3b85ffee3035@intel.com>
 <BYAPR11MB3717D733EC448197D0321FF695249@BYAPR11MB3717.namprd11.prod.outlook.com>
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <BYAPR11MB3717D733EC448197D0321FF695249@BYAPR11MB3717.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0024.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::37) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|BN9PR11MB5547:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c2778a-5280-4b4e-4c2c-08daad9c3816
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bDspO90Ex9Dwrc2oY4xS7p7PWr1/CzXQx+PHXmBipAZBoV5nDVQNbXO1WkLy7bSDZgYERIq/ncTOJL5VZtXx+VbX0vCHUGogbZ3ttvlykhRwvk0+OrPWgHQ5HVyVkdUiSE+kiABsy2IGv33NQj1TJvWXQ41VJpyYVIs7Nh5dgoRnlktdCy/qpxti42sf1yNNMxHmf7kHkmPL1j3vDHAZ4pbDqYktX4quFp94yow3IzQffDQnHS51+kFNAGx+wNYch+X63kTabRC6wgZNZ+UbBi/cOLvP3WNwlxun/+dASp4Co+rW1AjJU5LnIpDCGkX7jD/irYs2bLUA01N4gwAV/h9WQxvQ1oWpF1PugLcipxippWu/veWTRwEqtfUkWOlxfhV9f4CXcId/cYvES1TXLev5GL/wQRN8PpTKXQJGoLErbxJfaO6ErXSDac1jyoQXK8w3HDG7NlNCjwb9/KDrfRfimFMta2XnHQV1jKp4XdxyuavoMa3M2fm4q3yrnqFVhHrG9zOXw68THEChgrEuJeoJCG5/yBf1Z9LizKFFT8ZHIOl7BYbhtN8PMieB8uUuU+p/OJfhagrHh50Tnv31ujJQ0v1d3tQ6Vc80ABwibxCMxd43TR+C6pmxNsGgv2WBq9Jx2aDpHEETEtq9RjPT8uc/pa+YchimOq5ixbsbdHwBTHCdIq3HlrDhKQj/Qbu3Z/r8XatwM/mANuOfy/Ez7ErZY70m6TIMDZDxEBtVCQ3yEylVNVbmOYJ1ctFsAT2r173PF8kVVczX9M6+aV1ACXoz3wD78+hBrLEqpwbHdZm1pTYJFtZTmQIIVey4iSMKMqwURwn6OIYxYBIOwVRHWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199015)(966005)(6486002)(31686004)(478600001)(4744005)(82960400001)(316002)(110136005)(54906003)(8676002)(4326008)(66556008)(6506007)(41300700001)(66946007)(66476007)(5660300002)(6512007)(26005)(53546011)(36756003)(86362001)(186003)(2616005)(38100700002)(8936002)(2906002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1M4a3lkcktMNkVuUE8yTnlXNHhWZmR2eXNsTGZhZnN0RnpHWkFzZGgwb3E1?=
 =?utf-8?B?eUZDL3ZSNmNpUWQrVWgyZWlZQTRYTE13WTVtbjEvOUdmdm01VWlpMldCdjlu?=
 =?utf-8?B?SVpnU0xkelc3YytRZGVkMFVOWW5mckhrbmNBTzM4NnY3TVU3a3FKeVAxbjBL?=
 =?utf-8?B?Ni9Ha3VDaEtDK0hJZUtpUEZMYjJPNjRJb0JGd2pubEwwUytYcTBHVlN2NXFD?=
 =?utf-8?B?RTAyNUpIZE1lVHJUWXV6K21KRnhSSU9wMm1zdFB3OUN2Q1lOREhaczJpTnlv?=
 =?utf-8?B?YkIrd1YydEVVSjlQaHlZMTQ2emEzaG9wVHR1QStESkZsUGw0T21nbENwYVJ5?=
 =?utf-8?B?VDRzaGFjb2twU21ldE5oQVhsWEQ3bS9ndVpHQy9BWGlocjZNZ1lLVFMyS1J6?=
 =?utf-8?B?clh3YjNWcVVGU3VNS0QyUEhOZ1FyTDlJZTdKcmpiNzVmODJaQkpMNngzRlRn?=
 =?utf-8?B?SU9yM3o5K1VkeVA2eEpFZ2U1eGU3N0xlRXVya3F1NHFidUMzRlZpU09jd21Q?=
 =?utf-8?B?VGJSSFFsQTVWdFZ6NmF6ZlRaemI2YTVlVFVUR1RQOGxEZWpDcFZDdUd1TmtD?=
 =?utf-8?B?cFU1SDdqN2tMU0lGL3F6cFlLbzg4T1E5cXRreDJHTUR3MmswbHU2UlhRdUNh?=
 =?utf-8?B?djJ0cTJ2YUdMWnN4RDV0TVJZTTNxYmRWYlRIak1aYW1Rc2lvVWcrRnBIQk13?=
 =?utf-8?B?QXlUdERHdTFpQnhJZ0l5NE9EcHNJV2tpRU1jQ05ZR2gzb3dTN3poYUVDYW5p?=
 =?utf-8?B?dWxORWVUOFdlaUJ1L25nL1lIbmo0Y2JVUGYrUlVaZExkRHhlTkhvZlF5NUg5?=
 =?utf-8?B?RWpXaytFblJWRDhZMEJVMXZDaERMUExkZHQyUWJlTTJTYTQrekFBN2NvNnRs?=
 =?utf-8?B?YkdYd1loMXM5bVM3S0lkTkxaN1BzSjNYZmpkc3UvU1BqU2hFY2NZMlFtcm5m?=
 =?utf-8?B?ZzJhMUZkRk55Wk8rMk1NM3BPbmptbytxc21CUVoxYnBnb2hKNFpRUlcrUCtH?=
 =?utf-8?B?VldFdXhpM3pPTWxsZ3JPMFl2VlRoZzNia05RSldFU0xrYnc5NWZhL3E2RzFV?=
 =?utf-8?B?YTNxTStsclI2ZmJRZ1ZsMDZ3djI0bG1DUHQrRTEwOW0wNk9Jd1F6cThtaTMr?=
 =?utf-8?B?SUpUeDNIUzdXSzRBMHl2Q1RBUmtZOTI1VXFDTWFOQ25DYWJUY0pZcldmVWFU?=
 =?utf-8?B?c05vY3B1ZHBoNjE2ZjFIeHVsWW1xdFhXeVQrQXJ6TVpvbUF1Zzc2MTVrYjY1?=
 =?utf-8?B?V1E5TWphM1VlVDFxcXcwck9jNEsyaTVGYng3VjFSWlZTMWZoeW9ZblRFOGZG?=
 =?utf-8?B?dGhWWHpxdE9GTFdSOWZBL1lPQ0ZMRGJwaktRcFhnek9GQ0cyZVljZUJDUS9B?=
 =?utf-8?B?TytUblllb3dLTWhZQVlFU2UrZFF0M2RqN3JwTyt6VVVVQmk5T0VxSlpWd3E1?=
 =?utf-8?B?SHVsS1p5MjlLVElRcFJld2FJWXh6c1Uvc2Q0YlA0eldYeWRIck1pa21lbG9N?=
 =?utf-8?B?NENYRlBKb2kyaXFzc0hqWjcvbWd5WmE5ZENheXBycUQ0QnEwUldIeTZheTJZ?=
 =?utf-8?B?L3BHSzVhdGZBTzhSOWJIWDNQeVQ1US9KVERlWG9sa3JsZWRpKzY4Nkc2alNm?=
 =?utf-8?B?bHMzOWVsNWl1cW5JZG1DK0Z4VXRnejB0TWtEYjJTbm0za1hiY0F6bWZlSk5B?=
 =?utf-8?B?d2pTSlZxL2cxeWY4WCtkS2IxcHdHancxV1pvRWlHT09uRVNYQmFwVHdOeDJB?=
 =?utf-8?B?ZG9MNFJpQnRjbmttRWJQMEs2TTFIT3VsUW5PUEl3aUxkd1NIb2FaVmJvT3Nl?=
 =?utf-8?B?OFJCUkZXalNSdVQ4RXlEOEtEMGx0UC8vczlrZGNFQ2Q5ZXlwUHdWRWVIcHYy?=
 =?utf-8?B?OVMycFRzMUVEcnVVV1pOUktSUzl4VVQ1Z1VvekhIazk0YzhiaVZHR3RiSVcv?=
 =?utf-8?B?dFV0UUVrdENNYVd5eW1PTlJJYXVQNThEYklIek4zZyt6UjFGaEhMdlFPQlVp?=
 =?utf-8?B?NTRlc2FQL05kbHZ6QjA5MUxyN1NzbG9oQVNKbzRUelZUdUFNZC9PNFRrc3RN?=
 =?utf-8?B?N0V6VWNobHJtSFB2Q0JnN01MaWRYSEZlQUYxMHlQQ25HUElVV2xrZ2JiV0Jn?=
 =?utf-8?B?aUhiUkJXbk5NTHZQbzR5VnFDK2c4YWVSK1I3K0dnd2VrVytBbk0zTTErQ1Jl?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c2778a-5280-4b4e-4c2c-08daad9c3816
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 04:26:09.5240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KxdEyQnP7DzBOb8ErgOCQdx8W+a8AehE/OzF6E/rpTwjelfIKjNb86Tp5bbjL99ixSG+DswUUBoero7LD6Euh6Z0ix11sg290lBHLxgakoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5547
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/2022 9:10 PM, Yao, Yuan wrote:
> 
> Does init_fpstate saves the "init" state for all non-dynamic components in its buffer ? 

For legacy states :)

	 * ... But doing so is a pointless exercise because most
	 * components have an all zeros init state except for the legacy
	 * ones (FP and SSE).

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/fpu/xstate.c#n379

Thanks,
Chang
