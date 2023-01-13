Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0B36696C1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241010AbjAMMTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241203AbjAMMS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:18:26 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD34D45657;
        Fri, 13 Jan 2023 04:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673611866; x=1705147866;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VZhH74qhOfjiymOPouPcZoFTE1Kn4Bg15kSiDXcQHAk=;
  b=K+Q3uKt+VgP9wHuc8UmZ4Pw49nHTJWZjbTWvHL8f0xVl7XXAZjlHWMSr
   UDcuwHPYiiEduORP9AZe71U7teRKoOgRQOGY3YSMcyJgYVeynKexZqFf+
   OhqoqPoWaRw7gqdaN/8JKYQeh3SKo3m2N7YUuSrZVelPbsuYfZ2zx+6mq
   vNaG+2SeLYZRr06YhOyYRKq2gE8DZP5rDWP2BbP2KQU2j5fAEoaMSEz1z
   RVWrHWGjyFk+R5v32yt9ygibbfpFMY3rCt7M3chpkQUMqJ1m9wR4RH6UU
   xMOGweLz/1x0HvawfFtOtW6EpS92LoLIAhmCJXw/YjZLDwoJuWb1Puh0w
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="304357531"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="304357531"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 04:11:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="660195907"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="660195907"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jan 2023 04:11:05 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 13 Jan 2023 04:11:05 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 13 Jan 2023 04:11:05 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 13 Jan 2023 04:11:05 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 13 Jan 2023 04:10:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGpHFHeRvUTdEoqh11FvzWlxRLjHNIQdtmCYkVDx0A2hKKWkCYTG/6Orh2GodrHb7HIDE91XE402gsL8LU+ORD2agQIAGBRBMAj1CMJF5OUXnnOdvSrHrfJvvXQDWE1kS3mLKFgiyArstOy4P2WrJHYRS4rWKoXmZDkArDVbBTrFdzxVnbvJg5fvu6y1L0+zKeoHpqKY87m6J3+7lX8Ah91psyeQJaEIr8ZfawId0cKfJE1BOEvSw2bUSwKGpeHiSkoBRFMJeAPQmv4NCBzjpS7qpYvxZrXMV3DKjdampeN1Z6SsD9FulS8aIUFrp9h+xsLBjh5z3ixRCSKAtlyWHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZhH74qhOfjiymOPouPcZoFTE1Kn4Bg15kSiDXcQHAk=;
 b=Nx23XvuLWIBWqFQ+J8iTky7zL7IvNZbBYuz06gqRbU+o6O8LIxMshopk692AqN1ejNrK/gh23e7S1oT/90V3DzftqVzaX3CANt3M2Crsn09SDZFugymUcC/pXqbLDw6nwnulTasvv9WIKel1uN8bwX9BLXlVUdEohxr5G7FpYNYZ6EhI9OquaTRY7wMQ9MJiAIrh2RhuYvOp9dyE/EJJCV22MMxmiYbp+67UV+O/2gBCeU59DhwdBhUbPwOyI7D5hqdT2gTxiV+3d7D1ZrTKBsSgdkMdfnUtNrVtRjbFOehMbzo64svjtvtr7DDPhWV5FUKsWcTgpIAMEfTGtxjkTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by PH0PR11MB5928.namprd11.prod.outlook.com (2603:10b6:510:144::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 12:10:47 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::114c:5805:e63f:6018%4]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 12:10:47 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcu: Fix the start_poll_synchronize_rcu_expedited() be
 invoked very early
Thread-Topic: [PATCH v2] rcu: Fix the start_poll_synchronize_rcu_expedited()
 be invoked very early
Thread-Index: AQHZJlrAbelW6ZjuBUWwM88Mxg3+Hq6bJV4AgADo4SCAADQ80A==
Date:   Fri, 13 Jan 2023 12:10:47 +0000
Message-ID: <PH0PR11MB588008A9BBAFA6BEEC8685ABDAC29@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20230112075629.1661429-1-qiang1.zhang@intel.com>
 <20230112190656.GR4028633@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB588074A87AC454A7F0E42A5ADAC29@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB588074A87AC454A7F0E42A5ADAC29@PH0PR11MB5880.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5880:EE_|PH0PR11MB5928:EE_
x-ms-office365-filtering-correlation-id: ad7a64e3-7cb8-48fc-d573-08daf55f3472
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Hmn2AUhxdblM1ouuzEBsMDiIwqKUj2n0NJ5iLo8z3OpTS0jAuH6cFCslnzrDybCNa8xHNv4KRpUd2vwoMCAt2yY04iUDEHyZyBA+BBcVKi62VjO1iRvLubijM5MXVFk0/KpA8i05tMB9cTMQaarMcdgTtArBaMyeXR8vEfkEjRzTu18X92C/yK4QBUV5smNnmK8mM0pArM5rBSP2bLpPrd2id+yvFK/lRBzRwAAMdNAvQ/k7McfU8f6BP4MU1qcc8tZLI9qSBbe8QRmEGKwNSXN+Kqfx1yodpoHxR1Rp8IIQlpJAzK4x56AZVbiqYVkb/Vpcd80fVVpXAZpPAwboCjyJDKlz6OhLm1WO10ay5ZsosCVhexb33hgp1B/SvsC1BoS7g2ECpt2+AlJlxNyHdI5a4MMovs2FrD9lZgGuZOPYKmVzR1H06rZub3nEQN1qHgL+4wutRZhYlT+LNVX/ow59AG+DTdSQlupRigrlw3pfSLNe5Pe9WVDfTakbN4JXHxwOkctqWSdd90FfUOFjW2aM+90ms2LdpLmxrbIW3E+H4JT2+tOSrUFi65guq51twWIbGwYKa0omYYGy2alXjZz8oVemop+OpT7WP0Upfu1vg0NLGMN45kgz3gnmeSwq9a5NUp0xi1Hvrsze4tjmZLUEqDE+zKCErn+D0F/SyydRvYTCGQPmBhd/bB3TyAp+apTJ9rGhiFsjnITvIvwFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199015)(71200400001)(6506007)(2940100002)(7696005)(66476007)(26005)(66446008)(66946007)(66556008)(64756008)(8676002)(6916009)(76116006)(186003)(9686003)(478600001)(41300700001)(8936002)(52536014)(5660300002)(2906002)(4326008)(38100700002)(122000001)(83380400001)(54906003)(33656002)(55016003)(82960400001)(38070700005)(86362001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2hOMStHOUlEckdpbVJHQXEwMWV6SzBJakhGSFNpdFpPaGdLUDYzcjlJdUxq?=
 =?utf-8?B?c3d6T3UvQzNNWlJtSHk0eWZuZHFvZWhPQkpFK1hlN290TExCY2F3QWVSVjh5?=
 =?utf-8?B?V2xFTXJ1WS9pVFcxbjlDSCsrWjBiZGlEejBYQ0xIWmlpR2xUaEJWZlRQSktM?=
 =?utf-8?B?Z0M3ZFgzeGxZSHl4OTlwYUhsNEZ6T2dMUmxZMGw2TERITndUZ0FmeHhmTzhq?=
 =?utf-8?B?VmNQWFR5NVd4Z3Nad29VZGlPb3Fsbk1BTEhlSDhVemlVczNNYmJISU1sWitG?=
 =?utf-8?B?TGQrcCsreVN0YUNGUThuSXBneTVVbkNlK1FWVU9ib2puS0loMy9hUTNLdU1j?=
 =?utf-8?B?Z1UyRmFFVHNxQklIZEZQeHBYMG1Ub0dldFZhcjJRNXV3c3o2ZDUvd0RDWjAw?=
 =?utf-8?B?OEgxUzBtdkZ5ODlRTyt2UjhNb1RsOUoySkJ5WjRsYXlCS29adWlZZUR3WVBr?=
 =?utf-8?B?aFdyNVY3U2cwa2lSQ0NEekNXd0hHOFN1bjlRSlk5cVNTVGZSY3B6SVlZaFZL?=
 =?utf-8?B?UUtIcVU5K1hsNFZkQXh3WFhRTG91VTU0NDhKWlRRaEJiSHJQNmZHbXU0NEMv?=
 =?utf-8?B?Vm1tTWIvZUJaQjhmRXlCdkIvdjRUbTdiZWh2ZHkxMEl6dExhVVh6REx0NXh4?=
 =?utf-8?B?Sms4bTJJS0ZscFNtUE1UZXlxZ041cC91OWlZQ3pSVk4zOVNwOWJTaHVOVXM4?=
 =?utf-8?B?KzhIU2RHbnhYU2o4KzAxVXZPZkZzV0VuUDJlSjFINWc1aExhWkt2RUNpb0Ja?=
 =?utf-8?B?d2lPbnU5a2tLKzZGYkVSRjRoS0ROeVcyb2pGNnkvUWNKbjhoeGNhTmJ4QmdS?=
 =?utf-8?B?YzgxUkpBQnpWaDAzQmNXTVd0eEU4blhLL2MvT0djZ0tHWElJaHo5NElhOXUz?=
 =?utf-8?B?TTVsOFdEbkRBTGRLSTFQSDdvdGFRcWs2ZVI0MGM2MGhIcHNob0xjcTRMcXAr?=
 =?utf-8?B?LzhMR3Z4UHp0K3VsRzVya09hazVqUHhtWHNXWGhKaXdnZFVnZXdNakZqMnhp?=
 =?utf-8?B?eHV1cG9USS90TE16eUVNN2NnQVc4Q01FU1gxOFBWRW1qQlIwdGpaOG9DK0FF?=
 =?utf-8?B?dmN2dXNaUkVKKzMyTzBuQmJza0NGcTVrNEdFbU9mMmsrTEwxM0ZlcHkreSta?=
 =?utf-8?B?MDBRc3E2RmgrZTJBaGpvd0t3TXFGVlgyOWIyRFhYckk5dWV2d3hpcjVPRjZs?=
 =?utf-8?B?QStkaE00NzZnUHd5cDdhb3A2N0xnU29IWStQTFIvd0svOTYyNHFXV0xGaXcz?=
 =?utf-8?B?WThadTlrcGxwTzhFSmJUbWZ5TkR4MUt3Um9mWXdsREdNUXNpd1A0MDhrekE2?=
 =?utf-8?B?YjFaOFQ3UjRkYnBPdWxRbWplWFI3aXlCYUpXQjduNlU2dmtFdDlZZU9RQi9H?=
 =?utf-8?B?WUZndWZkWEVvUnR4T2trWjRnSGdpdk9BRysvSVhvZ3k2RU4rbXdvQU5LZXJv?=
 =?utf-8?B?cEhCOVU4R1F5RmZkejZRVFR3T1UwUUdUTVBib0xXRzJLTHZaR0hQdlc3ZXh3?=
 =?utf-8?B?SlNBNDd0QjZQYlAzbVc2V1JvZ0FtTGsxcDVCUUFJK3BtNkhMR0laaENHYXZF?=
 =?utf-8?B?ZE5UMDJSZ21PemNrOUdIRnVZT1JEZEx0cTNZSkJaK2ZTSEFMSHBQWWNkVFdY?=
 =?utf-8?B?empEWmxVRkhSM25hODB2UThZVklNeDNnWGVHbklEQ1h6Wjk0QnBycVBlYmNH?=
 =?utf-8?B?bVB6MmxPaTBvTWFYdG1SbUYxbk5uTm1IQWxneGFRb2dZU3QxK0ZtRFVwTDI4?=
 =?utf-8?B?UCtqRkNkbXFGUlQrMGgxOGhoa1JVYXNUOUkvUVFsdjV0bms3VU9FdzViNGg2?=
 =?utf-8?B?dXpRN1QzNWw2QW9ielRPd1ErVkVtZHYxU09lR1NlZHp4OUxQa0IvVXk2bEZm?=
 =?utf-8?B?eFp4Z1g3VmNMZGNqWDk1YmF1UjhnMUQ5dys3UkFmZDRqWmJ6K3lOM3RuV3VU?=
 =?utf-8?B?dlpqZmNOVWdCUjJHR3ZBY2dQaUNUNTJCZFJ5NlZlVTVuOGJyTUhyRVJnN0Fn?=
 =?utf-8?B?YzN1bGpTMXVYYTdFdVJuZlE1b2FSeWY5QVVTdzdkK1VRMllPSHJIQytZSkRM?=
 =?utf-8?B?b2hNNkxmVENNZU9lZ005d0RaZGFWWWtnNzZleUJKQ1JnczFNVG5OTVBZWGxt?=
 =?utf-8?Q?Jl7LD5qFSHCbGsDTcSu3FnQk+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7a64e3-7cb8-48fc-d573-08daf55f3472
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 12:10:47.6360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cRSXhzAdb3yJsBAEc/lR33Q6elHQEzHiruttGyUH7/qmCXApMUoNsII+nVbgsCIAmFfRwq9edKkqjcYjLoVUmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5928
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IEN1cnJlbnRseSwgdGhlIHN0YXJ0X3BvbGxfc3luY2hyb25pemVfcmN1X2V4cGVkaXRlZCgp
IGNhbiBiZSBpbnZva2VkDQo+IHZlcnkgZWFybHkuIGJlZm9yZSByY3VfaW5pdCgpLCB0aGUgcmN1
X2RhdGEgc3RydWN0dXJlJ3MtPm15bm9kZSBpcyBub3QNCj4gaW5pdGlhbGl6ZWQsIGlmIGludm9r
ZSBzdGFydF9wb2xsX3N5bmNocm9uaXplX3JjdV9leHBlZGl0ZWQoKSBiZWZvcmUNCj4gcmN1X2lu
aXQoKSwgd2lsbCB0cmlnZ2VyIGEgbnVsbCByY3Vfbm9kZSBzdHJ1Y3R1cmUncy0+ZXhwX3NlcV9w
b2xsIGFjY2Vzcy4NCj4gDQo+IFRoaXMgY29tbWl0IGFkZCBib290X2V4cF9zZXFfcG9sbF9ycSBt
ZW1iZXIgdG8gcmN1X3N0YXRlIHN0cnVjdHVyZSB0bw0KPiBzdG9yZSBzZXEgbnVtYmVyIHJldHVy
biBieSBpbnZva2Ugc3RhcnRfcG9sbF9zeW5jaHJvbml6ZV9yY3VfZXhwZWRpdGVkKCkNCj4gdmVy
eSBlYXJseS4NCj4gDQo+IEZpeGVzOiBkOTZjNTJmZTQ5MDcgKCJyY3U6IEFkZCBwb2xsZWQgZXhw
ZWRpdGVkIGdyYWNlLXBlcmlvZCBwcmltaXRpdmVzIikNCj4gU2lnbmVkLW9mZi1ieTogWnFpYW5n
IDxxaWFuZzEuemhhbmdAaW50ZWwuY29tPg0KPg0KPkZpcnN0IG9mZiwgZXhjZWxsZW50IGNhdGNo
LCBacWlhbmchISENCj4NCj5BbmQgdGhhbmsgeW91IGZvciBGcmVkZXJpYyBhbmQgSm9lbCBmb3Ig
eW91ciByZXZpZXdzLg0KPgkNCj5CdXQgSSBiZWxpZXZlIHRoYXQgdGhpcyBjYW4gYmUgc2ltcGxp
ZmllZCwgZm9yIGV4YW1wbGUsIGFzIHNob3duIGluDQo+dGhlICh1bnRlc3RlZCkgcGF0Y2ggYmVs
b3cuDQo+DQo+VGhvdWdodHM/DQo+DQo+QWdyZWUsIHRoYW5rcyBmb3Igd29yZHNtaXRoZWQgIPCf
mIouDQo+DQo+DQo+QW5kIHllcywgSSBkaWQgcHJlc3VtcHR1b3VzbHkgYWRkIEZyZWRlcmljJ3Mg
YW5kIEpvZWwncyByZXZpZXdzLg0KPlBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3UgZGlzYWdyZWUs
IGFuZCBpZiBzbyB3aGF0IGRpZmZlcmVudCBhcHByb2FjaA0KPnlvdSB3b3VsZCBwcmVmZXIuICAo
VGhvdWdoIG9mIGNvdXJzZSBzaW1wbGUgZGlzYWdyZWVtZW50IGlzIHN1ZmZpY2llbnQNCj5mb3Ig
bWUgdG8gcmVtb3ZlIHlvdXIgdGFnLiAgTm90IGhvbGRpbmcgeW91IGhvc3RhZ2UgZm9yIGltcHJv
dmVtZW50cywNCj5ub3QgeWV0LCBhbnl3YXkhKQ0KPg0KPgkJCQkJCQlUaGFueCwgUGF1bA0KPg0K
Pi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KPg0KPmNvbW1pdCBlMDVhZjVjYjM4NThlNjY5YzllNmI3MGUwYWNh
NzA4Y2M3MDQ1N2RhDQo+QXV0aG9yOiBacWlhbmcgPHFpYW5nMS56aGFuZ0BpbnRlbC5jb20+DQo+
RGF0ZTogICBUaHUgSmFuIDEyIDEwOjQ4OjI5IDIwMjMgLTA4MDANCj4NCj4gICAgcmN1OiBQZXJt
aXQgc3RhcnRfcG9sbF9zeW5jaHJvbml6ZV9yY3VfZXhwZWRpdGVkKCkgdG8gYmUgaW52b2tlZCBl
YXJseQ0KPiAgICANCj4gICAgQWNjb3JkaW5nIHRvIHRoZSBjb21taXQgbG9nIG9mIHRoZSBwYXRj
aCB0aGF0IGFkZGVkIGl0IHRvIHRoZSBrZXJuZWwsDQo+ICAgIHN0YXJ0X3BvbGxfc3luY2hyb25p
emVfcmN1X2V4cGVkaXRlZCgpIGNhbiBiZSBpbnZva2VkIHZlcnkgZWFybHksIGFzDQo+ICAgIGlu
IGxvbmcgYmVmb3JlIHJjdV9pbml0KCkgaGFzIGJlZW4gaW52b2tlZC4gIEJ1dCBiZWZvcmUgcmN1
X2luaXQoKSwNCj4gICAgdGhlIHJjdV9kYXRhIHN0cnVjdHVyZSdzIC0+bXlub2RlIGZpZWxkIGhh
cyBub3QgeWV0IGJlZW4gaW5pdGlhbGl6ZWQuDQo+ICAgIFRoaXMgbWVhbnMgdGhhdCB0aGUgc3Rh
cnRfcG9sbF9zeW5jaHJvbml6ZV9yY3VfZXhwZWRpdGVkKCkgZnVuY3Rpb24ncw0KPiAgICBhdHRl
bXB0IHRvIHNldCB0aGUgQ1BVJ3MgbGVhZiByY3Vfbm9kZSBzdHJ1Y3R1cmUncyAtPmV4cF9zZXFf
cG9sbF9ycQ0KPiAgICBmaWVsZCB3aWxsIHJlc3VsdCBpbiBhIHNlZ21lbnRhdGlvbiBmYXVsdC4N
Cj4gICAgDQo+ICAgIFRoaXMgY29tbWl0IHRoZXJlZm9yZSBjYXVzZXMgc3RhcnRfcG9sbF9zeW5j
aHJvbml6ZV9yY3VfZXhwZWRpdGVkKCkgdG8NCj4gICAgc2V0IC0+ZXhwX3NlcV9wb2xsX3JxIG9u
bHkgYWZ0ZXIgcmN1X2luaXQoKSBoYXMgaW5pdGlhbGl6ZWQgYWxsIENQVXMnDQo+ICAgIHJjdV9k
YXRhIHN0cnVjdHVyZXMnIC0+bXlub2RlIGZpZWxkcy4gIEl0IGFsc28gcmVtb3ZlcyB0aGUgY2hl
Y2sgZnJvbQ0KPiAgICB0aGUgcmN1X2luaXQoKSBmdW5jdGlvbiBzbyB0aGF0IHN0YXJ0X3BvbGxf
c3luY2hyb25pemVfcmN1X2V4cGVkaXRlZCgNCj4gICAgaXMgdW5jb25kaXRpb25hbGx5IGludm9r
ZWQuICBZZXMsIHRoaXMgbWlnaHQgcmVzdWx0IGluIGFuIHVubmVjZXNzYXJ5DQo+ICAgIGJvb3Qt
dGltZSBncmFjZSBwZXJpb2QsIGJ1dCB0aGlzIGlzIGRvd24gaW4gdGhlIG5vaXNlLiAgQmVzaWRl
cywgdGhlcmUNCj4gICAgb25seSBoYXMgdG8gYmUgb25lIGNhbGxfcmN1KCkgaW52b2tlZCBwcmlv
ciB0byBzY2hlZHVsZXIgaW5pdGlhbGl6YXRpb24NCj4gICAgdG8gbWFrZSB0aGlzIGJvb3QtdGlt
ZSBncmFjZSBwZXJpb2QgbmVjZXNzYXJ5Lg0KDQpBIGxpdHRsZSBjb25mdXNlZCwgd2h5ICBjYWxs
X3JjdSgpIGludm9rZWQgcHJpb3IgdG8gc2NoZWR1bGVyIGluaXRpYWxpemF0aW9uIHRvIG1ha2Ug
dGhpcyBib290LXRpbWUNCmdyYWNlIHBlcmlvZCBuZWNlc3Nhcnkg8J+Yij8NCg0KVGhhbmtzDQpa
cWlhbmcNCg0KDQo+ICAgIA0KPiAgICBTaWduZWQtb2ZmLWJ5OiBacWlhbmcgPHFpYW5nMS56aGFu
Z0BpbnRlbC5jb20+DQo+ICAgIFJldmlld2VkLWJ5OiBGcmVkZXJpYyBXZWlzYmVja2VyIDxmcmVk
ZXJpY0BrZXJuZWwub3JnPg0KPiAgICBSZXZpZXdlZC1ieTogSm9lbCBGZXJuYW5kZXMgKEdvb2ds
ZSkgPGpvZWxAam9lbGZlcm5hbmRlcy5vcmc+DQo+ICAgIFNpZ25lZC1vZmYtYnk6IFBhdWwgRS4g
TWNLZW5uZXkgPHBhdWxtY2tAa2VybmVsLm9yZz4NCj4NCj5kaWZmIC0tZ2l0IGEva2VybmVsL3Jj
dS90cmVlLmMgYi9rZXJuZWwvcmN1L3RyZWUuYw0KPmluZGV4IDYzNTQ1ZDc5ZGE1MWMuLmYyZTNh
MjM3NzhjMDYgMTAwNjQ0DQo+LS0tIGEva2VybmVsL3JjdS90cmVlLmMNCj4rKysgYi9rZXJuZWwv
cmN1L3RyZWUuYw0KPkBAIC00OTM3LDkgKzQ5MzcsOCBAQCB2b2lkIF9faW5pdCByY3VfaW5pdCh2
b2lkKQ0KPiAJZWxzZQ0KPiAJCXFvdmxkX2NhbGMgPSBxb3ZsZDsNCj4gDQo+LQkvLyBLaWNrLXN0
YXJ0IGFueSBwb2xsZWQgZ3JhY2UgcGVyaW9kcyB0aGF0IHN0YXJ0ZWQgZWFybHkuDQo+LQlpZiAo
IShwZXJfY3B1X3B0cigmcmN1X2RhdGEsIGNwdSktPm15bm9kZS0+ZXhwX3NlcV9wb2xsX3JxICYg
MHgxKSkNCj4tCQkodm9pZClzdGFydF9wb2xsX3N5bmNocm9uaXplX3JjdV9leHBlZGl0ZWQoKTsN
Cj4rCS8vIEtpY2stc3RhcnQgaW4gY2FzZSBhbnkgcG9sbGVkIGdyYWNlIHBlcmlvZHMgc3RhcnRl
ZCBlYXJseS4NCj4rCSh2b2lkKXN0YXJ0X3BvbGxfc3luY2hyb25pemVfcmN1X2V4cGVkaXRlZCgp
Ow0KPiANCj4gCXJjdV90ZXN0X3N5bmNfcHJpbXMoKTsNCj4gfQ0KPmRpZmYgLS1naXQgYS9rZXJu
ZWwvcmN1L3RyZWVfZXhwLmggYi9rZXJuZWwvcmN1L3RyZWVfZXhwLmgNCj5pbmRleCA5NTZjZDQ1
OWJhN2YzLi4zYjdhYmI1ODE1N2RmIDEwMDY0NA0KPi0tLSBhL2tlcm5lbC9yY3UvdHJlZV9leHAu
aA0KPisrKyBiL2tlcm5lbC9yY3UvdHJlZV9leHAuaA0KPkBAIC0xMDY4LDkgKzEwNjgsMTAgQEAg
dW5zaWduZWQgbG9uZyBzdGFydF9wb2xsX3N5bmNocm9uaXplX3JjdV9leHBlZGl0ZWQodm9pZCkN
Cj4gCWlmIChyY3VfaW5pdF9pbnZva2VkKCkpDQo+IAkJcmF3X3NwaW5fbG9ja19pcnFzYXZlKCZy
bnAtPmV4cF9wb2xsX2xvY2ssIGZsYWdzKTsNCj4gCWlmICghcG9sbF9zdGF0ZV9zeW5jaHJvbml6
ZV9yY3UocykpIHsNCj4tCQlybnAtPmV4cF9zZXFfcG9sbF9ycSA9IHM7DQo+LQkJaWYgKHJjdV9p
bml0X2ludm9rZWQoKSkNCj4rCQlpZiAocmN1X2luaXRfaW52b2tlZCgpKSB7DQo+KwkJCXJucC0+
ZXhwX3NlcV9wb2xsX3JxID0gczsNCj4gCQkJcXVldWVfd29yayhyY3VfZ3Bfd3EsICZybnAtPmV4
cF9wb2xsX3dxKTsNCj4rCQl9DQo+IAl9DQo+IAlpZiAocmN1X2luaXRfaW52b2tlZCgpKQ0KPiAJ
CXJhd19zcGluX3VubG9ja19pcnFyZXN0b3JlKCZybnAtPmV4cF9wb2xsX2xvY2ssIGZsYWdzKTsN
Cg==
