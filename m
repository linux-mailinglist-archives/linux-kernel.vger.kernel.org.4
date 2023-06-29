Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F99741ECA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 05:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjF2DkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 23:40:24 -0400
Received: from mail-db3eur04on2045.outbound.protection.outlook.com ([40.107.6.45]:32809
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230466AbjF2DkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 23:40:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXyozOfpDv0HmoZjejv1/v9TDYs2s6L6dGH4CEmy4GJencnYlwvYRFoXUGOVKLw+haUMLP/BhMb4NGjGAWuLDkZP4Ij20mCl6xeO87P+PflOYuD5ZHTBfyz/Ffkdimon6refPN3HIai1+IiBcVsRW4pYii7LqcdUZQogJblyw7Z7tPE99AxBi9mcaKdqJk//TW39cikb7qgxDLv6vu6Yoorxm7IjueG9JgSq2+X6G3vfPQlc8k8ZOf7Dx7l9EUbbhI7mZZSCUzshIvA73T44cef8eV2LFBQLzxbU3cAwos+WSJPPsrUAVcJ4a+TwraTpsfOFqXVfuS6K/2N37ip42w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPcaNyT389bC1YdfG0mj+vrSrbrj+UBVg1Ufi17k3Jg=;
 b=SkYjFw7pFpZGZAnmfAKpmlnfxyTZoBgkeDd7gKtmFxQ6prlDK0YefI+ZDf1/5K3JNV1qStPB6zusuh9DTR2SerTzjxTGqfuEeJC77qPnkHGHQ7GwHuRL6dEQu9ONVdYcKOAOppqIQjHXvdtZUTCEawnFi0vBMNP0WudxyJ9VfbkGGLs06kXHJKLxJAQRn40FBM4T7lGj44J0sh5vrWNPUxNOWQsWArANAU1nPWeKIfirbyKxSipZLqtTRmcnLD825dZppUB8yN175Sg++REbpYj2lIwuzY8g1pFnDPnfPf+mNgZSmrLxNWcSlLez/DZq91IK1KGDZjhcHCT4EJM/Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPcaNyT389bC1YdfG0mj+vrSrbrj+UBVg1Ufi17k3Jg=;
 b=cGZeEN6wF4r9s+Y80hrGp5QYjhDhfOiBh66PPi3yaGj8j7Q2aJYQxoHZxF2p83nBqT8QAY4Xbofco7PBS7eqKLZ1V4Kax4YNVDlFJ9NdUmDaY9vaGd4AnF0G97MqKP0Kv93MHhQ56Fu+adE/LhbhPnMfyzio9OrhKH5iebzBG+A=
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB9194.eurprd04.prod.outlook.com (2603:10a6:10:2f9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 03:40:18 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::4a2a:262e:415f:e41c%7]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 03:40:18 +0000
From:   Frank Li <frank.li@nxp.com>
To:     Roger Quadros <rogerq@kernel.org>,
        "r-gunasekaran@ti.com" <r-gunasekaran@ti.com>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>,
        Jun Li <jun.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Elson Roy Serrao <quic_eserrao@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?utf-8?B?SsOzIMOBZ2lsYSBCaXRzY2g=?= <jgilab@gmail.com>,
        Prashanth K <quic_prashk@quicinc.com>,
        Peter Chen <peter.chen@kernel.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH 1/1] usb: gadget: call usb_gadget_check_config()
 to verify UDC capability
Thread-Topic: [EXT] Re: [PATCH 1/1] usb: gadget: call
 usb_gadget_check_config() to verify UDC capability
Thread-Index: AQHZqg9cJmDWJzO0YUW2RAkaqvNJkq+hHfUAgAAAmtA=
Date:   Thu, 29 Jun 2023 03:40:18 +0000
Message-ID: <AM6PR04MB4838E7A9B41AB382DAAA35038825A@AM6PR04MB4838.eurprd04.prod.outlook.com>
References: <20230628222437.3188441-1-Frank.Li@nxp.com>
 <42940cae-ce4f-577a-474b-f06b3b481e4e@kernel.org>
In-Reply-To: <42940cae-ce4f-577a-474b-f06b3b481e4e@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB4838:EE_|DU2PR04MB9194:EE_
x-ms-office365-filtering-correlation-id: 87de2387-f0b2-4d4b-d963-08db78528f0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dT5q8i/nNNLeFdHCNYAv4O7WyygM7VtbEHPskz++E/zwERTA2ZSL86TJCSB/8fUACxF1evgiupMZ6Lo5Yr3AReWWRIDXUAqK/P80QXqNzEFCqpCBtDtk3emcp5ynYygy4Ji1t1Pl8mCO6VTYCxjtye4Yu2eGm1OskDdZSvz12gpoMroqQcp+xqvqZcz6LFXLHrnjWAko4RvB890BuaL33p2mTYfOkK86vNooDT7ZyUoXoOtAPPLwVvN7P1m63quJSPy65w7YwiYoXAxpOaLCaV5IgkAXJLr7KMeBFDAV80M+RAl3rHJjLwxMB4PXvrFh/CYcrA79ZCJ7sFqHxO+Gnzw39vPhnQirzl76NhJpsA1kFyExU2X2udsDqwy5fCy5Do5kU4lryqF2gtI1mE+L9iPq4uSh944ggJqdjJCA3of0ec0/jeNXNPvgVbRQJSF54r4U2gncD3lT34aqhsmuO12+p7r/HeZaFFRufmfWSL+AK6uMz/NukWEGiNep6zB503c09ROu3bipZ+xzYx8uavRnW32iPVdAg8bkuW8auxfTccNzjmbkUjJij/eDiKMpHC4SjnN7HmNM+KDFL0eIQVo2OWElSsJt/bxDd3dYzVfYqMcRI47uaWilITKEoY2v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199021)(38070700005)(478600001)(110136005)(86362001)(41300700001)(55016003)(33656002)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(2906002)(316002)(7416002)(966005)(44832011)(7696005)(52536014)(5660300002)(55236004)(6506007)(53546011)(186003)(26005)(9686003)(83380400001)(15650500001)(71200400001)(8936002)(8676002)(38100700002)(122000001)(921005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzBKUjFMMjhqL1BjaTlwQmYvNStJUWVlVXNjUFEzOFF5Wk1ZUGh4MFZwMWlQ?=
 =?utf-8?B?NGtkN2xnV0pFSm5qck5uMFN3cWpTanE4N0UrQWV1M1RiZzRLeHdsYnA5a2tu?=
 =?utf-8?B?T3hSVDFDd2Rxa0lKdWZPeEtzVlNNdzIxRHNzZFJRWEV2c2dHd0NOSUxOOEdz?=
 =?utf-8?B?blJ5NXB1ME9qSkZrM2wyODJMYWxIVGM5amVGRGpkZUVxaEVBZE9qYmF4Vklr?=
 =?utf-8?B?NWNNQ0VmLzgrZkNLY1VHY0ZFSE9NK1RPR3UyOE1EbHZ0SnpUUW1CTUkxRldu?=
 =?utf-8?B?MXFkbUNMSmUvRzNUSEpIeGxObCtLYXdtNmlEbkxEcUdmOG9nOW5oTlZtd3Zy?=
 =?utf-8?B?VjFTMmtsTFVLTmNxQWtWWVRDbnp1MjFPdS8wcTV5bVYvVC9SZUJ4eFF3dWZB?=
 =?utf-8?B?Vmt0SU56ckk5MDZ0dndHRnVERW13Vi9yUUI5azgrWGNrSnlZUkJYKzUzeFNN?=
 =?utf-8?B?Q01CTW1tVkNERE5oVE13OERHQkpJdkl4TFBaRWhHNzZPUVZzb2hOQ1hhcms1?=
 =?utf-8?B?R2FMU1hscEE1a2c2UEZIM1hrd0UzeExKQU9PVzR3ZU4yeHY0OEV1ZXpwNzRs?=
 =?utf-8?B?akE3MjdJMWNTcUY3bFlqQk9YbENIYUdJUkkxbmkxSmtyTGllWkhRM2dPWFh0?=
 =?utf-8?B?cU9aSmVrVjRBTEp1ai9hdG5ZMTJOcnJDWHA2eU9NUDBWQjNTVWFkbGVuVDBh?=
 =?utf-8?B?YjJ4SGNkYTUyeTlFYnJDUDNOZU5WZmF1aWM5dGtGZ2dsbHJJOGZwMHZCSTNv?=
 =?utf-8?B?MVpoTDhIcVRxTm81aTgxSzNwT3hRRlhWZzZBWHRwU1BxaDNVWXNvdmErUm4y?=
 =?utf-8?B?RThWYXU3R2c4elJDdDBBNm1IRitiUllveDJvUnl6M1BZdjhIcFpjWnpuWm4v?=
 =?utf-8?B?SUFzcERGNS9pTkVPRnlidjBIVHVzNGRYUndtRitFaEJRY25WTmNodHdPTkxU?=
 =?utf-8?B?VXFaYllIWi9aZk5FV0pwU2lxQ2QyVTV4UjE2bXE0amloQUVvRDlnNGVjME1V?=
 =?utf-8?B?ZEphTFAvTy84SHBJY01velROWmlZejhzSWFmRG5sb3BLSlBoMnpjL0hQekQx?=
 =?utf-8?B?SFBzcjFXU1NPTmU2emx3SVo0Z0ZyZkFab0t6VzVWSnMvdjk3ZTU4bENPUkRM?=
 =?utf-8?B?emJjV3k4MjllbDlHMlQ5dUVzTHFoL3RGTU1hSHljWFlaRjlMQVpEOHRieUQv?=
 =?utf-8?B?RnhDTVlXUjdYUGtmcU5tSFJ1YTJGR296dUZMcGlrVnFSbmJuaDUwcXhpMzdK?=
 =?utf-8?B?V2J0OUdYN1UrQlVuZjZXcEdRb2c5NXkyYWZIcWZIaE5neXhsdFpFZzBvK3d2?=
 =?utf-8?B?M1ZMTENOTTdKRXZsS0l2eW5KS0I4SGNkdUVoYkpMS2pQaXZMWUIxejFma1JH?=
 =?utf-8?B?b2VRRVgrMG5BR1p4ZnZ4cktBMERLeTVBNk1vQmFNaUpFQlZNQU9YMzR1QU05?=
 =?utf-8?B?L0JUaG5lcnh2NHd3ai9VdWtMR21YQjFNTDFvZytCQWczMHhtMnhIWlVGR0Zu?=
 =?utf-8?B?Wk9hMi9jK25HUS9XQ1BadjdBb3RvV0J0RTNBVmgvdE9nYlVBM2krS29oTkJY?=
 =?utf-8?B?c0M5cUNzazduL0RzQXV1VUhoQ0dCRHVFNldyUmVXcWttUVJCZTZJTEx5aFRv?=
 =?utf-8?B?RjdFbytUTUthWTZIVENPbGFGbng3WlQ5WmRkU1lrL2IwekcwOENFTmVMeVhm?=
 =?utf-8?B?VkdGcGRjQXVYditpNFBHLzYvbUdTYXQyd2M1Yms1OGluUWRjdC9Zc0ZuSjlw?=
 =?utf-8?B?QmpoMlJ1RnBucVp4NVhCV20wM0xDMi9zaldpb1RsZklWSFZKVTNHemNENyt0?=
 =?utf-8?B?TGNnQ29IS0crN2JEdVBNc0NJNUFtUEIzRlhUN0oyKzVWam8rOWhZZ09zeDdO?=
 =?utf-8?B?Nm9BTVhQeDJuWEE3ekx2THRObzUxQlQrVlpyRWo5WWZJT093NzFCaUlwc0JY?=
 =?utf-8?B?UE84OXFTd21sR1hiMWFBbURQS2ZpNTltTjg4OVZHQytNYmpiVGVVa21ET2lk?=
 =?utf-8?B?S2tTWEVad08yMUVUQlpsME1BbVBjQkI1c1lDRGhXN3ZUcW9BOEJlMHBvRUlI?=
 =?utf-8?B?RWRXZWd3Q1F2VkdCTWVOVkkxTStRK296TmZYbVdaNVBCLzk1alM0TWZkUTln?=
 =?utf-8?Q?MiiU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87de2387-f0b2-4d4b-d963-08db78528f0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 03:40:18.5302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 02vo4U7mIZ0v3JJLIX6PA4/QVAtr1/jlGqD6EEk8DSMBMOGb6KjjG5TkMxpQcYsU8Syi9wLNoM1hoBSsuinIHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9194
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9nZXIgUXVhZHJvcyA8
cm9nZXJxQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSAyOCwgMjAyMyAxMDoy
MyBQTQ0KPiBUbzogRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyByLWd1bmFzZWthcmFuQHRp
LmNvbTsgaW14QGxpc3RzLmxpbnV4LmRldjsNCj4gSnVuIExpIDxqdW4ubGlAbnhwLmNvbT47IEdy
ZWcgS3JvYWgtSGFydG1hbg0KPiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+OyBFbHNvbiBS
b3kgU2VycmFvDQo+IDxxdWljX2VzZXJyYW9AcXVpY2luYy5jb20+OyBUaGluaCBOZ3V5ZW4NCj4g
PFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+OyBBbmR5IFNoZXZjaGVua28NCj4gPGFuZHJpeS5z
aGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT47IErDsyDDgWdpbGEgQml0c2NoIDxqZ2lsYWJAZ21h
aWwuY29tPjsNCj4gUHJhc2hhbnRoIEsgPHF1aWNfcHJhc2hrQHF1aWNpbmMuY29tPjsgUGV0ZXIg
Q2hlbg0KPiA8cGV0ZXIuY2hlbkBrZXJuZWwub3JnPjsgb3BlbiBsaXN0OlVTQiBTVUJTWVNURU0g
PGxpbnV4LQ0KPiB1c2JAdmdlci5rZXJuZWwub3JnPjsgb3BlbiBsaXN0IDxsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIDEvMV0gdXNiOiBn
YWRnZXQ6IGNhbGwgdXNiX2dhZGdldF9jaGVja19jb25maWcoKQ0KPiB0byB2ZXJpZnkgVURDIGNh
cGFiaWxpdHkNCj4gDQo+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFz
ZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBvcg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRz
LiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQNCj4g
dGhpcyBlbWFpbCcgYnV0dG9uDQo+IA0KPiANCj4gT24gMjkvMDYvMjAyMyAwMzo1NCwgRnJhbmsg
TGkgd3JvdGU6DQo+ID4gVGhlIGxlZ2FjeSBnYWRnZXQgZHJpdmVyIG9taXR0ZWQgY2FsbGluZyB1
c2JfZ2FkZ2V0X2NoZWNrX2NvbmZpZygpDQo+ID4gdG8gZW5zdXJlIHRoYXQgdGhlIFVTQiBkZXZp
Y2UgY29udHJvbGxlciAoVURDKSBoYXMgYWRlcXVhdGUgcmVzb3VyY2VzLA0KPiA+IGluY2x1ZGlu
ZyBzdWZmaWNpZW50IGVuZHBvaW50IG51bWJlcnMgYW5kIHR5cGVzLCB0byBzdXBwb3J0IHRoZSBn
aXZlbg0KPiA+IGNvbmZpZ3VyYXRpb24uDQo+ID4NCj4gPiBQcmV2aW91c2x5LCB1c2JfYWRkX2Nv
bmZpZygpIHdhcyBzb2xlbHkgaW52b2tlZCBieSB0aGUgbGVnYWN5IGdhZGdldA0KPiA+IGRyaXZl
ci4gQWRkcyB0aGUgbmVjZXNzYXJ5IHVzYl9nYWRnZXRfY2hlY2tfY29uZmlnKCkgYWZ0ZXIgdGhl
IGJpbmQoKQ0KPiA+IG9wZXJhdGlvbiB0byBmaXggdGhlIGlzc3VlLg0KPiANCj4gWW91IGhhdmUg
b25seSBmaXhlZCBjb21wb3NpdGUuYy4gTm90IGFsbCBnYWRnZXQgZHJpdmVycyB1c2UgY29tcG9z
aXRlLmMNCj4gc28gaXQgd2lsbCBiZSBzdGlsbCBicm9rZW4gZm9yIHRoZW0uDQo+IA0KPiBQbGVh
c2UgYWxzbyBhZGQgZGVmYXVsdCBzYW5lIGNvbmZpZ3VyYXRpb24gaW4gQ0ROUzMgc28gaXQgd29y
a3MgZXZlbg0KPiBpZiB1c2JfZ2FkZ2V0X2NoZWNrX2NvbmZpZygpIGlzIG5vdCBpbnZva2VkLg0K
DQpXaGljaCBvbmUgd2FzIG5vdCBjYWxsIHVzYl9hZGRfY29uZmlnKCk/DQpEV0MzIGFsc28gdXNl
DQogLmNoZWNrX2NvbmZpZwkJPSBkd2MzX2dhZGdldF9jaGVja19jb25maWcsIA0KaHR0cHM6Ly9n
aXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0
L3RyZWUvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyANCg0KSSB0aGluayBpdCBpcyBub3QgY29y
cmVjdCBieSBhc3N1bWUgVURDIGNhbiBzdXBwb3J0IHNwZWNpZmljIGNvbmZpZw0KYXQgZ2FkZ2V0
IGZ1bmN0aW9uIGRyaXZlci4gDQpBZGQgZGVmYXVsdCB2YWx1ZSBvZiBDRE5TMyBhY3R1YWxseSBo
aWRkZW4gcG90ZW50aWFsIHByb2JsZW0uIA0KDQpJIGRvbid0IHN1Z2dlc3QgaXQgYmVmb3JlIGZp
eGVkIGhpZGRlbiBwb3RlbnRpYWwgcHJvYmxlbS4gDQoNCkZyYW5rICANCg0KPiANCj4gPg0KPiA+
IEZpeGVzOiBkY2U0OTQ0OWUwNGYgKCJ1c2I6IGNkbnMzOiBhbGxvY2F0ZSBUWCBGSUZPIHNpemUg
YWNjb3JkaW5nIHRvDQo+IGNvbXBvc2l0ZSBFUCBudW1iZXIiKQ0KPiA+IFJlcG9ydGVkLWJ5OiBS
YXZpIEd1bmFzZWthcmFuIDxyLWd1bmFzZWthcmFuQHRpLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBGcmFuayBMaSA8RnJhbmsuTGlAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy91c2Iv
Z2FkZ2V0L2NvbXBvc2l0ZS5jIHwgNCArKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvY29tcG9z
aXRlLmMNCj4gYi9kcml2ZXJzL3VzYi9nYWRnZXQvY29tcG9zaXRlLmMNCj4gPiBpbmRleCAxYjM0
ODkxNDllNWUuLmRkOWI5MDQ4MWI0YyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9nYWRn
ZXQvY29tcG9zaXRlLmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvY29tcG9zaXRlLmMN
Cj4gPiBAQCAtMTEyNSw2ICsxMTI1LDEwIEBAIGludCB1c2JfYWRkX2NvbmZpZyhzdHJ1Y3QgdXNi
X2NvbXBvc2l0ZV9kZXYNCj4gKmNkZXYsDQo+ID4gICAgICAgICAgICAgICBnb3RvIGRvbmU7DQo+
ID4NCj4gPiAgICAgICBzdGF0dXMgPSBiaW5kKGNvbmZpZyk7DQo+ID4gKw0KPiA+ICsgICAgIGlm
IChzdGF0dXMgPT0gMCkNCj4gPiArICAgICAgICAgICAgIHN0YXR1cyA9IHVzYl9nYWRnZXRfY2hl
Y2tfY29uZmlnKGNkZXYtPmdhZGdldCk7DQo+ID4gKw0KPiA+ICAgICAgIGlmIChzdGF0dXMgPCAw
KSB7DQo+ID4gICAgICAgICAgICAgICB3aGlsZSAoIWxpc3RfZW1wdHkoJmNvbmZpZy0+ZnVuY3Rp
b25zKSkgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdXNiX2Z1bmN0aW9uICAg
ICAgICAgICAgICpmOw0KPiANCj4gLS0NCj4gY2hlZXJzLA0KPiAtcm9nZXINCg==
