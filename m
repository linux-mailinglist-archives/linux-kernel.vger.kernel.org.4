Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66445B88E9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 15:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiINNPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 09:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiINNPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 09:15:12 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D8E52833;
        Wed, 14 Sep 2022 06:15:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1XtYcdnxMc3rKGgryz8dx5stgb2/AbYdcQaoYTM6NzM9GgGqOIX8OrArNRln4uJzK9m+qOYhrgCvcYQxqYIflBmJksU9JtH5NPSvoh8qtCAavdt/3HGm6IgijlEnz+q8yJBki0GsDoRLImbwFTPAMIQXSLQQJD+pFYDqqrOmLtdEpodpSugP4Su8YJny0maTMfTIcjF0wbGkKa0V6CCh99GioBHvojEpBntT1t2djXI5iNgetcc/8eiAAD3jZehDDMogUGsz6EGafFIyhpkrVo5jwFtQALRTWb/3Wz3aGgdrvfJbqLEWHCeAFlHwmWDj6z7X6p3hMm7Tulx36A0Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTw1WAzlOw0B5E8X87xjiF0fMJsi0q88WqrbU5JlSKc=;
 b=jyBUEvQrJ5We8cMmlSRkOCRG/xowbGMKBRLs4MJPlCCm7WHMFRcwWJaq9O7mmRXi7nn+x5ke9KkNFn7/cMHXGoPGO4Z4FjjmNKVHsKLklAIL2MsdbRoPjghxwbESwLbGqN8ZDUeT8Uhr20SYXo8/Xv8BoMBhf48FrUkVe72jO1p6BNPbov68okuG/wPoP2StQutRBjAzbtrD8Nit4pEEzXblbOhAeExKDnvYYbOHhd9idhxbVw4nn7D6gGWiVTx8aticjiETNEHQ56sOw0xbGwEsFkBV8/gCCjh/ur6wyd1HhPgjMbKV9wKl54KHqtpc2mhYa/XkGvwIcmV+d0rK3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTw1WAzlOw0B5E8X87xjiF0fMJsi0q88WqrbU5JlSKc=;
 b=RkK4AzGpvSlItPoz1tJkrRlaRrKH9VjvgDr9jyy3Xcv03iVV5MAYwOdBdpM304rk6A0pY0ItTDT4GhI1c1/2Nwp+/vOFDfwJgT2ssTY6oozbWvyR4C4F6iY+kxdOJMaxile6+4fWKoLE9Nrv2M0Nuy1eI38VIGrSG0HymRPvXZA=
Received: from MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23)
 by MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 13:15:03 +0000
Received: from MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::355b:bb87:4cf5:7b83]) by MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::355b:bb87:4cf5:7b83%5]) with mapi id 15.20.5612.023; Wed, 14 Sep 2022
 13:15:00 +0000
From:   "Mehta, Piyush" <piyush.mehta@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "balbi@kernel.org" <balbi@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Paladugu, Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>,
        Manish Narani <manish.narani@xilinx.com>
Subject: RE: [PATCH] dt-bindings: usb: dwc3: Add interrupt-names to include
 hibernation interrupt
Thread-Topic: [PATCH] dt-bindings: usb: dwc3: Add interrupt-names to include
 hibernation interrupt
Thread-Index: AQHYxoXS/6kPrZnbm0ah5M+XCTD+5K3dF3KAgAHHNvA=
Date:   Wed, 14 Sep 2022 13:15:00 +0000
Message-ID: <MN2PR12MB43330B57F5CFBEC35105665188469@MN2PR12MB4333.namprd12.prod.outlook.com>
References: <20220912085730.390555-1-piyush.mehta@amd.com>
 <4cc7a6d2-64ef-c176-21ad-4c3e66f664f7@linaro.org>
In-Reply-To: <4cc7a6d2-64ef-c176-21ad-4c3e66f664f7@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4333:EE_|MN0PR12MB5716:EE_
x-ms-office365-filtering-correlation-id: c6ceb419-3187-408f-b55b-08da965320f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9a3juG2bLL8n5JoU3Q66ScB/Ilklbw7iOl48a05d2pz0K5Eg0eKooxgChCQXN5umedD2WDBcWWY3Y3qzplDh2cJWQqKXroy5AjORheHreFJz0QQHFEgypGhRLMzZbnUOs7jiJ6YNlx/Hufi40ZMyw6hJLeacI0AUXZpwNswjPku3v9VJoJFgHQ75Wy0eDAgZGnmMPoyPXv8Cbgq0H/7A11EdHhoOJffREITyeoeyD3cpCnvAnYjn0PGodpeUCEWffuiOZWcUbH0hgEAMXXA0XjLPJfFvKgHfibDHS/038cqEOlUumP/B13U5iACsx6VvHu6264Qk0gwjBVFel0Qlx1RR9gUWNUbqP8cEMWotSbstdzJwExmjAWPUrCF8mwA3OadrO6LFW75qt0h9o4G3qhREodQStN9h9jJbD+QdUFCgS5+uxsjnvmHbCucqhMVcWVR2yqC8o7521hkCgxAcs4zKw+WNEV5Unn2G+FUq8TcyPB1mTSaD9UQM6HdC/bibwgRNJuh1roBOby12QKvp6veCKjHp/6u5hxzUu4swHiqe5ltlz9OcKkDVT52iYx+h+1QA67PUU+YEVTn0A4C0qr3mYZ5FaYY0sD3UrqOIg8X55uJDd4FiyAOLUUmOlx/GvTPvhVuEO22pwmMQ/IheEebb5LTQqklfur3CCmBFdV2JUIjQs75yksjrwagS3Jcjd3zrFKVOcA38m7p4zR9rRQSS48lrx35jHQHLqsG1BmgAsp8ZcSWI4qOYe33On3U32/DkK6+kdcVnfMoRIdTi3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4333.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199015)(66446008)(64756008)(66556008)(66476007)(8676002)(76116006)(4326008)(52536014)(86362001)(55016003)(33656002)(71200400001)(8936002)(5660300002)(66946007)(110136005)(478600001)(2906002)(54906003)(122000001)(38070700005)(53546011)(6506007)(186003)(7696005)(9686003)(107886003)(41300700001)(38100700002)(83380400001)(26005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ckQzMm11V3crSldtYS96SVJEb3huWU9ybW5zM250UVlyZUpHTEJFWGY1Z3A2?=
 =?utf-8?B?TXp3enA2c09LaVZuYXUrY2NqYmRTb3B0eVhNWmdzNlErTFFrVWdJWnlNMThM?=
 =?utf-8?B?QjlJVFpCU09UMGFXSCtwVlhzc0ZlbklneUpyZnQxRTZlR2NWaGVFTWVLSlY2?=
 =?utf-8?B?Q0RGYm9uUko3VHN2N0NaQlhTaXcyT3J3bEZJSGJtSnZlN0IyZEdhM1Fwajd2?=
 =?utf-8?B?L1F6empjNWlPNWpLQjErZGtpSWNsUmwxRXZQcWFsaHVjRFQzU2NXaThRQWFI?=
 =?utf-8?B?SjRlVzNaMFBHdzkyUlRhRytSV2UxSEtheksycGhLZGtsTjZoSDdrc3JaNW8y?=
 =?utf-8?B?cUZlcThOWkVBdFNicnhQdG5wSTNPRDdNVlBPYS9mOHM1bEhYMnZodnpEN1ZM?=
 =?utf-8?B?dDJQUjBwTGFjbGZGTm9KbXhFVVBSTVZEQzJMM0w3Y2REeFo3dFZkV3NLdlZk?=
 =?utf-8?B?RXNaUGhVejdkSkZiVkpBZkI5Y3dsZHdLUEFuU0xEUTFzVmFJSlphaWs1cjlB?=
 =?utf-8?B?S2hWUTh3bWh6emxGaDhCTlZacDl2QWNCdHVlMEFTUGR0OFJ5azRhQ2Z4YkxN?=
 =?utf-8?B?eUhMbDdTSEU2Ui9sYkZoaHpjOVg5QjRLWXdpRnFxdkdIczRqckFzQ0M1YmhN?=
 =?utf-8?B?VHo3NktPbDFETVlGSDdXbXZ4MWwrZlFRb3Q0R2ptMEgyUG10ckxIOUpMVksv?=
 =?utf-8?B?K1gxWjMyRm1ibUdUaHg4bnMzaVRaVzFVS0dEVE9NQ0J6OEJnb001UUhKSURy?=
 =?utf-8?B?QkZXeGV6UVNjdDQ2Y2hlMEh0ajZBcFBUYmE1ci9RYVliL25oNlovSG1sb2JF?=
 =?utf-8?B?NjNyZk5zelZpRU1pb0g0cWdxOTk2WVJZRUVFQTEwNFY4aVFQYk5WRXYyRW9y?=
 =?utf-8?B?ZCtqN3VEbkh4bXg2ZUwyQ2dnRjlnOXF5YUtpRjd2YkZvS1R0TXBsVCsvS0wr?=
 =?utf-8?B?emd1MVh1Q095Q1U5Sk9idjl5UjVMYVVveXQ2Nlg3dVFmNDFjOGx4U0VsdERV?=
 =?utf-8?B?SVNpOVVxSVZuUUk2Vzh0OERsZlZHSEtWaHNVeEE2cGV1bWlCZ3cwczU3QUJW?=
 =?utf-8?B?aFErekdlbXU5YWdQUjg2YXBkcmZaT1dqMEVIS1N4UzhwUm1KcGNYMkE1ekIr?=
 =?utf-8?B?NWJRQ0VYZkZ5U1owdUpDbndVNURFdjA2d0dkY3V5NUJzTm42bjJ1ajJsZ3ps?=
 =?utf-8?B?RERvY3FwMUduWU1mZmlaOVc2M1VFUmdmTjNyTW4vVE9hQm1FRFBHK3VjQjZo?=
 =?utf-8?B?UzdKM0E5WGJIY3Qxc0FMZmkxQ252c0k5OTkxU2hSKy9FY3c2OGMxWTU3aWVJ?=
 =?utf-8?B?UVYwbFIyUG5wZzc2Q0NyY0d1WnFWOERBTXhHMWMyVHBVdnhqckdYcWVaZzhi?=
 =?utf-8?B?UU53S3k1bGZjOU42YWt4K1lKMk15QlFkekFWQWkvV2dXaGMzVHBqMWJCWEJw?=
 =?utf-8?B?RXg4dkQzSGgvMzFxRTZzWVlJT2ZOUEtDVDhSdE9PaVhFUkU1MDk1Ukt6dTVo?=
 =?utf-8?B?Ty8yd1VQbC84SGxzR3JCeXhlU3BLT1ZpTTBoNXNwLy80bDZtT1VBdjN4K1VS?=
 =?utf-8?B?Q0dsaFIyTGhnZzFMMGpaU25QRlk5UkxWdFZYbjZuSkZVbWhXMVFlb0lra3Zp?=
 =?utf-8?B?OWlHemNuRXdpT3dta2ppRm5iekJ6Nk5yTlI0aERhSHVkbVZCYVc5NXJQR083?=
 =?utf-8?B?bjNMa2d4bER4czd1WXZqZm4xYW9xZGVweGdPeTRkWlNEdXhTR3RnUUNzT0Fr?=
 =?utf-8?B?TDBLUDJKakJHSE5wajJxUFpjQXZWT25NSThpeFFVbkhkNmxXaDY3K01wbjRs?=
 =?utf-8?B?WVlMb0hpU3NEOW1uWkJEWmZPN0Ira0I3cXZIZVB3enNibUh0eStRaU1QMEhD?=
 =?utf-8?B?R2VVVFExTzFXS2dKeGhqRHNjWTYxeEp4UjJjZFFrNHFFaGxBRTIvbUE3WWsx?=
 =?utf-8?B?VjhkNTNKS0RLeTJRT3YxSGp1dStua3VIZTV6WTdrcjV4YWVERldWUkh6Q2lT?=
 =?utf-8?B?UW8zeW56eVBrUTlUVUlXbHo5SjVOc0Z0aTJqUjMyWXZydzVUYmpISGk1dis4?=
 =?utf-8?B?K0RZZldHeGVSS1lnaGVJd1psTjFCNnBuV08vKzhuRmUycGJYalZxbWdEYlVO?=
 =?utf-8?Q?+pUQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ceb419-3187-408f-b55b-08da965320f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2022 13:15:00.5368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8FOtnwzOVk8Q4vQtsDfetzfPRM6QVeoxvazOT0lyPNFE1k1oZCsIpIp9KT7LKWEn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5716
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcgY29tbWVudHMuDQoNClBs
ZWFzZSBmaW5kIG15IGlubGluZSBjb21tZW50cyB3aXRoIHRhZyBbUGl5dXNoXS4NCg0KUmVnYXJk
cywNClBpeXVzaCBNZWh0YQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4g
U2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDEzLCAyMDIyIDI6NTIgUE0NCj4gVG86IE1laHRhLCBQ
aXl1c2ggPHBpeXVzaC5tZWh0YUBhbWQuY29tPjsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7
DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3Jn
OyBiYWxiaUBrZXJuZWwub3JnDQo+IENjOiBsaW51eC11c2JAdmdlci5rZXJuZWwub3JnOyBkZXZp
Y2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgUGFsYWR1Z3UsDQo+IFNpdmEg
RHVyZ2EgUHJhc2FkIDxzaXZhLmR1cmdhLnByYXNhZC5wYWxhZHVndUBhbWQuY29tPjsgTWFuaXNo
IE5hcmFuaQ0KPiA8bWFuaXNoLm5hcmFuaUB4aWxpbnguY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIXSBkdC1iaW5kaW5nczogdXNiOiBkd2MzOiBBZGQgaW50ZXJydXB0LW5hbWVzIHRvIGluY2x1
ZGUNCj4gaGliZXJuYXRpb24gaW50ZXJydXB0DQo+IA0KPiBPbiAxMi8wOS8yMDIyIDEwOjU3LCBQ
aXl1c2ggTWVodGEgd3JvdGU6DQo+ID4gRnJvbTogTWFuaXNoIE5hcmFuaSA8bWFuaXNoLm5hcmFu
aUB4aWxpbnguY29tPg0KPiA+DQo+ID4gVGhlIGhpYmVybmF0aW9uIGZlYXR1cmUgZW5hYmxlZCBm
b3IgWGlsaW54IFp5bnFNUCBTb0MgaW4gRFdDMyBJUC4NCj4gPiBBZGRlZCB0aGUgYmVsb3cgaW50
ZXJydXB0LW5hbWVzIGluIHRoZSBiaW5kaW5nIHNjaGVtYSBmb3IgdGhlIHNhbWUuDQo+ID4NCj4g
PiBkd2NfdXNiMzogZHdjMyBjb3JlIGludGVycnVwdC1uYW1lcw0KPiA+IG90Zzogb3RnIGludGVy
cnVwdC1uYW1lcw0KPiA+IGhpYmVyOiBoaWJlcm5hdGlvbiBpbnRlcnJ1cHQtbmFtZXMNCj4gDQo+
IFRoaXMgZG9lcyBub3QgbWFrZSBzZW5zZSBpbiBjb21taXQgbXNnLiBEb24ndCBkdXBsaWNhdGUg
cGF0Y2ggaW4gY29tbWl0DQo+IG1zZy4NCltQaXl1c2hdOg0KV2lsbCByZXBocmFzZSB0aGUgY29t
bWl0IG1lc3NhZ2UgYW5kIHNlbmQgVjIuDQogDQo+IFdoZXJlIGlzIHRoZSB1c2VyIChEVFMpIGFu
ZCBpbXBsZW1lbnRhdGlvbiBvZiB0aGlzIGNoYW5nZT8gSWYgdGhpcyBpcyBzcGVjaWZpYw0KPiB0
byBYaWxpbngsIHdoeSB5b3UgZG8gbm90IGhhdmUgZGV2aWNlIHNwZWNpZmljIGNvbXBhdGlibGU/
DQpbUGl5dXNoXToNCldlIGhhdmUgZGVkaWNhdGVkIGlycSBsaW5lIGZvciBoaWJlcm5hdGlvbiBm
ZWF0dXJlLCAgImhpYmVyIiBpcnEgbGluZSB0cmlnZ2VycyBoaWJlcm5hdGlvbiBpbnRlcnJ1cHQu
DQpEV0MzIGNvcmUgc3VwcG9ydHMgdGhlIGhpYmVybmF0aW9uIGZlYXR1cmUsIHdlIGhhdmUgYSBk
ZWRpY2F0ZWQgY29kZSB3aGljaCBpcyB5ZXQgdG8gYmUgdXBzdHJlYW1lZC4NCkFzIHRoZSBoaWJl
cm5hdGlvbiBmZWF0dXJlIHByb3ZpZGVkIGJ5IGR3YzMtY29yZSwgc28gdGhpcyB3aWxsIGJlIHN1
cHBvcnRlZCBieSBvdGhlciBTT0MvdmVuZG9ycy4NCg0KPiANCj4gPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IE1hbmlzaCBOYXJhbmkgPG1hbmlzaC5uYXJhbmlAeGlsaW54LmNvbT4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBQaXl1c2ggTWVodGEgPHBpeXVzaC5tZWh0YUBhbWQuY29tPg0KPiA+IC0tLQ0KPiA+
ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3NucHMsZHdjMy55YW1sIHwg
MiArKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9zbnBzLGR3YzMu
eWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9zbnBzLGR3
YzMueWFtbA0KPiA+IGluZGV4IDE3NzlkMDhiYTFjMC4uNjE4ZmE3YmQzMmJlIDEwMDY0NA0KPiA+
IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2Ivc25wcyxkd2MzLnlh
bWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3NucHMs
ZHdjMy55YW1sDQo+ID4gQEAgLTUzLDYgKzUzLDggQEAgcHJvcGVydGllczoNCj4gPiAgICAgICAg
LSBjb25zdDogZHdjX3VzYjMNCj4gPiAgICAgICAgLSBpdGVtczoNCj4gPiAgICAgICAgICAgIGVu
dW06IFtob3N0LCBwZXJpcGhlcmFsLCBvdGddDQo+ID4gKyAgICAgIC0gaXRlbXM6DQo+ID4gKyAg
ICAgICAgICBlbnVtOiBbZHdjX3VzYjMsIG90ZywgaGliZXJdDQo+IA0KPiANCj4gDQo+IEJlc3Qg
cmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=
