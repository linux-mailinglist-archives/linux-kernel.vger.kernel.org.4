Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75D36C71BC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 21:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjCWUoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 16:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCWUoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 16:44:13 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CF411EA6;
        Thu, 23 Mar 2023 13:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679604252; x=1711140252;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=TwvQGeDSBQeAXA8L4wOQCkz1mON3bBgsp6uyks1emhE=;
  b=kQJj8B+8z0l3B7o9UR4hGck27hljuXM8mzmsNz7ZvSxP7gZRItb43gIU
   yke/C7yIU/ZQl+R6R4DcJYeJMAR1froSAkPse2aVhLg76P6ui98M5uWYH
   KAjLvj16Pq+AwF/Z/QGCneJPP5XDzFGhnEdDvOArvzu/Jtq9S3qXb3Vzi
   I+HCkNAS9tuMoz6317GlBg5/xhNxkbE6prbMxk2xAHNPnxFTwmCdwjRcr
   LI45BxUyL2dz74f5/7e3VJtYYcJA2DzOWEA88X2doXa5TQA8XbHIl/SId
   wMuKfF+w6t9uxMYKI1Vgemvb0DXFUv9X1QP2LKLEd9MjCm0sMp/jwgUnw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="323482649"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="323482649"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 13:44:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="856624860"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="856624860"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2023 13:44:02 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 13:44:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 13:44:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 13:44:01 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 13:44:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kI06S49bAz9Z9xq672Iw53ln86w9AwOlgz/FhYyCLwS91etJKoBk7qp+Fz3XOspnuAd5XdEgZlSgGI3aRS8BTmy2DEgf3z3gWqmtMoYqcyNJSHI9McNtstVgOqy0qh5uk1JXIyj1V3FPItgZVWoYkC1veAqgZmewfrnMa3TzMlI+MzIoI0WdSQbMwwM2m2KKvNA/hqzACgmYpDEzBlZ129gkEsL2OMOW5LLMaU8a0MCoMns6BXuM6SfvtSjO58T5fw/9ag2oQyb/z/087LPiEwBHOFT/uAAfG/MqGOGMKQFgyxQFIYu091HqifxL6ZjqAej18/IzFwjmq2XPtALwmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4jrgIijdR3ntSbKzE4sm5/9uzagsvUZNPiLAl3iJHg=;
 b=HvV5y7EPBXkrJ0uFKitswSpE/eFDIL/k4Ptcq5aOBs2gaWaWBL2vQy2Kf+yPQrJKCKYORxNHC8MtxFX26uuBPi9SUp+Ffi1eYZxRwIdXlUTL2hSoTLgiIiP/vT7KE1lmCu+78TmxNKQDSBZe1B+A1rduJqIMFBEXWfZf9Wm3chPuF+zKj+qjxq9iF+dHyULGIfUyxSeRfGRDcUaBK4hHGjDmQ1z8Zpm1J2rolmRY2MlPscVeN8KFjfU4Lj26oETzimjJ+yX4dktVbm1CkWz2KXr/MWE38TQbHPVENYV+GckT11PlK2Y29+Gmuu0GfvAaaoL7bShQkM1mNMk1LsqqPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB8120.namprd11.prod.outlook.com (2603:10b6:806:2f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 20:43:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 20:43:54 +0000
Date:   Thu, 23 Mar 2023 13:43:49 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Edward Baker" <edward.baker@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <perry.taylor@intel.com>, <caleb.biggers@intel.com>,
        <samantha.alt@intel.com>, <weilin.wang@intel.com>
Subject: Re: [PATCH v2 8/9] perf metrics: Add has_optane literal
Message-ID: <641cba052d0f8_1b98bb294ab@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230323192028.135759-1-irogers@google.com>
 <20230323192028.135759-9-irogers@google.com>
 <44476adc-3797-504b-2b82-8ec670c691b6@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <44476adc-3797-504b-2b82-8ec670c691b6@linux.intel.com>
X-ClientProxiedBy: BYAPR11CA0076.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB8120:EE_
X-MS-Office365-Filtering-Correlation-Id: 86fea268-854b-47ac-eadd-08db2bdf50b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O362K+2pbeIiR5Vpw/ph7uTm3nwgqVk7LRLgCXKK6Cp0xiVv4V4gFtg9t9kpP8EQFM45yM8i52/c0NzKzUd/VRyVIM2PP9fNaMhzz7PJ2S1hXgOt+/dqH45agHlKtEAt36OemNdtuFEq7YNCBtwRQnre8ZC9LmnWLQfpBzLjuil7UL2g1VrEFWml8v5ojVJU0LK3Q8SiaJWI7pmrTuBEwGfz1Q2lLQ4UR2hkeBkfaalPCm8pWc6IbprhzYNODd5EjgVzn9CPbd3tjUtFsygawjB7gnxOiCE/VB60G00BM3B8klKKZtF0B7E7jIkLn0W/nH7bMcCNC9XdVlzZICzWVfqdg54bDedqvbZksh1gmcfkZh1nEzHlgSkltEOp2C27brVU0X2oiNwop8GCXulMdPpNeLCQ0YtYm5VIAj0xVUOMQzByYw6aCWv2cnHnrPdnHPWPHL6P7gF2jq/hZ56IR0KHVSNu7cmjkpqyrJUj4/MP33mM3vTcjjUXZsB/sQ9zFXtQrhonIs4y9hXYWbM3rsxSSJLipUK+/SnR9YCFr+wjwc7PkaVDC4Uz1kh9mIIYSaQ9N/R5HEUlY68xFj4AaEg/dvc1vO3QtAmJe3BZwqYHc+VYI3gf3tIj+wqDXVzIMaaebGXJDL7+Aw91PvogmjasmgqeMmmLeJ/X3d03i5+M4DHOs/t0nOnmvNUfowM8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199018)(4744005)(2906002)(6636002)(110136005)(38100700002)(921005)(7416002)(86362001)(82960400001)(66556008)(41300700001)(66476007)(8676002)(8936002)(66946007)(5660300002)(186003)(26005)(316002)(6666004)(53546011)(6506007)(6486002)(478600001)(6512007)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XjBgpbPzlX21rpidoKllVANYQrD39GLqpcdaQcvjGX5MmYepZuW/hGBZVBmK?=
 =?us-ascii?Q?GW9LEou8acr3BGPT5fNFjmkH1/zDdGYBK6j0PXx3gTeq2CBdegxvF/0ZC7sO?=
 =?us-ascii?Q?jd81yJILRakjxdcts9X/dvoZNQbkMsVTqbFlhKR+RLmD0soJKVee4SyXvXoy?=
 =?us-ascii?Q?BhsyGG7yIwyrkxOKgLeH6IYhFvy/Bt38xDV3NsY29nM+YwQmox3aqlygqVcZ?=
 =?us-ascii?Q?lJgCtVYCpJfqI6H0p2fdDVrdmzZaCrCeQVSziva2+jvh5K3C7kphQ00gGFyH?=
 =?us-ascii?Q?ZLogDx3bH/UG8O7ZDV7Vk/XhSMkJ4wjwUIrM2kJbONa21aw8m7LxiX9FwlTS?=
 =?us-ascii?Q?Vdh0Lu/1S/APQx2E4Su/7DsTHX0wf0owuYP6Jr0lMPiTKJIFCb2b0HcwpXyN?=
 =?us-ascii?Q?l9KNwZOdp+9OAarzhdTEZVrkziejato+7RYkDPXKi5Dv93+RFoKBO4BrtgIg?=
 =?us-ascii?Q?MIvaFWbhZUyDHWRmo1EnT+40wPeBDSjUbQDyLwbOhke9L6UqVEg/h9XTspZn?=
 =?us-ascii?Q?znD4bpkkSXr/B/CAtt6l+W1IApHHItKsFku0nVXDTZcKYZs37LqKMsLNQdGC?=
 =?us-ascii?Q?n1iq5XQsJ4CmWV624a1ItDofyJidux/kUKtiWAQz6Jubcsr1MHTzg8xMFdTd?=
 =?us-ascii?Q?rf/WYvLZnMGObDbkVawy0vllO5WeXiykDdJRz27s/VAGav68MD+ajPtK0ZIe?=
 =?us-ascii?Q?z4cub9CWeO2nRrIZfyp1l0t7tVzgodHymj77IkvarHPLmfggHyWbifOFooDr?=
 =?us-ascii?Q?uUgK2W6Y+3slouyFb2QxgOZpa6zCy2fE1/dPe8sSaGoBnpS3az3d7e4IVsPg?=
 =?us-ascii?Q?VqKJOjcaBT1hOUHUGQWO51Rw/uc9s0+l/O3I8G0Kd0tYTqwDA/MHZVyGiK1R?=
 =?us-ascii?Q?FagSiTLtTgyrPDHZWbdL8r3xWvws8MZMx/+zPMSCLPgwqtXiWaLkEzds8nGR?=
 =?us-ascii?Q?DtxHL/H0kfTcyrSTwQYu5mw5/e3jeIFNASRzpKX16zVQSNEpqzXsYMw/M1dQ?=
 =?us-ascii?Q?U3no3r7ULt8aGxDkx9t7Auj6t9rBviA3qKchMYrM2Lp4ZiYAPWz9usApr0fn?=
 =?us-ascii?Q?jDxcOa/x6K54+91PYI2gptq2VJC/6+HYifswNk3yc8PKHlQUsBuYPqg8zMkL?=
 =?us-ascii?Q?1T6ChujIRyGZrI7Qs49Xlg/6tybN0mJL/kqkzDEYSYJ/5PvCcmqPKYQ5TYfl?=
 =?us-ascii?Q?JV9jxi3IPVgIZFMwQWSOuEGTMweV/9Z9J8OAau68bj8W4Veqv4/zx5JA2pZx?=
 =?us-ascii?Q?1I1AFYJ3NAyubj5pqY0QcpmWY7UGQD4I4ac+odfPdmNa8XoRAVyJuxJaHsd4?=
 =?us-ascii?Q?TLTk2dzjilN94uDNPfrESqkXMdGv2ZIVg+21PYq5yRU2I0PVAuQjKYqTMuif?=
 =?us-ascii?Q?9clMbFV+h9zSNsUO+CXy04YVbEBscKrawGJVmQ8SPyUt5q5jnQF9mNauNzOz?=
 =?us-ascii?Q?qzK287Lt8xzI5djU+guuSTSlJchOXmfy8X+WtdrbZJVeIFHSSPd0WefmE0fi?=
 =?us-ascii?Q?wBMIW7SdrwbKBhcyXW9pNdLnjhviBlgAfcyjdoR8QpdL2HztQmf0op8pz/Iv?=
 =?us-ascii?Q?+ccaRkYuCDoK7oFyOCeE5ujnnzgS1xkvoxcguTmvPEGF6UA0+/Lhhg6AKwzD?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 86fea268-854b-47ac-eadd-08db2bdf50b7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 20:43:53.6551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6LMK+T+uQcm3QC0JgW9mmxtXWT/Pb2TdI6MwwDnAMFTsnmQ5aopCnnCW5M1Z9c/CtCWyOLmocRRAuAiQg93JYyZ+DbWiLvkELPDjrAuOOgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8120
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Liang, Kan wrote:
> 
> 
> On 2023-03-23 3:20 p.m., Ian Rogers wrote:
> > Add literal so that if optane memory isn't installed we can record
> > fewer events.  
> 
> I think we call it pmem (Persistent Memory) everywhere in the Linux
> code. Maybe we should use #has_pmem instead?

That makes sense especially because has_optane implies more precision
than the the check is performing. In general Optane is probably the
widest deployed NVDIMM type, but this check will succeed with battery
backed NVDIMMs and emulated PMEM in VMs which I think is perfectly ok
for making a default event record decision.
