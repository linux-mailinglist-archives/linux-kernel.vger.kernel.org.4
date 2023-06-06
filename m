Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AE972346C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 03:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbjFFBTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 21:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjFFBT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 21:19:27 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E048AF3;
        Mon,  5 Jun 2023 18:19:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXV9JDHqw93vCXoIoo9uCMhyIadZYITdbS+gaIyuxkODvltoZnEWHFm5PM+KgJwjBwvkHO1qCQ5fIKb6LgOtpLX6QSs3Jq8WjqWG6G+1RXJFxnqbgUIS4T3lBRqFd/Uts96FKUdj4u5/5CsVgVciLuJKoMaFHF1aN98Q36ly+07tgUUXNIre/RrUk6xiG+BYUbV64haBD3Z1HzDqDOHVBQsQAGPfB2Iw7rjw0leDs4UfCTIdkUJiHUS5XJG86dcRaecKoP5lU8u17jpDM+o2osaJtLF0+zQeI5FtTyzNWDixm+w0ALMBtXuYGKkWmlLWfkv1T61P42I1gzO0N4TrPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hdc5awdP+FN3Cwi3sPgkfO4keMSS3+yv7habI4T650w=;
 b=nQhF/M0BjJw9GXTrRdmgjyZwI5gcqrlZ8Nv/FS1Q3mmKUYbuQP5/M9n/VMu6OUPbMTxZuYi/Eiy8xlYn4mmQoDPpUl2Gj1WfxQwrJmvx/K/7QM4G9H+25mmYfV9uyYhoDGj+uL+AgNqs/gd91Nz0uuIs8m48CmWZmv2CRtqVRuiKqvFtMnaqD78NzI7XtU01BOdqWLk/mnvh35yhGqgVC3EiR0HfzjndV13veE6e1zojBRIcbZuC+Fe7sccG1HfUZMmHuIdNxmg/EN8Z8sGVaR2I04PAZ9MzjuITbUdLFmQNxDea3njZiHXfOetoSl1s/jaRJ0uCH7QxeCCGT4knGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hdc5awdP+FN3Cwi3sPgkfO4keMSS3+yv7habI4T650w=;
 b=jjbIuR2FNX1LciiGo68bWQz2udW/pB0Hu1ZpFXQL/F0HXZ0cqe6WxhS8WF9n/qARSIDIDNQLl88ovB9lG3uAIAETTavEU4p4RzHG/yShmEVsX4E9GbjggQaS35INpnI4cVmN+wqb4OIkveFVnPs34lsvg0/An9J9wLOlFRgIaJ4bq+1TjjeZEwgkp6iqLXLlLfppA0R1uUU6LT8MXHW72ScfZY9hSBNyMnv3ZvcKyTNEF5Y4X1mdXin9dGw2CCsWiP1CZK5oHjb34aKYZhah3BJsyYIkffg5rkOrEvESgT70ifYZQnWXk/V0fsFRwkIlbm3HrqAs9mH08j7WRVEs1g==
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 by MN2PR12MB4504.namprd12.prod.outlook.com (2603:10b6:208:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 01:19:23 +0000
Received: from SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::845d:9b3f:2367:4c9e]) by SJ0PR12MB5676.namprd12.prod.outlook.com
 ([fe80::845d:9b3f:2367:4c9e%3]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 01:19:23 +0000
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        Richard Wiley <rwiley@nvidia.com>,
        Eric Funsten <efunsten@nvidia.com>
Subject: RE: [PATCH v3] perf: arm_cspmu: Separate Arm and vendor module
Thread-Topic: [PATCH v3] perf: arm_cspmu: Separate Arm and vendor module
Thread-Index: AQHZfuz+cwQOAz4d1EugaMzRjf8I+a9L7wiAgASlAWCAJZpsAIAG/D6g
Date:   Tue, 6 Jun 2023 01:19:23 +0000
Message-ID: <SJ0PR12MB5676BC7BAB0C80293F0EBF7FA052A@SJ0PR12MB5676.namprd12.prod.outlook.com>
References: <20230505005956.22837-1-bwicaksono@nvidia.com>
 <09b2a614-b7e5-d4e4-bcd4-bd1c22470821@arm.com>
 <SJ0PR12MB5676B311C2D04301CC266292A0719@SJ0PR12MB5676.namprd12.prod.outlook.com>
 <dc8d8baa-22cd-ccd9-3598-1a52d4d749af@arm.com>
In-Reply-To: <dc8d8baa-22cd-ccd9-3598-1a52d4d749af@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB5676:EE_|MN2PR12MB4504:EE_
x-ms-office365-filtering-correlation-id: cff3524b-f60c-4511-153d-08db662c0fc0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KDnY3zjDOT3nYD8GM++T6vh6d8PC7iJUf4ustD5cLR5y4cnll9essgrWbkmi0Xc6g58vodt9Fxp/ihYC3X7a1NAzk4fGTYjWxNSU2f9Oja/6UtX5XdGJI2/rTtgZHPS/QuNfpoP3mDcUJO/QdCncL4PxDS6lnaGI3ku96bSYD+LPcAU2XcqtsSjQDQvXdSc/jFhI4a3Sj/PVxWraRkayy0Sljmb7wDXq9XfFG5Ux5WlDXeLDnfUWYQERDKpQSrGOptuH84lwHkKcmeV3ETB0RP1KQzjpu7qOWsE2yo1rSf0aeZKEHwwGVaR4nw268mafwtQG7Insp9FO7QGxZ0FDjOdSXDv03zl7cuY+Y8M6K6SNFIMFZi9QdDQm519QOcuIlBb2eBRNAL51RbjLK4URhHcCWWnXQfH2drRPDf7shrfUa85rKc2vJXco4S3pAgz01vsHxK96CIKNQDA6kDf2z4rQtZwlL5QN/1jZ4a5TRhvdwjPhqJbeNePBNA6fgPprxHjad423hc8iG0BAsFKlZ/I/OjU626jEeyi7PBo27JDhVCuFMQGlzQXXVzDdLXo1AMgM6k8YhiX1JJXRcuuTqAkALCrXqoHTd6FYYi9dtLNoGCijCkKoGS1J1B/TXNDN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5676.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199021)(9686003)(107886003)(53546011)(6506007)(38100700002)(41300700001)(7696005)(186003)(26005)(83380400001)(71200400001)(478600001)(110136005)(54906003)(4326008)(64756008)(66446008)(66556008)(66476007)(122000001)(76116006)(55016003)(316002)(66946007)(8676002)(52536014)(8936002)(33656002)(2906002)(38070700005)(86362001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFh5bUpNVG55eWJpMThrRk1qTnFHMHV1R1JKZW52SGxWNUJoSlAvc1dpdzdq?=
 =?utf-8?B?RU9PUkxzMEpHdVE4cmhwZlhQUXlpNE9ISDdobUl6SWFUeVZSTzJGaitvcUQy?=
 =?utf-8?B?ZWE0am5wZC93WWJsd2ZDUFh2N2xna3piSDVsQk9YYXRMRzl5Z2VKMTh2cEpE?=
 =?utf-8?B?VjZnUlgwWXRzZnYzd0l4UmxocC9hbkJLOUZjOEY3K25nYUluUUd4c0Z2aHZx?=
 =?utf-8?B?UkJ1aXE0WFV1T3p2WmtnYTJPR0xROGsxYWtjSndYeGNLSUREMDNIRS9URFlh?=
 =?utf-8?B?ZTJDMWppTEJQSVQzc2EzVjBIZjM1YUhZRHZ5U1Qycy8rN3VMM2MwZ0ROZ1l4?=
 =?utf-8?B?UjdmMVBMZWc5bDY2ZzlmQlBET2RMcVRTT1Z0ek1RemhTN2lxWERWVnJkejh4?=
 =?utf-8?B?cDZBYW5hTk1BVVBCU05ldzJob1F3LzQxUEhnSVFsL1I1ZkVHbkNzNGFFa3VO?=
 =?utf-8?B?WnlxLzdCVFV3VXpCbnpKU1dLUTE1Uytpa29uUzVtTFlWNXBNcW02WmJrTUVs?=
 =?utf-8?B?Vzd4ejJibDFUVkdhdG82LzhoWTN5ay93N2xiU2QzV0VnellRcmtQV09uNTdL?=
 =?utf-8?B?aWF2VmJiSm9pN3J3MmVBSVN0eHRJMFE5YWpwcWZZbGd4ZlIyQ1QzeUoxOEY3?=
 =?utf-8?B?ZFJETFc2dFpUMVpkQ3VlcHg2RDZCWTBYLzFycHVMZHRsb0RtdzNYQkI0UzV1?=
 =?utf-8?B?NFBEZGRSNGNZdG9sVm44RzBhZmUvLzUydmsvOEllaHpLaUJpeHFFazZybGxw?=
 =?utf-8?B?MUJ4bExDQ29ibVVRY3VUeDhFelhMNlBXdnBJWUVtZ3lpRWRDT1p1VzhRZ1JF?=
 =?utf-8?B?Ykd4bjV5eFM4K2pzcXZlSEdHVTllQzF3Smgra2tlWW0xbUNidDF4bmZxV3JI?=
 =?utf-8?B?UGZuckFPYlRrd0p3eXllUkJDYjdEK2lVRDNDdlN3aVFvVnNCU0dsNlRBc041?=
 =?utf-8?B?MUJYMGd5Qkt5N1NoQ1NpczlqL1psOGtta0d3TTZOeGJZVlE2NnhvKzM5VHVk?=
 =?utf-8?B?S3pBc0p2ZnBIZ3dOSi9HNjIraVdNQStlV1BDdnEyejUzOU1yN3VDaGhIT1J4?=
 =?utf-8?B?NHNpdUtnT3RHL0ZYallmcS92REZlSVRIUFAwSXp5MkoyM0VXbVk0VWgwdDZw?=
 =?utf-8?B?WnF2RDNIS3pkRFBtOVA0RDQ4SmR3U1l1eE50Wi9mTXlwZXllMFhsZ1U5emdn?=
 =?utf-8?B?Y3NKUzFVRmxzMnNxRDFTNkFkdUVYbGNWYXhmTlQ2eVgzTTBNVFAzamZ1Y2dF?=
 =?utf-8?B?Wjl6ajBHWTMxU1B0QklmOTYvSjR3Zy9lcGo2czBCTFo5MjR2eVVvMm1EQVhF?=
 =?utf-8?B?TEhkdGlaOXFTbzY3Z01NOTV1bldxcU1nMUcxNmw5R3hUMTBjR01GelR4VUhu?=
 =?utf-8?B?TEJscVZ4Wm9qcnBGQUJoU1c4WkVDZjdlU05rSkNJaXh2MmI2UE9YQ2JXMklB?=
 =?utf-8?B?VVB1L0FKZHZOOU9EMi9HaGtxZi92SDk5Um9SaVcrUmtpWElSZnFxRTlRT0Yw?=
 =?utf-8?B?K1A0aE1kWUxkQ0dPYlpyUHM1VVpEdmNQWEtuMDhqK3dwTlZBclRTT3NoQWhB?=
 =?utf-8?B?akRZbVowZHBlSXdaUDdJYUZkU3hxNU9CVkJqSldlMGlFNS8wRFdpVWtqUk1H?=
 =?utf-8?B?NzFaTkRONTNhRHoyTEQ5bjNydlhoTXk1NTlVVFg0RjlMbFhLY24xUGR6dlhp?=
 =?utf-8?B?am1kTG0zSndzK0FIVUFhUVJURHR2NmtiRUxtUUlZV3dVSFZCNk1UdyswbjRu?=
 =?utf-8?B?R2M3S3FCZDdWbHJ5aENzR0svUWRDOGRBWk5aeWprb0ZRTGwyS3ZJQno5bjBW?=
 =?utf-8?B?MVI1Uk9YK0YxNFUvR2hQWUZORDBjTkJaUGo4UWJjM3NMcE4wdmZ6blZqRitJ?=
 =?utf-8?B?SGpiNnp6eHJ5Q3YyeHhsMm15QmswbWFpdnJkMnNGUlR6QW5GU012NS9iaEFV?=
 =?utf-8?B?NFJ5T0Jqem15S3JaNm5VSkJrdFNsM1BXL0dRM25pL2JaaVpQQzgrTlN2bENT?=
 =?utf-8?B?RGx0WnlyMWM3M1M4YzlzYVdMR1UzRmFPcVZzSDd0eGpZTEVQcjFNMnZqOU5t?=
 =?utf-8?B?Mm55RUFQN3ltaXora2M1QXNoL3hpRE1IOEs4NHcyRFBKNFRaSm8wandaMEQ3?=
 =?utf-8?Q?TSgXtCS/OlOxhFWK0W8vd8avr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5676.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff3524b-f60c-4511-153d-08db662c0fc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 01:19:23.1479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8YlOs6CAK7tOPFZLhYC0Klq4wNlQmWfiXOT9oEMvTm4HAkUq2mlaD6ScPry+yleCbEjOmBNFYx3Jo2YToKt3Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4504
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

SGkgUm9iaW4sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4g
TXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEp1bmUgMSwg
MjAyMyA5OjM0IEFNDQo+IFRvOiBCZXNhciBXaWNha3Nvbm8gPGJ3aWNha3Nvbm9AbnZpZGlhLmNv
bT47IHN1enVraS5wb3Vsb3NlQGFybS5jb207DQo+IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOyB3
aWxsQGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tDQo+IENjOiBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LQ0KPiB0ZWdyYUB2Z2VyLmtlcm5lbC5vcmc7IFRoaWVycnkgUmVkaW5nIDx0cmVkaW5nQG52
aWRpYS5jb20+OyBKb25hdGhhbg0KPiBIdW50ZXIgPGpvbmF0aGFuaEBudmlkaWEuY29tPjsgVmlr
cmFtIFNldGhpIDx2c2V0aGlAbnZpZGlhLmNvbT47IFJpY2hhcmQNCj4gV2lsZXkgPHJ3aWxleUBu
dmlkaWEuY29tPjsgRXJpYyBGdW5zdGVuIDxlZnVuc3RlbkBudmlkaWEuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHYzXSBwZXJmOiBhcm1fY3NwbXU6IFNlcGFyYXRlIEFybSBhbmQgdmVuZG9y
IG1vZHVsZQ0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mg
b3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBPbiAyMDIzLTA1LTA4IDE4OjA0LCBCZXNhciBXaWNh
a3Nvbm8gd3JvdGU6DQo+IFsuLi5dDQo+ID4+PiArb2JqLSQoQ09ORklHX0FSTV9DT1JFU0lHSFRf
UE1VX0FSQ0hfU1lTVEVNX1BNVSkgKz0NCj4gPj4gYXJtX2NzcG11X2ltcGwubw0KPiA+Pg0KPiA+
PiBOb3Qgc3VyZSB3aGF0J3MgdXAgd2l0aCB0aGlzLi4uIEkgaGF2ZSBubyBjb21wbGFpbnQgd2l0
aCBrZWVwaW5nIHRoZQ0KPiA+PiBpbXBsIGluZnJhc3R1Y3R1cmUgdG9nZXRoZXIgaW4gaXRzIG93
biBzb3VyY2UgZmlsZSwgYnV0IGl0IHN0aWxsIHdhbnRzDQo+ID4+IHRvIGVuZCB1cCBhcyBwYXJ0
IG9mIGFybV9jc3BtdV9tb2R1bGUuIERvaW5nIG90aGVyd2lzZSBqdXN0IGFkZHMNCj4gPj4gdW5u
ZWNlc3Nhcnkgb3ZlcmhlYWQgYXQgbWFueSBsZXZlbHMgYW5kIGludml0ZXMgbW9yZSBwcm9ibGVt
cy4NCj4gPg0KPiA+IE15IGludGVudGlvbiBpcyB0byBzZXBhcmF0ZSBhcm1fY3NwbXVfaW1wbCwg
YXJtX2NzcG11LCBhbmQNCj4gPiB2ZW5kb3IgYmFja2VuZCBpbnRvIGRpZmZlcmVudCBtb2R1bGVz
LiBIZXJlIGlzIHRoZSBkZXBlbmRlbmN5IEkgaGF2ZSBpbg0KPiBtaW5kOg0KPiA+DQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYXJtX2NzcG11X2lt
cGwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBfX19ffF9fX18NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICB8DQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGFybV9jc3BtdSAgICAgICAgICAgICAgIG52aWRpYV9jc3Bt
dQ0KPiA+DQo+ID4gVGhpcyBoZWxwcyBkdXJpbmcgZGV2aWNlIHByb2JlIHRoYXQgdGhlIGNhbGwg
dG8gcmVxdWVzdF9tb2R1bGUgY2FuIGJlIG1hZGUNCj4gPiBhcyBhIGJsb2NraW5nIGNhbGwgYW5k
IHRoZSBiYWNrZW5kIGluaXRfaW1wbF9vcHMgd2lsbCBhbHdheXMgYmUgcmVhZHkgdG8gdXNlDQo+
IGFmdGVyDQo+ID4gcmVxdWVzdF9tb2R1bGUgcmV0dXJucy4gVGhlIGNvZGUgc2VlbXMgc2ltcGxl
ciB0aGlzIHdheS4gQ291bGQgeW91IHBsZWFzZQ0KPiA+IGVsYWJvcmF0ZSB0aGUgcG90ZW50aWFs
IGlzc3VlIHRoYXQgbWlnaHQgYXJpc2Ugd2l0aCB0aGlzIGFwcHJvYWNoPw0KPiANCj4gSSBzZWUg
dGhlIGludGVudDsgdGhlIG1haW4gaXNzdWUgaXMgdGhhdCB0aGUgaW1wbGVtZW50YXRpb24gb2Yg
aXQgaXMNCj4gbmVlZGxlc3NseSBmaWRkbHk6IGFybV9jc3BtdV9pbXBsIGlzIG5vdCB1c2VmdWwg
b24gaXRzIG93biwgYW5kIHByb2JhYmx5DQo+IG9ubHkgcmVwcmVzZW50cyBhIGZldyBodW5kcmVk
IGJ5dGVzIG9mIGNvZGUsIHNvIHB1dHRpbmcgaW4gYSBkaXN0aW5jdA0KPiAua28gd2hpY2ggbmVl
ZHMgdG8gYmUgbG9hZGVkIHNlcGFyYXRlbHkgaXMgYSByZWxhdGl2ZWx5IG1hc3NpdmUgd2FzdGUg
b2YNCj4gZmlsZXN5c3RlbSBzcGFjZSBhbmQgbWVtb3J5IGZvciB3aGF0IGl0IGlzLiBBbHNvIGlm
IGFueXRoaW5nIHRoYXQNCj4gZGVwZW5kZW5jeSBpcyB0aGUgd3Jvbmcgd2F5IHJvdW5kIGFueXdh
eSAtIGFybV9jc3BtdSBjb3VsZCBwcm92aWRlDQo+IGdlbmVyaWMgUE1VIGZ1bmN0aW9uYWxpdHkg
anVzdCBmaW5lIHJlZ2FyZGxlc3Mgb2YgYXJtX2NzcG11X2ltcGwsIGJ1dA0KPiBhcm1fY3NwbXVf
aW1wbCBkZWZpbml0ZWx5IGhhcyBhIGxvZ2ljYWwgYW5kIGZ1bmN0aW9uYWwgZGVwZW5kZW5jeSBv
bg0KPiBhcm1fY3NwbXUgaW4gb3JkZXIgdG8gc2VydmUgYW55IHVzZXItdmlzaWJsZSBwdXJwb3Nl
Lg0KPiANCg0KVGhhbmsgeW91IGZvciB0aGUgZXhwbGFuYXRpb24uIEkgd2lsbCBtb3ZlIHRoZSBp
bXBsIGNvZGUgYmFjayB0byBhcm1fY3NwbXUgc291cmNlIGZpbGUuDQpXaXRoIHRoYXQsIHdlIG5v
IGxvbmdlciBjYW4gbG9hZCB0aGUgYmFja2VuZCBtb2R1bGUgc3luY2hyb25vdXNseSwgc28gSSB3
aWxsIHVzZSB0aGUNCmRlZmVycmVkIHByb2JlIGFwcHJvYWNoIGFzIHlvdSBzdWdnZXN0ZWQgYmVm
b3JlLg0KDQpUaGFua3MsDQpCZXNhcg0K
