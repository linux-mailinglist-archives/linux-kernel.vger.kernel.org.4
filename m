Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680236DEC08
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 08:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjDLGqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 02:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDLGqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 02:46:08 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A698A4EEB;
        Tue, 11 Apr 2023 23:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681281962; x=1712817962;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PMZWdmPMRoo3tPbeaoTqFNn8JNN3czzkYFRWGRgYN8Y=;
  b=nSU2cXxzWoN1a1klvua+PCP17/FnkAAx02oACl9sM1k1eEWCGI4PRn41
   2/C1/2sJJOQomdZAHbaKdWNljBsW9uWGiSEV9aNn7GrkanrB4agWjWbFZ
   QLTW/YIW7k5uU/maWsSlUtB1VazsOBX+42aZpFVmu6ODZ/9k9tIXl+WLf
   uiGNn8UNPtafl7JvuhcwKaqQvUzA4ieZArybIiDU1d2kihCPBzLfPhKuN
   INZLANHFFJhXkPAGoEgOex8mdcD3lJz944DMUQFuxDd0BUhX2FLv0cMI5
   U12t2fKKJ6CohdmMcLkh1UgcRCYyJdwQFdjkX8vOR0p6y1y4s4rCcPpbT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="343820175"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="343820175"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 23:44:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="666233243"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="666233243"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 11 Apr 2023 23:44:48 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 23:44:48 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 23:44:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 11 Apr 2023 23:44:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 11 Apr 2023 23:44:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pjz7H7rDeYZlN2K9+cW9Y5WsUxVd8ueIkQQM2lDFUJl5R0Tbwy1KopWd4TumiTOvicr0jTJEO9+9A5tcN+i/RDBo8A1eYb4BBOvIrcz9zL5BqtJ1In4s1zaOoXlEuJHYS+sHGMeSXIibpacLF9D+5m2HGn98HQADAP5sFVEiSavvGxH8Zm+jzqCyaThdOc2Jgxv+SWD9yWHry0B63uMlOWfcciWGEhbOvxRbeA0hHWsegyhrGbbsT1rb7VsMmjPpNGbnxsP9GPgCLWxNF5fb8pkqj6ElccykH6wnjx+43HDwna3T5PI/jCEiMp1hUcXZxfU5mpWH80SUmXbTNvTyxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxpG2p1BQnUNYv/aXcFwLE84nwDGRGbyml4dCdlfyDA=;
 b=nuNwPQOkMuIaz30ZVYSwRxkjj2JONFyZyW7tn4BZ9AETolXFnogqSwnQowpfGyMbWTf+paSK4qGnXho3VBngmqz/qo+yiDBpfn5pjn/fum8GU4+s9pHGZjQx38bHGwE+0CXSuH+JaV48l0wSAclVvfdE88B3sp15el0gfDJGAK/PohGIvKp9OR614O9J5BtoM8/ZhxLFeTe7wXoywMrZ8+5qqjivDy9S+wThzWW0s4AD1EM5zEe8bSch0X8VQPpTY68aqvUUdbmvjedrw8crwlfxXnCgIq4QhGjcxPgSFrkXWudjMfO3mGj1cBlbfxr0uO8uz21lYkrgLKLeftUNBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by IA0PR11MB7379.namprd11.prod.outlook.com (2603:10b6:208:431::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 06:44:44 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::3265:f579:62a6:8a0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::3265:f579:62a6:8a0%5]) with mapi id 15.20.6277.035; Wed, 12 Apr 2023
 06:44:43 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Boqun Feng <boqun.feng@gmail.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>
CC:     Vlastimil Babka <vbabka@suse.cz>,
        "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "cl@linux.com" <cl@linux.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhao Gongyi <zhaogongyi@bytedance.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: RE: [PATCH] mm: slub: annotate kmem_cache_node->list_lock as
 raw_spinlock
Thread-Topic: [PATCH] mm: slub: annotate kmem_cache_node->list_lock as
 raw_spinlock
Thread-Index: AQHZbHbki7Ma+vCNa0GDd71XLN+bza8mHYCAgAAHn4CAAAM6AIAAAYwAgAEC4ICAAAO8cA==
Date:   Wed, 12 Apr 2023 06:44:43 +0000
Message-ID: <PH0PR11MB58805856C1C47D49D1BA8092DA9B9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230411130854.46795-1-zhengqi.arch@bytedance.com>
 <c6ea3b17-a89c-6f66-5c86-967f1da601b4@suse.cz>
 <ccaf5e8e-3457-a2cf-b6eb-794cbf1b46f5@bytedance.com>
 <f54cfeb9-f1c3-e656-d344-4cbf97a7c28a@suse.cz>
 <932bf921-a076-e166-4f95-1adb24d544cf@bytedance.com>
 <ZDZG6wlWIE4dzd4W@Boquns-Mac-mini.local>
In-Reply-To: <ZDZG6wlWIE4dzd4W@Boquns-Mac-mini.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|IA0PR11MB7379:EE_
x-ms-office365-filtering-correlation-id: d6c95e2a-1736-4b20-2da1-08db3b21661e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lr7mi0MU94koCjOLRIq9asSo863DZ9k1SmzBDwNoOlP0bI2RSrnmt4bgaG0DwnIcigxaFMabEgTmFu+wvPVYjJo1MXTJBq8jtqNM/3akhFl9N+2IzIHBIt6Y34F9B5oGhHnv+hzlmOjEDY0fvw5l6oHMA1fCofjaoJVYFs+5nmzy0MZz3FF8yxGI+UHyVPZo2RLXA/yvpY4MnePilEvhB8nr5+PDOIKvMOevbk34xCUA1fjuOpnq5W1DYNkDiwQQG4tXqDMKunKVLiQqxzMLnUsHyCi0AMgZKmPW6zWT4JjnkegY3z72mlGGizH0RJ9sh0MuzM+4YzbxqyuaxBIlSdSjA9/ctiL6d+7fnTD15kA3sv8vWPKCXaUTHPZj5YsjkZquMXmK62LDuE7cXgSDGfp/q7NX+INreqSLjw3ZnyJxVQ/cMWHbbiispuel1k8OfV958KkaqYhg+k2hwH9KYLo+q+CCsIx8k9YhJK3t5EZQjMn9vC3LfxNBGMxpZVIKFfdSWaigiViYLayMKgbdWt5fOU6fU3kxSjJHLO3LiSjWqhELMpkfmLxBJmdZpMEIooscidyEMDsNZVnVhJTZ6htjkh6ZPKklQzQwV7Sf7v6HY3wRe46OnRrHm5Juyr+u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199021)(66476007)(8676002)(66446008)(4326008)(7696005)(66556008)(64756008)(71200400001)(66946007)(76116006)(54906003)(478600001)(41300700001)(110136005)(316002)(33656002)(86362001)(83380400001)(9686003)(6506007)(26005)(53546011)(8936002)(2906002)(7416002)(5660300002)(55016003)(38070700005)(82960400001)(38100700002)(186003)(52536014)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cUXC3UADBH5peLIXIZjM317dPJbCL6fLdv12dLqeEwb+1is1CtPjTlkcGfTA?=
 =?us-ascii?Q?m0ALtfElCsFJjOx29lMU82j9XwhCIcRDsk8sCIeXq+0dOynW6H2aARUVy4Rz?=
 =?us-ascii?Q?ROuQWL20O3S3zi5g8WzzcCevtlsiXUcDeO/WW4p9Q4MWcLjCRRZOok6QIwkx?=
 =?us-ascii?Q?OEVZvzROk+cupRVLCjIjLA4cWzNKlyfhdVWhR/V94dc5O8H6PmsHeUfDIRVY?=
 =?us-ascii?Q?L0Wf1+Z1glAO7I28cYdZu6RRErlVT9BugyG1G8vuXWS6453euDceZsTg15WZ?=
 =?us-ascii?Q?h+BHEb8w6+4walxrbaR3rRbvBLI97ci+MbBca3QAoGAaQ05Qg1eMcplnm2BY?=
 =?us-ascii?Q?mIqWhMUlSTCgIWhIFRMTTEzig9z6dJzUny7WoVnSgnQosO/2GlYhp42vAKgF?=
 =?us-ascii?Q?DgJ2vlYme46PifX8GX41jlOZolSa925cKQqgFuoVs6T+xuxI80QpIh40iEBr?=
 =?us-ascii?Q?buZSUrFbSxmtOL3g1EQzLXBE2xD4qjHCoZNgNc19R5Zz0lR0Xi2d3928nfVn?=
 =?us-ascii?Q?jYJq69jfv/thBa+eECjVSjnK4dRkpA6bYjK7jZUnPsqOB0DlR9povfF20m6f?=
 =?us-ascii?Q?jwZVTFEZRXrCWdtCzAgrYsrYgbcSkXGQ8sMx+ZgQEFN4815XWb7VyGnVSikw?=
 =?us-ascii?Q?Sqcdljaa/lMEov+mRsB4znUuH2fV68g60wFzOXFuHmVDDVy0MPgC7pr4sk4g?=
 =?us-ascii?Q?mW980I14nKH0rbH1kL9NEgmbir/m44aMcBrkUrUgFRShIqbRz1MlqRuKA7bv?=
 =?us-ascii?Q?VnYR/rIE1UdOAVKihncwZ0nFti6pqgeJJ35BY/D1Uh1meCM6eyRFDNvfdCAd?=
 =?us-ascii?Q?iP/sdKjtxFi7CKV08/tjZWSgvMi0lChf4mu6tkP+EIUSzScdWLFHEiHl422D?=
 =?us-ascii?Q?r7tCsUL3SFgP2OLxcusAai2VpYqhpyC4S+LdPSvXWtGAGGkCXlI+8qjFiTGd?=
 =?us-ascii?Q?Z2DagPvC00dfVtVvioYoif5J3Y2jg2LC7/KBd3GVT6HdUWF3EJ2TEQ7NDUsg?=
 =?us-ascii?Q?ESAbvupqs8qe3DVZIREqrL8iECx6hWLuKIsAZ7Zmx5UWEpOkwt0YOUG49kNz?=
 =?us-ascii?Q?bZRFr8TODhwXtdjc2fh/AYvX777AX9scTL50RGzBDhyX0iIg+IiL51aKUtpb?=
 =?us-ascii?Q?XC6xry5rO+7P5hNlyN06GfYmRT6ue9We1kvaQo/aAbdxnZAWzKoQYzTg7g1r?=
 =?us-ascii?Q?JXsjy+saFwGkx3mtUSA/leZ0WO2lhBEib61sL/Y39g2xyDYF07gtNbMgxV3e?=
 =?us-ascii?Q?0WEtBXYqXK07ewjrlYx7F88jHYxkWRktGMi4RElISCU5olurnK9PmYnJkv4+?=
 =?us-ascii?Q?tIuSlNkBRdR6c2Y2f4+6YVSbFEDkOK9rfrCwuUI8yE3gPelcqM3qNxD1q4UQ?=
 =?us-ascii?Q?4mR3ti7P3g25+naaPdmzhs9xfBlYyONLhKxpkMGs8p4F4atZid2KE/ugT3nq?=
 =?us-ascii?Q?ki8EygjXYrjNsl5zuoNFhqiKlyKunzISpLDUCBOrUwwHFxo78UamdmW49EbC?=
 =?us-ascii?Q?jmguVdTjvQd1GWyGmU5EymdEHiSVOg/mb3EsoJw0krE9NKghd5kpWOsY4LWi?=
 =?us-ascii?Q?VGqThM8EqngkkqiCiVUsZIRNK6ECixG4Wv4n/3OL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c95e2a-1736-4b20-2da1-08db3b21661e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 06:44:43.5761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f7jyDKSM93IINtf50u7ouTghxCUdeS7pK1FJ1IhS1eFa0bVqJKVcbHWNfvA1Ri8lMDjQ97wgzTJQmpRgbASQaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7379
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

>=20
>=20
> On 2023/4/11 22:19, Vlastimil Babka wrote:
> > On 4/11/23 16:08, Qi Zheng wrote:
> > >=20
> > >=20
> > > On 2023/4/11 21:40, Vlastimil Babka wrote:
> > > > On 4/11/23 15:08, Qi Zheng wrote:
> > > > > The list_lock can be held in the critical section of
> > > > > raw_spinlock, and then lockdep will complain about it
> > > > > like below:
> > > > >=20
> > > > >    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >    [ BUG: Invalid wait context ]
> > > > >    6.3.0-rc6-next-20230411 #7 Not tainted
> > > > >    -----------------------------
> > > > >    swapper/0/1 is trying to lock:
> > > > >    ffff888100055418 (&n->list_lock){....}-{3:3}, at: ___slab_allo=
c+0x73d/0x1330
> > > > >    other info that might help us debug this:
> > > > >    context-{5:5}
> > > > >    2 locks held by swapper/0/1:
> > > > >     #0: ffffffff824e8160 (rcu_tasks.cbs_gbl_lock){....}-{2:2}, at=
: cblist_init_generic+0x22/0x2d0
> > > > >     #1: ffff888136bede50 (&ACCESS_PRIVATE(rtpcp, lock)){....}-{2:=
2}, at: cblist_init_generic+0x232/0x2d0
> > > > >    stack backtrace:
> > > > >    CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.3.0-rc6-next-20230=
411 #7
> > > > >    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.=
14.0-2 04/01/2014
> > > > >    Call Trace:
> > > > >     <TASK>
> > > > >     dump_stack_lvl+0x77/0xc0
> > > > >     __lock_acquire+0xa65/0x2950
> > > > >     ? arch_stack_walk+0x65/0xf0
> > > > >     ? arch_stack_walk+0x65/0xf0
> > > > >     ? unwind_next_frame+0x602/0x8d0
> > > > >     lock_acquire+0xe0/0x300
> > > > >     ? ___slab_alloc+0x73d/0x1330
> > > > >     ? find_usage_forwards+0x39/0x50
> > > > >     ? check_irq_usage+0x162/0xa70
> > > > >     ? __bfs+0x10c/0x2c0
> > > > >     _raw_spin_lock_irqsave+0x4f/0x90
> > > > >     ? ___slab_alloc+0x73d/0x1330
> > > > >     ___slab_alloc+0x73d/0x1330
> > > > >     ? fill_pool+0x16b/0x2a0
> > > > >     ? look_up_lock_class+0x5d/0x160
> > > > >     ? register_lock_class+0x48/0x500
> > > > >     ? __lock_acquire+0xabc/0x2950
> > > > >     ? fill_pool+0x16b/0x2a0
> > > > >     kmem_cache_alloc+0x358/0x3b0
> > > > >     ? __lock_acquire+0xabc/0x2950
> > > > >     fill_pool+0x16b/0x2a0
> > > > >     ? __debug_object_init+0x292/0x560
> > > > >     ? lock_acquire+0xe0/0x300
> > > > >     ? cblist_init_generic+0x232/0x2d0
> > > > >     __debug_object_init+0x2c/0x560
>
>This "__debug_object_init" is because INIT_WORK() is called in
>cblist_init_generic(), so..
>
> > > > >     cblist_init_generic+0x147/0x2d0
> > > > >     rcu_init_tasks_generic+0x15/0x190
> > > > >     kernel_init_freeable+0x6e/0x3e0
> > > > >     ? rest_init+0x1e0/0x1e0
> > > > >     kernel_init+0x1b/0x1d0
> > > > >     ? rest_init+0x1e0/0x1e0
> > > > >     ret_from_fork+0x1f/0x30
> > > > >     </TASK>
> > > > >=20
> > > > > The fill_pool() can only be called in the !PREEMPT_RT kernel
> > > > > or in the preemptible context of the PREEMPT_RT kernel, so
> > > > > the above warning is not a real issue, but it's better to
> > > > > annotate kmem_cache_node->list_lock as raw_spinlock to get
> > > > > rid of such issue.
> > > >=20
> > > > + CC some RT and RCU people
> > >=20
> > > Thanks.
> > >=20
> > > >=20
> > > > AFAIK raw_spinlock is not just an annotation, but on RT it changes =
the
> > > > implementation from preemptible mutex to actual spin lock, so it wo=
uld be
> > >=20
> > > Yeah.
> > >=20
> > > > rather unfortunate to do that for a spurious warning. Can it be som=
ehow
> > > > fixed in a better way?
>
>... probably a better fix is to drop locks and call INIT_WORK(), or make
>the cblist_init_generic() lockless (or part lockless), given it's just
>initializing the cblist, it's probably doable. But I haven't taken a
>careful look yet.
>


This is just one of the paths that triggers an invalid wait,  the following=
 paths can also trigger:

[  129.914547] [ BUG: Invalid wait context ]
[  129.914775] 6.3.0-rc1-yocto-standard+ #2 Not tainted
[  129.915044] -----------------------------
[  129.915272] kworker/2:0/28 is trying to lock:
[  129.915516] ffff88815660f570 (&c->lock){-.-.}-{3:3}, at: ___slab_alloc+0=
x68/0x12e0
[  129.915967] other info that might help us debug this:
[  129.916241] context-{5:5}
[  129.916392] 3 locks held by kworker/2:0/28:
[  129.916642]  #0: ffff888100084d48 ((wq_completion)events){+.+.}-{0:0}, a=
t: process_one_work+0x515/0xba0
[  129.917145]  #1: ffff888100c17dd0 ((work_completion)(&(&krcp->monitor_wo=
rk)->work)){+.+.}-{0:0}, at: process_on0
[  129.917758]  #2: ffff8881565f8508 (krc.lock){....}-{2:2}, at: kfree_rcu_=
monitor+0x29f/0x810
[  129.918207] stack backtrace:
[  129.918374] CPU: 2 PID: 28 Comm: kworker/2:0 Not tainted 6.3.0-rc1-yocto=
-standard+ #2
[  129.918784] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel=
-1.16.1-0-g3208b098f51a-prebuilt.qemu.o4
[  129.919397] Workqueue: events kfree_rcu_monitor
[  129.919662] Call Trace:
[  129.919812]  <TASK>
[  129.919941]  dump_stack_lvl+0x64/0xb0
[  129.920171]  dump_stack+0x10/0x20
[  129.920372]  __lock_acquire+0xeb8/0x3a80
[  129.920603]  ? ret_from_fork+0x2c/0x50
[  129.920824]  ? __pfx___lock_acquire+0x10/0x10
[  129.921068]  ? unwind_next_frame.part.0+0x1ba/0x3c0
[  129.921343]  ? ret_from_fork+0x2c/0x50
[  129.921573]  ? __this_cpu_preempt_check+0x13/0x20
[  129.921847]  lock_acquire+0x194/0x480
[  129.922060]  ? ___slab_alloc+0x68/0x12e0
[  129.922293]  ? __pfx_lock_acquire+0x10/0x10
[  129.922529]  ? __pfx_mark_lock.part.0+0x10/0x10
[  129.922778]  ? __kasan_check_read+0x11/0x20
[  129.922998]  ___slab_alloc+0x9a/0x12e0
[  129.923222]  ? ___slab_alloc+0x68/0x12e0
[  129.923452]  ? __pfx_mark_lock.part.0+0x10/0x10
[  129.923706]  ? __kasan_check_read+0x11/0x20
[  129.923937]  ? fill_pool+0x22a/0x370
[  129.924161]  ? __lock_acquire+0xf5b/0x3a80
[  129.924387]  ? fill_pool+0x22a/0x370
[  129.924590]  __slab_alloc.constprop.0+0x5b/0x90
[  129.924832]  kmem_cache_alloc+0x296/0x3d0
[  129.925073]  ? fill_pool+0x22a/0x370
[  129.925291]  fill_pool+0x22a/0x370
[  129.925495]  ? __pfx_fill_pool+0x10/0x10
[  129.925718]  ? __pfx___lock_acquire+0x10/0x10
[  129.926034]  ? __kasan_check_read+0x11/0x20
[  129.926269]  ? check_chain_key+0x200/0x2b0
[  129.926503]  __debug_object_init+0x82/0x8c0
[  129.926734]  ? __pfx_lock_release+0x10/0x10
[  129.926984]  ? __pfx___debug_object_init+0x10/0x10
[  129.927249]  ? __kasan_check_read+0x11/0x20
[  129.927498]  ? do_raw_spin_unlock+0x9c/0x100
[  129.927758]  debug_object_activate+0x2d1/0x2f0
[  129.928022]  ? __pfx_debug_object_activate+0x10/0x10
[  129.928300]  ? __this_cpu_preempt_check+0x13/0x20
[  129.928583]  __call_rcu_common.constprop.0+0x94/0xeb0
[  129.928897]  ? __this_cpu_preempt_check+0x13/0x20
[  129.929186]  ? __pfx_rcu_work_rcufn+0x10/0x10
[  129.929459]  ? __pfx___call_rcu_common.constprop.0+0x10/0x10
[  129.929803]  ? __pfx_lock_acquired+0x10/0x10
[  129.930067]  ? __pfx_do_raw_spin_trylock+0x10/0x10
[  129.930363]  ? kfree_rcu_monitor+0x29f/0x810
[  129.930627]  call_rcu+0xe/0x20
[  129.930821]  queue_rcu_work+0x4f/0x60
[  129.931050]  kfree_rcu_monitor+0x5d3/0x810
[  129.931302]  ? __pfx_kfree_rcu_monitor+0x10/0x10
[  129.931587]  ? __this_cpu_preempt_check+0x13/0x20
[  129.931878]  process_one_work+0x607/0xba0
[  129.932129]  ? __pfx_process_one_work+0x10/0x10
[  129.932408]  ? worker_thread+0xd6/0x710
[  129.932653]  worker_thread+0x2d4/0x710
[  129.932888]  ? __pfx_worker_thread+0x10/0x10
[  129.933154]  kthread+0x18b/0x1c0
[  129.933363]  ? __pfx_kthread+0x10/0x10
[  129.933598]  ret_from_fork+0x2c/0x50
[  129.933825]  </TASK>

Maybe no need to convert ->list_lock to raw_spinlock.

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -562,10 +562,10 @@ __debug_object_init(void *addr, const struct debug_ob=
j_descr *descr, int onstack
        unsigned long flags;

        /*
-        * On RT enabled kernels the pool refill must happen in preemptible
+        * The pool refill must happen in preemptible
         * context:
         */
-       if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
+       if (preemptible())
                fill_pool();

        db =3D get_bucket((unsigned long) addr);



Thanks
Zqiang

>
>
>Regards,
>Boqun
>
> > >=20
> > > It's indeed unfortunate for the warning in the commit message. But
> > > functions like kmem_cache_alloc(GFP_ATOMIC) may indeed be called
> > > in the critical section of raw_spinlock or in the hardirq context, wh=
ich
> >=20
> > Hmm, I thought they may not, actually.
> >=20
> > > will cause problem in the PREEMPT_RT kernel. So I still think it is
> > > reasonable to convert kmem_cache_node->list_lock to raw_spinlock type=
.
> >=20
> > It wouldn't be the complete solution anyway. Once we allow even a GFP_A=
TOMIC
> > slab allocation for such context, it means also page allocation can hap=
pen
> > to refill the slabs, so lockdep will eventually complain about zone->lo=
ck,
> > and who knows what else.
>=20
> Oh, indeed. :(
>=20
> >=20
> > > In addition, there are many fix patches for this kind of warning in t=
he
> > > git log, so I also think there should be a general and better solutio=
n. :)
> >=20
> > Maybe, but given above, I doubt it's this one.
> >=20
> > >=20
> > > >=20
> > >=20
> >=20
>=20
> --=20
> Thanks,
> Qi
