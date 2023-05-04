Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CF26F6A22
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 13:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjEDLho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 07:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjEDLhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 07:37:42 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2072.outbound.protection.outlook.com [40.107.249.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9434F5FE4;
        Thu,  4 May 2023 04:37:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1jU5bczjFUwEuqNjhXw7o/7PeAsfdQpnBm51ezCF54QWx+GbPAUu1xzjqOila5CCic8tEg9rd8v6v0InuCQ0dNm/5WjmjwZQnyG8Ux77yPaeUr8CdoN6MlRNJK61oEj8B5HY98lb6Bfq+tt0n0Nr5PJtv5Co6+UVs6G5oVTXGK/pFlvzJEiRWdoWJmgALigawfVaE0gv9NbxAYCQjMy0RviSC66faL6avo6aal61yiVhJa/QaJ7pSKY/fJzMoaLwbpOmfwEUl62au6iVnxAUGexYgGaBM9SUrpwQAtY056GgPB36INC6yPe0BegjOuNanVpZIyLsfWXwpkt+VumUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fruSJfZsP3zt8IcRCzTb3iK+gRl60Ty5VTeUBk/HzLU=;
 b=TBBwtpLA2CIbzmVoibkszz8XEk7Q5QdNKJFpMjaUzyyAWcsXe/f1TXTtbthq7/EAt1odEQlDdAz+xGfRsrLr3sj2YJd77RMJFuFwLEgvCzJ+cfnzlCzEZyDW7ae7IYfRXJ0dIrXOpWlgiDubYmx7uzWtw1jvWu2QHe/7ZoO5nTZAJaO4ibOsTznUuJp9G94rl4hHqG8bGSDM+ZPIpWv0GsDFXXpQ//Jqu8dPrvBKAwY+yQ785HQORl3hu/zw7ktgcAQkpDqb6tzKnIMdcbFbULh/aAT9ZRrjbB6+YKCSjcOinSGgDRDNkBconhqlCEupMdsD9W1YJhzCfHm9Y3bOUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fruSJfZsP3zt8IcRCzTb3iK+gRl60Ty5VTeUBk/HzLU=;
 b=Ral1sJ60KLDgh+be+/JbS4ac9xIZiIom7gfvLM+uKNGyqJAlEDH+JMNuEXAvNem4pZP859NSAhkeab6zlwYS4spLbwir/IhrVIVPs4/0q9pH5NoRvJhf9CD91xKu2YvX3HFPGxasOBq7GjEveJF8wkxZ4Xby931VgOvJ4iaiVxA=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7598.eurprd04.prod.outlook.com (2603:10a6:102:e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Thu, 4 May
 2023 11:37:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%5]) with mapi id 15.20.6340.031; Thu, 4 May 2023
 11:37:08 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg KH <greg@kroah.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>
Subject: RE: [PATCH] clk: imx: imx93: introduce clk_bypassed module parameter
Thread-Topic: [PATCH] clk: imx: imx93: introduce clk_bypassed module parameter
Thread-Index: AQHZfmVsUoWhON65f0ewGxlg24Oc/K9J088AgAAAwyCAAATkAIAAAJXAgAAIwACAABh+gA==
Date:   Thu, 4 May 2023 11:37:08 +0000
Message-ID: <DU0PR04MB9417CA83A206F0F9403EE042886D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230504085506.504474-1-peng.fan@oss.nxp.com>
 <2023050410-rejoin-vocation-8560@gregkh>
 <DU0PR04MB9417F9CBB5C9EE1FC85B10A2886D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <b09998bc-9ff7-3a18-89af-9778521ab127@linaro.org>
 <DU0PR04MB941792F2EF3DB5ADB0B1A75A886D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <7e585791-ed7b-80de-d1d7-7df54b7da442@pengutronix.de>
In-Reply-To: <7e585791-ed7b-80de-d1d7-7df54b7da442@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA4PR04MB7598:EE_
x-ms-office365-filtering-correlation-id: 8f099b62-4f37-4f1f-9873-08db4c93e4b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eHp+CHHhzjuuHMM/+RvguuTRNrHfTit7bdmJaWf9gJD6Ud9SAZfSzFCGBB706l9aJb1z7B65+iEeAOOIL0myci7MvfnZeMu6jwbohTTrh580nBhobTl0NdyA+WMPQqXU4EDKqMdTUJ1Y1vjTbPZcw/u3RPlxmW7L8M9oYZqRuwiKFhbzwiYiCnYl4TaVuhqaeIvskTdCVF5tK0UoiRGEEFqK5pS5jKncHKaL1XGK0/XAUEvw7YLTDebBcDJmU5Z8o7FKsWM9k/GI33SrUxYbZ1kfVwEVp0hqYU5hzsvRuSlMtkeNNO7RgN3pNO4XYK1HysV8JXYWj1a3fBv/j1jyj0FE9nYh80vsPWi0XYzyT6q3MO44p0GBySv2tZmuUCbH5lryTcx3llDQHAvyDQzuamOmBCwjFop5zg2ztqmzDd4lEyw8WFgw7HwR+16oILSdmeHQm2YqyAt7NCRm2vPr8YRjri7OdMrTBNV2TmpR3MZL2rEe/oe9w8pziFjSpSMq/8UzkkIixwAF6RzcgGTRhgvSzh/TTKg447PIU31hsMx/ptCO/nxw6fS6P91voXvYBcPe3JVc33J2Janvz1F5r6r5rJDItZxY8fhFgwEbkLeXV+WMRAD9NF5IH9vCU1+k
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199021)(316002)(33656002)(41300700001)(71200400001)(186003)(2906002)(53546011)(26005)(9686003)(6506007)(110136005)(54906003)(66446008)(7696005)(64756008)(4326008)(83380400001)(86362001)(66476007)(66556008)(76116006)(66946007)(45080400002)(38070700005)(44832011)(55016003)(7416002)(52536014)(8936002)(5660300002)(8676002)(478600001)(38100700002)(122000001)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?a05IcHJqM25paVJZSHRxMDBVMjFuUXM4QWxhZk5lMHFENDN5Vk90OUpJUjhj?=
 =?gb2312?B?bVR1TW1ETWMvaG5hNFpmemN4OWIzdEtSOUJKQ1cwOUk2d0lFTzJlSmFndDY4?=
 =?gb2312?B?VDRxaVhnRXhxNzJMVWVEWXkwQkZNMllPMlUzZEdmaGxYZ3k3Rjdvc3BaeDdL?=
 =?gb2312?B?cVo5TlVMTjJEWlB2UURuT0pPKzN3VU1rbk9tWk1YZlV0Z3E5NFN4aXFMOE1O?=
 =?gb2312?B?RnJGNlRyaEEyUm52ZXg4Z1ZBeFJySjdpamhIMzJlVEthalhNd2JvSmRtNFM3?=
 =?gb2312?B?TW5JNitpZGpXYmFDbmxxemtEaStsU1E2aHdUOExxSmp3RjY2dDE3RE1kY2Vw?=
 =?gb2312?B?WWV1SXkxdXlNYzQramF0VyszWFhZWVVkOHd4NUJPSjU3VWkvVHM4MFBoYXd4?=
 =?gb2312?B?L1hZbllEMjgxeTNEQXZ1cUR5OTIxNTVnWXFCRTR5Vlo2dkZtYXVxNE1HWDRi?=
 =?gb2312?B?VGxSWDRoNURaZytXSW8xQ2I5U2U3NWFVUTlYRXpFOXJGMkdlbndTQzZTSS8r?=
 =?gb2312?B?dWxBdDR5L2NkQm8zSGZNZmV3dFdtQlBibWJOem9jUm9YbkVhOVBGbG9Pc2ov?=
 =?gb2312?B?eEVscTl4OWo2dFJzek1TNllhZUZBRTdORWJwVmQyRU9FZ3dDeDFxOTR1QUJS?=
 =?gb2312?B?czN5WXYxTVRJM1ZwaDY1MFIrQlBxRG5oNHlCSVRTVHNscWRmMkpYZjBWNnFH?=
 =?gb2312?B?VUpPOGJDM0tXKzl4QnZ6RWRaL3hYQzJaMHNvcEljZXM0MUZFbWIzMTNYYjFh?=
 =?gb2312?B?MDFvc3VxNERZY0loN3kvVXdBMHdyTnBCbHcxZC9PNVdrVVBxRDlUbldtNytx?=
 =?gb2312?B?Y0FqMkpNQTVkaWo4L1Fsa09RU0ZkVFljZm81MXVkSkxEUGxaZWVzcXRMZTA3?=
 =?gb2312?B?My9ubG9ZelUySXdmTk1FQkNoaFlFcDFOTTdIL2RoRlhHMURDUm5LNmdIVk5J?=
 =?gb2312?B?bXdBYi9LTmZGN01kdnRHZHkwWDBwT2czVWdQTStvblJTaHhlcDlYMUgrdFoy?=
 =?gb2312?B?QnJrVWVjaWZ1Y1g5OUhPY0laVFR6dGw0eFpNeEcyZDdGSHVBRGE4OUFZRFB2?=
 =?gb2312?B?ODdoVWtkUzllSFFWT3RCZ0VkQ081ODgweEdBU2pZbEtsbklJTy9sczhKN0RD?=
 =?gb2312?B?MEtsSHZ6clM3MXUxMllLT2N5Zi9jNlIrZG1MdkNlejF3UGlaSFd1Z2o2WFJ0?=
 =?gb2312?B?Uk9XZ1NQZTRHVFErRjVHdWkwejVFSUlENThpMzc1Wkg1QTZRVU1XRXZ4anhL?=
 =?gb2312?B?bHhhTW8xblRxMVdQeUNlcEpyVzZhT2dzRUtEeFVGMGZXN2VUN24ycWxPMjdj?=
 =?gb2312?B?ZnFvR1QyRmFvZTk4blAvWHBUTzNPVnhZMENpenRVUytKY1VpWVl5V3VvdCtU?=
 =?gb2312?B?MDZRbTd6TXdkeEEwT2RrVDVNMGJKM0FpTWtYZVdKS29lWTdPVVRMVEtrYjBX?=
 =?gb2312?B?TzBCN0xEKzQ3bllwZVdrczFyM1RPenRPN1RWYkszaGVSc0dBdUQ2eWJhT2tE?=
 =?gb2312?B?WmJPRis0Y05HbzRRUFRYamF3bTNvZlpnTUxGaU91cXNUNjIyVmh4Q2daekcy?=
 =?gb2312?B?cEJZbG5oVHNjbUszUDZscUl5Z0ZITU5VRlZLY1ovVXNtQWJlM3RUdkIzTllO?=
 =?gb2312?B?S1lCenpyWUlHbFhVZzZZQldGNzFsVDRHMGxEZnlGRjh6dk1kazROb1V1QVFo?=
 =?gb2312?B?UDczT0o1cUJzellMbFFzQkVlS2lLMGx1T01jWkZJQkxyN24xRk5LWi91ZUZB?=
 =?gb2312?B?bVc4bGF4L3YvK0twam9lV1BKSDhlTGFWMThQM2c1cnV6L29kQndxeUpCY0pr?=
 =?gb2312?B?ZDJNejlUb1BET0YvTDN2SEdMVlVXTDhwanFFRFhIWEpzMEI5a2oxeXdkUjZC?=
 =?gb2312?B?WUphUkdWbC8rRkFMS0x6dXg5bmNHYmd2QXd3UmlNTXVUMWtrT0NOMXJaK0JF?=
 =?gb2312?B?WVA2citvdTY2WXFsbHdvY2M5YUg5aFFidzg1Vi9MTXFPemtVRVgrdDl3amU2?=
 =?gb2312?B?QnNxaTYxTWRFS1MvYTVvcldLOFhVVmJSVWtqWExxU05xcHhxcTNGd3NkZ0lr?=
 =?gb2312?B?U1RhZEtWaDduNWxiSWlMZEloaUhsdkdvQlY1dlROZzYybVV1UkttVEt6cWg1?=
 =?gb2312?Q?T/lo=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f099b62-4f37-4f1f-9873-08db4c93e4b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2023 11:37:08.3515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O4g1Jxr+GnXnnAW0K916BukwRiTmRQTsqk8/9flQlWbPvvaW/e8X8bS8K4okasdYkBYbgFH2FPt3J0KpS0eDdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7598
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBjbGs6IGlteDogaW14OTM6IGludHJvZHVjZSBjbGtfYnlw
YXNzZWQgbW9kdWxlDQo+IHBhcmFtZXRlcg0KPiANCj4gSGVsbG8gUGVuZywNCj4gDQo+IE9uIDA0
LjA1LjIzIDExOjM0LCBQZW5nIEZhbiB3cm90ZToNCj4gID4+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+ID4+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dz
a2lAbGluYXJvLm9yZz4NCj4gPj4gU2VudDogMjAyM8TqNdTCNMjVIDE3OjMxDQo+ID4+IFRvOiBQ
ZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47IEdyZWcgS0ggPGdyZWdAa3JvYWguY29tPjsgUGVu
Zw0KPiBGYW4NCj4gPj4gKE9TUykgPHBlbmcuZmFuQG9zcy5ueHAuY29tPjsgUm9iIEhlcnJpbmcg
PHJvYmgrZHRAa2VybmVsLm9yZz47DQo+ID4+IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJv
Lm9yZw0KPiA+PiBDYzogYWJlbHZlc2FAa2VybmVsLm9yZzsgbXR1cnF1ZXR0ZUBiYXlsaWJyZS5j
b207IHNib3lkQGtlcm5lbC5vcmc7DQo+ID4+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJA
cGVuZ3V0cm9uaXguZGU7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4gPj4gZmVzdGV2YW1A
Z21haWwuY29tOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgbGludXgtDQo+ID4+
IGNsa0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsgbGludXgtDQo+ID4+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gU3ViamVjdDogUmU6
IFtQQVRDSF0gY2xrOiBpbXg6IGlteDkzOiBpbnRyb2R1Y2UgY2xrX2J5cGFzc2VkIG1vZHVsZQ0K
PiA+PiBwYXJhbWV0ZXINCj4gPj4NCj4gPj4gT24gMDQvMDUvMjAyMyAxMToxNywgUGVuZyBGYW4g
d3JvdGU6DQo+ID4+PiArIERUIG1haW50YWluZXJzLg0KPiA+Pj4NCj4gPj4+PiBTdWJqZWN0OiBS
ZTogW1BBVENIXSBjbGs6IGlteDogaW14OTM6IGludHJvZHVjZSBjbGtfYnlwYXNzZWQgbW9kdWxl
DQo+ID4+Pj4gcGFyYW1ldGVyDQo+ID4+Pj4NCj4gPj4+PiBPbiBUaHUsIE1heSAwNCwgMjAyMyBh
dCAwNDo1NTowNlBNICswODAwLCBQZW5nIEZhbiAoT1NTKSB3cm90ZToNCj4gPj4+Pj4gRnJvbTog
UGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4+Pj4+DQo+ID4+Pj4+IFdpdGggdGhlIGNs
ayBuYW1lcyBzcGVjaWZpZWQgaW4gY2xrX2J5cGFzc2VkIG1vZHVsZSBwYXJhbWV0ZXIsDQo+ID4+
Pj4+IGdpdmUgdXNlciBhbiBvcHRpb24gdG8gYnlwYXNzIHRoZSBjbGsgZnJvbSBtYW5hZ2luZyB0
aGVtIGJ5IExpbnV4DQo+IGtlcm5lbC4NCj4gPj4+Pg0KPiA+Pj4+IEFzIEkgc2FpZCBvbiBhbm90
aGVyIGVtYWlsLCBubywgcGxlYXNlIGRvIG5vdCBhZGQgbmV3IG1vZHVsZQ0KPiA+Pj4+IHBhcmFt
ZXRlcnMgZm9yIGRyaXZlcnMsIHRoaXMgaXMgbm90IHRoZSAxOTkwcw0KPiA+Pj4NCj4gPj4+IG9r
LCBidXQgdGhpcyBpcyBmb3IgYm9vdCwgc28gb25seSBEVCBjb3VsZCBiZSBjb25zaWRlcmVkLg0K
PiA+Pj4NCj4gPj4+IEJ1dCBEVCBpcyB0byBkZXNjcmliZSBoYXJkd2FyZSwgaGVyZSBJIGp1c3Qg
d2FubmEgZ2l2ZSB1c2VyIGFuDQo+ID4+PiBvcHRpb24gdG8gYnlwYXNzIHNvbWUgY2xvY2tzLiBJ
cyBpdCBvayB0byBhZGQgYSBEVCBwcm9wZXJ0eSBzYXlpbmcNCj4gPj4+ICJmc2wsaW14OTMtYnlw
YXNzLWNsa3MgPSA8SU1YOTNfQ0xLX1g+LCA8SU1YOTNfQ0xLX1k+IiA/DQo+ID4+Pg0KPiA+Pg0K
PiA+PiBJIGRvbid0IGtub3cgd2hhdCBpdCBpcyB0byAiYnlwYXNzIHNvbWUgY2xvY2tzIi4gVGhp
cyBkb2VzIG5vdCBsb29rDQo+ID4+IGxpa2UgcGFyYW1ldGVyIGZvciBzeXN0ZW0gYXQgYWxsLg0K
PiA+DQo+ID4gQ3VycmVudGx5IHRoZSBsaW51eCBjbGsgZHJpdmVyIHJlZ2lzdGVycyBhbGwgdGhl
IGNsb2NrcyBhbmQgbWFuYWdlIHRoZW0uDQo+ID4gQnV0IHdoZW4gTTMzIGlzIHJ1bm5pbmcsIE0z
MyBtYXkgbm90IHdhbm5hIGxpbnV4IHRvIG1hbmFnZSBzb21lDQo+IGNsb2Nrcw0KPiA+IE0zMyBp
cyB1c2luZy4gU28gSSB3YW5uYSBsaW51eCBub3QgcmVnaXN0ZXIgdGhvc2UgY2xvY2tzIHRoYXQg
TTMzIHdpbGwNCj4gPiB1c2UuDQo+IA0KPiBEZXNjcmliZSB0aGUgTTMzIGluIHRoZSBEVCwgYXNz
aWduIGl0IHRoZSBjbG9ja3MgaXQgZGVwZW5kcyBvbiBhbmQgaGF2ZSBhDQo+IGRyaXZlciBiaW5k
IHRvIGl0IHRoYXQganVzdCBjbGFpbXMgdGhlIGNsb2NrcyBpbiBxdWVzdGlvbiB0byBlbnN1cmUg
bm90aGluZyBlbHNlDQo+IG1lc3NlcyB3aXRoIGl0Pw0KDQpIbW0uIFdoZW4gTTMzIGlzIGJvb3Rl
ZCBieSBST00gb3IgVS1Cb290LCBqdXN0IGNsYWltIHRoZSBjbG9ja3MgDQptYXkgbm90IGhlbHAs
IGJ1dCBpdCBtYXkgaGVscCBpZiBwYXJzZSB0aGUgbTMzIGNsb2NrIGZyb20gY2xvY2sgZHJpdmVy
IGFuZA0KZW5hYmxlIHRoZW0uDQoNCk0zMyBjbG9ja3MgbWF5IHZhcnkgYmFzZWQgb24gZGlmZmVy
ZW50IHVzZWNhc2UgKDogDQoNClJlZ2FyZHMsDQpQZW5nLg0KDQo+IA0KPiBDaGVlcnMsDQo+IEFo
bWFkDQo+IA0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IFBlbmcuDQo+ID4NCj4gPj4NCj4gPj4gQmVz
dCByZWdhcmRzLA0KPiA+PiBLcnp5c3p0b2YNCj4gPg0KPiANCj4gLS0NCj4gUGVuZ3V0cm9uaXgg
ZS5LLiAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwNCj4gU3RldWVyd2FsZGVyIFN0ci4gMjEgICAgICAgICAgICAgICAgICAgICAgIHwNCj4g
aHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHAl
M0ElMkYlMkZ3d3cuDQo+IHBlbmd1dHJvbml4LmRlJTJGJmRhdGE9MDUlN0MwMSU3Q3BlbmcuZmFu
JTQwbnhwLmNvbSU3QzhmY2VmM2QxYw0KPiA1ODM0Y2RhMjg0ZDA4ZGI0Yzg2ZWY3NSU3QzY4NmVh
MWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCUNCj4gN0MwJTdDNjM4MTg3OTE0NjQ3MTky
NjkzJTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUMNCj4gNHdMakF3TURBaUxDSlFJ
am9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MzMDAwDQo+ICU3QyU3
QyU3QyZzZGF0YT1GVE9lTlZSdExRbXQ5ZUFTbGJLbEV5dnc2bVh5ZERhcDRpM3ZZcEglMkZmUg0K
PiBrJTNEJnJlc2VydmVkPTAgIHwNCj4gMzExMzcgSGlsZGVzaGVpbSwgR2VybWFueSAgICAgICAg
ICAgICAgICAgIHwgUGhvbmU6ICs0OS01MTIxLTIwNjkxNy0wICAgIHwNCj4gQW10c2dlcmljaHQg
SGlsZGVzaGVpbSwgSFJBIDI2ODYgICAgICAgICAgIHwgRmF4OiAgICs0OS01MTIxLTIwNjkxNy01
NTU1IHwNCg0K
