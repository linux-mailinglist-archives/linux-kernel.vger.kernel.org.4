Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701666C7585
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 03:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjCXCUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 22:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjCXCUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 22:20:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EEA2A150;
        Thu, 23 Mar 2023 19:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679624428; x=1711160428;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q4CATM35YM77Qw26mThbqHFvu87PLrq5zpJzwzC5b8Y=;
  b=f4ukaCp1KRHgB40ptwuZgzbPQGlotsS0tF3Ct5tmSvwKBdq14a2VySb+
   C6ndIODNKNQGXtrWEOKdkgJeoQ96dGi8cpqZpaGEWO9v5PnN70tbBBwoR
   pMR8O7Q/fI/F0ruksJOT3k5OWCdoao1REYd1JUN2qVts/7EgvaN386GSX
   ezmlcgByVS5sR4nJPK/O4KEqEtdF/GJRos+qOx/BBM2y5/oZgtyGQLvaq
   JI6yEKbGoX9jJC5BYS9fHLMeuhA/FZ4myYspX9mBwlROxmuu94pAmy7sI
   e+KYdodiPCXyrJs0LHm1dS9a2uf4GbFRzbFrbXwuyyryOkYjWTA5xmric
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="402259787"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="402259787"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 19:20:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="1012077464"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="1012077464"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 23 Mar 2023 19:20:27 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 19:20:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 19:20:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 19:20:26 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 19:20:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gt7FfVypHDFuDxLWmzAAOMvO4p5Jmodbc8noD03xKaJGMUPscXA8+FpMhcblUakRhP+41hBB/45Vr02DxrfeNLKxDIEkVFOexZ0IPOuc+YSVk7q55Js5UEYKV0Tu6lkPZ5SZEbI5T7c2hRiYas6iGrp2HyB3bQA7jgVRI2tIjT5QElpUgBTd17tyZkO/LlVXnGa18glLCzLYBBf3KzfVb9NZ3HbyW24DY8s5IzPDJsO/T1+/uCiTFOC2N5wDlMAD5ODk/o9JKnP0T324ZLyclOkmm10krZZH155qHROiHcqdA9tD4s+4GyO1T064UoVhRiDdjrk2p14VP5t7K7MFIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4CATM35YM77Qw26mThbqHFvu87PLrq5zpJzwzC5b8Y=;
 b=mDRO+eO+snREzrlmuI5wSbUxUvElzrZUPEJ31Ve4kEkCRDhd5+E3ObnWIHHtvTQTCsX3S5ovdxKULKw4t2UcQeNgkX9NtQVjDsJH/b4KUfG1Mlkqq/UcI2vxkOlYL5swsvR3x9i2QCQ7OCj4EvaiOpyH0u+6hWQr1FBvK/zrnJZzak25Iy6fLvHSoObETUqmX3X8IiTSfzWNKuwheR8ZQdFLl5v4RwgBkTudcSzmiTGVVoyDHHM0pSH1+1aq1PqVIbEltWVWiFBGfP+81ROyZRT3Zhnkvlb+vwAsr0S8ussdzy7wn83ibe3xV6YT1j6fLgAxP61Gka8OqaZ8tBEhXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by CH3PR11MB7761.namprd11.prod.outlook.com (2603:10b6:610:151::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 02:20:18 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::4075:1af2:9fc0:66d0%6]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 02:20:18 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "qiang.zhang1211@gmail.com" <qiang.zhang1211@gmail.com>
Subject: RE: [PATCH v2] srcu: Fix flush srcu structure's->sup work warning in
 cleanup_srcu_struct()
Thread-Topic: [PATCH v2] srcu: Fix flush srcu structure's->sup work warning in
 cleanup_srcu_struct()
Thread-Index: AQHZXYxAg4SDOY9oU0i85jFtcpQGKq8IoP4AgACPfdA=
Date:   Fri, 24 Mar 2023 02:20:18 +0000
Message-ID: <PH0PR11MB58803F01B73914E1D7A052F5DA849@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230323134621.336832-1-qiang1.zhang@intel.com>
 <f18cad71-38f0-411d-9dc7-bda52d1d5a3a@paulmck-laptop>
In-Reply-To: <f18cad71-38f0-411d-9dc7-bda52d1d5a3a@paulmck-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|CH3PR11MB7761:EE_
x-ms-office365-filtering-correlation-id: 64f81f53-4ada-4857-1aba-08db2c0e4fb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yw0m7viD+MF044r3eM0TcgRunpxDda5xGgJHkSPhq5wezfzbcjVYJujI/WLOQILqtWDXgZbpEuxZgZeNbg0RhOu9V1oapplrbtpvZweWPiqqNGLqhyJGrjYImISQtZB5ph7AIWHpHH/c/w5i+Im9jlTMsQtC50UDogeR83OF4nfhc/4M7aBMUbp+FDn28EvPJsMPKWQFtSiAYVvOzi/SS0yZBgIu+9JKtX6q/xXz7mVmk9Pj0osdg4X57PhA3EKxVKvYl7msm8/xnUYAQNiQdOz2qsATJx7cD3K3fUcp7Af++i6itAdpfdvogRen90nkkZXKsqDkBQGjsIvHTBek3CtGmQ524BEXdCwHE2h4ONlYnskt7puWqaJrDo8ge2kVV+xjrDpvjESj68EoTSgojkmJ7B4qTcZ1RHYRzap0/ZK3NOgRlibXeunTW9dzkJuChJiqithL9MkQkKUBUtmeTJxj6yQu2HkEh9eBvJUdXEojZZgoup00mXlgAe3AUT6qRfuSdJJemHUA3JBtiPB81T4KzZX1cIPtaT8ICFlP/elW/irLsq+95ixeD9/sBFBpLsCjnNIVqPd1JKqAwAOuGjUPg0O0dTFEUMS5ys0krNM5J/BOuN+oUYKrroiFNft7AUKOeUOcLjTcZuPVS8B46y4qXO7y5wcz3erUNTHCpU8vvktprN5jUbad++RAsRgFGir4cBhilgXUTfFUVKbK1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199018)(33656002)(41300700001)(66556008)(66476007)(66446008)(64756008)(4326008)(8676002)(76116006)(6916009)(66946007)(52536014)(8936002)(7696005)(45080400002)(316002)(478600001)(54906003)(5660300002)(2906002)(82960400001)(71200400001)(38070700005)(86362001)(55016003)(38100700002)(122000001)(186003)(83380400001)(9686003)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjhhRVBkWTB1eWZzNzFlMUdpUTJsYlhvK1JZYUdrYkVzc2lpdW9Na3hObS9J?=
 =?utf-8?B?MTVsZkN2WTh1bmhyRURlMXVKd2ZSUnc1LzcxVmdLRkw4YTlRQVlDUWdkTGdO?=
 =?utf-8?B?WjI0Z0xaSDMyVFZPdUNUU1ZTMGV2SS9xelBIWEVja0RTSUN2MFY5MlJmTG8w?=
 =?utf-8?B?WUtBZFp6SHlEUVd1TkkwUXhvblhqbVdCQUpiR1FPanQxMXEyU2g4c1VOdWJM?=
 =?utf-8?B?Vnl6bTBwTmErRVkveHNmR0c5WTVROE9RN3JydStyVHVTL3JBd0YxZWk3NVBv?=
 =?utf-8?B?S21jMlRTbXNYZzdlUkd6eGN6ZkN6Z2pOYjRscGRDRzN5Rk52bUVDOFZoK3h5?=
 =?utf-8?B?ZDZKcDg4ckY0V1NlejBwRFBOcGVnRnA1WHJjMjFaRzYwNWcrQlg0ejN0SHNi?=
 =?utf-8?B?K3lUTzhOTVB5MldxcXdQaGxRT1Z5NTRQQWV0REVzQVpuNUl0SGxOeDRhS0hp?=
 =?utf-8?B?S3pHUVNBM2hyQUZaMXhKTWg3d3A1dHJJQVBIclVZRjFsa1QvdWd0QWdyUUlN?=
 =?utf-8?B?SWJIOGlGTnVUNUZvMFUzNk5UTUtWeWo3eElFTWxvd3grTmY3WGk3dEM0OTJS?=
 =?utf-8?B?Q2w3Ym4zeXAxeHhWSnZ4N0FIak5oYU9DZXJMSGE5dmhiZHpRUldhNXByN0gx?=
 =?utf-8?B?NlhRU3RNdk10MjNCcFpzaTNOcUFlaUYvS0hHUDlMcVVpbzU0cU1FcVQ0dU5U?=
 =?utf-8?B?MWtSc2N1S3VKUnh0M3lBSmptWHFkUUpJemc5QWhsVVlQQjZweElJQlRnS05z?=
 =?utf-8?B?YVgyWWhIdmZ2cW93eDhpK1VVbHVwa3RVWWl2ekhGdUxYV3kwaVFMaS9oMkhz?=
 =?utf-8?B?WHJKV0J6MXhQVDZJNzhpbnYwYVlaK0Izd0UvQU95Y2QwQ0lZd3psSU9CK2hY?=
 =?utf-8?B?bk1pSm1WY2pnNWZTaHpkRWJYMWk2Tkl0aWZibnlSNUVaMkE2VExldmNYRUJl?=
 =?utf-8?B?KzRPWjRPaVJKVFFvNVJBT1BicXQrbU5FRFh6OExBZEVaNWNjM3d5aGJhbzZr?=
 =?utf-8?B?dUpaS3N1d1BLelQ0bDRMZHp2ZWpQNUNiMW5sN2JQNUYvbHBMeWcwRWdERk5Z?=
 =?utf-8?B?RDN0WXlIMDRKWmpWVXZQaGNkLytCWmdTUEE2Sy9rWSt1VFN5VG1oYzUvOURP?=
 =?utf-8?B?NlBFaU5qWDZQdkIzMDNYK3RDOU9RQVVpUnNNREZ0RDlPWUZYS0RsNkl5c25B?=
 =?utf-8?B?aFNKcHJKK2VsMmp2L1RIdU5XVTQydnBQZUl1ZzB3V2huUnRha3VYcDdMcTMx?=
 =?utf-8?B?SDhhRmxNVkUxelEwRFByVy9EbTFDQkoxcTdpZU1hZ0JEZ2YyZXV2d0lCenE4?=
 =?utf-8?B?cFkwNTZvYUZQbkxURUxuT2l4UnJVTDIvaCtYcjZkYUxQdGZGK1RMRU5pRUJJ?=
 =?utf-8?B?OURRRzZTU0ttbWpKK3VyWmZIOVFmbklJaWRZTVgvMUd0L3UyY1hLNVFYbXh5?=
 =?utf-8?B?YndRWU85UHBsYW80WG9nMVBFN2pxa0VudDZWQkgySXJjbXBOL0c1SDJxcnJ3?=
 =?utf-8?B?d09adUdVaXBSUUVTT1BoZDRudlVyRHlFcUZ5VjJLZldzMjZnT3NmaHl3ZDFX?=
 =?utf-8?B?V1ordDFlZUlFcStJMGJ2THlyWXBsL1AvQzRib1cwYllPOE1tTkgrdmRmVGda?=
 =?utf-8?B?Wkx3S251enJVaU0zVEJqRzdwN0tVampxWmt1NmYwZEpwN1pOVUpiUFlpN1o3?=
 =?utf-8?B?cFlnb1U3bnpxcFVBTS9nbU1CQThza2VHU293R3U3azVjNFRkdy9oRXMzUDN3?=
 =?utf-8?B?UUJyc0hGR2lXa3kyWlJLNGZUa2hXVFZ5Q2FhN3czK3QwNG5hMExYby92NGlv?=
 =?utf-8?B?WGRDUUphZlU5ZHc1dWsraFJYd0pCTjN2dytkT2QzdUYwOUhTN2ppcm5TTk9V?=
 =?utf-8?B?QjVBU3BZaHcvMEIzekE2NkRTY1N6WURocEZhc3Fyby9SQXJtR0RROGJCSkpk?=
 =?utf-8?B?b3VxN1J6RDhLT0p5cUhjQ1hvbWcrckRaeHpteVFXQzRwaXNjeTZMeDloOHUx?=
 =?utf-8?B?NUp3anVlT0duclFOblJ6ZzVzTERKelNUdkRtRTNZNUNlbkRwMERzRmRNZXp4?=
 =?utf-8?B?dUJCamJCQUp4SWdwVytDUW91WjByWUdZdjJRODRVbjZqQ1pvWHJrL0lzMEsx?=
 =?utf-8?Q?Qqyjg3mJyQ+Ej9TA9vBjNVXaP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f81f53-4ada-4857-1aba-08db2c0e4fb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 02:20:18.0668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2PRwrVq+gQDW2ObSa4QjdKZfLvJ3RaoslLqBJLQZJsqC1tRBdQ/C2zHQ/5ZK5bjIBYzBz3d2cHh/JfK1LdJ64g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7761
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2M6ICBteSBwZXJzb25hbCBlbWFpbCBxaWFuZy56aGFuZzEyMTFAZ21haWwuY29tDQoNCj4gV2hl
biB1bmxvYWRpbmcgcmN1dG9ydHVyZSBrbW9kIHdpbGwgdHJpZ2dlciB0aGUgZm9sbG93aW5nIGNh
bGxzdGFjazoNCj4gDQo+IGluc21vZCByY3V0b3J0dXJlLmtvDQo+IHJtbW9kIHJjdXRvcnR1cmUu
a28NCj4gDQo+IFsgIDIwOS40MzczMjddIFdBUk5JTkc6IENQVTogMCBQSUQ6IDUwOCBhdCBrZXJu
ZWwvd29ya3F1ZXVlLmM6MzE2NyBfX2ZsdXNoX3dvcmsrMHg1MGEvMHg1NDANCj4gWyAgMjA5LjQz
NzM0Nl0gTW9kdWxlcyBsaW5rZWQgaW46IHJjdXRvcnR1cmUoLSkgdG9ydHVyZSBbbGFzdCB1bmxv
YWRlZDogcmN1dG9ydHVyZV0NCj4gWyAgMjA5LjQzNzM4Ml0gQ1BVOiAwIFBJRDogNTA4IENvbW06
IHJtbW9kIFRhaW50ZWQ6IEcgIFcgIDYuMy4wLXJjMS15b2N0by1zdGFuZGFyZCsNCj4gWyAgMjA5
LjQzNzQwNl0gUklQOiAwMDEwOl9fZmx1c2hfd29yaysweDUwYS8weDU0MA0KPiAuLi4uLg0KPiBb
ICAyMDkuNDM3NzU4XSAgZmx1c2hfZGVsYXllZF93b3JrKzB4MzYvMHg5MA0KPiBbICAyMDkuNDM3
Nzc2XSAgY2xlYW51cF9zcmN1X3N0cnVjdCsweDY4LzB4MmUwDQo+IFsgIDIwOS40Mzc4MTddICBz
cmN1X21vZHVsZV9ub3RpZnkrMHg3MS8weDE0MA0KPiBbICAyMDkuNDM3ODU0XSAgYmxvY2tpbmdf
bm90aWZpZXJfY2FsbF9jaGFpbisweDlkLzB4ZDANCj4gWyAgMjA5LjQzNzg4MF0gIF9feDY0X3N5
c19kZWxldGVfbW9kdWxlKzB4MjIzLzB4MmUwDQo+IFsgIDIwOS40MzgwNDZdICBkb19zeXNjYWxs
XzY0KzB4NDMvMHg5MA0KPiBbICAyMDkuNDM4MDYyXSAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9o
d2ZyYW1lKzB4NzIvMHhkYw0KPiANCj4gZmx1c2hfZGVsYXllZF93b3JrKCkNCj4gLT5fX2ZsdXNo
X3dvcmsoKQ0KPiAgICAtPmlmIChXQVJOX09OKCF3b3JrLT5mdW5jKSkNCj4gICAgICAgICByZXR1
cm4gZmFsc2U7DQo+IA0KPiBGb3Igc3JjdSBvYmplY3RzIGRlZmluZWQgd2l0aCBERUZJTkVfU1JD
VSgpIG9yIERFRklORV9TVEFUSUNfU1JDVSgpLA0KPiB3aGVuIGNvbXBpbGluZyBhbmQgbG9hZGlu
ZyBhcyBtb2R1bGVzLCB0aGUgc3JjdV9tb2R1bGVfY29taW5nKCkgaXMNCj4gaW52b2tlZCwgYWxs
b2NhdGUgbWVtb3J5IGZvciBzcmN1IHN0cnVjdHVyZSdzLT5zZGEgYW5kIGluaXRpYWxpemUNCj4g
c2RhIHN0cnVjdHVyZSwgZHVlIHRvIG5vdCBmdWxseSBpbml0aWFsaXplIHNyY3Ugc3RydWN0dXJl
J3MtPnN1cCwNCj4gc28gYXQgdGhpcyB0aW1lIHRoZSBzdXAgc3RydWN0dXJlJ3MtPndvcmsud29y
ay5mdW5jIGlzIG51bGwsIGlmIG5vdA0KPiBpbnZva2UgaW5pdF9zcmN1X3N0cnVjdF9maWVsZHMo
KSBiZWZvcmUgdW5sb2FkaW5nIG1vZHVsZXMsIHRoZQ0KPiBfX2ZsdXNoX3dvcmsoKSBiZSBpbnZv
a2VkIGluIHNyY3VfbW9kdWxlX2dvaW5nKCkgYW5kIGZpbmQgd29yay0+ZnVuYw0KPiBpcyBlbXB0
eSwgd2lsbCByYWlzZSB0aGUgd2FybmluZyBhYm92ZS4NCj4gDQo+IFRoaXMgY29tbWl0IGFkZCB0
aGUgY2hlY2sgb2Ygc3JjdV9zdXAgc3RydWN0dXJlJ3MtPnNyY3VfZ3Bfc2VxX25lZWRlZA0KPiB0
byBkZXRlcm1pbmUgd2hldGhlciB0aGUgY2hlY2tfaW5pdF9zcmN1X3N0cnVjdCgpIGhhcyBiZWVu
IGludm9rZWQgdG8NCj4gaW5pdGlhbGl6ZSBzcmN1IG9iamVjdHMgaW4gc3JjdV9tb2R1bGVfZ29p
bmcoKSwgaWYgbm90IGluaXRpYWxpemUsIHRoZXJlDQo+IGFyZSBubyBwZW5kaW5nIG9yIHJ1bm5p
bmcgd29ya3MsIHNvIHRoZXJlIGlzIG5vIG5lZWQgdG8gZmx1c2gsIG9ubHkgaW52b2tlDQo+IGZy
ZWVfcGVyY3B1KCkgdG8gcmVsZWFzZSBzcmN1IHN0cnVjdHVyZSdzLT5zZGEuDQo+IA0KPiBDby1k
ZXZlbG9wZWQtYnk6IFBhdWwgRS4gTWNLZW5uZXkgPHBhdWxtY2tAa2VybmVsLm9yZz4NCj4NCj5U
aGFuayB5b3UgZm9yIHRoZSB0ZXN0aW5nLCBidWctZmluZGluZywgYW5kIHByb2JsZW0tc29sdmlu
ZyENCj4NCj5JbiB0aGVvcnksIHlvdSB3b3VsZCBuZWVkIGEgU2lnbmVkLW9mZi1ieSBoZXJlIGZy
b20gbWUgYXMgd2VsbCwgYnV0DQo+aW4gcHJhY3RpY2UgYmlzZWN0YWJpbGl0eSBtZWFucyB0aGF0
IHRoaXMgbXVzdCBiZSBmb2xkZWQgaW50byB0aGlzOg0KPg0KPmU3Yzc3ODQ4OTA0MCAoInNyY3U6
IFVzZSBzdGF0aWMgaW5pdCBmb3Igc3RhdGljYWxseSBhbGxvY2F0ZWQgaW4tbW9kdWxlIHNyY3Vf
c3RydWN0IikNCj4JDQo+VGhpcyB3aWxsIG9mIGNvdXJzZSBiZSB3aXRoIGF0dHJpYnV0aW9uLg0K
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBacWlhbmcgPHFpYW5nMS56aGFuZ0BpbnRlbC5jb20+DQo+DQo+
QnV0IHRoaXMgaXMgc3RpbGwgYSBiaXQgbW9yZSBjb21wbGV4IHRoYW4gbmVlZGVkLiAgSG93IGFi
b3V0IHNvbWV0aGluZw0KPmxpa2UgdGhpcz8NCg0KQWdyZWUsICBmcm9tIGEgbG9naWNhbCBwb2lu
dCBvZiB2aWV3LCB0aGlzIGlzIG1vcmUgcmlnb3JvdXPwn5iKLg0KDQpUaGFua3MNClpxaWFuZw0K
DQo+DQo+CQkJCQkJCVRoYW54LCBQYXVsDQo+DQo+LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+DQo+LyogSW5p
dGlhbGl6ZSBhbnkgZ2xvYmFsLXNjb3BlIHNyY3Vfc3RydWN0IHN0cnVjdHVyZXMgdXNlZCBieSB0
aGlzIG1vZHVsZS4gKi8NCj5zdGF0aWMgaW50IHNyY3VfbW9kdWxlX2NvbWluZyhzdHJ1Y3QgbW9k
dWxlICptb2QpDQo+ew0KPglpbnQgaTsNCj4Jc3RydWN0IHNyY3Vfc3RydWN0ICpzc3A7DQo+CXN0
cnVjdCBzcmN1X3N0cnVjdCAqKnNzcHAgPSBtb2QtPnNyY3Vfc3RydWN0X3B0cnM7DQo+DQo+CWZv
ciAoaSA9IDA7IGkgPCBtb2QtPm51bV9zcmN1X3N0cnVjdHM7IGkrKykgew0KPgkJc3NwID0gKihz
c3BwKyspOw0KPgkJc3NwLT5zZGEgPSBhbGxvY19wZXJjcHUoc3RydWN0IHNyY3VfZGF0YSk7DQo+
CQlpZiAoV0FSTl9PTl9PTkNFKCFzc3AtPnNkYSkpDQo+CQkJcmV0dXJuIC1FTk9NRU07DQo+CX0N
Cj4JcmV0dXJuIDA7DQo+fQ0KPg0KPi8qIENsZWFuIHVwIGFueSBnbG9iYWwtc2NvcGUgc3JjdV9z
dHJ1Y3Qgc3RydWN0dXJlcyB1c2VkIGJ5IHRoaXMgbW9kdWxlLiAqLw0KPnN0YXRpYyB2b2lkIHNy
Y3VfbW9kdWxlX2dvaW5nKHN0cnVjdCBtb2R1bGUgKm1vZCkNCj57DQo+CWludCBpOw0KPglzdHJ1
Y3Qgc3JjdV9zdHJ1Y3QgKnNzcDsNCj4Jc3RydWN0IHNyY3Vfc3RydWN0ICoqc3NwcCA9IG1vZC0+
c3JjdV9zdHJ1Y3RfcHRyczsNCj4NCj4JZm9yIChpID0gMDsgaSA8IG1vZC0+bnVtX3NyY3Vfc3Ry
dWN0czsgaSsrKSB7DQo+CQlzc3AgPSAqKHNzcHArKyk7DQo+CQlpZiAoIXJjdV9zZXFfc3RhdGUo
c21wX2xvYWRfYWNxdWlyZSgmc3NwLT5zcmN1X3N1cC0+c3JjdV9ncF9zZXFfbmVlZGVkKSkgJiYN
Cj4JCSAgICAhV0FSTl9PTl9PTkNFKCFzc3AtPnNyY3Vfc3VwLT5zZGFfaXNfc3RhdGljKSkNCj4J
CQkJY2xlYW51cF9zcmN1X3N0cnVjdChzc3ApOw0KPgkJZnJlZV9wZXJjcHUoc3NwLT5zZGEpOw0K
Pgl9DQo+fQ0K
