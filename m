Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796DC6E3BD9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 22:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjDPUMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 16:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjDPUMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 16:12:43 -0400
Received: from mo-csw.securemx.jp (mo-csw1514.securemx.jp [210.130.202.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D0526A6;
        Sun, 16 Apr 2023 13:12:39 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 33GKCbGl024668; Mon, 17 Apr 2023 05:12:37 +0900
X-Iguazu-Qid: 34trY2IxUpWW3euG1Y
X-Iguazu-QSIG: v=2; s=0; t=1681675957; q=34trY2IxUpWW3euG1Y; m=BS0vo4pEqbaNES6v9HRrz7x9hBtkBsB3he2K29dcAw0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1511) id 33GKCaDP039796
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 17 Apr 2023 05:12:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fblBl7QaFKPEYJsRa+w1Tb83Lltyhu/mLLiwdAeKXJzNIWZhw8Z2njn0kqWtN8gQqmzcWBAE4MemsPZTALmkDXggUqqdhEvRuYJulHK16rItvu6O+VU2nGqsYb5IerdN87L2b5waxmpMQLskYpGE9qRx3gQkgw8DJGWSYugWjx/8EY20gZEeLjKCmNekHBCNjuobA4ZV/bnmCAN2kHpEV5MDjC2z/WBdShZ98iA82QnI1yAtZ7USiHIk8j3ImGMve1Miu1egapWK/sxHYDrQ3pbPNWn/ABg1Sz4FZk4a8Ox41LAa7ffVliZq4Ne9pw3WtDVIHBjDNNVlidTKFN8kpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAoR7cBrKKiyN7RN+qFS16+6bqWB6IXIXSGC3Ti/0cQ=;
 b=hqVywAheNvB/Nui985Iv8d3wwm4ns/IVdJShgvEQ3c8EEpRDtiaRv6XMIyN/Acp3hi+dGrHFbJK+Usn3xcG7MY3rnnY4knQ2KGQ2KsQGvJuh6tujO07FzHVDmKkIV/DVqBe9MhZG468PzdyLqtT07PHEF2LT1migBziJ+P7lMmbSAtLruci9Pvra6onYRyZ+MHTKUMzQrcbUTo4A9iPFUEc+l/fB+pcm9TohJUbqawpCo1eGohIoB2rolCJjtzUWPkIyXyYRmhkB0EvPVr/31XuNf5J3Vb14BGLhksJ4OPSxE7WeOjUloW7ws0PrJxoabQj7k6N1GGI2CievUhUbSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From:   <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     <krzysztof.kozlowski@linaro.org>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <jwerner@chromium.org>,
        <evanbenn@chromium.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <f.fainelli@gmail.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <sander@svanheule.net>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@foss.st.com>, <geert+renesas@glider.be>,
        <magnus.damm@gmail.com>, <fu.wei@linaro.org>, <vireshk@kernel.org>,
        <eugen.hristev@collabora.com>, <justinpopo6@gmail.com>,
        <rafal@milecki.pl>, <linus.walleij@linaro.org>,
        <clabbe@baylibre.com>, <Anson.Huang@nxp.com>,
        <robert.marko@sartura.hr>, <sergio.paracuellos@gmail.com>,
        <quic_saipraka@quicinc.com>, <wsa+renesas@sang-engineering.com>,
        <jamie@jamieiles.com>, <yannick.fertre@foss.st.com>,
        <christophe.roullier@foss.st.com>, <shubhrajyoti.datta@xilinx.com>,
        <srinivas.neeli@xilinx.com>, <linux-watchdog@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 5/6] dt-bindings: watchdog: toshiba,visconti-wdt: simplify
 with unevaluatedProperties
Thread-Topic: [PATCH 5/6] dt-bindings: watchdog: toshiba,visconti-wdt:
 simplify with unevaluatedProperties
Thread-Index: AQHZb4DW/nyKteRfzE6TT61PALyrca8uYDxw
Date:   Sun, 16 Apr 2023 20:12:32 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB9420BB1F19C8EE8B87F92542929F9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230415095112.51257-1-krzysztof.kozlowski@linaro.org>
 <20230415095112.51257-5-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230415095112.51257-5-krzysztof.kozlowski@linaro.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TY3PR01MB11007:EE_
x-ms-office365-filtering-correlation-id: af03b371-85d2-459d-0d57-08db3eb6e995
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wj0duY5uKC7QEELuIhqkWrJDP3vfEEkePcP89hYSDST1L5F8vyh2oC32D69iu9xtu0zZyKPHJ25P8Vlw8snivMC6HgBqmgI/HT/JTfFOYeRX8uMYvObsaW4wewddEmsmL1soJEfovlQ9mZI2Ls0kv93UKacgD7jkVhctZraXrSRLqqyvZyPk3EpNuY6/8OE6ABvcQvaLC7IQfupkA06jvlJ6X/FUX5itX11Oaa4fuNDanQzAFoTx+/Nvzwr7hp8ZUj5a3ZeMu9U7GGP8WN/ZecSerEY6PcFFUmwtsewrk+a+4tNBVeZSSggR3vZGfRilPU88AF1Tt9JrMHS4jkLsBzDyvPWPt1cXuRolQffMMzRBQIBL6QQ1gmqNc3DyK+4GzmwTAT6kWHsZOAnEjnwYn5RLRzDaNF4Y6HnugXJw+uLE+ClFMFQXq4akT832w/iRwuLdzL2DzUJ3J8wgKnA5spYqVpu1FtNBu+2z9yi42KgIR+RFRUG+AC/oOh3UskRaXexamMZUSBNQSQeqNn86a8tz+pjNoHuzciNjCQMNZBeaub7demZv5tFgVFkd2qNb5BjhQnHuuBYCldkrVXt2DKvkFU2tztJl1iUCeNMPJpB4SYozgvdjqukB4gV7p4Q+eWEpqIBQrR+a1O/dXKqqQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(7366002)(7406005)(7416002)(5660300002)(52536014)(86362001)(83380400001)(186003)(26005)(6506007)(9686003)(1191002)(921005)(122000001)(38100700002)(38070700005)(8936002)(8676002)(33656002)(478600001)(110136005)(71200400001)(7696005)(55016003)(41300700001)(316002)(76116006)(64756008)(66446008)(66476007)(66556008)(66946007)(2906002)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlY2T25ucU5Kd0lKQVp0M2U5MlpGeXhWMG1Jamd1Q3Y0bTFaNGRJeHd2MXdn?=
 =?utf-8?B?SDdPdGE0QWhLYnp6bEw4REFXK2lNUmU5MzVCaHJrWm92NUlPaWF5ZWZReTV6?=
 =?utf-8?B?TXlhSFh5UGV1bFQwRlV4TDRpSCtqSWJvTXpnUlk2YmlKcHkyYnNTcUl6TmtI?=
 =?utf-8?B?ZVVIK0xSYXRtbXBuNE5ubWs1eUQ4cVE0dC8vU2dYSU10TGEvdmZIR3U1U0pY?=
 =?utf-8?B?VG5RZlEyZkpJaUJBc0ZNK0UxSlAxZ0ZjcDdua09iaFBzeHlkbTBaczAvV09M?=
 =?utf-8?B?Vy9GQjRQOWhiYTVMbW1lSVN0SkVzNkdYeDJPQ1diRHR1cDhublJiZmhCbjd2?=
 =?utf-8?B?aHQvRUw4ZmNyYXlvQXJhaGsxendoNjNqVmdjdVQvbHdTTmwrRGhzU3dTbnp6?=
 =?utf-8?B?dEZMQjlOOHVZcG9ibG52c1VRaEUraW1zd0x2Vnp6Y1RvSnFKZHAya3k0NWNz?=
 =?utf-8?B?Tytyd21BL1h0N3ZhVnNESnhGdkJPSjRLcyszYnloYTRjaTZuLzczaE9qaDAy?=
 =?utf-8?B?WkhSVWlDbm5sUEp0LzRJeTJxeGUzVmdkNTZVbjFYVUo5VFhTTjQ5SG9XeWEy?=
 =?utf-8?B?TkE3U0R2UjhMUHJKTitSdDNmc1FQY2lvN3psQVphTGZ3bnFHT3Bkdk5FcmZh?=
 =?utf-8?B?NmFSS2dYaEt4bEE0bGphK2hKVEdPMXFGVEJYcDBoSUZWd2R6cm1zaDA4Z3lC?=
 =?utf-8?B?OTF0MVdIR0lYOGRST0hCRW54RjFZZ3FUWUF6NCttckFINS9Fa01SREdBVys0?=
 =?utf-8?B?bDFhODhrWjdpUjZvT1lBem5LWFhKTkptdGpZc1FXTlhJc2MwdUExLzJzVENO?=
 =?utf-8?B?bitaNzl3Ylp3TndJVlMzSTZTeUVCWXZrOWlCVlk5cmdpWDk0VTZXVkF4ajJk?=
 =?utf-8?B?UTdVR3ZGaFoxNGFNdVhGSUhLM29IWVRZUE9kZ2lwdlMyZVBzTmU4R3JXYVZh?=
 =?utf-8?B?dzB3QktnTmZVTFhGbWFGanFUaDdieUl5b25WcUpqYjhSMWQvRWx1blFyd25R?=
 =?utf-8?B?OWZrRGw0U0VCKzdUOHNZdXloYnI4VVZDRHZjMHpaVFdIUnIweEJkUkhuV2tM?=
 =?utf-8?B?NGJNcStSbVFFQ0lQcVRHb05VL3Y2UFROMysxNXNKeEptUFpmQzc5TVFtb3pJ?=
 =?utf-8?B?VmVRVkF0anQ4MVYwRFpjdVdCZXNFVVprVXk4dFFWUkJYYXAxOU1YZmZORllL?=
 =?utf-8?B?R1ZkODhvNEdFaHlIc2cyQU95K0RnS1k5a1h4aGlWUHJJVHR2OXVXMjAvWitP?=
 =?utf-8?B?NlJ1OENqb2V5YThXb0Q1M0NnZkExamdaWGhTdVQyQ2JVMHBGdjdvY1MxZXpC?=
 =?utf-8?B?ZGkwbUI0NElMRzF4amlRNFpNWm9lMkFFYVIwSTVqMERSL216VkpERjhuNlpp?=
 =?utf-8?B?VVlUUjVOQ1RtbTl5SHpuVnV0ZGY5TldWWTEwdmlKRk1PVlFKSXNZTzVjeEQv?=
 =?utf-8?B?MWRTaFcrM3pqR05sYlVKUXVQeDkwbnVkd2VVUEw1L05oSDJxV1R4ZjhHRmtO?=
 =?utf-8?B?eko4RWgzR1BSSDZEK0VFeG52eFhCdDI4WmlZMTFnV21Qb3JjR01LL0FFckgr?=
 =?utf-8?B?a3FkY21aWHJjc1dFQVpNNmhHU1BWUHg0Zmo5ME5iRW1yeGRZRmpJOU4wdzl6?=
 =?utf-8?B?bnZ6Nzh5NjJ1S0JGbzdNMXZxNjBqL1VyamRGcnRFdXR5TGNLSmpGaG5JWnBG?=
 =?utf-8?B?WW9nWjRjbjg1dmdUc2ExdXJIcFRrVTI0UTlBd09Cdk9sSU41WTU1Yllxd05Y?=
 =?utf-8?B?aGUwTGkvRjA0MGcxV0laY1h2V0RZVEEyRzZ0YzgvV1hRcGQvSEVCT2hReTF4?=
 =?utf-8?B?b2UzN1NpSElKZkdhYjcrSFJoUlYyVkZtSlMvS1QwVy9acVdmbnBRWklWMkN1?=
 =?utf-8?B?ZHQ5QnoxbFRQVnVIaWZBbTJIT3htcVdGOWZiNk51YmVOT2NhQzhJRytuNHRQ?=
 =?utf-8?B?MW1GdE5PWGdSdFMwc082ZUM2bDFOendwSVlyNVZNcTZaZTZiWDRWTW9RY0s3?=
 =?utf-8?B?M3N3ZDZyZitwUW80dFZERDZTa3M5dTVhdDZ1NkpVYmMxV3M0bTlYT3J6a2Vm?=
 =?utf-8?B?RGJ0QnZKb1JlbnlsNnFLc3htQ3FhWVNLeVAvZ0pMU1JrcWJxT3pNa1A5N3ZW?=
 =?utf-8?B?dGxwOXRuMTVRZXVQQmlpbzdOVjZZR0FSMEFxSDljUmRkd3Y5VWJSaU5Qd3pM?=
 =?utf-8?B?aHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af03b371-85d2-459d-0d57-08db3eb6e995
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2023 20:12:32.6613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1sriqPVzycidn3s/dBSgKiYHj2knZC4QPk9TCbds6ihWkxeKG9JyULsJVH6PWl2ZENs1o8ZQY6+Ha04XKHJnfDD1d/+qYc5jvb2tO2cSalNQF2IjNDXoBrbXk/vOgo7E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11007
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBbUEFUQ0ggNS82XSBkdC1iaW5kaW5nczogd2F0Y2hkb2c6IHRvc2hpYmEsdmlz
Y29udGktd2R0OiBzaW1wbGlmeQ0KPiB3aXRoIHVuZXZhbHVhdGVkUHJvcGVydGllcw0KPiANCj4g
QWxsb3cgZ2VuZXJpYyB3YXRjaGRvZyBwcm9wZXJ0aWVzIGJ5IHVzaW5nIHVuZXZhbHVhdGVkUHJv
cGVydGllczogZmFsc2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgLi4uL2RldmljZXRy
ZWUvYmluZGluZ3Mvd2F0Y2hkb2cvdG9zaGliYSx2aXNjb250aS13ZHQueWFtbCAgICB8IDQgKy0t
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAzIGRlbGV0aW9ucygtKQ0KDQpB
Y2tlZC1ieTogTm9idWhpcm8gSXdhbWF0c3UgPG5vYnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNv
LmpwPg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQoNCj4gDQo+IGRpZmYgLS1naXQNCj4g
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvd2F0Y2hkb2cvdG9zaGliYSx2aXNj
b250aS13ZHQueWFtbA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy93YXRj
aGRvZy90b3NoaWJhLHZpc2NvbnRpLXdkdC55YW1sDQo+IGluZGV4IGViYTA4MzgyMmQxZi4uNTFk
MDNkNWIwOGFkIDEwMDY0NA0KPiAtLS0NCj4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvd2F0Y2hkb2cvdG9zaGliYSx2aXNjb250aS13ZHQueWFtbA0KPiArKysNCj4gYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvd2F0Y2hkb2cvdG9zaGliYSx2aXNjb250aS13
ZHQueWFtbA0KPiBAQCAtMjQsMTQgKzI0LDEyIEBAIHByb3BlcnRpZXM6DQo+ICAgIGNsb2NrczoN
Cj4gICAgICBtYXhJdGVtczogMQ0KPiANCj4gLSAgdGltZW91dC1zZWM6IHRydWUNCj4gLQ0KPiAg
cmVxdWlyZWQ6DQo+ICAgIC0gY29tcGF0aWJsZQ0KPiAgICAtIHJlZw0KPiAgICAtIGNsb2Nrcw0K
PiANCj4gLWFkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiArdW5ldmFsdWF0ZWRQcm9wZXJ0
aWVzOiBmYWxzZQ0KPiANCj4gIGV4YW1wbGVzOg0KPiAgICAtIHwNCj4gLS0NCj4gMi4zNC4xDQo=

