Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A295072F678
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242862AbjFNHgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243417AbjFNHfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:35:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943231FD0;
        Wed, 14 Jun 2023 00:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686728149; x=1718264149;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3mdWZ7l4mU31nVET4ygnxiIXbYqdmHlUx1CSGL8YMbM=;
  b=E3P/8grvQgqMgjlHLIQlDYAayICiidaqheIFIlRITfV1MMwI2Ph0P7ii
   YHD8NTXeay6ufolN2OvYZtNdriKr44WdFRxejIl9/VofEYNGrCMhmOV8U
   6CFpNFXah8LzZ0LLbDBdVPfWqmtsoUtQFzJu8hWLxCyZatBQ0q1XZ0mJD
   M12Q97vSW7RJggbaUcEEj6/b/YAL/23TKBqhlXL2o5GMyC1Utr6r9qovB
   clYq6J5Hfxa0Zy+XRE9QhAlkL0pA0Fm1k6B6cFGGtUs+6SaoOH2jvGdGo
   AUiEG0vvln22xKPtoIHX0bWuofD77kTB+Lqlfmf9pLc1/bPmlPnB76K8Y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="361027195"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="361027195"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 00:35:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="741742478"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="741742478"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 14 Jun 2023 00:35:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 00:35:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 00:35:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 14 Jun 2023 00:35:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 14 Jun 2023 00:35:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzIE4C9jbpMBf8MhipEiVJ08f9RAK6m3MemNE4EoZB2juZcD9FTvwzVpOZ4wW5M0k4rnAwDHTyIaUIocafyt+k8A77ZEW/q4RSm/D+5uWP7nWPjjCN1dOCYxL5H3cvcWzT02r++OgRbloIjKjhBci/laWBetlRX9IJBRLszM1J4Jb33eZMr4M+04oMDuT6B/Wl8Ni4Uc3Aini/3+p71nWN2WqcgJFyjtr/Vt6DWElKGYUoyfihtDL6xJ4d7CbpDH3ITG42wI2+m6IlrePKLDtJihqyl/rzz0+Ck3iPc7uRw++kOLKc+sLRDaySMB8wgFeaa6J5uCt41YIjGKLneCvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=te3Ln0ENEh9pca57GQMlA7+Lfw4k4u9i45KlrWlj4CY=;
 b=fiPOguh2P5mwG31jny//3+5rKH1XjAk+5QlaEGfpdVaVnIK/KRJ36mdsB3x3To5ECjButOiaiZuqLDOKggF3Q6xjBTaR4lH3vVuA6Riw+U4ArqhGWVlbAcoDgnZLyOyAWjg8XkIz1urgVgb7FIgnojqsKwguU6zK+5nONuLm0teVcYnmOZBExdclz/ohElPeIbu6et8YplmQO7SYqh1G9S+c36Vfe7n//oEkbB8sFZFvyjG0YiKwaV/8cRVTqvmEm3rIo0SzOgOZwsGhtHHhgvIecYo4W6BLD3IRur2CC6l8WO5318tCmxkqak/ikYO473Gpt6AGo+3Om844TbzNQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by PH7PR11MB8058.namprd11.prod.outlook.com (2603:10b6:510:24d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Wed, 14 Jun
 2023 07:35:32 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::4287:6d31:8c78:de92%6]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 07:35:32 +0000
Message-ID: <03945e1f-caf6-3e5c-babc-d30e4e02b65e@intel.com>
Date:   Wed, 14 Jun 2023 09:35:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/2] x86/numa: Introduce numa_fill_memblks()
Content-Language: en-US
To:     <alison.schofield@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mike Rapoport <rppt@kernel.org>
CC:     <x86@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Derick Marks <derick.w.marks@intel.com>
References: <cover.1686712819.git.alison.schofield@intel.com>
 <9fcc548a6b4727cb2538e5227d7bad2e94e6adaf.1686712819.git.alison.schofield@intel.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <9fcc548a6b4727cb2538e5227d7bad2e94e6adaf.1686712819.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::20) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|PH7PR11MB8058:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dd86621-d965-4dd4-e71e-08db6ca9eeeb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UP+F09Fe5cbmfDkxD7e+146/qTZ5jdEcYYusOi2nP8xa4wTCs2Ozfr3aJtJvJ6/sRrE8YV929RJzYaxEkhPg01sXwEicdgpMPi9CC1Mu3SNq3gubu7Hb7zIaVS8YCpnExnaqS9B13ZXSDlojn3Sa9jNxDaz/n/aHyTTeJe2XlmtN+RgHTZS42z5rAGeDJI5xK2eqKR8BAPDvYnEfL9nXSpQkBXxV9Ya45yvcA3FyS1YvJenqHdiIamhqx9dEVrD9M6KaVqrBjXdwPlvlE3rE+GRCO37qYwwFbWDdiGw1D37JIRkrrVa2SabO5t9rKJEoBYR8Ml9+Nbyj8806AzFEFygfiVdelEl/g1B2iaGgL8KvYBcLpndnfUllri9zUGOrUWOT2Y0ZlshD+M5bLV9B3nJtyvGhkeQ8x9TvzhtDjna7yZs4714Js+KeI2/V1k750e1UZ3Hmiw7J43zUK4Qhnlx8GcJJqioCt/+WIVrh+R714HDxlIE0IQ1ecP7N4MRt0JbrqyFiRe/EcQCIM9oyMhwmT4a//Fk3wvlLbI0qub4P/FRr6bNJF0S15eof98FC1TiVQMWk92ngREpsTd6+B06mFUnD8IfmQVMyAE4EcLaKvEDuTQeXcLTgC5wkM0P28NrIeRB82yR20ZpU+Y/BIeZHwPodmlXlEILV8/Zafhc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(366004)(396003)(376002)(451199021)(2616005)(5660300002)(6486002)(110136005)(82960400001)(921005)(66556008)(8936002)(41300700001)(8676002)(478600001)(4326008)(38100700002)(66946007)(66476007)(316002)(83380400001)(186003)(6666004)(26005)(6506007)(6512007)(53546011)(86362001)(31696002)(36756003)(7416002)(2906002)(31686004)(66899021)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUxHRy9NOUd0aW9yOXMzUTMrZ0hNMzZJVHdpaFNrcWcrUlROVEUyak4xb0FJ?=
 =?utf-8?B?Mzg4OVdTN1FCWmE5NTlaRnZpbERnUGVPNGdkWHk1U1Q3SUxRZ2pyUFBZT3V6?=
 =?utf-8?B?S2E0U2tCNFRwZnEvRU4wcGl4K2tpM3liWFV3SkNTM0xzUGZ5OGtaa0hSSTJK?=
 =?utf-8?B?SStXQWdYZ3ZES3FaSmVMdFh2QlRBWWFHcmE3YXhFYkMveE0vbkxUczFuS20x?=
 =?utf-8?B?UUowSDF4Y0R2SXhBUzJEYUJHdGM1M01CRnhoanJJWnhJSE1LN05jaW5rT3B1?=
 =?utf-8?B?MWRpM3dPU2xuNko3UmhXZlNsdzl0YnVuRXViRDluTjhtNzk1djFvWWYvNDZD?=
 =?utf-8?B?dVU5eTJONE1aZkRvWWpsQk9mRG9qWkJLNTY1UnYwbS9DbUR4MFdDME1GckxK?=
 =?utf-8?B?UzlBWFhCN3FTRFhGUHdRUEhrWUM4V2REdXl2ZzFjREZWMHlucWhYNFlRRjRJ?=
 =?utf-8?B?YmhpQnR6VmY4ci9YRFhXWHlTNzhkeEhQVWFpSU1HRXcvNGRGdlFIakRzOUh2?=
 =?utf-8?B?NFhWQjd0RzVHZENTOG9XdkNRejB0VlNsR25UcWU3Wlpzb0hoMDdKZldjS2FU?=
 =?utf-8?B?VzVTVll0LzBXV1Y5QW9QbWR1cGgwaDlyZ2d1aU9Kc0hHUGlRTDdHODd2NExZ?=
 =?utf-8?B?TG9JelhPOE9iTS9uOG9jWUk4YjRRVjhyMEZCVzhFMjBlbEF1L0w4dXpDSzRQ?=
 =?utf-8?B?WWxrSUpGMzZzbllPMlpEQkJzN3dyOVpSNEpodkpRNSsvYXovYkgxSDQvK2dk?=
 =?utf-8?B?bVZNRWRPYkFhMUhsK255K1E5Ukw3S01vZ1Y1aURNMjVRdmdHY1NZNDFteWxn?=
 =?utf-8?B?MVRRRU02ZlVPc2o4bXZrTlhZWG8rMTRNM0l6Smd3RXBnSGpGS3VnY3hVeEZh?=
 =?utf-8?B?MXBuRElpUUp3RnJ5UlE1bDhmMzhsMkZiTUVLaUl6RmJGNlFVa25HSy9PL1lM?=
 =?utf-8?B?T3JKYzlXL1MyTC9kRjE5OG45MHY4M2FuVEIyM3lVNEVwT3p6M00wWFlCM0c1?=
 =?utf-8?B?QlR2TVFwdlNHaDhubXdrZmtiQ1pjRTk2WWNEK2U5TjdJUkIwVUc2dDU3YjR5?=
 =?utf-8?B?cDJFcGZHRkc1cHlETHoxSWJEcHVydXUrcE5tNHZHOUtVcWdaVkx5WVNnZTIr?=
 =?utf-8?B?SDkyUm1JNVhuZGpCa1ZNdXViaVg0TndsdzdOZ3hOZkRFVW1lcm0zZjJYcmxs?=
 =?utf-8?B?b1hMbHA2RFBmL2l3TG1qMC9SWUg2RU9YdG82SVR2TnFNcjJoQzNKRWYwaEhH?=
 =?utf-8?B?RGUzZmhibVVIZ3lMWVJ2dHV1MjZucHhJOXVRbW1GQ2JJb0VHV2hmMklBMXBo?=
 =?utf-8?B?YXZock53ZW9GTDliakQ3ZmFCOVJNRCtFaVVpblZUTGdYa0dEblJnNWR2WXdV?=
 =?utf-8?B?YUp6d2loeWlwaFh1eGZ5SkhaVjIvclgwUHNRcTl2aEo1WnRsS3ZPTjlmbFhL?=
 =?utf-8?B?ODU3L1czOUVKSEFrelVxbGp6QmdLcGJsUVpUS1BFU2dtTHZqYUdWSms3NDlv?=
 =?utf-8?B?bHVpdHQxSFJvL1IzbmI5cW9tT2lsZDA1Y09HMjNHNHJNZVJFL1hGdmZTY2k5?=
 =?utf-8?B?UVBVM28ybTJERDcyVUJoY3ZIYkR4aFdUZXh5b2JCclVWUTJ3SHJubmRoY1JC?=
 =?utf-8?B?VUg2bDkvN2h1L3JyRzZiS0UzL1VRb0RwckZ2STVBQlFqbXpTTGVBMnpyREox?=
 =?utf-8?B?MVV4RUdJbmJjMVppdzg0SnVobldYc1ZBTnJrNDZXZ3V6bm91MyswTGNGMmh1?=
 =?utf-8?B?WnhZSDdvUERaNVRaa3orc2dXZkJOVXRLbnlXZmRTQ0hPd0tTanNNSjhHRS9z?=
 =?utf-8?B?bW1KSUxUaU9pTGdLNyswNDM3YnBQQWt4U1F6Q1Q5ZkdNSko2anh6SEloaWJS?=
 =?utf-8?B?dnZWNE1zK0lUZlN2bUdQdDdmMmxaSk42Ri91a2hSM0R5c1JlOVRHQm96SDJG?=
 =?utf-8?B?WmxVcVJZRTh4Y2xwU1o3dm44T2NrVjZhd0ZqVlBvNWVyMlRIV3VnSkZzWjAz?=
 =?utf-8?B?cnpjZFNkM3prMFNsMkg4WmNyOWFsVGMzS3RxeWVreFhaUXdITWxZa2pvbHB1?=
 =?utf-8?B?WGhHL3AzcC85bm11aWRPeUdRS2E0b1BlZlZvSUdFazRQWjBoZDRpa28rK1pk?=
 =?utf-8?B?OC9PbmpFeWRiQkt2ZTNaQjNwdDU0SXFmTnp6WUNCS09pSERybFU3NEVOcEQ4?=
 =?utf-8?B?ZVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd86621-d965-4dd4-e71e-08db6ca9eeeb
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 07:35:31.9471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9y3jl5D5lZKyWN/h1R0MZhnEtfgjrAOEz5axMoUxhA19aXJ+BWurSdcp3Qgu+2ba4TzvAVDWpJs0Y37l2nXXvgRdW+UlxIpbDYP43GqSLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8058
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/2023 6:35 AM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
>
> numa_fill_memblks() fills in the gaps in numa_meminfo memblks
> over an HPA address range.
>
> The ACPI driver will use numa_fill_memblks() to implement a new Linux
> policy that prescribes extending proximity domains in a portion of a
> CFMWS window to the entire window.
>
> Dan Williams offered this explanation of the policy:
> A CFWMS is an ACPI data structure that indicates *potential* locations
> where CXL memory can be placed. It is the playground where the CXL
> driver has free reign to establish regions. That space can be populated
> by BIOS created regions, or driver created regions, after hotplug or
> other reconfiguration.
>
> When BIOS creates a region in a CXL Window it additionally describes
> that subset of the Window range in the other typical ACPI tables SRAT,
> SLIT, and HMAT. The rationale for BIOS not pre-describing the entire
> CXL Window in SRAT, SLIT, and HMAT is that it can not predict the
> future. I.e. there is nothing stopping higher or lower performance
> devices being placed in the same Window. Compare that to ACPI memory
> hotplug that just onlines additional capacity in the proximity domain
> with little freedom for dynamic performance differentiation.
>
> That leaves the OS with a choice, should unpopulated window capacity
> match the proximity domain of an existing region, or should it allocate
> a new one? This patch takes the simple position of minimizing proximity
> domain proliferation by reusing any proximity domain intersection for
> the entire Window. If the Window has no intersections then allocate a
> new proximity domain. Note that SRAT, SLIT and HMAT information can be
> enumerated dynamically in a standard way from device provided data.
> Think of CXL as the end of ACPI needing to describe memory attributes,
> CXL offers a standard discovery model for performance attributes, but
> Linux still needs to interoperate with the old regime.
>
> Reported-by: Derick Marks <derick.w.marks@intel.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Tested-by: Derick Marks <derick.w.marks@intel.com>
> ---
>  arch/x86/include/asm/sparsemem.h |  2 +
>  arch/x86/mm/numa.c               | 87 ++++++++++++++++++++++++++++++++
>  include/linux/numa.h             |  7 +++
>  3 files changed, 96 insertions(+)
>
> diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
> index 64df897c0ee3..1be13b2dfe8b 100644
> --- a/arch/x86/include/asm/sparsemem.h
> +++ b/arch/x86/include/asm/sparsemem.h
> @@ -37,6 +37,8 @@ extern int phys_to_target_node(phys_addr_t start);
>  #define phys_to_target_node phys_to_target_node
>  extern int memory_add_physaddr_to_nid(u64 start);
>  #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
> +extern int numa_fill_memblks(u64 start, u64 end);
> +#define numa_fill_memblks numa_fill_memblks
>  #endif
>  #endif /* __ASSEMBLY__ */
>  
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 2aadb2019b4f..fa82141d1a04 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -11,6 +11,7 @@
>  #include <linux/nodemask.h>
>  #include <linux/sched.h>
>  #include <linux/topology.h>
> +#include <linux/sort.h>
>  
>  #include <asm/e820/api.h>
>  #include <asm/proto.h>
> @@ -961,4 +962,90 @@ int memory_add_physaddr_to_nid(u64 start)
>  	return nid;
>  }
>  EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
> +
> +static int __init cmp_memblk(const void *a, const void *b)
> +{
> +	const struct numa_memblk *ma = *(const struct numa_memblk **)a;
> +	const struct numa_memblk *mb = *(const struct numa_memblk **)b;

Is this casting necessary  ?

> +
> +	if (ma->start != mb->start)
> +		return (ma->start < mb->start) ? -1 : 1;
> +
> +	/* Caller handles duplicate start addresses */
> +	return 0;
> +}
> +
> +static struct numa_memblk *numa_memblk_list[NR_NODE_MEMBLKS] __initdata;
> +
> +/**
> + * numa_fill_memblks - Fill gaps in numa_meminfo memblks
> + * @start: address to begin fill
> + * @end: address to end fill
> + *
> + * Find and extend numa_meminfo memblks to cover the @start-@end
> + * HPA address range, such that the first memblk includes @start,
> + * the last memblk includes @end, and any gaps in between are
> + * filled.
> + *
> + * RETURNS:
> + * 0		  : Success
> + * NUMA_NO_MEMBLK : No memblk exists in @start-@end range
> + */
> +
> +int __init numa_fill_memblks(u64 start, u64 end)
> +{
> +	struct numa_memblk **blk = &numa_memblk_list[0];
> +	struct numa_meminfo *mi = &numa_meminfo;
> +	int count = 0;
> +	u64 prev_end;
> +
> +	/*
> +	 * Create a list of pointers to numa_meminfo memblks that
> +	 * overlap start, end. Exclude (start == bi->end) since
> +	 * end addresses in both a CFMWS range and a memblk range
> +	 * are exclusive.
> +	 *
> +	 * This list of pointers is used to make in-place changes
> +	 * that fill out the numa_meminfo memblks.
> +	 */
> +	for (int i = 0; i < mi->nr_blks; i++) {
> +		struct numa_memblk *bi = &mi->blk[i];
> +
> +		if (start < bi->end && end >= bi->start) {
> +			blk[count] = &mi->blk[i];
> +			count++;
> +		}
> +	}
> +	if (!count)
> +		return NUMA_NO_MEMBLK;
> +
> +	/* Sort the list of pointers in memblk->start order */
> +	sort(&blk[0], count, sizeof(blk[0]), cmp_memblk, NULL);
> +
> +	/* Make sure the first/last memblks include start/end */
> +	blk[0]->start = min(blk[0]->start, start);
> +	blk[count - 1]->end = max(blk[count - 1]->end, end);
> +
> +	/*
> +	 * Fill any gaps by tracking the previous memblks end address,
> +	 * prev_end, and backfilling to it if needed. Avoid filling
> +	 * overlapping memblks by making prev_end monotonically non-
> +	 * decreasing.
> +	 */
> +	prev_end = blk[0]->end;
> +	for (int i = 1; i < count; i++) {
> +		struct numa_memblk *curr = blk[i];
> +
> +		if (prev_end >= curr->start) {
> +			if (prev_end < curr->end)
> +				prev_end = curr->end;
> +		} else {
> +			curr->start = prev_end;
> +			prev_end = curr->end;
> +		}
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(numa_fill_memblks);
> +
>  #endif
> diff --git a/include/linux/numa.h b/include/linux/numa.h
> index 59df211d051f..0f512c0aba54 100644
> --- a/include/linux/numa.h
> +++ b/include/linux/numa.h
> @@ -12,6 +12,7 @@
>  #define MAX_NUMNODES    (1 << NODES_SHIFT)
>  
>  #define	NUMA_NO_NODE	(-1)
> +#define	NUMA_NO_MEMBLK	(-1)

Same error code as NUMA_NO_NODE ?

>  
>  /* optionally keep NUMA memory info available post init */
>  #ifdef CONFIG_NUMA_KEEP_MEMINFO
> @@ -43,6 +44,12 @@ static inline int phys_to_target_node(u64 start)
>  	return 0;
>  }
>  #endif
> +#ifndef numa_fill_memblks

Why not just #ifndef CONFIG_NUMA_KEEP_MEMINFO ?

> +static inline int __init numa_fill_memblks(u64 start, u64 end)
> +{
> +	return NUMA_NO_MEMBLK;
> +}
> +#endif
>  #else /* !CONFIG_NUMA */
>  static inline int numa_map_to_online_node(int node)
>  {

