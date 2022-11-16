Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8493C62CEAD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbiKPXYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238463AbiKPXY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:24:26 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F736BDEA;
        Wed, 16 Nov 2022 15:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668641051; x=1700177051;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kQpWnlp6Zn5Irb6i5E3MTGO7IyRinTIvH3lzJxtI14U=;
  b=PefcKU3ZAw9j8d51AcnNVYMa60TesWGFA8YEB0SMNrbCMTGByRoG8V76
   65lnXxLpddwUgt8UyUC9hl3iqB/8nzAmSKBJvrCZkGAk6FUjXZuvMicjI
   e9Yi3kNc9vrNqxcaMgXGm6x46l6NNPY4OfcP3qG54znPpSitBErg1i8vq
   JMquqK0k/ataq2+JYpBWWuZxaeEIAYm0wbKvV3le6zHvtsmwzUufiLdXN
   1Q1O9tARMc5xIhvf4tWXfu/0LuKBIB37ncUo2V7ia1/5rD6lSzZdQpAl9
   7c3sgRbDxoVzZKbpaamU5KxjkUBiS+hBuGkh2SAfRVCs0BRTW+gfzbjNw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="300227659"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="300227659"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 15:23:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="590379237"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="590379237"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 16 Nov 2022 15:23:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 15:23:37 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 15:23:37 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 15:23:37 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 15:23:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIviNqDmdLIleF5RfEyYtN6Pgs2HEzhOqQUSAjt28oR/hH8v3YqlxxKl50A15+WT66alrwY1Lzc+vMNRuqpyobzq8A2t1701dNYyE0PK+yQ5SAoyq0QhQAGiBJL560epCQ3WqcqFfjRCdcYd+8aR+zgTfiMbftwZdNkrmeTtIrXGa6jLOOiAUNZIKJyB4YGq4RX2vVpqeK7a3D+tOArLAql0nyTndsS9AlJHhxWTlURi5kfDFAIojcDgjF+RjFc7KRswSacLDJKWQgvdBsXVcW8zYTnQd3gCvW8tJ3ZQzsnj6wZ67rLEqRU3vHpKjKUs/uYtpqd4YUKQTk2auxdhWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PikRmKgwtOkxiuQRmSJTLlJWeU1nFEstiBRaEKN0qzI=;
 b=oY5blwPJ3HyDjOnIgHjN/gEIBLqAzIpp//YOqTHwekfPh5E2evTlHbmpmCVQZ8Z6RVpB6FV1Lk67pzhnySPCoCOCOn6g/bgG0sALLd3Ij+SScXs3hWmGL6r+jn3PgrTz+k4ggLYUZGuOt/qDqFx0MsmyUvUQXv2tqdU1s7t8lOJU/T/CIcO8/M3j5jPTbtuXfcJKllpULw8x66X83m9MyKFLjo5BuQnnC4QjIfPynxWZGOHO8MvZKTf5RD5ztjfWJUvuN6LdIt0Yz7hMYfdDcMRdbXmc4z6wHxZfH36VSPV3HjFVB9gxLcUVySXH5cLFGKpOyWnsdSRyDI3snW5i/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by MW3PR11MB4714.namprd11.prod.outlook.com (2603:10b6:303:5d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 23:23:35 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::8f92:b03a:1de2:e315%4]) with mapi id 15.20.5813.018; Wed, 16 Nov 2022
 23:23:35 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Avoid invalid wakeup for rcuc kthreads in
 RCU_KTHREAD_OFFCPU status
Thread-Topic: [PATCH] rcu: Avoid invalid wakeup for rcuc kthreads in
 RCU_KTHREAD_OFFCPU status
Thread-Index: AQHY+PQlxGZ/hW5SmUe9kA4qPJUqOq5BgTQAgAARpnCAABPbAIAAiFzw
Date:   Wed, 16 Nov 2022 23:23:35 +0000
Message-ID: <PH0PR11MB5880615D66ADF23A21AA9E04DA079@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221115131926.3409974-1-qiang1.zhang@intel.com>
 <20221116124716.GA813995@lothringen>
 <PH0PR11MB5880FD7499114743BCE3E5A3DA079@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20221116150130.GD816333@lothringen>
In-Reply-To: <20221116150130.GD816333@lothringen>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|MW3PR11MB4714:EE_
x-ms-office365-filtering-correlation-id: 241f15e2-5293-44a4-6885-08dac8299590
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wDQ8NJrzZBTAd9b9ZOkbCIFAPi5hJ77Gienix1CkfEWJQXH0bYGLiIUnbqwMovgmSHFI6NbKWRLK3DXXxuEf8jlCVjVR/IN9ax/cJA5jXafmraRZTrh0ULRZMxkZOZ/Z7XoI1TvI/uS/AS/0hhS2KvCDhUHuu2zIZMHURpVuSRf9yTXTVn762PHUMXwgakeZu6pXTsTua03NnmQWZGj+8NfRM6/Gi9l2gDt3pAr53UVbaNYMyd9g8+SAMsk9pYf6bh+bobuXRpWSIy2lmp0KLpYkKW8IjiX0zmEfVkaMTDVOuMm47Fyhl/wPoIHvbYgttTXJozDM5WmJ4fD6GaRa88s4sPyLeOzAYtCAd/lDqu29JWay9DqM/L7jpvnFsbraGTSGgYNqFlL/lpMgYv1yvLYIHTOOgIR3gWRIQCwsLuAuymqlddQfQIhQkbYuQ2yazxZ1HBOzE/Ex5oqTKWvw2l9/OWpckLYRXIp0mMG40elhyI4WrGwrkbTXBf15eRTARqa5OpUAgClUjWfVOnVkgNUkweSuOqNMO8t8QurhlUuZ4xpblsstsfas7O1Emv3PbIAXLSgs6vQmnuiczTFlx2f0+ANMMRKhY17BpfwLGnHmCyvLkBSy2TUtpXkWtrOqFFz7023ULngMhmyNr0INsXwCEWTnBe8BxrPv0vwzIyIV1xaROM8fmAKednV2JVui9nKH42+YY31xKlY3oG91N3Td4H+nLu3f20bqXshFFqR6tSdJV7aC8BXMwF+V+NwIf439kXbTUiswhl9dQVRGPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199015)(66899015)(82960400001)(38100700002)(122000001)(33656002)(478600001)(71200400001)(83380400001)(38070700005)(86362001)(41300700001)(8936002)(5660300002)(66556008)(2906002)(66446008)(66946007)(8676002)(66476007)(64756008)(55016003)(4326008)(7696005)(6506007)(76116006)(52536014)(186003)(9686003)(26005)(6916009)(316002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jS/CGOBL9jLNCfXcEo6776gv5yjpikybabg79KFQ8l8dEmVRglbIetMjWvkc?=
 =?us-ascii?Q?O9W5Ube4FEtGC7Fn7tEKdp9r/BUnNfdcqoNk+fjq2mU8qPEXlNohliX9RKTS?=
 =?us-ascii?Q?NLGaWOUrwanezcYxZMN43+NDdUhJZcjky64pwLxwfHjiYyJMgEMLDMKSw2SK?=
 =?us-ascii?Q?J6QxdW/x2RJKJopLIAghPSlDF5iCjlE+2y0RxRSytzsarn5clGzAVILyaPiL?=
 =?us-ascii?Q?AE/UhJQ4r4Xzce2sIJo4cVfLmGglYRQQwjBJ+AB/FjNqWt2Rw6lax+eUpFx1?=
 =?us-ascii?Q?mtheo4csw0afjqCv8OO0YpD4zDFbSszQpXk+pxPBABQtDm7TXyXjhdTyHn0C?=
 =?us-ascii?Q?GuX/D03s0vE37piVQzg3eDDn5Vi03BDKBVc4WPFGKbgeTgKrecK1XBqyFjdi?=
 =?us-ascii?Q?oLdgDzEpIqCD2/bH3oLDuQBwJZUso+8BJr7mbhUKhJAa5UQP0W96QV+1KC33?=
 =?us-ascii?Q?0GTOtSytMdoiL1Ty6DaXj5OdK6vcJJ4tDQrYrCTqGDGbjYDRpEOav5NxZObU?=
 =?us-ascii?Q?UfRJqabq8bgjFtpwvPaFBnClbwklTsyJn8AqeZZckRTURTporOpMDDFTpKVe?=
 =?us-ascii?Q?sCHK5q52LM+QHbCTA582sxzqsW9qN6ljsudqNRLIEm+/RH3HcWFksru1xqXG?=
 =?us-ascii?Q?REN5EgYQWf1Hw1BfQE+CHR5kZ3VV6BcrgNffcqnlPuhhfboiDBV+z2GOrBkc?=
 =?us-ascii?Q?+zsL8jvSv/hfvaN3lPhZvDcE0ZrL7RJYtlZObhloS50ehuSZ6OVhsukxOcVZ?=
 =?us-ascii?Q?kK+QJt4lOWbZHDU+KkGuGGw8aeHfG2f5A8bkyMeADoNM8V1kPIjUFsZTClRz?=
 =?us-ascii?Q?CBdvmnn+m1DI4BWdLJsq+DE6mLS7jbjOiPYVZe4iDuTAGttJzqinUuLZySHp?=
 =?us-ascii?Q?Sc3LPY/9HRn4HxiCqpMG4xXfxQx8jjOlLcNwZRrg80Sukvu1KccFwHxs5CpS?=
 =?us-ascii?Q?wQu16k/kg8DqqSEEQuiGvejQleCC83otyhRIwCiLO4Xl1pfZtRVZQLgxNBDX?=
 =?us-ascii?Q?8cN51FZkbjH21SJFPFt9pTo2nYt5ID3xkTPMF82/FT3ROxTDucLzzCdCtzZt?=
 =?us-ascii?Q?X7AWPnr7dylDsFmpFaycjGle6ycLC7bbIZeCzHbedowYu52FfMhuibRqujki?=
 =?us-ascii?Q?/LLgd0I91NvUJnmBLaJlkJZPkKPS7QjS7w3YU+BWTb7nSiSzgF7QXRPequXu?=
 =?us-ascii?Q?43nzf4bk5zrCz2IDTH9xFXMam45ih9rW0LK5TgJn3/blClooBOLGceimQpvl?=
 =?us-ascii?Q?lljafHcEtxfs3DWXnXm4ws7qT/kANb2tcgmX7uysU8gtXeVR6kOrKJA7Q8qr?=
 =?us-ascii?Q?f5Ca8U4UYpo0fuZ1qz1CCrsRGQkQ9GzmZsIzWCMidBz++Dk9Ppmsr19V6pD1?=
 =?us-ascii?Q?SiLEpsR702T2xxcB/vgsoRo0jCSdBfPWQlnB9qvWtP5tekZJsw/LJq4HNQd3?=
 =?us-ascii?Q?Ejd1lfecjcx5b7YByMQPOAcmt4kIqgum+ZlI/X5+Y4kAvRGkqnSj+iTDalv1?=
 =?us-ascii?Q?5z49Qy5OLbCuI50az/GXXX+ag33ZBVQPPGTvvSralTgTrHd6xg+FhRbFVcLQ?=
 =?us-ascii?Q?B1jj8/62+IOfxeKrP6P/Ip1XFNfYUUgHnj9r42dF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 241f15e2-5293-44a4-6885-08dac8299590
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 23:23:35.4361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gh46gL2XXYKAQOVvz7x1YmVspBR3HjS9BLT45RociR7HgDLOk2wW5F1DTefGAaCXxeugjdbTurwpsPZD84zBZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4714
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

On Wed, Nov 16, 2022 at 02:07:28PM +0000, Zhang, Qiang1 wrote:
> On Tue, Nov 15, 2022 at 09:19:26PM +0800, Zqiang wrote:
> >And more important! On unpark time RCU_KTHREAD_OFFCPU isn't cleared. Onl=
y the
> >rcuc kthread does it, and after your patch it couldn't be awaken to perf=
orm
> >that, unless rcuc is lucky enough to have rcu_data.rcu_cpu_has_work =3D =
1
> >by the time it unparks and that isn't guaranteed. So rcuc may sleep fore=
ver.
>=20
> Thanks for review, yes I should register an unpark function to clear RCU_=
KTHREAD_OFFCPU.
> Is the following modification more appropriate?
>=20
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 3ccad468887e..a2248af0ccda 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -2375,7 +2375,8 @@ static void rcu_wake_cond(struct task_struct *t, in=
t status)
>          * If the thread is yielding, only wake it when this
>          * is invoked from idle
>          */
> -       if (t && (status !=3D RCU_KTHREAD_YIELDING || is_idle_task(curren=
t)))
> +       if (t && (status !=3D RCU_KTHREAD_YIELDING || is_idle_task(curren=
t)) &&
> +                               status !=3D RCU_KTHREAD_OFFCPU)
>                 wake_up_process(t);
>  }
>=20
> @@ -2407,7 +2408,14 @@ static void invoke_rcu_core(void)
>=20
>  static void rcu_cpu_kthread_park(unsigned int cpu)
>  {
> -       per_cpu(rcu_data.rcu_cpu_kthread_status, cpu) =3D RCU_KTHREAD_OFF=
CPU;
> +       WARN_ON_ONCE(cpu !=3D smp_processor_id());
> +       __this_cpu_write(rcu_data.rcu_cpu_kthread_status, RCU_KTHREAD_OFF=
CPU);
> +}
> +
> +static void rcu_cpu_kthread_unpark(unsigned int cpu)
> +{
> +       WARN_ON_ONCE(cpu !=3D smp_processor_id());
> +       __this_cpu_write(rcu_data.rcu_cpu_kthread_status, RCU_KTHREAD_ONC=
PU);
>  }
>=20
>  static int rcu_cpu_kthread_should_run(unsigned int cpu)
> @@ -2460,6 +2468,7 @@ static struct smp_hotplug_thread rcu_cpu_thread_spe=
c =3D {
>         .thread_comm            =3D "rcuc/%u",
>         .setup                  =3D rcu_cpu_kthread_setup,
>         .park                   =3D rcu_cpu_kthread_park,
> +       .unpark                 =3D rcu_cpu_kthread_unpark,

>Well, personally I don't think it's worth the burden because wake_up_proce=
ss()
>already does an early exit if it's not dealing with a TASK_[UN]INTERRUPTIB=
LE task and
>the window is so short and rare that it doesn't look like a good candidate=
 for
>extra optimization;

Agree,  in try_to_wake_up(), acquire rcuc task->pi_lock(there's almost no l=
ock contention here)
and then check tasks state,  for TASK_[UN]INTERRUPTIBLE task,  not dealing =
and early exit.

Thanks
Zqiang

>
>Thanks.
