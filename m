Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3A27059A6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 23:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjEPVgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 17:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjEPVgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 17:36:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7D072AA
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684272945; x=1715808945;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G3MT8wBLRCbOzhezxQdMlRPGPpXpHvCcJPX5GJY5YXs=;
  b=esoVhI2DxCNUpCHojvXKM8yp7pTgXE66HFy9kLc2MgX4C/bYJXn9fm+j
   gogQzcFSJ2bI/fEQB1jKXNGZABuJgCM/ZM6m9MVNkFFXMyuSj0LfxHV35
   jXs8eFTsYT5oMaKTXCB60t1ULp7LBNewFZGzjrIWccJ2rItJ0g4a0BUdk
   wobhH8ri0Y9mvUfpQGH6QPWwO/b4okkjHO2j3XRp00jPMQ/UhIZYlcoD2
   IcWmvOjetolnzUy32PbtJuBgi10YV5Yt+wJq2TIOTQGVbzcwQV06GtcZR
   XfK1snONbVR+2AI+3aBJMlqDzMTFo/jRvbkIjNQLVjsdE1QWyL+KJ+0tK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="353884524"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="353884524"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 14:35:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="875799149"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="875799149"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 16 May 2023 14:35:44 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 14:35:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 14:35:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 16 May 2023 14:35:44 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 16 May 2023 14:35:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ceumJ9/52pO0y5ffKQ652rtc5ce5I+BVpTePtPMdbKgxN0ILzFde9dpibf7xfHCYVVtHEQzaM+iZ4nyZEnzndjZfmY8jbUowc5PLaqJ9wkak+NzoB0DITlU2LwHlSvIacT3PdAAFaIJeA2kS+Pl8GgtISaaxyWe0tn5PHLkNYIwV3kleQP2kMOqGYahEa4P4Dx1rx9Hjp54JS5lpEB+N3zWBmtEeDfg9y6IXqjvenwhOlrtDHrv18jjiqPSWttUo1nc8WvMXH9lq7ZjASulGk4X31MediVF0YwBNt7nT7LpMgNw1eibfrYDhUkGmEgxjTpVme2yBW/NTnxSUK3zd7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VKSvNpajtC7Yzhz1qhVFbVxWQ53PQMiduc8SXSjZ5g4=;
 b=EQ471bCDo7O/LxG2IBghzEPC6mcaJwlJulrUQNeKimb0HLCII7FVoQd46O9z030Rm12Z7/hGRiK5ZpKQIDlEu8bYqkXm84hNM74xVQQSHvvWbFZNXtNO3C2FRWPbWkBIGJ4mDL/VIElpFEL3VLvntRBRabesO0U/B+CxvWwh9uGOmVYjoM2KDSf/Mh7jWG88kfxCiNI1eea2UTuQH0cnFSqoJIzQW0gyzbfJS83xIxB0xX0hceEGsWtqx9ppXScoRU07rVRgS6xh5ggfx0V3bFtx8kaHI71mVBDMWeGG71z83YvvkL1djXyLLY5ypn09LRZJ8WL8KDUBCmS4WSv0cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by BY1PR11MB8007.namprd11.prod.outlook.com (2603:10b6:a03:525::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 21:35:41 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::bad1:92a2:fa0a:1850]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::bad1:92a2:fa0a:1850%6]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 21:35:41 +0000
Message-ID: <6ab71997-8533-1828-7c62-717e2821f147@intel.com>
Date:   Tue, 16 May 2023 14:35:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] x86: fpu: Keep xfd_state always in sync with
 MSR_IA32_XFD
To:     Adamos Ttofari <attofari@amazon.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Kyle Huey <me@kylehuey.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        <linux-kernel@vger.kernel.org>
References: <20230511152818.13839-1-attofari@amazon.de>
 <20230512113900.56393-1-attofari@amazon.de>
Content-Language: en-US
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20230512113900.56393-1-attofari@amazon.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0161.namprd05.prod.outlook.com
 (2603:10b6:a03:339::16) To PH0PR11MB4855.namprd11.prod.outlook.com
 (2603:10b6:510:41::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_|BY1PR11MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: b5a6340d-98ff-42f7-b61a-08db56557ef2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m7/tV6Y4CAl6q/oaxX95ONmvkDTgud1zjlej1dzTP9gmGH/mLqnIWo4Qq6UKB5jTWRVKyzu4HhJjRv+eCQiE7GZma3r5lsHjP6Dov6w37g8ux1Tc+9tg3gC2DVpW+xhKnc6evfQIssyCk+vqpG1pPfZJ8xOOpdOOsPo6ikym0QN8QP5tw8yOTTxRUODS+5P0WKyyZG4FWjUz2LWQ0jcolMzMaGuI1nXI3oJsKqtIFxvYQwQOJimUJ9i4wP0NtJ8+Z8CDNHqGanIut6cHf4zU0nuEOC2GpRF6iJrEq7/BkmhEgh7KM+FT1QusgdYTVQroy9WUd9zVW/XQGNCaEKOiLf+PUAERba+wMXGEqBYiDbWA4Ql/yqmKSuceuBclLmpHr7lUAejMTxPxKDXvsjAhqLyUNivnkkA+DCYSunxI1ABAnxUOuFf3G1g1TOsxWWBJBZxejjqHk4msz/LhKcw0IpSxkSRw7YB1HgBA18p/Dku0/0U/vSH7YrAF9/U5HfGXMThlD1mpPr0dSzvpOV7XquH84Wf54uPA3a4q+5C6XSK0yB4hl0vbveyeV53vzTHzmT2QP7K+4+iYKT8a+Wk2AWCs2LC+0iAOrsCuU3zR9FGI2aajQ9LXgKQ8IRz/LwcxG5yiJiR2BrbPdJRy0UtReA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199021)(5660300002)(316002)(8936002)(8676002)(4326008)(66476007)(6916009)(66946007)(66556008)(31686004)(7416002)(2906002)(54906003)(41300700001)(478600001)(83380400001)(6486002)(6666004)(2616005)(6512007)(53546011)(6506007)(26005)(38100700002)(36756003)(86362001)(186003)(82960400001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmNlV2hYNng2Q0RPTExrbG0vcEpYNVFJVWJyYmgrWnRKRHVpS254eWdaKzdS?=
 =?utf-8?B?UWRPYzVLV3FQSmIvd2pxUy9qM3lWbTYvTExuMW91WW1ReVhoTkVnQWZ2RC9o?=
 =?utf-8?B?a0hVSG9nNGlqU1NEUkV0dVRscVNrSEFMQ3dvQVNWSGRScStoRzVrc0UxbGU5?=
 =?utf-8?B?bklKU2lwckpnN2dXOEowZmFmUUdlaHpMOWg2bFAycGFsemJQdnNWWUZ1cDI2?=
 =?utf-8?B?b1ZpcFhMenFZL05wbWFFNSs3NEdVS1dMc0RiYVpEYU1XbndldG9lUlJyOUxL?=
 =?utf-8?B?bDNaVXF5SkdEWUx4QmRIOGlieWxwczlyMkUzUXErbXZocjVSM2Z2WWRGVU5E?=
 =?utf-8?B?Q1ZiTWdSTDRPeHVyK1lmcXhyY0k5OUpBczY1ZWp3R2tCdmZKTHZGcEw4d1Zp?=
 =?utf-8?B?NGszVGFYeFRHa3BPMlowMHV5SFNpWHR5U1R2MkRlN0JVUC9hZFhTbkpPMVFY?=
 =?utf-8?B?R1l0UDQyMmQxc0p1VFRrVWltQWIwbzRBbDF3U3ZhazFtdkpTY2JFaHA4amhk?=
 =?utf-8?B?SFdTR2lyaTB5NkNET091djhTSzRxWGhneTE5YjcxMEU3TGxFU0h4bENTTWxh?=
 =?utf-8?B?ZTVuNXBOWmpnMWdhczNlQ1ZQWE1QZGNDSlk5RG5TeGNva29aRzVDL0xJdjg0?=
 =?utf-8?B?Q2l3Ykc0VktUSXFtc3RZZXJrY2RtbEc4NVJxZEZMQWNsSU9GSDlvY3Awa0Ir?=
 =?utf-8?B?V1llSmlUVkEzQnE2NVcyTTZxcFVWWUljVnRtb01nemJpN1AzU0RaMUlkYnNX?=
 =?utf-8?B?Y09EanNjUkxsNUxWRFMyc2ZpQU5jMXhmajRleE8zbGcvemEzUGM2eHEwTEZO?=
 =?utf-8?B?aEdyS3h2QWZsSUhZN3Z4QWc4QlE1T3pDc2ZxQXJ1bFVqRXUvZThvR1AwT3BL?=
 =?utf-8?B?ajJGUU5ETmVTbjFLcUtUL3RvVUtiVTk5di82OGxxckpDQTBkWkx1V3N5WFlk?=
 =?utf-8?B?TzJ6dEROTGNIVGQ3ZHpyZzgvN2lNOWdxQS9MeU51QjdicWdkOHU2Rm9Cam84?=
 =?utf-8?B?Y2swN042V1Ftc1dyNHZDWHBVbWNYMlgrRjRsS3lXOVd6Y0I3enA4Y1Jldm9E?=
 =?utf-8?B?R1Fna01TSjdKZkQxVGp0R2QwaEtRRjJEcWhoWVdDTFk2Y1MwM2FIMDhBeVFK?=
 =?utf-8?B?Q2hRYnhVOEIyQnQ2NFJqRGRmRmRaM2hwMTFBbFFhb2JyeFZsemRyR3RrOE0y?=
 =?utf-8?B?U3VNTndaL0htbUhqSjJHVW9TQTVRYm1qc29VTER0bDQ2YU5hdjlaQUliaEJz?=
 =?utf-8?B?VTFnRlJKeWlmRmxwU3A0dDR4cjNrUU1jMjNWSHk1MDNYYVF0dFdkYk9rMDll?=
 =?utf-8?B?WUp6c3gzWW1SK3phdVpQVTJmQzhvZWtlU3pjbWxtZndLYVR0SW9EZmdNVE1p?=
 =?utf-8?B?NXo3MGM5V0ZxNW5JV0RRdmFlaEMxaVg3dTNPajNrOVJvV0huMjhJYlNaemp3?=
 =?utf-8?B?Q28vK1BrQ0ZROTVmSDhaRjAyTkMwNUl0WlJxc2Q2bHFTNUxPNTRINVBnbXZy?=
 =?utf-8?B?cmxLbVU0MUtQQU0zSUVwY3c4R2VUTmlPUFpta2NQQ2pPai9DSXZoU2wzR3li?=
 =?utf-8?B?VGZpTUgzRmFvbnNxMml0Mm15dHFOT2ZKSmxIWmF5RmlLWHpBWXRnWWlseFZP?=
 =?utf-8?B?VFQwdXYrb0l6YkNTKyt2NDc0YW1CbWgwMnZlZytNVlVkQ3A2ZG12ekNkU2ZS?=
 =?utf-8?B?K3NSS0xjSDhkNmFUL0pTRkJ5d2RGZ2thR1BhNGVKVERnOTdyOHErTlh1N0JR?=
 =?utf-8?B?cU5vTzVEcHJBbFlaWXZML2JKRGtCTkx0NGVFaExkeDRLN0NJMFhkcm4vN0FD?=
 =?utf-8?B?MkJheGpReUZFbTh1dTQ4UHVJc2ZKZXpmL1ZTZXJNd1lNNEhTK05aQXdUb3Fu?=
 =?utf-8?B?S1cvRG81Unc5Q1RUcTRScXY3dTBHbjdEMkZsazMrc3lpVXhuWnBVYVZCVlBr?=
 =?utf-8?B?U3VnY1ZzVjNoTXh6RVdvdE5leDRLaVd6WFZsTEhSelYzWjBmcjhEdDBJSm1G?=
 =?utf-8?B?MlhrQTliNnVPRmFSTG83RWMxMCs2eVdSVk5temdBMVl2cHpGRWNJcmNuTGp4?=
 =?utf-8?B?MmswWVMyTXRKRUNzSSs5WldyYUNXMnU5UkV1N01PRktvY3pHb2RWaXJuKzdp?=
 =?utf-8?B?dWZTbHVKZ2pycTVoLzFhY0tDL3Q4b0JucDByOFNGWFJFblI2RmFIcExueGFa?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a6340d-98ff-42f7-b61a-08db56557ef2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 21:35:40.7090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vRvOcCEk+UKTvoyMCNxZCC9GI0CAR5ebfyeYgmigi3b7ULfGoBNKcWY3T8IH8tr6abmDcKcKu9AvvqjhrVwwl0zD9aHHW2VXzDtSDavm0D0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8007
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/2023 4:38 AM, Adamos Ttofari wrote:
> Commit 672365477ae8 ("x86/fpu: Update XFD state where required") and
> commit 8bf26758ca96 ("x86/fpu: Add XFD state to fpstate") introduced a
> per CPU variable xfd_state to keep the MSR_IA32_XFD value cached. In
> order to avoid unnecessary writes to the MSR.
> 
> On CPU hotplug MSR_IA32_XFD is reset to the init_fpstate.xfd, which
> wipes out any stale state. But the per CPU cached xfd value is not
> reset, which brings them out of sync.
> 
> As a consequence a subsequent xfd_update_state() might fail to update
> the MSR which in turn can result in XRSTOR raising a #NM in kernel
> space, which crashes the kernel.

I have drafted this to reproduce and test the issue in the amx selftest:

diff --git a/tools/testing/selftests/x86/amx.c 
b/tools/testing/selftests/x86/amx.c
index d884fd69dd51..c773de1f3864 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -767,15 +767,15 @@ static int create_threads(int num, struct 
futex_info *finfo)
         return 0;
  }

-static void affinitize_cpu0(void)
+static inline void affinitize_cpu(int cpu)
  {
         cpu_set_t cpuset;

         CPU_ZERO(&cpuset);
-       CPU_SET(0, &cpuset);
+       CPU_SET(cpu, &cpuset);

         if (sched_setaffinity(0, sizeof(cpuset), &cpuset) != 0)
-               fatal_error("sched_setaffinity to CPU 0");
+               fatal_error("sched_setaffinity to CPU %d", cpu);
  }

  static void test_context_switch(void)
@@ -784,7 +784,7 @@ static void test_context_switch(void)
         int i;

         /* Affinitize to one CPU to force context switches */
-       affinitize_cpu0();
+       affinitize_cpu(0);

         req_xtiledata_perm();

@@ -926,6 +926,120 @@ static void test_ptrace(void)
                 err(1, "ptrace test");
  }

+/* CPU Hotplug test */
+
+#define STRING_BUF_LEN 1024
+
+void __hotplug_cpu(int online, int cpu)
+{
+       char buf[STRING_BUF_LEN] = {};
+       int ret = 0;
+
+       strncat(buf, "echo ", STRING_BUF_LEN - strlen(buf));
+       snprintf(buf + strlen(buf), STRING_BUF_LEN - strlen(buf), "%d", 
online);
+       strncat(buf, " > /sys/devices/system/cpu/cpu", STRING_BUF_LEN - 
strlen(buf));
+       snprintf(buf + strlen(buf), STRING_BUF_LEN - strlen(buf), "%d", 
cpu);
+       strncat(buf, "/online", STRING_BUF_LEN - strlen(buf));
+
+       ret = system(buf);
+       if (ret)
+               err(1, "%s\n", buf);
+}
+
+void offline_cpu(int cpu)
+{
+       __hotplug_cpu(0, cpu);
+}
+
+void online_cpu(int cpu)
+{
+       __hotplug_cpu(1, cpu);
+}
+
+static jmp_buf jmpbuf;
+
+static void handle_sigsegv(int sig, siginfo_t *si, void *ctx_void)
+{
+       siglongjmp(jmpbuf, 1);
+}
+
+#define RETRY 5
+
+/*
+ * Sanity checks the hotplug CPU for its (re-)initialization.
+ *
+ * An AMX thread is created on a CPU while the other one went offline.
+ * Then, plug the offline CPU, and migrate the thread. Repeat this
+ * on/off switches multiple times to ensure no inconsistent failure.
+ * If something goes wrong, the thread gets a signal or is just
+ * killed.
+ */
+void *switch_cpus(void *arg)
+{
+       unsigned int altstack_size = getauxval(AT_MINSIGSTKSZ) + SIGSTKSZ;
+       int *result = (int *)arg;
+       void *altstack;
+       int i = 0;
+
+       altstack = alloc_altstack(altstack_size);
+       setup_altstack(altstack, altstack_size, SUCCESS_EXPECTED);
+
+       affinitize_cpu(0);
+       offline_cpu(1);
+       load_rand_tiledata(stashed_xsave);
+
+       sethandler(SIGSEGV, handle_sigsegv, SA_ONSTACK);
+       for (i = 0;i < RETRY;i++) {
+               if (i > 0) {
+                       affinitize_cpu(0);
+                       offline_cpu(1);
+               }
+               if (sigsetjmp(jmpbuf, 1) == 0) {
+                       online_cpu(1);
+                       affinitize_cpu(1);
+               } else {
+                       *result = 1;
+                       goto out;
+               }
+       }
+       *result = 0;
+out:
+       clearhandler(SIGSEGV);
+       return result;
+}
+
+void test_cpuhp(void)
+{
+       int max_cpu_num = sysconf(_SC_NPROCESSORS_ONLN) - 1;
+       void *thread_retval;
+       pthread_t thread;
+       int result, rc;
+
+       if (!max_cpu_num) {
+               printf("[SKIP]\tThe running system do not have any spare 
CPU for the hotplug\n");
+               return;
+       }
+
+       printf("[RUN]\tTest AMX state use with CPU hotplug\n");
+
+       if (pthread_create(&thread, NULL, switch_cpus, &result))
+               fatal_error("pthread_creat()\n");
+
+       rc = pthread_join(thread, &thread_retval);
+
+       if (rc)
+               fatal_error("pthread_join()\n");
+
+       /*
+        * Either an invalid retval or a failed result indicates
+        * the test failure.
+        */
+       if (thread_retval != &result || result != 0)
+               printf("[FAIL]\tThe AMX thread had an issue with the CPU 
hotplug.\n");
+       else
+               printf("[OK]\tThe AMX thread has no issue with the CPU 
hotplug.\n");
+}
+
  int main(void)
  {
         /* Check hardware availability at first */
@@ -948,6 +1062,8 @@ int main(void)

         test_ptrace();

+       test_cpuhp();
+
         clearhandler(SIGILL);
         free_stashed_xsave();

Thanks,
Chang

