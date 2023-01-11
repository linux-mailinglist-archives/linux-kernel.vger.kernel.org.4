Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24257666686
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 23:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbjAKW4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 17:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbjAKW4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 17:56:19 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68AF20A;
        Wed, 11 Jan 2023 14:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673477777; x=1705013777;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q9hllmj5+t+p/rkFxKzLgqbYKOvbZDqOt79/mh9tTYY=;
  b=EktOz3e4c7JEup9mqZTKRg+thIN1Qj/ovwYY99w/nIynfA/au2hFgeFo
   Ry/mIWp55+ZG8GMo86WT2EXZ/e9An0CRKl9cnxfwsD79QsFGJW1oPRShF
   lgI2B6MnAj8mWG1/N2gxngJ5Ik7RVK/yigtrVdMBoHxrHGqPboFJEkghz
   E7iCBUMvFWg37klMrLQgW2xqOdne3SmE/NnhvBtyQMqJ1pSjYnf1/yRSi
   vRRk5i/mc2x3DhsKI++MF8jIrQpSPIbrzRsHoKq95eCz2gq2+UQfFEnfA
   XLixPjg2qdZ+PcVvQ409fZVwAxxpOixHsRwMVAmDxpYEQR7asLi7rneqK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="307079588"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="307079588"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 14:56:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="659552403"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="659552403"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 11 Jan 2023 14:56:16 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 14:56:16 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 14:56:15 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 14:56:15 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 14:56:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EI0DL6J5iRz6oe0PCSjir/XF0DKkmBHeATQ7LM6cnekjkjiiXfSrSPrC3PQxpg/emrPBX26laB8r+hF7NoW5VoEsoKIN5rVXaEe6kCLcyLl27RKbNJxncAMSCswzqdGGcK00Lvd3Qwvv9qdFYtEUPpT6ZFL7l2qEvyCy/wECWb/diZ9Z2YYOHGiqyD2Ko/uwqwsK5RoPNp9xuQjG4fQ3JN3hF3P6nHAjd2rrZt167SRz3JETmavVKpmsNzt/2Qn2mrIvQSc6YF/gtuEzMCin1LzL+k58V+3GXNhUnxt9x+PNmWNz3LZQAs7/DxlNQ5bHv/LIrJxNi+b3T8BrBZ4yXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OeeT0X/6DKKe8/K65pVcY08nkvqn/kPGuHY4Pjl+cM=;
 b=nm3KJzV/NUjOpsgtut4fsGZRIyGILhcw1Y/HO1mj/J66KRbGY7G8OMJ2tYeOnZYOeDntAyjPg836Xh7Y5cyK171mpGPvBi8VXElYP+MByuLS9ShFdSRCjHKAvwCNXTPYfgrXgDzJ/Ubs+sNt98VhKb3vaSGetaLvQ4Enqk9VsEfks3y3DGOt2qt0DyLifsE70WJ/LMVz7wrqsS53VN3ebZ0xQZfQ4bjUhvflrjytaAwJBHBJ//ZNu09SUk8GY+fBK/5+OeVXR6hPXudcdL9GSNjgEcrTcnbqQAZjpSc8y9stH8rgLzfU/tiM58+UAnfvM3mSXCI4gpk0Q2bkhVvfkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM4PR11MB6310.namprd11.prod.outlook.com (2603:10b6:8:a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 22:56:07 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 22:56:07 +0000
Message-ID: <812a0d4d-dfb9-d351-9c9d-01d6943cd72b@intel.com>
Date:   Wed, 11 Jan 2023 14:56:02 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v11 13/13] Documentation/x86: Update resctrl.rst for new
 features
Content-Language: en-US
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
References: <20230109164405.569714-1-babu.moger@amd.com>
 <20230109164405.569714-14-babu.moger@amd.com>
 <c7d563ce-13d9-ca6b-a5c9-7e08a3cdc3a9@intel.com>
 <MW3PR12MB45538E045D655C1D6B3BD02C95FC9@MW3PR12MB4553.namprd12.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <MW3PR12MB45538E045D655C1D6B3BD02C95FC9@MW3PR12MB4553.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0130.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::15) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DM4PR11MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c530698-a8a6-4acf-c474-08daf42705f0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6R/LC4/Jnp0LRW0NOa1qEc/vgaD/FCaM0E7Lp0iuVitquRns2br3jhdZyOIMl0yN244WQuMMETse3tS6YBKsZ8LP9hl8liZrrJ1QGu3xyA9P8MMBoq09TROxERE0emNN9UI9hHjhYKaJyXl3HmcBTzkw+ALa7QUfubnE8NPiA/N6cQgemM4RFHY8CPKBClZNalR8DVEyHyvxTfDQyWIHX7G/iOejEgUSt+ucFb9Mclj2OrjnAL4jEOnQxDboa6P/cV85npEG8O5l1q+kR2F//MJL+0NP9xOoZo0sk0Pi708aD3A8SYMGy6NYkXRCBRPhi/gm4V0LHzKgNS2Ed63HsB7DLQdwhJurkhjjV1G5kTCBhpmBPg/eFJKSPgOILIKqXPZ13z86utk7sPxt5suY/REZKp37aLkzNj6l3xEG1eMhnTaVX4e4DceQqlsurHpsqngNDVmRjG/A0ZWrSyXDH4lFvQbIvxq7Fu/M6f7OfllITtWNo1xF/hUAlN2AdIW5UKB7SObDwuWh/Xm1RmY5mpJaQDkeBW8Obwwidh3WtX37qGOmsFF/5ecvOIyBJOQcggeErcdXDF15i2RGWR90V0uEZgC3TKMuCpt9paSFW6bdQ4TDXlR967Nd5XASD2eSZG/pjBjjaS1HwPhEUvxQn+9iu9+te9V/r6jbjLYYunpMMfmbwEP3pUhwAWY/VbCJEG+fM51sx8+l3XXbvVBNsjwzb4Jxzjy8aGRCvbr7verSYHZMNwShuSp0eOew+eU9/ARKmBKvZxtmEcjfkpOuTKwSRx/w+A3T063b0TxH+L4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199015)(7406005)(7416002)(5660300002)(15650500001)(8936002)(44832011)(41300700001)(31686004)(2906002)(66946007)(54906003)(83380400001)(8676002)(36756003)(66476007)(4326008)(66556008)(316002)(45080400002)(110136005)(186003)(6512007)(6506007)(86362001)(6666004)(966005)(6486002)(53546011)(26005)(31696002)(478600001)(2616005)(82960400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWZwQkVVcFo1QnhVaGF2bDBDOG15YkdxeGlrUDVnOHphSG1Wa3h4aDR2dVRV?=
 =?utf-8?B?TUlMLy91emtSZG1lWnNxUmhWM3BZWjNMUzlDTlg5aG84SmV0RGswWGZEWnFX?=
 =?utf-8?B?aUNCdjk4eWQ1aU4vR3BkaDFEekZ1bU9QLy9acG8zck1HNVFUS1ZxNkZoaG1w?=
 =?utf-8?B?Y2tlNWpnZTkyMVpmV1JkYWRVMC9vZmFYbHJ3c0RvSnp2OVg2Ni9xeXNnRnNJ?=
 =?utf-8?B?eE1oR1lIUmRjMC9SbjlpQ0pabC80aFBRL0VTUW9LalZ2RHp1b01NWWxJaTNa?=
 =?utf-8?B?RTNFdmJGNjk3YkI5T3FCYnNPeFFISUVXYVk2NVM4aTIxOWdqOFVSS0hUY2JJ?=
 =?utf-8?B?WHBEUGpNRXlMVm1USlU0Q2RGVmJodndGNC9hZUZwMVlqSjlWTzhtd0JIZDhv?=
 =?utf-8?B?TmpWVmh6M0w4eHp0VGxIbjRuWURuM3FGUFdmNE5ZeWlPekhoRDZEb09jOGp3?=
 =?utf-8?B?aHBuekV4Y3k3U3lyOTRUZVlzZi9GRnphNzJTNThRS0x0TXBDN1VuMFRsNzNj?=
 =?utf-8?B?WDRyaVZyS094RktDWHUrUDRjNVdWTGEvZ1duM1dZV095WXJZME9tcTNwWnNS?=
 =?utf-8?B?SVZqQitZOVlhNStXR2FzZHhQSnpFODJyVU96SExZVzBYVTliS3UwazRxcWRO?=
 =?utf-8?B?aGQrRGRmQlp1VzdPS0dITHFDTVVkMHpwUzd6Ukkzd0NHa1hmdFVIN2NMR0p0?=
 =?utf-8?B?NlRBWjBMVUxIRGdUZUsrNGRBdFRtT21YKzMxWXZ0WWI4dC90Z3Z5ZVY5cVlj?=
 =?utf-8?B?M3kxc1FaZmxPeC9qaEJFTGxVaVpyVy9tb1FMQWZlelBWd1Q0R3pIZjBkRzVN?=
 =?utf-8?B?RG1Bb3dDMGlNR3JLcGV2WkFkczFBd1A3SGI5ejdtLzVlenZYeE1mMyt0WXlN?=
 =?utf-8?B?Ky9Ba2tKbDJnSHF2V1ZkUVdvVnBzcmtVNEtkV0pHc3RTRkhKSmloNlZiNDI4?=
 =?utf-8?B?N0tpRTVpcFVUbFJEeHVrNGhmeFpuaGhnVUxuVVUwa3ZHYzUzRjBaQm0yTmh5?=
 =?utf-8?B?NFVsZGdkVzgwOTcydm1MYVRjRDV3Y2dsaUVBS1ZhbWM0QnM5VVdWZkhyNXRR?=
 =?utf-8?B?YUgwV20ybFFYai9HYTlSY1hMcStGb0xYeUpaOGFuNnlQRTJHU3U1bTdxaG9q?=
 =?utf-8?B?RERXVjlEYUZYSU1rRHRZV1pyekVyOUpxWmh3WkVScWFyWTRPakFKb0NRU1RG?=
 =?utf-8?B?R0NVcWVsOUI5S2ZSWFVGWDFSSWgrZDdyazZoejVNWTVDQm9Pc1FaM1d1Z2kr?=
 =?utf-8?B?WFRoQ3lMdmxBQWZ0SFpFWm5XUDZhaHNwZFB1Z1VVUGNjNmRuL0FEdlUrYTVj?=
 =?utf-8?B?aWZ3Z2ZSUmsyWEIwdGlzdGMyeGlqdjNpT2tMcHhyZXF2OG4yOEdXTGoyMThM?=
 =?utf-8?B?V1B6dnhhUlJ5NTJaQmJ1d1BoeDhjTW1QbjQ3TXdseDNsNjdhZC84Y0RaRitK?=
 =?utf-8?B?aEd3cGQyMnZWa0NRVWF5RmcxOHA3YXdzNFljZGNNaytBQ3BLb1JuOTI4aHZu?=
 =?utf-8?B?T2hlNkYycC9WWHY1bERMbjhvRVZkbXFpUE4yd0VJNFZlZU8vcTJ1Q0hnZGEy?=
 =?utf-8?B?QWQ2a3ZYOExjWlBzbkY1Q29PKytrTVBteW1ZYTRIUlhJcHJtaUh1U2NZaVlY?=
 =?utf-8?B?Uk9QOTMyK0dVQWFxbktsdTA2Mm1RdFdCL3lSU3dESHMyQzhVY0pBUWRCN0pr?=
 =?utf-8?B?a0F6UFU2a2tvVGZTeEExU2p6SVAweWdpaHVSM1pDa2FjZHFvTWNoZEtON0cy?=
 =?utf-8?B?Qlo2Ri92NGVUWDUwRUtVb3JtZktwcXNiZU9zZVpTVm5yWnJXeEpRbGlxYmpv?=
 =?utf-8?B?dGtTcnBuaWwyNC9kMjgvblVJMW1pdmlPVG1VNFp1YzlZQ3VlcVZGZkt5ejVO?=
 =?utf-8?B?a2FMaFY2ajZWbE01anJNQU9CYnNNQ3d0bXZmNy9rdFl4YU5FVkR6b0VXS1Uy?=
 =?utf-8?B?VER0ZFE5RmYzcG5PdmFiVVVnR2M0anVOR0RZVU9XcDhOMHhjSzhwM04zTnJK?=
 =?utf-8?B?a2hsU3NVVGlBdk53OU9BVW9OakVHUjhMcEVMTU5JNDRNVFI2M3R1aEpqaUZD?=
 =?utf-8?B?azZJWGpNTkYwYXRRZTc2ZHFHY2d2dnVKOGVBNEdNYlRtMWwxREQ3YldQZHZB?=
 =?utf-8?B?WkgzL1M2L1FNQUV4UjBrcG8yM0d5MFV3UWUvRmlUaTJkMG9ENk5YMkI3cGxZ?=
 =?utf-8?B?Nmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c530698-a8a6-4acf-c474-08daf42705f0
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 22:56:06.9487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 490lnN/PTRSaHY9f9lfyWcxGk67+W5BWdW5ioK0yQAeTmwaZ+a8PD6rDc/h0Ucdx4CaG0ltsmipSiRbdqTrRx7XuaietQhDOIqgqWl8wImg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6310
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 1/11/2023 2:39 PM, Moger, Babu wrote:
> [AMD Official Use Only - General]
> 
> Hi Reinette,
> 
>> -----Original Message-----
>> From: Reinette Chatre <reinette.chatre@intel.com>
>> Sent: Wednesday, January 11, 2023 4:07 PM
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
>> Subject: Re: [PATCH v11 13/13] Documentation/x86: Update resctrl.rst for new
>> features
>>
>> Hi Babu,
>>
>> On 1/9/2023 8:44 AM, Babu Moger wrote:
>>> Update the documentation for the new features:
>>> 1. Slow Memory Bandwidth allocation (SMBA).
>>>    With this feature, the QOS  enforcement policies can be applied
>>>    to the external slow memory connected to the host. QOS enforcement
>>>    is accomplished by assigning a Class Of Service (COS) to a processor
>>>    and specifying allocations or limits for that COS for each resource
>>>    to be allocated.
>>>
>>> 2. Bandwidth Monitoring Event Configuration (BMEC).
>>>    The bandwidth monitoring events mbm_total_bytes and mbm_local_bytes
>>>    are set to count all the total and local reads/writes respectively.
>>>    With the introduction of slow memory, the two counters are not
>>>    enough to count all the different types of memory events. With the
>>>    feature BMEC, the users have the option to configure mbm_total_bytes
>>>    and mbm_local_bytes to count the specific type of events.
>>>
>>> Also add configuration instructions with examples.
>>>
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> ---
>>>  Documentation/x86/resctrl.rst | 142
>>> +++++++++++++++++++++++++++++++++-
>>>  1 file changed, 140 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/x86/resctrl.rst
>>> b/Documentation/x86/resctrl.rst index 71a531061e4e..2860856f4463
>>> 100644
>>> --- a/Documentation/x86/resctrl.rst
>>> +++ b/Documentation/x86/resctrl.rst
>>> @@ -17,14 +17,16 @@ AMD refers to this feature as AMD Platform Quality
>> of Service(AMD QoS).
>>>  This feature is enabled by the CONFIG_X86_CPU_RESCTRL and the x86
>>> /proc/cpuinfo  flag bits:
>>>
>>> -=============================================
>> 	================================
>>> +===============================================
>> 	================================
>>>  RDT (Resource Director Technology) Allocation	"rdt_a"
>>>  CAT (Cache Allocation Technology)		"cat_l3", "cat_l2"
>>>  CDP (Code and Data Prioritization)		"cdp_l3", "cdp_l2"
>>>  CQM (Cache QoS Monitoring)			"cqm_llc",
>> "cqm_occup_llc"
>>>  MBM (Memory Bandwidth Monitoring)		"cqm_mbm_total",
>> "cqm_mbm_local"
>>>  MBA (Memory Bandwidth Allocation)		"mba"
>>> -=============================================
>> 	================================
>>> +SMBA (Slow Memory Bandwidth Allocation)         "smba"
>>> +BMEC (Bandwidth Monitoring Event Configuration) "bmec"
>>> +===============================================
>> 	================================
>>>
>>
>> I expect that you will follow Boris's guidance here and not make these flags
>> visible in /proc/cpuinfo. That would imply that this addition will have no entries
>> in the second column. Perhaps this could be made easier to parse by using
>> empty quotes ("") in the second column to match syntax used in the existing
>> flags as well as the cpufeatures.h change?
> 
> Hmm.. I thought we dropped that idea for now. Did I miss understand that?

I referred to the guidance in https://lore.kernel.org/lkml/Y7xjxUj+KnOEJssZ@zn.tnic/
Since the SMBA and BMEC features have never appeared in /proc/cpuinfo there cannot
be a user space that expects these flags in /proc/cpuinfo and thus no risk of
breaking user space. User space can get information about SMBA and BMEC
from the info directory. 

Later that thread discussed removal of existing resctrl feature flags from
/proc/cpuinfo - that is what I think we shouldn't do since there are 
user space consumers of those flags. I thus agree that the task described in
https://lore.kernel.org/lkml/MW3PR12MB455384130AF0BDE3AF88BCF095FE9@MW3PR12MB4553.namprd12.prod.outlook.com/
can be dropped.

I do not think this is a big change ... just add the empty quotes to the
two cpufeatures.h patches and a new snippet to the resctrl documentation.

Reinette
