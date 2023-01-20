Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBD4674F46
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 09:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjATIT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 03:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjATIT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 03:19:26 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253664CE7C;
        Fri, 20 Jan 2023 00:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674202765; x=1705738765;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nTReJJ78/Xq/IW+O6fKE+/sQLK86z24YfBGWBKEDFQM=;
  b=Dn//rVzKGg8GGjJSIqwf8FFJBLHQturRYXq/sIsBoZPw7nPm9uf0W5mm
   dGIV2dHypZLZOFFAYTz75Nv++fl2pwyT6hF7cELuOSYHrgPz/fbqgCZOf
   cNKs4ZfnmC9zI8SlwBaKKZ6K4qS/vXHWi2IMRFAdfjM7+Co62yaRGEqQm
   OM0jPoQftbH87lgD0BReXGTJ3I207RZoP7/70lEb9kYDczTzoCVppGYqq
   2yAdEZyP3SMU5ihFTiPCJc6b+PVzPhlNtWKTzLdUrMNU2GitnMjXnAA+h
   hCxGW/Sjul+rivcTfBMz4Fm2ys0JghZD4WNLD8yPdulzmjjXfkToS87hO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="411762985"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="411762985"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 00:19:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="653717171"
X-IronPort-AV: E=Sophos;i="5.97,231,1669104000"; 
   d="scan'208";a="653717171"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 20 Jan 2023 00:19:23 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 00:19:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 00:19:22 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 20 Jan 2023 00:19:22 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 20 Jan 2023 00:19:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ou1nk8JDQNy1g6rj/AvTDDRNpC/xYHdqmT0AYiyajOtKIB26vUN8GG7ZDrns5xAl4I4lTgWit0/i2txxv61Lf+Cl0svz+lQwomhOe7UbptZRKjXmYzSuATRXcn1LVmHQq7xkX0wC1v/6tJMfZiv6Jz3xrSmht7V/UNiccDFh1qp0kMQKY+a3yuA+xiNzVtWOEBbwrzziKlgfkcZPZkPHKXFK/0bBm7OtH9MiEyk81FhG49QZ4VQMwGRnNMwgKBLC0JimktmY8dq+o/hFcKXkYR0xpa8LJx8W2T8oPlrPdw4l83pp7/D1ghJKM3KHfh+LQwJZ/W7PApy9aKmcJLuRsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTReJJ78/Xq/IW+O6fKE+/sQLK86z24YfBGWBKEDFQM=;
 b=M0yJhgiYn5u0+BIoKroMwqtymJbRlTdDVZW15H62a5KdNmPKeYUxjbMh5N5dFv4ao6VFQ+C/1UcXnqaLZ/JkhkJmEEcYhLFA9H1jIOK2ZHPs5bQS72gKjOF/hL0tDiGP8OyBiMhhaZhCW/pAbj2ep9SpnlzCdHuJ8s+kvKt+3yKmGlw+7pmolwVGmM0powtfEkYVbFZ93z09vEyGC69TxN4TZbzqwuUx5AtxnQB5zS3CaSB1DKfCeb4oGyRz3tVTbm6EyZW4vR2RvupdSuKFg2mLKqvRjuTGPahJNC2xurumt7oqw/DPIboOAJklQ0Mcb10FgeTWwsOIjhDkk1IFxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by IA1PR11MB8223.namprd11.prod.outlook.com (2603:10b6:208:450::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 20 Jan
 2023 08:19:18 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018%5]) with mapi id 15.20.6002.027; Fri, 20 Jan 2023
 08:19:18 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>
CC:     "Paul E. McKenney" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] rcu: Remove impossible wakeup rcu GP kthread action
 from rcu_report_qs_rdp()
Thread-Topic: [PATCH v3] rcu: Remove impossible wakeup rcu GP kthread action
 from rcu_report_qs_rdp()
Thread-Index: AQHZKxIPnor+2NW260uOVFogeINpU66keT4AgAIrWoCAAAaHkIAAEYQAgAA0PCA=
Date:   Fri, 20 Jan 2023 08:19:18 +0000
Message-ID: <PH0PR11MB5880A16045A842AB80A25C4BDAC59@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230118073014.2020743-1-qiang1.zhang@intel.com>
 <20230118180714.GD2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y8oHL0uuSEef5aiI@google.com>
 <PH0PR11MB5880980194CEA45416325716DAC59@PH0PR11MB5880.namprd11.prod.outlook.com>
 <CAEXW_YQKhr6y+R+2a_Z8WG8+BuNT4jMP8eAepO0Z-apU2a_ibw@mail.gmail.com>
In-Reply-To: <CAEXW_YQKhr6y+R+2a_Z8WG8+BuNT4jMP8eAepO0Z-apU2a_ibw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|IA1PR11MB8223:EE_
x-ms-office365-filtering-correlation-id: f272eef0-155d-4460-babc-08dafabf06e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t9fiFFvLeiIKiD5Y0O+Y9HiRCK6k8E3BIqYoBdS2Ng8k7GHO02Dv2k8yRjCl5KE06bJo7rmgNjuLGeGemXj7qKOViuMWnr0rUjL1IxStzjdV8uQ4QmOC9fl0uMw0cttuydPLNmc5ElAMRYPcrlA3B02vVwdxO2HgyyAy+HtjqZhm1oj0c2OGlQGP5d/aaLBT8AcEAYAGuVuuhdNzpz5Hy45O6SIWkpA+jbr5VrOWf3d2Lz3ybF9uxc19A0ohcLvBaQPncA4uv8J2TVLOox5GDpn2AXuAM5qwODPWGBD7dKw1uuykQYXCpBl7Ma3cc0Q0FjpxQVCkKJkTpU0krcaRSWZBrC7A9KlQ3Hkpthy+W9vQRWfs7HZ8iwDH6S8sBWs8+EmQy7pwtlFNP08OS87yBLfcOTaY60nRu5Cyv+AWp8tmH/YBxVvor6fFHGynIVDfzzbYx5FNECyWBcRqj9T1aMq80eZbhtmUzS7ulMELQe/cs34W4ggbYZO0//+1COnjScLsRUT+5wf0h8GfwnAlrcRGUty4ynTGLQyUVf8LNuyh8jCdU56zQZa5mYwAGntvmL9DS8XfV8T1wBmdylTXEJ/D5swXmBOkfTRsZSGerY+m3RMe3a+dJKL6Sf8p+ItzMkksfYJOaVEvDe0vSUlJBLlgI+vScqH0xWv6h2H/0oBn++XOyL3xpMcrr0zr8Wy3O/cFyxXkrZ7oTRqoeNrcEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199015)(86362001)(9686003)(66574015)(66446008)(66556008)(26005)(64756008)(33656002)(6916009)(8676002)(186003)(76116006)(66476007)(4326008)(41300700001)(6506007)(478600001)(83380400001)(2906002)(54906003)(38070700005)(122000001)(316002)(38100700002)(71200400001)(7696005)(8936002)(52536014)(5660300002)(82960400001)(55016003)(66946007)(66899015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlVlNTVPSlRPQzVDamR3ZzA3ajMrZmlweVpublpvaHRhaUdpbE9FKytCRkNp?=
 =?utf-8?B?eXpuUTlxYkh3VXNOcStWRlA3VlpZdWtXYnluL04zTXZoRDY2Y3pXcEgrT3U0?=
 =?utf-8?B?MXF4aXRnUDhmMk0xemFNLzRkSEJSSzJRZ0hCV1M3YjZCQmZaaVZLMVZQVXgv?=
 =?utf-8?B?cm5XdWdlVGdXZU0zNW81amhSVVRlWjZQU2VCUzNLNlE2MGVUM1JiMmdyS09M?=
 =?utf-8?B?WWpNcEp1OHhkenZycGFjalR5bXlBdFQzczlpeTRKeXFmMlp6WjFBWkJPVVVw?=
 =?utf-8?B?dlViVytvcWJMQm5FaFoxczdhVEI3ZnpFU1d6Q0JOT0JmVlVqQmlvbnJPR1ly?=
 =?utf-8?B?WWVQenlZRlowZlpkeEFNMnBFWEw2RVFEU1phdXR5Q0tmcGFYYWFpYUJ2c2Fj?=
 =?utf-8?B?czBSOWQ1L0c0bmZvMDY3VWV6bnZnSFVPc2M2SXl0WTlua2NxRmZFaG5oZm1O?=
 =?utf-8?B?aDBuTjdCMml1ZlliczgwcWh1SytxUGxSWmdVV0l6anRzRDh5N08yZWRJN09E?=
 =?utf-8?B?eGlmc3VnVU1IVUZhaWplWFBhNGJiVyt2enUvZityQ0Z5TTZoQ3Q0dC8rQlM3?=
 =?utf-8?B?R2NaQVkzRG16R0hudU9zOFBnV1pjU0k3VzEraHliem9NbnRzRzRCMTZnVnY4?=
 =?utf-8?B?ODM2cnU5RUxXOC83WmVyczlxN1VyTkdPYkI1VG9mbnlKSmlJaXVTMjg1ais3?=
 =?utf-8?B?U3FCeUZFVVFwNlJhSkE4UFNyK1N6a29TZlphc1ExS2laak8yYllYMnYrbm1j?=
 =?utf-8?B?ajhVaElhWVF2K3dnN21FclJ1N2dPUGw2M0lhMVFyY0w1b2RpTHY2empQWVNi?=
 =?utf-8?B?dE1yQUM3VjZBaW0rRUkzRW9KdHFaNjdRWEl2VlFCWmNBZHB3dU45NExDODMz?=
 =?utf-8?B?NHdNeXZqN011c0pGanB5ZytkNWFaYVJMYVk4WVQvVExzUzZhMVU3cm10TTM1?=
 =?utf-8?B?eE1DOEpQelVzdlZYZTFRck9ZSWE5bUhuK2YwM2hiM1FTbXhwTVdxaHZIUjRs?=
 =?utf-8?B?YTBtWHQxbDFwV1NncU5OV2VCMHgxSTFIWEVJVWNja0xjT3dYUmQ3MU15VmRv?=
 =?utf-8?B?eDJzZVdUeW40NDhBVnROOFFFcEJGUlpjQjcwZUJvTSt3VjI0SkkwalZ2K2Vl?=
 =?utf-8?B?UWN4QXRRN2tycjV3NTlhemVKY1A4WmQraXBxSGYybi9YOG4xb3VGcWZRR3k1?=
 =?utf-8?B?NjFnaHdmSHo2SUZLR0lWNXpnY0puU1NobFVoVnVYelNmZXJZRmxKVnUxTnB3?=
 =?utf-8?B?djRsYkFaT2ljRTJOU3hFV0JuTTEvVFVsOXFNR1FVcjdYR0QwOHdTTFQ3TVZJ?=
 =?utf-8?B?S1dzTVJKZitqaG01bkhSN2JBMlRQaFN1czBJL2svQUw3N0RuZHkwQ3pzK2pv?=
 =?utf-8?B?dGF1aFNCcHc0VjlNcGNBdHU2WE95Z2FsK1A1SmVlUExWNUVsN3pOUXdFdjNs?=
 =?utf-8?B?SDRnVWdEcTMvNlpweFFCWlQvK2FIa0VWU05LaTQ4Nzl1bEYxMVlZa3F3aC9Y?=
 =?utf-8?B?d2x3Q0cxMjJTWVBieG53M1lPYlF5cG1MTHFQOGg2KzNhYVZ1Ym1xUXRhU051?=
 =?utf-8?B?NkdJbUNnVElVazZkcXYxcXh1YUZZWFBOUGhBdWxsTDZaQjFTSFNhbkIxak1W?=
 =?utf-8?B?QjFnc3lzVjJ4V1JjbVNOU2ZsbVRwcGR5OWxRMVdpcFQrcis4aW9DY1ZvdHZE?=
 =?utf-8?B?MWMydEk5QmU4U2IyOUsySktLZHJBZVNBV2pqd1Q2ZGdDWG5NZmhoWno4THlJ?=
 =?utf-8?B?cUVLclIzQzIwd2V6OWIvZ0h1M0Q5T2QyOWNqRFh3dGI4LzBoMjQzU3VwNy8w?=
 =?utf-8?B?di9XMHYrY2N2OU5aZ0F2MXV6NVlRYXUvWHNFd2l6aENndHNpdEhEV1dldTdM?=
 =?utf-8?B?dHdQcmhUK1JBUm41NS9jVldHK1h2N0tKRHhrTU54Q1VxWlRtL3grYTBXcjc1?=
 =?utf-8?B?QlhHcVNKSFBtMGs0UEJBbU54SklkMFpadjF0d083R2tXbVZRdXdKcnZFRDRV?=
 =?utf-8?B?Z0NnT1o1OWI2cWhrVTBnNVpQMC9EK25qUDd4ZVR1Z3hnamVoamZNZkVqanVD?=
 =?utf-8?B?eFBEZG11UVpwTXVVOEN3RkJPNWVIb0VpOG1sM3hPZk5JT3NVVzExVjJBaG9W?=
 =?utf-8?Q?5Kdyx5X11g6xBNIubH1HFzmfI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f272eef0-155d-4460-babc-08dafabf06e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2023 08:19:18.7712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1qYTtpvylWNaRVmekqhSUCH6Y7aEi6DJ8HZd37HmIpXXH9HHeYIBGCNAj0qiDcN/RnWZBQigLOqg7XdPclidHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8223
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pg0KPiA+IE9uIFdlZCwgSmFuIDE4LCAyMDIzIGF0IDAzOjMwOjE0UE0gKzA4MDAsIFpxaWFuZyB3
cm90ZToNCj4gPiA+IFdoZW4gaW5vdmtlIHJjdV9yZXBvcnRfcXNfcmRwKCksIGlmIGN1cnJlbnQg
Q1BVJ3MgcmN1X2RhdGEgc3RydWN0dXJlJ3MgLT4NCj4gPiA+IGdycG1hc2sgaGFzIG5vdCBiZWVu
IGNsZWFyZWQgZnJvbSB0aGUgY29ycmVzcG9uZGluZyByY3Vfbm9kZSBzdHJ1Y3R1cmUncw0KPiA+
ID4gLT5xc21hc2ssIGFmdGVyIHRoYXQgd2lsbCBjbGVhciBhbmQgcmVwb3J0IHF1aWVzY2VudCBz
dGF0ZSwgYnV0IGluIHRoaXMNCj4gPiA+IHRpbWUsIHRoaXMgYWxzbyBtZWFucyB0aGF0IGN1cnJl
bnQgZ3JhY2UgcGVyaW9kIGlzIG5vdCBlbmQsIHRoZSBjdXJyZW50DQo+ID4gPiBncmFjZSBwZXJp
b2QgaXMgb25nb2luZywgYmVjYXVzZSB0aGUgcmN1X2dwX2luX3Byb2dyZXNzKCkgY3VycmVudGx5
IHJldHVybg0KPiA+ID4gdHJ1ZSwgc28gZm9yIG5vbi1vZmZsb2FkZWQgcmRwLCBpbnZva2UgcmN1
X2FjY2VsZXJhdGVfY2JzKCkgaXMgaW1wb3NzaWJsZQ0KPiA+ID4gdG8gcmV0dXJuIHRydWUuDQo+
ID4gPg0KPiA+ID4gVGhpcyBjb21taXQgdGhlcmVmb3JlIHJlbW92ZSBpbXBvc3NpYmxlIHJjdV9n
cF9rdGhyZWFkX3dha2UoKSBjYWxsaW5nLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFpx
aWFuZyA8cWlhbmcxLnpoYW5nQGludGVsLmNvbT4NCj4gPiA+IFJldmlld2VkLWJ5OiBGcmVkZXJp
YyBXZWlzYmVja2VyIDxmcmVkZXJpY0BrZXJuZWwub3JnPg0KPiA+DQo+ID4gUXVldWVkICh3b3Jk
c21pdGhlZCBhcyBzaG93biBiZWxvdywgYXMgYWx3YXlzLCBwbGVhc2UgY2hlY2spIGZvciBmdXJ0
aGVyDQo+ID4gdGVzdGluZyBhbmQgcmV2aWV3LCB0aGFuayB5b3UgYm90aCENCj4gPg0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFRoYW54
LCBQYXVsDQo+ID4NCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPg0KPiA+IGNvbW1pdCBmYmUzZTMw
MGVjOGIzZWRkMmI4Zjg0ZGFiNGRjOTg5NDdjZjcxZWI4DQo+ID4gQXV0aG9yOiBacWlhbmcgPHFp
YW5nMS56aGFuZ0BpbnRlbC5jb20+DQo+ID4gRGF0ZTogICBXZWQgSmFuIDE4IDE1OjMwOjE0IDIw
MjMgKzA4MDANCj4gPg0KPiA+ICAgICByY3U6IFJlbW92ZSBuZXZlci1zZXQgbmVlZHdha2UgYXNz
aWdubWVudCBmcm9tIHJjdV9yZXBvcnRfcXNfcmRwKCkNCj4gPg0KPiA+ICAgICBUaGUgcmN1X2Fj
Y2VsZXJhdGVfY2JzKCkgZnVuY3Rpb24gaXMgaW52b2tlZCBieSByY3VfcmVwb3J0X3FzX3JkcCgp
DQo+ID4gICAgIG9ubHkgaWYgdGhlcmUgaXMgYSBncmFjZSBwZXJpb2QgaW4gcHJvZ3Jlc3MgdGhh
dCBpcyBzdGlsbCBibG9ja2VkDQo+ID4gICAgIGJ5IGF0IGxlYXN0IG9uZSBDUFUgb24gdGhpcyBy
Y3Vfbm9kZSBzdHJ1Y3R1cmUuICBUaGlzIG1lYW5zIHRoYXQNCj4gPiAgICAgcmN1X2FjY2VsZXJh
dGVfY2JzKCkgc2hvdWxkIG5ldmVyIHJldHVybiB0aGUgdmFsdWUgdHJ1ZSwgYW5kIHRodXMgdGhh
dA0KPiA+ICAgICB0aGlzIGZ1bmN0aW9uIHNob3VsZCBuZXZlciBzZXQgdGhlIG5lZWR3YWtlIHZh
cmlhYmxlIGFuZCBpbiB0dXJuIG5ldmVyDQo+ID4gICAgIGludm9rZSByY3VfZ3Bfa3RocmVhZF93
YWtlKCkuDQo+ID4NCj4gPiAgICAgVGhpcyBjb21taXQgdGhlcmVmb3JlIHJlbW92ZXMgdGhlIG5l
ZWR3YWtlIHZhcmlhYmxlIGFuZCB0aGUgaW52b2NhdGlvbg0KPiA+ICAgICBvZiByY3VfZ3Bfa3Ro
cmVhZF93YWtlKCkgaW4gZmF2b3Igb2YgYSBXQVJOX09OX09OQ0UoKSBvbiB0aGUgY2FsbCB0bw0K
PiA+ICAgICByY3VfYWNjZWxlcmF0ZV9jYnMoKS4gIFRoZSBwdXJwb3NlIG9mIHRoaXMgbmV3IFdB
Uk5fT05fT05DRSgpIGlzIHRvDQo+ID4gICAgIGRldGVjdCBzaXR1YXRpb25zIHdoZXJlIHRoZSBz
eXN0ZW0ncyBvcGluaW9uIGRpZmZlcnMgZnJvbSBvdXJzLg0KPiA+DQo+ID4gICAgIFNpZ25lZC1v
ZmYtYnk6IFpxaWFuZyA8cWlhbmcxLnpoYW5nQGludGVsLmNvbT4NCj4gPiAgICAgUmV2aWV3ZWQt
Ynk6IEZyZWRlcmljIFdlaXNiZWNrZXIgPGZyZWRlcmljQGtlcm5lbC5vcmc+DQo+ID4gICAgIFNp
Z25lZC1vZmYtYnk6IFBhdWwgRS4gTWNLZW5uZXkgPHBhdWxtY2tAa2VybmVsLm9yZz4NCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9rZXJuZWwvcmN1L3RyZWUuYyBiL2tlcm5lbC9yY3UvdHJlZS5jDQo+
ID4gaW5kZXggYjJjMjA0NTI5NDc4MC4uN2EzMDg1YWQwYTdkZiAxMDA2NDQNCj4gPiAtLS0gYS9r
ZXJuZWwvcmN1L3RyZWUuYw0KPiA+ICsrKyBiL2tlcm5lbC9yY3UvdHJlZS5jDQo+ID4gQEAgLTE5
NTYsNyArMTk1Niw2IEBAIHJjdV9yZXBvcnRfcXNfcmRwKHN0cnVjdCByY3VfZGF0YSAqcmRwKQ0K
PiA+ICB7DQo+ID4gICAgICAgdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPiAgICAgICB1bnNpZ25l
ZCBsb25nIG1hc2s7DQo+ID4gLSAgICAgYm9vbCBuZWVkd2FrZSA9IGZhbHNlOw0KPiA+ICAgICAg
IGJvb2wgbmVlZGFjYyA9IGZhbHNlOw0KPiA+ICAgICAgIHN0cnVjdCByY3Vfbm9kZSAqcm5wOw0K
PiA+DQo+ID4gQEAgLTE5ODgsNyArMTk4NywxMiBAQCByY3VfcmVwb3J0X3FzX3JkcChzdHJ1Y3Qg
cmN1X2RhdGEgKnJkcCkNCj4gPiAgICAgICAgICAgICAgICAqIE5PQ0Iga3RocmVhZHMgaGF2ZSB0
aGVpciBvd24gd2F5IHRvIGRlYWwgd2l0aCB0aGF0Li4uDQo+ID4gICAgICAgICAgICAgICAgKi8N
Cj4gPiAgICAgICAgICAgICAgIGlmICghcmN1X3JkcF9pc19vZmZsb2FkZWQocmRwKSkgew0KPiA+
IC0gICAgICAgICAgICAgICAgICAgICBuZWVkd2FrZSA9IHJjdV9hY2NlbGVyYXRlX2NicyhybnAs
IHJkcCk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIC8qDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAqIFRoZSBjdXJyZW50IEdQIGhhcyBub3QgeWV0IGVuZGVkLCBzbyBpdA0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgKiBzaG91bGQgbm90IGJlIHBvc3NpYmxlIGZvciByY3VfYWNj
ZWxlcmF0ZV9jYnMoKQ0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgKiB0byByZXR1cm4gdHJ1
ZS4gIFNvIGNvbXBsYWluLCBidXQgZG9uJ3QgYXdha2VuLg0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgKi8NCj4gPiArICAgICAgICAgICAgICAgICAgICAgV0FSTl9PTl9PTkNFKHJjdV9hY2Nl
bGVyYXRlX2NicyhybnAsIHJkcCkpOw0KPiA+ICAgICAgICAgICAgICAgfSBlbHNlIGlmICghcmN1
X3NlZ2NibGlzdF9jb21wbGV0ZWx5X29mZmxvYWRlZCgmcmRwLT5jYmxpc3QpKSB7DQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgIC8qDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAqIC4uLmJ1
dCBOT0NCIGt0aHJlYWRzIG1heSBtaXNzIG9yIGRlbGF5IGNhbGxiYWNrcyBhY2NlbGVyYXRpb24N
Cj4gPiBAQCAtMjAwMCw4ICsyMDA0LDYgQEAgcmN1X3JlcG9ydF9xc19yZHAoc3RydWN0IHJjdV9k
YXRhICpyZHApDQo+ID4gICAgICAgICAgICAgICByY3VfZGlzYWJsZV91cmdlbmN5X3Vwb25fcXMo
cmRwKTsNCj4gPiAgICAgICAgICAgICAgIHJjdV9yZXBvcnRfcXNfcm5wKG1hc2ssIHJucCwgcm5w
LT5ncF9zZXEsIGZsYWdzKTsNCj4gPiAgICAgICAgICAgICAgIC8qIF5eXiBSZWxlYXNlZCBybnAt
PmxvY2sgKi8NCj4gPiAtICAgICAgICAgICAgIGlmIChuZWVkd2FrZSkNCj4gPiAtICAgICAgICAg
ICAgICAgICAgICAgcmN1X2dwX2t0aHJlYWRfd2FrZSgpOw0KPiA+DQo+ID5BRkFJQ1MsIHRoZXJl
IGlzIGFsbW9zdCBubyBjb21waWxlciBiZW5lZml0IG9mIGRvaW5nIHRoaXMsIGFuZCB6ZXJvIHJ1
bnRpbWUNCj4gPmJlbmVmaXQgb2YgZG9pbmcgdGhpcy4gVGhlIFdBUk5fT05fT05DRSgpIGFsc28g
aW52b2x2ZXMgYSBydW50aW1lIGNvbmRpdGlvbg0KPiA+Y2hlY2sgb2YgdGhlIHJldHVybiB2YWx1
ZSBvZiByY3VfYWNjZWxlcmF0ZV9jYnMoKSwgc28geW91IHN0aWxsIGhhdmUgYQ0KPiA+YnJhbmNo
LiBZZXMsIG1heWJlIHNsaWdodGx5IHNtYWxsZXIgY29kZSB3aXRob3V0IHRoZSB3YWtlIGNhbGws
IGJ1dCBJJ20gbm90DQo+ID5zdXJlIHRoYXQgaXMgd29ydGggaXQuDQo+ID4NCj4gPkFuZCwgaWYg
dGhlIG9waW5pb24gb2Ygc3lzdGVtIGRpZmZlcnMsIGl0cyBhIGJ1ZyBhbnl3YXksIHNvIG1vcmUg
YWRkZWQgcmlzay4NCj4gPg0KPiA+DQo+ID4NCj4gPiAgICAgICAgICAgICAgIGlmIChuZWVkYWNj
KSB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgIHJjdV9ub2NiX2xvY2tfaXJxc2F2ZShyZHAs
IGZsYWdzKTsNCj4gPg0KPiA+QW5kIHdoZW4gbmVlZGFjYyA9IHRydWUsIHJjdV9hY2NlbGVyYXRl
X2Nic191bmxvY2tlZCgpIHRyaWVzIHRvIGRvIGEgd2FrZSB1cA0KPiA+YW55d2F5LCBzbyBpdCBp
cyBjb25zaXN0ZW50IHdpdGggbm9jYiB2cyAhbm9jYi4NCj4NCj4gRm9yICFub2NiLCB3ZSBpbnZv
a2VkIHJjdV9hY2NlbGVyYXRlX2NicygpIGJlZm9yZSByZXBvcnQgcXMsICBzbyB0aGlzIEdQIGlz
IGltcG9zc2libGUgdG8gZW5kDQo+IGFuZCB3ZSBhbHNvIG5vdCBzZXQgUkNVX0dQX0ZMQUdfSU5J
VCB0byBzdGFydCBuZXcgR1AgaW4gcmN1X2FjY2VsZXJhdGVfY2JzKCkuDQo+IGJ1dCBmb3Igbm9j
Yiwgd2hlbiBuZWVkYWNjID0gdHJ1ZSwgd2UgaW52b2tlIHJjdV9hY2NlbGVyYXRlX2Nic191bmxv
Y2tlZCgpIGFmdGVyIGN1cnJlbnQgQ1BVDQo+IGhhcyByZXBvcnRlZCBxcywgIGlmIGFsbCBDUFUg
aGF2ZSBiZWVuIHJlcG9ydGVkIHFzLCAgd2Ugd2lsbCB3YWtldXAgZ3Aga3RocmVhZCB0byBlbmQg
dGhpcyBHUCBpbg0KPiByY3VfcmVwb3J0X3FzX3JucCgpLiAgIGFmdGVyIHRoYXQsIHRoZSByY3Vf
YWNjZWxlcmF0ZV9jYnNfdW5sb2NrZWQoKSBpcyAgcG9zc2libGUgdG8gdHJ5IHRvIHdha2UgdXAN
Cj4gZ3Aga3RocmVhZCBpZiB0aGlzIEdQIGhhcyBlbmRlZCBhdCB0aGlzIHRpbWUuICAgc28gbm9j
YiB2cyAhbm9jYiBpcyBsaWtlbHkgdG8gYmUgaW5jb25zaXN0ZW50Lg0KPg0KPg0KPlRoYXQgaXMg
YSBmYWlyIHBvaW50LiBCdXQgYWZ0ZXIgZ3AgZW5kcywgIHJjdV9jaGVja19xdWllc2NlbnRfc3Rh
dGUoKQ0KPi0+IG5vdGVfZ3BfY2hhbmdlcygpIHdoaWNoIHdpbGwgZG8gYSBhY2NlbCArIEdQIHRo
cmVhZCB3YWtlIHVwIGF0IHRoYXQNCj5wb2ludCBhbnl3YXksIG9uY2UgaXQgbm90aWNlcyB0aGF0
IGEgR1AgaGFzIGNvbWUgdG8gYW4gZW5kLiBUaGF0DQo+c2hvdWxkIGhhcHBlbiBmb3IgYm90aCB0
aGUgbm9jYiBhbmQgIW5vY2IgY2FzZXMgcmlnaHQ/DQoNCkZvciBub2NiIHJkcCwgd2Ugd29uJ3Qg
aW52b2tlIHJjdV9hY2NlbGVyYXRlX2NicygpIGFuZCByY3VfYWR2YW5jZV9jYnMoKSBpbg0Kbm90
ZV9ncF9jaGFuZ2VzKCkuICBzbyBhbHNvIG5vdCB3YWtldXAgZ3Aga3RocmVhZCBpbiBub3RlX2dw
X2NoYW5nZXMoKS4gDQoNCj4NCj5JIGFtIHdvbmRlcmluZyBpZiByY3VfcmVwb3J0X3FzX3JkcCgp
IG5lZWRzIHRvIGJlIHJldGhvdWdodCB0byBtYWtlDQo+Ym90aCBjYXNlcyBjb25zaXN0ZW50Lg0K
Pg0KPldoeSBkb2VzIHRoZSBub2NiIGNhc2UgbmVlZCBhbiBhY2NlbCArIEdQIHRocmVhZCB3YWtl
dXAgaW4gdGhlDQo+cmN1X3JlcG9ydF9xc19yZHAoKSBmdW5jdGlvbiwgYnV0IHRoZSAhbm9jYiBj
YXNlIGRvZXMgbm90Pw0KDQpGb3Igbm9jYiBhY2NlbCArIEdQIGt0aHJlYWQgd2FrZXVwIG9ubHkg
aGFwcGVuIGluIHRoZSBtaWRkbGUgb2YgYSAoZGUtKW9mZmxvYWRpbmcgcHJvY2Vzcy4NCnRoaXMg
aXMgYW4gaW50ZXJtZWRpYXRlIHN0YXRlLg0KCQ0KVGhhbmtzDQpacWlhbmcNCg0KPg0KPihJIGFt
IG91dCBvZiBvZmZpY2UgdGlsbCBNb25kYXkgYnV0IHdpbGwgaW50ZXJtaXR0ZW50bHkgKG1heWJl
KSBjaGVjaw0KPmluLCBSQ1UgaXMgb25lIG9mIHRob3NlIHRoaW5ncyB0aGF0IGRheWRyZWFtaW5n
IHRlbmRzIHRvIGxlbmQgaXRzZWxmDQo+dG8uLi4pDQo+DQo+IC0gSm9lbA0K
