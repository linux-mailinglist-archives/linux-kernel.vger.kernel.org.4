Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C766A040C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbjBWInO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbjBWInK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:43:10 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE7B5FC7;
        Thu, 23 Feb 2023 00:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677141789; x=1708677789;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d3kjfZfjnyXnfklVDVqngQ1dqgVw6qO2LEDjynKuPSw=;
  b=jFuYEyLZw3Xx3hoO5xgI0guNR15K3W0spsvY4DTTnCX8TcvQb+JRS449
   WzOuAHUrPKSILPWpY1nAbUMGRWILk9ckEw2ygyu4SbocO1vrMjYWS6n1W
   ZJw+2L1u1UJOw8DRR75+YSPGrLajv8AmTdaNMvNQdEYS0hCfGsxf8hJbp
   QygfficlV4gmSihYjYV75xiIoTfXMEILkyhj12IHj0Rk8/BKItnUz/IlI
   HpRyQ3PIzE1uYsMdPp5IEvfSpUiIJUt1H6Bwp7TTXTRnjoC6w3UcvVSA9
   aJzZb3MoTvAi+4JiCjYNcIt8IneHbfjcDa/a5ljt487Jl43faBPF9FpkN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="334521061"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="334521061"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 00:43:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="815243118"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="815243118"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2023 00:43:08 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Feb 2023 00:43:08 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 23 Feb 2023 00:43:07 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 23 Feb 2023 00:43:07 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 23 Feb 2023 00:43:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhOuriEFpuLya3yYkciclK31zQqJVkKfwmv2knE+5OT0beiyP2tZVJ0pWOqt73KxUXExHBiiBc1lRb2LuoKF7xbOMtQ3E6brOR+/3FK6sfGHoKmf7cjZfOjgqRZu7KbpSClocC8PZ/TW2DDfFBQupkHZ3/VYLoxmTI5e9+/ga+SBjO6sHpbeQMK2q+g5UxCvS7kUxht8hojt42bB2qhHzf+15HhH76pU1sbEjVLpcARhZbZyPL9TcabbI7y1ewhFc7gvFcg+el+WFfEW0O95HnoY4+N21R2TZ85jgFY7Jn9bWAjsDi39wcfI+DuB+hw6oy0woWOgDwAdnCXFjMQ/YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyMqF6dMYv+9xWDFdHWv+QhtMe33lSeVaIhHTqqJc38=;
 b=NKgIYwqw3kW6zgND924Dpe8rmSwqSxZ5Yk5+EeQfmo55yLbj8/f6NEvzSQ3OtZqTy6xHedVYo1fX/eZk8n4RYyKhNHR4CBebxJk38KJHVaZbEi/6H7bfkcvuOrCpVu4DzW3wwf6yAM2vii45grNcfDANn+hZYnx0MyzCMPlHznkBGYkcPC8DqnbOy3N6rJrhdORcC9zCJ8VEQTrZwIEWk/p0L/T+vvvoGCPysmcHd8gt+Rvd858zoKHSvU+dZNGcpyN4c8y64vEIMFncefOmZQ3xdbQT1QOiFZAzZvQisJNAbEF3Tc7LL8FkLOqZ9bSgGNMlFov8zYIXLe9qYc2uww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM8PR11MB5687.namprd11.prod.outlook.com (2603:10b6:8:22::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.21; Thu, 23 Feb 2023 08:43:05 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be%4]) with mapi id 15.20.6111.018; Thu, 23 Feb 2023
 08:43:05 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>
CC:     "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu-tasks: Directly invoke rcuwait_wake_up() in
 call_rcu_tasks_generic()
Thread-Topic: [PATCH] rcu-tasks: Directly invoke rcuwait_wake_up() in
 call_rcu_tasks_generic()
Thread-Index: AQHZR0+ogcttGObez02wrCHslcltHq7cNR4AgAAAcHA=
Date:   Thu, 23 Feb 2023 08:43:05 +0000
Message-ID: <PH0PR11MB588084641FFB675A102BA503DAAB9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230223063022.2592212-1-qiang1.zhang@intel.com>
 <IA1PR11MB6171F5F6B525B6C599024C9D89AB9@IA1PR11MB6171.namprd11.prod.outlook.com>
In-Reply-To: <IA1PR11MB6171F5F6B525B6C599024C9D89AB9@IA1PR11MB6171.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|DM8PR11MB5687:EE_
x-ms-office365-filtering-correlation-id: 12ffedb5-5221-41f7-ce6e-08db1579fb27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0jbwlGJ+fT/lepaJlt3bJugBbwXTYfKNxpEeslQXHTRo46xsKKiox6D+dGSh0hyQRRliISOtphThfW7UUCToDDKsvfKwP5ZvOwp4ZgGgbfykQpLAoz5jbK7uxmCY2rp2ZAyBKYGharNKrmRQ/+JcfRKh2PJX+N8xVMN5NYHuQ6TwgQqM7dink4hDhxHnmz+t/E6m0/c4/Q3LGfDbs2jXq2tSEsD1SxJOmxfuA8ZoPHjDz8p4B924BKlHZBdF7QSUXWUfmw9yNA4fUAcSq3r2CmCREr1PjNKkATAAhUQxvh9rdZ2hMn0PkPTiJh7v+FMyPsKYqse02a4Hq6Ouc74sfEJPGo8Bayqe/QncLOzWw8/djXVGB4mItac4bOk6FLK9tY8wtz/JZO2KwHnNubVzwMeeFmnMC1HjHcyOv/XmZUkk+rJSL+xbM1SvOZ50usxiflRZ9BtoQ5xANddY0WE8sE5gDGFHlXpixNF4qyANSbycYK5qu7817+K6uKfYRV/y0zjSr2hPLPkIzlFBL7KWJv4kC978607Wii7tUPGHwf8aT8axuM5Zp9RIMVtLGmhBEtnJgnlm4ycPwXCXx5P5J2SdX/pV/Hpo/ldAoc46javob3k+/ofedSgwOLbR2GbAG65wFHsOe4W35HMOsLJ0QgC2slSJGeTi/Sc/O5emPH/sv8RPmgw8PlJe1keM9nRLgeDNT5IoVBZe+KRtj3f1RRDB/oZpjeMYG3ahaV1Yhko=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(346002)(376002)(396003)(39860400002)(451199018)(41300700001)(83380400001)(5660300002)(478600001)(9686003)(26005)(186003)(8936002)(52536014)(38100700002)(86362001)(110136005)(54906003)(8676002)(4326008)(38070700005)(55016003)(53546011)(66946007)(76116006)(6506007)(82960400001)(33656002)(316002)(122000001)(71200400001)(66556008)(66446008)(64756008)(66476007)(2906002)(7696005)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mcMYW1l21sTIelSHlF9yk4Zlo3s3poMF3m5cx7PemWuUNvx9/ahhChq4hJ5m?=
 =?us-ascii?Q?tJZHgGZuu5XktClTZmdV579e6CABHO4XdmmKHkFRHGEiHerd/Qvwq7kVqLId?=
 =?us-ascii?Q?t8Ymv8QsjUsJCMnoarim1cNpZdnMnE+6EbbWPWGZ/aeZOYbr0rESag40lEca?=
 =?us-ascii?Q?PVFwTHmGJs2gVywmdl8hOQlOl8l3w9c+9inEFFM+ftk9o8tc892d/99Z+D4S?=
 =?us-ascii?Q?zyNuFAYlyHJ4W+htFGJh5m9LzFiAziHYaMBDdR0Rdj8E1eVj6Pr434quFg2a?=
 =?us-ascii?Q?a7purh5y+jV3GQEKV0ETGjKEKd5nsCPIQeRLD/mC/NiLb6Z45/v+ye+fQptV?=
 =?us-ascii?Q?mIr7xcPiMdYVoAEG0qnWdfnPi+LZQnw2BAOs6o5MfO0wHrijyl5U+h+STM6W?=
 =?us-ascii?Q?rBUXOZo9VBYSof6vYSPAW0sVOLsR8Ds1aDmbjI/0Txa9cTvJ7wENyFO65XB9?=
 =?us-ascii?Q?31BNXOD5fbJjeVdsfiiasCGhj96Bn7hR76NAtO2h7Yf7as4vvMMM8kRZDWrb?=
 =?us-ascii?Q?IfKcaRpcXPk8+nH1qmwOlYGvqEGkzQ0HwyvQ9gFkc0zo5RlupjvrS0GLMAZm?=
 =?us-ascii?Q?hNKg/WAN4OOTZEpz2c4EaHcEVlQTLy1aD2dPvakUdZrgtZqZvbtMo/igI7UN?=
 =?us-ascii?Q?OBo1kqIf28C6Ds/XmXw+fc0Z2cuiplgj1IK+K6ePbC92Dl66MFTUQKL0bELn?=
 =?us-ascii?Q?g8tYDs6Xr9QkiL2eKF/rYJak5PpdjdLFE11ys3RKfE81ZK2kWO5l+F9X/e3/?=
 =?us-ascii?Q?3rBvpcxttzEK/jSUq0rWw8WvGvK3+gy9Z8BORH40sWaB2fIipEDN8D0Vrrre?=
 =?us-ascii?Q?2n6WcE106AucGdskTDvpgEwK3sUqFBdYWrqvR2TmYUHrB8hXAT12uUkV3YN1?=
 =?us-ascii?Q?QeduCKCpER35X4rGATaj+lc48kPo7GnjmLUKbYL77J3bEy/kkBbz7xZuvhLf?=
 =?us-ascii?Q?ufqZ6qAyCoH8P7xJCzK339S/JDw2L0C9WW/11eE0Zgh/VEsvFImZfn7d/FhX?=
 =?us-ascii?Q?UiyMHHEaZXDe/ibtFozz9HwiiwwpeRqXMYMI7I8HjVlRbdtIduvCZFR6QfRZ?=
 =?us-ascii?Q?7LjvXmgoQqKOegawmoJ0ITR0/DADgAEMtSIEASM0BQ5YdWXJHIVTkA5lpU6V?=
 =?us-ascii?Q?Wx21xzE6ywEbp/E3Hv4SxBkXqLiz9b77rLm6H4JIF1AitMFm7HKl+BISDT0h?=
 =?us-ascii?Q?he0+Zi/Y7c3iLLTh758NidDRrLJty182IKzDGh1XbaA2ozE1rsd/CLiC+rqs?=
 =?us-ascii?Q?MBE/sae6caMDiuH1Qi7hkbGluLFGszgH1ilyRgTb/rswaGWGXX6fDB4JMGmO?=
 =?us-ascii?Q?frnnUkDBTKZ5pkymAlYphNa/ptC6r1wZhuSiUrwrBdsTTg3MqmfbVrne/Pzi?=
 =?us-ascii?Q?BHp5N2mauRIas2AGStbg5LjGCORCRLbplsgO/shMC4HLX0o4xA8l+sDaCTO/?=
 =?us-ascii?Q?rZRqifwCvOh2DkeWlW2ISD6s37d798dj+XY8t5Vo4R/Scl45AmxTgzRaFSPa?=
 =?us-ascii?Q?flU4Hc/sJTXWbin/CGoZli4Jz+NpAORjNplt/TXCPp0EbEvqqyBKsBccMlgT?=
 =?us-ascii?Q?eECt3TACzpT8eH03kXbFIQ/r4o0cGgRNi0NV3dsx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ffedb5-5221-41f7-ce6e-08db1579fb27
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 08:43:05.1504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z/jFtrVoDmB33Hak8k/Pde13iHahlzHNaluLzWX/d0R5gmym17b4tcdKixC9nH0r124cW1CF2/DSPTyLeJ10BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5687
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

> From: Zqiang <qiang1.zhang@intel.com>
> Sent: Thursday, February 23, 2023 2:30 PM
> To: paulmck@kernel.org; frederic@kernel.org; quic_neeraju@quicinc.com;
> joel@joelfernandes.org
> Cc: rcu@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] rcu-tasks: Directly invoke rcuwait_wake_up() in
> call_rcu_tasks_generic()
>=20
> According to commit '3063b33a347c ("Avoid raw-spinlocked wakeups from
> call_rcu_tasks_generic()")', the grace-period kthread is delayed to wakeu=
p
> using irq_work_queue() is because if the caller of
> call_rcu_tasks_generic() holds a raw spinlock, when the kernel is built w=
ith
> CONFIG_PROVE_RAW_LOCK_NESTING=3Dy, due to a spinlock will be hold in
> wake_up(), so the lockdep splats will happen. but now using
> rcuwait_wake_up() to wakeup grace-period kthread instead of wake_up(), in
> rcuwait_wake_up() no spinlock will be acquired, so this commit remove usi=
ng
>
>There are still spinlock-acquisition and spinlock-release invocations with=
in the call path from rcuwait_wake_up().
>
>rcuwait_wake_up() -> wake_up_process() -> try_to_wake_up(), then:
>
>    raw_spin_lock_irqsave()
>    ...
>    raw_spin_unlock_irqrestore

Yes, but this is raw_spinlock acquisition and release(note: spinlock will c=
onvert to
sleepable lock in Preempt-RT kernel, but raw spinlock is not change).

acquire raw_spinlock -> acquire spinlock  will trigger lockdep warning.

Thanks
Zqiang

>
>
> irq_work_queue(), invoke rcuwait_wake_up() directly in
> call_rcu_tasks_generic().
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tasks.h | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
>=20
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h index
> baf7ec178155..757b8c6da1ad 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -39,7 +39,6 @@ struct rcu_tasks_percpu {
>  	unsigned long rtp_jiffies;
>  	unsigned long rtp_n_lock_retries;
>  	struct work_struct rtp_work;
> -	struct irq_work rtp_irq_work;
>  	struct rcu_head barrier_q_head;
>  	struct list_head rtp_blkd_tasks;
>  	int cpu;
> @@ -112,12 +111,9 @@ struct rcu_tasks {
>  	char *kname;
>  };
>=20
> -static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp);
> -
>  #define DEFINE_RCU_TASKS(rt_name, gp, call, n)
> 			\
>  static DEFINE_PER_CPU(struct rcu_tasks_percpu, rt_name ## __percpu) =3D =
{
> 			\
>  	.lock =3D __RAW_SPIN_LOCK_UNLOCKED(rt_name ##
> __percpu.cbs_pcpu_lock),		\
> -	.rtp_irq_work =3D IRQ_WORK_INIT_HARD(call_rcu_tasks_iw_wakeup),
> 			\
>  };
> 		\
>  static struct rcu_tasks rt_name =3D
> 		\
>  {
> 		\
> @@ -273,16 +269,6 @@ static void cblist_init_generic(struct rcu_tasks *rt=
p)
>  	pr_info("%s: Setting shift to %d and lim to %d.\n", __func__,
> data_race(rtp->percpu_enqueue_shift), data_race(rtp-
> >percpu_enqueue_lim));
>  }
>=20
> -// IRQ-work handler that does deferred wakeup for call_rcu_tasks_generic=
().
> -static void call_rcu_tasks_iw_wakeup(struct irq_work *iwp) -{
> -	struct rcu_tasks *rtp;
> -	struct rcu_tasks_percpu *rtpcp =3D container_of(iwp, struct
> rcu_tasks_percpu, rtp_irq_work);
> -
> -	rtp =3D rtpcp->rtpp;
> -	rcuwait_wake_up(&rtp->cbs_wait);
> -}
> -
>  // Enqueue a callback for the specified flavor of Tasks RCU.
>  static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t =
func,
>  				   struct rcu_tasks *rtp)
> @@ -334,7 +320,7 @@ static void call_rcu_tasks_generic(struct rcu_head
> *rhp, rcu_callback_t func,
>  	rcu_read_unlock();
>  	/* We can't create the thread unless interrupts are enabled. */
>  	if (needwake && READ_ONCE(rtp->kthread_ptr))
> -		irq_work_queue(&rtpcp->rtp_irq_work);
> +		rcuwait_wake_up(&rtp->cbs_wait);
>  }
>=20
>  // RCU callback function for rcu_barrier_tasks_generic().
> --
> 2.25.1

