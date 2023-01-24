Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A3F67A06F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbjAXRsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234495AbjAXRsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:48:16 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB79E4B774;
        Tue, 24 Jan 2023 09:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674582490; x=1706118490;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HjP6qq+MwPN7Vj9DLTy/HPaFDs/psaaVxq75r03y44w=;
  b=B4qMIpir7KEllEEnOVM5jAWcjOI/CdcIZljy/R4zasahpYFrP1U9o4Eg
   pSA9omnadMGuvpkhavzICFkZUKgp460kUdd4k7Uop8SFNOhFDiD21pHMQ
   HfUuULiVfKtrGnQWLrM3CouxYciKZEojp2XhI2bACmWBrNneTtUTgWAUt
   aJdD72Utz/UrlOPn0zZIMKkWB8lUVszd2lstqiCLVZ4fSp1icHUfqPoFT
   i8zDy6CIJ1Xr5skaccU4Mp9CZWBG0AcJ6r6We4iMgaf6SUq6SGotis8j7
   uvd0d8B8oYuYSZcoMWAjHZTOcygdwdCi+pHecfMh0i3VIm235WW3BIHaK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="309931107"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="309931107"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 09:48:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="770400034"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="770400034"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jan 2023 09:48:09 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 24 Jan 2023 09:48:09 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 24 Jan 2023 09:48:09 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 24 Jan 2023 09:48:09 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 24 Jan 2023 09:48:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2XnRXR82hCx025V2qg9/RqlYat0vGL5tRThhHOYglDFBy74YTGAXpXYWekbsvd7NYhWLKASdDWbt++T91Z2FtwnJiI8d70YiJSGeikVlZtlkW2dnvUxN4KaCYBvTu7v0VXJZ0+NL7YFD3p/48qEpwWzMAIZslmbSjHKAgMAjM6pcvNUW4ue4pmQkDMw7NuATbPIrQrsvjDh50J2qeWIPJNIKI3AeyvxtarAf062n1rCNnDnNvX5VMrxG+cwrZvsOiGrmniA88Poks/JVMleOyRPIMIFVP6qmz+8IPcAhnbD2f1iSiWdLNzY4CXoNrKQ0uwKG2Qd8PoMk0DvX36bpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPUg6B2oxoFHzlNqkqwOoyVyp+/JFQP88698i/X908E=;
 b=S0nFxW3o+7+q8utqK/CEwibNpZEhheSj1iY8gvRmTEK1MIHEw9JPKYZH6Ex9be2p9ufko13HYvEcsRoTvzTHy7s0n8JSX596Ow+6AtNY1OjC5cvBtCKX5c3enGSN7u+BCwg1BlUEIU7PzikrozeHjdpRpWBhcZEWNniBSDFaSikyCXYnmpy66Wq9Y+OjqDO9QzW4at2chbTkD4H0+b3505Kr1VBnmhWxRmXPAvG+0yjNE6OZPM72/HVEQn2FSiw+7SFQlL58xeeJJB0iiuRuOBGPLgtzS+xLeZK5oox9HdIg+ODrGDbUTYjugM7XGBXXA7TOmrCZ/9w888vWOne4uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DS0PR11MB6325.namprd11.prod.outlook.com (2603:10b6:8:cf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 17:48:02 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 17:48:02 +0000
Message-ID: <f6e24e38-31d4-e2f4-4dc1-13208a427a77@intel.com>
Date:   Tue, 24 Jan 2023 09:47:57 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v11 04/13] x86/cpufeatures: Add Bandwidth Monitoring Event
 Configuration feature flag
Content-Language: en-US
To:     <babu.moger@amd.com>, Borislav Petkov <bp@alien8.de>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
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
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
        "Das1, Sandipan" <Sandipan.Das@amd.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "quic_jiles@quicinc.com" <quic_jiles@quicinc.com>,
        "peternewman@google.com" <peternewman@google.com>
References: <20230109164405.569714-5-babu.moger@amd.com>
 <Y7xjxUj+KnOEJssZ@zn.tnic> <5afd0a7c-3fbe-dfea-f1b4-2fc35fbb4f13@amd.com>
 <Y7yCCNANVBnOOmxM@zn.tnic>
 <SJ1PR11MB608321F26D729A082BFC6FAEFCFE9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ecf0abf0-59fe-3898-762c-d9d883925550@amd.com> <Y7yMbQ8hI9MGl1w3@zn.tnic>
 <MW3PR12MB455384130AF0BDE3AF88BCF095FE9@MW3PR12MB4553.namprd12.prod.outlook.com>
 <Y8/CSrU8Bo298VzO@zn.tnic> <72cdefc5-1601-5c43-9ea4-4b637f5fafa5@amd.com>
 <Y8/07cV+t0PrqWX9@zn.tnic> <4ac38b77-77aa-f2c0-36e4-5e482013091d@amd.com>
 <1e662209-93d7-2247-4212-8c78748c69bd@intel.com>
 <12f98b80-38ce-5912-fa10-33d6b8a2fa81@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <12f98b80-38ce-5912-fa10-33d6b8a2fa81@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0203.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::28) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DS0PR11MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f486f9a-30e9-464b-b954-08dafe3323a5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CwiDa1nl/WV6WvULMGev1nd9a+dTqmaDFOH8z/ZDxiQ2DpYd7oLOrdaabrQS09kYvTVp5NyZ6vJ9w8rUvCZDRQgSC+q0Ul5cTOjfw9l0/P2ihoDGluQ3XdLc9OkVMSBGXsb9AeccgQkTWY1G+Ga3a7ECOak7c4fc6FBEoYYEqOeejzJWpX96HePs6Cii1D3Lop71UGle6zAzy6t3Um+Fkty2JZb/sx1A3hwea2dvSMPcr6e0d8bGUWr9YZplnd9px9+8l44LTDHZ+c8UBx9AIad6cYnigVK1mDjaUJH/7ABe9kqf6XYIt7adB7LVxqD1SV4JJPm0C+9B9OVAEC8jgyEDHv9PtYOhKIK9l6oqRU76p6XtBwjOk2yHed1NxPJVRojDQNVXgyv2jrQI3a0UzwmfZ3B37oxeVxQ/3FefoWQaMgB8RvWt3hz5IDuOKkADRXrcUlA8nsSqP6yalNZtq7I94ElUkNFO/hIuHU+gbfPoRL9prctqcLAdtcGIx4T6cZgsTP7rjegcXXWV4IUp0k1gdgD5QAC7soGpFvbxUqjjQ1ZQRRT0L6jVyQRMld+ybhDnkCKuf4fOvleHWzDtKJRAL3S73RPBhhEhHT4mWxs2Y4yckNlS377IvN05gRQw/Z0//6PMXbiCrtySWA0n4okl7Qv+mHFVplD7vojUHHInnxLOOgyYXR7Ja09mRsmN8gxCRdA4hm38FHKt6UVecbqk+SPLih9ld+6suoSKCJA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199015)(83380400001)(38100700002)(82960400001)(7416002)(41300700001)(86362001)(5660300002)(44832011)(2906002)(7406005)(8936002)(4326008)(316002)(6666004)(6512007)(6506007)(26005)(6916009)(53546011)(8676002)(186003)(66476007)(66556008)(54906003)(2616005)(478600001)(6486002)(66946007)(31686004)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yy96RmJzNjNaSmNoV0JBV1ZDcnZnR2doNUNQQlMvUFFPSFN6NFExcDBvVFhw?=
 =?utf-8?B?UVRMUjdvSlRPTVNNUVlxMDJjR3FZazNFOUJJNU9IZWtndjBiN1YvNC8wL3Fu?=
 =?utf-8?B?RWtCeW1laldlRXFaSC9qRzFBMXMybkVYRHBkWXJoZUJzTGhZSHVBSFM2WDhY?=
 =?utf-8?B?TjJvWmhMUEdrRDZ6Nk5iMFhyNDFjY29yalpoT2cxT0JiWnFBdXBoY1VIUEk4?=
 =?utf-8?B?ZGorVDlFNDFlRHNIaXZpMnJrdUkzVk9WYmI4c3o3RkVGakNodGtGZzNxeGVa?=
 =?utf-8?B?QVdtQ3p0R0NZWUQ5eDFGemRKSjJtTkkwOEJqcWluQjBFN1kyZVE0bjdBaExN?=
 =?utf-8?B?Y1UxME9aT3lDTTA5dHJzTFE5KzR3ak95VmY3YWJVT0tiOWF6T3pES2s5dmg3?=
 =?utf-8?B?NjZFZC9BRWl2N1ZoS1hvbitINWV5UHgxMGpITDNWZEtCQ0NKNDF6eEdyeStL?=
 =?utf-8?B?SG9adGFPcGJ5bWR0VjJ3OXFJQ2FvOTBKOXBWblhlOS9mWXpMWjZOM0ZqcThG?=
 =?utf-8?B?eWlSU3NUQm45eWpSUXl1eGZnMGUwZXhGbWtNVWNqYy84QzlVRWhFWXR1UWdv?=
 =?utf-8?B?bG9QeWpOeDU0MHNrM2xxUHAyN1lheXBWUVZiMFVkamsyMUZ3U3FCL05USURz?=
 =?utf-8?B?N0VydXBiMVlGcGxIRHVoK09hWHVhVEtpTWlvMkZXQjQ3QzdveXN2Y3k4MDNM?=
 =?utf-8?B?Slk5eU1EOVFDWkdBWlVCN29UV1ppVmRQSTBWMEFaREVUNnpCWGFKa0NqeXhp?=
 =?utf-8?B?TWFKNXdKNEV4UHhVS2RDd1JVbXdVNEI1Zk1pVFphVVM3cHRnMEh1aEZPaUpw?=
 =?utf-8?B?VzBsM0l2N2NoRDBseHV6bzBoWlcvcVJDV0VLTUoyYlhTSml0MWdDTDNuQURh?=
 =?utf-8?B?ZTR5RXpjTENGemI3Y3oxUWdZTnllWVh4d2tOT0xENTZYS0NXZ0VYYmV1dWZU?=
 =?utf-8?B?emJSditQRExLMTBRZmtLNkg3VVllNDM1MDlFMkNxMGZ6Zy9CeTgvZEhJYmNR?=
 =?utf-8?B?NjA0K2xaWFRGWXdDLzhCaHVZanRLT01acmdVQ3h2b3JoMEdqZ2RnNExyczBs?=
 =?utf-8?B?eWFTZktqeVkyTi8xZ09mRURWcm44MHByT2swcXkzKzNydExMT0I2dVlFditS?=
 =?utf-8?B?dDJKMG5MNzlyckFPWFZiNUprblNkemVySDFEbG15YXdoSFVyUWpKZWtyRFVY?=
 =?utf-8?B?c0hTNGl4NDNqeFZDT010NEJMSlRzL0ZYZDBsNU1lQmViSi9oeGRzL3gyTm9a?=
 =?utf-8?B?RE9WSWVXVldKUnIxUGlibnZETWw0MjJoUzl6ckExbnVpSmZ1ZnJITEpHZDFt?=
 =?utf-8?B?b1BzT0oxMjdaeFYyVGdaZmkxQ3RiYk9lRWhLYnNjaDdjYi9RL1REdTJqZzlB?=
 =?utf-8?B?TDN0RWhGZzFNQjU4SXVIWG9CRDJzSy9HYWkyNmZnMGRwUXNpZ3hiRWx3L210?=
 =?utf-8?B?c1dpc25JTHdXeDQvWmdCUDlnMzRSNGtBajZrZ044RFBObUlQNjNCNW13UTVu?=
 =?utf-8?B?Mnp2SW9HZlVpaWFtbGc4VHZrVDRlTzZkNjJMNVBUM205WmI2MUJYZDEwbkVu?=
 =?utf-8?B?bVY5NlJTY1hFR3NncXg4KyszaGFrUHY5amN4TlFDRnVOUTBLVHRzd3FGNEZn?=
 =?utf-8?B?NHF5OXhvb3RhVExnbnNvMnlNYlNkR203UUhpT0RCN1J4TnFQaG92T0lxRUIz?=
 =?utf-8?B?TVpIVE9ySlo5NU5OUmlFRkhQVlBSeXhORmxFdjdudHc2Z2hPY0E3UnNDUHhS?=
 =?utf-8?B?UGZ3Wis4LzJ3bmpVbWh1Q0xXcThaZ3RwZUthSnRzVnhaSWk4V1JtTVEzOXBR?=
 =?utf-8?B?RWRJUHVteFVLbEh4OWhsbzlXTi95NFlnbzRFMno2YzhLNVhtR3R0TWRtWE9W?=
 =?utf-8?B?UDBPbEdUV2lqYlUrOG1DTU1FcEk0YUJRUDBRWTl1Q3JIMTdQVjEzMjJKSDlC?=
 =?utf-8?B?RjVIbk9vVWRPMktFNGFMa2Z5WXNtdDJCWWVBTUhOdFFEU2dkRlFUUE45a0N0?=
 =?utf-8?B?cGgxWEZwb1A3L1Jrekp2U0s0ZTJSdkx0OHJ0cW8wdWV6ZHdPYTEvOHpGcjdG?=
 =?utf-8?B?cXhXTnArWnJ4RGlmcEw2cStORVphVlZXWHJqazlJOTBZTDZwZC8zVi9lbnN6?=
 =?utf-8?B?YjRZQjVJN2xvUVJma2wrZlJ4ZlI2N0FtTlYzQjdKK0RNVitYU0lreE4xcnBC?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f486f9a-30e9-464b-b954-08dafe3323a5
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 17:48:02.3697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETgZxFY5VIFmZBW00Oiaeh5muwxs/EL4xhdkBdloKe8Pd6L+ZKnZ6IAwhYLqQD4Ywopp33BhnnabzHxQyUw0MQg1FX1bceWO5soXjrBQ6/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6325
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 1/24/2023 9:30 AM, Moger, Babu wrote:
> 
> On 1/24/23 10:59, Reinette Chatre wrote:
>> On 1/24/2023 8:06 AM, Moger, Babu wrote:
>>> On 1/24/23 09:10, Borislav Petkov wrote:
>>>> On Tue, Jan 24, 2023 at 08:11:21AM -0600, Moger, Babu wrote:
>>>>> Understood. I am planning to add resctrl feature list inside
>>>>> /sys/fs/resctrl/info/ in my next series.
>>>> Maybe I wasn't as clear as I hoped for:
>>>>
>>>> so you have a couple of flags in /proc/cpuinfo which are actively being used by
>>>> tools.
>>> Those flags will be there. Not planning to remove them.
>>>> Why would you want to move the flags somewhere else and do the extra work for no
>>>> apparent reason?
>>> With this series(v12) we have added two new cpuid features(SMBA and BMEC).
>>>
>>> But these features are not visible in /proc/cpuinfo. Planning to add them
>>> in /sys/fs/resctrl/info.
>>>
>>> So, users can see them here. 
>> Could you please elaborate what you are planning to do? 
> 
> Yes. It is sort of available. But, I wanted to add them explicit using the
> already available function rdt_cpu_has().
> 
> Something like.
> 
> #cat /sys/fs/resctrl/info/features
> 
>  cmt, mbmtotal, mbmlocal, l3cat, mba, smba, bmec
> 
> 
> Some of these features can be disabled using boot parameter options. So,
> this will show only the features which enabled. 
> 

From what I understand the only feature that needs additional help is CDP
and it appears in /proc/cpuinfo. For all other features
/sys/fs/resctrl/info already provides information when they are enabled, no?

Reinette

