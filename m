Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D31E66C75B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjAPQ36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbjAPQ3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:29:38 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2126.outbound.protection.outlook.com [40.107.114.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EFF36FEB;
        Mon, 16 Jan 2023 08:17:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdqAmvzGePkrIZCHNj2BjIlYXl1LNDBqHKM5kPpzxOLXAtF6zsLYLHm0crb3mwfcWRSGplumoEZyrBaO8nlKgDvNteWCNCHl9qddyHg1L4qaH7Bm0ynXwaImVbiNkjzlZX9CmSIPYuVq7qGUVM5Y+aVQ1RyWbapnEoc38spW6T2rgy2XY/D8DWovu4ctXUX1jzhSs8ShWfEeBSTD1qtcJEF6bF6MmGL55v1z336EzUpoNBv/vU/evpbLXcmuKG021CaXFUshkHrv/M2W8rwsn1NhEq7JI+tSqfNsSnRPMBDDvjhZyBgIXIU2WecE0al27q1c69QvKzVoVtJKsPJQlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkEIdmgSOYmwtOocNPmF6u+FtZDqFL7m0AmzAOniF4A=;
 b=danukc4PwqdTSnfRtTgQuR3junud5ngUnDbtedmlZ5gQ47o6+Rfk8grKhBMEexejK+RIMv4edPn//jIXAoUbDzXF92AmHeHkr3Q9HfSNOp8VGQjnsYo4oEPfpUEHBX5QqIdkvKYdAqOeTnJSGGElldElEp/+0WT+XbciSb56bNZXJOg5rUicKlDvUKB0xIQu5DFXMvjyLgbc3qx5DCpnXim28ybn8U5gprcqeu9pZKmmqUItrjznujzde0k8Vgp4+EzEsGAIG0i6vqHMgvlWqL5EfXmlkt9EHxIs211t/zFCctY/KeUDYpHUl4AB3YjAws16dYIoT6c5RHAUBqd6Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkEIdmgSOYmwtOocNPmF6u+FtZDqFL7m0AmzAOniF4A=;
 b=PmVeA20mMqAPNTd+yd+9otMbNqrKgTGdmKOp9OYWl5XuWVa/vwsI6lhwlEX419UJPGkFeQFyvyE0oRPwB1avF2ImpAX736KpyfWjuKY8ixM//xDjjHV/XRkHpj3GR1V9N1WZ1m6pWmliBdFM4237u1bsdUPFeb5frZGs+Gn5TUw=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYCPR01MB10809.jpnprd01.prod.outlook.com (2603:1096:400:296::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Mon, 16 Jan
 2023 16:17:56 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::9459:ffa9:a884:8a8e%3]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 16:17:55 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Subject: RE: [PATCH 2/2] watchdog: rzg2l_wdt: Handle TYPE-B reset for RZ/V2M
Thread-Topic: [PATCH 2/2] watchdog: rzg2l_wdt: Handle TYPE-B reset for RZ/V2M
Thread-Index: AQHY+nqpy1QulZVqxE28XPYMi1eo7K6hkpCAgAAAPXA=
Date:   Mon, 16 Jan 2023 16:17:55 +0000
Message-ID: <TYWPR01MB877570EB023D2ECEB7896F84C2C19@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20221117114907.138583-1-fabrizio.castro.jz@renesas.com>
 <20221117114907.138583-3-fabrizio.castro.jz@renesas.com>
 <CAMuHMdUzkAjF=v__r2vJrYugBuDt13LnToCW66n-5r-jcVV+8A@mail.gmail.com>
In-Reply-To: <CAMuHMdUzkAjF=v__r2vJrYugBuDt13LnToCW66n-5r-jcVV+8A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYCPR01MB10809:EE_
x-ms-office365-filtering-correlation-id: 3adee536-98a2-47c9-b26e-08daf7dd3a01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l9Gk/PWg1JlAlDIQjYGl2o2+3yLCZ+M4xdOTJMvs6d7rPGKQClOjr7u2v5Vdc/erLzEa1rDmxxFtAff+lk5NHtNkE4ZHiqyvgeS2zzSmF/1FDPrLBQ6UeSm/g5JWsxbYSPZCW5UycYoyaAvCoO/RUCU+OZoJJd62HXnAwxd7eCEYBYbyV9lLgChfCTAWuDpZ32yLvDrnEQPr4CUQL535ftr85Dw4sBjebimbUJybJW3+oJoXx9rnkUPaKKTmVKucNoNv+BHbtI+4MZWb1mtiiWrm2Br0GDTTppou8NCmMhnu2shnYDLZZ5Vzf9EIUugxOzZ+s0loM2yYBT6MigVg41iq8cB32hCbWFhx9H9UFNKDkBCAiAxu9d+Jcbz9LxXc15GgHJw/wKa+dE6OW9LLlTV38AVHrT6+YlRwflea743bICxVBCZWSdVZosxJgOP4ug2yJ37qMakJEVCggPLG2ACyV/wp9AGbAOlR/aPmvdax77JqD2f1Jeb6Df/Ws8uZPTv+U71JMmYUv5bPiDOxw2SwwuxNYxGDyrlKZomFOVM52PLe62TwzWtQCl9Mvg3JsIYcSU/o9Xa1DNKbQeFpkC2OoT0fQolPHu2UOK8gPm7HUH4vFeUodEMC0zG4X07gne4wyj74qHv+SB+S29Anc++gDlmB2He6rnI91sgRS//nrlbX5kHduExHQELoAgZnwde6R/mdwwcjLQKoMdOYDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199015)(8936002)(76116006)(86362001)(66446008)(66476007)(64756008)(6916009)(52536014)(66946007)(83380400001)(8676002)(4326008)(38070700005)(55016003)(33656002)(122000001)(38100700002)(5660300002)(478600001)(66556008)(41300700001)(7696005)(2906002)(54906003)(9686003)(66899015)(6506007)(53546011)(26005)(186003)(316002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTFwMmNoN1NSRloybXovSUNuQkpZQXVBdWhuT1M5Umszbkl4eDVyZ2Y2Mzl3?=
 =?utf-8?B?d0lFVG5QSHFsTnJOK3ZxMTJ6ZTBhaTdKME1RTDZLM0JoRHlYQy9RZnVGRXJE?=
 =?utf-8?B?ekRnVFFDdXQ2clM2UmpRQmJhMzNoWVUrZVk3bndCc3ZpZU1uYlN5cHV6Q0VY?=
 =?utf-8?B?S2tHUytMaTJGSCthREdZNGdaRWNaY1UwNVBBVnlpMGlGdStoc0tNQWM4b3d5?=
 =?utf-8?B?b2pHUExnS25vRlhWOWhyQTBQRURyWHNmTWhRZ2FFd1lTK3BKYmRUS2ZOQzlp?=
 =?utf-8?B?aGxkK0pMT1VPWWJlM0tyQk9uczg5YkpBSmdBSFUvQUc2NlVGelFCZ0dORGJr?=
 =?utf-8?B?WlFqQVVOckZWZk5TOEFoZm5PbUh5d1JCN0piYzVnU0g1VUIzTHdxeXo4K1dn?=
 =?utf-8?B?K1dRMTkvcWRnaEVLZkpyblEvcXd4dVpwVjJqanRydzdJZFhQbWhrdW1vWE9S?=
 =?utf-8?B?YnZsSERXUzJuanA5b0kwQmJGa2J3UGJuc2lodDdMQm1yWkhnc2ErT3VqTmU2?=
 =?utf-8?B?eHdxMDNqNCtqOVowSlJKVXUwWlFrbHptcEo1MVplcXY4Y3A3N1NNVzRSVVYx?=
 =?utf-8?B?VjNZdWozL1d3Sk1kQVFwZDVKSUVBdUN6YnQydkVqNGNBQ1FCdUhHVFBaNFJL?=
 =?utf-8?B?ZXlpdUtFUGhMTFVFYlM1alpUUGpIcXovU0lQajY2c1BPTWZOYmwzUTRvN3Z5?=
 =?utf-8?B?dndVbCszd0VtRElPNFFxTGdVZzAwcmZ5MFJRL3V6anNWbFowNVAyLzNXRTVp?=
 =?utf-8?B?bm5tQ0xVT2hlNGNqZ08vWjRsWkNoRUtiVHRxMlU1aklLdnZYQ1B5NzN1R0Nk?=
 =?utf-8?B?TkYzQUZoeHBnblo2WDVmcDhBeGNzU2RyMjRxdEFsbDBZa1EwRkw5a1BNUEE5?=
 =?utf-8?B?QXgrUk9NdHg2bHJ6OWpOZitpM24rV0xKSEc1SXVvTDBFZ1dGWFhibTZGazFZ?=
 =?utf-8?B?NnZ3R2hNZkhpLzJMeVp4M2phNUREVENDTWRsUmRIQnIwYy9kQnJFVzdoYndB?=
 =?utf-8?B?YWhNYnNacHZQMTBQVWRaWmRPNnZSdkpha1FyeHFDUXFwS1NoQTg5WFZQMnZQ?=
 =?utf-8?B?WGU3U2NWcUtaYkE1UXFTTG13M0JOU3RvMURIZlducnQ2MDNPc3VpVjlGVUhv?=
 =?utf-8?B?VkhJd0VsbG5JNjVQVjRWQnppT3Z6YVhpak1zNG0rQ0NmeTFVQmFWUE9VZWRz?=
 =?utf-8?B?WktIQnJybEZwWTlzUG83bFRoSit1QTR3UWJndms5aEppZENEQUNpOTFHclkz?=
 =?utf-8?B?ZmR5Q1VxcHl0Q05KMzU2NDNCQ0hkK2FxQmNqOFlNNlJyQ2VVS2RZUlFxNlFj?=
 =?utf-8?B?WE5QNFo0ZFY4RmVJUGVkR2VaR25Lbm5iKzAreVhFYllVZDh6aEpRSGZzZGpj?=
 =?utf-8?B?ZjhtK21odE1tcTFxOExzQmszdW1sdVNnUkZjT3pqRVhuUGRrUDREVU9rN09Q?=
 =?utf-8?B?VENMREJrVzQvNzM5V284cG01SGhYK0JZZWwxVkVXaWpObjRjYmdlaWNsOW9l?=
 =?utf-8?B?WDhETFMwWnJ4eGFzUUxxVE91SExnNHhILys5Z2x3UU44akordERRaXNUdkRp?=
 =?utf-8?B?bG01Z1FDMnYwNFFSVWlvOU5BY0I3L2E2Q011SnZkV2V6cEtwMGUrZURUb1lJ?=
 =?utf-8?B?VFA2WU03SEdOTEZPUHdVL2tVWUZVM0JZT3cxbGFEMXlsQXlLdWdMNlI2ajNr?=
 =?utf-8?B?MzZ6UTFBenZOTEhmZU1tdW5TOFVvQlpHci9LTjRlS0dFM1hxZElYYnN6NHMw?=
 =?utf-8?B?RWdxaXloS3dLK2NLZS9XUExOckhuQXRnRWM2L3F0Nnpka0lLZ3c5T0g1S3BS?=
 =?utf-8?B?aHNzOUx3MUJ2MGE3bnRKRXV3MVoybGFJUXdLYUo5UmsvOE1nSEJzSmlvdlh3?=
 =?utf-8?B?Q2NKeDRVRC9Lc0NOSzNoNHhudFF2RlRiTFVjNkl2bWlaczNXYTJHdUdFbGdt?=
 =?utf-8?B?UEFtbW96Y3dPMnBWTzNRejBFeDd0c3pCaktlWnZZYlkxbmxlNUxDcHgyTWZT?=
 =?utf-8?B?VEMyb3NDM25sRzVFeGpWRGhMaXFoY1VnKzRadVY4VDVwSjNYMW5GSFQ1TWNi?=
 =?utf-8?B?ODlxRmp5U2ppZnNLaG12T3NFMkpKRW1wRVVwaDdHcVBNdzBLZENGTnlkemwx?=
 =?utf-8?B?VVh2MmxLcEIwTFZqTXFRUDM2UGpGSEtkRUVPd0pKUktrWkhGMmk1MzRxeVM1?=
 =?utf-8?B?SVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3adee536-98a2-47c9-b26e-08daf7dd3a01
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 16:17:55.9214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7wMYByOB0pBZHaN1bWwoS5zaeZUB3LLC0Rjf7yP3/FbuQ+ZN2LSF6u3yT+tp0jEn9JeIzUakQPFYe3JWn41cRTnk7ZjnHCSon03ZEdzVq/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10809
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR2VlcnQsDQoNCj4gDQo+IEhpIEZhYnJpemlvLA0KPiANCj4gT24gVGh1LCBOb3YgMTcsIDIw
MjIgYXQgMTI6NDkgUE0gRmFicml6aW8gQ2FzdHJvDQo+IDxmYWJyaXppby5jYXN0cm8uanpAcmVu
ZXNhcy5jb20+IHdyb3RlOg0KPiA+IEFzIHBlciBzZWN0aW9uIDQ4LjQgb2YgdGhlIEhXIFVzZXIg
TWFudWFsLCBJUHMgaW4gdGhlIFJaL1YyTQ0KPiA+IFNvQyBuZWVkIGVpdGhlciBhIFRZUEUtQSBy
ZXNldCBzZXF1ZW5jZSBvciBhIFRZUEUtQiByZXNldA0KPiA+IHNlcXVlbmNlLiBNb3JlIHNwZWNp
ZmljYWxseSwgdGhlIHdhdGNoZG9nIElQIG5lZWRzIGEgVFlQRS1CDQo+ID4gcmVzZXQgc2VxdWVu
Y2UuDQo+ID4NCj4gPiBJZiB0aGUgcHJvcGVyIHJlc2V0IHNlcXVlbmNlIGlzbid0IGltcGxlbWVu
dGVkLCB0aGVuIHJlc2V0dGluZw0KPiA+IElQcyBtYXkgbGVhZCB0byB1bmRlc2lyZWQgYmVoYXZp
b3VyLiBJbiB0aGUgcmVzdGFydCBjYWxsYmFjayBvZg0KPiA+IHRoZSB3YXRjaGRvZyBkcml2ZXIg
dGhlIHJlc2V0IGhhcyBiYXNpY2FsbHkgbm8gZWZmZWN0IG9uIHRoZQ0KPiA+IGRlc2lyZWQgZnVu
Y2lvbmFsaXR5LCBhcyB0aGUgcmVnaXN0ZXIgd3JpdGVzIGZvbGxvd2luZyB0aGUgcmVzZXQNCj4g
PiBoYXBwZW4gYmVmb3JlIHRoZSBJUCBtYW5hZ2VzIHRvIGNvbWUgb3V0IG9mIHJlc2V0Lg0KPiA+
DQo+ID4gSW1wbGVtZW50IHRoZSBUWVBFLUIgcmVzZXQgc2VxdWVuY2UgaW4gdGhlIHdhdGNoZG9n
IGRyaXZlciB0bw0KPiA+IGFkZHJlc3MgdGhlIGlzc3VlcyB3aXRoIHRoZSByZXN0YXJ0IGNhbGxi
YWNrIG9uIFJaL1YyTS4NCj4gPg0KPiA+IEZpeGVzOiBlYzEyMmZkOTRlZWIgKCJ3YXRjaGRvZzog
cnpnMmxfd2R0OiBBZGQgcnp2Mm0gc3VwcG9ydCIpDQo+ID4gU2lnbmVkLW9mZi1ieTogRmFicml6
aW8gQ2FzdHJvIDxmYWJyaXppby5jYXN0cm8uanpAcmVuZXNhcy5jb20+DQo+IA0KPiBSZXZpZXdl
ZC1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4NCj4gDQo+
IFBlcmhhcHMgdGhpcyBsb2dpYyBjYW4gYmUgaW5jb3Jwb3JhdGVkIGludG8gdGhlIFJaL1YyTSBy
ZXNldCBjb250cm9sbGVyDQo+IGRyaXZlciBsYXRlciwgc28gcmVzZXQgY29uc3VtZXJzIGRvbid0
IGhhdmUgdG8gY2FyZSBhYm91dCBUWVBFLUEgYW5kDQo+IFRZUEUtQiByZXNldCwgYnV0IGNhbiBq
dXN0IGNhbGwgcmVzZXRfY29udHJvbF9yZXNldCgpPw0KPiBJIHVuZGVyc3RhbmQgdGhhdCdzIG5v
dCBnb25uYSBiZSBlYXN5LCBhcyBpdCBuZWVkcyB0byBrbm93IGFib3V0IHRoZQ0KPiByZWxhdGlv
biBiZXR3ZWVuIHJlc2V0cyBhbmQgY2xvY2tzLCBhbmQgaG93IHRvIGhhbmRsZSBib3RoIGNhc2Vz
IChjbG9jaw0KPiAobm90KSBzd2l0Y2hlZCBvZmYpIGZvciBUWVBFLUIgcmVzZXRzLg0KDQpZZWFo
LCB3ZSBoYXZlIGJlZW4gdGhpbmtpbmcgYWJvdXQgZGVhbGluZyB3aXRoIHRoaXMgaW4gdGhlIHJl
c2V0IGNvbnRyb2xsZXINCmRyaXZlciwgYnV0IGFzIHlvdSBwb2ludGVkIG91dCBpdCdzIG5vdCBn
b2luZyB0byBiZSBzaW1wbGUsIGFuZCB0aGVyZWZvcmUNCml0J2xsIHRha2Ugc29tZSB0aW1lLiBU
aGlzIGNoYW5nZSB3aWxsIGd1YXJhbnRlZSB0aGUgY29ycmVjdCBiZWhhdmlvdXIgb2YNCnRoZSB3
YXRjaGRvZyBmb3Igbm93LCB3ZSdsbCB0YWNrbGUgdGhlIGxhcmdlciBpc3N1ZSBsYXRlciBvbiwg
aWYgdGhhdCdzIG9rYXkNCndpdGggeW91Lg0KDQpUaGFua3MsDQpGYWINCg0KPiANCj4gR3J7b2V0
amUsZWV0aW5nfXMsDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBHZWVydA0KPiANCj4g
LS0NCj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJlJ3MgbG90cyBvZiBMaW51eCBiZXlvbmQg
aWEzMiAtLSBnZWVydEBsaW51eC0NCj4gbTY4ay5vcmcNCj4gDQo+IEluIHBlcnNvbmFsIGNvbnZl
cnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxmIGEgaGFja2VyLg0K
PiBCdXQNCj4gd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qgc2F5ICJwcm9n
cmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZQ0KPiB0aGF0Lg0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzDQo=
