Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E3C6917F2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 06:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjBJF0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 00:26:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjBJF0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 00:26:10 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2F05A9E4;
        Thu,  9 Feb 2023 21:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676006768; x=1707542768;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ipf94CsLQ+sycHUE+ZLto1hd8PJT9SkxCBl/NWdA8Pw=;
  b=R+EaeEmaYT+kv6kwva+Y8vbcWSACgL/CQjc2HqSrWMfTSLxrmy40LcGt
   kwm+1eArd5lDmx1tU6rBdR91g0WWy/MvuxQtyFXF1z9rtGK7j+KGLRGCx
   KACfNfZjMJHmuZ0BLFkNxZFUbGTyGbb7CfgNVfWS5mudRcBqV9pG+vgaD
   1LjQjK3X0qlNBnVi6VFSgYaWi+0XpgbXNIulFCJ6yfDmhJgUi51MUhpSJ
   LaffczrFnBxrs5Z/z3A1+epR8mw0wkOkgdO2I554Ww0qyMWkoXFGCjvnF
   tcAcM3haQ/MokTIvyLZ1oCNTP655XmPvKjsIlly8TKtbAsxYI6XuHGZQh
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="318358534"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="318358534"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 21:26:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="756661992"
X-IronPort-AV: E=Sophos;i="5.97,286,1669104000"; 
   d="scan'208";a="756661992"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Feb 2023 21:26:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 21:26:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 21:26:07 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 21:26:07 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 9 Feb 2023 21:26:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAIaxsUxev61PbpPJovq7XvrNWPgEadtKGNU54El1+ATVEFtgFrCcZEku0ChGXswZka+tBwZFk3iuZ1wOJlJDJidne/K1U5p4Ac3jV99tLxQAApeVz4pv9zkgj6M3u7SB+SJ4rSitrY3ZWytfKatKRlZPp3p29ewPdR5qF8ivmvGHgymQzqw/+jf5fbFWV3F19MXXHH2NjU/F7y1dwbuCdcpO6k3YtJ1O3EDBjVHZF+E2YpgIGOONQKpG0lpT2DV4iXk95NU0g3ZS5tA9nd0UcL26ryFaIcsquRmIrqA/uLDrFop787gAuAfFeOG+cwrezA2foyHqjmB2k2IZdhwSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4QdHFVbZD1CoINCBKQ0+gEM5jcze/5T94cxI8ZiC/o=;
 b=MXLvrbwIfcWJnSwUKnWQ5k2aQ6mxR0zo+V+D9EQOSIIgOKzsrHlQhgokRyFkI3kdSqr50nu6kbjET1ZogfmWtbt9umv9kc5xuCBgRiOVR1vE2OpRzh4xVJbA0gHL9P2uvzIRgbKqtSXYqXfJSQtWDkoVoEgJ2wC4+L7nLyIj9Ognnuue3RQjF9xL2tObnPU4Crh6zlPZG6/S52QYxJhfUtdgvY8enmjHBh01Pbfoqx72wXp6Ibz0vztDSfU7G6CIi/VIEE8VEuX29XX8BHPh5S3cvhv2J77165Rpk0t+IQ7vSa5cNLk3lCfxiyLm5H79IHc3fGl5pb5V9gkyrr6FdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by IA1PR11MB6514.namprd11.prod.outlook.com (2603:10b6:208:3a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Fri, 10 Feb
 2023 05:26:04 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be%3]) with mapi id 15.20.6064.031; Fri, 10 Feb 2023
 05:26:04 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcu: Keeping rcu-related kthreads running on
 housekeeping CPUS
Thread-Topic: [PATCH v2] rcu: Keeping rcu-related kthreads running on
 housekeeping CPUS
Thread-Index: AQHZPHB1PeN6hngoGkqA2pE7E/WY3K7HVWEAgABP0ZA=
Date:   Fri, 10 Feb 2023 05:26:04 +0000
Message-ID: <PH0PR11MB58803E9D69F2FAC51C5E5589DADE9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230209102730.974465-1-qiang1.zhang@intel.com>
 <Y+WQkmiypKUUUfcj@lothringen>
In-Reply-To: <Y+WQkmiypKUUUfcj@lothringen>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|IA1PR11MB6514:EE_
x-ms-office365-filtering-correlation-id: cccf9ee9-4c25-4ecb-2077-08db0b274ddb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pr1dpQSzNtiDV5oiCtsRfVW+NGy3XJtvIUyPGfVGX20ZryZjE+N0Rz/Y7puYluVWovfpSTL0qz0TtdKuq022jMkS2XSvQjPspQVPTGFbAkuXq231MqOa4XU3tWQObJdTzObZGzXZZJLs+QOQj7XUq7SMckc+W52ZGM0m69GGgqwpvzgWwem5B520w5AUFssgaQo+f3dhqreUk9+Jgp/VEz5yzU0+rcle6Hp/geOD93m1p+p+Fq7qKEjWWS44qyg4l9iahltnmMhg9vZw8HyjUXALmRbs97tpKHX5kLx9xaLTt0xQ9D8s375pMPkyILM95i1VncnH4XncnLW0nxmZva+9QCYa6f+W1Elay8Nx4JQIATlY2FyrQsxUX1DswT+7LN7yFSjA/7vUOj6+r4q91hIxGTzsPRMjLQiOoQvllPXAku44WPMdZj5aZCtm+yWD3JjUlrkfBg8LUBLCCGYgENZ9SQY4dVkh+XBu2C1xw1V7ncRHm3+Wvbi+BjXFSCbZ7gU5T2csxs8aZ3OJ44Mt3L+dMe5a73OhuV1yHDWRKtYsv3OFa1t8IqsaL6J96dZA/xfaOQ+GYUGeTCHv4rohdRcON3HDlItcLpgP5iqZuzT+D05txlztHz+lEAFu4ChhU3mZE7rqM/EgjiC99A7usXp8URLrecfmexDO45Mo0+xPkEcTepkPszsQrg8/QEPARI7RpkcXoNyM5FmmYQqASw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199018)(66476007)(83380400001)(5660300002)(66446008)(2906002)(7696005)(186003)(9686003)(71200400001)(33656002)(41300700001)(6506007)(52536014)(8936002)(64756008)(66556008)(26005)(316002)(478600001)(86362001)(38100700002)(76116006)(38070700005)(55016003)(110136005)(82960400001)(66946007)(54906003)(8676002)(4326008)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cuHTJuWVLplaGQ+YCVbOn3Fl9x3eBVfdodEn0+r6I6ZJklg3Q022IzDBjtbv?=
 =?us-ascii?Q?/UiayjjW7L92f4as/pBwnEpdlpvuJItlFskZ8fHAs2WER8fEIg4geNxhXx2L?=
 =?us-ascii?Q?mvC3n/vpcaXEbKxXyBT+gExtlVbGPx0bZbQDzrNSOA8C1yLr891sxOBumWWK?=
 =?us-ascii?Q?qJSmhI2ThwLRVSj6E00fTsU9APC3mQlRxI/uzZ2AEGrvoEuqRwibqBu6g0rc?=
 =?us-ascii?Q?NbZMuwuWkanMfMcaxjHePtIJYKInb85WhVTkaKPlhdb6BIWLmT76k9wjTP+i?=
 =?us-ascii?Q?z79kLYOBf81jB8mIXVWhsTR5HmPHZK5TVqoTpSoGg7HpTNb7zBpXHEH7qqiu?=
 =?us-ascii?Q?6NibNTjy6c5VvwwsupXV0mmDbu+O98cD+/YtfsyKFsjEiwUITPx1w0SzrBNU?=
 =?us-ascii?Q?0Fm7BaEU+EicrlScKneXkauE0/5852YLG2N6alKAuqINuKg2kRo31C9CIloj?=
 =?us-ascii?Q?tl9XVr43xC8ANifnEzj5cjV0SserROKYBFnt6eGbUlZhtQs7dHjM9VNTDK+1?=
 =?us-ascii?Q?Z9o59gURwNkMxmGTsw2By6ptGH9tc8UqLMr5dSQFcxXDt0+tfw6HW/kZ2JMU?=
 =?us-ascii?Q?0ziKDqTZBmAtcvhV3gHDkQAsrqZ5ehi9MagjIkPRVnI/nxtQK2oyAgos7X96?=
 =?us-ascii?Q?8zfUi+Lgmy56CRyv+k39KqaQR+jGEEo9V++TnBr5Ft7AvjWyXer5uyRiSZXU?=
 =?us-ascii?Q?OaG40p1T2YBZEoGshhdSLiJQ93iAm1abo9IpOZuCuCy9AVLxMBjLlxtaASvT?=
 =?us-ascii?Q?fQYEHFwf5wP6m05NFIpM3h+SU+GkfsqiM1qAI7EXGIgXqIAVq4ry7OFm6/+1?=
 =?us-ascii?Q?67++cL3+vzcCiSqo0gwMICCHv/l9wlx2ok+7Qz57bOVPKWYJ0H43egJp5Nej?=
 =?us-ascii?Q?Q2utrGXhnR8ca4v1hQujlIUVj6uydX/fBtGKHDG3AZplcXLWHCnIi7LfJwIY?=
 =?us-ascii?Q?c4noaevpdI3b1Kml61/O18BdExt7WFSDFXaPjkhluXXVnPYSinSTKO6zLGC0?=
 =?us-ascii?Q?2H5Hpe0h7faJxivE83bJeiKF5bEXj7smCsodcTlvxeGBHD69jCeBcR+xsgcL?=
 =?us-ascii?Q?FnwUOyisRiK5MXm5kPsKgu2ZOgQtg6smT0sU6KH0lTd/stJB8Wni9bzr4GhF?=
 =?us-ascii?Q?cfAqdvT8QhZSDrYggz6AOPoPlsKyi+tN6gmd/a5zLI7JwQ8e3sk7+5YdIZSp?=
 =?us-ascii?Q?QVFOMBTdPGWtRxOJaVQt7Wm4bIHoNOgft33kwyJbJslHBLVkyp6ckxQqOcdU?=
 =?us-ascii?Q?DHpICFICItn74ttWyDrMF0IVZ8e35jwUk0nGbD1DypHUlBVev3pbzHeOF8N3?=
 =?us-ascii?Q?yXpZtbljnD2GOyr/dIHw73TeL+jmBQI5DzlBfq99TEodltw5MI0hsM38aPIq?=
 =?us-ascii?Q?N/ce7nS4RhB4C/5T7VU+gfuLKWMQMGsFk3r78kpuVCqUkQUgPgvad8+g1Hdd?=
 =?us-ascii?Q?iIehqZPeVc/njR555Qitg8oqABFIgaqoc1xEp04t3j7yCA3Hc8pAgGN26aHl?=
 =?us-ascii?Q?wGndlLVIN86ae2FqfpHuxCr/g9/FiW3yMCcYziBfsllLDHkNLcNBivBs+K+2?=
 =?us-ascii?Q?rhKYbUdpTnsSJUDI2mt9esx1eW9ibsDuvH5C9nUT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cccf9ee9-4c25-4ecb-2077-08db0b274ddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 05:26:04.0581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UcvFBeYWtBq01iMLAEX5m4k4aI7PPjgDlb9UeNVW70GxK44E4fd8GBnb5l8/4/el0tL0HDeLv0m/ZHrb+nPyZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6514
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

> For kernels built with CONFIG_NO_HZ_FULL=3Dy and CONFIG_RCU_NOCB_CPU=3Dy,
> when passing cpulist to "isolcpus=3D", "nohz_full=3D" and "rcu_nocbs=3D"
> bootparams, after system starting, the rcu-related kthreads(include
> rcu_gp, rcuog*, rcuop* kthreads etc) will running on housekeeping
> CPUs, but for cpulist contains CPU0, the result will deferent, these
> rcu-related kthreads will be restricted to running on CPU0.
>=20
> Although invoke kthread_create() to spwan rcu-related kthreads and
> when it's starting, invoke set_cpus_allowed_ptr() to allowed cpumaks
> is housekeeping_cpumask(HK_TYPE_KTHREAD), but due to these rcu-related
> kthreads are created before starting other CPUS, that is to say, at
> this time, only CPU0 is online, when these rcu-related kthreads running
> and set allowed cpumaks is housekeeping cpumask, if find that only CPU0
> is online and CPU0 exists in "isolcpus=3D", "nohz_full=3D" and "rcu_nocbs=
=3D"
> bootparams, invoke set_cpus_allowed_ptr() will return error.
>=20
> set_cpus_allowed_ptr()
>  ->__set_cpus_allowed_ptr()
>    ->__set_cpus_allowed_ptr_locked
>      {
>                 bool kthread =3D p->flags & PF_KTHREAD;
>                 ....
>                 if (kthread || is_migration_disabled(p))
>                         cpu_valid_mask =3D cpu_online_mask;
>                 ....
>                 dest_cpu =3D cpumask_any_and_distribute(cpu_valid_mask, c=
tx->new_mask);
>                 if (dest_cpu >=3D nr_cpu_ids) {
>                         ret =3D -EINVAL;
>                         goto out;
>                 }
>                 ....
>      }
>=20
> At this time, only CPU0 is set in the cpu_online_mask, the ctx->new_mask
> is housekeeping cpumask and not contains CPU0, this will result dest_cpu
> is illegal cpu value, the set_cpus_allowed_ptr() will return -EINVAL and
> failed to set housekeeping cpumask.
>=20
> This commit therefore add additional cpus_allowed_ptr() call in CPU hotpl=
ug
> path. and reset the CPU affinity of rcuboost, rcuog, rcuop kthreads after
> all other CPUs are online.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>
>Good catch! But based on that and your other fix, I suspect that
>nohz_full=3D0... has never been seriously used.
>
>A few points:
>
>* This is a problem for kthreads in general. And since HK_TYPE_KTHREAD =3D
>  HK_TYPE_RCU and both are going to be merged in the future, I think we sh=
ould
>  stop handling the RCU kthreads housekeeping affinity from RCU but let th=
e
>  kthread code handle that and also fix the issue from the kthread code.
>  RCU boost may be an exception since we try to enforce some node locality
>  within the housekeeping range. =20

Agree.  indeed, these works that set housekeeping CPU affinity should not b=
e handled by RCU,=20
and not only RCU-related kthreads are affected, other kthreads created earl=
ier also have the
same problem.

>
>* If CPU 0 is isolated and it is the boot CPU, we should wait for a second=
ary
>  CPU to boot before activating nohz_full at all. Unfortunately the nohz_f=
ull
>  code is not yet ready for runtime housekeeping cpumask change but work i=
s
>  in progress (I'm saying that for 10 years...)
>
>* I'm tempted to revert 08ae95f4fd3b (nohz_full: Allow the boot CPU to be
>  nohz_full) since it doesn't work and nobody ever complained?

Yes if remove 08ae95f4fd3b, this problem will disappear.

Thanks
Zqiang

>
>Thanks.
