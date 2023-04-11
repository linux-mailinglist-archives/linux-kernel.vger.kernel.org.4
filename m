Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2207C6DDF82
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjDKPWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjDKPWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:22:44 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2121.outbound.protection.outlook.com [40.107.113.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2A35BA1;
        Tue, 11 Apr 2023 08:22:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfmykNBmsO5ip8k6AZQ750jLxV6G38WbW21jX5gFahn9wdpuMMahzNhmeDrY0rM9OAjwdDjWAQ9baCs4z7N1FPOErTITaD4yLdG1GRiq/kFpLe4Rq+czhOXvGSztS4Ltw3Y9/SAWkMdG0jFGuiHunbqp+5yhP5s9JPQNH0OOS9NT5t9En8rXOSLVVYZoFAWjqxj0A7reNCOVxChUKx7ZzBZkwY2GtW6wDAjMxMmBdo9q40HbZ9rm7YNkJ2yckj6Tgyi3+LoybuqV83pPxCovGhfjBpr7xH6JTm8L2anECHeM61BWD4IG8lcfKM8C0yfRy9K8QfDhSUCpWdJT70UI3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rommvUOnJfbBGcf9vQGsh+GCQkhuPpI9GG5tpQ9eZsU=;
 b=TzBnBse9fwqBhoQKpaIYMTeQ07BSq3Zj2WWKZRNtYbdg8ytC1C/a+BJ7Sc0zttXAZWgi9MG6+wbQEotL3Mu/aPiV1+24GJ4JJlc8wyhnN2jBoyQNQ9ZCAfjEnoUgbzCaPFX5HlRI+nqmOEzs6Fl+HraXIYqhjR2jfgqzMAgKDtr0XIsyYLyra0swcwpBz33fPsv9iAeah45wrwxRR7Lloli1wZxA2aUHzNy1oyRQUEdCwrHrSKcw2RFK6J3YTJQ3llW7Ui6tsTI45A//U//RLX1kBGXxey0BQozRjnHKZM7cT31+lNjXRDprvd1hAnbG2UahbSCn4hk2tlyqwcUYqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rommvUOnJfbBGcf9vQGsh+GCQkhuPpI9GG5tpQ9eZsU=;
 b=U48i7a/rFnHVv+guJ5bFIM6xdOnxV89KmNjBL0QgP1w95zauil6HoCyuelrSTz611+ODrTbAaES8GHiv/5Z+tc7WWo0kYPUzSK3XVnTID0NKBqyEV3FBT68JghN4rVchIO0d2xnqcvGpqTNJ1II70XYg+lvz/S8/RB2DGPzinYM=
Received: from OS3PR01MB8460.jpnprd01.prod.outlook.com (2603:1096:604:197::13)
 by OSZPR01MB9331.jpnprd01.prod.outlook.com (2603:1096:604:1d6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 15:21:08 +0000
Received: from OS3PR01MB8460.jpnprd01.prod.outlook.com
 ([fe80::1813:de93:4f41:149e]) by OS3PR01MB8460.jpnprd01.prod.outlook.com
 ([fe80::1813:de93:4f41:149e%6]) with mapi id 15.20.6298.028; Tue, 11 Apr 2023
 15:21:06 +0000
From:   DLG Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
To:     Benjamin Bara <bbara93@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>
CC:     DLG Adam Thomson <DLG-Adam.Thomson.Opensource@dm.renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
Subject: RE: [PATCH v3 0/3] regulator: da9063: disable unused voltage monitors
Thread-Topic: [PATCH v3 0/3] regulator: da9063: disable unused voltage
 monitors
Thread-Index: AdlsiIFvFSxoU439RD6Kd9rPVwrAxg==
Date:   Tue, 11 Apr 2023 15:21:06 +0000
Message-ID: <OS3PR01MB84601A473F8466C5923D8965C29A9@OS3PR01MB8460.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB8460:EE_|OSZPR01MB9331:EE_
x-ms-office365-filtering-correlation-id: 65f4d410-8dfb-43e7-3eaf-08db3aa05f1a
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7MkrxkFeSugp+f1XRRA4z8X01RDatiF3PnIunuPotsAkZdYb7wXvXOsrfq1igkEJfsXO0LpKL5bP2UlhlxkZaClbjf3NxhBW74SBx5F/WQXNYtQIxVXOtCvei+prQZPpOdZF7Hk3XqkzrFzWRNSPwWEBK8MYr52RqjN/O5wotN7xXO1ws99rHbOmk00r9d9BhfmEl62oTVVnSQ9+Y1n0R9hAqpA8jlLbscAGw+qgbkj1nsecVI46TctvSNZhrrJWklw3WsRTHq9JiEFnGI1l3EjIaE/V9qMroNhBKmO8x8AlMRYx/EMeUFM1lTJb+1wAjlU2pat/5VLtg4E9gPJnBNL1zBA9ed8C7pGzvOiJuIjHUKXCo8XAosf55H/MF6D+eLeg+aOpCP3xMrJygnIbRjuNYX+vrs+VaYTjtDDA2EngsrtIKjn+A6khQia9p7mPSBiJ03EYIvt2OfepirbaAa92mvc0ZK3+xrvxBfK5XvgtIpjbh7+7dNMGXHfe3CyDj+/XtA1Wuv4cwBrVgKZtoPp0meFMxfDOyVnK6J0W5o4N9JzLbCRRR/w25NnQBi4R8SdjB5lt5AdD1FwkN8w05E/piVN1/dy+W8q11nc3Kug=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB8460.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199021)(71200400001)(7696005)(478600001)(86362001)(83380400001)(55016003)(33656002)(122000001)(38070700005)(38100700002)(2906002)(966005)(53546011)(9686003)(316002)(110136005)(26005)(54906003)(6506007)(186003)(55236004)(66476007)(64756008)(66446008)(41300700001)(8676002)(66556008)(52536014)(8936002)(7416002)(4326008)(5660300002)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cTRFVG9Od3lTN2NrQVhYOTZyTGtuZ0l1WVFWbmNlMUltVk8xUG81eEgxRGZH?=
 =?utf-8?B?Y2l4dm9WeVVMRjU5dFNyZFFIcGZOQWNId3FwejlWUm80TVNjMmk3ZHNGYTVu?=
 =?utf-8?B?cThqa3NBcDZSVmpZTTBaRW9NTndlK1djNWg5K0EzaHBnWVUwdlRJQ25DYW9k?=
 =?utf-8?B?TUJNdU41VVFrakdzUWZhLzhhMVlMMGNqS2o1am1iYkM3aEV3MVVOYWg4OGlP?=
 =?utf-8?B?NTlsOGs5bFE0Z0szRHZYTWRkNEttUEx4MjRTTWkySHgwbEJWYUs3ZjFNb0E2?=
 =?utf-8?B?RWFESXRxcmRkSTdCZmVvSmRxWUtrOWk3b3NSK1JYQmFrVDVUd3FnRWxyQXJl?=
 =?utf-8?B?NUMrYlV1ZU5DN0l4ZGVvQnh0SnFpNEIzSm5VR0sxVXFESXZ5c255UGEzNGx0?=
 =?utf-8?B?UXE5cUlLVHVZdEFsN21Qd2h6MDREeDZ2a0lqM2o4V0JDbFVHbEsxOTRtTjJZ?=
 =?utf-8?B?M2RxWUZZajdiQVphS3RSNDUydS8xZGxEY0ZyU3VPdVhzQVVCRC95NHF1alli?=
 =?utf-8?B?cmZMd3V6N2ZJOXBhQTRaaU50RjZZMlY4RlVkYXVDY29XaXk3eHp1dElQY1hV?=
 =?utf-8?B?Q2NJL0o4ZkJISWJRaVl1MnNqWWs0eFVFUFltd2lTWmZCUnljbHJVak5VTEx1?=
 =?utf-8?B?Vnc1TEVVSlJuWEt4SmxvMktOS0xteVlOVVUxRWg0RlJhYkZqNHQ4RmZ1ZG5k?=
 =?utf-8?B?U0l2VjdQL1I3R0VPd2NCelhxbW1RR3RwMmFQTkE5SmlqV1l6VGxOWWl5Q2FY?=
 =?utf-8?B?YTVidW5GUGFwY1UwaWhYdHVSQ2RGcS9hSk5raCtQSWdKdHhFRjRuN3M1c2xz?=
 =?utf-8?B?OEk2Y0NwZ1FGNE9lYXVZS3JOVzAyZzJWM2c2RmRBQkUvQnp4MDRKVXNwRE1M?=
 =?utf-8?B?RjZ4b20zNmhjSXBlRC9FNGUrSHpxNUJKMTdzQ20yZHNJUVM3NmFMYXBENGs4?=
 =?utf-8?B?bWhHYXVHallxWjRqcm13S2FNWW4xdlBKRHkxZXlMUERyazdxQ0REeFVXY1pa?=
 =?utf-8?B?YVlUK3VOU3lpeXZCU2F6Y3phbit2NTBzaTBlNWxhU3ZzQVAzK3A5cFZLTFhX?=
 =?utf-8?B?V3lGRXIzZjFDL29XVWlIc3RHYlVyeW9BMGh1U3owcGlrMTVCSTFxV3ZDRDE5?=
 =?utf-8?B?SVdRZTB2NHlXamJrS1pNdlEwWTVoZTlXV3RYTlRsdDRlczhseDN0aHJKWW84?=
 =?utf-8?B?TGhnbGFwaFFHVk1nTmxsR2MrYzJJSDcvdW9YSThIVm9uOHBRMi9EK2oxazRF?=
 =?utf-8?B?b3lFOGxtd3JBTWhTT3VNbWRuTjZqSFN0UWhKN0tVTXJOUXpBOHpLTWU5Vk4r?=
 =?utf-8?B?OU8rb2tJUEdiQ0M3ZUw0dU9wRGRtZTBVMlA3SlMyTURGZ1FLZ2d4YjVKdTds?=
 =?utf-8?B?NG5rdGJPdnNNNnVOVkh2WHJ2Z3lDWFdjaDBXR2VJZUlZbjZ3M0VDVkZiQmdi?=
 =?utf-8?B?RllMS0dUNTRZWTE5ZzZUVmhWeVYzSG4rbFphb21TWHRsRGFUVENXRmZNRjBh?=
 =?utf-8?B?dTg1WG92eW9XcjBmZkhhenl6ekVWcnd0Vm12MncrQU02eVk3eFJKaGlYSktQ?=
 =?utf-8?B?NHNwa1N4RFdicm9wR0d2UFllamlZRUxwWkhVaTBvTkhTSHFSUXJuS2xLaVJq?=
 =?utf-8?B?d2NObkpzazJwZlJsclR2V1RjZDJKY01yQ25rSmt5RDJ1U01rcnA1NnNjZS9J?=
 =?utf-8?B?Ry91WTVnUXZQR2ZQUk1PTFd2Qm5CT1VTY2Q4OVVkcDk4alNTZXN3ZUdXcWNS?=
 =?utf-8?B?SFVURWZVU0JmUGFyOWo4UzYvTllHa2xCdk5zOXpjVW4yenM1K2NGaWlFaExy?=
 =?utf-8?B?OGxaS1Q5YkhCRXdpbERWdisvVEdNbkJTNmtLakpGa3BHS0V6d2lObzdVQmhQ?=
 =?utf-8?B?YWkyUUNJOW9QckRZd3d3V1ZZWFJSVXlKYWZSVDMwZUlkTnMrUjA5R2h3RHNm?=
 =?utf-8?B?UEpFRmVlNmhYMWdYNGpaU2dNd0g2ZHVIdmlRV0dQOGcvaE1qMWRVZVVoekRI?=
 =?utf-8?B?OG14NnNnUzF3L0o4NFI2Y0JsT2lvQ0VsYndXRzVsalB0Rk1ZYlpHcWNFcjlE?=
 =?utf-8?B?UjQrZEgwSnZ4cnNYNHhjQSt4alVsdmNKdEppcWh3OW55R0ZuRnJKWWhZMTln?=
 =?utf-8?B?OVZmSE4xcGF0Um5BUVcvTFdOV21qMWtQOWdiVWZiTWVOempzUGRzOW5wUE9L?=
 =?utf-8?B?bEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB8460.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f4d410-8dfb-43e7-3eaf-08db3aa05f1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 15:21:06.7420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T2UWTIUoxXNApkYOhw2O4a5dlcBUHlb+H8albcxddlvuMe8AaoZeKiL8+3WfH3U5EZQ0+LLQftDQ5varxKgI4brmGByiXyy18u/bl8AzigE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9331
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDUvMDQvMjAyMywgMTk6MTQsIEJlbmphbWluIEJhcmEgd3JvdGU6IA0KDQo+SGkhDQo+DQo+
Rm9sbG93LXVwIGZvciBteSBpbml0aWFsIHBhdGNoIHJlZ2FyZGluZyB0aGUgZGlzYWJsaW5nIG9m
IHVudXNlZA0KPnZvbHRhZ2UgbW9uaXRvcnMuIFdlIHVzZSB0aGUgUFdSX09LIGZ1bmN0aW9uYWxp
dHksIHdoaWNoIGFzc2VydHMgR1BfRkIyDQo+aWYgZXZlcnkgbW9uaXRvcmVkIHZvbHRhZ2UgaXMg
aW4gcmFuZ2UuIFRoaXMgcGF0Y2ggc2hvdWxkIHByb3ZpZGUgdGhlDQo+cG9zc2liaWxpdHkgdG8g
ZGVhY3RpdmF0ZSBhIHZvbHRhZ2UgbW9uaXRvciBmcm9tIHRoZSBEVCBpZiB0aGUgcmVndWxhdG9y
DQo+bWlnaHQgYmUgZGlzYWJsZWQgZHVyaW5nIHJ1biB0aW1lLiBGb3IgdGhpcyBwdXJwb3NlLCB0
aGUgcmVndWxhdG9yDQo+bm90aWZpY2F0aW9uIHN1cHBvcnQgaXMgdXNlZDoNCj5odHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvY292ZXIuMTYyMjYyODMzMy5naXQubWF0dGkudmFpdHRpbmVuQHh4
eHh4eHh4eHh4eHh4eHh4Lw0KPg0KPnYyOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjMw
NDAzLWRhOTA2My1kaXNhYmxlLXVudXNlZC12Mi0wLTJmMWJkMmEyNDM0YUB4eHh4eHh4eHh4eA0K
Pg0KPi0tLQ0KPkNoYW5nZWxvZzoNCj52MzoNCj4yOg0KPi0gYWRkIGNsYXJpZmljYXRpb25zLCBy
ZXdvcmQgWFZQIHRvIHZvbHRhZ2UgbW9uaXRvcmluZw0KPi0gaW1wcm92ZSBlcnJvciBtZXNzYWdl
cw0KPi0gZW5zdXJlIHRoYXQgb25seSBvbmUgc2V2ZXJpdHkgaXMgc2V0DQo+MzoNCi0+IGRvY3Vt
ZW50IHRoYXQgb3YgYW5kIHV2IHJlcXVpcmUgc2FtZSBzZXZlcml0eSBhbmQgbGV2ZWwNCj4NCj52
MjoNCj4tIHJld29ya2VkIHNvbHV0aW9uLCBiYXNlZCBvbiBBZGFtIFRob21zb24ncyBmZWVkYmFj
aw0KPg0KPi0tLQ0KPkJlbmphbWluIEJhcmEgKDMpOg0KPiAgICAgIHJlZ3VsYXRvcjogZGE5MDYz
OiBhZGQgdm9sdGFnZSBtb25pdG9yaW5nIHJlZ2lzdGVycw0KPiAgICAgIHJlZ3VsYXRvcjogZGE5
MDYzOiBpbXBsZW1lbnQgc2V0dGVyIGZvciB2b2x0YWdlIG1vbml0b3JpbmcNCj4gICAgICBkdC1i
aW5kaW5nczogbWZkOiBkbGcsZGE5MDYzOiBkb2N1bWVudCB2b2x0YWdlIG1vbml0b3JpbmcNCj4N
Cj4gLi4uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2RsZyxkYTkwNjMueWFtbCAgICAgICAgfCAg
MTcgKystDQo+IGRyaXZlcnMvcmVndWxhdG9yL2RhOTA2My1yZWd1bGF0b3IuYyAgICAgICAgICAg
ICAgIHwgMTQ3ICsrKysrKysrKysrKysrKysrLS0tLQ0KPiBpbmNsdWRlL2xpbnV4L21mZC9kYTkw
NjMvcmVnaXN0ZXJzLmggICAgICAgICAgICAgICB8ICAyMyArKysrDQo+IDMgZmlsZXMgY2hhbmdl
ZCwgMTU3IGluc2VydGlvbnMoKyksIDMwIGRlbGV0aW9ucygtKQ0KPi0tLQ0KPmJhc2UtY29tbWl0
OiA3ZTM2NGU1NjI5M2JiOThjYWUxYjU1ZmQ4MzVmNTk5MWM0ZTk2ZTdkDQo+Y2hhbmdlLWlkOiAy
MDIzMDQwMy1kYTkwNjMtZGlzYWJsZS11bnVzZWQtMTU4MzZlMmY0NTM5DQo+DQo+QmVzdCByZWdh
cmRzLA0KPi0tIA0KPkJlbmphbWluIEJhcmEgPGJlbmphbWluLmJhcmFAeHh4eHh4eHh4eHg+DQoN
CkhpIEJlbmphbWluLA0KDQpGWUksIEFkYW0gVGhvbXNvbiBoYXMgbGVmdCB0aGUgY29tcGFueSAt
IGJ1dCwgYmVpbmcgb24gZXhjZWxsZW50IHRlcm1zLCBraW5kbHkgYWRkZWQgaGlzIGluZm9ybWVk
IHJlYWRpbmcgb2YgeW91ciBsYXRlc3QgcGF0Y2ggc2V0IHRvIG15IG93bi4NCg0KUmV2aWV3ZWQt
Ynk6IEFkYW0gV2FyZCA8RExHLUFkYW0uV2FyZC5vcGVuc291cmNlQGRtLnJlbmVzYXMuY29tPg0K
DQpUaGFua3MgYW5kIGtpbmQgcmVnYXJkcywNCkFkYW0NCg0K
