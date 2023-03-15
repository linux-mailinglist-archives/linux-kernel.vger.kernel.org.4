Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB24D6BB5C9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbjCOOSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjCOOR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:17:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740D77EC7;
        Wed, 15 Mar 2023 07:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678889868; x=1710425868;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MwlU9cJsbnhxEtbLYw963AqfJ/GhW3FJ3jNPjFpAkGs=;
  b=Gqlip7uBqwVrC8jT59fdGGalmXU/RihbvY8uDxvprzTBmCj43tU3mU5q
   31esWgNYQ9fma4ZXJ2XE7yRnOHVQPExAtu+Usovgdx8tByla6D9lcCyCS
   Qv6fRf4EE6ZVN26YqJjNtV14gko54GXR1UEWqxmxD0XIYu4YOUB6cQfFL
   27+ilv0FDw7CTQ7UpddxXnWG0qJsKsf8NVdfYAFU8Yug811WpSmZCat+K
   5l/WeY1b2leD6Ue7yw3tpOOrpts1WXHzNHm2IfUn2l4cQUVHeNVcLP1Td
   EB+gAHXhnCUyv61jyk775eswTLM/WvL5p3/Bj3DaBvD+FE5hxLnwVDuyr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="326072852"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="326072852"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 07:17:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="789806761"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="789806761"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 15 Mar 2023 07:17:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 07:17:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 07:17:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 15 Mar 2023 07:17:44 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 15 Mar 2023 07:17:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tw6+y1hmpP0ulm40Hh+hxIH2ykWathBUWa6L4/04tLVDn3LCfn4ZBkP9lbqSG3xI0uf7znGm/+pknYDzhyAFeRx34gLdYQIUKjqGCNkKRd4Epxq27U6m+D9txjHu/C0uUaednriYsfJduEsrT+5auOZQFxc+ellT+6Hm8XQz2q8KPBFwXQHJ3HwBP4lUSkzX8+Qmi/JrzHVfArA7AZF6QaI9sMmid0Ls4Roel9gzlXIkDfd8x6J37JZWjexgfxLj1ZOp2pj61XLQZBEDzJ8eqinqaZ4KHzQev62nuuLXKhAwqVZ95Z1mLWQiYSiZFn2x/DjmX/2tg6GVF8NfEwnA0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwlU9cJsbnhxEtbLYw963AqfJ/GhW3FJ3jNPjFpAkGs=;
 b=XEJV0cEk4CnS0KTSdkPRp51JwR81VEWKZNaeUUSz8aoMS2uIgixppwnJzpdIGZQ779QMcDZtEazUMrP1T5uOhIH+hCKFNnB18bGW1myOkbghLt/PgXu5Ks3ONIIKU4oXTrIr7GfJPCm9C0DlPD4Xl+zEdd0rMAxQZbgiCPsGmcaQnXEN9dyTzV3F2KB39SHMQB14NJGPQ1HvUWN8CL5ulT1XlIv6u2oA7lPsjM/GLPfllZ15PAQjiyiN/9N/m1HgoaeO+/vegGnblG8a43d8vl8lb/5ouY6O8abM+07oVaCPzLvAxhNGf58pizq2hQsCAwKHLPjyKlDoVq9ni+bXig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13)
 by PH8PR11MB6660.namprd11.prod.outlook.com (2603:10b6:510:1c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 14:17:40 +0000
Received: from IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::2aed:1a72:b351:1601]) by IA1PR11MB6171.namprd11.prod.outlook.com
 ([fe80::2aed:1a72:b351:1601%9]) with mapi id 15.20.6178.026; Wed, 15 Mar 2023
 14:17:38 +0000
From:   "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To:     Joel Fernandes <joel@joelfernandes.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>
CC:     Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] rcu/rcuscale: Stop kfree_scale_thread thread(s) after
 unloading rcuscale
Thread-Topic: [PATCH 1/1] rcu/rcuscale: Stop kfree_scale_thread thread(s)
 after unloading rcuscale
Thread-Index: AQHZVYJ6y9lPL1nBiUy5prGqw8pyma765zaAgAAHhwCAAPXpEA==
Date:   Wed, 15 Mar 2023 14:17:38 +0000
Message-ID: <IA1PR11MB6171450B68D3EF4000C9A4B089BF9@IA1PR11MB6171.namprd11.prod.outlook.com>
References: <20230313080403.89290-1-qiuxu.zhuo@intel.com>
 <d930f2a8-4b75-4109-a303-e2fc04443693@paulmck-laptop>
 <CAEXW_YRxWGCuV_YVLqpFqOnGAMYAf2c+TAV1iAD8=2uVOqkf_Q@mail.gmail.com>
In-Reply-To: <CAEXW_YRxWGCuV_YVLqpFqOnGAMYAf2c+TAV1iAD8=2uVOqkf_Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6171:EE_|PH8PR11MB6660:EE_
x-ms-office365-filtering-correlation-id: 40517704-973b-4e06-c22f-08db256007fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Ld80u0BD0K0bQ0DQf6k94A8QxNstCQjqYm9mvsmhCujpKaV/pVG9C3qQ2KY0/OdgmtJN5l0QZxxS5NUKAcW+4o/JP4MdOITszL7wQv9BF/I4kQ8aV21vz2NvJOfOu//2s0C150UjyFQFRa+rPULS/dwTxGc0XfIDg8pI+83ihlnl7Oig7o++P9BI5y5Cnq85I8SLYsRyRlT2fBTOtrIpFGO7FCoQu7D/VmaWwdU1PhMxRU9xSLFqN+Rh/9UDFk3MKxuiG2xTgBRqk5BOCkWG+CQBZmL5w2g8zyfip8tWIeVbpW+pMxGI9W+30ZguXQl0ZfHN6a3U0Ntg9tsK1cRtbf6ugZWMUR+nFb59qDZSn4jT1Bg/vIqlu4Um3p8gbtu18/5bHL8cBNKPHkb9r4jiyN7SSE9W9xpBd4k+7ILq1xcq6zYaqr3iidR5MNH4Ke75YtU6frFrv4evWhMxj82JSDc7AW5yYx5DpHoylq74srWWHNHZtg43MYLFqsfdzkTQg57XDESs+xhT111lM733dJ8laF14FZrRlrMCjM912pqM7uajSFMMfHVROD4XsUUQuuK/W1sEsYWHyRsiV+KHZr/1k3eSwi0s/iu/i4YCo8Rrl1srkTdpD6KaOqMe3VVauJE32MnICkv/m0/u04sWsaDP2t2bVs+Q1DSKiuNkrf/+5YA6mwSZ3ryZQZF2dTMC+5rDN7iNk2UGNroZdh/iQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6171.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199018)(86362001)(186003)(9686003)(38070700005)(33656002)(2906002)(6506007)(26005)(71200400001)(38100700002)(122000001)(82960400001)(8676002)(7696005)(5660300002)(7416002)(478600001)(55016003)(41300700001)(52536014)(316002)(8936002)(110136005)(4326008)(66476007)(66446008)(64756008)(76116006)(54906003)(66556008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGYxaDJzeGJSRlFrOGUwZGMwQ3JkYy84aklMWTNKL05JKzlDRmQzVHphb1Fv?=
 =?utf-8?B?Q3QrQXpNRjhIaDVHalV6ZThRNFZvdWJrclU5ZHROS3llN2tQclB6Rkljbkda?=
 =?utf-8?B?ZUN0TFd5UXhxTkFlRmZpcVF5UW5ramxuN3d5VVAwUnpwbS9uM2VhVzVCTFR3?=
 =?utf-8?B?eHYzUURxWnptVTFIZm5EZ2VPbFhja1E0OTcvbUREUElJZnlVb09xRzNQRVp2?=
 =?utf-8?B?TFFvdnhlYTVSazBFUERYaXY4N0lKRzM4cjJoL21rUEUveE5OS0NNbW5EK3ZK?=
 =?utf-8?B?YUora1lwVWQvVk9tdklUT3R6a2tpd01LOUpjYTEvaytqSXZtNEhIMEhaSFFP?=
 =?utf-8?B?Wk1rNVR5TWFQS2k0RzdPUEhGNyt5aFdGSUxUc0JsOHN6MzF2aHRQd0VCYzZl?=
 =?utf-8?B?bmJ4UTVyUDdRSkt3b2FoZUNraDBqVnVLc3BDajg2NEh6VGh5MFJTVTBMK1FR?=
 =?utf-8?B?dU1Lckx3NjI2d0NPS2JadXp6OURkSzd6U0VJcEkrbG85ejhmKzVGU3h0cWZr?=
 =?utf-8?B?c1pZbVdQcUowMUE4ODRIR2Q4bUhEclY5UFNpd29SdzluSXF1SVE5NEdIVTYx?=
 =?utf-8?B?ZlhmMHVJdlFPSFdmeWlDekVCUllaK21hYkpMVms4WXZBZzVQa1lHUWRzRWY4?=
 =?utf-8?B?OHN5dnhTaHBhNG1CdytiTWh0UjI4dTBuai85eno5aEIzY0ZXUngrQWZ4OGV1?=
 =?utf-8?B?TEtER2F2SmlRUWxKcERWa21wV1A5cyswSHhWak5CY3ptbW9QbVFRRE1YTzk3?=
 =?utf-8?B?MW85WENlZC9Sc29ZZ0VVa2dVdm81WUFiS0w4aGw4dGFQc0M0eWZrVVNJUW9K?=
 =?utf-8?B?S1RTNVNrZW1wUDJQb3RYblhVUDBoWlF6c2lhS0ZRRG1jV00xWE92c2NXSTNi?=
 =?utf-8?B?RE1tQTZyUlVIYi9ZYlpFK0dtYW1FZS9RbEsyTlJkeVpnRkNEeDYraTl6aHNt?=
 =?utf-8?B?cTU2OFlNREVvL2RINlliOVlVZUh3WjZMejY5dWQxVnpRemR0UjdGME9mblQ4?=
 =?utf-8?B?ZjFkOHc3bTR4KzljQSs2eFdSRlRqYjViRk84WjB3dkZ2NGMyVkVrRnBkUkdj?=
 =?utf-8?B?d2JJMTY5MlpVK05mclJFcDlacFhPN2RJVW9kWStBZW5JenVBRldTdjhKQlNk?=
 =?utf-8?B?RERob0FhVFJIZ1RUWXhkdmZtS0NiV3p4QjAxSGhaaUVVdkEvZVRHd3RJQXoy?=
 =?utf-8?B?ZElQdjlSd2xRbXUxdVpnalFIOVZ3cWZRSU9oaG1EdGl4ZkRXd3pIK3RJN1FO?=
 =?utf-8?B?L1IwMDc4d21OSzJRWjBIQU1nc2wwaFpETS9QaFBLTnAwVTA4OFNpcFNMYkwy?=
 =?utf-8?B?RlRBZ2lPOC9ZaWk0YVBpang3Q3lSWHlrRWJGYjVLMDBKakpLaFZqVjV2UUR6?=
 =?utf-8?B?VDV4L3JLdnBxMk9aWG94TGl6S3lZQkN3Y0pnSDlkaXp1OEdYUEo2a1lMUnI5?=
 =?utf-8?B?Tzh5YkhzMTVnR3k3RXlRanJneTRZVWcyY2puZlhEbVA1a0gyZlcwUWJuQzRG?=
 =?utf-8?B?d21mdGV6eFY5TVVYYkdqOFd6WkNlU2gwRkN0aDNkOUpiK3QwNXVBRTBxeEZu?=
 =?utf-8?B?TVd6cW4yMzQ4S3QrQnBTcjVMb0NqSEl4TzVXMUxWL25LdmZoVWRGRDVzaUxt?=
 =?utf-8?B?Qm9TVGtqRDJDSFhZTEFNY29qL215YTNLLzBUcVpnRWJiL0NjTUxPUWVHV1BU?=
 =?utf-8?B?Nkw4TGhiUzdaZkNjRzhKQWtoM2lOMitRYVBTWStVMzYvY2NiNVdSaWtGU3Vs?=
 =?utf-8?B?ZGI5bFZmbXl3VVMwZWQ5dUhzUjVxSUYyQ29OTVcwbkY4TWdaYUJpaVpRWk91?=
 =?utf-8?B?N0J3N2MwcVFxN3UvOWpKQWpxNERUV05KOEc1a3Irb3pNSHMvRTdYdTZkemNX?=
 =?utf-8?B?V1lpc0srVCs3aU1OMXF1dGRhcUQwVGZHMHp4SDlPTURXcDBOcWxrNzVRUUJW?=
 =?utf-8?B?QmhyenRtQVdIV00vOHpRVG5DK3Q0L0laSGdhajNuVjFrZ0tzRTFpNC9SZ08r?=
 =?utf-8?B?Ry8vMy84WGdhSnJaS1NjTkd6ODFpa3V4c1FXaGdkblVwdUE4WWdEbEZJcm9T?=
 =?utf-8?B?SEE3djdnb2h5OS9WeVRHZ3VFRUFjcmREc3Z0OGZwU1JiVGtiQVdZRkRUcWto?=
 =?utf-8?Q?ZFM1Ma1odvHFMBfhNVZYgqHsN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6171.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40517704-973b-4e06-c22f-08db256007fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 14:17:38.3460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3oyzAaRW2EeENrVXnWQ/fp05bFPyWJZl1uwsnt4KvcZTEHQTDXQ3YadYJ79sL3Wo3/RSad1FbfrLc1pADFv92w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6660
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKb2VsIEZlcm5hbmRlcyA8am9lbEBqb2VsZmVybmFuZGVzLm9yZz4NCj4gWy4uLl0N
Cj4gPiA+ICBrZXJuZWwvcmN1L3JjdXNjYWxlLmMgfCA3ICsrKysrKysNCj4gPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2tlcm5l
bC9yY3UvcmN1c2NhbGUuYyBiL2tlcm5lbC9yY3UvcmN1c2NhbGUuYyBpbmRleA0KPiA+ID4gOTFm
YjU5MDVhMDA4Li41ZTU4MGNkMDhjNTggMTAwNjQ0DQo+ID4gPiAtLS0gYS9rZXJuZWwvcmN1L3Jj
dXNjYWxlLmMNCj4gPiA+ICsrKyBiL2tlcm5lbC9yY3UvcmN1c2NhbGUuYw0KPiA+ID4gQEAgLTUy
Miw2ICs1MjIsOCBAQCByY3Vfc2NhbGVfcHJpbnRfbW9kdWxlX3Bhcm1zKHN0cnVjdA0KPiByY3Vf
c2NhbGVfb3BzICpjdXJfb3BzLCBjb25zdCBjaGFyICp0YWcpDQo+ID4gPiAgICAgICAgICAgICAg
ICBzY2FsZV90eXBlLCB0YWcsIG5yZWFscmVhZGVycywgbnJlYWx3cml0ZXJzLCB2ZXJib3NlLA0K
PiA+ID4gc2h1dGRvd24pOyAgfQ0KPiA+ID4NCj4gPiA+ICtzdGF0aWMgdm9pZCBrZnJlZV9zY2Fs
ZV9jbGVhbnVwKHZvaWQpOw0KPiA+ID4gKw0KPiA+DQo+ID4gSSBkbyBhcHBsYXVkIG1pbm1pbWl6
aW5nIHRoZSBzaXplIG9mIHRoZSBwYXRjaCwgYnV0IGluIHRoaXMgY2FzZSBjb3VsZA0KPiA+IHlv
dSBwbGVhc2UgcHVsbCB0aGUga2ZyZWVfc2NhbGVfY2xlYW51cCgpIGZ1bmN0aW9uIGFoZWFkIG9m
IGl0cyBmaXJzdCB1c2U/DQo+IA0KPiBUaGUgb25seSB0cm91YmxlIHdpdGggbW92aW5nIHRoZSBm
dW5jdGlvbiBsaWtlIHRoYXQgaXMsIHRoZSBmaWxlIGlzIG1vc3RseSBzcGxpdA0KPiBhY3Jvc3Mg
a2ZyZWUgYW5kIG5vbi1rZnJlZSBmdW5jdGlvbnMuIFNvIG1vdmluZyBhIGtmcmVlIGZ1bmN0aW9u
IHRvIGJlDQo+IGFtb25nIHRoZSBub24ta2ZyZWUgb25lcyB3b3VsZCBsb29rIGEgYml0IHdlaXJk
Lg0KDQpZZXMsIHRoaXMgd291bGQgbG9vayBhIGJpdCB3ZWlyZCAuLi4NCg0KUGxlYXNlIHNlZSB0
aGUgcmVwbHkgdG8gUGF1bCBpbiBhbm90aGVyIGUtbWFpbDogDQoiUHVsbCB0aGUgcmN1X3NjYWxl
X2NsZWFudXAoKSBmdW5jdGlvbiBhZnRlciBrZnJlZV9zY2FsZV9jbGVhbnVwKCkuDQpUaGlzIGdy
b3VwcyBrZnJlZV8qIGZ1bmN0aW9ucyBhbmQgZ3JvdXBzIHJjdV9zY2FsZV8qIGZ1bmN0aW9ucy4g
DQpUaGVuIHRoZSBjb2RlIHdvdWxkIGxvb2sgY2xlYW5lci4iDQoNCj4gUGVyaGFwcyBhIGJldHRl
ciBwbGFjZSBmb3IgdGhlIGZ1bmN0aW9uIGRlY2xhcmF0aW9uIGNvdWxkIGJlIGEgbmV3DQo+ICJy
Y3VzY2FsZS5oIi4gQnV0IEkgYW0gcmVhbGx5IE9rIHdpdGggUGF1bCdzIHN1Z2dlc3Rpb24gYXMg
d2VsbC4NCj4gDQo+IFJldmlld2VkLWJ5OiBKb2VsIEZlcm5hbmRlcyAoR29vZ2xlKSA8am9lbEBq
b2VsZmVybmFuZGVzLm9yZz4NCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3LiA6LSkNCg0KPiB0aGFu
a3MsDQo+IA0KPiAgLSBKb2VsDQoNCg0KDQo=
