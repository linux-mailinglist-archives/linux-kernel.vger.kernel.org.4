Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430B3741CEB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 02:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjF2AbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 20:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjF2AbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 20:31:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524082122;
        Wed, 28 Jun 2023 17:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687998680; x=1719534680;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BICH5n8MxFZryEEiFlmvkNuBrIOFHh1powT/aC+78IA=;
  b=UaYsbVsgCtMKfTySWyBxTsTQsgZKHJ5V5WMwT0OxbwHlfWrO1BFelG8Y
   W+zF2gNtYX4VVvLF4oq3DkWmZVa8oSl1Uk0qSlafIlZcLnSO4beRD2VZm
   l1pNftV8KkWAZNV3q+aOJA71l/7irlgfDyjxPHNPc6WX4HtX09XjF/OXY
   taXrmJDV8+2nxcOMFaLTr4dZ5Zys9Y4VzEZQ+SsFH1AZpiRm4BQgrsskH
   gptJuPLumx3ktD4kaUeOlAikM2pengFquI68cYPNuqNFxklKLLUf9ZmRZ
   QSrVMK55M52pFBR+8b/+JD+G9zy4wufljJ+JiPbYF9BDisng2I9z+zY6i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="428009937"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="428009937"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 17:31:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="1047595101"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="1047595101"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 28 Jun 2023 17:31:19 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 17:31:18 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 17:31:17 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 28 Jun 2023 17:31:17 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 28 Jun 2023 17:31:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTRjxIkA0nU3Vnm0lazG4YZEMTB5A5CmoxO7aqOsqvvTC+YSIkL9cv2OowpLWDBzKgNWuoNJ4UAkZa/w40RBVM711W/+f97v2u5xbR3kCHK1Nd5hq9Zk8ogXH8OG/m2Rh/LPLkSwCiDKjH3IRaCffcfYc0RI94yU6d//SIbJKEaz7faBWtTfwbapoG/v+7FKjE5w7lZ/uc7vmwo1yJNCoN6ZMsFlmKO7afh6AfSNGfvh2YjgzzidZxWh06EfWcMwkwDux7CG611A8DSoVpikdtgP3mmvTsIlBy6ZH6ko1+K2rjMZ2W6FRJLdaUhyH5BYmSEVk5QYAaRXmj7fO99yjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFSscqtt+Te54eQcY1aA/qcWmOiCkGf5mdGUPzYQAis=;
 b=NeanHzVsaIt9vbTDLeuDWS6nOnhBSWpoNuKUQURc1GHRlnD1Ixt9JgTMlTixvtZ5PVvCKPtwlzcZpUsszn0m6o5tpccSEatdIhCu73iPUJnXaW7rx1dyQHt8kt6cJN39LW7qHA9SePWjVi8ImQEM0oj7y0Ez7ki7IKlieiWNnYp8ErusRpG4yJNJ2svUR1jgo+1hp2Zn2SkBtBJ4UKWDqvyhkhy1lQbhzY9vKIK+sQeU5B6894cTAnxrtVztJZu7JdexILYmyAWlSzk3FSne8MwN25mX05V7Sv3dL/2WflPDO3YfOnxQHbU4ZKYmGaQXj7rrVdOSQYcrhF+FuSQwqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by MW3PR11MB4730.namprd11.prod.outlook.com (2603:10b6:303:58::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 00:31:15 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::e6c7:a86d:68d6:f2f3%5]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 00:31:15 +0000
Message-ID: <e8357d56-ab58-3268-e074-a4c494d4697f@intel.com>
Date:   Thu, 29 Jun 2023 08:31:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH v1 00/10] variable-order, large folios for anonymous
 memory
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>
CC:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Christian Borntraeger" <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
 <dcbbea37-7fbf-3a7c-6cfb-04dae715e967@intel.com>
 <CAOUHufbC76OdP16mRsY3i920qB7khcu8FM+nUOG0kx5BMRdKXw@mail.gmail.com>
From:   Yin Fengwei <fengwei.yin@intel.com>
In-Reply-To: <CAOUHufbC76OdP16mRsY3i920qB7khcu8FM+nUOG0kx5BMRdKXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::19) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|MW3PR11MB4730:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f8bdb33-b1da-4122-5b0f-08db783825bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lt2p5Vb58TvwgIm2OwOc2sNZFZJyWfp2+VAP7i55l+qLyJuYtMy6tj63W2F0GHc6+uO92LOmOrnYS//fOY1RWCsPEo5rq2gjV1R7savGV3uBpsDVg/3GSM6tMU/HcgoVQvqGUpPBbDVs2NjWP95n2cYo6nihNhoknRianBf6uZq/8iKg46S5OokpKCI7FrczhPhXpBoF6OHfPZSHULPzP23fXsWqwFlrtIpkuK5DuEu6zJFHde5PAzeCzBV6NPTYIoVRNcQtocaTnPbBZs3tAnXzOnpZ2xxEh6LKYpyEJZ4jqfn1rtEGGF4/XPduUJWzXT7EZ113e7qqovtWwH5hOOWnT6wEl5F44hzkKOjjmWx5ONRTLIetVJLoLhCmef2FJ+z24TreDaCDQ4qxsBsMgBLReC2+5c+Tx8dGhkRlGHTIt9RiHTaz6bhCwteD1BhNXLdmaKp5fNI5LgS/SaBg2h95Hw3ZcdbudCDShOfladznqQ8F/0T/8nDZTWOOrtY/deEjMmycn/xW0FB8ZdnBVLRM1bIEIYvQ3q0Qru6ctSHC2TN2QNGAyfrhINu58Lg8AsN5Au1RqxgyTDA+cEuCF+W01aowQdjatzcvlrFO7x52qXg70BJbffQxLNnmDT+MQdGCuvrFaedwQ5PkzVWwdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(39860400002)(376002)(396003)(451199021)(82960400001)(38100700002)(36756003)(83380400001)(31696002)(86362001)(31686004)(2616005)(54906003)(8936002)(6486002)(66556008)(6666004)(41300700001)(66946007)(66476007)(316002)(8676002)(53546011)(26005)(6916009)(6512007)(4744005)(186003)(4326008)(6506007)(2906002)(478600001)(5660300002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1B1WGEvNnZiTUd0TC94ckxNWi9pUjIyeUFWdDV1Y0ZtaWJhaEpoV2FUR0RU?=
 =?utf-8?B?OEc2bE0rem9LdnpsY1ZrZjVNcWw4cU1zak1yWVc0Zlk1N0ZpbUNKQXkxb3ZH?=
 =?utf-8?B?Mnp2cnQ5RXloQS82R0JrWDdiSkFCMXMrckV1Yk4zTXNMdldMS2c3V2VhTU8x?=
 =?utf-8?B?N2FPM2ZIZWdZbnBzM0VMUS9kOUYybjZ0dDEyQW0vMWlpQW52Q214aVUzQ09a?=
 =?utf-8?B?MmZ5aUNvSFh0OEZCaWN5REkyYWFUbzNvVW1tazhiSks3ZXR3TlB1WmhjVExv?=
 =?utf-8?B?M216OXNyZzlkYUNpdnV5SVhPWkN2UFNiU20wcFlkSUNRWDhGZTYvZWxscTdQ?=
 =?utf-8?B?Z2Y0NFhzUEtUcm5tMHprb3p1bTN2alUyclNEVHFtd2I0V0QzSk5CWm15UHcw?=
 =?utf-8?B?THFNaTE5RGxHZkZDeGRaUEVYU0xwTytZRUl1NXFIOGI5eXZkb1BjWkdOWWVY?=
 =?utf-8?B?bldhWUhkdjFyQ0VNQ1JQN0tock1SYkJSS2RCY0dRcWFsanJXdUJzbSttUGlX?=
 =?utf-8?B?Z3lja1ZxdVY0Y2crZ2dYZXZKUjcySFIyUlV5aXA2MGliMWxoU3ZxTTA2UFNV?=
 =?utf-8?B?bFV6c1N4OFBITVFoY2p2NTRMM2w1N3NWYnBTVEdqSDRnbk9LSm1OalVkU3Rp?=
 =?utf-8?B?aDUvR1ZkRFNab3IxZCtBd3c0cVIyVCtwbWZuUy9jVWg1WVBUWEdLdU5qMG10?=
 =?utf-8?B?aTF4M2tIUmFTb3E5b21uVC9pYkV3ZnJ0MGV5SmNCRlRtYisyRWdQVWNWV3lF?=
 =?utf-8?B?WVBjOFBLNEUrVDh6ay9VZDZrditIM2tFUlFkRVVZUzQ5RklYdUdteFdPaGh1?=
 =?utf-8?B?RUl5UUFaeHJmK1VsRkpKaTYxSE85L0NvSThtNXlCaG9veUlDckMwMlg0eVFS?=
 =?utf-8?B?MWZOMGpUQno4QjdIOTkzYzJsQ1dQYWFoS05BYThRUWJtZHliM1I0SXRrcGEz?=
 =?utf-8?B?dW9pM2NRNEZMWEVLak9rTjYxYjZieWNSMkZ1NGNYU3dPblRQaE1KdjZTYlpX?=
 =?utf-8?B?MkNGcnp2eUJQeWd0NDl3TmtndlorSXFzRlRBaTY4RGxpSE9tUnk3NkFmSjNG?=
 =?utf-8?B?c1FEaFV4amhqaGhWYUFyY3czU2VSaUpUVTZLa2M2U04vV2c2Y2xONWpKejA0?=
 =?utf-8?B?RllCTzlhbHhYTmx0UHpNS25paCtZZkdoSVQ5Tm9vQ3VWSGRLU0FHMEJBN0ZR?=
 =?utf-8?B?b2g1czhQNEtkcGQ5Nm9VVENhUzEydUpBT1Y0TXQ3MU41RjR4aFpMSm5FZ0pH?=
 =?utf-8?B?eDZUMjhFWHhIRGt2QnlSVy9VTFFnRkVEY05GLzZpWGg2cmtBY0dyUmZvK3Y1?=
 =?utf-8?B?cXVtZXZpZnNvVzJsMVh2L2JKeW15RVlYY01ob0V5OUFPdWxLdUpNaG9Fanl5?=
 =?utf-8?B?V3R2VHZudnJsclp5a2tNTCtkaXkrTDlwRzR0b2VJa2E3VnBQY2Y5akY0ald2?=
 =?utf-8?B?b29wL1BWK3NKdXRwR3NiN2pjM29Tb1MrR3Z6bit4TC9jY2FGdElTbkhGbnZM?=
 =?utf-8?B?R0R4Ny82eEpueUN6eUw5bktVNkE1Z2FEWmVVQkZrOGlDaTZ4bm45TXV0Q0Nq?=
 =?utf-8?B?aWZyeDFvaHpUTDUxazFXUlFDc3l5REhEL1FLVW1JUm84cXFpTnprZ05JWTZq?=
 =?utf-8?B?dXZTT3hGSit1SlJiZU5TZzdyZTF5MTR0cmZ3Y1UwRTJSRTRGOTFHeTJMckFM?=
 =?utf-8?B?OUNSeTg2OXkvZUE5Qmo1TmRHQitCRGN5b1ZmVU8vMm1ycWUwUmZUdFdROVpz?=
 =?utf-8?B?UnZqNlZ3WERqL2Zla1RBeVVDS29zWjlUWUJZYTdPYVFqa001OWVweHF0KzZS?=
 =?utf-8?B?VGU0UEE5QUx4ZlhLRW5LdzNVY3pNRW53YUU0NHVEYjNBWXVXK0p4TDFjTGRW?=
 =?utf-8?B?eHc1WklrZUpXcU50ZENJR0VZL2JWaFE3UERWQnU5UFFGZWRJTU5aVCtTS0ZQ?=
 =?utf-8?B?OXpZOW43cGhpUEcvanAyb3QveGtOTjNPdW4rbWV1L0ozTlJFY3B5Y3FjcEhR?=
 =?utf-8?B?Vldha0RWRllIdmVvRjhvc0ZGRXExSlZLamZuWkxqbGRMaHJ0dkN6N0tuTVVI?=
 =?utf-8?B?MnVmY3p0YjFUY3VXTmZHakdLdFM3eEQ1a1A0c3BKQXNublFIbFFiVnlhTExo?=
 =?utf-8?B?VHpRSjNlREozblRxYmNWV1NLUHljNWlDWFNWQnBEN3V2anBTT2duWWk2Mldj?=
 =?utf-8?B?UUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8bdb33-b1da-4122-5b0f-08db783825bd
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 00:31:15.2338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlFX8+D7K4sldTYWzpHs838nHiOm8LoUCC8b821MbBZDy4oyNuYSoWtJRig35Ijm+fBduZH2e/yLCmSyyUOfIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4730
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/23 08:27, Yu Zhao wrote:
> On Wed, Jun 28, 2023 at 5:59 PM Yin Fengwei <fengwei.yin@intel.com> wrote:
>>
>> Hi Yu,
>>
>> On 6/29/23 02:22, Yu Zhao wrote:
>>> And please make sure it's disabled by default, because we are still
>>> missing many important functions, e.g., I don't think we can mlock()
>>> when large() && !pmd_mappable(), see mlock_pte_range() and
>>> mlock_vma_folio(). We can fix it along with many things later, but we
>>> need to present a plan and a schedule now. Otherwise, there would be
>>> pushback if we try to land the series without supporting mlock().
>>>
>>> Do you or Fengwei plan to take on it? (I personally don't.) If not,
>> Do you mean the mlock() with large folio? Yes. I can work on it. Thanks.
> 
> Great. Thanks!
> 
> Other places that have the similar problem but are probably easier to
> fix than the mlock() case:
> * madvise_cold_or_pageout_pte_range()
This one was on my radar. :). 

Regards
Yin, Fengwei

> * shrink_folio_list()
