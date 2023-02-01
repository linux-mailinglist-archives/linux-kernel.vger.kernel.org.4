Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E3F6869BC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjBAPPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjBAPPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:15:05 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BCD6DB03
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675264466; x=1706800466;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NBCPMie6pPVAKlm6UG+W/esaguTVBv43HunmIuoFTRA=;
  b=cAm3O/ooatgva194drO5TNIvfC81JBWDcGxhtc02Q+1gcQya0dktuEI2
   yYdQHEhMG9OMHSodCvLOOiCSoDC5KdWAGj+ypuJ87ey7Ms3y/jn2WgUyx
   PWYYRfZUv67Ssp1emJJL/JdOltLYn0I2h7UPGnp0TtpM+62yShPsZ4UJ1
   1c9oG70kvhHvmnU9fY1wNiNemWxfd/5AbH/A9nn/dcCulIfg+qjXvWpeG
   I71mCwwol1SMHbVxvkh2z3kyvaGTSrhq5secwL7XHjotvIJdprgRKnTJI
   xNRzljiUif/E7kkvbKH9viY7aIgTFs4qyQ84m302O5HUMH0HQupFUOeNg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="325867717"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="325867717"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 07:14:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="728440490"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="728440490"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 01 Feb 2023 07:14:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 07:14:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 07:14:07 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 1 Feb 2023 07:14:07 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Feb 2023 07:14:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laANmN/88gtLN/Q2oFBuWjFUnIdP9fmnK4u3LCVEIIIFpyxyl//hUIiqGtXlRv1gUjG2SrKkA6fR8S5lzJZwO9531CzLtZX3sEzug2Vyz8Wk+3oSD9vfuh/2MvTumc4S6vo4KRMWExfOTe1uQ6dhKNintqOSILn3VWcqZHcqsJzIatxV7IlQF9VwFyGf6UM9EH+GrZNV7xg/zvF/mQDRw+EkykpeR3odmmA6sB25x4bNmun7wmeIKwL8zs2ixoTbz2vEYSYPeuBhs4i2mnTjg4nSbrLDRCPJsxZ1pbM7Gbg4Ut+tYA9g8Kl2Q1cK/tsAWFSapQrl7QAspu73JcRWrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faMBbi4WME7RnTNFPs0XV3Gh8P8WQxcl0bPbDQg5Y9U=;
 b=BOSxo6L2AQ5fctWqvuAI2QBxMgPtMD0dcm6UdJlLeR2ryhSEKUtE8RE+h62/1PNtfWvhxAd6eQ15M1tzUeMaBxEkSgg77OWGht42jTKGQdIz6U93HYQYAFVEuTqXIVxrjNneUbmncaz8Rth3qJnzzocr2dEUj9hj0Lek/DFBYkPGFgh1FNLfxEXlRi33GCKK4qqfuSJlqOqQMbmzIbxWfil1AtWiUIvpoaKbu7bHG5p6pqFMAr5ZLuI6ZKgwZT1iRsRvF3Lu5JWkQ/0oCTYuLF8KVpfpaWp0rH6x3zPD1s4IvG6AnRX7gDMroJaXRMMfAqhsk1RycF5etCdV4mSAxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by SN7PR11MB7092.namprd11.prod.outlook.com (2603:10b6:806:29b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 15:14:03 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282%5]) with mapi id 15.20.6064.025; Wed, 1 Feb 2023
 15:14:02 +0000
Date:   Wed, 1 Feb 2023 07:13:30 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Stefan Talpalaru" <stefantalpalaru@yahoo.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "Ostrovsky, Boris" <boris.ostrovsky@oracle.com>,
        Martin Pohlack <mpohlack@amazon.de>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [Patch v3 Part2 3/9] x86/microcode/intel: Fix collect_cpu_info()
 to reflect current microcode
Message-ID: <Y9qBmugSm+o5u4pq@a4bf019067fa.jf.intel.com>
References: <20230130213955.6046-1-ashok.raj@intel.com>
 <20230130213955.6046-4-ashok.raj@intel.com>
 <Y9lGdh+0faIrIIiQ@zn.tnic>
 <SJ1PR11MB6083580526A7FFA11F110B77FCD09@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y9l8yGVvVHBLKAoh@zn.tnic>
 <SJ1PR11MB60837E6E6AE7C82511DC039EFCD09@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y9mDYMASXCFaFkNU@zn.tnic>
 <SJ1PR11MB608384F3B075E0D2F25683D3FCD09@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <Y9pgzGr4MccwEJAl@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9pgzGr4MccwEJAl@zn.tnic>
X-ClientProxiedBy: SJ0PR03CA0219.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::14) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|SN7PR11MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: 3692d7de-57f3-432d-9fda-08db0466f399
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9lg4nZZjPS2BZ0WNlD2NcMCKkgZRyEHDrEBrYb6bsY5ek8BKC4Su1J76LOsI9aF1+gnM1jg4z+PKHAOt8YlHLrGCeTnJfE+IZnPK9oo+6mQIJIYt163hlfRNkuFHCdFYKg9hpO6yEJ31HC+F5rFTVV3q77D/LdouA+z0ZMMZSnfS2dGdOimjTvKvMBDd5wRyMkh3CTLN9ZW/KpnMo+GTTO7cJ5OD2Ax4UxXUyVMkCcoyte3rf/ZSazBNVt5Uvr+KTIXvcvR4s/Im4P1QyCBi3obyzaxq9GpirbUDzc7yWNywjtSG8cgcwwgpKhpsK5DkiFsmTtGUNGkqNYoo/guf4VHhmMujbcL1GnVWhXPrA8xlA+wqNO3yg4VpfUGZghoaPhhsteYOIUuFFVU+kGy8qMymYNBABgO5/+VBaA5GUxgl+ndYSHFTPUqIFib1HyjobISvxGbxbN/zaZZ7LmmfEX1Nk6Smi8mmgnpY5wUcLe+DfJmdrvr0dfydM5DIskvwdFkN81LvIu9s2NEqskYtxu+VHapc6XWfsDs5EnnM3trZnoVwJ+c0oa4CnTmzX6GJisBC70tXdFjsfBhrIbXJHGhzN8R4THYSXyB5idX2n9CA+yNfvINXZPPOrNZyD7lRPWpMQT3YUfIcK5ZHDKg4V2nU6Sc4vcStNd+ZwXAcB8Kbq8FNc7k0znUDH3A6fNUg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199018)(316002)(54906003)(5660300002)(2906002)(8936002)(86362001)(7416002)(44832011)(82960400001)(66946007)(4326008)(8676002)(6916009)(66476007)(66556008)(83380400001)(41300700001)(478600001)(38100700002)(6486002)(6666004)(107886003)(66899018)(6512007)(186003)(26005)(6506007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5PdxrGPvQc5ashy5WXc6AZ2q+LDePWbDNVW9qF341gH5v6WtO3J+ldZNnKmz?=
 =?us-ascii?Q?Cnq4xxOBJOe3sGUzUN4TlKYqGxSZhKBGUFmsLIyxaBKJLdeujPi8C/tYiXvs?=
 =?us-ascii?Q?1f5X9Uj45M9lmwFgGW6Dj6cI27hILw2wh6mbRWCtC7u5Qt9OU+r+62tMRVX0?=
 =?us-ascii?Q?mC+SzVLJtnWm1ttbkEghkPL+bhxswNI4vqZWcQH3CFbtnCksifz50nwSHsuJ?=
 =?us-ascii?Q?LeV3Dr8V7qTAfwF6PZ07EA3iyPAvpK6q+36jaQ7uPsn8xZx4t9h4GlzNar4W?=
 =?us-ascii?Q?nUmuV+2rRUCRFRH/5hUrkmU4CziKy1B+F2EPxRU7KKUmSblWM8Wnb8cTYYzp?=
 =?us-ascii?Q?3JG8PA36ppRkIESS1jZAbVeado1iO4kXLnwl0FamZ0YDZSuAhNyNVrKQk7Fy?=
 =?us-ascii?Q?AuuqT9Vnjv6qJXaw2dNu9W+C+GMb7xunFK/7qqwgjYYkAXSDJQ2NXXVcP03L?=
 =?us-ascii?Q?342NmkPRGoJbvVDFozMPK67qgw9Zmc009W6NboS9Tv0TxP+cpktN40ciYD75?=
 =?us-ascii?Q?0xNE1jmCZn7F75SWekr42tptpnwk9/BKKtptkfHEjUD/BYWpDPLU+DP8hfTd?=
 =?us-ascii?Q?YfHmZp3Orgwvwi1VXYsI9BmIF6iJaklYffB12abxsmQx6ssKisCvQFVn/Hs7?=
 =?us-ascii?Q?LAKmbt8QdDlVTbYS0wOq3BxsJiyKglbvDSC6FxXi00t82EKA31Y424n9DsKM?=
 =?us-ascii?Q?aZqWglX9pemg3Ig/R46QVNst5kmh7Lgaqf0RGqfycAOKWGbzr44zzJmcGiED?=
 =?us-ascii?Q?bBg3Sw0AIDDbObCNK0qzDlEpnFnEq3Zv1lsRYC2QE3Nzk1mN9UltZfn+UILG?=
 =?us-ascii?Q?xtNzv8Nk1y+2K6GnEturRV0adOSnTJYbvCNgiUrgAThhDzS1HxjpK9uyLY9v?=
 =?us-ascii?Q?0+NT1cLymyzUvPgITik70/9XhKYVNlP3V1V2Vb7BRKhybCOIwYTVKIw4iUms?=
 =?us-ascii?Q?5pvQowPsBzSlNKStSHPT6UaX5Kc5xT5uyNlPohiLbuxjUt9ze6E9Ipq4plKA?=
 =?us-ascii?Q?RgTEs0cUeGUtmURwSCAOn2nWOLK2c9inSIyqjJc1YJXmEny17kFjiDouvM5n?=
 =?us-ascii?Q?Ld3uxGDqtbl7nMdHN3bWPocf7zRze1OtIAYTr657+kFAmq4nzaHYxgRkkCDR?=
 =?us-ascii?Q?o639aMPbgsVZFWPzNQFQS7/TUUtNojuVTFWtgVzlh+wJWOJPZTB6JA2GCICn?=
 =?us-ascii?Q?H+P63w9rykj0I8z5Dx5dqsFXCDashI1gSWdoSscpPRpqqVpAs2UsfZsmZfD2?=
 =?us-ascii?Q?DDTi2s+ANqcsl0ym7tJKrpW7ZrXk5nYjQ859QAWJ1REESmQKYJqM8ypuB4xv?=
 =?us-ascii?Q?XTZ5wQEAiDOpfZpyStscLmtpGcGR09sSWXt1woTFvpj3SVyqwPjDXbDH1Z/m?=
 =?us-ascii?Q?27vH4Mcs4c7HXz6i627t8ERb0PO557tgNTUwUscYaq760Do4pVLhY5hf+nrZ?=
 =?us-ascii?Q?9XkFwr3u/3v0+PcnAwQyv+UVg4Ijgh8Sioh+5cRutgZIxzDGlBpCrS4mfdcN?=
 =?us-ascii?Q?4bGm4sQGl3jcWBcGW1LF783tfB3WmFzmoGhj40k/gxEnKCTBcZJbsUDZsGg6?=
 =?us-ascii?Q?aBIm/sgXDNXWWvqIjaEh96MJNKO39/yR8FHDsJ16k7YBwzmaK5c6VMUa9x1s?=
 =?us-ascii?Q?AQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3692d7de-57f3-432d-9fda-08db0466f399
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 15:14:02.5507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cEVpTqbbKoui2pRFVWbLBMliChf4KEM/j+lBZT9ClEcnrWDSxHTFeNZsosZeM4O6OGDzF7AkcUWRwJ0mBDaVJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7092
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 01:53:32PM +0100, Borislav Petkov wrote:
> On Tue, Jan 31, 2023 at 10:43:23PM +0000, Luck, Tony wrote:
> > In an ideal world yes. But what if T1 arrives here and tries to do the
> > update while T0, which has returned out of the microcode update
> > code and could be doing anything, happen to be doing WRMSR(some MSR
> > that the ucode update is tinkering with).
> > 
> > Now T0 explodes (not literally, I hope!) but does something crazy because
> > it was in the middle of some microcode flow that got updated between two
> > operations.
> 
> So first of all, I'm wondering whether the scenario you're chasing is
> something completely hypothetical or you're actually thinking of
> something concrete which has actually happened or there's high potential
> for it.
> 
> In that case, that late patching sync algorithm would need to be made
> more robust to handle cases like that.

That's correct. But fundamentally we sent the sibling down the
apply_microcode() path just to make sure the per-thread info is updated.

It appears the code is using a side effect that the revision got updated
even though we don't actually intend to perform a wrmsr on the sibling
in the normal case that primary completes the update.

If the purpose is only to update the revision, using the collect_cpu_info()
which seems more appropriate for that purpose, and doesn't have any
implied issues with using a wrmsr flow. It's not broken today, but the code
isn't future proof. Calling the revision update only keeps those questions
at bay.

I think this is what Thomas implied to cleanup in his comments. 

> 
> Because from what I'm reading above, this doesn't sound like the
> reporting is wrong only but more like, if T0 fails the update and T1
> gets to do that update for a change, then crap can happen.
> 
> Which means, our update dance cannot handle that case properly.
> 

It doesn't need to if we don't do an apply_microcode() for the sibling.

Cheers,
Ashok
