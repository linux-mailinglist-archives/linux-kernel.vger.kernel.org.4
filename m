Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A1B664EE6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 23:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbjAJWlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 17:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbjAJWld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 17:41:33 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AA9621A8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 14:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673390491; x=1704926491;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=DCoN01pJAPZdPCKsXvlhwArqJ320tZBGwFMnqn+iKXk=;
  b=fWxxhTgaxB8+qV8oyJPkooJA7n/FCKA2NQWBtqsx/W5rbDD+9CHz8seW
   +0mLZsl/Yed3IWnZXe5AQ2D81ThsjGUNY93mVsScw/wSJFUnGDXOz+B8n
   PyV5Ue1ZzAQlADsEPQ5fTDsqrGaArIxsVLd3ep5CqHQKEszj3jgEN5oty
   U0v9p604o7VMtiRFt/tmah/q2aWjLDIIRXW6z2N4qW/NoYYy4g9ABfJf0
   N4/0l+6evezD6iy7eBh8JYecls4pXTVvCQ1VSjKDWBforxDJRGCcshszJ
   voB0xT1qEEgOg5kWRz+07DwhUqMt5ijtit7CNBynnMYf6oBR1H4/KW9p3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="306788345"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="306788345"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 14:41:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="985927670"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="985927670"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 10 Jan 2023 14:41:31 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 14:41:30 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 14:41:30 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 10 Jan 2023 14:41:30 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 10 Jan 2023 14:41:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyJ2xWjcUM9kUqOjXSlwRmuwsPW7dnvSELU/+lDwuT6giGKLXEEqKkvqF5039oDr1ivc6bG/IHkreT/x/zeAJVTSIr0DplfQWKMpqiiit4cUdd+h1kjQD7GCoQUsc0Mlnjg7KompVGxFcWYujNGNKxAmwIGEL8Ijdfmxf14Z4amGta5GQpH1S5C20JY+Bqh6QHZmYTbAmvcHhYO94Pa/TpypakQhmLKtsIFTgrEXlMjcRK2Xl8XhuIdVsQtyNeMxgABakET8pkBjPml0ec7GOu5MflPMZJBET6UDpTECb/0ySj0CjCHkcIEmqP0NRatgE1YnlZUhn8uHnW7kOHIFBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ze3n4OhDed210nlKWvCqZwfkcZ1voYcSZLSI75S1XtY=;
 b=NODdkF8J6/btP8JvonzjRmZzPWldc8lC0CvZU7AbQ3QusGjUaSZXq+/Ws8U2yeUExnaOoK+1GJfqCxjpeU1Jf+DFaLTHDWgjnxhwKBTaN16D81osyMr2LtEG207vqTodGxLPvh+r6qYLeecaB79HrZHrMq+HbN+al0zWwsRUo/1GSK1aIlHIcOkW65myx8kSWT9o2D3GS127TcoA81ajqMmnSRt9pKh9ygCqbBr6B0qKPZr9h7tbFewK6D9eb5b8qljw2OIUuPI3LVOCRDz3EUNIdAtUQ55/9uvTFhr7nKqtMZFlRcHwdQZdqYbSnza3reLbEOmOvxbTbaQk3xEa+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by PH0PR11MB4791.namprd11.prod.outlook.com (2603:10b6:510:43::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 22:41:27 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6566:25b5:89ba:e209]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6566:25b5:89ba:e209%4]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 22:41:27 +0000
Message-ID: <693d8332-3b86-3dcf-fc87-5c3a08a752db@intel.com>
Date:   Tue, 10 Jan 2023 14:41:25 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/7] x86/cpu: Disable kernel LASS when patching kernel
 alternatives
Content-Language: en-US
To:     Yian Chen <yian.chen@intel.com>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Tony Luck" <tony.luck@intel.com>, Paul Lai <paul.c.lai@intel.com>
References: <20230110055204.3227669-1-yian.chen@intel.com>
 <20230110055204.3227669-4-yian.chen@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230110055204.3227669-4-yian.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::22) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|PH0PR11MB4791:EE_
X-MS-Office365-Filtering-Correlation-Id: d9bbba5b-b8a1-4623-53ac-08daf35bcef8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IPrgrpKT7Z4JGTdheO4mWO6A0dIDzsTQ5KMEkShL/fjpZCRaxk3LmiGXWtoHrit94VVgrPis6+ZpBLmrB+iV7vpDaysDdubtQyf3NlDbtt4pO42T5mljwn+Qefz0GTjKFrZG2JDV+IilLroNAGA9o8UcHbM9D2lNfUUDtTVG+9frrCLSZ0pvIS1g8ukvKG1tzhv1WuGPw1Bcq7hHV1bzt4zRkv9f0/b7EMdyCUX6JfYXRiiirEIbmfMolixydixLUZYKZqxlBr6ZXV1oM2+tE2E/5QefFUNEdWBsWj+vNYMo/Wucbz5dR3Tg2j62c1QVqSJiDwYNgcsL9e17fxdfNuVh6DW0NaoFwY+KZtjF/pxcVXf3BhlxDTJCtmuSWXPba+/81do4KLq7MtX9k4BNVG4QWqZYGAl0D53N0m7zIQky+BJ83PEE6RON2LHz14vEI6eJVkHrKMDTc4fElA5Rf4cfIqbOAxGT5AAiqAIJf282YDUbnJbw1tVVqPBG7UDsOfkX0fMuJ1SfrL0KJinYmH8FXeeUWr/BuPCVIUfAI6Wx7v4UrxH5fqN0alQv5J5nai0UNOtckpbcLcm5/FtymFQrsFHJZF1+2RxtMFgOAWRxZNmr9WAup6imcvKUbqsypkcsJHGTbVR24k6O/6/aAqkqX8kqxR6WlzyeIE7jHe0fb8ED0Zx5sk64VqTztLKCFNxHaL6L5QcCjNd77T/5qVceJrQUxRZoPKTWQBtzcWo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(39860400002)(376002)(366004)(396003)(451199015)(66946007)(31686004)(41300700001)(2906002)(44832011)(8936002)(5660300002)(36756003)(4744005)(8676002)(66476007)(6512007)(66556008)(316002)(6636002)(110136005)(478600001)(6506007)(6486002)(53546011)(186003)(26005)(2616005)(31696002)(83380400001)(86362001)(38100700002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFFZdWlLWFN2OXlYb2QvZWo2bDYvNWM4ZFNMSW9ZeXRvUVV2Z0RPYTFYWERy?=
 =?utf-8?B?NVpQZWEzUWRRbnpPNmRhdzVtZFVSbGE4Z2YyVkxQdE51cTNQZnkwTFpvSnMr?=
 =?utf-8?B?QWl4UkhrTGZJTTR5bnpTRUdtS0l4WExkZFJkb3p3Nk02QWpuZ050RkMyQStK?=
 =?utf-8?B?R3hhKytnWVVoc2NoNXJMZmxQb2pSSlZvd2Y4UWRHRGwvejVQdE1HKzVYYWZR?=
 =?utf-8?B?MTQ1MVNLN3kzVk11T0pIM1dqeDh2UjBNUFZad01kSVFLZzVTUEwvOE54ZEpL?=
 =?utf-8?B?TDhtVjZpdXAvOHJoeVFJRkJGNjFLN2tyaDl3WHZZbFpoQnMzUlQzZUk0Y3Br?=
 =?utf-8?B?cGNKQ3kwYWgrWVJxanVVWVdSeWgyOGVWdWRHaGRjemRXU1dHc1RWWmNocDND?=
 =?utf-8?B?NUdubEtScytPMUNZemUrYkV0TGl6S09oSGdmdEJEcHRVbDR5bVZqRDlRTVNZ?=
 =?utf-8?B?akU0MmFadmp1OXRpazh6cWRhbTUxc2Z6MjJzR2tNUkNMM2ZXdUVuWTN5dDRp?=
 =?utf-8?B?eFAwTy9rZW0vK3k5cm42Z1RvaHB0MmU1S2dTWnlpeDZGRG1lN0orK1hMNFRi?=
 =?utf-8?B?M3RPNHNlc1VuYmU2SFdiT2lJcHB1N3l4ZmVJeHlOYjYyUmptNVhlWEtTSWdX?=
 =?utf-8?B?Y3BiMTNQQ3NtRlJwaUU3dUpteUNiakhrUWJiVGxPZzhacDhLQTBKcUsyb1JK?=
 =?utf-8?B?RmxVck1rMVFBRFMrOHMrL2FHazhaNjJnaXJ5bTJyNTRMV1pkazc1VWZvRGVj?=
 =?utf-8?B?eVV3Um91ZS9aZis0THArOGMvZ3lnWGQ1cDViSVo1YmlqdlIvMU4zdGV4SmM4?=
 =?utf-8?B?Uzl0U2FCL29oM20xMFFJUVNWTnJGaitOaXpHaU8xTUFRQjFXQ0VXQllTN080?=
 =?utf-8?B?ZVJQRTJ3bXVmRWx1ckxIby9LdkFTS0Fua0E4cUJjM2hnYlN5V1BIemd6RG1t?=
 =?utf-8?B?UGFBeUZvWHVwMVdpTitlbm1YTmJnZFJZTHFpaXNEQzAzbFJzTDRCdXI4bHJH?=
 =?utf-8?B?Z1ZOMVMraldQd1VwMmtqN1RCSEo2cEJDM25lTFFzNDliaENzQW1hZm1tUTRV?=
 =?utf-8?B?ck8velpQUDh4Mjl5cUc1ekJUR1ZDMytOaHdDdmxXaG1OcDdaZHJIZGZWcUhB?=
 =?utf-8?B?dnl3TDNhSkdZTi9aSjRIcUlFbnZVeEJjdTNCdGlMQkdSMHQvV1ZRTmI1SU9j?=
 =?utf-8?B?SjlUUlV2Y3FNdGhOb0ZTN1NuUGFFMGEvNHppZUF6Q1pHMEIyQzhnZW1TVllu?=
 =?utf-8?B?a0MxNmMzQ3p1STBuN3BaN0pBaXBTMGFGM1VnTkNBVzgzSUtJSkRCdmVkUFVL?=
 =?utf-8?B?cWlKQzdURE1pY3l6SE1ydGxVNTB3NTFRWU5uTTJDV2NMRjhuVzlRMG0yOGls?=
 =?utf-8?B?NHh4ZlI4L2tSd2VWc245eW1iSy9SRmRuT051N1AwelZqVEpoN3J6Y1BYMDhI?=
 =?utf-8?B?bk9vQmdHVUk0SDdlRy9qR2d0ajQ3NkgvbktZK1RSYWpoM0pDc283OWVyQXNh?=
 =?utf-8?B?ZXcwTDdYR0FLOVpqRzcrNitQMTY0ZGdUYmk4clQxYTJIR3ZhdVhuaG1ITXRW?=
 =?utf-8?B?Qm5TZDFNVVZlRC91Si9DSWdJOGFRL21nZW81SDVBaXNqM1NZaDdiRTFqRW9l?=
 =?utf-8?B?Nmhqa0Q1bWMyL29UTDFSNE9DMjBYcXpmUWw2b3BDYWRYVFRZZFJ2MmJlOHFG?=
 =?utf-8?B?YzdrV1ZIcVNpd3dWWit6eFJOWTlpTk5pRHYvbWJIcVMwUHJ5MGRWL0lDdzEw?=
 =?utf-8?B?aXRxZU1KcTNrVi9xaHk1M2h6VW41NXIwUHRFYjNUbzRENHRQcVFDQUJmMUtI?=
 =?utf-8?B?TFdORVVHMUpXU2xWaTIvb1FMT211bTBjWEY0TmFJelQ3WFVPaVRQTnB5U1R3?=
 =?utf-8?B?MnBqTzdTNmpwY1NQUjQ5Qzk4bnN2dTdYNnZ3TlpnNE0yQU52Qk9KclZ6VFBz?=
 =?utf-8?B?NGVFSEYrYldNY25JMUhuMnNIK252dTBuR3Y3TGRaRWdFTXdycm1GODBYMkRE?=
 =?utf-8?B?YkcrTVJLNFVhZVAxWjZTdlN3VHpsamF6c2lXV2k1eWhST1lzeVl5ZnBuZ0xG?=
 =?utf-8?B?V1VHYzNBUjIvSElJRjgvVUovKzhhVnVndFlUdGJxZVNvZzFUMTZpWEh6RkZ0?=
 =?utf-8?Q?mIzY1ab3FAa8PRKWJiR292Vmq?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9bbba5b-b8a1-4623-53ac-08daf35bcef8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 22:41:27.0675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++vIk1uQyxec23eJVx8ylOXsj+tNcI+W9tDwtEajp2+Xwg03mEM7Sg4vS0K1PgRT5D7qLbeXpzgmtSxY/g94KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4791
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/2023 9:52 PM, Yian Chen wrote:

> LASS stops access to a lower half address in kernel,
> and this can be deactivated if AC bit in EFLAGS
> register is set. Hence use stac and clac instructions
> around access to the address to avoid triggering a
> LASS #GP fault.
> 

It seems we are implicitly relying on the on stac() and clac() calls 
that are added for SMAP. Have you tried running with SMAP disabled  i.e 
"clearcpuid=smap"?

I believe there needs to be a dependency between LASS and SMAP.

diff --git a/arch/x86/kernel/cpu/cpuid-deps.c 
b/arch/x86/kernel/cpu/cpuid-deps.c
index d95221117129..00bc7e4a65d2 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -79,6 +79,7 @@ static const struct cpuid_dep cpuid_deps[] = {
  	{ X86_FEATURE_XFD,			X86_FEATURE_XSAVES    },
  	{ X86_FEATURE_XFD,			X86_FEATURE_XGETBV1   },
  	{ X86_FEATURE_AMX_TILE,			X86_FEATURE_XFD       },
+	{ X86_FEATURE_LASS,			X86_FEATURE_SMAP      },
  	{}
  };
