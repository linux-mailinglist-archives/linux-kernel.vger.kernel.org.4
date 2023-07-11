Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF3A74F046
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjGKNgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGKNgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:36:45 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2160.outbound.protection.outlook.com [40.92.63.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C48E6F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:36:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciW9dEESDx18Bo+iRcAt9fG75a4wmLvU8CXbzek8V8QXJobfG1vOII8iMofJhCvSXACzRxgahwfJPRr1byh2yNHPxqLX7nTNdlSRlU0LmTstTbBVVfBbq4Xv1ZcAX0e9Ef9pPv8Tf6xEIgbQVT1ySk/J9Hx7LiDuilg06O8zzuK+GASCzMMPE5JiYzGyzN99QkxhURie/lC7Rh+AjqA5dR2h4rOwphf/CGaEUYdoNVVtZk5AcrOykivoUbJeYenpvEEgeDf0y/lJ815VPw71IXEYGLoAkAB/iS54Zd4PKzqKln2rNHRQ+Dedn3XmFhttAyxl/4Na/D9ERDsQYMwa3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/W5Pw+OmblAvdgPynIGXbCqrj81I6Jj8L0+aW9ZgqOU=;
 b=OdUCPij9mYchkO2COE9z2I5pMFecCOIrYiWqkuI9zFTcn01+UBbCmpWyARUolVJB6WTYR7m51d4S0CHZ5EJ4BwCvSlX73A6asdjuxrQYlqU/cY61/dIHoCfeBRJMD0EAz8/yiSjwT3ugTZUsTP4MAa0dWH3ZMXxMk6FO5uAxxVA4ZBeGvpuIWQbQrJP4uSFphSdg8+S2qeJkSmQvMi7sx1snNqAmYlQyhu6kJrav44/9++EbXWP8wblq9U8FIP6jqsNH0PfAg2FrOf5vq1z67eBmixHFxzGwYaVP4x+8yGhUKzBymkb4B2zj+npoUQuhMi9BPg4PblOdtAYTkGOWAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/W5Pw+OmblAvdgPynIGXbCqrj81I6Jj8L0+aW9ZgqOU=;
 b=ZUv4cCnFhDvGWs0BtDW7b2o4SG33ibPkB0JkbS2jDAXlVr9Za9Z52U0p9qXVZC4rITePKtXYwcVoYtXbfX/yoqqi9VS7eQCYH2YAkHZJaE3OzXV2Qshorn+0p3/nQeAsfKIeO7TKHXTZaBaNtLxiDfpIx2C0dBtJZ5aAewEkxPjJafiK9SklpbdUSpdtUvsAG94bJyoTfgUc61PWS55KGpc64NOQmVBvyWe778UbPEyWaT3Lv2ipXCK8/3mELKPogrhd3poUUx+NkHrgBBQR/nwLolvapNVVFp2WKPaD8PB0ZUKyzdAZByh0b4LjTcty/OPdPk66242CX9dlAmQwgg==
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:128::9)
 by SYBP282MB2724.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:153::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Tue, 11 Jul
 2023 13:36:39 +0000
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::46f9:569d:f1c:4f6f]) by MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::46f9:569d:f1c:4f6f%4]) with mapi id 15.20.6588.017; Tue, 11 Jul 2023
 13:36:39 +0000
From:   =?utf-8?B?4oCOIGRvbm1vcg==?= <donmor3000@hotmail.com>
To:     "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
        "xry111@xry111.site" <xry111@xry111.site>,
        "kernel@xen0n.name" <kernel@xen0n.name>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "tangyouling@loongson.cn" <tangyouling@loongson.cn>,
        "yangtiezhu@loongson.cn" <yangtiezhu@loongson.cn>,
        "zhoubinbin@loongson.cn" <zhoubinbin@loongson.cn>
Subject: Re: [PATCH v2] LOONGARCH: Make CONFIG_CMDLINE work with
 CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER
Thread-Topic: [PATCH v2] LOONGARCH: Make CONFIG_CMDLINE work with
 CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER
Thread-Index: AQHZs/t6emFy87WPUkSMudE1C5wLlq+0kE+AgAABI4A=
Date:   Tue, 11 Jul 2023 13:36:39 +0000
Message-ID: <9e6c9fc1f70e7eac34290e0c38cd7d6989162403.camel@hotmail.com>
References: <MEYP282MB2597022C264B501FE1B9C40AD931A@MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM>
         <d8e2e93e6cf07846621b15104ce89b430ee8426f.camel@xry111.site>
In-Reply-To: <d8e2e93e6cf07846621b15104ce89b430ee8426f.camel@xry111.site>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [qaPAa1YPsbrscYYZB0X21fyFTGPCCrK9LEYtzU775hMRkY8Xwv8ouYUFEc/3Ooa6]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MEYP282MB2597:EE_|SYBP282MB2724:EE_
x-ms-office365-filtering-correlation-id: accd08e6-573d-4043-9390-08db8213daea
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5kBrXWrQNSqnRsOD801nun96Qw+VtWtHdynNZ4pepg5eDBRj26S1jwvq8vt7qJP6MUzmrDmftM0j2VH9TxTZ2de+nPDFO6IHOLJgzz4DEZ6p+7q+mMrpfyAi81Xqx63DGEKHozcjTrIfoaLzCXhUFj4w/FN+hZiUICE3Ts6gDHxWBDN/f7sOugJQww0ovGZBw/KgOFMaty0CNwam3DLUgsYJDhdkH+HFexUZI8/Ss+GxSs/4KYmgFBYhnW0Q3doyReMTagtFZf/DDrLWh9Nia9HRWG5+3JZn+Rd+hbSbWsLnyr5M3xV4A+NBGEeCLj68soRJImi41rBVRGyh2U3IttAaX+WIXYoQsgYrWvYJbREVzGfM0pRM28ciW1St+/IXyev9d9oaG+/Id1pMVyak6ft9MjdrtpL5dDJzfA9kt3HkMFyDd5yLAnE4ujwwG/slYrgveRJMub41xY3QJ8Fj5yuD2FlZpd+3MWfZOMMwkxFo2zPwQr38H1OCPkNqC+scAITpGK26Y9mKsqTF4Qipf4GpV07kOWZDzC+oNPBuRv6P/8Q/ytJs3nXczNz4MeZv
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHBxKzRGSGZqRmxWUVNIdGRUUmNRTnVLNEFQZTZnaDlBWHBiZ29NNmd6c2Z5?=
 =?utf-8?B?MG91WWZ4S0FsTmtBUXlCZTRqaGRkS3licTZldTNmd1JKQ2hCQTErWGZ5Qld2?=
 =?utf-8?B?dHg5bDh4YjBYaU9TZFRNaWVScjY1QkJjNlYrQmFHK3pidCtLQjBsOC9BYmRx?=
 =?utf-8?B?SWFNSnlpaFBGNTFNZVkzQzdOSFlydXcwOUtPVDdMRWVWK014NHk4VEQ3dllQ?=
 =?utf-8?B?RGh2YzBGMyt2VDNKcVptU1FvMndBNXYzaDJHVmFkdnBOQmtqWjlsaE45WnJk?=
 =?utf-8?B?RmRucTlsd0dmZExVWUcrc0VrR2RVNXoxQ3lOTnVDU2JHYklzRUZVVVhoekxl?=
 =?utf-8?B?NFFsZnFxdDIwNllkOUpvNk5VTGVFbjkybndHS3lCSUtpZG9Fcjd4M2Zidkhr?=
 =?utf-8?B?aUxEZFY1RXJqcmQvOWlVQ3hMbDBBdnNJL3BEZFBrYlg1RDlraDZSUlVCRG50?=
 =?utf-8?B?VmkrK1pscnpQa3lCZ3JsNTBNRlE5d2NLZW5aUjZFQnRoLzRQR3VPU0lNajR4?=
 =?utf-8?B?VDlEWVNSRXJnUkY4Yzd4M0dodGdYQ3k5Q2srdmVmQkhzTEdPc28zR3lKYlEx?=
 =?utf-8?B?UVplSTM5dTJCSVJndktoTEtjZ01JVHFDRllRZ1EwQkhHc25qUWt0WkZ2azJE?=
 =?utf-8?B?ZVBpb0QwS1lRU1d6Z3dSSWdmd0dncGtza3pLMkZ6U2YrK0NtOHpqMmFXb1Q2?=
 =?utf-8?B?dXhQR1BqZFY2VUJNK3phRUlsNU5PMXVxTTlIWjhXbnBvUDZkaFdDeTR5SW9o?=
 =?utf-8?B?Q2FmeGlQeG53MUhDSm52aFBIeG9MblZGd1F6SjFCSmw1SkNJcGFNc2dOekt1?=
 =?utf-8?B?bEhyWnVDSnp3bSthRWN3bU5yWkt0YXlHdlVSdUJlTlcxOHNHZE0yWGFCMUli?=
 =?utf-8?B?djNpUGc0cFR1QTd1d1hmY3VkKzROZURFd0ExVllBaGU5cCs1Yy85L1J5ZlFE?=
 =?utf-8?B?bGYra2tZbUZ3TmJqMUFMTklXa01lZHgyekZveTZiZ3k3VzFYeWVndjZqRXA3?=
 =?utf-8?B?UERqRU40aTBFYSt1cFhnUjEyUUVSN1B1UmZQcUg2RkgrdWVoWElhbW5PNlJO?=
 =?utf-8?B?S2tRY2szSExXWEM0ak01c1ZMczJVeTEyRU5UZlc1ZnAyWVR4VHJ0ckY1T2ds?=
 =?utf-8?B?dzR1bmdHYlI2M1YxdUJnTjBPUTJwL2t2T1k4RVFYaUt3YVZtKzdhTGkrR2Nn?=
 =?utf-8?B?YWdZWFNJbjdPRzk4U2ZiSWZ6K2xGWVhNNGVTQUhyektFeHloVjZPdEhuNzZN?=
 =?utf-8?B?dVZPeUY0eDFiakJjMWUwME11UVRTYzdyaHVCdXlFbzVhZis0Q2l5QXQ5WnFk?=
 =?utf-8?B?b0RjZGZQMFhDSndEYTZrZzJ1NnZhYXBCUUk2Z0ZiS1dIU00wenB2eVkyZGl0?=
 =?utf-8?B?akoxNnJ6NGVFa2lEa3dsZXpwMTdQZTdwNUZlOGFibXVGNktuamZHc21XQW9R?=
 =?utf-8?B?VTV3MVZnRTdBWHF4RnhiUXhxdmZ0ZDJ4VEM5TVY3NEJPR1B1UWhiQ2tQS1d3?=
 =?utf-8?B?YlMwNWttZjBPT3JUWllrUXJMWWZNWjkvSElXQmZVSXNpdzFidFFaT2g2RC92?=
 =?utf-8?B?QTNTK1JNc0RIR01qSlh1S05TN2FkK0ZXTVMvTkxGZThOQW9MOUtRQjFIYTBK?=
 =?utf-8?B?ZWZvOUJadFJWSmtXUFFXRG0xTTFNdXVncktJL3ZIeUZUaXYybCs5cGFLaXVQ?=
 =?utf-8?B?UUZSczJ2Y3huSTRYNHkxY2diRDdJd1lIOUtITlNrVHVMSU5CRGtpVlMwNFln?=
 =?utf-8?Q?2ZDzRizt6P+TCHg2xw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A09920EC74DD9046A1FEA442A8EC3AD9@AUSP282.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: accd08e6-573d-4043-9390-08db8213daea
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 13:36:39.1717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBP282MB2724
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T2theSBJJ2xsIGdldCBpdCBhbWVuZGVkIHJpZ2h0IG5vdy4NCg0KZG9ubW9yDQoNCuWcqCAyMDIz
LTA3LTEx5pif5pyf5LqM55qEIDIxOjMyICswODAw77yMWGkgUnVveWFv5YaZ6YGT77yaDQo+IFVz
ZSAiTG9vbmdBcmNoIiBpbnN0ZWFkIG9mICJMT09OR0FSQ0giLiAgIkxPT05HQVJDSCIgc2hvdWxk
IG9ubHkgc2hvdyB1cA0KPiBpbiBtYWNybyBuYW1lcywgZW51bSB2YWx1ZSBuYW1lcywgZXRjLg0K
PiANCj4gT24gVHVlLCAyMDIzLTA3LTExIGF0IDIxOjI3ICswODAwLCBEb25nIFpoaWhvbmcgd3Jv
dGU6DQo+ID4gVGhpcyBwYXRjaCB0ZW5kcyB0byBtYWtlIENPTkZJR19DTURMSU5FIHdvcmsgd2l0
aCBDT05GSUdfQ01ETElORV9FWFRFTkQNCj4gDQo+IEFzIE1hcmt1cyBhbHJlYWR5IHRvbGQgeW91
LCBzdWJtaXR0aW5nLXBhdGNoZXMucnN0IHNheXM6DQo+IA0KPiAiRGVzY3JpYmUgeW91ciBjaGFu
Z2VzIGluIGltcGVyYXRpdmUgbW9vZCwgZS5nLiAibWFrZSB4eXp6eSBkbyBmcm90eiINCj4gaW5z
dGVhZCBvZiAiW1RoaXMgcGF0Y2hdIG1ha2VzIHh5enp5IGRvIGZyb3R6IiBvciAiW0ldIGNoYW5n
ZWQgeHl6enkNCj4gdG8gZG8gZnJvdHoiLCBhcyBpZiB5b3UgYXJlIGdpdmluZyBvcmRlcnMgdG8g
dGhlIGNvZGViYXNlIHRvIGNoYW5nZQ0KPiBpdHMgYmVoYXZpb3VyLiINCj4gDQo+IGkuIGUuICJN
YWtlIENPTkZJR19DTURMSU5FIHdvcmsgd2l0aCAuLi4iLg0KPiANCj4gPiBhbmQgQ09ORklHX0NN
RExJTkVfQk9PVExPQURFUi4gVGhlIHRvdWNoZWQgZnVuY3Rpb24gaXMgYm9vdGNtZGxpbmVfaW5p
dCgpYC4NCj4gPiBUaGVyZSdzIGFscmVhZHkgY29kZSBoYW5kbGluZyBDT05GSUdfQ01ETElORV9G
T1JDRSwgd2hpY2ggcmVwbGFjZXMNCj4gPiBgYm9vdF9jb21tYW5kX2xpbmVgIHdpdGggQ09ORklH
X0NNRExJTkUgYW5kIGltbWVkaWF0ZWx5YGdvdG8gb3V0YC4gSXQnZCBiZQ0KPiA+IHNpbWlsYXIg
d2F5IHRvIGhhbmRsZSBDT05GSUdfQ01ETElORV9FWFRFTkQgYW5kIENPTkZJR19DTURMSU5FX0JP
T1RMT0FERVIsDQo+ID4gc28gSSBhZGRlZCBzb21lIGNvZGUgYWZ0ZXIgT0ZfRkxBVFRSRUUgcGFy
dCB0byBoYW5kbGUgdGhlbS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBEb25nIFpoaWhvbmcg
PGRvbm1vcjMwMDBAaG90bWFpbC5jb20+DQo+ID4gLS0tDQo+ID4gDQo+ID4gdjIgLT4gdjE6UmV3
b3JkZWQgdGhlIGNvbW1pdCBtZXNzYWdlIHNvIGl0J3MgbW9yZSBpbXBlcmF0aXZlIChNYXJrdXMp
Ow0KPiA+ICAgICAgICAgQWRkZWQgYGdvdG8gb3V0YCB0byBGRFQgcGFydCAoSHVhY2FpKQ0KPiA+
IA0KPiA+ICBhcmNoL2xvb25nYXJjaC9rZXJuZWwvc2V0dXAuYyB8IDE3ICsrKysrKysrKysrKysr
KysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlm
ZiAtLWdpdCBhL2FyY2gvbG9vbmdhcmNoL2tlcm5lbC9zZXR1cC5jIGIvYXJjaC9sb29uZ2FyY2gv
a2VybmVsL3NldHVwLmMNCj4gPiBpbmRleCA3OGEwMDM1OWJkZTMuLjNjYWZkYTFhNDA5ZSAxMDA2
NDQNCj4gPiAtLS0gYS9hcmNoL2xvb25nYXJjaC9rZXJuZWwvc2V0dXAuYw0KPiA+ICsrKyBiL2Fy
Y2gvbG9vbmdhcmNoL2tlcm5lbC9zZXR1cC5jDQo+ID4gQEAgLTMzMiw3ICszMzIsMjQgQEAgc3Rh
dGljIHZvaWQgX19pbml0IGJvb3RjbWRsaW5lX2luaXQoY2hhciAqKmNtZGxpbmVfcCkNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICBzdHJsY2F0KGJvb3RfY29tbWFuZF9saW5lLCAiICIsIENP
TU1BTkRfTElORV9TSVpFKTsNCj4gPiAgDQo+ID4gICAgICAgICAgICAgICAgIHN0cmxjYXQoYm9v
dF9jb21tYW5kX2xpbmUsIGluaXRfY29tbWFuZF9saW5lLCBDT01NQU5EX0xJTkVfU0laRSk7DQo+
ID4gKyAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPiA+ICsgICAgICAgfQ0KPiA+ICsjZW5kaWYN
Cj4gPiArDQo+ID4gKyNpZmRlZiBDT05GSUdfQ01ETElORQ0KPiA+ICsgICAgICAgLyoNCj4gPiAr
ICAgICAgICAqIElmIENPTkZJR19DTURMSU5FX0JPT1RMT0FERVIgaXMgZW5hYmxlZCB0aGVuIHdl
IHVzZSB0aGVpIGJ1aWx0LWluDQo+ID4gKyAgICAgICAgKiBjb21tYW5kIGxpbmUgaWYgbm8gY29t
bWFuZCBsaW5lIGdpdmVuLCBvciB3ZSBhcHBlbmQgZ2l2ZW4gY29tbWFuZA0KPiA+ICsgICAgICAg
ICogbGluZSB0byB0aGUgYnVpbHQtaW4gb25lIGlmIENPTkZJR19DTURMSU5FX0VYVEVORCBpcyBl
bmFibGVkLg0KPiA+ICsgICAgICAgICovDQo+ID4gKyAgICAgICBpZiAoSVNfRU5BQkxFRChDT05G
SUdfQ01ETElORV9FWFRFTkQpKSB7DQo+ID4gKyAgICAgICAgICAgICAgIHN0cnNjcHkoYm9vdF9j
b21tYW5kX2xpbmUsIENPTkZJR19DTURMSU5FLCBDT01NQU5EX0xJTkVfU0laRSk7DQo+ID4gKyAg
ICAgICAgICAgICAgIHN0cmxjYXQoYm9vdF9jb21tYW5kX2xpbmUsICIgIiwgQ09NTUFORF9MSU5F
X1NJWkUpOw0KPiA+ICsgICAgICAgICAgICAgICBzdHJsY2F0KGJvb3RfY29tbWFuZF9saW5lLCBp
bml0X2NvbW1hbmRfbGluZSwgQ09NTUFORF9MSU5FX1NJWkUpOw0KPiA+ICAgICAgICAgfQ0KPiA+
ICsNCj4gPiArICAgICAgIGlmIChJU19FTkFCTEVEKENPTkZJR19DTURMSU5FX0JPT1RMT0FERVIp
ICYmICFib290X2NvbW1hbmRfbGluZVswXSkNCj4gPiArICAgICAgICAgICAgICAgc3Ryc2NweShi
b290X2NvbW1hbmRfbGluZSwgQ09ORklHX0NNRExJTkUsIENPTU1BTkRfTElORV9TSVpFKTsNCj4g
PiAgI2VuZGlmDQo+ID4gIA0KPiA+ICBvdXQ6DQo=
