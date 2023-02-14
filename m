Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2EE695623
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 02:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjBNBvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 20:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBNBvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 20:51:35 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE3A6182;
        Mon, 13 Feb 2023 17:51:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lftv0qzq/LqyXUZVjniOkUKqlG7KlNpevrAwEj123H2loA/E2h7JZ2VhU0pelvB4/YLXrnJgnei5rDAakcvTJfDX9iMWreBi7GSms4cxwu31D5kDrwVXjOEcnvamjrNPr7WXpLUv1l+XuJ3n2kaoPPxbfvyr7MNd0w6HMw2EfcXVB27Yso7pvVluBsOC35Mko49iN1IDZIHC30fxalnmYl8kSmJInLz21YkW/ctRFyInjF8mCSJqltvY5PqSdd/3j8aOtTFUawFelQIqSAql87ce7qjl1xaNA5tZxibPF2GdymA8oRGmQ7Y9WLX/oDwfvwiNf58oZ90A9xPS7MND9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGBkabXhC4r6JoVbeO38a2XU4gPrSvAuQ/aeCjehlsA=;
 b=dEy9U1eivmGloUM4QxBIXGFOsimD5UDJtP3/JBVxbmrwHhZEJnas+kZe7AH0AIwg0MVMO213nKVDUeBVZMCm+cW8K2BalhWQuVcaNevlsrHlaJTea0VVgcWVjj4qpw/6N7gILzbywLku3AKbWN16oVFkp5Ev5//skhlWOF1ygYAhoyCrv8OCthUFT0s6iYH0tPtbOyVyMRXkiYmY+Jz3S35m1IvnW2WGQG9cfwLlpz4j2CuXaklXBaN6+k2PyfBtb8xDBEdB0uWKsvnVE0EUQRwCWw9rEixbpMpTAE/Jl5572LZP/N2NesakNUDnTy53P20Zc85iCGpVQoAQ/P2umw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGBkabXhC4r6JoVbeO38a2XU4gPrSvAuQ/aeCjehlsA=;
 b=MqLvDq0tair/TNB+5pZmjO3Ml3zZ6YCB/FqFNtXkgWLnxqxA+K+fXhDvSNVPyNimzJcEIH3dPmGv1L+nlfEO+70jq1aLzSeBvm77lxUq3DJJ3AyOQ2IZvAQY+2j9Ejat8T/s3HxRiSz1kamXtI8oxIohh2qgCyKtFPhBz2ipZOc=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM9PR04MB8337.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 01:51:31 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3a82:42b3:f1ed:5c3d%7]) with mapi id 15.20.6086.023; Tue, 14 Feb 2023
 01:51:30 +0000
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
Thread-Index: AQHZNgIHzlzcYh6D30CtLzH3/KmPMa7IWdEAgARSOHCAAHs0AIAAmg6A
Date:   Tue, 14 Feb 2023 01:51:30 +0000
Message-ID: <AM6PR04MB6341A4CA774AC4F222D8668AE7A29@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1675230665.git.ming.qian@nxp.com>
         <93889cdefacaad260d978a8353066dd384a64609.1675230665.git.ming.qian@nxp.com>
         <fa6fcd8a905bff34f6d436ef328f5142b72b854c.camel@ndufresne.ca>
         <AM6PR04MB63418F16201148ECB0935A4CE7DD9@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <ddd0082ee020165dc84d7e57265cd4e92135c144.camel@ndufresne.ca>
In-Reply-To: <ddd0082ee020165dc84d7e57265cd4e92135c144.camel@ndufresne.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|AM9PR04MB8337:EE_
x-ms-office365-filtering-correlation-id: 94e22933-01c7-457e-9969-08db0e2dfe4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sQl1U6DvAZtJflZCqD5+EC7Y6D5kJnCD0kibgrWiyIVOd8b4xi5Ul4E9bGIPXK6fgFXhv8FC0BqpcLdON3fXJf/vV2l2PWPYbwPYKcTZtCK56N9/W58N1doEJ+26bksQC/EzWuP5gjCjJ0Ut/FGHu88Tv3Zz0DeJGhHQ6mUtE/YwGO6knWclygGxAdwTo7cIStLJWmHzfHAuqm0hp+Hk/cVYywxbk9xjMjbcKDcm/mGB+pFLARuKXvoM7OWXKKy2a0/GcOM/SW39tB6cxq9RqOFrPYAQNyOG/x6Tffi5eQcXc4QyypwWc/ily8ldoKGhys3uieH5DjefmGyFYYALe3m6dozSgWvqp7P70s345HMdXRjPAqlwIvDTusFYjStQadq0T9srw8le1UsdEERb6YKEPwrUiAsFIBoBfXkAB4HOm9/IEF4GiryoL3LFnKXvcl2j+PhM8/aRPwVrkc/xKUv5mt5V/aCNu6Z1lAwhFL1m77j8f6CN2aq10lxVRSOlP0pFyoD1FStH5ZUePK7SXXMXt8HKRy84KskBXLt2tswnEqtSvnXVoUnzu/oMXfIffpLH+BVXw8yVt8tj09/EE8bn2KKDwJqVz1wIuNrW1nEvTrH38u4s6ENFsJCu8SV5I7o7fvykulg66Xqs/hQCemAPTVpDkzJb0HxOxcfxKQwotv8vET3MuM/tQ7h205vQ9p4EPqxq4PfhjdZSUQSTbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(451199018)(41300700001)(54906003)(110136005)(83380400001)(38100700002)(71200400001)(38070700005)(66574015)(33656002)(2906002)(6506007)(9686003)(86362001)(186003)(26005)(122000001)(5660300002)(7696005)(478600001)(8936002)(53546011)(7416002)(52536014)(55016003)(4326008)(76116006)(44832011)(316002)(66946007)(64756008)(8676002)(66446008)(66556008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGtBNlV0SXlFWjFXcGx5KzlqM3ZIcU5ReDBTbDEzbzZOZ2lJSjNMUkJEZjkz?=
 =?utf-8?B?NVE5Y3VBZXdUcHE1OXc2c1RTL0JwUjF5aG54cGprRWV5TjNjRGh5RWVKTHJi?=
 =?utf-8?B?cnZhY0hJQW5WaTFRMnI0SllBVkwwTitxNFMweU5GYWJEK3AyNnBqa2h5T0pE?=
 =?utf-8?B?VGhKZllyb0FVU05LSXdkT3FVWnVvWXNEMkFubllmSjFaeDNqRERod1NyU3dn?=
 =?utf-8?B?SmIzUCtEYm9EWkJSWXRVRkdYNUlHQTg4MWtpWWlScENNa1prM2NGWmxUaElh?=
 =?utf-8?B?dGNvemRIRHNBUVZNMlpUcVF2NXpaTXBHcklreVhWNEc0eTdTRklka1JuMHRm?=
 =?utf-8?B?MDJmT1pBNG1DOUxUZzUxMGRhNlV0eURaU0Y4UHNhems4b1JmNjdhL1lSRUFX?=
 =?utf-8?B?Z0xSamZGNXJ5S1BmdjhpSDBtQ0VidkZ6Tzc4RU9LK1hBazVpTFhsNllMQWxl?=
 =?utf-8?B?cXMrQS91RmtmYUZpWkduTC9oVFhSSUlpQWVSZmtLc0l5WnU4ZUJRaTJhTFdk?=
 =?utf-8?B?S1A5b29hcjY0WTVMNWRwYUtDdmxwNHF4Nm5haFBYWHFXUjlsQ3dzSk53OEtw?=
 =?utf-8?B?Q0o1dm45MDltbGpaMGYvSGVGdVhmdURINlN0ekwvZjVzZ0V6OUNyVlhMRmRY?=
 =?utf-8?B?VGYxSHo4UW9nbkwrSE9lS01JdzFLMEdwbnFzZXBKdm9NS2NyaHQxMkpuTWhS?=
 =?utf-8?B?OWpERmt2YS9nSkplS1pVd2QxR1NLakpDcW1JMndxZTVsbDBBOUlVVXoxMGoy?=
 =?utf-8?B?WmRGZ2RpdFRrWFEzdlVIdktaV3I4L0ZWNUVYMU9hcFBKeHdvQ2ZWbzllcGRs?=
 =?utf-8?B?SFkyMTgyK3B5OVpnQ1lPZyttd2RhbmIxNzl5RWpkcmpISlA0SU91bXBtRlYv?=
 =?utf-8?B?a0x2ZGtnU1FTYitFVE5DWnRnb0hET0dOMm9iRS9mOGdTb2ptb2tmYUhiM24y?=
 =?utf-8?B?NWllVjhSTVluaGxOMk82MUYrZzFkbjF3REVyUEpPVG9EZGVUaFcrWUY5Umdv?=
 =?utf-8?B?MnBrTUlLUDNHMzBXajRoWDVGbVFaamp2NWs3b3NySDRZVUxicXd1QmZXTU1x?=
 =?utf-8?B?SklmeWFLTXJCSGtMZCswZEVDNjZzYll3ZmcrcnNjSnZBZVFnMmswcmZBQTBW?=
 =?utf-8?B?d2F2MVp0bng2TW1mektxSnZuQnRzZlVNTmtrNjRidm1zZVlqZ081YUw3cWI1?=
 =?utf-8?B?cUx2bUZFRU15cHMzMXJTdUE0QnRRV2tma3lVci8yVUNzZnV0UWhkUlZDTjRa?=
 =?utf-8?B?bFBvTzdTdHR1RTBEOTUvOXZuL29DNzFuME5heXZwWFNYdlFlQnF5K3JwVng1?=
 =?utf-8?B?R3ZUVWtMT0NjeExkZkFoRlYyYVpDNFZJZ2k0VDNrc2hrQTNEalRYSStDUkxP?=
 =?utf-8?B?dWRFVHdKb3Y1b3I0cjJlTVJ4R0k3djVLRWpENm1ubjVKQmhGOWZlcm5kSEVr?=
 =?utf-8?B?alo4MkFEWlgrRDBqTGU4aW1PWTExSUN2VWpIL1pFa0owM3pKemtTc0M3RnZU?=
 =?utf-8?B?TXpyN3JBUHJuNlU0TEVBTmdOajlFL3c2RDhZVFQvc2J2dzVtclVmYzVOemhU?=
 =?utf-8?B?V25Sa0VuK0RrSkl2NE5TMmNEQWNGbXpGMXdqQno4T0dBYUs5S0xFNnRqSE9Z?=
 =?utf-8?B?T1ZKRVdNVlVxeWxwZ3RYY3ZKNVlkQlFnUjdyS0lpR01xZkRkR2RwVlJCaG8y?=
 =?utf-8?B?cFpkdEhCRmZGMVB5Q0gwbEcvRUtTY1dHOGM2S0hKN2J2Q1UwTnRUT2tlQmRZ?=
 =?utf-8?B?SFhmM1ZPOVdGbE5qT2l0V1pqNXdXWVVZSUNUWXVTd0VWUURKWmdoamxQV2Rz?=
 =?utf-8?B?OHFERVdkZnMwakZFR053M2VXaUJHdm90U0JuSWFqb08zcGQyTG5EeGJuaWpO?=
 =?utf-8?B?Q2J2aDVOMzNmMzU5Si9xTTVYOFVudGdQYzRkd2gydjROemFBcmtWc0FlUjU1?=
 =?utf-8?B?bUFNTFh1SE5SdTZyRDdhN3dNRzJaSVpJUVUrVUJyUjUyREF3L1pCQjVscENk?=
 =?utf-8?B?b25WSjhneGc5ZktHV3JQK3BWNGZ1a0RrSzZ5bkcwM05rdlBGelEyKzZIQXh1?=
 =?utf-8?B?dW1mWmdGRko5RExFK1ltSVN4V1lsSk1ibFJGTXRaN3ZobytlT1ltdnJDb0w5?=
 =?utf-8?Q?LO3A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e22933-01c7-457e-9969-08db0e2dfe4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 01:51:30.5207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6XGeBY6eAP73U5bXNLbaESdEsUuDrIIYBFfnyYqjNTsAxdArrqSMToF4Yw+7X7+GBeu8RJJ45C/bNHPzn4qSlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8337
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
MjPlubQy5pyIMTTml6UgMDozOQ0KPlRvOiBNaW5nIFFpYW4gPG1pbmcucWlhbkBueHAuY29tPjsg
bWNoZWhhYkBrZXJuZWwub3JnOyBNaXJlbGEgUmFidWxlYQ0KPihPU1MpIDxtaXJlbGEucmFidWxl
YUBvc3MubnhwLmNvbT47IGh2ZXJrdWlsLWNpc2NvQHhzNGFsbC5ubA0KPkNjOiBzaGF3bmd1b0Br
ZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7
DQo+ZmVzdGV2YW1AZ21haWwuY29tOyBYLkguIEJhbyA8eGlhaG9uZy5iYW9AbnhwLmNvbT47IGRs
LWxpbnV4LWlteCA8bGludXgtDQo+aW14QG54cC5jb20+OyBsaW51eC1tZWRpYUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ZGV2aWNldHJlZUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPlN1YmplY3Q6
IFJlOiBbRVhUXSBSZTogW1BBVENIIHYyIDAyLzEwXSBtZWRpYTogQWRkIFkwMTIgdmlkZW8gZm9y
bWF0DQo+DQo+Q2F1dGlvbjogRVhUIEVtYWlsDQo+DQo+TGUgbHVuZGkgMTMgZsOpdnJpZXIgMjAy
MyDDoCAwOToyMiArMDAwMCwgTWluZyBRaWFuIGEgw6ljcml0IDoNCj4+ID4gRnJvbTogTmljb2xh
cyBEdWZyZXNuZSA8bmljb2xhc0BuZHVmcmVzbmUuY2E+DQo+PiA+IFNlbnQ6IDIwMjPlubQy5pyI
MTDml6UgMjM6MTgNCj4+ID4gVG86IE1pbmcgUWlhbiA8bWluZy5xaWFuQG54cC5jb20+OyBtY2hl
aGFiQGtlcm5lbC5vcmc7IE1pcmVsYQ0KPj4gPiBSYWJ1bGVhDQo+PiA+IChPU1MpIDxtaXJlbGEu
cmFidWxlYUBvc3MubnhwLmNvbT47IGh2ZXJrdWlsLWNpc2NvQHhzNGFsbC5ubA0KPj4gPiBDYzog
c2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj4+ID4ga2VybmVs
QHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207IFguSC4gQmFvDQo+PiA+IDx4aWFo
b25nLmJhb0BueHAuY29tPjsgZGwtbGludXgtaW14IDxsaW51eC0gaW14QG54cC5jb20+Ow0KPj4g
PiBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7DQo+PiA+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcNCj4+ID4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCB2MiAwMi8x
MF0gbWVkaWE6IEFkZCBZMDEyIHZpZGVvIGZvcm1hdA0KPj4gPg0KPj4gPiBDYXV0aW9uOiBFWFQg
RW1haWwNCj4+ID4NCj4+ID4gTGUgbWVyY3JlZGkgMDEgZsOpdnJpZXIgMjAyMyDDoCAxNDowMiAr
MDgwMCwgTWluZyBRaWFuIGEgw6ljcml0IDoNCj4+ID4gPiBZMDEyIGlzIGEgbHVtYS1vbmx5IGZv
cm1hdHMgd2l0aCAxMi1iaXRzIHBlciBwaXhlbCwgZXhwYW5kZWQgdG8NCj4+ID4gPiAxNmJpdHMu
DQo+PiA+ID4gRGF0YSBpbiB0aGUgMTIgaGlnaCBiaXRzLCB6ZXJvcyBpbiB0aGUgNCBsb3cgYml0
cywgYXJyYW5nZWQgaW4NCj4+ID4gPiBsaXR0bGUgZW5kaWFuIG9yZGVyLg0KPj4gPiA+DQo+PiA+
ID4gU2lnbmVkLW9mZi1ieTogTWluZyBRaWFuIDxtaW5nLnFpYW5AbnhwLmNvbT4NCj4+ID4gPiAt
LS0NCj4+ID4gPiAgLi4uL3VzZXJzcGFjZS1hcGkvbWVkaWEvdjRsL3BpeGZtdC15dXYtbHVtYS5y
c3QgICAgICAgfCAxMSArKysrKysrKysrKw0KPj4gPiA+ICBkcml2ZXJzL21lZGlhL3Y0bDItY29y
ZS92NGwyLWlvY3RsLmMgICAgICAgICAgICAgICAgICB8ICAxICsNCj4+ID4gPiAgaW5jbHVkZS91
YXBpL2xpbnV4L3ZpZGVvZGV2Mi5oICAgICAgICAgICAgICAgICAgICAgICAgfCAgMSArDQo+PiA+
ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQ0KPj4gPiA+DQo+PiA+ID4gZGlm
ZiAtLWdpdA0KPj4gPiA+IGEvRG9jdW1lbnRhdGlvbi91c2Vyc3BhY2UtYXBpL21lZGlhL3Y0bC9w
aXhmbXQteXV2LWx1bWEucnN0DQo+PiA+ID4gYi9Eb2N1bWVudGF0aW9uL3VzZXJzcGFjZS1hcGkv
bWVkaWEvdjRsL3BpeGZtdC15dXYtbHVtYS5yc3QNCj4+ID4gPiBpbmRleCA2YTM4N2Y5ZGYzYmEu
LjNmZmEyOTAwMDIzOCAxMDA2NDQNCj4+ID4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL3VzZXJzcGFj
ZS1hcGkvbWVkaWEvdjRsL3BpeGZtdC15dXYtbHVtYS5yc3QNCj4+ID4gPiArKysgYi9Eb2N1bWVu
dGF0aW9uL3VzZXJzcGFjZS1hcGkvbWVkaWEvdjRsL3BpeGZtdC15dXYtbHVtYS5yc3QNCj4+ID4g
PiBAQCAtMTAzLDYgKzEwMywxNyBAQCBhcmUgb2Z0ZW4gcmVmZXJyZWQgdG8gYXMgZ3JleXNjYWxl
IGZvcm1hdHMuDQo+PiA+ID4gICAgICAgIC0gLi4uDQo+PiA+ID4gICAgICAgIC0gLi4uDQo+PiA+
ID4NCj4+ID4gPiArICAgICogLi4gX1Y0TDItUElYLUZNVC1ZMDEyOg0KPj4gPg0KPj4gPiBXaHkg
dGhlIDAsIGNhbid0IHRoaXMgYmUgbmFtZSBZMTIgKGp1c3QgbGlrZSBZMTQpID8NCj4+ID4NCj4+
DQo+PiBIaSBOaWNvbGFzLA0KPj4gICAgIEFzIHRoZSBWNEwyX1BJWF9GTVRfWTEyIGlzIGRlZmlu
ZWQsIGJ1dCBpdCdzIGRhdGEgaXMgaW4gdGhlIDEyIGxvdw0KPj4gYml0cywgemVyb3MgaW4gdGhl
IGhpZ2ggYml0cy4NCj4+ICAgICBIZXJlIEkgd2FudCB0byBwbGFjZSB0aGUgMTIgYml0cyBkYXRh
IGluIHRoZSBoaWdoIGJpdHMsIHdpdGggemVyb3MNCj4+IGluIHRoZQ0KPj4gNCBsb3cgYml0cy4N
Cj4+ICAgICBTbyBJIGFkZCAwIGJlZm9yZSAxMiwgSSB3YW50IHRvIHNheSB0aGF0IHRoZSBsb3cg
Yml0cyBhcmUgcGFkZGluZyBkYXRhIDAuDQo+Pg0KPj4gICAgIE9yIGRvIHlvdSBoYXZlIGEgYmV0
dGVyIHN1Z2dlc3Rpb24/DQo+DQo+SSBzZWUsIEkgaGFkIG1pc3NlZCB0aGlzIGFzcGVjdC4gSSB0
aGluayBpbiB0aGlzIGNvbnRleHQsIGl0IHdvdWxkIGJlIGZhaXIgbmFtaW5nLg0KPk1heWJlIGRy
b3AgYSBub3RlIGluIHRoZSBkb2Mgc2F5aW5nIGp1c3QgdGhhdDoNCj4NCj4iSW4gY29udHJhc3Qg
dG8gVjRMMl9QSVhfRk1UX1kxMiBmb3JtYXQsIHdoaWNoIGhhdmUgaXRzIHBhZGRpbmcgbG9jYXRl
ZCBpbg0KPnRoZSBtb3N0IHNpZ25pZmljYW50IGJpdHMgb2YgdGhlIDE2IGJpdCB3b3JkIi4NCj4N
Cj5PciBzb21ldGhpbmcgc2ltaWxhci4sDQo+Tmljb2xhcw0KDQpIaSBOaWNvbGFzLA0KICAgIFRo
YW5rcyB2ZXJ5IG11Y2gsIEknbGwgaW5jbHVkZSB0aGUgZGVzY3JpcHRpb24gaW4gdjMgcGF0Y2gN
Cg0KPg0KPj4NCj4+IE1pbmcNCj4+DQo+PiA+ID4gKw0KPj4gPiA+ICsgICAgICAtIGBgVjRMMl9Q
SVhfRk1UX1kwMTJgYA0KPj4gPiA+ICsgICAgICAtICdZMDEyJw0KPj4gPiA+ICsNCj4+ID4gPiAr
ICAgICAgLSBZJ1wgOnN1YjpgMGBcIFszOjBdIGAwMDAwYA0KPj4gPiA+ICsgICAgICAtIFknXCA6
c3ViOmAwYFwgWzExOjRdDQo+PiA+ID4gKyAgICAgIC0gLi4uDQo+PiA+ID4gKyAgICAgIC0gLi4u
DQo+PiA+ID4gKyAgICAgIC0gLi4uDQo+PiA+ID4gKw0KPj4gPiA+ICAgICAgKiAuLiBfVjRMMi1Q
SVgtRk1ULVkxNDoNCj4+ID4gPg0KPj4gPiA+ICAgICAgICAtIGBgVjRMMl9QSVhfRk1UX1kxNGBg
DQo+PiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvdjRsMi1jb3JlL3Y0bDItaW9jdGwu
Yw0KPj4gPiA+IGIvZHJpdmVycy9tZWRpYS92NGwyLWNvcmUvdjRsMi1pb2N0bC5jDQo+PiA+ID4g
aW5kZXggMDY3ZGJkZDBhOWVmLi4wZWU3MzBhYTZjYzcgMTAwNjQ0DQo+PiA+ID4gLS0tIGEvZHJp
dmVycy9tZWRpYS92NGwyLWNvcmUvdjRsMi1pb2N0bC5jDQo+PiA+ID4gKysrIGIvZHJpdmVycy9t
ZWRpYS92NGwyLWNvcmUvdjRsMi1pb2N0bC5jDQo+PiA+ID4gQEAgLTEzMDMsNiArMTMwMyw3IEBA
IHN0YXRpYyB2b2lkIHY0bF9maWxsX2ZtdGRlc2Moc3RydWN0DQo+PiA+ID4gdjRsMl9mbXRkZXNj
DQo+PiA+ICpmbXQpDQo+PiA+ID4gICAgICAgY2FzZSBWNEwyX1BJWF9GTVRfWTY6ICAgICAgICAg
ICBkZXNjciA9ICI2LWJpdCBHcmV5c2NhbGUiOyBicmVhazsNCj4+ID4gPiAgICAgICBjYXNlIFY0
TDJfUElYX0ZNVF9ZMTA6ICAgICAgICAgIGRlc2NyID0gIjEwLWJpdCBHcmV5c2NhbGUiOyBicmVh
azsNCj4+ID4gPiAgICAgICBjYXNlIFY0TDJfUElYX0ZNVF9ZMTI6ICAgICAgICAgIGRlc2NyID0g
IjEyLWJpdCBHcmV5c2NhbGUiOyBicmVhazsNCj4+ID4gPiArICAgICBjYXNlIFY0TDJfUElYX0ZN
VF9ZMDEyOiAgICAgICAgIGRlc2NyID0gIjEyLWJpdCBHcmV5c2NhbGUiOyBicmVhazsNCj4+ID4g
PiAgICAgICBjYXNlIFY0TDJfUElYX0ZNVF9ZMTQ6ICAgICAgICAgIGRlc2NyID0gIjE0LWJpdCBH
cmV5c2NhbGUiOyBicmVhazsNCj4+ID4gPiAgICAgICBjYXNlIFY0TDJfUElYX0ZNVF9ZMTY6ICAg
ICAgICAgIGRlc2NyID0gIjE2LWJpdCBHcmV5c2NhbGUiOyBicmVhazsNCj4+ID4gPiAgICAgICBj
YXNlIFY0TDJfUElYX0ZNVF9ZMTZfQkU6ICAgICAgIGRlc2NyID0gIjE2LWJpdCBHcmV5c2NhbGUg
QkUiOw0KPj4gPiA+IGJyZWFrOw0KPj4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGlu
dXgvdmlkZW9kZXYyLmgNCj4+ID4gPiBiL2luY2x1ZGUvdWFwaS9saW51eC92aWRlb2RldjIuaCBp
bmRleCA1NDQ4YWEzYjc4NTguLjNkOGY4OWJmZjMzYw0KPj4gPiA+IDEwMDY0NA0KPj4gPiA+IC0t
LSBhL2luY2x1ZGUvdWFwaS9saW51eC92aWRlb2RldjIuaA0KPj4gPiA+ICsrKyBiL2luY2x1ZGUv
dWFwaS9saW51eC92aWRlb2RldjIuaA0KPj4gPiA+IEBAIC01ODMsNiArNTgzLDcgQEAgc3RydWN0
IHY0bDJfcGl4X2Zvcm1hdCB7DQo+PiA+ID4gICNkZWZpbmUgVjRMMl9QSVhfRk1UX1k2ICAgICAg
djRsMl9mb3VyY2MoJ1knLCAnMCcsICc2JywgJyAnKSAvKiAgNg0KPj4gPiA+IEdyZXlzY2FsZSAg
ICAgKi8NCj4+ID4gPiAgI2RlZmluZSBWNEwyX1BJWF9GTVRfWTEwICAgICB2NGwyX2ZvdXJjYygn
WScsICcxJywgJzAnLCAnICcpIC8qIDEwDQo+PiA+ID4gR3JleXNjYWxlDQo+PiA+ICovDQo+PiA+
ID4gICNkZWZpbmUgVjRMMl9QSVhfRk1UX1kxMiAgICAgdjRsMl9mb3VyY2MoJ1knLCAnMScsICcy
JywgJyAnKSAvKiAxMg0KPj4gPiA+IEdyZXlzY2FsZQ0KPj4gPiAqLw0KPj4gPiA+ICsjZGVmaW5l
IFY0TDJfUElYX0ZNVF9ZMDEyICAgIHY0bDJfZm91cmNjKCdZJywgJzAnLCAnMScsICcyJykgLyog
MTINCj4+ID4gPiBHcmV5c2NhbGUNCj4+ID4gKi8NCj4+ID4gPiAgI2RlZmluZSBWNEwyX1BJWF9G
TVRfWTE0ICAgICB2NGwyX2ZvdXJjYygnWScsICcxJywgJzQnLCAnICcpIC8qIDE0DQo+PiA+ID4g
R3JleXNjYWxlDQo+PiA+ICovDQo+PiA+ID4gICNkZWZpbmUgVjRMMl9QSVhfRk1UX1kxNiAgICAg
djRsMl9mb3VyY2MoJ1knLCAnMScsICc2JywgJyAnKSAvKiAxNg0KPj4gPiA+IEdyZXlzY2FsZQ0K
Pj4gPiAqLw0KPj4gPiA+ICAjZGVmaW5lIFY0TDJfUElYX0ZNVF9ZMTZfQkUgIHY0bDJfZm91cmNj
X2JlKCdZJywgJzEnLCAnNicsICcgJykNCj4+ID4gPiAvKiAxNiBHcmV5c2NhbGUgQkUgICovDQo+
Pg0KDQo=
