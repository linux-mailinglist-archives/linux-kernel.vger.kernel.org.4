Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC296940D4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjBMJWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjBMJWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:22:50 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B21EC4F;
        Mon, 13 Feb 2023 01:22:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UznHLZnWHzMD+yXF4nTbAnE16KUh/JiJGisNZTv6TtQd1drVZISSf73/1/AslOIlG4mRbq3odduedr1AKGpWUziOU492rEJtbEFQ0OBpAeWfKlDNujkdzvJjVF+izn+OAMaO/cUUGJ1+w/+hzXk3c5hwKDGVvuaZfrbfzeZ9kik/E0yKiZdPAVtrVnd4ce2wtt+KTQx34psPd/t40uqjJqHhFHpbzGuEcUnbzfIg59jVp0HOx74ryEElT+45+CF0W8/dWlT/PbBt/glATzBbRMiFtmCbxpoCdEsz11abRRj4EuuCiSgn4ZeZuqBsMiZKFcoorGbUxPur5k307qlQWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdRodVmb7eC2R9zS7GWt1cM1BFVgyNMqEyx20CAHNW8=;
 b=Od2MnXD0lfGR+sYUhfWGEOTNCawZ1V2yy/R/OZVrA9pMOR49tgs6fqgUg+uoCUydDb+FxnCRJkoF9blVXZSekRve/zGqrPajLYf5zkrayPbdJYYZ+ZvPe0yVqFlAulWHciUvWkiNAzxu429SA0GQQyVzVim6sRy05MgJ6SM8y0j9hahaC7vxoMIM7N5miaqXNKVAk0JZYZMC1vRVEO85Af4Ivjn1S8sLj91jJZ+IbB0q2WoZSHxlFCkPAws8VhcrUwG7vq6ZeXjYXwl/sjlRQbNhQnyjf/whT/d8bfNIB7mHJV58m9gLcH6NbH8cTomapkVxaxoeeRHOsyR1jj9vJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdRodVmb7eC2R9zS7GWt1cM1BFVgyNMqEyx20CAHNW8=;
 b=e0PmwIhdHF1XaVZVlvsTWZJVxokt/h5KP8YpKBzz4IRne/HXa0Hol7xvQiKwkr7Sy4l+1TjJhtL14RvCYMmpTRQHgZxFbFRk8/mMjdk0Ds3yHChegt5ke/bhZQ/za/Srt3mda6ZDWd117UuWCpoMrF3NUgqGm4HmJzG/1RsYrQ8=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB7699.eurprd04.prod.outlook.com (2603:10a6:20b:284::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.22; Mon, 13 Feb
 2023 09:22:44 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 09:22:44 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v2 02/10] media: Add Y012 video format
Thread-Topic: [EXT] Re: [PATCH v2 02/10] media: Add Y012 video format
Thread-Index: AQHZNgIHzlzcYh6D30CtLzH3/KmPMa7IWdEAgARSOHA=
Date:   Mon, 13 Feb 2023 09:22:44 +0000
Message-ID: <AM6PR04MB63418F16201148ECB0935A4CE7DD9@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1675230665.git.ming.qian@nxp.com>
         <93889cdefacaad260d978a8353066dd384a64609.1675230665.git.ming.qian@nxp.com>
 <fa6fcd8a905bff34f6d436ef328f5142b72b854c.camel@ndufresne.ca>
In-Reply-To: <fa6fcd8a905bff34f6d436ef328f5142b72b854c.camel@ndufresne.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|AM9PR04MB7699:EE_
x-ms-office365-filtering-correlation-id: bdba3380-3025-40b0-689a-08db0da3dd2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AWslVMoBb4Rn6k7I1mwhiGyjeVWc16CM/97Oslc/iYjdKOcVVU9lmEv2s5O2RPmUMAXIU0QCCnwl6Q8k0zkAFCen8fyYNLpBgGUnFidUTaSaHdg275chrjzIpkzSWms0TsySpeXRqI49guBXdqCT90RXe/G1LcDcs5asetNaEv/ztkqV7yVUSfHzPGcTNPSdeAftCFQHDl2h/2uhBeo/7XNn8dEOcdD00Ut8wgsU6V2H1t/Hzry66cgszc+YJ9OOLM2Tve8TkyXuUSJjT1HlfO65js2+cu4DK8/U/BEi0CnAEuN5dgP1CF78fJi86vQryQAMcm/l6hS0R/aCDalZjHZGMKvgaujadwrAonRtagFet2z2GiNoThe1a4TM2y6KZ8J7OHRqPeBbPVy+2+OBeSgOrZIMgGsn9mwhSduIhc9rBtgQsw9weqHvGi6kQ85189G+Cb4HVNAYERnx+YLS+VGudZ/LM//H3BWqUM82Cp9zWwzVF7ZInW9NBhp8cNHeJIPVqSGzAOgiLxu9PurIF2xd2LPHIe+gVZhPjrwRLdaTbft4qRfy+OIOnK3fWsztgn8uUISgD5A2DfM4yFL36mXySVjaNOzWBbN210Rd4J5KxV1eg+fuzf5p/RvyJB3n65xrBEhJvxE+oqbwJhe/ID2KRQLuosmXndxCufa7JEvU9WfJ7Z+H8Y0S1Z9a+zWDt2aYLpUnvyiHBM2joLYVfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199018)(9686003)(38100700002)(122000001)(54906003)(7696005)(478600001)(71200400001)(33656002)(7416002)(316002)(110136005)(6506007)(66476007)(55016003)(186003)(26005)(66574015)(44832011)(2906002)(8936002)(66556008)(66946007)(4326008)(5660300002)(8676002)(38070700005)(86362001)(64756008)(66446008)(41300700001)(76116006)(83380400001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V21wRjVUNlRaMWRBbkZwV2V1TWx2ZURJMmpxLysxeDJKa085WVByZUFOUmhh?=
 =?utf-8?B?OHlJL0E1YWw2MC9qODdoOXhhd0pad0hLRkp2M2ZKQ2ZlYnczcUROM2NEdy8w?=
 =?utf-8?B?eW90aTQwQ3IwR1YrQnhGM25jMkRBcEppN1UrckFjVG45VUM1WVB1Y0o5Tm9q?=
 =?utf-8?B?SFJHWmtNRDMyQVNyUkRPK1VNdXpXRkhRWWRHNDdSZ1N1NjNQOFlIVTFmTkhs?=
 =?utf-8?B?YzArZWM1S1MwRloxY0t0S0tUUEptR3NuOEhCZmw0N1pUVXdCVDducHNNc1Fr?=
 =?utf-8?B?MFpDbVdTOTF3NnJRSzl3K1d2UmVoTWtQNVpwQWxJbVpjUXV3QklMY3VhT09G?=
 =?utf-8?B?OWU1UHd4K1ZOVmZmaGFuTWlNaVAwdFVpeVhOcnJYaXJ0YzJKSmR2dE9aVzgv?=
 =?utf-8?B?M2dkYUlHL2tsenAveHBpazNIeDFZcEhmK2lZU2h5QWg5cFRHR0lEMkFocndy?=
 =?utf-8?B?b1RLNjRWYnQ1eEJCbVNwdXp4K0tMcnBzZjRaWmJSVXdtWWZHQk1mM291TjZM?=
 =?utf-8?B?b2o5NllOMitpUmRtRHRDa2Q1NWhhVWpDVCtjWkVDRy9DT1FwOEFuRC8xZE8y?=
 =?utf-8?B?ajlaYVIzU1hFRENselc3dmZYZm9BK1puNEE2dk1pbEs4ekZoaEloRHA0Mkdk?=
 =?utf-8?B?cDc1TGtyUUtZTis3ZUVDQVpGMEtxWkNSWWtSOTJsaVBGajBCS3drWTZSeE9R?=
 =?utf-8?B?RVplWCtDbEJZOUVac3BzMUZ0emQwVkVlcm1WMWFhdm9XQ0oxSDZ1N2ZVZkxt?=
 =?utf-8?B?RmdxV0srdVlVaCs0MTRURnR3WU9OeHBBa1loY0c5QU1XUlBWZlVVcm12STRi?=
 =?utf-8?B?YjBQOHZvNFYyd0ZVTk51WEYxazAwVk13OVRrY1hQSzZhK04yNER4OU94Q0s4?=
 =?utf-8?B?TFNQR3JiaTU2U2t0ZFZsTXRNYml2L1U5ZjZMYk4zdFBka1dmRlBOUkpyMkt4?=
 =?utf-8?B?eDdsaDJYcnVtVzhBd2JQaGJXeVBnSy9pUXJxSlpTL08wN2MxcEg3aUtHcjRn?=
 =?utf-8?B?VlBsSy85d3V4T0JNakd2TUhZMGJGVmlOUlpLZDBoS3lBRUZteU9HNjE5YmYv?=
 =?utf-8?B?MHBIbVJjUTc1aVNDZHY4TlBUUUVGT0c5WGZUQU1pejRZSEVPYUhoNmJ1NGF6?=
 =?utf-8?B?Q2dIZHFiNFg4b0FpbGhXaXBzejdvNXdIREQwRWV0L1BvUW1VVFc2T1VaRFhw?=
 =?utf-8?B?WFoyOWlJb3JqNWtkV3Z0M2k5NVozM0QvWmNDaG43NW0xcW1KRnYrY2VNVWti?=
 =?utf-8?B?TmU2RmVWZFVWWVJRYTk5RlVyNlJHYVVwY0pQdlg2TDhlaUpJd2JURGRSNWJr?=
 =?utf-8?B?YkxPOTREUWpQcGMyOUtUK0JZTVAzM3pDUXA3TjVQRmd2L2Q0MENoQTlESUFL?=
 =?utf-8?B?aEgrTjViTkxkTWlzREdidW1GTS9qc2tqMEFJOHgveXZOa3laSUNlaHYrVmky?=
 =?utf-8?B?QjlnYWppUWpCODNIRU5xWTB2S2xyTUZJYlZGN1VJKzdtV2hnczY1L2I1RzJk?=
 =?utf-8?B?eUt5NUNqUnRCWlh3czZodmVYNTFvVDZRWmEvcmN5cHRvV050VnhnK3N1ZWp4?=
 =?utf-8?B?c25WUjROWFF2YWVJM2hNTWN4VVFQWGp6OWo3b0FuNktEeUZPRW9mNkFsdWJM?=
 =?utf-8?B?VkxSVlpUd05LSmJiRUxTVGI4NmFmRjE5eG5Jak5UUnBZY3IvNndwNkJhQTNQ?=
 =?utf-8?B?Um5OMXh5SC9VbmNBaEFZQmQ5V01CYk93ZWRLRXZFSHl2UFZRZVpVcGRObXMy?=
 =?utf-8?B?dk02ZzJ2WElhclhWTjdod1dXQ1BnbEV2Vjh2L1YrSGEvb0xoQjc3eW5sTjRK?=
 =?utf-8?B?T3E4ODB5WmI1ZUIzY2t0SzhKL2ZTSlk5RFpTb3RKL0dsVGZyWVVUeUpneHVk?=
 =?utf-8?B?UE1ia2w0UUI1MHNNTTBzWlNNNUUza3lMUGJ0V1NaSDFoMjgwZDN1Qm1KK2Yr?=
 =?utf-8?B?THFqclE4UXJSSE5kc2FaUWFEOWtrMTNpMDFvTCtHc2c1TkVtL2k1NGNYS1hH?=
 =?utf-8?B?M1BOVHhYd0JJb0pDeG9UZzRpWCtrWHZpYklyMXRjZEd6d0JmemdWZkNsWllr?=
 =?utf-8?B?MTdjMUFhcFR1SWtxdHkyWVdOUVRYbHgxVXZPYy8vUGI0c3B6OXNqbExDbUk1?=
 =?utf-8?Q?rkdY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdba3380-3025-40b0-689a-08db0da3dd2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 09:22:44.3806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OlTj7OSm02uYSIW4cA/xeafaNqrz+y12FJyWifzarBTeqpcA3DOsHVXI8c/lun2gffMRbgXN4lyJCjK0f+Cv9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7699
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
MjPlubQy5pyIMTDml6UgMjM6MTgNCj5UbzogTWluZyBRaWFuIDxtaW5nLnFpYW5AbnhwLmNvbT47
IG1jaGVoYWJAa2VybmVsLm9yZzsgTWlyZWxhIFJhYnVsZWENCj4oT1NTKSA8bWlyZWxhLnJhYnVs
ZWFAb3NzLm54cC5jb20+OyBodmVya3VpbC1jaXNjb0B4czRhbGwubmwNCj5DYzogc2hhd25ndW9A
a2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRl
Ow0KPmZlc3RldmFtQGdtYWlsLmNvbTsgWC5ILiBCYW8gPHhpYWhvbmcuYmFvQG54cC5jb20+OyBk
bC1saW51eC1pbXggPGxpbnV4LQ0KPmlteEBueHAuY29tPjsgbGludXgtbWVkaWFAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPmRldmljZXRyZWVAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj5TdWJqZWN0
OiBbRVhUXSBSZTogW1BBVENIIHYyIDAyLzEwXSBtZWRpYTogQWRkIFkwMTIgdmlkZW8gZm9ybWF0
DQo+DQo+Q2F1dGlvbjogRVhUIEVtYWlsDQo+DQo+TGUgbWVyY3JlZGkgMDEgZsOpdnJpZXIgMjAy
MyDDoCAxNDowMiArMDgwMCwgTWluZyBRaWFuIGEgw6ljcml0IDoNCj4+IFkwMTIgaXMgYSBsdW1h
LW9ubHkgZm9ybWF0cyB3aXRoIDEyLWJpdHMgcGVyIHBpeGVsLCBleHBhbmRlZCB0bw0KPj4gMTZi
aXRzLg0KPj4gRGF0YSBpbiB0aGUgMTIgaGlnaCBiaXRzLCB6ZXJvcyBpbiB0aGUgNCBsb3cgYml0
cywgYXJyYW5nZWQgaW4gbGl0dGxlDQo+PiBlbmRpYW4gb3JkZXIuDQo+Pg0KPj4gU2lnbmVkLW9m
Zi1ieTogTWluZyBRaWFuIDxtaW5nLnFpYW5AbnhwLmNvbT4NCj4+IC0tLQ0KPj4gIC4uLi91c2Vy
c3BhY2UtYXBpL21lZGlhL3Y0bC9waXhmbXQteXV2LWx1bWEucnN0ICAgICAgIHwgMTEgKysrKysr
KysrKysNCj4+ICBkcml2ZXJzL21lZGlhL3Y0bDItY29yZS92NGwyLWlvY3RsLmMgICAgICAgICAg
ICAgICAgICB8ICAxICsNCj4+ICBpbmNsdWRlL3VhcGkvbGludXgvdmlkZW9kZXYyLmggICAgICAg
ICAgICAgICAgICAgICAgICB8ICAxICsNCj4+ICAzIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlv
bnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi91c2Vyc3BhY2UtYXBpL21l
ZGlhL3Y0bC9waXhmbXQteXV2LWx1bWEucnN0DQo+PiBiL0RvY3VtZW50YXRpb24vdXNlcnNwYWNl
LWFwaS9tZWRpYS92NGwvcGl4Zm10LXl1di1sdW1hLnJzdA0KPj4gaW5kZXggNmEzODdmOWRmM2Jh
Li4zZmZhMjkwMDAyMzggMTAwNjQ0DQo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL3VzZXJzcGFjZS1h
cGkvbWVkaWEvdjRsL3BpeGZtdC15dXYtbHVtYS5yc3QNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24v
dXNlcnNwYWNlLWFwaS9tZWRpYS92NGwvcGl4Zm10LXl1di1sdW1hLnJzdA0KPj4gQEAgLTEwMyw2
ICsxMDMsMTcgQEAgYXJlIG9mdGVuIHJlZmVycmVkIHRvIGFzIGdyZXlzY2FsZSBmb3JtYXRzLg0K
Pj4gICAgICAgIC0gLi4uDQo+PiAgICAgICAgLSAuLi4NCj4+DQo+PiArICAgICogLi4gX1Y0TDIt
UElYLUZNVC1ZMDEyOg0KPg0KPldoeSB0aGUgMCwgY2FuJ3QgdGhpcyBiZSBuYW1lIFkxMiAoanVz
dCBsaWtlIFkxNCkgPw0KPg0KDQpIaSBOaWNvbGFzLA0KICAgIEFzIHRoZSBWNEwyX1BJWF9GTVRf
WTEyIGlzIGRlZmluZWQsIGJ1dCBpdCdzIGRhdGEgaXMgaW4gdGhlIDEyIGxvdyBiaXRzLCB6ZXJv
cyBpbiB0aGUgaGlnaCBiaXRzLg0KICAgIEhlcmUgSSB3YW50IHRvIHBsYWNlIHRoZSAxMiBiaXRz
IGRhdGEgaW4gdGhlIGhpZ2ggYml0cywgd2l0aCB6ZXJvcyBpbiB0aGUgNCBsb3cgYml0cy4NCiAg
ICBTbyBJIGFkZCAwIGJlZm9yZSAxMiwgSSB3YW50IHRvIHNheSB0aGF0IHRoZSBsb3cgYml0cyBh
cmUgcGFkZGluZyBkYXRhIDAuDQogICANCiAgICBPciBkbyB5b3UgaGF2ZSBhIGJldHRlciBzdWdn
ZXN0aW9uPw0KDQpNaW5nDQoNCj4+ICsNCj4+ICsgICAgICAtIGBgVjRMMl9QSVhfRk1UX1kwMTJg
YA0KPj4gKyAgICAgIC0gJ1kwMTInDQo+PiArDQo+PiArICAgICAgLSBZJ1wgOnN1YjpgMGBcIFsz
OjBdIGAwMDAwYA0KPj4gKyAgICAgIC0gWSdcIDpzdWI6YDBgXCBbMTE6NF0NCj4+ICsgICAgICAt
IC4uLg0KPj4gKyAgICAgIC0gLi4uDQo+PiArICAgICAgLSAuLi4NCj4+ICsNCj4+ICAgICAgKiAu
LiBfVjRMMi1QSVgtRk1ULVkxNDoNCj4+DQo+PiAgICAgICAgLSBgYFY0TDJfUElYX0ZNVF9ZMTRg
YA0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvdjRsMi1jb3JlL3Y0bDItaW9jdGwuYw0K
Pj4gYi9kcml2ZXJzL21lZGlhL3Y0bDItY29yZS92NGwyLWlvY3RsLmMNCj4+IGluZGV4IDA2N2Ri
ZGQwYTllZi4uMGVlNzMwYWE2Y2M3IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9tZWRpYS92NGwy
LWNvcmUvdjRsMi1pb2N0bC5jDQo+PiArKysgYi9kcml2ZXJzL21lZGlhL3Y0bDItY29yZS92NGwy
LWlvY3RsLmMNCj4+IEBAIC0xMzAzLDYgKzEzMDMsNyBAQCBzdGF0aWMgdm9pZCB2NGxfZmlsbF9m
bXRkZXNjKHN0cnVjdCB2NGwyX2ZtdGRlc2MNCj4qZm10KQ0KPj4gICAgICAgY2FzZSBWNEwyX1BJ
WF9GTVRfWTY6ICAgICAgICAgICBkZXNjciA9ICI2LWJpdCBHcmV5c2NhbGUiOyBicmVhazsNCj4+
ICAgICAgIGNhc2UgVjRMMl9QSVhfRk1UX1kxMDogICAgICAgICAgZGVzY3IgPSAiMTAtYml0IEdy
ZXlzY2FsZSI7IGJyZWFrOw0KPj4gICAgICAgY2FzZSBWNEwyX1BJWF9GTVRfWTEyOiAgICAgICAg
ICBkZXNjciA9ICIxMi1iaXQgR3JleXNjYWxlIjsgYnJlYWs7DQo+PiArICAgICBjYXNlIFY0TDJf
UElYX0ZNVF9ZMDEyOiAgICAgICAgIGRlc2NyID0gIjEyLWJpdCBHcmV5c2NhbGUiOyBicmVhazsN
Cj4+ICAgICAgIGNhc2UgVjRMMl9QSVhfRk1UX1kxNDogICAgICAgICAgZGVzY3IgPSAiMTQtYml0
IEdyZXlzY2FsZSI7IGJyZWFrOw0KPj4gICAgICAgY2FzZSBWNEwyX1BJWF9GTVRfWTE2OiAgICAg
ICAgICBkZXNjciA9ICIxNi1iaXQgR3JleXNjYWxlIjsgYnJlYWs7DQo+PiAgICAgICBjYXNlIFY0
TDJfUElYX0ZNVF9ZMTZfQkU6ICAgICAgIGRlc2NyID0gIjE2LWJpdCBHcmV5c2NhbGUgQkUiOyBi
cmVhazsNCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvdmlkZW9kZXYyLmgNCj4+
IGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpZGVvZGV2Mi5oIGluZGV4IDU0NDhhYTNiNzg1OC4uM2Q4
Zjg5YmZmMzNjDQo+PiAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC92aWRlb2Rl
djIuaA0KPj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpZGVvZGV2Mi5oDQo+PiBAQCAtNTgz
LDYgKzU4Myw3IEBAIHN0cnVjdCB2NGwyX3BpeF9mb3JtYXQgew0KPj4gICNkZWZpbmUgVjRMMl9Q
SVhfRk1UX1k2ICAgICAgdjRsMl9mb3VyY2MoJ1knLCAnMCcsICc2JywgJyAnKSAvKiAgNiAgR3Jl
eXNjYWxlICAgICAqLw0KPj4gICNkZWZpbmUgVjRMMl9QSVhfRk1UX1kxMCAgICAgdjRsMl9mb3Vy
Y2MoJ1knLCAnMScsICcwJywgJyAnKSAvKiAxMCAgR3JleXNjYWxlDQo+Ki8NCj4+ICAjZGVmaW5l
IFY0TDJfUElYX0ZNVF9ZMTIgICAgIHY0bDJfZm91cmNjKCdZJywgJzEnLCAnMicsICcgJykgLyog
MTIgIEdyZXlzY2FsZQ0KPiovDQo+PiArI2RlZmluZSBWNEwyX1BJWF9GTVRfWTAxMiAgICB2NGwy
X2ZvdXJjYygnWScsICcwJywgJzEnLCAnMicpIC8qIDEyICBHcmV5c2NhbGUNCj4qLw0KPj4gICNk
ZWZpbmUgVjRMMl9QSVhfRk1UX1kxNCAgICAgdjRsMl9mb3VyY2MoJ1knLCAnMScsICc0JywgJyAn
KSAvKiAxNCAgR3JleXNjYWxlDQo+Ki8NCj4+ICAjZGVmaW5lIFY0TDJfUElYX0ZNVF9ZMTYgICAg
IHY0bDJfZm91cmNjKCdZJywgJzEnLCAnNicsICcgJykgLyogMTYgIEdyZXlzY2FsZQ0KPiovDQo+
PiAgI2RlZmluZSBWNEwyX1BJWF9GTVRfWTE2X0JFICB2NGwyX2ZvdXJjY19iZSgnWScsICcxJywg
JzYnLCAnICcpIC8qIDE2DQo+PiBHcmV5c2NhbGUgQkUgICovDQoNCg==
