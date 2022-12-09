Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3902C647F38
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 09:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiLII2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 03:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiLII2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 03:28:07 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on20629.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1a::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB7D2FBC8;
        Fri,  9 Dec 2022 00:28:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dv7uFK5Qpm4fZs/f9TePx7qczLPoJhrFf95I7r22bJhVhsG1K/AdcMAYWqnouNJsIq5YDhbAjhYc3Eq84EaepoMn3+8NWAyP1J0ORfbn2ibERdntKbHi0JQTajr4Uiz7TlNbfYEHF9sweNDa/LHhTd8qYvxOsfc0sfuNcbAWy9IDgpXGh5dcTNLw9sP/AlWt+H4Tgi364NXR6kvds0ahup4kJWctgO6Q9eKST8FNyYCnhJzJMw1VjJmi2+UqmrTT1I9TYja2tmKR1xnfIMARuIcyWsSh10U4Ar0qRwOMVqWlang17VNv28kBPW7Wy55GERloUx1pNUvvDYd7m8jZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfWda/4I+7eVj+W+FAKhiwssHPHQH2AEUZ9S0TSuh8s=;
 b=R/PxeBsGoLwhcL2oO2SO7uaa01fMtvOXyiqNNOwzceEyD0QhecIfoik3m4e7mDlrDUm7KremiVD74B9vPx+wZED71pt75YMkehdFsOkhuZTYOLpRX/5BM32gr6o/j1QT0e8h2zS0Fawt7JW5LaoXLHIIDoaUFZ8UxhMdkZmLTeRSst+iMRKKBICx/31oENcGWZFMEIVmN97Y89XflL8Puat/lZqcxdwgh7LpuxkelWyvUmos04BpNlSEcb5IsNwiFzJakrvC9y67vqRgXrAhnNij1ZpA1V/cU4Prhocl/byQnj3smswmaKEp6fW2euWrIbz/DXQSXbXCaTu4q5Y8og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfWda/4I+7eVj+W+FAKhiwssHPHQH2AEUZ9S0TSuh8s=;
 b=EmqioN3frnMWrrR+tPpNPLHUi/8DVCmFPMtbxvRdzRZYRSGNG/IkVh+tojflpGlyFTAsl5s9TKqBIV3vTQJrXiBdNZuirTgeKnMfQnipQJmVoJTch8Lx+P6ZAqGKZcJlR4+qZkVRVfllKIFlAo9qK/QozKlTFdRidT9oIqoKr7U=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 GV1PR04MB9118.eurprd04.prod.outlook.com (2603:10a6:150:25::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.11; Fri, 9 Dec 2022 08:28:02 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%7]) with mapi id 15.20.5880.018; Fri, 9 Dec 2022
 08:28:02 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     "ye.xingchen@zte.com.cn" <ye.xingchen@zte.com.cn>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iio: adc: vf610_adc: Convert to use sysfs_emit_at() API
Thread-Topic: [PATCH] iio: adc: vf610_adc: Convert to use sysfs_emit_at() API
Thread-Index: AQHZCg5rhUDsxPc9XEKNBOZZpVwt5q5lO+pg
Date:   Fri, 9 Dec 2022 08:28:02 +0000
Message-ID: <DB7PR04MB40107C14EF610040D1927EB0901C9@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <202212071534513812390@zte.com.cn>
In-Reply-To: <202212071534513812390@zte.com.cn>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|GV1PR04MB9118:EE_
x-ms-office365-filtering-correlation-id: 8480c2f6-8c36-46b9-dbe8-08dad9bf4987
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qTS6fB67jxVOg735fkK0uUh8JnF4UqCw855fa7+BaQzCtEYUQnFTyyMKBDOakU/pL3Jtmt9x7X6TbfPnoAGEHurw9tAPAPw9zRIYyD5yZmQuZKS1vgrORdXQ5UQCc0uD2F9D98XjjzkrFc20HtZFrtNA73Bde50s509HS+afrIFesLn1VjaSAcXhecDbzDe4UVxaozcFszNd0z/d2U0UciDjhgFdnXBd8G6Gvn57Sq3tcROyR/FXm0+wouLHyfmmG4GYBaWoTjqcecH+goA43KC+NFBXcyuELdOZnZzDXo1HszvES1mmAclPblACPdqmmWHqm7GKvmS5LPq6ipDyE2khsaY+6jLxHDmGU6EXNAYKdT5MQqJXGUlwYEj/FSzY9kUAWbfPHvoWH/38c0aPwcaCNDd/HRfZvBmbK53HOQoegf+w7Im6+57w1OHl7O+LughW7TJ330VhGiyrzwezMb1QlIsmf1YORKqUMWLXJPWTJSpsHLDOfqKYhXXdmPogdAUvugdAWAPaenrGrun7S21+Xo3hX1yhV+GmuqPg/U5k8o8PDYQgUrBLXDSLLCqF+Ht5F4JzO3JnQIvc8r38phH2T1fg2RpEcMPJ6Wac+UxN47PC9rs9ReQ/RKF4GpMfD8fwA0fzRM7LGaMwvsJ4IzW+A/i6dEfJFucrQUsU9wAHYSHKCxKekY9roCnQze8IJI9qO39a/+if9OhRM0O/rw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(451199015)(2906002)(38070700005)(55016003)(6506007)(33656002)(86362001)(316002)(54906003)(9686003)(53546011)(83380400001)(186003)(122000001)(26005)(7696005)(110136005)(478600001)(8936002)(41300700001)(52536014)(76116006)(64756008)(4326008)(66556008)(8676002)(5660300002)(66946007)(66446008)(71200400001)(38100700002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZE5rRUtlRWRwYnB5MHZ4Tk1yN2hXSGhaNmFBbHd3amlKbVhWTDVjS1pGM0lo?=
 =?utf-8?B?SkRpbEh0U0VRWC82N1htZjZsMnBLamhBT0JXSDVNdHYvL2pLRStqc2xZRjQ2?=
 =?utf-8?B?a2J4cTdhalFSN25ldXlqQVhtVi8xK3VPajF3SU9EaUR2Vmk5cEpzdG9qbGFq?=
 =?utf-8?B?YS9JZEFtMVVLYlVtUXFnTkJjOWRob1hiSi9JWUtIOXR0VVIzWjY1bTZJQkIx?=
 =?utf-8?B?cFd6b1RFbFVtUy9FUmZ4ODVZTGhnSkpEaGtIWjhjNjY2QUlTYlVGci9CbFRZ?=
 =?utf-8?B?amZjdFNjRzFVUk9ub2dKaWJIeDdJUDdtOHJBOGVtbzllYXRITXRhdVM3R1ZH?=
 =?utf-8?B?TFFlNkVEOXBrdWQ2TXVIMUZKRW5Vc2RDM2tDV0g5Y0p0dVNXNHNNM1l2V2tS?=
 =?utf-8?B?Ym9vNXZqVlN4RnRXRVl3Slh1UG5WUmRnVkQ5bnRYNzVwOGJRR0w1Zjc2ZE1D?=
 =?utf-8?B?eExmZTBiVkFVUVE5RGplQ1IyeWdxTFFSTkhsVjRQOFNLeEtXbndFN3duRWd0?=
 =?utf-8?B?NEkwYXF0OG1SdTNzVDUwdWoyaWVPdTVQMVVteXo1ZElUaDFvdFZJLzJzVWRj?=
 =?utf-8?B?U3A4d3VJSDMxSXU5K3NWTGVmMDErRU53VXFIeThyQ25JcUcyc1p0OTlQRUFj?=
 =?utf-8?B?TVBYVWxDZlFmT2tweUlwdEc4cFUwQTlpK1k4ZlJSK2RCS3hFeTNXc3AyWkp3?=
 =?utf-8?B?M0RMTjR6eTVKNmE2RGY5RDJQbWtrL3ZUMUZUNTdMblFWZ3ZoNEp2end1ampS?=
 =?utf-8?B?SWd3K3dVRWhaV2xjTmxQSVRXeXhZZUZ1VDhENVRRQUhMV05uRkpCNXlWS1BU?=
 =?utf-8?B?SEVmeXRleDlhaG45YmJsdTJwWFFDZTJTU284bWFlUHE0UFh0UndERTZZTFVX?=
 =?utf-8?B?T1RYRTVJMWRUNXYwR1NHQVVVQkgyVzA5VTREN25HRzlEMFdXN0lSZGlxK2Vp?=
 =?utf-8?B?dS9IcjNUbU0vNjJnYmZKWnAxYUtUb1J2aFNrTU5NTW9yblV5NDlqYjRiblJl?=
 =?utf-8?B?L01hQVUxN3pQMmUzT2NDeUJreTYzU0xMRjhkZnVuSGNiSnpIT3V3WWZzRU5U?=
 =?utf-8?B?a3dVUFdDV1pLTnhpcXMzV21hUCt2NVkwSEE3U2RneGFXUnA5dTNaT0RHL0lD?=
 =?utf-8?B?SXFQVHlVTjNTVHhwbkloeFBTZ2VFR3Z3ZzFNYzhBdkF1R2pVTmszNjVLVkNp?=
 =?utf-8?B?dkRGS2VGMFNjWXk4WDhBOHpkZGFOR2RtWHZKYWN2enZpWThGUGZaeHJ0OCtp?=
 =?utf-8?B?VVdPa0x0bnd4LzluSTJBN1ArcHNhbllqdDF1UXdMYnJ2amYvTEY0eEE0TC9K?=
 =?utf-8?B?ZzFKY2lKaWJCOFMxaSt3dnBwU3NYZFZwQ25yUDVVbVJURWNBUXFjb0Y2eW9T?=
 =?utf-8?B?a3l1SVRFUlptbHkzbW04ZjArT3BYYTJUM3Joa2d0dzBvU0c3UlVGbTR3dW8y?=
 =?utf-8?B?WUEwQ0g0eXVkWENEaEptYy9GblVCM3FMVGdPaFFJaGk1TGVyMGNKU25ubFgv?=
 =?utf-8?B?YTBDZUpIbnAwNERraGlKYU5FOWtudGJRWjBqUGpaZE5xditUY1BBYStSbnk5?=
 =?utf-8?B?dmQ2dVQxTlJxb0I5Q3ZYUUxqeU8zRENoZUZwdllqNmZYZ1VsU1VFTmE1VTU0?=
 =?utf-8?B?SDVNS2FpdDZFTVRpN2tIWlMwZ3o3OEV4VTE2Ty9pRDMxU2hxcENlWmk1RTZ4?=
 =?utf-8?B?WGczUTdNYlMwQ3BNUGpJRW1jczljcHVmaGE3TTYxMG95MnM0WDFyaWs5eVRR?=
 =?utf-8?B?Q0pRNFdaSmE2aUNYdFdoTHJDWklHYzc5UEdheFArcWdxQU5Kd0hkVzNHbUcw?=
 =?utf-8?B?dThyT3dtZlhHUmV0a2lmV2VtdnhFYlEzemhnVGtVMDRRM1hyT3lKVzdNMDUy?=
 =?utf-8?B?RkdCSWpHenVLZ0F5Um9kRWRxdVZnejl4RE51dERvakVZL09WbmhOVHB4aE5F?=
 =?utf-8?B?ZlNVUnMxeHpvY3NpaEl1Ulp6cjliWjY4bGxhclBkdVRwS29NQ1Z3RmpWd2My?=
 =?utf-8?B?MWN4cDRKYWJweVZJRFNYajdaaEVUU3FFVitadklsYXBYemN5NTBwaWpsc0sv?=
 =?utf-8?B?NG54Z21iOHhQVnVjd0w5R1QwMkFic0gzU3JXWnBobWROeUM1ODVDNHkxVzdh?=
 =?utf-8?Q?eZpniSub6ZAR1f9gAkkhHV/HU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8480c2f6-8c36-46b9-dbe8-08dad9bf4987
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2022 08:28:02.1655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7H90TPw4EuNGfSUUqSDOK9ige6EWk9XOVBFd8NOK6YM9/fRdUw1QTJfc5jU4TFdfr5e68fTVZOgyY8jnDBLfzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9118
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiB5ZS54aW5nY2hlbkB6dGUuY29t
LmNuIDx5ZS54aW5nY2hlbkB6dGUuY29tLmNuPg0KPiBTZW50OiAyMDIy5bm0MTLmnIg35pelIDE1
OjM1DQo+IFRvOiBqaWMyM0BrZXJuZWwub3JnDQo+IENjOiBCb3VnaCBDaGVuIDxoYWliby5jaGVu
QG54cC5jb20+OyBhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb207DQo+IGxhcnNAbWV0
YWZvby5kZTsgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1p
bXhAbnhwLmNvbT47DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDog
W1BBVENIXSBpaW86IGFkYzogdmY2MTBfYWRjOiBDb252ZXJ0IHRvIHVzZSBzeXNmc19lbWl0X2F0
KCkgQVBJDQo+IA0KPiBGcm9tOiB5ZSB4aW5nY2hlbiA8eWUueGluZ2NoZW5AenRlLmNvbS5jbj4N
Cj4gDQo+IEZvbGxvdyB0aGUgYWR2aWNlIG9mIHRoZSBEb2N1bWVudGF0aW9uL2ZpbGVzeXN0ZW1z
L3N5c2ZzLnJzdCBhbmQgc2hvdygpIHNob3VsZA0KPiBvbmx5IHVzZSBzeXNmc19lbWl0KCkgb3Ig
c3lzZnNfZW1pdF9hdCgpIHdoZW4gZm9ybWF0dGluZyB0aGUgdmFsdWUgdG8gYmUNCj4gcmV0dXJu
ZWQgdG8gdXNlciBzcGFjZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IHllIHhpbmdjaGVuIDx5ZS54
aW5nY2hlbkB6dGUuY29tLmNuPg0KDQpBY2tlZC1ieTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBu
eHAuY29tPg0KDQpCZXN0IFJlZ2FyZHMNCkhhaWJvIENoZW4NCj4gLS0tDQo+ICBkcml2ZXJzL2lp
by9hZGMvdmY2MTBfYWRjLmMgfCAzICstLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy92
ZjYxMF9hZGMuYyBiL2RyaXZlcnMvaWlvL2FkYy92ZjYxMF9hZGMuYyBpbmRleA0KPiBhZTMxYWFm
ZDI2NTMuLmRiZjgwZjVmNjc0YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9paW8vYWRjL3ZmNjEw
X2FkYy5jDQo+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy92ZjYxMF9hZGMuYw0KPiBAQCAtNjA2LDgg
KzYwNiw3IEBAIHN0YXRpYyBzc2l6ZV90IHZmNjEwX3Nob3dfc2FtcF9mcmVxX2F2YWlsKHN0cnVj
dA0KPiBkZXZpY2UgKmRldiwNCj4gIAlpbnQgaTsNCj4gDQo+ICAJZm9yIChpID0gMDsgaSA8IEFS
UkFZX1NJWkUoaW5mby0+c2FtcGxlX2ZyZXFfYXZhaWwpOyBpKyspDQo+IC0JCWxlbiArPSBzY25w
cmludGYoYnVmICsgbGVuLCBQQUdFX1NJWkUgLSBsZW4sDQo+IC0JCQkiJXUgIiwgaW5mby0+c2Ft
cGxlX2ZyZXFfYXZhaWxbaV0pOw0KPiArCQlsZW4gKz0gc3lzZnNfZW1pdF9hdChidWYsIGxlbiwg
IiV1ICIsIGluZm8tPnNhbXBsZV9mcmVxX2F2YWlsW2ldKTsNCj4gDQo+ICAJLyogcmVwbGFjZSB0
cmFpbGluZyBzcGFjZSBieSBuZXdsaW5lICovDQo+ICAJYnVmW2xlbiAtIDFdID0gJ1xuJzsNCj4g
LS0NCj4gMi4yNS4xDQo=
