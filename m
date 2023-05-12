Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAED6700777
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 14:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240558AbjELMJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 08:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjELMJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 08:09:41 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3D4F4;
        Fri, 12 May 2023 05:09:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euKdCfSMJDHiMb3ZHAqEwOZD3dTY0Vh/IQ3WD/CLAfGXLwqLuRom7acWLzYJ4zoJApUKOeKrmt1U5XaCsrAd6ziQ1wXULfn+oRrCd9n2opJbqdb4GiAS5T90At31/TI8i553frawrM/ysC/JgMwOwhyFWNxqTiBHsEX4X/V5Igzlgn/9W3oZUyo5V3HUshm/+S55lLU9MxY5WlpGX6BClDEqgfG69dq8gKHXfn5HGT/0VS5v72maOTdb3fWEMD8bPoRIDkfs9R+ucvdPx+/eI4SfSbc3J8sDuXMUPRpuANpE6mWjRX1HkvcVkSZUYSugTfeGYcfOjLwz7AlpRAXWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vM+0cY7Btab/atLVhAKJCupht00FF/D2RSKfp77ZvHM=;
 b=F49uBZ4ArpBx3pb5uRapxcUO2sQsQ39qSrNB6fWalMBm4n/v7VVdYhcWFKNLsZyd5BVG8M8lA5FRo3DrjJ562RGZbXNTrtruNQ+k2C0S38l3kExlGTh5/+g/TRGLR4VqcAGA15RIpruGDbjI4FNNjVZWCdqcGV84XgM0ihlCMikmyNINZAyHpYvPN348B6/LZATFPTFUbxq45p5EsyfwlmN4vYLkQiPXkVC6BNgOYJcgvWaldKQ7F5ufycbTneKxnkUQJ67MCyWjt0hb+m+uVy32j9+rEytb9MSJ7SJNCqzt0tCOQNO/djQNqi4qX8pHVAaApnyIRsAUXmv+3DtXSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vM+0cY7Btab/atLVhAKJCupht00FF/D2RSKfp77ZvHM=;
 b=Y0q0J7y9VzRwcTE3BNqWTwN2AKlPKlfBCNE/Q/8JofsVMsPC6H+G8nlxA0N1FtzynwyRMf5pOzEcCoxREBvNQIu+FnOO54we41uVbXL9Az9MlsafpUKwnZ+E6n68pBnKVNXDVrm7md90a+1jnP8JlHZRq8a2r+PwRydJM1tT+XTk31A06QDik79kbQOauH7c5kk2Ia9+ruAUH+l/VXO2f0ljAfB5iFDZLEs00UBI18NRTeTV/MPhRy/mt2bGx2qog2hXLVtHP8q7D5B6U1Lx7gFTEWQ0UMRpoJJuaqimi63u8VOCXkRYI6ss/kzkav1kvbTBuJHPIx4J2oR9dG/zHQ==
Received: from BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21)
 by CY8PR12MB7513.namprd12.prod.outlook.com (2603:10b6:930:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24; Fri, 12 May
 2023 12:09:38 +0000
Received: from BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::22d5:5aa:8672:e36f]) by BN9PR12MB5068.namprd12.prod.outlook.com
 ([fe80::22d5:5aa:8672:e36f%7]) with mapi id 15.20.6387.022; Fri, 12 May 2023
 12:09:37 +0000
From:   Liming Sun <limings@nvidia.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        David Thompson <davthompson@nvidia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: Add runtime PM operations
 for BlueField-3
Thread-Topic: [PATCH v1 1/1] mmc: sdhci-of-dwcmshc: Add runtime PM operations
 for BlueField-3
Thread-Index: AQHZg3bCXdvFHqXRPkyxeLJ8YfJcZ69WQcgAgABMM0A=
Date:   Fri, 12 May 2023 12:09:37 +0000
Message-ID: <BN9PR12MB50680246F0882CB9BBB156A1D3759@BN9PR12MB5068.namprd12.prod.outlook.com>
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
 <CAPDyKFrD5HihGzH17HHd9NP5SoH73prmsuK1NCHg-a62dbH_fA@mail.gmail.com>
In-Reply-To: <CAPDyKFrD5HihGzH17HHd9NP5SoH73prmsuK1NCHg-a62dbH_fA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5068:EE_|CY8PR12MB7513:EE_
x-ms-office365-filtering-correlation-id: 2d7a0584-db9b-431c-5bbf-08db52e1c1e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CUKu6ecXB0oCH6H8ssKNi3Gfekp4oxCyLLqThXjl9uSm6WFYw0RVuOh2XZTvYjJ2HBntQLwWuuIr8ZNdOI58/qnDe+/4IKLkGeEGl7uNzSsaiHkrsq325M0T8ks7D6I6zRXhZztTjO5J0rbquO4FCXHOc9JM4Z3wjjhOrznZxNM595hTWlG4i/mdL2eOrJzQhbv0NbGLOAeHhqwJuQ2MaxMM4tHko3QQ4hECjhISHQvDnlw817HNhDkAJZ7aH0VLyCkPw1x4ITRWaer/TTiCi1XJozZZYQbMRutxGGC4eBzebbAgATVJ/Paw8iFDzwASx2L/t7K+oJr0hTtCFpEuxtFecbxH7T3zNShfYOms8YhBWFqc24XeZbb09NYP5hSNm6xCtKnCBEfdRFhTxaIZWnREz67cQlKSRAa6xKC9TTErNuSspGrPn+lDq0acsTlhbsxEzVMrAmOh1EjFdsZZHP4RCtvhBZSNCergsk4lj24Rp7lkmaOlwSFQGOlYEBr045IUGmvDOIKs7KHuLw6AGI2hq3TpUnpnYC3di63fQxQfnHifrRr7U0OsCRvKqlyZwh1IoDUzfj6iwyyUA4IKsI2dG6GL598EerFfVeko52bi3eStrEEKxrXrzPboKVyQdkVdtY//bHN+f1UM1oo78A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5068.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199021)(478600001)(110136005)(54906003)(8936002)(8676002)(5660300002)(52536014)(38100700002)(2906002)(38070700005)(33656002)(86362001)(64756008)(66446008)(66476007)(66946007)(66556008)(4326008)(76116006)(316002)(55016003)(122000001)(41300700001)(53546011)(9686003)(6506007)(26005)(83380400001)(186003)(7696005)(71200400001)(133343001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHZuUUwvL25uTy9IUlVhRzNOQ0Vra0dtbDRzMVhGK0JhbFU5eGF0ZnJVbTJm?=
 =?utf-8?B?a1kyRUFvaEVEeW11MmhGYXo5ckFjdktJa0duRjRUdGNBSzg0UHF1N0lvYTVt?=
 =?utf-8?B?UkpSMXEzSnNEYlJFOUJmZzBHaEw1OVMxNit2d29tRE43SThKalVZOTlTc3ZN?=
 =?utf-8?B?Z09LNGlrbzhpbzJLeEhUOGhPSUx5bmx6VitaN1c5L1RrZjlkWGVEaXYzVXc3?=
 =?utf-8?B?UmllZ1VsV0lVR2ZsTzlkd3BSZWd1UUo4VmU4NWZKdW1BamdYY2JMNFlrNmxQ?=
 =?utf-8?B?K3lsdnFkZXVKWlBSUXNrWm8vaEp1Ty8yM21ENmtGVTE0alhYVVlVZU9mQVJB?=
 =?utf-8?B?Q3laT0JVTHM0OFBrOGFmWG94aFNRVjMzM0JKN29rVlpEbWR0eDJVVDhkZDlm?=
 =?utf-8?B?T1pJV2gyQkNoajJFUnNMTjltS3AxeURiOU1uM0hhaWpqampuWkVkYTlrT043?=
 =?utf-8?B?d3dUZXZpQnpabFZwK094TzBhL0g5THVDODZUVkk3WWxkeitWeXY1TE5ibVJx?=
 =?utf-8?B?YzVCU1VGc1BUNFZvMHM1d1k4c0EyUWpaNXhybTUyNDBNblQ0Lzk4by85UXZZ?=
 =?utf-8?B?NExvdHNVa1ZWOEFDUm15ZnNpZE1QNm9zd2tOL3k3ZEpxNExZVDduemJrM2Y3?=
 =?utf-8?B?dTAwbFE3STlaWGxsbHZjM2JQU09CZ1pzb2NkbEt3cEJ5T2lOMmRDbVo3VU55?=
 =?utf-8?B?MmR3Q2l6eVZOaUpSRjlWL1JsbmpiWHRmZzBYVGFPZ2dVUXZKTk5odzFzajhh?=
 =?utf-8?B?bWJMbnJVc1gwazBmWEtzUUFwQy9DdSs1bDB6NnU2UkRrcENnamRHdUFSQWR6?=
 =?utf-8?B?MjVHL0txbWJZOGhaUHJmR2U2RGxiNHM4cmRqaGR2Ym1lVTl4VXFTbzZFV2tD?=
 =?utf-8?B?OGt1VDROZnNpOEcwMXdHQVhHS3gzS2hYWFY4SlJzVzEwcjVScjVhODFhbXNR?=
 =?utf-8?B?T0xPNVNTSU9tN09UQ3ZXdVVPcHpDSmlDUTU1UG1PbTZGUVJtc3FqYjNRbWZS?=
 =?utf-8?B?Yll2d0JkbFNEK1hQVE5tMEk4N1RYcFFDY1BDUmtkbkUwdVh4OTI1YzJNNWJy?=
 =?utf-8?B?eE5ZZ1BBSnFtMDFxakFxMDRHb1E0QUtxVUFieEJhV0V1ZXpldFRoTnJSUkNB?=
 =?utf-8?B?QjNpSyt2WEVadnYwYzN0R0dHblFQVjlkL216TW45bWJpUXdralc0c2w1LzZi?=
 =?utf-8?B?TElqVEhWQ2FPTzlYS25jc05LVUVKdVVVNVl6UDZmUlU3dXgzZmgvbjFua2cr?=
 =?utf-8?B?eFJzTGtvQnVwOUxkcTliTzErbis3VWhOcEtsckV1MXloMGVFa3ZTZUdOT2wv?=
 =?utf-8?B?SVZJVEJ1RWR4REFDTzFJWHh0LzJ4NFgvM05FQWRsaUJNcVBqL2VKVk5IbWln?=
 =?utf-8?B?dVJxcUJEVzBXSkRMUUZIcEtOUFNkOVg0N2lQcXQ3djVRWXp6Ui96TnRjWUZG?=
 =?utf-8?B?M2szRXlKRmJDVkZNV3FSdzVpbE1SdlFyWE5HRU5lWWcwOTJKWWUxUWEzWFNS?=
 =?utf-8?B?NGtrTVh5UVFvVmlDOG1ncjZpZHJyUzJTTFBoakVrb2dkaEJSSVJ1NERrS3lo?=
 =?utf-8?B?T3dzYStpVm95OXlYQzZQaFc0WkFuSkhLcXc1MlRXSVlhRWFPQkRKVG1BbmNN?=
 =?utf-8?B?R0QyTlZaODVFSDZ1MjJaQXdFOUJPbk1BbzBQWklXVGQ0UE5ZMi81SDVLdU9J?=
 =?utf-8?B?VFFDRE9HSTVKWGdxMnp6QjNkUFFmd0dNR1JWL1pZWHVYS0Z5ZEJLQ1ZTaGtP?=
 =?utf-8?B?STVZaGU2M3lJNUVBTFlvN2pnamNnWXNRcnlpR1N6dHM5Y2NoR2lsU0NqcEN4?=
 =?utf-8?B?b1ZPTEdVcENnOWZpRnVnWWhZcHo2b2ZmMUF1OFlrWHpXalpISjNGZlN0TURD?=
 =?utf-8?B?WmpCT2kzT1hEV0Jza3NnajNxeG1NOEg5dzJJV3k1YUxRYWJ0QXJYTWJvNmgr?=
 =?utf-8?B?bkZNelFlY2lrbzZPWjZoaXJtZGdDWFdxM2s4Q1JXQWNlSlhseXV6SEZIb3c5?=
 =?utf-8?B?VjJpZDdxMWhOdmRrSHpHVzA2dEJRRFhqQTJReU45M3NwbGdoNXE5VU1idmZX?=
 =?utf-8?B?VDFiUHpNNnZ0QWVwRUxlSnVsZVpzYUJSd254QzdGRzBnbzZtUGxtZ1ltcDlE?=
 =?utf-8?Q?XWMU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5068.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7a0584-db9b-431c-5bbf-08db52e1c1e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2023 12:09:37.6616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YYhQfL/tlKwSgiAuMzvajGACb6BAU/KV9JdKdfznyMWKNQCLWizZQ+Ub52ScvHRMB7cYSSa4/lRAUNZZhQzT4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7513
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVWxmIEhhbnNzb24gPHVs
Zi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgTWF5IDEyLCAyMDIzIDM6MzYg
QU0NCj4gVG86IExpbWluZyBTdW4gPGxpbWluZ3NAbnZpZGlhLmNvbT4NCj4gQ2M6IEFkcmlhbiBI
dW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgRGF2aWQgVGhvbXBzb24NCj4gPGRhdnRo
b21wc29uQG52aWRpYS5jb20+OyBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4g
a2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDEvMV0gbW1j
OiBzZGhjaS1vZi1kd2Ntc2hjOiBBZGQgcnVudGltZSBQTQ0KPiBvcGVyYXRpb25zIGZvciBCbHVl
RmllbGQtMw0KPiANCj4gT24gVGh1LCAxMSBNYXkgMjAyMyBhdCAyMTowMywgTGltaW5nIFN1biA8
bGltaW5nc0BudmlkaWEuY29tPiB3cm90ZToNCj4gPg0KPiA+IFRoaXMgY29tbWl0IGltcGxlbWVu
dHMgdGhlIHJ1bnRpbWUgUE0gb3BlcmF0aW9ucyBmb3IgQmx1ZUZpZWxkLTMgU29DDQo+ID4gdG8g
ZGlzYWJsZSBlTU1DIGNhcmQgY2xvY2sgd2hlbiBpZGxlLg0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6
IERhdmlkIFRob21wc29uIDxkYXZ0aG9tcHNvbkBudmlkaWEuY29tPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IExpbWluZyBTdW4gPGxpbWluZ3NAbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVy
cy9tbWMvaG9zdC9zZGhjaS1vZi1kd2Ntc2hjLmMgfCA3Ng0KPiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNzQgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9m
LWR3Y21zaGMuYyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktDQo+IG9mLWR3Y21zaGMuYw0KPiA+
IGluZGV4IGU2OGNkODc5OThjOC4uMTljZTA1OGZjNWYwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvbW1jL2hvc3Qvc2RoY2ktb2YtZHdjbXNoYy5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvaG9z
dC9zZGhjaS1vZi1kd2Ntc2hjLmMNCj4gPiBAQCAtMTUsNiArMTUsNyBAQA0KPiA+ICAjaW5jbHVk
ZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiA+ICAjaW5j
bHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1l
Lmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9yZXNldC5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgv
c2l6ZXMuaD4NCj4gPg0KPiA+IEBAIC01NDIsOCArNTQzLDEwIEBAIHN0YXRpYyBpbnQgZHdjbXNo
Y19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiA+ICAgICAgICAgfQ0K
PiA+DQo+ID4gICNpZmRlZiBDT05GSUdfQUNQSQ0KPiA+IC0gICAgICAgaWYgKHBsdGZtX2RhdGEg
PT0gJnNkaGNpX2R3Y21zaGNfYmYzX3BkYXRhKQ0KPiA+ICsgICAgICAgaWYgKHBsdGZtX2RhdGEg
PT0gJnNkaGNpX2R3Y21zaGNfYmYzX3BkYXRhKSB7DQo+ID4gICAgICAgICAgICAgICAgIHNkaGNp
X2VuYWJsZV92NF9tb2RlKGhvc3QpOw0KPiA+ICsgICAgICAgICAgICAgICBwbV9ydW50aW1lX2Vu
YWJsZShkZXYpOw0KPiANCj4gV2h5IG1ha2UgdGhpcyBBQ1BJIHNwZWNpZmljPyBXb3VsZG4ndCBv
dGhlciBwbGF0Zm9ybXMgYmVuZWZpdCBmcm9tDQo+IHRoaXMgY2hhbmdlIHRvbz8NCg0KU3VyZSwg
bGV0IG1lIHBvc3QgdjIgdG8gbWFrZSBpdCBnZW5lcmljIGZvciBzZGhjaS1vZi1kd2Ntc2hjLg0K
DQo+IA0KPiBbLi4uXQ0KPiANCj4gS2luZCByZWdhcmRzDQo+IFVmZmUNCg==
