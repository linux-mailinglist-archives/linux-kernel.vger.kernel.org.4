Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB66D6CD1FC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 08:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjC2GRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 02:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjC2GRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 02:17:33 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A4C1FE0;
        Tue, 28 Mar 2023 23:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680070651; x=1711606651;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=9MaHQz9qyP6aWqeQzX5cwNBYt+4++zvMuwCFVoi+pBw=;
  b=eRXeaHbnt2ZxnDAONUl5wJ72nqJ7ystkbsXDKJ86xI+C+CLDAaW8VBuq
   Izn3cuJa9sOJodWyp8c6HoasEQ7XC3a+tEKZoVXsK3UPyqN6Eroasd3Vz
   RgQHcddMFXg0SlP+1LI2N6bCjn+IykHfvzwHR+Xc4G1b4v1FyK3X1dZnE
   LxabCrNMwjn2+Aku9esUTcRIPETALNz5nrZb8PkS6nQhvyQcOaeESkewh
   RtJ88CDh4TORDafyQ4nhtPZARro/nQ9CpvRqkoBz7mWA5TIa49UZs4kYX
   0yQ1E3yX7H63lBAsdZVU/j8sRCB8v4q4TUYcRzc4EZZjLXe6sAlKZitZW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="324693004"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="324693004"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 23:17:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="748676396"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="748676396"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 28 Mar 2023 23:17:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 23:17:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 23:17:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 28 Mar 2023 23:17:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 28 Mar 2023 23:17:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BQH3ahW1G7xYAz+5ySqob7Z7qX6mczjfPhnuYTONgWtVZuFBoIZ+KWLYvBPDdsfHhUWgjEAUNYwh4mRYEhbgHj975Ho94WrILPkE6nI7o0l42Rf6XFldLsfIXLwBTaw8jPMlX7XKtK0gldz0guQWsN4yCfnzu2U78ciiyixk2lKLYxre3z2tjf7fSAGl29Eajhmm55rX4tjWDK7SF9P7BJMREpFWsw87s8I9IjT0gXgalvZQ+WiMC5TnSD7suPiih9ZKbwBAmvu4etBtKo5YEm8ucwMCepUOwMqwHV5mKk0j6jfPECijl6eeYTw9BzM53t7MkwJUDMIl0lMXcCO4Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BF9GJe72Nijngios3Zc+DNm7a0ohGdG6d4AvA0bRUb8=;
 b=bUOAIK5tcvbacFuRv4XmaCgfD2YV+06tiYKL6EYgz56tJDft2U/0fBDO4EPcwPT7ep02XheuiiDo7+V7HShxQZzR3igAJHkKIH9PoNjc3cfaVfnPWeGRTv3JK+GhDaZKO0b9AQ+ry9axcUl6honc3tLI66DcQuHMaRty5pW+2U6e4J/n61pOvoVGYSgv2pnp1gYxykvCjbT9EKDSlMGl5iF0U3SautiEvXo/3L0gTIDaMWRRk5eIXrcFbv+ZLkahJxeKo109fbeg+u6mD0pVaJQcORms4qUp9NDlA4ng+LzrlgsImFornRbeVB5tzl9CimsIfgLwvnJf3lKIQtE3hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by MN0PR11MB6009.namprd11.prod.outlook.com (2603:10b6:208:370::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Wed, 29 Mar
 2023 06:17:23 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e073:f89a:39f9:bbf]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::e073:f89a:39f9:bbf%5]) with mapi id 15.20.6222.030; Wed, 29 Mar 2023
 06:17:23 +0000
Date:   Wed, 29 Mar 2023 14:17:09 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Ian Rogers <irogers@google.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Alexander Shishkin" <alexander.shishkin@linux.intel.com>,
        Andres Freund <andres@anarazel.de>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Quentin Monnet" <quentin@isovalent.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Stephane Eranian <eranian@google.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Tom Rix <trix@redhat.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [acme:tmp.perf-tools-next] [perf build] a980755beb:
 perf-sanity-tests.perf.make.fail
Message-ID: <ZCPX5bYv0zK+/a6u@xsang-OptiPlex-9020>
References: <202303222158.8975b36d-oliver.sang@intel.com>
 <CAP-5=fV3x_=6JqVsX8Z_+5bz67de_5JcWX-1B=So18wpMK3r=A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fV3x_=6JqVsX8Z_+5bz67de_5JcWX-1B=So18wpMK3r=A@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0207.apcprd04.prod.outlook.com
 (2603:1096:4:187::9) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|MN0PR11MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b2053e5-d966-478d-353a-08db301d41e0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2m4nJUQB9eeyb6EyoHOf9NjOdoZbdzFGyqtnUkOXFZpEwZWcTrqq9VPZhQ0uEqS/i4b4/4nhI0SNZj33SD6PfpdlanG6JJpcaEnelYwlipy2oCV1t2j5npAtJua4wdL9ekJyPZ4CB4HXUtsis0tpEpv/ScE1nYb2BEWfE2MzYBqt9p2T86qfKdD0FF+r/XMhnsWJixGJ5AHdiDdMThzrYnGaSI6i8X8onL627p3Q+KOP/sIqQiTFGlLq/y6nypp0uvA4to0Lfrm35yt2l8sjS2JdVE2yVp62aeH9dOWeTINRzRdZcOwh1o51A8fIXRmNYyzCbh9SWdFRpaji15vCEfRCrwxfeHg5hjCdJ7eJqjYNoUbbVf9I+MmvI//3ubMGuMb7+m/Aul5lowJFCFjzD005sG8nqWEqwjhxBDIvQI5RwuV0c/d1aUV/8APETHjy7qit1C2Xcc98sC97UlYsQP/kN3PgRWu7bG/Bk18D9yhu404iSk9ScW19sbZ9GPTr54o/oVKSPYDGkLp1uKhu8efTCUGCdvUcYLJ+vO+48ydyTvnAsiA1EtWQWo/ZzpRfbSmEWE/l1KrIr994/3lLgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199021)(33716001)(86362001)(6512007)(26005)(2906002)(83380400001)(6506007)(316002)(44832011)(6666004)(966005)(478600001)(54906003)(66476007)(6486002)(38100700002)(9686003)(6916009)(66946007)(186003)(8676002)(4326008)(8936002)(66556008)(5660300002)(41300700001)(7416002)(53546011)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGVRdlBWblhYQXBsRXlDMXRLcExZUERkSEMyNFNKZ0ptVjhlb0FtcXNReTkz?=
 =?utf-8?B?SVR3bWtZMWw4YitQMllvS29JV204Tk9SMVU3dmRRVkZFMEFjZkpKazZabnND?=
 =?utf-8?B?YXY2TG1BcCtoa0o5d3FmT2NvTEREOVBsckJPRUJ4Y0JoODdtZ05GZUZpdFMy?=
 =?utf-8?B?MFA4WEFrMis1SUZXWDd2T2RGODEwOUdkL3FiUGFKNFArcWdIdnNYWVdlc1NC?=
 =?utf-8?B?OXZBc0xuQmowVlp1amc3MmJxblJOUkNZYXlLV0hkWTVKNUZRUnVKMXUxNEg2?=
 =?utf-8?B?ZmVOOFNtL0hncUpjbDJJSm8rMS9FaGwzdkIzcHRFVCtoZlVrY2pIaUl2bDZM?=
 =?utf-8?B?NzRuZHR3Qkx1dlY2aUZnK053eVdFUlEyUTBxbDNZM2Q1Mkk2VWtvQS9LYlBN?=
 =?utf-8?B?ck0wb0xlblFMczF6NVRrK2xGb3UyOGNwRktiTXFlTzA5aFYyTmRHKzJpM0NJ?=
 =?utf-8?B?U1FObXhiTjBIRVU2OHJLNDFSRzZYTVZobDQzQmdjcnM1ejg3QTBFK2ZTVE5Z?=
 =?utf-8?B?a2wwZ3dxZXpwSkZUeXEycS9zMnpGbDlqOGZXcFhoZkRZcFg5NzY4OG1HUWsz?=
 =?utf-8?B?dXNHNXd3RmcwSFRacVF4VEFBZWYxenBHZFg5S0FRZ3RYRkh0clJxdnlxcy91?=
 =?utf-8?B?Q2VCK0IyWUtVRmNNNWg4WjM5NUVZNnVXSnZTdjZKNkFQRkxkMXRoZFY4RWNK?=
 =?utf-8?B?MEZtR1ZzeGljSE4xdWlRTUhucEF3aW0wdnFadmgzZHF5Ulc0QVorSUxVaVZv?=
 =?utf-8?B?bSs3NEJ5a3JaeENVZFFqamFyTmtHUVRwTm84NVdwQjhOVkxpWlZLdTNVaDIw?=
 =?utf-8?B?Vy9MSFY4enh1bUR5M25FOU90TngyZFcyVjlCMlZ1VUtXdzduS1ZiSTJQMjdz?=
 =?utf-8?B?V1NRaVNPZDJuS3ZLa0lTN2ZzTFcyQTVGd3dCbzlUbnJXS05hbUk0dTVBY3lr?=
 =?utf-8?B?V0JHMVk2UzdqOUhqTW5qQnNoSTJlaWN1eDZlR3NMV0FxR0VjN2t1WDcwWVIz?=
 =?utf-8?B?NXIyNmRTL1BJenVybGZGWk54Z0pDelhyN3d6b1lTTDljTU02L2JBQVYxR01K?=
 =?utf-8?B?NWUzTUlrL09Ic3NRLzNMNGo0ZTRpV01TOEliNnpaODFKblN6a095TkhDdGgr?=
 =?utf-8?B?NHBZZ1ZSWHNMSHZSamFSM1lDL1hrY1YvTTNjTytLcVV2alZ4eUpEOHdyWEY2?=
 =?utf-8?B?TVIzejdTSWNPQjZKdHZDWUFDZmFNYzJmRmdWN3lBb2ZGVHNWNjhJMytvNzRy?=
 =?utf-8?B?SDQxQXpKZGdqektBY0dXS3BXZ2lSWnFoeVE1MVN6emU2VWQ2TTQvRjIyMVd1?=
 =?utf-8?B?MXE3UEhLdEVmYlNRTFg3SDAzbEh0THpDKytKN3p3NFdwK3RTc2JsUHFDWWM0?=
 =?utf-8?B?K2tFU3dFWnpPSGV4OEFDamhZUnFuQ2pDTFkvWEFNcDNEUnBkaDdINlpMZk1u?=
 =?utf-8?B?MlpEUHI3cE8wWlR6OEVJTEpTV05iVGp3N2taSkxEUjFhNzFCU0VUSEk5QlV3?=
 =?utf-8?B?aXdqZnAzaDFNdlhGc2VMMDB3dzBLVFpaM2hEUU1vaCt0bXdMdnRTdlV4NnQ5?=
 =?utf-8?B?VnpoN1BrZXNKRUxSa2ZzckVhLzdFMStseXhyNEltdTUycTBOL3JkVkRnd2hy?=
 =?utf-8?B?VGM5Y1oxVXBuNkk2ZTlYblNtVGJXKzhjNFloblZDcHFzODFBaUZ4TmtveSs5?=
 =?utf-8?B?YmxsYk1wZzdyWUJKRE43NUdCUCtkL1hvd2FTQTFHK0prUWZiL01uajFxckg3?=
 =?utf-8?B?alp0aTVUK0tBQm5ueW5qdnpBa3ExT0ZCVkZlcldkMHJaQjI2QVN5WXp6Mi92?=
 =?utf-8?B?YU5HZWVieEcyUlhmQ090aHlFZXdCSUFoNnlwUTJJekhkUW5QaUxjRUtaLzlp?=
 =?utf-8?B?WjBPMjNRMTZrcTZFU0hPOVUxZlVFM2NwcGgyeXp5UE16YXJRRjRtMmRTRmhJ?=
 =?utf-8?B?RE9QRnhqRyt1WGdkdzhwc3J0ZzRvUU1HOGVRd1BqRTY4MmkwR3BKQ0RSUUlo?=
 =?utf-8?B?Qm5yQis2SGFzOHBnU1N3UStVYkd6aHFpaDV2THBxYjY0dzZ6OGwyaXl4bGFP?=
 =?utf-8?B?MHk3UmhLa0dIUm01TTdFd2NaVkYvWHNCQXVtRVVNVlduSmxEZXhrTVZtaXpH?=
 =?utf-8?B?WDZWeGNCL2VmdU9USXpscjVYMnBGWnZHM0N2Qm1pbUlnekRpK2FzbWJ3alpY?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b2053e5-d966-478d-353a-08db301d41e0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 06:17:22.7011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GeomXBr9qNar1OCZb8iUeA9pDKLCg+p/1nu7fKjF5qLGTp4DtCFbCig1W/ATiy1GwA7Y39M//RvC1CMsJTuBtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6009
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Ian,

On Wed, Mar 22, 2023 at 09:03:28AM -0700, Ian Rogers wrote:
> On Wed, Mar 22, 2023 at 7:20 AM kernel test robot <oliver.sang@intel.com> wrote:
> >
> >
> > Greeting,
> >
> > FYI, we noticed perf-sanity-tests.perf.make.fail due to commit (built with gcc-11):
> >
> > commit: a980755beb5aca9002e1c95ba519b83a44242b5b ("perf build: Make BUILD_BPF_SKEL default, rename to NO_BPF_SKEL")
> > https://git.kernel.org/cgit/linux/kernel/git/acme/linux.git tmp.perf-tools-next
> >
> > in testcase: perf-sanity-tests
> > version: perf-x86_64-e8d018dd0257-1_20230320
> > with following parameters:
> >
> >         perf_compiler: clang
> >
> > [   98.290078][  T246] make perf failed
> 
> Hi Oliver,
> 
> Could we add NO_BPF_SKEL=1 to the build flags? The idea with changing
> the default is that is what most users want and so we want the BPF
> skeleton to be opt-out rather than opt-in.

Thanks a lot for guidance!

I added NO_BPF_SKEL=1 then make perf can pass upon this commit.
I also tried to add BUILD_BPF_SKEL=1 while make perf for parent, it will fail.

since you said in commit message
"BPF skeleton support is now key to a number of perf features."
we will start to fix make issue.

Thanks!

> 
> Thanks,
> Ian
> 
> >
> > To reproduce:
> >
> >         git clone https://github.com/intel/lkp-tests.git
> >         cd lkp-tests
> >         sudo bin/lkp install job.yaml           # job file is attached in this email
> >         bin/lkp split-job --compatible job.yaml # generate the yaml file for lkp run
> >         sudo bin/lkp run generated-yaml-file
> >
> >         # if come across any failure that blocks the test,
> >         # please remove ~/.lkp and /lkp dir to run from a clean state.
> >
> >
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests
> >
> >
> 
