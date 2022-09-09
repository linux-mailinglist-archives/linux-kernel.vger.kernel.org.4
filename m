Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9053C5B2F69
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbiIIHBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiIIHBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:01:14 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4873BA74EF;
        Fri,  9 Sep 2022 00:01:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mvinx9mFpTYhu51pOXxETbH8CJhEWcOdOr1ZqJK520Hz5WdEbwzgVpZSETEvfwkLpmRVkjHsH3sul2iiro2C5HsJ2Y2K4nxFriCvMovAzvbx38aYe0HSXFYwCbjfjrhwQxpV2pnTYg8mSwqhcb8DguUSkmpLvwtWrhy/cGkcK4xlrLJXCL6s407ZDbZTyAwrkmiaM6rg7T7E3t+rl3hlLJA29Bvpbx9g41FzvpLwuUcvRCJ057NqvgVspy/298FbVNdZ0QzlXKHEi3XJh+2NnYQvnFoHGYvDGsKiMloc0CKv3BnjWVjEl4QW8HdFN8TNUs0aSoJ4eAzprsH2ctXLug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtpwHquEeaMoI8/K4VHhfhhn6rYTV2+E22u6nzRx2+0=;
 b=eWA3e9Z9ZBEd8RJvb3x0FugJ1+XQDpq1tlW03f+ePB6t/3zG3JhUqJePr3MLIVExlp50EmHMyg8bZvQ6NeknUjU2g9q4Rgpa8ej2j45Pi5WOCOD/Q7TMl5dMbbp6UugXvyZzC2ckup1xvKprhrNI6FNnRZq0+jCgAC5Y4knRKssSrusduxw2nJ2Z4Wfvo3rSdHNvAUtLd6z9HiImsOixV3G/vXpTp+qAzecICsGM3tERGG01rUPha8pchrIJnPFQENESvSAPOtn1BkpE4f6W2xTFeRz4JzAl+0BMlV7C3tdUbBwh1aNGe/zkS1CqRE25TlG5ga4RGXhy5H9b4rwq3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtpwHquEeaMoI8/K4VHhfhhn6rYTV2+E22u6nzRx2+0=;
 b=qaBYFZFpzxgpRyb7aNc+xqf4eJCa7uvJvDP1A3/49AvXXQJCl4age6OFvrsxeHOcdVAInPwFnuQPTzBH56yX6b9m98n/2EWB5NbGkG8Tbzde+zXEDj9QVy50AFvEQSPvgAYzajQxqp5PWWngqJx28zcRWR6kmpYQZc2G1QxeWmc=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR0402MB3781.eurprd04.prod.outlook.com (2603:10a6:209:1f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 9 Sep
 2022 07:01:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Fri, 9 Sep 2022
 07:01:08 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Marek Vasut <marex@denx.de>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>
Subject: RE: BD71847 clk driver disables clk-32k-out causing RTC/WDT failure
Thread-Topic: BD71847 clk driver disables clk-32k-out causing RTC/WDT failure
Thread-Index: AQHYvlGBdqdb0Wka20ODtoakwJg21K3LiDmAgAozSACAAA+IgIAAKeoAgAAUeoCAAFoVIIAACWUAgABIzlCAAAFb8A==
Date:   Fri, 9 Sep 2022 07:01:08 +0000
Message-ID: <DU0PR04MB94177C849658BB00B76A2D3A88439@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <CAJ+vNU1Za2CPGVX3q4HKufsxbL5zRrk1B5CWFpKritetrTs4dA@mail.gmail.com>
 <59b6dd0a-7cbb-5dbd-8da0-57baeba3327e@gmail.com>
 <CAJ+vNU2FVQRwCa3DnOwkFjaZg-ntFLZmetwDbSggDXDdwOOGTg@mail.gmail.com>
 <2ab24cc4-4aa2-d364-9b29-55f5d6b23626@denx.de>
 <CAJ+vNU0voeMW06Je6nyrV1Ud3sT8Us+RACcQtsKUwKVaXF+dQw@mail.gmail.com>
 <ce0ffc43-bae7-a55b-ebea-985abc765c33@denx.de>
 <DU0PR04MB9417D8123D40FBC980E9C05388439@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <a03ce7a3-dfa5-6016-afbf-33193a5e2376@denx.de>
 <DU0PR04MB9417919287BF69B2535348CC88439@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB9417919287BF69B2535348CC88439@DU0PR04MB9417.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98a37e4f-58dc-4894-8583-08da9231124b
x-ms-traffictypediagnostic: AM6PR0402MB3781:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wUDJjz5goH3rPHh/+pidimqoI1Wi0SFJ/VOQ3E38avhJtXH6K97erMfJeCBeDv+Qxdy714aIUECpCMOMn6Uxqc0RqEkmfCpEJ9/3TGDOjUUIPz6edzd/4eajll+vkCCKdoHfgx5KqdLA0jobsarF0Ztuch9ykkUGLGA/6E7qZ2k2w45jtuTYmfqkvUpoaS0pacJOSlDcscfe6rK4cv/Teu7QXvXmrvmXeKQWHSx+yRCDwXG2NbikSKyYfeeZydaLWyU4r8fyQPJpvxAQv889Jl/ahpd7/Ff2WOQLa8iGSok2loauNBabVdicLFRBE36drQ9Pd8TmZ5ZtgAO9JS3DF062vnQfFC08HXgEVWppQ+bViP3AXmaKzAF54J+fKYvxL0Z0V8PBiIYYp7ZHLdReujtTa0oubc4MmtIhQxeU5H1J5WAnfbzb+As+7LiDn7QbZ4gV3xbAqpzd1ZOBat3x10H+9rGov+eEocH2RdthAce8KVPP6HH6g+T+Z+p8jKb2O9R01FZYEtPKlDVwHx2mSugymITP0zliMRgP2uTqiS6OyIu8Rz95aJf6woE/BUB1YDr2JOKO6k4H2s1+tHzq8502Llm7intc0ieLJd5iH4LP3h2yAPTN3XVvPyPwe+jIHNFH/xHHlOx6kQWWhcrfB02XJdUPz8TOuOKLIWzLw9ooHWYvBvLBncchMrvFYRSL7oaEEtLm/Xf3858+P3AS/ZJC2z00OOX99IiFA5UecWCo6jrNQXuIebkEvaMaWPkeg50E8Z1iDiI3CK6C+b76sW7jZc43DJDek39AhZX1f2U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(6506007)(8676002)(186003)(54906003)(122000001)(38070700005)(83380400001)(966005)(71200400001)(64756008)(66476007)(66446008)(76116006)(4326008)(316002)(66946007)(45080400002)(110136005)(86362001)(66556008)(2906002)(26005)(9686003)(52536014)(478600001)(41300700001)(8936002)(33656002)(7696005)(53546011)(55016003)(38100700002)(2940100002)(44832011)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VHhZT0tCY3FSQ2NVYnZPK0RXQlJnVHNCek9XcGRGblkzN0NrcHZyYVIxL2tL?=
 =?gb2312?B?d3pOM1BVR05GTU56S25yWHdMSzRQVWEyZTVJVzR6MEErVUFCK0pXTUVjRW1m?=
 =?gb2312?B?aFltUjJ4YXlCUjZWUDI3ZXhrRVErOHExa3RvU05LOVBFQlVKRkxyS2lDWUg1?=
 =?gb2312?B?TUVHcDdPVGNhSm9MQTlGL0x2NTlEL1dsOUJsZyt6Q2xGQlhLZFoyWm4zRm51?=
 =?gb2312?B?dnRrN0FLYWVIempHeGgydGIyZVZPNkV3dW9KeEgwN0NuWUd5Qzh3UXkxRTBF?=
 =?gb2312?B?ZTJlYkdwUWZsck9VUERPYUE3L1hnWWxtK3BLYmZZb2htd01UYktQSnlsdHB6?=
 =?gb2312?B?MlNPMCs0YWs2N0tiSzY1WEJEUTNSMXlZbkkxQUNPVk9qRXZuR0liL1NDVEhP?=
 =?gb2312?B?U3ZHT3ZPQnpJOFRYUnlxaE9iRmUvanhWdkJaOU1ZUTJaRnpFNThXT3pEbDhW?=
 =?gb2312?B?Q2xROWlaU1BOUWNOSHBsWnYyaHY1dGZxYkRLOFlNT0VvRis4RklQYVphT1N6?=
 =?gb2312?B?QUx3dFEvQ3ZuemlkZCs4ZlRTczVWdHlvOGhpWEFDMTAzWmIxaHRjSk1adng0?=
 =?gb2312?B?Q3hIVzJsN0NNU1BwbXU3L0JWakZIS0FHT2hNYWtjRjN1Z2tOTzNjUzgrdUhs?=
 =?gb2312?B?eWJYNHRPVUpzR0F5ajhnam1ZdnpKNXV1b0NJMjh0Q2o1Q3FVRGlUNTZDalF4?=
 =?gb2312?B?cWh0cDNwRmpSZnV5a3graTZueVV4V2w3Mjk3WEJKWHVRNzE0dSsxVEdSYXA3?=
 =?gb2312?B?Vi9GV3FhUDdJNWp1U25MRktYQVpGNnlVZ3ZaTndqQjRyNlorT2s0TUFqN0lh?=
 =?gb2312?B?NVplU0FmYXEvVnowV0VpUlVwTHRRVkRWU1ltRlp5RWJwRWpTQWxmNEpURUxP?=
 =?gb2312?B?U1lrZlZVZEVtYmFScGpGbmRPakdiOTBmL3gzU2tlT0oyUXRpOURBWUUrSlhw?=
 =?gb2312?B?cFVjd3BqQnVNZnMvNy9WRVhjTWE2dXJ6VVJ3TGZWTlVHd2FuQkJFb0tTdjgw?=
 =?gb2312?B?aXFyOXR3cVhtQ3FTbk1ZTlc1WUhxV2xnU3ljZzRqV254V1RCcXR6eEExMGh4?=
 =?gb2312?B?SjZNUGx4eEpPR0JJeWZZMHl5RG56anYrZnBoSVNhamI5djJaOHBNQnl2WEdy?=
 =?gb2312?B?TFhDSWRCVTJ2anR4cGVvcU00NkZsQXBrSDgzK3ZjQUtSODFZWFEzeEhkL2Iz?=
 =?gb2312?B?Y0FCZ2dxdkJ2SmJycmc3UUVVa0U2UEYzMjc1V2ZoT0phV1RsNmNYaWR6cmlK?=
 =?gb2312?B?U3NIOW56NFVFZzVrZ3hEU1l0TUg0NnUwajFleGRLVEI1blJjbEZ4ckdHR1A2?=
 =?gb2312?B?RDltOUt2dWdqdW9ZbkV6QmV1b1N2eklnaHpRRzF3S212U0xXTlM1VEZiRFF2?=
 =?gb2312?B?cC9rNURKY3Q2aW1GUDFpbCtxRy9IVXlLUWxjRDFyL3VLclBXcForNGFGUGFZ?=
 =?gb2312?B?cnM5RkJCa2pFMUcwRXVodkd1ZXljbnJQSDVoc2xZRzhtSjBsNHh2enNIcXQz?=
 =?gb2312?B?NkNQU0hneEZEMGV6dU9UdnBDRDBTOFFEMVJhb2JOU09nc3NVWWlyd3hYbTNr?=
 =?gb2312?B?QWtRaEpFamtzNG9FUWhHTEdBYVg5MVUxZHBSRGpzeEpJZC9nUXpiYVA5QURj?=
 =?gb2312?B?Zzg5K2p4OGpqeEZXbDFxbWdEaFdkcHNWbFFmZWlQOW83dHRIRlJPV3FCdmJl?=
 =?gb2312?B?OFdRR2tFVDAzalVrOG9YaHE1ODBlQ0FSNUJrNmlKbFVVRTRXSHkwaStQNE1w?=
 =?gb2312?B?NjJqQXovQXIyNkVYVUxTSGFiWkZuU0VNR01ubmdyTzVRcmo3aE5oZm5NbFl2?=
 =?gb2312?B?NkJEM2tGZVFtVFpKMC9tNGZ0K2ovdEgyczMzZ29IaEltb2tsZ3BhREUvZzR4?=
 =?gb2312?B?M3VFcngvRUprbm9YVVFMY2N3elZRRnNLWHIwQ1ZXRk1yZi9EdmNDazBjdHow?=
 =?gb2312?B?OCtIZWN0N0ZqWUxLWS9FZWxRaXBpa0ljaWlrUER1NElCNDNIZUNzK0JEOGhS?=
 =?gb2312?B?R3NYbzR3VWVrSVV3UVJzQk1iMFEyZ3pTUEZtaVBxUGtiREExQXpvZjFsdnh2?=
 =?gb2312?B?UEFsZzYxWVlySnhwOGFUOGRHZzUxYmpRd3N2QmVxTHNVY0lobUVrKytGeWZN?=
 =?gb2312?Q?qHCM=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a37e4f-58dc-4894-8583-08da9231124b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2022 07:01:08.3869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6fQpZo6xCeF0eQ5MHr2Rm1lgZ+3DqqHzd2s19xPDcypKH1wgpthb26ByZPOk7mumTGSM5kAVJX5HLf/dAiQa7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3781
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGVuZyBGYW4gPHBlbmcu
ZmFuQG54cC5jb20+DQo+IFNlbnQ6IDIwMjLE6jnUwjnI1SAxNDo1Nw0KPiBUbzogTWFyZWsgVmFz
dXQgPG1hcmV4QGRlbnguZGU+OyB0aGFydmV5QGdhdGV3b3Jrcy5jb207IFN0ZXBoZW4NCj4gQm95
ZCA8c2JveWRAa2VybmVsLm9yZz4NCj4gQ2M6IE1hdHRpIFZhaXR0aW5lbiA8bWF6emllc2FjY291
bnRAZ21haWwuY29tPjsgbGludXgtY2xrIDxsaW51eC0NCj4gY2xrQHZnZXIua2VybmVsLm9yZz47
IG9wZW4gbGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IEZhYmlvDQo+IEVzdGV2
YW0gPGZlc3RldmFtQGdtYWlsLmNvbT47IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz47
IGRsLQ0KPiBsaW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgTWljaGFlbCBUdXJxdWV0dGUN
Cj4gPG10dXJxdWV0dGVAYmF5bGlicmUuY29tPg0KPiBTdWJqZWN0OiBSRTogQkQ3MTg0NyBjbGsg
ZHJpdmVyIGRpc2FibGVzIGNsay0zMmstb3V0IGNhdXNpbmcgUlRDL1dEVCBmYWlsdXJlDQo+IA0K
PiA+IFN1YmplY3Q6IFJlOiBCRDcxODQ3IGNsayBkcml2ZXIgZGlzYWJsZXMgY2xrLTMyay1vdXQg
Y2F1c2luZyBSVEMvV0RUDQo+ID4gZmFpbHVyZQ0KPiA+DQo+ID4gT24gOS85LzIyIDA0OjA2LCBQ
ZW5nIEZhbiB3cm90ZToNCj4gPiA+PiBTdWJqZWN0OiBSZTogQkQ3MTg0NyBjbGsgZHJpdmVyIGRp
c2FibGVzIGNsay0zMmstb3V0IGNhdXNpbmcNCj4gPiA+PiBSVEMvV0RUIGZhaWx1cmUNCj4gPiA+
Pg0KPiA+ID4+IE9uIDkvOC8yMiAyMToyNSwgVGltIEhhcnZleSB3cm90ZToNCj4gPiA+Pj4gT24g
VGh1LCBTZXAgOCwgMjAyMiBhdCA5OjU1IEFNIE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPg0K
PiB3cm90ZToNCj4gPiA+Pj4+DQo+ID4gPj4+PiBPbiA5LzgvMjIgMTg6MDAsIFRpbSBIYXJ2ZXkg
d3JvdGU6DQo+ID4gPj4+Pj4gT24gVGh1LCBTZXAgMSwgMjAyMiBhdCA5OjE0IFBNIE1hdHRpIFZh
aXR0aW5lbg0KPiA+ID4+IDxtYXp6aWVzYWNjb3VudEBnbWFpbC5jb20+IHdyb3RlOg0KPiA+ID4+
Pj4+Pg0KPiA+ID4+Pj4+PiBIaSBUaW0sDQo+ID4gPj4+Pj4+DQo+ID4gPj4+Pj4+IE9uIDkvMi8y
MiAwMToyMywgVGltIEhhcnZleSB3cm90ZToNCj4gPiA+Pj4+Pj4+IEdyZWV0aW5ncywNCj4gPiA+
Pj4+Pj4+DQo+ID4gPj4+Pj4+PiBJJ3ZlIGZvdW5kIHRoYXQgdGhlIGJkNzE4NDcgY2xrIGRyaXZl
cg0KPiA+ID4+IChDT05GSUdfQ09NTU9OX0NMS19CRDcxOFhYDQo+ID4gPj4+Pj4+PiBkcml2ZXJz
L2Nsay9jbGstYmQ3MTh4Ny5jKSBkaXNhYmxlcyBjbGstMzJrLW91dCAodGhlIEJENzE4NDcNCj4g
PiA+Pj4+Pj4+IEMzMktfT1VUDQo+ID4gPj4+Pj4+PiBwaW4pIHdoaWNoIGlzIGNvbm5lY3RlZCBJ
TVg4TU0gUlRDX1hUQUxJIHdoaWNoIGVuZHMgdXANCj4gPiBkaXNhYmxpbmcNCj4gPiA+Pj4+Pj4+
IHRoZSBJTVggUlRDIGFzIHdlbGwgYXMgdGhlIElNWCBXRE9HIGZ1bmN0aW9uYWxpdHkuDQo+ID4g
Pj4+Pj4+DQo+ID4gPj4+Pj4+IC8vc25pcA0KPiA+ID4+Pj4+Pg0KPiA+ID4+Pj4+Pj4gVGhpcyBo
YXBwZW5zIHZpYSBjbGtfdW5wcmVwYXJlX3VudXNlZCgpIGFzIG5vdGhpbmcgaXMgZmxhZ2dpbmcN
Cj4gPiA+Pj4+Pj4+IHRoZSBjbGstMzJrLW91dCBhcyBiZWluZyB1c2VkLiBXaGF0IHNob3VsZCBi
ZSBhZGRlZCB0byB0aGUNCj4gPiA+Pj4+Pj4+IGRldmljZS10cmVlIHRvIHNpZ25pZnkgdGhhdCB0
aGlzIGNsayBpcyBpbmRlZWQgbmVjZXNzYXJ5IGFuZA0KPiA+ID4+Pj4+Pj4gc2hvdWxkDQo+ID4g
bm90IGJlIGRpc2FibGVkPw0KPiA+ID4+Pj4+Pg0KPiA+ID4+Pj4+PiBJIGhhdmUgc2VlbiBmb2xs
b3dpbmcgcHJvcG9zYWwgZnJvbSBNYXJlayBWYXN1dDoNCj4gPiA+Pj4+Pj4NCj4gPiA+Pj4+Pj4N
Cj4gPiA+PiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91
cmw9aHR0cHMlM0ElMkYlMkZsDQo+ID4gPj4+Pj4+IG9yZS5rZXJuZWwub3JnJTJGYWxsJTJGMjAy
MjA1MTcyMzU5MTkuMjAwMzc1LTEtDQo+ID4gPj4gbWFyZXglNDBkZW54LmRlJTJGVCUNCj4gPiA+
Pj4+Pj4NCj4gPiA+Pg0KPiA+DQo+IDJGJTIzbTUyZDZkMDgzMWJmNDNkNWYyOTNlMzVjYjI3ZjMw
MjFmMjc4ZDA1NjQmYW1wO2RhdGE9MDUlN0MwDQo+ID4gPj4gMSU3Q3ANCj4gPiA+Pj4+Pj4NCj4g
PiA+Pg0KPiA+DQo+IGVuZy5mYW4lNDBueHAuY29tJTdDMDdkNDhlZGNjNDdjNDY5NGUwODIwOGRh
OTFkYTJiZjQlN0M2ODZlYTFkDQo+ID4gPj4gM2JjMmINCj4gPiA+Pj4+Pj4NCj4gPiA+Pg0KPiA+
IDRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2Mzc5ODI2NjQxNjI4Njg3ODUlN0NVbmtu
b3duJQ0KPiA+ID4+IDdDVFdGcGINCj4gPiA+Pj4+Pj4NCj4gPiA+Pg0KPiA+DQo+IEdac2IzZDhl
eUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZD
SQ0KPiA+ID4+IDYNCj4gPiA+Pj4+Pj4NCj4gPiA+Pg0KPiA+IE1uMCUzRCU3QzMwMDAlN0MlN0Ml
N0MmYW1wO3NkYXRhPXVGMjZ1OWc0b251cUNXelBSQXZEJTJGJQ0KPiA+ID4+IDJGTEJ5YUVoaDUN
Cj4gPiA+Pj4+Pj4gRHRhaDlLOENjQU9BTSUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiA+ID4+Pj4+Pg0K
PiA+ID4+Pj4+PiBJIGFtIG5vdCBzdXJlIGlmIHRoZSBkaXNjdXNzaW9uIGlzIGNvbXBsZXRlZCB0
aG91Z2guIEkgZ3Vlc3MgaXQNCj4gPiA+Pj4+Pj4gd2FzIGFncmVlZCB0aGlzIHdhcyBuZWVkZWQv
dXNlZnVsbCBhbmQgbWF5YmUgdGhlIHJlbWFpbmluZw0KPiA+ID4+Pj4+PiB0aGluZyB0byBkZWNp
ZGUgd2FzIGp1c3QgdGhlIHByb3BlcnR5IG5hbWluZy4NCj4gPiA+Pj4+Pj4NCj4gPiA+Pj4+Pj4g
QmVzdCBSZWdhcmRzDQo+ID4gPj4+Pj4+ICAgICAgICAgICAgLS0gTWF0dGkNCj4gPiA+Pj4+Pj4N
Cj4gPiA+Pj4+Pg0KPiA+ID4+Pj4+IFRoYW5rcyBNYXR0aSwNCj4gPiA+Pj4+Pg0KPiA+ID4+Pj4+
IE1hcmVrIC0gaGFzIHRoZXJlIGJlZW4gYW55IHByb2dyZXNzIG9uIGRldGVybWluaW5nIGhvdyBi
ZXN0IHRvDQo+ID4gPj4+Pj4ga2VlcCBjZXJ0YWluIGNsb2NrcyBmcm9tIGJlaW5nIGRpc2FibGVk
Pw0KPiA+ID4+Pj4NCj4gPiA+Pj4+IE5vLiBZb3UgY2FuIHJlYWQgdGhlIGRpc2N1c3Npb24gYWJv
dmUuDQo+ID4gPj4+DQo+ID4gPj4+IE1hcmVrLA0KPiA+ID4+Pg0KPiA+ID4+PiBJIHdhc24ndCBv
biB0aGUgbGludXgtY2xrIGxpc3QgYXQgdGhhdCB0aW1lIHNvIGNhbid0IHJlc3BvbmQgdG8NCj4g
PiA+Pj4gdGhlIHRocmVhZCBidXQgdGhlIGRpc2N1c3Npb24gc2VlbXMgdG8gaGF2ZSBkaWVkIG91
dCBhIGNvdXBsZSBvZg0KPiA+ID4+PiBtb250aHMgYWdvIHdpdGggbm8gYWdyZWVtZW50IGJldHdl
ZW4geW91IG9yIFN0ZXBoZW4gb24gaG93IHRvDQo+IGRlYWwgd2l0aCBpdC4NCj4gPiA+Pj4NCj4g
PiA+Pj4gU28gd2hlcmUgZG8gd2UgdGFrZSB0aGlzIGZyb20gaGVyZT8gSXQgbG9va3MgbGlrZSB0
aGVyZSBhcmUgYWJvdXQNCj4gPiA+Pj4gMTggYm9hcmRzIHdpdGggZHQncyB1c2luZyAicm9obSxi
ZDcxOCoiIHdoaWNoIHdvdWxkIGFsbCBoYXZlIG5vbg0KPiA+ID4+PiB3b3JraW5nIFJUQy9XRE9H
IHdpdGggQ09ORklHX0NPTU1PTl9DTEtfQkQ3MThYWCBlbmFibGVkDQo+ID4gKHdoaWNoIGl0IGlz
DQo+ID4gPj4+IGluDQo+ID4gPj4+IGFyY2gvYXJtNjQvY29uZmlncy9kZWZjb25maWcpIHJpZ2h0
Pw0KPiA+ID4NCj4gPiA+IElzIHRoZXJlIGFueSByZXF1aXJlbWVudCB0aGF0IHRoZSBiZDcxOHh4
IGNsayBuZWVkcyB0byBiZSBydW50aW1lDQo+IG9uL29mZj8NCj4gPg0KPiA+IFllcywgdGhlIDMy
a0h6IGNsb2NrIG9uIEJENzF4eHggc2hvdWxkIGJlaGF2ZSBsaWtlIGFueSBvdGhlciBjbG9jaywN
Cj4gPiB1bmxlc3Mgc3BlY2lmaWVkIG90aGVyd2lzZSwgc2VlIGJlbG93Lg0KPiA+DQo+ID4gPiBJ
IHN1cHBvc2UgdGhlIGNsayBzaG91bGQgYWx3YXlzIGJlIG5ldmVyIGJlIG9mZiwgaWYgeWVzLCB3
aHkgbm90DQo+ID4gPiBoYXZlDQo+ID4gc29tZXRoaW5nOg0KPiA+DQo+ID4gV2hhdCBpcyBuZWVk
ZWQgaW4gdGhpcyBzcGVjaWZpYyBjYXNlIG9mIEJENzE4eHggaXMgSSB0aGluayBjbG9jaw0KPiA+
IGNvbnN1bWVyIG9uIHRoZSBNWDhNIGNsb2NrIGRyaXZlciBzaWRlIHdoaWNoIHdvdWxkIGNsYWlt
IHRoZSAzMmtIeg0KPiA+IGlucHV0IGZyb20gdGhlIFBNSUMgYW5kIHVwIHRoZSBjbG9jayBlbmFi
bGUgY291bnQgdG8ga2VlcCB0aGUgMzIga0h6DQo+ID4gY2xvY2sgYWx3YXlzIG9uLiBUaGUgUE1J
QyBpcyBtb3N0IGxpa2VseSBzdXBwbHlpbmcgMzIga0h6IGNsb2NrIHRvIHRoZQ0KPiA+IE1YOE0s
IHdoaWNoIGlmIHRoZSAzMiBrSHogY2xvY2sgYXJlIHR1cm5lZCBvZmYgd291bGQgaGFuZyAoSSBv
YnNlcnZlZA0KPiB0aGF0IGJlZm9yZSB0b28pLg0KPiANCj4gaS5NWDhNIGhhcyBpbnRlcm5hbCAz
MiBLSHogWFRBTCBtb2R1bGUsIHdoeSBuZWVkIGV4dGVybmFsIHBtaWMgMzJLSHoNCj4gZmVlZCBp
bj8NCg0KSWdub3JlIHRoaXMgY29tbWVudCwgaXQgc3RpbGwgbmVlZCBleHRlcm5hbCBvc2MuDQoN
ClJlZ2FyZHMsDQpQZW5nLg0KDQo+IA0KPiBUaGFua3MsDQo+IFBlbmcuDQo+ID4NCj4gPiBXaGF0
IEkgdHJpZWQgdG8gYWRkcmVzcyBpbiB0aGlzIHRocmVhZCBpcyBhIGdlbmVyaWMgcHJvYmxlbSB3
aGljaA0KPiA+IGNvbW1vbmx5IGFwcGVhcnMgb24gdmFyaW91cyBlbWJlZGRlZCBzeXN0ZW1zLCBl
eGNlcHQgZXZlcnkgdGltZQ0KPiBhbnlvbmUNCj4gPiB0cmllZCB0byBzb2x2ZSBpdCBpbiBhIGdl
bmVyaWMgbWFubmVyLCBpdCB3YXMgcmVqZWN0ZWQgb3IgdGhleSBnYXZlIHVwLg0KPiA+DQo+ID4g
VGhlIHByb2JsZW0gaXMgdGhpcyAtLSB5b3UgaGF2ZSBhbiBhcmJpdHJhcnkgY2xvY2ssIGFuZCB5
b3UgbmVlZCB0bw0KPiA+IGtlZXAgaXQgcnVubmluZyBhbHdheXMgb3RoZXJ3aXNlIHRoZSBzeXN0
ZW0gZmFpbHMsIGFuZCB5b3UgZG8gbm90IGhhdmUNCj4gPiBhIGNsb2NrIGNvbnN1bWVyIGluIHRo
ZSBEVCBmb3Igd2hhdGV2ZXIgcmVhc29uIGUuZy4gYmVjYXVzZSB0aGUgU29DIGlzDQo+ID4gb25s
eSB1c2VkIGFzIGEgY2xvY2sgc291cmNlIGZvciBzb21lIHVucmVsYXRlZCBjbG9jayBuZXQuIFRo
ZXJlIG11c3QNCj4gPiBiZSBhIHdheSB0byBtYXJrIHRoZSBjbG9jayBhcyAibmV2ZXIgZGlzYWJs
ZSB0aGVzZSIsIGkuZS4gY3JpdGljYWwtY2xvY2suDQo+ID4gKEkgZmVlbCBsaWtlIEkga2VlcCBy
ZXBlYXRpbmcgdGhpcyBvdmVyIGFuZCBvdmVyIGluIHRoaXMgdGhyZWFkLCBzbw0KPiA+IHBsZWFz
ZSByZWFkIHRoZSB3aG9sZSB0aHJlYWQgYmFja2xvZykNCg==
