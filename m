Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F2566A0D6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjAMRgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjAMRfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:35:33 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2103.outbound.protection.outlook.com [40.107.8.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D2B892E3;
        Fri, 13 Jan 2023 09:24:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8tuv8iZ2c7CLHkJXH6EKgj0Myi3WKl8fvob5w3F3t+oMB+5b8TNMsLUx3egsphri/zWX2ZlQgUrQsST7S5qfRykrK19/sDSmAtHV8Te5xuqlLL4Y8b6+GEbgLPptPSr0kj3oFzUehG7CE43Gn/cmmaWtcz/4DMY/rDk9Ss29mwl013xg9xK8RIjKSYrev1FOSkupMcNwcbeVEWBTT6SXxnx3DwZrt9jh8oMzi6hdcRs/ClK6c8/A3sE7/NLC6ALcytBXEuKPnNjKmf5AYm02v5ZBg3GiMT39Tn/i8lN1mfKAe0MudwG2AY2LxK5eWc2mx3uit0OMfjDOtzInCedMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqHErEXQgUd18rUv+ktLEFiTK1VbwcaNb82Fe0K1M8I=;
 b=c1HHrYmY+e0bhXU9VLVopDGgvtH7K2VJYJU2PMTlSEjBHPjdTC9NkETGsxXY7wFsuGO39Q7cPm34aRc+ZqGynyF3v6MrzXqunWWqVzUIuYKa8pXp2BUN3mAG75dKX5zQ+TBUdD44uU/yvuPTSFPlGGADFXbzFZ/zcgIK5WGMQpUCr5FRkAWEgG96KcCZ1zrAQ/KRdOVM161YXhP3BSEHP7SJlpFMCbz/hiSHDZjI7RUxvw8QvbgxYiWHeQyLw+b9eNeigpQZGex/FGMPooePMgF90O4G+9JR3Ks2oMNUt/sLHyqdJDcmTp61JNcz9lKKDsl2fyw9y/kjgv0hrva2BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqHErEXQgUd18rUv+ktLEFiTK1VbwcaNb82Fe0K1M8I=;
 b=SPRZZyRL73gCQIBp8V/1SrpSTGeg+UlkSYs9XtwUAnq3DAbIaYJrcBT2vIHCqiEBJfXnUHkSn5scEsCOymlK05hb+QjpIZf36sZqGTRes5Wa2OheEaIzodxlq05bQZ6ftRjhYl1qBzet5bbyA/xMllwIO4q0HVILQJkgmlHRjvs=
Received: from VI1PR03MB3950.eurprd03.prod.outlook.com (2603:10a6:803:75::30)
 by PAVPR03MB8945.eurprd03.prod.outlook.com (2603:10a6:102:322::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Fri, 13 Jan
 2023 17:24:34 +0000
Received: from VI1PR03MB3950.eurprd03.prod.outlook.com
 ([fe80::1aa6:ce48:e8ac:be30]) by VI1PR03MB3950.eurprd03.prod.outlook.com
 ([fe80::1aa6:ce48:e8ac:be30%7]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 17:24:33 +0000
From:   =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <alvin@pqrs.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: add Bang & Olufsen a/s
Thread-Topic: [PATCH] dt-bindings: vendor-prefixes: add Bang & Olufsen a/s
Thread-Index: AQHZJ2hSEsudgw2Ykka8H2/bjKK0VK6cijmAgAAOw4A=
Date:   Fri, 13 Jan 2023 17:24:33 +0000
Message-ID: <20230113172433.h2357fjwqxkhgiz2@bang-olufsen.dk>
References: <20230113160102.677865-1-alvin@pqrs.dk>
 <972fc587-be4a-d306-4e1e-7e68e37ed452@linaro.org>
In-Reply-To: <972fc587-be4a-d306-4e1e-7e68e37ed452@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR03MB3950:EE_|PAVPR03MB8945:EE_
x-ms-office365-filtering-correlation-id: fa6ed709-03f2-4256-11e6-08daf58b09bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Qjf9ZkFN0yQJvOxkIv/lyAitgF2kr8+Zse5MGmAxFyRRXV55N/UGyaINGoc615wcB8gADRiibj/xLZBSH7Q4Edva0SxCiSL1OJjM3d/2mjEsfAJICPEf1lPnQWuiIjju1ieoOBFQI5c47RYdsNptpOYCUTBz6TGWCPKJy+XlPofZddvLjMmTJbUwF2jgDH8GbY4JCQkZ1hbifaIaTUjcrs9BzNXdZlJHs/LpyH8cndNbLfD5U/YRvq6S5R6oq3ByUg+mgGcy4k2eFrzfB/wcxllvWZmku2moFpGGLtfBw/vjo3qVQvadmV7+FjDBM/QNEvl2D6lSb+1GgJzWC/jOUycLhcOeGqVjtlKWL7bPts0HSHlkPDWmbH9uwR2tx/Qj+FSCj4Q30Kji0XqIKswBYvsFqy5WoTELq68Dc42V7PxnTDGaKQ6LyU2ODNPh+yaF+0FmD/bt5PtOdUPgGpx9SYl590CTDwcBA6o0cNOP0GIfdLC9kvIzDJJ/frMXnwp3NQH6NPDHlFmkNJUb3dc8t5foDx0mGlFTQaBwEbNqqPcmokXjDu01WMnlbMf3J2SQuAOw6SJ0CiEDd3gEcMjYDnyF9RWKPINBcDSsY54pmqG2wU/GTMINLanvCk7UqWIlawBP5Ff2CT6InQ/xoAmH1D0THTqLKZq55bzh5kaZXG4yWcZ70cgqE4RQ1bxnTKiFGybHPqthSNfrwMepXNA+RR6G1P7BWtyQkHz9ssaLIc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR03MB3950.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(451199015)(38100700002)(85182001)(85202003)(86362001)(36756003)(38070700005)(122000001)(54906003)(53546011)(91956017)(2616005)(1076003)(6512007)(186003)(316002)(6486002)(26005)(966005)(478600001)(71200400001)(76116006)(8936002)(4744005)(2906002)(5660300002)(8976002)(8676002)(4326008)(41300700001)(6506007)(64756008)(66946007)(66446008)(6916009)(66556008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnlxZnV0VGprVVhsUFRqR2w3eURCekFSQ0NhTjFsa0xVNUtGb1ZkbUdTTmpi?=
 =?utf-8?B?NGR6RzVYVVlrMVVkTzlrdUF5alZpZ3dRWmV0eUcwSm1jVERxM3puUlhsc3ow?=
 =?utf-8?B?Qk5xK0tIV2FwOWVUL0ZHem9oREd5MjZtREptOSt6NGJKT0tPczJ1cURPMHI5?=
 =?utf-8?B?M2ZJVVRZNXNabDllNWo4Z2s0OUI1dG4rVzE1WFB0Y2NnT01LSDk4dzZ2Y0xy?=
 =?utf-8?B?T1JsYXVNZ05yT3RzYnd6UXMvN2xZQTZzUDk0SVpqT1RDTmJkWCtZdUNrMXBr?=
 =?utf-8?B?ZU1LZ05yR3lnUEs2YkU5NmFWNUZ6cWtZQkZzQnBMU1dlYWM5bDhIY0p5ZzJR?=
 =?utf-8?B?d09TU3I4Qkl1dk1yelZkRk0ySjNkeVZjUVNXTnFXcVlJS000MStxTWs0azZS?=
 =?utf-8?B?Q3BmV3VFSmEwd0Q2Tng0Tk1FQVY3QTM4dVVDWHZDellsdU1qVWpTTUFRUG1u?=
 =?utf-8?B?ajZVQ2FNQjA4eFJ0VVN1ZTMzRDhqdEZnemFQSnN2VDdSN3ZuLzdMVlRtYjlF?=
 =?utf-8?B?NzFaRWtRS2Z6RDVTcHFiaXRISXNmV3Y1dkord3ZuS3dJTnJtdmxDOWd2WEpB?=
 =?utf-8?B?bzlYemd4K25ycUZ2NXNPZmpva01xUENmdWYzenN3d0o1RkFYbWREa3NrNnY1?=
 =?utf-8?B?cVp6WE5VbmtWYzc5aUlsbmpGb2Uvb0FjMlNNNkM2bGlPc3FPRmdiVWRibTJ0?=
 =?utf-8?B?RFJONFpGemw4ckdBcFNCSWxZekZ1dkF1NzNSNG5jcGFJTStpNkNMOStxckd5?=
 =?utf-8?B?c1N5RFhZUEFkaEpERXFLSmdpSzV4T1ozYjliMXpuRjhIcTloYVByei9oS0dh?=
 =?utf-8?B?Sjk0YzRMZlA0a3BKOCtoOGlJYnBPZGRqdEZ5aFEyZ0JLUWU4MWFMVUtZMStw?=
 =?utf-8?B?ZHBZcnpPdWJTQ2tqd3dRMUN5N0RCbVowWWtLVGpvTTRES1Z6WHVDQjcxQWZy?=
 =?utf-8?B?WXBhdktLVHVnWDhVeHU2UVE3aHhPclFSZHpSWUsra2xtR3hQRU1YVS9xQUlS?=
 =?utf-8?B?Z0w4OEFtZlZiSHdsem9aeXFwMUhDNXliZEs2SmNiZld1RmZRcDZma3Z2VVR0?=
 =?utf-8?B?akNvNmlRSXg0d0oxbk96TUlEL2trY01VYzVqSDFEN0poZFZ3SGVnanpyQUpP?=
 =?utf-8?B?TGJibmVGMjEwYW1xYmRoaC9OQktsdStuWkxuakRwWlF0OTBEdkhzeDd0b1ly?=
 =?utf-8?B?VGw5ejN4NUFsbWVTWmZzYnhMNElCNE5BQ002YXpKYXpzWC9OU1JxKzlZNlJF?=
 =?utf-8?B?cG1TS0orZVkvSEFXaXNYbDloNnNaZkRmMjJhMFd0QUVIOUQ2amg3eWh6N2JH?=
 =?utf-8?B?eUh4TmNPTDFNbmd1R2Zqck9SbFd2TGtEalhDNE80RVpXUEw4dkdPekFvR0U2?=
 =?utf-8?B?cDQwS2lZdXNZQkx6aXc5akhDUGNqTWdUaXlVM2ZLSGRjSzZaS2ZZdllhSGFK?=
 =?utf-8?B?N2ZnZElwRVFoMmZZNUxyb2JzdTRRZVVVR2lONHM5RVpVZStQanBNb0NZdis0?=
 =?utf-8?B?SzRadmpkNmJHbGtZbENOdjkyVVJBQjVtNWZEdlo1M0FlQkw0RUpwZlJKcnFi?=
 =?utf-8?B?NmVRYzdzcTVHcXlZeEc5d3RXS1VLdDg2alBPc2ZleEphcXZ0WStvRVVVZVgw?=
 =?utf-8?B?SW02aHVvUk5NUnFtT3pmbFZrd1liT2RjVS9sekVHZk5LZEV0V3UxNjc4TVBv?=
 =?utf-8?B?cjRkejNRTzU5cXlaMHdYbWJ1VEZNenV0TGlRN3BHbHM1YUtrd3lMVy9sUDNT?=
 =?utf-8?B?LzcwNWdBb0cvU2o3VVlhNWIwVzdYR0JMNlJJcGxOZjVhcnc1bHRRYXNSUUpn?=
 =?utf-8?B?SS9KTW9qWGdnWTkrc1ZIcnBWb0V2WjRhemJIVDVaTHk1ZUdqTlJsMnNnaHVv?=
 =?utf-8?B?ck5MU0kxY096ZmRGTVNHUndlU1EySlRkMjdyQm1XZ0tQaDNocnoyL3JtOHVw?=
 =?utf-8?B?Wjh5bHhyNjExcEJFa0FZTDVacExkSzd2aU5rR0t4WkhUZm5wNDVNRll0TFE0?=
 =?utf-8?B?Z3MxekJBS0E2b0VpUzM1bGFlKzRaN2IrWnZFNERuM2d1bjZ5bG9JbE1NVDAv?=
 =?utf-8?B?UEg5N3pzY3owdmhqc2dISnVDU0RBTnFDL3BTU2hiRFNEU3REQlZqNEJrd3Vj?=
 =?utf-8?B?c08rN09kRXhhK0xZTVczU1Q4NUtsdFdpT0MyMXZtcG83V1daUUs3amNFTVZ1?=
 =?utf-8?B?cVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B69DC7ACC128D4D9E7496A3430A5E0D@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3950.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6ed709-03f2-4256-11e6-08daf58b09bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 17:24:33.8235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KaxkD6PwjbRQIDprf5ncNVSgXNqiD8X4GE/AThl39hGvo5oMV6fW7PcjHv5uw0qPlH35MHi0B3dkJgVzLjxW2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB8945
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpPbiBGcmksIEphbiAxMywgMjAyMyBhdCAwNTozMTo0M1BNICswMTAw
LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiBPbiAxMy8wMS8yMDIzIDE3OjAxLCBBbHZp
biDFoGlwcmFnYSB3cm90ZToNCj4gPiBGcm9tOiBBbHZpbiDFoGlwcmFnYSA8YWxzaUBiYW5nLW9s
dWZzZW4uZGs+DQo+ID4NCj4gPiBCYW5nICYgT2x1ZnNlbiBhL3MgaXMgYSBEYW5pc2ggZGVzaWdu
ZXIgYW5kIG1hbnVmYWN0dXJlciBvZiBoaWdoLWVuZA0KPiA+IGNvbnN1bWVyIGF1ZGlvIGFuZCBo
b21lIGVudGVydGFpbm1lbnQgcHJvZHVjdHMuDQo+ID4NCj4gPiBUaGUgdmVuZG9yIHByZWZpeCAn
YmVvLCcgZm9sbG93cyBmcm9tIHRoZSB1YmlxdWl0b3VzIHByb2R1Y3QgbmFtaW5nDQo+ID4gc2No
ZW1lLCBlLmcuIEJlb3NvdW5kIEJhbGFuY2UsIEJlb2xhYiAyOC4NCj4gPg0KPiA+IGh0dHBzOi8v
d3d3LmJhbmctb2x1ZnNlbi5jb20vDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbHZpbiDFoGlw
cmFnYSA8YWxzaUBiYW5nLW9sdWZzZW4uZGs+DQo+IA0KPiBXZSBkbyBub3QgYWRkIHZlbmRvciBw
cmVmaXhlcyBmb3IgZXZlcnkgY29tcGFueSBpbiB0aGUgd29ybGQsIHRoZXJlIGlzDQo+IG5vIG5l
ZWQuIFBsZWFzZSBicmluZyB0aGlzIHBhdGNoIHdpdGggYW4gdXNlci4NCg0KTm8gcHJvYmxlbSwg
SSBhcHByZWNpYXRlIHlvdXIgY2xlYXIgcmVzcG9uc2UuIEknbGwgc2VuZCBpdCBhZ2Fpbg0KdG9n
ZXRoZXIgd2l0aCBhIHVzZXIgbmV4dCB0aW1lLiBUaGFua3MhDQoNCktpbmQgcmVnYXJkcywNCkFs
dmluDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+
