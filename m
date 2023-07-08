Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBE674BC6B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 08:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjGHGov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 02:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjGHGot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 02:44:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E631FEC
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 23:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688798688; x=1720334688;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pTzCulQmnszPJB87fXrozAhorl+uNUqSSNJhJEqtOt0=;
  b=inP9wFCvHi45X+Wcc1sYIxFIFh4KzqBxovHUF82idQNOwEzmje1Zs32o
   8D/Jfsy71kegRZZ8+pwmim0FDhBJ3Ejudjnc+9NSDam+oY8yhzGdvWdBv
   wLaEKfYXfhhkkLaFkPoS2ls9kTaOTNGzjkZ3NbJMGArJzOjXIIQjMWtIy
   xfxr8VnGu2Po8IwVFWQtGW4rIKMWBvbcuFl/k+vAlLVlsgnduP/7Y9MQX
   aFmh/34ne8BcmsJKhp2LJ/kr6+diGehUVfGOEBUfsGCL4S/eEJtB3mtAr
   j3Pgk7bEpyalN/mZaMmDeULHWqPDFGyqttb2TWGkQPIXlxRWnnSg6HP28
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="348834171"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="348834171"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 23:44:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="714240311"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="714240311"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 07 Jul 2023 23:44:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 23:44:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 23:44:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 23:44:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 23:44:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hAuZ+GhC4AmqEYKugY6jniKn3ydp3wltBfmN/6Z0DUuWxSC609EVyPqM5eCi/HP16Qtxt5EsOVrQZ2Q02MXk3quVVIGbEgFWLF4vZdMxCg9xd6j1x7SNLVVnTUs6lpccndK+JXEjB06vc+q+p64o54D2tQNVwnAaBXGB4sxwjBzKxSxkJJaynHEadwJmnMgESvR7y2I08MhYIxkdbZmAmgUKJkkNyr2nTNr4XDOm3CCQ+Yeh4F3yXmWstjYtp5goAKpXlSVz2H4naAYVTA/XFFWYfvxZM8Wx24OCN/TvDU9zjaaOjlhlNTrJbPtpiMSnJw/cET+Ug04uVvgASU9kWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xq+AdC/4ZEsdFL4D6QB0Lw3mXCn/2FV3INrYxSUpCAE=;
 b=W3Bp19vgd6G5WX8Y7obl4SDWkT8IIY7floFV7a6JiCBP4z0l+uNgoBsWfKJRjGfOz89XpLxKkJt0vPpvsgSjBB/9AH+yHztK0ZCDmCtsuN8no78KNEwTIddp4Q55N+Wd2WTuzzh2bSH5K6IFpG77TIczi47EUHVj7OSItFrWiSbjNtnEXcUX8LqYt4XrTcLdzFeVDUUbetxEeeAH2H/S9694droUu8uV+7FJh45lb+pS21MTz7zBYcWL+Mk3TRt8EGG7NtLMTI4EeU2cs8XqjNpK94DUH4u/PeDGRM+BNiyz+8MBtnXws+hWPEQaGV/kExI0GiqeQPwy0BdGi8kVMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH7PR11MB7719.namprd11.prod.outlook.com (2603:10b6:510:2b4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Sat, 8 Jul
 2023 06:44:40 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6565.026; Sat, 8 Jul 2023
 06:44:39 +0000
Message-ID: <74ee8221-883b-07e0-9665-81146960b92a@intel.com>
Date:   Sat, 8 Jul 2023 14:44:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 1/3] mm: add function folio_in_range()
To:     Yu Zhao <yuzhao@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <ryan.roberts@arm.com>, <shy828301@gmail.com>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <david@redhat.com>
References: <20230707165221.4076590-1-fengwei.yin@intel.com>
 <20230707165221.4076590-2-fengwei.yin@intel.com>
 <CAOUHufb=f1KUyXFGm7XjXJu8sp+pYrhUreiTe=ypqMnJbgwGKg@mail.gmail.com>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CAOUHufb=f1KUyXFGm7XjXJu8sp+pYrhUreiTe=ypqMnJbgwGKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:4:7c::31) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH7PR11MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d17d4c-d714-48e7-6b42-08db7f7ecd76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ZG71f8ULeRds3M4niUs0OU1ehBXJ5B8kt/DI8VKl/fcFneTVzzETf6gAYQEDMt5DDaVbaCw/ZMNM6Ge27O5L76VMJKSjksg/q/OyMjrEUXGWA1sVEWJDjxvfDhDrW62oFEIteYBgJDq9qIc5RQRotetYA65+8E72Y9zirZXAVE4cGtPqPkpHxWVmN9AAkcBiHPjceeqqUurvX9uG5UYwxujPy3t37B4dFXzP6UrCAHJWR1ImEeCR/2gwLKnWd58zdYcC9DeuGgRJ0nAYTVedHmYgVM8J4yLWfGUiwQlc39L4zPceFe5VUmrdFtLXvhvdFKK3NXekQH1Jle7uQLcukJ6gGdKKTgUG5dJblpf8mZodovCSLBinFp/Va7wB8EjEV7v54ZiHui7SM2Z8zfxTZw5dH/Vla9eoVpS1/PV45CIIoWaF+WOjOnZm5YEEM9dQm1ovfHnyoCgXntBKXjjqYcK7vA6ArXrLIcJKKBPYskBWS4Y1O4ZZezNXO08HH4UO9Q+M5RdaKwJ+Lmb6XVXkZH1bYCQZM0Tvn1F2RIT9BknMaQutyiMmlCM4wga1fdU8YyVnQAT3V+jNB943a8ntPv+ujm6Ip+ynwZOxoRjnnjpPq6sKYE7TYsuniwNhx2LWL3syNDQMQy3Q9Y1YtS7ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199021)(6486002)(6512007)(66946007)(6916009)(66556008)(66476007)(38100700002)(4326008)(186003)(86362001)(31696002)(2616005)(26005)(53546011)(6506007)(83380400001)(82960400001)(478600001)(36756003)(6666004)(41300700001)(31686004)(5660300002)(8936002)(8676002)(2906002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3RpUVdOOHI0WGJmSFlMemYwSWxHMlB5STFqc1hSMW9Makc3SGZENnV2RFJa?=
 =?utf-8?B?bXI2OXpsNHdWQlVHZmFTUnNnbUNOYVNoaEFVSEFicEFNRnRxTVU4cS9sajhZ?=
 =?utf-8?B?MWhhVkJuRG56T0J6Vk1ndVJhdlR0MU1aZTBQcnFYNi91RUE3dlVQZW5yTU1J?=
 =?utf-8?B?aDdOQnp4Z09LLzNTOVAyV1BZZjFpNGN3cHlJVVlmaklheFVGbHR6Q1FhNm5r?=
 =?utf-8?B?eDNZcDZsU0N0SFh5dmtBR2x5THBBS0VOZjA5SHpCbmtUN3lBaUdRMGNHNVNV?=
 =?utf-8?B?a3NiM2t5V1NQZ2tMQjFtdlBqZjV1L3locFk4Nk5DRkJWMVlpeDJuVzlXbHRO?=
 =?utf-8?B?RVJpZGsvZDh1a2E2UE9MY3Q3QXhsNFVyR1l6WlVvcGR3OEp2Z0JudjU4cjV0?=
 =?utf-8?B?T0RQREFsMWNBc1lUSGgrK2FNb3VqTHFCZlNTTGRweTN2S1VoM1FKZlNrYkZp?=
 =?utf-8?B?UENSZkttRk1SUklJZzVwRnBZTjE2R3Z0SlB3MVkvN3I2emd3NHRTd0FvVEk4?=
 =?utf-8?B?R3cvdXpTZ2l1OHVxZjM4TkVsNGVYTTZNZDhMUG9xWWQ1Z05QMlNIVkdmMmor?=
 =?utf-8?B?RVJWYnY4MG9sbkhEbjdOKzNtTVVjSkl1SHVUUTc2N3ZVUXBXTzJDUnpTUHg1?=
 =?utf-8?B?TTRlelhmWHRYV0tqazZnVFFqNGxyeXdPU3lCRmx6TUp3VkJWV1BLbDVERGJE?=
 =?utf-8?B?aFVGcHJ5V1VtU0FlOUlWaDVLWVpSZzRTbjlibW5obXc3OTJNeW16RXlGa0dl?=
 =?utf-8?B?bmN1ai82ejBUQmV3cDZ1RitIWlRFdFdUUXJ4WXl4K0QrSlprektyMmJBS2FB?=
 =?utf-8?B?MVJJaGVNQnI5WW5tSjhtNGN0OTVmZzRGTTdWTWpVQ0RHZEgweWJKYmNBWUk3?=
 =?utf-8?B?YWhOWEpsMEh6MkU5QTJ0c3VXUFBtM255YUNUVDB1L2poNitZUGRrTlFzSjZG?=
 =?utf-8?B?bWZLeXhmWTBIeElPZVhQeGVlQk1RV1UzZ3RHN21yOVV0K2U5WlpaVjFlaTkr?=
 =?utf-8?B?U3FQQW1XMmJFeG00ZXh5allBbTV4MDAza2lQMFVZVlZKWlNTRmE3TFJ5eVhT?=
 =?utf-8?B?SnByUFVWMW5mcUNSdUw4UktBdFdZZFZiSk05R01oT0I1bHQzVjlvRDVDNzll?=
 =?utf-8?B?bDZaQndlcGw2amtTR0F3cHJZOUxEK2tmdzFPZDZlQURGeTUrbWVnck1aejJ0?=
 =?utf-8?B?MDQ0d2R1d05nYnpXZXBXOVZCY3pHNC9tbDlCU2lWSGhKL1lsdG5MUlBjbVJ5?=
 =?utf-8?B?b084UnEweVZuUHNBYzRQT1RYMTBTVHJWb3pidGQrcWo1ZGUyV2VsaXVCOWFJ?=
 =?utf-8?B?aGRkeWMweFNaMkUyZ1Y3TkRCWXY2bWdERUFoRHgrYTFRNWJZVGRIc09LZTF1?=
 =?utf-8?B?SURUTlNrU1ZyT3UxWkI0NTRtTG9vQ1ZybXZJbTQ5R1lsaHdGbUV3NTF4NWtB?=
 =?utf-8?B?N29zK1ZQblRlTElWa3hRTVl6cndwVFNLcjlMV2lZQ3FSa01UU3UreXNTaFlT?=
 =?utf-8?B?Z29PYWRaU1Q5M3RRdmFMUmQxekh4Znd1eHN6TUREMk1oS2xYdi9VRFRabUVC?=
 =?utf-8?B?ZFIrbU80UW1aSnlrcWFjREI1QjhFME9QQmw1RzlGTjdUTmN5UWxkeG8wcHA5?=
 =?utf-8?B?MWZQdUdzTFdDNk1iV2Q0Y0dISjlQa2xQSlp1dHR5K0pra016aTAwUG1oVUpa?=
 =?utf-8?B?dU1LZTFUUFVGcHFSTkRocUVqbksvQWpDVEZ4dE53MFNtSms4TXQ5eUg4cjBE?=
 =?utf-8?B?SWJicFV1ZFdXd1JlZDhLREc3aDlqVFFwcndidTNRUDFsTW1QcVBUcWxGVzlX?=
 =?utf-8?B?Mm1qWi8zelFtTFB6ZFFDYTB5TzlQODZUQ3VzbW90SlFURHhuSmVkMGJvNVlw?=
 =?utf-8?B?bzQrOFd1eS9xdVRnU2tFcE83dGx5UUxNaEN5V25Va1FsOUxGRUhHNzdvcXlw?=
 =?utf-8?B?L1ZocnY1RHNCVi8xelZqZ2NwZ2xOYUZzbU5iRHNvUkFUeXNTT1RPVnVpVitJ?=
 =?utf-8?B?bmR1YzVxNnBKa2NMYmJDWXpCK1poeXVRcURESkl3RjkzNGdrM2dSQ2tNTGhh?=
 =?utf-8?B?QmE5dW9qS2Y0dHQ5aEh6d2ZKdWxvWXIrNkNrNURVMWtPbmd6VG9leEVNcGxK?=
 =?utf-8?B?U2REQzFCMm9TZnpRby9XbXBYSXlzZTNNKzh2alRESmUxVWkwV2VXYyszR1lW?=
 =?utf-8?B?blE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d17d4c-d714-48e7-6b42-08db7f7ecd76
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2023 06:44:39.5324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y8qhvVvyruOO7rQz5q7ko2MCIPBzRXHrKSwN2gyWuvTYg9n1VECWXPtALJX1OKB8oWalQbqdMluzYCg70AvCbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7719
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/8/2023 1:47 PM, Yu Zhao wrote:
> On Fri, Jul 7, 2023 at 10:52 AM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>
>> It will be used to check whether the folio is mapped to specific
>> VMA and whether the mapping address of folio is in the range.
>>
>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>> ---
>>  mm/internal.h | 26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/mm/internal.h b/mm/internal.h
>> index f1276d90484ad..66117523d7d71 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -585,6 +585,32 @@ extern long faultin_vma_page_range(struct vm_area_struct *vma,
>>                                    bool write, int *locked);
>>  extern bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
>>                                unsigned long bytes);
>> +
>> +static inline bool
>> +folio_in_range(struct folio *folio, struct vm_area_struct *vma,
>> +               unsigned long start, unsigned long end)
> 
> Is there a caller that's not "folio_in_range(folio, vma,
> vma->vm_start, vma->vm_end)"?
I believe madvise() will use start/end from user space instead of vma start/end.

> 
> If not, then just "folio_within_vma(folio, vma)" or a wrapper on top
> of  folio_in_range().
Will add folio_within_vma() based on folio_in_range(). Thanks.

Regards
Yin, Fengwei
