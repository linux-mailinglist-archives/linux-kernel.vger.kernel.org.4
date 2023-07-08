Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD54F74BB9F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 05:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjGHDwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 23:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHDwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 23:52:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC2B1FEA
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 20:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688788362; x=1720324362;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=W5H8aT6tQnjILXWRPBLvwcjOcNkKgjsf0jIuD2IZAMI=;
  b=LZjWAEPkj6IBT1VGklclOTk7TXdsyiOWSriitGbOVaLnJ+HAGsxiBbYa
   T/KtNcxSJbrMFKLcNqpTYAvYraA2uGmdYDZTedu5Po0ZyrbQPpAOXM767
   U6SFjbTmDAoWqBX0EEQC+IZpVLEV9bapH4wgF75qZ1JewThP3HLNv1/38
   6hcBHylVNLTz4A26MA3j9EYV5fRuux7jpOSYquNfdIR2UvO069f2/wBJI
   g8agAU4CRqFpIRhAPwAcr3vukuv9EB+TsPwcga/UrD+V4Cgd+rNGw1Lfc
   Z6AtV/auAb+yA2+bZUYpTrQVhcLoz11A/nH8W/5nBub7LGqbEKYRLROcP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="362894425"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="362894425"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 20:52:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="790183626"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="790183626"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 07 Jul 2023 20:52:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 20:52:41 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 20:52:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 20:52:41 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 20:52:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6TBRgIJTogO6WLrBb2R4bhKufBZCJqNQIl/e9HScqBAcVKAL2sP5ZgyZ/NPCL8xKktXR5cN6++WF+e8Zn2rMPUHBAIU7fTfrELS6XUEVIG5WRq2QbXTusbOIbGvr6oXcL35qzrHbXApe9jyEqiUzhvQW7KQGLYPGGKOhdPMfrbrRofrjKnnfk0nYPbfmKyjwyEtgnsphR4rhlsb2rq43LGu40lxd92s5rA3lbNHxdil7Lb2Q8D/5+t6y9EDUMkhNupzkZOj7/1/gKKu4ABbpl/dv8lIJP/TCw73Q0m239kSx+rM/Q9gCIrDORvIY4gy5LMi2l6CawKj6RFw/y5snQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3zEIFqo5u6VQ+lfcMJH/HADUMOYIck6C/8fDvka1vI=;
 b=VBNMp1RLmj15nYzC7HnfpYtP3Q2gzyEX+bmPrzibe7e8cw36Qs9aT77xobhkmCq34aoNAVjgAkQbMTRNjJkBfzMDIVvgxdDRKxcYLWUuDn8klKMph7iJ1bA50qi/iqXizIR7XpPlgl40yDf63LZUaRxmLhQ4N5Qe1SK+hs02krHi4sflFEMHAxYjixjAycHcbDTwMAbAgpOYhUfMATUibXNTo40XW+Ur9DGucARscWFqp4LNjKU3Kyqc4M2VzOGoYr/TynLp21W/h9OiwLBAmTgeIDrvodYt58irXW4FFjqR8r6L5hL+AZDFaGWdXDpmb6VtAdENCYARcaxpAst66g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by BY1PR11MB8077.namprd11.prod.outlook.com (2603:10b6:a03:527::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Sat, 8 Jul
 2023 03:52:34 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6565.026; Sat, 8 Jul 2023
 03:52:34 +0000
Message-ID: <436cd29f-44a6-7636-5015-377051942137@intel.com>
Date:   Sat, 8 Jul 2023 11:52:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 0/3] support large folio for mlock
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <yuzhao@google.com>, <ryan.roberts@arm.com>, <shy828301@gmail.com>,
        <akpm@linux-foundation.org>
References: <20230707165221.4076590-1-fengwei.yin@intel.com>
 <ZKhK1Ic1KCdOLRYm@casper.infradead.org>
 <4bb39d6e-a324-0d85-7d44-8e8a37a1cfec@redhat.com>
 <ZKhiGLpIWi5Z2WnY@casper.infradead.org>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <ZKhiGLpIWi5Z2WnY@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:3:18::21) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|BY1PR11MB8077:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d53984-5254-4622-55d9-08db7f66c327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gWhBJYngO8N2yLACf3vJt5KkI6y8dmLmLJSmWZmeGRKgbmn672QJeWfpNqV9A5ttN4hXySeMeIfD55qbkPTA0liVK/BgL5p4pQea2gXVMXZVyslrDCAW5ZV1nUA65khxwwY5ydYKon6GuHHLgZA7lpYSDLs7GNMYniv+vkIY7lrTVl7p8qCuG8K1TPGG/bQrSEUlAwA23oIGe9cGRQyKPFj1UbZS9/EpfOo6zVLF/z23v0dzCL3CtW6yjdkjLLiGNxT4i4VrNwr2bpgmTqWBDPgtHQelSUh811cCAEz2lA+RUxfv4dq6An0KHL7l4CR6IgyGVrYwqyGTzd54mld9Ycdp+05uNjCc1wkcplS0ig2WiEDGycZcDXk7OQa3PrMQsqk1/H9kEAxhVJJXjRgr8sDHKGeDFYjrAxNj3wMeJTgJLq9WQKUMkpkMZta9PFgDeOODarZzx8s/TeVsuK5JiQWSuJ5hopulx/Cje3rkNjNLscM6+Ko+SF0yycOu6me5i0IUneXN38kRTmAP4rj58DceXtNQlRiPH8NGzqL2mnVng4FjZBlzE6bSYi4Rj0QuKgr+LiFSUaziuLwunYSOEl7wqsuZ2HbiRyWCj6z4mA12DoalUg8vIuzfaGqZDiHypyBd1DL/veP8qxU6e8aGag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199021)(66899021)(478600001)(6666004)(5660300002)(6486002)(316002)(4326008)(66946007)(110136005)(82960400001)(66476007)(66556008)(38100700002)(83380400001)(2616005)(186003)(6512007)(26005)(6506007)(31686004)(53546011)(36756003)(2906002)(31696002)(8936002)(41300700001)(8676002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm5ZbDU2T1Y2ekRkUXlabDFpNkw4djJjVmVzODhma2ovaEFrWDd0Q2xsU3VW?=
 =?utf-8?B?UlZHVjNUOVpsRzdBUldIbS9reWcwSnY1eVQxbStlZERsa1F4VVoxRisxaCsx?=
 =?utf-8?B?eGV4OFlUREZJUE1tN0Myc011K2ZGVFdHQUh0aGtnZ3JseVNZNU80K0x3ajBL?=
 =?utf-8?B?NTJiSUM3WDhxVlMzVWVmNi8wRWRtSXFpU3dZTDkzbEFROEpBc08ybUdCTnNn?=
 =?utf-8?B?cnIzNjkrTWtDL1hrYThOOEVIZ0wvV0hlMmw1VEJYRUdyVm5hTDYvc3puMTBT?=
 =?utf-8?B?TWowRDRnL3BPUkl3UjNYNThsSEdGTkVXVFMxek9FbFpwVzBlSXlhY1UrdW1H?=
 =?utf-8?B?eDEvdnFlOW9ZVnZ4RzFtRlhhcE5LNjV5YkQybWx2TnFaSnVaSjI1VUpXb2Ny?=
 =?utf-8?B?d3NvR0pCb0wzbFBha3RDU2drYVhXTEd3dHRhc3RxeURsSm9OelBNdy9OKzk5?=
 =?utf-8?B?SldhTi9BcFdOQnVxT29sQmsybFQxL2c5ZWtTQzIxK1QyamRjaWdLV0xocTJE?=
 =?utf-8?B?STNGL1h2UGxVTkl3NWhKMXgrYmN6dlNTdEk5eFF2WUhBNy9oc1MwMnB2R0ln?=
 =?utf-8?B?Qi9LUW82MFVZQWRINzM3NGVkbkN1WUJpaXpHWVlvTC9MaDYyQUJwelQ3aWV2?=
 =?utf-8?B?ZlhEeklGYjQ0dHNvbnBOeGYvc1RNZ1d6MEh3ME43RHZ2RVhTc1VKUU5VYktL?=
 =?utf-8?B?cllzbU8yZDI0Z3BJdVlHQTY2dU5tVW9iV09pSk5BbjlmOXF2eXdGSEdlSXV6?=
 =?utf-8?B?SzV3TjNIdllNR3RFNzZWME5TV1piSGt3NmR1UGVZUDQ1MmJwYzMrclp1OEtT?=
 =?utf-8?B?UTA5SW5GcTZrL0hPVkZPTXhiMU05WDZxWTRpVEF5YUpxdXY2Tzd0RW1lU2cv?=
 =?utf-8?B?azROUzhNZ2hJTXRKNDlQVFpkNVRnT2xpa20vQlc2RXlocnhkZjg5L3hmbmxk?=
 =?utf-8?B?VFhXSGVFOFVlbjBQbGZaUkhtYUxUQ29TT2p6TTRWSllVdDFrZDlSMFNwZTAr?=
 =?utf-8?B?UEJSUEgvZVZTa3VZT0p4bFNEUG93YmltYkFjMnozZ2grdFpkclJpNkJoZXNM?=
 =?utf-8?B?TGNsQmlUQmYvSjJxTlJXK2x6R0RxNHJlelVGbWpvbFZEeG52QlZNSUVubmEx?=
 =?utf-8?B?dGJGdklZL2h1d1JvWnowZ0dJVjRXZ1A0eXVnUmEzQXFjbmpEL3RFcHQzVWE0?=
 =?utf-8?B?akkyVnFwSnp2SzZsVnVSTlJ5SWVXMEY2cjZDWkgyKzlIV01OcmE3eGIycDR4?=
 =?utf-8?B?RjQ1TkM0WmttcU5YZzExR25TSWRqQi96ZEVpa0Rtcm8xRDZIRW9MVTd3Y1F2?=
 =?utf-8?B?TU9lQS80RGF2R1I3b1lOMUhnbSttNTc0Mys5V1VmSXZ4OFdvVkNZS2RMbFQ1?=
 =?utf-8?B?azhicEZqN2FVbnBEUW1vdmNpaTVjUWg2REhRQ2dOb3R2cTAwTjFBSEd0NWNR?=
 =?utf-8?B?dmRER0xIaVR2NHJDdWpDY2VMcFdYMnQ5YWp2c3BDWk1iSnpWbGwyMDhnVkxp?=
 =?utf-8?B?ay9BeW85TC8rUDdUN0c5UHg4U1V4VFY2eHlHMWV2dTlGS3hJMm4vbW5UMXgw?=
 =?utf-8?B?V2c5a1lpWXFHbkowbjVXSklKZlRnQ1d6QnNSM3hIUkJ3YXl6dy9tb3hyRWxY?=
 =?utf-8?B?K01aRnQ3SnFObEU3Y0IydHY5RWE1ckk5MnpjeUJFTFhiaHJxajQ0cG0xdUFL?=
 =?utf-8?B?UGEyejFTTU55eVZzZDU1TzFJd2JkOGpWUjNUamZGN1J1WkdhSG4wRHd1SWNK?=
 =?utf-8?B?Qy9xQUhyM216RnFaNy8rZElQUHlGaTArTlhJWGVXYlhuaTh0c3F5TXRPdzUv?=
 =?utf-8?B?UllTdTlqMjVqT1RrS2IzZytTWis3V3hPQXRQSCtnRHJYM0pmT24rQXE3R1RN?=
 =?utf-8?B?Y3hVVlJ6RHJmWk9rckpsMHd5QWdFdFRNVk50Sy9CYW1BRVNkc1RRc0hTODln?=
 =?utf-8?B?Ynl0UUJ3bkZDejF6eDlrcFdaUDBaMDMxdGJ0c0FNWWJEZmhhN2g0Zng4Q1Yy?=
 =?utf-8?B?TDlId3Zob1lGM2MrV3AwUkZsNFdVSDd0dzJOY0QvQVFFbVlnTHYwV29vNGtI?=
 =?utf-8?B?Tmh3cndzY3RMeVhxYzlIZGNDSmwzRk5SMlVOV3g3L2dGcFpMM2hjTzlQWnoz?=
 =?utf-8?Q?ShumRdHWSfwFuENRgAiAGVLAG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d53984-5254-4622-55d9-08db7f66c327
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2023 03:52:34.3087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fuzcUx0b8cAwp9mAPkC8Q5cNeJv8jEMvd0VWPuaKkfZNODyUIgCpnldcrOLs+bdQGivN7ICWYCnr++JhCzZ67g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8077
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/8/2023 3:06 AM, Matthew Wilcox wrote:
> On Fri, Jul 07, 2023 at 08:54:33PM +0200, David Hildenbrand wrote:
>> On 07.07.23 19:26, Matthew Wilcox wrote:
>>> On Sat, Jul 08, 2023 at 12:52:18AM +0800, Yin Fengwei wrote:
>>>> This series identified the large folio for mlock to two types:
>>>>    - The large folio is in VM_LOCKED VMA range
>>>>    - The large folio cross VM_LOCKED VMA boundary
>>>
>>> This is somewhere that I think our fixation on MUST USE PMD ENTRIES
>>> has led us astray.  Today when the arguments to mlock() cross a folio
>>> boundary, we split the PMD entry but leave the folio intact.  That means
>>> that we continue to manage the folio as a single entry on the LRU list.
>>> But userspace may have no idea that we're doing this.  It may have made
>>> several calls to mmap() 256kB at once, they've all been coalesced into
>>> a single VMA and khugepaged has come along behind its back and created
>>> a 2MB THP.  Now userspace calls mlock() and instead of treating that as
>>> a hint that oops, maybe we shouldn't've done that, we do our utmost to
>>> preserve the 2MB folio.
>>>
>>> I think this whole approach needs rethinking.  IMO, anonymous folios
>>> should not cross VMA boundaries.  Tell me why I'm wrong.
>>
>> I think we touched upon that a couple of times already, and the main issue
>> is that while it sounds nice in theory, it's impossible in practice.
>>
>> THP are supposed to be transparent, that is, we should not let arbitrary
>> operations fail.
>>
>> But nothing stops user space from
>>
>> (a) mmap'ing a 2 MiB region
>> (b) GUP-pinning the whole range
>> (c) GUP-pinning the first half
>> (d) unpinning the whole range from (a)
>> (e) munmap'ing the second half
>>
>>
>> And that's just one out of many examples I can think of, not even
>> considering temporary/speculative references that can prevent a split at
>> random points in time -- especially when splitting a VMA.
>>
>> Sure, any time we PTE-map a THP we might just say "let's put that on the
>> deferred split queue" and cross fingers that we can eventually split it
>> later. (I was recently thinking about that in the context of the mapcount
>> ...)
>>
>> It's all a big mess ...
> 
> Oh, I agree, there are always going to be circumstances where we realise
> we've made a bad decision and can't (easily) undo it.  Unless we have a
> per-page pincount, and I Would Rather Not Do That.  But we should _try_
> to do that because it's the right model -- that's what I meant by "Tell
> me why I'm wrong"; what scenarios do we have where a user temporarilly
> mlocks (or mprotects or ...) a range of memory, but wants that memory
> to be aged in the LRU exactly the same way as the adjacent memory that
> wasn't mprotected?
for manpage of mlock():
       mlock(),  mlock2(), and mlockall() lock part or all of the calling process's virtual address space into RAM, preventing that memory
       from being paged to the swap area.

So my understanding is it's OK to let the memory mlocked to be aged with
the adjacent memory which is not mlocked. Just make sure they are not
paged out to swap.


One question for implementation detail:
  If the large folio cross VMA boundary can not be split, how do we
  deal with this case? Retry in syscall till it's split successfully?
  Or return error (and what ERRORS should we choose) to user space?


Regards
Yin, Fengwei

> 
> GUP-pinning is different, and I don't think GUP-pinning should split
> a folio.  That's a temporary use (not FOLL_LONGTERM), eg, we're doing
> tcp zero-copy or it's the source/target of O_DIRECT.  That's not an
> instruction that this memory is different from its neighbours.
> 
> Maybe we end up deciding to split folios on GUP-pin.  That would be
> regrettable.
