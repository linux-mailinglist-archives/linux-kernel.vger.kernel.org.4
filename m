Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD216F5799
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 14:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjECMJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 08:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjECMJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 08:09:42 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29885275
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 05:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683115780; x=1714651780;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UJm/xbuK9eiMknXtaolbMS/OFfDDogrV9LQnXq4yTxA=;
  b=YXSkyY2bLx51kuNl/F4tzgcz3MNRlx3Nfdpy+W2zaYN2n6KJGagmD+lP
   csQxf2+byKzOjrcVq4VXfNuZZb16ZGbNsPYqi2Q3hQuljpXN/ynkI6L+U
   4hnr6aOzLT7k0e2QimkoSPJ1Q4Svfz8q0J8WaJd/2Abw3pTEGa+P5Ah+J
   TLixJYzLEazvpDQ6QdWpvHozkzuoCUoh59ghgjg+ISWw1QlpjHtsCOXJQ
   KWcyuOxxi/BxA4TrSiAu2cD2370N32udb5wCdhs3MK4fZzwCGnPNut2Fq
   LTGOURLcLy3gunwomQPfNoJN6XRESO3L7WLhCKu60okQsBEmU2lnZLqqm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="347456810"
X-IronPort-AV: E=Sophos;i="5.99,247,1677571200"; 
   d="scan'208";a="347456810"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2023 05:09:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10698"; a="820744227"
X-IronPort-AV: E=Sophos;i="5.99,247,1677571200"; 
   d="scan'208";a="820744227"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 03 May 2023 05:09:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 3 May 2023 05:09:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 3 May 2023 05:09:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 3 May 2023 05:09:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 3 May 2023 05:09:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E98FkcASKWBhwDOPYI/VyT4N4qdFmL87Slv2sVtluV/5a7KLYYruBVIxSWvp601HDejARu5RWq1zTxMLRPLxReiNJ64UyZI0cpwPUF7tzeSnxFkNHzzoK9RSwuz6TXhAZW4UZqL1MkpSy7ylxYE8I1c4pnYr7RD5mnDS/S+H8nq5XNYoMpY1Y5xuJOeJLc0Hkllr/zA9BZlpvYh8t+93ezkijQC4SOKus8hA9xIVXyaZJnJmmXEsKZAWTeyQfqdjIv0wQ2ZKnBArjsn8Hq7KJQd6qfs9vPLODwmyLTRbsHX4+C+wyXjxx9wjes331uiK7pfjbvoM9VdMy4go3NhVSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTKhdYYeDXOTp2/h5OMl+QFFdwxjumvD6UPTjzZMDbg=;
 b=B0FSwxbBxCK2K3x7Fxa7tgppO3obhI7cw7InPW2dkSO9+rropU+VRnjEcvdMemMdRJIHRv0U4wVIkJD0/GaTdIP5dTf6wOcd0yzudhIXJoxuC/Mpg0+GU/oPFHUWE9SIx5BM9cjMC8EjwwcxdGe0QApg5lJlTkOnsS+oL2XZIn+CGaJpYD6LehODGXE0IcMrtw7CvUGpDEFU7suMxIqAGpBQUZBEF7fM6nzmat3S0niRn/kOVC0pLOUAkpqNBynwROurb7tnknJAmPLZuY7ZXcXz1P5F49aiYErdygC++TfzA8M/23RdjdO1eGmj4q0jyDlH+h4n0n3l2svpylsTSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by CH3PR11MB7843.namprd11.prod.outlook.com (2603:10b6:610:124::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Wed, 3 May
 2023 12:09:02 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::d7e6:2d0c:3393:229a]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::d7e6:2d0c:3393:229a%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 12:09:02 +0000
Date:   Wed, 3 May 2023 20:08:51 +0800
From:   Philip Li <philip.li@intel.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Mike Rapoport <rppt@kernel.org>,
        Justin Forbes <jforbes@fedoraproject.org>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <jmforbes@linuxtx.org>,
        Andrew Morton <akpm@linux-foundation.org>, <lkp@intel.com>
Subject: Re: [PATCH] Revert arm64: drop ranges in definition of
 ARCH_FORCE_MAX_ORDER
Message-ID: <ZFJO01C9jbZrmDMW@rli9-mobl>
References: <20230428153646.823736-1-jforbes@fedoraproject.org>
 <ZEv76qfIiJcUvdql@arm.com>
 <ZE1pcwi95nPdlKzN@kernel.org>
 <CAFbkSA3SzjWZ_Q8XC6-_Kzc+jmUN6sG7vzbSD5X1bRvPUaJg3Q@mail.gmail.com>
 <ZE3mdYajdFnvl1by@kernel.org>
 <CAFbkSA0O-4YgNt-7KPhvx+vhvRNc38PO8E--GVAWKVgHK-_9Mw@mail.gmail.com>
 <ZFEZLZHBosQK9xaH@arm.com>
 <ZFE3GDjmUWpMpmqu@kernel.org>
 <ZFFK/qPTCIpGE2Tu@arm.com>
 <ZFI1eK5JmwIdL1eq@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZFI1eK5JmwIdL1eq@arm.com>
X-ClientProxiedBy: SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|CH3PR11MB7843:EE_
X-MS-Office365-Filtering-Correlation-Id: ecf7ab68-bb96-4ccf-778d-08db4bcf2eba
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: maVeB94u2uzTBwF1eELymVL9PAT3WRxxXZWqf6kVPeFK7b62L9gAg4KHJaGkVOr76NxSs6tE1MokWKd3oZj0HhturA0agnD637vehq2EpSWx2jKrRIdGsmznsPLoYKmvD7wM6arzNXBRSwVj82ho4a4ZBsOZbqVm+47MVDGN2OP2YLom1sDTXnS61WFvMbXLFb4OLiMAiaJFC+DQ6s95RedPfzIkF+FaT2dlJtbgiglEfknBmRrASvyY5AippXCFKCvGMIFapVfd6oRbKM3VmkwSnKI3Uz/E4ZQS9WYttTk9wgdx39KfYdpWQkqBOl0A+vqbtACTOBHJvEDd2wTLjboOIISkjSG/9sQkwqleDVOo/VzWg5T+aHmvpPO969K9FK2rjzOilBRai3+EW6hrz8f2lwP3DVpWJ5c8020kDiz9SRKSkwONedp5AMDCqcUuiU7FUkSi8zuz2kGjtsju90XkVW5a9Qb3KAmN9nmbXmcdV96up6S6Nz8NlNj5CXuaAHaGi+OY6hkOC9PgnCAitgBclGWObbx5Z8pSrijPMI19SjPprr28E/xU1xchxx4qylCbvCvw/3y4jE2Tt/+Zxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(376002)(39860400002)(396003)(346002)(366004)(451199021)(8936002)(8676002)(966005)(6486002)(6666004)(86362001)(6916009)(4326008)(316002)(41300700001)(33716001)(66476007)(66556008)(66946007)(82960400001)(5660300002)(38100700002)(478600001)(2906002)(54906003)(6506007)(83380400001)(107886003)(186003)(26005)(44832011)(6512007)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lHEzrjoaQTrtORgDmeGF1ktAprUvNKFHJ5zxv1bYwv2lwTJaRM+rYWpjxahq?=
 =?us-ascii?Q?S/a5i1/nx7lGzloNzTXhXVIYsg5vk7nhp6jiYzX6c9hiE64aVnOvFq6Toiea?=
 =?us-ascii?Q?iESkUJV5CrI938S7prCdnZNp4b61MTa/EDPi+FjTS29Ud0WQLzsx3uw2L+fU?=
 =?us-ascii?Q?Ant6/LcLbDte1ON8TM13Jhpzxh15BQYgmiyJzcFb/U8q/0gSE29TQ7m6X0q4?=
 =?us-ascii?Q?308uFPnZ40pz2qRxoP3o9KA+rRbisXse81VJnarGbDTR/HbTtSWlM3zjj62p?=
 =?us-ascii?Q?gB0hQr20iLYGzW3L3G7kJmMX40+RTWsejiNjqc6zi5tNsjRev1HuLzPz8Scu?=
 =?us-ascii?Q?02uBL1COJxHMiTIlp3vsXO/l7xgRyRWGTqqtU6TaQ+ZdS/Sh6EDOTplcgGLy?=
 =?us-ascii?Q?dKCCgXTxNWDVbQTSj6P9b0ISbyo+8KVdGyqO3GJiPPI9qrMGeTD++iLJXkwP?=
 =?us-ascii?Q?0wCBZ5+3KRRzAETsoJ5TjhUd+9YTz4fzZQAbVKeaJiqbVFg8fyNH34gQevnG?=
 =?us-ascii?Q?Hywxl2D23fqx5zvEDlWGpCmZuwJgnF4Ycb8yKQ7yZIQ5sEfmKdHLnXihe/cQ?=
 =?us-ascii?Q?7j1O/SdRWnIQxblwOEHtz46iAwXBr5AkLEbo9odIxietOoQ/7z9y1A48ONNU?=
 =?us-ascii?Q?sSofD2wo2O0k123P53KHyGA6wLCRGlQS59KvM3Jyuwnb1kK/lpi+LSuDKFm0?=
 =?us-ascii?Q?KMPI6fGmDlQdwagzJ1GTx0nbMIcpirLIPV51dl/XaJ6s/4Dz2CbQxpwtaggA?=
 =?us-ascii?Q?5xAIrVDDx3xtDVloPxVHB7MIJA4vJxccqSRKjtOQgKtGtc7kt7Vi7zXznhpO?=
 =?us-ascii?Q?PP/UGKJ/yr/qx/erdbVnFPQqMe8oyitGBJf+T4QpBU3RVDkB4/VIupGSa1PJ?=
 =?us-ascii?Q?6X9kQ6ASb3/o+5MrsNuMdWgmL91TUeVFPmur83BpAwS1xaTyl1z5VcsMEahO?=
 =?us-ascii?Q?DJW+wDbk78AegdfZsEPxl7tlnfnsE8/Jc3t6RuQT28GKcAYiXvRttMfObJOb?=
 =?us-ascii?Q?Ts/8KBBOami+FtmLf7Z3Xz5MORsHZI1YdqbK+tGo+8m9mnC2P1ZZ6DusRvga?=
 =?us-ascii?Q?2pxqU45EeUfZX/sajAJ2IdTK5fP/x4oGGkkYctxkKdjy4f2RKlPbqC2nxHaP?=
 =?us-ascii?Q?bzqZevRsDIO+QaigvlmDzqDzrTuTx9m2ql6vbBu3KlQTfaFfCAMhOxnllexi?=
 =?us-ascii?Q?LAYYFchVysOrN6HZWCWcWDkgVeACDgWBgEUZSeOfEnnHFuO4kWBG8Sk+Ug4j?=
 =?us-ascii?Q?07MVBzRxpel7Ou5LeXQOlwyXzhyvAIJV5gZg34JpYPkhJAdMahNB3ttj3EG4?=
 =?us-ascii?Q?FkSG6Y1lqWtA/i9RkJq+ewE5LT8cmJQlEL02VJV5fGCS4/vQjpC7BPC8dE6h?=
 =?us-ascii?Q?1UCbKt/z/itgcAQZVopTUMqsTgoeoc15phrilsXSSjmjGhI3if8CEkd7MPLi?=
 =?us-ascii?Q?bpdlj+S9IYlm63wUOq+rxxtszmgTOm899kIwLO2KTpRWDL31zZVvmoA939gL?=
 =?us-ascii?Q?MW66mIOyn5xfedUyr6XL/IpXIwPf1QOEGypSAgu5A3z05ltb9oTNTc/UXz7C?=
 =?us-ascii?Q?Z0aV5mX/zenH/rbtBSrzOkZNc08t0QYZZqvsNVtj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf7ab68-bb96-4ccf-778d-08db4bcf2eba
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 12:09:02.1292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CkhXxRXequrNf9mhUZoF6yU6eqpK11toTvgDwMkjbm2uQusvP02isIHom/Uxqh8YZ6pJ98el9j9381i3qdG3WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7843
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 03, 2023 at 11:20:40AM +0100, Catalin Marinas wrote:
> On Tue, May 02, 2023 at 06:40:14PM +0100, Catalin Marinas wrote:
> > On Tue, May 02, 2023 at 07:15:20PM +0300, Mike Rapoport wrote:
> > > On Tue, May 02, 2023 at 03:07:41PM +0100, Catalin Marinas wrote:
> > > > On Mon, May 01, 2023 at 04:24:38PM -0500, Justin Forbes wrote:
> > > > 
> > > > Regarding EXPERT, we could drop it and do like the other architectures
> > > > but we'll have randconfig occasionally hitting weird values that won't
> > > > build (like -1). Not sure EXPERT helps here.
> > > 
> > > AFAIU, randconfig does not randomize int values, it's probably random
> > > people that do ;-)
> > 
> > https://lore.kernel.org/r/202303232149.Chh6KhiI-lkp@intel.com
> > 
> > with the randconfig here:
> > 
> > https://download.01.org/0day-ci/archive/20230323/202303232149.Chh6KhiI-lkp@intel.com/config
> 
> You may be right, I can't get my randconfig to set ARCH_FORCE_MAX_ORDER
> to anything other than the default. Maybe the kernel test robot has its
> own config randomisation (cc'ing lkp@intel.com).

Really appologize here, around Mar 23 time period, there's a bug in kernel test
robot code which wrongly set the value of ARCH_FORCE_MAX_ORDER to -1. We fixed
it after noticing this, and replied to the false positive reports we sent out.
But we missed to reply this report to point out it was invalid report.

Sorry about this again, pls ignore this report.

> 
> If we don't care about about this randconfig, I'm fine do drop EXPERT
> from current mainline, together with the 4K/16K pages condition. The
> condition only made sense if we kept the ranges in since these were
> configurable (no range for 64K).
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b1201d25a8a4..1867aba83ba3 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1516,7 +1516,7 @@ config XEN
>  # 16K |       27          |      14      |       13        |         11         |
>  # 64K |       29          |      16      |       13        |         13         |
>  config ARCH_FORCE_MAX_ORDER
> -	int "Order of maximal physically contiguous allocations" if EXPERT && (ARM64_4K_PAGES || ARM64_16K_PAGES)
> +	int "Order of maximal physically contiguous allocations"
>  	default "13" if ARM64_64K_PAGES
>  	default "11" if ARM64_16K_PAGES
>  	default "10"
> 
> -- 
> Catalin
