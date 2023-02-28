Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845366A5029
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 01:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjB1Acy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 19:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB1Acx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 19:32:53 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A365226CC8;
        Mon, 27 Feb 2023 16:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677544369; x=1709080369;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P23uLetnNolTJcy9mDLIsoQZ3g4oqxGnRUZAQbYhF+E=;
  b=R09iQP/W2FEpinsILT/GqfAE3kY3+yx2UTmKP8IGRvAf37g7KkeQ04Ve
   DqNVVHJgWWWGGZon6VAh5svo6Llh2WPRJeghpdepz5zT9Oizh+5XlA1Ny
   1FTBVgyrDvBTJnaTIVdZ3oYWncpyIKzuHjVrfGuG0ajcHAbW33z89oxb5
   aMWfo2uD2hN+8EbzazuoTyKtQpnygOzkwinTC5RxbDi41W7SCzI00yxMv
   vURQvWtxpq10T9EDDzGN/w4MaB2sNTP8fUEdg/5euntcGVfdxp/FPS6e1
   8g3c8kx151IT4rojum5jt5fk+Ry2+iPfqLcFgDmgct9rXLF6Z04vIMVyP
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="335498919"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="335498919"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 16:32:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="673939224"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="673939224"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 27 Feb 2023 16:32:49 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 27 Feb 2023 16:32:48 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 27 Feb 2023 16:32:48 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 27 Feb 2023 16:32:48 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 27 Feb 2023 16:32:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYhdWWzOKHSH4ubl0JJydI6+0mWN106gywex5Kjn6DKIe3mNRDPxU5dU59urEcGfWfUXifRHg+VSigNK8QnU1sostkPkg8pt/MhG4q+kdj+XHAnCOfDeQl/dNUQ9ex7ii/UFCwydrxtto6af/6fxtpjTTe9JAU40sTESGHBb1fAKNOjWeWLrBKCCrXRAx/xY8D3Q0gk/AABr1IERusfEMctHZOqtbt0Uy2+ZQRpw/Fiwxa/t9JR1Vow8Pk7N3wT6rwrKiOnXbYc4FGgEJ9Qd9hAyf0AF82VOHrD1h1Zai3vJbFI4B6a5U15fAEhf2hZId40fWfYu5yVg2YvLPZ59YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbTgprWF2o54uYVJGGoHAPrrePWR4SKvqJtRT3WWlxs=;
 b=UY+lafnmA70A4aktKdmcqGPQ81c2Gs52UgN+Jwnr9p2ewB8nP4XpZ5FQ5mHbXgcDq0JWg6wv8OudZNzc6mmI8QUgIGEfPqLpgvNGrodQWM4TTK4WYqsvIVivzzkICrSCCnI568vAgY3yRWVynk7bxif5kWNUvJMNkW0WvhSMpO+kejjxy7zR+5Nisrrv+p0NhSIfbaOEKDNinb5glD6/oNbFtzitNJMFSOhitqWg7Njf2BKByShKxxI7uAPYQWOViul4gfftiXMoVCoFoymSZ8cc9ElvhkTqqv+K2a5FEUckADt/0OhzSfU30xiyhurtTmuxWKVyOeLPIjTVcllcWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by IA0PR11MB7696.namprd11.prod.outlook.com (2603:10b6:208:403::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Tue, 28 Feb
 2023 00:32:44 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::8073:f55d:5f64:7c6%8]) with mapi id 15.20.6134.028; Tue, 28 Feb 2023
 00:32:44 +0000
Message-ID: <a4aa2e13-7187-600b-c628-7e8fb108def0@intel.com>
Date:   Tue, 28 Feb 2023 08:32:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [linus:master] [mm] f1a7941243: unixbench.score -19.2% regression
To:     Shakeel Butt <shakeelb@google.com>
CC:     "willy@infradead.org" <willy@infradead.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "dennis@kernel.org" <dennis@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        lkp <lkp@intel.com>,
        "zhengjun.xing@linux.intel.com" <zhengjun.xing@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Tang, Feng" <feng.tang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>
References: <202301301057.e55dad5b-oliver.sang@intel.com>
 <Y9dETROtv9Bld9TI@casper.infradead.org>
 <20230131052352.5qnqegzwmt7akk7t@google.com>
 <Y9iq8fRT4sDgIwQN@casper.infradead.org>
 <20230131055743.tsilxx5vfl6gx4dj@google.com>
 <CALvZod7TuaJ7pCc2nJKehwGkcuvsvjdL+4hs6qC3bZsOmGzXzg@mail.gmail.com>
 <d5d0bcf75cbaa2792a3ad0e7b15a84fd67e54454.camel@intel.com>
 <CALvZod7wP9n+cqJV4VN3YNnf6CPQ8PJZbkAgK=fv84D4Sk+Heg@mail.gmail.com>
Content-Language: en-US
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <CALvZod7wP9n+cqJV4VN3YNnf6CPQ8PJZbkAgK=fv84D4Sk+Heg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR03CA0104.apcprd03.prod.outlook.com
 (2603:1096:4:7c::32) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|IA0PR11MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e87fe46-0670-4c96-8cfa-08db19234ec4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 82Kqb7jro+UawYDyq3lX5dIKdZ1eHw986MtkePiGbrCDXgNmrPnAQ3HhP1TJP902XPDtOrkCrTqljp7EuEyaYzG5FalUjkhP6GXYmqdTMQodBh0uREGpdCHvonLtXRGyCLgEESlbuTAZvXCr8SLC6xjYnQE6W4H65QMuh5SEESPEcef+PbDJuNXgUqA55ebwneUYeZPhDO7olMqLZ4w7rsW5GJ5VQY8GGKT3TiAvJWzH1tpfGADUN8wERJsQJICY0krZkhJU/fCe7QBthbIpT9riWkgq0m6u2fj17GyoFvPkRVUi8SuaAnqtvX8JXbty3+wiJ5W815pxR22OdyB1bYqOxsEWgsHceoRNC60E97wD3f4S+qpdpuuupkXw08evOtqYz1TIMq81tM0VwiqSAEiynLrKhKSVs3AttVJl3Q+S6wL9QAKTVmAxwNm/pJa6EM9rX2fbZnypW3HC6BXwuWDDAW+0l6Ls2sqnxZurgXH6a9b9lYRTIIFCyeXjRyyChae5ZRMiFuRrglwpKc/I9SqtyL5jGxr8xbJRS+utNI4TudSC7A9bwHkzjxHllCALnCILKkPp1t9BW/HClFv8ptPHdwvg5ZiaA5F/Ho426C0A0KC0UoOwlNsRimYqUasLYZTIzSDCy2yjwl77PtfCPAzVmDaVj6TIo46fN9kgHCQwVHkgodt+1Y602O0p3uj6AgXR+VpBE9SndxOrln1GjqJsMv79tcObf5kx1uEA2EI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199018)(316002)(54906003)(83380400001)(966005)(36756003)(86362001)(31696002)(31686004)(6486002)(6512007)(2906002)(478600001)(7416002)(41300700001)(5660300002)(8676002)(66476007)(6916009)(4326008)(66946007)(53546011)(8936002)(2616005)(6666004)(186003)(26005)(66556008)(6506007)(38100700002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWFaV05EaVM4QzB6NWtkb0pKTGk2V2pLSHVvV29Gd0VGS05wUGNVb25MUmQ4?=
 =?utf-8?B?N3NHMEdJUmlpdVVZNTVFTit0N1gzS05BTHE0OHp1Nlo0WnE1Q3Q2N05BYmpj?=
 =?utf-8?B?TlB4MnhOZEJkM3JRSHUzN21DNGxKYktmZndRT2hiSzRobVBWUnJsdTR0VlJh?=
 =?utf-8?B?Q2xHWlBJZmtvK0FETzlSczZRVm1YNk9SWWVkNDdmQndmeWRuYUJZZmRmOEMv?=
 =?utf-8?B?MGh5OEZ2QVBoQW5mTndJU2tDZ1VlNkFrRHlGdEJiTzVCQ1YzWkNuN0ZRVSt5?=
 =?utf-8?B?ZzN4QjVLUDh1dVVCN3Q4eG9tUWZHWFd6azAzanVwcm50TmpBVlRVZWdGTWpj?=
 =?utf-8?B?MG1OSW56d1QxL05FeXJEYmFOTTV0WUx3VzdNeFZJUEpLTks0aTR3S3NDbThR?=
 =?utf-8?B?Yk54U2o5UGRMaERIb2FiRFFrdUoxUVF6eDI5M3h4S0ZqTjlweDQ3d2tMV2dm?=
 =?utf-8?B?ZVVUc2thV0ZIc3BCOXljMVEyMmpaVEEva1RrNGN6YnVNMWg0a3B2Nk9MMHFT?=
 =?utf-8?B?WVczUlo2dTFUSFdVQU1OTkJqeXQ4eFl2cDZDZ0I4bjczUGwwQWV3amxtUnZG?=
 =?utf-8?B?TGIrUW8wQWVLS2JkZTBRVHc0ZFNPZDJDTW1GVlZEOTE1UW1LRk5WWDhTeU5J?=
 =?utf-8?B?YVVOS1g0d2t6SVY5OHhoUStuR3VNZ2g5WGxaVWFJV1phS21UVFQ3d25EMWdJ?=
 =?utf-8?B?ak5IZ3NLY08rTVJuamdNRUdWcEY3dVN6anNiVXFkZEtldUVRTVVyZWE3OGpw?=
 =?utf-8?B?VWw0dndhMmE4VFlsK0Z3K0UyN3d4cXM4Umx5c282YzVTQWpGZG54VjR6NGtx?=
 =?utf-8?B?NFd4dGlraHFzNksycC80SkJyN2NXdGVvWit2cCtSNDMwWm5nOEVUbEh1QnF5?=
 =?utf-8?B?VUhtWG1ZbzRnS3V2a1BJRmZ1bzlNcUdjNW5wUzhxVjA0eGp0QmcrVlZUVjJ1?=
 =?utf-8?B?ZGJpS3FlYTVpYldoNjJyWUZyK2hsa2R4WkFtQU1vZzlNaXBqN2piZG5yQkk5?=
 =?utf-8?B?dGFlaUlOcktDOW5lbEdYSmkrSzJ3YjA0cEJIcmlTUmg5ZjFjVmd3c0EybXRL?=
 =?utf-8?B?bkJjYTlERVFaTkc0RDlSaVRablJ6MkRpY2lsOU9qTGFhcVZ3dUxQaVJ0OVYv?=
 =?utf-8?B?NVRCQVhqZnYrRStmUTErMENWWURCZTRhYWtKZlBCSGZ4QXlGQnZxelFWTmVN?=
 =?utf-8?B?NDU0NDVjQjdBY2Z5aCswNlg5WEttT204SkM1b1VXK2VITitoU0NYeHVObGFq?=
 =?utf-8?B?V1dOMEZWVVRXclJZSFpXYWJQMm5vbG9vZDFGM0RUTHV4bXpBSVJkVlp6Wjdi?=
 =?utf-8?B?blozeS8yd1NaZGo1SlB2NHVVSDVFb1lzbEpOTWNDcGxCQWZQZS90N1d2WEZI?=
 =?utf-8?B?a083N050UE1EeTkzTUh1QzFiSmsrd3dQTzUrUFJEbmd1RXdTRyt3RkRwSUdi?=
 =?utf-8?B?dzMvaENmNHVjWWpERnZIbGZ5RFZ3SGFzUHN0Nk11WU0vZUQycm1lYkZmczdM?=
 =?utf-8?B?K0NaSVJmeWVQb29VSjFlQnBOU2pnY0JCbFEvZVhHZCtObENkMXEzV1FhTmc5?=
 =?utf-8?B?em4reGlzOHBNeWMzTHB1N2RiSEpJbkVwaEFQMHBGRGk1dXlMbk1pMENaa1RD?=
 =?utf-8?B?WE1NTVZlU0NIRmVRUzEycDVjSFJRNHFJREU1bkl1b0JDTkozTm1yY2ErZFpt?=
 =?utf-8?B?emlIWTRsYmx1UTFVUE1nUTFGMFE2MlZnZDdheExCTE8vVjh5THUyWTJxa1NN?=
 =?utf-8?B?VHVHekNqTGY2WHQ0dlZHaEZEeGQrMDViMUdKTENvMzgydXNibERtRVNqVWhr?=
 =?utf-8?B?ZnllVFFZUFpGcXgxRWE1R2p3NWVmU2xrZjRINEZlUk5HSEtrb2FYVmtRNWwz?=
 =?utf-8?B?dkdMMFRxSEREcWF1QWo3aGwxSmZHZW5pbnJKYyt1RGpiSUY0V0tESThoSURS?=
 =?utf-8?B?Q05nMlY0WmlGSE43amtyL1J2UnpoNHpia3piZkdMODRlSlRscDJ1bE8xelli?=
 =?utf-8?B?THVSbHNCQXVsQmRlbEY0UmdadVFXcDNWR2ZkZDFzaTMvQzJ6TW51Ti9aV0lR?=
 =?utf-8?B?eldBaFNGTGx2ZHNrUjhEZlRRVk1jb0xTR2RHdldFL0xyYlVSTXVicmFUVThx?=
 =?utf-8?Q?YZ0ON2BRaitYj7rPUmQTnAlG6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e87fe46-0670-4c96-8cfa-08db19234ec4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 00:32:44.1453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXwRjuQ+oH+EqclC4otZVI8lumYwbFtKmZKVxEBv39rAdEwOwuVG2acU/zqSan2UL5FDnqytaGJUuBPPeOLuiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7696
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shakeel,

On 2/28/2023 12:50 AM, Shakeel Butt wrote:
> On Sun, Feb 26, 2023 at 10:35 PM Yin, Fengwei <fengwei.yin@intel.com> wrote:
>>
>> Hi Andrew, Shakeel,
>>
>> On Tue, 2023-01-31 at 10:26 -0800, Shakeel Butt wrote:
>>> +per-cpu memory maintainers for FYI.
>>>
>>> Thread started at
>>> https://lore.kernel.org/linux-mm/202301301057.e55dad5b-oliver.sang@intel.com/
>>>
>>> On Mon, Jan 30, 2023 at 9:57 PM Shakeel Butt <shakeelb@google.com>
>>> wrote:
>>>>
>>> [...]
>>>>>
>>>>> We could cut down the number of calls to pcpu_alloc() by a factor
>>>>> of 4
>>>>> by having a pcpu_alloc_bulk() that would allocate all four RSS
>>>>> counters
>>>>> at once.
>>>>>
>>>>> Just throwing out ideas ...
>>>>
>>>> Thanks, I will take a stab at pcpu_alloc_bulk() and will share the
>>>> result tomorrow.
>>>>
>>>
>>> OK, not a one day effort.
>>>
>>> Andrew, which option do you prefer?
>>>
>>> 1. Keep the patches as the test workload (fork ping pong) is not a
>>> representative of real world workload and work on improving
>>> pcpu_alloc() for 6.4+.
>>>
>>> 2. Revert the patches for now, improve pcpu_alloc() and re-introduce
>>> the patches once we confirm that fork-ping-pong is not regressed
>>> anymore.
>> This performance regression still can be reproduced on latest master
>> branch. So we took option1 here. Right? Thanks.
>>
> 
> Yes unless some real workload reports regression.
Thanks for the confirmation.

Regards
Yin, Fengwei

> 
> Shakeel
