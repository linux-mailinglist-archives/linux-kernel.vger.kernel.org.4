Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED94367F7F8
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 14:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbjA1NUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 08:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjA1NU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 08:20:29 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2285623C5A
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 05:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674912028; x=1706448028;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hLjGrCk0nJqf5AGzhjKN7UBZ/+yfumPhWxJN5y7kowE=;
  b=EF4rRTmcLt4wE24SHXwYoJBlIIZoncnvnULYz+iQ7aoBO8P/tLM4NvYz
   K0+pmWWVQ17pvR7+lso2CzdPXGS4Fkp875oyyalqGqyIhOofwYDkM9ovI
   17gLE62y2eKhF0emM2riXQ8EqltGrboEg4lhO8aiFF1F1INYnL8MWDFUU
   r24OqsNKi6imBxh6vuXNBj3Vu3KEwh+FXjO7w1+pxmkPIyw4BNPx8R82C
   +GxS7xA6lI5e3aSDclMlg5VMvwxUKOLG+k65VtcCEM7EhdtF+K4zLQezy
   QT9VcLEjBhZoUMQd4fob71xu1dS+mE4+a6opZ+a6Utd5CcFIlc7lb6jb6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="315244192"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="315244192"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 05:20:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10604"; a="656931550"
X-IronPort-AV: E=Sophos;i="5.97,254,1669104000"; 
   d="scan'208";a="656931550"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 28 Jan 2023 05:20:27 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 28 Jan 2023 05:20:27 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 28 Jan 2023 05:20:26 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 28 Jan 2023 05:20:26 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 28 Jan 2023 05:20:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnZXtPH3Y2jRgza+AWE6E/ZV5EXDPtoxhKuM4BHRlBn2d0NlQw+pNOwKgQRhPGsmpQ18e6+eoyaxpRs57uXEk7k/bT7mHNYM2Rr254Fy9SIfeVqi6NBDPEVn1JRHWgxAMuXe/9r8icjgNGEBapXg22N/9XFrg9RfE9FuKILEtif5G2vljpKYfoJ6/v3VVBqEuy3d5pnyD3BD+KODxz7A9tV2VQxNVrIAqnIsWWpxzNae23M/t1tlJLYgWyfctn5+ZUURp/7crflQmdz4Xgvs5uVr9s3isbLzWUQ6nqS0Bbv3ufqdJlXb3X5uwxWNvZERGBkpXLwixla+pRdKoFnpng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iufgfUMj2tKpEtFHJKaAjVKdPOnNifewzQ8iCEc3ehw=;
 b=iAYfcwoPRO5n2KWZBM2rm13DTqEdgEbW6GJjNzoaq01zqzOSFgrQV8IgAKtecgr2wy7GAKKr+b8ucxVozlTJ0QyNmhGumOOpdKvRJMDI+aedguFf86fLbwtPelNBPd7gEuj8ATBQ/bm7zJKTvuixMy85Q45bCAGQXTj7aS5RJNXVbpqlW+FW36gdoLVbfYQ8vyYoYXevY3ma8vQTHe5qnmIZUkwTX7q/MSeI0ms0cuaLhFqFtjS4BXS6hsSnb72pEAs6qhaUTh6MK3eYf0dopCBQUz4z5Hc+MZj0ExZqO/oQHP393l+gHLPmT7fwRPhZUraTxJd137d+Q19U2VGMeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH0PR11MB5207.namprd11.prod.outlook.com (2603:10b6:510:32::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.30; Sat, 28 Jan
 2023 13:20:24 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::1531:707:dec4:68b4]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::1531:707:dec4:68b4%3]) with mapi id 15.20.6043.030; Sat, 28 Jan 2023
 13:20:24 +0000
Message-ID: <560a0204-5f4e-07af-61be-26e949fe6f20@intel.com>
Date:   Sat, 28 Jan 2023 21:20:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH mm-unstable v2 1/6] mm: Add folio_estimated_mapcount()
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Vishal Moola <vishal.moola@gmail.com>
CC:     <linux-mm@kvack.org>, <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
References: <20230124012210.13963-1-vishal.moola@gmail.com>
 <20230124012210.13963-2-vishal.moola@gmail.com>
 <477bbc1e-a60a-cfce-d31e-0b4bdd5f6429@redhat.com>
 <526e5156-6c4b-9f2c-1637-2f83c1dfea1e@redhat.com>
 <53d86764-d155-8d97-1a4d-7e701848c950@redhat.com>
 <CAOzc2pyV9-wq04NRKVE1vRj7PnRF7g+jSFFj-oKYuZk-t9smBA@mail.gmail.com>
 <52af321f-175b-9fa9-10f0-ac2bba04c677@redhat.com>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <52af321f-175b-9fa9-10f0-ac2bba04c677@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0157.apcprd04.prod.outlook.com (2603:1096:4::19)
 To CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH0PR11MB5207:EE_
X-MS-Office365-Filtering-Correlation-Id: 540c1f03-2e28-4bf3-36d4-08db013269d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jvJGsCzr9RqlY78VpGNViHbpRx+Ik96NuxL2BuUB/bb/cvxpL/pSu8Cr1qaAI83tHTUY+9EimyUzkZPNzFLRR/1a7CuWUm5+0BJcalJDByh9JvX1R2lkBm03CdSpGmRXMNPlaVQc0oBvvHFiHwVpHO8wLyGkeDSJkm8F0LSMr1mtb6RvTR5UkK4WFcbFUeuGpyZwmgzd709wxeHbSPcRSW29k/FNaVPsxEbQMCZqLLqHbLKlE6Jl3/Nw0KOvXjRBYAJiqYoZHAWLg/YRPRMkrarccrHerit6K35Wgr5ZgkIl2+BlrBo2Zr0q6o6qhjNt4y4TIOD2coLvxkZo7uWXrnLMHf7SPXKnN7VnwqHFWHUXDrsi47E7gNd3VV3NL1f4pawjG0tFOlT41x64VUoNXrCFI5TnWb+SxJl9oDNPiuZq0Efuk/O2+bKgSMlNGZ16aIhunmG/5TDK7SYe3rVj2r7QVBoy11TNwny5H9QWajE18t9W7ckUvhpIbNshHhKbzOaSjVSA1OW4ONsnt7iPhtzf0djRm67A/X1TTfuPm08IzZJAWVWcfWzX3tAzz/86Z0oEp5+mhQEiQIjbPGIKveap4+WGNtJLWNJjnTC2adIqvg31U7J1fUw9i4fyi77T9KD3ePSQn0hPeU4tMk0IAX8Gl7ozGu2w1cV35mpNfZxzv19r1BKEYV5kNYHKguZSr6yFxaPfQ9ubbVNd7aoAANMpiZuNJSabOI+ND/mFnV0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(376002)(346002)(39860400002)(366004)(451199018)(4326008)(66946007)(66556008)(66476007)(41300700001)(83380400001)(8936002)(8676002)(31686004)(6506007)(36756003)(53546011)(82960400001)(2616005)(316002)(5660300002)(110136005)(31696002)(26005)(6512007)(6486002)(186003)(4744005)(86362001)(2906002)(38100700002)(478600001)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1I5WlJ6WUhwZWJmVE1iWXNDN29CVnBzaEpnd29KNEMySXBxc01rUnFOSkFO?=
 =?utf-8?B?MGcrTmtaUkVQMTJkaTB3dFkyUW9QYXN5dkdoNHN5akY0YXVOU29vQlovRlZV?=
 =?utf-8?B?MTZSL1owOGh1b3RFTTBOajd0VjNNZDNUWXZCRmpiNWY2KytDSnZsQk9BWVMv?=
 =?utf-8?B?UG9BbHNjRjhYdkhBbysvWlhWL1BwTFkxYmRHSXZsZmc5UjZncUJMaDc0RUl2?=
 =?utf-8?B?YWhPYnQvSGJnbHhndjRGZVJ4MFdackNnTlhrL1V1aDd4MFhoeVhhUjlxSkoy?=
 =?utf-8?B?TzI2YitXcGFucExUMzh0eHBqMWhDdi9VajZ5M0lhazU1WTMxS3IwQmU2RGhh?=
 =?utf-8?B?UVFmM2dHM2kyVTluK0J6bmZ3SFhlRTZ3RWt5OUc1MjJGSXRtanhyTnR0SzE2?=
 =?utf-8?B?anMvOUdnZ3h0VWFJTmFoTlgzcVpjSWNyTitNT3pkK3JGRE9hdlg1aVhaS2Zo?=
 =?utf-8?B?Qks4MExnSWVodDlJc3dsTGU2RWdWaW91ZUpsV3J0Wnlpc1ZOUnF3UlhEcnNV?=
 =?utf-8?B?dCt5YjVJVktSQzZrR3RNOXZzYkNLS0tObGE3UFRabmMxcWRtWGRzUzdob0ZZ?=
 =?utf-8?B?RmNqNGNLdWlUVlZybmE5NVNXeGxyRU00Ull4S2RpSXVkTUZvcFUzai9paFQ2?=
 =?utf-8?B?RVh4TUZRR3VleThRR2IveXdITTV4cGF1ZkNEb3UzK3hOdnRjL2k2bnZlLy84?=
 =?utf-8?B?eVhnZDJMWXdmNnBEbFBxa1cxVkhFdjBqS293YXNjN21qcDZjVk5LaHhQZGVX?=
 =?utf-8?B?NWdtbTRkdUYrYVhWbE95cm44TkFlT2xSMFp6bXdVbC91YzJ6QXNkYmZRbk9R?=
 =?utf-8?B?YlF3LzFQSGhmZElBWWdTZExReE9xYkNmdVA3U0Q0QUtWUEZTbzJCWGtHdFQz?=
 =?utf-8?B?bFc4WkNnbWJPY0JwcDhlZ244V01xRDVuSE0xVHJKQTB6bVpzRUszUGRVRXlU?=
 =?utf-8?B?SWUrZEhBSzN2WXlvcFhUcXVCM0RuaEpjSmVMNFB3blRFaEpqNFQrSWJlOThX?=
 =?utf-8?B?dWZqMitZb2w5VSttV1dpOUw1d1UxYzVoZEZHMXlEVzNIb091aTQwY1pwOEZT?=
 =?utf-8?B?SjFJQlpZQnZuZkx5cHY2WGJOcVdRV0xmdEp1MSttcTREbUh3c2RickV5Umd5?=
 =?utf-8?B?TVJrM2p6ZGNveko4ZUVBVWVuOUk4eU9sQmtvTHlqbmU4dnB6UlEwdDduNkpv?=
 =?utf-8?B?ZWFRNnB6Y2VGMVZKWm5xemVKejNkOFdDQjEvWUNsWVFjVHZmT1NGSm42bDd5?=
 =?utf-8?B?LzV6TUhwdCs4VU14Qy9kWjVpUmlWNHM4MDFmZ0VRVjRlS2ZnYjRvMU9saDJB?=
 =?utf-8?B?ZEhlamtTYUwycGlXcXhhVVcyYzlaZkFhb0ord0l1WkswYWtJUTFZd1Z0RE80?=
 =?utf-8?B?RFdQS2QzSlA0SWRlcjlZMHc4bTJSSjduL25EdlpmTnhveDhkdllydWpNSEVv?=
 =?utf-8?B?RWpkN3FzTUdkdFFKeGM1ZkZGZmdBeW5SamM1My9oWEc5TGh1ejBOV2RMQ2c0?=
 =?utf-8?B?RjZwKzVMaVdKOWdYa1JHeTRyUlloWmY2M1UzWlFVeEowakE3dDB0OEVoV1M5?=
 =?utf-8?B?cFF1T1RMM3RXZlN5QVVWYm9JTGNNK3hHbUh5cjI0NHJoVFU3dG1qRjdWMlcz?=
 =?utf-8?B?NjBReC9iSGFTZW5JZURoN3JaVW42ZDBEbWtrNnk1R0FWa0JDYjBUeHdvaEI3?=
 =?utf-8?B?anFuUlZjUStsaUNlYW5oeXVwaVVpWXRzQmwwYXppbnNOZi9VVTU1c0lSNGNj?=
 =?utf-8?B?MmVPMTNKbWRpOVpFS0wyU25BQWIrcVNaZkR1VTZEeTN0YjNDZng2N2pmNnVo?=
 =?utf-8?B?RkZMLzFTK2l5Nks0Ni84cUlvRm15RDhxRGFRbDJ1WUtOUkxmYk9NRitRSmkz?=
 =?utf-8?B?TzFKR0QxcGZqZUlEanp0cUx2TjdFVU8zaUtiY2VGV0gzSlR0anJpL1JSaEtp?=
 =?utf-8?B?VTNiNmlFRXd5ZlFvQjVKWHhIS3JuN2xob0grbzAySWRKUGQvMXlWZHFheHRK?=
 =?utf-8?B?YmlzYWo0RnBzZi84NEJNTC9HNlh4MTVOMnY1cG0vOXBud1dRWmc3UVVpNVQ2?=
 =?utf-8?B?djMvOTFwQ2U0RHNDOTF6VCtjYUdlVzdCeWt5WktwQy9QVEo0NlNCdEhHR3lY?=
 =?utf-8?Q?QDR7cQWcjaz6cvUZNmbivGUSB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 540c1f03-2e28-4bf3-36d4-08db013269d4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2023 13:20:24.2470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GtQSmAtkTG+7BxRaMsPERR8lmgUamaM90Itm0QOMvrcqZ+KJaXdAaQIgwbWgwtXSW/oxpbyRshAyVlfjdb5yCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5207
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/2023 4:37 PM, David Hildenbrand wrote:
> Thinking about it, I guess "folio_estimated_sharers()" might be what we actually want to name it. Then you can comment how we estimate sharers by looking at into how many page tables the first subpage is currently mapped, and assume the same holds true for the other subpages. 
Vote for 'folio_estimated_sharers()'. If better method
other than checking mapcount is found in the future, it's
easy to update the implementation without change the API
name.


Regards
Yin, Fengwei


