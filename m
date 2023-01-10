Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15883663AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjAJIOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 03:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237953AbjAJINw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:13:52 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A1BD98;
        Tue, 10 Jan 2023 00:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673338430; x=1704874430;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tfRH7KKvnS0qrcYRUhfcKvdxZLTv3GfwDD3br2xo+EY=;
  b=FBKYIN0xR6Aa/xAzEX8IdJ3kL3koT+GiT26fpHRzKLAel9HzRk3TFllr
   qzU/MWwjuNFwbkb5WlwgXmGnr/atkeoHLnZ0edmzICWThFJAgNUKZaWWO
   MLD6Uv9OgT5R6M5Y2vVuToOsRLH/qJTAHy1apQV7tgYinEv3bUviQ6+6I
   k3pFtkEidvFKw9XTtODDdWDp5r8eHV5nd9y8YnJZqIYtuu386Glse4pjv
   p5hmXWgcbjO+S5SkHEOVFC2HFC7k6glJgQrCb02pQGr4wQ99twXjNJXHo
   O4/J9stLzAKC0cU10baZZbXnf5pm0eLtFpAX2sZ3xulNw9vVzzKk15Il2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="310890256"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="310890256"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 00:12:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="606872729"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="606872729"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 10 Jan 2023 00:12:55 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 00:12:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 10 Jan 2023 00:12:53 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 10 Jan 2023 00:12:53 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 10 Jan 2023 00:12:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JCEnmwxqQ2SXG9e4XyN4V61Tl5INUs0TGjm/JZwdLWc71zLaw2IXeF+DZqs/uegR3ogK/bYNkzHQBacKc07M7P84Ui3/Hf4wTQA/Ht+y0dpAgJOL/1glAVjxyLbcsAA5VCA2iOWo9rDC9QCoESafih7Cq3jVtWA4yfUS/9Y+gsNxQMIdt234bOgZgcDNfARfeBCvOx4BuEldiAKOkd/DnS9uwRLmZsOSFONMOXVWLfcdo9kai2vnNxr/z/UPjbUoE08+uvI0ikkAwrLTXP9YlTKP7YeMrHBLdFl59ZECSKHSyV09SOIhjoXK6q5e1bMSoz7aTCB3kpj7Qqi8haQdCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FaX2bvJaS0+eleY+5tjwkXJRlTe4qe+yDqlajoLdYo=;
 b=kv6Q2ULYdWYCjmP9G0uY9/zJoSKOWeeVfql5wDEbbBarFewliPt3Oh2sK4Kif/hwjQWftE0k1i5moD89EQjMBnHk9WJsKTfZu6i7Nr0rNgvK7HcM0k4Oq+OltXBXKtaPMILiHdBr8ht8G0AfBR+KbzrOWaS24my5IpQjXt3W8tDgXts3++kY3W+JSkdjrbnLqRlD5xb2SonBoHKI9kM4YV++yPXSsewES3ZxY45dLbgSLfwlVh8ixHPXJXfPIbOn2uPkhqXl/bnD6IkHcxA6oLt9x5TkpcKIiRbXvhs1+D975cdp6CJYR8+YVKc4hG3AcnCPIz2Oe0SmAM2IYE+opQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SA2PR11MB5196.namprd11.prod.outlook.com (2603:10b6:806:119::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 08:12:50 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018%4]) with mapi id 15.20.5986.018; Tue, 10 Jan 2023
 08:12:49 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "Liu, Yujie" <yujie.liu@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>, "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] rcu-tasks: Make rude RCU-Tasks work well with CPU
 hotplug
Thread-Topic: [PATCH v4] rcu-tasks: Make rude RCU-Tasks work well with CPU
 hotplug
Thread-Index: AQHZBRUNYM7gGe8KaECV+8uqpx3Q8a50ePYAgAAL4hCABFctgIAA5ZxAgBaZgACAAIwEcIAGQAgAgAAwP4CAADGRwA==
Date:   Tue, 10 Jan 2023 08:12:49 +0000
Message-ID: <PH0PR11MB58808C49B2BFA8F4D6D9E0FEDAFF9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20221130234533.1983769-1-qiang1.zhang@intel.com>
 <202212181914.f5a305f3-yujie.liu@intel.com>
 <PH0PR11MB5880EB31D9AFD82EFA3073A6DAE59@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20221221193325.GE4001@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB588092AB6A014F30420D697CDAE89@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20230105182220.GF4028633@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880273B1F5A6FF2CB782051DAFB9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20230110021012.GI4028633@paulmck-ThinkPad-P17-Gen-1>
 <20230110050253.GA3798705@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230110050253.GA3798705@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|SA2PR11MB5196:EE_
x-ms-office365-filtering-correlation-id: a180c736-c57a-45bd-b334-08daf2e276ea
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TwO7s7mpGnZ+Vw7m3CAQ0NqH376hsg5TJ5cHdTEI0uEsIKbqwcJJcEeUvRayQFvPQGpsFwOYFGNhnzeicxmBbVeC9WtG1WRlgmfuLKi5pj/+I2/OtM7TRkNvKdwJVDsPPc+eMSD9gJPYfYQu9UCfZLP5Fr97asVwWNxQjMU4F82SAi5HZc+fyiyXWmaImqDfpqDD4mXhWk6xHmm/KjnMwcD0p2mH/1lSW610iGK0MU/JPCeSZax5TbbL+AKurpMknvtuX5CIFg6f+2aEPNhubidlqNSj6Y9upER4nTy5Adz0eOqq7rqw2SShZTCuNf/OuyYqe7e1znJuFeDbqS+uRd1vppI366EVxkWcQCA/vZQSjB2guGFVXtbN31h7qbza4xbpfsj2lcSFzsWRHvmzmUvY6Cu+egva2TVtpVXjcqQUmnbDig6ey/NmuOoaGYX0j0XMIMu3KsdqSczUCssCYNA44563TxayMBRr05lUS35+VRUTxuuPu9fOFrTpCrqJKUZ7yyIeuWAWw6B7gV9pJ+j/1ccDkf9LZYv7Qw+kbRavIL4uO1AhOHWFwpl/6KIoKoakUoy5ThQn+3xeVNUphmZS2XPdxqH7evm4KQA3ZRe8a8TL6lXz9zncgzrj4C1nOhxl8A1PEz6blpzK88MU5LI2xGN0tbDNHycpifIfwb6i7whhkaZXTpnI7LrBm2WYUPD0Z2NelRR9bK3q7wTsUuDUb9IiUmn+rc64WGYbTRPPW1oQ1+L2zDHJPmQn1FMSrqkZj+XBTaS232tgznu38Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199015)(8936002)(2906002)(5660300002)(45080400002)(52536014)(41300700001)(71200400001)(66446008)(4326008)(7696005)(316002)(76116006)(6916009)(8676002)(64756008)(66556008)(66946007)(66476007)(54906003)(38070700005)(26005)(9686003)(122000001)(38100700002)(55016003)(86362001)(186003)(83380400001)(966005)(82960400001)(478600001)(33656002)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a2/X6R35k2PdmJyk6qeLbiNx66u1+OXsEBmMh1sLmf5r+V3gOe1MbZ/xBdff?=
 =?us-ascii?Q?0i/qYTOuB7Hlr4wqlQNa6Ayg4I9MOYIF16kIjQEcSAhWJvkGm0yUFoGbrtvf?=
 =?us-ascii?Q?2HpH+fzsum4+NmqfVsS2MPnYwJlu7yzwg5YdQ7qWZTCI7UoNQYkth5fCVosi?=
 =?us-ascii?Q?lRytW9K4XLctc++2wOc8/w83zO095pXN19hfrQY5Oa9HlGmYeDQA8UXTLH8t?=
 =?us-ascii?Q?2cIChoG/7OqPGWdAoWsFQiXXfZOhLJ5bHzwaQ8OdmUXiYxQq+V6njoN2Cocj?=
 =?us-ascii?Q?i/AOr5MQvVOklCQ6e1/QD6hArLyW5hMpZBWKlVyphreqp2NNTTzfj8YydaaO?=
 =?us-ascii?Q?zk3IiZddeZZsYWuJ34dS/Dtp/nRwGNrYr+2uoykIZdExZBttusr2bTGRLI3W?=
 =?us-ascii?Q?zPc1AvrCuikTf8I8JW9I4vMXTTBjIkStZxhWtr2iVsO6gxE9Me3FVXddagAs?=
 =?us-ascii?Q?3dlX1gKGpDFYcZDBvR1nD2riUFjDOBVTIRrlqhjP4whRl8Oe/KhqsoDl2Jg4?=
 =?us-ascii?Q?AgJtp1EjuncgrRHJ4LpNkAa/BarX3j0XcKy09wpflSiaYuCZQyNZg9TuAFhA?=
 =?us-ascii?Q?vvgIHDWgpKeH97kS0kcmlIJvdHR3DIQ7nsVz97X4ZJ/mYShZk0cgWYh5mNGA?=
 =?us-ascii?Q?+7RRAfpZkZZGf6RufuP0ulgCdxJe+PnMV3vw5yRz6h/CUQGswp09m7WIN227?=
 =?us-ascii?Q?Gmcz470bQh/REfsxFrL9cAie9G50kfbQVLNWTOVbPrNxGFBshApZeqU3LsEm?=
 =?us-ascii?Q?TMwBdnj7tD3hLOz4f0nkZuiujmdEbX+Bg6fuktl+g3V/FrsCzNJfKTmFN02B?=
 =?us-ascii?Q?xj/2BuKGayIWx1BYhCUHuCT6ckgUa3P+sXLyxW8PivzLcXy3QRXMXV0l47e9?=
 =?us-ascii?Q?QlKxmpx2fRjCuHxj9HYHn0noHr1q5ywlA9B/i2hRAEMKgVkDHryTBezO9Es8?=
 =?us-ascii?Q?aNEkhFjPH9KtBjoPB/4R8x9PvVOW7IaySGQebByVlJNoIazFt/Lupn3Y9sbP?=
 =?us-ascii?Q?3eskUZcg+oGa4u6LGg0M3asaOIkXLKF0sgSNTjJ8OAh26cpJ/pqQXiBb8tzS?=
 =?us-ascii?Q?g349fY+QrD94MxwHEEW0A8YW3c2PdIWB96FPkYJvv7vfukqrSWMDjRst6jy+?=
 =?us-ascii?Q?Nb895/T+OQb4UgsfEyl457ugkTXKVBLMIzzc2/AArGqiTJwCkcbTZRTFG2Pq?=
 =?us-ascii?Q?DDsEv1QZEgpu5VA0vRDYYAPmYgkEaACbkSIv0/gL0odBarf1X2rPVmydo+7h?=
 =?us-ascii?Q?KpPI0zhNSNX4eOaBBkX5NjUVqhFmHUw1mhlmjoMTVzj05+3w448KFVUbRP+/?=
 =?us-ascii?Q?aYnMbMNusWeTXfJ2X0ZY1321bgp9YdHl5fFwrDO8yqy/648EBMBdQoLlGgw7?=
 =?us-ascii?Q?9S1sCvVlwo6ghiuiEvPReNnjh/zqTXJo8JA8CSXrcdNAmRqfKpULOZbv4dMc?=
 =?us-ascii?Q?n0yCUhJM5BnLmH0JAS72kjNw2rEDe+A5xXmjLWTOYi9VRRIG6uNbxSuS3ksj?=
 =?us-ascii?Q?Y+bqp25qWoEOtzY3BXfZff+4GtyxlFyqgj/yoe0uKnQxqjvwg6O6cA3WkWbX?=
 =?us-ascii?Q?tmqt8uZhsBGAzPEGQzqMd28i9KhkBz1nEQs2b/lz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a180c736-c57a-45bd-b334-08daf2e276ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2023 08:12:49.7813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rOa88JupL2xzkM+SkUiQ0RPuLZpMGd8HhWvcgg/GQKXXktqw1JLt61hXlUD0D0CYfPoztdPNxoQf3E1k2XcBRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5196
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


On Mon, Jan 09, 2023 at 06:10:12PM -0800, Paul E. McKenney wrote:
> On Fri, Jan 06, 2023 at 02:48:56AM +0000, Zhang, Qiang1 wrote:
> >=20
> > On Thu, Dec 22, 2022 at 09:35:06AM +0000, Zhang, Qiang1 wrote:
> > > >On Mon, Dec 19, 2022 at 02:21:01AM +0000, Zhang, Qiang1 wrote:
> > > > >Greeting,
> > > > >FYI, we noticed WARNING:at_kernel/rcu/rcutorture.c:#rcu_torture_fw=
d_prog_cr[rcutorture] due to commit (built with gcc-11):
> > > > >
> > > > >commit: 572a17843591d3c03ad891492939a06833fdd17d ("[PATCH v4] rcu-=
tasks: Make rude RCU-Tasks work well with CPU hotplug")
> > > > >url: https://github.com/intel-lab-lkp/linux/commits/Zqiang/rcu-tas=
ks-Make-rude-RCU-Tasks-work-well-with-CPU-hotplug/20221201-074127
> > > > >base: https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-r=
cu.git dev
> > > > >patch link: https://lore.kernel.org/all/20221130234533.1983769-1-q=
iang1.zhang@intel.com/
> > > > >patch subject: [PATCH v4] rcu-tasks: Make rude RCU-Tasks work well=
 with CPU hotplug
> > > > >
> > > > >in testcase: rcutorture
> > > > >version:=20
> > > > >with following parameters:
> > > > >
> > > > >	runtime: 300s
> > > > >	test: cpuhotplug
> > > > >	torture_type: tasks-rude
> > > > >
> > > > >test-description: rcutorture is rcutorture kernel module load/unlo=
ad test.
> > > > >test-url: https://www.kernel.org/doc/Documentation/RCU/torture.txt
> > > > >
> > > > >on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -sm=
p 2 -m 8G
> > > > >
> > > > >caused below changes (please refer to attached dmesg/kmsg for enti=
re log/backtrace):
> > > > >
> > > > >
> > > > >[  106.051532][  T583] rcu_torture_fwd_prog: Starting forward-prog=
ress test 0
> > > > >[  106.052085][  T583] rcu_torture_fwd_prog_cr: Starting forward-p=
rogress test 0
> > > > >[  133.611262][  T583] rcu_torture_fwd_prog_cr: Waiting for CBs: r=
cu_barrier_tasks_rude+0x0/0x10() 0
> > > > >[  146.800051][  T583] ------------[ cut here ]------------
> > > > >[  146.800411][  T583] WARNING: CPU: 1 PID: 583 at kernel/rcu/rcut=
orture.c:2806 rcu_torture_fwd_prog_cr+0x22c/0x2a7 [rcutorture]
> > > > >[  146.801075][  T583] Modules linked in: rcutorture torture ipmi_=
msghandler crc32c_intel serio_raw processor fuse
> > > > >[  146.801894][  T583] CPU: 1 PID: 583 Comm: rcu_torture_fwd Not t=
ainted 6.1.0-rc1-00180-g572a17843591 #1 0cc09f902db70bae111a0c12c137296733d=
de4a9
> > > > >[  146.802916][  T583] Hardware name: QEMU Standard PC (i440FX + P=
IIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
> > > > >[  146.803693][  T583] EIP: rcu_torture_fwd_prog_cr+0x22c/0x2a7 [r=
cutorture]
> > > > >[  146.804177][  T583] Code: 89 d8 e8 fc c5 ff ff e8 67 49 03 00 8=
3 c4 10 84 c0 75 79 a0 96 c6 10 ef 84 c0 75 70 e8 c8 ee ff ff 84 c0 75 67 8=
3 fe 63 7f 02 <0f> 0b 8b 45 f0 8b 15 40 25 8a c2 ff 75 e8 ff 75 e0 01 f8 2b=
 45 dc
> > > > >[  146.805599][  T583] EAX: 00000000 EBX: ecee3800 ECX: 00000000 E=
DX: 00000000
> > > > >[  146.805992][  T583] ESI: 00000000 EDI: 0000c350 EBP: ed9d5f64 E=
SP: ed9d5f40
> > > > >[  146.806491][  T583] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 006=
8 EFLAGS: 00010293
> > > > >[  146.807010][  T583] CR0: 80050033 CR2: 08082ff0 CR3: 2daaf000 C=
R4: 000406d0
> > > > >[  146.807484][  T583] DR0: 00000000 DR1: 00000000 DR2: 00000000 D=
R3: 00000000
> > > > >[  146.808031][  T583] DR6: fffe0ff0 DR7: 00000400
> > > > >[  146.808384][  T583] Call Trace:
> > > > >[  146.808634][  T583]  rcu_torture_fwd_prog.cold+0x3b/0xee [rcuto=
rture 6754ed9afe4685f50ef7fade6309181c73794538]
> > > > >[  146.809348][  T583]  kthread+0xc8/0xf0
> > > > >[  146.809635][  T583]  ? rcu_torture_fwd_prog_cbfree+0x80/0x80 [r=
cutorture 6754ed9afe4685f50ef7fade6309181c73794538]
> > > > >[  146.810347][  T583]  ? kthread_complete_and_exit+0x20/0x20
> > > > >[  146.810734][  T583]  ret_from_fork+0x1c/0x28
> > > > >[  146.811075][  T583] irq event stamp: 205883
> > > > >[  146.811400][  T583] hardirqs last  enabled at (205891): [<c114b=
b06>] __up_console_sem+0x66/0x80
> > > > >[  146.811960][  T583] hardirqs last disabled at (205898): [<c114b=
aed>] __up_console_sem+0x4d/0x80
> > > > >[  146.812583][  T583] softirqs last  enabled at (205880): [<c1ecb=
40b>] __do_softirq+0x2bb/0x440
> > > > >[  146.813079][  T583] softirqs last disabled at (205871): [<c1084=
5f0>] call_on_stack+0x40/0x50
> > > > >[  146.813567][  T583] ---[ end trace 0000000000000000 ]---
> > > > >[  146.813926][  T583] rcu_torture_fwd_prog_cr Duration 2411 barri=
er: 3960 pending 50000 n_launders: 0 n_launders_sa: 0 n_max_gps: 0 n_max_cb=
s: 50000 cver 1 gps 0
> > > > >[  147.914266][  T583] rcu_torture_fwd_cb_hist: Callback-invocatio=
n histogram 0 (duration 6702 jiffies): 1s/10: 0:0 2s/10:=20
> > > > >[  149.453780][  T557] ------------[ cut here ]------------
> > > > >[  149.454322][  T557] rcu_torture_writer: rtort_pipe_count: 4
> > > > >[  149.454817][  T557] WARNING: CPU: 1 PID: 557 at kernel/rcu/rcut=
orture.c:1583 rcu_torture_writer+0x71d/0xc80 [rcutorture]
> > > >=20
> > > >=20
> > > > This is not a bug.  this is caused by grace period taking too long =
time, the previous callback
> > > > has not been completed.  from the dmesg, can be found that the cpuh=
otplug test is being
> > > > performed periodically, this may cause the rude RCU-Tasks  grace pe=
riod to take more time,
> > > > due to we need to acquire the cpus_read_lock, and the CPU0 always b=
ootup failed, that is to
> > > > say, only one CPU of your system is online at this time.
> > > >
> > > >Onlining of a CPU failing with EIO is a new one on me.  Especially
> > > >persistent failure.
> > >=20
> > > I use the kernel configuration file in the attachment and  base on:
> > > https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git de=
v
> > >=20
> > > use "echo 1 > /sys/devices/system/cpu/cpu0/online" can reproduce this=
 problem,
> > > the CPU0 always fails to go online. =20
> > >=20
> > > Debug found CPU0 is always not set in cpu_initialized_mask.
> > > causes the do_boot_cpu() to return -1.
> > >=20
> > > do_boot_cpu()
> > >      wakeup_cpu_via_init_nmi();
> > >      if (!boot_error) {
> > >                 /*
> > >                  * Wait 10s total for first sign of life from AP
> > >                  */
> > >                 boot_error =3D -1;
> > >                 timeout =3D jiffies + 10*HZ;
> > >                 while (time_before(jiffies, timeout)) {
> > >                         if (cpumask_test_cpu(cpu, cpu_initialized_mas=
k)) {
> > >                                 /*
> > >                                  * Tell AP to proceed with initializa=
tion
> > >                                  */
> > >                                 cpumask_set_cpu(cpu, cpu_callout_mask=
);
> > >                                 boot_error =3D 0;
> > >                                 break;
> > >                         }
> > >                         schedule();
> > >                 }
> > >         }
> > >=20
> > > This looks related to this modification e1c467e69040c("x86, hotplug:=
=20
> > > Wake up CPU0 via NMI instead of INIT, SIPI, SIPI ").
> > >=20
> > >=20
> > > The following modification can make CPU0 go online successfully(This
> > > is just a test, not sure if there are other effects).
> > >
> > >
> > >Thank you for tracking this down!!!
> > >
> > >Huh.  CPU 0 is normally the boot CPU.  Back in the day, it could not
> > >be offlined.  Given that your testing indicates that CPU 0 can now be
> > >taken offline, maybe this "if" statement is a holdover that someone
> > >forgot to remove?
> > >
> > >But I must defer to those who know a lot more about this level of
> > >x86 code than I do.
> >=20
> > I found relevant modification information, maybe it will be of some hel=
p
> >=20
> > commit e1c467e69040c3be68959332959c07fb3d818e87
> > Author: Fenghua Yu <fenghua.yu@intel.com>
> > Date:   Wed Nov 14 04:36:53 2012 -0800
> >=20
> >     x86, hotplug: Wake up CPU0 via NMI instead of INIT, SIPI, SIPI
> >=20
> >     Instead of waiting for STARTUP after INITs, BSP will execute the BI=
OS boot-strap
> >     code which is not a desired behavior for waking up BSP. To avoid th=
e boot-strap
> >     code, wake up CPU0 by NMI instead.
> >=20
> >     This works to wake up soft offlined CPU0 only. If CPU0 is hard offl=
ined (i.e.
> >     physically hot removed and then hot added), NMI won't wake it up. W=
e'll change
> >     this code in the future to wake up hard offlined CPU0 if real platf=
orm and
> >     request are available.
> >=20
> >     AP is still waken up as before by INIT, SIPI, SIPI sequence.
> >=20
> >     Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> >     Link: http://lkml.kernel.org/r/1352896613-25957-1-git-send-email-fe=
nghua.yu@intel.com
> >     Signed-off-by: H. Peter Anvin <hpa@linux.intel.com>
>=20
> Interesting!
>=20
> When I run rcutorture on x86 (under qemu/KVM), it refuses to attempt to
> offline CPU 0.  The reason is that cpu_is_hotpluggable(0) returns false.
>=20
> If I comment out that check, I get this:
>=20
> 	rcu-torture:torture_onoff task: offline 0 failed: errno -1
>=20
> A bit of digging turned up the CONFIG_BOOTPARAM_HOTPLUG_CPU0 Kconfig
> option.  Setting that causes CPU 0 to be offlined.
>=20
> I clearly need to add this to one of the scenarios.  I arbitrarily
> chose TREE01, but please let me know if some other scenario or
> group of scenarios would be better.
>
>For example, like this.

This looks good, whether all TREE* can be added ?=20
(after all, this just makes CPU0 support offline, but the actual CPU going=
=20
offline/online also depends on "onoff_interval").

Thanks
Zqiang

>
>						Thanx, Paul
>
>------------------------------------------------------------------------
>
>commit 6c11be38a0363b61db36352555e6746920711a1f
>Author: Paul E. McKenney <paulmck@kernel.org>
>Date:   Mon Jan 9 21:01:12 2023 -0800
>
>    rcutorture: Set CONFIG_BOOTPARAM_HOTPLUG_CPU0 to offline CPU 0
>   =20
>    There is now a BOOTPARAM_HOTPLUG_CPU0 Kconfig option that allows CPU 0
>    to be offlined on x86 systems.  This commit therefore sets this option=
 in
>    the TREE01 rcutorture scenario in order to regularly test this capabil=
ity.
>   =20
>    Reported-by: "Zhang, Qiang1" <qiang1.zhang@intel.com>
>    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
>diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE01 b/tools=
/testing/selftests/rcutorture/configs/rcu/TREE01
>index 8ae41d5f81a3e..04831ef1f9b55 100644
>--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE01
>+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE01
>@@ -15,3 +15,4 @@ CONFIG_DEBUG_LOCK_ALLOC=3Dn
>CONFIG_RCU_BOOST=3Dn
> CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dn
> CONFIG_RCU_EXPERT=3Dy
>+CONFIG_BOOTPARAM_HOTPLUG_CPU0=3Dy
