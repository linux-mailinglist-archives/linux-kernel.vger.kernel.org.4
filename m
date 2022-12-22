Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7834B653D99
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 10:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbiLVJmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 04:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbiLVJme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 04:42:34 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFF163F7;
        Thu, 22 Dec 2022 01:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671702153; x=1703238153;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=d/WEBnAr0jBEkQ/kJ0YTKcJfJMJiRE7OSxp0ZVdKh5c=;
  b=R+Qw8LtvYkc25ECqicjf/HbmUBRJgUspzapSwgRabf/7goSWqbuEgXq2
   oXzE5GIMzFXOxtDuc8sy6gESxKeQljbkAvAaBMFnu1LZnVdVEbG+P3D5g
   AUxkYOYg4eM26ZwY0NuvMBjg5x8TRnV1FJuVeRNCXFH50RGbWhoGxgoMm
   0WrFJMCNkJNU1hQGoRfwCjb/ILM3ZG7IMBK2yJvl+hbpz9Bl2oVkyWUtj
   CA1urvy9Qm/FEe4/bTtYS2vkb0lTyV2W0I0fe17NNbmxypHEVnBcsqwxF
   y63U/0KnZo78/H2afiMGZ9wWHwd8WSgMHAAYW7Dxox/R6c4Dqaa/ZgtwK
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="307773671"
X-IronPort-AV: E=Sophos;i="5.96,265,1665471600"; 
   d="scan'208";a="307773671"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 01:42:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="740490585"
X-IronPort-AV: E=Sophos;i="5.96,265,1665471600"; 
   d="scan'208";a="740490585"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Dec 2022 01:42:25 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 22 Dec 2022 01:42:25 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 22 Dec 2022 01:42:24 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 22 Dec 2022 01:42:24 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 22 Dec 2022 01:42:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSJQg3hN+4cLZvL6purnNy0l72aQz0YVKfZCZ8vilcG2uurlBlJzwsQGrY6lCPXGJ9W99K/tVU9VK+YO7nXkXgWNKoDyMHX9q9dyl/YJHPq87PQM3TwkM8tQ/2xha/Sr6zgYhknW28sQFV8mt0/KmO6WSKkrspXYyIEh8cYUC7cHciAm6qpi0cHvBwEPCMEInk2BFl3NsVI/3LLSA1c41GDQM38Ruv1CKmyMfksg3mreuBaK4XuiZ2j6AgzOinkTJiG49MsGKczb/h/99/oje2b1cfcf0ubd+4+QsEWQJJ5Y6n5/ffnvu7uTyCc58mHOu5IuL6X3rgLV6ND3HSSuKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4OqHQqR5GP/sGMwH8LZ5PLRlStAOmX9e26VbiSHPdQ=;
 b=HCuzGX7tjhnSM59b0SzzA9O1bQ8Igx3j7GRcSvrb/jLYJDk9l+tpuYVaoLG97n6rLL1O3D4mcOhWA1gkEOTVx/Mk1AfOrr03FoaSYqkbyIw+Q9zcbkay29GUCbOjT4epaffKbfnfZzbTPwgFGD1DOYFnvhNnCWGxxnAKeuxyLRlceoBzIK4OP6c+xh8/6Wcfo0Ulz0UJAgx2OAEO2nMBkd+7S7OzVrAawHTHiBiLy5GzOI6Ku/ZCiNU7I0m04sKkmwwYkP7e002O2QMkq7vl9AjFOaLzMHfM3KRruKohFLqQpROF9Xc460yO7BBl670y7aBkVwHGmhWeS9PI0g/7KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by PH7PR11MB6699.namprd11.prod.outlook.com (2603:10b6:510:1ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 09:42:19 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018%6]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 09:42:19 +0000
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
Thread-Index: AQHZEGMOnvxGUFjU2Uq5+RiLJLzbVq5xR5qAgAABybCAAMOa8IAGtnQAgADtg5A=
Date:   Thu, 22 Dec 2022 09:42:19 +0000
Message-ID: <PH0PR11MB58802F8D66E4FBA455E15CC8DAE89@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221215090029.2972236-1-qiang1.zhang@intel.com>
 <20221217010919.GG4001@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880B9403488CAB5DF9810FFDAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB58806ABF242993103390A6F5DAE79@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20221221192622.GD4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221221192622.GD4001@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|PH7PR11MB6699:EE_
x-ms-office365-filtering-correlation-id: 7ca6b262-b1a5-476e-591c-08dae400d1a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y1Rdg7m2tKs8kYlXtwuo5dGd4QvrvKbdeAOhPKAn3lg2F3+yDQhLqkfKAxmrNZe3DZoBaBhem3Hy9QJ9vh46dgupgbwenOwocysATG3y0YgDL0YN3IZn/tTFN2zO9psUZTL7Bs7kF091yEv8d1mxUKHwlVOixaVJddML6kdbEaGcg4DEztttwsa36hey1Axo/gqblNatoQuC3QUbvd9j6t5phnAFZGlFsT/x3fZF5e9rCFWih3tIKBtkoeJcuuJhhx9lEe3Cm93TWjsAkcOFfepJDy5mvNG2EpTVHCd+zdFRnEIYO3CA7Tw/+Ky9NKwjfiLHZaGl+s+YisFdL6/KKrlJT2bfssBmiN1YQq1weAfWP4jvPkhp4Zl1Yt55/2fto3WiB0+QFzWaux+0wut2tN03WuDysU2RD5hwPmeW+VQvKFAM0wWWGYPkMZQlWHQ2v3lMB6KIwiIdXPIFHSZlxkQVIGR8NplVRgrxuqzHHaUE07jPjRedPl0Jo6PzaSJU/P+zvbuv+Zt6Y1qAia2xR9juH7pvhCb8KznHPzy2yr1ijfSCxT4aZGCgFiFjeJiX2mqSvSlbKF6OaSgjjvVcmZsXRnL6B3di1Hail/u3A+lVYe81FfOuwSBBGgNA+Uj/D1h+7whVvKnpEH7nX+SE9688mDgpSReVbrNuzy4pMyadr/93c99A8sZ7lG19H5gVN783O9mLTPeH/1J33dqRug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199015)(38100700002)(82960400001)(41300700001)(8936002)(122000001)(52536014)(76116006)(66476007)(8676002)(4326008)(64756008)(66946007)(5660300002)(66556008)(66446008)(6506007)(83380400001)(478600001)(54906003)(66574015)(6916009)(316002)(38070700005)(2906002)(9686003)(71200400001)(33656002)(26005)(186003)(7696005)(86362001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/9bQCWiXPDHxtVJT0wG4WovwWp2YmdUBG0I7UTtMHG6M6Wop5bP2mTo0uHsL?=
 =?us-ascii?Q?A42s46sKkERQ1qbU++ieKvWnpZfUCu/79f4CGrzan7C/E74P4vyoQMaMp+y0?=
 =?us-ascii?Q?8rry6BR6X1S3Dg0rwweUP6GmAaMwXudWYE2zKTBCr3T9GTA3bwBcD13P+Aud?=
 =?us-ascii?Q?h6NErjZX6MMNK/3HVbrhAPlgME0KdYUOnWikPcPv7OqfR+s6BVhHCg76zCYh?=
 =?us-ascii?Q?QSuOhd0SeI9s+9cHClhVffwgIgQ27gAxweXsh5yl+kgxP3aG9zI9URQF3qkv?=
 =?us-ascii?Q?M7MpXzEWhea5QyOaluhvfl7i9fzWlu8om2zdphPsrHt+/D1cFDNQFEWgpMBE?=
 =?us-ascii?Q?/lTPzQ1reeDS3C2cpG4zOeNUHgfJl8x/2sUFLxkJ3zBZ5BLpycOPoRHgorZM?=
 =?us-ascii?Q?j+/S3+rdZwwgW/mH0bCfHJhxquF3XKdk0fyVcQ6hnxdIShAsAvmimSVdRwHv?=
 =?us-ascii?Q?IxA/kkrpXehW13fUbYXqtXf+UIJjbGMIy2QrnhrIber6AetPO/1QjY/XXI7H?=
 =?us-ascii?Q?fyrJOQVY27vUMHMi8I0CJdX5L8i1CPxt7D5uFOpntazaPJlP/edLt4fEieEr?=
 =?us-ascii?Q?I4NQ6uBlN17kYseu8+q/TzCAG1o9PtnDv90mZogNzY+KRZnxgVjpYfwcPueP?=
 =?us-ascii?Q?Pq0YCKpoBGa4nlCozE2DoXikgf+SkYRp6exUYAXc8Mm+W0c+loGSAdrgTQjp?=
 =?us-ascii?Q?o1o/OfHV9jflkOrHpSyX/Pg8nGVLUZ6I07b3vQ9x33+eqI4JcaFLzpC6ya6x?=
 =?us-ascii?Q?syqaVaGnD2vz56FkxTz206w7RTJYtFtYtlN75Q4YflufmkCY4Gdy6waoUyGd?=
 =?us-ascii?Q?t9XDKu6tROmFYNq/PVO44bTnv/cdIgKUjsef4lm6OPZfg/PcUNgw5Aa7FsGa?=
 =?us-ascii?Q?Oebz3+fDyiCq7upla2nMqJLcGFmh4jK1CmCo+ULxGLGPW9L3y9dDWmAzh60T?=
 =?us-ascii?Q?VvqAjR5Lwia1ZzSTkJ+vPgfpqQ79LPDliyV0lYBdy4BdHgSSIkmXn+JO/hpI?=
 =?us-ascii?Q?HOJ8B3G/vfaZxeFWffqQZhKaUMsRtOzW3NCnML5E2WJgEBIa5NMJMk9v3Lp6?=
 =?us-ascii?Q?evMzO4Adw/BKrfd+ocdxSnX5sd1T36DOU4aEmKmb/FMz6oeLCZhSmr2sxJgV?=
 =?us-ascii?Q?ACZITkK7p9eEItdOooI6v+JmYZrRwRsFDdJgA8RGCNpjBHBtBQH5TyyOZfAY?=
 =?us-ascii?Q?toXuWBQ9rtek0qhXXRno3SvpVcM347QKNYuIvLS9pXnkxvT1F2IsKP0tTAKx?=
 =?us-ascii?Q?+4J5+z81Dp4j3+b2R3FXEhPcOUGK7Auf6Lg25aIG0baoT0hXL9EZhsj9h88X?=
 =?us-ascii?Q?vllnnVnhR+2ZkrrF5SNOtp2tLBQPes4+9xWqUyEtcF9U+/Wmzf6WXLiVrnO0?=
 =?us-ascii?Q?m3VQECCteYILarudCPtsF+sH+M58paklx2TV4Avt43ueTn/PQ82euvxIh+c1?=
 =?us-ascii?Q?ZJUYaAl1iFEMHckwtDl7Q3W0eYI01V+2vXuuYJhq/h462SJ3KYJpoN7y/SQA?=
 =?us-ascii?Q?K59ZiEqoDvzfdnafCn0PHMY6/m/vUdF+sdLBXDq3/xaTXbGJKYShrA5Us8rY?=
 =?us-ascii?Q?RwcJ2NBsU2JDDndTHtRS/LNRiCYLU6aGvl/dbcTq?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca6b262-b1a5-476e-591c-08dae400d1a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2022 09:42:19.4269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3KEva6d6yoUaS2kbyGulerGArVgay62EX8njHzbxl1LX85t+la3Ine5tdo/uc1/MGtnV2V6ozR84os6JUYOWmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6699
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

On Sat, Dec 17, 2022 at 01:02:03PM +0000, Zhang, Qiang1 wrote:
> On Thu, Dec 15, 2022 at 05:00:29PM +0800, Zqiang wrote:
> > Currently, when CPUs going offline, the rcu boost kthreads CPU
> > affinity has been reset in rcutree_offline_cpu(), therefore this
> > commit remove duplicate settings in rcutree_dead_cpu().
> >=20
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >
> >One question...
> >
> >Given that rcutree_offline_cpu() causes rcu_boost_kthread_setaffinity()
> >to be invoked with the number of the outgoing CPU, but rcutree_dead_cpu(=
)
> >instead passes in -1, are these two invocations really redundant?
> >
> >Although -1 is passed in, but at this time, the outgoing CPU has been re=
moved from=20
> >rcu_rnp_online_cpus(rnp),  in other words, we will eliminate the same CP=
U, which is
> >also  we passed in cpu in the rcutree_offline_cpu() before.
> >
>=20
> I also used " qemu -smp 4 "for a simple test.
>=20
> 1) rcutree_offline_cpu()
>=20
> (gdb) bt
> #0  set_cpus_allowed_ptr (p=3Dp@entry=3D0xffff888100bd9cc0, new_mask=3Dne=
w_mask@entry=3D0xffff888100ce7cd0)
>     at kernel/sched/core.c:2939
> #1  0xffffffff811be169 in rcu_boost_kthread_setaffinity (rnp=3D0xffffffff=
837a4c00 <rcu_state>,
>     outgoingcpu=3Doutgoingcpu@entry=3D3) at kernel/rcu/tree_plugin.h:1250
> #2  0xffffffff811cfa9f in rcutree_affinity_setting (outgoing=3D3, cpu=3D3=
) at kernel/rcu/tree.c:4297
> #3  rcutree_offline_cpu (cpu=3D3) at kernel/rcu/tree.c:4341
> #4  0xffffffff810c4e6f in cpuhp_invoke_callback (cpu=3Dcpu@entry=3D3, sta=
te=3Dstate@entry=3DCPUHP_AP_RCUTREE_ONLINE,
>     bringup=3Dbringup@entry=3Dfalse, node=3D<optimized out>, lastp=3Dlast=
p@entry=3D0xffff88815b027568) at kernel/cpu.c:192
> #5  0xffffffff810c6e24 in cpuhp_thread_fun (cpu=3D<optimized out>) at ker=
nel/cpu.c:785
> #6  0xffffffff8111784e in smpboot_thread_fn (data=3D0xffff88810014c3c0) a=
t kernel/smpboot.c:164
> #7  0xffffffff8110c88e in kthread (_create=3D0xffff8881009b8b00) at kerne=
l/kthread.c:376
> #8  0xffffffff81002902 in ret_from_fork () at arch/x86/entry/entry_64.S:3=
06
> #9  0x0000000000000000 in ?? ()
>=20
> (gdb) p/x *0xffff888100ce7cd0
> $1 =3D 0x7
>=20
> 2) rcutree_dead_cpu()
>=20
> #0  set_cpus_allowed_ptr (p=3Dp@entry=3D0xffff888100bd9cc0, new_mask=3Dne=
w_mask@entry=3D0xffff888109fc7948)
>     at kernel/sched/core.c:2939
> #1  0xffffffff811be169 in rcu_boost_kthread_setaffinity (rnp=3D0xffffffff=
837a4c00 <rcu_state>,
>     outgoingcpu=3Doutgoingcpu@entry=3D-1) at kernel/rcu/tree_plugin.h:125=
0
> #2  0xffffffff811cf4a1 in rcutree_dead_cpu (cpu=3D3) at kernel/rcu/tree.c=
:4176
> #3  0xffffffff810c4e6f in cpuhp_invoke_callback (cpu=3Dcpu@entry=3D3, sta=
te=3DCPUHP_RCUTREE_PREP, bringup=3Dbringup@entry=3Dfalse,
>     node=3Dnode@entry=3D0x0 <fixed_percpu_data>, lastp=3Dlastp@entry=3D0x=
0 <fixed_percpu_data>) at kernel/cpu.c:192
> #4  0xffffffff810c58f5 in cpuhp_invoke_callback_range (bringup=3Dbringup@=
entry=3Dfalse, cpu=3Dcpu@entry=3D3,
>     st=3Dst@entry=3D0xffff88815b027540, target=3Dtarget@entry=3DCPUHP_OFF=
LINE) at kernel/cpu.c:675
> #5  0xffffffff827a5f6a in cpuhp_down_callbacks (target=3DCPUHP_OFFLINE, s=
t=3D0xffff88815b027540, cpu=3D3) at kernel/cpu.c:1170
> #6  _cpu_down (cpu=3Dcpu@entry=3D3, tasks_frozen=3Dtasks_frozen@entry=3D0=
, target=3Dtarget@entry=3DCPUHP_OFFLINE) at kernel/cpu.c:1170
> #7  0xffffffff810c6ff8 in cpu_down_maps_locked (target=3DCPUHP_OFFLINE, c=
pu=3D3) at kernel/cpu.c:1202
> #8  cpu_down (cpu=3D3, target=3Dtarget@entry=3DCPUHP_OFFLINE) at kernel/c=
pu.c:1210
> #9  0xffffffff810c7906 in cpu_device_down (dev=3Ddev@entry=3D0xffff88815b=
026988) at kernel/cpu.c:1227
>=20
> (gdb) p/x *0xffff888109fc7948
> $2 =3D 0x7
>=20
> As can be seen from the above, we have set the same cpumask twice for the=
 same boost kthreads.
>
>Very good, thank you for checking!
>
>I have queued this as shown below, so please let me know of any issues.

I have checked and thank you for the clear description.

Thanks
Zqiang

>
>							Thanx, Paul
>
>------------------------------------------------------------------------

commit 5815245b56229198d5f5d0c48c26d3c0c53ee222
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Wed Dec 21 11:15:43 2022 -0800

    rcu: Remove redundant call to rcu_boost_kthread_setaffinity()
   =20
    The rcu_boost_kthread_setaffinity() function is invoked at
    rcutree_online_cpu() and rcutree_offline_cpu() time, early in the onlin=
e
    timeline and late in the offline timeline, respectively.  It is also
    invoked from rcutree_dead_cpu(), however, in the absence of userspace
    manipulations (for which userspace must take responsibility), this call
    is redundant with that from rcutree_offline_cpu().  This redundancy can
    be demonstrated by printing out the relevant cpumasks
   =20
    This commit therefore removes the call to rcu_boost_kthread_setaffinity=
()
    from rcutree_dead_cpu().
   =20
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c3255d27286c4..a6181b76fd5ab 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4165,15 +4165,10 @@ static void rcu_cleanup_dead_rnp(struct rcu_node *r=
np_leaf)
  */
 int rcutree_dead_cpu(unsigned int cpu)
 {
-	struct rcu_data *rdp =3D per_cpu_ptr(&rcu_data, cpu);
-	struct rcu_node *rnp =3D rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
-
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
 		return 0;
=20
 	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
-	/* Adjust any no-longer-needed kthreads. */
-	rcu_boost_kthread_setaffinity(rnp, -1);
 	// Stop-machine done, so allow nohz_full to disable tick.
 	tick_dep_clear(TICK_DEP_BIT_RCU);
 	return 0;
