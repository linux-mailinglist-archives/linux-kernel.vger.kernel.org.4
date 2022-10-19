Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D063C603847
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 04:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJSCxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 22:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiJSCxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 22:53:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9637DE52FA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 19:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666148018; x=1697684018;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=fA1pOuSDZJkeJRtzg3VTvXJQej81Iz8hRrCNxzOSjgU=;
  b=l5FEZQAIAgj3o++jDwgr7hIXT/fBF1ib3NhASON/2Meo8YFMecH7cezd
   REe07WZod3a7njb/JfL9t1zdI4yFK5tzECYsFn4CPgpJsTiIwcnWwMG/c
   wv5dyBA/V+Oaqy+2xoKvz8/lE/YR6soMJUBbk/s7YCGLqIIX4Clscu1cn
   khogUSyLVE9Jt9qdMEUyBlDgBeXFQO4+sEZNnDSiet9UTWXALU06otm5Y
   3GI8udkjOdsmVof96egEkiyRFaBjvVFw05ETGbkEltXNsPf5MvBHtBN/G
   OjXzmW5au80yCVb3Mm2N6Lbiv8gsoc86f65RmeDwWc2Zn/Z0DXMcGYbBJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="392592157"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="392592157"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 19:53:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="718254632"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="718254632"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 18 Oct 2022 19:53:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 19:53:37 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 18 Oct 2022 19:53:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 18 Oct 2022 19:53:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 18 Oct 2022 19:53:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0AU0Ip342mAYCzN3l+Zje5tX+WFTBzUIqACwjv1uIRWOVxnXDnC75LMn1sTc/obZgqqqDnD49uUJBbyN7/3ApfVtGZJr+pOWMRRg12ja91GTqGOrpI9DPooZBa47RIDQD16dIlasxLOptDatta5Sm3tqc+Q+ikyPl8PKfT86cY+ganzUZqzr3+vRvEr5UrjIvRVKxt5dYv0JKIMBVyVAYgJPFz+y0j22fAtdHEGAa1es04NlQiJGfIxOUbC8rQTTudetph+cdqj4DJFDYeE93vQQC1lMv2D7gg4iqRgD75XRhXvVjsrSPbxbGnpfbZsg2QjHkRly0tdFmBvUS3mGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkIDjTqz1fzi6cZF5Ph3eBOORTkPawQrVpFCI2eWI8Q=;
 b=MofdTEcXreIgv/CgwSGLdvlVy1eCYw+xwGxA9+WWQNJX8yVMD4D0x+KhHqh2Qxf9e/vY1Ma86Gnz1M6y5AOjhNZ6A5S4iroDqT4eEgwFKaizcS9eGSES6lorCaMIeOSXFi8wyFrtIiKeTIp+EntzABVQUdVLqy/CHK02tyWnhTeHx2GQyCG1jdxVjs2lvzNJ9kzm00KF07FhNyzb8CS3aMNby/8xT2lvhbmRAUJA41GLpedGlutCGUhBENsGfFLJnr01FvDusEll0uW0MMhBdQIL9w0uxqIwg0445I5BE2QBRDKIFeJxOsRx0e6RTHy43nb5baz/IHkEy7OBN5maRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by BL3PR11MB6362.namprd11.prod.outlook.com (2603:10b6:208:3b5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Wed, 19 Oct
 2022 02:53:35 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::84b8:ae06:56d7:f7ea]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::84b8:ae06:56d7:f7ea%3]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 02:53:35 +0000
Date:   Wed, 19 Oct 2022 10:53:38 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Miklos Szeredi <mszeredi@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <heng.su@intel.com>
Subject: Re: [Syzkaller] INFO: task hung in fuse_lookup with v6.0 kernel in
 guest
Message-ID: <Y09msl1sHoA2Zj7k@xpf.sh.intel.com>
References: <Y00b31dX1mIfgnBP@xpf.sh.intel.com>
 <CAOssrKfakpGguAV=102jpW4m+YfpRx=+cBBO1O43bt3iwJHiSA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAOssrKfakpGguAV=102jpW4m+YfpRx=+cBBO1O43bt3iwJHiSA@mail.gmail.com>
X-ClientProxiedBy: SG2PR01CA0159.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::15) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|BL3PR11MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f1eee6-8a8f-41e2-889a-08dab17d1d7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ySU8RIMinEIYaletYps2eBgZn3z2ZU6mVJdNGIhSZTgumxBQ9mKB7gEUJobpfJi795J3gBpqJvDKpCUS2xj1mwCiFYtK3PkhsmBFiYV2Q+pd5+oABgiS+GcGrlw6mnMQUr4yN/khIDCFx2j+lKhoVvF/z6Tg5601PFYB95I3ZJb5cNC7VlMzeBSCShQ8U4midt6Jd23UCBLTjI8/fAPG1ltRZNHFrFkRoQrlv9GiBGOJeXXS0p3d0oVCuahfRoOJ9TUxoF7/ZBMjeOlGBXEjvJ1hkNAouqdJIjhqzMEJ+c9MGgUfhaPgvdGgSbeUr1l10jyJXU5Xx18R+RQFEiEJyVpwAJC8Ax3/0JsZZ45yn5ryXLmXspwR/5iI5n1V3YSj+MLWcW4Gpu/mlEPUL7G/8psbnyPMr5Jboo3tDpM/x9Ukh8Gksr6I/GQnAJJVPp/IjplGchU1uzO08yHpkcJcQhHiLkPMYzeJSnYQ2RhbNKWogYHy6n1JmlLw3mRX46r4peJwDJsk7Xxz282LkwMFcji3k3z2qs5/Jfl6C7GDyQI+czFQZJRr3Ig7fAEHmFW35fcdlUhnmNzsW4ya5sWAN/D2v+IL6adjp6eHnp8ot2wnagomKFECqBUi05djWiddEnRyhFIsglmbrPuxGpFpd4UvYxWx8PPHtUXGHazg2qh3LqF0yuIwrNNEXMlM3hGbgxKmuJ2LWz4aMhmRU/B2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199015)(2906002)(26005)(186003)(478600001)(6512007)(6506007)(83380400001)(4001150100001)(107886003)(44832011)(5660300002)(53546011)(6916009)(8936002)(66476007)(6486002)(66946007)(8676002)(4326008)(41300700001)(66556008)(316002)(82960400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k/EsK2Qsq0rQcKjuKVFhhGm+EANprww7vdTwGlepF2H+koTDoNIJ2oRRVwga?=
 =?us-ascii?Q?oqO6XldAFOatGbdJJvTo8rlyZxUB5cOb2G1wHhbAAlHayjWZYUjBWtZgrK/t?=
 =?us-ascii?Q?kNgP23QmT2yXBSLayXnMBf1YMuyYf/9HHk2TVRJvqL/tSkzPUAN/t0/XoLWb?=
 =?us-ascii?Q?fnJa4nh3H95Pga2scOoySyn2WQFaKxRrcgghecUBiv699csrPYnwWTTwtMZ6?=
 =?us-ascii?Q?X5rdxuoDkNZqNs+fj4dwgirIwWelWy0pWwv3uG+4IhcbzfKF4iOvGYwo/Q5Y?=
 =?us-ascii?Q?SGfldqi+6xcmcLXxc9lOnukIWQM/ahfUJCzf+KKaS6yq0u/18azMvFmSCWXE?=
 =?us-ascii?Q?fOVhz72V0z04U18waUPd0IdwgkTxaOV5HHkRsSunde0Yoe129Q7/f0z4lMbc?=
 =?us-ascii?Q?mg7Y4HHIRePeHjQynW09knof5cDE9qvVWHlJp5ZaMSMLFSerVAcOfjLdHCad?=
 =?us-ascii?Q?MZS2Ls63KYRvDV2TZPmfng73ZbwWw49p+47TZq0kUyg/eUkmMu/mKlult9WN?=
 =?us-ascii?Q?bR/hZLQGrWcAFWCBys79TrjlP51w9vjNLco7fZIxF2d/gxYiH6Z8is/9dVFm?=
 =?us-ascii?Q?wFY+iC2GEy2nDm2v3eBzvCWMDjjpfTHe3BBHvZhtHklTu3EgL3nCszr5qJv7?=
 =?us-ascii?Q?79CL0eOKhHocVDgQjjlqiZnmJBwYyTRbvq1c6O4X0j5GJEll7dLV5+7iijcJ?=
 =?us-ascii?Q?sIfOq3l/mXZGtrtAosbINGKrnnHEbxj7o2EnYdjk4Vdvv8k6YVcMFQmRAS6t?=
 =?us-ascii?Q?Bigqi/cx1ANmRYc9apVE9mgrbWuj1CpM74KoK0oaY+h/LDqzstLTmpAyHdM7?=
 =?us-ascii?Q?/3VXvbetRluqe6ssUauxuT3CFoGZemu1KaPTk4m70vOx0EiLXMc8hh3pBe37?=
 =?us-ascii?Q?09kGAoWH+X3a/69xBsCSHkPsgio2Y8NOZmvY5tCh647t+V1CIeiDidZywbVk?=
 =?us-ascii?Q?bwfbD8E0eROKcVndZZZEQ3n+sju0A1/yHRPdoFSP5P014iMOYGAk+IuvH1qU?=
 =?us-ascii?Q?1H63BV+7wrl1oySu0Pu252u2to3XRPmqpj7g3Dt8cF9hFUeSQN4zWBTrvck4?=
 =?us-ascii?Q?KdOsFZZsEF/tsJbfs6BtdTOMkVkMnmY/mwZ8wZsxkMVw5YPI/rZtMIhK1ieM?=
 =?us-ascii?Q?FtUcUs4ev6IULiBzsyq//LlURwNQRZB0EDcD/BxMKdPOrLH1d15Gqb28hged?=
 =?us-ascii?Q?NiPVjxjgwe36UOYM7rOVY92D45Ue7rO2dH7sx37qDRvucXniXAQhZCsmyhfA?=
 =?us-ascii?Q?O/qQAo8bdlwajYYerMk7FhXBeVJniuOP1SfLL/RymnTH15aNmazfUNiUrBtr?=
 =?us-ascii?Q?6DQsquNIB3BNJGHLZqUHDvSA4Y3urNRJSii5DtNUHQZq6tfoFvzxUjkjheCw?=
 =?us-ascii?Q?M6HNYCOrfsoxCUSA3M8LYp3x7+uuT7Qa1lcxk1zBzxRHn4Xa9VhpflvS19/E?=
 =?us-ascii?Q?pjENfsJIYyE1jLRYbJp/D+BUYBQHcUHcz19maFMBp7oAuvnk+F7KlUiCfEQ4?=
 =?us-ascii?Q?JCcOwrNbsU8NmsCDD5qOsIvcVWMD12x8o68VVpqiTWV/1eL8V8XGc2Vu1yT2?=
 =?us-ascii?Q?n0+XNB4exbhGFuayoeU2CfGigblUIMUCkVrubc+c?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f1eee6-8a8f-41e2-889a-08dab17d1d7c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 02:53:35.1950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZSSFEs1CZcWa+7jqp8FOxCeZhpEKQClnVhWgP+LWjOcWQaXB7Q5xJ1mS3KAKqXqA0TOChy2UubBUDUdITNYpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6362
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miklos,

On 2022-10-18 at 11:23:17 +0200, Miklos Szeredi wrote:
> On Mon, Oct 17, 2022 at 11:17 AM Pengfei Xu <pengfei.xu@intel.com> wrote:
> >
> > Hi Miklos,
> >
> > Greeting!
> >
> > Platform: Tiger lake CPU platform.
> >
> > We found 1 "task hung in fuse_lookup" issue by syzkaller with v6.0 mainline
> > kernel in guest.
> >
> > Bisected and found the bad commit:
> > "
> > commit:  62dd1fc8cc6b22e3e568be46ebdb817e66f5d6a5
> > fuse: move fget() to fuse_get_tree()
> > "
> >
> > Reproduced code generated by syzkaller, binary, bisect log and all the dmesg
> > info are in attached package.
> 
> Thanks for the report.
> 
> I tried out the reproducer, and the deadlock can be triggered.
> Unfortunately killing the deadlocked processes is not enough, but it
> still should be possible to recover with "echo 1 >
> /sys/fs/fuse/connections/$FUSE_DEV/abort".    In my tests this works,
> so I'm not sure there's anything to fix here.
  Thanks for the solution: "echo 1 >  /sys/fs/fuse/connections/$FUSE_DEV/abort"

> 
> Is there a real life situation where this occurs, or is this just
> triggered with fuzzing?
  It only could be reproduced by repro.c from syzkaller, and we have not
  encountered this problem in real life yet.
  So it's a low priority issue and it's not even clear if it's worth solving?

> 
> I'm wondering why syzbot didn't try aborting using the "abort" file in
> sysfs, AFAICS it does know this trick.
  Yes, maybe syzbot should improve it? :)

  Thanks!
  BR.

> 
> Thanks,
> Miklos
> 
