Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C226C1D24
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjCTRDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbjCTRDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:03:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68930367DB;
        Mon, 20 Mar 2023 09:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679331424; x=1710867424;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Susmz3e+zk2WT6SIPi5bPGHJVx3n7gxjMWrmcp2b8Rs=;
  b=hvHKy+IgL1w78qAzZOKFuemPd5aNDd0LVl6s5tUcplZb/2yVk0OrVpjT
   plQB42s5X/Fanz5+6j/2CZVDmTjXKOBjCyx48nX8zyklxzXYgXMkiK46j
   7HUkgkFs1ZB5v046b9Qs26BgFDI0FXTEZfQL40ciddeh2Nvga+7mqNFoY
   w9qg/xRY+VUuKPjeJV9lJRAQ2Qsp5emVfJxNHY8GeokKFZFOCjPvsAniE
   XjQ97EPAsPLsNYc+x20K/cGshNz6ksdcOV52TZHZHwBuMFTa40cbnGVSd
   L45Afxm8DiEJkC6I3nD91wLqBCwXthPD5zWvn0IemIf30K6CV5uoYtR+M
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="401290666"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="401290666"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 09:54:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="681161486"
X-IronPort-AV: E=Sophos;i="5.98,276,1673942400"; 
   d="scan'208";a="681161486"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 20 Mar 2023 09:54:17 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 09:53:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 09:53:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 20 Mar 2023 09:53:03 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 20 Mar 2023 09:53:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8S66qo6cyl3lIncPdti0luzQr3LEmHGbMgzYWAfMICyMJPCDTPFO6FQ/cqjf17x+M3gksJ+i/QMsye1zjXYUdU7aXDKMQ1wf57Y3GaYxjFOOcmib3kCFhpnMWt1Z5vA8TxOqkYvgzCfky0T7BZXGTOrAFralwYc9B64OTVGC0pRAKCexa16L1oQhmulp5CV50KUT/+hjcNvRxTq8Hdax8ZWjnZsLbhjLpsUq+EV1yk3nMTDAlp9DKD5GXGBWAxQXg0d7UwkaCazvgym47XoZQ80nf8XaU492V7fEWcXiH/F053pw9h2GysAegmDsEinNsMoQfVVz10KWDXY9Lck5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ns7reXeCXcpxSwUjDLC37qazB0U9eQDS8rlO6xrjxRI=;
 b=DnDgXUEOmn+/vaitux8WRPTsMt6juJfqVwXRumf1FPWjPL960prphsmgaQSw20ZW1xSNbv+5uXYXhcG9YQHVqeRq1x6AK/SqBC0AyHxWseQvsa4sv8d21Ed0Y4kHMfEuAUmsO1/PxY8Gblq/aBEEpnYloTwB+XWI+sOpBsZAeEO0is3Kwb5tT+SRQRHE4zq1yUuYk/g2RLR/gwgyuEwI/MD2mHvRG1AF8AEewJCe0a0QYQQHka9+Ri1BxnvW/9RXcdnCMOzctlKtEYW8hqn39SbPBG1yairRdlrshBKX46SCpH1m242XOGqk3r1A+fwi7Df1cKkEH4CjJltbBdjCZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by SA3PR11MB8022.namprd11.prod.outlook.com (2603:10b6:806:2fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 16:52:56 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.037; Mon, 20 Mar
 2023 16:52:56 +0000
Message-ID: <ec71ca8a-2550-8e01-7830-6e9f62ee4e95@intel.com>
Date:   Mon, 20 Mar 2023 09:52:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/7] x86/resctrl: Add multiple tasks to the resctrl
 group at once
Content-Language: en-US
To:     <babu.moger@amd.com>, "corbet@lwn.net" <corbet@lwn.net>,
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
References: <167778850105.1053859.14596357862185564029.stgit@bmoger-ubuntu>
 <167778866506.1053859.2329229096484796501.stgit@bmoger-ubuntu>
 <9af9eb7a-476c-d4b0-e114-3f5c2b45dd95@intel.com>
 <MW3PR12MB45537DC45130BB5F02F0F3F095BC9@MW3PR12MB4553.namprd12.prod.outlook.com>
 <71b58853-e7c9-b522-3f90-c3d84cba1317@intel.com>
 <39c85927-9c34-0284-86c6-724f417423db@amd.com>
 <7a71ac36-d9dc-c2d8-31fc-127225d21ee4@intel.com>
 <044fd84b-257b-d450-2b4c-f6ca5ef47f7c@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <044fd84b-257b-d450-2b4c-f6ca5ef47f7c@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0099.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::40) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|SA3PR11MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: 14603ab1-d81c-4456-b715-08db29638db2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qYyrwe1fn6/amdKboEvJwYoc6LgfJz2P/Ozu+PcFL2q9qnpUOUXzVI90/yD7lLJf++iSBF1vRqxHGIEz+S2NL9Zt+aeRljyBg+6CKPLG+COBdd+zQ8SdLqwgn3GdhyFCCLDNhAkZJga1is1XBAHfHTaYoQ1j8+hi405nnhszgMO799TwHJRrPIxS/pb2+7m/1j1ihG6LluOuIX8Kcgiiz7hoYokp9HR5sdakalOzhfEBs0SflcEe5HsB1vROoP8uWIZOPjPPckVE7UMEPnblvCb5beMUHM+0fAnJ9JtfKhAuPMbHRZWEPzH3CWhqWQt/ZaqKzbdAJQlJqJ0mDLtjm7XqVfarUDptKWR1NSbPPaDND78Ty0f4Y+hBgAR+zTRPCx68TDcFZxWaFtYVXJuFwxa8GNAnsnyFqu+0an8BXB6E6keINR4iwK4MWpkxGQ6aymSnAwf9wHAouqNgYmAKiSaU6Ns01QBh0nP1pa297Yv8qz6uwN50xG+A/Xu46iM4QEQAlzBoRliZXbbj0T+gs3+Za95IuR453PgabLPJ2t+niGfIDHcO2FL3kmI9z2+8MVD0BJd9KnLIvkH5tuDK6z3iAaRm4sch0/aKyWvwkiSAMkKpNnNRxD9zj3BuoP9AhexHKhtpyv30dNmHdkmuyXcpIyZ/14DIyIfYP0csPNryd3kN/fzkCyU1V3XMgyEsP9K6dLDm3rn2naKM+UY/5ndCwTmJUPbxRiLe+XNt0sw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199018)(83380400001)(6666004)(6506007)(6512007)(26005)(2616005)(478600001)(186003)(66556008)(66476007)(66946007)(316002)(54906003)(4326008)(8676002)(110136005)(31686004)(53546011)(6486002)(66899018)(8936002)(41300700001)(7416002)(7406005)(44832011)(5660300002)(82960400001)(38100700002)(2906002)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajBlcWZHb2pxcmsydXU4bGtXb21ZT05oakdyWUxKVHFJREhUK25xSTRlQTBl?=
 =?utf-8?B?R2dGTDE2cWxOZ0x1Zm9LZVJtellNODUvUjY3WlRxM3lsNHJQODZPeFRPVVJa?=
 =?utf-8?B?anIvTW5CRFl0cDRlS0lVLzJpN0s3bzlYRm9mR1pFeCs3alcxS1cyMmVsSnd0?=
 =?utf-8?B?NVhzYjV2bjd4ZE5FN2ptMEQxVi9FOFI5R0JDaUtFdXlnaHdPekhHWEUrUjFt?=
 =?utf-8?B?RXVVUTJOVktIc1VZN2RlZVZ1YmVtYm5DcUc2cVQzY21nSnhIWG9PN0t5Tyti?=
 =?utf-8?B?d3pSUVFvbmpxK3R5ZWdrK0I4RkVKSWlNcnVLZUJhVVdzS3Vvbzd1a0wxYi9u?=
 =?utf-8?B?K2wwN1dhWFZuaEUxR3l3SFZCL3dNLzVoemdDWFRLWEk4V0hUM2dJeW1WR2U1?=
 =?utf-8?B?b1RCUjdOOExJSzM1UCtLMkt6Yy9yYnZVQ25pNEdYZ1FEN2lBZXJPYjNKdXNK?=
 =?utf-8?B?a0tSYS9EQVBEYkdaNEZFVy81V0x4RkRWMW00dy9WU1pHdDQxd2g0bFp3Z0NN?=
 =?utf-8?B?L1RrblpDRVl1WDNPN1hwRm42U1JSRXFLTmQyeTdrZEF4eGcyQ2lVQ0MvdUMv?=
 =?utf-8?B?Ri80czg2cDRJUWkwRHo3eElrUXJ6akZ6Yml2RmE3dFd3SkcyQiszUGpTMU1U?=
 =?utf-8?B?N0M0OEpXL1pMSzVIUlVVVlY4YTdISmNiczA5ZTU1YklzZTVUSzNkV0dmUW94?=
 =?utf-8?B?NktIT0o4cWJ2cTF5RFlORU83elB3RzFENDhwdHhhVmEwTWptL2hhWUQ5V004?=
 =?utf-8?B?NnBYVXJRWFJ2d3JIVzNlVEZvRVY5ODVMMXZCd3JEUjEzbmtySG1CNUxLSlFw?=
 =?utf-8?B?ZXExcG5vQ1o4WnFjdjFOK0I5aVdxWWU0N1g0Z0dIMHdZSm04SmtnbThRODY2?=
 =?utf-8?B?OWh0YmtaVXFCVXgvY0c3OVdzdU02NmMzMG1leEEwVnZodE95N0NHb2JSQVhR?=
 =?utf-8?B?UUgwR3RZb3hlMmxhWGkwd0NFckhGVlhkaTlOcWVQaHZaK1BtNkNBMS85WFdj?=
 =?utf-8?B?YkFrMktOV0xPTzlRcUcxVW83YWpsK2JmUUZqY0htWmIyaVgxTGVhTG5Od2sw?=
 =?utf-8?B?OWp3OUpJODVLOTg5ZDJFRm8wM0hxV2ZBQkJCKzlKK3BMeVR1cGFaZ0N3Sm05?=
 =?utf-8?B?YmRNUnJQWE1CaDBQcStVUnBPY2Fiall2TWxzWkJBaUV6MFFYVGJCR2pzM0tW?=
 =?utf-8?B?RitsUUwxVTBlYVBYbFZGUnpXMGR5MFU0NCt0blF3NzNZMkpBVzRYaURuSXlq?=
 =?utf-8?B?QUFmdUhYdWhtaW5vekg1TE9VdDhuTThNNjJLV0F2MEo4eWljbytERXNzZWt1?=
 =?utf-8?B?ODJkdlY0Uks1VitnTGZoL2h0aVdYQkVaZGkzNHFsc21TSmZIUTJzT2FxTFB2?=
 =?utf-8?B?UEtRRTFaWnV6MkdFMDA2aXZrcEE3UkI3dUpDMUVzK0g2QW1CaUowN1hLdnQ0?=
 =?utf-8?B?U0JUa29ieWk0a3B3azlsTVg0VkZKaFFKWHFNZGFpMUJka1ExbGZyZ25PVU5T?=
 =?utf-8?B?VnV1YmRoL1hVZWFHV2dtTVV2elgxSldDT0l5YmxUaTV3RFpXNys3WitaTHU5?=
 =?utf-8?B?UHVBNHRnYitzcHpqL0JTZVBma0liU2d6eGtUUzFpeWg5WWhEc3A2NkdpNHcr?=
 =?utf-8?B?WDhkQlp3VldtZFhHNXY2U21oc3FFbXFLU3hnb1Y4aHJLK3F5K0JBdWw5akkx?=
 =?utf-8?B?UXBURXgwQUt2Y1FQbXBJSDRRbE8wSk90TWhYNi9yREk5WDdFZFJoN3N6L1Mr?=
 =?utf-8?B?MzVISkpyU2RZMTJPUHVOajM2eE9waUZxVXZmOGNJNHhXQUhnaFd5UHN1UzVh?=
 =?utf-8?B?dFVKNXRteEVLTmsvWjZFMXU5bTNPS3JlcERQbldWdk82KzJ2ZW00bWVWTU1t?=
 =?utf-8?B?dW5EVGNpZ1B3eGVxdDdnN0JlYmdZZFUraTNkdHJ6dFVoYzBCS3hPcDAxSUdK?=
 =?utf-8?B?THNYZFl2cWZNVGFaZUc5Yy9ZclNDdHFYMW50b21OMXpaYXdVWG81RjEvcENx?=
 =?utf-8?B?YWI5d2R5aXRoM2RpRGFNZCt4UzRuY255U2M3SE5pUldoejZUWitta1NiWHJv?=
 =?utf-8?B?UU5sWUtVcEFmMVNmNHJDL2NYV1V1Y1Jydm84WkN6c2NjVlJGbmRaM0xsRDFt?=
 =?utf-8?B?SHA1UlhkTU1uQmdGRk9rUW82TFVweEs4MEI0TkFLWFcwdVlWVFBaeDcvbHRE?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 14603ab1-d81c-4456-b715-08db29638db2
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 16:52:56.1982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QiahkWrkhgzq9ABYPdlUcCz5QYjqR1auqkBRbm8JYSshLT2g91GG/Trb+w0molEQcieD0rvhp47bEyiaTHnvPLP2zEpr6hCPkOrhbsekoIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8022
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

On 3/20/2023 8:07 AM, Moger, Babu wrote:
> On 3/16/23 15:33, Reinette Chatre wrote:
>> On 3/16/2023 12:51 PM, Moger, Babu wrote:
>>> On 3/16/23 12:12, Reinette Chatre wrote:
>>>> On 3/16/2023 9:27 AM, Moger, Babu wrote:
>>>>>> -----Original Message-----
>>>>>> From: Reinette Chatre <reinette.chatre@intel.com>
>>>>>> Sent: Wednesday, March 15, 2023 1:33 PM
>>>>>> To: Moger, Babu <Babu.Moger@amd.com>; corbet@lwn.net;
>>>>>> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de
>>>>>> Cc: fenghua.yu@intel.com; dave.hansen@linux.intel.com; x86@kernel.org;
>>>>>> hpa@zytor.com; paulmck@kernel.org; akpm@linux-foundation.org;
>>>>>> quic_neeraju@quicinc.com; rdunlap@infradead.org;
>>>>>> damien.lemoal@opensource.wdc.com; songmuchun@bytedance.com;
>>>>>> peterz@infradead.org; jpoimboe@kernel.org; pbonzini@redhat.com;
>>>>>> chang.seok.bae@intel.com; pawan.kumar.gupta@linux.intel.com;
>>>>>> jmattson@google.com; daniel.sneddon@linux.intel.com; Das1, Sandipan
>>>>>> <Sandipan.Das@amd.com>; tony.luck@intel.com; james.morse@arm.com;
>>>>>> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>>>> bagasdotme@gmail.com; eranian@google.com; christophe.leroy@csgroup.eu;
>>>>>> jarkko@kernel.org; adrian.hunter@intel.com; quic_jiles@quicinc.com;
>>>>>> peternewman@google.com
>>>>>> Subject: Re: [PATCH v3 1/7] x86/resctrl: Add multiple tasks to the resctrl group
>>>>>> at once
>>>>>>
>>>>>> Hi Babu,
>>>>>>
>>>>>> On 3/2/2023 12:24 PM, Babu Moger wrote:
>>>>>>> The resctrl task assignment for MONITOR or CONTROL group needs to be
>>>>>>> done one at a time. For example:
>>>>>>>
>>>>>>>   $mount -t resctrl resctrl /sys/fs/resctrl/
>>>>>>>   $mkdir /sys/fs/resctrl/clos1
>>>>>>>   $echo 123 > /sys/fs/resctrl/clos1/tasks
>>>>>>>   $echo 456 > /sys/fs/resctrl/clos1/tasks
>>>>>>>   $echo 789 > /sys/fs/resctrl/clos1/tasks
>>>>>>>
>>>>>>> This is not user-friendly when dealing with hundreds of tasks. Also,
>>>>>>> there is a syscall overhead for each command executed from user space.
>>>>>>
>>>>>> To support this change it may also be helpful to add that moving tasks take the
>>>>>> mutex so attempting to move tasks in parallel will not achieve a significant
>>>>>> performance gain.
>>>>>
>>>>> Agree. It may not be significant performance gain.  Will remove this line. 
>>>>
>>>> It does not sound as though you are actually responding to my comment.
>>>
>>> I am confused. I am already saying there is syscall overhead for each
>>> command if we move the tasks one by one. Now do you want me to add "moving
>>> tasks take the mutex so attempting to move tasks in parallel will not
>>> achieve a significant performance gain".
>>>
>>> It is contradictory, So, I wanted to remove the line about performance.
>>> Did I still miss something?
>>
>> Where is the contradiction?
>>
>> Consider your example:
>>    $echo 123 > /sys/fs/resctrl/clos1/tasks
>>    $echo 456 > /sys/fs/resctrl/clos1/tasks
>>    $echo 789 > /sys/fs/resctrl/clos1/tasks
>>
>> Yes, there is syscall overhead for each of the above lines. My statement was in
>> support of this work by stating that a user aiming to improve performance by
>> attempting the above in parallel would not be able to see achieve significant
>> performance gain since the calls would end up being serialized.
> 
> ok. Sure. Will add the text. I may modify little bit.
>>
>> You are providing two motivations (a) "user-friendly when dealing with
>> hundreds of tasks", and (b) syscall overhead. Have you measured the
>> improvement this solution provides?
> 
> No. I have not measured the performance improvement.

The changelog makes a claim that the current implementation has overhead
that is removed with this change. There is no data to support this claim.

...

>>>>>>> +
>>>>>>> +	buf[nbytes - 1] = '\0';
>>>>>>> +
>>>>>>>  	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>>>>>>>  	if (!rdtgrp) {
>>>>>>>  		rdtgroup_kn_unlock(of->kn);
>>>>>>>  		return -ENOENT;
>>>>>>>  	}
>>>>>>> +
>>>>>>> +next:
>>>>>>> +	if (!buf || buf[0] == '\0')
>>>>>>> +		goto unlock;
>>>>>>> +
>>>>>>> +	pid_str = strim(strsep(&buf, ","));
>>>>>>> +
>>>>>>
>>>>>> Could lib/cmdline.c:get_option() be useful?
>>>>>
>>>>> Yes. We could that also. May not be required for the simple case like this.
>>>>
>>>> Please keep an eye out for how much of it you end up duplicating ....
>>>
>>> Using the get_options will require at least two calls(one to get the
>>> length and then read the integers). Also need to allocate the integers
>>> array dynamically. That is lot code if we are going that route.
>>>
>>
>> I did not ask about get_options(), I asked about get_option().
> 
> If you insist, will use get_option. But we still have to loop thru all the
> string till get_option returns 0. I can try that.


I just asked whether get_option() could be useful. Could you please point out what
I said that made you think that I insist on this change being made? If it matches
your usage, then know it is available, if it does not, then don't use it.

...

>>> I can say "The failure pid will be logged in
>>> /sys/fs/resctrl/info/last_cmd_status file."
>>
>> That will not be accurate. Not all errors include the pid.
> 
> Can you please suggest?

last_cmd_status provides a 512 char buffer to communicate details
to the user. The buffer is cleared before the loop that moves all the
tasks start. If an error is encountered, a detailed message is written
to the buffer. One option may be to append a string to the buffer that
includes the pid? Perhaps something like:
	rdt_last_cmd_printf("Error encountered while moving task %d\n", pid);

Please feel free to improve.

Reinette


