Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3940E69C418
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 03:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjBTCPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 21:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjBTCPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 21:15:52 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2086.outbound.protection.outlook.com [40.107.249.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830A2A277;
        Sun, 19 Feb 2023 18:15:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfG4fNXnTeIUG8g/NzFggLzvop5NiRKls4sY++9Vi7kI/G6ZUPwHc1XlIa64RCu9GbFRGcUWtIgJEwv4F3VYgOmv01Hw/gGbFyADlYyLc3L9u6P4SDr0d/uZi5g3WtCN/5tksEDrpqFrLLV4yQ7rzLQYIlNqiEjwzD6JK+neT23T49NYgJnO1c+q/GhIIgeZ5PtnsmVgFV8ZJT2oD6QTJHen6Nep5HPQcvIKVPXiH9Eus85A0nbgaSHQ7vI/vvTpIXBauUSpAKhAHtpWugte7UpmVNSbdftno8wANMrOiXnRehIVNsrRUMxOwU0ky9b0sJdo/yKFOuyhAV75LmJybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvo/TdW4zE4aEwAfHDssFSCqmzSdVccB49ts0pGz2t8=;
 b=eoXVxcGRdN1KRb5wBLrqFN6BmUsVs46QxUWOVAofKV+BI7GHTrADzafjeXNkgpv2s4A2nrOOQ42JfjHnCN82CfYE7gn3UquiVJiYG0MPwTcLv/n8IUyJxpvZq7jJZLUt4A0S3fajxvnIhUgyLU8oE2wrshm0ESt3PXzXMImAxOa1EY2FGlSOyqJddx29+L99vkUNN5PNM8o52f9lSyIFTgYLF322GITsslL/rE7Yux9fSx6l6bUpdlR4iSP9mtRQuZMBduoYzvPWzE+B9dOcfOLmvYJxLLys6hTfiEVoVN4Ahh2DnH6DkQIm//XrGQMLygrmBBi1B12mX+776rqvxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvo/TdW4zE4aEwAfHDssFSCqmzSdVccB49ts0pGz2t8=;
 b=aSNzhPkTasdWs7CzRwSHx+RC1nZprRtvOMzAdkn7a/tW7hxYKAxylJxYyP5rPiJHPc3eXaDN9l32cQ+8e6dFjvnfOAz36B2E0coQAoOlUCTFI5K5XAZo1QUEm1UA3fu0awTKWoTVU0PRQPySe8ElzLoW+JhjfKWF7pn7wkTzbZI=
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VE1PR04MB7408.eurprd04.prod.outlook.com (2603:10a6:800:1b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 02:15:48 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::89aa:9204:790d:e46b%5]) with mapi id 15.20.6111.018; Mon, 20 Feb 2023
 02:15:47 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "nicolas@ndufresne.ca" <nicolas@ndufresne.ca>
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
Subject: RE: [PATCH v3 03/10] media: Add YUYV64_12 video format
Thread-Topic: [PATCH v3 03/10] media: Add YUYV64_12 video format
Thread-Index: AQHZQFs+JrSKpLxKnkayok570LdnN67VRamAgAHbLqA=
Date:   Mon, 20 Feb 2023 02:15:47 +0000
Message-ID: <AM6PR04MB6341F28B0116C2263DFB9ED0E7A49@AM6PR04MB6341.eurprd04.prod.outlook.com>
References: <cover.1676368610.git.ming.qian@nxp.com>
 <f5ef51d5e0ce881501a3d72a8e49c8a040fc64f6.1676368610.git.ming.qian@nxp.com>
 <b734fa87-c3ca-5c21-d8ce-ad5083461200@oss.nxp.com>
In-Reply-To: <b734fa87-c3ca-5c21-d8ce-ad5083461200@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6341:EE_|VE1PR04MB7408:EE_
x-ms-office365-filtering-correlation-id: 995b8712-b8bb-4c05-c163-08db12e86149
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QSvyM2P+0OoPO5uoqt+xAjRvex+6i/LSUXPXLTTaoBqWW16UWo3GjxAtcR5pgrN26GiGLzD2Cdgyo2WfyCXc9zrj14AAv6eFr4thpXvuFFXITJLo4iFzTNVWciQlkAl8wjeJqMXRnycVPDHkqIkk1mtUo1Q/VETgE8C9a6Qvr4lzTFGTMyDHrArsPXExKxYTl9of/iRUggj9gP7mkbA899chf5CSj85knjEuOwEqKxoJGzhHpBjF/XAHYxxWMs1Mz71AyYTAhoxx4+fli3EW//xe/3PX9aT8wsFICPMANod/BHpNTwlAeg+bIQk7V3jY/OYGQIvRk9oHhWow74tnoARgn3QpK8xZKGMOOrov6axdk5k+o/nWR4YMcr5WsguUkclZ4zCbixFfGNaawM6XnSJbBjt48xEfQ7QlUyqFZniVNg1WxTHW4fyJA4Gfeb1vjvT1vrfhV1MKPIfS7jrLg2DLspgfMD5NdUpLkVS3msks2zbebtUsPd8CJ2M70wifqFKifYc8GbXaIs8O+fmT6AIlAVOWOeuWqaYytIiivT3hhPVY/XGU7+bXVKfMZo0b4PiJpyO66tkyT7w4MhZHY38sZ5Vo/wihFhaB6v2mAUr1zto3Fnt0hqEXgZA70t/DsIyinHgUZeDH/Xw5hI0W8go5C8MyVao7mT3nRszar93tajd38rbPlZKtqMHwjvBIS6SqeP6KW1CvBUskpFaypw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39850400004)(366004)(376002)(346002)(396003)(451199018)(5660300002)(44832011)(7416002)(86362001)(33656002)(2906002)(38100700002)(122000001)(7696005)(71200400001)(478600001)(26005)(9686003)(186003)(55016003)(38070700005)(66946007)(76116006)(110136005)(66556008)(316002)(54906003)(41300700001)(4326008)(8676002)(64756008)(52536014)(8936002)(83380400001)(66446008)(6506007)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clNQdmZRR2VlQVllNzVxNVMwWUhZTGgwY2dBSW5zYVZuTEJnQmhvb3J2TFpM?=
 =?utf-8?B?VkdUNUlUQ0ZzY0xVWEZhUFJLdk9mTkRkRVdhdWpUSmxBZWdBQUIzSTZ5clRr?=
 =?utf-8?B?RjZ0ODlSTCtuamMxYy93dUs3VG9kQXlTWHQzbVRqa2xMUFNPMWZ5UVhMY1Uz?=
 =?utf-8?B?cU1JOE9vZ2dsc09taUo5cmZVYjRORVVxcmxJZk9WaTJYTHZnN0M0UzY1djFj?=
 =?utf-8?B?WVVVdUY2S052VUlQUHdCaHhDdHpaaUlLZHBySGh4NUJmZU56V1RuL0Y4SnlP?=
 =?utf-8?B?Y2tobWN5UlpJK2lJTHc4cnhJM3lpeWtJNmdmWWo4ejBQdkFwbU96d1dTTWxX?=
 =?utf-8?B?VDlwTlU2aXNsTTI4Ny9VTEVaQ1o0ZlNMSE5uQTJXeFI0K3VxaFNqM1R2U0ZK?=
 =?utf-8?B?V0VaV2FiUUhwRks3Z2NmZXJGdSt5bmovbTcrcTFNeXJTQXExd2k0c0xoR2ha?=
 =?utf-8?B?Tk94UzZaQm8rN0twUmZxVytIN0YycUk0SjY1S2ZiTFU2U25GMmJzcitybyt5?=
 =?utf-8?B?c0lOeGs4K1phNWltQkdWQW8yOHBpYlJRSm1XeXM0M2tkTFlzMUFFRnFpREtP?=
 =?utf-8?B?bnJCc3hKb2lnTmk4QlQvaERZQy84Wm1MeUFTbEpNdmE5VUwxcjFqWDJpTXEz?=
 =?utf-8?B?alEzbjNpWk5Vc3NhWXcyWVhpNk5hNllNM3VMamd3TzMwVFVOKzVoVDZIbXc1?=
 =?utf-8?B?dTN6Y3hiOVBCZk5ERzd2NTVFeHI2ajBRRDlnV1kvWklLVVJCeVJ5K1Evb0M1?=
 =?utf-8?B?Z2N2MllmZ1NyZ3JVWlRNUFFseldZSFlkZlgzN0RqWkN2cUczVmpnUlF3aWhN?=
 =?utf-8?B?WjdlOEhNVENUMlM4YlYyUEVJcExoUWM3Z2lja3doRXBZZE5rdm51ZWdWM2NK?=
 =?utf-8?B?SDk0Q1dXR0lTZ1NtcjlMaFB4NGlKTzZEbUt4dFFsMVhPeGJTL0lyaGxXVCtv?=
 =?utf-8?B?bHVKZkE3L0hGRjlsQjNjRzM2MTRVRWhES0hjWlNVbytmRk1MT3dIY3hKamh5?=
 =?utf-8?B?VDIydzlqMUZlWkZIWXdnZ1krNVJtQTEwall4YmVZb0o2SGszVjF2cEd2eWUx?=
 =?utf-8?B?SzQ0eHR3VEh5WjBnbjZYZ0daWk1LRzJZMW5LaXBFZVlhU0dFcGJQWUI1YzJZ?=
 =?utf-8?B?UU02NittNlRrOWRlNXNTWDhjZjV1ZUZGNHNLZjN6T1o1citkTGczRC9ZUTdG?=
 =?utf-8?B?OURuYTVKeVNIQnA2RW1qdi9vZk53NGxObFhXL1hKSlFSQWVHcXM2M3dKUkpC?=
 =?utf-8?B?c0U0WTBOaDVtRXp0QTg5VHJDMWNLOU0rakpuMXZUZHFlcWtvVzFDNzJNYml3?=
 =?utf-8?B?RWpOelFtbE5GOU4zbGVBNmJ4S1lqTEpWcElZVDMzUVVFY04vZDQ4My9xRjEw?=
 =?utf-8?B?SG9PZjRSclkzTE95RHQySVNURk53YVYvVEJiRTAydTF3SHlmaGsvSkV4S3Fq?=
 =?utf-8?B?TGVjTlFESkR5YU4vdFNTdk9sSkVxem1iU2s2dGRudVN2SzhyVTdPN1o3R0px?=
 =?utf-8?B?UURodEtPOWxWTWkrVDFnbFZlUzRHWWFtTCtXWUo4Y1NCTTBPVjVYMjlaR0xG?=
 =?utf-8?B?NXdVTXAxMzJPdnNFRzF1dG1yNGFFaksxNHV2OTlNTHJCS3hZN0Z5NGh4Ujc3?=
 =?utf-8?B?T3ZGMkZKNVZsaEl6YUhKaVU3S2ZTNHRmQ0ZjTHp2YnBlUVQrdWpCSmpBK3BI?=
 =?utf-8?B?bnFMVCtDL05oL05kVG9uMUx1aTRBaUZrcVV5dWgxcWZzb28xRGx6UzQwWGJW?=
 =?utf-8?B?eWRpUHgralFWcy9BdW1TQ2ZZa2g1UmgzaUJyRjM1VzJtWXVIVVlWbVc3THdD?=
 =?utf-8?B?Y25xR1NTZThtYmxRcnhEbnpZT1JjOGNkRVBCY3NJUlBKQjBia0VtR2RqTVZz?=
 =?utf-8?B?K3Vqc0QwL1AzQnE3dTUyaXNsdnowRW1CY0tuWkVKNmtSdXpjMGI5L0Nwei9M?=
 =?utf-8?B?WTFOYkJzYVJjOFJxS1NoN3l3ZHg5Nk0rN0RoSGRpUko5bFM1akc5Zmd4aDNT?=
 =?utf-8?B?cnkveS84V1AzNmIrRGl4WnZuRmMraXlhS2VreVJsMFN0TFhXbmhTZE5kck5R?=
 =?utf-8?B?NW9lY2xPVmpCYnBmalNUbnNzQjlGRjQ0OXp5RENHM1piNDJoNW1CTUoxSENl?=
 =?utf-8?Q?LqnM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995b8712-b8bb-4c05-c163-08db12e86149
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 02:15:47.6524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q8pIzH4rBe36yRWaUHHYW28AevIxc97dksLVi7IzJwT+KS0CSGbrRMuyCU6FobHSV55KjH91lFJw4gLQrwFrSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7408
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PkZyb206IE1pcmVsYSBSYWJ1bGVhIChPU1MpIDxtaXJlbGEucmFidWxlYUBvc3MubnhwLmNvbT4N
Cj5TZW50OiAyMDIz5bm0MuaciDE55pelIDU6NTINCj5UbzogTWluZyBRaWFuIDxtaW5nLnFpYW5A
bnhwLmNvbT47IG1jaGVoYWJAa2VybmVsLm9yZzsgaHZlcmt1aWwtDQo+Y2lzY29AeHM0YWxsLm5s
OyBuaWNvbGFzQG5kdWZyZXNuZS5jYQ0KPkNjOiBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVy
QHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+ZmVzdGV2YW1AZ21haWwu
Y29tOyBYLkguIEJhbyA8eGlhaG9uZy5iYW9AbnhwLmNvbT47IGRsLWxpbnV4LWlteCA8bGludXgt
DQo+aW14QG54cC5jb20+OyBsaW51eC1tZWRpYUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7DQo+ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMDMv
MTBdIG1lZGlhOiBBZGQgWVVZVjY0XzEyIHZpZGVvIGZvcm1hdA0KPg0KPkhpLA0KPg0KPk9uIDE0
LjAyLjIwMjMgMTI6MDQsIE1pbmcgUWlhbiB3cm90ZToNCj4+IFlVWVY2NF8xMiBpcyBhIFlVViBm
b3JtYXQgd2l0aCAxMi1iaXRzIHBlciBjb21wb25lbnQgbGlrZSBZVVlWLA0KPj4gZXhwYW5kZWQg
dG8gMTZiaXRzLg0KPj4gRGF0YSBpbiB0aGUgMTIgaGlnaCBiaXRzLCB6ZXJvcyBpbiB0aGUgNCBs
b3cgYml0cywgYXJyYW5nZWQgaW4gbGl0dGxlDQo+PiBlbmRpYW4gb3JkZXIuDQo+Pg0KPj4gU2ln
bmVkLW9mZi1ieTogTWluZyBRaWFuIDxtaW5nLnFpYW5AbnhwLmNvbT4NCj4+IC0tLQ0KPj4gICAu
Li4vbWVkaWEvdjRsL3BpeGZtdC1wYWNrZWQteXV2LnJzdCAgICAgICAgICAgfCA0MiArKysrKysr
KysrKysrKysrKysrDQo+PiAgIGRyaXZlcnMvbWVkaWEvdjRsMi1jb3JlL3Y0bDItY29tbW9uLmMg
ICAgICAgICB8ICAxICsNCj4+ICAgZHJpdmVycy9tZWRpYS92NGwyLWNvcmUvdjRsMi1pb2N0bC5j
ICAgICAgICAgIHwgIDEgKw0KPj4gICBpbmNsdWRlL3VhcGkvbGludXgvdmlkZW9kZXYyLmggICAg
ICAgICAgICAgICAgfCAgMSArDQo+PiAgIDQgZmlsZXMgY2hhbmdlZCwgNDUgaW5zZXJ0aW9ucygr
KQ0KPj4NCj4+IGRpZmYgLS1naXQNCj4+IGEvRG9jdW1lbnRhdGlvbi91c2Vyc3BhY2UtYXBpL21l
ZGlhL3Y0bC9waXhmbXQtcGFja2VkLXl1di5yc3QNCj4+IGIvRG9jdW1lbnRhdGlvbi91c2Vyc3Bh
Y2UtYXBpL21lZGlhL3Y0bC9waXhmbXQtcGFja2VkLXl1di5yc3QNCj4+IGluZGV4IGJmMjgzYTFi
NTU4MS4uNzZmYzMzMWYxMjZlIDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi91c2Vyc3Bh
Y2UtYXBpL21lZGlhL3Y0bC9waXhmbXQtcGFja2VkLXl1di5yc3QNCj4+ICsrKyBiL0RvY3VtZW50
YXRpb24vdXNlcnNwYWNlLWFwaS9tZWRpYS92NGwvcGl4Zm10LXBhY2tlZC15dXYucnN0DQo+PiBA
QCAtMzQxLDYgKzM0MSw0OCBAQCBjb21wb25lbnRzIGhvcml6b250YWxseSBieSAyLCBzdG9yaW5n
IDIgcGl4ZWxzIGluIDQNCj5ieXRlcy4NCj4+DQo+PiAgICAgICBcbm9ybWFsc2l6ZQ0KPj4NCj4+
ICtUaGUgbmV4dCBsaXN0cyB0aGUgcGFja2VkIFlVViA0OjI6MiBmb3JtYXRzIHdpdGggbW9yZSB0
aGFuIDggYml0cyBwZXINCj5jb21wb25lbnQuDQo+PiArZXhwYW5kIHRoZSBiaXRzIHBlciBjb21w
b25lbnQgdG8gMTYgYml0cywgZGF0YSBpbiB0aGUgaGlnaCBiaXRzLA0KPj4gK3plcm9zIGluIHRo
ZSBsb3cgYml0cywgYXJyYW5nZWQgaW4gbGl0dGxlIGVuZGlhbiBvcmRlci4gc3RvcmluZyAyIHBp
eGVscyBpbiA4DQo+Ynl0ZXMuDQo+PiArDQo+PiArLi4gcmF3OjogbGF0ZXgNCj4+ICsNCj4+ICsg
ICAgXGZvb3Rub3Rlc2l6ZQ0KPj4gKw0KPj4gKy4uIHRhYnVsYXJjb2x1bW5zOjoNCj4+DQo+K3xw
ezMuNGNtfXxwezEuMmNtfXxwezAuOGNtfXxwezAuOGNtfXxwezAuOGNtfXxwezAuOGNtfXxwezAu
OGNtfXxwezAuOA0KPj4gK2NtfXxwezAuOGNtfXxwezAuOGNtfXwNCj4+ICsNCj4+ICsuLiBmbGF0
LXRhYmxlOjogUGFja2VkIFlVViA0OjI6MiBGb3JtYXRzIChtb3JlIHRoYW4gOGJwYykNCj4+ICsg
ICAgOmhlYWRlci1yb3dzOiAxDQo+PiArICAgIDpzdHViLWNvbHVtbnM6IDANCj4+ICsNCj4+ICsg
ICAgKiAtIElkZW50aWZpZXINCj4+ICsgICAgICAtIENvZGUNCj4+ICsgICAgICAtIEJ5dGUgMS0w
DQo+PiArICAgICAgLSBCeXRlIDMtMg0KPj4gKyAgICAgIC0gQnl0ZSA1LTQNCj4+ICsgICAgICAt
IEJ5dGUgNy02DQo+PiArICAgICAgLSBCeXRlIDktOA0KPj4gKyAgICAgIC0gQnl0ZSAxMS0xMA0K
Pj4gKyAgICAgIC0gQnl0ZSAxMy0xMg0KPj4gKyAgICAgIC0gQnl0ZSAxNS0xNA0KPj4gKyAgICAq
IC4uIF9WNEwyLVBJWC1GTVQtWVVZVjY0LTEyOg0KPj4gKw0KPj4gKyAgICAgIC0gYGBWNEwyX1BJ
WF9GTVRfWVVZVjY0XzEyYGANCj4+ICsgICAgICAtICdZMjEyJw0KPj4gKw0KPj4gKyAgICAgIC0g
WSdcIDpzdWI6YDBgDQo+PiArICAgICAgLSBDYlwgOnN1YjpgMGANCj4+ICsgICAgICAtIFknXCA6
c3ViOmAxYA0KPj4gKyAgICAgIC0gQ3JcIDpzdWI6YDBgDQo+PiArICAgICAgLSBZJ1wgOnN1Yjpg
MmANCj4+ICsgICAgICAtIENiXCA6c3ViOmAyYA0KPj4gKyAgICAgIC0gWSdcIDpzdWI6YDNgDQo+
PiArICAgICAgLSBDclwgOnN1YjpgMmANCj4+ICsNCj4+ICsuLiByYXc6OiBsYXRleA0KPj4gKw0K
Pj4gKyAgICBcbm9ybWFsc2l6ZQ0KPj4gKw0KPj4gICAqKkNvbG9yIFNhbXBsZSBMb2NhdGlvbjoq
Kg0KPj4gICBDaHJvbWEgc2FtcGxlcyBhcmUgOnJlZjpgaW50ZXJzdGl0aWFsbHkgc2l0ZWQ8eXV2
LWNocm9tYS1jZW50ZXJlZD5gDQo+PiAgIGhvcml6b250YWxseS4NCj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL21lZGlhL3Y0bDItY29yZS92NGwyLWNvbW1vbi5jDQo+PiBiL2RyaXZlcnMvbWVkaWEv
djRsMi1jb3JlL3Y0bDItY29tbW9uLmMNCj4+IGluZGV4IGE1ZThiYTM3MGQzMy4uOGZiMWMwZmE4
MTU4IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9tZWRpYS92NGwyLWNvcmUvdjRsMi1jb21tb24u
Yw0KPj4gKysrIGIvZHJpdmVycy9tZWRpYS92NGwyLWNvcmUvdjRsMi1jb21tb24uYw0KPj4gQEAg
LTI1OCw2ICsyNTgsNyBAQCBjb25zdCBzdHJ1Y3QgdjRsMl9mb3JtYXRfaW5mbw0KPip2NGwyX2Zv
cm1hdF9pbmZvKHUzMiBmb3JtYXQpDQo+PiAgIAkJeyAuZm9ybWF0ID0gVjRMMl9QSVhfRk1UX1lW
WVUsICAgIC5waXhlbF9lbmMgPQ0KPlY0TDJfUElYRUxfRU5DX1lVViwgLm1lbV9wbGFuZXMgPSAx
LCAuY29tcF9wbGFuZXMgPSAxLCAuYnBwID0geyAyLCAwLCAwLA0KPjAgfSwgLmhkaXYgPSAyLCAu
dmRpdiA9IDEgfSwNCj4+ICAgCQl7IC5mb3JtYXQgPSBWNEwyX1BJWF9GTVRfVVlWWSwgICAgLnBp
eGVsX2VuYyA9DQo+VjRMMl9QSVhFTF9FTkNfWVVWLCAubWVtX3BsYW5lcyA9IDEsIC5jb21wX3Bs
YW5lcyA9IDEsIC5icHAgPSB7IDIsIDAsIDAsDQo+MCB9LCAuaGRpdiA9IDIsIC52ZGl2ID0gMSB9
LA0KPj4gICAJCXsgLmZvcm1hdCA9IFY0TDJfUElYX0ZNVF9WWVVZLCAgICAucGl4ZWxfZW5jID0N
Cj5WNEwyX1BJWEVMX0VOQ19ZVVYsIC5tZW1fcGxhbmVzID0gMSwgLmNvbXBfcGxhbmVzID0gMSwg
LmJwcCA9IHsgMiwgMCwgMCwNCj4wIH0sIC5oZGl2ID0gMiwgLnZkaXYgPSAxIH0sDQo+PiArCQl7
IC5mb3JtYXQgPSBWNEwyX1BJWF9GTVRfWVVZVjY0XzEyLCAucGl4ZWxfZW5jID0NCj4+ICtWNEwy
X1BJWEVMX0VOQ19ZVVYsIC5tZW1fcGxhbmVzID0gMSwgLmNvbXBfcGxhbmVzID0gMSwgLmJwcCA9
IHsgNCwgMCwNCj4+ICswLCAwIH0sIC5oZGl2ID0gMiwgLnZkaXYgPSAxIH0sDQo+Pg0KPj4gICAJ
CS8qIFlVViBwbGFuYXIgZm9ybWF0cyAqLw0KPj4gICAJCXsgLmZvcm1hdCA9IFY0TDJfUElYX0ZN
VF9OVjEyLCAgICAucGl4ZWxfZW5jID0NCj5WNEwyX1BJWEVMX0VOQ19ZVVYsIC5tZW1fcGxhbmVz
ID0gMSwgLmNvbXBfcGxhbmVzID0gMiwgLmJwcCA9IHsgMSwgMiwgMCwNCj4wIH0sIC5oZGl2ID0g
MiwgLnZkaXYgPSAyIH0sDQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS92NGwyLWNvcmUv
djRsMi1pb2N0bC5jDQo+PiBiL2RyaXZlcnMvbWVkaWEvdjRsMi1jb3JlL3Y0bDItaW9jdGwuYw0K
Pj4gaW5kZXggZWMxYzllZjI3ZTg4Li5lNTAwMmQ2ZmU3ZWUgMTAwNjQ0DQo+PiAtLS0gYS9kcml2
ZXJzL21lZGlhL3Y0bDItY29yZS92NGwyLWlvY3RsLmMNCj4+ICsrKyBiL2RyaXZlcnMvbWVkaWEv
djRsMi1jb3JlL3Y0bDItaW9jdGwuYw0KPj4gQEAgLTEzNDMsNiArMTM0Myw3IEBAIHN0YXRpYyB2
b2lkIHY0bF9maWxsX2ZtdGRlc2Moc3RydWN0IHY0bDJfZm10ZGVzYw0KPipmbXQpDQo+PiAgIAlj
YXNlIFY0TDJfUElYX0ZNVF9ZVVY0MjA6CWRlc2NyID0gIlBsYW5hciBZVVYgNDoyOjAiOyBicmVh
azsNCj4+ICAgCWNhc2UgVjRMMl9QSVhfRk1UX0hJMjQwOglkZXNjciA9ICI4LWJpdCBEaXRoZXJl
ZCBSR0IgKEJUVFYpIjsNCj5icmVhazsNCj4+ICAgCWNhc2UgVjRMMl9QSVhfRk1UX000MjA6CQlk
ZXNjciA9ICJZVVYgNDoyOjAgKE00MjApIjsNCj5icmVhazsNCj4+ICsJY2FzZSBWNEwyX1BJWF9G
TVRfWVVZVjY0XzEyOglkZXNjciA9ICIxMi1iaXQgRGVwdGggWVVZVg0KPjQ6MjoyIjsgYnJlYWs7
DQo+PiAgIAljYXNlIFY0TDJfUElYX0ZNVF9OVjEyOgkJZGVzY3IgPSAiWS9VViA0OjI6MCI7IGJy
ZWFrOw0KPj4gICAJY2FzZSBWNEwyX1BJWF9GTVRfTlYyMToJCWRlc2NyID0gIlkvVlUgNDoyOjAi
OyBicmVhazsNCj4+ICAgCWNhc2UgVjRMMl9QSVhfRk1UX05WMTY6CQlkZXNjciA9ICJZL1VWIDQ6
MjoyIjsgYnJlYWs7DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZpZGVvZGV2
Mi5oDQo+PiBiL2luY2x1ZGUvdWFwaS9saW51eC92aWRlb2RldjIuaCBpbmRleCAzZDhmODliZmYz
M2MuLjM3MTJhMzZkNmZkZg0KPj4gMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgv
dmlkZW9kZXYyLmgNCj4+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC92aWRlb2RldjIuaA0KPj4g
QEAgLTYxOCw2ICs2MTgsNyBAQCBzdHJ1Y3QgdjRsMl9waXhfZm9ybWF0IHsNCj4+ICAgI2RlZmlu
ZSBWNEwyX1BJWF9GTVRfWVVWQTMyICB2NGwyX2ZvdXJjYygnWScsICdVJywgJ1YnLCAnQScpIC8q
IDMyICBZVVZBLTgtDQo+OC04LTggICovDQo+PiAgICNkZWZpbmUgVjRMMl9QSVhfRk1UX1lVVlgz
MiAgdjRsMl9mb3VyY2MoJ1knLCAnVScsICdWJywgJ1gnKSAvKiAzMiAgWVVWWC04LQ0KPjgtOC04
ICAqLw0KPj4gICAjZGVmaW5lIFY0TDJfUElYX0ZNVF9NNDIwICAgIHY0bDJfZm91cmNjKCdNJywg
JzQnLCAnMicsICcwJykgLyogMTIgIFlVViA0OjI6MA0KPjIgbGluZXMgeSwgMSBsaW5lIHV2IGlu
dGVybGVhdmVkICovDQo+PiArI2RlZmluZSBWNEwyX1BJWF9GTVRfWVVZVjY0XzEyICAgdjRsMl9m
b3VyY2MoJ1knLCAnMicsICcxJywgJzInKSAvKiAzMiAgWVVZVg0KPjEyLWJpdCBwZXIgY29tcG9u
ZW50ICovDQo+DQo+SXQgc2VlbXMgWTIxMiBpcyBhbHJlYWR5IGFkZGVkIHdpdGggdGhlIHNhbWUg
Zm91cmNjIGNvZGUsIGNhdXNpbmcgYnVpbGQNCj5lcnJvcnM6DQo+DQo+ZHJpdmVycy9tZWRpYS92
NGwyLWNvcmUvdjRsMi1pb2N0bC5jOiBJbiBmdW5jdGlvbiDigJh2NGxfZmlsbF9mbXRkZXNj4oCZ
Og0KPmRyaXZlcnMvbWVkaWEvdjRsMi1jb3JlL3Y0bDItaW9jdGwuYzoxNDU1Ojk6IGVycm9yOiBk
dXBsaWNhdGUgY2FzZSB2YWx1ZQ0KPiAgMTQ1NSB8ICAgICAgICAgY2FzZSBWNEwyX1BJWF9GTVRf
WTIxMjogICAgICAgICBkZXNjciA9ICIxMi1iaXQgWVVZVg0KPlBhY2tlZCI7IGJyZWFrOw0KPiAg
ICAgICB8ICAgICAgICAgXn5+fg0KPmRyaXZlcnMvbWVkaWEvdjRsMi1jb3JlL3Y0bDItaW9jdGwu
YzoxMzQ5Ojk6IG5vdGU6IHByZXZpb3VzbHkgdXNlZCBoZXJlDQo+ICAxMzQ5IHwgICAgICAgICBj
YXNlIFY0TDJfUElYX0ZNVF9ZVVlWNjRfMTI6ICAgIGRlc2NyID0gIjEyLWJpdCBEZXB0aA0KPllV
WVYgNDoyOjIiOyBicmVhazsNCj4gICAgICAgfCAgICAgICAgIF5+fn4NCj4NCj5SZWdhcmRzLA0K
Pk1pcmVsYQ0KDQpIaSBNaXJlbGEsDQogICAgV291bGQgeW91IHBsZWFzZSBkb3VibGUgY2hlY2sg
aXQ/DQogICAgVGhlIGZvcm1hdCBWNEwyX1BJWF9GTVRfWTIxMiB3YXMgYWRkZWQgYnkgdGhlIGZp
cnN0IHZlcnNpb24gb2YgdGhpcyBwYXRjaHNldCwgYW5kIGl0IHNob3VsZCBiZSByZXBsYWNlZCBi
eQ0KVjRMMl9QSVhfRk1UX1lVWVY2NF8xMiBpbiB0aGlzIHYzIHBhdGNoc2V0Lg0KICAgIEFuZCBJ
IGNoZWNrZWQgbXkgcGF0Y2gsIGFuZCBteSBsb2NhbCBlbnZpcm9ubWVudCwgSSBkaWRuJ3QgZm91
bmQgYW55IFY0TDJfUElYX0ZNVF9ZMjEyLCBhbmQgSSBkaWRuJ3QgbWVldCB0aGlzIGJ1aWxkIGVy
cm9yDQoNCk1pbmcNCg0KPj4NCj4+ICAgLyogdHdvIHBsYW5lcyAtLSBvbmUgWSwgb25lIENyICsg
Q2IgaW50ZXJsZWF2ZWQgICovDQo+PiAgICNkZWZpbmUgVjRMMl9QSVhfRk1UX05WMTIgICAgdjRs
Ml9mb3VyY2MoJ04nLCAnVicsICcxJywgJzInKSAvKiAxMiAgWS9DYkNyDQo+NDoyOjAgICovDQo=
