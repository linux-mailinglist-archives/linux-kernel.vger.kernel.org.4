Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC1874086C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 04:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjF1Cc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 22:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbjF1Ccx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 22:32:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B3911D;
        Tue, 27 Jun 2023 19:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687919572; x=1719455572;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HsTsqz8xKyc17yw2F5EShmUDRS4lEKx3+dH1J4V2Jxo=;
  b=AsFuhxUbenzfiuN0Qq5KfXetgJVwa1efXkZp2W9SQMCuzSteMe1dVUpL
   8DFy6KGNph8sgVc4/N0DcteZ2wyGt/mK9mTje1v1xg77QWC1a1FrTp2HE
   I61V7wIgmqtcobkAfoVQBMDnggnnWJs+4SDLreI49YAJk8F0PKCrv+l8Y
   QoF7aPUfeckS3/qluycRm7g1LmqVJCEbekCP3yLsAd0kwffuHSPi302aS
   uekyHhyJ/E97yTa9xc/PtErhyX1vlddfLXmhMsk3jduUztaMhqZ4H8Ox1
   Kvzo257d8PFuawJ64jEO47DWGcrJgOYNwPaS/WfUq6Di0sn4nQmQofsZI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="364278277"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="364278277"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 19:32:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="890885444"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="890885444"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 27 Jun 2023 19:32:48 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 19:32:48 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 19:32:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 19:32:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 27 Jun 2023 19:32:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbA8fjfrYwrf1OeyQqKJ0BsjWKjBNOvHNoVSs6XokDm8S+Kx9HZ/tSd1rQ9oa8FVd91qcn5ewMuuI/mpvZd0+TaVJr9ob6PKp+qdkg6pFpghvSPbb8Gqr9BzfYQEt7F0goh5Y6m9rXRFGpyYWVThl7LTQ26P5vTHfwvoh6yxgTRHB1/x2TCac+Eo3uA63pdf8X5cGs91BLCnlboku1e+RMA+Kx2wo9HXG6Z+XTYtgPahOW2WFhpG12X7c4sEYftcp+UOnsrMYpn8PIyTYtIYq18xJTh+lFqF7ig6N3bILZdIcNn1pyQmhvbTSCtEDhpOoqorbEH+N3sWqjmBSUxVow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azIWUfj5VlxE8/zGjq9kQPcvcQqJv5cL5Za9f7PiWnA=;
 b=LTtu8kCmJIXLFXFHhEQ87+PvVpoIv8b5WJFk4s9idhkT4jslDf9v8LaOFrExehhPdVi3tdSope+kOADRMPNjUyOWN6O3zWVnKfKCJ4iq6jodDjiJg5wTyG+/QoJ23KZGndZU8e418KMNTh8eNn9ELrYM/op6urqQn1KvXAs3tCoDwKXm+MuSScMOIqU0SFDbPokSHFEpfQlLYTn67tAYxiEkuAOLg03zuDvt2qjrfC4Vm9cU56R5+Dz9GY+J8YWdddua3w22PiE6U64LcWRwV5dgmZGuf9UutEFr13DYXoQYZXM1RTddjVsE6tGhZNH6CIHw9V29NhPCxzobfnv6Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by BN9PR11MB5259.namprd11.prod.outlook.com (2603:10b6:408:134::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 02:32:45 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 02:32:45 +0000
Message-ID: <8ab18141-8091-6691-ddbd-cff834a8d4d0@intel.com>
Date:   Wed, 28 Jun 2023 10:32:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v1 03/10] mm: Introduce try_vma_alloc_movable_folio()
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>, Yu Zhao <yuzhao@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-alpha@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-ia64@vger.kernel.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-s390@vger.kernel.org>
References: <20230626171430.3167004-1-ryan.roberts@arm.com>
 <20230626171430.3167004-4-ryan.roberts@arm.com>
 <CAOUHufZKM+aS_hYQ5nDUHh74UQwWipJ27Na5Sw4n+RDqnwyWHA@mail.gmail.com>
 <CAOUHufZeFTjzO6nSFz7Y=5rBGPzY+_eeN3f8W+g0u6AqosdmuQ@mail.gmail.com>
 <ba282a84-1a0d-4ffd-0b22-ac9510a820ef@arm.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <ba282a84-1a0d-4ffd-0b22-ac9510a820ef@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|BN9PR11MB5259:EE_
X-MS-Office365-Filtering-Correlation-Id: 506c9b40-70db-4e7b-eaeb-08db777ff4cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /QebkPsAWsqzpFT5KH1VBzo0J1pni8qmH73Siirk2qAPWjIGLJ+oEBIx9AiyM2BPXGdXWq4CFuJ+WKJJI1c66EhYKAzPzxyn/4GWu6VwlOgX+AB501YEio/itk59Qs30hun+GI1Sfy79sOmCUYGFuTfz0yq8GdYqle4UTgbJZ69SPqSN/WZyH4xPP3FS6VDVz/BAWL2sbEnuLJyzHgfTNy9r2koDPn1PYwbIGkv0BOxd8Q9ol2MLRKDQgVLjSWrd+IEM8neSitC0TTLBjoA2Ys/s4YC/yNtzgUA6fg/D/aF5T5SLQTunp2otHT55C+pZJGEtOhAvImAqPezb2rx1jwPTkC/76hSLtwgjIWE6F3KkwQ/8za0hvjJ9w4AIO2KdNlEtZ6cGVFvb0oBtKOndw5izhyd5lYO4nZ9fO0gKEhydEpCCVb+KRZcmE+2vuFPU4woHmdP60Xqs8Rr3br8GDmwbZOB92o/HiH6iLmYi6RkWdMZNrSFODA29yBV42IsiA5lPOXqtyEDKtZq0dqilDTIyrvE3WFK8Ndf8/QNb2uOdjDq/70GP6bw4JvUyVPXPDs3Yu0hmfkUJVV2drI8q7OttgcvQ/pJujhNWtFG4ARSErj9zO+Fc5Ezun3eVEKhoY4MG09cE+k1pKlEUJhjf5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199021)(53546011)(6486002)(83380400001)(6666004)(54906003)(110136005)(26005)(2906002)(2616005)(6512007)(186003)(478600001)(6506007)(5660300002)(36756003)(7416002)(38100700002)(316002)(82960400001)(4326008)(66946007)(31696002)(8676002)(66556008)(8936002)(86362001)(41300700001)(66476007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDEzcHhTZTFQeXZQOUFVdXpKcW1seHJnaSs4Wk4rN2xLMXZ0QWpWcm5TdERt?=
 =?utf-8?B?d1gxamxJcyt6REVCT1pzL2lnTElqRWxwV0tGWVN0UHhFcU9zUGVYcCtIUEts?=
 =?utf-8?B?UGdzV3BYdXFvUzFUV3VqVE84Nm9YbnVHdVZETWVaN3ZtMTBYL0VVZHdBOThV?=
 =?utf-8?B?VUNCTE9WcVVJRTJMcEpIdDRpSXBabU9KcVVNemJBeU81Zy9MK0RqNngyejJ0?=
 =?utf-8?B?b1MzQjl3MW1RdXNJc0lyNVZEUjNvQm85TG91QTdUdGR6NmVVNXFxTWxuajVq?=
 =?utf-8?B?R09OSVlwMERZcHdTb2dtNGRmSHh5ckFSMXhlaHI1SjFDVXNpT0YrY2xTK2Nk?=
 =?utf-8?B?b3ZJa05IbGEza1VPM1F2V0FrZ2N3aGNFa0Y4V2E4V3ZJZ2dWamsrcVpRbWtj?=
 =?utf-8?B?Y1FkNjlFY1c1K2FjWkJxMTg2dWRFbnB2SDVrSDBtVjZjQVVPZlBxTXcxaVlt?=
 =?utf-8?B?aUlObWxBL253YzFYTE5mZ283cWpSeTJqSmFqeWxZT1VjSFVaRDZVZTJPSUg2?=
 =?utf-8?B?R2wvZUlnS1JZT3VkN0ZXTlEwdUtsenlWRnUwTE44QU1ya3pCckM1RTBBc3gv?=
 =?utf-8?B?Z3AzSGhRTVlDSlcycWxPdWVkRW44UG11cEdXSVduU1dQOGZwQVIwczFiWTI2?=
 =?utf-8?B?N2VoaGRKWmZGcUVMdllVZkl0dm05SlBGcXg4aytPR2NnM01JNS9yQVVOMnlm?=
 =?utf-8?B?SmxsN3Y2S1dnaHE1UXRlQkxiWDI0MXJDdGtwUDNwNEd5N2U1ZjI1aTdyL0tt?=
 =?utf-8?B?T0c0a2RrMGVONk8yOHRZYzQxc1Z4NWRQU2tXTEdlMkRGS0hzaW9sWC9jZ0R4?=
 =?utf-8?B?c0liL0lMZVF3T1dpeWNxcUQ0SkxJZmxLSUcvUGFYL1ZXZm5aYW1SaWlZRXVw?=
 =?utf-8?B?bDVGdnBYRHc1NHBPQUVPVE40TnZmdFJmZTFqUU1XcEhNVlVUZTBTdVRJbHhK?=
 =?utf-8?B?d0c3M3VCbjBWeW5RSUExSXhyZWs0MXhyZFpQZGYrNXpXRzhVM2w4NUM4enFm?=
 =?utf-8?B?d1RNZ1FOd3dUY3JjbUxscTdwUkkwUVAvVTJMK1V0cFk2UFBhdld1b3JqNlVv?=
 =?utf-8?B?NWc4cUhEbG9KR2pWb1lQZ0k4bkRjZEJQOGVWQVJrYXZqSjA0UStCVk5wRWRs?=
 =?utf-8?B?cVBCczFGSHo4blBwdDFuYXZRY3EwV3BrTUJDcWpneVYzc3lUWTJoZ25zOG1p?=
 =?utf-8?B?UXVFcEJhWVZ6KytNcEVqUWk5R3d5dC9ZVnhZN24zL29JQXRCaHp5TCs0TjFk?=
 =?utf-8?B?R2tlbEdZaDBkRzlNeXFVdHNlSklVOWw2NjgxYnRVakRRQkREbUZUdHpvVEJ5?=
 =?utf-8?B?R09FRll0VmtzOE5Zek1iZy96b0Q2cEtkejN4WUx0TEM3YklkU0MwZTgzVDM4?=
 =?utf-8?B?SFVOVTEweFAwNFM3TVFBTDNSNng0d1BPMWxiMlFmY0tGemdHUTRKK01DL25W?=
 =?utf-8?B?Znc0TlVESXlrZGJ1OUFrQmRyNmc4R3B6Q1JJdkg2Mm9ZMGEzL1ZHMzFqYXRl?=
 =?utf-8?B?R0dTMmVRK3dxT2Z3bjR4Q3YxNThITGFQNFUyMHZOY21CcTBsNEtJZzFvdTBJ?=
 =?utf-8?B?QThHMVN4allJWDlRb2hhd3dUdVlMa0tEM05IQ21Vdzl6amx5Mkl0dkUwemZ3?=
 =?utf-8?B?NVlxYjg2MTQ1ZlZpYTNsUEkrYm9iaFRCTWFkNElrdFZDZkN1NkdQWU5aRnc0?=
 =?utf-8?B?VFBtanBQZ2VuUXJMdS9CS09FVGRlWEFFbk41ejg4d3ZZWHVjYlZ5V3NBTUd5?=
 =?utf-8?B?eTJoYXg4Sm1VRXlaSXpjVTNiYVhZRm5ubEZBS0VXVjNSalpFdU1TWkt2d3JY?=
 =?utf-8?B?cGljc3Nrd0tYWElBcFNuUmZRYTQxb01xVisrQ3F3RkEwYklFMmY1NW4yQ28x?=
 =?utf-8?B?TTluRThybk96Mzd4UlFFVUhBUERYYkRXRnhMUWxKYnl1SWQyTjZLczR4U1kr?=
 =?utf-8?B?ai9UUVBya1FCWk1PMGVYWGtpcWIrdXhFeDl3SC9vOUpCdEQ4cVE1dTg2cHF4?=
 =?utf-8?B?bFoxVEE1WGJqdkcrbTc0VnFFNnd0Q2N5cm5rZkY2ME1tQzVVdFFBZU1tWVhH?=
 =?utf-8?B?VFcwOWMvU1dpai9nbmV1ajNQbmErbUg3Mmp3eVE1RTN2VTU2VWppY0FMVisv?=
 =?utf-8?Q?HaG2RJpqa14oZ3DOVHSrtKzT7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 506c9b40-70db-4e7b-eaeb-08db777ff4cc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 02:32:45.7608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJ+qq9QzW3oXY6VVv6YSDqoiscxDAh3TtRGADrGoMtqRR0tK51HuLOP26M3oCY0glJVkxmgjBlV9sEL5oiSUjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5259
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



On 6/27/23 15:56, Ryan Roberts wrote:
> On 27/06/2023 06:29, Yu Zhao wrote:
>> On Mon, Jun 26, 2023 at 8:34 PM Yu Zhao <yuzhao@google.com> wrote:
>>>
>>> On Mon, Jun 26, 2023 at 11:14 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>
>>>> Opportunistically attempt to allocate high-order folios in highmem,
>>>> optionally zeroed. Retry with lower orders all the way to order-0, until
>>>> success. Although, of note, order-1 allocations are skipped since a
>>>> large folio must be at least order-2 to work with the THP machinery. The
>>>> user must check what they got with folio_order().
>>>>
>>>> This will be used to oportunistically allocate large folios for
>>>> anonymous memory with a sensible fallback under memory pressure.
>>>>
>>>> For attempts to allocate non-0 orders, we set __GFP_NORETRY to prevent
>>>> high latency due to reclaim, instead preferring to just try for a lower
>>>> order. The same approach is used by the readahead code when allocating
>>>> large folios.
>>>>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>  mm/memory.c | 33 +++++++++++++++++++++++++++++++++
>>>>  1 file changed, 33 insertions(+)
>>>>
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index 367bbbb29d91..53896d46e686 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -3001,6 +3001,39 @@ static vm_fault_t fault_dirty_shared_page(struct vm_fault *vmf)
>>>>         return 0;
>>>>  }
>>>>
>>>> +static inline struct folio *vma_alloc_movable_folio(struct vm_area_struct *vma,
>>>> +                               unsigned long vaddr, int order, bool zeroed)
>>>> +{
>>>> +       gfp_t gfp = order > 0 ? __GFP_NORETRY | __GFP_NOWARN : 0;
>>>> +
>>>> +       if (zeroed)
>>>> +               return vma_alloc_zeroed_movable_folio(vma, vaddr, gfp, order);
>>>> +       else
>>>> +               return vma_alloc_folio(GFP_HIGHUSER_MOVABLE | gfp, order, vma,
>>>> +                                                               vaddr, false);
>>>> +}
>>>> +
>>>> +/*
>>>> + * Opportunistically attempt to allocate high-order folios, retrying with lower
>>>> + * orders all the way to order-0, until success. order-1 allocations are skipped
>>>> + * since a folio must be at least order-2 to work with the THP machinery. The
>>>> + * user must check what they got with folio_order(). vaddr can be any virtual
>>>> + * address that will be mapped by the allocated folio.
>>>> + */
>>>> +static struct folio *try_vma_alloc_movable_folio(struct vm_area_struct *vma,
>>>> +                               unsigned long vaddr, int order, bool zeroed)
>>>> +{
>>>> +       struct folio *folio;
>>>> +
>>>> +       for (; order > 1; order--) {
>>>> +               folio = vma_alloc_movable_folio(vma, vaddr, order, zeroed);
>>>> +               if (folio)
>>>> +                       return folio;
>>>> +       }
>>>> +
>>>> +       return vma_alloc_movable_folio(vma, vaddr, 0, zeroed);
>>>> +}
>>>
>>> I'd drop this patch. Instead, in do_anonymous_page():
>>>
>>>   if (IS_ENABLED(CONFIG_ARCH_WANTS_PTE_ORDER))
>>>     folio = vma_alloc_zeroed_movable_folio(vma, addr,
>>> CONFIG_ARCH_WANTS_PTE_ORDER))
>>>
>>>   if (!folio)
>>>     folio = vma_alloc_zeroed_movable_folio(vma, addr, 0);
>>
>> I meant a runtime function arch_wants_pte_order() (Its default
>> implementation would return 0.)
> 
> There are a bunch of things which you are implying here which I'll try to make
> explicit:
> 
> I think you are implying that we shouldn't retry allocation with intermediate
> orders; but only try the order requested by the arch (arch_wants_pte_order())
> and 0. Correct? For arm64 at least, I would like the VMA's THP hint to be a
> factor in determining the preferred order (see patches 8 and 9). So I would add
> a vma parameter to arch_wants_pte_order() to allow for this.
> 
> For the case where the THP hint is present, then the arch will request 2M (if
> the page size is 16K or 64K). If that fails to allocate, there is still value in
> allocating a 64K folio (which is order 2 in the 16K case). Without the retry
> with intermediate orders logic, we would not get this.
> 
> We can't just blindly allocate a folio of arch_wants_pte_order() size because it
> might overlap with existing populated PTEs, or cross the bounds of the VMA (or a
> number of other things - see calc_anon_folio_order_alloc() in patch 10). Are you
> implying that if there is any kind of issue like this, then we should go
> directly to order 0? I can kind of see the argument from a minimizing
> fragmentation perspective, but for best possible performance I think we are
> better off "packing the bin" with intermediate orders.

One drawback of the retry is that it could introduce large tail latency (by
memory zeroing, memory reclaiming or existing populated PTEs). That may not
be appreciated by some applications. Thanks.


Regards
Yin, Fengwei

> 
> You're also implying that a runtime arch_wants_pte_order() function is better
> than the Kconfig stuff I did in patch 8. On reflection, I agree with you here. I
> think you mentioned that AMD supports coalescing 8 pages on some CPUs - so you
> would probably want runtime logic to determine if you are on an appropriate AMD
> CPU as part of the decision in that function?
> 
> The real reason for the existance of try_vma_alloc_movable_folio() is that I'm
> reusing it on the other fault paths (which are no longer part of this series).
> But I guess that's not a good reason to keep this until we get to those patches.
