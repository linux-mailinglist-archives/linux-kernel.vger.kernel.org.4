Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8F765E19C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240310AbjAEAdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240569AbjAEAcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:32:24 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CEA574F6;
        Wed,  4 Jan 2023 16:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672878594; x=1704414594;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7bmELqFaId1iiVAqAYSEYFCQ/3vT7xBMKyLNhrzDFOw=;
  b=GlMK7yW3Zo3KwcJB4DxHIwSe5p7vLA5khxl4fO8b7Z/TVz8nGRm9hfBV
   ctbhP2oKUygl1u6izyRCUyKbs1Iiy6TCvLvDyioNLLU4zhV7ObAvmMEJP
   eVWgA4zUcGtw2WhgjMggtEE/b4pdEaFHQdlJlTVfFBy7DvOwt9F3zReFf
   6GM3tHUoWdj1Y/IGt36JoO7p0jc1Cmiq/FUKdjq4eDlHak/qr42S8yx1N
   CWbmHWIRzGN/Hmei2O2QKfTuqdnEuN/+ARDeHA1t2kQAyCHF8CXE+FA2f
   FZx0jTy9fTWXAkXtwYYdaoS1IfthHdGR1lPTnUg/GVHxx3mk/pMg6TBjf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="324081197"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="324081197"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 16:29:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="900750704"
X-IronPort-AV: E=Sophos;i="5.96,301,1665471600"; 
   d="scan'208";a="900750704"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2023 16:29:01 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 16:29:01 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 16:29:00 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 4 Jan 2023 16:29:00 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 4 Jan 2023 16:29:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drvj2g/ZBJgucTz4voN0tOOwdjSEdSxKnTeQ+qymkbiosUugur3CZ6I350tFFVsCDTgG2PrQbO6S6hM5OlyZcLRz4bjqhV5Tdb/ZovS7Xp7OK4q+lOvCKRUii0aZ4rBSDv49WHDI8k7o2AMnAWki0FhQeU5L25mr5HCFAo4A5wtykpju0Y2i+diudmcATNo9sQtmgKhZIu56+uqWgjxbciJWJgAwotlnvzI7G8BeHZ7bQuRNwLE2224lt65ckhPNFnysH7+6v54FsDYWXAcTILe5e0BcTHRKgp2/Y3nQ/TLF6Qz9hYBOYZkHoTgo+RufnyBRKGvYagqn9NJB1/KxaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0WUeuHH2g48NYI66ezkEJfZ6NR3jbX8xHWUNu4f+PG0=;
 b=c1ikaiUxDmQInSLtBgVqjobSHZkY3NWO/h17QD0KGf5B9GfpFFUbhuVovohudJ54mrcrCP//amQ5n9/Y0qF911FsN+TKaUENHK+GhY4/WeD1Fcy6qh56TT6yCaqLcTw8pVm0MKmjm14EePJ7ILxfdNf5H2XxcflL7P19nTyNQt5RFJvF/1L4iihe0XODgLEMyDM1oPRUay1nqhyRo5ac+iim1ZHaJx+ithfEnjTg6hsKDGQ5qVqG7N/64MWMr5nvLNBmuitH0fLPyjeYzu8TW0aAqa4oK+rNqd/JLX8mnCwVFPyHlA18OcmI3BCI1jP4p0o0WzYANsAcgDVSgJSTBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DS0PR11MB7507.namprd11.prod.outlook.com (2603:10b6:8:150::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 00:28:54 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a1f7:e4c4:e60:c5b3%6]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 00:28:54 +0000
Message-ID: <6597dab2-db66-e4c1-e8e2-b18b2a0bc9e3@intel.com>
Date:   Wed, 4 Jan 2023 16:28:50 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v10 07/13] x86/resctrl: Add __init attribute to
 rdt_get_mon_l3_config()
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
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <20221222233127.910538-1-babu.moger@amd.com>
 <20221222233127.910538-8-babu.moger@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20221222233127.910538-8-babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0041.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::18) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|DS0PR11MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 951b1476-83b3-4fb3-fb3f-08daeeb3d339
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cy85xQuPEjLR+3WuibQRKQ67I380Ujyhf5dsCMWaTUph0XsTQ1mO4PXSz1ZPrjluiibjzsRF08InIPme6SsTqURa66C1HoEtUpyOf6b3yo0OdD+0N6GaNn0VKeXxwNwcOQSXhWb5y9lYMm82WJFJvcaFLnD3soVb7zmHOM+RiHaaxKVyre+gmkJSFqHmsCub52SePCewbRwjqLtRU2JkWcgi6HKIiO2UbftSc2pH4+0qjHzl8Gn1JVfneWcRs5Pxm4fV8XOQ8Pu3TS2+lKzharN8R0rdPvFm4FKC4Iit79keSqpPSJzbYHljLxHM7spEylvtywpjnaZLjaCqh/LW62dSVtljX3c8srHho/Z3qlLw7DE4jhlW0IT69NEw4TOwFIl0uzmut9TBBnR5fXi1RxrfVM2jTwdL5pPkHDWUUAUWbXCGrn7alfuS9n/DAQeFTEiIBqeRqKwml9/8Hj+UO+GVgcrly3jeK/Dcp2xHwNRo60kqs3ArfrjH7zWsRevu++eP3aabBtFAMZHsrZOb/NOn13eidhiIDWo+tHJEk49YyXocQKpwTE2IR2TBlHl/Z/AwyAQpiuuBiiGOBt8DylorQYcT6CXH9B/iUGoMQ4Gbox0qLV6dxdNiO/VZeUYv+LBIhteNQ6/AU9euxokAa51Gy24VBVjkdzRyGknh+tQGTQG0/BYYChL0g6uEXPC+EAjTfcjYS3TP3XDfEFXPLz8sQ9V4bIFcl8Ad8rZ4euw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199015)(2616005)(31696002)(86362001)(82960400001)(316002)(4744005)(36756003)(38100700002)(31686004)(2906002)(44832011)(8936002)(4326008)(66946007)(41300700001)(7416002)(7406005)(66476007)(66556008)(8676002)(5660300002)(53546011)(6512007)(186003)(26005)(6666004)(6486002)(478600001)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3hhWElrQWc4Yko4dXh4TzVCYXUzWFAxd002MjU3Q2t2YmhvM0JRSDFVY25W?=
 =?utf-8?B?SzArY0g3M1pFRXFHeUR6eXBjZE9PVXZqeU03dkhJOWN6ZDdodzNPTTd3UTBj?=
 =?utf-8?B?aFFpQ3hQY3VYODJmUlJvNmdRemNnOWlVZFdwUVBXZTg1WVRScTZha0dSOWxX?=
 =?utf-8?B?WkltTE1MTXU1cDZITm45b3lXMXR0V1pXOE90a1doTVFQd2lDTmlNQlpSbklm?=
 =?utf-8?B?SVZwVWh3ZlRKVzFHaGRPMk04Z0M0UnlEWitrWk9EdE5QV2thWEdwVWNldEdI?=
 =?utf-8?B?MzFRUEpleDlNck82RkJUMXlQdjNaKzNiejFsUkZyU3JhL092eDFoY3I0dkhK?=
 =?utf-8?B?Q3l6T202T0RsSTRtVmV5UkdjRVFXOEwvZGR3aU5ZZHJXd2lZTVBzUm9WRkhj?=
 =?utf-8?B?VnRRalNDcHo2ZXVlQTkzSVM2RWZ3ZE5nNmp0ZmNDTzhPOTAwemVBRzR6anpj?=
 =?utf-8?B?eUY0OUZiNlJJbm5IR3dMNUt4SER5Zld4U3ZqL1FLa2VKY3pHd29KM3BaWTZh?=
 =?utf-8?B?Ris1eERhdExtclNtOUZTTVd3Z1IzOFdGaEJLam1UdVh4bzVzNUtwZlRveTdP?=
 =?utf-8?B?YjZQMnBod1g4VU5od2g1SjAzOHpMT1NvSzhLZ21EUW1zZmk1TWIwTUdVZ1RP?=
 =?utf-8?B?clZNbVZ3alJMb1FDOFdENWE4Z3VPdGZIZmRvRWlxNDhMZGM4OWQ1Z0dwQlVW?=
 =?utf-8?B?MVZKOGM2bEI5aHJkVStxY0x4N1ZvTFozMTJkYkhYanBnMzZnbDhUUEtQTFN1?=
 =?utf-8?B?SEhsbkt5Qk9lWmhuOXUwTGFRTUdvWGwyWUlJRWdmMTIwMXVtQzNrZUtpbU4x?=
 =?utf-8?B?bnRpcll3c2ttV3VZMGthZnRzN3BZZnlQTHZhZEthaVIvVEx1djV1b1M3MXZ0?=
 =?utf-8?B?bGRsMFE2YUc3cTdacEhMWHVNMHN2Tld1SjYyME5Rb3M1YjNUYmNWcnJubTRP?=
 =?utf-8?B?eVR4WVVaMkRKbStFWHllRXFZWTV6YXVkRmNyTTZsN3ErcnpkZWVXNEhubHhy?=
 =?utf-8?B?L0wrS1ZCbTlvaENrbXZDT3R4U3lUNHhybWVIRTVsNkt1MjFNZjFaRnk2eEw0?=
 =?utf-8?B?SzVCVVhqOFBTMEtRSTlXTU83ZmdkcXR6R2VTQnp0YVNSRElUcG92Umx3UGlY?=
 =?utf-8?B?TURHM3ZDTGFTMHpqY0p5WS9McllicHFPOGZoN3lzRkJBZm54WmxOQkVyL1VO?=
 =?utf-8?B?akExaEhPbGp3OG9VZk55NlBaV0kxUnYyWFhmSFBHbEpla0dINGNNMlRMaXJj?=
 =?utf-8?B?MlBzMWhHK3Fhc0RQazhDN3FoZ3Z5cEN3a2hjbmRUeGU5N0U5NE1yM0VJanlo?=
 =?utf-8?B?VjREOTRURjZ0SllhcytQdzZTN0dGRko4OGZHTjhvcG84eWJ6eURrUDdPZWpv?=
 =?utf-8?B?RjBOUXZVVGZudDBvYTNmbElGbjRXZkIzWFVsbXdqNVl4by9BdVZtaWYrTkdE?=
 =?utf-8?B?TGVmb2U5a0Fsa1NqRFhkbVBZU04wQXF3VWFSMzJja0tRU3FqL1pieTVMdXB4?=
 =?utf-8?B?elpwblh6em1tclJZZzdkM0ZZMnE2SEFDMnNqUGxtM3hLSzRPUms2QUlWbWRh?=
 =?utf-8?B?S0cwZVlFRzBSUVovS0hxVEoxdHBrb0lFa09ZT01JWW04L0ZtVkVaL09jZEQ5?=
 =?utf-8?B?L1hTWG81clFRZDMzSEV3UmtRMlhSOWlhQlJVYTNNTTQ0UmlJUVFiRGlTaENX?=
 =?utf-8?B?NTREci90TERING96Ty9GVlBiSlJFbnNGVndQcTRWSU1DMFJGTFlWYUxQd0xy?=
 =?utf-8?B?TTNiY29hMUorQXJZS0hPWDVKRTVMRkpwRTFJVmR6SnpZTDEyTDdaMXFac1B6?=
 =?utf-8?B?OEtua2MycDR4eDZVREg0NUo3a2ZlaTdrUlNhMHR2V1pMWUpJRVU0NHVXbHdQ?=
 =?utf-8?B?UzFIQTJkSEQ1blZBSStYZ0RGbGRMMVdNL3M4WTdsSUZuTWFZYVpCcEdGaGRw?=
 =?utf-8?B?cXkxbVpQUzA2MzFBOWIwb0o5dmJnSi9WL3BuRW5NaFBiY0hNcXZUdHVJTW5J?=
 =?utf-8?B?UjkxZk1WLzVQazJHNE96cjMreDRnSzl1UU1aWDFBUWhIUjdGM1NOUlNZalVK?=
 =?utf-8?B?OStzY1dscHV6SVhYTFZZdUYzbXZFM1NYbFdmbUxnMTNUSE1jU1dacnF1SHdW?=
 =?utf-8?B?ejBpbCtMcmw5OWI1V3p2Z3I2RHNtZTNXNmFvN1dwdVpBYVJGVUtxbnF4VG5I?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 951b1476-83b3-4fb3-fb3f-08daeeb3d339
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 00:28:53.8726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQNKJRMpFb9oQoD8+HmjNI1Pa5FCGYplqjXeoBzIYfKgnXLVxCHckdTqKCa0CxyAfLJtiR6mWdvH2yAasEiEPPf2N6hZNa9htEZ90/18PcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7507
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 12/22/2022 3:31 PM, Babu Moger wrote:
> In an upcoming change rdt_get_mon_l3_config() needs to call
> rdt_cpu_has() to query the monitor related features. It cannot be
> called right now because rdt_cpu_has() has the __init attribute but
> rdt_get_mon_l3_config() doesn't.
> 
> Add the __init attribute to rdt_get_mon_l3_config() that is only called
> by get_rdt_mon_resources() that already has the __init attribute. Also
> make rdt_cpu_has() available to by rdt_get_mon_l3_config() via
> the internal header file.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
