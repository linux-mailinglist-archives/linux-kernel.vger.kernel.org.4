Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636856C5D47
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 04:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjCWDco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 23:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjCWDcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 23:32:41 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DDC2596C;
        Wed, 22 Mar 2023 20:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679542359; x=1711078359;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JjURrg0T5uBwgXeIZauE1q8s60/9Lyhla2beWErXL8Q=;
  b=bqNGtUBrebKllW7yjIXEMgHykcgpSSc19tljuYvx7fdY6WZjyr7EVQdv
   Yy/+kS4/QwAQTs8C2ihbJaiZa0yK4mN0iOfjYIETG+xiyhrml+nt9dz5Z
   RMI3a+aHRQixcV2FrguZIctFKf9lENAgwGds37HeLuRJ+WTQFxmPJroZD
   L2ijNYeuBSxV3rBBABX0jlIQLO6rfxcS72B1EI6xhcOnhOstBfIGFmkTj
   A/bibkUr8rP0fhnwloxpgx9BjwuPNf2P5LGqX73BdXT8rFf7HebjbUzoE
   oI52mj+FvDRCtJPUIqLymgG3+WM2Zm5WL/9T0mgXCmw1IPm2dn75JaRJ5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="338107418"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="338107418"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 20:32:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="684544557"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="684544557"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 22 Mar 2023 20:32:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Mar 2023 20:32:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 22 Mar 2023 20:32:33 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 22 Mar 2023 20:32:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 22 Mar 2023 20:32:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzMXmG0biSAAY5N04Gci1t2axvpbdFKWe58L3TEVxNmyGJnXtBCxoljVw5SFucgXEyfLVKnW7cB9fQe3pqgtVJFGWCaoNjjCipmEz+OrHb/BZajqVMliAnvK/weRQkgW0rGB0VNCrVaVslq7thtWi+HVkossBoiJtxx9aR9tOsFjLCrXyJ4N+I0FpazV2mLPDvXRNB9wTu1AA0kLVjsx4IAiy1rA9HNc+7B8a/GHKoVz0xOw2iGe71au0JDHoGQhNzzwW7ghgDNs+eIudaORP3nGY5dQbzqmMPVt9TOhYnSzobzf2zcIdOJJ4nxQgVuyyZj8om1luPX4FjiNapnnzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyL8myPbVu7HPgKYZY3Ed8dQrMuHEwzSmcn6pXDZVfQ=;
 b=fx2IRugwOtFvb0LAAbjL9jguY0UXXMwlGlTqxO0DMQ7d5zIw018B6had5KtNVK8g6HjViv9hMKvewdqXnDTG1hf+3+2Ch3j2Iz8nEIshsQBM5fx+CcoASHhvCihsqU8/igon0NMSN9gVFMQQ8NICnlqRQbQwi9De7ngHYPsnBcr68tBrrbWUxlhMBSzrpxD++cPtsc8arUelS1E9A4E1E4yOmF+NLTT85P2USYMGmbijOVZamK0nmiHIjhYnxrBqVWttBRKNkwZpMfuFsYp806wNBw8FuugAiSZZ20KuAQha3cawqmtvrnscEMM6Sa8LdGeVXq5PucnPFdq4Z5DMYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SA2PR11MB5114.namprd11.prod.outlook.com (2603:10b6:806:114::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 03:32:31 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0%6]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 03:32:31 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     Shigeru Yoshida <syoshida@redhat.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
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
Thread-Index: AQHYpowdL4alsdv780yl8/IOMQTYBK2d3fwAgWjxNICAAPiCIIAA9HsAgABmCGA=
Date:   Thu, 23 Mar 2023 03:32:31 +0000
Message-ID: <PH0PR11MB5880E574D9560638C7092BD9DA879@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220802162205.817796-1-syoshida@redhat.com>
 <20220804000252.GL2125313@paulmck-ThinkPad-P17-Gen-1>
 <223892ae-648e-4931-8c11-063de83d2c40@paulmck-laptop>
 <PH0PR11MB58809BAC834FD65419DEB3B4DA869@PH0PR11MB5880.namprd11.prod.outlook.com>
 <09987549-0a29-439d-8860-3fa6d255288e@paulmck-laptop>
In-Reply-To: <09987549-0a29-439d-8860-3fa6d255288e@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SA2PR11MB5114:EE_
x-ms-office365-filtering-correlation-id: 14d4e6cb-7860-4d78-a1b8-08db2b4f3bf5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pJHOae4gRpJrZfs01Fp4/OTPD11RMWh1oc4xeO8lEyO+vBxwjOwVpwbvfQJ3Ysm3EMIp3lJ9Q/bdFQZfxBdpU+V3GZw/vQ+bEuNcNmLRgNg0hAJjNmkokmF3MlgSPE2zrhBA4NPW7sUkU58DHUdGPiT/nMpfmlcFYtO2JbO+NNBvo9YQy4chWcYza3vSAqgN9C7p29vecDIhRUK0sFFugdIJCyHnQ+mk/OqG+KE9WUMqJrayKKYIUwJKQcNqpDF14uHYzw+55l0YE2NhYu0i6rvvcKjTDymoMrEAA1aQ3N6VZKKq/zfmDsbdjQpMzB5EY8wwWsOnMws8tHgjb7ax0Vn/Yyd/uPQ4Ur5txQ76E+763lrdPynJN8vXTmxSyLE/Uup92FRpLLrEg/qDhg5L7MT0YazzeitqUtAOvl8jthfRNPrlPEKypcbQDoKye9AvHtenR0R8QSrNDFkNyCv+0zAQy3ZZcXmsQsuaiYT/Vkywf/cmbS3UvYnOsahw3ihqfGoZJLRZXurRQLXT+Tb9Xg21KQ5rXhKBQVFSGpNzFAkFnPHtlL6SyCl7k+bm7J3d9cUDHYlmfphixBDElZF+6O9yokCzMwitpyCBt1i3ftPph+utUh2GSEbfBuwPBKOxNz0D4d3iX1JPCuFLMpAPEs6n3TjJQyKVCztej0bBZPwTWmnA9jxRuZkUkqa9LRjLJvYJbSLDO2PDI0A3b1ueL8H0CS+T7sW0hXPZE8zJOJI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199018)(6506007)(26005)(33656002)(9686003)(186003)(55016003)(316002)(122000001)(2906002)(38100700002)(54906003)(41300700001)(52536014)(8936002)(66446008)(66476007)(8676002)(64756008)(66556008)(6916009)(76116006)(66946007)(4326008)(82960400001)(7416002)(5660300002)(7696005)(83380400001)(71200400001)(86362001)(38070700005)(478600001)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?heUCyOgbcO7Y9ddPYZ8b9We7pMw8q+HJu/QR7iZIVkkF/heq/V9DQMtngSns?=
 =?us-ascii?Q?YIM/jb6S0U86nlmwSMLSHNv79+/Rr/te8NSH0wBedtuDoDrYQPtW3KbpDTw0?=
 =?us-ascii?Q?CPlp4KBuAVjLlEZ8nGrEwbprBKOiHxTjhkjYp2/p+AvCX7sgdmp0zjBRNg2s?=
 =?us-ascii?Q?XgN4QTvXnlSLmeTf2BUhJBSYO/cQ5ljNeVXGOW/qRAZe8uM+rN82M3aQNvSg?=
 =?us-ascii?Q?39ZbWPb0+exeRSAlmVDa/nLlySz8s6LGMxhH3INZaIEXAbYZfffqD+XPDykw?=
 =?us-ascii?Q?kcA/UaM73L4KiKg4dyQPM0x0fhjsL3x1j2JDQv230RBwaHZdNBpkW8y7DFHX?=
 =?us-ascii?Q?bDGMpqmNOXy3xLRlRin2G0CPy9n1MjjhRNpzmJAjfxiyQXmgzj6RpTA36iIO?=
 =?us-ascii?Q?DnFWauuSBWUSf2npfrnDmR5t8TpKucJZCX6zXsxzlBrqb1DSGypd7QrWgW9J?=
 =?us-ascii?Q?BTbk/sS/VD99165vCf5Heeiz+53pa1raLiwziaD2fL7TTaRmb+phEfBGkT35?=
 =?us-ascii?Q?rbQ5OHD2XBCNY2enWF0SOXs4X0VSwW55xhAgqWSWc8psuSCPYLFDB/gx5SEl?=
 =?us-ascii?Q?heHTKEmJjg2BkrZySaKCLER0CaIVrB429GzwBsKtWBXbZX8qXfj2+SVGnP7b?=
 =?us-ascii?Q?sf0CZMFqPoPmwaSTx0qSoNW0/fuLXCjEuM4Wte6yp2lldjqxNSzGXY2hcdGh?=
 =?us-ascii?Q?+gJWjWjHEo7pe1i29xTaDoisgr2Kuq6ZyymXrTB/PMPqy3evxF4DEmh5k7m5?=
 =?us-ascii?Q?/fD1iDwOzvqgyVWlDDlyuYAxoQmD2Udwsj273tmV3MOiPavpCEPxnDHFf624?=
 =?us-ascii?Q?a+GH58GvAEiUEfcrJXinS3gObpnPyR5lCw2+hSJuB8lAG4/QW1X+0U191B1P?=
 =?us-ascii?Q?McBAqjLEfGjawgAzp/E07A2rldJ2Nb9LKqAikilr6h22iDb1yAR1oS1xqpr5?=
 =?us-ascii?Q?d2sgxRImaUuXtx36K9NOn/dZiArhKc28R0ncwXWHrXbNt6CPXGOk8zf7VV1A?=
 =?us-ascii?Q?7QqfxrBmWEmsJQljDKJajc5/sVE3WjeBJU2WZL5iyJePASD7NGKqqhUCmhkw?=
 =?us-ascii?Q?dKN63NrAHrITDey+nCkUp5o8+c1bTaTExmDa05IWCT7DzNkDRN7ByWiTFahn?=
 =?us-ascii?Q?B6Seb2AIUqw64n48690jF2T2RtvEluXVvNk7PFx2Y2KWLbIq9U+BThM1XH+n?=
 =?us-ascii?Q?36v/Qc3fjPA3ipVtauUpDyyksef+5dzF1GCd4jDtypD7DkSHrbSRKe+4RVcd?=
 =?us-ascii?Q?E4jBADfLt9ZFoTo6qCnp+zeRsqlg0AR3f+P5sPfndoND2/ngqteGH1vJzxG7?=
 =?us-ascii?Q?GHz7Y/xKgUi9Q7uo6Uzh8ccYrrxQYASdE85U8kp/k6xRxTuFMqX+QBeXvBQF?=
 =?us-ascii?Q?2EqrDBr91V40emo6DxEZUY2kNoNyIQMprwjbhSaxNmV0EDjiuF6860dp/N9i?=
 =?us-ascii?Q?vMJq3YUvRdWlsnsDpqKENSZpJxi5qAE5MciaNozI8aa/5cbMfhyiaPKKf2Hi?=
 =?us-ascii?Q?hv5KQxo0WvtghEAcX1JRBuTtXJKT98MUE/Skb/y4g9bgw2buoVzPvcTyOeY4?=
 =?us-ascii?Q?mfEZOkcNk7krPR8jxCZzrMpMJVxE3D/pJeo4zpvQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d4e6cb-7860-4d78-a1b8-08db2b4f3bf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 03:32:31.1265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HeKMXQFaYHrPZ/kTHSKjEZaeEl8l7b8gUaUSIcqLDsXa0DJRSCPvJhoIZ9hKB8OqhkB9Gcv9hRIdvLK89JAcnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5114
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Wed, Aug 03, 2022 at 01:22:05AM +0900, Shigeru Yoshida wrote:
> > > pr_info() is called with rtp->cbs_gbl_lock spin lock locked.  Because
> > > pr_info() calls printk() that might sleep, this will result in BUG
> > > like below:
> > >=20
> > > [    0.206455] cblist_init_generic: Setting adjustable number of call=
back queues.
> > > [    0.206463]
> > > [    0.206464] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > [    0.206464] [ BUG: Invalid wait context ]
> > > [    0.206465] 5.19.0-00428-g9de1f9c8ca51 #5 Not tainted
> > > [    0.206466] -----------------------------
> > > [    0.206466] swapper/0/1 is trying to lock:
> > > [    0.206467] ffffffffa0167a58 (&port_lock_key){....}-{3:3}, at: ser=
ial8250_console_write+0x327/0x4a0
> > > [    0.206473] other info that might help us debug this:
> > > [    0.206473] context-{5:5}
> > > [    0.206474] 3 locks held by swapper/0/1:
> > > [    0.206474]  #0: ffffffff9eb597e0 (rcu_tasks.cbs_gbl_lock){....}-{=
2:2}, at: cblist_init_generic.constprop.0+0x14/0x1f0
> > > [    0.206478]  #1: ffffffff9eb579c0 (console_lock){+.+.}-{0:0}, at: =
_printk+0x63/0x7e
> > > [    0.206482]  #2: ffffffff9ea77780 (console_owner){....}-{0:0}, at:=
 console_emit_next_record.constprop.0+0x111/0x330
> > > [    0.206485] stack backtrace:
> > > [    0.206486] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0-00428=
-g9de1f9c8ca51 #5
> > > [    0.206488] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),=
 BIOS 1.16.0-1.fc36 04/01/2014
> > > [    0.206489] Call Trace:
> > > [    0.206490]  <TASK>
> > > [    0.206491]  dump_stack_lvl+0x6a/0x9f
> > > [    0.206493]  __lock_acquire.cold+0x2d7/0x2fe
> > > [    0.206496]  ? stack_trace_save+0x46/0x70
> > > [    0.206497]  lock_acquire+0xd1/0x2f0
> > > [    0.206499]  ? serial8250_console_write+0x327/0x4a0
> > > [    0.206500]  ? __lock_acquire+0x5c7/0x2720
> > > [    0.206502]  _raw_spin_lock_irqsave+0x3d/0x90
> > > [    0.206504]  ? serial8250_console_write+0x327/0x4a0
> > > [    0.206506]  serial8250_console_write+0x327/0x4a0
> > > [    0.206508]  console_emit_next_record.constprop.0+0x180/0x330
> > > [    0.206511]  console_unlock+0xf7/0x1f0
> > > [    0.206512]  vprintk_emit+0xf7/0x330
> > > [    0.206514]  _printk+0x63/0x7e
> > > [    0.206516]  cblist_init_generic.constprop.0.cold+0x24/0x32
> > > [    0.206518]  rcu_init_tasks_generic+0x5/0xd9
> > > [    0.206522]  kernel_init_freeable+0x15b/0x2a2
> > > [    0.206523]  ? rest_init+0x160/0x160
> > > [    0.206526]  kernel_init+0x11/0x120
> > > [    0.206527]  ret_from_fork+0x1f/0x30
> > > [    0.206530]  </TASK>
> > > [    0.207018] cblist_init_generic: Setting shift to 1 and lim to 1.
> > >=20
> > > This patch moves pr_info() so that it is called without
> > > rtp->cbs_gbl_lock locked.
> > >=20
> > > Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> >=20
> > This patch looks good, except that wasn't this supposed to be fixed
> > in printk()?  Or am I suffering from wishful thinking?
> >
> >And I was indeed suffering from wishful thinking, so I have queued this
> >patch.  A big "thank you!" to all for your patience, and to Shigeru for
> >this fix!
> >
>=20
> Test the patch
>=20
> [    0.178892] cblist_init_generic: Setting adjustable number of callback=
 queues.
> [    0.179366] cblist_init_generic: Setting shift to 2 and lim to 1.
> [    0.179488] cblist_init_generic: Setting adjustable number of callback=
 queues.
> [    0.179961] cblist_init_generic: Setting shift to 2 and lim to 1.
> [    0.180470] cblist_init_generic: Setting adjustable number of callback=
 queues.
> [    0.180949] cblist_init_generic: Setting shift to 2 and lim to 1.
>=20
>
>Nice!  Can you see the problem without that patch?  If so, may I apply
>your Tested-by?


Yes,  after enable lockdep, I also saw the consent question.

CONFIG_LOCKDEP_SUPPORT=3Dy
CONFIG_LOCKDEP=3Dy

[    0.190643] cblist_init_generic: Setting adjustable number of callback q=
ueues.
[    0.190656]
[    0.190657] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    0.190658] [ BUG: Invalid wait context ]
[    0.190659] 6.3.0-rc1-yocto-standard+ #724 Not tainted
[    0.190660] -----------------------------
[    0.190661] swapper/0/1 is trying to lock:
[    0.190662] ffffffff86235698 (&port_lock_key){....}-{3:3}, at: serial825=
0_console_write+0x37b/0x7d0
[    0.190669] other info that might help us debug this:
[    0.190670] context-{5:5}
[    0.190671] 4 locks held by swapper/0/1:
[    0.190672]  #0: ffffffff840374e0 (rcu_tasks.cbs_gbl_lock){....}-{2:2}, =
at: cblist_init_generic+0x29/0x3c0
[    0.190678]  #1: ffffffff84022320 (console_lock){+.+.}-{0:0}, at: vprint=
k_emit+0xd6/0x2f0
[    0.190684]  #2: ffffffff84022390 (console_srcu){....}-{0:0}, at: consol=
e_flush_all.constprop.0+0xbf/0x750
[    0.190689]  #3: ffffffff83fb1ca0 (console_owner){....}-{0:0}, at: conso=
le_flush_all.constprop.0+0x277/0x750
[    0.190693] stack backtrace:
[    0.190694] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.3.0-rc1-yocto-st=
andard+ #724
[    0.190696] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel=
-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/014
[    0.190698] Call Trace:
[    0.190699]  <TASK>
[    0.190700]  dump_stack_lvl+0x64/0xb0
[    0.190705]  dump_stack+0x10/0x20
[    0.190708]  __lock_acquire+0x6c4/0x3b40
[    0.190710]  ? __pfx_stack_trace_save+0x10/0x10
[    0.190713]  ? __pfx_check_noncircular+0x10/0x10
[    0.190719]  ? __pfx___lock_acquire+0x10/0x10
[    0.190722]  ? rcu_read_lock_sched_held+0xb0/0xe0
[    0.190724]  ? __kasan_check_read+0x11/0x20
[    0.190728]  lock_acquire+0x188/0x460
[    0.190730]  ? serial8250_console_write+0x37b/0x7d0
[    0.190734]  ? __pfx_lock_acquire+0x10/0x10
[    0.190738]  ? __pfx___lock_acquire+0x10/0x10
[    0.190741]  _raw_spin_lock_irqsave+0x45/0x90
[    0.190744]  ? serial8250_console_write+0x37b/0x7d0
[    0.190746]  serial8250_console_write+0x37b/0x7d0
[    0.190749]  ? console_flush_all.constprop.0+0x277/0x750
[    0.190752]  ? __pfx_serial8250_console_write+0x10/0x10
[    0.190755]  ? __pfx_lock_acquire+0x10/0x10
[    0.190757]  ? __pfx_lock_release+0x10/0x10
[    0.190759]  ? __pfx_lock_acquired+0x10/0x10
[    0.190763]  univ8250_console_write+0x4b/0x70
[    0.190766]  console_flush_all.constprop.0+0x2ea/0x750
[    0.190768]  ? console_flush_all.constprop.0+0x277/0x750
[    0.190772]  ? __pfx_console_flush_all.constprop.0+0x10/0x10
[    0.190776]  ? __pfx_lock_acquire+0x10/0x10
[    0.190780]  console_unlock+0xbd/0x140
[    0.190782]  ? __pfx_console_unlock+0x10/0x10
[    0.190784]  ? __pfx_vprintk_emit+0x10/0x10
[    0.190787]  ? __down_trylock_console_sem+0x80/0xd0
[    0.190789]  ? vprintk_emit+0xd6/0x2f0
[    0.190792]  vprintk_emit+0xdf/0x2f0
[    0.190796]  vprintk_default+0x1d/0x30
[    0.190798]  vprintk+0x50/0x60
[    0.190800]  _printk+0xb3/0xf0
[    0.190802]  ? __pfx__printk+0x10/0x10
[    0.190804]  ? __pfx_lock_acquired+0x10/0x10
[    0.190806]  ? trace_hardirqs_off+0x23/0x30
[    0.190809]  ? _raw_spin_lock_irqsave+0x76/0x90
[    0.190812]  ? lock_acquired+0x327/0x660
[    0.190814]  ? lock_acquired+0x2d6/0x660
[    0.190816]  cblist_init_generic+0x395/0x3c0
[    0.190820]  rcu_init_tasks_generic+0x15/0x1b0
[    0.190824]  kernel_init_freeable+0xc7/0x640
[    0.190827]  ? __pfx_kernel_init+0x10/0x10
[    0.190830]  kernel_init+0x21/0x180
[    0.190831]  ? __pfx_kernel_init+0x10/0x10
[    0.190833]  ? __pfx_kernel_init+0x10/0x10
[    0.190835]  ret_from_fork+0x2c/0x50
[    0.190841]  </TASK>
[    0.191635] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.192106] cblist_init_generic: Setting shift to 2 and lim to 1.
[    0.192685] cblist_init_generic: Setting shift to 2 and lim to 1.




>
> It looks more clearly
>=20
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -270,10 +270,9 @@ static void cblist_init_generic(struct rcu_tasks *rt=
p)
>         }
>         raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
>=20
> -       if (rcu_task_cb_adjust)
> -               pr_info("%s: Setting adjustable number of callback queues=
.\n", __func__);
> -
> -       pr_info("%s: Setting shift to %d and lim to %d.\n", __func__, dat=
a_race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim));
> +       pr_info("%s: Setting shift to %d and lim to %d rcu_task_cb_adjust=
=3D%d.\n",
> +                       rtp->name, data_race(rtp->percpu_enqueue_shift),
> +                       data_race(rtp->percpu_enqueue_lim), rcu_task_cb_a=
djust);
>  }
>=20
>=20
> [    0.178746] RCU Tasks: Setting shift to 2 and lim to 1 rcu_task_cb_adj=
ust=3D1.
> [    0.179322] RCU Tasks Rude: Setting shift to 2 and lim to 1 rcu_task_c=
b_adjust=3D1.
> [    0.180076] RCU Tasks Trace: Setting shift to 2 and lim to 1 rcu_task_=
cb_adjust=3D1.
>
>If you make that "Setting shift to 2, lim to 1, and rcu_task_cb_adjust=3D1=
."
>looks like an improvement to me!
>
>Please send a proper patch for it.  There might be objections if someone
>has scripting depending on the old message format, but that is after
>all one of the reasons for putting patches out for review.


I will send patch

Thanks
Zqiang

>
>							Thanx, Paul
>
> Thanks
> Zqiang
>=20
> >							Thanx, Paul
> >
> > > ---
> > >  kernel/rcu/tasks.h | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > > index 3925e32159b5..d46dd970bf22 100644
> > > --- a/kernel/rcu/tasks.h
> > > +++ b/kernel/rcu/tasks.h
> > > @@ -227,7 +227,6 @@ static void cblist_init_generic(struct rcu_tasks =
*rtp)
> > >  	if (rcu_task_enqueue_lim < 0) {
> > >  		rcu_task_enqueue_lim =3D 1;
> > >  		rcu_task_cb_adjust =3D true;
> > > -		pr_info("%s: Setting adjustable number of callback queues.\n", __f=
unc__);
> > >  	} else if (rcu_task_enqueue_lim =3D=3D 0) {
> > >  		rcu_task_enqueue_lim =3D 1;
> > >  	}
> > > @@ -256,6 +255,10 @@ static void cblist_init_generic(struct rcu_tasks=
 *rtp)
> > >  		raw_spin_unlock_rcu_node(rtpcp); // irqs remain disabled.
> > >  	}
> > >  	raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
> > > +
> > > +	if (rcu_task_cb_adjust)
> > > +		pr_info("%s: Setting adjustable number of callback queues.\n", __f=
unc__);
> > > +
> > >  	pr_info("%s: Setting shift to %d and lim to %d.\n", __func__, data_=
race(rtp->percpu_enqueue_shift), data_race(rtp->percpu_enqueue_lim));
> > >  }
> > > =20
> > > --=20
> > > 2.37.1
> > >=20
