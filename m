Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2DC6A54A9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjB1IpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjB1Iol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:44:41 -0500
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2100.outbound.protection.outlook.com [40.107.135.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FBC42CFD7;
        Tue, 28 Feb 2023 00:43:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krCYiIdwjeXLTPV1fGs6n/3UD3CAcVT/z3zPJkishlLTtyzNCzhSRGOUryxObszT0/2KAZNNhRwVhviDkUpqpZPJ2kst4/K9yYtd6ps86Nr5rpNYFmCCEIzeI46//segEKfJUtEasPxC/JpGbZ5E6bZQo3p2RKC2QZxMuJXtfNWbsH+yhIOMmTISC6t27NCYCsUcuV+iqZLP14Nt81wvLwKDpCT3btI+Qv41UThUZE28g5otUpC2hNKoeBgLwUnjITQ1n5iQrmHFDY7GQXqMmSNXhpvvEKcmpD1wPjj5fhjLVszgUWns3csPXPClYACfwJtH2hYwEDQu9ryyLsR0dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m37HYBEMH6Q6zn5bLIufKlY7CCpzRDI43xoTacz5NBY=;
 b=HOPwsznu1BFjzAJq93ZEy2W0HrUj+GUagHtfvS+rabvFIq99LDEXAnvCoqHImjurOtGnKTDg9HaRJarzirGZ3wZOUI2hXg/W/CjhNLhoDSwNueFhBSABhoSFpakqGU7S6mOSdt6P21au+FaljbBqdp+SoSnp/+H1x7t1RnOrj2OWSmMIoTJBhrjFwirPlEdGbh2DGSxFnFioS2ErG0YoD5JxPZZuwiYd4ILEJpwqwamBD27jp70kxiVciXHK4dJMsLwarnZH4WRRcld0LSFBhE/B1QkLTsLRfYWn3+YJ2w7gkBtmoU9MlpQWYrvQgVFt+FP+DzCfHwulyTYWHa6uJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductor.onmicrosoft.com;
 s=selector2-rohmsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m37HYBEMH6Q6zn5bLIufKlY7CCpzRDI43xoTacz5NBY=;
 b=orEY4wpwSL8aUhWnvJUgI8pPbPs5KczhDcM8Tbf+INFJUkvv7qDmtSpRHPq+EFj42lyajX7ivaDgCj1HrD/z04mUIYWyDg8QAbn1aTjxZSoOr3JevjTg3SUlyB9vQHU66yYFf8ObGEbPV4F0lGS+E9pn50pOR01EgS4jJQFw5D0=
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:59::10)
 by BEZP281MB2674.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:71::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 08:43:28 +0000
Received: from BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::f504:16e7:71d4:2fd8]) by BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
 ([fe80::f504:16e7:71d4:2fd8%6]) with mapi id 15.20.6134.030; Tue, 28 Feb 2023
 08:43:28 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 5/6] iio: light: ROHM BU27034 Ambient Light Sensor
Thread-Topic: [RFC PATCH 5/6] iio: light: ROHM BU27034 Ambient Light Sensor
Thread-Index: AQHZRtj7z7K/u6iCTU+V9BreEYjFrq7d63wAgANZ5ACAAs5hgA==
Date:   Tue, 28 Feb 2023 08:43:28 +0000
Message-ID: <ec0d0f3a-c10a-4d55-486f-7b90db90a427@fi.rohmeurope.com>
References: <cover.1677080089.git.mazziesaccount@gmail.com>
 <63a2dbedf54e2e00e3b63dd16aae190ff6596355.1677080089.git.mazziesaccount@gmail.com>
 <02f948ee-34ee-c15e-09e4-d0d8c5161c9b@gmail.com>
 <20230226135216.3f962b51@jic23-huawei>
In-Reply-To: <20230226135216.3f962b51@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fi.rohmeurope.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB2454:EE_|BEZP281MB2674:EE_
x-ms-office365-filtering-correlation-id: 89ec6c8a-7407-4e7b-79c0-08db1967dcda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UZELylY0lptAwS6/wXdS4WX1z244b30PXqB2FUfFUJ2Fhi37Nsi7J8PALOX3TWdet9AotUWH4ogxd7eIbH1vQ+4VpYdV8vuhsfmz7DqH8dLosdX9MuvvQq1aoY5QK9BqkmOUcm+Y12gShzmwEoktrOeurMHFH39zyLuI3tYBqoF6U9xurXnqDKZaD8T7kWQXdv7hDqJyKdw5E0DUh6F6BFKecCXenv9SgvgASqn/RTFFQ4dUtGNQeK76mGSIK5Sa38BiRXQxTR0dFXpgqIbW8qvEpB0MQczRu8lYCVX9MO5HuCQkxGX1XWeqAJUN0h3YnxkwDkZrF9+Yi+D+wfdYPGX8kYZlJZOLg3ThLBdZlAMpNKTTyQr0yVKcWbvADX9+wGw838N4dsYC7ViDo4z/2sEK2WqUFQFsW8eFU9aFyrloxuc0I9enO1YOy5uQPLul/n85zbj/gUGsPmSEsj5KiM28YDESxUPidxRvlYkk3BzXRYDey9bBTfPjvm403h2TsYHkBEVrTJFD3oAKzTHeIWRlj2yau3SwND9zLxWW4VQirrY+kzUyvvumZX2PGZNz55NRiLqRb9lddiEslDoceltbuKIihaUdHxIUUOCrF7wy5f8ruikg8SUVRHfGPVB1KmuH09iJm2zcSmRz3735g+sLx9G3zw0gVwXg0d2kVRphYgJO86dfp4z67zPwI4dy6gpmi0sHlhy11KUe5PPZe5abF7dT5Y4YwPxEOGbVNcDcKDItJZdTmaUtyCLf4JBrb6xJm6qp73C3d1heKauC2g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39850400004)(346002)(396003)(136003)(366004)(451199018)(2616005)(53546011)(186003)(122000001)(38100700002)(8936002)(41300700001)(38070700005)(91956017)(31696002)(8676002)(66446008)(66946007)(66556008)(66476007)(4326008)(64756008)(76116006)(86362001)(478600001)(83380400001)(316002)(5660300002)(110136005)(54906003)(2906002)(31686004)(6486002)(71200400001)(6506007)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVQ1cWdlNGdzOFlheU9idUZZdUVNMk1hbXh2T2NneUVvdERmaS9JM2dRNDZU?=
 =?utf-8?B?aERYbEM5L3BjUDUvQi9HRzJ6MnBUYU13R3V1WGk3M0ozcmZjandNRDh6QUlW?=
 =?utf-8?B?SEFlZWFvZmRlVFJ0TklHQXZsK3ZOb2E0RTlnOFlaRTQ3ZEl3TTQ3T1FPYWZv?=
 =?utf-8?B?TEh5ZUJ5TW93NUhIOHVtbWRBRk9mem1PM2xnYzZ5QlozVWJHMmFoSjBkVHl2?=
 =?utf-8?B?cTBrQkcyVkZTYWpPUjFRWDQvbTBScGx3QlB2WGs3Q28yTDVrZ0FqcVRuYmMz?=
 =?utf-8?B?YlVHaStvc0U2bjZ6Qld5VUpWVXY3NFRzaDFlMFREaVZhcndzOTlEQm1TS21a?=
 =?utf-8?B?UzkwT1BsYWlvb2QwVVBnbTlPWTFXWDR5bXRKR0VmZHl6dWNEWlFLeEEwY0p6?=
 =?utf-8?B?cEpBOG0wVndwYmpTV0w1ZXVjM3ZkZTIwZnhGS1B6T2lyOSt4eHduT0dFZk5H?=
 =?utf-8?B?UERBMC8wcXRGYStVTXMrNWgrTmw4NitteFhJbm1rSGZVWjlzQlZ4NUxMcmd4?=
 =?utf-8?B?Z0JaMXgyZGkyRGo1dW9XaEZneUpzQ05sOWx4SEdsWW1Ua0s1bHpKZW5tU3gz?=
 =?utf-8?B?SzBDWEJDcnBWbGRHb0lRT0VwV3NOMFdnNWEyWFBlOEtJR3dtYUpDUkdwTWdr?=
 =?utf-8?B?Z2xYSmFBeVFjZTE2L1Fkckw2cDVQVmh0VXFQeWh1QW53MzMzOGVPNTFxTzUy?=
 =?utf-8?B?R1BGUG1mMUFidkRHNjA2Z0l3SThkcEVRc3JOd3E2dXAvVXZWOTFCNkxXMVJq?=
 =?utf-8?B?eFQwRXBwK2ZuYmRCeFZzWFBMQmtTb2NWL3cyNXFGUG9wTFpRVDRzSGFJSG90?=
 =?utf-8?B?VFJQb0RrNkFqUnhVS0x3WnovQVhTa3VxUWJ5QXVSMWdKaFhVYStDTERlUFVE?=
 =?utf-8?B?dG9EOVdhcmJ4ZHNTam5jRUROM0lZMmdxaEdoSFU2a0g1RE5UeDBOQ1EwZEtR?=
 =?utf-8?B?VGpYUW5RRHNnUEptR0JrWUVKQ3M0M2hUOTdodFEzSEcvNnd4N2gvSS9tVDZK?=
 =?utf-8?B?UE1WKzlubWNxdmJOSjV3d2pOaHo4RTdDdkd5K2h4c2FMdVBVcTR4a2ZiOENs?=
 =?utf-8?B?d2FyNytxL1NOdXRvcjVWRzYxbmpPMDVJQ1dtRlViY1dqVW5ib3NNSEh1Q210?=
 =?utf-8?B?aW4wemxlOXQ1RWxZME9VQ2tWZnZUL2xnNjJLeUlhekI3Tms0ZTNxNEl1SFdM?=
 =?utf-8?B?UWRROUtaejVmaUx0Z1BDT0ZkL3dPSktrUUg3RG9hR3h6YjdEdE5oQlFwK0lW?=
 =?utf-8?B?TTRuZmh3eVdIRGIwMzBrQmY4M3VZbkNkVVNsejBmVEZCeVFiakVUYStQTzJo?=
 =?utf-8?B?SHcxRXk4cnZsMHE1ZytFMzNiR1luRFVWM0Nhb2VZSTgrV3NUMWR1L3BsSE1M?=
 =?utf-8?B?S1pGZ3VCVmorbktkRUJoTWxEQjg2NER5UFpuMHlaZ2NleW5LYkRPRmpWOG9H?=
 =?utf-8?B?N2RQdGdsZkNjaUxnYTBKMVlMOCtzTittdEs0aVpVZWZhQTc0ZmFBZlRsbllW?=
 =?utf-8?B?cDdzaGk2L1NITWRHd3RhRytrZkVLQ0pZdEFxMHdVdEg0SlZHMm9pSlVzdGx2?=
 =?utf-8?B?TzJwSWFZaXVsQkxOSGpIdkx5aGJHM3pUL1Y5KzYzcEllRWgxSVhjdm1qYWdv?=
 =?utf-8?B?V0crRTQ2YTBJN1MvTC82RVNZNjdFOWdwK1VIOXJkZW41bDlmZ2cwdWRMaStv?=
 =?utf-8?B?QmtidEFVNURPdTRlMzVNai9KWFpEbnBBbDFmZHp0TzAxL081ZEFDdlNEemJi?=
 =?utf-8?B?UUxSTU1rYmExMHN3VFZxUFI4UGJFeHRvaUoyalhaTFowdnFabGt5MGlLNVg1?=
 =?utf-8?B?bktiaUdabCtleTRkRGhmT0dyWFhNZENBNkM0OWdQYlNDa3BPM0lJWVFlSmtp?=
 =?utf-8?B?a2pMNnZ2OUdaVFp4R3VhbUgyVHhQUTlwR2JkWUdrZzF2NmRQV1pISzhWR216?=
 =?utf-8?B?Z1dEejRpUjRRTTFrajFPOTNhMVhuMEdBM0d1dVh4SzduOU5MOGx0NTE4RFZ0?=
 =?utf-8?B?SGpQTm5PWHk5S0RsV2FFeUxSejIzMDJhNzZXUU5mKzRmaVZYcDJ0NVdaYVpG?=
 =?utf-8?B?K1pnUnVGQnFWbHpvb1g2bFhmcEFpd25pekU5YmRUNDRBWnMxYnFMUGpURFhH?=
 =?utf-8?B?QkJGSWY1alNSSHJGdEEvNjFYa2Vjb21mS0Juc3VhWnVXN01RUnQyWjRhdkhU?=
 =?utf-8?Q?pNYhW2gtisy9Z+Gf+oDxC4U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <807015422D85334FBB92E7C7637974B7@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB2454.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ec6c8a-7407-4e7b-79c0-08db1967dcda
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 08:43:28.0688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b24d4f96-5b40-44b1-ac2e-2ed7fdbde1c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pTDjPD/DErr4SYE2CywLa+BeZHcNofgq53yuP26v0b/q00PQ/JP9u2azKAEvq1p/9OrJSD1TCvjzLRcUuH38oXg4kbMKUquppg29hWGHu4DSu7G8luAh2y/t4eCIw0ix
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2674
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8yNi8yMyAxNTo1MiwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gT24gRnJpLCAyNCBG
ZWIgMjAyMyAxMjo0MTo0NiArMDIwMA0KPiBNYXR0aSBWYWl0dGluZW4gPG1henppZXNhY2NvdW50
QGdtYWlsLmNvbT4gd3JvdGU6DQo+IA0KPj4gT24gMi8yMi8yMyAxODoxNSwgTWF0dGkgVmFpdHRp
bmVuIHdyb3RlOg0KPj4NCj4+IFdlbGwsIHRoaXMgIndvcmtzIG9uIG15IG1hY2hpbmUiIC0gYnV0
IEkgYW0gc2xpZ2h0bHkgdW5oYXBweSB3aXRoIHRoaXMuDQo+PiBJIGhhdmUgYSBmZWVsaW5nIEkg
YW0gZWZmZWN0aXZlbHkgbWFraW5nIGEgcG9vciwgcmVkdWNlZCB2ZXJzaW9uIG9mIGRhdGENCj4+
IGJ1ZmZlcmluZyBoZXJlLiBJIGFtIHN0YXJ0aW5nIHRvIHRoaW5rIHRoYXQgSSBzaG91bGQNCj4+
DQo+PiBhKSBOb3Qgc3RhcnQgbWVhc3VyZW1lbnQgYXQgY2hpcCBpbml0LiAoc2F2ZXMgcG93ZXIp
DQo+PiBiKSBTdGFydCBtZWFzdXJlbWVudCBhdCByYXctcmVhZCBhbmQganVzdCBibG9jayBmb3Ig
ZGFtbiBsb25nIGZvciBlYWNoDQo+PiByYXctcmVhZC4gWWVwLCBpdCBwcm9iYWJseSBtZWFucyB0
aGF0IHVzZXJzIHdobyB3YW50IHRvIHJhdy1yZWFkIGFsbA0KPj4gY2hhbm5lbHMgd2lsbCBiZSBi
bG9ja2luZyA0ICogbWVhc3VyZW1lbnQgdGltZSB3aGVuIHRoZXkgYXJlIHJlYWRpbmcgYWxsDQo+
PiBjaGFubmVscyBvbmUgYWZ0ZXIgYW5vdGhlci4gWWVzLCB0aGlzIGlzIGluIHdvcnN0IGNhc2Ug
NCAqIDQwMCBtUy4NCj4+IEhvcnJpYmxlLiBCdXQgc2VlIChjKSBiZWxvdy4NCj4gDQo+IEhtbS4g
TGlnaHQgc2Vuc29ycyB0ZW5kIHRvIGJlIHNsb3cgaW4gc29tZSBtb2RlcywgYnV0IHJhcmVseSBk
byBwZW9wbGUgYWN0dWFsbHkNCj4gaGF2ZSBzdWNoIGxvdyBsaWdodCBsZXZlbHMgdGhhdCB0aGV5
IGFyZSB1c2luZyB0aGVtIHdpdGggNDAwbVMgaW50ZWdyYXRpb24gdGltZXMuDQo+IA0KPj4gYykg
SW1wbGVtZW50IHRyaWdnZXJlZF9idWZmZXIgbW9kZS4gSGVyZSBteSBsYWNrIG9mIElJTy1leHBl
cmllbmNlIHNob3dzDQo+PiB1cCBhZ2Fpbi4gSSBoYXZlIG5vIGlkZWEgaWYgdGhlcmUgaXMgLSBv
ciB3aGF0IGlzIC0gdGhlICJkZSBmYWN0byIgd2F5DQo+PiBmb3IgaW1wbGVtZW50aW5nIHRoaXMg
d2hlbiBvdXIgZGV2aWNlIGhhcyBubyBJUlE/IEkgY291bGQgY29vay11cCBzb21lDQo+PiAndGlu
eSBiaXQgc2hvcnRlciB0aGFuIHRoZSBtZWFzdXJlbWVudCB0aW1lJyBwZXJpb2QgdGltZXIgd2hp
Y2ggd291bGQNCj4+IGtpY2sgdGhlIGRyaXZlciB0byBwb2xsIHRoZSBWQUxJRC1iaXQgLSBvciwg
YmVjYXVzZSB3ZSBuZWVkIGFueXdheXMgdG8NCj4+IHBvbGwgdGhlIHZhbGlkIGJpdCBmcm9tIHBy
b2Nlc3MgY29udGV4dCAtIGp1c3QgYSBrdGhyZWFkIHdoaWNoIHBvbGxzIHRoZQ0KPj4gVkFMSUQt
Yml0LiBOYXR1cmFsbHkgdGhlIHRocmVhZC90aW1lciBzaG91bGQgYmUgb25seSBhY3RpdmF0ZWQg
d2hlbiB0aGUNCj4+IHRyaWdnZXIgaXMgZW5hYmxlZC4NCj4gDQo+IEZpcnN0bHkgeW91IGRvbid0
IGhhdmUgdG8gaGF2ZSBhIHRyaWdnZXIuIEluIGEgY2FzZSB3aGVyZSBpdCdzIGEgYml0IGhhY2t5
DQo+IGFuZCB1bmxpa2VseSB0byBiZSBwYXJ0aWN1bGFybHkgdXNlZnVsIGZvciBvdGhlciBkZXZp
Y2VzLCB5b3UgY2FuIGp1c3QgaW1wbGVtZW50DQo+IGEgYnVmZmVyIGRpcmVjdGx5Lg0KDQpUaGlz
IGlzIHRoZSBhcHByb2FjaCBJIHRvb2sgZm9yIHRoZSBuZXh0IGF0dGVtcHQuIEkganVzdCB1c2Vk
IHRoZSANCmlpb19rZmlmb19idWZmZXIuDQoNCj4gVGhlcmUgYXJlIHZhcmlvdXMgb3B0aW9ucyB0
aGF0IGV4aXN0Li4NCj4gMSkgaWlvLXRyaWctbG9vcCAtIHRoaXMgaXMgbmFzdHkgYnV0IG9jY2Fz
aW9uYWxseSB1c2VmdWwgYXBwcm9hY2guICBZb3UgdGhlbg0KPiAgICAgbWFrZSB0aGUgaWlvX3Bv
bGxfZnVuYyB3YWl0IG9uIHRoZSBmbGFnLg0KDQpJIGFjdHVhbGx5IGRpZCB0YWtlIGEgbG9vayBh
dCB0aGlzLiBUaGUgbG9vcCB0cmlnZ2VyIGhhZCBwcmV0dHkgbXVjaCANCmV2ZXJ5dGhpbmcgSSB3
b3VsZCBoYXZlIG5lZWRlZCAtIGV4Y2VwdCBjb25maWd1cmFiaWxpdHkgZnJvbSB0aGUgZHJpdmVy
LiANCkl0IGhhZCB0aGUgZW5hYmxlL2Rpc2FibGUgd2l0aCBwcm90ZWN0ZWQgc3RhcnQgb2YgdGhl
IHRocmVhZCBhbmQgdGhlIA0KdGhyZWFkIHN0b3BwaW5nIGFsbCBpbiBwbGFjZS4gUmVhbGx5LCBh
cyB5b3Ugc2FpZCwgdGhlIG9ubHkgdGhpbmcgdGhhdCANCndhcyBtaXNzaW5nIHdhcyAiaGludGlu
ZyB0aGUgdGltaW5nIi4gRm9yIGEgbW9tZW50IEkgd2FzIHBsYXlpbmcgd2l0aCBhIA0KdGhvdWdo
dCBvZiB0cnlpbmcgdG8gaW1wbGVtZW50IGEgc2ltcGxlIGdlbmVyaWMgdGhyZWFkLWxvb3AgY29k
ZSB3aGljaCANCmNvdWxkIHRha2UgdGhlIHNsZWVwLXRpbWUgKyBjYWxsYmFjayBmb3IgJ2Vuc3Vy
aW5nIHdlIHNsZXB0IGxvbmcgZW5vdWdoJyANCisgYSBjYWxsYmFjayBmb3IgY29kZSB0byBleGVj
dXRlIChjb2xsZWN0IGRhdGEgKyAgcHVzaCB0byBidWZmZXJzKSAtIGJ1dCANCml0IGZlbHQgbGlr
ZSByZS1pbXBsZW1lbnRpbmcgZXhpc3RpbmcgbWVjaGFuaXNtcy4gQmVzaWRlcywgYXMgeW91IHNh
aWQsIA0KSSBkb24ndCBwcm9iYWJseSBuZWVkIGEgdHJpZ2dlci4NCg0KSSdsbCBkbyBzb21lIGNs
ZWFuLXVwcyBhbmQgbG9vayB0aHJvdWdoIHRoZSBmZWVkYmFjayBhbmQgdHJ5IHRvIGdldCB0aGUg
DQp2MiBvdXQgc3RpbGwgZHVyaW5nIHRoaXMgd2Vlay4NCg0KWW91cnMsDQoJLS0gTWF0dGkNCg0K
LS0gDQpNYXR0aSBWYWl0dGluZW4NCkxpbnV4IGtlcm5lbCBkZXZlbG9wZXIgYXQgUk9ITSBTZW1p
Y29uZHVjdG9ycw0KT3VsdSBGaW5sYW5kDQoNCn5+IFdoZW4gdGhpbmdzIGdvIHV0dGVybHkgd3Jv
bmcgdmltIHVzZXJzIGNhbiBhbHdheXMgdHlwZSA6aGVscCEgfn4NCg0K
