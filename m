Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C904D686A84
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjBAPnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBAPnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:43:17 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8495A458A1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675266196; x=1706802196;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YDKn0j/AP1AbA5BZWhxFPcHZyRgu5xDptF73t4/yuRM=;
  b=DCWjkjgANj31lrGKkdUetC/4SK8g6WiAs9+HIIBessWKrYyi3h6Lx669
   QdhuOYQ9112xPLaxoydwY4SyvM2aH1DdZDYuzMNOrc4JRmazoBFLB4twf
   k+hHX460ZTd5M9+OOd2Ha+lCs45fhWyCfpFuFkBg9E/KVGp7mCQuhwB+Y
   cZY2vOsCpc8OAItQ5LxPw90m42cJgDxPPn2vw5kIEzADNWG6Boax0/rfN
   xoumIKxAKvkrxaPF2jKb+cr6dbrs7Q2SMG1/hNhLhg3I4Bj6I4Aua7qUx
   02GpIguIuThyY1Eo0IdD58hc0O5eWF/sCYqROPHNOFGxOYD2Mis/anG6F
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="414385409"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="414385409"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 07:43:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="910352608"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="910352608"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 01 Feb 2023 07:43:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 07:43:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 07:43:15 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 1 Feb 2023 07:43:15 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Feb 2023 07:43:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilm7QBGNBHRhLHbPSPuUV6HsUvNJEflw6WbRSZz3XA9M0jDGaxT3mKWjon8E4TGdcqzJiX9Jx2XLqDeJaBMK4Gkv9HwZQVRB4IzOK1p8S8BK+O/dDQZsJLyY2KaYpzfCvOnEot7SME3H5rYwIKfRU1YP6s8BciRD/vkoRtYBjs21bTnBp2nOvzO4C+gE6wZn+TqR9S5dI1Tv3hGsYz3bEQaTomtRcz6jnpvcQdfEvPapuQuwUQ23kvbiBuRW70Fz8x02Xe/YzZkuDaCaYl1MgJES3PIvWsL0ySNp5HwwlhpPI0MPKZIzcfYIpfdePy2Zjfx0Fr3vR2bDF7EXBtXNJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzTMZQvrnZ4vMK7cBEaGHPkN+Sq5wEAMh3Gh3bQMQq4=;
 b=jo7hgSTGJ0I0IDj1ycTD7Lr1PALx1h90j/TtezW0FNRckMtZF0orgJXLlUUqycXyR2Z5vje86OL7ymOdYenhmSO3F05kxUh494LpVCBJBjMiOmA5k+BXuNLVk9oVkXUFRz09eX5CABLZxA4hiAQ0D06HfEF2NduznmkeXl+ITgE7Nf7P2znUL9z5Jll04rL/Cklt9ffw/Q5kf0X/IW/IDuVvrIxFBKH9N/e7I2Gs1coSz25+wrdG5o/ZxaV1oRgbxwawT5SCocXH5qF3gdcOwMLtMPpeqjcN6EPeTXVGCWMSu3uf870bbTz7wLi51Lt+5okIp2JT8sflfClbndjjag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by DS0PR11MB7336.namprd11.prod.outlook.com (2603:10b6:8:11f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Wed, 1 Feb
 2023 15:43:09 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282%5]) with mapi id 15.20.6064.025; Wed, 1 Feb 2023
 15:43:09 +0000
Date:   Wed, 1 Feb 2023 07:42:34 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
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
        "Li, Aubrey" <aubrey.li@intel.com>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [Patch v3 Part2 1/9] x86/microcode: Taint kernel only if
 microcode loading was successful
Message-ID: <Y9qIalgcZmpX6eCR@a4bf019067fa.jf.intel.com>
References: <20230130213955.6046-1-ashok.raj@intel.com>
 <20230130213955.6046-2-ashok.raj@intel.com>
 <Y9kAlKFfdek2rq6g@zn.tnic>
 <Y9lHDWjjnqdletL3@a4bf019067fa.jf.intel.com>
 <Y9l4FdvytLqMc3jm@zn.tnic>
 <Y9mcCxYK/VPB0ATM@a4bf019067fa.jf.intel.com>
 <Y9perwfaheZqAJWl@zn.tnic>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9perwfaheZqAJWl@zn.tnic>
X-ClientProxiedBy: SJ0PR13CA0213.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::8) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|DS0PR11MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 007169c6-9f70-43f4-51c5-08db046b04e2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7uxVqOIyn0JoudfDuOLMSTOeWheAzoK2pF7USwOf8Fwy7CJ2dzUrIvi3cvYId+75wyuTcxbQP59+doznbyQ6MPTaW9RVmJQNUpVX0SVs2VY2dW3XKeDhUXuhYf9xu9Z4juxq9r9win3pJK3v4U4y+RjIIyQgI56dbGFl7q+ESqvlOyKIUXJmltR6dbysIbzcPhq4pstoI/2uFUfYv+XawrZG0iUXtxXuvs1N20VSgNws1y5/4tkTDmPOVPFJ72QhwdeywSPdO2lEFrDhxRR2ygyxCZc8CmAU5GYHSoQ+kU+IK6NT4lu8qHohkEQvMCss6k3Dta1n0hx0HIfSJ5d4ffdZ4bM2yOjARui6k95M4U8Zmn1zV8lm72dHaxoeJFAxX3HYl2uZN1F3aNJCBF5XHbFEsDYxEI+ztxllwud9gxdlWOTk6q1Bu0071Efy+44tyeKHX1xdFeV8rcMjvnrX3Qf1+3XJ9jYZRtFSKLWFQRU0nNFsuTXJO1qjd7fA1onyy0DXERmwbd+aNjgbivJlp2tVCmEQ2o0CBquaEP2z1s3TMjpDqq443vzp1OKREzLPNCi4RxObW4d66Tjw8GLJ4lvkt1ccjuDTbOLS9IGFYkXwY7tskRSkrRFq5f9azBAjw/03NvbV51FxoJC58SWAdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199018)(186003)(26005)(6506007)(6512007)(38100700002)(86362001)(83380400001)(478600001)(107886003)(6486002)(6666004)(54906003)(5660300002)(316002)(8676002)(4326008)(82960400001)(41300700001)(7416002)(2906002)(44832011)(8936002)(66556008)(66476007)(6916009)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?szn7wVyOAUb/qDv+GmfeswtpqY44G7Wa33pGlKxNI1VvTYdrG2naPQQLH3hc?=
 =?us-ascii?Q?IsrOH6/xhjkpKFtUagwwgOSGd1W7ZCf8kvVUT631dPb3M5OLlQ0ROt8nG/V9?=
 =?us-ascii?Q?qRr7bMRO8GyqHmbUOeeLlOdoUVk1ESXEnRkxYOG38nJ/HdTRTVdmaklaMoHN?=
 =?us-ascii?Q?B0SEh2Bz5quXesJcOW+NMe+w+qG165tazDnbMBdCYPX8uU36AjdiibMYVIVB?=
 =?us-ascii?Q?PesdPWXsUge9Sj5I1OJYv+qsWwbopgJc9OxL1CTNylfssVqa3a6UwAXsMyI1?=
 =?us-ascii?Q?Wl4Z1LBf2wE0vb/4ToCWp8p2TAmz+527JBqxzsits447aVuFWEXjSX3UHTMq?=
 =?us-ascii?Q?62uPfG+1ilSevRy532XT306ZYo+RDZEXfhrw7mSPmniWPAQCghHtQ2evV+PH?=
 =?us-ascii?Q?oULoayb3+cqATzMOJ/NBPRCvDhIHtZjgN+BnQskMo4Z48BG4iZaFHbvgccD6?=
 =?us-ascii?Q?zWArV2QISs/gAMTo/iCe1zZhkbgKE8ZyPmWy6JO5FaTJHbLYEqfMwxz5nY9J?=
 =?us-ascii?Q?SO5PsDLhYQrYlE4iBWYaXHaYKvMl0/TW+DI2mnt1Ztndg7aBdCBxeevAhwIJ?=
 =?us-ascii?Q?ON95cm5YUlZCA7I9X2Pbzx4LD4yk6vMppsUzcGb5C5wLbvIgUHPy7ISWuTwx?=
 =?us-ascii?Q?AvfWPKI61cFpbXeKIEAPycgaxZPvvls5fOdFist18LWJnW1vduqkpohAIpXH?=
 =?us-ascii?Q?GPejYIN5L2Ttwul+0e8MfKFQJE8Mqcad7haH5iFvvde2rpUzF38H1gJcdmX9?=
 =?us-ascii?Q?W34sko8QuJau0b9lRmgH+cldd/LPYEEf/lqMQBG00iP4Uovk5oT/T3Vi/mrf?=
 =?us-ascii?Q?s3P6Wi6tkfXCtRkLf1m6KGQDTAW5+GHYeKz+BlLVxCx3H4+ZYyGUpWGD0vBx?=
 =?us-ascii?Q?+8F6g0hhbsqsf6yhuws1OfQqonKipgLOpA/93T1f/+5DLMD8PpZ8PhyVrLo2?=
 =?us-ascii?Q?rybETeRIzvS1gyjV8oOqHcDSdgw2SvdmV3+geLEdUIjNcQI3DsOL9chTxmse?=
 =?us-ascii?Q?+syzO0bmyhrXpDWqVtBxGBcFnWKdfhzhzj8XiWfz2/ZTrUFDEFOFtK47L+nw?=
 =?us-ascii?Q?4rCdMTw+6V52n7Tv0b3c5QJUNrPlFhKubkSKcGB63BGwHw8OphheYWlp1125?=
 =?us-ascii?Q?YM/mzz26LDN6DDGj+Mt9qeLo9UDVL76v9XOoD6Xm+nsDWt6tcbVzS40fVYKz?=
 =?us-ascii?Q?RNNu6qQiLH+ZhnPm/2djrsq27RVbH3dbmfRZujgoEx3eZxvscwwFq+ZfZBoC?=
 =?us-ascii?Q?3T5+bbdyQnyrtiBMYfH7/dMGQUOpGXZ1XqwSgPeJpctKy3zQsBCNVfwEsE++?=
 =?us-ascii?Q?7t9W+O+l3CixS27fWOjavUiqwgoahqowsNgDQpa96tYZgjbtfbhtVPYsBzN1?=
 =?us-ascii?Q?C1S3yCzCNtwzOIq+3wCODDaOB5KFSlcyCjc2Jrh4JNtv3RfpA6Vqk2gU8aQr?=
 =?us-ascii?Q?P8pRhFjdYoj8cF5iZGA/PGLYUn8YUio2QzKW15yEnnCh4qgM7VSRhlA3CDh/?=
 =?us-ascii?Q?eDN8k6bLKy/1OJ0eKlbIU2AXgjTx6BO6mgD7xBBrBQpcLZodVHSWwPN0jAI1?=
 =?us-ascii?Q?V995gDijxTdaJySETjiIfXXh3oKJ/jnfdvSW3GQDt0IHnVszV3c3qNwNqIAs?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 007169c6-9f70-43f4-51c5-08db046b04e2
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 15:43:09.5366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7dO1/ctO4OGzi5CYq9LQsXaST+QBIbKRP4n1u3hVKxodgHqbi8iJUxs8ShkRJHLz7gAyPxrrZPMv4fwEVOTcdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7336
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 01:44:31PM +0100, Borislav Petkov wrote:
> On Tue, Jan 31, 2023 at 02:54:03PM -0800, Ashok Raj wrote:
> > It's not an error, only when request_microcode() returns UCODE_ERROR, should
> > it return -EINVAL,
> 
> So looking at ->request_microcode_fw(), it looks like we return
> UCODE_ERROR when something with parsing the blob has gone wrong. So I
> guess we can return something more fitting here to state that we failed
> while parsing the microcode blob from userspace: it is corrupted,
> truncated, what not.
> 
> Looking at the error codes, this:
> 
> #define ELIBBAD         80      /* Accessing a corrupted shared library */
> 
> seems fitting as it has "corrupted" blob in the definition. EBADF sounds
> fitting too. In any case, it should be a distinct error value which
> hints at what goes wrong.

Perfect!. In the next respin, I can update this to EBADF. 

Later patches when we do minrev checks, or if the current rev is higher
than the one in the directory, what error would be fitting? Currently we do
EINVAL, I can't find a suitable one for that, if you have any good
suggestions that would be awesome.

> 
> > This shouldn't be noisy, but if you think this isn't needed, it can go
> > away.
> 
> I think all this preemptive development - it might make sense so let's
> do it - needs to stop. If there's an *actual* real use and need for it
> sure, but let's issue a printk just because is not one of them.
> 
> > When it fails due to current_rev < min_rev, Isn't it good to add indication
> > to user space that it didn't succeed? Thomas wanted these return codes, so
> > someone scripting can get a status after an attempt to load.
> 
> Return codes: yes. Random, flaky, potentially overwritten in the dmesg
> ring buffer error strings - nope. Soon someone will come along and say,
> "hey, don't touch those printk formats - my tool parses them and it'll
> break if you do." Yeah, right.

No arguments there. 

I'll drop the pr_warn() before taint as you suggest.

Appears we have good direction for patches 1-3. 

Cheers,
Ashok
