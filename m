Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8167B6A3BD9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 08:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjB0Hxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 02:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB0Hxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 02:53:46 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92E3EB7B;
        Sun, 26 Feb 2023 23:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677484425; x=1709020425;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PLRpbsG7MDtJjmngjwptM4XSz6vyLeu6x3QKNqgSEiA=;
  b=TePYBZFddmZ6CuCe3aSQinE3fPC7K9ffG3EOI8QgCuL3hUz6y1OnbFoo
   rl1K6JfqFR7OxCQSksGq/h6fDlMLNkPY7l7KLtcEReoP2k6k3+SuQfITk
   tjO+PeupEYbebF0NJlXaBH4zGiOPrVZNlq9nUMfMJerNH1Xtgdlrb/9Kw
   xMVtj1OhhGdUHw5f4DpDNDLqATG377Jhzve29C76f7qampztGneAThtIT
   5I7lJRQ1BUrxyxBpbtm+e6ndNa3ZfJmaXOP8e/JGJ2E7cidU6gO3yHKrY
   yPIsDB7LlJNZo4Y0tk3Wu+9QakUEB3MOM7Ac58N09SGNAHTPuUze45rjW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="317602755"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="317602755"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2023 23:53:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10633"; a="666913537"
X-IronPort-AV: E=Sophos;i="5.97,331,1669104000"; 
   d="scan'208";a="666913537"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 26 Feb 2023 23:53:37 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 26 Feb 2023 23:53:37 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Sun, 26 Feb 2023 23:53:36 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Sun, 26 Feb 2023 23:53:36 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Sun, 26 Feb 2023 23:53:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eN5KBidfjv4tGU6xO0TE9FpYAOdKRPJfzkJ5aH9sXCBWBP9+FumkCUPTuCnSCCoiMUn/Yh07rSy/LUsFZX1KZqOGVkjZO68MCQ2xjg5v4r7rEIEjLmeDavYZX9mv8W8a+2yPlJkDjgrYms5nuUJrZjOlxemoqzZ8HQu8OZg0uJgwrb6fK4usCmWmyZjGPkzGk9XRWDlRPnejsh7BJffYibSfMOGfOpMLhps+Cdyl0QIwmZy779Kd8c3ZMlSWAGMRTjVbI0hNVWpHwdbBUxQcSriwld0zf2IiJC4ETTa3IUP5FJ8geYhb2gKblL54+8trGqsQR6+fHtE92hw2op5C3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LRRcWTLYEDHIpLvTXGR7V4mo8/X/7Jlb2HcXu7EbGA=;
 b=OT2Y9k0ZME3NtPULf3HXoUNDzluaaMXFTKHzu505FyVt3FJLsjnAIC0DLf81Wc4oEuySTCkapGcfrc9j9c5LL8+pQjeeFBokgP7DfBwpOjfxvlpw/4f1gVEXbaSyIiyOedn/GhRfjsszXNeoval14MIrC2tcCfFah/noZqBjZoGw9vtVyPaxsmOQlIDcKs3+x9fwSXtwRmUHLSuq7UiGZuelHLO1RZyfWc/QIPE9aQjIFzz20MAqGPRUjTnxuvR3F+TDiXicBCr762raHNTo25x+3rwT4QGOsCqH/Pq+nMrKuke9L+s67IurI4B/oh8IqKZ+waEYsbZ/RnP7hUYf/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by PH7PR11MB7644.namprd11.prod.outlook.com (2603:10b6:510:26a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Mon, 27 Feb
 2023 07:53:35 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::b6d8:543f:3a43:6c56]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::b6d8:543f:3a43:6c56%7]) with mapi id 15.20.6134.027; Mon, 27 Feb 2023
 07:53:35 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Frederic Weisbecker <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: RE: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
 completed
Thread-Topic: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
 completed
Thread-Index: AQHZSMoUan4Z/tmfYUGikm7Xfdsdaq7iacDQ
Date:   Mon, 27 Feb 2023 07:53:35 +0000
Message-ID: <IA1PR11MB617175CA398D425B7489CE4889AF9@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <20230225033421.3323164-1-joel@joelfernandes.org>
In-Reply-To: <20230225033421.3323164-1-joel@joelfernandes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|PH7PR11MB7644:EE_
x-ms-office365-filtering-correlation-id: f1cf1bfe-bcc1-4b0b-56eb-08db1897ba7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wXSi4gx2n1/0q2DKfClh1gRyt01i4FPGo292kwwbM7lCxIpveJT4CmcLQH/qy65/nB2499ICIF6fPK3TMo43ybFuzQnlRfb9AA+G/27AzAssoo6b5uVdSZue6RseJV2TmeJpLkE//4K8TgeR6YUe85+d1WQi98E4+onKjsn78i/kS0TttXm372uPzQH8xe0OdRNId2xCT4EjMAIeMz8DEDTOyaYIsSRqH/eRUdFgWKzXffO19XibYyPKfQNAfhM7jHr1rFZkspaRnt+/uD+YxTi33EG0r9ewViCjnchdl6XMvJYz9j0dzjsUAxgzXwuOvB6r0BfK7tpBxTheeMWT0p7jLGQvZ8uvP4DHY5jJrm2LCalwL0j2blO/+i/o+8iZO72OKBAY6Eyc0Rlf2CGT+bd8Vk1Ipz6zQEGxZAfBkIPQ2R0HbY9c4/3nsr5Se2wCBj0BUwb9nKIs38b/qvKKCDInjQLEIMTCyalKv4v8A7J6Xh6odFt6FJ1FuRJg+GB7noCg8+qFJtLngenBCCqEnBLVkU7VQMH1t9zE/Byr+LG3pGTqT65ZFGwGBVqEzuW5BjKuhT09rJVQvXkIn8jVCDGVjrR1pLinmKBUrZF4NY/6Q6eUkeq86gvmVkBotcyX3diL95DlmUZb+U7dGLtUheVxx5J/0u8y6ot4Ik2sKeKGzljUgzvXxBXQxWNO9LSE+rQJiePCr8gQe84j1QzZmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(396003)(366004)(39860400002)(136003)(451199018)(52536014)(9686003)(8936002)(122000001)(54906003)(316002)(82960400001)(38070700005)(186003)(26005)(38100700002)(33656002)(71200400001)(110136005)(7696005)(478600001)(86362001)(6506007)(2906002)(55016003)(53546011)(41300700001)(76116006)(8676002)(5660300002)(83380400001)(64756008)(66899018)(66946007)(66556008)(66446008)(4326008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6PQcQpfEfi4tzWiiQdMe96v2fR3gf7r4PnwtqaqcusIhfSt3plBS3KnmWoIM?=
 =?us-ascii?Q?MuppP+BXT6KTuqBWdgeSUMH0ydYPtzdl5E5MScUKcUCEdlNFzrDbpoK255dH?=
 =?us-ascii?Q?vVTGmYaqgRzOZdFH/V3k+Pg6OS8y9zVd5LXdDG8qI0YhQMuz9qo0I94lQWXG?=
 =?us-ascii?Q?rv4p8/Fj00zjx8re3uSV/6Ikvsfp2JjAYRPoHv+jXEkVqFDYXL8Awaa26ENJ?=
 =?us-ascii?Q?GCFJ2eQfVeKQDvvUkj87QJyUDJCFOGEVSe4r5jW0tQCQk8rUjjw34MArBZRv?=
 =?us-ascii?Q?vptShoImn3zgB71RmpqqUlwHQ5ca76uO0OU73IZUTLvSSTglvjoFrJHrqKcR?=
 =?us-ascii?Q?Uxco9IoE2iZhQZ0i7xs+f8XM7273k48J7q9hUZulTS4blalHygngC0XgtbG6?=
 =?us-ascii?Q?wXqgmBV3ZnZWqcTiLjpLepEyLVAi04ddCHyWp8X3LAYDnMwZW/82UH24gexD?=
 =?us-ascii?Q?EsTa9QnbEqoHeNWOylqy3dFXrCyhXH2U0mCfx1xrkbhGS1sBxrFUYLd1FBi3?=
 =?us-ascii?Q?ACd7UltSbOYeTPjKHFWlJ52nCXYlJqmZebdDAqlqTSLw913OX9BbH/5yaaER?=
 =?us-ascii?Q?NO/K+xGIqOBLSWsOAZK0U+Te36rz+rDNwNFaibM76g8T8jhROoscFXX+dmcx?=
 =?us-ascii?Q?4Q9zuNOmPNortI+UvDXamFUGd7EKMJFoCqaymY/ANNoAv/QV8WRjR2BSfPT0?=
 =?us-ascii?Q?T0Lf2Cyd7qkNNNawMDZC410Nu/L9/JwUg479hUVqsBTHkjQkJX1r514B6ThT?=
 =?us-ascii?Q?IyMYEKDxyf5DedANOo1k+mO1vOUZnilBYkBlywZHHFPP8AE39No2S81jAEO8?=
 =?us-ascii?Q?v29rGPJqSWCEY/NgkcAclRECvBKjimPcPvXtSUTnGRNdZ8gQmZG0cxMfGRIe?=
 =?us-ascii?Q?K3tzpesSRSQa1+Gm80r2pwhz7E2Kxzdt4HwI0y+MSwW2TTI6SSAoWk0D/LFc?=
 =?us-ascii?Q?8upV15ZXuPMrY+njLISQpUoiKBSAbArSAkZrjHg03PFhBwgIDTTWPHvv1+ED?=
 =?us-ascii?Q?buR78odGVi95mMgf/e1xDwRCr3gr1Zu1J9HH1Q61iOBzi7I9reIicDn76kKv?=
 =?us-ascii?Q?Y2XqpjASoJDBPRc0PNBkkOcxbpsQoQQBIaMBwnLA6KuiORhcG/UYxvVMbQs2?=
 =?us-ascii?Q?BQHMj858ZRyviwqxj2g6CzQ3Y3hdgpcZApXrmc/QozdJ1eraiqqLppiJOdUT?=
 =?us-ascii?Q?OCWU3SOL0uWY+f7W/3oDJQwtizQrAZHL9wXRdQe0pki5Y7Ge9z5LaTbqrb+m?=
 =?us-ascii?Q?DbFuusXt80Xht4TfrGIUhU+K8ExDbevO4TVjXUtypnWx6Hboh3Cf6OUQaSD3?=
 =?us-ascii?Q?9gT5p92lJLpsCCuJJzagq4Mjr+DyDb1pu1h6R144DHFQ4EBy2m6UDNq6xzOA?=
 =?us-ascii?Q?HAt+zRBFVW2JpgB+JX8BAWEfRtmDTPER7WApm4yDX2GWFojQItRiqDJpSzFn?=
 =?us-ascii?Q?wof1ZS4fftOAD4Jyy6yr/woezqmpkOzHPArkMp5FyokHzqpHP1OWoeDh+nrk?=
 =?us-ascii?Q?EYEKvpRswW2qdTmNbjOpbUYfDw0JynrvtNVmVfJ6hp2TkKu1eZKTYqPBzVvs?=
 =?us-ascii?Q?PqOeZhdYt/zPg99azl3sU2QGUMvkjblOKzESccAc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1cf1bfe-bcc1-4b0b-56eb-08db1897ba7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 07:53:35.0612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PFjzaEwud+Ej0i2tnoWP906NfXwuiDn5ZQ0LkrREuRwA1nWWzfidfNb8gNhd+nyQlBIuzx5K+HsAbJ2wtLxrEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7644
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Joel Fernandes (Google) <joel@joelfernandes.org>
> Sent: Saturday, February 25, 2023 11:34 AM
> To: linux-kernel@vger.kernel.org
> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>; Frederic Weisbecker
> <frederic@kernel.org>; Lai Jiangshan <jiangshanlai@gmail.com>; linux-
> doc@vger.kernel.org; Paul E. McKenney <paulmck@kernel.org>;
> rcu@vger.kernel.org
> Subject: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
> completed
>=20
> On many systems, a great deal of boot happens after the kernel thinks the
> boot has completed. It is difficult to determine if the system has really
> booted from the kernel side. Some features like lazy-RCU can risk slowing
> down boot time if, say, a callback has been added that the boot
> synchronously depends on.
>=20
> Further, it is better to boot systems which pass 'rcu_normal_after_boot' =
to
> stay expedited for as long as the system is still booting.
>=20
> For these reasons, this commit adds a config option
> 'CONFIG_RCU_BOOT_END_DELAY' and a boot parameter
> rcupdate.boot_end_delay.
>=20
> By default, this value is 20s. A system designer can choose to specify a =
value
> here to keep RCU from marking boot completion.  The boot sequence will no=
t
> be marked ended until at least boot_end_delay milliseconds have passed.

Hi Joel,

Just some thoughts on the default value of 20s, correct me if I'm wrong :-)=
.

Does the OS with CONFIG_PREEMPT_RT=3Dy kernel concern more about the=20
real-time latency than the overall OS boot time?

If so, we might make rcupdate.boot_end_delay =3D 0 as the default value=20
(NOT the default 20s) for CONFIG_PREEMPT_RT=3Dy kernels?=20

-Qiuxu

> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> v1->v2:
> 	Update some comments and description.
>  ...

