Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145006030B9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJRQ1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiJRQ04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:26:56 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11698BBF3B;
        Tue, 18 Oct 2022 09:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666110414; x=1697646414;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sf5SHsVjiAEoTu244K14Z2jqMZf/Eei1VxvPlXkg2+I=;
  b=e+N9DKV31ALv4/mhJCFvm6OG8ETXb3z4P9m2QVGzRJUIEhgvxaPATVSS
   tAh3Wjvp4z9XgQ89hyqHRRIDWY3s9XBGZNbdOc9BekuTQmtElbpKnn6P7
   rn5ZshOtqYPym4u8MENkE7un6nIFTLoIHQObFhGsbSFAYelKabnFYrhQJ
   35gzJATLqPXOfaKTMu0v8FWuouhWzOKzad0r1ny/RMWiXLyZpx5Fe/jML
   e7jKwrAkkPOyvucG5NJ1MY86Z3ndwwPqDPUsC3X3vRg9dFGVTiOapv9wV
   vS+a9ofFTHYzCighZWTW1QWam8ExJW/COVk2xD9eVsD60IrFyaVKhDGtK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="307820198"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="307820198"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 09:26:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="771287872"
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="771287872"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 18 Oct 2022 09:26:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 09:26:50 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 09:26:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 18 Oct 2022 09:26:49 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 18 Oct 2022 09:26:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibjJClgJuMsbwStoLEOjZ+O9Vvv6IEN97/kQ0nkkNTkhpqmihJl2vGp5FsCDmEv7Bc2ViX1xg6wx2MymjGmFc+4U/kTWAg1dWwRPxAVj81/S3R7zx9F7Bp2guVzXCxd8qEXyPcpRoX3FxmC9KhUy6382Slxj5QbgrocTcIgpa1ukwS74xQ9WuatERqUHc1lLilQhfdzH5o1bEaOeFwCY/gQVq+BJvsFMiKHzkukaYFzvTGJzXiToZEmYZlOLlFW/Xjfw58vuN9NmltsmCmtGdR8T9MxfmcmNocuLTido+4fT9jZ2FSmbv9nkcWqyS+X1HZAYlm/Ze1UKRtbVIaRQsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XjzoV82nyjFJ16n7bh7hnsxrT0akNwY1DaVS6xso4Y=;
 b=lDg7HRxFP4PKDtExytDSWP/PP7aiujWq9nBGA2hxswnWpCAkpGu5x4DyMzIHoHjK6x1mMI3mi7WiOSeQ6TLV1c6N7e3EYYM8XXrLJxmwPOtJe4iPVo8QFXgJR1BmshGtLZD1626e3xhRrTIsXMMf3EbVgrHgU3W789FHNLU5itQWmQA+KogA527DfK06MzVyG/Iou9YDPhTqGzrkZkI4yDpxhfq1OxXlWk4yaTbAmXC0V1AkmZZVVgTWzauRdgQwXjmmycBDyytekBQ5sCwQmUBgdgCgNJDcbyb8jDcf+AY74r4CQhh+0JOOdZQ3p7Sd+PXamTZWKoyc1TeY91GfCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Tue, 18 Oct
 2022 16:26:47 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5723.033; Tue, 18 Oct
 2022 16:26:46 +0000
Message-ID: <703e6dfd-68d6-6def-183d-fb99b39692b3@intel.com>
Date:   Tue, 18 Oct 2022 09:26:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.3
Subject: Re: [PATCH v5 0/2] x86/resctrl: Fix min_cbm_bits for AMD and code
 cleanup
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     <fenghua.yu@intel.com>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Babu Moger <babu.moger@amd.com>
References: <166430959655.372014.14294247239089851375.stgit@bmoger-ubuntu>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166430959655.372014.14294247239089851375.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0151.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::6) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH0PR11MB5191:EE_
X-MS-Office365-Filtering-Correlation-Id: cadfdf73-efdf-4745-a4fd-08dab1258ce1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z7czbwh27hzE4e9jCwUurLsqlcok9eKDcbuZsOtFmZ0STy5tH0OiuzGa2CwtN9QOeB4ZiFS2K5ch9TUgagSYJlXrcruWmJjTP6YBjsfK1coKaZ4O+5D6+SujMb3qF0TtkQkDCsyjO0oO8Zuhd3BLf+lyPDx8uvmKan0uqooENK7M2AZp+c4fz5gapHHos6jYvosXe093Oe8/OaYyK7HoLjnrXlGzTSuSfBy4fI5Qx4mvg0OFi76Dl8U0kTvLGatDzeZFIeWPM71rVSXiydquYXzk9wdxwNRi7xWH2685UVsCGOihJ35iGy5ZQTUwbLsJj4K1oGmDs8J61TTQ5SWNc+umaafS2xf582tgVo6gvreloUKRwZz0fWBazfS5tWtdPV1XCBfRW9a6Rca4F7OmciD7eSYZH9MBrPSRYLIcC+idSwfF5vhSBEkE9AMRUpIjVez1VeAZIsxXgp2M6M5p+kCC45KF3St6BIVGjpyI+Jm40r3PKAzcBQfHOrJfxMY0uTCmLxo/5xAMJ8QmsZtl7QFsMhkBdpeoG8L06CjzOX5HxkDcwgYMdp3B0jq2PJxrZADykPqtWT/xhkUJIUPthkoh9z8ORn2Nnh/k4y0/BZdY7qQ2Gm1GCtMX0hJSgY5S3OEPlz7nTxkVS+N0TT/I5IFM6hd4YRyXJD0iCUdmA8ruXfAij7DYK5xUgAa7+JvltGAJhejO8M0ev//GszAabrYteIPSZSOneMX5rotzCn1608iH8mdaHgSIM/XTW+iIaUozaDMxxW0pOWuiXXMOTXNz2IA6kSbYKmWh53TAMwbOKWk5WS/BoRFx00FcCHSp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199015)(36756003)(31686004)(82960400001)(86362001)(31696002)(5660300002)(2906002)(4744005)(7416002)(44832011)(38100700002)(2616005)(186003)(6486002)(83380400001)(26005)(6506007)(316002)(478600001)(6512007)(966005)(54906003)(66946007)(66476007)(66556008)(53546011)(110136005)(4326008)(41300700001)(6666004)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emlIKyt2MTVkQ1RuMU9NS08wREVTZFYrYko5ajVFR1VBd053Tzl4WDRySE5m?=
 =?utf-8?B?b282Znp5THZGR2dHU1A5c2FTRDZ1VXgrQlZQcmdvblVoYUN0V3JOaE1zL0Fp?=
 =?utf-8?B?N1o3UDZPQVAvanpvU3lOdUFvdWRKdkd6ZFVkTHRvdUlDRk04bzEvZ2xyVUZP?=
 =?utf-8?B?aGtJK2tFa29zTnNTQzVXM3JVc1dYME1SbXo3VFVKWDY4MW1scDE1c25zM1Nz?=
 =?utf-8?B?KzFpelVlWW80TGFveHZ4clhRcnJkQm9IVUdIcnRJRHVlSGFmYnBMWHltS3ZI?=
 =?utf-8?B?eFJwNVNLbFVGU0tPVytNWC9WVDRyZktZdFNZcmp4eWZaK0RrcCsyMWp3cXkr?=
 =?utf-8?B?a3JLNXhPTEVnOGdxVWM2V21pSlR1QzNkZjFheUJaZzkrY1ZNdkRHajF5ZDZS?=
 =?utf-8?B?L2JlN3IxUGloVCticks4b3UycjROZmlsUldjVEtSangyK2ZpQWhNQ3JvVmZ3?=
 =?utf-8?B?SysxbFJaZW9IYnlXOWsyUWhqdndiMjhQdGhiQnJqcWZuU0Q0YVM0cW54aE4x?=
 =?utf-8?B?L1ozdkl4ZjU4ODRkWmZqQ21zSmlURkhwZEk1S01ubllxR1ZuNVErM2dyVTIy?=
 =?utf-8?B?QnhJRy8vcnIwbmFBSUlmUWFoQnRqaXkxdzAySFpxaWZMK0NSOHhmSUlaU2cv?=
 =?utf-8?B?Lyt3ZysydjV1bnltV251TnRtVmc3dEZUR0tQVGJ6djNGN3JwRk9QbXNxbElG?=
 =?utf-8?B?eWYxc3V5YVBoM1JmT2czUHRoVm1DS1p5V2pUYzVHcHg5OGZxdTRXYkNWRE5Y?=
 =?utf-8?B?VURvQ3E4SHozRTlzNEhyc2dwc3U0K1M4UmVGMUpWOTZEa1UyNUJQT3dIOTJ3?=
 =?utf-8?B?VEd6dTNiUFBKWWFQTEdOcmcxdEl5UmhDRlRnMWorNGVwR0x4TFhwK2FqNk5C?=
 =?utf-8?B?dGZJbFREenhlbWZuWnA2TlU3ZWdkTkhGQmo4eGZuSXhOQ2hnLzBJOGZNY3VV?=
 =?utf-8?B?VkQ1N25RUXBLbVN6U1pkOUhJdkNqWWxpUGNMRzg3VjJ1VkN2NFJOdTBoZEJQ?=
 =?utf-8?B?OE9EVEJlYXR3UkRLeVZ6MjdYWEtXazcyaS9iS3QvVnBRejdjQkx1NmdiZkdr?=
 =?utf-8?B?NGhFUHkxVnZ6TllkNHVFdVFJdDEwbk5HSUI2dXBadWVubnN5M0NJMkpVaUJM?=
 =?utf-8?B?L2xmd1lDY05XRG9yaUYzMU4veUpjbmVjTHJVK1VsakFSbmhuL0FvbU1mekFj?=
 =?utf-8?B?KzR0TXRHUWlPWG96T1BidXBxU0dFQmRCU0p6S1NIaVlSUkJCM2c1QVdEQjda?=
 =?utf-8?B?VTNJcjBjdXh4YU1LeENlcDVhWGJLSVhDckdONkNBK1Z3Y21zRE9ZNnhPRHlr?=
 =?utf-8?B?eEMrWVRuZEEzUGlDVnQzMWFZZ1RPYWlJMGNWR0hKMkRFdXN5WGZIR2JRZXJi?=
 =?utf-8?B?S0E1VHEwUGtlUzRjTmVrQXE3U3QrNVZXN2NrS1F6NUt0Y2dQbW1iWklQWVpz?=
 =?utf-8?B?bGJoZHBGQlhEd3hyTkZBNHFNM0FGRmRlUkhlcGNhUHl6VWQ0bkU0UDRLanZW?=
 =?utf-8?B?UUh4bGFNMnBtU1NVb1d0cGY4RnZISkpCNGFkSmhpalQyQm9vR1hzdU45Z3lm?=
 =?utf-8?B?WXlFMTFLNWVHUUxJamhnem9zQ241SktiOFEvS2gzeVNIQkZjendwcXNHU0Zq?=
 =?utf-8?B?OFJtYmdXVE9iSEtKNC95bHdSeFlQNXZrYjZ5eFZ5QzhQd2JuU2hndWlCQy9i?=
 =?utf-8?B?VVFxZkphVEhyMGNHWmhYb3pvdUpTTWpoYWYrTUs3blE2RUFFdlJ5ZWZHNkNJ?=
 =?utf-8?B?OG9JdkpIb1pUL3FkelllNmZNWURSeFd1TDZyYmM5Q0xXaHp4akZodituakxG?=
 =?utf-8?B?T0taNDdjRW9BSDJnRHhMRUx5QnhtTFdnYkZoc21DTDZock1aRDhid2xxNnBT?=
 =?utf-8?B?bWFXRXNZTHdkejI3YTB0QWJ2bEgrcHA1d283Z2swUWRzVkl6K0s4cDd5V1JP?=
 =?utf-8?B?bjFtdnZlU1RFa0VzbFpOSzZFaEE4QytZQ3Iycm5Bcy9jSmgrVy9FSm1ybE9T?=
 =?utf-8?B?RWtpQ2pST0gyRGFUS3pTb0kwd0M2R2pnWm9uY055dHlVMGg5cS96OHFTZzls?=
 =?utf-8?B?Tk8wbHk3MUJ1amV5Qmp0UXg0Z0lMN2RvZGZvQUdMRzJieDMxQXI2dGgwSnVS?=
 =?utf-8?B?MDNmcVh4L0hGdW9jTlU5c0JPRVp5c2xrYmg5cEsyZ25hOTFTaHBTNlVHY2Vv?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cadfdf73-efdf-4745-a4fd-08dab1258ce1
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 16:26:46.5131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6dg7qJNjvt3zCL00TDZuQlW8KYrOlcu8AzjtpYwgWiKQydoal3dPnSkar8F06Jz9XS8gPihi2HCAw7gKx/OTjfvPBcgRWofR1lzSbJbwYYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5191
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi X86 Maintainers,

Could you please consider this fix and cleanup for inclusion?

Thank you very much

Reinette

On 9/27/2022 1:16 PM, Babu Moger wrote:
> This series adds a bug fix for AMD and a minor code cleanup.
> 
> ---
> v5:
>   This is bug. So, submitting these patches as a separate series from the old v4 series.
>   This was a comment from James Morse. 
> 
> v4
> https://lore.kernel.org/lkml/166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu/
> 
> Babu Moger (2):
>       x86/resctrl: Fix min_cbm_bits for AMD
>       x86/resctrl: Remove arch_has_empty_bitmaps
> 
> 
>  arch/x86/kernel/cpu/resctrl/core.c        | 10 ++--------
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  3 +--
>  include/linux/resctrl.h                   |  6 +++---
>  3 files changed, 6 insertions(+), 13 deletions(-)
> 
> --
> 
> 
