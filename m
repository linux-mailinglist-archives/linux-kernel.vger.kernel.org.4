Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B08E741CB2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 02:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjF2AAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 20:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbjF1X7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 19:59:51 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5147AED;
        Wed, 28 Jun 2023 16:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687996790; x=1719532790;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1+OeyyHHyne3JXkmRuJel0Pw2Z9Ooa48wSggUjOTeTo=;
  b=aQPNtXRobwtfHoSPuua24rS7y9zvEa4b0yienzPPVkwlPQGCMuiNJOfr
   U6crJ0hJ8AgjP11MetcZkZz7pL4sJuG0bU4K3s/qnNVnYH9+89Bs2dKx3
   r6j4x5gDjSLELyRD4ON8aAY4hTETkKakfXpC0B19uXiIZRlPBPPRCSOoa
   5Q742i68eTqPdmzaIQcYRIib/ycq1PCr6hVRhpF9NBU0JeWu4o44mxsQh
   NkT3GmZXwZt3u3sTcubFnb1oJnDyjnCK6VIUzrTmocKzDsHuWKgKaAXep
   8mnoXlMKTmfxtRbXBoguPbLkECNV5WH0EMze2/mUTad2ke8H3WmMNUFXT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="342324684"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="342324684"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 16:59:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="667311060"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="667311060"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 28 Jun 2023 16:59:48 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 16:59:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 16:59:47 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 28 Jun 2023 16:59:47 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 28 Jun 2023 16:59:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1Ijbg6gbO2Q5nq4blSfOkHEGbpYjJiYB1pFYA8pWWet/g1G8fX+d5HSR5RQ+vnH32yx+wFsgHWbjrvVdGyRxf1pLt9dxN1tqJCTYCT5oR+Kp5fAVJGohrNuws8gFnx7Zl8hPaKJqZ6urYKLHYD+6OYq6+gFgFuxDcCgFC/qc0TeI/K5qqFYiFcqUHgkdWI9xcinuG77WaBcK3yFxeJJxhLa37DCU8u0XKlOYdCIaqHzMxcSZGhgOg6V8eKd6T6n+Kge+PrR6viD2zXeB1ZUWGvZiuKRyxTQviJ48rEMYVx9sIjvaOa2qr3y+4XKGSs1xurU+h7HbhQZ63sSL9IHxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGdYIFZXUDe55KPDgW0YkV43ras9G7r5Bp73X48vCM0=;
 b=WNQcgugyf75MXExTamszoTBwVgo9xi0e6BLUFh1YzBTmlZjj0ocOfL9Q8Adll/w6NQQuuuzXSsO3QOC5hrlI/J7mU5UlsdFvUDJhpbSKw674LRy3fs0O1ERFDbUrhU8m3DyI8orJBDWN+qyPKMki2ymAlK1HVKW/zT9ocEeK6pqHIyg1TNLpgvZQq7k9XzccAFz21tZ9VMy458NEUH0X9Fea2P9j6BZ6lbXWl57F3e72Bs8iZ8wpFQuM9rVmi7PdkmVGxiIvHTr5bl3ZuUIdtpmW/NHfu89C9fgm8MH19CGCd9mNZDGUP6yTzbHWVrYB/WaVD4kJXpwJ22ZoC65Elw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by IA1PR11MB7755.namprd11.prod.outlook.com (2603:10b6:208:420::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 23:59:40 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 23:59:40 +0000
Message-ID: <dcbbea37-7fbf-3a7c-6cfb-04dae715e967@intel.com>
Date:   Thu, 29 Jun 2023 07:59:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v1 00/10] variable-order, large folios for anonymous
 memory
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>, Ryan Roberts <ryan.roberts@arm.com>
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
 <CAOUHufaUTbUw9MTzw8D=sVrEB+RP6LSBQVGn93TWk=ozV8XobA@mail.gmail.com>
 <CAOUHufa0S_ayrys0XzDbH8KJi5HxvbGCh_bSAhDpAgcmSJjFUQ@mail.gmail.com>
 <1fb0c4cb-a709-de20-d643-32ed43550059@arm.com>
 <CAOUHufbtNPkdktjt_5qM45GegVO-rCFOMkSh0HQminQ12zsV8Q@mail.gmail.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <CAOUHufbtNPkdktjt_5qM45GegVO-rCFOMkSh0HQminQ12zsV8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:196::18) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|IA1PR11MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: fdc7cece-ef4f-4288-1c6c-08db7833bc27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PYgX1EAWmbTB5y1r7NKEkYppfxVKaCSKfZPvJ2/5cvYtBII6h6Cf9ZnJ/aBgCw2xBQTtu8DA1borGz5xdQs2li1O+2X4E1agwGRYSJRRZLmubiyZsFl2b/wQmE3x6o66WFA4SxDExuFd3c8GeCbwy69UHH6hc76znPhnRsbMymBFwHPcSARpzhjjz3tazjuIgfrC8uoqXixhvIwiZQqt7mk9X2Rwi7w3GrWsRAHXsDAyltOHpDFaZ9IRBGGc4jqyP64Vt9diEN9SalA7BwQawyrPlSF5xTDKpydS4I+d41tKmglkZOCVNPgn4NfOAidTv6g+cZq/vDPaKBm3yeG0uoaUwhvmi1u549ZkcVup+KG4gaPdRbv3+KqDRwPV/PtPS0a05HxXUYDrHrk2gSB2V0qMcFhZUx8xvO+IkMIEmOh8GYn8wHCkPcn1KjrLlE69AqU4nUtI8jRarEv1DJrRVBbxiVRBFOW2zVsGmgjpRCHhyUD00K4tOOWSUXFP0fVzprAYvWa3q8/h8UyBslT40SS1+fgYpBg+L9e+X7s24UZGdNw8dmoK/KBXKlsjP226286/1IU1i3veuKa4jjNmEsubb+uUI7igCVwrZx8Ej0SshPCO4QftxlI/xrA89Vx35gzTRwCBXnaAwpMRE31R+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(7416002)(5660300002)(31686004)(66946007)(66556008)(4326008)(66476007)(478600001)(36756003)(316002)(8936002)(8676002)(2906002)(6512007)(110136005)(54906003)(41300700001)(31696002)(6486002)(186003)(86362001)(6506007)(53546011)(6666004)(26005)(4744005)(38100700002)(82960400001)(2616005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHE0a0c1MTAzM1BGeGZTajY5M2RSMnBEK2VYVS9sTWNtVE1kT2wrWE04bWcv?=
 =?utf-8?B?ZzZNMVlySnFMNEx3dmNCZDFiekRmK1JGSDZLczVQVHZRZCtnV3JEUlJUSE5t?=
 =?utf-8?B?bTRiWVVhczEzZ1g3VXlIaHQ1TFQ2VU1laDVqY3JPY1BRVERpUnBkUjFCcDNr?=
 =?utf-8?B?TWxrVjF3Wmh3WHlqVURQOHdZR1cwL1RsNnpDWUE0ejk3eCtUQzRpUVpNT1dE?=
 =?utf-8?B?WmV3ZTlmUnBRSWRyTWdvbzRJQnFMbGlOTGwwblZqaUpTQkRwNk5QSWl2by9U?=
 =?utf-8?B?ZCtuaUo4c1c5Nmh3cEZRVmJyaS90VHFzcnF2Y1E0cWxzZlNXMXN4dVQvOXpL?=
 =?utf-8?B?WWtNTjhaM0w3a2llWk5uaVRvZWxLcnUvR003YW91bStlbmZad0hhWCswUURy?=
 =?utf-8?B?ZU0xVUp2U1FEWEtlQ1BNZnhEdTVsSVFUeFc1VEdXQ0JEVkMyRGRYcmFoKzV0?=
 =?utf-8?B?ZWhVK0V6VEt4aXpRK25ReTFhdXJOWHpuQVcrS2dSSkJwKy81YTlYWXRpM0lY?=
 =?utf-8?B?cWN0VXpUcXUzK2ZGUjRVOVBCeWlUVVNEcUtXV1ZaR3lhZkNRcHBGRDhMU0RX?=
 =?utf-8?B?a1RrWHY3THM1R1pZNWJvVHZsTWVVVDVSVDFjVFFLNHVOb09va3hDNm9tZnVR?=
 =?utf-8?B?M1ltUndrcm5FSnRFdzFLa2dHb0grS1JRTWY0VS8xdGlicDA1MlZsNEZKSjFW?=
 =?utf-8?B?amYwYmdQTmx2T0FJYTlYT2V5R0QybUFGL3ZlZWhkSXRkNE1sNVNTemJkY0VU?=
 =?utf-8?B?bFhUbXpJOU1rdVo3MVNxR3ZHYjlxVVdVRHZuOVFXRnhVREZTNmdQdW8wemFY?=
 =?utf-8?B?MkwxNGxIN09kVnp6dlYvUWs1cnU5OFg4VWlUSGpIWWM2ZE5qYitOTWRPeWF1?=
 =?utf-8?B?enliZHNINnNHZGlrNlFReE9Fb3BBanNzUllrOWVOdlg0SWhMMlZZTmJydzZ2?=
 =?utf-8?B?ZHo1MjN3ZnlTNVFNNWlBRGtMQUlwSkFGKzQzYU04SGk4cjVKeDExNXFSSThY?=
 =?utf-8?B?LzF1aGwvdDZLUXl0Z29zVnVwVEZnK05XNTE0K3Znd1dXMTFyZWIxeXhvSHJ0?=
 =?utf-8?B?ZFE2UWZ1UWwyY0hZYTZrRmluVjlySURIMjVCbVBRVWJEdjhnMHU0aXR4M0tB?=
 =?utf-8?B?SlYybUZFMVNVM3dPVStuRithdFFzODRMS0N6ampRQlZoVDZQYWlzS1dJaVJO?=
 =?utf-8?B?MUh3Q044TEJKVG1nQmNCRzJKSGdYTW9JVjF6YmV2Q0I0WWtxSGgwMExpUXFr?=
 =?utf-8?B?cXhTQm94OFNGc2VZWEcvbkFHWURxUUdia1ZlN3JhTXdselB1Q09VWW83aER3?=
 =?utf-8?B?WGtVQ2VOazA1VGlVQWZZc3JiSitXZ25KdDJYdDRNSXozVDVWTEYwNFJuN1pG?=
 =?utf-8?B?Q0g4SThseHBvQXhqZGpRd2x6aFliVkdnWUtCQVpzZ2loM0xxbGNTbG5udVBJ?=
 =?utf-8?B?RDAvYjJLOCs2OWJEVUhTVGZOMUdObElva0JrNkNCRzNqQW96aDBGWmJ3NER2?=
 =?utf-8?B?MlNJRmtjY3o3UkZ3VDZ5LzdsYStmWTdBT0NLT1BvZnc2ajdhZzI0NmtqU2U2?=
 =?utf-8?B?TEhmVGc1WEJMQWJKSjhoMHFaaWVsMEhvdmNwbmlvb1ZlaXc1U2FtSk55aEJa?=
 =?utf-8?B?VnpaNzRrbkY0akx2Q3FMdFQrWG5XRHl4c3hXaFdaWW9SS1VoNkpFM3FqRXIz?=
 =?utf-8?B?T0RycUtaeWcwckVzQVZXQi91SVZPSUsrOFIxS25sUy8zREtVcTUrNU5VbXFa?=
 =?utf-8?B?Y1VPU0wwbnNMMHFRU1lsS3ZreVJKZTUzY3FsU25oNmMzWDY3ZHFHZmpLYkFY?=
 =?utf-8?B?ZU10VFpnVGFqL0Uzd2VBVXl2bmowNnBPKzVQMXBGdHpBNjVGMjhmYWRyeWhk?=
 =?utf-8?B?SFFjMS9pOVVmM0Y2U3lGMnJDS1BEbFFLYXlwT1NrT1h4eG9XSGdic2JiQjIz?=
 =?utf-8?B?VWJCbzBCOWJpb2lsZ1c0MXVaZ1RpYWthSGJIT3hxQ2s3NTJGK0pTZ21KMHhC?=
 =?utf-8?B?WndFakMwbDN6NFBXUTFXL250Q2piOUdvcXBFdzBpTXlobFJRVFFXbWZ1dVJW?=
 =?utf-8?B?cUwzTy8zZVI3MzBDbDRwM05jV0xSa0R3TkZhZ2c4UTF0MU4xYW1EamswbU5V?=
 =?utf-8?Q?yrVKp33Tz4srBHMJfyPDsE4ha?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc7cece-ef4f-4288-1c6c-08db7833bc27
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 23:59:40.1127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VxSeOdXNZYi/0X6/EmMKHJXu52OiYNEhtm97bO5FPnOnFd72hKCIj6LIChWeimdu1f7CvlA5bht8k6vTKQrCtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7755
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

Hi Yu,

On 6/29/23 02:22, Yu Zhao wrote:
> And please make sure it's disabled by default, because we are still
> missing many important functions, e.g., I don't think we can mlock()
> when large() && !pmd_mappable(), see mlock_pte_range() and
> mlock_vma_folio(). We can fix it along with many things later, but we
> need to present a plan and a schedule now. Otherwise, there would be
> pushback if we try to land the series without supporting mlock().
> 
> Do you or Fengwei plan to take on it? (I personally don't.) If not,
Do you mean the mlock() with large folio? Yes. I can work on it. Thanks.


Regards
Yin, Fengwei

> I'll try to find someone from our team to look at it. (It'd be more
> scalable if we have a coordinated group of people individually solving
> different problems.)
