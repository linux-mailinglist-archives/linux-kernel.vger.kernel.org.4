Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C05D725AC5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbjFGJkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240180AbjFGJj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:39:57 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E178FE43;
        Wed,  7 Jun 2023 02:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686130795; x=1717666795;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Z+94QZxFcFczZjUH7Nzkhevp2Do+npNT+dRFTQstsdA=;
  b=Oe+gZsuNMPjKo5d/3Wx2Y92vGEjfjtrKcRgx+wG5hiWr1GUVibnk0eoP
   K1y4FUWsmUo4n/kO7k6XpI+Iig532vedrNVQ43xViyZFOTADx1sN7fYqx
   wVSc+TgmSqrO1Lvj6aWMEH0EA+4P3KK778+VS4P3RCI/XYW/4bmOREDq3
   KAPD1mMxi96yxP7sYNErkwdhfT5JcOshX7JjpRn5ObeiXgkQ0mFUtla6c
   nfeRkrvpj0MHz/bjVnZgWFVtC9BhBk+s86ynBDq0S91rSYhX1ohSDnyLY
   pM6O667HhM/+yqdfCyDwX+xZ9yZ+C8C8k1cvwm6YuQu8JzFTU2IGl7JV7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="336563901"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="336563901"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 02:39:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="709414085"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="709414085"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 07 Jun 2023 02:39:54 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 02:39:54 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 7 Jun 2023 02:39:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 7 Jun 2023 02:39:53 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 7 Jun 2023 02:39:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fS+NWLO2/k0f2lp0a6YRpvQgEggbuBxSMBxL1wRHBMAOBCDvURTMuxDaXcEAv/SJGdZAcFaw5dxj0MMs5+oKplqVkJxpGFrmTtTmpfV6vXaVLg1hxasbnOhEoxALjhdH8DtUGR5DK065f4zdVpecV51v9eQfr+LcaDxcKZMgL6oNC5qarNa0JdbxwqEPxMtflVfEo7/JMOh6gY8t2ir/1AmDeHCha0yJec2OF/tyHLEXWGpYKLG28HTj7VvIKmM9TPPpWCuIJA8dWPjSr7XZ8J4mFhlxnuR1/tQhmFXWHdlaevMOek+FDcjRzQi5E6Lbs6PqM693I+BPI8ksas12HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7PvSr30htElDxa6tTBUTAVk/3lK6P9QrQD0PhruKrg=;
 b=SAkaaboUERPEiLXtpeDMv/wal7cDeFueS66SueKE4jdpZoUyQ3I61DSlZE9K0jgftCsAATtXKAh0fRN7nfgWkscyILJbTebP1LBP+moqTuAAXPkbe82aX+9MHwGzL+DhOm4QD4S3AXOOZjtDotyAhT5Y8mDWx+9qd7WAa1SAgPppNulbiO/KU+/XiJV/fwFpgTzmAj5ESydqSXwUFVO5ER7gvKT+FI6ZUWb78Tbawgo1UMdKB0yqShjcO8jRiMWhyN/OBszUNkioavOgyfqEoeSeZW1h9+tdaZ1XubVea4gAiOYKw5um5m0d5Vo58WV5NguszM8dPRaFxYsGUrXSwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by SA1PR11MB6918.namprd11.prod.outlook.com (2603:10b6:806:2bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 09:39:51 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::d549:ec18:45ca:2786]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::d549:ec18:45ca:2786%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 09:39:51 +0000
Date:   Wed, 7 Jun 2023 17:39:39 +0800
From:   Philip Li <philip.li@intel.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     Richard Weinberger <richard@nod.at>,
        Eric Biggers <ebiggers@kernel.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Maxim Krasnyansky <maxk@qti.qualcomm.com>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        linux-hardening <linux-hardening@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: Reported-by/Closes tag for uncommitted issues (was: Re: [PATCH
 v2] uml: Replace strlcpy with strscpy)
Message-ID: <ZIBQWytL3zhWFLgd@rli9-mobl>
References: <20230606182410.3976487-1-azeemshaikh38@gmail.com>
 <1833651082.3690424.1686084717406.JavaMail.zimbra@nod.at>
 <CADmuW3WzC61-si1j61kzwfx5EcsvSt4QBaY9VHiybBRWAN3yyA@mail.gmail.com>
 <20230607042340.GA941@sol.localdomain>
 <57443d420183b7a0bcab8041c2dfe3ba44e054f4.camel@sipsolutions.net>
 <2092891129.3692555.1686126895090.JavaMail.zimbra@nod.at>
 <ZIBJadzmheKWCErq@rli9-mobl>
 <a953b19efca20b470759b1d53beb957a11062ba1.camel@sipsolutions.net>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a953b19efca20b470759b1d53beb957a11062ba1.camel@sipsolutions.net>
X-ClientProxiedBy: SG2PR04CA0164.apcprd04.prod.outlook.com (2603:1096:4::26)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|SA1PR11MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: c1809068-9aea-4560-d0fe-08db673b23d8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AwuSmCpQXQH0Q4jMnQOax/+pnPuVFHp87la+7O9Rc931XsNjD3Wy/PlJRSJ7Q7uq8aY4CZmDw6mY5tBATQe3fpgus7iG3KSf1gB1GgZACFUWFCjQixWm9VJCJP+cCZjeZZXjjTUJrL41MkLzOBALt3YJiCjSrKrJ6A/0Viq914160VVL9rW7g6/Fcv29Ij2ZR0zrIYH/EVtx9rvblo3F3WavHBpQ5kzh16mdoemWHm92sKjRZ109cozIhO+2HZCa1VG4ASmf7KzX/KswFoXy9j+fY/O1wumL9isbIFpMUqOuXRAszHHXQScjOkEMmQ2i5SDm62Gop+IlP1Q3Re5rSmNLjC6AY5a1BeYOZG42yGS7JS2gygW0b8dAOvVaJLs01KGChur+D0I9n6j26M2rksLAouiEDBGQuafKbCnjB1sPu0d8FGaPRNsIFSSNb3t0f3OtJ7HqsTt2i6HqOChNJBwDfdDdqXBwPiMZ11jIVzOMFjsFBFVJjAUd/FaKdEAS28/3we+Nj6/iaWQKU0GS5MwXRkfyIxYVaAiyQskHRlM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(366004)(136003)(376002)(396003)(346002)(451199021)(83380400001)(38100700002)(86362001)(33716001)(82960400001)(478600001)(41300700001)(6666004)(966005)(6486002)(54906003)(8676002)(44832011)(66946007)(66476007)(4326008)(5660300002)(6916009)(8936002)(66556008)(316002)(2906002)(7416002)(26005)(6512007)(9686003)(6506007)(107886003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?SDvzsGe8S+yvaYLhI/TRR4rsgYGbnCCWUfsUtFfnm674iMR8/P8ycDtP4j?=
 =?iso-8859-1?Q?ZBjCCzNFDrazOXLKyu8lLY9AoVo8U14yCGTutUlzbQEaMgWpr3AjgNCUOe?=
 =?iso-8859-1?Q?KhTV+vQDsBhS25ZIaSTNz8oR3lAtGJiaz+2ymvy6yImJXflkvNNQv6UW2f?=
 =?iso-8859-1?Q?9MdCLODXc0ASjXKeyCUT2Jh6o81j72EoHNtS1t3uiurnRKkgrLUTmTZQco?=
 =?iso-8859-1?Q?iqW2bUYX7j9NIQcl3p0QUbhm/MURABUdjxz/rOceFnf/Lw5VUY+nmfcQPy?=
 =?iso-8859-1?Q?FSaw9NZ2Gb8aoMhp/dzoguvmkE0JaKiOOvdkMGTSyJIIr7k+x8Enneepz+?=
 =?iso-8859-1?Q?2m9ilDJoDSATldKuPUf1DEbh8DfFBwade20ZVtLC77o6yInlifFunia6P1?=
 =?iso-8859-1?Q?u1jNt0sj6uFKQzJ9zjc96dwJAVRhKkFvZQor6HzDIUdbv+xkYdJBGxsfkr?=
 =?iso-8859-1?Q?ePifbc4f7PFrRj8L44khsj2y27zUF85zymBKONQkU5mTyUW1oMdoyDCDKN?=
 =?iso-8859-1?Q?rMtMQrGlgJaN+hP6oSVVGHJQoQj/7GzjSCLNRpPyPXAvVhWVCOeyAG/7TP?=
 =?iso-8859-1?Q?xK0dy2ZXCh6ftSVUjiQLgqTwo4SNfN0ayrgmKO2yvfK/xcWBiiu/+9QMry?=
 =?iso-8859-1?Q?EIDctNuwgrs8iESW686mdQ3DaymXqqcjE3M3ZF1OGL/35lUcGYCLIKIUrB?=
 =?iso-8859-1?Q?czaUv9qzc1SLgMnNzmLADmqefC/Jze85bqVZkq4anP2ilC7zhlKjTKUYPQ?=
 =?iso-8859-1?Q?lnin092obL9+n10ICxPVLkmCNmUvkgSeDYO2Owr6+FRgrQvugQoCeO+4fR?=
 =?iso-8859-1?Q?4sL8KV9gmCLPLbCuncrvMox1/BoUgW6rCfuZ5ceqlfRBniLrdjRePFPzSd?=
 =?iso-8859-1?Q?hnIkl/O9wYN3uM868TpKJbUA58d8L2x3BblhCWWFW16t/fJ5oKKTA/eqsQ?=
 =?iso-8859-1?Q?evYeY+ZY8yFlwDw6dJ8qRkCnk+aUUg7Zizkt3bK+wOZFDxgrs0zxi9/8+b?=
 =?iso-8859-1?Q?97ZEf24b7lANsSxWFhiz3ecFLBP/KLWfvAD0x2bGsCQJ8M5DfwPqmMXL4+?=
 =?iso-8859-1?Q?DP/yiIDAt96rT3uQDoWwFHwZ2dQjvrERUpkcTGM7+ueXLoP46V7Y4tqEiD?=
 =?iso-8859-1?Q?4s/F5jZflO9cSXQdW++PlnOoz2IMYqSC54iVOZ0DxwJl97KvnhJJNUxSMw?=
 =?iso-8859-1?Q?/7iSdNkiRzTpKUjwvDd2upgSgaabfVPA9f6plX6u5CRcvfn6pDCMOGgrgI?=
 =?iso-8859-1?Q?Y0vGtybHS3KIQk2Wu4nCzzvkdl9OAIT2siqTK7uRlRY5S9URT7BDNm4Jf5?=
 =?iso-8859-1?Q?jR7NHMNBYffZ671zvDowgo78U7Ws7iGYD4lDxn9BE0ZAmLiOJuxZR/rnUb?=
 =?iso-8859-1?Q?/zE9yCcjKn0GdQTHlRbrjv6PxvTm3uWC1rD2r2BdKvg5wTpxnhB1cRybcO?=
 =?iso-8859-1?Q?OyvBrmh1ZO578YyGXXEc8j8mbCUvCvUcbeeQ3dBipzslr0wKjygu34/hXW?=
 =?iso-8859-1?Q?EEU0Q7Fy+kcOxsMbaa+JRYgEj3HG8nh40OxT9UtTmMzOyN60dVf4lvZU0R?=
 =?iso-8859-1?Q?6pN+daeocZXIwt+7tB5NX/xw6RGu/dB84tmq+QcKDwM/claWMLEZXMutBp?=
 =?iso-8859-1?Q?FqkWjyYCoMNc0A0UDODDtTGVHryFknYe7q?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1809068-9aea-4560-d0fe-08db673b23d8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 09:39:50.8313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VbWPtQ3RLZf2py7UP8jHrrqYTuUTKSEATjXD+Dqc7ZaO3fGNRUQZdwOLhUeMc0KEkW46EG2O37uVyIQVjVWF0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6918
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 11:17:54AM +0200, Johannes Berg wrote:
> On Wed, 2023-06-07 at 17:10 +0800, Philip Li wrote:
> > > > So it seems we should ask the robot maintainers to just stop suggesting
> > > > those tags?
> > > 
> > > Agreed.
> > 
> > Thanks all for the feedback. We will carefully consider how to present the
> > suggestion clearly.
> > 
> > For now, because the bot covers both upstream and developer repos, there
> > can be various situations, such as the bug is found in upstream. 
> 
> Ah yes, that was actually in my mind, but I forgot to write about it,
> sorry.
> 
> I agree completely, in case that you find a bug in an already committed
> tree, and there will be a separate commit to fix it, it's completely
> reasonable and useful to have those tags.
> 
> > So the bot
> > tries to let author decide how to apply the tags in appropriate way that
> > they feel comfortable.
> 
> Right. It just seems that many authors aren't really all that familiar
> with the processes yet, and take the suggestion at face value.
> 
> > In the report, we now uses phrases like below
> > 
> > 	If you fix the issue, kindly add following tag where applicable
> > 	| Reported-by: kernel test robot <lkp@intel.com>
> > 	| Closes: https://lore.kernel.org/oe-kbuild-all/202305311135.zGMT1gYR-lkp@intel.com/
> > 
> > But this may be not clear enough or not the best way to suggest. We will
> > consider whether we can detect some situations (like RFC patch) which is
> > no need for such tags to avoid confusion.
> > 
> 
> Right. Maybe the only thing really needed would be to say something like

Thanks a lot, the suggestion really helps us to get this better.

> 
> "If you fix the issue in a separate patch/commit (i.e. not just a new
> version of the same patch/commit), kindly add ..."

Is that ok we just take this phrase as a quick improvement for first step, which
is

"If you fix the issue in a separate patch/commit (i.e. not just a new
version of the same patch/commit), kindly add following tags:"

This could help remind for most cases if not all. Also this allows us
not doing "complex" judgement by the bot itself.

> 
> or even just
> 
> "If you fix the issue in a separate commit, kindly add ..."
> 
> so it's clear that if you're changing the commit, it's not really
> something that should be done? In which case probably even a Fixes tag
> should be there, but I wouldn't want to recommend adding that since the
> commits may still change etc.
> 
> I don't know all the processes behind it, but I'm thinking that even if
> the bot picked up a patch from the list, it could get committed before
> and then fixed in a separate commit.

You are right, thanks for reminding this. The bot monitors both patches
in the mailing list and repos of developers. It could happen that a patch
exists in both place, though there's logic to avoid testing both but can't
promise which side got tested first.

> 
> johannes
