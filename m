Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6026803B5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 03:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbjA3CEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 21:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbjA3CEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 21:04:32 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F2B1CF7B;
        Sun, 29 Jan 2023 18:04:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwJXtzPcX0ABo45iYeVkG1Q/P+Uf1L18QmCmIUnsqbZNolVXJsZ9rnlsoNVKFHl/e3To1Kc/XMM5o60ugW9o3hGVHWrKNUuLF0Gs0WMVaK21eaw2P4oLz+emBk92ruvowxhqIj9QsTaK+BXh0c9kHFlxceer8jl9KCuftYkDZOawOal4bGnfavjGpchzNBecpVeTGNJRSZMmrWwGm/RBoKQN+93/9H73RdHuUuvknGYbOFPzr0TLsAepSTrQpU6X4ep/M4WKQfyjYRkasKWGbLWq1BeB+TPg+0EKARADT3dhnophwoC99LXq7JF9SRmvbfmagL5MIcMHO18fZRvFkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6H+zyRi/+rQjYNltAQEitJGTD9+x4F/EuwU6IfnDlzI=;
 b=YYZ/4c3Td5a/LGNuBkQdGP+EUz6fYJgclGm+HcpIQXApIF+ylQBsxhHW26ryAiukS17+l4DoG911igc1rSjw3JdDkk1ArdYf2aSCmUmbeeig5Ff2haTC2O/PWXUoEUYdXjX5fV0nd4zpXZdIBl+fm5SXJ+tlZTYrWNwtjxBSBMDK8+2rN9dEJPPej0Mg4yBq47O8SQmMXhtoHqYEFvsxZypCYWFWcg7ZyKWRyB1BZDxDgbuTw2tVP280atPAkttcB6xbcAO4KWTreyz5aqgaeJrEla5zbBB6kC/Uif1B5BN08lzacu8dBGH31UWCc8adipfUXKG40OaAoIkTy27gAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6H+zyRi/+rQjYNltAQEitJGTD9+x4F/EuwU6IfnDlzI=;
 b=OplDPwtwR504t7GRXGTz9JcImWzWhs9EX2Q19jOzQ/3Kvx0EFEt27bzpEq2mt+/OFFBOdFgORL7KceTtVZcfB5rztdopBma/gs99kNO7dKKU34dDZJXGtmqQ147iWy5CFNI4U9UgrAVLlnj1+d9ns/8351OS+lhnkD72xRsrkBA=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM8PR04MB7459.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Mon, 30 Jan
 2023 02:04:12 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::4dcb:740c:bf92:954a]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::4dcb:740c:bf92:954a%8]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 02:04:12 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Peng Fan <peng.fan@nxp.com>, "marex@denx.de" <marex@denx.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Frank Li <frank.li@nxp.com>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v6 6/6] arm64: dts: Add i.MX8MP PCIe EP support on EVK
 board
Thread-Topic: [PATCH v6 6/6] arm64: dts: Add i.MX8MP PCIe EP support on EVK
 board
Thread-Index: AQHZLJMjGtiwIm4P1kaLyv0MDP7hCq6m88oAgA9QXzA=
Date:   Mon, 30 Jan 2023 02:04:12 +0000
Message-ID: <AS8PR04MB86769BDD3F9A3503D7E5F0DA8CD39@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1674192352-4473-1-git-send-email-hongxing.zhu@nxp.com>
 <1674192352-4473-7-git-send-email-hongxing.zhu@nxp.com>
 <b4375605-c322-4dfc-e3ec-1e38aa45774a@linaro.org>
In-Reply-To: <b4375605-c322-4dfc-e3ec-1e38aa45774a@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AM8PR04MB7459:EE_
x-ms-office365-filtering-correlation-id: d5f11979-0f0c-4336-7124-08db0266483a
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1ccqGa4w1H7zjaps4+MkH8AIqhkf/dJgG8RiG3d13Mib4JDf50oTAd0SrhYtxLaAjYsC9WTWC7OnsNDqUtxwVOQruk6TLJlhVYwwUyFhQ55UCisyx3KW6FG3Rw0cvXZgWAK0H5WFLi/Fijb4v1WnTv/xS+A6vJexTVlMwRbHxsVJxetgXhMQsE9Oy2C9ZxNYFqb01791gepkcgr52LCpNxCa+JIg+0xLZg2vsGR1RcGRZ8YhxSb6oI8OWD5N97mIKaQs32XW2CiOEw1J7Y+n5G5aKTOj3DbaQOBwkym0wx88KRHdxy8oFiKxezq3fAKfs+MqUYGvzu9RklegZxvQfRLrrAC+ZVW11Ec0VuJMa/F7ZX6pFjLkbQ3yhvl/pLTEfmi2rDGMP8UaJPFOwLjNo34375uDCm1qtOUmiccXhSXDOkvzdBUeqp6jsTYLBvG2rtKxon1kCp+gaQ9DgVJgi4qt1w9NGz3m5vLxo7AUqs7GciMB65U9cHzn1rtFnp3sorMIoU83gGgugXQKezVd9sxDsHk8fhj4sjKpefnIYrinIpWg5bg4GLq7YgpA7zDl5NO84YVlcxi/JQG2MU8fS9zJ+rwtOTfUsMU+Gg4bd+7c52XBOdef0fchCYNqwZQdcl/gn/aVIJqGgU8Sk/6V88NzQz+M5OPlg8APp4CUprrxIsi8R0U9r/xyRYI4G/fwvsABC2Hx0qhPqWEtTUgrUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199018)(54906003)(316002)(110136005)(6636002)(7416002)(55016003)(33656002)(5660300002)(8676002)(4326008)(66446008)(66476007)(66946007)(66556008)(76116006)(64756008)(41300700001)(122000001)(38100700002)(83380400001)(8936002)(52536014)(53546011)(478600001)(6506007)(7696005)(44832011)(9686003)(26005)(186003)(38070700005)(86362001)(71200400001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEU3ZTc5WTdjdUpZcWVFMFA1MnM5Q1dENzhudU1ieHM0Z2VaU01UcjBSdm83?=
 =?utf-8?B?Y0pFWTViMWFOR29lRDNIN0o3ZC9HaU05QzFDU0g3OWp4R2pkWG9CdFQ0NXVw?=
 =?utf-8?B?YmZ0eXM3OUlOd1FNVlQ3OFFXeTBZRVVVUDdMSVNRVG0xTksxZU9uVDdNd3RN?=
 =?utf-8?B?Tm1ubEE3M3FCcEJ1U2oyYTV6L2QweVJTZDdBa0dLYTM2VGVjS2ZFZFZETE1v?=
 =?utf-8?B?bktoMkdINjMzSmJIYVlsZUJIMXM1OXovQm4vQUJFOFdWQzVDZml5d3ZBSlpN?=
 =?utf-8?B?TjdzSFBJSGVCMzhXVGxuT1NOYkxReFU5cEVVaUZGZ2FnekxFdEVSaWVqNnU5?=
 =?utf-8?B?cUd1c0hiRzJwUHAwUkZCSnlOaTRhTmU2QWttQk1ZN0Y0Snk1WXZIZFhSbzVG?=
 =?utf-8?B?d0RpVEkyZEN2b29SZjU5Y0diWTZsWGlOclJMUFA3MGFYbkpTNU1iM1FCVHUw?=
 =?utf-8?B?b2hraGxvaGtvMzJDSm5GdmdEOUhVOWF2YVNSVk9VM0FxNTkyVkhhcVRsNDU4?=
 =?utf-8?B?N1BhblByUlhwMHlnK05xODV4KzJzaGtXaG1ERGYrdk1nVUpQM0ZtdGZoSEQ1?=
 =?utf-8?B?cUFrTjdXa2REMXFaanRVVm1CTVhETy9ZNE5qeWZuOGx3bzkvakRnZjR4UVNQ?=
 =?utf-8?B?NUhtcWZ0aEoxQVVwWVpUOHdKOXpITG5wUmxlbDE0N0VVZThMSm93TmQ3VzM5?=
 =?utf-8?B?RVpXUHU5bitxQjJnbGlheERiajFNTHlsbGFtT0pLZ0w2V3Z0MVM2Ui9wQUNK?=
 =?utf-8?B?MEowZ0FsNXhmQ3QweFRPejR2cElnUXhlVXU5aWl3VnlRQUI1Rk1rczRjNEIy?=
 =?utf-8?B?bFIzR0hCQnl6c0ZkNW5DVno0eVlxc09wNTFOK2IveS9wdUtFbUk0Wmh3bWkv?=
 =?utf-8?B?WnFIZ3hNbDFnL3lWb04xL21Qd29TZVZpMm8vK2JmRUdtRUlTenZEbERSQUts?=
 =?utf-8?B?Skp5THVpdmNzdWJxOXJnODR3TnhQVkhpcDd3RWpleGNiUzE5T3poYm05cGEz?=
 =?utf-8?B?S1NhVy9vNlhBa1pkeXl2bkZmNUxRTncvN1p3MFVmazdiSDcxS0lJdVcwWjgy?=
 =?utf-8?B?STFsdFN6Q1Y3QVp5NjZ0d0VXdE9ZK3dyL2hESTNNZUtxWkJVdDBtZlI1T3dr?=
 =?utf-8?B?azB0WGptMkZ3ZVFSY2tLOCtPWTJnUjBuVjA0RjltUVEyMW9JOUs2MFN3UDF0?=
 =?utf-8?B?OWVYRmVWaHFBYkpxUDB2eTFOVEJ6NWgxSFlnNTV3eXAwRDN3V2lQRFhyc3Vz?=
 =?utf-8?B?MTBTUHJ1M3lreXVuVlIxbGxhYXoxcEp4Y1EzU2V5b2RGVFBLQnZ6Vkh4QTVH?=
 =?utf-8?B?NG5YVDN6MWhhN3M5YWMwZlBIcm5jK0FUSGx0VXFHRUdTZUhPVzYrdGQ1UDly?=
 =?utf-8?B?eWV3RndPeGZ5YnZMaktURGJJK1U2QURZSUo2ZjNMWWE5dFRZZ1RRSVZ2MHB4?=
 =?utf-8?B?TEFjdHUzWkF5Tm5NRjBXTHpySlZTdkV6K3FoeURnNHJaYW5EMHc5ZUpwU0pK?=
 =?utf-8?B?ejJVZEZrY2QweWMvUDFkU2c2MGZiUGh4a2x0azhGT280M2kvYmpYWGZQdUxF?=
 =?utf-8?B?SUhZczI3T0lrUUFzWEJKQThwdjJwL0ZTZzhPb3NPVEsvTlpSaDVkTkppeitr?=
 =?utf-8?B?ZHdWSkFwbi85c3pZWFVjVm5ERlFIUUs1RVB2UUc0SFd5R0FJSXJ3am5NZXAy?=
 =?utf-8?B?VFJnMXp6dWpOQkNidXAxWWV4QVNucWM3RlZ0UHEzMzBqSnlmWnk5QmpneUN5?=
 =?utf-8?B?Y0lXcU1mUXpPdnhrWEZ3cG54bWdiTHhibTlNNWpZOHpMV0VLckNWdUhYUVk3?=
 =?utf-8?B?TE9mS25oOEU5WjdJRXJic1QxNytheUt6ZzNBdE9ORTRmSHd4eDR6bnFKY1Np?=
 =?utf-8?B?RzhZZmJ6Y3FNa2t0ZGlHb1hhMUNCVmZIZjU3WE9BaEFaTXVKR3ExQ0FLeEdR?=
 =?utf-8?B?QjZnbVJUbnFNUUwva1FOZG9WMzE3dEY4M3h1NEh0a2l5aEJiTTViMDkwamFr?=
 =?utf-8?B?SWVSQ0grWU9MTHJuVHBxaDYyQXllakpiREtKT3MwSFlKN2krbVl2c05LZkdI?=
 =?utf-8?B?SEtITFIvUFdQSTlkYjVxdnFFNlJ5QmhnY0tKQ1pqRWdYMmcrYk5QN1dQZUNE?=
 =?utf-8?Q?fxL2NRycbnqAkCN2EWTyxQy6f?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f11979-0f0c-4336-7124-08db0266483a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 02:04:12.4454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d5xI40zG7oh9KuCuTL2cLUegN7xyLN40GIPD3jNEjxyOxT3QuOOtcC2iXlCLQZW7LUkt9E/M9IfZmvdI2U81kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7459
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMjPlubQx5pyIMjDm
l6UgMTY6MDkNCj4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyByb2Jo
K2R0QGtlcm5lbC5vcmc7DQo+IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgc2hh
d25ndW9Aa2VybmVsLm9yZzsgUGVuZyBGYW4NCj4gPHBlbmcuZmFuQG54cC5jb20+OyBtYXJleEBk
ZW54LmRlOyBNYXJjZWwgWmlzd2lsZXINCj4gPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT47
IHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbTsgRnJhbmsgTGkNCj4gPGZyYW5rLmxpQG54cC5jb20+DQo+
IENjOiBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGRsLWxpbnV4LWlteCA8
bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgNi82XSBhcm02NDog
ZHRzOiBBZGQgaS5NWDhNUCBQQ0llIEVQIHN1cHBvcnQgb24gRVZLDQo+IGJvYXJkDQo+IA0KPiBP
biAyMC8wMS8yMDIzIDA2OjI1LCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiBBZGQgaS5NWDhNUCBQ
Q0llIEVQIHN1cHBvcnQgb24gRVZLIGJvYXJkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmlj
aGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtZXZrLmR0cyB8IDYgKysrKysrDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtZXZrLmR0cw0KPiBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMvZnJlZXNjYWxlL2lteDhtcC1ldmsuZHRzDQo+ID4gaW5kZXggNzgxNjg1MzE2MmIzLi42
Yzk0ZDU3OTEyYjQgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OG1wLWV2ay5kdHMNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2Fs
ZS9pbXg4bXAtZXZrLmR0cw0KPiA+IEBAIC00MDQsNiArNDA0LDEyIEBAICZwY2llIHsNCj4gPiAg
CXN0YXR1cyA9ICJva2F5IjsNCj4gPiAgfTsNCj4gPg0KPiA+ICsmcGNpZV9lcHsNCj4gPiArCXBp
bmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ID4gKwlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfcGNp
ZTA+Ow0KPiA+ICsJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gDQo+IERpdHRvIChkcm9wIHBhdGNo
KQ0KT2theSwgd291bGQgYmUgZHJvcHBlZC4NClRoYW5rcy4NCg0KQmVzdCBSZWdhcmRzDQpSaWNo
YXJkIFpodQ0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
