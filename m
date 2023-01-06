Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5C36600CB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 13:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbjAFM6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 07:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbjAFM6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 07:58:14 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9F4736EE;
        Fri,  6 Jan 2023 04:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673009892; x=1704545892;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SD67aBQnma9FHdf+bzFc0XgfZEakO3gra5N3eJ3oOQk=;
  b=PhkmqyBxTtmK+vYzETTuuWMF8NYHT8Svpr1EItOY2GapporfNau2fqrv
   As4WBQpxwPOSi7aMFpQseuYW0M0NovIwNDiEHjarl7YGujn0CyKfgVnXq
   MFQIVIDg4rTZMpz5so1bO1JVudZ/kWocGJIKVPtaK8c1Rp99XvImCcEXo
   aL5S8dsxo/5+j2COOqVV0ncyWz8oob8hl1VwUBjyBT/fNV3hhNvcYFeKB
   kYAhWaGy3DgZ3nNVKbpe2VOhCgoF8IVdMlHjiUzMYNjYGBX6UP3ghlgd3
   7NjS1/eBgk6WUTr82D8Dd6LrmPRb07yg8OpJAHvqgJ4/rqzzIDR2PcNyJ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="320175784"
X-IronPort-AV: E=Sophos;i="5.96,305,1665471600"; 
   d="scan'208";a="320175784"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 04:58:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="763514130"
X-IronPort-AV: E=Sophos;i="5.96,305,1665471600"; 
   d="scan'208";a="763514130"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jan 2023 04:58:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 6 Jan 2023 04:58:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 6 Jan 2023 04:58:11 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 6 Jan 2023 04:58:11 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 6 Jan 2023 04:58:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KO2nD4WUZiWzwlG1bSOX2a2A7taGGiQGM8hyAwDAJhFmk5cBgSGiPtToK8ugnfuL5WLWrtgV2qajyR3KgLgFk2oxS5fhDmrSilPCzlAGE3au2lRpNB4eI0YKSN0YulpgfTszv+Sy+CHgJeL5T2Z3uNdA6foPbqh4uLG+2tK2pm65uZSUkqxEjVkqgJvi/ZtjsO39FCvFRETC7u85Lgn7SZG1ytvze1td24WmSdedmcVgJfIUdXSTXz0aJ9v4e1ldkYLBzATKH5F6LtCyq3Q8/xWFEaHwmDUyul24WN9tJi07UcCPgdi6GfN1IvR4Gi9CZjkkI/wu76/K4Rld0P9rTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2VV0jJZAEI+VDiVmakmZ5cCog8qJIh9Ys7okL/Ug7E=;
 b=oSG3BtVzpoDA3A9Pjor/Py2YL5idJefqIk+zbNt/AA9tKonEz8ns82AVoGYCdoHCiNyMBrAr6zJka4NlXxlwE2y9nrjgmTEL+7nMc53TTlRIibm/0rV4QgbDH+Pm1OmkcnO6CHhBgygB+h8I2rfG6RxGgt/IQKySkihwWoPQWEPvbuTvm1slVJYJYb7rrOiMugcfwVH6y8TLj2fgv6vT88oDkbIYr1wxtxS+xwYq2DAwRP5Ae6p0zwwiO4G2l5SzHAAgXQNSEjY+x6pLoQUhq5ThTpA5fsQTlBJShp1frJebYcdt5jPu/3Ug2PtWuzyNixKtn8Geqo4D6wvou2RC9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by CY5PR11MB6236.namprd11.prod.outlook.com (2603:10b6:930:23::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 12:58:10 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018%5]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 12:58:09 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Safe access to rcu_node structure's->exp_tasks
Thread-Topic: [PATCH] rcu: Safe access to rcu_node structure's->exp_tasks
Thread-Index: AQHZF1d1vL7vqzT7Rk6Qh2aIcidsQa6Q0uoAgACaqqA=
Date:   Fri, 6 Jan 2023 12:58:09 +0000
Message-ID: <PH0PR11MB5880A02CB83F4AC48A99E9F8DAFB9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221224052553.263199-1-qiang1.zhang@intel.com>
 <20230106034146.GM4028633@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230106034146.GM4028633@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|CY5PR11MB6236:EE_
x-ms-office365-filtering-correlation-id: 96992f40-9963-4a39-ce0b-08daefe5a9a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OjfOdPSU/DENLg1mm7sn7VfEyMsa9SDhOa5z1vkrKONUP4XnP6in6tOIDzV7PyGz/2/FNSFdggOogsYoAfIlOKjDlXrv/rMqQ5YlbCL/XbU4CenXTirRSg/fQ0bBrkhboowjJ3ouNGqk4zGCXzv06Fl7+yaNOBQXBYPOlOJsXiViDrGBOjNXKR3/FIl0yowg9F4d8wSi5tMSChh/tmEz8OkWHsDBFW1kvGw9R/nionk9SUQhzIKWFJEJ809UmdEr+MaQVnpz5wA/YMpphqAh7c+MPWbpK+JqrYXZ1ZeRuEY8iX+puyg4M3RAVM9m96Yk0wrgQKPiKrp2Vg0JfVXLq9fQ8MstrNJ+Oh+7TnGEG2FpPuPZNBqMwT1BYdF2yiNyy8jrpz1ZLrM424c/qx4RGP5HfTw9OygU48r+UtCFb3OIoYzK12dkGrkDlGa7QMRizvpvUM5HmLNlUYeLmdbMIfYoxRgTtpCOveqbVpB4gHGnV2IRXqB3LQnhY4gdTFuGqqeVoUhMTlNvYhh3Kgtd6PD6zXK77C87P8NFLHKPUSMOusPCk9FpKiFTUfeioL2xNuSii/j6dBP64pZpXxTJo6bFxBNWuJ9FL50vmiMkJMEWwr/XVkKZwY5Aw/V2hFrOmh2/WmxqSutiyONuTmQ08OEuFah7BO52uSYlN8DtDF5FCx2C+oSNGYqTQY1imh+GL1O0BuhdnUeD77nWcg1RDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199015)(76116006)(66946007)(66556008)(4326008)(66446008)(41300700001)(64756008)(38070700005)(316002)(8676002)(66476007)(54906003)(2906002)(86362001)(5660300002)(52536014)(82960400001)(38100700002)(122000001)(55016003)(33656002)(6506007)(9686003)(478600001)(8936002)(26005)(186003)(83380400001)(71200400001)(7696005)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+f9vvApkmVOceHzTLNh9CzOG17ZxeEF8j/GMHnDzUsLBc9bjG5nMTlWzWdR9?=
 =?us-ascii?Q?qFxKVvtjfXo/FBDEJLXQMNHZh7TWWkepUNi9QT7p9g2iA0EkeGVB30fNqA5z?=
 =?us-ascii?Q?5Ehvc6EmYS2A1aYvgGvDIC9f62HsEEojibtG0/7MejdZcuUNkbLaG0XMRC+f?=
 =?us-ascii?Q?REPaX6vSM92GHWMoW+/IcSf28U0tULhVS2rlKBIShfErAXmxgYMS8rHykg4s?=
 =?us-ascii?Q?wJ486s6P4H4NkAyvZ6gUpiVpZnRLn5VC0RBTPjdGlDax7v5tpA4N98ebp1XW?=
 =?us-ascii?Q?4Q9rVwYOweD6kLiZtFwP6kQ3Mw2At6GGA9fRtU0VhNFHAM3R1p6HWwAyCLoJ?=
 =?us-ascii?Q?t/2gUfJwia2FHtr53ooE17HrLi6e1rDAe+vnGa+MKnRo69WdmkdWuUBHAZJG?=
 =?us-ascii?Q?DeTfpBgFDH4QQ4OGlvMVPP2Y0DvhConW6DYEX6FFWyyjzcOFgCtf0nMJObNI?=
 =?us-ascii?Q?+5hAkGGdvf5/JkE/kjgrjME6aG7GtVI/6OUbbE9WGd9OQD1Fd3KKCaDUKkxJ?=
 =?us-ascii?Q?npkEY/1oJWloeFIxUo7WeYjPoWIBeegUpPFgQC/UAsFWT1cq0ET0Z14Ezyu7?=
 =?us-ascii?Q?ZsFFIurNaSVQzBLsiHAc0T2ctvj60tkGBmqm9Eo28jFULHthxo0tD5QJJcZE?=
 =?us-ascii?Q?TLJVqiltkfuhfW8ZQbgBcmv+kpAWFATiLfQVcuDP0nd4TtYbuwlU6IYn5duK?=
 =?us-ascii?Q?p3EqErqMt1ODa08aL+lBEkaIjMCS/2CZr38ZsWHNAhPMbXzDWli+CEAIvyuS?=
 =?us-ascii?Q?52vshQhThLyTV1/a3SGa3EUFAAVDJ767kxZBnkD/nfyVZwrkv5PFV4SFiHz8?=
 =?us-ascii?Q?E7Bq3XgX4NlmWBfcHPeEY6F44wt44FRlDtajdGvVzp0UCiD412zXo+rctrtm?=
 =?us-ascii?Q?HWBPKqulzBoS5XjwE3c4xupx17se84HpCbznr9gD+JzzJdFdUqvpr0aVtHoA?=
 =?us-ascii?Q?IO32IAm0jW8fjyz2Ix32mmrmYp6+kUZblIRvAKZGQukYPQD9WwdEWn1K+xKb?=
 =?us-ascii?Q?5Y4whPUl7EuKdigS3TOgM9ByE7AYRGEhOdfAGVpA+KfRj5NkaawT9KRpvAfG?=
 =?us-ascii?Q?dtwJI6/uMCPSBVYndzyiaP2Oz+/dzwP9ZDJnILmog+Pp5tmVO6z+ySLqFH3w?=
 =?us-ascii?Q?8FzpYGh4zhpPN5c84rIE/y+6GucjZS5kJCv5gRLIMgKOBpK0M4LVmkI9nBPk?=
 =?us-ascii?Q?yW3eVJLgkMBdHxfCrqbWzKgTvq/RzpHALR4FF//Dgjh7bQSDI/36EOBa1vNS?=
 =?us-ascii?Q?L1VVFzqxr9ndjtXNSKOl/kt+X84njbWG8cluuPGgBd3XXNoXbrLt/p77xOjY?=
 =?us-ascii?Q?fNSO2eBk5QC0BiuktlTFJ6u0Zim8ts7CNLAZmhX2Bt3uV+0r9b5VKxGu3UKM?=
 =?us-ascii?Q?qAjx+2QZp/FnMZ/vs++kk1hxKYPq3edZOWJ8nKU/QSohtizAoONO0vkK89Mc?=
 =?us-ascii?Q?JSi4e61+GnMogbVXAVHOKAySvtK7orGN0yZa5q8qTlW4IKnxPgFWJrC/IbMJ?=
 =?us-ascii?Q?bhBPNIk8iWcgCGutE2E4h9xUVe5q1nBzZBSXxXUfI7gW43IeMHeZdA3enrou?=
 =?us-ascii?Q?8rswx4kdZjVkJ4MZLpmVMMZ2rKjsOrmy5Mez7g4N?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96992f40-9963-4a39-ce0b-08daefe5a9a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 12:58:09.8693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CuVqgRcNVywSWPbgT3HSxAWbNLKeKItVrAMUh7fwjBT+ATyU3ahL/rDmXvB/0u6ea6eThX7ggp0kxrzOIk8h1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6236
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> For kernels built with CONFIG_PREEMPT_RCU=3Dy, the following scenario
> can result system oops.
>=20
>            CPU1                                           CPU2
> rcu_preempt_deferred_qs_irqrestore                rcu_print_task_exp_stal=
l
>   if (special.b.blocked)                            READ_ONCE(rnp->exp_ta=
sks) !=3D NULL
>     raw_spin_lock_rcu_node
>     np =3D rcu_next_node_entry(t, rnp)
>     if (&t->rcu_node_entry =3D=3D rnp->exp_tasks)
>       WRITE_ONCE(rnp->exp_tasks, np)
>       ....
>       raw_spin_unlock_irqrestore_rcu_node
>                                                     raw_spin_lock_irqsave=
_rcu_node
>                                                     t =3D list_entry(rnp-=
>exp_tasks->prev,
>                                                         struct task_struc=
t, rcu_node_entry)
>                                                     (if rnp->exp_tasks is=
 NULL
>                                                        will trigger oops)
>=20
> This problem is that CPU2 accesses rcu_node structure's->exp_tasks
> without holding the rcu_node structure's ->lock and CPU2 did not
> observe CPU1's change to rcu_node structure's->exp_tasks in time,
> if rcu_node structure's->exp_tasks is set null pointer by CPU1, after
> that CPU2 accesses members of rcu_node structure's->exp_tasks will
> trigger oops.
>=20
> This commit therefore allows rcu_node structure's->exp_tasks to be
> accessed while holding rcu_node structure's ->lock.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>
>Apologies for the delay and thank you for the reminder!
>
>Please check the wordsmithed version below, which I have queued.


Thanks for wordsmithed, this description is more clear.

Thanks
Zqiang


>
>						Thanx, Paul
>
>------------------------------------------------------------------------
>
>commit 389b0eafd72829fd63548f7ff4e8d6ac90fa1f98
>Author: Zqiang <qiang1.zhang@intel.com>
>Date:   Sat Dec 24 13:25:53 2022 +0800
>
>    rcu: Protect rcu_print_task_exp_stall() ->exp_tasks access
>   =20
>    For kernels built with CONFIG_PREEMPT_RCU=3Dy, the following scenario =
can
>    result in a NULL-pointer dereference:
>   =20
>               CPU1                                           CPU2
>    rcu_preempt_deferred_qs_irqrestore                rcu_print_task_exp_s=
tall
>      if (special.b.blocked)                            READ_ONCE(rnp->exp=
_tasks) !=3D NULL
>        raw_spin_lock_rcu_node
>        np =3D rcu_next_node_entry(t, rnp)
>        if (&t->rcu_node_entry =3D=3D rnp->exp_tasks)
>          WRITE_ONCE(rnp->exp_tasks, np)
>          ....
>          raw_spin_unlock_irqrestore_rcu_node
>                                                        raw_spin_lock_irqs=
ave_rcu_node
>                                                        t =3D list_entry(r=
np->exp_tasks->prev,
>                                                            struct task_st=
ruct, rcu_node_entry)
>                                                        (if rnp->exp_tasks=
 is NULL, this
>                                                           will dereferenc=
e a NULL pointer)
>   =20
>    The problem is that CPU2 accesses the rcu_node structure's->exp_tasks
>    field without holding the rcu_node structure's ->lock and CPU2 did
>    not observe CPU1's change to rcu_node structure's ->exp_tasks in time.
>    Therefore, if CPU1 sets rcu_node structure's->exp_tasks pointer to NUL=
L,
>    then CPU2 might dereference that NULL pointer.
>   =20
>    This commit therefore holds the rcu_node structure's ->lock while
>    accessing that structure's->exp_tasks field.
>   =20
>    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
>diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
>index 7cc4856da0817..902e7c8709c7e 100644
>--- a/kernel/rcu/tree_exp.h
>+++ b/kernel/rcu/tree_exp.h
>@@ -803,9 +803,11 @@ static int rcu_print_task_exp_stall(struct rcu_node *=
rnp)
> 	int ndetected =3D 0;
> 	struct task_struct *t;
>=20
>-	if (!READ_ONCE(rnp->exp_tasks))
>-		return 0;
> 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
>+	if (!READ_ONCE(rnp->exp_tasks)) {
>+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>+		return 0;
>+	}
> 	t =3D list_entry(rnp->exp_tasks->prev,
> 		       struct task_struct, rcu_node_entry);
> 	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
