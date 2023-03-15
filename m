Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E72E6BAC9F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjCOJvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjCOJu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:50:59 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2040.outbound.protection.outlook.com [40.107.249.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD25227AD;
        Wed, 15 Mar 2023 02:49:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+1hWU03pEchaSNgDVkEIuqKnHh/oM2vKiGeOqrYt/bwM69+AlSCLax0qCbEb7N7/jG+XM0RaBk065LIoI3UVH9aQ+/DUjHslkjd5ladMsyAApmIUBiSklEXO2gpoWQPkM4SUB0e0n0R3PDNBZ5N0DtK6nyLGMdRI9pltTuPpPaqajWoHNiZerGmKOlr4wmFHkKfZ+KR4C2WZtNBKaoOp78ElcsFnFiawPV/Vw7b9lvsCqFvNRIMfSGjDjXOf2V2Rk27eunHcMiJ1BPWa0kxBNa+ik4AaPMSZ3pldvI10IAPYyyBgtcDj+9fjamaY+zM5Ztk4W0RDPd/2d7qm2geug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+WCKZX0xr3scMGoR8aJbY18jKEmsgH136Jr8OOomBs=;
 b=IClhQh2uVhbWkpI5Jj+IinZq+8AHs0dbF0M7a8fDax1YQVqm1mbPCxn14caL9nMSZP433f4CUShdHndMdkKRX3z6Da8wRvmlWhNUyHCpF55a3N229V1Xx4ICr4RGhzYLg77hxJowMEJs4YA2+r9Eqb7eoezI7d/H/UQjJq49V8fWSu7nd9tR/dYwIp7qO5EPXi3ADYCt10d8aRYtRSvb2IdCGhkXlJX3OmZPT4is/AbnoYuPMKsLnjnB7xdvaG5/mDjZ4z2TSick2DdVnqqw9AyygVDwN/LzNyueIlHuRYRpPD7KX/wLQGFOt42W38h1qy+HBGcRogQ42dcb0U4Zww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+WCKZX0xr3scMGoR8aJbY18jKEmsgH136Jr8OOomBs=;
 b=XsKRBe+BEqMTLWcAKgCh85Ue874miQiCfNm3b5narEwz5l1tVJHZOqkGx3ZYj4ebNrVu9szr54NKMHv/W7pj8P062Cx8OEl6GSQaLYIWsAG4ewlJpIxWjWy/53IRpQoL6na76suFeZwXDtCwQD0mYJbQJB+4UwmAZtfLA2Y3HOk=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DBBPR04MB8057.eurprd04.prod.outlook.com (2603:10a6:10:1f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 09:49:53 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3079:f55a:740e:c103]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3079:f55a:740e:c103%9]) with mapi id 15.20.6178.029; Wed, 15 Mar 2023
 09:49:53 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] tty: serdev: serdev-ttyport: set correct tty->dev for
 serdev framework
Thread-Topic: [PATCH] tty: serdev: serdev-ttyport: set correct tty->dev for
 serdev framework
Thread-Index: AQHZVw9OUac0kayKm0KF91nNt7mFIq77dH6AgAAIVPA=
Date:   Wed, 15 Mar 2023 09:49:53 +0000
Message-ID: <AS8PR04MB840408DC92F4001AB440353292BF9@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20230315072143.7815-1-sherry.sun@nxp.com>
 <ZBF2Pyd4VSZq3HoA@kroah.com>
In-Reply-To: <ZBF2Pyd4VSZq3HoA@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|DBBPR04MB8057:EE_
x-ms-office365-filtering-correlation-id: adccf763-3d3b-4878-e324-08db253aa065
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X6RNBfEPwDZrc8RAvPIEUwXMa2MBtWLyZ6G4bdT5Rx6/ALlFcqb6mLByf3aYkLrFuhHrZEt2xg2LupdClecjp7LddhvNoulcR08BpnGmX4z04peBtpdtx+rlWm0i3WtQNY/Ix33fK7+67UQnro1aOhj79vAIyRkoTQF1IIWAt046JofAZgoyCCu3hpBvPAsT09XI4ZgFRzcwUMQf7IDlvB9iKGCFOicmLHaEUBWiR77K5PP0XbV7MnIDJ60hGEar7WxYS5EAFUrrOmGGeymNGpoC1GBxpa81Ut59HLbTJVWK+a/rXn1brPEkm7apY8AOwyhlH8gKBHtmUKA8OBJb3T4GPOrIpuBfrhbRFakoAz/T8/tufPz1eNnzYfbimodcGYOngajooRQllhBkFaz8ZNLN4UquKO0j4CUDyIhPPuo1gt6tPzHY3xjeSk8/7FKN/jW/WEvbigH8DCD0RJBS+cXVI4yvBI7i91udWgEsqLNohQgRQhK4px2y+QQNHCH1ISanUQh4OagjOz/pWYQov0L0C/VTKVpZUn+pWtGEBRGN4ptTm7UzEUQ4ADfFHBa7gw6WeaWN5sBXYcVLgK7IlzO6M99+FmlXuxzTDASR4upVmFyiGgOWSOBzzIvmt5zBBPzd06xvz9g61Cjout5gwqz760liQz+vZEXfkEkfDCwiBEZ8h9MmM/Ud/PEH7bowHiCUI8wuzeHlzmyQF8TtWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199018)(38070700005)(86362001)(33656002)(122000001)(38100700002)(44832011)(2906002)(52536014)(41300700001)(5660300002)(8936002)(55016003)(4326008)(6916009)(186003)(83380400001)(6506007)(9686003)(26005)(53546011)(54906003)(316002)(8676002)(66476007)(76116006)(66556008)(64756008)(66946007)(478600001)(71200400001)(7696005)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VTU1UkwxZUtZSmZDSFp1QVBvTmZGZlExUU11bXJJNDBtYzdMMUk4S3NwK3VZ?=
 =?gb2312?B?QTFJY3JlOWVrVzNFeWt0QlNpaWk1Y1JrY0lJUDlubnZlQ2VxZ0ZmMk52cnNB?=
 =?gb2312?B?M2tkMGVIcTY2N2NtSFBTZ0lsQnFyeFFCV3FYQVlVT2lVVHZZQTJnNmxKVnZY?=
 =?gb2312?B?RGVuZ3NZbUFGaHV5aGtiQlJISlZ3NkVVSW4rN0tzbUhvSHJLc0wzUmdUbXQ2?=
 =?gb2312?B?UjZnQUhUaDhFaVJGanlMQ3FRUnErRDJsVXRXcWlyMWFxU0xPaFM1bk45aVRF?=
 =?gb2312?B?UVRLZXYwV00vK3RxYWxzRElxRXo1RnVRSmRRbWJoMFRqRG5yVE5YNUhjYkxM?=
 =?gb2312?B?bHhMR1U1cC9ZSk1Wc1Bydk9FZjFjSWE0L1lLL0JPSE8xTVhNd1hmU3h2TUx6?=
 =?gb2312?B?T2pmZGt4ei9iUTV0NElUbWIvTWQ1cHVOR1dWWDJraEtTaTZNMkx6c09XeFRj?=
 =?gb2312?B?UjhhVEt2SmVXUXFsVEVaSDRzSXY1U1BVTDdIL2pOSzhFSy80UGdXaDBpSnRW?=
 =?gb2312?B?Wm9ncnRnd1ZieUlITTY5MVkzV2lrT0ZFZkg2VEZBSW5mK2xja3prYkNrNzlM?=
 =?gb2312?B?cy9ZdG1wWG0xK0JKbHhUYjB5d3gzWUxJMTgwYmxhMkk2eHNtUm9iU1VwU3Z4?=
 =?gb2312?B?Tmd2RCtUbURmT3FFZ1EzVnhtT0hNVStJdWVlMDZhZkVVVEJUUklFZXhNTWpF?=
 =?gb2312?B?V0wxdjNMWGozbzQvNGVGa1RGMDdib3NVWENCOHFteFNaRFdtMFFIMXpxamlS?=
 =?gb2312?B?U2t1RFJWNkZVTFlWZzY4elFvQmd4T1d3dDFKTktneTJqYlRjWnU4SUdpS2Fz?=
 =?gb2312?B?WC83V1ZGRXN4QW1TUXpOcDFaYjNvb2ZycUk5RUZCT2hkWkVSeFN3U2U1dUI4?=
 =?gb2312?B?VG1xZDNXWERVMDFPanlDMDIwVDJITDhmdC9mNkZiR0ZkeUZFa0xZYU9zSWxv?=
 =?gb2312?B?TVU3ME9IYzhkUHNQWW81bVFUTWx2RU9WQVFtRlkwREU5UGdzRTZibGVXWGVL?=
 =?gb2312?B?TmJCTS9KUE4vMkxFYUgrSlRhbk96MzFPdFFtNVNEVE9WdFFvRmpJYlpjc3gr?=
 =?gb2312?B?UzFMbllsMDNDOStKUnFUVGJlSjNSaVRENFBoSFBlNHhLK0FrWmU4b1l1WjVs?=
 =?gb2312?B?ZmozanA1MmhCNzQvSTVlT29Fa1hwT3Yybi9jek9xOThTZWVCVEQxcFZyWnlv?=
 =?gb2312?B?V3h6dlM5Zlc2NnFOYllzMXFDeXRGU1JXeEZCTWY5UmQwWS9SM3BtVG9kQjY5?=
 =?gb2312?B?WXp0UVVCQjJpOE1vS2h5aFlNOHRvRXExQUVtM2V2VTFkQmdWTDFrdjBLTFdm?=
 =?gb2312?B?NW5OM3Z6UW5UaDgraWwrK25NL2p3UElzbHgvWWRWV3NyWjY0a1lpdmFwcGFq?=
 =?gb2312?B?eEt0TUVIVDZDVVpUeTVaVFhiYTVqclZ2a1QxUjdTY3JEY3JBTDM0UVhsRnBy?=
 =?gb2312?B?WEJtOFppRzk1M05kYno1Uk5RL3JYZ0ppTisvSTFmWWZuOU0vM3ZDVlpYZGZN?=
 =?gb2312?B?SklUZ0xFK3RUOUptZThjanUvNEFKSWNQLzBhUkNrQVhCRStTMVdiNlN3YVdv?=
 =?gb2312?B?VDNXTTV0VytnaW5IYkdrVjZvd0RMTDhRU2Y0VnBBaTdrSHlNYjByTVFSSitE?=
 =?gb2312?B?TnNlYzU2a01WSm14UWVmUkgrSjBSeTJZNk5lZjF0OEpOYkFUQkZzNGNPYUpJ?=
 =?gb2312?B?MWoyMmlnanFMcmQxMng0OEV1QWNQc29uU0N3eVVQSVZQNEdjYXZ6NWxIUlAr?=
 =?gb2312?B?a2ZHY2lMQ0lRc0tBalVHeEd0ZnorUUxRL205ZWRuNlZhVEp3cDVaSGxtRTV2?=
 =?gb2312?B?WEtXdkI0eFZybEhxWGNlK3FMeXZxK21vMGRYVGJIbzJNTm1LaU52cHFCeitB?=
 =?gb2312?B?MEx3TzRQaG5aOEkxR2pUU0lXZFR0TEc2ejdDNlptaG5uOEI5V2dia1VsMUl4?=
 =?gb2312?B?UVhoQzcwZEVIdEpBRGdtTExVeE9VOFhkM0lCcUl5R1lOYjlObXhpcU8xSXVO?=
 =?gb2312?B?UVk1MnBGeUJFR2Z0MWRIbVFkYVFiVHRyaWVYNmJIaE5nR3d1SEtMcFNFNjZW?=
 =?gb2312?B?VHZyazZmUVlyVVZGMklhUk5ISUpVbDNwK3ZSZ0VyZlZyRjhWeW5EL2srSk1l?=
 =?gb2312?Q?KWicvU7+q4Hm5xTF0tDgoC7qL?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adccf763-3d3b-4878-e324-08db253aa065
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 09:49:53.1795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CQGTm+tBgoRYSGgKqmHvCkl0R1PYfbrOfnx5PArMCVMVivGbENAzgR24P8VF6dFfBHp2c0BMP83CPPYqnG0oWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8057
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3JlZyBLSCA8Z3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+IFNlbnQ6IDIwMjPE6jPUwjE1yNUgMTU6NDANCj4gVG86
IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4NCj4gQ2M6IGppcmlzbGFieUBrZXJuZWwu
b3JnOyByb2JoQGtlcm5lbC5vcmc7IGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHR0eTogc2VyZGV2OiBzZXJkZXYtdHR5cG9ydDog
c2V0IGNvcnJlY3QgdHR5LT5kZXYgZm9yDQo+IHNlcmRldiBmcmFtZXdvcmsNCj4gDQo+IE9uIFdl
ZCwgTWFyIDE1LCAyMDIzIGF0IDAzOjIxOjQzUE0gKzA4MDAsIFNoZXJyeSBTdW4gd3JvdGU6DQo+
ID4gdHR5cG9ydF9vcGVuKCkgY2FsbHMgdHR5X2luaXRfZGV2KCkgdG8gaW5pdGlhbGl6ZSBhIHR0
eSBkZXZpY2UsIGJ1dA0KPiA+IHR0eV9nZXRfZGV2aWNlKCkgY2Fubm90IGdldCB0aGUgY29ycmVj
dCB0dHktPmRldiBmb3Igc2VyZGV2IHR0eSBpbg0KPiA+IGFsbG9jX3R0eV9zdHJ1Y3QoKSwgYmVj
YXVzZSBzZXJkZXYgZnJhbWV3b3JrIGRvZXMgbm90IHNldCB0dHlfY2xhc3MsDQo+ID4gc28gY2xh
c3NfZmluZF9kZXZpY2VfYnlfZGV2dCh0dHlfY2xhc3MsIGRldnQpIG1heSBhbHdheXMgcmV0dXJu
IE5VTEwuDQo+ID4NCj4gPiBGb3Igc2VyZGV2IGZyYW1ld29yaywgd2UgbmVlZCB0byBhc3NpZ24g
dGhlIGNvcnJlY3QgY3RybC0+ZGV2IHRvDQo+ID4gdHR5LT5kZXYuDQo+ID4NCj4gPiBGaXhlczog
YmVkMzVjNmRmYTZhICgic2VyZGV2OiBhZGQgYSB0dHkgcG9ydCBjb250cm9sbGVyIGRyaXZlciIp
DQo+ID4gU2lnbmVkLW9mZi1ieTogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL3R0eS9zZXJkZXYvc2VyZGV2LXR0eXBvcnQuYyB8IDEgKw0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3R0eS9zZXJkZXYvc2VyZGV2LXR0eXBvcnQuYw0KPiA+IGIvZHJpdmVycy90dHkvc2Vy
ZGV2L3NlcmRldi10dHlwb3J0LmMNCj4gPiBpbmRleCBkMzY3ODAzZTIwNDQuLmJiYTM3YWI5MDIx
NSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJkZXYvc2VyZGV2LXR0eXBvcnQuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvdHR5L3NlcmRldi9zZXJkZXYtdHR5cG9ydC5jDQo+ID4gQEAgLTEx
Miw2ICsxMTIsNyBAQCBzdGF0aWMgaW50IHR0eXBvcnRfb3BlbihzdHJ1Y3Qgc2VyZGV2X2NvbnRy
b2xsZXINCj4gKmN0cmwpDQo+ID4gIAl0dHkgPSB0dHlfaW5pdF9kZXYoc2VycG9ydC0+dHR5X2Ry
diwgc2VycG9ydC0+dHR5X2lkeCk7DQo+ID4gIAlpZiAoSVNfRVJSKHR0eSkpDQo+ID4gIAkJcmV0
dXJuIFBUUl9FUlIodHR5KTsNCj4gPiArCXR0eS0+ZGV2ID0gJmN0cmwtPmRldjsNCj4gDQo+IFdo
YXQgaW4ta2VybmVsIGRyaXZlciBuZWVkcyB0aGlzIGNoYW5nZT8gIEhvdyBoYXMgaXQgbm90IGJl
ZW4gYSBwcm9ibGVtIHNvDQo+IGZhcj8NCj4gDQoNCkhpIEdyZWcsIEkgc2VhcmNoZWQgdGhlIHVz
ZXJzIG9mIHR0eS0+ZGV2IHVuZGVyIHNlcmlhbCBmbG9kZXIsIGZvdW5kIHRoZSBmb2xsb3dpbmcg
ZHJpdmVycyBuZWVkIGl0Lg0KZHJpdmVycy90dHkvc2VyaWFsL3N0bTMyLXVzYXJ0LmM6NzgwOiAg
ICAgICAgICAgICAgICAgICBwbV93YWtldXBfZXZlbnQodHBvcnQtPnR0eS0+ZGV2LCAwKTsNCmRy
aXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmM6MzAxODogICAgICAgICAgIHR0eV9kZXYgPSB0
dHktPmRldjsNCmRyaXZlcnMvdHR5L3NlcmlhbC9zdC1hc2MuYzoyNjY6ICAgICAgICAgICAgICAg
IHBtX3dha2V1cF9ldmVudCh0cG9ydC0+dHR5LT5kZXYsIDApOw0KDQpBY3R1YWxseSB0aGlzIGlz
c3VlIHdhcyBmb3VuZCB3aGVuIEkgdGVzdGVkIHRoZSBueHAgQmx1ZXRvb3RoIGRyaXZlciB3aGlj
aCB1c2Ugc2VyZGV2IGZyYW1ld29yayBhbG9uZyB3aXRoIGZzbF9scHVhcnQuYyBkcml2ZXIsIHdo
ZW4gc3lzdGVtIGlzIHN1c3BlbmRpbmcsIHRoZSBmb2xsb3dpbmcgTlVMTCBwb2ludGVyIGtlcm5l
bCBwYW5pYyBpcyBvYnNlcnZlZC4NClRoaXMgaXMgYmVjYXVzZSBscHVhcnQgZHJpdmVyIHdpbGwg
Y2hlY2sgdGhlIGRldmljZV9tYXlfd2FrZXVwKHR0eS0+ZGV2KSB0byBkZXRlcm1pbmUgaWYgd2Fr
ZXVwIHJlZ2lzdGVyIGJpdHMgbmVlZCB0byBiZSBlbmFibGVkIG9yIG5vdCBiZWZvcmUgc3VzcGVu
ZCwgaXQgd29ya3Mgd2VsbCB0aGUgdGhlIGxkaXNjIHR0eSwgYnV0IHNpbmNlIHNlcmRldiB0dHkg
ZG9lc24ndCBzZXQgY29ycmVjdCB0dHktPmRldiwgc28gaGVyZSBjYXVzZSB0aGUgTlVMTCBwb2lu
dGVyIHBhbmljLg0KDQpyb290QGlteDh1bHBldms6fiMgZWNobyBtZW0gPiAvc3lzL3Bvd2VyL3N0
YXRlDQpbICAgNDIuNjU3Nzc5XSBQTTogc3VzcGVuZCBlbnRyeSAoZGVlcCkNClsgICA0Mi42NjQz
MzNdIEZpbGVzeXN0ZW1zIHN5bmM6IDAuMDAyIHNlY29uZHMNClsgICA0Mi43MTc2MjRdIEZyZWV6
aW5nIHVzZXIgc3BhY2UgcHJvY2Vzc2VzIC4uLiAoZWxhcHNlZCAwLjAwMSBzZWNvbmRzKSBkb25l
Lg0KWyAgIDQyLjcyNzA2M10gT09NIGtpbGxlciBkaXNhYmxlZC4NClsgICA0Mi43MzAzODNdIEZy
ZWV6aW5nIHJlbWFpbmluZyBmcmVlemFibGUgdGFza3MgLi4uIChlbGFwc2VkIDAuMDAxIHNlY29u
ZHMpIGRvbmUuDQpbICAgNDIuNzUzNjUyXSBmZWMgMjk5NTAwMDAuZXRoZXJuZXQgZXRoMDogTGlu
ayBpcyBEb3duDQpbICAgNDIuNzgwNjgxXSBVbmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBv
aW50ZXIgZGVyZWZlcmVuY2UgYXQgdmlydHVhbCBhZGRyZXNzIDAwMDAwMDAwMDAwMDAwZGMNClsg
ICA0Mi43ODk2MDNdIE1lbSBhYm9ydCBpbmZvOg0KWyAgIDQyLjc5MjQzMF0gICBFU1IgPSAweDAw
MDAwMDAwOTYwMDAwMDQNClsgICA0Mi43OTYyNDJdICAgRUMgPSAweDI1OiBEQUJUIChjdXJyZW50
IEVMKSwgSUwgPSAzMiBiaXRzDQpbICAgNDIuODAxNjYxXSAgIFNFVCA9IDAsIEZuViA9IDANCi4u
Li4uLg0KDQo+IEFuZCB3aHkgYXJlIHlvdSBzYXZpbmcgb2ZmIGEgcmVmZXJlbmNlIGNvdW50ZWQg
cG9pbnRlciB3aXRob3V0DQo+IGluY3JlbWVudGluZyB0aGUgcmVmZXJlbmNlIHRvIHRoZSBwb2lu
dGVyPw0KDQpTb3JyeSwgZm9yZ2l2ZSBtZSBJIGFtIG5vdCBjbGVhcmx5IHVuZGVyc3RhbmQgdGhl
IHJlcXVpcmVtZW50IGhlcmUsIGRvIHlvdSBtZWFuIHdlIG5lZWQgdG8gYWRkIHRoZSBmb2xsb3dp
bmcgY2hhbmdlcz8NCiAgICBnZXRfZGV2aWNlKCZjdHJsLT5kZXYpOw0KICAgIHR0eS0+ZGV2ID0g
JmN0cmwtPmRldjsNCiAgICBwdXRfZGV2aWNlKCgmY3RybC0+ZGV2KTsNCg0KQW5kIHBlciBteSB1
bmRlcnN0YW5kaW5nLCB0aGUgcmVmZXJlbmNlIGNvdW50IG5lZWRzIHRvIGJlIGluY3JlYXNlZCBh
bmQgZGVjcmVhc2VkIGZyb20gdGhlIHVzZXIgc2lkZSwgaGVyZSB3ZSBvbmx5IGRvIGEgaW5pdGlh
bGl6YXRpb24gZm9yIHRoZSB0dHktPmRldi4NCg0KQmVzdCBSZWdhcmRzDQpTaGVycnkNCg==
