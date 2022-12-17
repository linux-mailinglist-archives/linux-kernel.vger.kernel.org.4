Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA3D64F6E4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 03:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiLQCA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 21:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbiLQCAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 21:00:45 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB40E081;
        Fri, 16 Dec 2022 18:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671242441; x=1702778441;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1PAjXLuu/MK43zP7KyatVwF+JbHfOppaPtJNTiY982Q=;
  b=AxEoLgMV8I5K0/ce6xtMrp3rJdlAUqfoagTXInE54YX0FmfgOdWg5+Z+
   /w7dj+sjqpll9iIe52YlkJ2B/uBBV53n8xAQJ6tdDi4t7DZeD4cxOZw/W
   zwiThNt4Gh0F/NrvZOHbO+12NB/PJu6zQ3S0Kcuippv96SI8rjDT5oe+F
   XKqf+/fbmr3Cjg4cpmTgetDPfw1PD3Hex6msqJ2LwNzfxYgrwSEMai6/I
   snYhif6OVtkyYYKQqe2TwHqZk/Ywm/XCOkpG8TQ2Nu4U/8VkiEdAFZNP1
   139JYcYNz1nwzfr+PDqSZlcFwvm72dtTQUqGWMb6SmkBZYWD+H75W3eAR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="302516339"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="302516339"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 18:00:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="756947444"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="756947444"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 16 Dec 2022 18:00:39 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 18:00:39 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 18:00:39 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 16 Dec 2022 18:00:39 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 16 Dec 2022 18:00:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIBUchT4XRlb9JCqLcJ9HldMkXwRfGpPId8QOUSQcCLbLbYn28qeXUAnEUtCHkJpXEYHADgj116WaPy3ke04bnPXBO2pVWvmNbg9Zs500+OrS8pzCSkaHFyM83kJam0EDLHD39WA/BZBMtnq5lBK4iHd7XuLqL5jgx+emwDx66Q92aIVYgKPOtSea5arsrKxBgkLmvBhIl5aF2EC7wT2ZPcNcfcL52Kx2ttYkImfAymO8JB/eWv1i052Dd9QeMI0vdNznv9i5MaVOAyG6ZpY2xCGLhmjXDc5bmEbuLR1dPBieZkmKSpaB7J0RoCpNk1kNjqLnjBGOXw8lN4ovvNgDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EG5UnNobP//pSb1ORXBW3NyJlagC25yI6601Mi2pWwU=;
 b=bjNwdUiTRn/SMViNHdiyg6AwMisxVWqeZNJR/oUyhTef//xjiPGXbYfLtTnODPCzgpv6gUnPI+E+lBy3JHuC7wLK1yBvy6oYj96g5FVrS51I/wCTGhBI1CCQ7G18K7VKsE2IPYebLRhUk+icf2G/ILofqk19+fTU5C3co+TZ+zjHm0m9XBzO0gKbeWwi/oLHq9gY06oJgI8IuksIGIkRBqUhJ8BVhguIzslgV+6CdiYpl1j6MR4q5sh/wTT6g2xYqAxaoaP8E8bGiB0lWzE3ZHl0M0Mv4YVFPwmiNKHCd2aUT6gY/kPVr/2mTc9Ic4AXJ0z3pN/OVyWMrG/gwXYEOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BL3PR11MB6313.namprd11.prod.outlook.com (2603:10b6:208:3b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Sat, 17 Dec
 2022 02:00:35 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018%4]) with mapi id 15.20.5924.011; Sat, 17 Dec 2022
 02:00:35 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Remove duplicate settings for rcu boost kthreads
 affinity
Thread-Topic: [PATCH] rcu: Remove duplicate settings for rcu boost kthreads
 affinity
Thread-Index: AQHZEGMOnvxGUFjU2Uq5+RiLJLzbVq5xR5qAgAABybA=
Date:   Sat, 17 Dec 2022 02:00:35 +0000
Message-ID: <PH0PR11MB5880B9403488CAB5DF9810FFDAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221215090029.2972236-1-qiang1.zhang@intel.com>
 <20221217010919.GG4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221217010919.GG4001@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|BL3PR11MB6313:EE_
x-ms-office365-filtering-correlation-id: baefa717-9909-455f-5afe-08dadfd27cb9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sNOZ9+HBI8hWRZSi5OV43Snga/CrFn8ctFgQOuRaqMV/mBJx/8vZtRq5/P8k2L3kkQ7ukZ/mQlaH3FEcPG6HJY3w64o1MKzKRGHBqmnYZkk9ulvbPYAaqPXZhlGQzgAwOW4OiYHic8fKJWZ2tP19WEl7bPo4J0X4gMcwy0axIi0QSxwtChqZc2fpeK8OJh64WaaaXeaQzlD4SOg++SmmhJmYzXyf4nCX2MiP4MT4v7jF7E0QyqwBOY81SbIqqyGLuSach7wVMhwAufy71l+FEV5woqgN/CMDb5Ztv3AeAdomeKWwmgJ13v8vlsNSzdkYk8RVMgnNkdzj8zvx7J8On1gKG0NGgBPZFk/DW1bfcXNl1wosDyMzZuSEOSNHvqeR1ej0YKyZ/vhdUS8BRZeCKI9ZPb5KQ5PhICvwpYilhlph9YPVpNAA67q8yJ7cwi5DmcLeD8bHcu2qfEQX3tqMTIUGo0uYdlNFcpGgCmYfWwJEV0XXCKtxSlC2vIbF4tMS9gU3bdMMeXB95lGtR5PvqAwFGMPlFnehHgVciP48Y2XEusChDAlNS7mJQ3J2t4sE7i1WCBpZeYVkAOxeYN0VfUuJ4LvMsKzF5Oak4KcEaL0HooePZllpucF2S+urrX1s3sZEOuQ2T7lellsfmaSqguih7l5nCPorutFeLr4SRbaP28KYGZAbK/9m2uAVN0Fd8kB9tWtRJDTu2yR4nx7Nxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199015)(26005)(6506007)(2906002)(82960400001)(7696005)(86362001)(66574015)(122000001)(52536014)(33656002)(4326008)(66556008)(5660300002)(83380400001)(54906003)(66446008)(76116006)(6916009)(8676002)(41300700001)(64756008)(316002)(66476007)(38070700005)(66946007)(38100700002)(8936002)(55016003)(9686003)(186003)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8WyZiAl0tlJ+mE+tWBcugYt1DKZn885bwpFfynFieGmUrVVZG1TWtsQJe8zC?=
 =?us-ascii?Q?RiS1hlbRfgm+xWOLTgeRYmivfleo+viQd+sks9jnxvF23gp48657FO2iiEC7?=
 =?us-ascii?Q?tQrgrNGd3MaRmQp3VIyBhVCuoWet9Imngjg2/eeIc+cSr1oBhi6Mn079ZsL+?=
 =?us-ascii?Q?V1UVogi53054ZrNPacujmWq0OJt96mkHfFgNd3tUfn+k4eOiEL6/lPkQnTAr?=
 =?us-ascii?Q?tMqc/ahlkrqlWm7QEJwpALRfV0zXYmd5DegMGsP5mNYdVyfCbvYXsqd/3CGv?=
 =?us-ascii?Q?AxKdfCFHoEJZBFkDbokKi+8otQnmgB1vJOunwLafAZzTv89kBxly1Lnn6fZw?=
 =?us-ascii?Q?MJI4xuqPxwNkjDl881Pz+VMzfbWzBVC2t2EdQ9ATQw9flhnw1zWvHRHWBPaM?=
 =?us-ascii?Q?MYGkIOhpUBns+ckcq/vyktDhP+Hr5cNJjr5lrWF8G6CnxLuP25L8NbX8IDVH?=
 =?us-ascii?Q?ioUmLzBbbxVZo8EbiQwmlDh3Wlpi6gbHYRBrQCwGA10Nzw/TgEcZGk+HWZlb?=
 =?us-ascii?Q?yE1i7VOSSErJy8Awmj3et0g/N/t1SDghn5ViTYA63pP9HR91o8gcqCrW/C5W?=
 =?us-ascii?Q?DIz0nlt5TzHfasstQR03c1qQj3rpUBG3hkVYjP/0T74VEXWRvx74BrUNnBXG?=
 =?us-ascii?Q?XePrUfxT6cNjsBmDpoYSGpHA9N0rYSxT42dBHbwIjprJeDuK+hsIEBn5ank7?=
 =?us-ascii?Q?a4nUqh8zrCHg4DXCPRQE9RjNoNAv2jceEGYRauO9JpwgTqCR1UfkZl0gpBSL?=
 =?us-ascii?Q?qMKk+tK/EBdEyIar2Xsm1DqEnJ7hDz2dtnFm+9+W+YzuZGhdo0J0pgmvwkZv?=
 =?us-ascii?Q?LAckOipqat2i2Rof9WFr91VUUauYKBqFwFaCilssy4OGKK1+2AoKhe9Isa4w?=
 =?us-ascii?Q?Ts9jXkUDujHzZlnbzxuUgj9lWcEL0VJ+vQ3NVKKsEesZj3CTPUSfTvFh3Rp8?=
 =?us-ascii?Q?XnT3HyOFNFWMKw+a00w8ZirOIn9srzQXJkpxvEi/dUHaoKq7oKHzooIxHOl4?=
 =?us-ascii?Q?gGYYuAU+C44+eCMwqQPJ+0npPKcwauoskrvDbbxCYOFqy4dRUTJHuXGnicTQ?=
 =?us-ascii?Q?EYMUEWDxuh/hcATGX7fMRqJsEPO9w15RfHRn0683tEstaKox159C0EbRjEhj?=
 =?us-ascii?Q?cxuLnULd8eADlTryp+YXQtEPH+QEBFTekHsNPcekAHwPUEa+O6T1/RwhKdZQ?=
 =?us-ascii?Q?bKU27yU06dNWvvopFuO5SAH+6eWhqrV5ZgH5KYF5xkbJn52gmg9Gh6caq9V1?=
 =?us-ascii?Q?7125gnrRM8XU1mpUov+bbDrMJNG4MqLl9PGwVr5Kx7HnCcvYXFdRx4LqTd5s?=
 =?us-ascii?Q?X1M9Kq8NIqdhhdTsc4FwwboVjL8oG/yM3qvA6WQI1/QpqDl+aSYSLREAeYAO?=
 =?us-ascii?Q?oQg4AXr/dFTuQrr/j6l6S6E++lsgPwV+NrtuiKGAk1fpzw8yw4FWlUazWam7?=
 =?us-ascii?Q?z3YnXkbVXiUqalhEV/6yLZO2xlRPv+PRx72LuH9gsw1CxMLFMs5UfxXtOsLQ?=
 =?us-ascii?Q?C8UmdqSJ7IdR/IZ17P67ce5ABm1+DveaOEGbHoI/ADpa29TjP9FXyT8twAeA?=
 =?us-ascii?Q?ohqkwlwcnaBsDZfH6rq0m1eXzXRvuvYcNeYt/lYV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baefa717-9909-455f-5afe-08dadfd27cb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2022 02:00:35.4838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ybtJCJXazedXEp4SM/7pMyX1hzqFDY8IT8UxhAb2k/7YiLsK+hEpOFAJY4/S1icXtl0sONIadXYUiIUffrs6zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6313
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Dec 15, 2022 at 05:00:29PM +0800, Zqiang wrote:
> Currently, when CPUs going offline, the rcu boost kthreads CPU
> affinity has been reset in rcutree_offline_cpu(), therefore this
> commit remove duplicate settings in rcutree_dead_cpu().
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>
>One question...
>
>Given that rcutree_offline_cpu() causes rcu_boost_kthread_setaffinity()
>to be invoked with the number of the outgoing CPU, but rcutree_dead_cpu()
>instead passes in -1, are these two invocations really redundant?

Although -1 is passed in, but at this time, the outgoing CPU has been remov=
ed from=20
rcu_rnp_online_cpus(rnp),  in other words, we will eliminate the same CPU, =
which is
also  we passed in cpu in the rcutree_offline_cpu() before.

Thanks
Zqiang

>
>							Thanx, paul

> ---
>  kernel/rcu/tree.c | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 65f3dd2fd3ae..20de83ed0c7e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4122,15 +4122,10 @@ static void rcu_cleanup_dead_rnp(struct rcu_node =
*rnp_leaf)
>   */
>  int rcutree_dead_cpu(unsigned int cpu)
>  {
> -	struct rcu_data *rdp =3D per_cpu_ptr(&rcu_data, cpu);
> -	struct rcu_node *rnp =3D rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
> -
>  	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
>  		return 0;
> =20
>  	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
> -	/* Adjust any no-longer-needed kthreads. */
> -	rcu_boost_kthread_setaffinity(rnp, -1);
>  	// Stop-machine done, so allow nohz_full to disable tick.
>  	tick_dep_clear(TICK_DEP_BIT_RCU);
>  	return 0;
> --=20
> 2.25.1
>=20
