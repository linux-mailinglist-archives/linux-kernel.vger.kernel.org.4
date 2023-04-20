Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9910C6E95EC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjDTNfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjDTNff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:35:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3795A46B2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 06:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681997734; x=1713533734;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=UoGjNr7ZaKklGM85sljqIBRDErM5yxBuRGOcj+SnJZM=;
  b=ddr05JKL06lm1jdIV5ZnsWlUQapSj4oJAyZjWsvg/QvyW2MBEw7Y1o2H
   Ww5gHPKnE57NqNOFvqJokF3Q1Svm3MMFSklT8r62PoUgil0KywCK62lAN
   c1ZC5R9e9zj+BmQq+MAOXoIYUmfchd5Dq/4+iPVmKlXvZL3DyjrIhvJqQ
   2E2WY1eXvfWmxHAiHGTH1FPxkwr4xL8Yggg8CEchz8Bv5niyjxcEcCCOj
   9xpmNefeJLUtsK4bI1qE8ZLicjhtPWofmnRWgA6R2nrORpBpfF7XvOWUW
   C3AS+P9upCwmMQqqBviiFLykZZZmDzTCY1nvm+WJoeobbBndZf6UQy5gK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="329908768"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="329908768"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 06:35:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="781239533"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="781239533"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Apr 2023 06:35:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 06:35:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 20 Apr 2023 06:35:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 20 Apr 2023 06:35:32 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 20 Apr 2023 06:35:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwldOnkO2M5AVR1FekBlPog+d6TmP/n27p2hELVt9NLJmk4nkxNz8u3xcbwFWa9DFhyADBxYATvJVzVXpMpdJjtmzSO9TJt+ZkdF/2ApgO3C4CKR8GjiGT6PksE6XDxqzJS/OqeW36UhwaqoDYdQe7T+JFZ47Efl2briCx0ZJtYx0nNvRFbK57BXbI+/0Gn6R3UsY8tkb14qwsYpelwvBJxZPI3YvYFbAaCULdwGlAdsP1BZeaqecZ/gnPhrDWXMfyi4/T4Q0mhX6Zyr3W1fm7ZOfsfrnuOosF5cqbJAA+u3XW0tmRJHbYMWJwBHqkUS89to1e7wMlZjgn+p0UAE+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UCRsZuMVbiNW/GcUL+qPmKT3WwlC2HgZJxKICqA0lAQ=;
 b=PlT6rQ3nSPv5yARY8NihBSF5r2M4EYp9rS95uRXa1+SaED57Z0FsqePkk36oCRkkjU9Cl5ixpqJuX2eebaCwOEo2u59CvhR0liHhmMEXpDQPmfX5rEGzjLGqqB7TxLZVmgF+Gh6Wx3aCzKgErxRNk4DM5u6zh8muFzNGCP8NBfq9O4Wdq4KvGAKM3/a1R5lyInNIjZ+K1cN6P0yUb/1nyv1rmRFEi6BPVK7cFsJCCFH1y1aoAZbOTaKpB/nbVIfPzsPSb7nKStT6detGydOR4u0INolvHJ290bWe95urDACtKDHhy95ep173nspMjmzzVr64skn2G6sLS0iwAYt47w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by DS0PR11MB8052.namprd11.prod.outlook.com (2603:10b6:8:122::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Thu, 20 Apr
 2023 13:35:30 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::9cc2:9827:4f29:5885%4]) with mapi id 15.20.6319.022; Thu, 20 Apr 2023
 13:35:30 +0000
Date:   Thu, 20 Apr 2023 21:35:19 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, Olivier Dion <odion@efficios.com>,
        <michael.christie@oracle.com>
Subject: Re: [RFC PATCH v9 2/2] sched: Fix performance regression introduced
 by mm_cid
Message-ID: <20230420133519.GA154479@ziqianlu-desk2>
References: <20230419155012.63901-1-mathieu.desnoyers@efficios.com>
 <20230419155012.63901-2-mathieu.desnoyers@efficios.com>
 <20230420095610.GA153295@ziqianlu-desk2>
 <c01ddfc5-9410-14e1-55f7-c24f44447f8a@efficios.com>
 <20230420125048.GA154262@ziqianlu-desk2>
 <721f4b8b-c238-53b1-9085-a9dae6a961e1@efficios.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <721f4b8b-c238-53b1-9085-a9dae6a961e1@efficios.com>
X-ClientProxiedBy: SG2PR06CA0227.apcprd06.prod.outlook.com
 (2603:1096:4:68::35) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|DS0PR11MB8052:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0daed7-43e8-41b1-5517-08db41a41b8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uQmHyA98UnYKesv/nvOQZDJ6rXz0Fy/aNmWF/lC5Ir8m0Y9TML1hcRL9dgGfrXGwBnCS9CRTqs7uxBpczEJncBNYNGMtpQb1DnFSjjOEbdBmibnh2inX4vXLQ2flrrJKvETcRG0n+3Wx1bVtZ7Xu50quCQYZkiXaOOcxPn1AjAuMw/vlU2zux0GJTKOSjiWeSzeq58T+HJGdtl1sDAO6LtvjMP6Kt857/2rWlOfBqpNKiGykIzOn3jXTrQeCLIjKDlpAw/6IY52f/wyw/AzFxMC+cWPAYW02Gb+wrsYIEyu7Ru1mntOpS1d0cTPzJg1UvaxZvardYncQNxNViB3h5z8Db+84SwhLXlFhq7+dLMYUudj3MMLJfyd4ZELbDiq1pz/kYBICVZasIgjky8u4rEve1fPV1HodCdMMXyjvI7lG61m6cWXMDqT8GqgJCmMg8ew1sARLk+XqSkC4+/Zd4dylmX9snacu2X/Y79SBWyqkMmpmuUEUhK6pEWH3vkj8fQfGqm1CCaskFfctbIbZ7ldLQd0URN4YDQPkfAH51Ok=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199021)(33656002)(53546011)(4326008)(54906003)(6916009)(316002)(66556008)(66476007)(66946007)(966005)(41300700001)(6486002)(478600001)(6666004)(33716001)(5660300002)(8676002)(8936002)(2906002)(44832011)(86362001)(38100700002)(1076003)(6506007)(9686003)(26005)(83380400001)(82960400001)(186003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFRYdjBrTVYzaW9JTGdoSnhiNEtlRTU2NG9KSGlhZXY1R29hVFN5NGJtcGlB?=
 =?utf-8?B?bVhrR1pQRWRlUHdxekdPVDQvZFpGNHBsMmNZSVNDbFIreldoUGdGSFI3OFRN?=
 =?utf-8?B?dklXZEtaZ3VTcGdScFJORVRWTCt6Z3BxK0ZaTm1oR0EyWnpHemNtSEQ0Z3V5?=
 =?utf-8?B?akxLZWE0NzZwcElSdjJFejhEb2VyTDM5SE1oN2RlRHhsa0R2NWJDM1NVU2ZY?=
 =?utf-8?B?ZjI4T0hsTkFLZWplWVZEM28yakRYTkYwZmJXRHRzeWNpMW1kb0xPMVRVYXZT?=
 =?utf-8?B?ZGJrK1FHUDJvY2ZXMEhyR2p3anpVa09kQXo3MCtFVDhGTm1vRldrSTVUMW5O?=
 =?utf-8?B?OEtTTzdSc1kzbFJFRmJHSGRXMlp3VWphMFczT3VwbWlmN2s2NWp4MHQxYkhO?=
 =?utf-8?B?dFpVQU1obGUrUHp3VStlc3pmZmJwQjhtdmRvQjVrZzBzTGxZckNGcXY1UE81?=
 =?utf-8?B?QitIcUVxem5XSko0Yys2TW5FY1ZJNXFTSWwvRFdSVS9tdHo4NzZVK2kvNm1z?=
 =?utf-8?B?aXFIeDdsdjhtSUpBSlYyZHlpbWd3V1BzTzBLZyszQzRoUDVqMGpXRmhYVExF?=
 =?utf-8?B?SmRlYm5HVzYxNmVmUDFkTUJ6RmhWUm40UDQ3ZCtkMnJFNXlDMzJjeExjcGE4?=
 =?utf-8?B?SVBpK3podjFqeFZISFVUK041cnhwTnJzenFEWEd1cThVQWMyb0RRZnFEeExz?=
 =?utf-8?B?V2huQlk5dUZta05LYTRscWtnbW9rYXNIZm5VNXhoSDRKTkpwQ1FFRmdZMUc4?=
 =?utf-8?B?N1ZxQ3BNb2RvTGs2SXAza2hkVm5wYVlIRzd4QkpFYkkxN0RCbU5sR3NPWEwv?=
 =?utf-8?B?SThrbU9NV1k3eGJkM1BWSmxDdmZhaTF1SnBCZE94dEQyQi9rYmhBcFducTVX?=
 =?utf-8?B?cEpwNjJQRUlJQzA3K0FLcllHRlhZMjRTQ2docHIrWmZYek5UUm9vU0o4RUlw?=
 =?utf-8?B?N21VMjc0REhxdVJoTjhXeE01dHVIL2EvVlhhTnFwN2FqWFduQXJNS1RnMEhF?=
 =?utf-8?B?eXdnUXF5RGpZK1lnZUltb3kya0JWTnByNmpvZ1M3dmNyaVFJV05nbkZqQkNP?=
 =?utf-8?B?ZkpDTjFENjkyWlhHZzhuR0l4amFGUXA0cytuRG9OUWF3dmRMU2czSmthTUJ2?=
 =?utf-8?B?dlE5ZVlwSXpISncwYWVHUUZBVURwbjRMY1lSOWtqNFNWWng5cXdlSXV2Rzh4?=
 =?utf-8?B?REswVnNtTXFmMHRKQys1dURPaTZHMk5KNkE4ZU5aUXRiUTVUdkgyZ0U4UUpP?=
 =?utf-8?B?QnBzKy9OVjZBNFlRVS9wVURiakM0Z21nWFVhcUd3c0FRTTZQck1GSloyVk9T?=
 =?utf-8?B?ZTUyTlREdWV0ZUJCMzVwOVI4WkdMVzJGNGRVYUtyNHlZazZ6SVZTMXdoRXFq?=
 =?utf-8?B?ZHpNS21xUHdLTHlVQzdiRzlORGRuL28raDBmbmpLMVF1SjVUS200aVNzQU5t?=
 =?utf-8?B?WlhVc3dsY0NERFhaL1JZajE0TWhlR1BwV1RWazdEcFFjOEM1a0dXSEJHdWtm?=
 =?utf-8?B?TzNTbzNnalN5dDZsbkJ0WTJkblg5N1hTdXpXQXROcnNKdDF6Wk1yb3l5NjZX?=
 =?utf-8?B?NXpXZ1RYVW9FQzFqV2dGeHlIUDE0VVVkaGpBV1krTGhPSnpNbTNTY2RaR2k4?=
 =?utf-8?B?K2svVzYwUjRCMWFJeTRHV0NDRE0wVXU3bkEvbExPTHVrZmk5YVY1S2t0RlNy?=
 =?utf-8?B?S1N2WDMrdEN5dE1lWUVMcXh3ajFMR28wZUtiMzFIRUF0Q20zV3IzSFlqK3lk?=
 =?utf-8?B?RzFJOE1Sb3hiWS9SMWVRbEZTR21nT1o3bDFIN1JiRVUwaUVjU2R0Z1B3cEFn?=
 =?utf-8?B?SitvVDd1SFRRcmZ5U1RhTWk4T2toUnNBcDNiR0JrT3p1T0xhUFAxUmtDMlk5?=
 =?utf-8?B?eHhQeUZJbHhuNXR0OURJZFFUTkNFME1FZnZtUHAyeDZjNHNTVS9SeWxkN0xs?=
 =?utf-8?B?NEtnUG9ac2JidUw4QUtFdUtabTc4WkV4VjRmTGxVc3BKMlpoWFhuajlWbzdW?=
 =?utf-8?B?WmpBWENaNHRHK3hOWEZFZythMzFuOExWTEFGTHRCNmgwS0J4SCt0cGhBSUVz?=
 =?utf-8?B?cHhaQVQ5TkpxUmh3eW9TcjBsWUtkMFJYT0IwTFRuOWJtN2pvZW11aVhTZ2Qr?=
 =?utf-8?Q?pSsYuPD/6klVnEbhDFcJ+r9nY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0daed7-43e8-41b1-5517-08db41a41b8f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 13:35:29.9477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nVSW9gOIlPOI876XQkjPFw34Z6H8PY2bfgSpNOIbuZ9vcUqRnWnKYCYDLZuplTfVHt1sxTBEQ0QPMs1Xozuaqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8052
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 09:10:35AM -0400, Mathieu Desnoyers wrote:
> On 2023-04-20 08:50, Aaron Lu wrote:
> > On Thu, Apr 20, 2023 at 08:41:05AM -0400, Mathieu Desnoyers wrote:
> > > On 2023-04-20 05:56, Aaron Lu wrote:
> > > > On Wed, Apr 19, 2023 at 11:50:12AM -0400, Mathieu Desnoyers wrote:
> > > > > Introduce per-mm/cpu current concurrency id (mm_cid) to fix a PostgreSQL
> > > > > sysbench regression reported by Aaron Lu.
> > > > 
> > > > mm_cid_get() dropped to 5.x% after I disable CONFIG_DEBUG_PREEMPT, using
> > > > __this_cpu_X() doesn't help, I suppose that is because __this_cpu_X()
> > > > still needs to fetch mm->pcpu_cid.
> > > > 
> > > > Annotate mm_cid_get():
> > > > 
> > > >          │     static inline int mm_cid_get(struct mm_struct *mm)
> > > >          │     {
> > > >     0.05 │       push   %rbp
> > > >     0.02 │       mov    %rsp,%rbp
> > > >          │       push   %r15
> > > >          │       push   %r14
> > > >          │       push   %r13
> > > >          │       push   %r12
> > > >          │       push   %rbx
> > > >     0.02 │       sub    $0x10,%rsp
> > > >          │     struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
> > > >    71.30 │       mov    0x60(%rdi),%r12
> > > >          │     struct cpumask *cpumask;
> > > >          │     int cid;
> > > >          │
> > > >          │     lockdep_assert_rq_held(rq);
> > > >          │     cpumask = mm_cidmask(mm);
> > > >          │     cid = __this_cpu_read(pcpu_cid->cid);
> > > >    28.44 │       mov    %gs:0x8(%r12),%edx
> > > >          │     if (mm_cid_is_valid(cid)) {
> > > > 
> > > > 
> > > > sched_mm_cid_migrate_to() is 4.x% and its annotation :
> > > > 
> > > >          │     dst_pcpu_cid = per_cpu_ptr(mm->pcpu_cid, cpu_of(dst_rq));
> > > >          │       mov     -0x30(%rbp),%rax
> > > >    54.53 │       mov     0x60(%r13),%rbx
> > > >    19.61 │       movslq  0xaf0(%rax),%r15
> > > > 
> > > > The reason why accessing mm->pcpu_cid is so costly is still a myth to
> > > > me...
> > > 
> > > Then we clearly have another member of mm_struct on the same cache line as
> > > pcpu_cid which is bouncing all over the place and causing false-sharing. Any
> > > idea which field(s) are causing this ?
> > 
> > That's my first reaction too but as I said in an earlier reply:
> > https://lore.kernel.org/lkml/20230419080606.GA4247@ziqianlu-desk2/
> > I've tried to place pcpu_cid into a dedicate cacheline with no other
> > fields sharing a cacheline with it in mm_struct but it didn't help...
> 
> I see two possible culprits there:
> 
> 1) The mm_struct pcpu_cid field is suffering from false-sharing. I would be
>    interested to look at your attempt to move it to a separate cache line to
>    try to figure out what is going on.

Brain damaged...my mistake, I only made sure its following fields not
share the same cacheline but forgot to exclude its preceding fields and
turned out it's one(some?) of the preceeding fields that caused false
sharing. When I did:

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5eab61156f0e..a6f9d815991c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -606,6 +606,7 @@ struct mm_struct {
                 */
                atomic_t mm_count;
 #ifdef CONFIG_SCHED_MM_CID
+               CACHELINE_PADDING(_pad1_);
                /**
                 * @pcpu_cid: Per-cpu current cid.
                 *
mm_cid_get() dropped to 0.0x% when running hackbench :-)

sched_mm_cid_migrate_to() is about 4% with most cycles spent on
accessing mm->mm_users:

       │     dst_cid = READ_ONCE(dst_pcpu_cid->cid);
  0.03 │       mov     0x8(%r12),%r15d
       │     if (!mm_cid_is_unset(dst_cid) &&
  0.07 │       cmp     $0xffffffff,%r15d
       │     ↓ je      87
       │     arch_atomic_read():
       │     {
       │     /*
       │     * Note for KASAN: we deliberately don't use READ_ONCE_NOCHECK() here,
       │     * it's non-inlined function that increases binary size and stack usage.
       │     */
       │     return __READ_ONCE((v)->counter);
 76.13 │       mov     0x54(%r13),%eax
       │     sched_mm_cid_migrate_to():
       │       cmp     %eax,0x410(%rdx)
 21.71 │     ↓ jle     1d8
       │     atomic_read(&mm->mm_users) >= t->nr_cpus_allowed)

With this info, it should be mm_users that caused false sharing for
pcpu_cid previously. Looks like mm_users is bouncing.

Thanks,
Aaron
