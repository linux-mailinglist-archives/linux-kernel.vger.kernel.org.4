Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE4A652599
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 18:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiLTRci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 12:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbiLTRcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 12:32:24 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7D61F1;
        Tue, 20 Dec 2022 09:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671557542; x=1703093542;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xXWxcec7sHDQtpvvdk2dZpXRRgFa6DZBECrkORXJCY0=;
  b=gtqkayzPXUOXvh2oc8WSTg+g1QmEYXEkuD1wyF2o22VZt44ytdiGjkwW
   rocLqBILQe82AkRpU2M2bFBDp79QWKyYg//JyNNRPh65mYnevYdXzifv5
   mQWfQ1VuRnYKDGGNoyCQMSEPoFvH9Ia8AkrxxuHLPDm/32tueA+36cFgp
   EkS1UEDClO4pi42xsDJw8lpwqt+mUnQ5rJKpiO1zyfiAUvG2lUstLetOj
   QP/r8EY9Jdx0u2/X5zX0RKyUmju1Y64qjQrP1+nwzE0KyyVz8ZkA1RDGV
   cA1/tc6pqQa3gfDrshsIm+18Gx8BfYOwNcOwZAkvJM+kMMuNerRArooiZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="384017465"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="384017465"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 09:32:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="979885871"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="979885871"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 20 Dec 2022 09:32:16 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 20 Dec 2022 09:32:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 20 Dec 2022 09:32:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 20 Dec 2022 09:32:16 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 20 Dec 2022 09:32:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWbx/r87sDfg4np6SE1NzPEAqwbYWegsWupdzk+7oiQjSHW/mjhR/b6ZY9P6mz4D6A4Xhr/ieNpsGzlM+RoZRuaGmnlfmm4fJwCJOVoN9d+FYhWOJc5Enlc7rPlOVC300YygCSWvm14Fnf51qthnh54w7jcKPuITUx/Osf3+LplN1RIhWiEQDtAK5x3UgTxjogo/Y6LTUwSi5bR69HMBhdJeHCqz4bwgUr1L3pnM9GoIKbHHqrAezHMhlbN5gIlGfFxWqc1iKrteSrD65szQDsWJMcHOldv5iAGTzHoBkkjJaqvHK/jfLh8+/H1+faj5aZpZzQWma6fMvIgKTE8zwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=favITndmn0qy02KBQ9ej4GO1KLbE2aEI9AzBAvtkitY=;
 b=gwqoyuRSNTQuite4FnET+sFaR7XmFfH2IurDYUQUn+1duwxCH2RO2bakD4D9huIHgjNq0CKKEwcGXIbFQJuhXvaPkT5seny2o4Al75vvmFDewH6sc6QPBg7BeegQn+L//7EytZLQCx8RycsuWyAb5FCMLOHk2kPFwYEOVJWRStHsLcfJhyTNl75GbMPuv9gECp3lISpu1VM7NQ4mB2UAHug6BTZk7O1UgAufBCdZ1NYtlGWdAkxyutFKs1ZQfo35BzyvF4MizBnVqT25F4D0J+nDIMMZEEqdsSVakw2qSK85KmujECqsN7l6hMCEFUaO8Vt4lH/lS6/gmXwv5/KzhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM4PR11MB6288.namprd11.prod.outlook.com (2603:10b6:8:a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 17:32:06 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 17:32:06 +0000
Message-ID: <02d9ecbd-9b08-9777-f93d-0811edc79b6d@intel.com>
Date:   Tue, 20 Dec 2022 09:32:01 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v9 10/13] x86/resctrl: Add sysfs interface to write
 mbm_total_bytes_config
To:     "Moger, Babu" <Babu.Moger@amd.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "eranian@google.com" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
References: <166990882621.17806.16780480657453071426.stgit@bmoger-ubuntu>
 <166990903030.17806.5106229901730558377.stgit@bmoger-ubuntu>
 <084224cb-271f-a1c8-6665-1953b2574495@intel.com>
 <MW3PR12MB4553A194B951DAFBA116894995E59@MW3PR12MB4553.namprd12.prod.outlook.com>
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <MW3PR12MB4553A194B951DAFBA116894995E59@MW3PR12MB4553.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0152.namprd05.prod.outlook.com
 (2603:10b6:a03:339::7) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DM4PR11MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: de44cb85-b9ee-41b7-06e1-08dae2b01d50
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Nc/gwzKEzSCmVa6saKBC7ZQ2s8k2qBtfFQi4AI/eWZAUTP5o/1AYfADx8mHTZZbFpcpsuUmeTGeeurCq1IFFijD3FZt28o/dIMufaS0amzOmakeICefysOAIEqhvBpMc0b33Ek8kiFGIH/uE2GOPmR6HbYWBEurbeqAK4JWvpSH6PAXuBYd2JDUhzZf2zVt5lzmO7oawVtEthUnsHm01lYaoIryZB/hKFvNfFgKKL0gQGNVLMKiCHIcLjCFGRwth4SotXZYg8eHLlDjCs7MbIQWBIEBh5mWGVr4Vatsy/ZasfDtwFU42hvoKbEn9PcAUvkwWyWFvNpmmDYGmWQVgf77lkb3Va4mjSqoReVkWZ3s0MReZrLYPTK/bTwyZPMVoiFXzKAfNpxk8U6HZmC2cbhBFBqT9vmGEeYocIVuJcV9MiIUO6DzLOUejls/a8A9MKnt+jqdRSVFOvZJq57wqf8JUbyz8l0tXEm+UglC0uyXP8BIvz1oLeVty0EP8zB6cMoWSEvJwwm+8s+L+9/7bk3vovkvDJABrlGDwMkX2Aa43/yDc+TsdaXOeBBWkyMio0StsP3jI29hI1XC+W4aDocH+prF9v4+CFB320rZqx/56g5nTtPbro9+6o/oKpw3/URqY7X2vw5kqMVIbwbJ+M8FiGuEsk9LljTH73K2vxQAttSf2fopJ82BhGfvOSj+2hDSDK4MluQY6CU+g8mBk9tCCvgT5Qdeu/GIWDIqkHk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199015)(36756003)(44832011)(110136005)(2906002)(86362001)(54906003)(316002)(2616005)(83380400001)(6512007)(26005)(6486002)(31696002)(82960400001)(478600001)(186003)(6666004)(38100700002)(8676002)(53546011)(5660300002)(66476007)(41300700001)(66556008)(31686004)(4326008)(8936002)(6506007)(7406005)(7416002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGlyMUM4NHAyZE9MRnFmcklCVmZMclRvMGlielVVNkJ0YUMrd21FdW50V09w?=
 =?utf-8?B?TERYMzBKbGJtMlBJM2ZPM3BGYmlzMXE2L0tpSmhpQkVXV3FPUVlqODFsQm5I?=
 =?utf-8?B?SS9XZzF3MXVnemRMNGlLUTk4bjRuTVE5MGRZS0dGVVhkcmhpY0kwTXBFRWxs?=
 =?utf-8?B?bjN0b25GWDl3Z01oSlg5R0doWXJ2Q3NEd1hPOGhueE92SGtCb0RXOUZCOFIv?=
 =?utf-8?B?a3BaMGVwVkFKU1RRRzdkYy9xYVo5aGNFT2JsczNHU0dWN0ZxZG5Fak5WLzRa?=
 =?utf-8?B?bDlBTWJiWjlzdCt2SkdiYkNPbGRjcy9aUG9MSTN4UWRlSUZYM3pWTUM3cDYw?=
 =?utf-8?B?K0RmNEc0a0NHb29tcU5OVjJBa05sUFBLTzB1M0ViazJiMkcxS0o5c0dxaUxQ?=
 =?utf-8?B?VCtpNE9KeUtyK0xCTVpPUlI0T3lKTVl6UVBwaE9yK0g2bzNpSmRYTDVtdXlK?=
 =?utf-8?B?MGozRDhMK3NuSTBLczFlOXY3T3NBYWdSZTFUTUV2MWlmeWVzU0dabnRvV1U3?=
 =?utf-8?B?Vjd2cXQzM1NsVVVDWDgvTitKdlBIM2daUHhVWkszbEIxVFJXRDBPTUVZcmkz?=
 =?utf-8?B?YWRLYVAwUG11eTlhcWRKSkY0a0FoNnoweGFPN3RnVnhBN3AvVXlGVTVSSHFL?=
 =?utf-8?B?S1RwUVFINHg5MU1LQ0xqa0VaWThXNTlJNklFMzhnKzFLMG1zVTRVTHRWZ293?=
 =?utf-8?B?TDRUeVhGQURCTGp4MksvZGlWTkl4RklKaUFVdndpN1E0OHE3N3cxOUNaUUMz?=
 =?utf-8?B?NGhscUlMVHVwUjVHVzZ1b3FnUVBBb1RPSDB3ek9TSUNQcVVGQ1gvaWx0Nm11?=
 =?utf-8?B?M1gyME5URzN1ZHBpY1ZMeVlHdDFBdFk5dGN2RWpFSlpaMVd5Wi8zb1FQUW1q?=
 =?utf-8?B?U3M5WEJsWjBRbzF3OFhyVWplUWJHazBNY3RVRkRna0pFWVcwSUFudHVqSW9w?=
 =?utf-8?B?L2FHaWJqQ1kxTUk4NEgvKzZEUW9McVF0c1E2Y0xwQkRlRzFNQ0JqNmRLRHlX?=
 =?utf-8?B?TzdmRzg0SEtnbktPWE1qWG12UDllTHI3UDI0bE1mbDN1b25XbkEwdDltVzVn?=
 =?utf-8?B?UEVrN0ZmZGVMcFAybHdKeEtWM1ZoeThVWDhMWHN1cEFxeGllRzFmQ0FsVlMw?=
 =?utf-8?B?UnBJQlBEdzlLRVI1STBxeGRzZjMvcm5ERGNtZVhlbkxsVXlobXN1L1ppVzlY?=
 =?utf-8?B?MkdvZC9WdTNGMlJweDgydjQ0QUcwM094TmZoajdqMERhNVloWGppMm4xN0xp?=
 =?utf-8?B?TzV3YUkzNXNxYk1wYXhMYURnbFNKcHg0RkZmQ2wzeEprR3pid0pVQkc0d1JR?=
 =?utf-8?B?U2dacDY4SGtOb3IrRWFDci80RjlKUnJjblo1RTd4Y3JlUGhjS2JxWUxxbzV0?=
 =?utf-8?B?ankySDFSWmFRb0tiZXZ0Uk5CeEgwQTh3VE1YZlpQTm5YQmpiUmpTeUN1dmlT?=
 =?utf-8?B?UHFyRjZKbUQrZE1EVmo5NGthRlNabDFDNS9pR21xd1JiVXh3a3lRQThYanhJ?=
 =?utf-8?B?ZG1nd3JuOXp0YTUxT0xDRGx0THdlWG96TFRsNUVscHRVU21vSDIxaHZzUkZ2?=
 =?utf-8?B?WGR3a0JCdlNRNnpvbDZJU04yWDFlZGprMmoyKzBxeEN2T1ZiRC9FMjh3Q2dT?=
 =?utf-8?B?bGZxQmVrVnBMbDFjRFNzUzZqZTQvWlRxbnFTbnh0eDlDL2c3V09CZzNjU3pK?=
 =?utf-8?B?enpPQUlRbURUckZNN0RyU21IYkpQaCt1YzUycU9lRm4rQUJtbW84VEJHZVNk?=
 =?utf-8?B?cjB6UExzVVUwZFdNV3VlbURCRUw2cnZNT3NQMHMrQk56MW9ScXYxVmxidHZF?=
 =?utf-8?B?RWJJbGdXcjdBaDBlNmhTODJxYjhJK0lUNnMrblkxZUZScXZyc1Ixc0tkWm1W?=
 =?utf-8?B?Q1lEVDcvNENOdHdHSExwREhIVnJZeUVHYVdRKyt4UEM5YzI4bkttS0NBVmpL?=
 =?utf-8?B?SjFUTXZDdzc2WnNxWUFBNXJEOHN4UGhlQm9vOCtEUk1hUWJDTFlwZzFvVmFF?=
 =?utf-8?B?dmNSOTRMdy9SMXhnamN3MzVJdUMrZVJmL1dwWTVDUkJROHRQMS9Wa3BHTXZs?=
 =?utf-8?B?NEJ2OFRoemZnOWVaYnhKYTZVWTZNb0hqK0tUTmZDNmY3cWE5R1NwZlZ2UGNx?=
 =?utf-8?B?WktRWldLU2VJcTdYaUkveGg1Nk5CVi9obTBKWXdtSXRWUnJ4eE5HOVc2NDd0?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de44cb85-b9ee-41b7-06e1-08dae2b01d50
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 17:32:06.2595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kaTTycL07SUXou8YIO75oq+oLSrsGoB63mrd6urL1mYsgAmh6+9XBpa590gtdZ4WkBRUlDfZr3z2BhNicHcDSd/wttkrLHFvEbwVAc39jl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6288
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

Hi Babu,

On 12/19/2022 11:28 AM, Moger, Babu wrote:
> [AMD Official Use Only - General]
> 
> Hi Reinette,
> 
>> -----Original Message-----
>> From: Reinette Chatre <reinette.chatre@intel.com>
>> Sent: Thursday, December 15, 2022 12:25 PM
>> To: Moger, Babu <Babu.Moger@amd.com>; corbet@lwn.net;
>> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de
>> Cc: fenghua.yu@intel.com; dave.hansen@linux.intel.com; x86@kernel.org;
>> hpa@zytor.com; paulmck@kernel.org; akpm@linux-foundation.org;
>> quic_neeraju@quicinc.com; rdunlap@infradead.org;
>> damien.lemoal@opensource.wdc.com; songmuchun@bytedance.com;
>> peterz@infradead.org; jpoimboe@kernel.org; pbonzini@redhat.com;
>> chang.seok.bae@intel.com; pawan.kumar.gupta@linux.intel.com;
>> jmattson@google.com; daniel.sneddon@linux.intel.com; Das1, Sandipan
>> <Sandipan.Das@amd.com>; tony.luck@intel.com; james.morse@arm.com;
>> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
>> bagasdotme@gmail.com; eranian@google.com; christophe.leroy@csgroup.eu;
>> jarkko@kernel.org; adrian.hunter@intel.com; quic_jiles@quicinc.com;
>> peternewman@google.com
>> Subject: Re: [PATCH v9 10/13] x86/resctrl: Add sysfs interface to write
>> mbm_total_bytes_config
>>
>> Hi Babu,
>>
>> On 12/1/2022 7:37 AM, Babu Moger wrote:

...

>>> +	/*
>>> +	 * When an Event Configuration is changed, the bandwidth counters
>>> +	 * for all RMIDs and Events will be cleared by the hardware. The
>>> +	 * hardware also sets MSR_IA32_QM_CTR.Unavailable (bit 62) for
>>> +	 * every RMID on the next read to any event for every RMID.
>>> +	 * Subsequent reads will have MSR_IA32_QM_CTR.Unavailable (bit 62)
>>> +	 * cleared while it is tracked by the hardware. Clear the
>>> +	 * mbm_local and mbm_total counts for all the RMIDs.
>>> +	 */
>>> +	resctrl_arch_reset_rmid_all(r, d);
>>
>> If I understand correctly the expectation is that when user space read counters
>> (via mon_data files) right after the configuration was changed then this read
>> will return "Unavailable" and then the next read will return data.
>>
>> If this is the case then I think a snippet about this user experience would be
>> helpful to add to the documentation.
> 
> Ok.  How about this in the documentation?
> 
> "When an event configuration is changed, the bandwidth counters for all the RMIDs and the events will be cleared for that domain.
> The next read for every RMID will report "Unavailable" and subsequent reads will report the valid value."
> 
> 

Thinking about this more ... why are the counters for all eventids cleared
when only one eventid's configuration is changed?

Reinette


