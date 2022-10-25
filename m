Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4245260D829
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 01:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbiJYXtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 19:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbiJYXtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 19:49:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612EDA4BA4;
        Tue, 25 Oct 2022 16:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666741739; x=1698277739;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DPYgY4WJOq0Qff75Gk1wNpqpNXf58IcHCnTav56OfpQ=;
  b=msPK8Ao8li8Ge4Ya1Djriw6IuAxmLCrf61seJVt2f839tiPB5pnWNTK6
   4EUZURn8uFbm1Z7h2hJpJpMGkz7xwcIKZyYKCrssGBLHI/CEWtAjfH8o4
   mvKMYl3b0X6edT5iCpTFTF18fhuIVqicmb+Of5LNwrtBUjJUJ5fWlL4pB
   ME3CkFFHY+HDoHSkvfBWaPed3ZrF7/BGX+Sewcpabzmx3Voq9ibtj8MU2
   3APwU6SB48OtPFHYgHomyCSS5e+uEgzJOtJwoHedg1EI5GWMJMlTNUQ2j
   CDe7wpqQAQXjTPVp1px/wo5J09xeax+LslTRCHwoMKxriumXjHDjt5uFM
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="291123189"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="291123189"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 16:48:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="695156072"
X-IronPort-AV: E=Sophos;i="5.95,213,1661842800"; 
   d="scan'208";a="695156072"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 25 Oct 2022 16:48:57 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 16:48:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 16:48:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 25 Oct 2022 16:48:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 25 Oct 2022 16:48:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YL2ljlteOYu3QAvMrlUEW46Kg1bjxY8fuBIxm+G//Ag3mE1lCxcEORoppCoY8bpfV63y398pr47bzM5IM632fE7qm59iLmelG0wTwdtkd5rdP2NcnMFCGSPbjXAx0y+jm30Kg/B5LJw4XuQxERXid1YI7euuGQ0vPgCaKMAlPdofaIqjGdbnq2s6mYGCAIdIu9eRHUJ/L+JITumPEXhmefZrASGOIrhM//3OXMXH6Z3xcLg0ZIUFyjnNIw6ESSMnKNSZiTC0lS4Ric+69KivcjNf9sYmPs3bR2i+su/bgINPiny2YoWOAaVOoA1XHzXr4STt4/t5ucBWDY/jA7Thpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+AUCZCQ1HuJOqJjtEc0movmhz+a8ihDHXpercxsY6I=;
 b=YVRVwjJLtxsknArCYoFY2dBgZ6j3JbV0LeKb9oA9h0vTyn/8365OpDM1Z0lYFDnxiZfIvp7vy7OE4XsJZnk9pNt/AbUEXUUzaysc9wsUQeWdFIpPtKSHtNya2q5qnaOAleEF+uRMUtAqCeDSt1wdXpLLom/8POuJY2DkmneO1A2jLDOc3sJPKtI06cbSVw/DyhYalqDwg/Zn73v1ab6R+mdRdb+ix3iljh9L0MaVu99lI9Gah8c/sz2BKFIwUZ0eirzX1FmBJ6scbKcxHVBacL+VGaf+j+7CwCF5NbsO8bOGOgHiChNpKNof+pVhxe5fKPNAHBjyLhQWUflpuIDfPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CH3PR11MB7201.namprd11.prod.outlook.com (2603:10b6:610:143::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 23:48:51 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::207e:ab0b:9e29:6a4b%12]) with mapi id 15.20.5746.028; Tue, 25 Oct
 2022 23:48:51 +0000
Message-ID: <28a0c3e6-a746-edbd-e7ec-06ec5eb414c9@intel.com>
Date:   Tue, 25 Oct 2022 16:48:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH v7 09/12] x86/resctrl: Add sysfs interface to write
 mbm_total_bytes event configuration
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
References: <166604543832.5345.9696970469830919982.stgit@bmoger-ubuntu>
 <166604563304.5345.2402589906956965706.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <166604563304.5345.2402589906956965706.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0038.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::15) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CH3PR11MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: c7552806-f2c8-41b9-c718-08dab6e377bf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TNteIModbvNHRa3/GEGS6/dGeYt2G/WONInJKG2Fe22e4Ulw5hOSw9rkXWa0TwhEChmeuGz+Pmy/z4tbifgtpluAz5GJsFwoVeUkFthvATi4A0z24Ddk+zhRE8fpKkobvPfW3eABr5qF2WXBjEJn0phyJe3KRZ78s5rNyr5jdhl/zwgY7tiGxqcXryFvtZW1YJpIZKEhswdSyv4CCnKDBeCJXtF0/96X1dx1jo66La2VayA1W2CNuEXVIepNFXynpF0hWhcrlDPBpHI7vw4bwRKVD4YQXg/44z6oUfhOsIYi/oFuXwVugTLNFdBE8k/JXVNmuEaj8GnnojGlRVxknD9YWUURga+7IySA31Fmi+/FVhoePwuN4vydKaX/DmqjlFfID4zJkMaegGqXZo9se1r3JAhgriYPFoJpp4lOUnTEE818wDwdlycrJLKtnxR6GJhp1fLf+YWgHGNId8ftnDyA/sHat0OdU1Q5W/sSqP2doyKrxOq1+OvMHobGn9eSQSAJb7MmpWiP39iG4rv6Lpzosnrl20CjrQzScbvxGqFBpv0RDOtOnwX3TG/TfC8ez3/JL2P2I05lRuIDbbA/ykQ8YF0gYgx8NhmBLIZLcWSusoBsPrCgt16aDQnUBQWVi6WO/YDE1Dm4VLfaxMNDa/oJUBsbZVtQGFIa7TvxYMg3T2UcYaQ1b6S5DpzKO/urvdHJcv+6QbyyzuCWrOrwoWVWkxNVB96fw0WHh7CFUDLvK6w17d7SSXJKh9AvCS+E/PCWBNwEVxVomUeGD8nIDOLqg+pXsIwSkDT3XDX96QM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199015)(8676002)(82960400001)(83380400001)(478600001)(6666004)(4326008)(36756003)(6486002)(44832011)(41300700001)(316002)(26005)(6512007)(86362001)(8936002)(38100700002)(31696002)(2906002)(31686004)(2616005)(7416002)(186003)(5660300002)(53546011)(6506007)(66476007)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ryt1Rmx5MkdnRmZuYVMxak9mUXNsYm1mUDZESjFhN1F2WUhaZlhOUHBGK0Z2?=
 =?utf-8?B?ME92bGxQYTgwdWFobnhwbHllYXpEanNnSXJ3TGpoWmF2QTV3Vzg5OTBYL0NQ?=
 =?utf-8?B?L09jUkNiUm0yQ3lTOFRBN3hCbmhMMTNzV0pQRVVKUTNUMEZWai93ME04RDhB?=
 =?utf-8?B?M3BzL2pLcFZrU082Ynk2aGJJSndJeFU3amQ2RE9HTUVSZURHTU1UMU5wcExs?=
 =?utf-8?B?d1NoNVBxSWtTZnlhZDVNRnd6OWplTCszc1l1S3h5cHlYWFM0WDJhWmk3bk8w?=
 =?utf-8?B?NlJHSGVtODJVazJydnh3dm8zS29mWDVDK2FXdFVJQml1YnNWbmxxd3Y5enJI?=
 =?utf-8?B?SEl5WUVtZlkyUnVtd1ozSnY5VFhmZXBDRXc5NUlGL0p6cFkrb3hUUzdoNVVV?=
 =?utf-8?B?VVVmdlExcnM4SEk0czhaY2lxL3UybVNQMWozREJjcTcxdlRDb3BYbzdxVkdB?=
 =?utf-8?B?VkFzNkt4YlBQOTNBTVJQbmpiNlRuVkcwU1Z1b3U1dnVySWpBRnovK0VUV2J3?=
 =?utf-8?B?NHhBWEc1Z0RTWlZxNkNHR0dKNmdFN2FVNG5SeUxMSWpZZkRhRzNqcWJnQ1NH?=
 =?utf-8?B?MjZsZkZSdW03bjVLaFFsYkVUR1Nla3d5U3hwaFpPVUUyYTNpWHJGNDJ5WHI1?=
 =?utf-8?B?Y0plMnZiaU5JVnBFNGtKSTNTK3RZaktQcThsTExwRTdKeXFiYVVORzBhQmty?=
 =?utf-8?B?UHI3NjR4WE1FcmwzenA2VTlnNUxXQmMveExxZFRSdk9XbnE1MTJHMzVzWGQx?=
 =?utf-8?B?M2NSeHFCSUJPTFFKb3ROT3BjejNYRmo5cWluS3o3Tm9DR0ExYjBGcmltN05x?=
 =?utf-8?B?NkFWU3VTaFlmSHNPcTRqTlpnbldURVFwY3p5UlhhTEo2WkFwZktpd2s2ZnFL?=
 =?utf-8?B?UjRVUm9XY3kvVnZRVDN5UHhZMTNSWXRoZTFnMFoxTjlqNVMwMEVWejNZUVQr?=
 =?utf-8?B?Slo3NDFXb3prU1hxYWo1cXYrN3pXRmtLL2pJUnlpdFZwRHNtZTMyRXlqSjBh?=
 =?utf-8?B?RmlPT29TZC9kaDBLVE1peldoU2ZvZmdwTE9FMmhPdjZUakhhSXNlNW1YTDJ2?=
 =?utf-8?B?U1NwVTdFSkxNaWlabHNJM0h4dmlyTXJsbmx3d2VpNzBpbFZOYy9KWGxuckpn?=
 =?utf-8?B?ZTRSQlB4M3pYZnc0STZBSnhzRTFhYWpOTk1IS1BiM3VWYnh3bkJEcFBHT2lG?=
 =?utf-8?B?dE9SakZFRkZ5TTRhcWg4bmp2aDByWlNBNDNuWC95R293Y1Q2T0FyV04va0wr?=
 =?utf-8?B?Ujg4dlo5NkhVUzUrMkhiK3dOQjF6UVcxVzZzUVd5WHJha1lQd21zRFhJYXda?=
 =?utf-8?B?bUFSUFozcFpETzJ6TkZVaFp6bEQyMzVJblJHcUx0YjFUT0hnKzgwbU43MVBR?=
 =?utf-8?B?Z0dqQ0lEb3ZTaGNsS0t6OGhTYTIxMlNXcElnMFVVYTE1WGdTZXIyYnpOQUJo?=
 =?utf-8?B?amEwMXlSRXY1ZzVKT2NBMDRsOTBVckdvUzB6ZVJiK01EV2I3U0pPbXFtRE9w?=
 =?utf-8?B?bThzbjluYWVaQzVkcjBtcWhNOXNBc1M3eWdOYTdoRk9DVE83QkZoTE1SYWpZ?=
 =?utf-8?B?a0ZOcGZLbmE5TE04aFdjZzE1cGw2cGUzRzlPVU45VDhkSVRTWFd6QkE0WGJz?=
 =?utf-8?B?RnFKQ0FwQys3c084Wi9mQVF6RDVNY2kwZHhQZW5zWlhSaWJkTnBvdWtaKzlz?=
 =?utf-8?B?MmF2L0c3bDNDd1JOd1JCZXVsZmhWeTB0VU94UkNxckJGdUxFMEhRTFNaT0hr?=
 =?utf-8?B?R0RveWlJSDhLaG9kZU9rNUY5bFB3ZnNBTHFzVTdwbElxWkVrS2s5U0dRT3Fm?=
 =?utf-8?B?dEYyMjJDTm9BQUZuYTJkVnp0bDRqQ09KVEtac1dXS3VrQXlZL05NRmluVmNv?=
 =?utf-8?B?U0UraklqUlRwRitnOEw0UURCY0czeVV4Z1hQQ0I3RmJEM2ZpV1VJVDllNCsw?=
 =?utf-8?B?NmJXbVBSZnJRcld1VzQrdGJ4MjlLR2R1aTJMcjIyUVdlOVJ4ZW5RV3Nwb3px?=
 =?utf-8?B?UThyc2d6c2l4bVZXOHBBRWM5OGw5K2hTME5PcnoyWW5tT0hvd0F6UWJZT3dl?=
 =?utf-8?B?bHY2OVBYWEdPMUJXOWlHa1pzUlY4S0VVaXBLa0hpT0FBbWdROVRjcWg5WGVy?=
 =?utf-8?B?N0hMRENGWTBsZnRUbEpOUzhneXd3a0hDZlpXbjdPZmdYNEY1dTdqc1FUbnVP?=
 =?utf-8?B?QWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7552806-f2c8-41b9-c718-08dab6e377bf
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 23:48:51.1578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXscxU8EDiRxoFU09tnz5ackMG5lGC1eJkuWTrkpSs4hgjJezeSbc2BciwtUn2bNe9V386IcAYvbU4bgQSaZbcgcv4O2ffsuuKB9hhVnWiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7201
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 10/17/2022 3:27 PM, Babu Moger wrote:
> The current event configuration can be changed by the user by writing
> to the configuration file /sys/fs/resctrl/info/L3_MON/mbm_total_config.
> The event configuration settings are domain specific and will affect all
> the CPUs in the domain.
> 
> Following are the types of events supported:
> 
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
> For example:
> To change the mbm_total_bytes to count only reads on domain 0, the bits
> 0, 1, 4 and 5 needs to be set, which is 110011b (in hex 0x33). Run the
> command.
> 	$echo  0=0x33 > /sys/fs/resctrl/info/L3_MON/mbm_total_config
> 
> To change the mbm_total_bytes to count all the slow memory reads on
> domain 1, the bits 4 and 5 needs to be set which is 110000b (in hex 0x30).
> Run the command.
> 	$echo  1=0x30 > /sys/fs/resctrl/info/L3_MON/mbm_total_config
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/internal.h |   23 +++++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  146 ++++++++++++++++++++++++++++++++
>  2 files changed, 169 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 326a1b582f38..c42b12934a0e 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -42,6 +42,29 @@
>   */
>  #define MBM_CNTR_WIDTH_OFFSET_MAX (62 - MBM_CNTR_WIDTH_BASE)
>  
> +/* Reads to Local DRAM Memory */
> +#define READS_TO_LOCAL_MEM             BIT(0)
> +
> +/* Reads to Remote DRAM Memory */
> +#define READS_TO_REMOTE_MEM            BIT(1)
> +
> +/* Non-Temporal Writes to Local Memory */
> +#define NON_TEMP_WRITE_TO_LOCAL_MEM    BIT(2)
> +
> +/* Non-Temporal Writes to Remote Memory */
> +#define NON_TEMP_WRITE_TO_REMOTE_MEM   BIT(3)
> +
> +/* Reads to Local Memory the system identifies as "Slow Memory" */
> +#define READS_TO_LOCAL_S_MEM           BIT(4)
> +
> +/* Reads to Remote Memory the system identifies as "Slow Memory" */
> +#define READS_TO_REMOTE_S_MEM          BIT(5)
> +
> +/* Dirty Victims to All Types of Memory */
> +#define  DIRTY_VICTIMS_TO_ALL_MEM      BIT(6)
> +
> +/* Max event bits supported */
> +#define MAX_EVT_CONFIG_BITS            GENMASK(6, 0)
>  
>  struct rdt_fs_context {
>  	struct kernfs_fs_context	kfc;
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 305fb0475970..25ff56ecb817 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1494,6 +1494,151 @@ static int mbm_local_config_show(struct kernfs_open_file *of,
>  	return 0;
>  }
>  
> +static void mon_event_config_write(void *info)
> +{
> +	struct mon_config_info *mon_info = info;
> +	u32 msr_index;
> +
> +	switch (mon_info->evtid) {
> +	case QOS_L3_MBM_TOTAL_EVENT_ID:
> +		msr_index = 0;
> +		break;
> +	case QOS_L3_MBM_LOCAL_EVENT_ID:
> +		msr_index = 1;
> +		break;
> +	default:
> +		/* Not expected to come here */
> +		return;
> +	}
> +
> +	wrmsr(MSR_IA32_EVT_CFG_BASE + msr_index, mon_info->mon_config, 0);
> +}

This duplicates most of mon_event_config_read() from earlier patch. Would a
utility like "mon_event_config_index_get()" help here?

> +
> +static int mbm_config_write(struct rdt_resource *r, struct rdt_domain *d,
> +			    u32 evtid, u32 val)
> +{
> +	struct mon_config_info mon_info = {0};
> +	cpumask_var_t cpu_mask;
> +	int ret = 0, cpu;
> +
> +	rdt_last_cmd_clear();
> +
> +	/* mon_config cannot be more than the supported set of events */
> +	if (val > MAX_EVT_CONFIG_BITS) {
> +		rdt_last_cmd_puts("Invalid event configuration\n");
> +		return -EINVAL;
> +	}
> +
> +	cpus_read_lock();
> +
> +	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL)) {
> +		rdt_last_cmd_puts("cpu_mask allocation failed\n");
> +		ret = -ENOMEM;
> +		goto e_unlock;
> +	}
> +
> +	/*
> +	 * Read the current config value first. If both are same then
> +	 * we dont need to write it again.

"we dont need" -> "we don't need"

> +	 */
> +	mon_info.evtid = evtid;
> +	mondata_config_read(d, &mon_info);
> +	if (mon_info.mon_config == val)
> +		goto e_cpumask;
> +
> +	mon_info.mon_config = val;
> +
> +	/* Pick all the CPUs in the domain instance */
> +	for_each_cpu(cpu, &d->cpu_mask)
> +		cpumask_set_cpu(cpu, cpu_mask);
> +

Why is it necessary to create a new CPU mask just to populate it
with all CPUs in another CPU mask? Why not just use the original CPU mask?

> +	/*
> +	 * Update MSR_IA32_EVT_CFG_BASE MSRs on all the CPUs in
> +	 * cpu_mask. The MSRs offset from MSR MSR_IA32_EVT_CFG_BASE
> +	 * are scoped at the domain level. Writing any of these MSRs
> +	 * on one CPU is supposed to be observed by all CPUs in the
> +	 * domain. However, the hardware team recommends to update
> +	 * these MSRs on all the CPUs in the domain.
> +	 */
> +	on_each_cpu_mask(cpu_mask, mon_event_config_write, &mon_info, 1);
> +
> +	/*
> +	 * When an Event Configuration is changed, the bandwidth counters
> +	 * for all RMIDs and Events will be cleared by the hardware. The
> +	 * hardware also sets MSR_IA32_QM_CTR.Unavailable (bit 62) for
> +	 * every RMID on the next read to any event for every RMID.
> +	 * Subsequent reads will have MSR_IA32_QM_CTR.Unavailable (bit 62)
> +	 * cleared while it is tracked by the hardware. Clear the
> +	 * mbm_local and mbm_total counts for all the RMIDs.
> +	 */
> +	memset(d->mbm_local, 0, sizeof(struct mbm_state) * r->num_rmid);
> +	memset(d->mbm_total, 0, sizeof(struct mbm_state) * r->num_rmid);
> +
> +e_cpumask:
> +	free_cpumask_var(cpu_mask);
> +
> +e_unlock:
> +	cpus_read_unlock();
> +
> +	return ret;
> +}
> +
> +static int mon_config_parse(struct rdt_resource *r, char *tok, u32 evtid)
> +{
> +	char *dom_str = NULL, *id_str;
> +	struct rdt_domain *d;
> +	unsigned long dom_id, val;

Please use reverse fir tree order.

> +	int ret = 0;
> +
> +next:
> +	if (!tok || tok[0] == '\0')
> +		return 0;
> +
> +	/* Start processing the strings for each domain */
> +	dom_str = strim(strsep(&tok, ";"));
> +	id_str = strsep(&dom_str, "=");
> +
> +	if (!dom_str || kstrtoul(id_str, 10, &dom_id)) {
> +		rdt_last_cmd_puts("Missing '=' or non-numeric domain id\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!dom_str || kstrtoul(dom_str, 16, &val)) {
> +		rdt_last_cmd_puts("Missing '=' or non-numeric event configuration value\n");
> +		return -EINVAL;
> +	}
> +
> +	list_for_each_entry(d, &r->domains, list) {
> +		if (d->id == dom_id) {
> +			ret = mbm_config_write(r, d, evtid, val);
> +			if (ret)
> +				return -EINVAL;
> +			goto next;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static ssize_t mbm_total_config_write(struct kernfs_open_file *of,
> +				      char *buf, size_t nbytes, loff_t off)
> +{
> +	struct rdt_resource *r = of->kn->parent->priv;
> +	int ret;
> +
> +	/* Valid input requires a trailing newline */
> +	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> +		return -EINVAL;
> +
> +	rdt_last_cmd_clear();
> +

How is this code protected from interference by other actions? Needs rdtgroup_mutex?

> +	buf[nbytes - 1] = '\0';
> +
> +	ret = mon_config_parse(r, buf, QOS_L3_MBM_TOTAL_EVENT_ID);
> +
> +	return ret ?: nbytes;
> +}
> +
>  /* rdtgroup information files for one cache resource. */
>  static struct rftype res_common_files[] = {
>  	{
> @@ -1597,6 +1742,7 @@ static struct rftype res_common_files[] = {
>  		.mode		= 0644,
>  		.kf_ops		= &rdtgroup_kf_single_ops,
>  		.seq_show	= mbm_total_config_show,
> +		.write		= mbm_total_config_write,
>  	},
>  	{
>  		.name		= "mbm_local_config",
> 
> 

Reinette
