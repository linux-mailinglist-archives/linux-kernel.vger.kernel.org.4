Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CBF5E72F0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 06:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiIWE26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 00:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiIWE24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 00:28:56 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE5C11E973;
        Thu, 22 Sep 2022 21:28:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwBz4wb7e9xNYgIfz8xis2qe1Gd1jlQz2AabfNMqwyH82crlHGuyEIQCR0kC85ylpirmKmLTGZUVunFd0spTE15lB//de3rZCPrylBp5YHgK4w3zayjXr+gdeYH6MbQw6PVoUbC36xol+QqCzmTjzgNTOzuHwciahZWnPRhtmLJnRXw95YGRXz9BAMXszjUn7ERAJwvKQQ93kbILsbSL/9+7nFFzX77bMjNX37XlPrsWgkKaVW+tjlwrfGxgb/KE/FSgHsl+RKDJfu825Rclh/cV33APv6PtQQwaczpqE8qlFM8qKrYhzL5RrmVRJFMOQ356GztNTlBnjep3aW9RlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xUh6nntJcPnm3afaYrtVOUsEhlb3mn9yBQ3tXRZi7Ks=;
 b=U7wJQ7bqTzk8ZR93NdubfCuq/oSgbnKoVUk+CxSfDXbPeBOh0+tXwks59Ypf9dVx49b2vP5NNBGDlQC/Q72YUip+PXZ41YpoFXBXsvzFEG+40A/AdqAZdzKRUAr8/003YHHDnnoHOHH09r8Iv+qgbk4QzL7bj6BATVcSHUNGtwhoW50GyPqg9ReKRiviV8HuPWbDRrX9zfk3WxyNq3nEAvo5HPuh1sVgPHb4kaOwrh+spVyApWp9LQXAYVZATIuWLaZp03lvvLJUi+DhqqPqZbXyu72B3Wp35H+Znff4DqMWPTDwbjh/FLMyBIpU3zVrQHkx0VqV2/TKfiH/wQ9m/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUh6nntJcPnm3afaYrtVOUsEhlb3mn9yBQ3tXRZi7Ks=;
 b=WE1V0x7n/XU42M7j2Op4pINYrsctX9fUxnIMdVwZ712x9zj1wSKmTVI6Ms6xvEQCuVPU1f3CEJ9lRQ+F9uGc6bmBzRDHCK/VEWe4xQ4LulqIxku7gcIsvsP1OJYRdMgqhM7U3aCHA0jPPIPb766oGV9Rad3bhYxZ3+tHapPPJLw=
Received: from MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23)
 by DM4PR12MB5342.namprd12.prod.outlook.com (2603:10b6:5:39f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Fri, 23 Sep
 2022 04:28:47 +0000
Received: from MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::1438:15a9:cb60:6f03]) by MN2PR12MB4333.namprd12.prod.outlook.com
 ([fe80::1438:15a9:cb60:6f03%5]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 04:28:45 +0000
From:   "Mehta, Piyush" <piyush.mehta@amd.com>
To:     "Simek, Michal" <michal.simek@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "balbi@kernel.org" <balbi@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Paladugu, Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>,
        Manish Narani <manish.narani@xilinx.com>
Subject: RE: [PATCH] dt-bindings: usb: dwc3: Add interrupt-names to include
 hibernation interrupt
Thread-Topic: [PATCH] dt-bindings: usb: dwc3: Add interrupt-names to include
 hibernation interrupt
Thread-Index: AQHYxoXS/6kPrZnbm0ah5M+XCTD+5K3dF3KAgAHHNvCAAVMmAIAABZkAgAGkkQCACYWfgIABFjDA
Date:   Fri, 23 Sep 2022 04:28:45 +0000
Message-ID: <MN2PR12MB43339688207D0E5695D0051488519@MN2PR12MB4333.namprd12.prod.outlook.com>
References: <20220912085730.390555-1-piyush.mehta@amd.com>
 <4cc7a6d2-64ef-c176-21ad-4c3e66f664f7@linaro.org>
 <MN2PR12MB43330B57F5CFBEC35105665188469@MN2PR12MB4333.namprd12.prod.outlook.com>
 <05ce5c7c-c7e2-cac1-341a-5461804f96ea@linaro.org>
 <46b9bb31-efb5-1e1f-9d01-3841661293dc@amd.com>
 <00368da8-bf24-da5a-15da-dbc1a6a716e8@linaro.org>
 <1824afba-c249-f5d1-e504-d71bf7d79979@amd.com>
In-Reply-To: <1824afba-c249-f5d1-e504-d71bf7d79979@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4333:EE_|DM4PR12MB5342:EE_
x-ms-office365-filtering-correlation-id: 420377f2-431d-45e4-94bb-08da9d1c1a37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y4aJrVvsuHzoBGnZu9fZLFuidwoKtR6Q78FdGpi7yHf6GAKSvR3A1f972iCyKVFo0FMitOB0tnVBqPfF1E7BetNG7jAQATru0R8/pNq5sGC7thdR6CNMLtsfE2qMtGqh9gAA2uAQNcDAF6pBxSXaVyDphMeBZwkcr5Wbdlr3TRNhd+c2jq/l4chVU+14Mqwg31LVKxamx7ZNYVi/jDHw27Bjv1wUI82UrW+XHIbf4UmOmrIDft06b6u4T8ninKBTDkzDD8j9NNgxJnZEKh9GH6qdOuTNTSg0PZt4EqsuIM6CYk1u4NBghAkFkuqIHktVBRkkzPyqh7MoZI8q0KE9Q59eSbwpmDQstT2sR/2ZQ8c3Ee1XFOVNHP4wQ61iQVcnv71aBs4Zvw/k2ummyQx+2IYYnxLcU3oFBzlt+EIyWH4Q91nC2jWssWGnbPXT/k/2ZbEkCrxKBCmTEX9FTo+Mm9egoPGunWolPJ3qaRPUMgmxt6kOKQSNRMytSFBRWQ6K9F5QPpQ9PR3jgGTdDGkj4GB0AEriIOzt5NMF9Ztx19S1HHLHGf3rmfpOs3+avku5wZgwSVjkcr7otAyYAj+e4JXLBD71kH7QRzXmgoj5M2CrENh0DHPwc7oqjfihTXpzRgn4BEk/kiVTiUsiDHmVX9pv9yqJcIkKv08Wn/0J3qUwa2TCa+d4mu+qwR3Yl07kxrBg+E9RjtAUKqE26nm1gvrLerGpsnmq5gE6WZIZywW80TzPKBpLg9I8LCu/gkxxODYiAhzfwj4iuOQm7IIaZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4333.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(451199015)(186003)(71200400001)(83380400001)(4326008)(66946007)(8676002)(64756008)(38070700005)(8936002)(66556008)(66446008)(66476007)(33656002)(2906002)(86362001)(110136005)(478600001)(122000001)(38100700002)(41300700001)(76116006)(316002)(55016003)(107886003)(9686003)(52536014)(5660300002)(53546011)(7696005)(54906003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmNVb2dIdVpnWVhKODdTVHZWeGJ6VmFaSlB1MXFqbEZ6ODBoWEJIdnU5SC9E?=
 =?utf-8?B?d1FoSHNuaUZuN0phSjlTTHlPL084RVBNaW0yN0tnbWxUZ2ZUblJ4VUZnb0Jx?=
 =?utf-8?B?UGtpMFVOM0M3Q1loUitEeGxwcG1OYmFQMUdnTzNndjhhUmFRZE1HeTdVMERH?=
 =?utf-8?B?N2FUVXc2MzBKdEtPWlJ6b0xpaW91blc0dDgrWXd3VUJob2Z0cGFRaVhsSUlD?=
 =?utf-8?B?eFhpSVFvcGgyclROTWxqNDdWSWdNalp6NmxPSHdqdk52Y3RmUkl5dXlsaDNQ?=
 =?utf-8?B?WHFWNzBPZWxnUFhuMkszWDFiSTk1ZWsxa1JQa3l0ZjRUV0ZFeTZ1M3MyNEZH?=
 =?utf-8?B?WmViTFpiRWtiMHBuTXlWSjhtNEIxekJSbUdxUHBMa2Q1UUFBM3c0eG9Wbksv?=
 =?utf-8?B?RTRmLzdRbVBrU1RyTFdwSml5Z3lZN2lpU3RyZEtaOWY1OG1VRDFIclNKQXY0?=
 =?utf-8?B?blZva1pQZGMya2tRZTJHdUxjc1RjK2xaYzJsNzdlSmFqMlVYakV3UmhML0M1?=
 =?utf-8?B?MUF2QytVUndWS2JpV2h2a1l3ZjJrK045NXF6SjczRStwTkNvazExLy82Qk9l?=
 =?utf-8?B?dHY0SGU3cTEyVjFVS1o4MmxBbnJiM0N3QUpQbmJ5cDNLajRNSWNoNEVGTXc4?=
 =?utf-8?B?empERnoyNHdXS1lJbE0rSjhMMHJMWHhKc2huNGg0SDVLSlE1U2NXZ2Y1alJ2?=
 =?utf-8?B?WFlsbmhoZkZ0UjJOblNuTkRDM1FTUWZCb1RaOVZDQUlSZmcwL2ZWUjllbGVI?=
 =?utf-8?B?UkN2Z1lHbGt1TThqWmtzSmRwQU1qWnhFWU4wNWJHci9WdEh5Vnoyc1VKSVRP?=
 =?utf-8?B?VGcwVVpiVnFCTGgwZmN5QU4wcW9OSFpvcFpuTXRla25TMjhyTW1CdTVUbGVG?=
 =?utf-8?B?UzBvQlkzMUx3YjU4eUgxYXNXMGgvSVRldWY1dnQ0T3ZFQ1pBSVR2TlRrMjV5?=
 =?utf-8?B?V2YyamNTYmNRN0xvU2hSc1Fvb3dtTnV5TUxiN0lrMjU2QXRMb0xzdzFxYmhh?=
 =?utf-8?B?ZDdFYTFxVHRXMk92cVdnZ1JnVVZrOWZYenFGNk9jQmk5U29RbDluSlkwRG8w?=
 =?utf-8?B?Q0p2MDMxOFpOQU5IaGdiR3hvS2hSK3JNNkZRVGJ3clNPMTBKZ1pBc0Rva0s1?=
 =?utf-8?B?QmlxQVByUHd6UWhLSEVoZXk1ZEl4MFlaUWdaTmZOaUk3QldJWGVkb25hZUh0?=
 =?utf-8?B?YmVnRHkxcjVHcFZQUkpCT29uYkVLb1BMblY5RkVQVFB4TDl3WFdGR1I3dFJI?=
 =?utf-8?B?c1Nyamx1c2w4NTRieHVpUXVFdFE4VlFHNVhRMG9zZGlnMGtCZlZXZUM5TWpq?=
 =?utf-8?B?N1JxWm5KSFM1TFRCYjB5b1FFRHpxdEFBMGF3S0ZXQUFOcWRUYmRLVGNIMnNZ?=
 =?utf-8?B?YTY2Ym1sVFVpSmVmaUs4Ull5cW1CME1zNStVZ3FiQVRqcGVHeHFheTIzbCtH?=
 =?utf-8?B?VGczSzYwR3NKemNwc3VweWFUcVFsclplcko1UzliNVhueWVPdXFEUkYzMUhT?=
 =?utf-8?B?VHpKU0c3RzA1VHpnellWdUpSbjBJNzNXNXJmZ2VLMzJUWU5jR0hDZWVxUlBY?=
 =?utf-8?B?d0UzSi9LQXZEcTBabTU0WE43c09FRTRYd0hsOVdkcmhLMGxZcEhCbXlTd2Zv?=
 =?utf-8?B?ekNXWkRKazFCYS9TcjJnN1h4M0JGdXcxTC9LTkRXV0xvYTIvamh5RDF4QWp5?=
 =?utf-8?B?Y3hWejRERWtuajBzMCsxc2FkSkF4d1pQRTdtQVVvWWdIdjh5ejZhTEVYRjZz?=
 =?utf-8?B?c3E3T201NXp4cTN6cSttSzZNclViUXgyOHE3OFR6YkxlMWdIcDRDcFd1Y0Fk?=
 =?utf-8?B?aFhPVVkzODYyeVExRmtVdjYyaDNaUFRTdFRyeHlaZ2hBbDhRQm9NVHJEK1ov?=
 =?utf-8?B?OFcrU2tuRTlFZHZyQzVRQ3NLSEpOVVAvUGxSZHgrRU5NV3Y1RVk2OW84dUJm?=
 =?utf-8?B?U2dKUUlYMG5WbFhZMXBuNmtwV2t5cjlWMlJwWTljVjdPcWM3MVVBMVErbHFu?=
 =?utf-8?B?eWljazVZUW92UGJ1ZVl6NzFhL0txT1g1VjNDbXBjWWpvSXRGcVdlbnlnWnhF?=
 =?utf-8?B?ejdhMTBhM2xvd21rZHdGemFveUNISFdWcC9xaHZPSlkxYUpucXFDbnZPWHBp?=
 =?utf-8?B?N2VTK28zTWpLYUJlWlg0a2VhOFVvRW9DUU5NeTlXYzhRSlhLYTg4Z0RJMDZC?=
 =?utf-8?Q?+6h4GQLyy4pxqTklwfCzqOM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4333.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 420377f2-431d-45e4-94bb-08da9d1c1a37
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2022 04:28:45.0685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6VxEtrFn76fQIVCuhWx7KZFlDADB2dTsz27bsXplrizO9BU5LGo0XeNG+rt1A6Cx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5342
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2ltZWssIE1pY2hhbCA8
bWljaGFsLnNpbWVrQGFtZC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMjIsIDIw
MjIgNTowNSBQTQ0KPiBUbzogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3Nr
aUBsaW5hcm8ub3JnPjsgTWVodGEsIFBpeXVzaA0KPiA8cGl5dXNoLm1laHRhQGFtZC5jb20+OyBn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsNCj4gcm9iaCtkdEBrZXJuZWwub3JnOyBrcnp5c3p0
b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IGJhbGJpQGtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4
LXVzYkB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC0N
Cj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgUGFsYWR1Z3UsIFNpdmEgRHVyZ2EgUHJhc2FkDQo+
IDxzaXZhLmR1cmdhLnByYXNhZC5wYWxhZHVndUBhbWQuY29tPjsgTWFuaXNoIE5hcmFuaQ0KPiA8
bWFuaXNoLm5hcmFuaUB4aWxpbnguY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkdC1iaW5k
aW5nczogdXNiOiBkd2MzOiBBZGQgaW50ZXJydXB0LW5hbWVzIHRvIGluY2x1ZGUNCj4gaGliZXJu
YXRpb24gaW50ZXJydXB0DQo+IA0KPiANCj4gDQo+IE9uIDkvMTYvMjIgMTI6MTAsIEtyenlzenRv
ZiBLb3psb3dza2kgd3JvdGU6DQo+ID4gT24gMTUvMDkvMjAyMiAxMDowNCwgTWljaGFsIFNpbWVr
IHdyb3RlOg0KPiA+Pg0KPiA+Pg0KPiA+PiBPbiA5LzE1LzIyIDEwOjQ0LCBLcnp5c3p0b2YgS296
bG93c2tpIHdyb3RlOg0KPiA+Pj4gT24gMTQvMDkvMjAyMiAxNDoxNSwgTWVodGEsIFBpeXVzaCB3
cm90ZToNCj4gPj4+Pg0KPiA+Pj4+PiBXaGVyZSBpcyB0aGUgdXNlciAoRFRTKSBhbmQgaW1wbGVt
ZW50YXRpb24gb2YgdGhpcyBjaGFuZ2U/IElmIHRoaXMNCj4gPj4+Pj4gaXMgc3BlY2lmaWMgdG8g
WGlsaW54LCB3aHkgeW91IGRvIG5vdCBoYXZlIGRldmljZSBzcGVjaWZpYyBjb21wYXRpYmxlPw0K
PiA+Pj4+IFtQaXl1c2hdOg0KPiA+Pj4+IFdlIGhhdmUgZGVkaWNhdGVkIGlycSBsaW5lIGZvciBo
aWJlcm5hdGlvbiBmZWF0dXJlLCAgImhpYmVyIiBpcnEgbGluZQ0KPiB0cmlnZ2VycyBoaWJlcm5h
dGlvbiBpbnRlcnJ1cHQuDQo+ID4+Pj4gRFdDMyBjb3JlIHN1cHBvcnRzIHRoZSBoaWJlcm5hdGlv
biBmZWF0dXJlLCB3ZSBoYXZlIGEgZGVkaWNhdGVkIGNvZGUNCj4gd2hpY2ggaXMgeWV0IHRvIGJl
IHVwc3RyZWFtZWQuDQo+ID4+Pj4gQXMgdGhlIGhpYmVybmF0aW9uIGZlYXR1cmUgcHJvdmlkZWQg
YnkgZHdjMy1jb3JlLCBzbyB0aGlzIHdpbGwgYmUNCj4gc3VwcG9ydGVkIGJ5IG90aGVyIFNPQy92
ZW5kb3JzLg0KPiA+Pj4NCj4gPj4+IEJ1dCBpcyBoaWJlciBpcnEgbGluZSBwcmVzZW50IGluIG90
aGVyIHZlbmRvcnM/IFdoYXQgY29uZnVzZXMgbWUgaXMNCj4gPj4+IGFkZGluZyBub3Qgb25seSAi
aGliZXIiIGlycSBidXQgYWxzbyBvdGcgaW4gY29tcGxldGVseSBuZXcgZW51bS4NCj4gPj4NCj4g
Pj4gSSB3aWxsIGxldCBQaXl1c2ggdG8gY29tbWVudCBoaWJlciBJUlEuIEJ1dCBJIGV4cGVjdCB3
ZSBkb24ndCBoYXZlDQo+ID4+IHZpc2liaWxpdHkgd2hhdCBvdGhlcnMgYXJlIGRvaW5nIGJ1dCB0
aGlzIGlzIGxpbmUgaXMgbm90IFhpbGlueA0KPiA+PiBpbnZlbnRpb24gdGhhdCdzIHdoeSBJIGV4
cGVjdCBJUCBmcm9tIFN5bm9wc3lzIGhhdmUgaXQgYnkgZGVmYXVsdCBidXQNCj4gPj4gaXQgaXMg
dXAgdG8gc29jIHZlbmRvciBpZiBoaWJlcm5hdGlvbiBmZWF0dXJlIGlzIGVuYWJsZWQgb3Igbm90
Lg0KPiA+Pg0KPiA+PiBvdGcgaXMgYWxyZWFkeSBsaXN0ZWQgaW4NCj4gPj4gRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9zbnBzLGR3YzMueWFtbA0KPiA+Pg0KPiA+PiBJdCBp
cyBvbmx5IGFib3V0IG9yZGVyLg0KPiA+PiBEcml2ZXIgaXMgYWxyZWFkeSB1c2luZw0KPiA+PiBw
bGF0Zm9ybV9nZXRfaXJxX2J5bmFtZS4uKCkgZnVuY3Rpb25zDQo+ID4NCj4gPiBMaW51eCBkcml2
ZXIgeWVzLCBidXQgb3RoZXIgcGxhdGZvcm1zIChib290bG9hZGVycywgb3BlcmF0aW5nIHN5c3Rl
bXMpDQo+ID4gbWlnaHQgYmUgZG9pbmcgdGhpbmdzIGRpZmZlcmVudGx5LiBUaGVyZWZvcmUgdGhl
IG9yZGVyIGFuZCBpdGVtcyBhcmUNCj4gPiB1c3VhbGx5IHN0cmljdC4gSWYgdGhleSBjYW5ub3Qg
YmUgc3RyaWN0LCBpdCBpcyBuaWNlIHRvIGtub3cgd2h5IG9yIGl0DQo+ID4gaXMgbmljZSB0byBy
ZXN0cmljdCBpdCB0byBzb21lIHNwZWNpZmljIHZhcmlhbnQgKGlmIGl0IGlzIGFwcGxpY2FibGUp
Lg0KPiA+DQo+ID4gVGhpcyBpcyB3aHkgSSBhc2tlZCB3aGV0aGVyIHRoZSBsaW5lIGlzIHNwZWNp
ZmljIHRvIFhpbGlueCBvciB0byBvdGhlcnMuDQo+ID4NCj4gPj4NCj4gPj4gSSB0aGluayBhbnkg
Y29tYmluYXRpb24gc2hvdWxkIGJlIGZpbmUuIERvIHdlIG5lZWQgdG8gcmVjb3JkIHVzZWQNCj4g
Pj4gb3JkZXIgb3IgdGhlcmUgaXMgd2F5IGluIHlhbWwgdG8gc3VwcG9ydCBhbnkgY29tYmluYXRp
b24gd2l0aA0KPiA+PiBkd2NfdXNiMywgaG9zdCwgcGVyaXBoZXJhbCwgb3RnIHNob3VsZCBiZSB3
b3JraW5nIChpZ25vcmluZyB0aGF0IGhpYmVyDQo+IHdoaWNoIHNob3VsZCBiZSBsaWtlbHkgdGhl
cmUgdG9vKS4NCj4gPg0KPiA+IFdoYXQgY29uZnVzZXMgbWUgaGVyZSBtb3JlLCBpcyBoYXZpbmcg
b3RnLiBJIHVuZGVyc3RhbmQgdGhhdCBkd2NfdXNiMw0KPiA+IGlzIHRoZSBzaW5nbGUgaW50ZXJy
dXB0IGZvciBhbGwgdGhlIG1vZGVzLCBzbyBteSBuYWl2ZSBhcHByb2FjaCB3b3VsZCBiZToNCj4g
PiBvbmVPZjoNCj4gPiAgIC0gZHdjX3VzYjMNCj4gPiAgIC0gZW51bSBbZHdjX3VzYjMsIGhpYmVy
XQ0KPiA+ICAgLSBlbnVtIFtob3N0LCBwZXJpcGhlcmFsLCBvdGddDQo+ID4gICAtIGVudW0gW2hv
c3QsIHBlcmlwaGVyYWwsIG90ZywgaGliZXJdDQo+ID4NCj4gPiBIb3dldmVyIGhlcmUgUGl5dXNo
IGFkZHMgbm90IG9ubHkgaGliZXIgYnV0IGFsc28gb3RnLi4uDQo+IA0KPiBJIHdhcyBsb29raW5n
IGF0IGNvZGUgYW5kIEkgdGhpbmsgd2Ugc2hvdWxkIGJlIGFibGUgdG8gdXNlIHRoaXMgb3JkZXIN
Cj4gLSBlbnVtIFtob3N0LCBwZXJpcGhlcmFsLCBvdGcsIGhpYmVyXQ0KPiB3aGljaCBzaG91bGQg
ZW5zdXJlIGNvbXBhdGliaWxpdHkgaW4gb3RoZXIgU1cgcHJvamVjdHMuDQo+IA0KPiBXZSBjYW4g
Y29tcGxldGVseSBpZ25vcmUgZHdjX3VzYjMuIEl0IG1lYW5zIGFib3ZlIGR3Y191c2IzLCBoaWJl
cg0KPiBzaG91bGRuJ3QgYmUgYWxzbyBsaXN0ZWQgdG8gbWFrZSBzdXJlIHRoYXQgdGhlIHNlY29u
ZCBlbnRyeSBpcyBhbGwgdGhlIHRpbWUgaXJxDQo+IGZvciBwZXJpcGhlcmFsLg0KPiANCj4gVGhh
bmtzLA0KPiBNaWNoYWwNCg0KRW5hYmxpbmcgd2FrZXVwIGluIHp5bnFNcCB3ZSBuZWVkIHRvIHB1
dCB0aGUgY29yZSBpbnRvIGhpYmVybmF0aW9uLCBhcyB2ZXJzYWwgZG9uJ3QgaGF2ZSBoaWJlcm5h
dGlvbiBjb25jZXB0LCBidXQgd2UgcmVxdWlyZSBpbnRlcnJ1cHQgZm9yIHdha2V1cC4NCldlIGhh
dmUgYSB2ZXJzYWwgcGxhdGZvcm0gd2hlcmUgd2UgYXJlIG5vdCB1c2luZyBoaWJlcm5hdGlvbiwg
YnV0IHN5c3RlbSB3YWtlIHVwIHdlIG5lZWQgdGhlIGludGVycnVwdC4gRm9yIHRoaXMgaW50ZXJy
dXB0LW5hbWUgZW51bSB3b3VsZCBiZToNCi0gZW51bSBbaG9zdCwgcGVyaXBoZXJhbCwgb3RnLCB1
c2Itd2FrZXVwXQ0KDQpSZWdhcmRzLA0KUGl5dXNoIE1laHRhDQo=
