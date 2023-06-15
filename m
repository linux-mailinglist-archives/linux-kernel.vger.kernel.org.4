Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC487317E4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344606AbjFOLv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345075AbjFOLut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:50:49 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on060d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::60d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB3D525B;
        Thu, 15 Jun 2023 04:46:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDjrpqLuHb62YzIrTGfiVaAJDrkcqz2DsHAiiI5LO8pZ4Q2ZvhGjTcUF9V2vr6ijDtZTJWFF1A3upNcvxKq2ZM7wP6jXFz7eUo6zco7/rGkYmD2KC6CREU5wHj1f7XeoXWKv+Pgw1bdIFja2Mkk+kgDcF+aVBg71f0d6+bOP1AgHBVyd8m1k+IPyxuFSkUnXhFy4dlRZzuooCoQVEdi91UXkHOGPr3Z5Uvhh3YtUMyeHgbYusM13pbwR0KGzfcqs94U8W803XORFvlhU65tJpH1AmZ8N5pZYvXRh+tPuHFH1OZQvf0LQLMh5OEBD/snL36/3m7RqK1F+R0m6yR7GJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q//0fWczqs56L72RAhL56PX8o3Zt26qh6GMI9Ib7YI0=;
 b=RRq67+6KcekaMbvHes6avO6OSTr0EGHAKO/5nnTC7E/v4UXbcV8eQb6L+QPxg3V/GJfYAtGUv+Bou6+WBeEMG9PeEmPN27A03/CJReVIvsJMDPSmmWUU0Wx9hfHDEPuzBo/HfbLZfbuQXCbdI6zUoBoOOrQ7bFwckCm1wexYjgPsXJPbYu+BiLRRGJK+Dz+gJVG4erC3qgmvYUIzV17Z46r3b/nkGhrO66owWuIm6ABjxvuY18xysqgnhNGgm+lhefrNakR2UQklUmuf5OLFdLI7ed043VD7xLmyHhrNIGPoMYATgvm4iY3CzDSBVvzgXKgRr7CYPRxgeCju6FfaTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q//0fWczqs56L72RAhL56PX8o3Zt26qh6GMI9Ib7YI0=;
 b=m6V46ksuaqYqlhKta7/iHZJ95MrzTGiBWJBTjQ7KhLh3Qff6ynuLYGISlcDztywvo/lkuo4nK7R/PXh7cBTNbMSdgM2mCBQVYEj/fRvcvjBYkuljhjvfpOVBL+nOr6k6zgOKMN1yVgmneflQf9HNbhbem75rja1sgzCy3rAXEo8=
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com (2603:10a6:208:11a::11)
 by AM7PR04MB7109.eurprd04.prod.outlook.com (2603:10a6:20b:117::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 11:46:10 +0000
Received: from AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::eb27:f73a:5829:ae0e]) by AM0PR04MB6004.eurprd04.prod.outlook.com
 ([fe80::eb27:f73a:5829:ae0e%4]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 11:46:10 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Victoria Milhoan (b42089)" <vicki.milhoan@freescale.com>,
        Dan Douglass <dan.douglass@nxp.com>,
        Vipul Kumar <vipul_kumar@mentor.com>
Subject: RE: [PATCH] crypto: caam - add a test for the RNG
Thread-Topic: [PATCH] crypto: caam - add a test for the RNG
Thread-Index: AQHZnQfyY+f6qHURvUWXf+wiKxYZlq+Lw90g
Date:   Thu, 15 Jun 2023 11:46:10 +0000
Message-ID: <AM0PR04MB600427DF880ECCA8C8814B30E75BA@AM0PR04MB6004.eurprd04.prod.outlook.com>
References: <20230612082842.1256507-1-meenakshi.aggarwal@nxp.com>
In-Reply-To: <20230612082842.1256507-1-meenakshi.aggarwal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB6004:EE_|AM7PR04MB7109:EE_
x-ms-office365-filtering-correlation-id: d5843321-d70f-4672-b756-08db6d961d10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pvheixri4RyI3g1ZdJk3aIjDincLRRV9y+rhrN7KsuhiHhZe3wsNuOoy+Z9Udm3DV+SuVW3XX5yAVvTJd0dCBWqf5C1DWy0CoYOVOczlWnziC9nEyelCfJVqtnBDcyJXVNvZsNKY3H0aDM/c8X/+cRTLXMNCqmr/YDUyj8NkAzgNyGlk/XevJW8X8bxNa8sMPXUR9s+CFJuGN/cin1iUFSuuQsmWMTGnYjq9GVvNS38YaU4q4VgLzG+CGdJGaNfJkkroC+mwPdT6I/VjLeKK1/PHSZleObXu9bVN8ZjNswuZuAlyoCZfm5b7aYrHh5Ajq6FZiCWQ65c9a46jTQRARYr8eeIH23XzC3SsJcKR3esib6bAxhbRPKjUT4jamB5nOO2+oMjMDxGjylygXkAm2xOCDgs4figF1XkCWi8WOm17qbWb6gWiDs122TbFlqrQmNjfEQthUzJF845rR4iIFH6RNClvqWa2tFbar3JPG1WAry2prgd2xUKdK3hCWF0QwwC3CnW6d4/kQq8xds3vO+y8RDNZA1xpVWCrCOW9xZPEBn/eWBi5u3k/Hlrmh/pEAnR2bvU0aK01uUEH8ibsxXKGELcpeSZ2n5IX2xZuKm4iK1QwneX9i1LlWZQMh94P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(451199021)(186003)(55016003)(7696005)(71200400001)(478600001)(52536014)(9686003)(26005)(53546011)(6506007)(55236004)(8676002)(41300700001)(8936002)(76116006)(316002)(5660300002)(4326008)(66446008)(66946007)(110136005)(64756008)(44832011)(54906003)(33656002)(38070700005)(66556008)(66476007)(122000001)(86362001)(2906002)(38100700002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wmc3bHFqcTZBaEcrNkQ5WGZsa2w1N2NmVzVyNytIRTdsSGxiSlNjU25UYVhG?=
 =?utf-8?B?bEp5aGp6T1UyZm9PQkpadXRoQ2hoUDl5aC9Mb0dWeGpUU0grT1M0Q25NWmg1?=
 =?utf-8?B?LzN5OEZUVDBFaDVOdnZSOUpWbTVVVXB5Tk1pTUtBYmdCNlFvQ2ZyTFBxd3lV?=
 =?utf-8?B?YWd1YXEwZGJCK2IzUTFZcXJlMWM2OVdhemVPQVlvcmpCcERvbzVTOUJQSER4?=
 =?utf-8?B?aHVJeERDbG0rUVplRnhZYWF1WDlnSXFpWjByZlFvY01yQ3Y0V2dDZWxFMnk1?=
 =?utf-8?B?NUhPUWNOMnBLT2dEdDNnQ0c5dUVKMHBiMytmVW84NGkyWU9ENks5YUMybmFu?=
 =?utf-8?B?Y1ZLUldQNWoydU9vUmpRT2xJQkRMQXo1MnVUS2s0bEk2U1dKdXlSTk9WZG9s?=
 =?utf-8?B?YVRHZWlTc2hZUDQ2NUJrcVpQT0NrMG54RG92OHVnQ21icXg5WUYzRWVmbXdJ?=
 =?utf-8?B?S1dyZ2lUZHViVlE2d3A2c1VTTjFYMHJTQ2JHV29HcXlaNFltMUs5SGtmOTJh?=
 =?utf-8?B?dm1uZUFyTFdPbE4rdVZtQlNneGx6clpxRHdtRGRaVWx0U3JaUGx4cm5ubVJC?=
 =?utf-8?B?b0RsWGJZOXMwcUErQTNCOVpFRHJUK2ludUNvYjdLK1djZWlDcGp5K21SbEls?=
 =?utf-8?B?b09uMyttL3IreVE1TjNEQ3FjTXZXYkgySGRnS216ZU9oY0wyT2NyVmljbENy?=
 =?utf-8?B?Sk1Id1NiOW5VV0JTK3BLWm9pZnIva291NHpMSmRCa0tBd1hXMEl0NUpCS3Fw?=
 =?utf-8?B?bE96LzZqak4rREZHVk1USGJMcDc4WGtJTzJnd1RwWFhydCtyV0F1SGtFalJ3?=
 =?utf-8?B?WUx2WUwrMmNGbmE1Uy9pS0N6RVFjNDF5N0NGYVpGeTh6a0Y3bTlpV0NjVm8r?=
 =?utf-8?B?RkQ5S3FBaEtkdkY4enVZbWJKaXFXWWhLTmlXbkk4bzlKUkNDcEFYbjkvNVNE?=
 =?utf-8?B?WlV6ZDcxVTlTY3laMUxmRWl5WVlMS1RZRVFiNC9pWWxRQnZtZktGMlJGbHNt?=
 =?utf-8?B?VGVLdU11ZnBMWW82dUphWGZJeVpUZXFOK1dCWHU4Sk1GclZ6RXJmQXYvVlZq?=
 =?utf-8?B?SElwWklqdUZ6am9CTmt4M0pDcVpGRWVQQzJCL3JaTVVXQmQ4L3liNndRajE1?=
 =?utf-8?B?Mi9MSFNRaElBMFAzUzQxeTZzTy9oSENpeFhGOGwzTklkU1YyRDZPNUczazBi?=
 =?utf-8?B?aGdzZ1RIZ3hnM0phK2lidmRPd3ZDbkNIdGVramxZOHI3M1JjaUg5MTgxRmV6?=
 =?utf-8?B?QUROUjRROG9YbjZndDBIR2w0Y3pQdlI4dHBXNTd4QU1ydzNkOXMxd21ldSs1?=
 =?utf-8?B?V1lxRVlnR0RRUEkzR3QzblZFa1ZTN0xvaHpDbHcxR3AvUXlaTkdDYjVFekVV?=
 =?utf-8?B?dkYxZklIS3BmN3d4T1M1NS9rb3lwQWRlYUoyUGJ1TWhwcEV1dzlPdFF6SC9a?=
 =?utf-8?B?c25UL1JwNk9WYTBwYVA1dytrSEtVbjh5L2hpOTNodVA2S3hLWmJGN2lHdWJh?=
 =?utf-8?B?bmhGMTZ4UmFmT0VHc2VOZ0QzQlE5Mk9kelpFRC9BVWptUUV0Q2p5eFNLRmFm?=
 =?utf-8?B?cGNVUk9zdTh5VG9MdEtxL0t4QVFJNlgyRGgzU0FFU0hzN1ZmQkcxcXJDTGcy?=
 =?utf-8?B?Vm13dmtPZFJ2N2NTSnVSZzVwaE9MR0g3YmFnemVUb3pTYk1CV3NxNkVKK0Rn?=
 =?utf-8?B?SjIxKy9nbzhGT2JNd1hQMzRYUXQ3MndpeEM0djhoVDlaaWNnczNpeEhGR0Ro?=
 =?utf-8?B?VCtwa2N2ODZoMUFIWE9YQ3RlTGZTekwycVB4UGdNb3NwZnlIVjhhVkdRSVdu?=
 =?utf-8?B?cmZCRGxzTHJRYWpKMEI0Z29iTEt6Nm5tc21ydUs2NzRiMFEzUFNZUUVoZUJY?=
 =?utf-8?B?LzNaSjR5REtZTndWRXIydENCbDI1elVSQXhkNTNjamdmRy9sNy91ZERPeE5P?=
 =?utf-8?B?cjNKbzZoVUlqdmtsMXV4RDhUOEQvUG41M29PV1IwTldFTCs5R01UTmJ2bnNy?=
 =?utf-8?B?eXpRaTdVcUVFOEtza0F1M2tzQ3NJajdGNVZtT05NcWx6S25XK0ZabWx3eks1?=
 =?utf-8?B?UHZ1ZndodC9NQWw4Q2dIOHRJSzRyU2swM2NDNW1TSUdHVmdYVEhvaTRDM2FF?=
 =?utf-8?Q?QLbBm+VDBXlU3Kh7Ek8OjTQz/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5843321-d70f-4672-b756-08db6d961d10
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 11:46:10.2870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u8/1S/AAI7S3rDgT6F4nFjdDXVQ2uFqBxkS1U1K6QpesQ7PZonAQYqxToJ536HYcuPIwXr9DHdmqbL30j1Fnzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7109
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV2aWV3ZWQtYnk6IEdhdXJhdiBKYWluIDxnYXVyYXYuamFpbkBueHAuY29tPg0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1lZW5ha3NoaSBBZ2dhcndhbCA8bWVlbmFr
c2hpLmFnZ2Fyd2FsQG54cC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgSnVuZSAxMiwgMjAyMyAxOjU5
IFBNDQo+IFRvOiBIb3JpYSBHZWFudGEgPGhvcmlhLmdlYW50YUBueHAuY29tPjsgVmFydW4gU2V0
aGkgPFYuU2V0aGlAbnhwLmNvbT47DQo+IFBhbmthaiBHdXB0YSA8cGFua2FqLmd1cHRhQG54cC5j
b20+OyBHYXVyYXYgSmFpbiA8Z2F1cmF2LmphaW5AbnhwLmNvbT47DQo+IGhlcmJlcnRAZ29uZG9y
LmFwYW5hLm9yZy5hdTsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgbGludXgtDQo+IGNyeXB0b0B2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IFZpY3Rvcmlh
IE1pbGhvYW4gKGI0MjA4OSkgPHZpY2tpLm1pbGhvYW5AZnJlZXNjYWxlLmNvbT47IERhbiBEb3Vn
bGFzcw0KPiA8ZGFuLmRvdWdsYXNzQG54cC5jb20+OyBWaXB1bCBLdW1hciA8dmlwdWxfa3VtYXJA
bWVudG9yLmNvbT47DQo+IE1lZW5ha3NoaSBBZ2dhcndhbCA8bWVlbmFrc2hpLmFnZ2Fyd2FsQG54
cC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSF0gY3J5cHRvOiBjYWFtIC0gYWRkIGEgdGVzdCBmb3Ig
dGhlIFJORw0KPiANCj4gRnJvbTogIlZpY3RvcmlhIE1pbGhvYW4gKGI0MjA4OSkiIDx2aWNraS5t
aWxob2FuQGZyZWVzY2FsZS5jb20+DQo+IA0KPiBDQUFNIGluY2x1ZGVzIGEgUmFuZG9tIE51bWJl
ciBHZW5lcmF0b3IuICBUaGlzIGNoYW5nZSBhZGRzIGEga2VybmVsDQo+IGNvbmZpZ3VyYXRpb24g
b3B0aW9uIHRvIHRlc3QgdGhlIFJORydzIGNhcGFiaWxpdGllcyB2aWEgdGhlIGh3X3JhbmRvbQ0K
PiBmcmFtZXdvcmsuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBWaWN0b3JpYSBNaWxob2FuIDx2aWNr
aS5taWxob2FuQGZyZWVzY2FsZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IERhbiBEb3VnbGFzcyA8
ZGFuLmRvdWdsYXNzQG54cC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFZpcHVsIEt1bWFyIDx2aXB1
bF9rdW1hckBtZW50b3IuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBIb3JpYSBHZWFudMSDIDxob3Jp
YS5nZWFudGFAbnhwLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTWVlbmFrc2hpIEFnZ2Fyd2FsIDxt
ZWVuYWtzaGkuYWdnYXJ3YWxAbnhwLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2NyeXB0by9jYWFt
L0tjb25maWcgICB8ICA5ICsrKysrKysNCj4gIGRyaXZlcnMvY3J5cHRvL2NhYW0vY2FhbXJuZy5j
IHwgNDgNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDIgZmlsZXMg
Y2hhbmdlZCwgNTcgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY3J5
cHRvL2NhYW0vS2NvbmZpZyBiL2RyaXZlcnMvY3J5cHRvL2NhYW0vS2NvbmZpZyBpbmRleA0KPiBl
YzZhOWU2YWQ0ZDIuLmM2MzFmOTllNDE1ZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jcnlwdG8v
Y2FhbS9LY29uZmlnDQo+ICsrKyBiL2RyaXZlcnMvY3J5cHRvL2NhYW0vS2NvbmZpZw0KPiBAQCAt
MTYyLDYgKzE2MiwxNSBAQCBjb25maWcgQ1JZUFRPX0RFVl9GU0xfQ0FBTV9QUk5HX0FQSSAgY29u
ZmlnDQo+IENSWVBUT19ERVZfRlNMX0NBQU1fQkxPQl9HRU4NCj4gIAlib29sDQo+IA0KPiArY29u
ZmlnIENSWVBUT19ERVZfRlNMX0NBQU1fUk5HX1RFU1QNCj4gKwlib29sICJUZXN0IGNhYW0gcm5n
Ig0KPiArCXNlbGVjdCBDUllQVE9fREVWX0ZTTF9DQUFNX1JOR19BUEkNCj4gKwloZWxwDQo+ICsJ
ICBTZWxlY3RpbmcgdGhpcyB3aWxsIGVuYWJsZSBhIHNlbGYtdGVzdCB0byBydW4gZm9yIHRoZQ0K
PiArCSAgY2FhbSBSTkcuDQo+ICsJICBUaGlzIHRlc3QgaXMgc2V2ZXJhbCBtaW51dGVzIGxvbmcg
YW5kIGV4ZWN1dGVzDQo+ICsJICBqdXN0IGJlZm9yZSB0aGUgUk5HIGlzIHJlZ2lzdGVyZWQgd2l0
aCB0aGUgaHdfcmFuZG9tIEFQSS4NCj4gKw0KPiAgZW5kaWYgIyBDUllQVE9fREVWX0ZTTF9DQUFN
X0pSDQo+IA0KPiAgZW5kaWYgIyBDUllQVE9fREVWX0ZTTF9DQUFNDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2NyeXB0by9jYWFtL2NhYW1ybmcuYyBiL2RyaXZlcnMvY3J5cHRvL2NhYW0vY2FhbXJu
Zy5jDQo+IGluZGV4IDUwZWI1NWRhNDVjMi4uYjNkMTRhN2Y0ZGQxIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2NyeXB0by9jYWFtL2NhYW1ybmcuYw0KPiArKysgYi9kcml2ZXJzL2NyeXB0by9jYWFt
L2NhYW1ybmcuYw0KPiBAQCAtMTcyLDYgKzE3Miw1MCBAQCBzdGF0aWMgdm9pZCBjYWFtX2NsZWFu
dXAoc3RydWN0IGh3cm5nICpybmcpDQo+ICAJa2ZpZm9fZnJlZSgmY3R4LT5maWZvKTsNCj4gIH0N
Cj4gDQo+ICsjaWZkZWYgQ09ORklHX0NSWVBUT19ERVZfRlNMX0NBQU1fUk5HX1RFU1QNCj4gK3N0
YXRpYyBpbmxpbmUgdm9pZCB0ZXN0X2xlbihzdHJ1Y3QgaHdybmcgKnJuZywgc2l6ZV90IGxlbiwg
Ym9vbCB3YWl0KSB7DQo+ICsJdTggKmJ1ZjsNCj4gKwlpbnQgcmVhZF9sZW47DQo+ICsJc3RydWN0
IGNhYW1fcm5nX2N0eCAqY3R4ID0gdG9fY2FhbV9ybmdfY3R4KHJuZyk7DQo+ICsJc3RydWN0IGRl
dmljZSAqZGV2ID0gY3R4LT5jdHJsZGV2Ow0KPiArDQo+ICsJYnVmID0ga2NhbGxvYyhDQUFNX1JO
R19NQVhfRklGT19TVE9SRV9TSVpFLCBzaXplb2YodTgpLA0KPiBHRlBfS0VSTkVMKTsNCj4gKw0K
PiArCXdoaWxlIChsZW4gPiAwKSB7DQo+ICsJCXJlYWRfbGVuID0gcm5nLT5yZWFkKHJuZywgYnVm
LCBsZW4sIHdhaXQpOw0KPiArDQo+ICsJCWlmIChyZWFkX2xlbiA8IDAgfHwgKHJlYWRfbGVuID09
IDAgJiYgd2FpdCkpIHsNCj4gKwkJCWRldl9lcnIoZGV2LCAiUk5HIFJlYWQgRkFJTEVEIHJlY2Vp
dmVkICVkIGJ5dGVzXG4iLA0KPiArCQkJCXJlYWRfbGVuKTsNCj4gKwkJCWtmcmVlKGJ1Zik7DQo+
ICsJCQlyZXR1cm47DQo+ICsJCX0NCj4gKw0KPiArCQlwcmludF9oZXhfZHVtcF9kZWJ1ZygicmFu
ZG9tIGJ5dGVzQDogIiwNCj4gKwkJCURVTVBfUFJFRklYX0FERFJFU1MsIDE2LCA0LA0KPiArCQkJ
YnVmLCByZWFkX2xlbiwgMSk7DQo+ICsNCj4gKwkJbGVuID0gbGVuIC0gcmVhZF9sZW47DQo+ICsJ
fQ0KPiArDQo+ICsJa2ZyZWUoYnVmKTsNCj4gK30NCj4gKw0KPiArc3RhdGljIGlubGluZSB2b2lk
IHRlc3RfbW9kZV9vbmNlKHN0cnVjdCBod3JuZyAqcm5nLCBib29sIHdhaXQpIHsNCj4gKwl0ZXN0
X2xlbihybmcsIDMyLCB3YWl0KTsNCj4gKwl0ZXN0X2xlbihybmcsIDY0LCB3YWl0KTsNCj4gKwl0
ZXN0X2xlbihybmcsIDEyOCwgd2FpdCk7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIHNlbGZf
dGVzdChzdHJ1Y3QgaHdybmcgKnJuZykgew0KPiArCXByX2luZm8oIkV4ZWN1dGluZyBSTkcgU0VM
Ri1URVNUIHdpdGggd2FpdFxuIik7DQo+ICsJdGVzdF9tb2RlX29uY2Uocm5nLCB0cnVlKTsNCj4g
K30NCj4gKyNlbmRpZg0KPiArDQo+ICBzdGF0aWMgaW50IGNhYW1faW5pdChzdHJ1Y3QgaHdybmcg
KnJuZykgIHsNCj4gIAlzdHJ1Y3QgY2FhbV9ybmdfY3R4ICpjdHggPSB0b19jYWFtX3JuZ19jdHgo
cm5nKTsgQEAgLTI1OCw2ICszMDIsMTANCj4gQEAgaW50IGNhYW1fcm5nX2luaXQoc3RydWN0IGRl
dmljZSAqY3RybGRldikNCj4gIAkJcmV0dXJuIHJldDsNCj4gIAl9DQo+IA0KPiArI2lmZGVmIENP
TkZJR19DUllQVE9fREVWX0ZTTF9DQUFNX1JOR19URVNUDQo+ICsJc2VsZl90ZXN0KCZjdHgtPnJu
Zyk7DQo+ICsjZW5kaWYNCj4gKw0KPiAgCWRldnJlc19jbG9zZV9ncm91cChjdHJsZGV2LCBjYWFt
X3JuZ19pbml0KTsNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gLS0NCj4gMi4yNS4xDQoNCg==
