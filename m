Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7E25F43D1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 15:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiJDNAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 09:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiJDM77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:59:59 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6A65F13E;
        Tue,  4 Oct 2022 05:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664888236; x=1696424236;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aBX8hZAjxKMJpyvg7/zozy2cWdvHJmrhXUZEkygbN58=;
  b=JVuNgY19hY8pHbYTw8rLUX2jKvvW+xQ3U04FQCBtpCnuoEcuRFPukPqW
   Fw1MN1uCxqYmxgMxd/8n2LanM60ubvvNV0usIxOBEpGIIRO0mvLCfItm0
   fNlrsE9kaLvW6lusMFew9WsF0s8bd/jj57D6cOklMQ4esga/zVxUUile0
   NPMu+hp/LuUiE2LCeC/jZWyOm7rz8aXt29j6K4eM5WLEwnSpJt/+Tyoiy
   0ikJi1k7pHU64JaQqqi6sUuQMV3lWS2gXL3O2IVHKvjTDUfM/+3+SazLZ
   x8k+MNy6ZVgr/9yaTocETbjti+E/CBfClIjZwoqAZbDSyE0waUVtyMhm+
   g==;
X-IronPort-AV: E=Sophos;i="5.95,157,1661788800"; 
   d="scan'208";a="213354877"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2022 20:57:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vn7c9K96DGoPUFuvWIKNd74L+ttZv2nFgmEzJ2ts6uw+TQ/G7Amcg3yMdHEXx60wAdqKjAh+rAK1LCr8HHtOUa4trH9fvzgt78JOiuTUbzGkZpE3gZYHnJByHTtfYGopbzp0wAq6vMeLp51Lcv9lMa+Fj0+MsIX6TP+8lRUbEcZZBsFt7wSmC5ZAplx8P209wDIp7tZVZFFS1XgKDhK7Rksfsatl+L8eCyizbCVCRmipd9zRVDadileoBot1kyRT+348TJAsH5y1xC/CHu7fC4VgKstEVFLwDBBSRx/XXNXP7xGxRPITeVqhLgUPP8Vb+9hxJIjNO4ING33Hefuf9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBX8hZAjxKMJpyvg7/zozy2cWdvHJmrhXUZEkygbN58=;
 b=PWhRF5I4qRzEQiLl/FEVPoga5dWt9OJ6FAV47O41lk9SWUdZ1R4hI9YqbzdaWfP33AJQox4fDKNPCyl1Fuhw6j2AMAINzGMH/x2yrqMx6jSByfQpkS84onSqIQcRGDwfPfPeVV4TzpxNQRSgJzg1Yr7F/rWXNnXKAsVBO0pDdmU/N1osX09RPzr6A200gxJcdMgrSWra4qsoZrfbDsbVDCLdKJ60SOi45AVHmCqmwy92ygghxRcz1spnMNU+FRknoOrz+Z0pKa/UYT7jhgX/l/279PCiJqIih1gwQXuajj8edGqcVz8SUWTPGx1ZO7yjy8USqlL8HSaiMWJ1oIA58Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBX8hZAjxKMJpyvg7/zozy2cWdvHJmrhXUZEkygbN58=;
 b=b66KdRZsLN+ZY2jyxFIPP0MXcwG+LRje7SFTPbb5G2b3l7PEJIPLzX32NhiQCuwQ/FB8SsEA6oOaWYI8PQT7Q8bBjDXgdyo6YSKzLylvHdSoTfHzGraHCh/n8NoViZnbNsxQwARJyaAAVgd/8lhb4dRIH2cOxU2H10UdwFYCp9Q=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 BYAPR04MB4983.namprd04.prod.outlook.com (2603:10b6:a03:41::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17; Tue, 4 Oct 2022 12:57:12 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::2503:ada1:dcf6:8ae1]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::2503:ada1:dcf6:8ae1%6]) with mapi id 15.20.5676.031; Tue, 4 Oct 2022
 12:57:12 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] mmc: core: SD: Add BROKEN-SD-DISCARD quirk
Thread-Topic: [PATCH v2] mmc: core: SD: Add BROKEN-SD-DISCARD quirk
Thread-Index: AQHY0yDOaUJLRu52/U+MvPPMhQxPMK39QDmggADiYwCAABidAA==
Date:   Tue, 4 Oct 2022 12:57:12 +0000
Message-ID: <DM6PR04MB657553CAE1EF33CD8AF82ECBFC5A9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20220928095744.16455-1-avri.altman@wdc.com>
 <DM6PR04MB65758C73ABC2DD731167158BFC5B9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CAPDyKFqC8FskROQQbCqx5zHS8e4ci4OmekTHE+gFTR6SzUH4Ow@mail.gmail.com>
In-Reply-To: <CAPDyKFqC8FskROQQbCqx5zHS8e4ci4OmekTHE+gFTR6SzUH4Ow@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|BYAPR04MB4983:EE_
x-ms-office365-filtering-correlation-id: 68128b87-672a-4d3d-1754-08daa607f49b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z+uo1p8Uipe0dbSXcqnuzf27wS+jEcdu4l2yew9ClcRmxWqpSokMzSLu77t5RBjLvBwvIPNX3UunXQo5UaB7Hc48rCWjjrx/+Qwa/V5I3XWsRWSpzT7kg0u1dhHf/G7ZCWuPDK9qfuW+cE/yPMPcfzdoWPn2I2S+j+CCHOfsDWgKohYpei3e8U3TbDThd/zexysmfuBuBbSCTUxK/S4soly7qOFEHCbA225yT8ujcGF9zayJTqhdh7C91LQ0fGXb1o5/2qTLnveKiHWgHARNkKV3wdvqN48w9oBR5U7SkrHoaOkJtRmieTm8dp36gnD/xiNQpT8o5sNW1KGhXb0zf7EX+DdEivNIfpa7C7C5rg+LLcAkvcTCCoqIm6O1izANakaQTrOUPbQmtW5DvX2D3slH9oAS/RqWhEoUxF7I02oNnUdKGa8tgP0lOsLNHEztRX9hXoJif+iI00n2kTgEYz1dI1fEOg5nzyML/awL8kQlW+riJAo8tlS2DhRTEgU5AZYqUTsbNThLITGgdy9BOZQ0PGtemqxy92ffyfzG3dTMZ59BZygX6WtynKC5+p9O49knYxliCTIwAmBF/d3tnNV9jDLmZ8Hix1uczxcP6sJ598aVesg1HPXor6+8jR+70ESZXeVnrOyBngUDknw8gPTtx3Zk8FPgZLh6wKFZmQbI4M0Ko9X6nLAA42+s4PWmmhq6z+qmOWbirFW6lsPoqdIicTrYWGnoD+FTrzvtL0lWKAJqimydvrmfQWfqMOPQNPguz+wYM2QtN0/Orat/zg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199015)(2906002)(8936002)(5660300002)(6916009)(316002)(52536014)(41300700001)(54906003)(66556008)(64756008)(86362001)(66446008)(66946007)(76116006)(4326008)(8676002)(55016003)(33656002)(66476007)(83380400001)(38070700005)(122000001)(26005)(82960400001)(6506007)(7696005)(38100700002)(478600001)(71200400001)(9686003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFNTSWFoelVOdGVaVURrZGt4Vkt5ZzZzZ2xuaW5tZ09EMHh0eHhGZnJMWVpM?=
 =?utf-8?B?YTRxVEpWTlRnQXM3OFFHaFlKTlgzeHVRMS95clE5QnhnR0ZOK1Q1YVZvVHIx?=
 =?utf-8?B?Z3BoTFIxSlplTUFYOXo4bGgxVTlLSmcyeEpkUHA3VExXRXhqTzMxY3Rvd09U?=
 =?utf-8?B?Q1JzaEtTSUsyL21LLzlabGUyOEd6dkFib1VKQmV6RklDdDhwYU5RTll1Q1Yx?=
 =?utf-8?B?clBIamRNcnRjWXRjWU0rcWRCa2dsSEFDRHZETmY1RWJaOSt1RklSTzBkMG80?=
 =?utf-8?B?YmFlK3FZWFBVUjEzQ1l1UTZpZUpRTDVsZWtvUjZicEMrUEpYZXNuSEpHVEhE?=
 =?utf-8?B?ZnprTXJuNzFDSGZUbklyTlQzNjV2SzVWK3hudnVaZFdlRzRVdUpzdytvQ0hL?=
 =?utf-8?B?aTRENTB2NW1CMFQ5VFNsKzJjcHlpeFZ5VTRxcnBHM1F2Yk90dUR5blp2dytP?=
 =?utf-8?B?eXlra0VDTVRBMVVQUFVDa0JpNC82cytmM3Z4d3Jtc0Y2SGdObEtLT3ordlNH?=
 =?utf-8?B?Um1hcnhPdGFMTW5RMEUxV2FMemV4d0ZsbFUxdkVNR2pydTQ4NmovK2NDejVs?=
 =?utf-8?B?a1U2RjhLMDRlNDRTc3hzeGhNOGpsWGMzNndUUmk5aWhBeUxySkUxMjlEdGY1?=
 =?utf-8?B?UGdqREM5eS9MZTl1OWVYVnBiUXpqS3cyQnkySm5PUGh4WUZsaTdydHdlOGI4?=
 =?utf-8?B?UklrcVV5Q2w3aVBuMXNKSHM3TTBRdWdZSVRWeEd5QWVUYTF1bXRlRkVxWlB5?=
 =?utf-8?B?ZU1zd3dQL3J6YnJPOFBpNU96clhXZjdPRXZvUG83bkhzMVlrT2IyVmxGRndh?=
 =?utf-8?B?QXM2eEFLVysycE0xYnI2RklFaGVqQXI0S3d6ODlzZnpZTjdFSFgvbGd2SEIw?=
 =?utf-8?B?aDBseWxSazVoeVJHN1FiWW8xdFRUTnVHYXJob2NtMjgydy9Ib0l0c25YZ3Nx?=
 =?utf-8?B?alNIOTg3Nk83VFNsUkkwNHdzY05ycnVzbXRZeTREcmNiWHJvYkR6LzhGY3NU?=
 =?utf-8?B?eHJzSEpreDU4TDJMbUxYamd1ZnlwTG5BbG1CdzZLRDNwUm5BYWpvWWRETVFG?=
 =?utf-8?B?Vk9taU5Uem9MM2RJM2FsUkRERko0N1ozZFFzc2lmUWpKUDYzS3RYR0o4S0Fm?=
 =?utf-8?B?SEdFaFlvaVdNZVRZS3NxT3lqcXRScy9CUGRkTCtDTGpGS2VtZ3JGQmpkVVRG?=
 =?utf-8?B?YnZtRitGRmp4dU9CbFdGUHVlaEM1M3RKM3dWTnhQU3NpZlN1eDg0ejFUKzRC?=
 =?utf-8?B?NldSQXp4Z2EwRWU3d3A5UEJZWTlnanRLKy9XTGJ2ekwxdmEya0daUVEvSlFy?=
 =?utf-8?B?TG9iaUlaY0Q4aXNFeGd2V1VMTmZieWxXa3ZuYnUwcmc2dGdvbkJPaTF1MFAz?=
 =?utf-8?B?MXN2SEFGWlJ0WmZLR2NzVFg1Y3RPSlRvT1lVeFVOWldIcXRyVk1nVjY5dS9t?=
 =?utf-8?B?UVRYa3ZZemUvNktkU1dHQ1N4YkxXK2ZCendHRnREeWhzelNNdlJqYW5FbGpS?=
 =?utf-8?B?a2xZYlRiYjJ3SkZLMldLRytoYjlRSUlHSjR2S0hWd1c5R0ZWbVlmOXFRQk5T?=
 =?utf-8?B?bVZYQkRKMHJadXdIbHU4b2t1aHlFcVFXOUZGaUc2dzIxWldNWXdjNncwK2s2?=
 =?utf-8?B?cW9WMUkzZ3VHYTZqSGpSazhUdlNyOUtSTkNNdjRJVkNSS2U0WWEveHlNZUZY?=
 =?utf-8?B?NVFvSk5yN0lJckFPb3BzOFJPL0hoK3ZTQ0lmOTI5QktjWGw4dlJwdjR1S0NP?=
 =?utf-8?B?VUF2cGhsSE4rTHdndThiOVp2NUpZczF5c2F2K1dzczFEMkhwU2tWc1NuWUVE?=
 =?utf-8?B?K1JKWG5uMHhrN3VwVWQ0eDhVRnhod3ZoSHNmM2xuVk8yWXZjNG9GeFZ0aUI5?=
 =?utf-8?B?SW1nNVpPc3YvTndMTjY3VEtXVEtiL0VSL3ZtZndzS0FMS3NRMVdsaGJieGNU?=
 =?utf-8?B?TnJKemlQOHBMdXVINnBxcFJ4VGp2SlBiRmVBRFgwaStCK0RrSkJNNTlOYzdl?=
 =?utf-8?B?a2dUVlVadXlkNkZ6V2pwSlplTGZBd1luZkxIUURFUlZGUHJWb0VIOFpXOTcy?=
 =?utf-8?B?NFUxcktRNDg0V2s0T1pvelU0eW96dmcvbktNVGhtZ0dtbHJ6bk13UklwRk9w?=
 =?utf-8?Q?u6CEYjGLQj09+d3RqIXpDoqCR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68128b87-672a-4d3d-1754-08daa607f49b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 12:57:12.4820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i0wIF9/HlKt1EX29P2xt1z/9FtStHHAG5ImPDhebzDYtX42H+/kdt4q2Z7PCmxSvfLY/TjOBj0iSlC1lsKjUGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4983
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IFVsZiBoaSwNCj4gPiBJIHdvdWxkIGFwcHJlY2lhdGUgaWYgeW91IGNvdWxkIHRha2UgYSAy
bmQgbG9vayBhdCB0aGlzLCBTbyBpdCB3b3VsZA0KPiA+IG1ha2UgaXQgdG8gNi4xLg0KPiANCj4g
SSBhbSBwcmVwYXJpbmcgdGhlIHB1bGwgcmVxdWVzdCBmb3IgdjYuMS1yYzEsIHNvIHRoaXMgd29u
J3QgYmUgcGFydCBvZiB0aGF0Lg0KPiANCj4gQWx0aG91Z2gsIHdlIGNhbiBzdGlsbCBxdWV1ZSB0
aGlzIGFzIGEgZml4IGZvciB2Ni4xLXJjMiAtIGFuZCB3ZSBzaG91bGQgYWxzbyB0YWcNCj4gdGhp
cyBmb3Igc3RhYmxlIGtlcm5lbHMsIHJpZ2h0IT8NClllcy4gIFRoYW5rcyBhIGxvdC4NCkF2cmkN
Cg0KPiANCj4gPg0KPiA+IFRoYW5rcywNCj4gPiBBdnJpDQo+ID4NCj4gDQo+IEtpbmQgcmVnYXJk
cw0KPiBVZmZlDQo+IA0KPiANCj4gPiA+IHYxIC0+IHYyOg0KPiA+ID4gIC0gQWRkcmVzcyBVbGYn
cyBzdWdnZXN0aW9ucw0KPiA+ID4NCj4gPiA+IFNvbWUgU0QtY2FyZHMgdGhhdCBhcmUgU0RBLTYu
MCBjb21wbGlhbnQgcmVwb3J0cyB0aGV5IHN1cHBvcnRzDQo+ID4gPiBkaXNjYXJkIHdoaWxlIHRo
ZXkgYWN0dWFsbHkgZG9uJ3QuICBUaGlzIG1pZ2h0IGNhdXNlIG1rMmZzIHRvIGZhaWwNCj4gPiA+
IHdoaWxlIHRyeWluZyB0byBmb3JtYXQgdGhlIGNhcmQgYW5kIHJldmVydCBpdCB0byBhIHJlYWQt
b25seSBtb2RlLg0KPiA+ID4NCj4gPiA+IFdoaWxlIGF0IGl0LCBhZGQgU0QgTUlEIGZvciBTQU5E
SVNLLiBUaGlzIGlzIGJlY2F1c2UgZU1NQyBNSUQgaXMNCj4gPiA+IGFzc2lnbiBieSBKRURFQyBh
bmQgU0QgTUlEIGlzIGFzc2lnbmVkIGJ5IFNEIDNjLUxMQy4NCj4gPiA+DQo+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBBdnJpIEFsdG1hbiA8YXZyaS5hbHRtYW5Ad2RjLmNvbT4NCj4gPiA+IC0tLQ0KPiA+
ID4gIGRyaXZlcnMvbW1jL2NvcmUvYmxvY2suYyAgfCA2ICsrKysrLQ0KPiA+ID4gIGRyaXZlcnMv
bW1jL2NvcmUvY2FyZC5oICAgfCA2ICsrKysrKw0KPiA+ID4gIGRyaXZlcnMvbW1jL2NvcmUvcXVp
cmtzLmggfCA2ICsrKysrKyAgaW5jbHVkZS9saW51eC9tbWMvY2FyZC5oICB8IDENCj4gPiA+ICsN
Cj4gPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9ibG9jay5jIGIvZHJp
dmVycy9tbWMvY29yZS9ibG9jay5jDQo+ID4gPiBpbmRleCBjZTg5NjExYTEzNmUuLjU0Y2QwMDlh
ZWU1MCAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvYmxvY2suYw0KPiA+ID4g
KysrIGIvZHJpdmVycy9tbWMvY29yZS9ibG9jay5jDQo+ID4gPiBAQCAtMTE0MCw4ICsxMTQwLDEy
IEBAIHN0YXRpYyB2b2lkIG1tY19ibGtfaXNzdWVfZGlzY2FyZF9ycShzdHJ1Y3QNCj4gPiA+IG1t
Y19xdWV1ZSAqbXEsIHN0cnVjdCByZXF1ZXN0ICpyZXEpICB7DQo+ID4gPiAgICAgICBzdHJ1Y3Qg
bW1jX2Jsa19kYXRhICptZCA9IG1xLT5ibGtkYXRhOw0KPiA+ID4gICAgICAgc3RydWN0IG1tY19j
YXJkICpjYXJkID0gbWQtPnF1ZXVlLmNhcmQ7DQo+ID4gPiArICAgICB1bnNpZ25lZCBpbnQgYXJn
ID0gY2FyZC0+ZXJhc2VfYXJnOw0KPiA+ID4NCj4gPiA+IC0gICAgIG1tY19ibGtfaXNzdWVfZXJh
c2VfcnEobXEsIHJlcSwgTU1DX0JMS19ESVNDQVJELCBjYXJkLQ0KPiA+ID4gPmVyYXNlX2FyZyk7
DQo+ID4gPiArICAgICBpZiAobW1jX2NhcmRfYnJva2VuX3NkX2Rpc2NhcmQoY2FyZCkpDQo+ID4g
PiArICAgICAgICAgICAgIGFyZyA9IFNEX0VSQVNFX0FSRzsNCj4gPiA+ICsNCj4gPiA+ICsgICAg
IG1tY19ibGtfaXNzdWVfZXJhc2VfcnEobXEsIHJlcSwgTU1DX0JMS19ESVNDQVJELCBhcmcpOw0K
PiA+ID4gIH0NCj4gPiA+DQo+ID4gPiAgc3RhdGljIHZvaWQgbW1jX2Jsa19pc3N1ZV9zZWNkaXNj
YXJkX3JxKHN0cnVjdCBtbWNfcXVldWUgKm1xLCBkaWZmDQo+ID4gPiAtLWdpdCBhL2RyaXZlcnMv
bW1jL2NvcmUvY2FyZC5oIGIvZHJpdmVycy9tbWMvY29yZS9jYXJkLmggaW5kZXgNCj4gPiA+IDk5
MDQ1ZTEzOGJhNC4uY2ZkZDFmZjQwYjg2IDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9tbWMv
Y29yZS9jYXJkLmgNCj4gPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvY2FyZC5oDQo+ID4gPiBA
QCAtNzMsNiArNzMsNyBAQCBzdHJ1Y3QgbW1jX2ZpeHVwIHsgICNkZWZpbmUgRVhUX0NTRF9SRVZf
QU5ZICgtMXUpDQo+ID4gPg0KPiA+ID4gICNkZWZpbmUgQ0lEX01BTkZJRF9TQU5ESVNLICAgICAg
MHgyDQo+ID4gPiArI2RlZmluZSBDSURfTUFORklEX1NBTkRJU0tfU0QgICAweDMNCj4gPiA+ICAj
ZGVmaW5lIENJRF9NQU5GSURfQVRQICAgICAgICAgIDB4OQ0KPiA+ID4gICNkZWZpbmUgQ0lEX01B
TkZJRF9UT1NISUJBICAgICAgMHgxMQ0KPiA+ID4gICNkZWZpbmUgQ0lEX01BTkZJRF9NSUNST04g
ICAgICAgMHgxMw0KPiA+ID4gQEAgLTI1OCw0ICsyNTksOSBAQCBzdGF0aWMgaW5saW5lIGludCBt
bWNfY2FyZF9icm9rZW5faHBpKGNvbnN0DQo+ID4gPiBzdHJ1Y3QgbW1jX2NhcmQgKmMpDQo+ID4g
PiAgICAgICByZXR1cm4gYy0+cXVpcmtzICYgTU1DX1FVSVJLX0JST0tFTl9IUEk7ICB9DQo+ID4g
Pg0KPiA+ID4gK3N0YXRpYyBpbmxpbmUgaW50IG1tY19jYXJkX2Jyb2tlbl9zZF9kaXNjYXJkKGNv
bnN0IHN0cnVjdCBtbWNfY2FyZA0KPiA+ID4gKypjKSB7DQo+ID4gPiArICAgICByZXR1cm4gYy0+
cXVpcmtzICYgTU1DX1FVSVJLX0JST0tFTl9TRF9ESVNDQVJEOyB9DQo+ID4gPiArDQo+ID4gPiAg
I2VuZGlmDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9xdWlya3MuaCBiL2Ry
aXZlcnMvbW1jL2NvcmUvcXVpcmtzLmgNCj4gPiA+IGluZGV4IGJlNDM5Mzk4ODA4Ni4uMjliOTQ5
NzkzNmRmIDEwMDY0NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9tbWMvY29yZS9xdWlya3MuaA0KPiA+
ID4gKysrIGIvZHJpdmVycy9tbWMvY29yZS9xdWlya3MuaA0KPiA+ID4gQEAgLTEwMCw2ICsxMDAs
MTIgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtbWNfZml4dXAgX19tYXliZV91bnVzZWQNCj4gPiA+
IG1tY19ibGtfZml4dXBzW10gPSB7DQo+ID4gPiAgICAgICBNTUNfRklYVVAoIlYxMDAxNiIsIENJ
RF9NQU5GSURfS0lOR1NUT04sIENJRF9PRU1JRF9BTlksDQo+ID4gPiBhZGRfcXVpcmtfbW1jLA0K
PiA+ID4gICAgICAgICAgICAgICAgIE1NQ19RVUlSS19UUklNX0JST0tFTiksDQo+ID4gPg0KPiA+
ID4gKyAgICAgLyoNCj4gPiA+ICsgICAgICAqIFNvbWUgU0QgY2FyZHMgcmVwb3J0cyBkaXNjYXJk
IHN1cHBvcnQgd2hpbGUgdGhleSBkb24ndA0KPiA+ID4gKyAgICAgICovDQo+ID4gPiArICAgICBN
TUNfRklYVVAoQ0lEX05BTUVfQU5ZLCBDSURfTUFORklEX1NBTkRJU0tfU0QsIDB4NTM0NCwNCj4g
PiA+IGFkZF9xdWlya19zZCwNCj4gPiA+ICsgICAgICAgICAgICAgICBNTUNfUVVJUktfQlJPS0VO
X1NEX0RJU0NBUkQpLA0KPiA+ID4gKw0KPiA+ID4gICAgICAgRU5EX0ZJWFVQDQo+ID4gPiAgfTsN
Cj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tbWMvY2FyZC5oIGIvaW5j
bHVkZS9saW51eC9tbWMvY2FyZC5oDQo+ID4gPiBpbmRleCA4YTMwZGUwOGU5MTMuLmM3MjZlYTc4
MTI1NSAxMDA2NDQNCj4gPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvbW1jL2NhcmQuaA0KPiA+ID4g
KysrIGIvaW5jbHVkZS9saW51eC9tbWMvY2FyZC5oDQo+ID4gPiBAQCAtMjkzLDYgKzI5Myw3IEBA
IHN0cnVjdCBtbWNfY2FyZCB7ICAjZGVmaW5lDQo+ID4gPiBNTUNfUVVJUktfQlJPS0VOX0lSUV9Q
T0xMSU5HICgxPDwxMSkgLyogUG9sbGluZyBTRElPX0NDQ1JfSU5UeA0KPiBjb3VsZA0KPiA+ID4g
Y3JlYXRlIGEgZmFrZSBpbnRlcnJ1cHQgKi8NCj4gPiA+ICAjZGVmaW5lIE1NQ19RVUlSS19UUklN
X0JST0tFTiAgICAgICAgKDE8PDEyKSAgICAgICAgIC8qIFNraXAgdHJpbSAqLw0KPiA+ID4gICNk
ZWZpbmUgTU1DX1FVSVJLX0JST0tFTl9IUEkgKDE8PDEzKSAgICAgICAgIC8qIERpc2FibGUgYnJv
a2VuIEhQSQ0KPiA+ID4gc3VwcG9ydCAqLw0KPiA+ID4gKyNkZWZpbmUgTU1DX1FVSVJLX0JST0tF
Tl9TRF9ESVNDQVJEICAoMTw8MTQpIC8qIERpc2FibGUgYnJva2VuIFNEDQo+ID4gPiBkaXNjYXJk
IHN1cHBvcnQgKi8NCj4gPiA+DQo+ID4gPiAgICAgICBib29sICAgICAgICAgICAgICAgICAgICBy
ZWVuYWJsZV9jbWRxOyAgLyogUmUtZW5hYmxlIENvbW1hbmQgUXVldWUNCj4gPiA+ICovDQo+ID4g
Pg0KPiA+ID4gLS0NCj4gPiA+IDIuMTcuMQ0KPiA+DQo=
