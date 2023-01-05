Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F6765E8A1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbjAEKH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjAEKH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:07:27 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2042.outbound.protection.outlook.com [40.107.249.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7600B389F;
        Thu,  5 Jan 2023 02:07:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXpm2NPNNSnmJYaRgmu3hKEZ8Z5+8xBoRUif2dW2sbfXLTUfhsd6F2ioSLwRKlfYBf1WZ8ZGTedG9nL/hbXKJAIOvrhYLJ2F+Dlzl9lxXLqCsWYSlLWB4D68IutULrmlMgPJ26MjgsV+0FfhjHR0GIbIDSOBE5vbbDTXQnW+rAxsi3nOIO1lP/PqMEdYVi51Lk3duGDDaysJ5UwwYE/bvmBNQVD4ePY2N+7o2UR5MxRwh9sla6EiDAxLdKfqOEz8TuvjCN/vU7MGEJ1/w7rnOYur32mZgrGQWudLyz771lRFrfw5rPbaplaBPEscyX98fKxFfuKmT5eTT9JaxwMsDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oh8z84JwvfYPovYf2u/bQpKoQ1UuNLqLBXhT4tByFHE=;
 b=GCdRVp+F6dYfvwZt55NJeo2DD/XlG3Eb34hEmL8T5cj9gFEejYuFdDnx33J9uwIHVQutb49w7KUxOvsStwfe1IZaOA9iiyhiU/MkS1GqFZAKwL2RKh24rPXKqKA+FalDZS8edoxAD0ddBfIvGcVO6jRZF9LVTKKI7rYP6lbVppnPapY+Rupf4fKLm7EKHymUJcTDIcwB3CFKWaW786F44dwycd08WqId8mnJ5TI/bi/Mf6q2P3sH7EhDsT4l1mwI3xhC6t3FK27181/dyWl3fE1EwY2bEmx5aLjiBxsP/pBOtzEPCEIf7/TYXP2It1CM6xmOzxtuvHAHqpJd+DH2YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oh8z84JwvfYPovYf2u/bQpKoQ1UuNLqLBXhT4tByFHE=;
 b=iGk5t8uFPZnpNIox0y+y38NKDDZx6+kQC24WyqmHGso/JKyRy7AmTVc7XPDuGXM6meLfPIExRHQD4WxJCChIFGF/eGmn9BgLtSjtGVN7yK+783jDFBsf5hzbjYj2jPZN0hkXqhr5UbvWRmdor6thrjYs6T6+03cCPP7G0MZHA84=
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM8PR04MB7970.eurprd04.prod.outlook.com (2603:10a6:20b:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Thu, 5 Jan
 2023 10:07:23 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::f75a:918f:6b4c:4a00]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::f75a:918f:6b4c:4a00%4]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 10:07:23 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/2] thermal: Add generic device cooling support
Thread-Topic: [PATCH v1 1/2] thermal: Add generic device cooling support
Thread-Index: AQHZIN8rC/I1joRfaE6IeJMxlSSJAK6Plu+AgAABSAA=
Date:   Thu, 5 Jan 2023 10:07:23 +0000
Message-ID: <AM6PR04MB605351CEA7E47B21882841DBE2FA9@AM6PR04MB6053.eurprd04.prod.outlook.com>
References: <20230105082234.16962-1-alice.guo@oss.nxp.com>
 <20230105082234.16962-2-alice.guo@oss.nxp.com>
 <0275b025-2029-0a78-1ef8-166bb58d742e@linaro.org>
In-Reply-To: <0275b025-2029-0a78-1ef8-166bb58d742e@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB6053:EE_|AM8PR04MB7970:EE_
x-ms-office365-filtering-correlation-id: 0189eb3c-c374-47d7-9b56-08daef04a3f9
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EyA7eNZe2myrNZCqavhBd5yPHDaz1hb509X7ila8KY94DDyc2O3V98T7mtCniAMQinoiovdchnOoTbV2E2s1JovNUXvN/aP+A6+WS/Qjk5NEyZ/eWzCRZvbKhXlx/eF97CEpmwxGXT2URhfSpcv1AJN1AMFXhtiDTcicCx5hAFfw2gLNXbqdaHt65htef6Dp7qKxji11yxD/xM8KSrqpFQfcsLiwwh4BTyvD/AyHrooPyyiKI4ydtiviCivH34SO8MAjvyj6KvBeSs/MEmQ/kVLLMxxgXItnPF3tQMQiM0sgFKuaSAonW7W9hJrJYaLitfx1H5ENmJjkXMucM8eyEbztmw3m2diJ9B2DzU7VeuiM0fRKGCqIaIJ5HYlHU5PxfCuJz8bBEjZkq8du9mhZuap+UatOq9eLedJWDKtGt2LuDvHkPyCkr1Dwy0H39aRQ3YCPBlNQZkMo8GC15IbmZoKIdEg2H1HdsD4bpQSQ7HJpSFoMnuwvVtXx8hzntxgK77nsc4LfCJUrNTBprGdgk2GrCEZAMkm1V9BkSD3cPnOj4DxOiFi+Dbwv7jCM3rWNNHf38fOPYSZ1h/u3eERISmuReU+JD6oSVC2bx3UHsoqnIfqgPuQgAnyhjW25mnZWTelRj85kprVuADMo6rrNM4XgY68UClSKrLYGeebA7frmzRuUD9SwFXmH+We57YuT3oEZ3ZSxFWv2YRMUPOFb0xFgjBz6XkAULlI1UwEPghZpLgzGksWR1pHncVzao0Jg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199015)(83380400001)(55016003)(86362001)(66476007)(64756008)(66556008)(33656002)(38070700005)(8676002)(66446008)(122000001)(38100700002)(8936002)(4326008)(5660300002)(110136005)(2906002)(52536014)(316002)(66946007)(54906003)(6506007)(186003)(76116006)(53546011)(41300700001)(9686003)(26005)(7696005)(71200400001)(478600001)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHdtZW51Umdvby8xODhqMmFHRmxSbU5Xc2tacDRiSGlBbjZuMjExYXJQVGRM?=
 =?utf-8?B?TVJWYkJBcERKWFg2aXkzdkxyazkxd1JNWHk5Z2NscjJiRlA4VEV5S3hrZEpz?=
 =?utf-8?B?a1dtNjdEWTBON2kzUVpEcWthYWtvMHVCa2MrNGpVd0drWmM2UmdXb21iRTJ1?=
 =?utf-8?B?SmZvanJtdXZmN0hUakNoUlE2a2VQcFo0UXhJU094bTRHUHAzMlhWTUVHU0tZ?=
 =?utf-8?B?bVZvOE1YSURQTDA5M1NCRHE4Vk04bi93UWNXZkRyYytRQWtQaFlWL0dxTEpO?=
 =?utf-8?B?ZXlNMzFWQ21yVVRuMEpubHBTeCtyK25OU2JzRUlyV1R5Ylp6UW9YSVZKbWp2?=
 =?utf-8?B?S3hTa1hmVFlKell6YXhZZWVhVXczemFWZGVYMHV1c1MwL09nVnJqNWk3SVhU?=
 =?utf-8?B?eHVOZGlFeXhWcUpKTlRFS1I1YkoyYXJ6M0tscTlBaWNxTU0wMXNKaWxGWjkx?=
 =?utf-8?B?SWFhUUF3VHUzWFAzTmY0UTljTURETUNqU3E4VnpzRWFtWVcrTlBKMC9YRHd6?=
 =?utf-8?B?V0ZTMjNNY1FPNTlCMHVrR2FSVHhOZ09VY1BPbG13aGJWdnpaSkFzV3RzYm91?=
 =?utf-8?B?M1c4aVMvOEc4R0FYWmdkNU1ldjZuemtZWGl3RW1uZVlGZ1dudVJVM0o4c2I0?=
 =?utf-8?B?bWU4bnRqRVhaVm5aY01jcmFKaWVnSmlPRSs5VC9OSUJ3UUp5bWdsTlpPbnFk?=
 =?utf-8?B?cjhpcExPczB5alk2ZnAzL29vZGhzTlpkc3BiSjIxbVJaT0IweTFuVWRJSnBP?=
 =?utf-8?B?ZytXbTRaTEhYdDU2M0t1Q2kzS3EvbUhyMkNnOTZZaCtqN3grZmdNS3Vtd2lS?=
 =?utf-8?B?RE1ZWTczRlRPTVpDdXl3MFVQN2g4YXdEb1RrV2I3Z0NPV0VBdFVENVBiWWF0?=
 =?utf-8?B?ZW00MjFES2c3NFdna05hYUdrd2Q1b0c2ZUJWRTdVQzNhaGdaVDVYMFFaTk1i?=
 =?utf-8?B?WXpCZEpseEpSamw0eFozWUs1Yzc5UlMyVk5HbUN3K29kV3R6S1lQR0lsMDVY?=
 =?utf-8?B?STBwWkkxdFMra29PakZNTFVNMGpNcWJpUmFjSXhYQWNPclp6T3VPaXNaSDBS?=
 =?utf-8?B?SUIvTm5wNktUOWxSODJPSS9yQ2FsVEQyQ2hxMi9rbHlUNEVjakk3ak9hUk12?=
 =?utf-8?B?R01NR1V2ZEdvbXpCTUwwUHBENm5tR2QyYUZoOHlNNzFndkNXVG1pOEVEVVNX?=
 =?utf-8?B?QjhHcDJqVVRUNElXQ1ZYcEphT3RIeUZyVWZxUFVIK09QczN2TklKQnduZzVL?=
 =?utf-8?B?OTdKV2RSanBKQU5RUkZtMzBCR3B2WWQ3QVJVNkRuODZwV3lENlovcG1tQndZ?=
 =?utf-8?B?dkY5S055dUxJMW5LNDFlQ2YrNVI3WnA3NkthbnRQNUErRXVSY3FKMUlqbCtl?=
 =?utf-8?B?em81MWwyR1R0aGFoVWVZdGRRVkVxM2FhUml5TjNjSllMajRjaXFyTVNWUGVI?=
 =?utf-8?B?QUVLNldUYUZoTVV2QlJVc1BvRTgzZlVlT3RjWGxRZVBURXVmWEZVK0cvb3hu?=
 =?utf-8?B?a3E5TFV5REJ6V1FLc0FvTlpYcVZXWmF2WDkxNHAxMlQ1cFA0cHVhbUVsRWlX?=
 =?utf-8?B?WjFtK044VWpMbG84eWYwMlI0T0c0eU1RT1NOZWljR0ZLTEc1cFB5cGgzVWp4?=
 =?utf-8?B?M3BweEI5SEppcXBVK2VHbFRZWWxpQWJyT3lHWDVITTU1UC9vdXc0eFZOb2FJ?=
 =?utf-8?B?WFgrM3VJWlpKRU0vY2pzNjBtWHNybGhPbERpaEhuM1VicktuL0g0dTU4TGtD?=
 =?utf-8?B?TWI4RWJzWUdkMWVhV0pzVVowWXBzRnlEV1N3TGRNRnltSDI3UXZxTm5Jckx3?=
 =?utf-8?B?V3lkaFFHalZJMENzUFJwQTlpbDRkMXBEbUhMaTRLVEFlM1pySVh5Y3NGZXla?=
 =?utf-8?B?K1hOZlJWM3FwcGlOdlFNaTNrWnkzT2tuL295OHdwdFZWZWczWGc2cDREdDFz?=
 =?utf-8?B?bEJoM0JqVTNzbWJOa28wZDg2ZFJEUHFFUFF3em9LTkxWNWFYWUY4TE8wNUlB?=
 =?utf-8?B?Z0dtSjFncXpXTXA0dkNjNnNBVDdhQ3FkWHpkbTZycS9xQWcrVlpRYndqTTUw?=
 =?utf-8?B?bEFYTEhLQzhDeG1JZUk2WUFkeE9ieEp4ZDVWVjN5SCtMd25ldWE1L1I3anFh?=
 =?utf-8?Q?FGdg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0189eb3c-c374-47d7-9b56-08daef04a3f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 10:07:23.5673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aXZJFDRI+uYHJa5pUSpUlYDmAB/5hniiQq6BbxpsKbtX0pvkjl8h1fvSy72RExBHap1T0T1tGOZqgFp4USakRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7970
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkkgZGlkIG5vdCByZXBseSBpbiB0aW1lLiBTb3JyeSB0byBib3RoZXIgeW91LiBQbGVh
c2UgaWdub3JlIHRoaXMgcGF0Y2hzZXQuDQoNCkJlc3QgUmVnYXJkcywNCkFsaWNlIEd1bw0KDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERhbmllbCBMZXpjYW5vIDxkYW5p
ZWwubGV6Y2Fub0BsaW5hcm8ub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgSmFudWFyeSA1LCAyMDIz
IDU6NTkgUE0NCj4gVG86IEFsaWNlIEd1byAoT1NTKSA8YWxpY2UuZ3VvQG9zcy5ueHAuY29tPjsg
cmFmYWVsQGtlcm5lbC5vcmc7DQo+IGFtaXRrQGtlcm5lbC5vcmc7IHJ1aS56aGFuZ0BpbnRlbC5j
b207IEFpc2hlbmcgRG9uZw0KPiA8YWlzaGVuZy5kb25nQG54cC5jb20+OyBzaGF3bmd1b0BrZXJu
ZWwub3JnOyBMZW8gTGkNCj4gPGxlb3lhbmcubGlAbnhwLmNvbT4NCj4gQ2M6IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOw0KPiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMS8y
XSB0aGVybWFsOiBBZGQgZ2VuZXJpYyBkZXZpY2UgY29vbGluZyBzdXBwb3J0DQo+IA0KPiBPbiAw
NS8wMS8yMDIzIDA5OjIyLCBBbGljZSBHdW8gKE9TUykgd3JvdGU6DQo+ID4gRnJvbTogQW5zb24g
SHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4NCj4gPiBUbyBjb21wYXRpYmxlIHdpdGgg
cHJldmlvdXMgaW1wbGVtZW50YXRpb24sIGFkZCBnZW5lcmljIGRldmljZSBjb29saW5nDQo+ID4g
c3VwcG9ydCwgZWFjaCB0aGVybWFsIHpvbmUgd2lsbCByZWdpc3RlciBhIGNvb2xpbmcgZGV2aWNl
LCBhbmQgd2hlbg0KPiA+IHRlbXBlcmF0dXJlIGV4Y2VlZCBwYXNzaXZlIHRyaXAsIHRoZSBkZXZp
Y2UgY29vbGluZyBkcml2ZXIgd2lsbCBzZW5kDQo+ID4gb3V0IGEgc3lzdGVtIHdpZGUgbm90aWZp
Y2F0aW9uLCBlYWNoIGRldmljZSBzdXBwb3J0aW5nIGNvb2xpbmcgd2lsbA0KPiA+IG5lZWQgdG8g
cmVnaXN0ZXIgZGV2aWNlIGNvb2xpbmcgYW5kIHRha2VzIGFjdGlvbiB3aGVuIHBhc3NpdmUgdHJp
cCBpcw0KPiA+IGV4Y2VlZGVkOw0KPiANCj4gQ2FuIHlvdSBleHBsYWluIHRoZSB1c2UgY2FzZSB5
b3Ugd2FudCB0byBzb2x2ZSB3aXRoIHRoaXMgc29sdXRpb24gYW5kIHRoZQ0KPiBsaW1pdGF0aW9u
cyBvZiB0aGUgZXhpc3Rpbmcgb25lcyA/DQo+IA0KPiANCj4gLS0NCj4gPGh0dHA6Ly93d3cubGlu
YXJvLm9yZy8+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZvciBBUk0gU29D
cw0KPiANCj4gRm9sbG93IExpbmFybzogIDxodHRwOi8vd3d3LmZhY2Vib29rLmNvbS9wYWdlcy9M
aW5hcm8+IEZhY2Vib29rIHwNCj4gPGh0dHA6Ly90d2l0dGVyLmNvbS8jIS9saW5hcm9vcmc+IFR3
aXR0ZXIgfA0KPiA8aHR0cDovL3d3dy5saW5hcm8ub3JnL2xpbmFyby1ibG9nLz4gQmxvZw0KDQo=
