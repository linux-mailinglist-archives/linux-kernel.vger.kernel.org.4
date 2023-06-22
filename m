Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C30073A772
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 19:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjFVRkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 13:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjFVRke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:40:34 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404AD269A;
        Thu, 22 Jun 2023 10:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687455621; x=1718991621;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=coeHA2NMPp9tzHg/EpS8ja+jjhjSsUAZ9D0UIjs59ys=;
  b=bcIX2px+JldHa2TmrSdDZppop/yalmGU7NlH3m/sfl1exsvMDysTyc4J
   PnQYNwYXq4gDZ/8zrXx3q6fE+n0K4tpNU3paiQJRvrhaVXaNpHP0FPXBz
   SE0ARu0+m2ONIyXOqeAjaIGH5T6GXSLIR9rhZrD9vU2wMn7919yxtG1yb
   bDR3tRzuUo8wEUh0Qih7m19Q4MuHw9oinmTMVZuXF7AX6y6OFzPMFwkkA
   Pmpg1cDXkJ6jwOAxLne2Kr/QMOLzBeWj78fSGwyKeJnRk18oL1FlDaTo5
   d8d6udaB0OnhUDpbrohN8Ql4eXAOTRzzAYLyzvv8C4xGaJqkOGExGYY2c
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="446936699"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="446936699"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 10:40:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="709168665"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="709168665"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 22 Jun 2023 10:40:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 10:40:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 10:40:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 10:40:18 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 10:40:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YN5NeoQOxabVQT8380NBdAH0HRwcJPYYFQgFIrxJHw9NgSbuS7z48zjC5bfE2jrseHJQCX4/vsuQF4iCowoHHkqHDtid859rXmaUDBlN4NKNFLm2+WciRgN7R/nKDXiExccevpWMjYezWyUxqH3RsnF1yCc3pscwas9T/dJA79Z9jLjWY4oILQLRoZTsS0ILDbZ7EhTvyx4/qVPN00oaqC7QkbHRjcolmIa2frbHDWd+4vY9GGWTdH6c9EriTUAJI63qxIvJBALU/o9WLAUI1X9DgYotEdjW2C4FbGsucj+AeoNEzCLVaN4HIlKrQ4eQ04itumL9grD6m6VF+ZRWAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coeHA2NMPp9tzHg/EpS8ja+jjhjSsUAZ9D0UIjs59ys=;
 b=fOK5FIPlKn6GZp3h7dpP5ptaJ2rN9THNqpfKHpXaBccEkoibUAaTJghdJYI//J4rrHSPZOoHgaAZl876WJidaz7XTDJhLvhj3GGbZhgUI3g4HatkWvmnBC+dijSiGUaJepF0ECUGGblmDmrV2GAOS+B1ow1mp8YzzeAwMNsqLgTbe2q2nTwrrk9vDHTJ5IX4eykkfR2b3ykoHEPKY164qpT2Nf2qi8Bi9PEi4BteUjLrcAH00z5uihNRFVKsFJ0Aqe8I9hmEcgsrXJ3ljppnGD8bvXiNjnR1vB3jxOM3ReBVd94hxGZGyyLum2ue2QAm+qeZWgNEeAdxIAyRj6Rtgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31)
 by SA1PR11MB6895.namprd11.prod.outlook.com (2603:10b6:806:2b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 17:40:16 +0000
Received: from MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::f070:fc63:a1af:225c]) by MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::f070:fc63:a1af:225c%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 17:40:16 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     Prashant Malani <pmalani@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: RE: [PATCH 1/2] platform/chrome: cros_ec_typec: Configure Retimer
 cable type
Thread-Topic: [PATCH 1/2] platform/chrome: cros_ec_typec: Configure Retimer
 cable type
Thread-Index: AQHZl0kyNzTj3/3/50ykPnbIRiA00K+MLxWAgAHbUMCAAARFgIAJIjdw
Date:   Thu, 22 Jun 2023 17:40:16 +0000
Message-ID: <MWHPR11MB00487A8E79B50419848CC5ECA922A@MWHPR11MB0048.namprd11.prod.outlook.com>
References: <20230605010117.794691-1-utkarsh.h.patel@intel.com>
 <20230605010117.794691-2-utkarsh.h.patel@intel.com>
 <CACeCKaeVw4UJ8oCj-wmWgf6TCcKYdprqb8Wdu-g2ZC5npgs71g@mail.gmail.com>
 <MWHPR11MB0048F68F717892378FF64E5FA958A@MWHPR11MB0048.namprd11.prod.outlook.com>
 <CACeCKac9YRbGYVSVjVWKX0hzJ2PJnenWxasABf2QoUQKK52XvA@mail.gmail.com>
In-Reply-To: <CACeCKac9YRbGYVSVjVWKX0hzJ2PJnenWxasABf2QoUQKK52XvA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB0048:EE_|SA1PR11MB6895:EE_
x-ms-office365-filtering-correlation-id: a79d2c36-628b-47db-fe9f-08db7347bd9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P5k89BWz9PELvdRLYNDSskoxmtc7us7Bmf2TikO1r2FOd2049uvf6oaWVM6w+14HIwbjEb2SXXyCDBCi5kuWOBDssE7OAR88N+dYTBIf7XzLwj82ULI4l2OpyYvh9ITCy7Satq3KpfvZhy0be5OP0tQZxahAR11srYU3XZCdA/uZpNM1SH9Z4cbIQZjjTuf0e+vcKEj85PkrgEHAXUf2r5/wuSvyIs7nB+ijwjCGMohHLLPnpdQ0EyXFBpu/Z0jAkIMOUvd9qbIqvgt+lY8eKL0IZEoATzViyG3r7FyH8kc1CqJNbTU2UPlTW4ju0j4cIBPbeYA3LcpKvgBQUczPRTCP6t4c7JekAp8bvvjvaJXOGTa7sMLUioYcPKKPwb6/6SC7vXVwWbfajzwKIb17TCQuAmt6SZyHaee4dYWel6yEDTC+X+3YwNwZqbTdMDGCOp31pToWwokj/d5ytQ0dPx5trxNX5hU5MUZjY3tR35RPEEKstu7cEIr6fmpklnECLJEC8yU3AsWpu/+3lPfedTE6AO92eX3RCNAmvz9Ap5D+s9FgNr8Q00jsdKG3GFkGButOMzR9PKbfUTbHr4/wbc5J3QGMhuidPxVdkXr+y3s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199021)(4326008)(6916009)(64756008)(66556008)(66476007)(66446008)(54906003)(316002)(82960400001)(122000001)(76116006)(66946007)(71200400001)(83380400001)(52536014)(6506007)(53546011)(86362001)(2906002)(7696005)(5660300002)(8936002)(8676002)(9686003)(26005)(186003)(41300700001)(478600001)(33656002)(55016003)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWZ5L283bitoT3BVTGpOaWgzYmI5SnR5VG5oQmZybVFqYi8zbnVmZWw0bS9m?=
 =?utf-8?B?Q0xrUm1KZTdtVHJRNko4Ry9iN2lxMGFBUUl5cmduU2w4eWVHQllIMHcyQ05Y?=
 =?utf-8?B?SUNvYzY5UlV4ZHVLTHFRaFh0UWtFYmV4cGlaOFJCejEzeEFQcnROb0txSjlj?=
 =?utf-8?B?Uk9nUW9YMHN3Vkg4QVV4Z2VmYis3ODZBTHdqMnN6Zm1wcisza3pvUGdmUWdp?=
 =?utf-8?B?QlZMRGJoR1RXNlNKTjlqbjIrcTgvOFdGTjUyK0xqZWdhMXRvdGJMVWhVZzVq?=
 =?utf-8?B?dXNLZTBnUGFxRktnTGcyTlJPalNjWjMzaVlTbll4dkVyRW5VaHR6SXNlUEJh?=
 =?utf-8?B?eS9FRjI4N0lLWHZ0UzYrS1RmdkpuMlBERC9td2hFenVKWTFXc0JuYjY1T2hi?=
 =?utf-8?B?eFZnb3RMdGFpTUNjOFAyR3JZV1c4NU9uUTVaWXFHTHJxSUk1TndJRnNkUGtu?=
 =?utf-8?B?YjdSMUQzOWxZTU1zUWlnWCt0VmQ5bCtsNEpna3hlWWNsMHNPSEtpSHJlODZo?=
 =?utf-8?B?OHR1QlJkUEh4L0UvWVNzTEEvTWYzdjFhajZSTHkyWGxKM21NOW5VZlUxUDdY?=
 =?utf-8?B?MVpvdUJaNUhNT2pmSGMrcnRsR1FwaCtsVFZFT1FUb05kdHV5Vjlkb0pOcmNu?=
 =?utf-8?B?eElsYmwvTFZUTlBWeXlxT0FKcVU0TkhTSDVuZkp1NVkxUkpvVHdYenhQVFVV?=
 =?utf-8?B?R29vazlkTnFoUVRiRDBubnA0QXFkMm4rSlpSUWpMcWsxOExKTFhDeElqdzFB?=
 =?utf-8?B?VmxmRnA3QTNpYk5iZWVpMTdnTFNyUGdXc0F6MWtlVFBpMkE2RnJYMzZXL01G?=
 =?utf-8?B?S2ZCT0Nlejh6MFUvVmxYQVNUdC9rb1FPYkRqb3FDb3g5RlIwZytzR0IrVlhm?=
 =?utf-8?B?dU5NSVdBb0wwT2JZbnVQVUlxWDYrWFYvUmJqL3U2cnYza2h4RjJuYTR1Mnc3?=
 =?utf-8?B?Y0tmaGlhRlJ2NHhkSnFNT3lQZzJ5L3dtNWpJVXBLc3BacUE2VElEYU5nNmRW?=
 =?utf-8?B?N0dQeFhXNWpMNi9aNzJPSm5saUo1dkNyb0Zvckovdmg1aERkSkFQb0lRVG5G?=
 =?utf-8?B?WjVDN29vYU4wVllLWW5CVnE5c0lGOGVvTTdSUnF1cWRGQW44OU9uTmN5SmV2?=
 =?utf-8?B?QnpRUGtQM0syQVBGcHU1bWo0QXBQeXlVd3Zidmc2SENIcmYrL21uenF1VjMv?=
 =?utf-8?B?RTZWNTFrQ2xaUjk5K2pqMzR6M3IraTRudUZsazFMblVITnprd2ZXdklETjZD?=
 =?utf-8?B?L0R3dklOZ3VSeTNrazRocU9PMVJndHFocEdlMWN6ZEVNWHZrNnY2cWROa1VF?=
 =?utf-8?B?ZjZ5aHpPQ29JaDUxYWlXQkdCcUVKKzE2SldvcWYyZUc2SFhIb1JvZTArYjho?=
 =?utf-8?B?Kyswd09DcGVqdWUxWXVXMExJTUVUakJLTWNPdTVkZ0hkaWpKRE8vZ24rblpz?=
 =?utf-8?B?WGJXeHF5a2tMSmFEK2pvOGJ1MGtsVERUZDUrOVRYNnNLSVRITytZWTcxK1pO?=
 =?utf-8?B?dWpVcERqb0t3YUFtbEFkUWp1dTNoelFwUEYyT0VtYjMyRW5md3lhc0JpcnRF?=
 =?utf-8?B?Rk8vN0t1YTdtVUJxWXFHWDFnVGs3eTdWVDRlMDN2Z0VjRnlDTmhuNzdVUkw4?=
 =?utf-8?B?cDFqR1BOd0ZYU1c3ZElHbFUwVmU3bUZTdStVcnNxWnpzTEMrZXVKMDUvOXZT?=
 =?utf-8?B?VU9HT2NDay9yZGMyTCtLYjVPZGE0S3FSUXRlSTRoZkJ5UnY3SmJITkxJVmhr?=
 =?utf-8?B?SGxNeGJjcWo0Wno5UmMxYlBIUXVVZWNoT08xN3AzRXhVdzZQU1Q5am5PaXZC?=
 =?utf-8?B?aGdLTWJjU1dUbkw5Y0hQMzV5ejRmNFgzaGxIcDQ1MGZybkpKMU5Lb1YrU1FW?=
 =?utf-8?B?cXlEbm1ZNVM4dGtJSDU4SmlUOExrc1JMQkxTVGMwK3E1bEZMNjVQQWp4NFRp?=
 =?utf-8?B?cHJPRFkxZnc2cksrdzhOVDR3VW5rN3M1ZHI4VXNlMjFycVFTbTUxbkpjNEF6?=
 =?utf-8?B?R0dxWm5nRXRLZ2psNXVUQTErNTJleENlRVhvaTBKcHRoK3RYVjJQSEpBbHVo?=
 =?utf-8?B?WEZKY2dqbWdHLzdZN2w0U0lZSjNkaDhqNkdpdGM3RDVvQ3pPN29JK3BOZkpU?=
 =?utf-8?Q?wFljNWLA5nvr+PhHoMMKgsZgj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a79d2c36-628b-47db-fe9f-08db7347bd9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 17:40:16.4270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fmJ2bQeyWC0apXxZpxFRJ+vc59hCdHqqaGHQ8c7cwaYnmZOncSC0moRh+h9IF6yTGOOOPEjXr1fv6ClqNvLW/sgXYizCxEWVaQD9PoDmPHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6895
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUHJhc2hhbnQsDQo+IA0KPiBIaSBVdGthcnNoLA0KPiANCj4gT24gRnJpLCBKdW4gMTYsIDIw
MjMgYXQgMjo1N+KAr1BNIFBhdGVsLCBVdGthcnNoIEggPHV0a2Fyc2guaC5wYXRlbEBpbnRlbC5j
b20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gSGkgUHJhc2hhbnQsDQo+ID4NCj4gPiBUaGFuayB5b3Ug
Zm9yIHRoZSByZXZpZXcgYW5kIGZlZWRiYWNrLg0KPiA+DQo+ID4gPiA+IENvbm5lY3RvciBjbGFz
cyBkcml2ZXIgb25seSBjb25maWd1cmUgY2FibGUgdHlwZSBhY3RpdmUgb3IgcGFzc2l2ZS4NCj4g
PiA+ID4gV2l0aCB0aGlzIGNoYW5nZSBpdCB3aWxsIGFsc28gY29uZmlndXJlIGlmIHRoZSBjYWJs
ZSB0eXBlIGlzDQo+ID4gPiA+IHJldGltZXIgb3IgcmVkcml2ZXIgaWYgcmVxdWlyZWQgYnkgQVAu
IFRoaXMgZGV0YWlscyB3aWxsIGJlDQo+ID4gPiA+IHByb3ZpZGVkIGJ5IENocm9tZSBFQyBhcyBh
IHBhcnQgb2YgY2FibGUgZGlzY292ZXIgbW9kZSBWRE8uDQo+ID4gPiA+DQo+ID4gPiA+IFRoaXMg
Y2hhbmdlIGFsc28gYnJpbmdzIGluIGNvcnJlc3BvbmRpbmcgRUMgaGVhZGVyIHVwZGF0ZXMgZnJv
bQ0KPiA+ID4gPiB0aGUgRUMgY29kZSBiYXNlIFsxXS4NCj4gPiA+DQo+ID4gPiBQbGVhc2Ugc2Vw
YXJhdGUgdGhpcyBpbnRvIGFub3RoZXIgcGF0Y2guDQo+ID4NCj4gPiBJIGNhbiBkbyB0aGF0IGJ1
dCBzaW5jZSBpdCdzIGp1c3Qgb25lIGxpbmUgY2hhbmdlIGFuZCByZWxhdGVkLCBrZXB0IGl0IHRv
Z2V0aGVyLg0KPiANCj4gSXQncyBmaW5lIHRvIGhhdmUgYSAxIGxpbmUgcGF0Y2guIFRoYXQgc2Fp
ZCAoc2VlIGJlbG93KS4uLg0KDQpBY2suDQoNCj4gDQo+ID4NCj4gPiA+ID4gYS9pbmNsdWRlL2xp
bnV4L3BsYXRmb3JtX2RhdGEvY3Jvc19lY19jb21tYW5kcy5oDQo+ID4gPiA+IGIvaW5jbHVkZS9s
aW51eC9wbGF0Zm9ybV9kYXRhL2Nyb3NfZWNfY29tbWFuZHMuaA0KPiA+ID4gPiBpbmRleCBhYjcy
MWNmMTNhOTguLmM5YWE1NDk1YzY2NiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvaW5jbHVkZS9saW51
eC9wbGF0Zm9ybV9kYXRhL2Nyb3NfZWNfY29tbWFuZHMuaA0KPiA+ID4gPiArKysgYi9pbmNsdWRl
L2xpbnV4L3BsYXRmb3JtX2RhdGEvY3Jvc19lY19jb21tYW5kcy5oDQo+ID4gPiA+IEBAIC00OTYz
LDYgKzQ5NjMsOCBAQCBzdHJ1Y3QgZWNfcmVzcG9uc2VfdXNiX3BkX2NvbnRyb2xfdjEgew0KPiA+
ID4gPiAjZGVmaW5lIFVTQl9QRF9DVFJMX1RCVF9MRUdBQ1lfQURBUFRFUiAgQklUKDIpDQo+ID4g
PiA+ICAvKiBBY3RpdmUgTGluayBVbmktRGlyZWN0aW9uICovDQo+ID4gPiA+ICAjZGVmaW5lIFVT
Ql9QRF9DVFJMX0FDVElWRV9MSU5LX1VOSURJUiAgQklUKDMpDQo+ID4gPiA+ICsvKiBSZXRpbWVy
L1JlZHJpdmVyIGNhYmxlICovDQo+ID4gPiA+ICsjZGVmaW5lIFVTQl9QRF9DVFJMX1JFVElNRVJf
Q0FCTEUgQklUKDQpDQo+ID4gPg0KPiA+ID4gV2h5IGFyZSB3ZSBhZGRpbmcgdGhpcyB0byB0aGlz
IGhvc3QgY29tbWFuZHMgaW50ZXJmYWNlPyBJcyB0aGlzDQo+ID4gPiBpbmZvcm1hdGlvbiBub3Qg
YXZhaWxhYmxlIGZyb20gdGhlIENhYmxlIChwbHVnKSdzIElkZW50aXR5DQo+ID4gPiBpbmZvcm1h
dGlvbj8gV2UgcmVnaXN0ZXIgYWxsIG9mIHRoYXQgaW4gdGhlIHBvcnQgZHJpdmVyIGFscmVhZHkg
WzFdLA0KPiA+ID4gc28gd2Ugc2hvdWxkIGp1c3QgdXNlIHRoYXQsIGluc3RlYWQgb2YgY2hhbmdp
bmcgdGhlIGhvc3QgY29tbWFuZCBpbnRlcmZhY2UuDQo+ID4NCj4gPiBBbGwgdGhlIGNhYmxlIGRl
dGFpbHMgdXNlZCB0byBjb25maWd1cmUgQWx0ZXJuYXRlIG1vZGUgYW5kIFVTQjQgbW9kZSBpbiB0
aGlzDQo+IGRyaXZlciBhcmUgcHJvdmlkZWQgZnJvbSBFQyBob3N0IGNvbW1hbmQuDQo+ID4gVG8g
c3RheSBjb25zaXN0ZW50IHdpdGggdGhlIGV4aXN0aW5nIGltcGxlbWVudGF0aW9uLCBpdCB3YXMg
YWRkZWQgdG8gdGhlDQo+IGV4aXN0aW5nIGhvc3QgY29tbWFuZC4NCj4gDQo+IEkgdGhpbmsgaXQn
cyBmaW5lIHRvIHVzZSB0aGUgY2FibGUgVkRPIGZyb20gdGhlIHJlZ2lzdGVyZWQgcG9ydCBwbHVn
IGZvciB0aGlzLiBJdCdzDQo+IGxlc3MgZGlzcnVwdGl2ZSB0aGFuIGludHJvZHVjaW5nIGFub3Ro
ZXIgKHN1cGVyZmx1b3VzKSBob3N0IGNvbW1hbmQNCj4gbW9kaWZpY2F0aW9uLg0KPiBJdCBpcyBh
bHNvIG1vcmUgY2xlYXI7IHJpZ2h0IG5vdyB3ZSBkb24ndCBrbm93IHdoYXQgaW5mb3JtYXRpb24g
cG9wdWxhdGVzIHRoZQ0KPiBVU0JfUERfQ1RSTF9SRVRJTUVSX0NBQkxFLiBQbGVhc2UgdXNlIHRo
ZSBleGlzdGluZyBjYWJsZSBWRE8gZnJvbSB0aGUNCj4gY2FibGUgc3RydWN0IGZvciB0aGlzIHB1
cnBvc2UuDQoNClRoaXMgaW5mb3JtYXRpb24gaXMgcHJvdmlkZWQgZnJvbSBFQyB3aGVyZSBpdCBn
ZXRzIFRCVDMgQ2FibGUgRGlzY292ZXIgTW9kZSBWRE8gUmVzcG9uc2VzLg0KTGlrZSBhbnkgb3Ro
ZXIgY2FibGUgY2FwYWJpbGl0aWVzIGUuZy4gYWN0aXZlL3Bhc3NpdmUsIHJvdW5kZWQgc3VwcG9y
dCwgY2FibGUgc3BlZWQsIGNhYmxlJ3MgcmV0aW1lci9yZWR2aWVyIGNhcGFiaWxpdGllcyBpcyBh
bHNvDQpwb3B1bGF0ZWQgZnJvbSB0aGlzIHJlc3BvbnNlIGluIGJpdCAyMi4gKGh0dHBzOi8vY2hy
b21pdW0uZ29vZ2xlc291cmNlLmNvbS9jaHJvbWl1bW9zL3BsYXRmb3JtL2VjLysvSEVBRC9pbmNs
dWRlL3VzYl9wZF90YnQuaCMyNTEpDQoqIDwyMj4gICAgOiBSZS10aW1lcg0KICogICAgICAgICAg
IDAgPSBOb3QgcmUtdGltZXINCiAqICAgICAgICAgICAxID0gUmUtdGltZXINCiANClRoaXMgaXMg
YWxyZWFkeSBiZWluZyB1c2VkIGJ5IEVDIHRvIGNvbmZpZ3VyZSByZXRpbWVyIHdpdGggdGhlIGNh
YmxlIGNhcGFiaWxpdGllcyBhbmQgdGhlIGdvYWwgb2YgdGhpcyBwYXRjaCBoZXJlIGlzIHRvIHBy
b3ZpZGUgIHRoZSBzYW1lIGNhYmxlIHJldGltZXIvcmVkcml2ZXIgY2FwYWJpbGl0aWVzIHRvIFNP
Qy4gDQpXaGVuIGFsbCBvdGhlciBjYWJsZSBkZXRhaWxzIGFyZSBwb3B1bGF0ZWQgZnJvbSBFQyBp
biBhbHRlcm5hdGUgbW9kZSBhbmQgdXNiNCBtb2RlIGFuZCBzZW5kIGl0IHRvIFNPQywgaXQncyBi
ZXR0ZXIgdG8gc3RpY2sgdG8gdGhlIHNhbWUgZnJhbWV3b3JrIHRvIHVzZSBjYWJsZSBjYXBhYmls
aXRpZXMgd2hpY2ggaXMgYWxyZWFkeSBhdmFpbGFibGUgaW5zdGVhZCBvZiANCm5ldyBpbXBsZW1l
bnRhdGlvbiBqdXN0IHRvIGdldCByZXRpbWVyL3JlZHJpdmVyIGNhYmxlIGNhcGFiaWxpdGllcy4N
Cg0KU2luY2VyZWx5LA0KVXRrYXJzaCBQYXRlbC4NCg==
