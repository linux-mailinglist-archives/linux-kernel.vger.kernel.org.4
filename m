Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39F374BB93
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 05:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjGHDbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 23:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGHDbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 23:31:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436721FEA
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 20:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688787074; x=1720323074;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tKrYtNB7ld1AfyLU2vyfc6nhsgEJyFzpjN0cmzdHXtA=;
  b=XPX8QbK9QyjGhW4VC6ykWmQ80M/wDH7F7qhp0/RhXwbJPNsXg+3YrswK
   aapUGaJSXr+6/uZpuI/jNgKU4ydGJkp1QtApPCVtYv1AvE/7yakkNd+hD
   2/hyxEccsWrrTG4V5ysPgE1GUtwxUvGERBBGo7kI2oyj2GjHNLs+hn8pW
   npr9uCR5N7Fn8mx8CBRUQNP/jSG5h4yi70O8CJz9ZMdoS7vwMc3ASobCC
   za+jZvFVqBoKlwVPcA1tjJWoNBfBtCFg9dcRGxXBljohJsDyoVBwSEBkE
   eG3Hd3a2mVOGV0UPT9zfE+G2FszrI5UXQgvRPluKsaMsC/o0UEVaSvcJx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="344358213"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="344358213"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 20:31:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="790181497"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="790181497"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 07 Jul 2023 20:31:13 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 20:31:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 20:31:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 20:31:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 20:31:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRiG0FsHl3GPHihT8DI6aNPkbKoQQ/M/0C1Xaq2n8CjW4y0lotF3HOSX0XACGZ52SqnaNlUHzJ7tt6o/oklTxyjJE/SzEYfm8eeanfsHR6Q/AUrhxRWQ18/0yF72V9M2lPoUmUHLZj6z3qi/+hGUqy7IZc6905Q/D3KmMDuvbGNYwLviyyqq/A42T0Si6blndnYHdFVvrVn1VVne/CIsA7vKzmb6zwObLGOfQ9P3sVuFPdnXsoSig/7ysbxTrn3Ye08gO7VE1JCCG0JwWRue0gOnO0fp8PG+An8C/kZMnm+D7IGdEPqq713L5Pvj9DjjF5VxfmIh2EGc+yXYD5Vvew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEmdLx2A7qpFpiSlIDT+l9a6Z+TmJMaq+zIvHMBy240=;
 b=Xm+mHSc8NeSeFKFfvt81he8VwCPNOya+UWxk//6Tc4RFtbxSdv5zQU4dWP7DlnMB/8SJ8O4uxt0Nq2CmMPhLF3aetq2mjeyTrz9NOeW1Zap9Hz+dXO1HdvcZD+VEG886eP88pJxDobS695rbEa1ALsNCo+AG6I/f+NOFwVkzq+bHTQlYJyyIyQ3TNDO6bU+M533WZu7v4qXztnx2kCKvZtUqdVWTxy/ztLzBT+4iSzfb4o7fCv4FvSOGGUPFdjsGS7FhKIJj9YbbWuhikfWEVbVLKb3bYsUZ8/pznm1Q62nv32H6oq+NosYXdigNha08sn6AgFgfCQ4Aci9W8WwDJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SN7PR11MB7589.namprd11.prod.outlook.com (2603:10b6:806:34a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Sat, 8 Jul
 2023 03:31:10 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6565.026; Sat, 8 Jul 2023
 03:31:10 +0000
Message-ID: <2689f0de-fbb1-7ed9-6cf9-63e73bf0c119@intel.com>
Date:   Sat, 8 Jul 2023 11:31:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 0/3] support large folio for mlock
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <yuzhao@google.com>, <ryan.roberts@arm.com>, <shy828301@gmail.com>,
        <akpm@linux-foundation.org>, <david@redhat.com>
References: <20230707165221.4076590-1-fengwei.yin@intel.com>
 <ZKhK1Ic1KCdOLRYm@casper.infradead.org>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <ZKhK1Ic1KCdOLRYm@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SN7PR11MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: b68f6657-69cb-4104-7101-08db7f63c5d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q9PhR/tw8pGhLXXONeK2qmyLF1YpfEzT5Pb5Y2E//9Nfy3j559RbmQf/+/RdJOYNzpanY561dN3a48nb0ND5VcFAIm9JH6AoKZHMziy3BNfAQqJiuyQdIbFy+XvtH6GU6CJZ1aI0XeCZ46+T8I+KlPQTi0nNRlifQYQdDQxeWjy6excF8qiXYCcjscHY28DVf0y0EePBYOqKQrFOwHlanNLVieY43zW9h3IfOYXPVuE0fSam/KaWdCq6hEuCA/2UjH/wJ/YfUJN7yqCAnloKIwdRWp8FynXF8mm8S7EyEDfjQ6P0sDV4ni+99fYHSga3CTARlncymUg5SaJ2iaaRuTny7LCj7LtIfcl1KJoI0+VzLiNHGilwFPUnYpWaKU93L0BKUDqMW6+l7Z6A9T3y9A0ruAfVrXqVnNn1qB/VDEG7DCGEvk8JAZV/zRpvOZ6VqDf1Swzcyt/3h5huFhs5rS90pd2s7iZVAJo42IhnpfAC6NEa8gK4t3Fr7KA5X8bPKNTjZKBXyDlO9Pk58SGaCpGa4Y7CacziToSdDtxrkPad4U3mUc9Is9CpI+0PdU/LAoV0Xqy1QzU3bRaSXcke7QeZYpNBObTuagWRvI2FziBgD2wiDs3reGiUrO8plkMOZN+0++VC1eT1RiovBA6PrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199021)(66899021)(66476007)(66556008)(6916009)(4326008)(66946007)(38100700002)(5660300002)(316002)(8936002)(8676002)(41300700001)(86362001)(31696002)(36756003)(2906002)(6486002)(31686004)(6666004)(83380400001)(53546011)(186003)(6506007)(26005)(2616005)(6512007)(82960400001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2diaVFpTXZxMFJtcEl0S2pEN2RqbE10UTlFdlZ3M0JSODFLQzJCK2xKbWVU?=
 =?utf-8?B?SEQrb1Q0b0t6QTlFdEVuamZmaWd6NGNPUGtNeFVwMWovMmt1Z0twbXIwajdI?=
 =?utf-8?B?bjJnRzYySzFJWTdheTJzS2JBeTNMancvbk5yamwvdXp2L3ptdGk5b25tRVQ4?=
 =?utf-8?B?azNPK1dsYytzcUprR25uTHpkaHlYZ2Y3S093eEFMcUZwbXNqQXY1ck9MZit5?=
 =?utf-8?B?VmFTVkY2K0Q3RmxSZkZNdjZnZEFNVUdSMU8vdytLbjloSnJ2RTdDZDAvRm5R?=
 =?utf-8?B?U1JmcUFDMU9jdG9IaUdleHFZUGcxSUV2bitSY1c2NXd0MWw1a0FJNjE4VTR0?=
 =?utf-8?B?NklMekFuMFE1N29kQmU2RUFQU1Bodk4yZHIyZGhsZ2dUYWhCUjgvRVA0d25S?=
 =?utf-8?B?K2FXMXJ1VHR1VnZzNklXdzBOQWFqeXV5Y0V0V21UWVVhYVprTVMydG5uODRp?=
 =?utf-8?B?a3VlZWtoSzdLZjlCQzFWOTg1cUwybUNzZ3Nsa2ZiL2trV2c0eUdUeXpTSTQz?=
 =?utf-8?B?blNRQmJLc1ZzZEFGSjdubHlLSWpiS2JjS2lCc1gwZ3I4alF6MWJuTVpiU1dY?=
 =?utf-8?B?NE5iUFNJVkloWVZxWk9NQkttOWx0b0J4WVo3RU5FUHJvNDdvOTg2cE04dFYz?=
 =?utf-8?B?dHBEZ0VSUkhhdFB3U0VROXN1dC9Bc2VJSnFZQXNvOGJxMFI1Vms4amRkSXIv?=
 =?utf-8?B?U2N5VVhJM21iUXdzYmF0U2hmK2oyanlVekl1Wk5UMVM5TkN5VVNVcmd1K25v?=
 =?utf-8?B?N3Y3SWNCeGFRUkRlcS9zYWRxcngwd2hVOFVHdzNSQ1d3bzVTak9JaS9NeERL?=
 =?utf-8?B?a2w2WXduaVY2L1ZucG9TNG9xekZWSGtmZ3llSy85Tk9FaHRucXFyOW0rN0VJ?=
 =?utf-8?B?aE9aaXN5UUFKMElZYWhlS0hFZWRZRnRFQTRodURTYWdaVC9DTldKZzN1Zjdi?=
 =?utf-8?B?TXJHN29CRDhpVWpXaDl6UTE2UDI2LzRiQUlUR25FRkxWazdVSTF6QXd1aUky?=
 =?utf-8?B?UW9aM2dKY1RScTkzMDRKcDlzZktMUzBvMlZwQVFlemI0THpTQkl6c3c1MGJ5?=
 =?utf-8?B?Wm5lU0l4R3E0cnVoREpteEhiOTNtaXJvSld5dkFrQ2JuY2dGNzZ0YzdGb003?=
 =?utf-8?B?R28vVW5ib3ZmRkY4QmtQQ3lZM1FDZlI2SCswSmpNa0xBYkw4dytHWkt3Kzkz?=
 =?utf-8?B?U2NKeFhWVDZXMnJUaG9LNUw0alB2TGl3dzZhWUVCUGxTVm5FZ3FNZDJGaEJm?=
 =?utf-8?B?R2xOcDZaUE0xVXB3QWMrMEt5Tkc1WTlOVlJEOEY1b1YvMHB1b2ZPV2N1ZWhw?=
 =?utf-8?B?eXAzUkdhZCtaeVVQdUl0cy9ueUo1UFFUSVBUYUJnNTFRTUczN3ZJMzU5UVcv?=
 =?utf-8?B?QW5EU1NoOEdsTE4rYjNENHF5NUg4WndvcG0yajk5S05wREg5Wkt4UU9PZ2Jj?=
 =?utf-8?B?Q1BuL0diMTQrV3c4akxSd1lveVVKcGQ1cTlZSEZLcDFTUDBLb2VIOFRLN2lj?=
 =?utf-8?B?ZlQxcWJRa3VHa0pPa3NQU3hEY1crSlowQUxaeEE0RTBvSXZHcEhVMmlNL2FQ?=
 =?utf-8?B?WjVZMVBPMkF3eHFGc1BaQlA3VURFRytZcTVYTmxQbnhBUVJVUnR1cmNQTVhT?=
 =?utf-8?B?SGV0ZnRxaGYvOGV6MTEvRllBVEZQNE1vSFBtbksydWxIcmRIWnE0b3FBd3BG?=
 =?utf-8?B?WTJhdVJEeHVuMFBSbDY1UFFPVy9BdXVJRkhvSEpzeCtad01ORzVDUERJWWs3?=
 =?utf-8?B?SHpQT1ZuMGVVbWhKdlA2NTlsZHJmQmhjaHVuWGpVOVRBWHFwbC9mcGN1ZWVR?=
 =?utf-8?B?LytWM0lxWW1oaUVvUk1FUGovZGNuY0dXUHcvb0tFcURhZWM3aDJnOXBxK01Y?=
 =?utf-8?B?QlhTSXpNVXA0TXU0R1l1bXQ1RDZnTTRyRUhMTWxEaDVVWUpyeko5aUwvdlNO?=
 =?utf-8?B?WmJENHlCZ2lOQnc1M2U1YTIvNE0ySENRclZjMjU3aUtkU0pIdE45cVlFOHpI?=
 =?utf-8?B?ZnpiMVdzUGdlKzZxU1ZrUWh4U01rbXQ2ZS9kVXNjN25kMlpwQzg4SXRDNFdV?=
 =?utf-8?B?VHZqVUJxV0QzeTMvb1E4b1JmSXl1SkF0SEoyMDBuSFQycTFFOGE3VStQRVls?=
 =?utf-8?B?b3RMY29nOHlpTnRnQkc0UCtlQzh2YjMzN054SkFVUFNuQTJFTG1udkVRTjFk?=
 =?utf-8?B?cXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b68f6657-69cb-4104-7101-08db7f63c5d0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2023 03:31:10.2874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3FghAXmGTM7I3xEcVmHmaVLLeiGLtA7WyPGFRMpO8Ln4oYEUsxcEfEsMesDAWusQPeh9gi4ZWxCfk7lizAU5VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7589
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



On 7/8/2023 1:26 AM, Matthew Wilcox wrote:
> On Sat, Jul 08, 2023 at 12:52:18AM +0800, Yin Fengwei wrote:
>> This series identified the large folio for mlock to two types:
>>   - The large folio is in VM_LOCKED VMA range
>>   - The large folio cross VM_LOCKED VMA boundary
> 
> This is somewhere that I think our fixation on MUST USE PMD ENTRIES
> has led us astray.  Today when the arguments to mlock() cross a folio
> boundary, we split the PMD entry but leave the folio intact.  That means
> that we continue to manage the folio as a single entry on the LRU list.
> But userspace may have no idea that we're doing this.  It may have made
> several calls to mmap() 256kB at once, they've all been coalesced into
> a single VMA and khugepaged has come along behind its back and created
> a 2MB THP.  Now userspace calls mlock() and instead of treating that as
> a hint that oops, maybe we shouldn't've done that, we do our utmost to
> preserve the 2MB folio.
> 
> I think this whole approach needs rethinking.  IMO, anonymous folios
> should not cross VMA boundaries.  Tell me why I'm wrong.

No. You are not wrong. :). That concept to keep anonymous folio not
cross VMA boundary is decent.


I tried to split the large folio when it cross VMA boundary for mlock().
As it's possible that the folio split fails, we always need to deal with
this case. I decided to postpone all large folio splitting to page
reclaim phase. The benefits we could get:
   - If the range is munlocked before page reclaim pick this folio,
     we don't need to split the folio.
   - for the system which don't have swap enabled, we don't need to
     split this kind folio.


Regards
Yin, Fengwei
