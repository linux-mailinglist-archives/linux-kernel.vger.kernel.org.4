Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE656022A2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiJRD1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiJRD0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:26:36 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88525A3465;
        Mon, 17 Oct 2022 20:20:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOL8kPuYdMX9rQKOfePqDT14Y/S+jJeONB66AreUPgRRQlkyAUOWfXhJGgznZLiPawgvRi/7c5E20zB1yEoM/5GeHRr4DkcEuS3I60nTNhJjBAZYJwM28792iFGDEbL76IJvcRcd/P8phZz7UJA0xF+Rr4yVP/doHM0dR9uZrd5qZkIid8IwlADsIKQyGtdahI3op4IJuqILm9FoJ2Xq6eOc1jJT/SMgt9WQHAT6JtD8rb5KXftuMPAd1YXdmCYdKfUIGG9j8Rh/gKd24anmY37epXb7nuUSwzbx+WaCq43MCTlen+IQU2u6lep5u71X0gT47jIwM4U1nhB0HTwrzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WU59yyJcyjC/lhRBOw8MGPOmOvjD8wDwQVaQNPtm6OI=;
 b=XTB1g67JyL2FVzEIT/n84wHqysFhCeLSm0dCRF1g1uBju1GJStIqypoXrlWWGQO3tKgSA9gyLWTF3ESkR1567gQTvy5BM02OxkvwngmBUlhKRqjEvhz6bj2Ny/WwyBgCYzeC2TKwr/FIX0/ORzFDhz1cVaL5M7ZEIOINyetTIDAod/WCJEkbVZ7rgl4ngYBKfgfIEYKcnYYKlHSgncnqSu443y9aoa04Lb9JChURjit5f1TzrHwdCBXfFjJIoPJDXCycNKjQRsCEg2hkUnuw9B+PYOqKRgxClK/goc5eAulold1EACYzHyCh5cR2GkdNqT8gQnoRC0Fnk7bF47B7sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WU59yyJcyjC/lhRBOw8MGPOmOvjD8wDwQVaQNPtm6OI=;
 b=c6O2j1kr4jm4g49rrHP+2S8marTJRCUEIVyvtMlFZNKsF3LL2iG6KSY9X+4aYEw6XV098Sp6UpcoIZMNny8vnC3q44m9WKbzN2LFoNJ+wa6nOV5In7EtcmdAxIreDCO/l02ZENiGMToADYAtG9toAjq6gVw7KokvRHG85okkdVGg+uDZsAP59tYxy7ft3vcVMbxbDNFu7uNHieeQB+6SEmOUwb27fmSSuir0JrUIUwUG1e90Q/k8wb+EL4KtXUk2q1lwAWPreztBaqzQYeUcGt2TRgLVOD/qd/ViQqMb3Lz2s7w4xzLW5NNJKRgdF7tMBCAkgrJxMFd9Z3QmiYr79g==
Received: from IA1PR12MB6603.namprd12.prod.outlook.com (2603:10b6:208:3a1::17)
 by PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Tue, 18 Oct
 2022 03:20:33 +0000
Received: from IA1PR12MB6603.namprd12.prod.outlook.com
 ([fe80::d140:ead8:ffd1:76e3]) by IA1PR12MB6603.namprd12.prod.outlook.com
 ([fe80::d140:ead8:ffd1:76e3%6]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 03:20:33 +0000
From:   Jim Lin <jilin@nvidia.com>
To:     Jonathan Hunter <jonathanh@nvidia.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>
Subject: Re: [PATCH v3] xhci: tegra: USB2 pad power controls
Thread-Topic: [PATCH v3] xhci: tegra: USB2 pad power controls
Thread-Index: AQHY3iTzGqk+LW8EIUGun7Nw/Ps9r64Ko9kAgAe3xICAALMQAIAAdjCA
Date:   Tue, 18 Oct 2022 03:20:32 +0000
Message-ID: <ff55893f6876fe04de43906db927fbe1139dc4da.camel@nvidia.com>
References: <20221012102511.3093-1-jilin@nvidia.com>
         <37b168f2-049c-c01f-9f60-c119fabf8606@nvidia.com>
         <cf9b9c605ed06e59edd3ae5deba914cfbfa55be3.camel@nvidia.com>
         <d627e907-8c2e-6a98-20ad-5f7c50e56146@nvidia.com>
In-Reply-To: <d627e907-8c2e-6a98-20ad-5f7c50e56146@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6603:EE_|PH7PR12MB7210:EE_
x-ms-office365-filtering-correlation-id: 076dd00c-6b69-4cf9-93f4-08dab0b7b775
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GBL0wGpg9YeaQHsISKRynYim0/phZ/dS1LK0fj4RKmitpT7Ktm9VS76AggqCZcSxtLm2CgefOJ70xlmeNg5npzG6rqYM7MQd2H55unDMaa2Cd3SvGGAZEyszHrlU/cDtFyciN/qhNP3ysBELphw0FG9/HMHPK9Yr1B3iTaxroc/HiF23k8cmws6gWAKpRjb+IoRUsVRn6Ak5hO4ZKrdyUdwnpD43aOFfebPbcm7lixUQe4+wSXtVo3AGWC3EQ59KdL7z2s0fJJ5Q9mY9qAOS0mpNw97m9S1U8dxPQYCuOoeL16KsZGuxrxnr9soiBDRRJWNq3CumqWIL1LUURmdEIlptzA+MVUlbSa5m3gcZWEjwjoUlHG6hfb2jksr/z3u/ZXqzmZ6LrrQzf20gtd6FriOpSCl5LBsT49Pj8LR7+pBgOhNGh4QBiGWZY3uvgmPDI44hZ68IbcbF+diWB9lhrfcYu/Ywv1plVU6qVI0cldliAS4qkMbpI/oZvwBmgTqdrOs8ZmVeGo3KnS+WYxsYIlk3B7lCD/8MRZ44ewVERma7hPy6+elVldi+2+5aX2S2P0jmeNXy0GwLPS1rN5aT6hJ04iwEZgeTFfgTByv2nvbdY4PqYLTXft6xP97xDSX/QQjKGkiOGqmAW5V4k5zzoaJoLccqOUQJu8XhBIYeXLwOjKVwvo5rfy83kFoxty+ZKVjBc09G65L8K8OxmvNG1Gr3FYtU8pjDceJydyiJMb3pgeFX26vu4R4x+Q/r3mV5LBVyKMoLfmLTtSlgp8b7rW0jHtWy75xqpYX0f2fN0m4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6603.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199015)(6636002)(36756003)(53546011)(26005)(2616005)(8936002)(6512007)(41300700001)(4326008)(64756008)(66556008)(66446008)(66946007)(83380400001)(66476007)(186003)(91956017)(38070700005)(6506007)(2906002)(76116006)(6862004)(8676002)(86362001)(6486002)(122000001)(71200400001)(5660300002)(4001150100001)(37006003)(316002)(478600001)(54906003)(38100700002)(99106002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZktJdjBwUmZjOGZ1S29hUjZBR2E3V0VTWG5pSittbE1pLzlYdkFtd2lzeXhF?=
 =?utf-8?B?V3pVK3RLRVpZbHIranFHK0JyZUxSVDRFZWNyQUIzK3h4Q3pFTGd0MXZwV2Vw?=
 =?utf-8?B?MnFoYXBvSzlaaEtRWGcwdG5QZUpMblFQQWZRdmRIQ3pWN29SR2Y4OUlkZ0RJ?=
 =?utf-8?B?Y0lGMzc1MXNOV3RPQUcrdWEzRHlReWRrcXBORVJWNm5mSk8rT1oydHZxdEUv?=
 =?utf-8?B?Nm5GNFExdzZqeXBkOW52R3lZend5YzB5T2IyOHpDTm5OWmtaVFh1c0lTVlNS?=
 =?utf-8?B?MkRnQWRUQ2x5UGpvM3R6WXBZZXZ6VzZyd1JqekdFWDF4QTZUNDV4N1k4TEZ6?=
 =?utf-8?B?aHczSjJEbmE0eVB2MC9RQmhMNlEwTkNZYmIyTUZFMzM2K2FIVVhsbTJpSFlI?=
 =?utf-8?B?WFNZMDRCLzJMRzY3QUxZeGE5eEtpYmptdWd1amYxTlpCbWdHT0tqZnd3NkNS?=
 =?utf-8?B?a0ROWnFWaHVSWXdSVlJLY20vNnhvdXBaRmFCODE3UjdhVTlUSFlxZXg3NFpW?=
 =?utf-8?B?SmNuekxaVnpZakJ6bzdQNXRMRFJySUdXMVZMcjdwQzNPV1o4c3BQU2Z6TGhO?=
 =?utf-8?B?aDJ0NnlPVFRIZ2R4RGg0OTJYSHltbTU2QWxmQmFGaDdMZ3FSSVF6RGpmanN3?=
 =?utf-8?B?SHBJYTNmREZpZ0RmSG1uV01KdVVzakE3aHNwM3BkMUhBd1ZzMks2Qk9aQTM2?=
 =?utf-8?B?VExtdm5RRlk4ZzFsUlF5YmYyeDZDa21RVmVDYkFSTmtQcVdZSTZTcnZsVjly?=
 =?utf-8?B?eUVrNVcya040eWlhNUxMczRSc1dvTDJDOVBkTUs1bEdyTXRCcTNyalk4Z3FK?=
 =?utf-8?B?RnRuR2wrK1hoR3dPNHF1TTlZVXJsUmZOMlNWTjV6b3BWMWFZSEpLa25INFRa?=
 =?utf-8?B?a0I1ZU1oTTU4REkvYVNHbzNEL0d0NHBhNHFhdnNoYmZYVzVKdnVUNmFTSUxW?=
 =?utf-8?B?NU9zY0x1K2lxK3JXU0ZFUmp4Sk1DR3Q0NHlTK1Q0QTVDR3FsRFpwTDI2eEw3?=
 =?utf-8?B?dWZGSGFFc2xIWXpYTG5NM3c5TzRRZVlneTBjRWpjaXp0WUtBdXZjaCthNncz?=
 =?utf-8?B?emtGTDVoZzVVTDQ1QzI4dWZPdGowaUxnMnhhRzZKQXIvb0hRQTUyRFRGUng3?=
 =?utf-8?B?SmFxRXdtNW5YQ000elBXZGVRZE04RWpyN2MzbHQycXQ1bVVGbWgxeXNZc2xP?=
 =?utf-8?B?N3lIZUJCeWFCTUxEbFRzNlA4VmJmdUdHbWZwT1JVbzdqOXpLa1Z6MVc1aEND?=
 =?utf-8?B?b0pWQ2ZtUjgyRndSVERUNGR3ODVxOUpCT3A2WW1HdWM4U2loSVRzTXFMWTBr?=
 =?utf-8?B?Zkl1N0Q0K3grcmlPclE4cXRpN0gwOTNoU21pOHJIVjNRQ0hZWm9yN3d4d2FV?=
 =?utf-8?B?cCtNU3lTSVh2MDlyRjhLNnYxaTI4Vk5lVDZvV3EyaWppQlk4dFQ4YndkdnZi?=
 =?utf-8?B?V2lBNlN4am5wblhvcTArZ3M1TzQzQkYvdTNVbDBEZTBHaVBoZlhoZ0tBTzln?=
 =?utf-8?B?L040U2VyeE9KaWh0bzNWRXhselk0dVdkcFBVdUNoMzVoYVZZVnRJSnhmNEd4?=
 =?utf-8?B?ejIyNUd5WGY4M3ltZGJPcTVNd2F4ZlM4VjJDWHdzMGVIN1ZyeHdlMjdSRDhV?=
 =?utf-8?B?TytrVm9mYWR0RHJ1eUp4RHFOWmVheXBUaG5OSlVIN3U5YmpQM2xFMkNKWE92?=
 =?utf-8?B?cjJwWlJVbU1XZkxVZEZ3S2FTN3REYTVMYTBrSENEUHBkK3ZCdENBcFhKRE5m?=
 =?utf-8?B?RlZWM3NsY2MySmRXeDU5L1VmcjF0aTZWMXJaNmp6ZHRqMUxjUEJUbStvaHlJ?=
 =?utf-8?B?K2FNaDd0VGxaOFFCSWZWeC94UVhIMDRReklNV21KekkzUi84QkUvQXBMMUw5?=
 =?utf-8?B?K1VvdFZ1UnNCTm42dFc1bENpanl3WGthL1hxaFVkM05rYW5iTGdiMFNEbGxS?=
 =?utf-8?B?N09VcEg3Qll1cjFYekgxUU9tVk9ITmt3bUtWdTVhKzd2KzgvakdzSldoQkVD?=
 =?utf-8?B?YXZleURUNk1qcm14WEFJUG1jNDFPZ1dTWUFqRHJORzhBT284bTZETzFzbUx1?=
 =?utf-8?B?SytDRWlmY1o0bTQ4VmxNbktGNWdURytTb0daVkpna0N5QlZpSHNMVjloYWtI?=
 =?utf-8?Q?aDKjVHeLC2zjxGGKU2yr+GZ5y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B2076D88B45F847B15717ABECB9C793@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6603.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076dd00c-6b69-4cf9-93f4-08dab0b7b775
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2022 03:20:32.9473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M67pAN2cnGQXfk0q1g4JqcpSmJRoLz/YioYEAokyJP/M5+vnDVQPLJjg2G47CFbYUnJGhrU/vMBcabcBvHK9Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7210
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTE3IGF0IDIxOjE3ICswMTAwLCBKb24gSHVudGVyIHdyb3RlOg0KPiBP
biAxNy8xMC8yMDIyIDEwOjM2LCBKaW0gTGluIHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAyMi0xMC0x
MiBhdCAxMjo0NSArMDEwMCwgSm9uIEh1bnRlciB3cm90ZToNCj4gPiA+IE9uIDEyLzEwLzIwMjIg
MTE6MjUsIEppbSBMaW4gd3JvdGU6DQo+ID4gPiA+IFByb2dyYW0gVVNCMiBwYWQgUEQgY29udHJv
bHMgZHVyaW5nIHBvcnQgY29ubmVjdC9kaXNjb25uZWN0LA0KPiA+ID4gPiBwb3J0DQo+ID4gPiA+
IHN1c3BlbmQvcmVzdW1lLCBhbmQgdGVzdCBtb2RlLCB0byByZWR1Y2UgcG93ZXIgY29uc3VtcHRp
b24gb24NCj4gPiA+ID4gZGlzY29ubmVjdCBvciBzdXNwZW5kLg0KPiA+ID4gPiANCj4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogSmltIExpbiA8amlsaW5AbnZpZGlhLmNvbT4NCj4gPiA+ID4gLS0tDQo+
ID4gPiA+IHYyOiBGaXggaXNzdWUgdGhhdCB3cm9uZyB0ZWdyYS0+cGh5c1tdIG1heSBiZSBhY2Nl
c3NlZCBvbg0KPiA+ID4gPiB0ZWdyYTEyNA0KPiA+ID4gPiB2MzogTm8gY2hhbmdlIG9uIGNvcHly
aWdodA0KPiA+ID4gPiANCj4gPiA+ID4gICAgZHJpdmVycy91c2IvaG9zdC94aGNpLXRlZ3JhLmMg
fCAxMzkNCj4gPiA+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ID4g
PiAgICAxIGZpbGUgY2hhbmdlZCwgMTM4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
PiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktdGVncmEu
Yw0KPiA+ID4gPiBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS0NCj4gPiA+ID4gdGVncmEuYw0KPiA+
ID4gPiBpbmRleCBjOGFmMmNkMjIxNmQuLjk5NjE4MmExOTU5ZiAxMDA2NDQNCj4gPiA+ID4gLS0t
IGEvZHJpdmVycy91c2IvaG9zdC94aGNpLXRlZ3JhLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy91
c2IvaG9zdC94aGNpLXRlZ3JhLmMNCj4gPiA+ID4gQEAgLTE4OSw2ICsxODksMTMgQEAgc3RydWN0
IHRlZ3JhX3h1c2JfY29udGV4dF9zb2Mgew0KPiA+ID4gPiAgICAJfSBmcGNpOw0KPiA+ID4gPiAg
ICB9Ow0KPiA+ID4gPiAgICANCj4gPiA+ID4gK2VudW0gdGVncmFfeGhjaV9waHlfdHlwZSB7DQo+
ID4gPiA+ICsJVVNCM19QSFksDQo+ID4gPiA+ICsJVVNCMl9QSFksDQo+ID4gPiA+ICsJSFNJQ19Q
SFksDQo+ID4gPiA+ICsJTUFYX1BIWV9UWVBFUywNCj4gPiA+ID4gK307DQo+ID4gPiA+ICsNCj4g
PiA+ID4gICAgc3RydWN0IHRlZ3JhX3h1c2Jfc29jIHsNCj4gPiA+ID4gICAgCWNvbnN0IGNoYXIg
KmZpcm13YXJlOw0KPiA+ID4gPiAgICAJY29uc3QgY2hhciAqIGNvbnN0ICpzdXBwbHlfbmFtZXM7
DQo+ID4gPiA+IEBAIC0yNzQsOSArMjgxLDE3IEBAIHN0cnVjdCB0ZWdyYV94dXNiIHsNCj4gPiA+
ID4gICAgDQo+ID4gPiA+ICAgIAlib29sIHN1c3BlbmRlZDsNCj4gPiA+ID4gICAgCXN0cnVjdCB0
ZWdyYV94dXNiX2NvbnRleHQgY29udGV4dDsNCj4gPiA+ID4gKwl1MzIgZW5hYmxlX3V0bWlfcGFk
X2FmdGVyX2xwMF9leGl0Ow0KPiA+ID4gPiAgICB9Ow0KPiA+ID4gPiAgICANCj4gPiA+ID4gICAg
c3RhdGljIHN0cnVjdCBoY19kcml2ZXIgX19yZWFkX21vc3RseSB0ZWdyYV94aGNpX2hjX2RyaXZl
cjsNCj4gPiA+ID4gK3N0YXRpYyBpbnQgKCpvcmlnaW5hbF94aGNpX2h1Yl9jb250cm9sKShzdHJ1
Y3QgdXNiX2hjZCAqaGNkLA0KPiA+ID4gPiB1MTYNCj4gPiA+ID4gdHlwZVJlcSwgdTE2IHdWYWx1
ZSwgdTE2IHdJbmRleCwNCj4gPiA+ID4gKwkgICAgY2hhciAqYnVmLCB1MTYgd0xlbmd0aCk7DQo+
ID4gPiANCj4gPiA+IElzIGl0IGJldHRlciB0byBhZGQgdGhpcyBmdW5jdGlvbiBwb2ludGVyIHRv
IHRoZSB0ZWdyYV94dXNiDQo+ID4gPiBzdHJ1Y3R1cmU/DQo+ID4gPiANCj4gPiA+IEpvbg0KPiA+
ID4gDQo+ID4gDQo+ID4gRG8geW91IG1lYW4gcmVtb3ZpbmcgdmFyaWFibGUgIm9yaWdpbmFsX3ho
Y2lfaHViX2NvbnRyb2wiIGFuZCBzYXZlDQo+ID4gZnVuY3Rpb24gcG9pbnRlciB0byB0aGUgdGVn
cmFfeHVzYiBzdHJ1Y3R1cmUgPw0KPiA+IA0KPiA+IEJ1dCB0aGF0IGRvZXNuJ3QgbG9vayBwb3Nz
aWJsZSBvdmVyIGhlcmUgdG8gcG9pbnQgdG8gdGVncmFfeHVzYg0KPiA+IHN0cnVjdHVyZSBhbmQg
c2F2ZSBwb2ludGVyICh0byB0ZWdyYV94aGNpX2hjX2RyaXZlci5odWJfY29udHJvbCkNCj4gPiBp
bnRvDQo+ID4gaXQuDQo+IA0KPiANCj4gQWggeWVzLCB0aGlzIGlzIGluIHRoZSBpbml0IGZ1bmN0
aW9uIGFuZCBzbyB3ZSBjYW4ndCBkbyB0aGF0LiBBbnkNCj4gaXNzdWUgDQo+IHdpdGggY2FsbGlu
ZyB4aGNpX2h1Yl9jb250cm9sKCkgZGlyZWN0bHkgaW4gdGhlIGZ1bmN0aW9uIA0KPiB0ZWdyYV94
aGNpX2h1Yl9jb250cm9sKCk/DQo+IA0KPiBKb24NCj4gDQpUaGFua3MsIHdpbGwgdHJ5Lg0KDQot
LW52cHVibGljDQo=
