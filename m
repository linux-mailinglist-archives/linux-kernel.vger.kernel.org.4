Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7425606DD4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 04:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiJUCfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 22:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJUCfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 22:35:43 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60084.outbound.protection.outlook.com [40.107.6.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC5A1ABA0B;
        Thu, 20 Oct 2022 19:35:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0jlTuOuPqJmPw9DM1IDHDVN1+WqYHmcmNsA+B3PW2vLa5BsyJRb/C2Jsn2PvEpGVC4HoUV7mz9901J31jGawWNjbLLISVqkUNwdRzhS+9VjgGIquN7QXYvxQ11SZu8NLgY1FFt34MOXCGefGe9FHHv7eJY/LVUHpivxWM+/Izprbdz8os2cW+Cr3xk3l+GeDjOsM6Cuo4UfrXpsVvEL3x6XivqhLdMKqh7em+uRhr5sM2tUTEERn4W3YY6ijRLq/x/xbIs8pRxq2QNdg0XqKrplDAuT6192jNWeawk5f6OWAVhlsFT031+1qA5+QsKJuQ+r150jfQL8A3EU6NCR3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QF+7WYQFjvEYnzBCZdtke3kKoZL0p4WS2u8p9jfbaSQ=;
 b=Jwmh/NxiufTO2CtcIe91w36NajDdpVF5ZpheOFwTQrsKKKR78TMe1Qjkb4zztnP/PByxbrVBpNgKKo+WJ8gfqIOjaDGV9Cvya40USGCXomZuVli8uf3VCGERdyJ96wVMATxeZhKm3N4S59fOYawphzgUd7IoQHDjDJudWXdR48cUDjJ82cCj2GWByd3JqE8DNMnyBWd+kXA6zV2KXwn9fV61rp+TP/A6i5TLvRP13P2WikJlpRMi+do5dIoY/a95qiaxarwoRI9qQ2tqmh60W4KfyfCz40xQIswo/TpePWlEV+4C3QXIW0CmkjleeuEhQxHSc4Fcdjj0VDkQb/6SSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QF+7WYQFjvEYnzBCZdtke3kKoZL0p4WS2u8p9jfbaSQ=;
 b=VWXNveeN9Fk/VoOD0OKC4Nwx1KvYa3eo2FXpAeUNCtvBYnVmoBzFKhFj8sQWhV7ZjOSGlIa6YvFwgEUIlTnSuseMzYb54env9ICqNpX9oOd1ycfNLJ9WZWdOVVVmaLWx4JqTdrYQZ11TddB2AF3GSwo5Od5Ur2GQz4ZO6KbDVmw=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AS8PR04MB7590.eurprd04.prod.outlook.com (2603:10a6:20b:23d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 21 Oct
 2022 02:35:39 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::4cee:c7ba:1bbf:1c27]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::4cee:c7ba:1bbf:1c27%3]) with mapi id 15.20.5723.035; Fri, 21 Oct 2022
 02:35:39 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Brian Norris <briannorris@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Shawn Lin <shawn.lin@rock-chips.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Al Cooper <alcooperx@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: RE: [PATCH v2 4/7] mms: sdhci-esdhc-imx: Fix SDHCI_RESET_ALL for
 CQHCI
Thread-Topic: [PATCH v2 4/7] mms: sdhci-esdhc-imx: Fix SDHCI_RESET_ALL for
 CQHCI
Thread-Index: AQHY5AV2JhW3fxvHvk6HuCJLwkrZQ64YI26g
Date:   Fri, 21 Oct 2022 02:35:39 +0000
Message-ID: <DB7PR04MB40103EFAF2842B82AD8BA38F902D9@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20221019215440.277643-1-briannorris@chromium.org>
 <20221019145246.v2.4.I7d01f9ad11bacdc9213dee61b7918982aea39115@changeid>
In-Reply-To: <20221019145246.v2.4.I7d01f9ad11bacdc9213dee61b7918982aea39115@changeid>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|AS8PR04MB7590:EE_
x-ms-office365-filtering-correlation-id: b51c0ed6-76c7-4d49-0188-08dab30cf153
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tDhHHWGk0EonSYVAn1MCOWtQQ0LX348J5dQd4rUT1oiLcaxbZwPV3fbYwMvhxGKrrBNmRSA8PkoRuFYWArG9F3LodmRarpQp0Oh90RB/NjvyCTMXyM6SeYaVJHYuMrRo5qB3BKbsyky1tqH4mr/oJgVfrtGfAm3dmTZFM11OE+8YITB+fYIjabxcAxPoT9fSuSm8CtvIsFhtSWbrsHQPBaE9nGcWAbzG9U90hZft/8lpxrKlBRyMhkmmTL9LhSmxKvE35b9L++72m/4LKTuwatplG6ORrg30Z119Wc2QlaTDBG1NdaQBQHBZSpdbVaMWCB8b1QMWf0vDQhzEui0V6pz47u1ndHxFvJpFYVk8FYwOaevia5W1hnEj+BzYR5x4sRxOL0/FL6GG6t2dwYa/MiR9wQyGFwZXoQbBSPGLDp5JqKywR7OUAjk3HoD7oy1Fv3vWah+M2bZ21UPy3/pZvLXiFfsrmPe4jkZzjyYQYrbxESv4xJXP9TOJMeNxE2YD2Vcmr0wrdKW1Uk7WsXQP1b+7CEryJTqB7jMYo/YsKRFlLTWoKcdUVNxtgaRjBBMa/uwDn1gCMRs5vl6rIKfxc4LFfGtyPndMFVIFRtDPFQt/F2DT+0KBgd8gKyLV5yWQ0/RBkaBXUIprHNn8NJ/k6E1tYqEwoutk5sk22vJ1QIvDq7guixiEMcR9rnJubBqL3ZullcOVcUJDu+DKdz53sDDvnfrw0grXcA6t0+kUaI16Q89Z7XgjW85GfY3fPwLFWfRKCFKAa9zfLYeTP9Rg5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(451199015)(478600001)(71200400001)(83380400001)(122000001)(52536014)(9686003)(38100700002)(316002)(86362001)(54906003)(38070700005)(110136005)(186003)(2906002)(7416002)(33656002)(76116006)(8936002)(8676002)(41300700001)(7696005)(66446008)(5660300002)(4326008)(66946007)(53546011)(55016003)(6506007)(26005)(64756008)(66476007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?NlZaaG1IY1VDTTJtMkRrcWwxK2htYW5FalVVVEpSQklER2Z1b2d5eDl5ZEhh?=
 =?gb2312?B?VHVXMHhya2wvK1RWZGt5dmJhOVdSK1FZVTdEUS9zWG5sMFBKd3NFcmUzYWcz?=
 =?gb2312?B?WkFWSVk1Z21abHpRL0NSTzhBRkNRUmpWcmFMWktTa0xxdWlJQzhXQmhvcXgx?=
 =?gb2312?B?MXV2Q3c1aVAvYkpXYU82WTJqQUowckxTMDlNcUJMc043KytvQ2JGTEQvNElj?=
 =?gb2312?B?Ym8vc3ZtaFhOVkNBK2tyWTNaQS85YWxhU0JnS3Qvam91WVJoeFpkWk5VNDZs?=
 =?gb2312?B?bDdkaVNFQjg0cGFqRDlnZFEvVnVWWkg5SmRhVnJKTi9pS3hEMXk0RmhiMkFF?=
 =?gb2312?B?WXA5YmM0ejRxa041c1dMcVFkc0dUZGFPeHFrSWV4NzRuSWduOHM0TFdPWXV4?=
 =?gb2312?B?OHd2Q0tsY3VzNFRWZ0dmYStuN3NBbGppL2o3RWkxeE1naEtiTThKWGZoZlRw?=
 =?gb2312?B?ck5HZHNrVmNyZHZoVUZhUE5DVW5Fb3p5M1VQT2tOdE83b01mV295Vkx5UVg3?=
 =?gb2312?B?WWVmSEJZQ1VHQ2FKbEFJUXV4SG8zQm1wQXlQbnFscTdrc3d0TGpTbXI4WVJt?=
 =?gb2312?B?Yllja0pONFZldERCUHJraW1mZ2cvU2hOZzdnd1o2Qnk4ejViaTdrWFlVNFh4?=
 =?gb2312?B?aWhrcGNyM1R4SHNEaHFEeDRKOEdHQmZTMXlTYUhEMzFaVE1uUUJwdlBXV2tN?=
 =?gb2312?B?TUx3by9RKzF5VFZVRU55ZWlUeWpvNGFTU2krNkZlZnZzRDE1Z1lMQktPa1lK?=
 =?gb2312?B?amdLTWlFc1hpaUtUOGpha1BqT1g0RTJXa1lEMGhSVk50bmpmSG95RDE5SElH?=
 =?gb2312?B?YjNOV1RkV2ViNmIxRkF0d1RPbEE4VnNaZ2Vya2FJaVpmSjdBdk8vbytCblNw?=
 =?gb2312?B?cXJzL1BnM2svTnZvUys3c1ozRDJHN2p4cnkxMmlnSURQd0lPaTM0YjlFZk9X?=
 =?gb2312?B?Z2I5Sm5VeU9oczFXbjQ3TkkvTzZWZUlJdlZZakR4N3dHSWVrMk1OSURvdWxD?=
 =?gb2312?B?NUhFRGFLdzk1aVV1ZVF2a2h2dWNJS0R5aGtiN3FzbFFlalNEdVlCcE96Tzc0?=
 =?gb2312?B?T3U4eGl6MW54djh6dlI5ckp2ODlqN1c4UFFoZjFnQjlMMlpOVi9uY0diQkFE?=
 =?gb2312?B?Ni9BTTEzTTl0ejdtT1NNeXRMM0xxNXNJYjAySE85bCtSZkRNT1VJNDlNOE8x?=
 =?gb2312?B?YVE5YVF4aWdlVDFRZExpeFkreWdoZ2szWGhsUlRlWUpyVkpxd1YxeVJ6b0hT?=
 =?gb2312?B?VkI4WTdHUm0rZjRuZnNiR2FCR3lFd2xOL3dLZzJVN3BLQ3JJSHhhaXp3SWNW?=
 =?gb2312?B?VXNlaGhRMU05U1JGVm5aT21CNzJtelhaRW4yZ0U4dGtEc3krSHBveXczelp5?=
 =?gb2312?B?UE5QU3FaeDFkZXVKY1dzT2lMb1V3c3Nad2dONDljZUJHYzVBRkFubDM5MmtD?=
 =?gb2312?B?R29nZWo4eDlpK2NsOEtjaFJvUjM5VHBRT2NUUG1xT0lNU0RaOEpCQXZ3Rk1M?=
 =?gb2312?B?Z0lHVkhndXkxeFk0QkUrOHdWT0xKWEtFUmRrV0FFa3JqMzgwRXVpMFZoUitS?=
 =?gb2312?B?eGsrNExpUzFzRkxZTHo1eHI5RWtLWGFNb0JIdFpQVldIUm1MK2laMUJLSUt3?=
 =?gb2312?B?THAyWXVnZzA5dkRiMzdiY1hjdkVzeUx4d1Q2MHBuSllyOEFHaGlpWm5HQlNU?=
 =?gb2312?B?RDBHdG1rQ1BMMC9TUE1TSmxBMlczWmFZUFViaXNBRFBrWS8xTzFuZmJTd3ZF?=
 =?gb2312?B?cERaNDQzcGhhNHpIckJHQWVLRHVCNkg1bm44SDFmSUNCWEM0S2FXZjdHUUZ5?=
 =?gb2312?B?VE1lWEdITXVuell6UXBpRGR3Q3lpWGYwY2hJWkowcEkvN3JTUnVmZm12SkF5?=
 =?gb2312?B?cThLQ0htaVlsRjZueHhDYmo0VDJLNGVyY2VyVUlqU3owWEl4TXRBRHhmZU5U?=
 =?gb2312?B?OUVML0lxVHJTM01SZGxWbldaYTQvYVB1Qm9ZWlRBVjFJY1h0UGdpQW56SFpq?=
 =?gb2312?B?ZHNrdVRYZGlsaFpydlZRbjk4VjhDb1F4MTZCWmsrR0pSeXpXQU15aG5sbS9I?=
 =?gb2312?B?ZkZaalEyOERtUDdGSnJLdEk1allCeEo2YkJXbE9HaStLend5VFk4WWdOendY?=
 =?gb2312?Q?4HHcGtjk7fIitwtsKOjtw/v6H?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b51c0ed6-76c7-4d49-0188-08dab30cf153
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 02:35:39.5762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vfNkE8MfKC1lxFb4UFvx7XLCsKvO41H0E0t8cQ35TxEPiNwUQ2K6fKFNx04Rn8WXmqNoKmOlYeRT0ZOHCVJLgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7590
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCcmlhbiBOb3JyaXMgPGJyaWFu
bm9ycmlzQGNocm9taXVtLm9yZz4NCj4gU2VudDogMjAyMsTqMTDUwjIwyNUgNTo1NQ0KPiBUbzog
VWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IENjOiBTaGF3biBMaW4gPHNo
YXduLmxpbkByb2NrLWNoaXBzLmNvbT47IFNoYXduIEd1bw0KPiA8c2hhd25ndW9Aa2VybmVsLm9y
Zz47IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT47IEJvdWdoIENoZW4NCj4gPGhh
aWJvLmNoZW5AbnhwLmNvbT47IEJyb2FkY29tIGludGVybmFsIGtlcm5lbCByZXZpZXcgbGlzdA0K
PiA8YmNtLWtlcm5lbC1mZWVkYmFjay1saXN0QGJyb2FkY29tLmNvbT47IGRsLWxpbnV4LWlteCA8
bGludXgtaW14QG54cC5jb20+Ow0KPiBQZW5ndXRyb25peCBLZXJuZWwgVGVhbSA8a2VybmVsQHBl
bmd1dHJvbml4LmRlPjsgRmxvcmlhbiBGYWluZWxsaQ0KPiA8Zi5mYWluZWxsaUBnbWFpbC5jb20+
OyBNaWNoYWwgU2ltZWsgPG1pY2hhbC5zaW1la0B4aWxpbnguY29tPjsgRmFpeiBBYmJhcw0KPiA8
ZmFpel9hYmJhc0B0aS5jb20+OyBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBKb25hdGhhbiBI
dW50ZXINCj4gPGpvbmF0aGFuaEBudmlkaWEuY29tPjsgQWwgQ29vcGVyIDxhbGNvb3BlcnhAZ21h
aWwuY29tPjsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBTb3dqYW55
YSBLb21hdGluZW5pDQo+IDxza29tYXRpbmVuaUBudmlkaWEuY29tPjsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgVGhpZXJyeSBSZWRpbmcNCj4gPHRoaWVycnkucmVkaW5nQGdtYWlsLmNv
bT47IEFkcmlhbiBIdW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsNCj4gU2FzY2hhIEhh
dWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPjsgQnJpYW4gTm9ycmlzDQo+IDxicmlhbm5vcnJp
c0BjaHJvbWl1bS5vcmc+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MiA0LzddIG1tczogc2RoY2ktZXNk
aGMtaW14OiBGaXggU0RIQ0lfUkVTRVRfQUxMIGZvciBDUUhDSQ0KPiANCj4gIFtbIE5PVEU6IHRo
aXMgaXMgY29tcGxldGVseSB1bnRlc3RlZCBieSB0aGUgYXV0aG9yLCBidXQgaW5jbHVkZWQgc29s
ZWx5DQo+ICAgICBiZWNhdXNlLCBhcyBub3RlZCBpbiBjb21taXQgZGY1N2Q3MzI3NmI4ICgibW1j
OiBzZGhjaS1wY2k6IEZpeA0KPiAgICAgU0RIQ0lfUkVTRVRfQUxMIGZvciBDUUhDSSBmb3IgSW50
ZWwgR0xLLWJhc2VkIGNvbnRyb2xsZXJzIiksICJvdGhlcg0KPiAgICAgZHJpdmVycyB1c2luZyBD
UUhDSSBtaWdodCBiZW5lZml0IGZyb20gYSBzaW1pbGFyIGNoYW5nZSwgaWYgdGhleQ0KPiAgICAg
YWxzbyBoYXZlIENRSENJIHJlc2V0IGJ5IFNESENJX1JFU0VUX0FMTC4iIFdlJ3ZlIG5vdyBzZWVu
IHRoZSBzYW1lDQo+ICAgICBidWcgb24gYXQgbGVhc3QgTVNNLCBBcmFzYW4sIGFuZCBJbnRlbCBo
YXJkd2FyZS4gXV0NCj4gDQo+IFNESENJX1JFU0VUX0FMTCByZXNldHMgd2lsbCByZXNldCB0aGUg
aGFyZHdhcmUgQ1FFIHN0YXRlLCBidXQgd2UgYXJlbid0DQo+IHRyYWNraW5nIHRoYXQgcHJvcGVy
bHkgaW4gc29mdHdhcmUuIFdoZW4gb3V0IG9mIHN5bmMsIHdlIG1heSB0cmlnZ2VyIHZhcmlvdXMN
Cj4gdGltZW91dHMuDQo+IA0KPiBJdCdzIG5vdCB0eXBpY2FsIHRvIHBlcmZvcm0gcmVzZXRzIHdo
aWxlIENRRSBpcyBlbmFibGVkLCBidXQgdGhpcyBtYXkgb2NjdXIgaW4NCj4gc29tZSBzdXNwZW5k
IG9yIGVycm9yIHJlY292ZXJ5IHNjZW5hcmlvcy4NCj4gDQo+IEZpeGVzOiBiYjZlMzU4MTY5YmYg
KCJtbWM6IHNkaGNpLWVzZGhjLWlteDogYWRkIENNRFEgc3VwcG9ydCIpDQo+IFNpZ25lZC1vZmYt
Ynk6IEJyaWFuIE5vcnJpcyA8YnJpYW5ub3JyaXNAY2hyb21pdW0ub3JnPg0KDQpSZXZpZXdlZC1i
eTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KDQo+IC0tLQ0KPiANCj4gQ2hhbmdl
cyBpbiB2MjoNCj4gIC0gRHJvcCB1bm5lY2Vzc2FyeSBFU0RIQ19GTEFHX0NRSENJIGNoZWNrDQo+
IA0KPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYyB8IDMgKysrDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
bWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNk
aGMtaW14LmMNCj4gaW5kZXggNTU5ODFiMGYwYjEwLi5jMDdkZjdiNzFiMjIgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gKysrIGIvZHJpdmVycy9t
bWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiBAQCAtMTI4OCw2ICsxMjg4LDkgQEAgc3RhdGlj
IHZvaWQgZXNkaGNfc2V0X3Voc19zaWduYWxpbmcoc3RydWN0IHNkaGNpX2hvc3QNCj4gKmhvc3Qs
IHVuc2lnbmVkIHRpbWluZykNCj4gDQo+ICBzdGF0aWMgdm9pZCBlc2RoY19yZXNldChzdHJ1Y3Qg
c2RoY2lfaG9zdCAqaG9zdCwgdTggbWFzaykgIHsNCj4gKwlpZiAoKGhvc3QtPm1tYy0+Y2FwczIg
JiBNTUNfQ0FQMl9DUUUpICYmIChtYXNrICYNCj4gU0RIQ0lfUkVTRVRfQUxMKSkNCj4gKwkJY3Fo
Y2lfZGVhY3RpdmF0ZShob3N0LT5tbWMpOw0KPiArDQo+ICAJc2RoY2lfcmVzZXQoaG9zdCwgbWFz
ayk7DQo+IA0KPiAgCXNkaGNpX3dyaXRlbChob3N0LCBob3N0LT5pZXIsIFNESENJX0lOVF9FTkFC
TEUpOw0KPiAtLQ0KPiAyLjM4LjAuNDEzLmc3NDA0OGU0ZDllLWdvb2cNCg0K
