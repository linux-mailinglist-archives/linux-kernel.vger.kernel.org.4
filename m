Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC16E68736C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 03:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjBBCwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 21:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBBCw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 21:52:29 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BAD73760
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 18:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675306348; x=1706842348;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6/6FGNfbhcfF2dDz/VORseVqSN4DicX+uvcuI2CKgrg=;
  b=JaWMBh0viAVs35wGQPHPJIFkgl9VzXg+F4tI6CQbntOwuyQIaPdwvDy1
   jPm7Tlow3bXt8iJ0xqSGx97hwLYFu4kB40BrAQPE5gUOIBket2JMQpvAk
   CSXH1hwN9IxWaG1c/Uw6DE8i1M1dQHIs7zEUzE7pHc2eDlNb8vqCrjihy
   dfhngGBZke3B6vnGLhKjOg5XOAsELg4BtVkMFn9BhzTuvn9IHaFBX1m3U
   cF5b7pNW/D6WMm1vZjkPVtE+r/lVBhTw6t53FpIPF1LO5Of1bDND5cMD2
   LrWT3i7TmBFeCdchGoU0SCCqbHYoOhVg7SRCbyn4EQKJsu3XipKuCcNma
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="414541759"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="414541759"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 18:52:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="642715456"
X-IronPort-AV: E=Sophos;i="5.97,266,1669104000"; 
   d="scan'208";a="642715456"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 01 Feb 2023 18:52:22 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 18:52:22 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 18:52:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 1 Feb 2023 18:52:21 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Feb 2023 18:52:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AsGR6VZh1AUZbD8bJq35kLTKwb/tS+oLHWBXW/1QS/KYkIpxQtmyJwEVvEoEjlQChG0UnmdfiJgEfIBO096gifJUME0ubrKtnZfJ4vvzLgT+8XPlxd3Waq0xEEyiXm4PGaYSbOrIEkTDn0YMZA+5buIO1RAEcWbHj9qojoYRQb/KGqyAXP1d2XCzq3AVL3RBnNElyvbbccJhl/HpVIsuYe4EC+J45xD70586bzORkzGHSYr0dDFE/NEj9YAGrLtykyYH5n0nt5Fxw5ODB8uu4+TUe5Q/ayoeUT9+YXOcTp30CNnxY5IBe3Z3BpcnNOIrEgoNMgGo8rInELb0eYODBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuNHLdyehfZNS4eR+OJT0rEsAJfn1chDs3GtjuteK1o=;
 b=TdXjLI1YZ0eNvDILerW1uy8YcwCvdhIm83GhAurtreAfCpr+zN3ru0nGeDXFtIoj8u0q0F+EE9SfZbGY5/tZIrSKW7AtvPoNAkSrsKdaQt5xoSJThrBSlkJtHQKmLxj/6/CC8a+y/uN/iMKDVy5thPL2VXqHv+ysYJA56sgMztVMW8syvYEPGjpYgL963q2UJb1i0ZGyEVHVKL0sXIrbrYmCOd/AH8uGMMOB/WAC8bUadJ6lIAmkW8m5hXousedU3wLGfgqvBFJzh9MxMJs1D1SeHQmNYBlgfy699JvPazg/QCMPf7HIr3YSdAIuf+yXXPvS1HFUtvfEGigheHXLag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by SN7PR11MB8028.namprd11.prod.outlook.com (2603:10b6:806:2df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Thu, 2 Feb
 2023 02:52:17 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282%5]) with mapi id 15.20.6064.025; Thu, 2 Feb 2023
 02:52:17 +0000
Date:   Wed, 1 Feb 2023 18:51:44 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stefan Talpalaru <stefantalpalaru@yahoo.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Martin Pohlack <mpohlack@amazon.de>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [Patch v3 Part2 4/9] x86/microcode: Do not call
 apply_microcode() on sibling threads
Message-ID: <Y9skuAuxozZLDrGB@a4bf019067fa.jf.intel.com>
References: <20230130213955.6046-1-ashok.raj@intel.com>
 <20230130213955.6046-5-ashok.raj@intel.com>
 <bfd85699-4b7a-c606-266a-cea7ff336950@intel.com>
 <Y9rqeqMjDOYJKmLZ@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9rqeqMjDOYJKmLZ@zn.tnic>
X-ClientProxiedBy: BYAPR01CA0016.prod.exchangelabs.com (2603:10b6:a02:80::29)
 To SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|SN7PR11MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: e283214c-f04d-4f80-ac02-08db04c87e90
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 93AfvEKl+Tm2P0NMYJ9X+ot1fQyyTrqfB+6bJASL3KxJNct37aQJ/X2e1penT9zYW94QmO43yHIWXVvPKPIze7zrGgv1FqytvRSo81LmH3MLgAGCOu79yA52NTbbZMfOgIAMeIn1g4jZ22nw1rRDuuc9r/1cV5wMKm01GrCXa/VvKSOF01GhszwWFwjqQ5c/FwXNEahgPYRCbSi3Pn9XgCZEBZScFANP3R3s2zEcsNRc5tKEAmfSWubhSfiOaD5sQYlNrcnnbfCsQu5/96ZJ2BzKpDYd05/x92vFNdJKMeDWTgOcalzVGk1AkxAq12anHy2vz+kWNVMheqswA3PKik9SpXJIuiIs73Ia6dNzejhVm5C6nehFrm9e1CctlyH/kzkggofQtHr597W8uYhrqKshQLESpkuCOfcj1/mYsglruBmmFnbcWtTWBa5CaV7AS+9ICqJ5cfqMkNR7syAyw4vobwRZ6vSQ0umeH5zIN9oCtbHVtDKORHBYh7rRYoxP6Cmwhed8/AeoZR1R6zCm9OqiZd96jBUXXAFSFnQ7zrqpuzwh/scq/vzIuv/nBvQGeudKjHa2YW+mgxDPRXwjWT/LB7GTlEqbLfbXcHNWIo/IzF5FtPqDRWN7Pv3v82CsIO7TMS/LPQAnVdrnMasktA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199018)(54906003)(6486002)(478600001)(6666004)(107886003)(26005)(66556008)(4326008)(6916009)(41300700001)(6506007)(8676002)(66946007)(66476007)(8936002)(6512007)(82960400001)(316002)(38100700002)(186003)(83380400001)(2906002)(44832011)(7416002)(5660300002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CXNaOFUFstbNeCbE0A2CL/ogikFfH9Ve0W65U7SO5oquw41YzQbAMCFudRr1?=
 =?us-ascii?Q?8k97gV40SDUvZAdrutxxcTBfEifJ7zPTDVJzf0Lzm25dNkGGB35KYM7XvEP4?=
 =?us-ascii?Q?6QW0/nguTSdwp5hfGb76cLvsmtQXzW7hB6MDwl0Eg1mfA3bccJqKe3XoBhQq?=
 =?us-ascii?Q?LI7sRCigNitzosv2TF3NHr7uY6gZUQwDOE/ljNJZfWV7G5h5qu5MZVZJbuQl?=
 =?us-ascii?Q?Z+DpRbhpGeBeGaf1Qe+bNrDZe7K3Nyz71CHKeUeglolgSH/43ficzj/DxGSj?=
 =?us-ascii?Q?8caC2rX/Eg3V9DXrt9YJv0PoGXY56xf9xsxbnRa/j++7udZAI6LugBkTYxTR?=
 =?us-ascii?Q?3nUJQ5B/Z/QjbTyCorsyPHLoWgc0HovMUD/iDvbSXyv3blWrgkc6vvxZR+DV?=
 =?us-ascii?Q?WQ58ZxW72EdeLo01n1264Wz08LABmmiqWX/ge2WLWFeMq6wQAms8VcOtsWiL?=
 =?us-ascii?Q?DC+vtzEBirAccdEI17CuZNBo3Qg7WdQSMdJlzi2Jbi72kZHILEG8GFVP1+Ar?=
 =?us-ascii?Q?s8IbPF5utI2f/feJimUiPVJKs9hCzzc7SRRSuvwp63VR2Cer3q0Aw3tP9/SL?=
 =?us-ascii?Q?qgQlhjYYAvD0ZOTvf62EUcDh2oSBeKXDA0AJa/ytfqekCGqV94LUxQC4jga7?=
 =?us-ascii?Q?kAkkVllf8GfQNsDQ+0MbfK1ve1Q+X1QYgyUaYEhvslWwC21+YfM/7zgcpPJ3?=
 =?us-ascii?Q?RvWNjkYGQFnYLgkc9GlG0Kld4yHU6AQB69/CfR+GZtZcUWC5n/lMNR1STuqx?=
 =?us-ascii?Q?NCxXtSMCKgeb8Gum7sdWm7QdENAYAkIL4SFWFj8yE7pZ9Ziku+v9T271hrav?=
 =?us-ascii?Q?W0Ty4ZdD93DpbJC291AW801209/o7EVRVUR5AMzU3kqAWlCvGVK/qomAeDG6?=
 =?us-ascii?Q?BnUKKg7McVRvAXvv8RX95/F5OoSWeJB5tovCbSnuTJr0er5vU/L2JrN7bkOL?=
 =?us-ascii?Q?KK8hID9qK33rrGGIs9NNHI2bZ0UJzNdbCUGsAo9AjeorS+mRoVo9qZMZrnf1?=
 =?us-ascii?Q?07a8I28sqVDFgC9cgMxZXTTLEJGGFrSUOvw1+P/eW6Hpl/cDxxRCRgjFWhax?=
 =?us-ascii?Q?ZKXa3xRotPTHRvfb1z+mchsmVk4GLssaWpVhvksX6wvnwSsiGrXaGnIjODoz?=
 =?us-ascii?Q?DJx3F60eRGzF6S4F08Y7DfmW8+kvJtEuuAKlR3JTzQE5BBwo/xcaav53uHTg?=
 =?us-ascii?Q?oZGxqStXJqOFymZFsUOS4ie84bLTT8VUQiu9vRdWpUBT/1wFWbPA4MlQbvE7?=
 =?us-ascii?Q?h7wDHNfLkJQivdKDJeT79WF0x/8dGilz7bId8rHCJoJuNjlO4UsY/61NjtFN?=
 =?us-ascii?Q?yKjGc54l+nUoC3fvk1mVBQ07cc3zL9RYVTeqJke7V7Q5v3REf81UaJLcw1og?=
 =?us-ascii?Q?DuP7X4soRI2wbzZqnhNMh2G6Auzv6wUK22QI6R4OVohcrPawB4hzBg0X3VSN?=
 =?us-ascii?Q?Iw9GTArw39mIA0t4m/yVAfU+dOzYCWWHtWAVbgWaJ1Rc5mJhJ+k5Lb46S+/n?=
 =?us-ascii?Q?4Yb9U2BEWgGvtAu+zLPnPENA3jDJCmOHTOu8lM5Q3NLPmEoc8GSMb3XV3ZpZ?=
 =?us-ascii?Q?x7qk/tFxo2UkThridihbNLDwM/WxFbi2xix7o9qOBJFwqGgBZqo7R2WwzPlz?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e283214c-f04d-4f80-ac02-08db04c87e90
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 02:52:16.8937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ksHh0o0we6rnzoickUHMBmLBq64x05XUW+WNp1KD8S+w/2u9Wy3QYWg+fL2SNIW9maGAU3ArWjb+Nktw58vlhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8028
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 11:40:58PM +0100, Borislav Petkov wrote:
> On Wed, Feb 01, 2023 at 02:21:18PM -0800, Dave Hansen wrote:
> > That works great, unless T0 experiences an error.  In that case, T0 will
> > jump out of __reload_late() after failing to do the update.  T1 will
> > come bumbling along after it and will enter ->apply_microcode(),
> > blissfully unaware of T0's failure.  T1 will assume that it is supposed
> > to do T0's job, noting "rev < mc->hdr.rev".  T1 will write the MSR while
> > T0 is off doing god knows what.
> > 
> > T1 should not even be attempting to do ->apply_microcode() because T0 is
> > not quiescent.
> 
> Yah, thanks for explaining properly.
> 
> So, if T0 fails, then we will say that it failed. The ->apply_microcode()
> call on T1 was never meant to apply any microcode - just to update the
> cached data.

The commit log "attempted" to convey that, replace primary with T0, and
secondary with T1.

> 
> Now, if T0 fails, then it doesn't matter what T1 does - you have a
> bigger problem:
> 
> A subset of the cores is running with new microcode while other subset
> with the old one. Now this is a shit situation I don't want to be in.
> 
> And I don't have a good way out of it.

T1 shouldn't be sent down the apply_microcode() path, but instead
just gather and update the per-cpu info reflecting the current revision.

Patch 3 and 4 attempted to that. 

In addition....to ensure cores being out of sync within themselves

At wait_for_siblings: Each thread can check their rev against the BSP (yes
BSP can be removed, but we can elect a core leader) and if they are
different we can either warn/taint or pull the plug and panic.


> 
> Revert to the old patch? Maybe...
> 
> Retry to application on all again with the hope that it works this time?
> 
> What if some core touches a MSR being added with the new microcode
> patch?
> 
> Late loading is a big PITA. As we've been preaching for a while now.
> 

Cheers,
Ashok
