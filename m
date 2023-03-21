Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81ED6C2661
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 01:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCUAfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 20:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjCUAf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 20:35:27 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C779EEB7F;
        Mon, 20 Mar 2023 17:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679358925; x=1710894925;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IK3o8b76laNkF//9EHQFkALrDpHyao7/1PhaeFCO7UA=;
  b=dFVOrBLmlxGoJDutrEPkos5UkwXAjTSpVPVWGFmwdWflHVHAfy4enqHS
   QKooOu4Bk3PRfyuClFr/8sbFBYvsponwdeSJLQryGpClhLfQ5/gc59ZD0
   Q0dPOUV5IZKpIpygFGnwQG5kh5f6r0t/6pt9HyBW1VEL557x4LK8TU9CB
   9f2SauuOr8cHYwR4LWjPRQulsrScOzsuepAmdvNcxqLo5IrOmHqoQIBJ8
   /UAqVNqD0MP2bHsUy0h8WMuF/aa9TnfARaJJfLv6ykZ8sNoz3o5pSEemg
   KEYgQ/xXhlnb0d+srOI9Jsh85V+Wjk7ZjS4ZNlDBxEW+SxSa1n2l4TYzb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="341170543"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="341170543"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 17:35:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="658567913"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="658567913"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 20 Mar 2023 17:35:24 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 17:35:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 17:35:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 20 Mar 2023 17:35:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 20 Mar 2023 17:35:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvcaccNWlorpecfxmtYmyHOk5u6yszHL+FYINvrq2bxRJd+8eXBdmvXcaS3JJPtb+i/fKXgTGeKvdERNpLfO/UTBs0s21PRbA5XPKjRET/eJEEK8NU7UJMrqAbgkQXoElR8xMY3bHkxyyieUPgufi7eMFzKYF1Uq8Z6t4Gk2xf7brgzXbOodN4okMllLHn9dmCenAABk75Tpm005RTd/q3a45eAWbGkH90XvTZyL+tbW8hzh9jXHhITuhLnwGbPHkqwtxBbGJJRs9qIJNNjoU3qtcxYhVQwnA4my0bJ5pGh41zHC49X9X0Zy7MXdJLl4FkdMYvrDZ63TsSZ6Du4raA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtSfw6d5Cn7l6shFQ3fN1QqQ61rKpnkSPUi9xlUMKOo=;
 b=h2WiFz6NLYd3j7efYPdWH5nyaPkyQR2AS1kciNHUn1SVVLjXJkj/4249kSrDbLaXSh7lA+brcc+b74sBnifrT0HCozt1ucYCGkPUdc+QlZpvUkw4lb1fxvK6mVsFa+BouiZAkmj3kIlDf+/AzOr6sNm/xIp6EF7bbhLXKBQ+BNGM7zmdItkgK1Ot8eOL444kLzNoPgKYnC9b40h6z6pxLRbmhQB4nBJYFNWEDWfNnJHEkepBpBpjYQk4ZtvX+juSH3uSm3nWemsnWWnFnWJAGTfe8fUVdwoHvMkk+wBugPqNhOYUV7uGWL8zLr8i7yVQeT8EiAuEb4HM6HturSvmEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by MN6PR11MB8244.namprd11.prod.outlook.com (2603:10b6:208:470::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 00:35:21 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0%6]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 00:35:21 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcutorture: Convert schedule_timeout_uninterruptible()
 to mdelay() in rcu_torture_stall()
Thread-Topic: [PATCH v2] rcutorture: Convert
 schedule_timeout_uninterruptible() to mdelay() in rcu_torture_stall()
Thread-Index: AQHZWtris8fTdEhd602c/GqMXMcxwK8EHJQAgAAryuCAAAtBAIAAD3ew
Date:   Tue, 21 Mar 2023 00:35:21 +0000
Message-ID: <PH0PR11MB58807EB54BC051D39300C1DCDA819@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230320032422.4010801-1-qiang1.zhang@intel.com>
 <7a414721-25fa-485c-91a5-13d3149073fe@paulmck-laptop>
 <PH0PR11MB58806032CE88C9E6BE61059CDA809@PH0PR11MB5880.namprd11.prod.outlook.com>
 <5a887ca6-10e9-4026-b792-164deb80d0a8@paulmck-laptop>
In-Reply-To: <5a887ca6-10e9-4026-b792-164deb80d0a8@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|MN6PR11MB8244:EE_
x-ms-office365-filtering-correlation-id: e42d678f-16ff-49ef-c7ac-08db29a42790
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nUk93L0hvXMJb8eJKEpeBfeBQh+g1mBfkQY7G/kLrj5uBN+jNmjM2KofbSrYeEKcsgkCW5A+QFQmuVRRlAbMLlMRaZB9RW0ed66MGmry/BiXfnWkBp/TLEY4OOTFUOGrgOH3m2u7h0OVxsCmMq5Y2DE0Y5gdI2vCwZrib4YASgB/A4i59OUCZqYVnojAgOdv+EdLQr97DIvf6XKLyusn2KT5HKRC1vXat4+H1agVPxYbvyDRBZc/rvTKOBlDkuqqZyYyC4k04o9Oce3dSoglrppUnzykPhgy7xyDMqkAgX+c+g/HnynG4Xrb5AeObGtMcsrFgcPAlBPobc8qb8yGRtOVILAPFyVWZm8OVVC05dxMHfrS/Bu2mNkdir6wgc7Uq/EPjDTyb/UWRypdAMPZrggzjs0huf9it51k4RupQA3STBVPz7LG8wQ2cmFDZPC0qWOxHJlaoVDmkWahWos5IvltbH2P9j86zgqW+qSqHzp9yIGhoxoHqxIlvoUeeF93WBF6UatCw2M5zBJxWmDVBwVz7XiaK8ogMZYNgQMp2oq28Wed1XZb9FMbKdaBB8d7BX54pk7Qn6z2s9BYGGRaRB9c6p00R8F1E70aEmi9heWa1WlFJI3NCJPk9qxnDoEL/rNkNbXrjs5psN2e2lDxx//cFvDFHiWG6PSrhUtNVEOwsKucK/U4g+/J0NaCwJ5DPMIeRDzJh647sP2Q/KLB+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199018)(7696005)(33656002)(26005)(5660300002)(86362001)(6506007)(71200400001)(478600001)(316002)(186003)(9686003)(83380400001)(54906003)(76116006)(6916009)(64756008)(66446008)(66556008)(66476007)(38070700005)(4326008)(8676002)(41300700001)(52536014)(8936002)(38100700002)(66946007)(82960400001)(2906002)(122000001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kMdugRM3K/p/Yd0hCf6Ok6JQ4rvbwE1a07nmnMheDymaaQt3RjfGER9SXaoN?=
 =?us-ascii?Q?pi+TGpFtptloPTYJsHl8d0gaOzAkXpdvjY0EA4aIaciR6LHqp/tmm13GvLNt?=
 =?us-ascii?Q?uq0HPQc/N1X0/eEBTh8BHeBiTcZIHMLUD74u1/JN0AB67noAxN6EJqFFeCVs?=
 =?us-ascii?Q?jmrSmjf6zbcwmUzQ0nGp2Dy+DlPXmIm6PCrvbcU2fYxVogpI4wDh4IJRaeHZ?=
 =?us-ascii?Q?rfTEnkDSeB/+QaYG1fozmV9SzQmtMaTHP9QS9r5MhoH+Glxa0TTxq2YykfQw?=
 =?us-ascii?Q?U0MWskZBLuoT1YHrOeWDHtT9D2xTE6FY6DlzvQpUmlZ164kcmUYmjSSOeAv/?=
 =?us-ascii?Q?eeVhKt8tV00KfN+TEO8HhxzvM1tzlazPbSpUsq4zkbaoaioldH/NBHVKbnKk?=
 =?us-ascii?Q?y90lnJx7eyIuSLyFi+ZBPZlg2ablFdBN3+zGnrgZ5MRzZuQ2u/w+8iF3xytx?=
 =?us-ascii?Q?Xi/VLi08V5osU4P1qKBEjN+ciRpW6jJGufxDRCkj+NZTOL59jxgiH7Ld6OjB?=
 =?us-ascii?Q?QI0YZz3FzbdJLZfEAwx9Ev83BPdxgHOjMpA0Mp9Sb+QouFe/Frx8dy+EnIJK?=
 =?us-ascii?Q?Y0U5uCnQayGdYB/2Uk1H9C3k8DxWCj/Nms9hO8XUzh/j+nR3DgWT5BKwWYPc?=
 =?us-ascii?Q?robO+73i2OlsNVt2CB6qMsv9ORDj65Lk3JNhx8a94QtUrNhelaaLlDSscYez?=
 =?us-ascii?Q?JjNyPKk1n9ixuwXxdZtah1hvECjFYrqZ4YgOv7j9ZBTrH1A7C+lC7sw6jyCx?=
 =?us-ascii?Q?+1mch9/bProEEGUAHAxDcneoMroAF7DTiegU4HpHducrBsHGtubGsIOS7LbK?=
 =?us-ascii?Q?WVfTWGI/niveKGECPyItipiBZscEpeyAYAFClvnzPi4VINOOWKN7KYIi6zyA?=
 =?us-ascii?Q?iXUQHhQQ+vND3LZ5CbDsIyJ8D6enA6z3iAaf96+xMFwjMux6yNZtLipksS05?=
 =?us-ascii?Q?BaSUwrNb6dRqwvKrerqRJCZNY9Z4fttfk45VLp/th1CRfd1gU07oor4A5zQy?=
 =?us-ascii?Q?OGiLDbL8lr1bgsTnWrUItwen3bnHxl3eSSf/fJGyiUjS2bYgzYfqItGUh/gl?=
 =?us-ascii?Q?U6G88tBq7DHsJE6ajCmiBUmjg37vqCIjA/Rd+nmlS/cNzV6oLfjunOeDhvxh?=
 =?us-ascii?Q?7GfgtRhp9Mv4g7EQiOJ+EvliXDtpJNKv6GkkU+SFMiGJf1sEBf82x4JxA1j7?=
 =?us-ascii?Q?0Tz8k/ZU+BWmfag5bCUdbom3i5ZeshoHpO9pupDzjzK1RHWWC2X50HHwx6pV?=
 =?us-ascii?Q?sDpXxSXs14cw2GcY7zFLIkOk1axSkR5vgLrwdlqErpgeOIhtqZsv1Vz84cVr?=
 =?us-ascii?Q?9kSirZkNkoTwCFdlNaY2TsDHfCkqlEp7bwchrBdZsm3PGDGcRNlFRbosSvUy?=
 =?us-ascii?Q?rw0ZewaYUUfYyzXZL63ZOIlahwbdu93jzWuecpYvIj8mu5WQ2Z8QxRHhxOBS?=
 =?us-ascii?Q?vl59LbYCkCuI377Wd8BQ4i2hmzWaWKCV6E3psV6+B1/5KEUPGv2A7Cpkcw/9?=
 =?us-ascii?Q?DeoE1c6ALSzrRLQDr5JRs1yM2TV/CICnU+H+bGSIdGLwcGv4NTH7OjSHLBKP?=
 =?us-ascii?Q?n2fbAIoRpuXWTVgbtUQcoCPVji3brb3y0Ovus1Dh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e42d678f-16ff-49ef-c7ac-08db29a42790
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 00:35:21.7763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EDeV0FZASORLCauD/wAvtkXOXK7NiMSAxh5fI72CGcoxmAEzwzhYAg7yAb18qbZQWfyIEnClZFJs7W25YchtXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8244
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > For kernels built with enable PREEMPT_NONE and CONFIG_DEBUG_ATOMIC_SLEE=
P,
> > running the RCU stall tests.
> >=20
> > runqemu kvm slirp nographic qemuparams=3D"-m 1024 -smp 4"
> > bootparams=3D"nokaslr console=3DttyS0 rcutorture.stall_cpu=3D30
> > rcutorture.stall_no_softlockup=3D1 rcutorture.stall_cpu_irqsoff=3D1
> > rcutorture.stall_cpu_block=3D1" -d
> >=20
> > [   10.841071] rcu-torture: rcu_torture_stall begin CPU stall
> > [   10.841073] rcu_torture_stall start on CPU 3.
> > [   10.841077] BUG: scheduling while atomic: rcu_torture_sta/66/0x00000=
00
> > ....
> > [   10.841108] Call Trace:
> > [   10.841110]  <TASK>
> > [   10.841112]  dump_stack_lvl+0x64/0xb0
> > [   10.841118]  dump_stack+0x10/0x20
> > [   10.841121]  __schedule_bug+0x8b/0xb0
> > [   10.841126]  __schedule+0x2172/0x2940
> > [   10.841157]  schedule+0x9b/0x150
> > [   10.841160]  schedule_timeout+0x2e8/0x4f0
> > [   10.841192]  schedule_timeout_uninterruptible+0x47/0x50
> > [   10.841195]  rcu_torture_stall+0x2e8/0x300
> > [   10.841199]  kthread+0x175/0x1a0
> > [   10.841206]  ret_from_fork+0x2c/0x50
> >=20
> > The above calltrace occurs in the local_irq_disable/enable() critical
> > section call schedule_timeout(), and invoke schedule_timeout() also
> > implies a quiescent state, of course it also fails to trigger RCU stall=
,
> > this commit therefore use mdelay() instead of schedule_timeout() to
> > trigger RCU stall.
> >=20
> > Suggested-by: Joel Fernandes <joel@joelfernandes.org>
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > ---
> >  kernel/rcu/rcutorture.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> > index d06c2da04c34..a08a72bef5f1 100644
> > --- a/kernel/rcu/rcutorture.c
> > +++ b/kernel/rcu/rcutorture.c
> > @@ -2472,7 +2472,7 @@ static int rcu_torture_stall(void *args)
> >
> >Right here there is:
> >
> >			if (stall_cpu_block) {
> >
> >In other words, the rcutorture.stall_cpu_block module parameter says to
> >block, even if it is a bad thing to do.  The point of this is to verify
> >the error messages that are supposed to be printed on the console when
> >this happens.
> >
> >  #ifdef CONFIG_PREEMPTION
> >  				preempt_schedule();
> >  #else
> > -				schedule_timeout_uninterruptible(HZ);
> > +				mdelay(jiffies_to_msecs(HZ));
> >
> >So this really needs to stay schedule_timeout_uninterruptible(HZ).
>=20
> But invoke schedule_timeout_uninterruptible(HZ) implies a quiescent state=
,=20
> this will not cause an RCU stall to occur, and still in the RCU read crit=
ical section(PREEMPT_COUNT=3Dy).
>=20
> It didn't happen RCU stall when I tested with the following parameters fo=
r=20
> rcutorture.stall_cpu=3D30
> rcutorture.stall_no_softlockup=3D1
> rcutorture.stall_cpu_irqsoff=3D1
> rcutorture.stall_cpu_block=3D1
>
>Understood.  If you want that RCU CPU stall in a CONFIG_PREEMPTION=3Dn
>kernel, you should not use rcutorture.stall_cpu_block=3D1.
>
>In a CONFIG_PREEMPTION=3Dy kernel, rcutorture.stall_cpu_block=3D1 forces
>the grace period to be stalled on a task rather than a CPU, exercising
>a different part of the RCU CPU stall warning code.
>
>In a CONFIG_PREEMPTION=3Dn kernel, using rcutorture.stall_cpu_block=3D1
>forces the CPU to go through a quiescent state, as you say.  It can
>also cause lockdep and scheduling-while-atomic complaints, depending on
>exactly what type of RCU reader is in effect.
>
>So these are test-the-diagnostics parameters.  The mdelay() instead
>makes rcutorture.stall_cpu_block=3D1 do the same thing as does
>rcutorture.stall_cpu_block=3D0 for CONFIG_PREEMPTION=3Dn kernels, right?

Yes,   maybe  we can increase the description of the stall_cpu_block in ker=
nel-parameters.txt.


>
>							Thanx, Paul
>
> Thanks
> Zqiang
>=20
> >
> >So should there be a change to kernel-parameters.txt to make it
> >more clear that this is intended behavior?

Agree

Thanks
Zqiang

> >
> >						Thanx, Paul
> >
> >  #endif
> >  			} else if (stall_no_softlockup) {
> >  				touch_softlockup_watchdog();
> > --=20
> > 2.25.1
> >=20
