Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60384622181
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 02:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiKIB7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 20:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKIB7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 20:59:15 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85531248CE;
        Tue,  8 Nov 2022 17:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667959154; x=1699495154;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kBlXXmVM/et0nyXHuce++LbHAKWVTCRaozamSzRRbCs=;
  b=U+d8Hj2B2iiulwhqVYlzFzA+SAdyIFZl57XDF7k3w/LFX02SO0OAfGS/
   INwyvz3QaQ6dLLjyCwrD9T4N+xRcADmQTgH4TiNBtbuuegxBgo+XgCSX3
   JVqr9OK/iiPw9CuECwaJM014QvYwX6olZFzh8boo0sKkI0L94CAMfKany
   tJuUAfSJFI3WVFWHckzesxhbrY4J6shQg2oDf+hO2+yhknpI8Loy+T69+
   dzB1QkpzrRv5Yi8ryuSXQ/7S5kWYkokIwZ+h4NFNHQBHa1POeyjtmjaTS
   kVZQbDA1ov4VdY/Cj5ldyvhwI8d6w2U2pGWk5XJL/FDTjM9gTxspClKFk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="290578716"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="290578716"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 17:59:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="614494960"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="614494960"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 08 Nov 2022 17:59:13 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 17:59:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 17:59:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 8 Nov 2022 17:59:13 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 8 Nov 2022 17:59:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQrExPNtV6my5j3o3HYHYjixFotZNPIzE/QFLz4siHBrV9um5+iYsWyUX3YjWKZaFDSq0x7ZbyRH5tY/LpfxQEU4Ywb3HvDu/ugl6BzhxFQ5RN2bluZw+63hEt/hgHQv72sP6c//Oe8TAk429LuqPUfBtZp+cBZDaXZvD80RXZwq00l+C0YPqOD9/x3UzRpnKvbIq68/hldqI6EY+VgmurGBj9pSuZaawdkbeZGvoaTNvunG5u3BafKUsDVr2cZFYaBIBq/BYiDoG7P4Lp9SMSU7+2FhvywTofeDKZmEUpzCsBh8ac1+Xb9JyOg/o0DBfp41qDtFpZQsGVDKIzCmdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6b8X03mPfhhgEhS2ArWnZHBAYr7+xDk4R6G8mWtnHjE=;
 b=Tq+29wphF6QBEETDRwQXwQnQnwa3tMyTZue40mVp8Zz06efAMd5QV+JOlBxRzgdLw+1Euw+arTRQUcZMkjn0IDl+o1ruLzyuMUra4CnaojtYyMgTVoMs7xogM1gGS2otZKgAnW6h3NO4dYbZZ27bnV9DI2C8rSyehGGMGW9ImRAQnXysMZ43zDsjWJe/WvRUuAqCZg2ObqPdEmmE4jJ2E02WNlRQV6GARkrCbYyf/W3VvfNBuJ617Hk4fnWhkcXAT4p/hkWWFcJcuBpnT+y04TDB2NrLUPSYVD4y4BPkNSZQG+XakQOfmU+0FrJMhf8axnc5Q2WHBaHzND21H6a51A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3322.namprd11.prod.outlook.com (2603:10b6:5:55::19) by
 DS0PR11MB7335.namprd11.prod.outlook.com (2603:10b6:8:11e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.26; Wed, 9 Nov 2022 01:59:09 +0000
Received: from DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::2720:c97:3346:ede4]) by DM6PR11MB3322.namprd11.prod.outlook.com
 ([fe80::2720:c97:3346:ede4%7]) with mapi id 15.20.5791.026; Wed, 9 Nov 2022
 01:59:09 +0000
Message-ID: <3a2f83e0-9ce5-ee6b-2b70-a7e94f4b7de7@intel.com>
Date:   Tue, 8 Nov 2022 17:59:07 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 03/14] platform/x86/intel/ifs: Remove image loading
 during init
Content-Language: en-US
To:     Jithu Joseph <jithu.joseph@intel.com>, <hdegoede@redhat.com>,
        <markgross@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <gregkh@linuxfoundation.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <thiago.macieira@intel.com>,
        <athenas.jimenez.gonzalez@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-4-jithu.joseph@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20221107225323.2733518-4-jithu.joseph@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0101.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::42) To DM6PR11MB3322.namprd11.prod.outlook.com
 (2603:10b6:5:55::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3322:EE_|DS0PR11MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f58b7ac-8395-4a2c-e68b-08dac1f5fdcb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t+trv/iz4CZ3Sea6OCYzA3r4KTpp3P0ncO/HvsuUgoE4ntw9sRdEw4bnedV2rq5A7sRi4za6EawXNOTBD0kWG0bs1yRrf5geGSuNzxIIvOtPLf0s8D99y8VJu/w8KH4JdEAPWfzjdG3KxjrthNDsrCxQbaShskdavcE6l6aZwM4g456mM7ytBxKDlIjm0Wj0dd72yq2/bgdPO/eay8+Sy6IiuZ60C0qtYBxR0NVZ/P4soMHABfxbxbd2jeyG36UIo+wYzeoeunXAVibTtJYdakKR3AL/V8rXcKWmvMlo3jjevFFAbp6a/ROdD48dkvYeiQwCysV5JbPw0nLP/LkSmrlJAxhdpnTkfsy/HawXm+QSOPVDgW2lnAGQ+ovJdnPnylxu1PiDFg9giNnG44wLqcjQ+R2oNzvLyMuS8uGqLu9vhZxPcEfO9obvFqBfqO9CHrmnMM39Chbp53mjwrvCLd8Vuyg22aWIuujLHP7KS8GuJt2q31ewdg36LtUSg09R2JpUX10Iik263VT/Ya4BDHhEU+6kB1jVynZJETsXoH7LkEE7vHhkkObJRdXMVgCMO8hXIb14zWwJVOc2d0flElEPXqnsBTRkAuTqMDGaDGu2WwGyIFXo6V5mjmzhKjVW0mhy7n1Bf+0DslKDvYmFDoqU/Kltnh7TUhfmNL046AHVPWxTAazILm4JfqAm2Wdvzp9nzc2xgtPM4telA7hnFta4XVy24gdvI6w1I9tBmVJBlD85keI6TfkGJ9/YDipstRMVl2HJU6SkSS4reOUaAIe4CPPnG+QU10eNQGxnWBM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3322.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199015)(6506007)(5660300002)(53546011)(316002)(2906002)(7416002)(8676002)(2616005)(44832011)(31696002)(186003)(8936002)(36756003)(26005)(6512007)(66476007)(4326008)(66556008)(66946007)(41300700001)(4744005)(86362001)(478600001)(82960400001)(6486002)(31686004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3JMWUIyU3dUalVnUTNYWWdaL1BacWgxTFZrcnU4YmtWZmMwVTJMQ2YrRHVm?=
 =?utf-8?B?Q2J1NUlwWmkveHpMNk51UFhZbzc0MkJERDdZWTE2Wi9YTDVYa0g0ZWRTZkJM?=
 =?utf-8?B?NWo2aGd4UzdNaGV3cHNVNXo4SS9oRVBZTHlhUGJCbEJ5Y0xYZHJyTDJ2Sjhj?=
 =?utf-8?B?TUZwdTd2Q1Rha21ia0JxYk40ellaTllaL3JETG9CVmdMSkZqV2Vzb1FyZmFK?=
 =?utf-8?B?UFJHbHdRa21EYmhiVnQycUVTNUYvekh6bVZ6TjBCUU1GUDNZS0hVeWhBdm1k?=
 =?utf-8?B?QTNzalduVjcwWUhseVB3TFprRk1xRGpsUWtuc0JkWWlqSkkvZlo2MGtNNmlx?=
 =?utf-8?B?a1RNREtGK09hOHovS3pib2VENDFCVTlSYUpZcHErN0R6SDBqNDFqQ3M4NUVx?=
 =?utf-8?B?dU5hV1RycnViNkFiYnlDUFcya25FVEhrUU1JYmhjUkNmRS9UaVkrQ09VZzVn?=
 =?utf-8?B?cGFTM1VSNDJBeVVadmE3S1Z6VUpPYTVZQ2t1WXJKYS80bG9oZ2sxUzY3Ykh6?=
 =?utf-8?B?NVJLRm52QWJGYTJtTFZzSG1nWkRuYTBOTVVyR1V3U3VFdFpEeXpFSmhidGpZ?=
 =?utf-8?B?b1FZcSs0RjFHbVN5VzhtSEhzT1U3VFVpVzNYY0l3LzFOUGtSRWZGYnZXVnVQ?=
 =?utf-8?B?VDRBUDdxcUhheGQ3UXV5akxGb09adW9KZUVoV3RFQ1NqMWhKZ2Y5K2pRdjVD?=
 =?utf-8?B?VjZSbDkvSWhUMWxKU203UEpmTHJ4d3p6SGhZSWJoeDZGWUJJeXBQUmVBcytU?=
 =?utf-8?B?N094cEEwaEtVWGkzOGVmaVluWmplMERWOXV5N0k5WFFROHlGSThqUzZOWFpn?=
 =?utf-8?B?ZnVnVFNia241K1JsKzd5RWtDT0djK3pkVk1qQ3JUS1lDU2E3ZVo5TnJ0Q01w?=
 =?utf-8?B?N2dUWENCb0U5RExxYllZcUZHcEoreXRINkRmTzZNYlZLOTRHa0QxSlVOOEdl?=
 =?utf-8?B?NUU3SmJZWmMrcmdUQ3Q5YWJyOVlWd1p0YTRXR21JcVBpdzBiOVRuL3RqOGdX?=
 =?utf-8?B?bGQ5YmpqSFVtQ2NmM2R0Q3RuUGZGQVBNaExSVHZzTjEwTlRDYi9ySE1HM2Na?=
 =?utf-8?B?NmFHS1ozMnJXQ3BNWXk4TmdPYXhxL2JmZ1E3V3BnQk4wWGYxVzk4TEE5VVVz?=
 =?utf-8?B?a2hEUG5ya1JiRFVTRW8ybS9vNUFSek5VdEFmQlU4R3FUV29jUjVsejVpUmJi?=
 =?utf-8?B?SkJpUjI5aDFGS3NmRGtMRkJWc2s5UDJxQ3JnbWtJd3NuQWFIckFzMUMzcGZK?=
 =?utf-8?B?d0IxUHVsRWVwTnR6ZUkvWjU0cXZwb0Qwd3dHWjhhY3VsTzB5M1VyeDlDcmph?=
 =?utf-8?B?UG10SUhXeGZ2NXRoUWhENVVvS2RCL082eUN1SnN6NWx2YW54ZysyaS9ZNFpT?=
 =?utf-8?B?L1ErNG5IN0dHSkxLZW00WlE2ZFRTMEhkb3V4VlBlamJxNnBtSkRlVHNMZWlH?=
 =?utf-8?B?dWV3OVRzU3J3cml2eFgvdzZ3MW9VVFkzZ3pXWGR2ejZSa2FsUFpwMStYU00w?=
 =?utf-8?B?TkxGRmMzVHEvakJwUDJCZTdWemNtMlhXYWpiQTlxbTZtT0o1dUtMSE1VbmJr?=
 =?utf-8?B?VXFkZFF5dHpkYVdwUitQWjRhU09zTEM0Ykt5dEx3bndqV1U0bktRZG90bE4y?=
 =?utf-8?B?YTJVUmZ0d2hxelBvakR2b2ZWOUxUU2dtTmVGT05VN2k1MDd4cG5vQTFXbHRm?=
 =?utf-8?B?dGp0Mlg2WGJuRHpqTFJxSlZkdWcwSSt1bmtrN05uc1ZseGZyWWlZeXJkYmVJ?=
 =?utf-8?B?RkNyYXNXZlc0SFg1cVBsald5bWU0dDdXWHJXTDZncTg3RnRXWTRhZDdOalE2?=
 =?utf-8?B?RWwwWk91MmRiRi9tcUkvYllSZjBjVHVYVlF1SGhaMHZpWFh0N051UzgvaEJL?=
 =?utf-8?B?TGdMeGp6ME1aTGFsdStDUnhodzkvVk5PY2V3UHRJNk01aEZ4bVV2K1krSnAr?=
 =?utf-8?B?SUN3ZHl4Q0c5dDJnNENEU2xUYzVrcmltZTJ6MUZCbTRKeTlBUzREV2JydFVG?=
 =?utf-8?B?N1dWSlN4TmNTSHhmZERrTWFSK1NyTXNWZGwySHN4SnBoeFhuYVdwUm14YkF2?=
 =?utf-8?B?NHlXWEQ1ME5SLzFWOHJ1WmUzbG1NazZJcUo0cUFyQno1MlBpVTd2RWZTdklr?=
 =?utf-8?Q?7IRiT2TRL+u4hyS6Jxps/veCv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f58b7ac-8395-4a2c-e68b-08dac1f5fdcb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3322.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 01:59:09.7368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yz5ZvDim+fZNgWDDamVTjjxP0K2g4tcrKIb3I5AVh4NqB/cNI7Evca0rXotee94RTD7vVgKXKnK4Q2dGkBDh3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7335
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/2022 2:53 PM, Jithu Joseph wrote:
> IFS test image is unnecessarily loaded during driver initialization.
> Drop image loading during ifs_init() and improve module load time.
> With this change, user has to load one when starting the tests.
> 
> As a consequence, make ifs_sem static as it is only used within sysfs.c
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
