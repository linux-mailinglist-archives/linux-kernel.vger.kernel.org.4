Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A101634B92
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 01:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbiKWAPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 19:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbiKWAPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 19:15:00 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A4FD32B2;
        Tue, 22 Nov 2022 16:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669162500; x=1700698500;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FqGCsyfNIhguF00iGTYFx1SVEzy6cjZc9IO7/kCxA5o=;
  b=T89oqQQ6+YjnePPihcmgrmbZ2zBqGV2UCglHQOw7cHZI4O2X3/JBBQdU
   x/U6nt9DkxM/rg+LHLofKJEi5maPjws/ub+Vtx64r5kReluOgKGiwQ9QI
   UrgzeG4KvGPeH32T9UFlasTZ4++NR22unP95a6bcj8Nwdy0ASJ8/C0vAb
   vWRB8713+2GftSaEhOCC/sC3ifE6A9uF3/qRG/KbVainGZVg66dthgdmK
   oovvTUbmi8jVP1O/BLbmKLj1SHANpt0MJTu8wW5YyuHN2gQYx5RfRl65m
   kRjz6+YWS4/E67AVr0jFSymNmly+ZZqDKqarCCo+lPU6Km44MasxrAJgY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="376090211"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="376090211"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2022 16:15:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="970664344"
X-IronPort-AV: E=Sophos;i="5.96,185,1665471600"; 
   d="scan'208";a="970664344"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 22 Nov 2022 16:14:58 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 16:14:58 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 16:14:57 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 22 Nov 2022 16:14:57 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 22 Nov 2022 16:14:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mg91WDHS9EXyVPPXQSkH0Z6vbcgktagy+rPbfwsjKoQtK5OHhKZRd5CuRlaFkIzTE4IgvtdCz3HEFKdaPqnuBawrdqQyeEZwO5SvjCZu94uo6pBkaGgsgizmmiOfWpDQrsOBQDC4b9dFZpMCHOsjd3gitPv6ZGy9W0yqrO8VKf20kb3k62Jxuo6PFwodbaDxidwo+YSyrGqonTAzBm1ExMzl+OVA35oUD+u/vOMdkHp6AkPyv0MybP79aa1LNDlZziRxMrItPBL5H1VU98XNWnKAZDjivAY/kyELWvOTmdqOAmN1Sh/WDVxyH4SSrgDaA0+07DMBlnSJlamFm/SaDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWzQQU2n1NBMvSXoyhuaETOcLSCf7lr/cV/tuhoZzU0=;
 b=ML9A7u9KldFirHfj8XiJzoomBqnFKidmIjW3r2dUp8kGaUSdeOCNTg/MqtFSK5lvfoVC0owpic5vB+BV6v+TXfgKEbB2h47D3gFWJvuD7W94gjAu85HdnUSOuzwjhTPje7Qm0GYj++a3dVPWCEMT0FQye8xk+Pu4Gly44Kt6cm1mTo8C8H2Qznv7vsn11MHC59NY9nvOd6bZMq97adjCWTS4B3q4Dv0ZB4iF/35w7ZaChFOUp0tRppBpvjKom+K8q7ZOAu5owwV0t+P5pRTOxuRPaEfWtp247kydwLPZZvI1d5GS5EXe1HrUu7w60VoEUAcgkYy2jYNBGgpZPnzrtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH8PR11MB6949.namprd11.prod.outlook.com (2603:10b6:510:227::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 00:14:49 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::6005:96bf:e2e1:2f7a%12]) with mapi id 15.20.5834.015; Wed, 23 Nov
 2022 00:14:48 +0000
Message-ID: <74fc09e7-3a75-2c62-d505-244a12b6190f@intel.com>
Date:   Tue, 22 Nov 2022 16:14:45 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.0
Subject: Re: [PATCH v8 07/13] x86/resctrl: Introduce data structure to support
 monitor configuration
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
 <166759204323.3281208.9744810874584175730.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166759204323.3281208.9744810874584175730.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::20) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH8PR11MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: a9faf90b-af43-4931-e772-08dacce7bba8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L1YOmHCW0HZ8Ezh8rfni660ugSJveG3DYm0nYGnmXmvfPzZD5KlO747XzExIYyZmO1kuek9pvP6DYdFhJPl/YjOX9/OTsHwmppV2S9+CJ8njg4NpURGND7tm0gyjxJcFmyI0UDmTUOqKp9r8Nl0BL/KsHvG+i1S9TxjtPi/1DpXum7H0QvzPvrn2IMxWwpILbIPzmMMXVe8NQxYE7R+6RhXm2uS/XbhLDev921aabIyEbggmmf3/mpKGD/SJZunpTAfyW733lx/M6dwriIkZTfEurPOhNzRk2YZ9jjZJCE5NUMBCUzyCjRSDkEXAmQKE3JT1y43uFizaE3YZuIMRa0qVS0ltmP5fU9TNxn+BUy2jQlxYLhhRvjcCryDf59NPEttSk3SF7OwyNQbFVPmD4IIb0ONcx+M04Mx+tqryWH5536sVE3/LkzjeBklEJ1XuzY0UXNg+E17sQIY4QZofMw0uerKtpqdmcf3gQFx30sp2neBy/kSuLDZGLo7kHF/pTukOzhGBypO2ZBrGJuwSXAWjqAZiqR0PBPoEkaXZUGQasola5gW8MCpPTvjONEPEK6FvzAHFVyYi69VFFdCeunnGDKVmjOsUHOnzen7/xs2FYFWW625IJXFiXHIckNEtyDEtFbX77pR1ASowJ9K8v/CfKc+fUwpa8divuFeUtqp16Pfn+Oy1+e5SvBtR6XrkUdD/goJIEVMQX5Nm5ScM+y9bdVVd8y14C3n0YcCESjo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(376002)(366004)(136003)(451199015)(36756003)(31696002)(86362001)(38100700002)(2906002)(5660300002)(7416002)(44832011)(8936002)(186003)(83380400001)(82960400001)(2616005)(316002)(31686004)(478600001)(66946007)(41300700001)(66476007)(4326008)(8676002)(66556008)(6486002)(6666004)(6512007)(6506007)(53546011)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTl0T0h1M1FzN0lTRTliVnVqVVRXRlJKRzYrWUU3VmhnMGNmT1J1UjVDNGlM?=
 =?utf-8?B?T3ZTZnMxdUNsbmFVUkxxN3luUDJuWmlaaitVdDdGZlkwQlJQTTU3bWJKbWtv?=
 =?utf-8?B?SDRTbWdCNUZ2THk5aFFrVXJZT2lEK3pIQkV2YXh1RzZPRjNZRXlZdVBxSll1?=
 =?utf-8?B?YzN0a2hTUDF5T09iVlZ3N01MWldJTTRxZ1pscUtCNFNwRld6UUgzVUx1Wnhw?=
 =?utf-8?B?dTJDeG4xSVVMODgvQm9hWEU1TW05bXRHZ2gzK1JvOEJ6UDNSNVBSdVlFQnVN?=
 =?utf-8?B?VEFXdXJwRlgwNmY5VThpSlB6YkN1cVdLaUZnNlFwcUo3Ty9zYk9KbzJIOTIy?=
 =?utf-8?B?NkVMQ3hzcjJiMFhBQitZUWY2ZlZicU9YdGRaQ09QbFFQR002QkVPWE1WSUtQ?=
 =?utf-8?B?ZmxpOEtBNEI1RFpuT0M3YUhMRmZXMGdxNG1Yc0NRZXJMclRtREVhRWRzRDh4?=
 =?utf-8?B?c3JFQ0RndkY2ajFwWXIza0JBQitTN3lGS2ROejE0eXV0UWc3SjZYVWN4MUxn?=
 =?utf-8?B?UFRsY21mcTdtd1pFNzBadkFsZFZOMTZuWmNEVmdvN3dIb0FweVFhbW16czlT?=
 =?utf-8?B?UnkrMlV6MSs4WU9aV05DYTN5b0s5dlV1S2VNRDN0TXlxMGlQR2hhZUpUWDdy?=
 =?utf-8?B?MnNBN1Frb3FkdlVYRjl1bzlhSDFKUTRmM0puZDJjOHU4RWl3OUFsUmEvbVVJ?=
 =?utf-8?B?Nk5aQ3RSNEkvNVVIUVViaituRXRFTVhJYXRKMUtEZVNpT2xjbjQwV3RmcGNI?=
 =?utf-8?B?aWZGeitjOFA4dWVWdlpzSXVjL3lUQ3NlK05RbDdaME9SU3VYc1BuR0ZrSHFV?=
 =?utf-8?B?TWNCQlc1YkNBNDFqTEFyOTEvQ0xJVmlqTVcyV1BaMjNRSmV4MHF2c0phUkwv?=
 =?utf-8?B?UWNoNW5ZN2VYc3BZaGlFUkNPVUthWEljNE1qcytXY2p1V1F0R3RrUUtsZjAw?=
 =?utf-8?B?dlY4dHhWNWNhQ2tSV3NEL21UWFNFL2p1UHk5dXhDMG5WZWQ3ekMrYnFoVllY?=
 =?utf-8?B?RGpXamhkTTNPOW1XcThKY1MyMFJCWSsrbll2NnRFZjFoaFRmRzdFZHBJSVAr?=
 =?utf-8?B?TXdSb2UzekRrM2dISjRoMmZxZXNSTGFENXZPUGRZNlVqOXk5RGFxMmlHR0Y4?=
 =?utf-8?B?UW1NZFJLYXkrWFlhWWNOV08raG5pL3ZZOERlYUE3WnNKaVh3djcraWEvOU1h?=
 =?utf-8?B?YUtpT1E0Q1F6Zi8rSFBhVUtGOUFIN2M5dUlieVBpdHdBL3ZhTDg3KzFxc0Fj?=
 =?utf-8?B?bTZVbG1Rc0VQRDVPbUw0OWFydnBrV2Rkckx2Tm5sUmNOWHU5Y2svUDhqM2JJ?=
 =?utf-8?B?MmphbXczcERIS3dMVXpFT1c0ZTNha0JqRlZLejNWR1FLVUdZSHh0QmE1dEFU?=
 =?utf-8?B?dk5oRTNya0R2M1RKK29nRjYzWjdaaDJrSlYyWFhNcDdqaittandUQzFKMk1m?=
 =?utf-8?B?TkRBbVZRbGJ2Q25CdEtLSVpKUkVhL2dXWGhBMjEzQ1pnRnl6eWE1V2pDa1NS?=
 =?utf-8?B?b1RRdTkxYnd5bk5TRVEyc3U1U0NLTDZ0S3BPa0ZWUmhaZ0tiOTFqaGxnL1JZ?=
 =?utf-8?B?V2xhYnNKWDdldWZMOHlKZElML1phaHhHUzFFaEczSjMxZVlTblVDSmNnMW9m?=
 =?utf-8?B?TjdRV3NhendsNFBYRk1uWUozZW9TY1J3cjhXVnJXRGlPaDNOTmN2QnZ3YkN1?=
 =?utf-8?B?WjhGZmMrTGVyVGpuSXB4ZHJ0YjFaM3paNGhKd1pOZGhVTjNPY2h6emUzOHd6?=
 =?utf-8?B?c0xBdERmUXAraC9KczJlK0pLUlI3eHFIUkNINTZmNmpXbjhKUFZqcmF0U0RQ?=
 =?utf-8?B?eEVIVVNhcit6MDlUdy9aQ2xaMXlVY3g5NXQxU1RpQzY5UmhQWVU5cVpCT3BW?=
 =?utf-8?B?b1AxcVF4eDN0OXZXRkxPbWlYS0RMZE5saDZRM0NSNk02MlNMVVFsNjZRSUkv?=
 =?utf-8?B?bUFQNXZMcGRHRmZpdlBxeENFZndpRmt6eTlDenU1WUNiYXlBM0ZSeUxOWFk0?=
 =?utf-8?B?dGp0RUo1aEdaRHo2dkp2QUFjNzZ5cW5FNmN4OTNMR0lWZE0zTG1GOGIyOHFR?=
 =?utf-8?B?WTZvNlludUlBNEhGRGtxcGdJWmZqTDVvOWI2QmU2Y3ZITUZIMEVKR1dmTmNH?=
 =?utf-8?B?OWJUcmpQUlFPVXJyV2JGUzcrUWoyWmkrdFlwM2Eva2dORm4vVmdISEdaK2lp?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9faf90b-af43-4931-e772-08dacce7bba8
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 00:14:48.6610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVMlP96RqOA96DP7hdAUbHOZa783eY9GU/7s52R4/fLFiqH/poNLso4DyE0JpNwsAKsmp9wafoDCRHlCvF9XNPpHN3ZIc+rWAwYA13U8PXk=
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
> Add a new field in mon_evt to support Bandwidth Monitoring Event
> Configuration(BMEC) and also update the "mon_features" display.
> 
> The sysfs file "mon_features" will display the monitor configuration

sysfs -> resctrl ?

> if supported.

This is not clear. "mon_features" does not display the monitor
configuration, it displays the name of the file that can be used to 
see the monitor configuration.

> 
> Before the change.
> 	$cat /sys/fs/resctrl/info/L3_MON/mon_features
> 	llc_occupancy
> 	mbm_total_bytes
> 	mbm_local_bytes
> 
> After the change when BMEC is supported.
> 	$cat /sys/fs/resctrl/info/L3_MON/mon_features
> 	llc_occupancy
> 	mbm_total_bytes
> 	mbm_total_bytes_config
> 	mbm_local_bytes
> 	mbm_local_bytes_config
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |    2 ++
>  arch/x86/kernel/cpu/resctrl/monitor.c  |    6 ++++++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |    5 ++++-
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index e30e8b23f6b5..5459b5022760 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -63,11 +63,13 @@ DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
>   * struct mon_evt - Entry in the event list of a resource
>   * @evtid:		event id
>   * @name:		name of the event
> + * @configurable:	true if the event is configurable
>   * @list:		entry in &rdt_resource->evt_list
>   */
>  struct mon_evt {
>  	enum resctrl_event_id	evtid;
>  	char			*name;
> +	bool			configurable;
>  	struct list_head	list;
>  };
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index efe0c30d3a12..06c2dc980855 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -750,6 +750,7 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
>  {
>  	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> +	bool mon_configurable = rdt_cpu_has(X86_FEATURE_BMEC);
>  	unsigned int threshold;
>  	int ret;
>  
> @@ -783,6 +784,11 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
>  	if (ret)
>  		return ret;
>  
> +	if (mon_configurable) {
> +		mbm_total_event.configurable = true;
> +		mbm_local_event.configurable = true;
> +	}
> +

Is the local variable needed? Why not just:
	if (rdt_cpu_has(X86_FEATURE_BMEC))


Reinette
