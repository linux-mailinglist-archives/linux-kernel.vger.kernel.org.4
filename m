Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1623D6A8B55
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 22:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCBV50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 16:57:26 -0500
Received: from mail-sn1nam02on2076.outbound.protection.outlook.com ([40.107.96.76]:7431
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229997AbjCBV4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 16:56:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMmLibK1vetVlxB06G8wDtqkftVKoc0S5zpq62n7PLeVG0MNfcLEY/0Q4dnI0DcQ9bqcMXDkdiS6HNfnCIJ0Kj/D+WGNUcQyJGJrsqKLY3fwg0JU5rKmdVrqdlU/623bBfzjnoSbCfdO7LuAVgVP09dp/8zRF2dbhxzufGJVJOZNSPEl/r9X7HXG6PrmPyekqo7xv/c6IIQAWfsljCnTRiK6sQNq0EKUdvdku7YeRyml4oWTsIbGXbkyM5x8cm+uMWxYHUYHfg24yG2bJGOZq866ZtNqcvcvac5Ok4z2HQdstwxMPRtitCi98ZeD9FKlb5qqbButbZV3OGuCePX0Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w47Tdt9kSa7LA6xwf2NtMY+EqbvQ1cY9uZANT4Hc6nk=;
 b=VLEGf2rbjaz3Y74HiUeGNZWsxFi9y+NOdt2ByF8xUW96OgL3J4EOMTVUNRyhl4Z+7rxNgTmnVLb4QSTZEpoGyQWp1OPjGEJ0mfN2QQ5Nq2ovIfg4kMl3AJ5cBc5rJBP2H+EARC2FL6AosvmvCFgwT8noUhc77/RIPYJ/9z2pXrOVAFKAwnbepAgQFXva249cENhaEslYQVH8yr/Q5PO0jVTOVclIHm/rJFvpspIZf49iRgrdW3FmQR4ayeq+Nw2hLujRCLZPD1PQz6QsHw49k2GnE13fbdkZyNAx1Ld+Xg+epjMzG/YX3CNobWFkJPDF8vZjSLGUE/oeY3qO2jBdWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w47Tdt9kSa7LA6xwf2NtMY+EqbvQ1cY9uZANT4Hc6nk=;
 b=SaGNcMxdaiE1BDV5btG2//sBOqwki+ALqGkXSnWAIaOfZF5K3i8s+EUw4IIsUyCoc9u79moSKS2EA9daPpWzeC1pWod5UA8mVS2RmsfpdEaYcmhyl3B1XXgw97fVrkuVlWz2VHJLeqyUv8WHVUC04f62T/EpZuelQGy+X7BdE38=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 21:55:18 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::a4e:62dd:d463:5614%7]) with mapi id 15.20.6156.018; Thu, 2 Mar 2023
 21:55:18 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        =?utf-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>,
        Grzegorz Bernacki <gjb@semihalf.com>,
        "Thomas, Rijo-john" <Rijo-john.Thomas@amd.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "Allen, John" <John.Allen@amd.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 7/9] crypto: ccp: Add support for ringing a platform
 doorbell
Thread-Topic: [PATCH v2 7/9] crypto: ccp: Add support for ringing a platform
 doorbell
Thread-Index: AQHZTT9AmFJfjSXPsUuvS34jJQ/xT67oB98AgAAALHA=
Date:   Thu, 2 Mar 2023 21:55:18 +0000
Message-ID: <MN0PR12MB6101D9EB99F5CDF24575E22EE2B29@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230302194235.1724-1-mario.limonciello@amd.com>
 <20230302194235.1724-8-mario.limonciello@amd.com>
 <b52c68e6-2501-67c8-1fbd-60a35537c1f2@amd.com>
In-Reply-To: <b52c68e6-2501-67c8-1fbd-60a35537c1f2@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-03-02T21:55:16Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=5a0c3234-e8f0-43d2-b22f-9f85adebd818;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2023-03-02T21:55:16Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 3ba5b253-7c2f-48a8-9513-99797a71c7d3
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|SN7PR12MB8129:EE_
x-ms-office365-filtering-correlation-id: 3ef5d3e1-bedf-4a2a-c25e-08db1b68cfe5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fG3a0JShdwSi9wrg8QUEp3tLIDpaJFI4Gu2Kz2VxvXnd7T8VK8M/ewfO1sLDxmLIm33sXTFF8gaVF52Xi/I6nvnUJ1VW3fQjZw/F8wFQaHMuRxmNQXXbL4WmNvsU2dXaoxPvOtxhn+EYAYPpq6LJen72SKOWp6DRv8w/Q6nW6tyTox4X+uzfn0C25G8lKUqOhhAl4qJOrFTY0OKPcnFAX9btRebJfuVnlByDuiMI/OdkkFnGjtoGmb518GBVl+Ml+JUbKG/sN2NfGbNpSaT6ghNOtRgDRXaCy/UazolY+0p3lM7OnVQTN29PoQqPGHXEuRQhHD4gqAVtL3NNMyfR5lwEtSbO2pK1VSad74O9QVfKYaGDHnT2urZWHdXqmh6qvc5Xn8p+u49k3+mAyQJxR9Z+JNZD+Z1JP16f+ppukql2a6nnbAFF8TKZFfFuzkT6+X8vYk0Nfx/25hXQL4SH2WnPfitpOcpp3wQhwcFfKEyxVWZxe5tiLBF9/1GM9kHO8qFXXQ6km9jrixqTYyvp/a+M0ZMIFVu81neZ1HcYJ4gVaSuE2Vq0F/GN6Jeb/Kes77IsPmteaBD3o8in14hPAIUQwVcG+10CbpfPbNUdNk0wlyxdHDcRu76iOl5uBAKuooUKkFKkmShKJPqfFXqi0cmZrBY/uRPjubd2G/urFbxEyfZA3DSDjemFmI95p7PV1JJl9sZzGkaw4PPd2/gW+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(451199018)(66556008)(83380400001)(122000001)(66574015)(26005)(8936002)(5660300002)(52536014)(478600001)(86362001)(66476007)(38070700005)(55016003)(38100700002)(33656002)(186003)(9686003)(6506007)(53546011)(71200400001)(966005)(2906002)(66446008)(8676002)(76116006)(66946007)(64756008)(7696005)(41300700001)(316002)(110136005)(6636002)(54906003)(4326008)(134885004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkVKbE9kL2ZVcnVuSTdoYjZ0S0s1TWl5dnkyemo3MllVakJxdkFiZWlyenNz?=
 =?utf-8?B?UUYySGpNU1E2V3RVQzdjSEVhU3B6b1RYSVpTblBrbG5XZTQzV3pXSXg3OHBF?=
 =?utf-8?B?NnZ0ZDY2V1d4QkpGZmRDbnB2aUFkYlVQdmo2QkovRExJSVRndFZoeVU5ODFR?=
 =?utf-8?B?RnVCR2tqSUNURXNBOE9ZczhxeXRaM0JBcWZCMEJFNW1ZWWhma3ZWVXByeVVV?=
 =?utf-8?B?WVV5NkNvbDBLdjJwczdqMHllN1B5eGhHSWp4c2k0RUZWUFJkdzR3L3NhWjdV?=
 =?utf-8?B?THdTa3Z0SnVmLzF4WGp5OXAxRkh0QlczRjkza3NVNEMxNzg3RW16N01IUTc1?=
 =?utf-8?B?UEdmM2YwL0pqUk1keUJxbUo5VGUybjBSclI3NzNkZkQrODM2bjFuZkZ3a3Rx?=
 =?utf-8?B?YVlPODBucjJPZVpHbFJpaFNjNkpiQW5LY21jQjc0OE5iMGU5TklqTGR6a1p6?=
 =?utf-8?B?RWpZTEJZK1BVNVA4ZEkzejREUFk4MkVQTUVxN1M2ekUrak1udzI2a2Z1aGY3?=
 =?utf-8?B?ZStDS2pyL2JMTU1tOU1TL054RU45aDVRdDR1cUg4TUhZNXNtc1I3a1NYclFD?=
 =?utf-8?B?WFV3K2k1UndSRTZFWE1mcmNwdWd5TXVRQW5oMUNpSWN4TGFqdVhJWk8xWllF?=
 =?utf-8?B?YVNoZ25rSGphS3FLVmg0WXdWRDRiUVcyOHVqbDg4QW5icVJIalhmYXhURzY0?=
 =?utf-8?B?Z0QydU5NRDVaVEZrNjJvNFFOUDM4bk80aDVZU2svSWFOeWp2L3NuLzE3MzlO?=
 =?utf-8?B?bFF3c3NoY2xxbG13RTExcE1wRFQrMThXSkVzK3N1S0E0MjJUNm9tTy9HZFRl?=
 =?utf-8?B?R1M5bXFDM3MwQXRMTTlGYkc1YTAvRzU0YXh0aVZJN3VjT2FqT3VBU0diakdD?=
 =?utf-8?B?SHBHWk9yc0hiNGpnSjNEWnE0L1Y2QWoxanhaeWpWK25GRE93Q3hMN3FNQ2t4?=
 =?utf-8?B?bVZzMWhFL2ZseHJ2ZEdPRzZGUC8zZVZUYXF4Q1BxMzFoSEpPSHhTNGMyNjhz?=
 =?utf-8?B?ZDVmWm1DREVWRFNoK0FFZkFQK3hwbXVCUm9yZW5LV0VBYnJoSHJDanVjYkUr?=
 =?utf-8?B?K3VheGp4ZUVsU3dTY25VbSsycWIwMHM4cTZPd1MyVE51MTBTaUdON05tekZ3?=
 =?utf-8?B?SUxwam9MS2xSY0lXZGMwZTFXNWcweUVuRU16UTczaVBhTnFXNnlRT3NBcVFs?=
 =?utf-8?B?cms4Y3ZSTlRXZGVUcytHWXYrVTFGNWxGSmVSZS9KMFljVUZrM1dFZXRDb3dD?=
 =?utf-8?B?K1A5YXQ3aEhmaSt4RkdRcUVBcURVS1BtVS9jZy9mMHZBUWdMSHBMdVh2RHZ2?=
 =?utf-8?B?QzUwODdDbXJRVUE4ejI1OG5HdTVqeHAveUNFRWluZ0JWRFJoeHRnWFRaWEJP?=
 =?utf-8?B?V1EvOFRTQzRqWjJveFllZmhESUdjV0tHSGQza3h0czROL3ZJQWlQUjd0RjR2?=
 =?utf-8?B?c1lVOHVrN3lLZjRPczFPcVFXZllZWkdwaUpMM0F1NXhzbWJ4clM3VnRweU80?=
 =?utf-8?B?eXdhSk8ySzU3N2RJd1ArV0I4dThsbTI5YU9DMXdlVDBYNGlmUnQydnUwMDBy?=
 =?utf-8?B?Y1JXTWl2YVpuQW11bVJHKzNFSUhoRE5KUmZWMmoxWGd0YWxwbjBxR1hqRmhl?=
 =?utf-8?B?TE9HNDArdXg5ZkFxbnFqczIvTnZabldPYnA4YWpVV1ZpZWhWSkYxekV5NU5G?=
 =?utf-8?B?MkNGTGMrT1g4bG9CYTNuUGFoVmJGQWpBcUFqMFozOHVmdzU1Ukp4WElEUms0?=
 =?utf-8?B?RVQrZkJFR0FydDN2cUxDZmovbXA3ZlgyWjh5aTZGaTJSRTFUbG1tMFBFUGl3?=
 =?utf-8?B?ckJVa0tMcWRaMnN5NUovRjQ4c1ZoSTE3U1BZNWUwS3JIZng5ajhqc1ZoQ1lx?=
 =?utf-8?B?YlgvMjhxemU5bDV6WldMV0UvL3NJaHFIQXpicGxtbUdrMEZaNUZzR2hrdzNK?=
 =?utf-8?B?WmpWWGVPM20xaFEzY3k3Nkpod3owdVRLNGp6YUxYU29meExmRFZoQW9rWEpt?=
 =?utf-8?B?S2RNT28xK3o1K3IvMmNQZHZuOTBKNElGbU9lR1F4MmdIa1hycWkraHFnSVN1?=
 =?utf-8?B?bkl2K3BqVjJJUW5QV21DYWpGS0tHQ2dRTnNtY2w1KzArUVc4Y3FlZE16ejUw?=
 =?utf-8?Q?myD0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef5d3e1-bedf-4a2a-c25e-08db1b68cfe5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 21:55:18.1078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S67/Ca9Z/3nhML+Dg6N1w00D+PzmigmrdbtdLfRU8AuZocmFcyu4VVQhbYFCR9kDxiDkVj5Ca6033wgtOibHjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGVu
ZGFja3ksIFRob21hcyA8VGhvbWFzLkxlbmRhY2t5QGFtZC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5
LCBNYXJjaCAyLCAyMDIzIDE1OjUyDQo+IFRvOiBMaW1vbmNpZWxsbywgTWFyaW8gPE1hcmlvLkxp
bW9uY2llbGxvQGFtZC5jb20+OyBKYW4gRMSFYnJvxZsNCj4gPGpzZEBzZW1paGFsZi5jb20+OyBH
cnplZ29yeiBCZXJuYWNraSA8Z2piQHNlbWloYWxmLmNvbT47IFRob21hcywgUmlqby0NCj4gam9o
biA8Umlqby1qb2huLlRob21hc0BhbWQuY29tPjsgaGVyYmVydEBnb25kb3IuYXBhbmEub3JnLmF1
OyBBbGxlbiwNCj4gSm9obiA8Sm9obi5BbGxlbkBhbWQuY29tPg0KPiBDYzogRGF2aWQgUy4gTWls
bGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgbGludXgtY3J5cHRvQHZnZXIua2VybmVsLm9yZzsN
Cj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYy
IDcvOV0gY3J5cHRvOiBjY3A6IEFkZCBzdXBwb3J0IGZvciByaW5naW5nIGEgcGxhdGZvcm0NCj4g
ZG9vcmJlbGwNCj4gDQo+IE9uIDMvMi8yMyAxMzo0MiwgTWFyaW8gTGltb25jaWVsbG8gd3JvdGU6
DQo+ID4gU29tZSBwbGF0Zm9ybXMgc3VwcG9ydCB1c2luZyBhIGRvb3JiZWxsIHRvIGNvbW11bmlj
YXRlLiBFeHBvcnQNCj4gPiB0aGlzIGZlYXR1cmUgZm9yIG90aGVyIGRyaXZlcnMgdG8gdXRpbGl6
ZSBhcyB3ZWxsLg0KPiA+DQo+ID4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
aTJjLzIwMjIwOTE2MTMxODU0LjY4NzM3MS0zLQ0KPiBqc2RAc2VtaWhhbGYuY29tLw0KPiA+IFN1
Z2dlc3RlZC1ieTogSmFuIERhYnJvcyA8anNkQHNlbWloYWxmLmNvbT4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCj4gPiAt
LS0NCj4gPiB2MS0+djI6DQo+ID4gICAqIE5ldyBwYXRjaA0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVy
cy9jcnlwdG8vY2NwL3BsYXRmb3JtLWFjY2Vzcy5jIHwgNDcNCj4gKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPiA+ICAgZHJpdmVycy9jcnlwdG8vY2NwL3NwLWRldi5oICAgICAgICAgIHwg
IDEgKw0KPiA+ICAgaW5jbHVkZS9saW51eC9wc3AtcGxhdGZvcm0tYWNjZXNzLmggIHwgMTUgKysr
KysrKysrDQo+ID4gICBpbmNsdWRlL2xpbnV4L3BzcC5oICAgICAgICAgICAgICAgICAgfCAgMyAr
Kw0KPiA+ICAgNCBmaWxlcyBjaGFuZ2VkLCA2NiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9jcnlwdG8vY2NwL3BsYXRmb3JtLWFjY2Vzcy5jDQo+IGIvZHJpdmVy
cy9jcnlwdG8vY2NwL3BsYXRmb3JtLWFjY2Vzcy5jDQo+ID4gaW5kZXggYWYzYTFlOTdhYmZlLi4w
NzYzMzg5YTI4MTQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jcnlwdG8vY2NwL3BsYXRmb3Jt
LWFjY2Vzcy5jDQo+ID4gKysrIGIvZHJpdmVycy9jcnlwdG8vY2NwL3BsYXRmb3JtLWFjY2Vzcy5j
DQo+ID4gQEAgLTEzNSw2ICsxMzUsNTMgQEAgaW50IHBzcF9zZW5kX3BsYXRmb3JtX2FjY2Vzc19t
c2coZW51bQ0KPiBwc3BfcGxhdGZvcm1fYWNjZXNzX21zZyBtc2csDQo+ID4gICB9DQo+ID4gICBF
WFBPUlRfU1lNQk9MX0dQTChwc3Bfc2VuZF9wbGF0Zm9ybV9hY2Nlc3NfbXNnKTsNCj4gPg0KPiA+
ICtpbnQgcHNwX3JpbmdfcGxhdGZvcm1fZG9vcmJlbGwoZW51bSBwc3BfcGxhdGZvcm1fYWNjZXNz
X21zZyBtc2cpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBwc3BfZGV2aWNlICpwc3AgPSBwc3BfZ2V0
X21hc3Rlcl9kZXZpY2UoKTsNCj4gPiArCXN0cnVjdCBwc3BfcGxhdGZvcm1fYWNjZXNzX2Rldmlj
ZSAqcGFfZGV2Ow0KPiA+ICsJdTMyIF9faW9tZW0gKmRyYmw7DQo+ID4gKwl1MzIgZHJibF9yZWc7
DQo+IA0KPiBMZXRzIHNwZWxsIG91dCBkb29yYmVsbCBmb3IgdGhlc2UgdHdvIHZhcmlhYmxlIG5h
bWVzLg0KDQpBY2suICBHaXZlbiBkcmJsX3JlZyBpcyBvbmx5IHVzZWQgb25lIHBsYWNlLCBJIG1p
Z2h0IGp1c3QgZHJvcCBpdCB0b28uDQoNCj4gDQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiAr
CWlmICghcHNwIHx8ICFwc3AtPnBsYXRmb3JtX2FjY2Vzc19kYXRhKQ0KPiA+ICsJCXJldHVybiAt
RU5PREVWOw0KPiA+ICsNCj4gPiArCXBhX2RldiA9IHBzcC0+cGxhdGZvcm1fYWNjZXNzX2RhdGE7
DQo+ID4gKwlkcmJsID0gcHNwLT5pb19yZWdzICsgcGFfZGV2LT52ZGF0YS0+ZG9vcmJlbGxfcmVn
Ow0KPiA+ICsNCj4gPiArCWlmICghZHJibCkNCj4gPiArCQlyZXR1cm4gLUVOT0RFVjsNCj4gDQo+
IFRoaXMgd2lsbCBiZSBub24temVybyBiZWNhdXNlIHBzcC0+aW9fcmVncyB3aWxsIGFsd2F5cyBi
ZSBub24temVyby4gTWF5YmUNCj4geW91IG1lYW50IHRvIGNoZWNrIHRoZSBhY3R1YWwgcGFfZGV2
LT52ZGF0YS0+ZG9vcmJlbGxfcmVnIHZhbHVlPw0KPiANCj4gSSB0aGluayB5b3Ugc2hvdWxkIHNx
dWFzaCB0aGlzIGFuZCBwYXRjaCAjOSB0b2dldGhlciBzbyB0aGF0IHBhdGNoICM4IGp1c3QNCj4g
d29ya3MgcmlnaHQgYXdheS4NCg0KQWNrLCBJJ2xsIHNxdWFzaCB0aGVtIHRvZ2V0aGVyLg0KDQo+
IA0KPiA+ICsNCj4gPiArCW11dGV4X2xvY2soJnBhX2Rldi0+bXV0ZXgpOw0KPiANCj4gRG9lcyB0
aGUgZG9vcmJlbGwgcmVnaXN0ZXIgb3BlcmF0ZSBpbmRlcGVuZGVudGx5IGZyb20gdGhlIG90aGVy
IHJlZ2lzdGVycw0KPiAoQzJQTVNHXzI4IC0gQzJQTVNHXzMwKT8gSWYgaXQgZG9lcywgeW91IGNv
dWxkIHByb2JhYmx5IGp1c3QgaW50cm9kdWNlIGENCj4gZG9vcmJlbGwgbXV0ZXguDQoNCkl0IGRv
ZXMgd29yayBpbmRlcGVuZGVudGx5LiAgSSdsbCBhZGQgYSBzZWNvbmQgbXV0ZXguDQoNCj4gDQo+
ID4gKw0KPiA+ICsJaWYgKGNoZWNrX3JlY292ZXJ5KGRyYmwpKSB7DQo+ID4gKwkJZGV2X2RiZyhw
c3AtPmRldiwgImluIHJlY292ZXJ5XG4iKTsNCj4gDQo+IE1heWJlIGEgYml0IG1vcmUgaW5mbyBh
cyB0byB3aGF0IGlzICJpbiByZWNvdmVyeSIgKHRoYXQgZ29lcyBmb3IgcGF0Y2ggIzQsDQo+IHRv
bykgb3IganVzdCBwcmVmaXggaXQgd2l0aCAiZG9vcmJlbGwiIChhbmQgInBsYXRmb3JtIiBpbiAj
NCkgc2luY2UgeW91DQo+IG5vdyBoYXZlIGR1cGxpY2F0ZWQgbWVzc2FnZXMuDQoNCldpbGwgYWRk
IHByZWZpeGVzIHRvIG1ha2UgdW5pcXVlIG1lc3NhZ2VzLg0KDQo+IA0KPiA+ICsJCXJldCA9IC1F
QlVTWTsNCj4gPiArCQlnb3RvIHVubG9jazsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlpZiAod2Fp
dF9jbWQoZHJibCkpIHsNCj4gPiArCQlkZXZfZGJnKHBzcC0+ZGV2LCAibm90IGRvbmUgcHJvY2Vz
c2luZyBjb21tYW5kXG4iKTsNCj4gDQo+IERpdHRvLg0KPiANCj4gVGhhbmtzLA0KPiBUb20NCg0K
VGhhbmtzIGZvciB0aGUgbmV3IGNvbW1lbnRzLg0KDQpJJ2xsIHdhaXQgb24gSmFuIGFuZCBHcnpl
Z29yeiB0byBjb25maXJtIHdoZXRoZXIgdGhlIG5ldyBkb29yYmVsbCBzdHVmZiB3b3Jrcw0Kb24g
U2t5cmltIG9yIG5vdCB0byBzcGluIGEgdjMuDQoNCj4gDQo+ID4gKwkJcmV0ID0gLUVCVVNZOw0K
PiA+ICsJCWdvdG8gdW5sb2NrOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWRyYmxfcmVnID0gRklF
TERfUFJFUChQU1BfRFJCTF9NU0csIG1zZykgfCBQU1BfRFJCTF9SSU5HOw0KPiA+ICsJaW93cml0
ZTMyKGRyYmxfcmVnLCBkcmJsKTsNCj4gPiArDQo+ID4gKwlpZiAod2FpdF9jbWQoZHJibCkpIHsN
Cj4gPiArCQlyZXQgPSAtRVRJTUVET1VUOw0KPiA+ICsJCWdvdG8gdW5sb2NrOw0KPiA+ICsJfQ0K
PiA+ICsNCj4gPiArCXJldCA9IDA7DQo+ID4gK3VubG9jazoNCj4gPiArCW11dGV4X3VubG9jaygm
cGFfZGV2LT5tdXRleCk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHJldDsNCj4gPiArfQ0KPiA+ICtF
WFBPUlRfU1lNQk9MX0dQTChwc3BfcmluZ19wbGF0Zm9ybV9kb29yYmVsbCk7DQo+ID4gKw0KPiA+
ICAgdm9pZCBwbGF0Zm9ybV9hY2Nlc3NfZGV2X2Rlc3Ryb3koc3RydWN0IHBzcF9kZXZpY2UgKnBz
cCkNCj4gPiAgIHsNCj4gPiAgIAlzdHJ1Y3QgcHNwX3BsYXRmb3JtX2FjY2Vzc19kZXZpY2UgKnBh
X2RldiA9IHBzcC0NCj4gPnBsYXRmb3JtX2FjY2Vzc19kYXRhOw0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2NyeXB0by9jY3Avc3AtZGV2LmggYi9kcml2ZXJzL2NyeXB0by9jY3Avc3AtZGV2LmgN
Cj4gPiBpbmRleCA1ZWM2YzIxOWE3MzEuLjg3YzBiOTM1MGJjMiAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2NyeXB0by9jY3Avc3AtZGV2LmgNCj4gPiArKysgYi9kcml2ZXJzL2NyeXB0by9jY3Av
c3AtZGV2LmgNCj4gPiBAQCAtNTQsNiArNTQsNyBAQCBzdHJ1Y3QgdGVlX3ZkYXRhIHsNCj4gPiAg
IH07DQo+ID4NCj4gPiAgIHN0cnVjdCBwbGF0Zm9ybV9hY2Nlc3NfdmRhdGEgew0KPiA+ICsJY29u
c3QgdW5zaWduZWQgaW50IGRvb3JiZWxsX3JlZzsNCj4gPiAgIAljb25zdCB1bnNpZ25lZCBpbnQg
Y21kcmVzcF9yZWc7DQo+ID4gICAJY29uc3QgdW5zaWduZWQgaW50IGNtZGJ1ZmZfYWRkcl9sb19y
ZWc7DQo+ID4gICAJY29uc3QgdW5zaWduZWQgaW50IGNtZGJ1ZmZfYWRkcl9oaV9yZWc7DQo+ID4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvcHNwLXBsYXRmb3JtLWFjY2Vzcy5oIGIvaW5jbHVk
ZS9saW51eC9wc3AtDQo+IHBsYXRmb3JtLWFjY2Vzcy5oDQo+ID4gaW5kZXggZjVhMDNjZDExZjEw
Li4xZTFkMGUwNzdjZWMgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9wc3AtcGxhdGZv
cm0tYWNjZXNzLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3BzcC1wbGF0Zm9ybS1hY2Nlc3Mu
aA0KPiA+IEBAIC0zNSw2ICszNSwyMSBAQCBzdHJ1Y3QgcHNwX3JlcXVlc3Qgew0KPiA+ICAgICov
DQo+ID4gICBpbnQgcHNwX3NlbmRfcGxhdGZvcm1fYWNjZXNzX21zZyhlbnVtIHBzcF9wbGF0Zm9y
bV9hY2Nlc3NfbXNnLA0KPiBzdHJ1Y3QgcHNwX3JlcXVlc3QgKnJlcSk7DQo+ID4NCj4gPiArLyoq
DQo+ID4gKyAqIHBzcF9yaW5nX3BsYXRmb3JtX2Rvb3JiZWxsKCkgLSBSaW5nIHBsYXRmb3JtIGRv
b3JiZWxsDQo+ID4gKyAqDQo+ID4gKyAqIFRoaXMgZnVuY3Rpb24gaXMgaW50ZW5kZWQgdG8gYmUg
dXNlZCBieSBkcml2ZXJzIG91dHNpZGUgb2YgY2NwIHRvIHJpbmcgdGhlDQo+ID4gKyAqIHBsYXRm
b3JtIGRvb3JiZWxsIHdpdGggYSBtZXNzYWdlLg0KPiA+ICsgKg0KPiA+ICsgKiBSZXR1cm5zOg0K
PiA+ICsgKiAgMDogICAgICAgICAgIHN1Y2Nlc3MNCj4gPiArICogIC0lRUJVU1k6ICAgICBtYWls
Ym94IGluIHJlY292ZXJ5IG9yIGluIHVzZQ0KPiA+ICsgKiAgLSVFTk9ERVY6ICAgIGRyaXZlciBu
b3QgYm91bmQgd2l0aCBQU1AgZGV2aWNlDQo+ID4gKyAqICAtJUVUSU1FRE9VVDogcmVxdWVzdCB0
aW1lZCBvdXQNCj4gPiArICogIC0lRUlPOiAgICAgICB1bmtub3duIGVycm9yIChzZWUga2VybmVs
IGxvZykNCj4gPiArICovDQo+ID4gK2ludCBwc3BfcmluZ19wbGF0Zm9ybV9kb29yYmVsbChlbnVt
IHBzcF9wbGF0Zm9ybV9hY2Nlc3NfbXNnKTsNCj4gPiArDQo+ID4gICAvKioNCj4gPiAgICAqIHBz
cF9jaGVja19wbGF0Zm9ybV9hY2Nlc3Nfc3RhdHVzKCkgLSBDaGVja3Mgd2hldGhlciBwbGF0Zm9y
bQ0KPiBmZWF0dXJlcyBpcyByZWFkeQ0KPiA+ICAgICoNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9wc3AuaCBiL2luY2x1ZGUvbGludXgvcHNwLmgNCj4gPiBpbmRleCBkMzQyNDc5MGE3
MGUuLjkyZTYwYWVlZjIxZSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3BzcC5oDQo+
ID4gKysrIGIvaW5jbHVkZS9saW51eC9wc3AuaA0KPiA+IEBAIC0yMyw0ICsyMyw3IEBADQo+ID4g
ICAjZGVmaW5lIFBTUF9DTURSRVNQX1JFQ09WRVJZCUJJVCgzMCkNCj4gPiAgICNkZWZpbmUgUFNQ
X0NNRFJFU1BfUkVTUAlCSVQoMzEpDQo+ID4NCj4gPiArI2RlZmluZSBQU1BfRFJCTF9NU0cJCVBT
UF9DTURSRVNQX0NNRA0KPiA+ICsjZGVmaW5lIFBTUF9EUkJMX1JJTkcJCUJJVCgwKQ0KPiA+ICsN
Cj4gPiAgICNlbmRpZiAvKiBfX1BTUF9IICovDQo=
