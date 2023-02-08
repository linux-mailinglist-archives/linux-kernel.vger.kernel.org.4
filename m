Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C2968E929
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjBHHkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjBHHkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:40:31 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F5D1734
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 23:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675842029; x=1707378029;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0R5f6LwlrfI1k2EIFaYLtxMKf8jESoh/H3BHnQsQhZQ=;
  b=Al3EYJU0Z4C0X66sXNVg/7mLbn5nT/WSkIQYUA+D9IZj48k8V3DpavCY
   Yj5KzcWlAjXogYmX41KTiE+S6Vxh3Y1L0zS5MzkCX1QvhFXXHZ2mYeO24
   Y+SZoqVUPjPBUNOKrI0bxOfhjXxRVwcsjTniZdiuF7PNJSoCcNQzwsKaK
   QvpDRqw6ZjEev8OE+qx6xdK8Qe2c3Nh8WEoFDHdj/fzRHXnC05Fngbral
   gvB24g/YrbWI8vE9y+Rfofai0GlciioIat9ln7IS76Hql245L+Iemjc9e
   suKhOadjgp7eZrmzAI6vgTnHfZ5pPG100guItK57W8pJqbGjq53V/D3v8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="357121774"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="357121774"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 23:40:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="775907094"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="775907094"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 07 Feb 2023 23:40:28 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 23:40:28 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 23:40:27 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 7 Feb 2023 23:40:27 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 7 Feb 2023 23:40:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOMlj1xBl52XAnX+Ny/qbPQaqnFOoe7PtZ1g9FNWaluHuF5JIbe6nCn6zH9oQG8H1ESpVfvo6QEs+0mfTTxHSUOX2wlBW+pUH2s4OEI8j5xo8tVE8tZ/HoHDNnFXjtsA18JMEtpew0iQhH1z/p51U65+vXqlkYQuHZ+QqQWqViC6IIoLoRaxuSOq+hvkvc8ZHgfXuEDum6cCPqt8bAdTNTurJ9jwL7bkWpny+gShiLfOsh0jCt+3HqY/Bcwhm0OgyoNiToEv+FnNkqZkFlzWgG+fCt+TYopAamlvdG+sM+byM/nqvczIwXnI1FZ5nmiSicMbHYK6e7eO1twlx30yYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+9EckUKxjEuUO3qT9/UeTJKeX0s+EUPzjzIzGq1G3A=;
 b=D9CzfapcIQXrxZU5pIoXpbgVQxcCZ/ksKyKV8nIXVevUj+w+m9efh1CNMif3CGQJ6ZOt/W01OcwoljUiV2vQm6UfJwecpp44mjF4hZ8iH+v5QW8bpsNj1QyrqUZuL9skCpJ9BUmWg8LHlLESoPmhTA34rhsWQ4jtrEE/AtS6i9u1n6NBicD3pAtafyic169Pogqf6IB3Y11Q/lm5F6/UVZSsNkB2J6ONzMVDyXJC2oogxy6niQz+3Qdtz620tyNQN/+DRgMEfFH65EwUld9wlUMQIfSNykcbuWmM6wYmUiNuy1gfbucMYhseFfpolx0k5NGAzgewpbW3WOmFSAcOlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by CO6PR11MB5620.namprd11.prod.outlook.com (2603:10b6:303:13e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Wed, 8 Feb
 2023 07:40:25 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::30e3:a7ab:35ba:93bb]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::30e3:a7ab:35ba:93bb%8]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 07:40:25 +0000
Date:   Wed, 8 Feb 2023 15:37:52 +0800
From:   Yujie Liu <yujie.liu@intel.com>
To:     Nathan Chancellor <nathan@kernel.org>
CC:     kernel test robot <lkp@intel.com>,
        "Jason A. Donenfeld" <zx2c4@kernel.org>, <llvm@lists.linux.dev>,
        <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: arch/x86/crypto/curve25519-x86_64.c:609:3: error: inline
 assembly requires more registers than available
Message-ID: <Y+NRUJ4Q/hJmT2Yh@yujie-X299>
References: <202302062324.HhzEZCF7-lkp@intel.com>
 <Y+EwHnWsubeQ0qjh@dev-arch.thelio-3990X>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y+EwHnWsubeQ0qjh@dev-arch.thelio-3990X>
X-ClientProxiedBy: SG2PR01CA0125.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::29) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|CO6PR11MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: 2efe0348-7edc-441b-d0a9-08db09a7bdf1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xz0UGgfMKc1xhuWZHM/FYBLGUovxExlUNerHUEM22n2TuNI+hO/m6YFPfgDocpXAVPL8Zf0xlaVJ+pAyDkoSHklmDIcCsmAgtgp98b7ZWJ85baxjYmZPYJNmtqqmH7dO5OnHulJ+t/Yk5tvjB/rHJBGJTpCppT1VsNdrY70MStgDI3ma6ftymJdhMb6jd927PmW3TkBBs7znn4rKH7IAzOs253/1uXy4kWinyzZWHRY2tdPvkNjF0oXHMXXhTdWjc3jKqvnHN8Or2rNEv0Z8zxpjAva/ICfEBLDOnpmEv7bylPp5X+KhNycIu8Tbr43Rnj0wBJjR7AEiO4krYKddmuZyV35VVnoroUR9zc0dS8s5Xwt/oDXI6/QxN6+pkZIpgvaM3YT45UXoqVDTMmiq6WwKVi4lvgVDaJyTnUhS86G0Exrfi5CLS40Z10LglT37c95Iuh0tl0+cVBAUrx/0PJ/4hfO9Z+IoIS1TWkqAEmLqq8gRHbd1xJ/Gw78bWhkX5nEsLwGdY8h3srGG0jISXKbHKYSTEPxRS29itiLZ83UIYjST0qLLAAkmO+ZqUe904Cmi8/Qv50RG4xbQx/oVO3ePfr1pklZLYqzmzYfF31Wv3O6q4TaXj01+2l8YF3/W5Fu7OcHwDNeRroOgeeufzOLsex/rV2GvZ05GsQQUoJb9FjDWyh9vo7c4y1bYOm5Oy/LppvD3AEpr8sPXMPhtxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199018)(316002)(83380400001)(2906002)(26005)(33716001)(41300700001)(478600001)(54906003)(38100700002)(6512007)(6486002)(966005)(186003)(44832011)(9686003)(86362001)(6666004)(8936002)(6506007)(5660300002)(4326008)(6916009)(8676002)(82960400001)(66556008)(66476007)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PI1k7gS/8Kzc9DTgB+tvSEjnko1DO6qRMqmU1CcxcFuf7c0YgDEHOoyKiFte?=
 =?us-ascii?Q?GahfBezocDALnQYhcPU7VoPmQ2yPXl7EzO3XsqyOJ6W7SfQyz3QEqsARysN6?=
 =?us-ascii?Q?zfz7nKJlqxSY0/kzgFuwT4dl5NqK0LzVU1b+uG4O7o+YQxMoPt+w8TVBh9wO?=
 =?us-ascii?Q?ov4CDEoYjGM3cId0qO8cZk6nxQvUtlH/2OznGsqE+HtzCnNh30WLG78gtwXl?=
 =?us-ascii?Q?Ei6P4LGptJ2UpA0u3SYHwlyv+8a4Q7B17QMOl+x2y03J3r/tQpE2ydtT5y4S?=
 =?us-ascii?Q?t+EGj3BuZbqdgR6F5bdxkKvqjlXQWeGK/Q/sXa8gluebDgUvJeLhyPTuovoU?=
 =?us-ascii?Q?a+LdDphjsUQLjAHub6JOftWM65pQM8HIDJAVKatN+5lnxFsfvnHlLC2mDNnM?=
 =?us-ascii?Q?+s1wQ+LMRPcY5M1Em9p7RhtNOgulWhzkjaJJPOL3aDlbtooB1Rnv6fElSOo3?=
 =?us-ascii?Q?3C93GdESq20qCGWzWxdFTpMARNxhM2Ac3YHCK2b98aSqaZei3GDyTulhDr7d?=
 =?us-ascii?Q?kIS+XYRwd6tHfIH/SlpfJX/w+PfU2QJBjySgNnUpwG2+6CvHujKNEzuPRRW5?=
 =?us-ascii?Q?UR49PgSZnN7cFd8j1wkKkrZgF3jjv3Tyme4Y1faTfEqPCKvwCObdlEL1PSaP?=
 =?us-ascii?Q?DyiPklhrAXgxARnsV87uVyZILBA8Wk7z0a1Qz6iUJzdk1TdL9xTO1xASF9eX?=
 =?us-ascii?Q?zO6Sm4l3UDLV7OSCwxWEfNhEbnD7H2SdMdsh9W5zJvL9zUK/aeveWE9EIAog?=
 =?us-ascii?Q?zLioZZTR+bwT59UI4AnoxWYJ7drvdX0PzY8lKIs2CVNW+9xQF5K0i9jjkZa5?=
 =?us-ascii?Q?xT3D/TlkC46UoTMsQh8qscqUh9HDEhebw9Ge2OfFLdo2CheaEF+kymZnFaAw?=
 =?us-ascii?Q?EReh4gJifrGhHyzAyQGtSoVOljgy3DzMIEP6fSAr1BDeZruPCYCwxmEjh0V5?=
 =?us-ascii?Q?WqAsTZ2UaYUrb8N5CLvX+EfncEdQOzMlv3ebtjXa3A2bl1t1+wZBmtB/kwwO?=
 =?us-ascii?Q?wv0Q/+vs7oQqujsL6SjfVS86PT+xJaxQMOnT8F7sk/1r6pKOIPqo7ow9RiSM?=
 =?us-ascii?Q?3m+VLsp6cjZ/VuONztrkB23NewDDmwXpP9loFhpDbpIMDleffsujN7n5C0Ng?=
 =?us-ascii?Q?udEXHV9DwXfDypky1GKswFQgmntmRWZ8hqxjqRiuy7AqiBQtP3FniIB5dK/u?=
 =?us-ascii?Q?aUr6Xu/ydKdKVZ12WDn/2bjOFjDYsOdwrOduAIzqLBmrL3IvOkVlt6Rjpmuk?=
 =?us-ascii?Q?RsWLDM8RhI2WWskisJTbVCen4VCTfNKW0bjPbA8oCSMM9yitA6PFq7zEPGlR?=
 =?us-ascii?Q?9cEldz2U6lkCoBPdohfe/OexCSKkp6t1/0HAjIz6l1M7KbgkrezhNaCkGxSV?=
 =?us-ascii?Q?8DaplBEov7z9VY3lkc4TiVAwuFZg3b4yAXRtW3QkdmqjtrEAEe2wdy/4x2EO?=
 =?us-ascii?Q?/k2qDdB6a+g9o+6dJCrMI9F0l0Vptvg3E4XYlUL0Kgm+dRyiib9gNixHPAEE?=
 =?us-ascii?Q?ntX05OPG+w08zH15CQhU7DgYO+uZLjdTW01ig4c+g2tO/Q1P1pyqVBUSlw9P?=
 =?us-ascii?Q?seNdTJ6gQY11j4ehBemANmu0gX0hyPy9E1c4FIWz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efe0348-7edc-441b-d0a9-08db09a7bdf1
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 07:40:25.6330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7zy8FInl+5gi1YHHzUNRUsEOVkOBh42sPCyzAlt3hNkfyWcSXQ0VKKn7cr9XecnarGiQdugAPBMo8mxIRvwWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5620
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 09:51:42AM -0700, Nathan Chancellor wrote:
> On Mon, Feb 06, 2023 at 11:52:01PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   d2d11f342b179f1894a901f143ec7c008caba43e
> > commit: 07b586fe06625b0b610dc3d3a969c51913d143d4 crypto: x86/curve25519 - replace with formally verified implementation
> > date:   3 years ago
> > config: x86_64-buildonly-randconfig-r006-20230206 (https://download.01.org/0day-ci/archive/20230206/202302062324.HhzEZCF7-lkp@intel.com/config)
> > compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07b586fe06625b0b610dc3d3a969c51913d143d4
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 07b586fe06625b0b610dc3d3a969c51913d143d4
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/crypto/
> > 
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    arch/x86/crypto/curve25519-x86_64.c:954:6: warning: variable 'carry' set but not used [-Wunused-but-set-variable]
> >            u64 carry;
> >                ^
> >    arch/x86/crypto/curve25519-x86_64.c:951:6: warning: variable 'carry0' set but not used [-Wunused-but-set-variable]
> >            u64 carry0;
> >                ^
> > >> arch/x86/crypto/curve25519-x86_64.c:609:3: error: inline assembly requires more registers than available
> >                    "  movq 0(%1), %%rdx;"                                       /* f[0] */
> >                    ^
> > >> arch/x86/crypto/curve25519-x86_64.c:609:3: error: inline assembly requires more registers than available
> >    2 warnings and 2 errors generated.
> 
> https://github.com/ClangBuiltLinux/linux/issues/1589
> 
> Intel folks, this can probably just be sent to our list from now on.

Sorry for repeat reporting this clang issue to kernel developers. We've
added a new rule to send similar reports to llvm list only.

--
Best Regards,
Yujie
