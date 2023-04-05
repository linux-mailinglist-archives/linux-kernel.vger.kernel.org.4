Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8776D7FBE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238369AbjDEOj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238312AbjDEOj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:39:57 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B2F1BEA;
        Wed,  5 Apr 2023 07:39:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2mMa2YSCz8JHGeSqkWJdsJEiF1Bl6FhHZAmFdsf3Tn5SJrTAlusnpuC6Puqt2qh5pdKPMnlxZ1S2o4ZOJVR/onsDvjjR+V6w2fiHKyCgE4MIXI69IWV9HGUnIywMPVGI7zU1jX/iS+TBNb+58VexUlLQL/VyBzasI2SnlLlhSMBxWduHjWDkQ3QcCWZH+RSNty2BjTUMEg9HiLPsFAeWSMTFcUHjtfxOKtZRcAN+aVYWzLLtNplyzNxkNx3NKr/u+FMpBaPL4J2gD1zZdEXbgqfaj4aQ6cFopGoSaJIlZHfSQle+9apXuprqDXRT8UFrEjZaRQxK8phSjE9kF+Cjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKCEIev0STESKCvbIecJvZ5/EeslMj/Cpkbdp11yfWQ=;
 b=SHM/quQ9NedKdZI7POHG52lqhuwgi5f8PhmnporjmPa96u6L2G8cV9IbrxjmwOLH6g0OmI/rVr8XNiQQxvE26hYtIaQn92k+0UKjY4pXJg0juNe255zST4GyHqYDkuTSnHXKxzqflFw6i6aHIZC3XlsNbraokFDKmtxeBHzRZMnZAmt2pxNi+oeAbr0+deGEEPcTskxgV0h9iOhq21XN9/PdK1FQKo8x5ucrpABMSn+ukExEoJGN09aoD9VDHE7kNkHlGK4MV8h8LjsPNEmtBFgVXcwmOT8/jfO4iUxJAp87ZMppT5ytZIB6pd76jD/1QEC6PhwJZrlXoBwwpx+xAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fKCEIev0STESKCvbIecJvZ5/EeslMj/Cpkbdp11yfWQ=;
 b=g6gCREb0BF1wQTbs0iqhg5TAqiyylfMUlOPSbLKEAh8ghUrKXW5ePy0L7iw3MbLvLV4B3zwl+0TDUi6a+e+UysaNKpuIinXYNKqreIRYyBrGPHeXfq37sDWo7S2kRvuoCsRPIrYB/w7I8kQkLuPjSgXtc31qTeG0SBl1K5EzppzVb8ltvsDxLm3wbLs0YlU1fj+OwMWDY486ksNtyigjDrQy1mKWZ2MAZ4NpYLx4wwN+LKRHHMjX9TbQUjR1p+Sn+0xmF34/nZQDGLgTtWNxFhXTQw2eB0pE0+cP8kYAaC28URY765xxbDdDkH/pcFAZ0U8y54V8zowJFOBpoTVvTA==
Received: from MN2PR12MB3616.namprd12.prod.outlook.com (2603:10b6:208:cc::25)
 by BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Wed, 5 Apr
 2023 14:39:53 +0000
Received: from MN2PR12MB3616.namprd12.prod.outlook.com
 ([fe80::ed6d:b467:7f58:1207]) by MN2PR12MB3616.namprd12.prod.outlook.com
 ([fe80::ed6d:b467:7f58:1207%6]) with mapi id 15.20.6277.030; Wed, 5 Apr 2023
 14:39:52 +0000
From:   Khalil Blaiech <kblaiech@nvidia.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        David Thompson <davthompson@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/1 RESEND] platform/mellanox: add firmware reset
 support
Thread-Topic: [PATCH v1 1/1 RESEND] platform/mellanox: add firmware reset
 support
Thread-Index: AQHZZ8uOwSrN4makrUqnlN0I4y2l4q8cx6pw
Date:   Wed, 5 Apr 2023 14:39:52 +0000
Message-ID: <MN2PR12MB3616FBB92F354699B9925864AB909@MN2PR12MB3616.namprd12.prod.outlook.com>
References: <10da04fa43e8acce5d4ec173e225c28b9e979e4b.1675790783.git.kblaiech@nvidia.com>
 <7ec19101-0288-71e1-cdca-cfe7acbbe0e9@redhat.com>
In-Reply-To: <7ec19101-0288-71e1-cdca-cfe7acbbe0e9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB3616:EE_|BL1PR12MB5898:EE_
x-ms-office365-filtering-correlation-id: b03d9848-1bea-40ff-b24d-08db35e39df7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4al5Z480r+Vc+aW29tDEnlxgb2KwVZ0eShGMcQYfhD67bVmtITOm2w1IexT45ux3IBSaeOv1yk5bKbxJ5lrw9qRtuBZNl2EHoWCdBDjqqVF1S5QD6dbK6jB8pXyrofCxClk3EyasGTOrnrV8lYjWHPKDHHg2EHVQhvYa+r38rYKbyXiMpkci+zRWCNb1MDMo2A82sb6Z6SGnv8WZVdSPd9RMlOsNpqxA6F605SyJsfRZ5nGnDznDYfhjltJ5IKtfbV76brBQ6gfFcdl555z/hd5w3nO7w1nM2FRC6vx7yfNaNssN0EAEX28BFejwbhGFsO/ilMq+CjVGl2+fLS02F0zMDZVf6BeCTrpccP+G8gHy6SKb8qJikaXemlgzgkFzSV1GkgfimI0/ZhagD0PPUYgNhOPc6UNOstSYpKVRBvZ+qqE9tiMLZvIiNciWvXKkZkkc1rjPtND/BfqmUsm4XzQf2TJBMhnwnv0vzYiMVrxSHhCsuUA5StZBABNZzkqDzJs0d5u4jcrTEsIMZL35Pz01IbZm7x2jFN/wwAcWGcRCbAFxtk03D0VbDYox+vMKwMDdfa3ZTGxQAUN23wLiEJRy2x7t4Qjmd/6IbrhfNQ4w5rlX84tOvS33kQYtn04K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3616.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199021)(186003)(7696005)(55016003)(41300700001)(8676002)(4326008)(66446008)(64756008)(66946007)(66556008)(66476007)(76116006)(2906002)(71200400001)(122000001)(38100700002)(38070700005)(86362001)(33656002)(83380400001)(5660300002)(6636002)(110136005)(8936002)(316002)(54906003)(52536014)(9686003)(478600001)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SU4xc2VLd3ltSlFvSGd6ZG5iMC95a2p5NDdIeisvN3VKR3FnN2VaRDZ3UzBS?=
 =?utf-8?B?anNuRGVFZmRYWG4wbDVMd0toTEJHUU80ZVI1S2VjWEVIcmxHSUZpemxLUEJE?=
 =?utf-8?B?dS9YNXovYVNJRW5RelUrUm5hc3RGZ09MVWxidG14QkZkNGJPRmFDL2x1cGdR?=
 =?utf-8?B?K2x5b1g0VHB4U3M3RlUwUU9MakVNRDRaOEpvc2dwa292S1kvU2NkMmU5ZmFJ?=
 =?utf-8?B?eFp2N1dMQk0yZEg2M3hnZm1CVnZXWUZWSzVqT2Z1K2VYT2dOcE1RcktJdDRS?=
 =?utf-8?B?TzZiS2JGak5ZWWpyK29kMktXNFhxTGw5OEtTeG9jemRwYjdkbDBWekxIcGVn?=
 =?utf-8?B?V3MySEJaZmFlY0k2WVE2RmF6Z2NPSTc4TS9UaEIvWFBBSUQrYzN5MVRDRWE3?=
 =?utf-8?B?eUpnWU1GREpRdUVZL25zNjJ1WWVnVFJGWGRoNVkzeDQxaGp1RjVtUTRuc3VL?=
 =?utf-8?B?Y0R6aktzQjBHUk9xSzVXOStFSU91cDFjOHl4RFRCcE1Rd00wc09DbkJGQVBj?=
 =?utf-8?B?Z29iT1VKKzY1TGxXVUtXcjErV04yNlZ6S2o3NWVlcTBjWGl4MUY4WnU0NTdY?=
 =?utf-8?B?NVlmQTNUWjY2dzlNN0tDaVhBOFpybWtMSExmUHJqMElkYzdPL0JaSWZTbmZt?=
 =?utf-8?B?akpuOTFRZ0ZSNW96VktlaGVRc0hqRVhPWHRiRjlsVDlDaHp0OFUrT3pkUERZ?=
 =?utf-8?B?bUJUeVZRcjlsRWhGV1g3ZE8zTlpLVm00UWhKd1V1WVJwUDNlMHg0R3ZaL1l2?=
 =?utf-8?B?cXlhY1pjN3l0Nm1rRjNJbmVmVHlWemJDejNhS0F5VlJDbWRuQWxWNk16VGg3?=
 =?utf-8?B?MkJrd05IRVlGTHRWQzNiWjNwSDVLTTVldlp6TTFYQ3htVFNhZjQ3ZklMbmFZ?=
 =?utf-8?B?dEY2ZDBuR2lmMS93ajVOTWsya3RXS0haYllXcENBaEs4THp5SFRrbzRkeWdn?=
 =?utf-8?B?R1Rrd21vWnpWSDR6T0tnRXNNY0tDbzlPSEQxdVh6anNRNUtZaVBwbmd1NStC?=
 =?utf-8?B?dUNLY3ZpSWFaSXd2U2RQanJkVFhuRXdKODNBenBwL3FkT0NTdnZrVnNRMnVL?=
 =?utf-8?B?YlBRUjl2cUh0VUQ3eUJqcmZCYXR6aWhOZGM1cVJMSjFkVHArLzkrUmkzT0pO?=
 =?utf-8?B?cXVXN3FJdHVhTWJ0UFdtUmlUaXhIQXNsTW5UUVdXZTNKK2dEQlNXL21INW9F?=
 =?utf-8?B?TEpoZ0dBNHd0WWZqYU9uYkJVT24xWnJhSWE5SjhLMk9vc0J1VjVLRWdLWDNY?=
 =?utf-8?B?ZG5ORVk5dVBrSVowRDZNYmpuK05FeUtSZzY1K29ZQXFPL1R5SVRDRkN4MDh0?=
 =?utf-8?B?aE9jVDdvMkhlcUtXVkh3Y2Nkc3BsNFZreG90L1BycU5EZ25teEpTYldQc3Rl?=
 =?utf-8?B?T1dyVERidGorY0FUeTdUbGRMUFBwNDlmTHdVQ3M4NENzcVozbUQzcDR1K3BE?=
 =?utf-8?B?Zy8zRWR1eEJpL3BuRkw2djZnci9CWkRYUnBnRzVaU0pTZ2tLeUdjZnpwRDBO?=
 =?utf-8?B?NGVLdlNsNGxYZXd2c2lnLzY1YW9xeW1NVGRVeU1FRWJIN21qZmhXeVJvYkla?=
 =?utf-8?B?WG81YTA5SW00L3FKalJBMXFNOUZVeGptRkhxUDNFeS8zZjloK2NueXVKMFlI?=
 =?utf-8?B?Nm1vYkxhbXdudVZmN1lOb081Uk9pS2VzazNmSHdLU1dJMUg4S0FRVDJkRWxL?=
 =?utf-8?B?USttTDZlL3p4cWxocVhLbDNhRGRhWHpZWUZpZWxncm9SejNvNnJha3VGeGRp?=
 =?utf-8?B?WGVlTHlqbldaSldFYWIzcFFxbUxIdXFJSWprd1lvdWxUVWRMbGlWNmZQWG5q?=
 =?utf-8?B?ZWsyeENwTVdrOTAzOHlVMkJ0Y2ZuMmx2N2FWeTlUZW9LOGNXbyt2V0U0QnZR?=
 =?utf-8?B?UVNkNTNRUFRQUnNIUnJwQnlwMndYUUsxYlY3aTFPcjFEQmN2Ull2MFBmdnlP?=
 =?utf-8?B?Y2pMU2lObGxDVDgxWDVWTkJ4cXY2WGJMVmlVL0N0M2FvcFlQdnpaVTJyMFc2?=
 =?utf-8?B?c2x0OElPbU5JUGY3NUtaeVJoUHJPZnYrUzBuZlRDcVJhYUNPbVYxdi9wS29p?=
 =?utf-8?B?eXBFZm9nZDU5ZUFNSk9xekFoWnFSWERISjQvcS9oN0dCUzBjcVlNV1kxemJu?=
 =?utf-8?B?UVhVVUlkMis5YXRSWGZUVWQ1Y3VRMEoyWFJwekRVbndCeHJYQlVZa2llWWg4?=
 =?utf-8?Q?Ea77Qq1wT7oGqctNvmE5PwNzHDWWfmNRldOeTyYkQ4YJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3616.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03d9848-1bea-40ff-b24d-08db35e39df7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 14:39:52.6654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +5FoUTt+3qHKEDTtjMMu1ledh+Gc00VMytWIzskT3gxlKVQAWp/ELbwnXm4zz0CW/Vi83ftY9fkkv8ERTvK4sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5898
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSGFucywNCg0KQWN0dWFsbHksIG15IGZpcnN0IHBhdGNoIHdhcyBwb3N0ZWQgYmFjayBvbiBG
ZWIgOCwgMjAyMy4NCk9uIEFwcmlsIDQsIEkgcmVzZW50IHRoZSBwYXRjaCB3aXRob3V0IFJFU0VO
RCB0YWcsIHRodXMgdGhlIG5ldyBwYXRjaCBpbiBsZXNzIHRoYW4gMjRoLg0KDQpBcG9sb2dpZXMg
aWYgSSBkaWQgc29tZXRoaW5nIHdyb25nLg0KDQpUaGFua3MsDQotS2hhbGlsDQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBIYW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQu
Y29tPiANClNlbnQ6IFdlZG5lc2RheSwgQXByaWwgNSwgMjAyMyAxMDozMyBBTQ0KVG86IEtoYWxp
bCBCbGFpZWNoIDxrYmxhaWVjaEBudmlkaWEuY29tPjsgbWFya2dyb3NzQGtlcm5lbC5vcmc7IFZh
ZGltIFBhc3Rlcm5hayA8dmFkaW1wQG52aWRpYS5jb20+DQpDYzogcGxhdGZvcm0tZHJpdmVyLXg4
NkB2Z2VyLmtlcm5lbC5vcmc7IERhdmlkIFRob21wc29uIDxkYXZ0aG9tcHNvbkBudmlkaWEuY29t
PjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSCB2MSAx
LzEgUkVTRU5EXSBwbGF0Zm9ybS9tZWxsYW5veDogYWRkIGZpcm13YXJlIHJlc2V0IHN1cHBvcnQN
Cg0KSGkgS2hhbGlsLA0KDQpPbiA0LzUvMjMgMTU6MTYsIEtoYWxpbCBCbGFpZWNoIHdyb3RlOg0K
PiBBZGQgYSBuZXcgc3lzZnMgdG8gaW5pdGlhdGUgZmlybXdhcmUgcmVzZXQgaW4gaXNvbGF0aW9u
IG1vZGUuDQo+IA0KPiBSZXZpZXdlZC1ieTogRGF2aWQgVGhvbXBzb24gPGRhdnRob21wc29uQG52
aWRpYS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEtoYWxpbCBCbGFpZWNoIDxrYmxhaWVjaEBudmlk
aWEuY29tPg0KDQpXaHkgYXJlIHlvdSByZXNlbmRpbmcgdGhpcyBsZXNzIHRoZW4gMjQgaG91cnMg
YWZ0ZXIgdGhlIGluaXRpYWwgc3VibWlzc2lvbiA/DQoNClJlZ2FyZHMsDQoNCkhhbnMNCg0KDQo+
IC0tLQ0KPiAgZHJpdmVycy9wbGF0Zm9ybS9tZWxsYW5veC9tbHhiZi1ib290Y3RsLmMgfCAxOSAr
KysrKysrKysrKysrKysrKysrICANCj4gZHJpdmVycy9wbGF0Zm9ybS9tZWxsYW5veC9tbHhiZi1i
b290Y3RsLmggfCAgNiArKysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygr
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0vbWVsbGFub3gvbWx4YmYtYm9v
dGN0bC5jIA0KPiBiL2RyaXZlcnMvcGxhdGZvcm0vbWVsbGFub3gvbWx4YmYtYm9vdGN0bC5jDQo+
IGluZGV4IDFjN2EyODhiNTlhNS4uNWU0MWMyNzAxOTVjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3BsYXRmb3JtL21lbGxhbm94L21seGJmLWJvb3RjdGwuYw0KPiArKysgYi9kcml2ZXJzL3BsYXRm
b3JtL21lbGxhbm94L21seGJmLWJvb3RjdGwuYw0KPiBAQCAtMjQ0LDExICsyNDQsMjkgQEAgc3Rh
dGljIHNzaXplX3Qgc2VjdXJlX2Jvb3RfZnVzZV9zdGF0ZV9zaG93KHN0cnVjdCBkZXZpY2UgKmRl
diwNCj4gIAlyZXR1cm4gYnVmX2xlbjsNCj4gIH0NCj4gIA0KPiArc3RhdGljIHNzaXplX3QgZndf
cmVzZXRfc3RvcmUoc3RydWN0IGRldmljZSAqZGV2LA0KPiArCQkJICAgICAgc3RydWN0IGRldmlj
ZV9hdHRyaWJ1dGUgKmF0dHIsDQo+ICsJCQkgICAgICBjb25zdCBjaGFyICpidWYsIHNpemVfdCBj
b3VudCkgew0KPiArCXVuc2lnbmVkIGxvbmcga2V5Ow0KPiArCWludCBlcnI7DQo+ICsNCj4gKwll
cnIgPSBrc3RydG91bChidWYsIDE2LCAma2V5KTsNCj4gKwlpZiAoZXJyKQ0KPiArCQlyZXR1cm4g
ZXJyOw0KPiArDQo+ICsJaWYgKG1seGJmX2Jvb3RjdGxfc21jKE1MWEJGX0JPT1RDVExfRldfUkVT
RVQsIGtleSkgPCAwKQ0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKw0KPiArCXJldHVybiBjb3Vu
dDsNCj4gK30NCj4gKw0KPiAgc3RhdGljIERFVklDRV9BVFRSX1JXKHBvc3RfcmVzZXRfd2RvZyk7
ICBzdGF0aWMgDQo+IERFVklDRV9BVFRSX1JXKHJlc2V0X2FjdGlvbik7ICBzdGF0aWMgDQo+IERF
VklDRV9BVFRSX1JXKHNlY29uZF9yZXNldF9hY3Rpb24pOw0KPiAgc3RhdGljIERFVklDRV9BVFRS
X1JPKGxpZmVjeWNsZV9zdGF0ZSk7ICBzdGF0aWMgDQo+IERFVklDRV9BVFRSX1JPKHNlY3VyZV9i
b290X2Z1c2Vfc3RhdGUpOw0KPiArc3RhdGljIERFVklDRV9BVFRSX1dPKGZ3X3Jlc2V0KTsNCj4g
IA0KPiAgc3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUgKm1seGJmX2Jvb3RjdGxfYXR0cnNbXSA9IHsN
Cj4gIAkmZGV2X2F0dHJfcG9zdF9yZXNldF93ZG9nLmF0dHIsDQo+IEBAIC0yNTYsNiArMjc0LDcg
QEAgc3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUgKm1seGJmX2Jvb3RjdGxfYXR0cnNbXSA9IHsNCj4g
IAkmZGV2X2F0dHJfc2Vjb25kX3Jlc2V0X2FjdGlvbi5hdHRyLA0KPiAgCSZkZXZfYXR0cl9saWZl
Y3ljbGVfc3RhdGUuYXR0ciwNCj4gIAkmZGV2X2F0dHJfc2VjdXJlX2Jvb3RfZnVzZV9zdGF0ZS5h
dHRyLA0KPiArCSZkZXZfYXR0cl9md19yZXNldC5hdHRyLA0KPiAgCU5VTEwNCj4gIH07DQo+ICAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0vbWVsbGFub3gvbWx4YmYtYm9vdGN0bC5o
IA0KPiBiL2RyaXZlcnMvcGxhdGZvcm0vbWVsbGFub3gvbWx4YmYtYm9vdGN0bC5oDQo+IGluZGV4
IDE0OGZkYjQzYjQzNS4uYjQ4MjQzZjYwYTU5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BsYXRm
b3JtL21lbGxhbm94L21seGJmLWJvb3RjdGwuaA0KPiArKysgYi9kcml2ZXJzL3BsYXRmb3JtL21l
bGxhbm94L21seGJmLWJvb3RjdGwuaA0KPiBAQCAtNzUsNiArNzUsMTIgQEANCj4gIA0KPiAgI2Rl
ZmluZSBNTFhCRl9CT09UQ1RMX0dFVF9ESU1NX0lORk8JCTB4ODIwMDAwMDgNCj4gIA0KPiArLyoN
Cj4gKyAqIEluaXRpYXRlIEZpcm13YXJlIFJlc2V0IHZpYSBUWVUuIFRoaXMgbWlnaHQgYmUgaW52
b2tlZCBkdXJpbmcgdGhlIA0KPiArcmVzZXQNCj4gKyAqIGZsb3cgaW4gaXNvbGF0aW9uIG1vZGUu
DQo+ICsgKi8NCj4gKyNkZWZpbmUgTUxYQkZfQk9PVENUTF9GV19SRVNFVCAgMHg4MjAwMDAwRA0K
PiArDQo+ICAvKiBTTUMgZnVuY3Rpb24gSURzIGZvciBTaVAgU2VydmljZSBxdWVyaWVzICovDQo+
ICAjZGVmaW5lIE1MWEJGX0JPT1RDVExfU0lQX1NWQ19DQUxMX0NPVU5UCTB4ODIwMGZmMDANCj4g
ICNkZWZpbmUgTUxYQkZfQk9PVENUTF9TSVBfU1ZDX1VJRAkJMHg4MjAwZmYwMQ0KDQo=
