Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8B56585CC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 19:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbiL1Sgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 13:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiL1Sgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 13:36:35 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA65613E0A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 10:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672252594; x=1703788594;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ur8MBZstW+Pbk28uTVSCdj7qAJw27dj9lQtgJkctmNs=;
  b=Hv3AG2rj1EDAdtfHSFH/NeyJFKs4MjiDwBhIsvsmyq5cyNIJYkp3Djlu
   Sn0E3OmjohlPVnrij37Mn7lblDuZ9COT9f3or8UY3476qGpXe2NZDsiIt
   bcHlOj7qEtc+S6nq/FD2OSFe4UZFbppLJ3Eq5IK8IJ50R8Hy1q+9S6E9U
   zfEvxW4rUDVgBq6xZBTeydhJIJA0wDOUJZDhYTA70SloJIzBKZG9Tob2d
   sxtzkAlavy6R1fpdqhkIOEbjLZXsKy7mHBv+9PkIDqyGwSjkrwSdJsT1g
   HBu6Q9fbwOi+omUb5KylN0U9yEtKK1she93Cv3bvNgzk8EbLtII4jzJLz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="322154337"
X-IronPort-AV: E=Sophos;i="5.96,281,1665471600"; 
   d="scan'208";a="322154337"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 10:36:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="982153212"
X-IronPort-AV: E=Sophos;i="5.96,281,1665471600"; 
   d="scan'208";a="982153212"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 28 Dec 2022 10:36:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 28 Dec 2022 10:36:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 28 Dec 2022 10:36:32 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 28 Dec 2022 10:36:32 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 28 Dec 2022 10:36:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8bRJjEQSq0I1MC0v0OL4OZQZ8LqmHBg60kUcv1YdabAo/fIu+vdoiOSLvTKi73h5MJqON+VtK5SGGnUrytAdKrKzwyqDcscNYrFbAqY4z2ki3HKudGaNgjQ3n+Ds/SQneV9Etqe11OfPRKEMwTzqr0aMC6Sn+Mm1ts9QsFsfwrTT5gB94KbMQDcX0J6K4XQBdPP8LIxc/RQZITio4JPEK622Yp/g0nFzvgfc+slXL/eNuE37947Zm3G/SutjIrENSTaOxrwq/Klt4Y+y2JYcySjabL2jE1Hil9cmOr74zyCWpXRMs0VXPxDDRglz4V/jOIHTBWgpAm6DJzE0eVYiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9Ede9Silf7iREblB00+Yhhq+bHPzQm259GIGTRbC54=;
 b=gYsGp5I1kchPxWW1c3OSiFLX5Y1vo51mPZgXuBoROrHJLqEXdwDBZbX/DgYd36RqPAsC9QrOCO31aDckr3yWAr+VfT/B3wmlwlpyZn9zAdE4tVfNwvkCkmEK5XyBbLpaAKoiNfhFYYldiObBVH7/4/9oCc3smYfsXIFsQkbbdVR+KnLTVOHxaE6BwpYxRpM+min7zglpQbaix68kLIp0Bazf1624YKR8GAyCR7MNgpUnpBByeqpHX2NhSB+ixBbuEmagNpE0GDnHCMi964XQogpDCpydurbQwosT1L8JMtQwiY26i2ZvwJFBYzf2nQ3V8cRNCMBBlF+De2gMJsmwWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by SA1PR11MB6942.namprd11.prod.outlook.com (2603:10b6:806:2bf::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.13; Wed, 28 Dec
 2022 18:36:24 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::570c:84d0:3c30:3282%7]) with mapi id 15.20.5944.016; Wed, 28 Dec 2022
 18:36:24 +0000
Date:   Wed, 28 Dec 2022 10:36:22 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v3 2/2] x86/microcode/core: Take a snapshot before and
 after applying microcode
Message-ID: <Y6yMpt+RMUL3Cqu1@a4bf019067fa.jf.intel.com>
References: <Y6tMgcU2aGbx/6yt@zn.tnic>
 <20221227210144.5112-2-ashok.raj@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221227210144.5112-2-ashok.raj@intel.com>
X-ClientProxiedBy: BYAPR08CA0054.namprd08.prod.outlook.com
 (2603:10b6:a03:117::31) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|SA1PR11MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: 400de523-2efb-4c32-c05a-08dae9026c48
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eDpVJN4YxQ+3JyfGYR+Gmc66uYcdXRmm/gC3OO08VhW/YO/UfjqZDzmBbDEgie1NW2oJ0hChTVPVbPWvyCYMpikf5qZKYY1nwjflPW4XHFnXxl0jmh5/m9/BWbFEnh+YRgPqv/+XZRgIyU8+qtUkk4pQBbdsE7XcqTmO9Mwll17IwzvJwijA2kv+GTluNP1MxpL3gbCswAyK4Xrk/rJHOSfBKtA7cRGx9qRpCOIROXEZ7Uh6xlHcBtVtYO58NxWULifx8klliiVR/ABNuJ7XCL0eaGLjDUKH98wryE5x5CENL2VE+PUK3r/kRc4SIKI+vX0arTgvmDGCLz/FdzbH6owaX1J/cV83+INjgbXCx8t2MXTvdBhy8JMuw98lNN/nlS6x5FMnpCm+ii2lmNGp5O/CAI/ahedaw5ck+CNHDPNpMXU3yn2sauZiS6E7qvwPCTCD/lLfZeS78GLttdYB4JaJB9bEhtrZLxKYfaLMMDTl+17lt06060xdflgqqg444m50+D1mGFOuJ6Y/aqToZlEd9aF0UkTeEwqZBENoJWoAKDGs2Lnpbf9/V6CJeFdJ4KOag9F4p8jm8TgpIFB0FKwN5YN96/Y3TJMICD7JMxG0DwUCp730gnA3DpCgosdoQttCDhNnJGBEryyZx33vz5Ff4a2ZWnb93E14eaz5G8hHgZL07LUglFnPuK1kWpm/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199015)(107886003)(110136005)(186003)(6512007)(26005)(316002)(86362001)(6486002)(6506007)(54906003)(478600001)(66476007)(66556008)(66946007)(4326008)(8676002)(41300700001)(83380400001)(5660300002)(8936002)(4744005)(2906002)(82960400001)(38100700002)(44832011)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?djljX7fYH8z5HxOH+0kHfDhWx4/q/4na8m09/45umxfeBv25uAcobv8j5IoY?=
 =?us-ascii?Q?Gfk8XQTZSvycxo+0iHsMAbRlc/HK0ckV3ZXoTaEOdxiwoS9PTRf1Pop6ztDu?=
 =?us-ascii?Q?yXi7BCAY3mEXn5SnAucjRdRYPFqMos9VaPBekIsnbREpOt5Oc7/NR2Z9FU/4?=
 =?us-ascii?Q?xUvmRvO/cvEXWDGvTEG2i2LZ8lrQbxCDHkkP+S4kMblXeMcbMRUvSVLR1wFN?=
 =?us-ascii?Q?Zu0Dc0rT70GwOvMOTeAnkmHoC7FIBDEobxLTGs6V0H56SGr7Tv9HvDpTkcXS?=
 =?us-ascii?Q?buQFfCafA0ePmCFsG+zTDcBpPXihvi4op7cg2HqCsJfxie2oiSFn0X86COnC?=
 =?us-ascii?Q?fF3kfDuI0S7FCmJ8alkSUB6stEBezf6AUez6boea52vfScWy4qgsU1lrkGh+?=
 =?us-ascii?Q?FY8rsK57N87voWoQ3c3pH8KxTqWTbawsPKNd1wXZI1R1iX2td/XqidPa+HD6?=
 =?us-ascii?Q?kS0vLzf9qCTJ2UADfv1RQewIRYCwS8E6KSbi/M2wOA0El8yg6wKqv5tKnfOl?=
 =?us-ascii?Q?JXySVaTThkx+4stCoD+FjrrMHe0jEEuw7Kcu4sXdHQ3JYAoIkXjmAmweSz2h?=
 =?us-ascii?Q?Obv6z6OGU/4o5/u9QX/iHAnYPHq4PfuGZKbLP2eh3LZaVCiayu4nWJGNVWff?=
 =?us-ascii?Q?cM89qSxgtPjMwTlwC7KYqBI/E7G7055uYkV9vb9mX29ShT8gQk9tpl3SYSya?=
 =?us-ascii?Q?trLLT6IwqXE2o5pNnB4bY+eB5vDYIDqWkcDYU3ynGBnbPqSJ5SZHkUtqjFIv?=
 =?us-ascii?Q?LIX5wv7h2jEyoTJRE43PCzmVgMcwSSRRkeC+1ypwBIKZbzPMD9KL8xGv5AGS?=
 =?us-ascii?Q?5CS9C3JEi7aGxVLTe+55NBINBKMmEuRuV1Do5rbQWrGZUNItJ4t1AqZc8tzj?=
 =?us-ascii?Q?5K7yvtlhUvxu06mWOE4AebSsBdP7bK0qdFY/HTY3oNrU+kl9pY+Npfh/JUbU?=
 =?us-ascii?Q?YI0Y1ZNgc7dD/5Ntud6ErhbUhhnmoRy79yx+YE5H/2E3CwqHK5a2toi983ZN?=
 =?us-ascii?Q?Gwx4FSGn4Dt9YzU+yVVelwPWMh9Np1/CaLTA3EeiUTnGRusf7OZP6uYrRAZu?=
 =?us-ascii?Q?lxxizHNzWj2ALAAOaroUqyL3bqcn/onlprD1oDj/FkgBMgYAl20tzorTe+wh?=
 =?us-ascii?Q?wY+jN/5A599na+2nOivQr+DRLe9KZpDQLFVPsrwwlQnyu033oLoJshCi1PNZ?=
 =?us-ascii?Q?MSscX0MCPHOFioZZAGaW0Upj4kPW5ZW2s/RS14Ugix3iPcRIpNWvbJGYS3z5?=
 =?us-ascii?Q?QZ3eCfLs856Z/U5suBlGckaiT+b0Su6TQTEXSa+5Vf8caKxhBY8Vx3zvx2mD?=
 =?us-ascii?Q?9NM77sKw8Pxot5gE7ZMGxB2+YiHCi3t7R+hrE/sy9rEl+oR1ebEm1q78VmTS?=
 =?us-ascii?Q?1JT7S0NhEN0n8aTCjgzAjC7guqkB0RwQX4Kbg+lECgEime1MFHYeIdxzfjLM?=
 =?us-ascii?Q?MuaOgpJKWTmGxRoYD4lus2uxtP36uuxaVar9nuBMRj16Vi2TEQ9XtylEk9Gn?=
 =?us-ascii?Q?DqLSGFuU9955RA4g1Jsce3+YTlNU/NhfZOzViK1Rfc9ufQlEwO+gF8pFRJGl?=
 =?us-ascii?Q?6yA0zTyR9aV+nP7o81C0jv8BRA8g4kSZLTORN36XDmLDZvkFu5TCc8SjViJJ?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 400de523-2efb-4c32-c05a-08dae9026c48
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2022 18:36:24.3822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZI1INlocMBQOiWi81hr9InpWXbPBiqVhU7VTldURzquEr59CCQhwLcZo1JZlKuE2+RQ0CbecNxGMUQtOUgt7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6942
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

On Tue, Dec 27, 2022 at 01:01:44PM -0800, Ashok Raj wrote:
> The kernel caches features about each CPU's features at boot in an
> x86_capability[] structure. The microcode update takes one snapshot and
> compares it with the saved copy at boot.
> 
> However, the capabilities in the boot copy can be turned off as a result of
> certain command line parameters or configuration restrictions. This can
> cause a mismatch when comparing the values before and after the microcode
> update.
> 
> microcode_check() is called after an update to report any previously
> cached CPUID bits might have changed due to the update.
> 

I'll send you a clean version. Somehow this picked up an interim change and
the change to microcode_check() is not there. I remember testing but it
happened to be a different system I updated. 

I'll send something after the new years.. working during holidays isn't
efficient :-(.


Cheers,
Ashok
