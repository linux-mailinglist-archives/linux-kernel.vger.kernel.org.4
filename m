Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC44665142
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 02:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjAKBu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 20:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjAKBu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 20:50:56 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9B15F54
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 17:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673401855; x=1704937855;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3SN0Lp0RDzU53OAVCtBosqwyQVQ6voqsnKXw2D7hVGw=;
  b=VgkRXTFVR+LdW8RfWXd7OX3uN9KG1M04BjaJYah7C0noF7TcaRed6kwl
   TmwjSUAfHkLzowB2KpLrBnecNvyZ8dr8TfJczfvlP7XIeCzdLsNpHsc2r
   pTxWFONAJoxndvS0AAwWwTYkCtWFPa91y14CiL9RKEA5CNZkN76vJ2XrA
   1qZzEGoJrTau7nLlvc3UQQE7bax+Vvl8s15QFCO55lax9btS00cUwtc7C
   VkyT9mdzNDL00NnEAzigpX8sit5Z/WU7xKiuPuy//jLEpc4UyGMRw0Bx1
   4vdMtKYbkaY2oIL+4i0Yo/oktSzQAAVk3gE3s6w2xnvWTdx0LiGFXN66o
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="325314589"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="325314589"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 17:50:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="650562809"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="650562809"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 10 Jan 2023 17:50:46 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 17:50:46 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 17:50:46 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 10 Jan 2023 17:50:46 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 10 Jan 2023 17:50:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M92+Q24z7em+fbVtRQfQx06HO+PjlOiBH3Y1TElgdp6bBt+cqpbSxHK39Df99W/fxYjR65HBYr0DKrPN/CJl1zLjPaZ9snMDPJzYOsbZsTpK7loh+M6q7ip924bwVUmItaDTGxK3pzW6ErTJaM9p11kFsy8qRdMivAqov3coGfz6Z79MlZwcqass/DhrkxZBx0gS1GRnuHzbwwbjH92IvRa0MpNOGruZJTYz9pK+ZOphKIyEDgp30FVwGjTjJdGold2oPN4U0j8kw7SVH/tw0VTffLWjyfHiKlN1iurZrEMEa+VRKz+c/B4fbw/NWK2X+ZBHbvLM/1aHSlriBbyuNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1tILZtHhkrN5QddCv4ZMgfk9SgeNcoVAbMk3Q7LN9c=;
 b=NEjgFbKokUbch5pH8iTeSUlLvRSwYF+Bhf4cURERc/SJlIe4+CgiMgqBi6Y44Y27k80GkpK3LKxJgioC9XP10K+UsEH9BJX6vBSHnJ4d1LA0IvAheXJCKGEXKsNhZHqvqvUb/ZsZr8q1XFbNqi9pIhLerHurjqu0TtJXQ+/vCqF4MStQ4nx7upmTBXYrgfrAc4XUOf3IkKZqDybvKnkUzPHqhvQPKuOvAaqoxOp9r/aEbNKR9s13pt48iyXPDJ91+aRky7hoKVYP4N+QF3QCOquw8ypM3EQ6VAURmOkQHXDCOimQYHqeclaaqt3e01+iHeChKmI6icpjANEnP+mB2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by SA3PR11MB8075.namprd11.prod.outlook.com (2603:10b6:806:303::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 01:50:42 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::30e3:a7ab:35ba:93bb]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::30e3:a7ab:35ba:93bb%8]) with mapi id 15.20.5986.018; Wed, 11 Jan 2023
 01:50:42 +0000
Date:   Wed, 11 Jan 2023 09:48:45 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     kernel test robot <oliver.sang@intel.com>,
        <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Lameter <cl@linux.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [linus:master] [mm, slub] fa9b88e459:
 kernel_BUG_at_include/linux/page-flags.h
Message-ID: <Y74VfdHtEAmmbAHP@yujie-X299>
References: <202301081605.a2503af7-yujie.liu@intel.com>
 <654982ed-0ccd-8285-65b2-dc05f8b5bd27@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <654982ed-0ccd-8285-65b2-dc05f8b5bd27@suse.cz>
X-ClientProxiedBy: SG2PR04CA0212.apcprd04.prod.outlook.com
 (2603:1096:4:187::8) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|SA3PR11MB8075:EE_
X-MS-Office365-Filtering-Correlation-Id: b9cb294a-5b64-4455-6724-08daf3763f9b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SPUk05ib08WlwNTOYUFGTpg7GvngeBltpmEDoc7fJH6AvRtA47fcTU0UGG9eLGe5TtL1MnGIhYBQn5trcexGcOibGxyRFciNezG/f1TweCW5IXkfCC8gfotrHjz7LEtxy36XP5rZ3TxztWzcA03is2oLTY3beZ2MsbEkRMAoCa4DVicyhjswu6Owjfegl07IzvDWOlH3OJyshqiUuaX4XX2xrkdmf5bg78xRpSKY832k29RD5xKnTdpbA1jTlcNKphZ1iWJNn73fH4yOQB7XDgP6kaIhG3klZl2LWyZlVH7cbcRZeR8GyQSC/AYa2SY5QkFhN+F6ACC9v2rbVwQ755SEnG4WN8ZQPLiTI9LA7c9hk1xbiGReFhoHBKgpGYNyOXNZ5S9EWI0b8eLlk3UP1LC/7aLsqPbL2cB3zTSwYuM7m5iYsa0VJtQzy5oLuptqwzXg0xbDGRGtpGF/MK6DlCNMjqknKlaj5SWjdQpLZtUG4X8VbuBJcfBEplPwCSXosqS9NZ2x9ny/f++B6Zo8emy0PIQkzbodjMI7tX8TDVqLxs9TXHOT3Srp6PngoUNcjkVlzRtU1iYUEmTOOxxfoyA37X/3bT4NXtcv6cqqvX0Si2ffyamnsuJau7kPShsntZp88HntQWuBEGtm2XarPbhgvJJIZOgg+gmoRxUipBgq+O98wjuiaVuSppbnd+sFGc+VHkG/UJa1cUjvCJcwbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199015)(41300700001)(4326008)(8676002)(83380400001)(66556008)(6916009)(66476007)(54906003)(66946007)(316002)(86362001)(8936002)(82960400001)(33716001)(44832011)(38100700002)(5660300002)(2906002)(6506007)(53546011)(966005)(6486002)(26005)(186003)(6512007)(478600001)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?72LlXsw5OXcZ1rrTCa6LLHjilZpErv00bBz1d5BQm7a3tbGafajIuvmXrLFQ?=
 =?us-ascii?Q?yqPBFuZY9T+Xi36K+ebpzqcbI3v63rCYTrBp9E1wEOvvinKrOjfFQqAXlnWW?=
 =?us-ascii?Q?/8mjPSb8Kg9pv8n4cffum4VW90XQSb99TxKXhp6C4XWrZ/mK/9shB5HTQr0S?=
 =?us-ascii?Q?WxWDDLxyJKe4MW5+midwzTRgOduoTvFCaXvVN58NK562pI4i2nDmvaodOCqL?=
 =?us-ascii?Q?cGdVzmFMtZbajb2QyJKBWmpNbVjDAd6BQ/+P17cSeJfNyetLV+60B/iRqLVR?=
 =?us-ascii?Q?onh7E6lxQZn1e6SqH3TgmpD9KGzONYGcVOlTVxhJRTNH7nHZoneops/GY5nC?=
 =?us-ascii?Q?/s3HhdUCHuqd/fXfhquy7iYyUcQ+dypjIkay/mhOv+hmMR/NqnaDUnOs/oP0?=
 =?us-ascii?Q?NEVXpKwCMp5pBJrjPqv9e3r77iKxTxyfcNjvNk0TFmFbhbpLYcgBz5iGhi+E?=
 =?us-ascii?Q?Btr8a9onyec+ikA89uVtQIsAoAULr2MtF6YX3a95a/h3l0ew/UEusdQRot8P?=
 =?us-ascii?Q?ulETIOJBPTuvCqGtp1uoa2I4DpHZNaHifJ1ZED9XgWeiwTk0eFNvm+L5jxiy?=
 =?us-ascii?Q?LU94UxJkSLaO1GTrzoZwaHrlm58gcE37qQt8ixT4yZf5T0jQ78I8VxbcnI4R?=
 =?us-ascii?Q?adwnO7zWadQpJr9/iueQEPu88JvK8xGokDNfn1UTef2h1fYt1cwpBlxyMP3T?=
 =?us-ascii?Q?DqZ5+6n4eNMxAkZUuCqOVy8rBV8p33bVCDuxvViN6/rXIloel6a/eYY9t9fB?=
 =?us-ascii?Q?PhmglRq/A8rDhmjFNNorZrt+m3jFMPUINTsemDV1WtFl7bHE/gycJ+9scG3v?=
 =?us-ascii?Q?0sMbD7hYZp/FR6t10/Al/PIGhrd6gq4g3ZpVgg2NUmjIxehlsLWNOFdKelHV?=
 =?us-ascii?Q?M9Nwdd9N/MP87zSPxnsG8jnOeywRvB+eRcWgqjOSbrBmW6v/+CKIsnI1chEB?=
 =?us-ascii?Q?JJLwBVPjow8BkA7Exr3veaXj9do714lMUpuUjIgXhWrTAxtda7o0HNSyvcQP?=
 =?us-ascii?Q?hAoBn2+x1f0ZdSzHYH7Go0CZvip/INwblM2rPyLdUNHOYjnQlB5XmmT5Npgz?=
 =?us-ascii?Q?YXsLK8o/Z9DQkOjBxtCXcFqT42bxoamsydbv4mF8KOlwYmQa74D0pjG3b8MB?=
 =?us-ascii?Q?3v/wUtYmZuubMQBxGCwvZLfJsdl6R15pwQnfwXFFGpCUCEU0DCsfBUjArrxo?=
 =?us-ascii?Q?WsnLkdCRKSW8FSmoirgHHxciCq99Ynox7sAAFhRDfy+C6xRey9zqrNPRW7j1?=
 =?us-ascii?Q?/Iwc8GSom9xf3wVO+QYf/V8bKZoDWyczJpVB46iZCVG5PYuLw4DLoq2cDqm6?=
 =?us-ascii?Q?bf2EQyAQD1R50agpiM0Jf7gw5oM4KNPcCt3DbWo8AkokwvGdf7ZBTJi32Rg4?=
 =?us-ascii?Q?Wzzi07tMD3RdWtRop1zXKwAR1MEK8wcf9l0EE7a1GvdCIlmIO5UE4v9WwDSH?=
 =?us-ascii?Q?zwVV5HzByjvvRP8emzMliuaUJnBMNHPHWwSpj7ilLBlxxBlNZThW2iyLPXdr?=
 =?us-ascii?Q?EVAC8xOdlLz0TAmPzdZg+dCJCTOceXuIBqypVBSTUaBl8JmOvrWlUFaWvxo4?=
 =?us-ascii?Q?R/nYPOp8Yj+4fWPnWsccW1TLei+NP4VI5F66aI9x?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9cb294a-5b64-4455-6724-08daf3763f9b
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 01:50:42.6748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MAOGyhWNFtenAicUJeo8pOQpJeRHisk1MATKNFZIwEd/jyCPvegOw/6VsTaHBSq2hQO3A/SxUwqooW1eX5dl3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8075
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 11:57:12PM +0100, Vlastimil Babka wrote:
> On 1/8/23 17:28, kernel test robot wrote:
> > Greeting,
> > 
> > FYI, we noticed kernel_BUG_at_include/linux/page-flags.h due to commit (built with gcc-11):
> > 
> > commit: fa9b88e459d710cadf3b01e8a64eda00cc91cdd6 ("mm, slub: refactor free debug processing")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> Thanks for trying to bisect the root cause to earlier commit than
> 0af8489b0216f, as we discussed. Here I strongly suspect it's also earlier
> than this commit. Because the code changed here is only used with
> SLUB_DEBUG, which is not enabled in your config. Only later in 0af8489b0216f
> it becomes used also by SLUB_TINY.

Sorry for this false report. We don't have much confidence in bisecting
this issue since the reproducing rate is very low, so it's difficult to
mark good or bad during bisection.

Thanks for the latest update at:
https://lore.kernel.org/all/d024b846-9282-4ecd-eafd-2e5571932a72@suse.cz/
The test results so far have been summarized by Oliver in the previous
report. Will keep you updated if we find other clues. Thanks.

--
Best Regards,
Yujie

> > [test failed on linux-next/master 469a89fd3bb73bb2eea628da2b3e0f695f80b7ce]
> > 
> > in testcase: boot
> > 
> > on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> 
