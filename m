Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3BE6DD83E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 12:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjDKKrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 06:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDKKrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 06:47:06 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992C926B6;
        Tue, 11 Apr 2023 03:47:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQ5NNh34ZzhTcMT8stoFoqJa65iZN2yI3epK1VFTCPymCIZbVA/UkN/gNoB3ntdsaKhG9HYli1wAMZ7FbPyAgDz5zFnMSJP3WysjpdjA9sJNYlREU4G/Zi6Y3AwIWETGlZp4p/+kBcuyr9jtxGKGWGQbPsXKCc39JFcVAW8Mt24mgkin9UPnYyimlEQVSHI23Aer3wvSryE26Mkv8mnUdizXTLAQyVCRMzZX7Q0vkurQ9jqJEVn+xRfUkL2m678viO35byCjAdlnbxYgITzzXAWGVLiW+aiXtAUbMW/z4j3yppjqmxVnEq5XW09GtHVgv4hs9qruKeX4XGEpnyNqWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JfIihGg4HHCIMbLH0InOab+DVjBRPzQbl4POT3WnnI=;
 b=OkEccAoin0evObLWivfjg82HpoMen7HTDbs1oeWiE9vZoFFWXHcee5CarYIjEdHUUf27rQKmU7KREH6Ip6amODqGRekZzaM0joGrJAKwJkDq770ZB245Sg+hu8G6H7Dnckb8QKmk2ez73IloFFDAmIvL6HAuMfBwdUDaLZEr1m90fi+RSiPtbLRC8rew6qF/LCsSXAMtgtDdPb7x7yEqnJqp+Y1jN9iThlaPoE5yOx3cqNRUaR/YOGzawLYCJBzewZAtiP3MPTpawvMZsUZa8YMjDD8vsCxEZrzrzkyAuOG5aE/MQmQm8NMGxT94Bp4vI+RbaEk6zQ7aqb/sdtAl6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JfIihGg4HHCIMbLH0InOab+DVjBRPzQbl4POT3WnnI=;
 b=LnG5lInO9J9zQcoKPo343IzUJSTgCDRGQGDccsAihSGY/F3hUjFVWUxitoVJJJU2TSBT+Nd5K5OS+BwRU+dMi12Wj42PRwhAaA0wApW++P5R2EVSweoflxrd2gbs6PNxNaQvKRhx7YXhfmWrdJ8p4KyjO/fnOiaAlWvYhlN0oY0=
Received: from BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22)
 by CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 11 Apr
 2023 10:46:58 +0000
Received: from BY5PR12MB4033.namprd12.prod.outlook.com
 ([fe80::ca02:f54f:1f98:6ba7]) by BY5PR12MB4033.namprd12.prod.outlook.com
 ([fe80::ca02:f54f:1f98:6ba7%4]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 10:46:58 +0000
From:   "Neeli, Srinivas" <srinivas.neeli@amd.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
        "Simek, Michal" <michal.simek@amd.com>,
        "Goud, Srinivas" <srinivas.goud@amd.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "git@xilinx.com" <git@xilinx.com>,
        "neelisrinivas18@gmail.com" <neelisrinivas18@gmail.com>
Subject: RE: [PATCH V3 2/4] dt-bindings: watchdog: xlnx,versal-wwdt: Add
 versal watchdog bindings
Thread-Topic: [PATCH V3 2/4] dt-bindings: watchdog: xlnx,versal-wwdt: Add
 versal watchdog bindings
Thread-Index: AQHZY6ROgpDtrE8tBU2zZ66wUBBtsa8Z7iIAgAwQB/A=
Date:   Tue, 11 Apr 2023 10:46:58 +0000
Message-ID: <BY5PR12MB4033849F2B1170B898CA6165939A9@BY5PR12MB4033.namprd12.prod.outlook.com>
References: <20230331074117.356339-1-srinivas.neeli@amd.com>
 <20230331074117.356339-3-srinivas.neeli@amd.com>
 <23a7215e-0be4-195c-f3c9-3b1d1b760fa0@linaro.org>
In-Reply-To: <23a7215e-0be4-195c-f3c9-3b1d1b760fa0@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB4033:EE_|CH3PR12MB7500:EE_
x-ms-office365-filtering-correlation-id: 35519b08-25f4-4757-53d6-08db3a7a134b
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /eoxOmXSNqeq9XHovyQhP87JteaeNyXKLjaPJeUUvL9pfJ8PPcESgGTHXy8TzwIrYHubihhtFXvuqUnLrmxv7JXjP414vyqKxX6a+bFGzj4mf8P201SKmrbdqde56srHf6ctB/j3wPTtHlwOTFBj/gV0MoZVLfd0dVt1mXq5CXjjvspEf3eP2+neUn+o52b3wZr1kJ7RY9tMk/dpdBuoQp1qINlp88/xHtC1UjvmioWXq5If7c6u2IajAx3edNwu+FwhgBmQbv3oUN7kJ4vhhCN2bGaAM3rHg3n3k5yqeT+WBjWjdR+HlXQe/9VfoeiGYZI4ggx7aw4mLVwZN5abVhoUxr4tD7eF+qDpvMD4PGWuhkTGE6wSpKqUtaoIYAzAeEJE+uCHMNVSamCve0HsbxlN0nNsKkehZNSzKHsIW0RFYmNtKBZjcTTWMNOiVOJHUb9ws4yaexOWyhLq5yr90uj2kqkqudNsS0p+a4y0RVuBHDDO9FD6rEo7CgRLlQzkItWuGyDsjsYco5Tv3gUTlqL2QDkGdgUcWnCYX1Mq3fFLqKShEk02Hxfvokt6i1eC5Ipnzf8//NYRASov4R1fQte4AgAaRlo3oKib4Jj7JkdMcPtUvRPQtHIvMDSytfIiqh91+SkeHXGIv+JbNtllZB+6jsgj2wO26UBpt+frhHQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4033.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(451199021)(53546011)(54906003)(66946007)(66476007)(66556008)(110136005)(66446008)(64756008)(316002)(478600001)(76116006)(8676002)(33656002)(7696005)(2906002)(71200400001)(4326008)(966005)(83380400001)(122000001)(5660300002)(41300700001)(52536014)(7416002)(8936002)(921005)(38100700002)(86362001)(6506007)(26005)(55016003)(186003)(9686003)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmZGYklTTEM5MVZieGlPZVlpU2xoNTNrWEhUVHVvbDRDV0NTQjBlRHJ1bjls?=
 =?utf-8?B?bWNNbDRoV0dTaFA4Yk0wZEtTSGkwWVgrN1kzdWp6bmZJbDVoNU40cWZzSDFp?=
 =?utf-8?B?c1Q5K0U4d3RFU09nTHo2SWtucC80SGZNZGJRMTU5ZTNNQ1Y4R0RyK0t4TmVW?=
 =?utf-8?B?a3FsWEZKczJ0L3BjTDNrMWVQM3hSSTJ5eHQwNUs0eVFKY1dzc0xGT2p2QW12?=
 =?utf-8?B?WnZCRFA1REpTNlJwNXlLTFhPTDVEemZqS2wyWmlZTnZNNGhwRFYrcmJ4QUQ2?=
 =?utf-8?B?SkZCeUNIeFFmZllKdGRoUkErL2pWWGV4Z1hHOUhqMXhsdUR5UlNzMUNXL1pJ?=
 =?utf-8?B?UzlhZitEQzJibmdNcGwrY1pMZEZZa3FlSVp0QXphWjQ4aE1WNXpFL3ZlR2Ja?=
 =?utf-8?B?MkR4RVhUOFVsZW5CdXNpNGRKellqUFdjSmdUMkJLQTZ1V25KT0MrWk5Ody9y?=
 =?utf-8?B?UU1KV0x2TENtYlluRGNzeHNnV2hBeEFybVk4Y2hyRDIvU3JjeUdzcEgxRE9E?=
 =?utf-8?B?L21Fb3hrUnZXM0pUSy9Gb3BWLzlhM1YrR1VsYnJab0hwZ2FkeThiZXpyS2lY?=
 =?utf-8?B?Mm5DL3lwRi84MXZxeCt4Vm91dTlGWTNiMHJ3S3pXZkZaVUs1ekFRMmp4dGFC?=
 =?utf-8?B?RjlTZVBmRFZObjk0Q1FNVzBmNktzNGFoQWd4NGE4Vkhrb25NeHp4V2tubnFt?=
 =?utf-8?B?dlRjMHBBWVRVenhCMEFjdnc0eUx6L3dsVEZmZjJLbXBadWpKSUJ0ZmJlbzNB?=
 =?utf-8?B?N1RnOFBSNmYyNVQvTFMzNzJ2N3JBVlY5MzJRU2hhbEV0ak4vVEszSjJpVEMr?=
 =?utf-8?B?ckZoWmt1NFVZN2NCVkdLaUh4bXRKQXJyTVViKzZZbE83WkpZYXlQdEVEeHhw?=
 =?utf-8?B?VWxlbXJ3UHBNVi9EYlorbTBQcFMyckVyN0IrVHgxcWZ3TzdMY0lsMWlkaXdG?=
 =?utf-8?B?UkdRTUFoUnQvTkJiU2tnTXVyZmVrUXI2QnFJejIwUkZNUFdISmRKMlF6WEJG?=
 =?utf-8?B?WmhWVmZPWlgzRFNEVTVJenBkcWJVL3RMU2tUdXZOdDd3Q3pUclhYek9uV3RR?=
 =?utf-8?B?WkJJZE56aGl5OEZjRW8zMWc2UFBaZlNuZDZwODdCaVhpN3ZZNGU4RXYzZ1ZX?=
 =?utf-8?B?KzFMUUIxQ3dleFpuWTBSaHpMWDdDOUJSVkkvZHRlSUc2YlZDT3RpdzBINFdJ?=
 =?utf-8?B?QW1EbVhPSGFTTmRtSGtBNDAxeWNlTjBFZDB5cUxGcHNTVmNocjUyaERtenVz?=
 =?utf-8?B?TVdEQ2pZOUlBbSt0OHArMHRFQUkybGVNRW9pT1JpZ09hUnBUOFJBWlQxU0hZ?=
 =?utf-8?B?Ulo4aDFucjZRZWlXaThNQ0l0TytTZlkzYnR5QzIzbkhOVVhpbGVEdm1uVjJV?=
 =?utf-8?B?UXNMMnMrSkdhOE9XUG9lZWQ0bmtSMDJTZ0x1UWRFOTFmRDhYLzRVQUZyQjdm?=
 =?utf-8?B?UHRiWGt4b3lqa2J0eWk5bjI4YmVudzZXc0NUTEloaVJiRXZXNVhMRyt6WDd2?=
 =?utf-8?B?cUNBaWU5Rlk2TFkyVXN0M0tNRXlHdmpzYUpyUHYvNmlGUU9KWUtsNENITTRQ?=
 =?utf-8?B?Z0NtN2FjVVFvbUpaeWR6aHRvTTl4dXNRem5JR2JNblBvRE52Y0xRNlNKQXJv?=
 =?utf-8?B?ejhCb2xUTitONW5FazA1UDRpQmhvcU5Wc3pSUlJMeGowZGx6Z3RRQkFRT2dk?=
 =?utf-8?B?K3BiUWI4NkM2QXFVdVhJT2FSWW5GTzA5MTVyMkZ0VDRMQ0w4azZmVm13ZFQ5?=
 =?utf-8?B?VUs1dmZBRWV2c3ZGQWRJejQ0MWkvRVlGZkF4R2ZVOVczSjZvUG05Q3I2SjlW?=
 =?utf-8?B?N2NhTXlDL3ZWRVNVKzREcXJkVE83R0d3ZjVBM0E4b2MrQ2wzSnFScDduNnBq?=
 =?utf-8?B?T1FYaENXNCs2WlBRWXFGYWsvZzh5ZGo4KzVhc3h0bDZOSCtEWkNKSXNCcVZE?=
 =?utf-8?B?OGRTbElFRVpyaW5SeGRNdGdkWmYyYUtHRW9WYmtqbkExVlAxbEZ1dGYrazd1?=
 =?utf-8?B?WmdhZG5WT2dTaUhxNXpBUmpXQUhQUUsxUEovUnF3SzQrNWo3VzdDSGxDN3ZG?=
 =?utf-8?B?L2NnQW9hTUh1bXBVeHJtdjd5TlU3dW5JRjY4SmNacXZRSUhKcUxJUk9iTmZ5?=
 =?utf-8?Q?oBLE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4033.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35519b08-25f4-4757-53d6-08db3a7a134b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 10:46:58.6886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O+hnMw1DGpqzZdXKsMh9XNYU+/MA6jqptYeIM3HEbgw0TZ0iw2vQSvtlkPKwjian
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7500
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEty
enlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2Vu
dDogVHVlc2RheSwgQXByaWwgNCwgMjAyMyAxMjowMyBBTQ0KPiBUbzogTmVlbGksIFNyaW5pdmFz
IDxzcmluaXZhcy5uZWVsaUBhbWQuY29tPjsgRGF0dGEsIFNodWJocmFqeW90aQ0KPiA8c2h1Ymhy
YWp5b3RpLmRhdHRhQGFtZC5jb20+OyBTaW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNv
bT47DQo+IEdvdWQsIFNyaW5pdmFzIDxzcmluaXZhcy5nb3VkQGFtZC5jb20+OyB3aW1AbGludXgt
d2F0Y2hkb2cub3JnOw0KPiBsaW51eEByb2Vjay11cy5uZXQ7IHJvYmgrZHRAa2VybmVsLm9yZzsg
a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnDQo+IENjOiBsaW51eC13YXRjaGRvZ0B2
Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
OyBnaXQgKEFNRC0NCj4gWGlsaW54KSA8Z2l0QGFtZC5jb20+OyBnaXRAeGlsaW54LmNvbTsgbmVl
bGlzcmluaXZhczE4QGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDIvNF0gZHQt
YmluZGluZ3M6IHdhdGNoZG9nOiB4bG54LHZlcnNhbC13d2R0OiBBZGQNCj4gdmVyc2FsIHdhdGNo
ZG9nIGJpbmRpbmdzDQo+IA0KPiBPbiAzMS8wMy8yMDIzIDA5OjQxLCBTcmluaXZhcyBOZWVsaSB3
cm90ZToNCj4gPiBWZXJzYWwgd2F0Y2hkb2cgZHJpdmVyIHVzZXMgd2luZG93IHdhdGNoZG9nIG1v
ZGUuIFdpbmRvdyB3YXRjaGRvZw0KPiANCj4gU3ViamVjdDogZHJvcCBzZWNvbmQvbGFzdCwgcmVk
dW5kYW50ICJiaW5kaW5ncyIuIFRoZSAiZHQtYmluZGluZ3MiDQo+IHByZWZpeCBpcyBhbHJlYWR5
IHN0YXRpbmcgdGhhdCB0aGVzZSBhcmUgYmluZGluZ3MuDQo+IA0KPiA+IHRpbWVyKFdXRFQpIGNv
bnRhaW5zIGNsb3NlZChmaXJzdCkgYW5kIG9wZW4oc2Vjb25kKSB3aW5kb3cgd2l0aA0KPiA+IDMy
IGJpdCB3aWR0aC4gV3JpdGUgdG8gdGhlIHdhdGNoZG9nIHRpbWVyIHdpdGhpbiBwcmVkZWZpbmVk
IHdpbmRvdw0KPiA+IHBlcmlvZHMgb2YgdGltZS4gVGhpcyBtZWFucyBhIHBlcmlvZCB0aGF0IGlz
IG5vdCB0b28gc29vbiBhbmQgYSBwZXJpb2QNCj4gPiB0aGF0IGlzIG5vdCB0b28gbGF0ZS4NCj4g
Pg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBkZXZpY2V0cmVlIGJpbmRpbmdzIGZvciB2ZXJzYWwgd2lu
ZG93IHdhdGNoZG9nIGRldmljZS4NCj4gDQo+IERvIG5vdCB1c2UgIlRoaXMgY29tbWl0L3BhdGNo
IiwgYnV0IGltcGVyYXRpdmUgbW9vZC4gU2VlOg0KPiBodHRwczovL2VsaXhpci5ib290bGluLmNv
bS9saW51eC92NS4xNy4xL3NvdXJjZS9Eb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3ViDQo+IG1pdHRp
bmctcGF0Y2hlcy5yc3QjTDk1DQo+IA0KDQpUaGFua3MgZm9yIHJldmlldywNCkkgd2lsbCBhZGRy
ZXNzIGFsbCBjaGFuZ2VzIGluIG5leHQgdmVyc2lvbi4NCg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogU3Jpbml2YXMgTmVlbGkgPHNyaW5pdmFzLm5lZWxpQGFtZC5jb20+DQo+ID4gLS0tDQo+ID4g
Q2hhbmdlcyBpbiBWMzoNCj4gPiAtIFJlbW92ZWQgIHhsbngsY2xvc2VfcGVyY2VudCBwcm9wZXJ0
eS4NCj4gPiBDaGFuZ2VzIGluIFYyOg0KPiA+IC0gQWRkZWQgd2F0Y2hkb2cgcmVmDQo+ID4gLSBS
ZW1vdmVkIHRpbWVvdXQtc2VjIHByb3BlcnR5DQo+ID4gLSBVc2VkIDQgc3BhY2VzIGZvciBleGFt
cGxlIGluZGVudGF0aW9uLg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3Mvd2F0Y2hkb2cveGxu
eCx2ZXJzYWwtd3dkdC55YW1sICAgfCA1MCArKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCA1MCBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy93YXRjaGRvZy94bG54LHZlcnNhbC13
d2R0LnlhbWwNCj4gPg0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy93YXRjaGRvZy94bG54LHZlcnNhbC13d2R0LnlhbWwNCj4gPiBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy93YXRjaGRvZy94bG54LHZlcnNhbC13d2R0Lnlh
bWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uZGVh
MWU3YzQ4N2QzDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy93YXRjaGRvZy94bG54LHZlcnNhbC0NCj4gd3dkdC55YW1sDQo+ID4g
QEAgLTAsMCArMSw1MCBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIu
MCBPUiBCU0QtMi1DbGF1c2UpICVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOiBodHRwOi8v
ZGV2aWNldHJlZS5vcmcvc2NoZW1hcy93YXRjaGRvZy94bG54LHZlcnNhbC13d2R0LnlhbWwjDQo+
ID4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1s
Iw0KPiA+ICsNCj4gPiArdGl0bGU6IFhpbGlueCBWZXJzYWwgd2luZG93IHdhdGNoZG9nIHRpbWVy
IGNvbnRyb2xsZXINCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gTmVlbGkgU3Jp
bml2YXMgPHNyaW5pdmFzLm5lZWxpQGFtZC5jb20+DQo+ID4gKw0KPiA+ICtkZXNjcmlwdGlvbjoN
Cj4gPiArICBWZXJzYWwgd2F0Y2hkb2cgZHJpdmVyIHVzZXMgd2luZG93IHdhdGNoZG9nIG1vZGUu
IFdpbmRvdyB3YXRjaGRvZw0KPiANCj4gV2hhdCBpcyBkcml2ZXI/IElmIHlvdSBtZWFuIExpbnV4
IGRyaXZlciwgdGhlbiBkcm9wIGFsbCByZWZlcmVuY2VzIHRvIGl0IGFuZA0KPiByZXBocmFzZSB0
byBkZXNjcmliZSBoYXJkd2FyZS4NCj4gDQo+ID4gKyAgdGltZXIoV1dEVCkgY29udGFpbnMgY2xv
c2VkKGZpcnN0KSBhbmQgb3BlbihzZWNvbmQpIHdpbmRvdyB3aXRoDQo+ID4gKyAgMzIgYml0IHdp
ZHRoLiBXcml0ZSB0byB0aGUgd2F0Y2hkb2cgdGltZXIgd2l0aGluIHByZWRlZmluZWQgd2luZG93
DQo+ID4gKyBwZXJpb2RzIG9mIHRpbWUuIFRoaXMgbWVhbnMgYSBwZXJpb2QgdGhhdCBpcyBub3Qg
dG9vIHNvb24gYW5kIGENCj4gPiArIHBlcmlvZCB0aGF0IGlzIG5vdCB0b28gbGF0ZS4gVGhlIFdX
RFQgaGFzIHRvIGJlIHJlc3RhcnRlZCB3aXRoaW4NCj4gPiArIHRoZSBvcGVuIHdpbmRvdyB0aW1l
LiBJZiBzb2Z0d2FyZSB0cmllcyB0byByZXN0YXJ0IFdXRFQgb3V0c2lkZSBvZg0KPiA+ICsgdGhl
IG9wZW4gd2luZG93IHRpbWUgcGVyaW9kLCBpdCBnZW5lcmF0ZXMgYSByZXNldC4NCj4gPiArDQo+
ID4gK2FsbE9mOg0KPiA+ICsgIC0gJHJlZjogL3NjaGVtYXMvd2F0Y2hkb2cvd2F0Y2hkb2cueWFt
bCMNCj4gDQo+IEFsbCBvdGhlciBleGFtcGxlcyByZWZlcmVuY2UgbG9jYWwgd2F0Y2hkb2cueWFt
bC4gRG9uJ3QgZG8gaXQgZGlmZmVyZW50bHkNCj4gdGhhbiBvdGhlcnMgKGdpdCBncmVwIHdhdGNo
ZG9nLnlhbWwpDQo+IA0KPiA+ICsNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoN
Cg==
