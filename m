Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62A96C43A5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 07:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjCVGxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 02:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjCVGxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 02:53:01 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B0023D90;
        Tue, 21 Mar 2023 23:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679467979; x=1711003979;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vqkmelVqhz3VETy9hm/mrcTOrq0jvCYnzlZToZ74ngg=;
  b=KSJjUZSnLczdBHjiY4q7NVtfFlOsZzTzzyq8GdAiGnezamGzqI+gS4WP
   r2maNXSUwEu3grVu6FcZpBbsUixWGVcy004MXBA7WmkahBxSL74oKNGvk
   XrZvoYif7BiNRE9cLO0iZdpwCEZdFPbFp4w/HKqLVuIGo7NrDt12uhNuC
   Gsv+GTNLm2vTjxVcGLNanGt6xVyeIhwj8sy77B5zn8FjLx8mGtCWIeJMh
   etqkvdc9LSYzC6KffNXZcy8t3OKX4owkba0tPwXkkcLqmkYTjWqWEB8v2
   DbnBnCnxJVj7AzrXiJddlc7UWr3dUJduYAPQlcExjh8YsTMhWvcYmMY67
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="341497928"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="341497928"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 23:52:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="631881015"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="631881015"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 21 Mar 2023 23:52:53 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 23:52:52 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 23:52:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 21 Mar 2023 23:52:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 21 Mar 2023 23:52:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUJNgb0rBvnECwHkMVDs1+oQpvOarlz5AVbLN3s6jPAiKNF4Jhb92HqW2kR1TwIfERVA5HXXwDHCrw3X7JZw0nYzTjkGM2U/3GIM73JmFSZKJgJkFRK9VgUUoGiLgWRiIeYS2P+xhjc5aoWN/hoh1Am3qGoIPKiVfLbqkJ67GVt5MEcR2g9TPgvIPJFEoOn8H4NaHvOUmbk1mrlhgLoH/HF+x8ebUPLAZkHTPPwuN0LFFon+KxY5UBZwuy1Kv/JLQIA61llIYq2wQWwbWtuXOacE89HGDh/qFfdsqT6/IjZk4n5c+bl6Yh/elZNjFV5EJ7wWM1+LLDQ/tiVMctLjNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBvJ05So06tbKOTXxcRbFKpO9mRf0Ce6VmaT8IqBr/c=;
 b=BsO3L1rWAKCZksRmSc5T//Nb1cOjXn8s/oyhvFRPFIJ6Ve93rwHegmKcoqxtLV+JJ2m9IIMrKgcy4OadXsEuno+LxS3OCPqI9FTXaqgfGF+C/2UtZ0JrxYnKSGuAZY26qMWBjf97/IeZT9LxtF2Taky2QOxlBzVFeK0W9ZKMkhj+jVBbB+wJKq7GJWx1I2ErXsz8ZfazawGlm5C3SETRZrXrHOnNZcXmSNHKr5uPaUhZ36dBlgVLlGydVrXULMvCrFjd/kIUGzUCuZlbCbv8t719YzV1EjV799pHHGtM0Dalx770Ozqwh4UnNVA0Ad5XdAQVsJSJ1CXBBwvzZTe44g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DS0PR11MB6469.namprd11.prod.outlook.com (2603:10b6:8:c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 06:52:45 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0%6]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 06:52:45 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Shigeru Yoshida <syoshida@redhat.com>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "neeraju@quicinc.com" <neeraju@quicinc.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu-tasks: Avoid pr_info() with spin lock in
 cblist_init_generic()
Thread-Topic: [PATCH] rcu-tasks: Avoid pr_info() with spin lock in
 cblist_init_generic()
Thread-Index: AQHYpowdL4alsdv780yl8/IOMQTYBK2d3fwAgWjxNICAAPiCIA==
Date:   Wed, 22 Mar 2023 06:52:45 +0000
Message-ID: <PH0PR11MB58809BAC834FD65419DEB3B4DA869@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220802162205.817796-1-syoshida@redhat.com>
 <20220804000252.GL2125313@paulmck-ThinkPad-P17-Gen-1>
 <223892ae-648e-4931-8c11-063de83d2c40@paulmck-laptop>
In-Reply-To: <223892ae-648e-4931-8c11-063de83d2c40@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|DS0PR11MB6469:EE_
x-ms-office365-filtering-correlation-id: 59f628f5-53c4-4142-072f-08db2aa20ab1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xuKWgg19PR4b0OHqFP+Dqznu6Oqmqqoz8g4I4PuR3W8AYoGK+odQGTxL2+gG47faPzbbMoXgCuthhJFRUFh1JxdOYczla0Mj+2ChHUG+0g1/n9J1FjXZ8b7maIA1+IhUms8k11WrrDgYPg/ukxh9bH9KbCFzz4WA8lUNDLZ313dxWEnVuS/tKnlg3azVp3E50Epuf1pyaCUM8oZ/D1SY7dku4ZOkNFD75d8xE6+8ZBpQfHK4DaZjr7w+7P2Ikhieg0Fj7cx3AkID3wF0MuQ2xkEhd5vCk106Q2VtVJ0SSawfFM6KUjwTfRJ5Pcmn2S9ZIVp1kf81h3P+k0GT5YoTriP0YtZfEL4aZ/xAQsh1n9CORY3f+pkWwxK5DE05WHe2pbNtmvKgMnYqQ2CHL90dW7Q7ocP+kxjoJQ5iOe43o3GRiqPXRSX2K+fJwcOAWRTYwOSvBDDAlFbwkieZ2t0d8Ja9Vc4iAT8zN828hx+lQFsxh10sTZfqBG0DcjFmrLGolWGJF5SVxhc1Ywo3XQJ6zbfMnlpJtgTawxqnkep2Gnu6lqMImdw6t6WOxTA/oeB3Xpl3yxqrxTod9ptmXLABJcCfRS8BFfskPH3k9w65CyIncqJ6ruIFWsvWAFVgCoUBslWUNOXP7Bx5taTRKSJkH7/AcoAqZTlR3xMj+n7NhNMnJvC6Q0T3MMm/Wj+d5DKJmQB1WTNs03piaF+Q/Wft0YJmxpM8mPic2Kj5gKWz4bU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199018)(71200400001)(83380400001)(316002)(54906003)(9686003)(5660300002)(33656002)(6506007)(7696005)(7416002)(478600001)(122000001)(66946007)(186003)(38100700002)(110136005)(4326008)(86362001)(55016003)(38070700005)(66556008)(2906002)(76116006)(52536014)(8936002)(8676002)(66476007)(64756008)(82960400001)(66446008)(41300700001)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C7qsbprIfQb2rfW6IOr/e5fN35vxKDDreFbkBzFa4Giayvf3kKPP7NXIlJfs?=
 =?us-ascii?Q?0AxmZMl7Uzj8PPyHwuMZvCNtoBQ+Zd4Vj7mUT6GupGgSskr2OvPTn8fGiN1V?=
 =?us-ascii?Q?CAm/oWgwn9CfYgdd0Dl6IGZe0by6eUpzjibA004HUKfCFa3nodRiyqgY892r?=
 =?us-ascii?Q?2XVwTnw8hNHsZ51oS3idBAgfzDsnDt6Pk1arbEvxQoHKT5s3JDQj/f+SLICt?=
 =?us-ascii?Q?qKW/oQONsCScZVaJbraqIPibaQt4KFlXxVkCF9nXuVxhtB+3mpU4+Y21N+Mn?=
 =?us-ascii?Q?FEMnIMsJNrOzeQN1MdkKyMsckaglinClMt66L9gvmbCVmI7J41bgb6Y2KPOb?=
 =?us-ascii?Q?7rw4dxT1xlsNMS3xjJ/OtbbbYl4aeOzGg2d2fpcUzalWh76tyHp4p6wV5pZQ?=
 =?us-ascii?Q?3gcTv4rynxgUL6sPGSi7HpijDODsIdV9SLyrVZU6cPRvQFCNiRGl8MZnXtEc?=
 =?us-ascii?Q?cKgTXwWe6fix3Tnc331jHLfpL+fX0UPDBUtbTH+zUiw4f1e+BmJN+T8CeUNa?=
 =?us-ascii?Q?DtQtv1OV3KE0CxTv/nrNVr/9QzzFZEcJ4leRd/J9Pd+HHdtFwA7OtFKgAmAH?=
 =?us-ascii?Q?uVZNBM2dMLmhNROjN8UjgGMdo/UAZtv3QDIv4Iz0HIFg9hTJNX+RgwjBppsj?=
 =?us-ascii?Q?8kNuK7YdLvOyiHjxNxvO3wF57b9AbzTl7fgnsyowcrSFkq/2TWjtduX1KjaM?=
 =?us-ascii?Q?oH8+dgAoGBnPeD1KM0TLdmx9G6F8wpwsRDy6fP61+Oste1VU3fj6njUJQ3QX?=
 =?us-ascii?Q?WAQlwkQIaaD4XxLJeV4d2bdM86nmOZjsUrHpJnqwH0XrgpQPY5pi0uQWMoqj?=
 =?us-ascii?Q?Fl2j3EwcDV55CA1GJpUVp/oCEhluBC0ysM+Eepsn8NpZf4Cc9goB+1TUXGMl?=
 =?us-ascii?Q?/lDg9UYm5KXI3Przauk8D2MG1HD57LXdJGryb2iyjVh93gqg12M5zVK2kUxm?=
 =?us-ascii?Q?Bkv0mjZa5ptJ//mp7K85kJZoCFB6TEVr5qEeywOY+UqBSk88zp871i8MU9k/?=
 =?us-ascii?Q?uyEq4R95yf6EdI6afqjPFmWWNdcaM6/MkB7tuT/oBEsT/IA6oT7CI7RwAFsC?=
 =?us-ascii?Q?D8cko3fQqKoWfllLMwj5ZulPik9CDURUN//Yh4hR8eKaVh3l8YgAGjym5NXK?=
 =?us-ascii?Q?9Vsq/H686XLl+I4f1pzso8emTPmixTEW/aAAz4tkAm3s4NbMNWQSWCCoRoqc?=
 =?us-ascii?Q?8Xkvw7g8XHEg9J/fWK0+zodtmOK2u70nGWLLnUulj2C3gcMM3pyJvcm3ddBD?=
 =?us-ascii?Q?6egT0Xa8EK/fmxGM5FCoSRsQnwn44A/jMCKZ8jNjkdqV7HbKXc8lqv8nG+9v?=
 =?us-ascii?Q?6UfNUQgPL4MLUtON6DK60iYrp8ejsZp9Gwd6DlEMJKan2rEm8ErNDBDytXES?=
 =?us-ascii?Q?VLpzoW+10CBo4komGJeM3CUFpQ5UlH4jhK/I2CYc3i6b7GcZoCRYJMLm2pba?=
 =?us-ascii?Q?m3DKR7uCLPjUVz1EL4UlNIEMPtJy2oyOmdehbyN8C93/WlERgbmwZ3pJN16d?=
 =?us-ascii?Q?GLknad2wsByaM1iYUsjrqD0vfwVqQV7Sx/g6Yqf9JFsUvOT/ElT90ul0pAMO?=
 =?us-ascii?Q?HB9bETh4m3VTnluYM/uzeYE3iMg0ZKxaFaqOjN0Yf3NXyApAHlQrrbXKKdDk?=
 =?us-ascii?Q?v14pwOC7bQG9CNGIZJLp7iqdY81lWGtSGCfcyglshHAf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f628f5-53c4-4142-072f-08db2aa20ab1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 06:52:45.5031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l52Oelw7rWfAIYVnYtRuiqhpKosWz5DU2m2r0Nvm3USZDHNlz7qrxkNB9MZZ+nWVebeHMoPf3Dtg1lrLkXVZog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6469
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Aug 03, 2022 at 01:22:05AM +0900, Shigeru Yoshida wrote:
> > pr_info() is called with rtp->cbs_gbl_lock spin lock locked.  Because
> > pr_info() calls printk() that might sleep, this will result in BUG
> > like below:
> >=20
> > [    0.206455] cblist_init_generic: Setting adjustable number of callba=
ck queues.
> > [    0.206463]
> > [    0.206464] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [    0.206464] [ BUG: Invalid wait context ]
> > [    0.206465] 5.19.0-00428-g9de1f9c8ca51 #5 Not tainted
> > [    0.206466] -----------------------------
> > [    0.206466] swapper/0/1 is trying to lock:
> > [    0.206467] ffffffffa0167a58 (&port_lock_key){....}-{3:3}, at: seria=
l8250_console_write+0x327/0x4a0
> > [    0.206473] other info that might help us debug this:
> > [    0.206473] context-{5:5}
> > [    0.206474] 3 locks held by swapper/0/1:
> > [    0.206474]  #0: ffffffff9eb597e0 (rcu_tasks.cbs_gbl_lock){....}-{2:=
2}, at: cblist_init_generic.constprop.0+0x14/0x1f0
> > [    0.206478]  #1: ffffffff9eb579c0 (console_lock){+.+.}-{0:0}, at: _p=
rintk+0x63/0x7e
> > [    0.206482]  #2: ffffffff9ea77780 (console_owner){....}-{0:0}, at: c=
onsole_emit_next_record.constprop.0+0x111/0x330
> > [    0.206485] stack backtrace:
> > [    0.206486] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0-00428-g=
9de1f9c8ca51 #5
> > [    0.206488] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1.16.0-1.fc36 04/01/2014
> > [    0.206489] Call Trace:
> > [    0.206490]  <TASK>
> > [    0.206491]  dump_stack_lvl+0x6a/0x9f
> > [    0.206493]  __lock_acquire.cold+0x2d7/0x2fe
> > [    0.206496]  ? stack_trace_save+0x46/0x70
> > [    0.206497]  lock_acquire+0xd1/0x2f0
> > [    0.206499]  ? serial8250_console_write+0x327/0x4a0
> > [    0.206500]  ? __lock_acquire+0x5c7/0x2720
> > [    0.206502]  _raw_spin_lock_irqsave+0x3d/0x90
> > [    0.206504]  ? serial8250_console_write+0x327/0x4a0
> > [    0.206506]  serial8250_console_write+0x327/0x4a0
> > [    0.206508]  console_emit_next_record.constprop.0+0x180/0x330
> > [    0.206511]  console_unlock+0xf7/0x1f0
> > [    0.206512]  vprintk_emit+0xf7/0x330
> > [    0.206514]  _printk+0x63/0x7e
> > [    0.206516]  cblist_init_generic.constprop.0.cold+0x24/0x32
> > [    0.206518]  rcu_init_tasks_generic+0x5/0xd9
> > [    0.206522]  kernel_init_freeable+0x15b/0x2a2
> > [    0.206523]  ? rest_init+0x160/0x160
> > [    0.206526]  kernel_init+0x11/0x120
> > [    0.206527]  ret_from_fork+0x1f/0x30
> > [    0.206530]  </TASK>
> > [    0.207018] cblist_init_generic: Setting shift to 1 and lim to 1.
> >=20
> > This patch moves pr_info() so that it is called without
> > rtp->cbs_gbl_lock locked.
> >=20
> > Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
>=20
> This patch looks good, except that wasn't this supposed to be fixed
> in printk()?  Or am I suffering from wishful thinking?
>
>And I was indeed suffering from wishful thinking, so I have queued this
>patch.  A big "thank you!" to all for your patience, and to Shigeru for
>this fix!
>

Test the patch

[    0.178892] cblist_init_generic: Setting adjustable number of callback q=
ueues.
[    0.179366] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.179488] cblist_init_generic: Setting adjustable number of callback q=
ueues.
[    0.179961] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.180470] cblist_init_generic: Setting adjustable number of callback q=
ueues.
[    0.180949] cblist_init_generic: Setting shift to 2 and lim to 1.


It looks more clearly

--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -270,10 +270,9 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
        }
        raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);

-       if (rcu_task_cb_adjust)
-               pr_info("%s: Setting adjustable number of callback queues.\=
n", __func__);
-
-       pr_info("%s: Setting shift to %d and lim to %d.\n", __func__, data_=
race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim));
+       pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=
=3D%d.\n",
+                       rtp->name, data_race(rtp->percpu_enqueue_shift),
+                       data_race(rtp->percpu_enqueue_lim), rcu_task_cb_adj=
ust);
 }


[    0.178746] RCU Tasks: Setting shift to 2 and lim to 1 rcu_task_cb_adjus=
t=3D1.
[    0.179322] RCU Tasks Rude: Setting shift to 2 and lim to 1 rcu_task_cb_=
adjust=3D1.
[    0.180076] RCU Tasks Trace: Setting shift to 2 and lim to 1 rcu_task_cb=
_adjust=3D1.


Thanks
Zqiang

>							Thanx, Paul
>
> > ---
> >  kernel/rcu/tasks.h | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index 3925e32159b5..d46dd970bf22 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -227,7 +227,6 @@ static void cblist_init_generic(struct rcu_tasks *r=
tp)
> >  	if (rcu_task_enqueue_lim < 0) {
> >  		rcu_task_enqueue_lim =3D 1;
> >  		rcu_task_cb_adjust =3D true;
> > -		pr_info("%s: Setting adjustable number of callback queues.\n", __fun=
c__);
> >  	} else if (rcu_task_enqueue_lim =3D=3D 0) {
> >  		rcu_task_enqueue_lim =3D 1;
> >  	}
> > @@ -256,6 +255,10 @@ static void cblist_init_generic(struct rcu_tasks *=
rtp)
> >  		raw_spin_unlock_rcu_node(rtpcp); // irqs remain disabled.
> >  	}
> >  	raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
> > +
> > +	if (rcu_task_cb_adjust)
> > +		pr_info("%s: Setting adjustable number of callback queues.\n", __fun=
c__);
> > +
> >  	pr_info("%s: Setting shift to %d and lim to %d.\n", __func__, data_ra=
ce(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim));
> >  }
> > =20
> > --=20
> > 2.37.1
> >=20
