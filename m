Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6C95ECF37
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 23:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbiI0VVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 17:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiI0VVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 17:21:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8111E1CE5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 14:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664313694; x=1695849694;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Nle8XfTH4urbqN1UZ80EaIj8UAJZEcbii2cQYMFODYk=;
  b=c+AjTMpSxl2xpFvyXNTLI5IUvWHCEswTsLznHUzoh2YPq8nKkHw5stvI
   ASJgGy42rTTefUEP2rkpUFhRlZWrOdGVG2KSxnUb+CGEVIhRvVlBTDnWV
   K00++duy946iNoWhpgLnCvZVq82EmCEa5R4kKRBwn4L3jzrDlPCyE+VwB
   jRNfrZNIW2QKMLkXjCQLDF4sw8M6FeZS3PRW/ZrINEFf06e/HSkodciqC
   vvC+1fy9wYrmfmkIz98NWFjfT3FbeKrr0CMLv0LG/AMX1eKZeqjzZkdnp
   mAEF5R49QyEED7Fff1QM3KkYuoXlmSxZpiz8KdqnJOc81Te/SPy8ISddy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="288588971"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="288588971"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 14:21:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="572794137"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="572794137"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 27 Sep 2022 14:21:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 14:21:33 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 14:21:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 27 Sep 2022 14:21:32 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 27 Sep 2022 14:21:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzvX0xGGhh3iML2cVqA9jjk4hybKH9AMtForNYZO2cVbT2NLA6YVsx0BVC9qSh/fHkI92V5zxWQhHMkHnHnVBEsKXihF3m76j/8x9HSZ9Mh/Aoi2JMRw81vh/dBtUODIhwm+X6JE+WQI5xmPCFqHn906DCOb+UWvMqwgP6p80I4uuPzJeSJ0OZ1jvTvKkuqNLes1HEvggvVNBkuCR5LjrHGmNM7VJptLsY76Nn+VaFL4fVeCJptlM6rH1zWimxDpAqkZ6b46Txahv43Moa3QlU48nKHBUwtpERlPS02HGgZgDtqBhRXsCPAyEV6l6IRBbjG4qFnxDozRYjSrJC86pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20n8QZUNvqOSl9WgGE9zgN4OJ6xMHRBXXXCZwSZAGKg=;
 b=VoBsW3gewwD1AdpY+SRzVopUA9Q471ajZTqqc9Qu4Pq1yztT/BiIG2s6zNBCVKDi9GFYn0YyOMfLTRzrK0cMPC65JdUJOoG//34J1nCJGssF8hL0tELOrCQgK7AQRV41r2Y6mtG/dwFdTCYiq4NkAPJ2gotvIfMnaVG3re9XWyH+cF3qTkZWPM+gx0OQtyIpHvPkRyZiWSnAGPeLyuIl9Ry0sSe/gE8tfQNrhxuabX8wVw+IPXBI7KNsRYg0bJvyd1uVIuxgk1005iTxKDkuAdFTW87fU9Jzz8DOnWXIAiC3ZuvYAZ+xnfLltSf+BzKbblXvQyHD6xxntAEBsh++rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM6PR11MB4577.namprd11.prod.outlook.com (2603:10b6:5:2a1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 21:21:30 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5676.015; Tue, 27 Sep
 2022 21:21:30 +0000
Message-ID: <2728c354-ac75-be4c-66ad-86ebd9c50248@intel.com>
Date:   Tue, 27 Sep 2022 14:21:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.0
Subject: Re: [PATCH] x86/resctrl: Clear the staged configs when destroying
 schemata list
Content-Language: en-US
To:     James Morse <james.morse@arm.com>,
        Shawn Wang <shawnwang@linux.alibaba.com>,
        <fenghua.yu@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
References: <1664247269-41295-1-git-send-email-shawnwang@linux.alibaba.com>
 <80d6238b-223c-e60a-6930-24a981d9dd0c@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <80d6238b-223c-e60a-6930-24a981d9dd0c@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::18) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DM6PR11MB4577:EE_
X-MS-Office365-Filtering-Correlation-Id: 05e4f3f6-c658-4d7d-9de5-08daa0ce3e9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g0fPlSiwADRhh9UhC3dvqMkmXPvuoSwOMrYTx6f1l7lXqA6rblKhBuHiLzaFUqzZE6FKrrU9NmdHmjR8EdQ5+6x7Z7NCtQuQir2xA4pkPb4fg8ISD9v2iyOeIgn9TsvQy+uSIXPNksFgsq+rqfRN2iexzBfyv5h1gERyjwUgTg+wsCilgqUSMcbXu00MSuKMkkl1aMlxAFh24+OduRDt7Z36ntDWRtHK887z1BjHuvT+VCiZqznXdqRMjsMssynhuSGLNJeYNorAXoIS9bh02KPEFP76EW/LwujzmaI672Bq3XieEypLsiENy4DbvOuRAxfSRib/zVlsZgO305diGdw78F00DAIMEdl7xUYB8GuKQwcYzLn+yaw3QmatFElhL3P2k33VmJRUuexcOda56EsaJblIkzbdzsiU4Q/RPKE4x1xfwpwA+D6u6jkBITpXqC9+Y++2wRe+FdWCHC1bBg94LHDRLveMx7qrbbagnQvWxgJhPKyeVCUYOyknr+QP8fD8Hp2/Yb8FH/Aux9xlRceR+7jErkA8890K/m2Tj+8j+Sr/msb/sHDk/SmEF5ASiZSCy4lJTWwZY0cNvetuuE0b1sQfOJuM3B1SJBwIq/7dr/AS4Y8U87uAJqlJfSqOwKA5X+bVqxK4YkgkzgH8nDIjQwsX/7U4c1iFr9Twwaj1w6miWrlp5GTwCxo1wg/azkm/2D403Hzso3eB1vWYay6q1olzz/rPUOanFa3UnajAstdpioccNMMNz4k5GpRsITIclJlZ0yU3G//QgLyYZNiBv+78hudx1cE7GCzOnl4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199015)(110136005)(316002)(6636002)(82960400001)(8936002)(36756003)(5660300002)(31696002)(86362001)(66556008)(66476007)(66946007)(8676002)(4326008)(41300700001)(2906002)(44832011)(26005)(2616005)(6512007)(186003)(6666004)(478600001)(6486002)(38100700002)(83380400001)(53546011)(6506007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2thTWZ2NUprSlFseEhkbFRJMnkxNm9aQllKZ2dvNU0rM01UYTUxbnpaQTIx?=
 =?utf-8?B?bVh3N3drQlNvMEo5Yy9LRzZybk5wOG11cm1kc3dLcDd5aWdRczZTbkRwOXdm?=
 =?utf-8?B?ZHhJeXFodThqcVJOQW8yVWNTOFBGZGhiT3FwVFk4Z0prQWR0clRuUHMwc3Fz?=
 =?utf-8?B?VThZbytSdXljNG9kanlYR2Jya29yc2RMUndISjBXTmFEWVF4V0plZkw4NDdt?=
 =?utf-8?B?WDhVNkZ5eFgwbjNBZmZ5bDJWMzBGMDFoK0VTdHdXdW9MVUxRRGNPdmdNcGpy?=
 =?utf-8?B?eUlqd0JQbXZJVkQzVWpVeDlEWFVsR2ZWeGludTlVd3pVMWRjS0FOdGpKSUZK?=
 =?utf-8?B?TXZ3OTg5TlpOS0xxaXNLcmtPRTNIVDhNZmU2N0FDNm9PU2VWamE3bFNKK1VT?=
 =?utf-8?B?K1ZkTjNhK1ByNUp6T3ExRUFUK2RzUjMxbWowVlplQm5YUlN3YlowbSt2SWcv?=
 =?utf-8?B?WUwvOERTMlJyNStTcEorM2tuZUw0RXJXUjRqQjVCUk5aNW8reTFHdUt6NmND?=
 =?utf-8?B?ZFEyOFlhOGtDZm8rbmVVeldwWURrVWxkckdBMnNvSWUrUHpzcjVSdzhYYzgv?=
 =?utf-8?B?WVlKRW1tRVpoZnYvYVErdGhPZzBCK3gzQjU5RU04V09pZnU2aURJNHdHY2ZS?=
 =?utf-8?B?bXd6aU9lSmt2QXZnNXo1SE5MQXVCWFc0STZZMUIzZTBTcngyVklKM0pUNXNH?=
 =?utf-8?B?YmpDRkJIbjlIUnFUdVR4M3RwNTN3TTV2U0tLL0lTYmpjK1k5YkxabUE3SHFZ?=
 =?utf-8?B?L200THYwMVRsU3g1cmlKeWJOd1daTXB0SGd5dG40TnBtV0R3aW94L0o4SlUz?=
 =?utf-8?B?RU0zcy9ha3pod1E0cmlMN0hxS0Q4YXNxNTMvYk1pNkNraUdmOVN3M1F0SFFK?=
 =?utf-8?B?SmFzbHFHNjRmMGdxTlRwc0FLNUEzM213OStMUmRaaWJzQXJZTjJNTXQzMjI3?=
 =?utf-8?B?RnV2QkdzRXBCNVErYVpUQlozUEFTQmFvbWlrcHNFVVFRUzJpZzQzd1J4N05Z?=
 =?utf-8?B?Zm51elpYWVlQeVdIdGhkUzFXckFpcFY4QitVWlZiTEthb29vOGhMcXhjZW1x?=
 =?utf-8?B?cnJPOTZ0SG54cHFtWlBmSVJ1NDk3cVVMZmJoeU54aTBPMXcyUmxGdmdVNjNQ?=
 =?utf-8?B?OFA1QlVFTnVpd1VjK2ZiejdTbWVtUW1POUtpNGg1K3pnVG1wYW5DLzg2T01s?=
 =?utf-8?B?c09BT3NkMVZMVUNpYXdnWnRwR3RsWm13R1hLbUtiSUwxVnZHR21saS9iYWpp?=
 =?utf-8?B?NEwwT0FSMlBBdHJVMHlPSHR0cHc0b0hMZFNreTNpaXNLbERBN0RQRWtWY29k?=
 =?utf-8?B?UXlRRUE2OWVMTS9HMWJreFBJbitua00wRTU4MjdMKzcxekY1NWxma2NIOUI0?=
 =?utf-8?B?RDBaSzF1dzhKNDBzRG40aFRINDhQZ1JXTDVCZHh0aVhjUmFxcmQ1R0NQYjhV?=
 =?utf-8?B?bFR2bHpwNHV0emhUU2xLa1hjd3VzcUJ6WVRiQi8yYzVPd3BLa1J0aXYvY3lw?=
 =?utf-8?B?WU80YlZqaGJ6Ky9IOU1UNlkrZERHNWdoVStVNU54ckNFL2E5M1VQMTVteVdz?=
 =?utf-8?B?T3FBeFFQaW5jZFoxQUY1K2FxNU5CcnJiN09Bb09wcmdRYjg2YUw2QXZTYU5X?=
 =?utf-8?B?cXlLRHl5Z1FjSGtyUnRybXNVNGhiTG8xZ2d1QVVnMmk0SmNsSXQzVkYyTENq?=
 =?utf-8?B?MWF3Z0dHWDdpNWtYUkRWRXdYNXVsc2N2QUVTYkNkSi9ieUhHZGN4R1ZyN01h?=
 =?utf-8?B?dUlFeHYza0tiazZoaytYaXZBYlFGRStxZmJpTEtiRjRQbUd4TUVXc2padFF1?=
 =?utf-8?B?QWlHTTFETFd3b2lPQkNJRCt0ZzJoNFBiWXBhODNWb1k0VzEyTjJNK2NSUWJ4?=
 =?utf-8?B?TTRGQ2t0WlZaNFZkc2xJUmNpMGFxamtrSmNId1NLcEpPVXRxRGpXSEJ2ZGw3?=
 =?utf-8?B?SkREOWhzbS9YV0d1bHVsaVZIM2IrQ0VGbU1Fc01oMkxNanRsOHhwbG5vVnl3?=
 =?utf-8?B?WVBEbnpSRmF2bnNjaHlJNWk4cU9paXVwY21wVklZU0F5NXpaeWplMGRuZHk3?=
 =?utf-8?B?Rnc4NzNEWUJLL0xKSmoxeVdpZDZDRVhwamFHb3Q3NGUxbE1WZW1XSHNPaS83?=
 =?utf-8?B?eW9kSDM5aVNmVUQrdUFURG92UklucVpnbGJCYlU5OE9iaVppTi9xekVLdWdm?=
 =?utf-8?B?K3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e4f3f6-c658-4d7d-9de5-08daa0ce3e9b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 21:21:30.2470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JVsfG4tAMAtGrq0y1nSPh1GN/9qrVYdkR8Up48jfKBjfOWBN4UYcIZ+wwO+ktG17mSNxlIsh/QitoCOU63yxmnIirotYEp0boZgw28GClbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4577
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James and Shawn,

On 9/27/2022 6:06 AM, James Morse wrote:
> On 27/09/2022 03:54, Shawn Wang wrote:
>> Array staged_config in struct rdt_domain still maintains the original value when
>> resctrl is unmounted. If resctrl is mounted with cdp option and then remounted
>> without cdp option, field have_new_ctrl in staged_config[CDP_CODE] and
>> staged_config[CDP_DATA] will still be true.
> 
> staged_config[CDP_DATA] is an array - its always 'true'. I think you mean
> staged_config[CDP_DATA].have_new_ctrl, which will still be true because it is only
> memset() when the schemata file is written to.
> 
> 
>> Since resctrl_arch_update_domains()
>> traverses all resctrl_conf_type, it will continue to update CDP_CODE and
>> CDP_DATA configurations, which can cause overflow problem.
> 
> Only if its called with a stale staged config, and it should only be called when the
> schemata file is written to, which would memset() the staged config first.
> 
> 
>> The problem can be reproduced by the following commands:
>>     # A system with 16 usable closids and mba disabled
>>     mount -t resctrl resctrl -o cdp /sys/fs/resctrl
>>     mkdir /sys/fs/resctrl/p{1..7}
>>     umount /sys/fs/resctrl/
>>     mount -t resctrl resctrl /sys/fs/resctrl
>>     mkdir /sys/fs/resctrl/p{1..8}
> 
> Thanks for the reproducer - but I don't see what could set have_new_ctrl in this sequence.
> You can't call apply_config() to set CPUs in the mask without that being set.
> 
> Creating a new control group, (your mkdir step) shouldn't touch the hardware at all, as it
> should be left in its reset state from the last umount(), or setup.

There is an attempt to configure the hardware in the mkdir path:
rdtgroup_mkdir()->rdtgroup_mkdir_ctrl_mon()->rdtgroup_init_alloc()->resctrl_arch_update_domains()

This is required in support of the different resource group modes. When a new
resource group is created via mkdir the configuration should respect any
exclusive resource groups that exist at that point.

> 
> I can't reproduce this on v6.0-rc7.
> Even if I dirty the configuration by writing to the schemata file, I can't reproduce this.
> 

From what I can tell the reproducer is dependent on (a) whether hardware
supports CDP, and (b) the number of CLOSIDs supported by the system. The reproducer
works for hardware that has 16 CLOSIDs (see later).

> (I have mba enabled, but all this should affect is the number of closid available)
> 
> 
>> dmesg will generate the following error:
> 
> Which kernel version is this?
> 
>>     [ 6180.939345] unchecked MSR access error: WRMSR to 0xca0 (tried to write
>>     0x00000000000007ff) at rIP: 0xffffffff82249142 (cat_wrmsr+0x32/0x60)
> 
> Is 0x7ff the default CBM bitmap for this CPU? Or was it written in a step missing from the
> reproducer above?

The value of interest here is the register it tries to write to ... 0xca0.
On a system with 16 CLOSIDs the range of registers available to set the CBM
would be 0xc90 to 0xc9f that corresponds to CLOSID 0 to CLOSID 15. The error is
an attempt to write to an unsupported register - there appears to have been an
attempt to configure non-existent CLOSID 16.

As Shawn already root-caused, this is because the staged_config contains data from
the previous run when CDP was enabled and it is never cleared before the resource group
creation flow (triggered by mkdir).


CDP enabled:
mkdir <resource group>
	domainX.staged_config[CDP_NONE].have_new_ctrl = false
	domainX.staged_config[CDP_NONE].new_ctrl = 0
	domainX.staged_config[CDP_CODE].have_new_ctrl = true
	domainX.staged_config[CDP_CODE].new_ctrl = 0x7ff
	domainX.staged_config[CDP_DATA].have_new_ctrl = true
	domainX.staged_config[CDP_CODE].new_ctrl = 0x7ff

unmount/remount resctrl (CDP disabled):
mkdir <resource group>
	domainX.staged_config[CDP_NONE].have_new_ctrl = true
	domainX.staged_config[CDP_NONE].new_ctrl = 0x7ff
	domainX.staged_config[CDP_CODE].have_new_ctrl = true /* stale */
	domainX.staged_config[CDP_CODE].new_ctrl = 0x7ff     /* stale */
	domainX.staged_config[CDP_DATA].have_new_ctrl = true /* stale */
	domainX.staged_config[CDP_CODE].new_ctrl = 0x7ff     /* stale */

Above becomes an issue when the resource group being created is
for a CLOSID # that is more than half of the CLOSIDs supported.
In the reproducer the issue was encountered when creating resource
group for CLOSID 8 on a system that supports 16 CLOSIDs.

In this case get_config_index() called from
resctrl_arch_update_domains() will return 16 and 17 when processing
this resource group and that translated to an invalid register - 0xca0 in this
scenario.


> The rest of this splat isn't helpful as its the result of an IPI...
> 
>>     [ 6180.951983] Call Trace:
>>     [ 6180.954516]  <IRQ>
>>     [ 6180.956619]  __flush_smp_call_function_queue+0x11d/0x170
>>     [ 6180.962028]  __sysvec_call_function+0x24/0xd0
>>     [ 6180.966485]  sysvec_call_function+0x89/0xc0
>>     [ 6180.970760]  </IRQ>
>>     [ 6180.972947]  <TASK>
>>     [ 6180.975131]  asm_sysvec_call_function+0x16/0x20
>>     [ 6180.979757] RIP: 0010:cpuidle_enter_state+0xcd/0x400
>>     [ 6180.984821] Code: 49 89 c5 0f 1f 44 00 00 31 ff e8 1e e5 77 ff 45 84
>>     ff 74 12 9c 58 f6 c4 02 0f 85 13 03 00 00 31 ff e8 67 70 7d ff fb 45 85
>>     f6 <0f> 88 75 01 00 00 49 63 c6 4c 2b 2c 24 48 8d 14 40 48 8d 14 90 49
>>     [ 6181.003710] RSP: 0018:ffffffff83a03e48 EFLAGS: 00000202
>>     [ 6181.009028] RAX: ffff943400800000 RBX: 0000000000000001 RCX: 000000000000001f
>>     [ 6181.016261] RDX: 0000000000000000 RSI: ffffffff83795059 RDI: ffffffff837c101e
>>     [ 6181.023490] RBP: ffff9434c9352000 R08: 0000059f1cb1a05e R09: 0000000000000008
>>     [ 6181.030717] R10: 0000000000000001 R11: 0000000000005c66 R12: ffffffff83bbf3a0
>>     [ 6181.037944] R13: 0000059f1cb1a05e R14: 0000000000000001 R15: 0000000000000000
>>     [ 6181.045202]  ? cpuidle_enter_state+0xb2/0x400
>>     [ 6181.049678]  cpuidle_enter+0x24/0x40
>>     [ 6181.053370]  do_idle+0x1dd/0x260
>>     [ 6181.056713]  cpu_startup_entry+0x14/0x20
>>     [ 6181.060753]  rest_init+0xbb/0xc0
>>     [ 6181.064097]  arch_call_rest_init+0x5/0xa
>>     [ 6181.068137]  start_kernel+0x668/0x691
>>     [ 6181.071914]  secondary_startup_64_no_verify+0xe0/0xeb
>>     [ 6181.077086]  </TASK>
> 
> It would be good to know what triggered this IPI. It may not have been
> resctrl_arch_update_domains(). This pattern also happens from reset_all_ctrls() which

I believe this is indeed from resctrl_arch_update_domains() since it calls
smp_call_function_many() to configure all the domains.

> happens during umount(). (and that would write the default CBM bitmap)
> 
> If you can reproduce this easily, could you add dump_stack() to update_config() to see if
> any path is setting have_new_ctrl. You aren't writing to the schemata file in your reproducer.
> 
> 
>> We fix this issue by clearing the staged configs when destroying schemata list.
> 
> 
>> Signed-off-by: Shawn Wang <shawnwang@linux.alibaba.com>
>> Suggested-by: Xin Hao <xhao@linux.alibaba.com>
> 
> If we can work out why you are seeing this, it would need a Fixes tag.
> 
> Otherwise I agree it makes sense to make this more robust, but it would need a different
> commit message.

What do you think about clearing the staged config within resctrl_arch_update_domains()
after the configuration is complete and there is no more need for it? That may reduce
complexity where each caller no longer need to remember to do so.
I see "staged_config" as a temporary storage and it my help to understand the code better
if it is treated as such. 

>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index f276aff521e8..b4a817ae83ab 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2127,8 +2127,15 @@ static int schemata_list_create(void)
>>  static void schemata_list_destroy(void)
>>  {
>>  	struct resctrl_schema *s, *tmp;
>> +	struct rdt_domain *dom;
>>  
>>  	list_for_each_entry_safe(s, tmp, &resctrl_schema_all, list) {
>> +		/*
>> +		 * Clear staged_config on each domain before schemata list is
>> +		 * destroyed.
>> +		 */
>> +		list_for_each_entry(dom, &s->res->domains, list)
>> +			memset(dom->staged_config, 0, sizeof(dom->staged_config));
>>  		list_del(&s->list);
>>  		kfree(s);
>>  	}
> 

Reinette
