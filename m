Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2625EBED3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 11:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiI0Jkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 05:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiI0Jkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 05:40:47 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2078.outbound.protection.outlook.com [40.107.212.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68BAB2CEB;
        Tue, 27 Sep 2022 02:40:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bH8XiCF8hnYxg0ODXEJM9q4NEU8zyeysdllOQ7dfxkaRlV33ni8v2QyuybdL4Zyp3JZNvDVS2NLYSoJcDPCsm2wzuVjCtH3+0F5Ay6+/8iO0+THB3jbZOFh/zZAQNDQTso6OAR2LS+o33TJoHm2TFITQXhw9AZeLwYYv1/R/j1KN1Cv11jf3GI097Ky0J/rc75yfsmCWCcmy4Ye5XuYJYvfvpYmNd97WjWsuwN5f5u6YEFqtN98FzaMw+QCCsdAZvySZloKhC8ojSjwynQkis1jO8/DQoCmz9XCa1+sdQxDqZvQSZwsXZo69ZgYYXbTq24w+mgF+UAzCzR/f0HeY5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jSyWYsXritb4YLWC8z04UWVN2Lvn+dOuLoRm19qA6M=;
 b=Dp6I/zQmyocUrsqsO7QeXPJqyj64HUOYS9+0Vqi88WPJ/SnXnsOy5NrNYAVqXZ3rOj6ZZpMauCTIepojchVVsPJi1baaZL8OBH063De8vtMrSIrtL9jdTZvn8iVjM/4uOAhf4cZETs0nfa5453iZ+d4p4Z5GzuVdlOV8CXMB7LeioHIQjv2WHPM98rtX3p/pT+FOtl9gccRjHyyR2oKzfa1T1bmp1qPc1z5otlIooYq/StWLBXTO8wyHvsGqdyYP9hPPkkJyoVkCGEceDae0CRvAVr6R/3B2reFEEI18/lDlX72fhQLw7hS/cWjSzxkFP6gU+BUWOErkaj6FYBh3Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jSyWYsXritb4YLWC8z04UWVN2Lvn+dOuLoRm19qA6M=;
 b=bfn8+6x9WF0uVQeqQDldcsKIOxKGT/cpcya6o146VoM3UdaO1zBeYcacNbrOGKxmoftYb/KD6nD3ziGw8LYRWEy4M080CFyBxtwa6xvRZAmO1un0Px5kFkDZ2+Q+/m0swaVPtk0PWgEr94sROxCOAuqjjaZBxb7cxt7PYwOGK2w=
Received: from BN7PR12MB2802.namprd12.prod.outlook.com (2603:10b6:408:25::33)
 by SJ0PR12MB6877.namprd12.prod.outlook.com (2603:10b6:a03:47f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Tue, 27 Sep
 2022 09:40:41 +0000
Received: from BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::9157:1a8e:dbc8:3d0a]) by BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::9157:1a8e:dbc8:3d0a%4]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 09:40:41 +0000
From:   "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "git (AMD-Xilinx)" <git@amd.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [RESEND PATCH v3 6/7] dt-bindings: spi: spi-zynqmp-qspi: Add
 support for Xilinx Versal QSPI
Thread-Topic: [RESEND PATCH v3 6/7] dt-bindings: spi: spi-zynqmp-qspi: Add
 support for Xilinx Versal QSPI
Thread-Index: AQHY0XH48qHCxkbEg02FemP0sh0oZa3xaj+AgAGcr4A=
Date:   Tue, 27 Sep 2022 09:40:41 +0000
Message-ID: <BN7PR12MB280227F30AA6D6B9C11359E0DC559@BN7PR12MB2802.namprd12.prod.outlook.com>
References: <20220926063327.20753-1-amit.kumar-mahapatra@xilinx.com>
 <20220926063327.20753-7-amit.kumar-mahapatra@xilinx.com>
 <8c16fdda-6cc7-998b-882c-f52bd9813aaa@linaro.org>
In-Reply-To: <8c16fdda-6cc7-998b-882c-f52bd9813aaa@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR12MB2802:EE_|SJ0PR12MB6877:EE_
x-ms-office365-filtering-correlation-id: 0b7b0779-e557-4338-3a60-08daa06c57df
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ev7YDDGi8z2BP+W72dhROU5xT4ogDGceim8QC7WnkBkhBywo14yLekuhwk5rJ8vkLJ5l72tEYJGAh7UzdAQjUNzN81Uod2KMX8yvK7y54wOlG3YacelxKi7xjEcbRyWIbs8Pp/4kQxYMyKhOzCWxQmj0u1k23GuXdhSd7VyWTN16wBQcBfuzRYHQhYrdaNXurbqcfYzAiTRISJ8gge9W4aVpTvlUpC+mfsgFY02thRCnYDnXupVic9DOCRXmo85BHTOAwMDvsLcLgsFKxBTX7L3o9cxA4C4HJMqHvIvDT9jb0YESa9edwRkFy6Gz4t3XjKbMCKJcUzBvEUZd2x8shIeBdAgeCjo3rsP1mFt2KyDVUAhm1oiXHeF0nTCxR5/MgYIjMqTdzzHs9qwKptaVHZbAkFeV+0A18sCFROQYdGHex+zVhEyu+JoKHf0xhERbBHZqpS3nXhmWZtEdhZCJ2d+ibqmUQZMMqF/1tS46T+sX8QitQj572CNnzokDbpNqRFGXaSSl91XAck/lceDC2fZ+co7nkxS3ZyL/EUjcS7EI1AwH0ZWFjCU0I0HGCzu7IK6yj2UKnNUdC31pCtTf4030/o0dpZ1hGDuh2SxODXvkJ0rEmAdj7+tulocMDzA4XDts72CBrpbaWq9tZ4JspKcn+cipvYPyO2IFXVDazHJ1wC9z7naG3f/v3Fb89d5w+d6evqFugHtg9ir16ZOT6mAy75YpiKZ7GJpGPn5iQJoDQ8GaVm4eMduASxuVG4ffg6G+Nmq+WTHDdQh6ynfeOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(451199015)(110136005)(38070700005)(54906003)(186003)(2906002)(316002)(122000001)(38100700002)(55016003)(52536014)(86362001)(41300700001)(9686003)(26005)(33656002)(478600001)(8936002)(64756008)(66556008)(5660300002)(8676002)(4326008)(76116006)(66446008)(6506007)(66476007)(66946007)(53546011)(7696005)(71200400001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmhhN3o1SVhiNXQvcnplQTdLWURCdmt5bHp3azdwaFE4Mk90eWZQekdBVEhD?=
 =?utf-8?B?a2xoSHkwRkpLcS9McVp5SmhSZWY3b0N2cTBMVXNnTFNmRTBxaUs3eTBsTEVT?=
 =?utf-8?B?L0ZlNEdsWG1lZURtSkgyMjR5VDlhcXZ3blhBZUNzNnA0TmVhSjRWNEtyQ0RT?=
 =?utf-8?B?NjdLb3NMUHd5ZEg4TWtwQnE1S25tcHFYL3RMUHZvZ0U0VmFvRWpvV0RBOVZa?=
 =?utf-8?B?bVkrdnB5QWtiV0ZDYkJKcVRIVDBhZHUwaDhxRTFLeFE5cTQ4SzY1YUZVV3J6?=
 =?utf-8?B?SzVxZHQ3SzJMaDhLamErZXVUR3JXd1h3VnhMQ2sxZzRVajJkcEcybGtlNEs0?=
 =?utf-8?B?aE9LdERraG1peGxsZ3Y2clZDWVVIbm9sdk1zcU5HbFIyNjZrMWNpamlsMUJR?=
 =?utf-8?B?WDIwTllQQUVHTHp6cXhVUysvOHcxaW5xMytjLzgwY0lnc2l1UXhTT1ZySmpM?=
 =?utf-8?B?eGZVYWNxYldDMFZmYTNsMDFRcndmQVJKUVREYmZsaVFQV3UvTlpBRnhia2RC?=
 =?utf-8?B?bDRqT1hoc3M3c1hWWXY4U1NYc2wyTjZXclMvZjBjWTR5RkdLWW1uYWJ0bHJU?=
 =?utf-8?B?ZVRnelRZMTN2T3RSb1FPMHpqcnA3OTNBV0h0S0doYVJsRlRIVUpXMHVncTJ2?=
 =?utf-8?B?amNIVzJ2WU1wckR6SHY5K2VaVzVGQUoydzJWNHEzT3RsK1prTUVNYW1NOEIy?=
 =?utf-8?B?bk1UUVNmbUY0SGpQaHhZMVhTSnZ0cTRjV0NlekwxeS9ZT0xETEdCSk0yOHgz?=
 =?utf-8?B?aldBUGIzcWZBYjZYY1ZBVDZEb3NFbW11M0ZHV21pdDMvV1FFdFdkMkJjOFVL?=
 =?utf-8?B?SkgzQk5iNm5JK2VvdHl2MFJOYm01QWhHTE1ZQlREdEc3N2p0djZTa2lqeTdi?=
 =?utf-8?B?SFV3ejhUSWtvRXpEbWFrMFBBcGJ5SS9laWhHSUxYTTd4WlcrY29xVEtULzA0?=
 =?utf-8?B?WEdrUVdxWG5VNXFNbElGRVF1cUpLZXdtL2hNNFUxSDdoaXBrTUFtOTlYUWRt?=
 =?utf-8?B?cmRSTU9mV0xYdEdDeGwrZ3ZZKzZ3T2xSS1VaU3JqL1F3aG5zcXk5M2FYVFpn?=
 =?utf-8?B?bDVGelJZczBsaktCaDE2WlBBZFQwcFI2eG5Rckt0N1poa01YWjFNd3VnekhK?=
 =?utf-8?B?azJDL0RKUjROMVpacmVuKzhoWG4zeWhaci9UVjRpRzR1YWE5Q2twUm85RXBv?=
 =?utf-8?B?U3Mwd0RqdFJpMzNKWUpjN2ZmSHBlL09nS2tmcjN0V1NJNFdGcHhFbzVxeENK?=
 =?utf-8?B?N2o3cTZDbmZpL3lTSWwyTCthRWgvVTZpeUp6V1V3blA5bVR5aDVKRW5oNXkw?=
 =?utf-8?B?WmNoSE5GbWhIeWFKcHlwYy95b3ljVGVyRVk1M1ltMXFVMnR4YlNiQWhyZGRk?=
 =?utf-8?B?aEFURnlzWkMwN3ZkOERvV2hHT2pYRjZQaXNJSzJkSkpoaXcxdmk5OTE0cUE0?=
 =?utf-8?B?MmJFMzNtR3ZyQmdrd1FvRXFXZVZJa0xQQ01xUGppZ2xsVUFwR2Y3ZElzekdQ?=
 =?utf-8?B?UlIwRmdWQzJzYWtWWnpPTyszMWYxdHRGN210bEtEazJ0ZVNCZyt4L0JvV1Ns?=
 =?utf-8?B?ZGRoeFZXMzM0R1g1NUtEVjQ4OGNFeENSV2MwMHRLYXJUb1dkTHFOdkliNktK?=
 =?utf-8?B?elN1bFZmTFZreHB3azkzcWF1bk5uVnBUbEVFdUFibFgrT0lTNnAwOENDbVJ2?=
 =?utf-8?B?OG00T21EVVlPQkxLaXN6ek9sK0dheXpWMHA3aXVOc0VHckhYZWNpbmJiT3FB?=
 =?utf-8?B?SHBsR05VS29DVjlpclZ0Y3V4WFY3K2svSUJVZHZJaFppbGZmb0toSkZKcnR3?=
 =?utf-8?B?SzhtM2VtbTVBUTFaSXFHSks0Q0JqczlLMERXVlU4Z1dzKzdVWDFCSHdnMlNp?=
 =?utf-8?B?eG5VNDZwUnhvbnc1Rk42TkU0RzRncVJwQnJGemlTRFBXMVF2NFM3endiSEpE?=
 =?utf-8?B?UEJwNGQ2T2dSYks2VE1ZM1BZajhsV3NjbnorU3VLTVF6RUtPRG9pajhFZS9Z?=
 =?utf-8?B?MlVMRUJza1FCVDNjaXBuNTlPcWlvby8xcmlNMDJjMWhRVEE4b1BDZmRwVkxn?=
 =?utf-8?B?Nk1hZURSVVBvK2F5L2FNU1FiQ21ZVndsenlxdEM0VklYZXdlMTUybHZLemxj?=
 =?utf-8?Q?8Q8M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7b0779-e557-4338-3a60-08daa06c57df
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 09:40:41.7193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R1D11Jk/6jY2BHw3xnGFr09dF3z+YQ+E3lgSYErKo+s15w+x+omGcSo3FzEyB0XAbmg5c3ghNgVja8S2h++Zkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6877
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gS3J6eXN6dG9mLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4g
U2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgMjYsIDIwMjIgMjozMiBQTQ0KPiBUbzogQW1pdCBLdW1h
ciBNYWhhcGF0cmEgPGFtaXQua3VtYXItbWFoYXBhdHJhQHhpbGlueC5jb20+Ow0KPiBicm9vbmll
QGtlcm5lbC5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4ga3J6eXN6dG9mLmtvemxvd3NraStk
dEBsaW5hcm8ub3JnDQo+IENjOiBNYWhhcGF0cmEsIEFtaXQgS3VtYXIgPGFtaXQua3VtYXItbWFo
YXBhdHJhQGFtZC5jb20+OyBnaXQgKEFNRC0NCj4gWGlsaW54KSA8Z2l0QGFtZC5jb20+OyBtaWNo
YWwuc2ltZWtAeGlsaW54LmNvbTsgbGludXgtc3BpQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgTWFoYXBhdHJhLCBBbWl0IEt1bWFy
IDxhbWl0Lmt1bWFyLQ0KPiBtYWhhcGF0cmFAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRVNF
TkQgUEFUQ0ggdjMgNi83XSBkdC1iaW5kaW5nczogc3BpOiBzcGktenlucW1wLXFzcGk6IEFkZA0K
PiBzdXBwb3J0IGZvciBYaWxpbnggVmVyc2FsIFFTUEkNCj4gDQo+IE9uIDI2LzA5LzIwMjIgMDg6
MzMsIEFtaXQgS3VtYXIgTWFoYXBhdHJhIHdyb3RlOg0KPiA+IEFkZCBuZXcgY29tcGF0aWJsZSB0
byBzdXBwb3J0IFFTUEkgY29udHJvbGxlciBvbiBYaWxpbnggVmVyc2FsIFNvQ3MuDQo+IA0KPiBV
c2Ugc3ViamVjdCBwcmVmaXhlcyBtYXRjaGluZyB0aGUgc3Vic3lzdGVtIChnaXQgbG9nIC0tb25l
bGluZSAtLSAuLi4pLg0KPiANCj4gVGhpcyBpcyBzdGlsbCBub3QgZml4ZWQuDQpJIG1pc3NlZCB0
aGlzIGNvbW1lbnQgaW4gdGhlIHByZXZpb3VzIHZlcnNpb24uIEkgd2lsbCBmaXggaXQgJiBzZW5k
IHRoZSBuZXh0IHZlcnNpb24uDQoNClRoYW5rcywNCkFtaXQNCj4gDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBBbWl0IEt1bWFyIE1haGFwYXRyYSA8YW1pdC5rdW1hci0NCj4gbWFoYXBhdHJhQHhp
bGlueC5jb20+DQo+ID4gLS0tDQo+ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9zcGkvc3BpLXp5bnFtcC1xc3BpLnlhbWwgfCA0ICsrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpLXp5bnFtcC1xc3BpLnlhbWwN
Cj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NwaS16eW5xbXAtcXNw
aS55YW1sDQo+ID4gaW5kZXggZmFmZGUxYzA2YmU2Li41ZWQ2NTEwODQ4OTYgMTAwNjQ0DQo+ID4g
LS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGktenlucW1wLXFz
cGkueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkv
c3BpLXp5bnFtcC1xc3BpLnlhbWwNCj4gPiBAQCAtMTQsNyArMTQsOSBAQCBhbGxPZjoNCj4gPg0K
PiA+ICBwcm9wZXJ0aWVzOg0KPiA+ICAgIGNvbXBhdGlibGU6DQo+ID4gLSAgICBjb25zdDogeGxu
eCx6eW5xbXAtcXNwaS0xLjANCj4gPiArICAgIGVudW06DQo+ID4gKyAgICAgIC0geGxueCx2ZXJz
YWwtcXNwaS0xLjANCj4gPiArICAgICAgLSB4bG54LHp5bnFtcC1xc3BpLTEuMA0KPiANCj4gV2l0
aCBmaXhlZCBzdWJqZWN0Og0KPiANCj4gQWNrZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGty
enlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6
eXN6dG9mDQoNCg==
