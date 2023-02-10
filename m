Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8EF691ED7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 13:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjBJMFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 07:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjBJMFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 07:05:21 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2048.outbound.protection.outlook.com [40.92.103.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83839138;
        Fri, 10 Feb 2023 04:05:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvZWx4s/7I+IwgkjV20kSA2Qg4w7CtDdnJ6hAdyT1Ql++c1VJGX7Ao3b/H4wz9rp4r6BA5YDVR93dgYXI3jbJkBIelzTnRDhL1vdTLFrUUYjEGetTAGpBWxIA5/2lPGplUDijV1Yk/2e7TYhgLkgw58ZXw+HrrHw1eeV1HPhCtVjdfqW7r+ABfXpinCz70epA+wBGd//cyhSDzH0V4XyEwJqTLsX227L0d5mN6txUzNrqiBY82XpERlrQi6K7mbkiH1zeBKFOXME9z2NxqG5ryDFJt1xXvHnwwa5/dDZS1fm9RSvVseJx1N8jnG7ajiNvNJSzyn+dK1n2BxYOW6W0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsD+jon+VuBQbmujetiB4S0hJ0zv4aA2mYjt00Pbhww=;
 b=LEoSvQHXZs72pUdGActEBDgbXyJwbEnbJZiiasZnPkC0HZiUYOFBqABOEDAvWI0m6nbuq/T7G64trqChscrrJCoOIju9VdjVxijuQTZr1vgeN8ER6SLbxrKOpnlZzZw4YUqQiT2VRs8Bz453YzoJ+qohMErAz3AekkHJ8Yx0MRsXSuoecDymRtLpZ3x6eFSzxNkHzQjxtzxUWdi+FkMzJU2axmmgX4AR6nkbiIoWMqp4LawR4F17zPSFXgkBeEOVa0iGJe3p+YPaAH2xaWriSZR494sI/RIBSk6ii6bn8ea3DOTBCstBcGn+AIYunVBLmRQc4sna6ZfIb+jcq+6LPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsD+jon+VuBQbmujetiB4S0hJ0zv4aA2mYjt00Pbhww=;
 b=OvW0ovbRaWvyOjT6aM1RKTq/62DqNhl8fr+oF+eqwLEkRDGJy5VA1lKjPNsQjTpXZyOCyS9qHfLHuE4FhI+lmmiyFB1qbMOYjnAESJ3AKcvN/3iE1QA8zfX9jtfZl37YiCmWj2G846YNDf0LeEtiFrTOq10Z4puOmL6pfRo2t9U1EEXAiU50YOSTAnOKZLirqb3XdBdw6i91PKwRepVeuYeNY1xYXpp6MdMyfSRU2eU9Du9UUKGpjTXvf20Tu+o9BiHShGVxI1brNRphBpvAuimQ4Vo6Ddsqd4a4PF4j5IOVPibHmsjlc4Eh0YMtYwGI6Sz4nMnI5qUppSs93ieC7A==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 MA0PR01MB7609.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:26::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.5; Fri, 10 Feb 2023 12:05:13 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::9dc7:9298:c988:474d]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::9dc7:9298:c988:474d%11]) with mapi id 15.20.6111.005; Fri, 10 Feb
 2023 12:05:13 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     =?utf-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <thomas@t-8ch.de>
CC:     Jiri Kosina <jikos@kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "kekrby@gmail.com" <kekrby@gmail.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>
Subject: Re: [PATCH 1/3] HID: apple-ibridge: Add Apple iBridge HID driver for
 T1 chip.
Thread-Topic: [PATCH 1/3] HID: apple-ibridge: Add Apple iBridge HID driver for
 T1 chip.
Thread-Index: AQHZPQwM5DSulXBskEykQ8jgSAssVq7IFbWA
Date:   Fri, 10 Feb 2023 12:05:13 +0000
Message-ID: <B9E319F8-6047-40E5-BD9F-D90D6504AA9E@live.com>
References: <E5D8BEBA-3C5B-460F-BD2C-39470A793CC3@live.com>
 <40274C3D-4F4F-479C-944C-EEBDC78F959C@live.com>
 <20230210045624.cjxroikmmvm3liij@t-8ch.de>
In-Reply-To: <20230210045624.cjxroikmmvm3liij@t-8ch.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [wN30vWiLefJOvp6Lt9pQe4n22hrqwkf3]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|MA0PR01MB7609:EE_
x-ms-office365-filtering-correlation-id: e802b543-f77c-4af5-66fd-08db0b5f10d7
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eI26vGCMDDUBAhF93UwgCb4IIH+MvmGAjTtBS6Okmdv3DWW4xiEwCUTl65RRBT3S72N2U5ny0zbP8RhuwKT1Fe1yaaDdF4ffpGSD1EwSWPwI2YAV+L89ot4YSIVP8opnzo7wGqJSPDoa1BNhjwWbHuAgIjnl0HrWv9HwAmLEi5HkFe0YUg29xZWTqFIkbpU9ouH7ELgWgBVsvASz+3hPG/AqJrAfWhXLNVVtcjS6yUE+P2gQRGMsDgMHQfvo2d35gYcuqcoi/vfuwc8K7jpbRroY0E0rZtwv8crDyrW32Tt78pQNQzPtN+N9IW8gUSFxi+hI82lDk/XdgkZA2RuwWXg/+31SQA0buI8dUuZqtvGw9L9Vq7l1u8toJ2NarzpZmM+bZhhIEXF1n672ScWAPac1ogWuGmltn75FaZiSjccss1SvkIoVTTvQ4vhw8D6BDq/kMVax6hXgrok/hOzTHlE56p19WCdNDoZ5Oqj0GrrvvRoPPJCLUYfeyzvHMlexB6sLM4Vk+wwstfv6D2pUipqFMXH/jGcIY69ibi1OOPl+BVHrIA5SFnAYNbG1kYYgKUTbBS1zYvPs7MIpqMawXHJSNrZDXtTe+wKexlIEgHpQNPLgXJH3pjG5JscecU5UVMH+FWfuZlp/9D0PKO/uhw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUFhdG16MUl4ZVZrME5MZThVTWpYeVVRdkI1OEwxb05TK2w4VnBGMWZCUG9U?=
 =?utf-8?B?bGFIWFVwRFVoWmdGaFU2QWVodUNHS29EN2x0K1RiMm52TStwa3lWNnk4ZTY1?=
 =?utf-8?B?Y01WVHF5ODVEdE9RRHdTUkJRQWhvT0tEUXJuVEt4U1BXQVo5MDRObHMzbHFj?=
 =?utf-8?B?bHZUOGkrdWc0cmQ5SlREekYvaTcrR2xEUzVlczBYVWVvOFhqSVVTNnlEZU1v?=
 =?utf-8?B?K3gzREhEMHdvTXh3cUd0R3pqQkNTMVBIN05WT2IzL1V5U3FHdHJ2UTdwcncv?=
 =?utf-8?B?YlNmeTJzajdNajF6MTVnUy9ieVhKOHNtaU9EZG5FUDBjcDR2NkhHU2dmK1Rv?=
 =?utf-8?B?K0VBNHZwbEJoSmltaTRhZFRvdHlCYXVIZjdDb3B0dTgvTS8vcms3anp2QkFr?=
 =?utf-8?B?Ym5HMnlaOHUvSE83Yyt3V0JlNkhiTm9aZ0tndzUzb2V0dmY0QXgyQjdHNVBu?=
 =?utf-8?B?Z0pUU1FaMzhLcDdKTUhMVjlIZ0ovUFlvNEI2YjNMOHhHUkhJRmRKakQ0elhp?=
 =?utf-8?B?cGlpSTdZRWtNMnl4SlVCQnZlOXEvTzFTOXhTY1hXVm1jTXg4YjQ1cFZHeFEv?=
 =?utf-8?B?N3FxVlVDZWdTOThVYWkwaGhES21Yd0tVNGQzZlNLd0xEQUlFUXVxUGRaNjU1?=
 =?utf-8?B?YXlyTnNYSXpNSnpOZkNrNGJnOUJ4Vnd5ME1teXpYODlkTXg3ZjUrRnNxY0Rl?=
 =?utf-8?B?T1g5dFJ3Z1dpNkU2bjlzbnpwTnZ4TGVEVkxvWkR5Zy9DaWtQUlUwMkVCWGM2?=
 =?utf-8?B?ajVhcEdZNWQvaFpEa2lLaFZVNExBU2V3YlVFVzVlUmZzZkszeHpORWF5MnFM?=
 =?utf-8?B?WjRoakhNZnBaR1lQRmh4VUF6RWFPT0NUQWNic0tDRFBjbzl1SVAwMy9xR0o4?=
 =?utf-8?B?OE5LT24zcDdpVWk5aG80akZmVEpCTXIvRW9Ua0hjZm5KZndDeDNRQzlFdmw1?=
 =?utf-8?B?aFlkU0NWU00va0k2dWZ0T1lCR01BOFE4QXorRHMvZTFQSCtRWWV4SnEvOTBl?=
 =?utf-8?B?SURxSnR0ZGVmc3RBWjFwcUZFV3ZIekpqcVFhWGxuQjdiRW1qMzByc3pnTVU0?=
 =?utf-8?B?Q1M4UHk1algrdjJzSjVXSllUVWhZb3BPR1pybkExVlorVkFvcTRydUlvanF5?=
 =?utf-8?B?QVdUWkxYTVBpTC8yRVdpZVNMS2ZYRTRXY0MxRWx3eUU0MGkxeHJOSERyMlgr?=
 =?utf-8?B?VzhPdjJIYXhqV2xjZ0lka2hKTUpVcjRYTDBJdEF2OUhkNGFDa21FRWkrUC8r?=
 =?utf-8?B?TVE0blVUZEFBR0lZODh4cXE3WGpZRGtoeUtLLzhwMm0zQzhJbG1yU0tSUEhm?=
 =?utf-8?B?VGJ3MTRNd1hIeHR4YU5Hb0NRMjFDUTNSTHo0OXREakZ6UzlrWE9BaTFBR1dj?=
 =?utf-8?B?TEhtbU40cndyV0RoSEVLTk5ORFZja1IvSFBic0RqdjhtZ0EwN0x0OW9GSlNG?=
 =?utf-8?B?WVcyKzd1VHpmd3BXVkJzbi9SWEp0UElDZEZPV0xVVE8yWlJ2RUFNMUk4VmZ4?=
 =?utf-8?B?MzhOV0JSTHhJZzFWTUVPT1cyZGIrRGJ4eDM2SndpQWIwbDVic3M1UHFJYVo4?=
 =?utf-8?B?RlBvaEhsNTM4ZVFuVDlzMGp3Q3FkcWxIRDlBYkZQMjhDbDNXSnIvSjhseERi?=
 =?utf-8?B?WHFsZ2ZSQWlsN3lJV01Ob0g5M1RjSTVwOW4zaXN3a25xZmtwaTNpbDgreENi?=
 =?utf-8?B?UmFmRVlJcDl6UlFLTXZIVHU1WVVBUHdadTFRZzE2WXF4cUxWc3BDZjVnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <465CC224BBF9534D8FCCF61A73E69451@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e802b543-f77c-4af5-66fd-08db0b5f10d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 12:05:13.4782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7609
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gMTAtRmViLTIwMjMsIGF0IDEwOjI2IEFNLCBUaG9tYXMgV2Vpw59zY2h1aCA8dGhv
bWFzQHQtOGNoLmRlPiB3cm90ZToNCj4gDQo+IEhpLA0KPiANCj4gc29tZSBjb21tZW50cyBpbmxp
bmUuDQo+IA0KPiBPbiBGcmksIEZlYiAxMCwgMjAyMyBhdCAwMzo0MzoyNEFNICswMDAwLCBBZGl0
eWEgR2FyZyB3cm90ZToNCj4gDQo+PiArDQo+PiArc3RhdGljIHN0cnVjdCB7DQo+PiArIHVuc2ln
bmVkIGludCB1c2FnZTsNCj4+ICsgc3RydWN0IGhpZF9kZXZpY2VfaWQgKmRldl9pZDsNCj4+ICt9
IGFwcGxlaWJfdXNhZ2VfbWFwW10gPSB7DQo+PiArIC8qIERlZmF1bHQgaUJyaWRnZSBjb25maWd1
cmF0aW9uLCBrZXkgaW5wdXRzIGFuZCBtb2RlIHNldHRpbmdzICovDQo+PiArIHsgMHgwMDAxMDAw
NiwgJmFwcGxlaWJfc3ViX2hpZF9pZHNbMF0gfSwNCj4+ICsgLyogT1MgWCBpQnJpZGdlIGNvbmZp
Z3VyYXRpb24sIGRpZ2l0aXplciBpbnB1dHMgKi8NCj4+ICsgeyAweDAwMEQwMDA1LCAmYXBwbGVp
Yl9zdWJfaGlkX2lkc1swXSB9LA0KPj4gKyAvKiBBbGwgaUJyaWRnZSBjb25maWd1cmF0aW9ucywg
ZGlzcGxheS9ERlIgc2V0dGluZ3MgKi8NCj4+ICsgeyAweEZGMTIwMDAxLCAmYXBwbGVpYl9zdWJf
aGlkX2lkc1swXSB9LA0KPj4gKyAvKiBBbGwgaUJyaWRnZSBjb25maWd1cmF0aW9ucywgQUxTICov
DQo+PiArIHsgMHgwMDIwMDA0MSwgJmFwcGxlaWJfc3ViX2hpZF9pZHNbMV0gfSwNCj4+ICt9Ow0K
PiANCj4gY29uc3QNCj4gDQoNCkNvbnN0YW50aWZ5aW5nIHRoaXMgcmVzdWx0cyBpbiBjb21waWxl
ciBnaXZpbmcgd2FybmluZ3MNCg0KZHJpdmVycy9oaWQvYXBwbGUtaWJyaWRnZS5jOjc4OjIzOiB3
YXJuaW5nOiBpbml0aWFsaXphdGlvbiBkaXNjYXJkcyAnY29uc3QnIHF1YWxpZmllciBmcm9tIHBv
aW50ZXIgdGFyZ2V0IHR5cGUgWy1XZGlzY2FyZGVkLXF1YWxpZmllcnNdDQogICA3OCB8ICAgICAg
ICAgeyAweDAwMjAwMDQxLCAmYXBwbGVpYl9zdWJfaGlkX2lkc1sxXSB9LA0KICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgXg0KZHJpdmVycy9oaWQvYXBwbGUtaWJyaWRnZS5jOiBJbiBmdW5j
dGlvbiAnYXBwbGVpYl9hZGRfc3ViX2Rldic6DQpkcml2ZXJzL2hpZC9hcHBsZS1pYnJpZGdlLmM6
MzYzOjI5OiB3YXJuaW5nOiBhc3NpZ25tZW50IGRpc2NhcmRzICdjb25zdCcgcXVhbGlmaWVyIGZy
b20gcG9pbnRlciB0YXJnZXQgdHlwZSBbLVdkaXNjYXJkZWQtcXVhbGlmaWVyc10NCiAgMzYzIHwg
ICAgICAgICBzdWJfaGRldi0+bGxfZHJpdmVyID0gJmFwcGxlaWJfbGxfZHJpdmVyOw0KICAgICAg
fCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KZHJpdmVycy9oaWQvYXBwbGUtaWJyaWRn
ZS5jOiBJbiBmdW5jdGlvbiAnYXBwbGVpYl9oaWRfcHJvYmUnOg0KZHJpdmVycy9oaWQvYXBwbGUt
aWJyaWRnZS5jOjQzNjoxMjogZXJyb3I6IGV4cGVjdGVkICcoJyBiZWZvcmUgJ2hpZF9pc191c2In
DQogIDQzNiB8ICAgICAgICAgaWYgaGlkX2lzX3VzYihoZGV2KQ0KICAgICAgfCAgICAgICAgICAg
IF5+fn5+fn5+fn4NCiAgICAgIHwgICAgICAgICAgICAoDQpJbiBmaWxlIGluY2x1ZGVkIGZyb20g
ZHJpdmVycy9oaWQvYXBwbGUtaWJyaWRnZS5jOjQ4Og0KZHJpdmVycy9oaWQvYXBwbGUtaWJyaWRn
ZS5jOiBJbiBmdW5jdGlvbiAnYXBwbGVpYl9wcm9iZSc6DQpkcml2ZXJzL2hpZC9hcHBsZS1pYnJp
ZGdlLmM6NTQ0OjM1OiB3YXJuaW5nOiBwYXNzaW5nIGFyZ3VtZW50IDEgb2YgJ19faGlkX3JlZ2lz
dGVyX2RyaXZlcicgZGlzY2FyZHMgJ2NvbnN0JyBxdWFsaWZpZXIgZnJvbSBwb2ludGVyIHRhcmdl
dCB0eXBlIFstV2Rpc2NhcmRlZC1xdWFsaWZpZXJzXQ0KICA1NDQgfCAgICAgICAgIHJldCA9IGhp
ZF9yZWdpc3Rlcl9kcml2ZXIoJmFwcGxlaWJfaGlkX2RyaXZlcik7DQogICAgICB8ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+DQouL2luY2x1ZGUv
bGludXgvaGlkLmg6ODk4OjMxOiBub3RlOiBpbiBkZWZpbml0aW9uIG9mIG1hY3JvICdoaWRfcmVn
aXN0ZXJfZHJpdmVyJw0KICA4OTggfCAgICAgICAgIF9faGlkX3JlZ2lzdGVyX2RyaXZlcihkcml2
ZXIsIFRISVNfTU9EVUxFLCBLQlVJTERfTU9ETkFNRSkNCiAgICAgIHwgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXn5+fn5+DQouL2luY2x1ZGUvbGludXgvaGlkLmg6ODkzOjQ3OiBub3Rl
OiBleHBlY3RlZCAnc3RydWN0IGhpZF9kcml2ZXIgKicgYnV0IGFyZ3VtZW50IGlzIG9mIHR5cGUg
J2NvbnN0IHN0cnVjdCBoaWRfZHJpdmVyIConDQogIDg5MyB8IGV4dGVybiBpbnQgX19tdXN0X2No
ZWNrIF9faGlkX3JlZ2lzdGVyX2RyaXZlcihzdHJ1Y3QgaGlkX2RyaXZlciAqLA0KICAgICAgfCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+
fn5+fn5+fg0KZHJpdmVycy9oaWQvYXBwbGUtaWJyaWRnZS5jOiBJbiBmdW5jdGlvbiAnYXBwbGVp
Yl9yZW1vdmUnOg0KZHJpdmVycy9oaWQvYXBwbGUtaWJyaWRnZS5jOjU1ODozMTogd2FybmluZzog
cGFzc2luZyBhcmd1bWVudCAxIG9mICdoaWRfdW5yZWdpc3Rlcl9kcml2ZXInIGRpc2NhcmRzICdj
b25zdCcgcXVhbGlmaWVyIGZyb20gcG9pbnRlciB0YXJnZXQgdHlwZSBbLVdkaXNjYXJkZWQtcXVh
bGlmaWVyc10NCiAgNTU4IHwgICAgICAgICBoaWRfdW5yZWdpc3Rlcl9kcml2ZXIoJmFwcGxlaWJf
aGlkX2RyaXZlcik7DQogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+
fn5+fn5+fn5+fn5+fn4NCi4vaW5jbHVkZS9saW51eC9oaWQuaDo5MDA6MzU6IG5vdGU6IGV4cGVj
dGVkICdzdHJ1Y3QgaGlkX2RyaXZlciAqJyBidXQgYXJndW1lbnQgaXMgb2YgdHlwZSAnY29uc3Qg
c3RydWN0IGhpZF9kcml2ZXIgKicNCiAgOTAwIHwgZXh0ZXJuIHZvaWQgaGlkX3VucmVnaXN0ZXJf
ZHJpdmVyKHN0cnVjdCBoaWRfZHJpdmVyICopOw0KICAgICAgfCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fg0KbWFrZVs2XTogKioqIFtzY3JpcHRz
L01ha2VmaWxlLmJ1aWxkOjI1MDogZHJpdmVycy9oaWQvYXBwbGUtaWJyaWRnZS5vXSBFcnJvciAx
DQptYWtlWzVdOiAqKiogW3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6NTAwOiBkcml2ZXJzL2hpZF0g
RXJyb3IgMg0KbWFrZVs1XTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9ic+KApi4NCg0K
U29tZSB3YXJuaW5ncyBhcmUgYWxzbyBkdWUgdG8gYSB0eXBvIGluIGlmIGFuZCBjb25zdGFudGlm
eWluZyBgc3RhdGljIHN0cnVjdCBoaWRfZHJpdmVyYCwgYWx0aG91Z2ggdGhleSBwcm9iYWJseSBj
YW4NCmJlIGZpeGVkLg0KDQpJbiBzaG9ydCwgVGhvbWFzLCBkbyB5b3UgcmVhbGx5IHdhbnQgbWUg
dG8gY29uc3RhbnRpZnkgdGhlIHN0cnVjdHVyZSBJIGFtIHRhbGtpbmcgYWJvdXQgaW4gdGhpcyBl
bWFpbCwgYXMgd2VsbCBgc3RhdGljIHN0cnVjdCBoaWRfZHJpdmVyYD8NCg0K
