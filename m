Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A62634B99
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 01:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbiKWAUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 19:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbiKWAUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 19:20:01 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0F465E55;
        Tue, 22 Nov 2022 16:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669162800; x=1700698800;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iqajjKVXsdimEkbQpIRW8Lb+TPmvAoGeX4EmsSXQXIw=;
  b=FH/wlvi8djbfDJj4PmXRiciTZfb8zcA1qjcgZvTdBlspro5NTj5yPVI3
   csx4y8dd4DyaTBu9En0c4gn3ihs+zEq7yM+5fpSm26D8Ead+NDhAtccdk
   J4qii6j8sJf1N/YTpr20793GjyqSbXS2SlYmM56OqK0KbRvmFGVQ2tBhT
   T/rUxiq/jp1TfT0wZbCBAvuvDE4vjqDc7qRk5CWlT6ho/Y9ccEhj4zadQ
   TXgqRpmxvNh3xY1M2EEXtfxHNGbSFgEpIPjYtgCindG9SxxiDs5fxNX1r
   U3kN1SA82ayuy8qKl+JkPIAGTS0O2Ji13IC5OwOY6qnRRvtnvvhpZxCOR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="294335138"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="294335138"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 16:20:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="970665681"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="970665681"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 22 Nov 2022 16:19:56 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 16:19:56 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 16:19:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 22 Nov 2022 16:19:55 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 22 Nov 2022 16:19:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cg75yEBrg4Fp4M68iuQ0Bh4Em5k8DbnoiXfhAe03bo1CvuWS7F3NLi/hmUE/0b50lDRfpPRiry4JR09eIy/FXbtlHhd0kCtcWV2SMTGsMqnrrkrHfMeqU++9Asr+MyPYPPW0qXxuWG0UyrvwMh3nOGxTqdEcC+I9cw1vtd0wFqGGHUncUmkIdzbqDXV0em93CcYc8e25NnMNY8cuhqNEEZCBT2snzZ7v2oOT+ybi8A7L74fiJGHc22ZdHDlSVyiIe7SuLh/0Y5gA/inL7kk6WzPgvN8TI0QGVF8IxnWxJJhA4Pe956Sm0e8MBFAcMYzQFYoKrQ6ip4zJynX8r8qUUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCTzk4IcRi64VK2rOnjqSQlCCPJdq+CeLhff2WHdmNE=;
 b=FbocwLewyyNbnjmkEDcYyqL5/CQ6ntDYK0Eo51+yZ5n3v8quf+u5jmyO1GqigbJoHvel8jFmg9MuhSg6RSP28DjwpheT7xklQAv/VDiv5bzPAUz9090NxmLjVtEi1FUuOAEiew7MjgCzIsj15/AJ1Ftdk11J1il+If0U3eTQd65t8ZEHLqJXb0Q7xzdtZh/eZ4xxR6jCO4Y7VO+bIKc/0kVkk69U44WYVHbZSBjhoU71iTd1etI/3lMqE+mdvug8tyscv+DI3Bdtjn3xkYStLet4giz1fLWiUau9cbBrpIjuFInA7tw4/rLF7wV2N3WSTqji8ZSPdn+DePZ9yUg43w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH8PR11MB6949.namprd11.prod.outlook.com (2603:10b6:510:227::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 00:19:52 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a%12]) with mapi id 15.20.5834.015; Wed, 23 Nov
 2022 00:19:52 +0000
Message-ID: <46d00211-e6e2-a0d9-22ca-ee0d3ca15468@intel.com>
Date:   Tue, 22 Nov 2022 16:19:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH v8 08/13] x86/resctrl: Add sysfs interface to read
 mbm_total_bytes_config
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>
References: <166759188265.3281208.11769277079826754455.stgit@bmoger-ubuntu>
 <166759205510.3281208.11437041392524040365.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166759205510.3281208.11437041392524040365.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0274.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::9) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH8PR11MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: 095a0008-c937-421a-761a-08dacce8707f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7kKNNylpY3b8aJVia9SwlwB7dgS/B5NoivfEM3o3oMoXYSSNR3KQDZv4ervF4WH3xw81vMuA/qGANbBYPNESs/iaan1TJFcrCQQnGgNRmks7+/bE46GU32/6PO+5rnN2r2octUinDaba7gdrDgVcAhdnwcnTD0fLCsPJIqRTGUf7VMA9q5/Q/Uh66xoazd6b6czd/7bJ9013K9EhGVezFwOKGDEMmYB5htWND4Y+FgVdzeiWf0VgSHcAdQXegE/cZ/e4WewZ7ORTOn0SYjd9MTQ9CPtFa44n0ZVeVKCSUZExXQYlOYQdjjwobUEsczS+9vB3aDvx31L1bhfMkGBUC0GvD+5KZ+UdxJ33toXeGEcF/UA5FsM5nihxLQFOZ5QgKCFCQGErnThy+ugPWo2g2KWrSMve3x72S6xdoW1tdHlKtnepPbwYdeVlyMDIhevZlCEHVX2i/gaTLbiRup3bzFsw4hvUg7/PD7aHHrRomI+wHptm26qlGX+nr20s8MKo5bY7IL2CXVlLUe2dMrAffdvcNXbKkLHirSu7fs8ZRqNAFGZ80EwsSEehO3Kezqp+HDGX9d4+wSXUi+O+ywkTLSjVh0LKoLLn6hXDpXRy44Xka5h4JE5EtH4vsdEv493um65JJACe28JcgdPpODOw5eDyNS2XOW/wVZm8vMnb/WshFZJE5rt7PN9QU3Sk16jFZX7+a014ipJyUF6lnU2kWR8TXhyFvx0WcawbBpDS/Sw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199015)(36756003)(31696002)(86362001)(38100700002)(2906002)(5660300002)(7416002)(44832011)(8936002)(186003)(83380400001)(82960400001)(2616005)(316002)(31686004)(478600001)(66946007)(41300700001)(66476007)(4326008)(8676002)(66556008)(6486002)(6666004)(6512007)(6506007)(53546011)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVo1bTZCL0FvSVV1RGY1Ym5YL0M3Wko1azFnNTBpa2c1UHNDTmwwaCs2TXVy?=
 =?utf-8?B?ZlhwNGE5U2pWOHB3cEM1SkxRUTJzeDV5c1JhWS82bVE3N3kvM1lvZGRJTTZs?=
 =?utf-8?B?RDVVeXVMdzFYYjZFSHU5MjFhNDRwb1hsanNQWHNKbEZmeDlCTFpyb0wrM2xp?=
 =?utf-8?B?dWRxTzFmUnp2ZWxucEVJaU9XOUtuRSt0TGZheWl6WFhmVmVSSW8vNk9KZXhz?=
 =?utf-8?B?ZklLeDhQMkhEQUF2WkFod0plL3pyMFUrTGV6SW81VzlneGFHYnc5bk95S3M0?=
 =?utf-8?B?cFFPcUtpZ0pKa2JmR3NuRUFuU3h2cWNMd04wSDZsaTU3a2h5OTZNL0RpOXRG?=
 =?utf-8?B?d21hbUdUU09MWUdybzNkSVdUcVhaYTBDczZYMTczajV2eG1LbVhqbXpDVU9P?=
 =?utf-8?B?bGxQa1hjL1luaUV6NFRRZTN6eXdxMWFsU1RFU0M4VlBOMklEaTBHbk1XM1FG?=
 =?utf-8?B?ZGJ0V0V1TzQza293MFJZTHlDU1JqKzZwT2RuK2hBbHppdUFkakVIcUJ2UXln?=
 =?utf-8?B?d0tYaEp5Q2FjN01rNFZ0OEhDMXZCaWdUcmV0STB1dlQ0cTRXRGtUamVyYUhM?=
 =?utf-8?B?cWVhWmlHb1pYM0VKRFpIb0hVMHV3RTZDcGJUYUp4bTMrSEZNRmE3YktCMksx?=
 =?utf-8?B?ZTcrRXo3QlNDdlN3aGU2VWc2U2RuOGpScEsrOG11MXo3eWREMlVySk1wVTBj?=
 =?utf-8?B?ZzByTmF3a2NCV3pLZi9PNVZWTFM3YUpxSHczclBMSHEwbWZhQThrU0svcUZu?=
 =?utf-8?B?OWlzcWhCL3VLbWZhczQ0ajdaM1FSOGpvTWk1cGRib0FqclJBNTMyUmQzRC9u?=
 =?utf-8?B?bEJ6T1BBZ2dHY2c4T05iSVNRY2NwTTRncXVNbDJ3aDU4cHkxYWFlbndrcVpN?=
 =?utf-8?B?dHJybmJnYXQvbjlDdTZUUk0rM0VVSnh6a2VBUUs0NUorZEdPc1lzMGZqVjky?=
 =?utf-8?B?T0d2Yjk2bkZoYzNzOWYxRnd6eTBieEhnOHQ3UFpJZ0hiQlpnLzVwL0xuVG5I?=
 =?utf-8?B?TW5EenllU3ZNMERrVHU3RDRjMVdlZ25VN200RlVmOWsxUjNVOUgvbE9mam9H?=
 =?utf-8?B?dGVpTkt5blQzSC8wcU1seWkzRnNQakh1eE5QQU15VDVHcXJ0N2NlQ1NtOEhX?=
 =?utf-8?B?aGl3dzBDS0ZiRkc3SG5NYjBmZWd0M0FxaHd2Wm93V1BzUHQrSVpzdGVNYUxG?=
 =?utf-8?B?bThKaEdzYUo2MHhYWTJLMnQxL0NvWTcvb3I0bFFoanBPQk00VTlKeUF5b2k4?=
 =?utf-8?B?cHVSaFZ6TzMwbWkwdS9XK2lsZXZmQm9EQ3BqRHpwRWlJZSt6TFlDbGlVUDlS?=
 =?utf-8?B?ZFpJa2xVbTlkUkpXTkRyamluVlFTZ0tobk0rMTVTWmdsZ094OTJ6OTBXQi9v?=
 =?utf-8?B?cjlocGk3andDL1YyRVY5bjB4V1dtM3BKVURUcCtVdmZ5Yis4L2NOajAwVTZ1?=
 =?utf-8?B?RE8xN0twb1RvOENtQjFJUEdYMlhsSmRTWnJaSTdhMEs5WXgvV1RXeHZIdGU3?=
 =?utf-8?B?d0R3Q0xZUjl0SEJzYnlDNE8vemN0N1ZqWnd4MDZQSGZsZ3pFTFllWmhZb3Nj?=
 =?utf-8?B?MU5OVFdPcEorVjhwZ1Y4a2lwV2M2ZHJkcE9vRGM3RDNMU2RreUs0aFNCUVRN?=
 =?utf-8?B?MmUvZ3ZZUjVVdUZCVTBDQnVaOHlBRTMyOG9kcEgxRlIyV0pWT2Z0QmpWNGhP?=
 =?utf-8?B?aHBDTWlFY3l6Q2ZVSmNsZW13NjRoVmxZY3ZHV0JnNmgzNjB2b1VrY1MrN0RC?=
 =?utf-8?B?OXBDTDR0L21pTHk2MnBvTzF4a3h4OFRRYi9HUldmNmN2NUplVzhDNEFvZ0dB?=
 =?utf-8?B?Tit5RjVXYnZSQ21sZ1NPUEdacW9kV25SOGdaczZtTHJjNExFVnJXWWZ0UWNs?=
 =?utf-8?B?WFVEMWJEeEJZdUwwblE0WTNaRUNXaTdxZEMyTlljWEh3UTFrT0JXaEFCd3ZX?=
 =?utf-8?B?Q0w0cTFJTkk5TTBHZG1TU3dFZzlBbmR0NXpoMURpZnpLeHUxdytTdi9pQThs?=
 =?utf-8?B?VnE4OE5BZmJnUmZ3Q1grUjNaYkEva2pVZkk1emFnRUh1amFYZG5oeE1TekZN?=
 =?utf-8?B?WDQ2WGlENWp6bmhBUUI5SE04RStSMndwaVRKOWhEMnRZdGZrMitwNTFWODVm?=
 =?utf-8?B?NXY1RzZhZjNoRDR5ZzN0V0wzUWF0U1NLQlNQdkhrUFlpTm9ja0N4Q2loZVJp?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 095a0008-c937-421a-761a-08dacce8707f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 00:19:52.1039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgJ0ZbEnNHcTPOBIQn/drQKfTwLKA2OlaYDpAyJcF0J2h721TGR2e+yIYJ1DlbdjoHXrfkdcoTXnUbuFqsvECAtHT8dSgdJoGXyXPhutzGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6949
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 11/4/2022 1:00 PM, Babu Moger wrote:
> The current event configuration can be viewed by the user by reading
> the configuration file /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config.
> The event configuration settings are domain specific and will affect all
> the CPUs in the domain.
> 
> Following are the types of events supported:
> ====  ===========================================================
> Bits   Description
> ====  ===========================================================
> 6      Dirty Victims from the QOS domain to all types of memory
> 5      Reads to slow memory in the non-local NUMA domain
> 4      Reads to slow memory in the local NUMA domain
> 3      Non-temporal writes to non-local NUMA domain
> 2      Non-temporal writes to local NUMA domain
> 1      Reads to memory in the non-local NUMA domain
> 0      Reads to memory in the local NUMA domain
> ====  ===========================================================
> 
> By default, the mbm_total_bytes_config is set to 0x7f to count all the
> event types.
> 
> For example:
>     $cat /sys/fs/resctrl/info/L3_MON/mbm_total_bytes_config
>     0=0x7f;1=0x7f;2=0x7f;3=0x7f
> 
>     In this case, the event mbm_total_bytes is currently configured
>     with 0x7f on domains 0 to 3.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |   28 ++++++++++
>  arch/x86/kernel/cpu/resctrl/monitor.c  |    1 
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |   87 ++++++++++++++++++++++++++++++++
>  3 files changed, 116 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 5459b5022760..c74285fd0f6e 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -15,6 +15,7 @@
>  #define MSR_IA32_MBA_THRTL_BASE		0xd50
>  #define MSR_IA32_MBA_BW_BASE		0xc0000200
>  #define MSR_IA32_SMBA_BW_BASE		0xc0000280
> +#define MSR_IA32_EVT_CFG_BASE		0xc0000400
>  
>  #define MSR_IA32_QM_CTR			0x0c8e
>  #define MSR_IA32_QM_EVTSEL		0x0c8d
> @@ -41,6 +42,32 @@
>   */
>  #define MBM_CNTR_WIDTH_OFFSET_MAX (62 - MBM_CNTR_WIDTH_BASE)
>  
> +/* Reads to Local DRAM Memory */
> +#define READS_TO_LOCAL_MEM		BIT(0)
> +
> +/* Reads to Remote DRAM Memory */
> +#define READS_TO_REMOTE_MEM		BIT(1)
> +
> +/* Non-Temporal Writes to Local Memory */
> +#define NON_TEMP_WRITE_TO_LOCAL_MEM	BIT(2)
> +
> +/* Non-Temporal Writes to Remote Memory */
> +#define NON_TEMP_WRITE_TO_REMOTE_MEM	BIT(3)
> +
> +/* Reads to Local Memory the system identifies as "Slow Memory" */
> +#define READS_TO_LOCAL_S_MEM		BIT(4)
> +
> +/* Reads to Remote Memory the system identifies as "Slow Memory" */
> +#define READS_TO_REMOTE_S_MEM		BIT(5)
> +
> +/* Dirty Victims to All Types of Memory */
> +#define  DIRTY_VICTIMS_TO_ALL_MEM	BIT(6)
> +
> +/* Max event bits supported */
> +#define MAX_EVT_CONFIG_BITS		GENMASK(6, 0)
> +
> +/* Max configurable events */
> +#define MAX_CONFIG_EVENTS		2
>  

This max being disconnected from what it is a max of looks like
a source of future confusion.

>  struct rdt_fs_context {
>  	struct kernfs_fs_context	kfc;
> @@ -542,5 +569,6 @@ bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
>  void __check_limbo(struct rdt_domain *d, bool force_free);
>  void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>  void __init thread_throttle_mode_init(void);
> +void mbm_config_rftype_init(void);
>  
>  #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 06c2dc980855..a188dacab6c8 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -787,6 +787,7 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
>  	if (mon_configurable) {
>  		mbm_total_event.configurable = true;
>  		mbm_local_event.configurable = true;
> +		mbm_config_rftype_init();
>  	}
>  
>  	l3_mon_evt_init(r);
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 8342feb54a7f..dea58b6b4aa4 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1423,6 +1423,78 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
>  	return ret;
>  }
>  
> +struct mon_config_info {
> +	u32 evtid;
> +	u32 mon_config;
> +};
> +
> +/**
> + * mon_event_config_index_get - get the index for the configurable event
> + * @evtid: event id.
> + *
> + * Return: 0 for evtid == QOS_L3_MBM_TOTAL_EVENT_ID
> + *         1 for evtid == QOS_L3_MBM_LOCAL_EVENT_ID
> + *         > 1 otherwise
> + */
> +static inline unsigned int mon_event_config_index_get(u32 evtid)
> +{
> +	return evtid - QOS_L3_MBM_TOTAL_EVENT_ID;
> +}

It seems strange that the validation of the index is split
from where the index is determined. I think it would be easier
to understand, and reduce code duplication, it if is done together.

How about:
#define INVALID_CONFIG_INDEX   UINT_MAX

static inline unsigned int mon_event_config_index_get(u32 evtid)
{
	switch (evtid) {
	case QOS_L3_MBM_TOTAL_EVENT_ID:
		return 0;
	case QOS_L3_MBM_LOCAL_EVENT_ID:
		return 1;
	default:
		/* WARN */
		return INVALID_CONFIG_INDEX;
	}
}

What do you think?

> +
> +static void mon_event_config_read(void *info)
> +{
> +	struct mon_config_info *mon_info = info;
> +	u32 h, index;
> +
> +	index = mon_event_config_index_get(mon_info->evtid);
> +	if (index >= MAX_CONFIG_EVENTS) {
> +		pr_warn_once("Invalid event id %d\n", mon_info->evtid);
> +		return;
> +	}
> +	rdmsr(MSR_IA32_EVT_CFG_BASE + index, mon_info->mon_config, h);
> +}
> +
> +static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mon_info)
> +{
> +	smp_call_function_any(&d->cpu_mask, mon_event_config_read, mon_info, 1);
> +}
> +
> +static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid)
> +{
> +	struct mon_config_info mon_info = {0};

> +	struct rdt_domain *dom;
> +	bool sep = false;
> +
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	list_for_each_entry(dom, &r->domains, list) {
> +		if (sep)
> +			seq_puts(s, ";");
> +
> +		mon_info.evtid = evtid;
> +		mondata_config_read(dom, &mon_info);
> +
> +		seq_printf(s, "%d=0x%02lx", dom->id,

This is a u32 ... is just x sufficient?

> +			   mon_info.mon_config & MAX_EVT_CONFIG_BITS);

Please do this masking within mondata_config_read(). It should
not be required for every mon_config_read() caller to validate the
data because they may forget (re. patch 10).

> +		sep = true;
> +	}
> +	seq_puts(s, "\n");
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +
> +	return 0;
> +}
> +
> +static int mbm_total_bytes_config_show(struct kernfs_open_file *of,
> +				       struct seq_file *seq, void *v)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +
> +	mbm_config_show(seq, r, QOS_L3_MBM_TOTAL_EVENT_ID);
> +
> +	return 0;
> +}
> +
>  /* rdtgroup information files for one cache resource. */
>  static struct rftype res_common_files[] = {
>  	{
> @@ -1521,6 +1593,12 @@ static struct rftype res_common_files[] = {
>  		.seq_show	= max_threshold_occ_show,
>  		.fflags		= RF_MON_INFO | RFTYPE_RES_CACHE,
>  	},
> +	{
> +		.name		= "mbm_total_bytes_config",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= mbm_total_bytes_config_show,
> +	},
>  	{
>  		.name		= "cpus",
>  		.mode		= 0644,
> @@ -1627,6 +1705,15 @@ void __init thread_throttle_mode_init(void)
>  	rft->fflags = RF_CTRL_INFO | RFTYPE_RES_MB;
>  }
>  
> +void mbm_config_rftype_init(void)

Does this need __init?

> +{
> +	struct rftype *rft;
> +
> +	rft = rdtgroup_get_rftype_by_name("mbm_total_bytes_config");
> +	if (rft)
> +		rft->fflags = RF_MON_INFO | RFTYPE_RES_CACHE;
> +}
> +
>  /**
>   * rdtgroup_kn_mode_restrict - Restrict user access to named resctrl file
>   * @r: The resource group with which the file is associated.
> 
> 

Reinette
