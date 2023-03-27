Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096036CA0AE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjC0J6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 05:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbjC0J6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:58:23 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B55349F6;
        Mon, 27 Mar 2023 02:58:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVTFj3SG5VzORHQPmWJxJ9EIX1oDXUSSjSCpWbRA69beb9IcssaB0jF4jtCFWOQ0zFl+FG7A9rCpEoielCOvC6qsQDkrUbysgZwa8zZDe7yUwkN3s26CLieomtpC7I1mbFVO3X0Osyuv77JE4/D8dvM3Nx88JZrlZCF/QJSB9IKvCO7TenYhAOcN4tkodWazNakgmiswDNTH9uy908QIUjewRfrjPxOkfwaE2j59enS3X71mtOV65UA62SZOoL3aqKf8aOtqYXC5U1rd7H4bAseQKkEwRpOain8CZAf2CdnSuVbBbsPG7COXsprTQFkQQoQU4h4M6/TpVBqXBwqY0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FD+K/C2VpNNXsCsV6MNWLg1udwQZABIXdjHJAy+Fg/k=;
 b=IGicURx6lL2nU7oP+d8oKo0QLqrXoxttGcUBkr+yuxnyQxAl0ajFf+gpe1SRvcdqpTC7+3a6eLP78mJBCqj4t/SpD/pv0c4ZQdhI4BzVEFriegmRfw2J3ac3nEl0ZV6hXzAbvA2XswJQlKYdz1PggYvu7h2JJbuOfbprVb0cSsGZa5X20Gw/1fr3Hxtz6xwWc92a4z2qGy/OpN6qSV5+o9oxTgY6SVgZl0YDSChPnzbLrX2lRfoOT5+cqSit+Yr6AbcbsBODbqtbt/eQJ6H/3BEAYFX8lFQ/s6qc1zHqFaq8Behz5q0BFsL16G97YJYZetB2vd2zuAniN+XmWVeGcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FD+K/C2VpNNXsCsV6MNWLg1udwQZABIXdjHJAy+Fg/k=;
 b=hf0JCwa/5gEhJQv3Wz5fGQDQBXkKt1woz19970a5baDSp/z3a8EqgOq2DBISeSrQzO5M8f7eFlkz8R+li5r3yTpcJOMt27oCAkNglXyu03Ye+7clK4omJUYxj5HVamfCfyVut6TZVumGBPI2vScocPK9cavarr5JT8JNJ0LqBUo=
Received: from BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 by BL0PR12MB4914.namprd12.prod.outlook.com (2603:10b6:208:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Mon, 27 Mar
 2023 09:58:17 +0000
Received: from BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::f07e:3ff2:7a67:dfd5]) by BY5PR12MB4258.namprd12.prod.outlook.com
 ([fe80::f07e:3ff2:7a67:dfd5%8]) with mapi id 15.20.6222.030; Mon, 27 Mar 2023
 09:58:16 +0000
From:   "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>
Subject: RE: [PATCH 1/2] dt-bindings: mmc: arasan,sdci: Add Xilinx Versal Net
 compatible
Thread-Topic: [PATCH 1/2] dt-bindings: mmc: arasan,sdci: Add Xilinx Versal Net
 compatible
Thread-Index: AQHZXiN1aENLQJlZ60KAbZ7vtoXp4a8Jz6aAgARhqQA=
Date:   Mon, 27 Mar 2023 09:58:16 +0000
Message-ID: <BY5PR12MB425806889EE700C1FCC8A465DB8B9@BY5PR12MB4258.namprd12.prod.outlook.com>
References: <20230324073630.3194724-1-sai.krishna.potthuri@amd.com>
 <20230324073630.3194724-2-sai.krishna.potthuri@amd.com>
 <d646d109-d0a6-aedb-a8b2-ac954336e628@linaro.org>
In-Reply-To: <d646d109-d0a6-aedb-a8b2-ac954336e628@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4258:EE_|BL0PR12MB4914:EE_
x-ms-office365-filtering-correlation-id: 9eef3b48-a599-4114-85b8-08db2ea9c98d
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mzPUF3+QPy2tPya9TT3REkduZ2i+fz+MiabGINl/GMtXhnXxDL4ZaPmcAscunVSMyAm/WPdZpae2m+avEXxnWcTeoh9by4e+EPk8tQWNZIIkR3Nv6ToYgrV3Z4PhNH4yHxvgZ09Ir7DS2tjzab8oVYHHW0IT0RRFcNVRn1ZAmbrN0FP3WDKBIaKL2Go2/UNqHTTS7pgyCfuIABqKNIVGPv0xgf8c4ixaOdzjZ1hrcFpZ52PbMiqw7A8CcrcOi8fSJyfbMZEjgnIp8fiGW62fE12RDPvcIGs/lGKcvBkuAYi9o9zia7FfM7KLZPFq2QPYt4IFzgSsLHiOwmXpVU3BiqlkEZcW4OPabPLDXAULcJaHdgisRJoqP/1E6HlMVFPeOSC2OZKRbJ3gn2ILBlLfJLKKJqEEAumYjDYoujcE+tIZ79zrQBmtxPzqW9KZTXdsBYjThrzDFJTB8HMYxc9Gne70kwJpKq7IIIMf0w92PXCmOioivBHYcBmMk+LqqJvL8hsadvCSZyaDxk8Y6/zAfZVr0gjRNE27KRs56OEpjzIh9CFI+0c/MPgFoXCVUNkKVQkSSqfWo821r/Z0vtMIHDQT4MqQwHN9zqdt4Llz5ITQG9Nba3cLiY/LK+4fMtAI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4258.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(451199021)(9686003)(316002)(7696005)(2906002)(5660300002)(8936002)(76116006)(33656002)(38070700005)(53546011)(52536014)(66946007)(26005)(186003)(6506007)(38100700002)(71200400001)(54906003)(7416002)(66446008)(8676002)(41300700001)(66476007)(64756008)(4326008)(66556008)(478600001)(86362001)(83380400001)(110136005)(122000001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cU90cTZ4SzNRNEl6K0V4SXYwblA5YW1VZk51dzk3OEVlMFRFLzdBdUQ4eVJs?=
 =?utf-8?B?Y0E0YTJJc0NDS2I4WHROWWs1WXA2cmJqM01jRjR5dUJtWEtReEFXdUdyR2Nr?=
 =?utf-8?B?YjduZm5pUDBIRmwwV0VNS1RGeVl5V1lMMTF1MU1RWlkxaHZyY1AzTVpVelkz?=
 =?utf-8?B?cEorSDBlV1lpYUNaWVdJVlJJc0RGSWVpbDV5a3hpNlczT054UlZQUjY2MnpK?=
 =?utf-8?B?cEVtcHBxU0pybExsNWgvYUJ5WTFVcEsrekVRSVpYT1R0UXozNnlFMFlvUU1q?=
 =?utf-8?B?WkhvV2xub3NLYUFLRzhLMVdUcjJOckliSFFoRmpCUUZHWG1FNHNYeFFERXhC?=
 =?utf-8?B?Qkk2K2FzN285alh5MG94OGhuRzdXeTBnSVJTU3M4dW9TcEk4ZUpoSUd0eS9F?=
 =?utf-8?B?RXlneUxLTHJjUFZ4WEZEWmw2cy82OFlmTkVLTitHRys1LzFTRWh2bFl6Ym5I?=
 =?utf-8?B?cHA1TlFXaS9oZGFTaUVHTThPd0lYZ2czend3UllYakJhMzJjbXBFTjM0SlY4?=
 =?utf-8?B?T1RVaUZHblpDV3FpSUYxM0JiTm53TzJVTmg3ZzZYQnJTWkVVd2JiR3FtNXA4?=
 =?utf-8?B?UHFHdE9JWkRremRkMU5uclpIV1dja0hWWEU3MGhsS0l0L0tVTHpnTUd2Qnhm?=
 =?utf-8?B?OHMrMFpISnJwS21mVXBNQzRzbER3cjBFZFJuWXcvMHlNY1IySjg3dG8yZVNy?=
 =?utf-8?B?TEFGMXUxUVBuTi85MXphS3BVeDQwL0Jla0RrUnpBbHdTVm5DeFd3MUthM1Vs?=
 =?utf-8?B?YjdrT0V3RFhaVEN0dHNicytTQVFCdEFuZG4zc0JvSG9HT253MFFrTkNoT1dX?=
 =?utf-8?B?YjVBWVhsZVFzVklsbzN6aDhXd2xzdDUwV01rcFUydVVZOTRST0JGd2JWb09o?=
 =?utf-8?B?dEh4blEyc1JkMm9rcnVxek42V0lhaGxSQXVibVVYZGhkeVVqTFdOa0RxT3dl?=
 =?utf-8?B?K1IybTN3K1JMam5wWGJhejVxVEY0STFDYThBSEZQemVFWWF2QW1jTFYzOG1K?=
 =?utf-8?B?a3l1M3dhbTdMaUFvY0xCbkNPdmRlM05mMGpvZ3pwQmRwOFhWeE5ac2FiQzBz?=
 =?utf-8?B?NXAwKzFwY3YreTBmZ0orYW1wUmxMM3ZHMzRIVVNJdmhXVmZoNklDaXBMRkRn?=
 =?utf-8?B?Zll4NzJRT05hUGVUdWdjUWlnQ0ZKSkZZbC9LOVViUjFJU2FQd2NXclNWeDZm?=
 =?utf-8?B?N05JRmxFMENsQTh2MUwxR1lINTYrWkhTYzBSNEU3cXhaRVB1UjJxdS9hQ0kz?=
 =?utf-8?B?empVcndTajNOaWRybkJtMDg2Y1RTcTVEYmd1MGRhQVQ4NmlnMlJFRDN2eEFm?=
 =?utf-8?B?VmpFc0FlNWFLZ2RqclFJa205MDZSc0UyYWthQ2tIbkhGNit3ZEpJbDh3UFJO?=
 =?utf-8?B?UkZ3UW5EamwyUFVhRmpXRlQxS1ZucHgyaWFzVFdxTysrdWxvVVdKc0RmMll3?=
 =?utf-8?B?L2kzVDVRRHpJemNiMVoxK3hPTnpLcWE0aElJTlNHRVBsc1V3cHp5Y0lrTE5Z?=
 =?utf-8?B?WmcxbFFKWVVVeWk3a3RYVjVCalVhajIyK0hyMmhoR3VOK3o1Y3B1VFRibWo0?=
 =?utf-8?B?cjk1UUhkSGdWcXVKU1FkMnZIdWVkR1RMb09hNzI0OXJJYnJVL1JJdWdtQkFP?=
 =?utf-8?B?R1hNNDBuSS9TNzc5OFY3V256TkZNUnJUbDB6VlV1NDZQbE84bm1mS3ZSVlVY?=
 =?utf-8?B?eU9OeHJFSWdFUGNVc0hXc1ZGamQ3clJBeGh3ekVqUE55aTg5K20zYUdWMDll?=
 =?utf-8?B?Qm1VVCt1U1R4dnJLaUhnK3NWRytBNTVrR2FpcEI4Y282TGJac01vN1Y4RlZh?=
 =?utf-8?B?cWRGY1ZIMWptbmVld3A5RU5lZ0czMDlxeE5VOTVmWHF0ZFJXMFNyeG1QRHRT?=
 =?utf-8?B?MDRHY0kxZUtRWXUwb1htYmhaMTNJU1ZxRzJxTW9Qa3h4OGpJYm1rWEpaTEpp?=
 =?utf-8?B?ZC9HMFk4OEtWZUdFVTdlUEVtUmFGYmlCUzNRZm5LcCtUclNXbFZiTENlTDRZ?=
 =?utf-8?B?OGRqbHFhK1I1TldMYTlNaENwYXRqUzQ4bkljMzVxM3d3RDl3MXErVG15MGp0?=
 =?utf-8?B?cC9KWm43dTl0R2czSnVhNnpXeUhBQ0VXd3F1RVExcnp0b0tjTUhHd2tmeFhM?=
 =?utf-8?Q?MAjw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4258.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eef3b48-a599-4114-85b8-08db2ea9c98d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2023 09:58:16.8636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FfjvBlgSVT9naCREuEutws0RrLJQ/AR+UQTUpDyycUR9RnWV4Cb8w9C+ATqODts6irqkZt/XbuAfcbIs41KBng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4914
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEty
enlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2Vu
dDogRnJpZGF5LCBNYXJjaCAyNCwgMjAyMyA1OjE0IFBNDQo+IFRvOiBQb3R0aHVyaSwgU2FpIEty
aXNobmEgPHNhaS5rcmlzaG5hLnBvdHRodXJpQGFtZC5jb20+OyBVbGYgSGFuc3Nvbg0KPiA8dWxm
LmhhbnNzb25AbGluYXJvLm9yZz47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBL
cnp5c3p0b2YNCj4gS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc+
OyBNaWNoYWwgU2ltZWsNCj4gPG1pY2hhbC5zaW1la0B4aWxpbnguY29tPjsgQWRyaWFuIEh1bnRl
ciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+DQo+IENjOiBsaW51eC1tbWNAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBnaXQgKEFNRC0N
Cj4gWGlsaW54KSA8Z2l0QGFtZC5jb20+OyBzYWlrcmlzaG5hMTI0NjhAZ21haWwuY29tDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBkdC1iaW5kaW5nczogbW1jOiBhcmFzYW4sc2RjaTogQWRk
IFhpbGlueCBWZXJzYWwgTmV0DQo+IGNvbXBhdGlibGUNCj4gDQo+IE9uIDI0LzAzLzIwMjMgMDg6
MzYsIFNhaSBLcmlzaG5hIFBvdHRodXJpIHdyb3RlOg0KPiA+IEFkZCBYaWxpbnggVmVyc2FsIE5l
dCBjb21wYXRpYmxlIHRvIHN1cHBvcnQgZU1NQyA1LjEgUEhZLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogU2FpIEtyaXNobmEgUG90dGh1cmkgPHNhaS5rcmlzaG5hLnBvdHRodXJpQGFtZC5jb20+
DQo+ID4gLS0tDQo+ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvYXJh
c2FuLHNkaGNpLnlhbWwgfCA2ICsrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21tYy9hcmFzYW4sc2RoY2kueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL21tYy9hcmFzYW4sc2RoY2kueWFtbA0KPiA+IGluZGV4IDgyOTZjMzRjZmEw
MC4uY2Y0NGE0Yjk4OGE3IDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tbWMvYXJhc2FuLHNkaGNpLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbW1jL2FyYXNhbixzZGhjaS55YW1sDQo+ID4gQEAgLTI3LDYg
KzI3LDcgQEAgYWxsT2Y6DQo+ID4gICAgICAgICAgICAgIGVudW06DQo+ID4gICAgICAgICAgICAg
ICAgLSB4bG54LHp5bnFtcC04LjlhDQo+ID4gICAgICAgICAgICAgICAgLSB4bG54LHZlcnNhbC04
LjlhDQo+ID4gKyAgICAgICAgICAgICAgLSB4bG54LHZlcnNhbC1uZXQtNS4xLWVtbWMNCj4gDQo+
IHY1LjEgaXMgZU1NQyBzdGFuZGFyZCBvciBWZXJzYWwgYmxvY2sgdmVyc2lvbj8gSWYgdGhlIGZp
cnN0LCBpdCdzIG5vdCBzdWl0YWJsZSBmb3INCj4gY29tcGF0aWJsZXMuDQo+IA0KPiBBbHNvLCB3
aGF0J3MgdGhlIGRpZmZlcmVuY2UgZnJvbSB4bG54LHZlcnNhbC04LjlhPw0KVjUuMSBpcyBhbiBl
TU1DIHN0YW5kYXJkIGFuZCB0aGlzIGNvbXBhdGlibGUgaXMgZGVmaW5lZCBiYXNlZCBvbiBzZGhj
aSBhcmFzYW4NCmVNTUM1LjEgSG9zdCBDb250cm9sbGVyKGFyYXNhbixzZGhjaS01LjEpLCB3aGVy
ZSBhcyBpbiBWZXJzYWwsIGl04oCZcyBhIGRpZmZlcmVudA0KY29udHJvbGxlciBhbmQgaXQgaXMg
YmFzZWQgb24gNC41MSBIb3N0IENvbnRyb2xsZXIoYXJhc2FuLHNkaGNpLTguOWEpLg0KVmVyc2Fs
IE5ldCBDb21wYXRpYmxlIGlzIGRlZmluZWQgaXQgdGhpcyB3YXkgdG8gbWFrZSBpdCBpbmxpbmUg
d2l0aCB0aGUgb3RoZXINCmV4aXN0aW5nIFNvQyBjb21wYXRpYmxlcyBsaWtlICJpbnRlbCxrZWVt
YmF5LXNkaGNpLTUuMS1lbW1jIi4NClBsZWFzZSBzdWdnZXN0IGlmIHRoZSBjb21wYXRpYmxlIG5l
ZWQgdG8gYmUgcmVuYW1lZCB0byAieGxueCx2ZXJzYWwtbmV0LWVtbWMiPw0KDQpSZWdhcmRzDQpT
YWkgS3Jpc2huYQ0KDQo+IA0KPiA+ICAgICAgdGhlbjoNCj4gPiAgICAgICAgcHJvcGVydGllczoN
Cj4gPiAgICAgICAgICBjbG9jay1vdXRwdXQtbmFtZXM6DQo+ID4gQEAgLTYyLDYgKzYzLDExIEBA
IHByb3BlcnRpZXM6DQo+ID4gICAgICAgICAgZGVzY3JpcHRpb246DQo+ID4gICAgICAgICAgICBG
b3IgdGhpcyBkZXZpY2UgaXQgaXMgc3Ryb25nbHkgc3VnZ2VzdGVkIHRvIGluY2x1ZGUNCj4gPiAg
ICAgICAgICAgIGNsb2NrLW91dHB1dC1uYW1lcyBhbmQgJyNjbG9jay1jZWxscycuDQo+ID4gKyAg
ICAgIC0gaXRlbXM6DQo+ID4gKyAgICAgICAgICAtIGNvbnN0OiB4bG54LHZlcnNhbC1uZXQtNS4x
LWVtbWMgICAgICMgVmVyc2FsIE5ldCBlTU1DIFBIWQ0KPiA+ICsgICAgICAgIGRlc2NyaXB0aW9u
Og0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
