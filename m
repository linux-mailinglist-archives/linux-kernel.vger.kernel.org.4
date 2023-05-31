Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F47771735E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 03:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbjEaBwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 21:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjEaBwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 21:52:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6515EC
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 18:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685497919; x=1717033919;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MqlXND9E88N68vaLNPIVzAU7D02bBI2LQB+kUsXzEfE=;
  b=DQ89qCtIiizohOnGzhD8+JxmajBo4LBjknSQCaS6ZFWi7RFh7wBklaq8
   T4PO2CFA4UV2Hx5JAFmzNA5xMdMoWvsNIOIcBPfJB06uIgjrQa5F/BsUh
   bsiQJr6jDpF9hVoalZKAU/hVdczyNdkuOimwtmx2xG4heF2BaOQ0kjyLT
   m+WyW11O8EOCyV0iLgjnwCL2w7FnOVWsMEoEf1whvF/WvtQ9gMOF5LhF2
   SqBnVE0zZIY9M/xwa+hiwAZ9gEYo1FXgDltZSnAFWpO6N2RattuxfZ8GT
   3gaYf5pefPTYCsCBTM9a+bzuFey126PKU1VJmDOQBq2sDI300kJecrLhG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="344608169"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="344608169"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 18:51:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="796494315"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="796494315"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 30 May 2023 18:51:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 18:51:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 18:51:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 30 May 2023 18:51:46 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 30 May 2023 18:51:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6Fqv9NpbPn+BrBfKwBn4oVBvQq3nDdSAKFzkU/eOu27nVloeasY1hLexBjiAeMe52TV8fSW4xcJ83wTTz0GUi3qc7HyAZkAxMgJg204udYMNHfJiX7TTEXKCFhyOhr8LvLeriAY7/3YbivZCTSgh2GWMUY8ed6OuBHXdNL40GLVZ+6zHbRlHQPHZEFmyG1FOUMywBzxvX6rRgiw/MYIH9qiw0mW/V971fT9BaX3zc60r7tmkr79QhoO3TedgpgvVulvA2Lu1XlbLkxfW/YOPsFdF5eXKm9sDcQ427DM+la9yXmoPWjj0+G3k0TUDqsp7qI0Q/hSrELxtmNBo2mQkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfPxXIxr/tdZJ3lMl6u/+9IblvycoLdchVVNMbdBdzA=;
 b=aa1YScqkve5x/uEiaLzBvU8oemUKK2lcj02cek0pftqwcYOiLBOX8R2blGGlw12eOSmy9UGlyOoVKwMNS4mDEkUajyi0KytHdTE8ojYUXwIkZGOpVAW97EO8GcUZA4ah7BO4q7J8e4O92UyHtYiwEOZrWWT+F9HSPtWeAA4Ric4N/eMj9sro1vMVFoOyU1VFDQ2a7ikXC5gmzf+MDmMx4vvve1ahZmppzJ63iaollmo+hgQtybq5X8FywmeF2spMVYjsSBbv7gO+tvKeSV8xLLqMsXQbqa3pH8iqX0S4IH5cdPBfil5NvqWtpNlPunqs9JaB8k69BxTq93PeXsK9Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
 by PH0PR11MB7586.namprd11.prod.outlook.com (2603:10b6:510:26e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 01:51:42 +0000
Received: from BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::8be:ff0e:230e:ebf8]) by BL0PR11MB2995.namprd11.prod.outlook.com
 ([fe80::8be:ff0e:230e:ebf8%3]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 01:51:42 +0000
Date:   Wed, 31 May 2023 09:51:31 +0800
From:   Philip Li <philip.li@intel.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
CC:     kernel test robot <lkp@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: vmlinux.o: warning: objtool: vmw_port_hb_in+0x1df: return with
 modified stack frame
Message-ID: <ZHaoI0g7VeeG81tj@rli9-mobl>
References: <202305160128.ULUxagaV-lkp@intel.com>
 <20230530232925.ovvzpoxxeduru4fj@treble>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230530232925.ovvzpoxxeduru4fj@treble>
X-ClientProxiedBy: SG2PR04CA0164.apcprd04.prod.outlook.com (2603:1096:4::26)
 To BL0PR11MB2995.namprd11.prod.outlook.com (2603:10b6:208:7a::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR11MB2995:EE_|PH0PR11MB7586:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e743aa1-fbed-4b63-5b65-08db6179944f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I3QL4111n/R0GECz0gM9c/xICy5LaN+TTOWK8Nw/mK0fH7t/2llIKUTfKWX5U2z4TMgT76ZHGkfc84gJusHAJU6g82UrwCrThV8V0ccxdw9qBthbBha7j8LmJCysofhbTO0TlEWzGB7btJPKRg73E3Wr4agvwZY0Yrq/VFICkxFufVwdLxp/SmgZ5BxJI43AvBlLi6PpU+2mjrHucsJt3i5h3hOipK0XSkREcOvLn50rPGCB+Uz767zcZIZMG7F/2Xxud6MZo5DjLdLR69uqFIaVv4W0XpS6+Gr9pvFAPTZfrvSuunr9toEn3Ow2bncVnWukNs1B2+aNgvXK3ZGNn2tmqPi0e5ceVWeR5SonlkNd5HuS9NssFZgZ2fhSK4R0qIkdzmMDyfdN/Sq85gRrCrI5sXWul7mSVW1VbwBITsj1dNe6YTK1s+93GflWb+IiwrDYcwd7MfjZTwWdWDRy74LBtn5RmqIafNKWpLtlPaD7oArdg0ar3907aYgrxW9FvTDm/KjrsG+tm3sRKMK/EWkQRZqJkoA/pEQaauvCf8aeadwT801ojrFvG1nhq7qX4cgMRxVEIeXPJST1Kxggug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB2995.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199021)(86362001)(54906003)(478600001)(4326008)(316002)(6916009)(66476007)(66946007)(66556008)(966005)(6666004)(5660300002)(6486002)(33716001)(8676002)(8936002)(41300700001)(44832011)(2906002)(38100700002)(82960400001)(186003)(6512007)(26005)(6506007)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M0jQJnjKH3SEv6BbnUqRyt8so8U+e897iocRFOyAAY7vjz6NP4iUcSvy42BK?=
 =?us-ascii?Q?cNHkNpH9o7HMBfBJydhnpHawvGjQRvwzIoFqym3eTANqwka9Q8dIjTTej339?=
 =?us-ascii?Q?Bj1rkBia2+g8kGFJgDGQo6dOy6+jqLY02vh3XH0mLvzoxMYxItHYmyiXuqde?=
 =?us-ascii?Q?+RMqa49r0x9PsrrvVMZpEPH7D8f7g9MQwdLMaTqt0fm5wUjjpllHurWtkpSd?=
 =?us-ascii?Q?M7J2N+KGLYzROIxuq7q3kS40F1vPd1/4LIwOtZJpnzCtfwGkVqsyHHPGcGuT?=
 =?us-ascii?Q?ixrxpmjH0b1WsI9vk+mF9LQK2LLB3ifAphT45UQz0WNK3juxRJ5K8iKgOVQO?=
 =?us-ascii?Q?A9uURqomkle55Gxjmji3Gp1IhVydOjeDqx3taPJB4WVeouXelZvyFLxrP7J2?=
 =?us-ascii?Q?GKX07VwiYb+tYDgvbh2msr1kqU94aiq26LMBUfMDBxon8rRS3QHzOErE/ns7?=
 =?us-ascii?Q?v1V2Iojd9Y+UpVEYVHuCdXq/7NFt9MEtO0lCSlbM8dIqSjlCQLaoCzdHXzCK?=
 =?us-ascii?Q?D5lmB/Kv9Zu/G2HslVi8TQFIsRkMbcLmJ3sLVr2AQlUOum0aZc1Jmk2VDGge?=
 =?us-ascii?Q?0Ux4HPw626Zx8bSmiHbtfNVepLhM+9NYW6HLsXtdiUvG+2TruN7lodXSwQ4i?=
 =?us-ascii?Q?m8+dQB22xqhJoJ2+Kt6BnyDZgKG3qIzSAWl8+130/QnZl45l1qDVodFaAAV4?=
 =?us-ascii?Q?FgnX4DACBwqoVytbWTP+On/cUFp5kdtgKS7iI/5iydkNY9CB5/s+iJ7tuRub?=
 =?us-ascii?Q?LhlPzGAeOGaTZBLBuvOH0ioKuOYjmUJYeAu19RL+x44rUnIUzjrGufbLWsgv?=
 =?us-ascii?Q?X6mwDZmsqT6dZGnF1OBIboleZA9tDYTDlrTBE5fDE64MtNn4Fn9F97fk92pf?=
 =?us-ascii?Q?wgXlp5sdywXn9e9pyWyTXwWpVC0cAhtm2hFWinJMS1iFdzJHjJQ7gvhPwx0e?=
 =?us-ascii?Q?FWiakPhV4zu53neVdpMp3mmjY7EXeFiN8IGla8+4jezkOBDfXsefJYKIGBSv?=
 =?us-ascii?Q?CoXHCQ4WcXBbBnk4zTe/zd72zHqOBO5u+zbLjYLzcr0miaHbb5LSZBOphvnD?=
 =?us-ascii?Q?0O0OhR4BDarrm4aLw6UauuIX0qVhJxBaa5AwjJGW9F24H4kraFxgRu77NOeC?=
 =?us-ascii?Q?iKLKaEu8qCAolnm9i549XqGU2u7HcYtqqoQeKuzLw3CjnJAp+B6SDf8RF16f?=
 =?us-ascii?Q?lmgsk0wXqnEcpOBkyx1vH+lgoyhHmfbGU4vdYXI7Cfahq8Yom2TT0wnqK/Q9?=
 =?us-ascii?Q?pJ6sFWExgyjJHurHfPrN/8CHX8g17YBjwr5Pz2spzEh2ictRdzLomFQDVGbw?=
 =?us-ascii?Q?hJVJfX9rZ9+IYFXr2XqtX/mJpxlKVzDN0bD2MzadWtMHuerGBXvO2mvJUn3i?=
 =?us-ascii?Q?iQJrXUldx0Cdv8OSC6T4fxfQzwbOBlG+ZGFqT141ongyqvym1biDJf+0L3d9?=
 =?us-ascii?Q?vZV7gWElDDUzZRmusjYIXC41ZEreCJH9gzQIpQGktEMAXoOt/YXmmSrIDAst?=
 =?us-ascii?Q?zIX6PE4d4jTSfAp2aa/CukK7GrYu0psYXhDaOJwxKa3GeBIeXyZYFhRPDvbV?=
 =?us-ascii?Q?zrU0baPtxFIyz+GqVAIjuyJOXiDwW+qb+TZy5fZ7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e743aa1-fbed-4b63-5b65-08db6179944f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB2995.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 01:51:41.4196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzM4m6+aGGn57ViC0hD1ju2spL/u90XcXrR9zsFUbm9BK9AJZh645V49HR6xdH6no+SvyYvEU7W22TikPGS8nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7586
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 04:29:25PM -0700, Josh Poimboeuf wrote:
> On Tue, May 16, 2023 at 01:44:48AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6
> > commit: 72064474964724c59ddff58a581a31b1ede75cf9 objtool: Make stack validation frame-pointer-specific
> > date:   1 year, 1 month ago
> > config: x86_64-randconfig-x091-20230515
> > compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> > reproduce (this is a W=1 build):
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=72064474964724c59ddff58a581a31b1ede75cf9
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 72064474964724c59ddff58a581a31b1ede75cf9
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         make W=1 O=build_dir ARCH=x86_64 olddefconfig
> >         make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash
> > 
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Link: https://lore.kernel.org/oe-kbuild-all/202305160128.ULUxagaV-lkp@intel.com/
> 
> A link to the actual config would help...

Hi Josh, here is the link https://lore.kernel.org/oe-kbuild-all/202305160128.ULUxagaV-lkp@intel.com/2-config,
kindly check.

> 
> -- 
> Josh
> 
