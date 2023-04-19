Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EFE6E7098
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 03:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjDSBCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 21:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjDSBCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 21:02:21 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2061.outbound.protection.outlook.com [40.107.117.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9614C05
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 18:02:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BGSmot8j5RC9qMHay6/Ifwc8K8t4PxDCH9bhuX2s1wD+75xPMhh9Nx2d+UVmU9+5z8vdXe2z4Otr5vW7Yjns3Jxyh2eUR2jgkuMt/cGr1VOAwMGwi7N3j3xOzsinpj9LrcM8PioZI6Garse2O87tD/D+uxBMIjelffbMdtBIS0FWx0qFsu0F8SPBfz6ivga3UJ9uXI4D748yId0e98vChQhg4/0LEEvrI3mT9mPbWxFYzrVxftZ8D9IMjMDsdEH4Jeto9+gOX+8j4o8uNfH2pPRFNz89QiEcNMpD/lHfRlPvYvjiVksavpGLF8b26vHp7jyCkcOoXGYzAhIfmsck/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1b0ksBKf8+cpQ6yv1W/EF58CDcAptew1Y02zEZagtSI=;
 b=fzopX2i+1qMhFzYQ1awhHZyLw0EQzKPxs4OhuOj03niRb8rcp+3s2A6UEyuDuFESg7Zrya5U7PoQ6IDIhiiK0tHI2rkmw/P9u2eXdWYZdjwjVNCWfHfHA8is+/aASlP00xJJ2Klh2tdCEnoSabKncqm5uO3ni4tVf22cnHQWTgcj8s83tiMXdLHQbGGQBofnrUu7g2f1+3LKNVKSmFKJHV8mtaB0tOUMUAd+m8p/Iv/PFuLicvhWBAtPp0wEsU7MSaCnPPQ+rl+KGti3BnV2Njl117kPLrw2hvr90IRMIz1bTsKruhBythKvCcSirz38ZvhwLfnjh234gMV4WXht/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1b0ksBKf8+cpQ6yv1W/EF58CDcAptew1Y02zEZagtSI=;
 b=Vp6a/BVwkuoPTrrSF0fQu3PVjKbl4NfJZT3w/9ywcYbSDKYukU1bmDCatNSaLg2kMzKVnjrkn4vOm8qHjppC0+hwhJODfusxzXAfQHpyhpFUAkUezRtQvbAi+k0Gqyk13W21ezu2Usra7U9jylk4+Yqn+XGVWF5EUxOx0qQGE7Ta0VAiZHmMOYUR+8hiXGBe3/KBTPVT+qo8Rnu0fPuJpKBrL8DXnEub8hzTrhz9v+ixMP+A36RiXhEVEvbLzNroy2lEknOBQHNdLw0oxbrHFkdInSiZRCdm8+nMsceqfCIUvIMSwE7Op81vIiIP/svFmfTMC7Trl/amVoafQFRzDQ==
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by TYZPR06MB4159.apcprd06.prod.outlook.com (2603:1096:400:2c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.21; Wed, 19 Apr
 2023 01:02:16 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::9e20:dc84:28e8:3c6]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::9e20:dc84:28e8:3c6%3]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 01:02:16 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] driver core: auxiliary bus: No need to get auxdev->dev
 again
Thread-Topic: [PATCH] driver core: auxiliary bus: No need to get auxdev->dev
 again
Thread-Index: AQHZcfC4z7mF90StUkmfgq3O4d6CV68w/7wAgADQs0A=
Date:   Wed, 19 Apr 2023 01:02:15 +0000
Message-ID: <TY2PR06MB3424FD1DF9CE50F1E5AED1CB85629@TY2PR06MB3424.apcprd06.prod.outlook.com>
References: <20230418122406.1338-1-angus.chen@jaguarmicro.com>
 <2023041816-magma-shortly-dfdd@gregkh>
In-Reply-To: <2023041816-magma-shortly-dfdd@gregkh>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3424:EE_|TYZPR06MB4159:EE_
x-ms-office365-filtering-correlation-id: 9c480108-26d9-4db9-185d-08db4071b797
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fyb7d94Dx1dSpQKFPoUkT/FZAN9kOsL7p2olmCusPzHntyFUcDcyEcTMvQZz+g/xAp1mMzMoVJ5Y36m0HAz+GUL9b53WF4Y4yJqbVvNhcWLoK4tZyqSfkxw5NB56rwNvHXTqKGHrRp/awo3TwzdVhKTwFvitoqi9Io2O5muEXnLdLiEFhbHiTkf1RopWiIAIcBiuliH/Z58K6+m1psAKk/SDUgDdDvAYHuR5x1pIZ+y8C3ILsXy5MaYXe5wkHGGpNCADDTns8iLaPm5DsYeM21EZNlZ7kghkW7MAHkx8x6yP7NSMaCbA3/irX7Abb9E4UDFSXx6tGK8ekix7PTSqe0y6YY7VQLwCpo5YgjzFYqheTvdP+aG6XC8fmUrb/aJnjEW1zFqyJG/n99KLnwmTEjgJj4DPNmel4H5iYpjlkaFlnFUtHo6yU8CfY7309p+LIr5IwgMzjd/hDIGW28gniQ6p1GWe9wmiO2iPARUa/UHDtRoq2E88jE4BMpwjCUVqv3lXTKDkEOYDt3Y+3MNRssI0KLITcwKGWOFDX/cXcIth4vTUR1fdSOdCDkAPi+yKpBPievPJTNIEfKUcRqDq0sAzM1ik2R9kRAutAv5T2xIxHpXC65glOlbBLdCNcMyo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(366004)(39830400003)(396003)(451199021)(52536014)(5660300002)(44832011)(54906003)(33656002)(478600001)(8936002)(41300700001)(55016003)(316002)(8676002)(122000001)(4326008)(38100700002)(66476007)(66556008)(66446008)(64756008)(6916009)(66946007)(76116006)(2906002)(53546011)(9686003)(26005)(6506007)(186003)(38070700005)(7696005)(86362001)(83380400001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVVucWZlTzNCREJXVElCdUlENXpMN0ZhYm1RRW9iVlFHRWVRdVdMd3Nsa2ky?=
 =?utf-8?B?QnB5ek0wb1Nsd1drOGEwWnRmSktpUnZRNWtxYk1pMm8xVmdIUVg4QVVBZlRi?=
 =?utf-8?B?blJSdytqWlVKNHdIbDBnVFRBTFhXWDY4QmtkWVJaQmxvR1FSVW8zdE1zUXRT?=
 =?utf-8?B?RG9sWEM2TFFFdG9iWXNvcFRueng2YXpxaXpCZmdCZG00VjBHbE16NkljNDYx?=
 =?utf-8?B?aWE3K3BiYXIwTitKNVZqdkhwazRIUlRNdlJubExFa0s3UVRBdkg3OXBnV25J?=
 =?utf-8?B?VEJYaFg1Nzg5YXpvUkE2V2l1MHc2aU1HL3hnbnQ4RkhGMllnUU4vUG5ZSGRj?=
 =?utf-8?B?dnUrZ3laUklVNERRZG9rWFFwOXk1ekpUbFI4K3c2V3c4VHZsNFg3Uk9DcFpz?=
 =?utf-8?B?Tm84M2xrUFFpTmRGVXZWV2dlN2Z6RU1qNk90cDRsYTFvQnRDblo5UjlkVzRI?=
 =?utf-8?B?Z0VHTDdXcG9VZmtESDlnZEVMWWhWMU04b2JSVFlNTFNvWENQMkVTemk5N3Jl?=
 =?utf-8?B?dk1ILzlpamYwb3M2ZXVheW1RbjhMNXljTGZINTFNcGNhaDZjN0srS1dsb2JU?=
 =?utf-8?B?VERsbFFGN3d4Tyt5SjByQVVsbVN0Y3ZzMUh3bGNwZzV1YzRBK1lpQ0RqazZ2?=
 =?utf-8?B?Rjl1cWd4eFpOWWJIOGc5QTJkZjBJNUJpOXRNU0FsbE5wNGlUczYyWFhJa2xX?=
 =?utf-8?B?d1paUHVycC9Ua1AxUXlZeHpQZ2F2THRBaEdJWmJGL3EzM3FXc2hyK2MyN1hm?=
 =?utf-8?B?Nmp6S1pzTVFaWmcxU3lCZUFiRE9aL25ndzkrZ2IxRy8zMUlYYVM0TER0VXlG?=
 =?utf-8?B?Q3JMekpjVXhNNXlnN0liRmU3cWw0blRUUXJxMEhHMUIzV1hjb0FWVGp4Yk5N?=
 =?utf-8?B?blUxOUM2QWtEdS9randBMFJBV1dLQkJGTlFDajdWREM5VEF5VDU4Q0hNbmh6?=
 =?utf-8?B?b2UyMU9EMy9ZdklwMHZwd1B4QzFNNTE2ekV2dkhKZCtQQW01cWFYaDdjbk1F?=
 =?utf-8?B?Z2lBSVRIRS9nV3BiZ2tmN3liTFNVTVc5enZ1K1lvdStLQXoxbDdnd25xV1JL?=
 =?utf-8?B?a0p4SVNsUU5BVjRnblNHZ1FlcE5tU0FJcFpXNkw5R0k3MGJHb3hXU3BTREYx?=
 =?utf-8?B?L1VCQzcwa2NrdVhqMjN2ZXMwNFkwOGdKdCtjNFlPT0J0M3FhMWY2bG4zOXIw?=
 =?utf-8?B?S3JyTXRmQ25PSmVYUkNZOGgvNCtxKzg5aEgzMXRoekdMblh3aGZjenEzZTZ5?=
 =?utf-8?B?cVBVeUtjM2V3bWgrSlo5MEtZN3YvOVY0NzdJOU9FQ1p4N0c2TkNaQnN2OUY1?=
 =?utf-8?B?MUM3K3ZzSnVzbWoweDlhTDN3QkJQdDZBQU45Wk9weStuanVZYytCWmRJYjl4?=
 =?utf-8?B?VG1UVkp4djhlTmgxVVJhWTlERUZBZVdKWHU0UnRQNEJ5Y0Y0dTI5MEdzbEpz?=
 =?utf-8?B?UmIzN0FpRC9RWDk2TkdLeGN6NWxQY2xLR2xsM25FSVRBRytMWTlGNFVnOGJR?=
 =?utf-8?B?eHZpdE1aV0M1OFh1djg4cFJ5T3JHSjdPTW00QUJpd2JUS2FJR3dvRzlWYmJq?=
 =?utf-8?B?TmlmSGtmSTgybXQzdzIzdUpBb0hjU1lTckFWVTM5bk9vZVZWT0J1WVI4eDZR?=
 =?utf-8?B?aFpLVVdQVEp6MEtQWDNHUUdZYnBGM1dtTHlneE9pcWgzdXY3anRmNDIvNTVz?=
 =?utf-8?B?S0I4a0FHSmxac3ZWMkxLZDJoRytjbWlaL2dVUmwwdnJlenlzOVEyZ0N3b2dt?=
 =?utf-8?B?bHAydXBxR2dnVzRMTlBVSUs1VWRKTDVUdCsyTnVkd1ZsTXMrb2Z1MDFLTU9D?=
 =?utf-8?B?SXRqSDNRb0g4RjJtbmNPNHNvNFdkdGdRc0g4aG1ZZDFZU1c4WXhoVnM1VHR0?=
 =?utf-8?B?T0dxY2hqSmIyVEVUZDdCWG41aXRRZjIrRFpFdE5BOThNMlhZWVVWcDNqZU1z?=
 =?utf-8?B?Z1hldDZpZXRkUnJWRXNIT1kzeHd4QVdNL2pIdy9waitVeThSMXg4ZmRaSVd2?=
 =?utf-8?B?Rm9qNDJPSmxnWG1WVmgveFNDZGN3ait6WW9QREpOVmJyRlZHdWMzcXR4Tzla?=
 =?utf-8?B?Ujk0R0toaXBrcXltZUtaYmNuWEE3L3BWbHQrekYzYVVMSlBZKzNrYTJCVWV5?=
 =?utf-8?Q?rIc7dqxOioiK3d1GZGPHs+1k/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c480108-26d9-4db9-185d-08db4071b797
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 01:02:15.8432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/GtmNVaASPvKOH85yLJ9N0ML13Fy1B5YOgjz3pobd+Tix304KTDGUYH9pT22tjzyk3niZUIQwgtKDeiB9aYydWL/MS+mGlX0YKz5t7xN3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4159
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3JlZyBLSCA8Z3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDE4LCAyMDIzIDg6
MzIgUE0NCj4gVG86IEFuZ3VzIENoZW4gPGFuZ3VzLmNoZW5AamFndWFybWljcm8uY29tPg0KPiBD
YzogcmFmYWVsQGtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSF0gZHJpdmVyIGNvcmU6IGF1eGlsaWFyeSBidXM6IE5vIG5lZWQgdG8g
Z2V0IGF1eGRldi0+ZGV2DQo+IGFnYWluDQo+IA0KPiBPbiBUdWUsIEFwciAxOCwgMjAyMyBhdCAw
ODoyNDowNlBNICswODAwLCBBbmd1cyBDaGVuIHdyb3RlOg0KPiA+IFVzZSBkZXYgdmFyaWFibGUg
ZGlyZWN0bHkuDQo+ID4gTm8gZnVuY3Rpb25hbCBjaGFuZ2UgaW50ZW5kZWQuDQo+IA0KPiBOb3Qg
aW50ZW5kZWQsIGJ1dCBpcyBpdCByZWFsbHkgaW50ZW5kZWQ/ICBXaGF0IGRvZXMgdGhpcyBsaW5l
IG1lYW4/DQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5ndXMgQ2hlbiA8YW5ndXMuY2hl
bkBqYWd1YXJtaWNyby5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvYmFzZS9hdXhpbGlhcnku
YyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9iYXNlL2F1eGlsaWFyeS5jIGIvZHJp
dmVycy9iYXNlL2F1eGlsaWFyeS5jDQo+ID4gaW5kZXggNGQ0YzJjOGQyNmM0Li5jYTFkMDQ0ZmY3
MzggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9iYXNlL2F1eGlsaWFyeS5jDQo+ID4gKysrIGIv
ZHJpdmVycy9iYXNlL2F1eGlsaWFyeS5jDQo+ID4gQEAgLTI4Niw3ICsyODYsNyBAQCBpbnQgYXV4
aWxpYXJ5X2RldmljZV9pbml0KHN0cnVjdCBhdXhpbGlhcnlfZGV2aWNlDQo+ICphdXhkZXYpDQo+
ID4gIAl9DQo+ID4NCj4gPiAgCWRldi0+YnVzID0gJmF1eGlsaWFyeV9idXNfdHlwZTsNCj4gPiAt
CWRldmljZV9pbml0aWFsaXplKCZhdXhkZXYtPmRldik7DQo+ID4gKwlkZXZpY2VfaW5pdGlhbGl6
ZShkZXYpOw0KPiANCj4gV2hpbGUgYW4gaW50ZXJlc3RpbmcgY2hhbmdlLCBpcyBpdCBuZWVkZWQ/
ICBXaHkgbWFrZSBpdD8NCkkgbWVhbiBpdCBqdXN0IGEgY2xlYW4gdXAuYmVhY3VzZQ0Kc3RydWN0
IGRldmljZSAqZGV2ID0gJmF1eGRldi0+ZGV2Ow0KdGhhbmtzLg0KDQo+IA0KPiB0aGFua3MsDQo+
IA0KPiBncmVnIGstaA0K
