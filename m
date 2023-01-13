Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD352668920
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 02:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjAMB2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 20:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbjAMB2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 20:28:43 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2047.outbound.protection.outlook.com [40.107.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B51C72;
        Thu, 12 Jan 2023 17:28:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9HRqbg1vBPkFVWSGXpJkQUm/Tz5YQe/YeR8Dzc0JnC+c7lWhRVin3EautT3Y95xYjmQZG7YaA8oX3BkgqXeEmEOOGQ9m0ExJjESkIU+FC9m1dU2mHMdBhuF0wYlHIOOq7eiTFOCbJWxmEt/PAy5cn9k/rK1H6RwMMgmkQfhXrSI2V2AtZ3XX8oKwnwh2lBXEkXIGlgOziFomvjrLSOAZKreEMM2PsTxW1Z3uyI/Jaz0Vvb51C01joy3vmEaHov2GZCHUSL6UuhlqZnItpcxtBwKRgpbgEc9ndwRERc9if4I9jWRliRTnBKzUEuQBcO4GwZgCaSSOcnZpX2RQQd4xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSCGCLDk3yCPWmeujqvZGgMkBcJfGY6srtT3BYad36E=;
 b=gsuHKo7lVvFhrm6qpryP4J2XQRptOJz7CBxght7FakPnP6PmX9+yvc3ToJPw+NmIenutOlxvvHfZTDUcHK2H8T612HIdDy7MsNAOnzmvEZRlhJVawIdVBzgIQWttpcJOv06aRDmbliHylUQFCvBgLEAL1x5a0wulsJvgyP06I0xm/aLrJ2DCz2X0TCUWKp7gasftbl0J200LEqm+qxSOi8SW7KNEmQAP9tStcaRd1IS/GOeqeb3nNdS/OV5e6UQVkY7y5mZvYLG6/ITBfX/LXdip5LdmI4Esc7N/3P6fN+lIG0RzA9hyhqd7DtWEzUd24lUCPPRk0MJDdD3iPZhhdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSCGCLDk3yCPWmeujqvZGgMkBcJfGY6srtT3BYad36E=;
 b=RYPIH1FNJjlyv2HbT6Y/c8I+y4FC0KBhHtrFQgejSJfBeZp12B/ze8uPv3c8E5JC2MonaLCQqvZNEz5en5b34H07o9gVmxGFpAvPzEAleBImCeOPlmDn5jbKp4B4OCRtBIPwE9mtOVnH4arQr3rN4yrOw8p+WnLqxf3EMt7kE7g=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM8PR04MB7761.eurprd04.prod.outlook.com (2603:10a6:20b:248::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Fri, 13 Jan
 2023 01:28:38 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6002.013; Fri, 13 Jan 2023
 01:28:38 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>, Eagle Zhou <eagle.zhou@nxp.com>,
        Tao Jiang <tao.jiang_2@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v2 1/2] media: add RealVideo format
Thread-Topic: [EXT] Re: [PATCH v2 1/2] media: add RealVideo format
Thread-Index: AQHZJmWr/X5o/eC7JkuZmScGtzIiI66bTTwAgABBP0A=
Date:   Fri, 13 Jan 2023 01:28:37 +0000
Message-ID: <AM6PR04MB634109A48183262BBFF3BF76E7C29@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1673514352.git.ming.qian@nxp.com>
         <ef8212602467151a6e20ccce3e7ef7adcd7a7c91.1673514352.git.ming.qian@nxp.com>
 <d841827840b0a33b424d91aea46af33d30f5de7c.camel@ndufresne.ca>
In-Reply-To: <d841827840b0a33b424d91aea46af33d30f5de7c.camel@ndufresne.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|AM8PR04MB7761:EE_
x-ms-office365-filtering-correlation-id: 348474b0-b342-49ad-1d47-08daf5057f00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zgGopDX2d80HAcEapgTc7v8l/0utiF8R8k/9QsQTX0M2tBDKlXGyphuDBDxibQR/qgE4xHuLwwSKLlBefIBvz9ThkFjJVqVPiM6NijqPSv1cIoVK62Tu5JeTiJBFkeBuUNi1i+Aczki0YcH16vMAMhoMQGId7CZeSZ3QO7pnEnCYvjVYtCqJ5rlTINnGcofAoWyOl1VjOfDVSMU6uoqWeHYSMRtBTGuL6c2SydsGDaGHiKBRZh2DYq4IV0Vc7wbhbHx/7YHof1KYw6AY16IPvUtTeeB2Ddbj29D4g1w3lc+7esEFo+Ia52VYXerzr3Al+rEGs4FzeDJrBZPPeuauN0IXnQF+G1Xf3qNl1i/VT87bHjYEelZ4WlZmmf5TmS1Jba4xFZIorFNgYh9rQ8pjoAaM1dFIRJvE+9IJjOysUeyP4I5UuPvdpsiO8JmCiqKpLgvEtNuNP1S9fmfSCpqXqZLiZEJ1CmyVpuoIlXco7GDZjW8oS19h/mN8zWc738zqWQ3PHA9kzsjWRHOjL4SNXzphFPhvl26/USXpgDWUhmG5oo0QiOfAtWU1i1/swrbiFoKJFOmT2h/mm5J+Wjk/YsJKXRpb9AIpgLdJWrS51xBZ0sxpBMEXOFycanUziKEauzCbaGYMkyWRlucfUR9L0cugvSyA5PQJZmL7PakyP++0PJxlwHQvx9jUa1mBhJGH0UVgX45ibkQn+5pGnRnZ8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199015)(4326008)(8676002)(76116006)(66556008)(64756008)(66946007)(66476007)(66446008)(52536014)(8936002)(41300700001)(33656002)(5660300002)(7416002)(478600001)(83380400001)(26005)(186003)(9686003)(66574015)(6506007)(316002)(110136005)(86362001)(38070700005)(54906003)(71200400001)(55016003)(7696005)(38100700002)(2906002)(44832011)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUVmemFQMlFmeWkxUzZsWE02VHBrYUx1TXp1MXYreWo5eTlaNmtrUFJWc25q?=
 =?utf-8?B?bGFZd0Nac01TZllKeS9mUEVkQTNCNnU0VmkrOGVFNktEZ1JqQzlRaC9FNWQr?=
 =?utf-8?B?cmRjeVV3d3IzY2JtbDlYTXM1SzBQSVZmWEt6RkJ1UFo2ZTJHTzNqZ3RGSDFD?=
 =?utf-8?B?RG9pc3ZjL1djU2Qybno0L2FqdTlheHN3dFRJQnJUdUV4aGp2dmtpSS9QQzlO?=
 =?utf-8?B?VWJROEdPaUlhTUVPaVltTFVZNytGNDFxOGRxZExIV0JveUhScTFFNnhpMGND?=
 =?utf-8?B?SFJQY0JLdlBRR2RrRkx0ci9xOEpnUU85RElLeFRTSUpWNzFaS29tUVdJZ2d2?=
 =?utf-8?B?Ulk4WWoxT2Q1MG51T29QaHRlMnh6N29BdlZleGhvY0lKRitrc1J1RVVkNTVO?=
 =?utf-8?B?TGVvenNjOXl4Vnl3R3JQdVpIMGI5QjNaRnJkY29waEk4NjBNL2FsN2RJNmVC?=
 =?utf-8?B?UlF1MFlCeW5XZGFMWGVucUdlNU5DbnZsekU5OTJrZWJTcUtxNzBpUzJOWitZ?=
 =?utf-8?B?cjJ3ak9POGZvbThDZStKeFVYZjl2VG9BbW9UZ01adkppUDJjVnliRGhwbW1q?=
 =?utf-8?B?QjUybFYrbGdqOWlIeE1XcXN1cEVOZ3JPMWZQZFlDTXU3dUU3UFdhMVNabVV6?=
 =?utf-8?B?OFVMZHNyL3doYVhjTk5lMmt1b0xJdDlXWEVNcURPZ0hTZmQvMU9kQlVPUmw1?=
 =?utf-8?B?T2NpWWFURm9GZ2M2Rmt1aE5kTk95dVBadXVDcmZMQTk4QU1IamZOVkdrVUJT?=
 =?utf-8?B?SG5zanJnWm9FMUQyWFBsY2hDRXhWM1ZEdFdMWVJ0RkYyNHhUMzVBaXRacmxO?=
 =?utf-8?B?Zkc4TjRrTW9Yc25lUFpCcjByMEFQdzd0akZVL3dWT0FzaGE5aGZKMm9TY25t?=
 =?utf-8?B?QWpORjhQQVhxRXpzU2ZLY3ZHZ2FQbW95SkVkU0hmZW9pTENyMmdjWVc5ZGZ5?=
 =?utf-8?B?bFZqUzFkNlJ3WXhjWDZmM1crMWZ4cmFxSHV0eFJUb2UxcjluTTFsdXBtVGpt?=
 =?utf-8?B?R2szUWRaVC9yY3lLZ1RhcDYvUkRSNFRFNWUyUmx2TkZpUTBiamtnZ0tyZGpE?=
 =?utf-8?B?L2kva3NuOHRJWUV2YlFXdnZzeGVBS0pZcld2RVcrcDN1QkNGaG9ESXVUdkI5?=
 =?utf-8?B?SWJDRE9OMFk1Mnl6a2tkYklINjFyMm85Z3FGWGxrK3krK051TjlPVXQvVGlO?=
 =?utf-8?B?aitCOG8rQmtpL3VJM1g4RkZWdFR4ZmY4dERZYmkraVo1aEYzTnh6Y0hsb1lx?=
 =?utf-8?B?YWxPS0tnT3JZeGJ5VVBLSUJNZFZMLzh3RnNkaW1xc3dUZXBPRllsNDZ1NG03?=
 =?utf-8?B?MkpLUjNhOWk2RGdxa1JDbFhvbS9hY2RHSXNibnFRdnJ2eTRyQmJRZkJTZUd2?=
 =?utf-8?B?ajI3N3JtaHpBRVpMSlQwTXZGUTJIUHpnL1g0d3ZyRExXNXJaOWdvanpkT0hL?=
 =?utf-8?B?V3l2YWxybEhyWVBtak1zQmpWa0M0L1RaR2ozWHpxVUsyRDhRaUhZbFF6U0tv?=
 =?utf-8?B?eVdPZis2S1NDMG03OEhQS1N0UkROTzBCUytxSHplWVR1WEg2TXJybHNyMVF6?=
 =?utf-8?B?U29WQ2tzdjJ4bnhHOWUzY2RjK094aDZTdi9SKzhvdy9GclhZTkR2VFdRK2Qy?=
 =?utf-8?B?VWZtN3pDL1ZGckh0OTZZKzdlMWJ2TDBWdW1PbC80cXJlUk5SN29qNVU0SWRT?=
 =?utf-8?B?aWRvc1d0TGV1Y1FQdy9KV3hQUzQycWpSZWNKZWZCZ0p4Y2dLejQvMWVzQ2Qw?=
 =?utf-8?B?a2dmNElKSGF5K3l6ZDRGYTBTenl3S1VPcjY1THI0K0IwTlpUbTYyUlkrNkx1?=
 =?utf-8?B?WDI5dFhVOFlxMnJvU0NDK3grUi9sdXVHY3RYWW5LU3VvMk5GM1BCOVMrRmN3?=
 =?utf-8?B?dU5WUFExVm04Y1AvaFY4R3hpVkVvSmQ4ejJrVm0yUmtzSmlDZDNJbE9XYjkr?=
 =?utf-8?B?YncvbXRiSDBBN3FRTXgvRlplRjBNOUJZd2IxWmM1b29SZ09ySWlPZG43UHBI?=
 =?utf-8?B?ZFZWUzdlV0tNdXdxcElKUndBQXNBdUh4d2FFa3pDK250SkJla3ZXVnhGRWE3?=
 =?utf-8?B?T1dTeklMMkxhSDZMWW10NUNTNWtyM1F0UUtSL1UyQ3RFRGViNndSdFk3dmlv?=
 =?utf-8?Q?Hk18EsUEuyjItBrHrrS7uZFf7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 348474b0-b342-49ad-1d47-08daf5057f00
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 01:28:38.0077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DOmN37fuPvfcaWJqtHriPn0N5uc3OQMi+lkn4fgrhr0LLDKkiVGq7aqVPzOHJdIxvNIX1OnriMi1SXkMb9fRzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7761
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkZyb206IE5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPg0KPlNlbnQ6IDIw
MjPlubQx5pyIMTPml6UgNTozMA0KPlRvOiBNaW5nIFFpYW4gPG1pbmcucWlhbkBueHAuY29tPjsg
bWNoZWhhYkBrZXJuZWwub3JnOyBodmVya3VpbC0NCj5jaXNjb0B4czRhbGwubmwNCj5DYzogc2hh
d25ndW9Aa2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4
LmRlOw0KPmtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBkbC1saW51
eC1pbXggPGxpbnV4LQ0KPmlteEBueHAuY29tPjsgWC5ILiBCYW8gPHhpYWhvbmcuYmFvQG54cC5j
b20+OyBFYWdsZSBaaG91DQo+PGVhZ2xlLnpob3VAbnhwLmNvbT47IFRhbyBKaWFuZyA8dGFvLmpp
YW5nXzJAbnhwLmNvbT47IGxpbnV4LQ0KPm1lZGlhQHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLQ0KPmtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnDQo+U3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCB2MiAxLzJdIG1lZGlhOiBhZGQgUmVhbFZp
ZGVvIGZvcm1hdA0KPg0KPkNhdXRpb246IEVYVCBFbWFpbA0KPg0KPkhpIE1pbmcsDQo+DQo+TGUg
amV1ZGkgMTIgamFudmllciAyMDIzIMOgIDE3OjE4ICswODAwLCBNaW5nIFFpYW4gYSDDqWNyaXQg
Og0KPj4gUmVhbFZpZGVvLCBvciBhbHNvIHNwZWxsZWQgYXMgUmVhbCBWaWRlbywgaXMgYSBzdWl0
ZSBvZiBwcm9wcmlldGFyeQ0KPj4gdmlkZW8gY29tcHJlc3Npb24gZm9ybWF0cyBkZXZlbG9wZWQg
YnkgUmVhbE5ldHdvcmtzIC0gdGhlIHNwZWNpZmljDQo+PiBmb3JtYXQgY2hhbmdlcyB3aXRoIHRo
ZSB2ZXJzaW9uLg0KPj4gUmVhbFZpZGVvIGNvZGVjcyBhcmUgaWRlbnRpZmllZCBieSBmb3VyLWNo
YXJhY3RlciBjb2Rlcy4NCj4+IFJWMTAgYW5kIFJWMjAgYXJlIHRoZSBILjI2My1iYXNlZCBjb2Rl
Y3MuDQo+PiBSVjMwIGFuZCBSVjQwIGFyZSBSZWFsTmV0d29ya3MnIHByb3ByaWV0YXJ5IEguMjY0
LWJhc2VkIGNvZGVjcy4NCj4+IFJWNjAgaXMgUmVhbE5ldHdvcmtzJyBwcm9wcmlldGFyeSBIRVZD
LWJhc2VkIGNvZGVjcy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBNaW5nIFFpYW4gPG1pbmcucWlh
bkBueHAuY29tPg0KPj4gLS0tDQo+PiAgLi4uL3VzZXJzcGFjZS1hcGkvbWVkaWEvdjRsL3BpeGZt
dC1jb21wcmVzc2VkLnJzdCAgICAgfCAxMSArKysrKysrKysrKw0KPj4gIGRyaXZlcnMvbWVkaWEv
djRsMi1jb3JlL3Y0bDItaW9jdGwuYyAgICAgICAgICAgICAgICAgIHwgIDEgKw0KPj4gIGluY2x1
ZGUvdWFwaS9saW51eC92aWRlb2RldjIuaCAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEgKw0K
Pj4gIDMgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQN
Cj4+IGEvRG9jdW1lbnRhdGlvbi91c2Vyc3BhY2UtYXBpL21lZGlhL3Y0bC9waXhmbXQtY29tcHJl
c3NlZC5yc3QNCj4+IGIvRG9jdW1lbnRhdGlvbi91c2Vyc3BhY2UtYXBpL21lZGlhL3Y0bC9waXhm
bXQtY29tcHJlc3NlZC5yc3QNCj4+IGluZGV4IGEwMjMwZjM1NzY4MC4uMjIwMzVkOTJjNzg4IDEw
MDY0NA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi91c2Vyc3BhY2UtYXBpL21lZGlhL3Y0bC9waXhm
bXQtY29tcHJlc3NlZC5yc3QNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vdXNlcnNwYWNlLWFwaS9t
ZWRpYS92NGwvcGl4Zm10LWNvbXByZXNzZWQucnN0DQo+PiBAQCAtMjM3LDYgKzIzNywxNyBAQCBD
b21wcmVzc2VkIEZvcm1hdHMNCj4+ICAgICAgICAgIE1ldGFkYXRhIGFzc29jaWF0ZWQgd2l0aCB0
aGUgZnJhbWUgdG8gZGVjb2RlIGlzIHJlcXVpcmVkIHRvIGJlIHBhc3NlZA0KPj4gICAgICAgICAg
dGhyb3VnaCB0aGUgYGBWNEwyX0NJRF9TVEFURUxFU1NfRldIVF9QQVJBTVNgYCBjb250cm9sLg0K
Pj4gICAgICAgU2VlIHRoZSA6cmVmOmBhc3NvY2lhdGVkIENvZGVjIENvbnRyb2wgSUQgPGNvZGVj
LXN0YXRlbGVzcy1md2h0PmAuDQo+PiArICAgICogLi4gX1Y0TDItUElYLUZNVC1SVjoNCj4+ICsN
Cj4+ICsgICAgICAtIGBgVjRMMl9QSVhfRk1UX1JWYGANCj4+ICsgICAgICAtICdSVjAwJw0KPj4g
KyAgICAgIC0gUmVhbFZpZGVvLCBvciBhbHNvIHNwZWxsZWQgYXMgUmVhbCBWaWRlbywgaXMgYSBz
dWl0ZSBvZiBwcm9wcmlldGFyeQ0KPj4gKyAgICAgICAgdmlkZW8gY29tcHJlc3Npb24gZm9ybWF0
cyBkZXZlbG9wZWQgYnkgUmVhbE5ldHdvcmtzIC0NCj4+ICsgICAgICAgIHRoZSBzcGVjaWZpYyBm
b3JtYXQgY2hhbmdlcyB3aXRoIHRoZSB2ZXJzaW9uLg0KPj4gKyAgICAgICAgUmVhbFZpZGVvIGNv
ZGVjcyBhcmUgaWRlbnRpZmllZCBieSBmb3VyLWNoYXJhY3RlciBjb2Rlcy4NCj4+ICsgICAgICAg
IFJWMTAgYW5kIFJWMjAgYXJlIHRoZSBILjI2My1iYXNlZCBjb2RlY3MuDQo+PiArICAgICAgICBS
VjMwIGFuZCBSVjQwIGFyZSBSZWFsTmV0d29ya3MnIHByb3ByaWV0YXJ5IEguMjY0LWJhc2VkIGNv
ZGVjcy4NCj4+ICsgICAgICAgIFJWNjAgaXMgUmVhbE5ldHdvcmtzJyBwcm9wcmlldGFyeSBIRVZD
LWJhc2VkIGNvZGVjcy4NCj4NCj5NdWNoIGJldHRlciBkZXNjcmlwdGlvbi4gVGhvdWdoIHlvdSBo
YXZlbid0IGNvbW1lbnRlZCBvciBhZGRyZXNzZWQgbXkNCj5jb25jZXJuIG9mIGhhdmluZyA0IGRp
ZmZlcmVudCBDT0RFQ3MgdW5kZXIgdGhlIHNhbWUgRk1ULiBJIHRoaW5rcyBpdCB3b3VsZA0KPm1h
a2UgbW9yZSBzZW5zZSB0byBleHBvcnQgdGhlIGZvdXIgb2YgdGhlbS4gVGhlbiBkcml2ZXIgY2Fu
IHBpY2sgdGhlIHNldCB0aGV5DQo+c3VwcG9ydCwgcmVnYXJkbGVzcyBpZiBpdCByZXF1aXJlcyBz
cGVjaWFsIGhhbmRsaW5nIG9mIG5vdCBhdCB0aGUgSFcgbGV2ZWwuIFdoYXQNCj5kbyB5b3UgdGhp
bmsgPw0KPg0KPkV2ZW4gdGhvdWdoIHVubGlrZWx5IGNvbnNpZGVyaW5nIHRoZSBhZ2Ugb2YgdGhl
IENPREVDcywgYnV0IGhhdmluZyBhIHNpbmdsZQ0KPkZNVCBmb3IgYW4gZW5jb2RlciB3b3VsZCBq
dXN0IGluY3JlYXNlIHRoZSBlbmNvZGVyIGludGVyZmFjZSBjb21wbGV4aXR5DQo+KGNvdWxkIHJl
cXVpcmUgYSBjb250cm9sIHRvIHNlbGVjdCB3aGljaCBhY3R1YWwgZm9ybWF0IHRvIGVuY29kZSB0
bykuDQoNCkhpIE5pY29sYXMsDQogICBJIGFncmVlIHRoYXQgaXQncyBiZXR0ZXIgdG8gZGVmaW5l
IDQgZm91cmNjIGZvciBlbmNvZGVyLCBJIHdhcyBvbmx5IHRoaW5raW5nIGFib3V0IGRlY29kZXJz
LA0KSSB0aG91Z2h0IHRoZSBmb3VyY2Mgb2YgcnYgdmVyc2lvbiBpcyBpbmNsdWRlZCBpbiB0aGUg
c2VxdWVuY2UgaGVhZGVyIG9mIHJ2IHN0cmVhbSwNClNvIHRoZSBkZWNvZGVyIGNhbiBkZXRlY3Qg
aXQgYW5kIGRlY2lkZSBob3cgdG8gZGVjb2RlIGl0Lg0KDQpDb25zaWRlcmluZyB0aGUgZW5jb2Rl
ciwgaXQncyBpbmRlZWQgYSBwcm9ibGVtLCBJJ2xsIHVwZGF0ZSB0aGUgcGF0Y2ggYW5kIGRlZmlu
ZSA0IGZvcm1hdCBpbiBWMw0KDQpNaW5nDQoNCj4+DQo+PiAgLi4gcmF3OjogbGF0ZXgNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS92NGwyLWNvcmUvdjRsMi1pb2N0bC5jDQo+PiBi
L2RyaXZlcnMvbWVkaWEvdjRsMi1jb3JlL3Y0bDItaW9jdGwuYw0KPj4gaW5kZXggOWI1YjA0Yjhh
YTY5Li5jMzc1MjYxZDE2OWYgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL21lZGlhL3Y0bDItY29y
ZS92NGwyLWlvY3RsLmMNCj4+ICsrKyBiL2RyaXZlcnMvbWVkaWEvdjRsMi1jb3JlL3Y0bDItaW9j
dGwuYw0KPj4gQEAgLTE0NzMsNiArMTQ3Myw3IEBAIHN0YXRpYyB2b2lkIHY0bF9maWxsX2ZtdGRl
c2Moc3RydWN0IHY0bDJfZm10ZGVzYw0KPipmbXQpDQo+PiAgICAgICAgICAgICAgIGNhc2UgVjRM
Ml9QSVhfRk1UX0ZXSFQ6ICAgICAgICAgZGVzY3IgPSAiRldIVCI7IGJyZWFrOyAvKiB1c2VkIGlu
DQo+dmljb2RlYyAqLw0KPj4gICAgICAgICAgICAgICBjYXNlIFY0TDJfUElYX0ZNVF9GV0hUX1NU
QVRFTEVTUzogICAgICAgZGVzY3IgPSAiRldIVCBTdGF0ZWxlc3MiOw0KPmJyZWFrOyAvKiB1c2Vk
IGluIHZpY29kZWMgKi8NCj4+ICAgICAgICAgICAgICAgY2FzZSBWNEwyX1BJWF9GTVRfU1BLOiAg
ICAgICAgICBkZXNjciA9ICJTb3JlbnNvbiBTcGFyayI7IGJyZWFrOw0KPj4gKyAgICAgICAgICAg
ICBjYXNlIFY0TDJfUElYX0ZNVF9SVjogICAgICAgICAgIGRlc2NyID0gIlJlYWxWaWRlbyI7IGJy
ZWFrOw0KPj4gICAgICAgICAgICAgICBjYXNlIFY0TDJfUElYX0ZNVF9DUElBMTogICAgICAgIGRl
c2NyID0gIkdTUENBIENQaUEgWVVWIjsgYnJlYWs7DQo+PiAgICAgICAgICAgICAgIGNhc2UgVjRM
Ml9QSVhfRk1UX1dOVkE6ICAgICAgICAgZGVzY3IgPSAiV05WQSI7IGJyZWFrOw0KPj4gICAgICAg
ICAgICAgICBjYXNlIFY0TDJfUElYX0ZNVF9TTjlDMTBYOiAgICAgIGRlc2NyID0gIkdTUENBIFNO
OUMxMFgiOyBicmVhazsNCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvdmlkZW9k
ZXYyLmgNCj4+IGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpZGVvZGV2Mi5oIGluZGV4IDI2MmVmMTBj
ZmEwMi4uMGE3ZGRiMDIzZDdjDQo+PiAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51
eC92aWRlb2RldjIuaA0KPj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpZGVvZGV2Mi5oDQo+
PiBAQCAtNzQwLDYgKzc0MCw3IEBAIHN0cnVjdCB2NGwyX3BpeF9mb3JtYXQgeyAgI2RlZmluZQ0K
Pj4gVjRMMl9QSVhfRk1UX0gyNjRfU0xJQ0UgdjRsMl9mb3VyY2MoJ1MnLCAnMicsICc2JywgJzQn
KSAvKiBIMjY0IHBhcnNlZA0KPj4gc2xpY2VzICovICAjZGVmaW5lIFY0TDJfUElYX0ZNVF9IRVZD
X1NMSUNFIHY0bDJfZm91cmNjKCdTJywgJzInLCAnNicsICc1JykgLyoNCj5IRVZDIHBhcnNlZCBz
bGljZXMgKi8NCj4+ICAjZGVmaW5lIFY0TDJfUElYX0ZNVF9TUEsgICAgICB2NGwyX2ZvdXJjYygn
UycsICdQJywgJ0snLCAnMCcpIC8qIFNvcmVuc29uIFNwYXJrDQo+Ki8NCj4+ICsjZGVmaW5lIFY0
TDJfUElYX0ZNVF9SViAgICAgICB2NGwyX2ZvdXJjYygnUicsICdWJywgJzAnLCAnMCcpIC8qIFJl
YWxWaWRlbyAqLw0KPj4NCj4+ICAvKiAgVmVuZG9yLXNwZWNpZmljIGZvcm1hdHMgICAqLw0KPj4g
ICNkZWZpbmUgVjRMMl9QSVhfRk1UX0NQSUExICAgIHY0bDJfZm91cmNjKCdDJywgJ1AnLCAnSScs
ICdBJykgLyogY3BpYTEgWVVWICovDQoNCg==
