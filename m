Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16D8743A2B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 13:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjF3LB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 07:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbjF3LBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:01:13 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79499F5;
        Fri, 30 Jun 2023 04:00:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UP1j8LujxMFKj2tlaYb0J17KQdbS4nYWxG5fZ8XHFqKkewK+mlsQeXdldBI2CybvLpHnHUSx34Dm91VMFYhHPoMS5mnfvRAhHUlGilnAhUUvzWVprFr8gJlinKGXVVZyuMc4zttWZ35Sq9FiOtQDmJM1el7jQlTR3kS1y8gZiYHt9H5rT5Gd7F5QQ9bjWKDsM6miIT2g5WO0xN8E4pJeyqxrmiVXUypjXo0UHMxlyG+QHTdQX5KKWELWftcvHEOk770hzbwF2G95KiRx2p99LW3Ov516xLXZ1XFAIl+cWDhL7Ez5BIRzqaTl6XCe6O/VXg8IY/f7xdRu4mtxQnhhoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=62bjiV9RDnxnzXzqVkfD/FUora+FHj+ur/gcohlCNmM=;
 b=fmlHBMW5cJp1N2c25zBG5CS3+EkpPHa3Z7ffN+TkwDiyN/urd4PQEXUU7p4K51hpa8TOdtSJQXoxfYqkMqGqvDzcLkMeYPhghi4Bi10crAc/dWB7o+cMqH1g8wQMfQ2HIndTueIfEBVtXsKZSI8FSesUxstkLxZFIMMVu/fhKkUz6yXf1J3MSdYI5/BgLpAT08Xo6Zzfb5UI1L2JOPtDA9Wt0AKWCjw2AojoycW81R+pxeFWiWghguLG2T527vFlYi+iYzGHnqPCq+g7oMrHJvOvRCM3yPCjj1Gx3sXs/83HhuNKTSVHTBqAoHedzQ2KUB5+TxjHBekKBd7MqwasrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62bjiV9RDnxnzXzqVkfD/FUora+FHj+ur/gcohlCNmM=;
 b=IzNS4e6va8uiRDhnDrAPch2OeTD1eW8KPd0htuiqkPcIkxdHsWn+6+KecCqrQQxman63usuv1alq26FTKbwNFUaK5tB0T1C6P3Ol0oOLdlwYMASgOji1K6Lsw+vZr7Q77BUVcl54rBosB0zZLf9plH/3j6T+TNN+1cRY3oTsjqQ=
Received: from BN7PR12MB2802.namprd12.prod.outlook.com (2603:10b6:408:25::33)
 by PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 10:59:40 +0000
Received: from BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::3087:7db7:f0eb:cb8f]) by BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::3087:7db7:f0eb:cb8f%2]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 10:59:39 +0000
From:   "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Michael Walle <michael@walle.cc>
CC:     "pratyush@kernel.org" <pratyush@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>
Subject: RE: [PATCH v3 2/2] mtd: spi-nor: Avoid setting SRWD bit in SR if WP#
 signal not connected
Thread-Topic: [PATCH v3 2/2] mtd: spi-nor: Avoid setting SRWD bit in SR if WP#
 signal not connected
Thread-Index: AQHZp0xXPMgZrN231kex2RYj3Ml7G6+eLsuAgATh3YCAACO+QA==
Date:   Fri, 30 Jun 2023 10:59:39 +0000
Message-ID: <BN7PR12MB2802FCA032525982E70A9432DC2AA@BN7PR12MB2802.namprd12.prod.outlook.com>
References: <20230625100251.31589-1-amit.kumar-mahapatra@amd.com>
 <20230625100251.31589-3-amit.kumar-mahapatra@amd.com>
 <5e5fe22aebe17da4f9ad2c4eaaa8985f@walle.cc>
 <6190c9c4-6d6e-7577-f2a4-8fbede61b405@linaro.org>
In-Reply-To: <6190c9c4-6d6e-7577-f2a4-8fbede61b405@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR12MB2802:EE_|PH0PR12MB7888:EE_
x-ms-office365-filtering-correlation-id: d3496e67-3dd1-462f-f824-08db795919e1
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SzFVaiAhgyl8OWkdWgJ8DZHW1phBTrGO0gkj12k9rrQrxyjRwFGV08VkK3njeoPQqHa3S2ZBQjT7FpTwtXHucAY8alcj9P8xZkv4uWiwBJFNQCh1Qyj7cZe6MrmXm1itha6hGpyBrWB4H5SR/zsjQ/DnsLQueXjneJ/8kLVYxDH4eTPjJDeCwss5WQRbCYsaQ0SHcxgYl6euBY8MeqaqDlOBNWCHO83lwVFtAKgCbSi2KE797DgwisLe3Nq5efXRlmNRBfJzcwch59Yby7F6E+8yM+XMQgXnRIXV438PuhK3CiHGSZ2Ynd/PXAstYUCvyAHyufCW5Yllsr2RmsiXYcwOhP/qwQNfuTVBYU92mFCUdUJxsQSHo9kL1G9ULeafU9dOWJQfZpzUSEeK8SxWAr8IvhojnQDN2043dzVVFyEvXff6Fa8e4w7EjoLbKT+uktUytCmKtsV8njnZ8T+/Mj4INBmaIhACsTfKVWaPOLWyU12NZYlObaoc9nRcef6ExlqLh8rB6wOQNmtNSLxUMvq10MuWVXLJwxOehdIt1sX7SL8Ngg8YnFbMf84K1lJ2EwgKb1I17lafMWIkyoIyRBhXw9FIeYjAhiUBXampFAt5RogS3CPnKMxl6Vrz67Yu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199021)(71200400001)(110136005)(54906003)(8676002)(8936002)(5660300002)(478600001)(4326008)(7696005)(64756008)(66556008)(66446008)(66476007)(76116006)(66946007)(316002)(41300700001)(38100700002)(122000001)(55016003)(186003)(53546011)(52536014)(7416002)(6506007)(26005)(9686003)(83380400001)(38070700005)(86362001)(2906002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXR4b2pVQmUrODdadUtFMGxDSWlQTzlEdmhya0poNG45SW5rS3htV1hqTnBY?=
 =?utf-8?B?U2R1TzNrbE11YnFHM29idi9BVHhaRlVwK2pzYlFFNldvVlhGaGsxa2hjTnFk?=
 =?utf-8?B?cVNYcnFmRFFiWTJMMWlxcjJEUFpYeUpuRGtLM1JrNkhXQ0N4Z1VBeXdIVGNm?=
 =?utf-8?B?MnRPYWx1R0lhMExGTlNleC8yWmpaMTlKN2dicDFXd25Obk1qU0xHaVFGcEgv?=
 =?utf-8?B?MGRxUkR1clhtYXhzQ0pzMW1WaURneGtwY2RTMXNHcUNkWFhXM0h0MVk2TFFU?=
 =?utf-8?B?MW5CTXRzeEFFRFRGcXU5TzdpalBDbnlQSUhjUUNLcUtrMFY2M2VNV01QN3pB?=
 =?utf-8?B?YnNyYzJ6aGZpSTJIeTBNaFlSRHM4VlhmcHN3RTh6d3d0SXd6V0NpbVRoQXN2?=
 =?utf-8?B?OFJhU2d6UVIyb2VIS2pQSnVNbG1pTXhCRDV4K0dlY3AyMWROMFRqUzRaWVBh?=
 =?utf-8?B?ZlB5bnNMMzZaT3JwejIvUVpDc3U0MEUwcW5qZEdUZkx5QWFTWGdEdkhrVnkv?=
 =?utf-8?B?TzFKeTN6blptRW0ybzdsb0ZnRXYwZVRDajFuSzFwbHJQMGs1OGhHTG9RTyt3?=
 =?utf-8?B?ZWUrcHR1NGdYMkRZVGx5c1JXaFRMeFhiNEYzcmIyeHZWUlVVakNxbEVZYW9B?=
 =?utf-8?B?cnBIZldkdGZFUzc2dzI5WURmVEFrR1pYSlRkc3A2SDRkY3VVWEtuYkZqa2tT?=
 =?utf-8?B?KzAzVW5pYzdtRStLczd4SkFTak9zWS9aWWlVVVlPbTlXRWl5WnYvNzFLZ2dC?=
 =?utf-8?B?UXlIZXZhWFc2d2tKdHl1dWwzdjcwcFkvaHN2c3RFREhpYXBRYUlnZzZXY1pV?=
 =?utf-8?B?RlVwcXZwZjBBeXRIUE1aVXRLQURDK1FObHhnRTdtbXp0YVpvVkhGYmFoOGNJ?=
 =?utf-8?B?SzhOenJNbFR4aHQyVUZCZk5xZ0owU2xETC9EUDZ0cHcvYlZZejFuSGdsaXpV?=
 =?utf-8?B?ckoxaUgyTEtIS29BajZBRFlEV08zaHBVUm1Za04renNLaldYa0ZuQksrQWV6?=
 =?utf-8?B?V3dqWTV6b1h4cWxxQjJUbGVzZkkyK3dqem5oalo2TEJGWU9LSnEweXA4Szlx?=
 =?utf-8?B?RDI1NnJleGgzN3IxcXdzbnllREFxM253czdyZitpSUkvUGFjc3VRTkpWd3Fk?=
 =?utf-8?B?UWxxZ0pueU10dkc5R0U0aHBsUXFvb05Xc29XN2M4dE1sYVNHRG9Pa1NFdWNr?=
 =?utf-8?B?allPb1BXWENyOG03RHl6Vk1SQ2tKdGI5a1FjT3dNWnJSb2g3OEVOb2FIWUhi?=
 =?utf-8?B?ZjhSY2hNcEdhNEsyVmFuN2x3WkgzakowRGZ5UEd5OVZhbEV3UklwOW1hK0pm?=
 =?utf-8?B?VmU1MHdFSlNpYXhHTkJFcmRRYVVCaUZZZmhCQlk5b0djLzNyMmExWkFZVG9W?=
 =?utf-8?B?cDUra0U5WUJST1ZPOC9vSjNwMWZuZlNocElEL24wQ1NDZGJVR2xBdTJjTzBH?=
 =?utf-8?B?Rk9VNUtLZFdDdHZubyswSFppTTlWVzhKV081VU8vY05qL3hHRXMxM0thQkVm?=
 =?utf-8?B?VXdsazd6QWRQTEdVWUttanNOaHU5N2tXYnhSYngwUDhoME9rdTNhQkZxcm93?=
 =?utf-8?B?SG5haFJrTVBvSTBwWDJJejlRUXVmUFEvTlZHNEtuOUlwUU1kS0VFaVJoMWxV?=
 =?utf-8?B?bWtKNTRmazVqT0RHRU1ISExqMHRkdjV0S2pLeWVrcjdaazdEY3JSSzk0Y3Ra?=
 =?utf-8?B?WW9mRVBURVk5SlNTWURNbzhJT3BwaGZkN2k1d3BONmlqclQyejRhTng1bjd6?=
 =?utf-8?B?TTRoOHFjcXN3RVIwTmxjWXZtTVExWGNsNzNCZEJBaUZXcXowbkNGWHBrMVdt?=
 =?utf-8?B?VTF5eHNrclBaQi9wa3V4TnRMMDRiWlRIWTVWRnRmZ3cvMHBwOTk4bFpRS1pp?=
 =?utf-8?B?MkduNjlOL1hNYU1mRlF3dUM1cUwyeFUvOVcvd1puK05xbThhQWV2RGJieVEx?=
 =?utf-8?B?RENESWtnS21FdkJWd0NLTURrZG9DdFFCNFlySHdhMHZFZXVTbjliU0I2Zzc0?=
 =?utf-8?B?UWFseHl5OTlGZnE2Q2RLaFRNdUhQeWQ4WmY0SlpBd2dvN0lxdVNEczdiSVVh?=
 =?utf-8?B?cFRjTkRkWEZabGVnU1pWYUduakxMQkNWV2F3ZnZZNzFLWVRSOU85ckNKOWhD?=
 =?utf-8?Q?6eo4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3496e67-3dd1-462f-f824-08db795919e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 10:59:39.6113
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TsQDr/OtcLYHW6ecwVpONu180jzphsr0iYhjbxeX8ufjnRAv7d2wJ8+yST75LVyieA9qawwFiKwuEMBKDgniMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gVHVkb3IsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVHVk
b3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BsaW5hcm8ub3JnPg0KPiBTZW50OiBGcmlkYXksIEp1
bmUgMzAsIDIwMjMgMjoxOCBQTQ0KPiBUbzogTWljaGFlbCBXYWxsZSA8bWljaGFlbEB3YWxsZS5j
Yz47IE1haGFwYXRyYSwgQW1pdCBLdW1hcg0KPiA8YW1pdC5rdW1hci1tYWhhcGF0cmFAYW1kLmNv
bT4NCj4gQ2M6IHByYXR5dXNoQGtlcm5lbC5vcmc7IG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb207
IHJpY2hhcmRAbm9kLmF0Ow0KPiB2aWduZXNockB0aS5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsg
a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOw0KPiBjb25vcitkdEBrZXJuZWwub3Jn
OyBnaXQgKEFNRC1YaWxpbngpIDxnaXRAYW1kLmNvbT47IGxpbnV4LQ0KPiBtdGRAbGlzdHMuaW5m
cmFkZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBhbWl0cmtjaWFuMjAwMkBnbWFpbC5jb20NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2MyAyLzJdIG10ZDogc3BpLW5vcjogQXZvaWQgc2V0dGluZyBTUldEIGJpdCBpbiBT
UiBpZiBXUCMNCj4gc2lnbmFsIG5vdCBjb25uZWN0ZWQNCj4gDQo+IA0KPiANCj4gT24gNi8yNy8y
MyAwNzoxNCwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gPiBBbSAyMDIzLTA2LTI1IDEyOjAyLCBz
Y2hyaWViIEFtaXQgS3VtYXIgTWFoYXBhdHJhOg0KPiA+PiBTZXR0aW5nIHRoZSBzdGF0dXMgcmVn
aXN0ZXIgd3JpdGUgZGlzYWJsZSAoU1JXRCkgYml0IGluIHRoZSBzdGF0dXMNCj4gPj4gcmVnaXN0
ZXIgKFNSKSB3aXRoIFdQIyBzaWduYWwgb2YgdGhlIGZsYXNoIGxlZnQgZmxvYXRpbmcgb3Igd3Jv
bmdseQ0KPiA+PiB0aWVkIHRvIEdORCAodGhhdCBpbmNsdWRlcyBpbnRlcm5hbCBwdWxsLWRvd25z
KSwgd2lsbCBjb25maWd1cmUgdGhlDQo+ID4+IFNSIHBlcm1hbmVudGx5IGFzIHJlYWQtb25seS4g
SWYgV1AjIHNpZ25hbCBpcyBsZWZ0IGZsb2F0aW5nIG9yDQo+ID4+IHdyb25nbHkgdGllZCB0byBH
TkQsIGF2b2lkIHNldHRpbmcgU1JXRCBiaXQgd2hpbGUgd3JpdGluZyB0aGUgU1IgZHVyaW5nDQo+
IGZsYXNoIHByb3RlY3Rpb24uDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEFtaXQgS3VtYXIg
TWFoYXBhdHJhIDxhbWl0Lmt1bWFyLQ0KPiBtYWhhcGF0cmFAYW1kLmNvbT4NCj4gPj4gLS0tDQo+
ID4+IMKgZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMgfCAzICsrKw0KPiA+PiDCoGRyaXZlcnMv
bXRkL3NwaS1ub3IvY29yZS5oIHwgMSArDQo+ID4+IMKgZHJpdmVycy9tdGQvc3BpLW5vci9zd3Au
Y8KgIHwgOSArKysrKysrLS0NCj4gPj4gwqAzIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9z
cGktbm9yL2NvcmUuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+ID4+IGluZGV4IDBi
YjBhZDE0YTJmYy4uNTIwZjVhYjg2ZDJiIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL210ZC9z
cGktbm9yL2NvcmUuYw0KPiA+PiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiA+
PiBAQCAtMjg2NCw2ICsyODY0LDkgQEAgc3RhdGljIHZvaWQgc3BpX25vcl9pbml0X2ZsYWdzKHN0
cnVjdCBzcGlfbm9yDQo+ID4+ICpub3IpDQo+ID4+IMKgwqDCoMKgIGlmIChmbGFncyAmIE5PX0NI
SVBfRVJBU0UpDQo+ID4+IMKgwqDCoMKgwqDCoMKgwqAgbm9yLT5mbGFncyB8PSBTTk9SX0ZfTk9f
T1BfQ0hJUF9FUkFTRTsNCj4gPj4NCj4gPj4gK8KgwqDCoCBpZiAob2ZfcHJvcGVydHlfcmVhZF9i
b29sKG5wLCAibm8td3AiKSkNCj4gPj4gK8KgwqDCoMKgwqDCoMKgIG5vci0+ZmxhZ3MgfD0gU05P
Ul9GX05PX1dQOw0KPiA+PiArDQo+ID4NCj4gPiBQbGVhc2UgcHV0IGl0IGJlbG93IHRoZSBvZl9w
cm9wZXJ0eV9yZWFkX2Jvb2woKSB3aGljaCBpcyBhbHJlYWR5DQo+ID4gdGhlcmUsIGp1c3QgdG8g
a2VlcCB0aGluZ3Mgc29ydGVkLg0KPiA+DQo+ID4+IMKgwqDCoMKgIGlmIChmbGFncyAmIFNQSV9O
T1JfUldXICYmIG5vci0+aW5mby0+bl9iYW5rcyA+IDEgJiYNCj4gPj4gwqDCoMKgwqDCoMKgwqDC
oCAhbm9yLT5jb250cm9sbGVyX29wcykNCj4gPj4gwqDCoMKgwqDCoMKgwqDCoCBub3ItPmZsYWdz
IHw9IFNOT1JfRl9SV1c7DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2Nv
cmUuaCBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oDQo+ID4+IGluZGV4IDRmYjVmZjA5YzYz
YS4uNTViNWU3YWJjZTZlIDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL2Nv
cmUuaA0KPiA+PiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaA0KPiA+PiBAQCAtMTMy
LDYgKzEzMiw3IEBAIGVudW0gc3BpX25vcl9vcHRpb25fZmxhZ3Mgew0KPiA+PiDCoMKgwqDCoCBT
Tk9SX0ZfU1dQX0lTX1ZPTEFUSUxFwqDCoMKgID0gQklUKDEzKSwNCj4gPj4gwqDCoMKgwqAgU05P
Ul9GX1JXV8KgwqDCoMKgwqDCoMKgID0gQklUKDE0KSwNCj4gPj4gwqDCoMKgwqAgU05PUl9GX0VD
Q8KgwqDCoMKgwqDCoMKgID0gQklUKDE1KSwNCj4gPj4gK8KgwqDCoCBTTk9SX0ZfTk9fV1DCoMKg
wqDCoMKgwqDCoCA9IEJJVCgxNiksDQo+ID4NCj4gPiBTZWUgdGhlIGNvbW1lbnQgcmlnaHQgYWJv
dmUgdGhpcyBlbnVtIDovDQo+ID4NCj4gPj4gwqB9Ow0KPiA+Pg0KPiA+PiDCoHN0cnVjdCBzcGlf
bm9yX3JlYWRfY29tbWFuZCB7DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9y
L3N3cC5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9zd3AuYw0KPiA+PiBpbmRleCAwYmE3MTZlODQz
NzcuLmNmYWJhNDFkNzRkNiAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9z
d3AuYw0KPiA+PiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL3N3cC5jDQo+ID4+IEBAIC0yMTQs
OCArMjE0LDEzIEBAIHN0YXRpYyBpbnQgc3BpX25vcl9zcl9sb2NrKHN0cnVjdCBzcGlfbm9yICpu
b3IsDQo+ID4+IGxvZmZfdCBvZnMsIHVpbnQ2NF90IGxlbikNCj4gPj4NCj4gPj4gwqDCoMKgwqAg
c3RhdHVzX25ldyA9IChzdGF0dXNfb2xkICYgfm1hc2sgJiB+dGJfbWFzaykgfCB2YWw7DQo+ID4+
DQo+ID4+IC3CoMKgwqAgLyogRGlzYWxsb3cgZnVydGhlciB3cml0ZXMgaWYgV1AgcGluIGlzIGFz
c2VydGVkICovDQo+ID4+IC3CoMKgwqAgc3RhdHVzX25ldyB8PSBTUl9TUldEOw0KPiA+PiArwqDC
oMKgIC8qDQo+ID4+ICvCoMKgwqDCoCAqIERpc2FsbG93IGZ1cnRoZXIgd3JpdGVzIGlmIFdQIyBw
aW4gaXMgbmVpdGhlciBsZWZ0IGZsb2F0aW5nDQo+ID4+ICtub3INCj4gPj4gK8KgwqDCoMKgICog
d3JvbmdseSB0aWVkIHRvIEdORCh0aGF0IGluY2x1ZGVzIGludGVybmFsIHB1bGwtZG93bnMpLg0K
PiA+DQo+ID4gbml0OiBzcGFjZSBtaXNzaW5nDQo+ID4NCj4gPiBPdGhlcndpc2UgbG9va3MgZ29v
ZC4NCj4gPg0KPiANCj4gVGhhbmtzLCBNaWNoYWVsLg0KPiANCj4gQW1pdCwgd291bGQgYmUgZ29v
ZCBpZiB5b3UgY2FuIGFkZHJlc3MgTWljaGFlbCdzIGNvbW1lbnRzIGFuZCByZXN1Ym1pdC4gSWYN
Cj4gbm90LCBJJ2xsIGFtZW5kIHRoZSBwYXRjaCBieSBteXNlbGYgd2hlbiBhcHBseWluZy4NCg0K
SSB3aWxsIGFkZHJlc3MgTWljaGFlbCdzIGNvbW1lbnRzIGFuZCBzZW5kIHRoZSBuZXh0IHNlcmll
cy4NCg0KUmVnYXJkcywNCkFtaXQNCj4gDQo+IENoZWVycywNCj4gdGENCg==
