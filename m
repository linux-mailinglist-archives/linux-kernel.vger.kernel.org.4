Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC7869BE82
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 06:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjBSFEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 00:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBSFEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 00:04:48 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8AE12F15
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 21:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676783087; x=1708319087;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P/Qbd18wHCzJK4KIX4NJpbn4bj1YlPKmbqMCOfDGrus=;
  b=n6NnIrsiwrGjKDBdE1+lJjqqyZghEZnfE/VCWq1toRn6LD3US3jk0DlE
   hi7k51LA2/iIbNJ005Tj6Ffhnd3Qcp/AogX037PsZ3s4KDXbQ0ZC03FSp
   b4WeICCy8/A4wCu1di8AgFYWSwSd4PFM1AjfPEv8mRl+z0YIujvCcJ1C0
   YWXAuBVX4hu9KyuhYXXC01LRBP63w1kJovV8bZwGoM32Xb5I0BF2SnPJn
   YXlFBlh5hQcz/tT7DutskqIVXiArjU+Sl9o2XyZfcQw1DyDEadgQxkT+5
   a2mmLd2+koc64Eus8WBD5zRe9SPOts5xSwtCueY3Kv1CWixgS3OQGhLQX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="334425288"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="334425288"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 21:04:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="794841538"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="794841538"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 18 Feb 2023 21:04:46 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 18 Feb 2023 21:04:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sat, 18 Feb 2023 21:04:45 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sat, 18 Feb 2023 21:04:45 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sat, 18 Feb 2023 21:04:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F15FlSXYYt/ugV7WnOWnSl8WdEsoiCOFSXZ4y9PKZHm5D1dIWJ03p3G0D8zQU7y5yIOa8vi192RVK/UrT5QCp9+7uLI8sb8899lGSs3ZZUKNllIjzUbxnkwn/7gErcSg+ltnxe2MUqboJXWGMO04c39kphi5v3q0jpatPWhyWDSIiosarveSGtgm9QGpINKHmzBfhZQpLIV1N80UrCfwYtKgm0gyyLHlO8IemI7iI0Bx7c4kfGbZylLyODZP16L7AV3LyvLaV3l80vuwq2uU29JkJbfzVwOegVIK5qu0ZyMb440j1nflHspRfEVQjN/1hRNHLjUqctG+A4UKD6q/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1GA69Tr/mJoyY8PLdmcFR3kdBbeT/pnbtU9NRR3HaE=;
 b=S9NqXZ7zvzPk905rU5lS3WGW7DJwuYh9jrKfY/GC4b1Rp5WKQ9xQA4K3tDESF0boM8M7iH8tnGsj8tM13AJsp0y6vq90Qx1nGMHxDGglwptZ9MZGxJjR4WL6Sj2yB2FRWJz0CuQWttMimv5VRfm8FKdnJkxinsS0dTfulK6Va/USEk7j9Ixj4GLFqVfXYmOweVIfXBSWDCsTVt+sIdI0FtEkXzZUFHC899uUd2Pag8eDS2pmV7BfQvt3qaX07xSsOezb7ALmnC26j6/uxSwQoyW2niCVh734dDjyHZiXyeHwlIWgLTMmSksWQd9D4FEU3BlTkbClXqjgdqTCCRl8JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Sun, 19 Feb
 2023 05:04:42 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::13e0:365f:80d9:f2be%4]) with mapi id 15.20.6111.018; Sun, 19 Feb 2023
 05:04:42 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "dave@stgolabs.net" <dave@stgolabs.net>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] locktorture: Add raw_spinlock* torture tests for
 PREEMPT_RT kernels
Thread-Topic: [PATCH] locktorture: Add raw_spinlock* torture tests for
 PREEMPT_RT kernels
Thread-Index: AQHZQQOQoUWyhnQ0g0erj0/4773a9K7VHgwAgACdRLA=
Date:   Sun, 19 Feb 2023 05:04:41 +0000
Message-ID: <PH0PR11MB5880CD867814DFAAF8930E5BDAA79@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230215061035.1534950-1-qiang1.zhang@intel.com>
 <20230218193438.GE2948950@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230218193438.GE2948950@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|BN9PR11MB5483:EE_
x-ms-office365-filtering-correlation-id: 6feb0193-d060-4532-1e16-08db1236cf22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4jk0WHouRfOscMFr3hPhySGabNJGKQMiKJCQXFe7ykfZS5uXmPIyypCBrH/M1vCkMt449dEuoxwO4uWzR+8dB3yXfvErq1Z6iTK4P/C6Z+zzCBQT788SlL8Su27lBRIFhNYWs17TeQAof+wkK5Czr6v5e6nBpfr9xEKLXqebQhPR2jKIqa15OyBhvgmAKVxizXJx2Ad3/L/v3aBLCWxpR1GijTZqkcYWUJwiNuCXp6JHG4Lt9TtJncLgHwPUVFwop3YU7nU0+wtYxqv78WBDhOmLa/wkccqlNNBoQlEfC5W/BMV5hiTsMHnXeqNTNcrDlCSiDlS9gdq/yGJ+nc3U9UIrYVm2pB+gnEGElwAJrKlj0oe0vyaipd85jktjrR8qWpQ6U++XFqO3LpnMjkw9URf8tlXuxMj8sSefIDhY/lFR/WakxO8KDCdUjXgl2796umHDxUQ+POALjgvWNWxrb3cC11sXYM4VvUyDaHE3aDi0WE+UEQGw2xHJnx8rjC+sWRKxliDX+LtXBiRT115xJ2C/FuJg2itiQ63NJC2bDHYcxO/EjBSK43wp0w5vfAonKgrcY/B64upg7Fgagev1V8S7X+r9+7S/Sb5K2cgk1taBkoNbjzrtdGqtYN83ZNWUAYuZyrOvX7Ywx7aI4PqKYiBVNuZbednuehLGTDPVVgHYYnICoAny6Ch3d2NIDuNM0FusczJmB/a+Rlo5MFObRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199018)(33656002)(55016003)(83380400001)(2906002)(26005)(7696005)(9686003)(6506007)(71200400001)(186003)(86362001)(82960400001)(122000001)(38100700002)(38070700005)(4326008)(8676002)(66476007)(64756008)(41300700001)(478600001)(5660300002)(6916009)(52536014)(66446008)(76116006)(66556008)(66946007)(316002)(8936002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+MVdDcbaACwChYzX0DDaVnEAXfsVbLeceT474irSR0XGVLxVt1N4Fbq5IX6+?=
 =?us-ascii?Q?nzEt6httKq9XWZIpWvwXkej3CpH/y2Qfg9FhIxY4vwXhs6OFA+vUE7kaF92P?=
 =?us-ascii?Q?ig0PA1H7lFsDpgM2aGVOPqEEdaZxhq0C9fzOMGUvOMWrAVtBq88SJ+ic44Fv?=
 =?us-ascii?Q?XdPEmrn6ZDdNjP3QkW7EPP2L0CBin6HifnOkehaszqGR2LNOkAzIdSIqR0lk?=
 =?us-ascii?Q?gBNKKYUFcwS1sgQ1F1B5HyJgrXgpN+hXSdMuVxXv1EVRpYCP1dmUKm6vp7Mg?=
 =?us-ascii?Q?GR3F2XFeb9OVmjF9KXle4NSlqsYRUUsSWCi0UcWkgv9e1DNvemrM38dzD0Cc?=
 =?us-ascii?Q?taL2n3/KeShSfM4nMdy/O4dCsWdlk+LPJvdcKMe8woUD9Eqd0BAncUhSpJfz?=
 =?us-ascii?Q?unKyuBgTdQoMgd6WQDZuO5VrC/EHI56kJZ9un68F+jk/6ygNz8EFTRmyXwj8?=
 =?us-ascii?Q?BClLMqpUyKFLxOOzIFVE7VPvyExQe3XOAq400r1tmSSilTErYI89hMjW5nVl?=
 =?us-ascii?Q?uxfZqL2byFjUh0NgN7UPKHsvoS2RHxdRsUoCFfBHjPe1n0WKIqKSkLnMWIQe?=
 =?us-ascii?Q?fGDO3Gcxwe0cX6tTNjVxj0uxMFwEuHZpiQvHQ0STab5AFIndVgjf0wUMswH3?=
 =?us-ascii?Q?EBSoMeCyvrxWl4g+mzjXfC4lzNN7FpJjC66+14BGilhRn6oKJw59B9OFxZuk?=
 =?us-ascii?Q?MAhOCaxb+BSEk6lsMXWOqx3I7zr8T/Hl8pZsrmIhLUtnxBcrUfkqsUGyBWyc?=
 =?us-ascii?Q?W9+42KbS6tXvBkJOol9JwO1/X+137SacdJX6INByl5KT3ZKqVNIPxlYyAeq9?=
 =?us-ascii?Q?Yp074WJ0HYObSnGa75gfSAW67JOdK+V0TMNXgdnnqN/VHQQyTMt1fT1R8VtC?=
 =?us-ascii?Q?M1Xh0QxEvOWMJG5vr/P7VwzyU+ygaDjrj2WSLqfXrZ05eJUkkwE40wv7Lg4j?=
 =?us-ascii?Q?4thbtQKeHobugQhdBlEHWfb88PPG3ZwHTtEATyiYkQ7K4GLau4s5R03LPSAl?=
 =?us-ascii?Q?LAuST20RHuICpGF8CSCJySf0zWV8YClQgQIpZ2q8pm3ZS8XRJBQ8GlSeTZjd?=
 =?us-ascii?Q?eAynphhfeunNM2ioPFxIZGivGrpYuSm2jA+0W06BhfmNMOwEvHMFFc0Ln1sQ?=
 =?us-ascii?Q?RLkxdmnNqOs1eKqYx7Jhe92aTNUuyl0d2wzFgOD524u6vnVH0neVFSUwFSYn?=
 =?us-ascii?Q?QlA4ePVy0ObYXBGXEWARnRopWFtCN++8F3fQKsQkH0EWfIUfZo9J3A19qfFQ?=
 =?us-ascii?Q?yBnoLhh8VFoCkbQNBmKpBZZyIymQ/UpB5wyKgn0YNINDZZ5V+m8jon5pnIWH?=
 =?us-ascii?Q?8m4ftDW34DbgqKhO1lvKmbkNs6uYL/ZS++Gc1lKduarm8kJ4CYuP3RweahJN?=
 =?us-ascii?Q?ztLcsTv4uVd/Qp1ipnAufHRQ9QglZ/WmDGjppdc78lj8ToaCxzHhsz0uu7l+?=
 =?us-ascii?Q?ftfsW1NTilcJRJ5HuR6vp15qM9xnTNJIuGCUJ9CzLCbCvd/Ji2sLydrcTV3B?=
 =?us-ascii?Q?H8suwVxEd6WaIW8PJqKy0CDUK+ITCd2e0QFZOZK2fn0ztk3NUU8pMioUeSyO?=
 =?us-ascii?Q?srLx1JqkiJlhnQCECtJBodVr3EvtC5aRsSRNrUlS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6feb0193-d060-4532-1e16-08db1236cf22
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2023 05:04:41.5398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HHWwG6uhQBdtNHCaJLhqHcrAM7J9BL6WuXdzzKrb7humlRXgnsK0QiXFMw9pzNweqmbJFGqMhMKEruSiixnKJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5483
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>On Wed, Feb 15, 2023 at 02:10:35PM +0800, Zqiang wrote:
> For PREEMPT_RT kernel, the spin_lock, spin_lock_irq will converted
> to sleepable rt_spin_lock and the interrupt related suffix for
> spin_lock/unlock(_irq, irqsave/irqrestore) do not affect CPU's
> interrupt state. this commit therefore add raw_spin_lock torture
> tests, this is a strict spin lock implementation in RT kernels.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>
>A nice addition!  Is this something you will be testing regularly?
>If not, should there be additional locktorture scenarios, perhaps prefixed
>by "RT-" to hint that they are not normally available?
>
>Or did you have some other plan for making use of these?

Hi Paul

Thanks for reply,  in fact, I want to enrich the test of locktorture,=20
after all, under the PREEMPT_RT kernel, we lost the test of the
real spin lock.=20

Thanks
Zqiang

>
>						Thanx, Paul
>
> ---
>  kernel/locking/locktorture.c | 58 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>=20
> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> index 9425aff08936..521197366f27 100644
> --- a/kernel/locking/locktorture.c
> +++ b/kernel/locking/locktorture.c
> @@ -257,6 +257,61 @@ static struct lock_torture_ops spin_lock_irq_ops =3D=
 {
>  	.name		=3D "spin_lock_irq"
>  };
> =20
> +#ifdef CONFIG_PREEMPT_RT
> +static DEFINE_RAW_SPINLOCK(torture_raw_spinlock);
> +
> +static int torture_raw_spin_lock_write_lock(int tid __maybe_unused)
> +__acquires(torture_raw_spinlock)
> +{
> +	raw_spin_lock(&torture_raw_spinlock);
> +	return 0;
> +}
> +
> +static void torture_raw_spin_lock_write_unlock(int tid __maybe_unused)
> +__releases(torture_raw_spinlock)
> +{
> +	raw_spin_unlock(&torture_raw_spinlock);
> +}
> +
> +static struct lock_torture_ops raw_spin_lock_ops =3D {
> +	.writelock	=3D torture_raw_spin_lock_write_lock,
> +	.write_delay	=3D torture_spin_lock_write_delay,
> +	.task_boost	=3D torture_rt_boost,
> +	.writeunlock	=3D torture_raw_spin_lock_write_unlock,
> +	.readlock	=3D NULL,
> +	.read_delay	=3D NULL,
> +	.readunlock	=3D NULL,
> +	.name		=3D "raw_spin_lock"
> +};
> +
> +static int torture_raw_spin_lock_write_lock_irq(int tid __maybe_unused)
> +__acquires(torture_raw_spinlock)
> +{
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&torture_raw_spinlock, flags);
> +	cxt.cur_ops->flags =3D flags;
> +	return 0;
> +}
> +
> +static void torture_raw_spin_lock_write_unlock_irq(int tid __maybe_unuse=
d)
> +__releases(torture_raw_spinlock)
> +{
> +	raw_spin_unlock_irqrestore(&torture_raw_spinlock, cxt.cur_ops->flags);
> +}
> +
> +static struct lock_torture_ops raw_spin_lock_irq_ops =3D {
> +	.writelock	=3D torture_raw_spin_lock_write_lock_irq,
> +	.write_delay	=3D torture_spin_lock_write_delay,
> +	.task_boost	=3D torture_rt_boost,
> +	.writeunlock	=3D torture_raw_spin_lock_write_unlock_irq,
> +	.readlock	=3D NULL,
> +	.read_delay	=3D NULL,
> +	.readunlock	=3D NULL,
> +	.name		=3D "raw_spin_lock_irq"
> +};
> +#endif
> +
>  static DEFINE_RWLOCK(torture_rwlock);
> =20
>  static int torture_rwlock_write_lock(int tid __maybe_unused)
> @@ -1017,6 +1072,9 @@ static int __init lock_torture_init(void)
>  	static struct lock_torture_ops *torture_ops[] =3D {
>  		&lock_busted_ops,
>  		&spin_lock_ops, &spin_lock_irq_ops,
> +#ifdef CONFIG_PREEMPT_RT
> +		&raw_spin_lock_ops, &raw_spin_lock_irq_ops,
> +#endif
>  		&rw_lock_ops, &rw_lock_irq_ops,
>  		&mutex_lock_ops,
>  		&ww_mutex_lock_ops,
> --=20
> 2.25.1
>=20
