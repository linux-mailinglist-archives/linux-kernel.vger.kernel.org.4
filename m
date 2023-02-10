Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF6F6922A3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjBJPuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjBJPuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:50:09 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2039.outbound.protection.outlook.com [40.92.103.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B27770956;
        Fri, 10 Feb 2023 07:50:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0YrtKjg+V5GeYWPobwPaUH+Iel0/PVZlDqpxPD4jBUfVV/R4/DxVaYWLAGBAcQSp0t8waZ/6GCAhnL4ijSP651OLAvFMSW0bO77Xtaf1CyVGHQ7ikuHa8zWi6o5Des+LEhRKp+VPgv0CYFy/YJw4qIS9X5Y3qkyQU2wI+N5v7UgektRSu3nhLxpSQ3yugx/z26nf7UvPyxiNPkGsv9nK3dp8jMukk65+JQtz7Y9BXfdzLVYr4XPpgP/GSqEwScyavnOYAVN2XuZ59sPNyEZbGmghm8hbc6sjHJ1BhDdD8oixmCEmGU33PDmFRy9rumIZPuGqE6+bo9o4oh+04P6rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgUQI2cKqq29RMvEwO6jVLXyv85g1QSht872Ww9fec4=;
 b=DV3BQSwuYozv21thaZ7BPL8cjl9aTHo6hd4eeNMSU0jJhMNQJzehRjsuQWBwIRHnASgHf83YtqJg/kxn+Ay8ExYnFD5CVkbxxaHUYoD+53lB3YgWOK0dkge/NZAu9P6/BlZI5QlWsmPkYsgZEayBu07Fmn85DXwN6h2OGr6INKW/iDM38Rz7J6jp/3h4ozxKj9TdPrRrAiMQ62h0S/2+QUTPoeewkdIXDLjNOBfL4UEdcQwYZiqPZJI9Pw8LBJtTVN5KpymcD/74t/JU2uDtEIb/XOzbMQ5vZ+WuPF6zjKUKVRQs5AE/VMcsbKqohlFFG9uCGKJk4cvi6qNxKjjPyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgUQI2cKqq29RMvEwO6jVLXyv85g1QSht872Ww9fec4=;
 b=bmpfi8Ki35Uh5QDYqxe33rJjiJ1hHuMO93HKzxSxaZqvcfcABQiO7cUSX/y8w5u45HOnZAT1MqjzsNvS4+WtA2Np7I3WE+9aSUeC54xAtPHbJMSu03t328hXYYZYe5FB8EeW3sPE/tOATvzboBNNF+JINKvS590beyLHisajkZm7285FTMUW2StGf5L8KGUx3RLZ3MQ7nKQCiaCw7zzQi3EBLMbwfRQQ1uOfQgsygDBjsyx9Lk0XAfRfRLawA2FLf/buVlFwl7CbdHtx+oyKM6F42dUAYBdhEAvi3ht/G7h9nMQ1I46d4HPdNJmiDVX25C1z7P4L6qYpA7EOvcD24Q==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 PN3PR01MB8659.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:d0::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.5; Fri, 10 Feb 2023 15:49:59 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::9dc7:9298:c988:474d]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::9dc7:9298:c988:474d%11]) with mapi id 15.20.6111.005; Fri, 10 Feb
 2023 15:49:59 +0000
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
Thread-Index: AQHZPQwM5DSulXBskEykQ8jgSAssVq7IFbWAgAA6XwCAAAR8/A==
Date:   Fri, 10 Feb 2023 15:49:59 +0000
Message-ID: <BM1PR01MB09315DC70770D236DD29D007B8DE9@BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM>
References: <E5D8BEBA-3C5B-460F-BD2C-39470A793CC3@live.com>
 <40274C3D-4F4F-479C-944C-EEBDC78F959C@live.com>
 <20230210045624.cjxroikmmvm3liij@t-8ch.de>
 <B9E319F8-6047-40E5-BD9F-D90D6504AA9E@live.com>
 <20230210153356.zdj7gw7ztbgz2qx7@t-8ch.de>
In-Reply-To: <20230210153356.zdj7gw7ztbgz2qx7@t-8ch.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [NKIfIui+tj6+Pb9qNzOcWDJK7u1BRiz9MbiIg5D/g+srMO6Wsbv7Rkn8QvGY5Hd4]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|PN3PR01MB8659:EE_
x-ms-office365-filtering-correlation-id: 4a4f7fca-4acd-4b02-7720-08db0b7e771e
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y/tHcSgqsMycCqt6UKrTKPQk04f9lqzwOH38c5DCS1XeH884IDNBnkNJxUUzwC0VNoK/98oD55TsB74ydjyU2Co8arrgwjB8urnDhtHlu76TFKXooJRLF57FmUR5Y5NENQP0T4ZBK0+6FTANZGanoB9mXOC6OiLKR91hMgD4q7IxBm37Fqk0gq3I0LoWsjaBtnHHktlWxY2LkNIUiPy0S2TOB/DUUJzN8dPgHN8H9vsx5srjC5wvjlT74NYEgoQNHY/oEst3ujw1yqk9n4nEC10gUGaZP4usXPozdZlUkxQBxrj3tbauKixeFCYnMe41Gilp4s0fbxj+HCnRoaIf3mmNTAv2nSS90x2XIIIJtVILfSBRubk8O22s8ZlvN7HSJtfzodlVQCuoABf8pzjmxRyLbwLrTBbgTAHrt0VrLq9MkjkRcywGm7AHR40YvddX+lzeibtVHKfhTYSL58G/u8btU639UtJUm+AiOZh2D1ovl8uJMPhbV/tgoAaSWgkNmZ+MzzWARmbmIc99nmjWL+xi7jY377an1kyPcENFkisQ2PRYAajACnjU92udyazSLUI4qJl/Bn184P39/SiFoj5kk4VoFBFGN9jd4Buz4LTALecYjGA3/2S6UTS4QMg6gi6zKCK10QN21RAwQJPnnA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVpVSGUvc0c2R2FNRzIvWDVIR20vellub21RTm4rV1JVUGpnVnBwTjVaWjhK?=
 =?utf-8?B?c1pnMklkWFBLWTNCZUZnMGFncWRMOC9JdExlWXN2Yk5JcUE4ZUM5RDJ5cmdI?=
 =?utf-8?B?dk43WCtSODEwUHlwSjg0ZTdiY242YThpd1d5b1l5NWIyazJWSDZNVHRIamtZ?=
 =?utf-8?B?Z3R0aExMSEVKcGVQVzBZM21NbUhGVk9yWTBlYnA1SG9QVnQ4ZWgwSitzbWFE?=
 =?utf-8?B?ZnZhWGNub3RtRE5WOVkzL3o3enVZVklleFkzVGp1L2pCdjViaW5kUTBMRE1V?=
 =?utf-8?B?ckhtYllUUHpURkhKbFp2RUVHd3U0cGNCR1U0N09HWHo5Yi91ek0vNFFvYW94?=
 =?utf-8?B?TDFCREZDdm1sa2tuSllJc3hsSkNZS0t6U2lVWkp1alBFdGlxNXprdE9tOEtq?=
 =?utf-8?B?TG5NN0FhcDBTNWEzdGZWRkxWVmNVQzFzK0IwaDVSbFBTeTRtREVKUzdNQmg3?=
 =?utf-8?B?VklzY1BKdklxcGUrQVZwSHFzSWZ3NUZ1YXc4VXdTRFR4c1dQb2Q3L3lzcjBT?=
 =?utf-8?B?ZDFocC9QZXdJZ2xHanlFRFJ4YjlITWc3amI4d0puRXFFNWFIbVcrcUVZOUhN?=
 =?utf-8?B?S1hRN0NMSjZMdnZjRTd5OElpd3JZOGNvQjkvckRzWVV6MGp0M0xnWXBsS05u?=
 =?utf-8?B?Ylp1L0JjcmgyM0FqenJXcWdHd2hESHJtRE51YXVOOEx5ZGkvNkoyTFNHNmFB?=
 =?utf-8?B?bU1zYjJEZmNTcXFVVWlCMmdrNDlNUlh3NUdZVTZjc0UwWldjQzdCRlh5NGVG?=
 =?utf-8?B?Sm9jQUZUdkZaVTN5RytHdWh0eUo5L0xlbktXcVE4VnFFY09DRUQyMGo1VjdS?=
 =?utf-8?B?VlBFb3czNVRkZzBnTVVFMkhVNDdhYzdIWnc1OEJHL3J3VnkzNmpianJRMzdv?=
 =?utf-8?B?K3RyZkRjcXdPMFBQVlVQQU1rdmlvcUdHT25jWXdIUkthYUZxNGxEUUpiUk5B?=
 =?utf-8?B?L2dDUXVTSUZXdDhFTlVIby8xdytHSkRRUno0c2FRVVhId2FIUERNZS9abEtm?=
 =?utf-8?B?WjQrZ1ZNSzVYeFltaSthUHd1OHVkZ2lScjdOOXFzSmVLcmJMZk5BdDZMc3Fw?=
 =?utf-8?B?V3k2SU5kS1Z5REZSMmtzZlI2QUVWd2czc1ZPeTUybjRab1dRWXZYLzVoR3F5?=
 =?utf-8?B?a3pIZmtxczVrMGhWNHZHTmxhZjkxcUYvRkJlUTVkRXBxWDlJVGIrN2lDc3FT?=
 =?utf-8?B?aWhQc1Q0cThYWElCV1dZVHhsaUFDNTRGdWtIcFFHdk91dUpvUytkVTZwZFZr?=
 =?utf-8?B?d000bkU2OGlmVkhzUDNqWEYwR21JcFVMTmhQUzN6dUtkVzlkQXMxMFVrYVlT?=
 =?utf-8?B?bE1zcEpZVVRPZkVwNW95NVRWbE9KTVByMnJjTW1idmRIV2Z2eGpiNGJ3ODl2?=
 =?utf-8?B?UmJnektqNCtLK09vd2p1c1lzM1BaRi9Pam11OVBocDhKQ0YwaUNUSkhPalNX?=
 =?utf-8?B?TjdzMHFHS1Q3YTNLa1RuMkVvVHl3SGFFUWhwVS9LU2RuL056WGo1MkI2aFpX?=
 =?utf-8?B?aWg5WGdqQlRXODVaY0QxSDFSaitXUVhoTytlYjR1ZXN0N1RXKzRHbFBONE9Y?=
 =?utf-8?B?SVdyQzFETlVrY296WktxOTJ6NEsxckMvVW9HRUpVaVZ3L0RYOVppWnJvdVky?=
 =?utf-8?B?UGhITC9ZRkFmRWlabURiVlNUaFhWVHc3d3g5cFdSTjNVNTI4bmZaYmsrMWE3?=
 =?utf-8?B?U2szejRBWFFpR3g5bFlJMUQ1cENKa1NnY3FxSU1uS0IxQ2pRdzFkdHloYkRp?=
 =?utf-8?B?NVZRWWprWEpmYkRGVDNGSzdLU082Y1E4SEJ2YlZDZUxlRlNFcmpmTDNWNXVY?=
 =?utf-8?B?NzJLZWt4cDI3b0tlMWRtdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4f7fca-4acd-4b02-7720-08db0b7e771e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 15:49:59.5171
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB8659
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gMTAtRmViLTIwMjMsIGF0IDk6MDQgUE0sIFRob21hcyBXZWnDn3NjaHVoIDx0aG9t
YXNAdC04Y2guZGU+IHdyb3RlOg0KPiANCj4g77u/UmVzcG9uc2VzIGlubGluZQ0KPiANCj4gT24g
RnJpLCBGZWIgMTAsIDIwMjMgYXQgMTI6MDU6MTNQTSArMDAwMCwgQWRpdHlhIEdhcmcgd3JvdGU6
DQo+Pj4+IE9uIDEwLUZlYi0yMDIzLCBhdCAxMDoyNiBBTSwgVGhvbWFzIFdlacOfc2NodWggPHRo
b21hc0B0LThjaC5kZT4gd3JvdGU6DQo+Pj4gDQo+Pj4gSGksDQo+Pj4gDQo+Pj4gc29tZSBjb21t
ZW50cyBpbmxpbmUuDQo+Pj4gDQo+Pj4+IE9uIEZyaSwgRmViIDEwLCAyMDIzIGF0IDAzOjQzOjI0
QU0gKzAwMDAsIEFkaXR5YSBHYXJnIHdyb3RlOg0KPj4+IA0KPj4+PiArDQo+Pj4+ICtzdGF0aWMg
c3RydWN0IHsNCj4+Pj4gKyB1bnNpZ25lZCBpbnQgdXNhZ2U7DQo+Pj4+ICsgc3RydWN0IGhpZF9k
ZXZpY2VfaWQgKmRldl9pZDsNCj4+Pj4gK30gYXBwbGVpYl91c2FnZV9tYXBbXSA9IHsNCj4+Pj4g
KyAvKiBEZWZhdWx0IGlCcmlkZ2UgY29uZmlndXJhdGlvbiwga2V5IGlucHV0cyBhbmQgbW9kZSBz
ZXR0aW5ncyAqLw0KPj4+PiArIHsgMHgwMDAxMDAwNiwgJmFwcGxlaWJfc3ViX2hpZF9pZHNbMF0g
fSwNCj4+Pj4gKyAvKiBPUyBYIGlCcmlkZ2UgY29uZmlndXJhdGlvbiwgZGlnaXRpemVyIGlucHV0
cyAqLw0KPj4+PiArIHsgMHgwMDBEMDAwNSwgJmFwcGxlaWJfc3ViX2hpZF9pZHNbMF0gfSwNCj4+
Pj4gKyAvKiBBbGwgaUJyaWRnZSBjb25maWd1cmF0aW9ucywgZGlzcGxheS9ERlIgc2V0dGluZ3Mg
Ki8NCj4+Pj4gKyB7IDB4RkYxMjAwMDEsICZhcHBsZWliX3N1Yl9oaWRfaWRzWzBdIH0sDQo+Pj4+
ICsgLyogQWxsIGlCcmlkZ2UgY29uZmlndXJhdGlvbnMsIEFMUyAqLw0KPj4+PiArIHsgMHgwMDIw
MDA0MSwgJmFwcGxlaWJfc3ViX2hpZF9pZHNbMV0gfSwNCj4+Pj4gK307DQo+Pj4gDQo+Pj4gY29u
c3QNCj4+PiANCj4+IA0KPj4gQ29uc3RhbnRpZnlpbmcgdGhpcyByZXN1bHRzIGluIGNvbXBpbGVy
IGdpdmluZyB3YXJuaW5ncw0KPj4gDQo+PiBkcml2ZXJzL2hpZC9hcHBsZS1pYnJpZGdlLmM6Nzg6
MjM6IHdhcm5pbmc6IGluaXRpYWxpemF0aW9uIGRpc2NhcmRzICdjb25zdCcgcXVhbGlmaWVyIGZy
b20gcG9pbnRlciB0YXJnZXQgdHlwZSBbLVdkaXNjYXJkZWQtcXVhbGlmaWVyc10NCj4+ICAgNzgg
fCAgICAgICAgIHsgMHgwMDIwMDA0MSwgJmFwcGxlaWJfc3ViX2hpZF9pZHNbMV0gfSwNCj4gDQo+
IEZvciB0aGlzIHlvdSBhbHNvIGhhdmUgdG8gY29uc3RpZnkgdGhlIGhpZF9kZXZpY2VfaWQgKmRl
dl9pZCBpbg0KPiBhcHBsZWliX3VzYWdlX21hcC4gQW5kIHRoZW4gcHJvcGFnYXRlIHRoaXMgY2hh
bmdlIHRvIHNvbWUgZnVuY3Rpb25zIGFuZA0KPiB2YXJpYWJsZXMuDQo+IA0KPj4gICAgICB8ICAg
ICAgICAgICAgICAgICAgICAgICBeDQo+PiBkcml2ZXJzL2hpZC9hcHBsZS1pYnJpZGdlLmM6IElu
IGZ1bmN0aW9uICdhcHBsZWliX2FkZF9zdWJfZGV2JzoNCj4+IGRyaXZlcnMvaGlkL2FwcGxlLWli
cmlkZ2UuYzozNjM6Mjk6IHdhcm5pbmc6IGFzc2lnbm1lbnQgZGlzY2FyZHMgJ2NvbnN0JyBxdWFs
aWZpZXIgZnJvbSBwb2ludGVyIHRhcmdldCB0eXBlIFstV2Rpc2NhcmRlZC1xdWFsaWZpZXJzXQ0K
Pj4gIDM2MyB8ICAgICAgICAgc3ViX2hkZXYtPmxsX2RyaXZlciA9ICZhcHBsZWliX2xsX2RyaXZl
cjsNCj4gDQo+IEFzIEJlbmphbWluIHNhaWQgdGhpcyBpcyBiZWNhdXNlIHlvdXIgY2hhbmdlcyBh
cmUgYmFzZWQgb24gTGludXMnIHRyZWUNCj4gYnV0IHRoZXkgd2lsbCBicmVhayBhcyBzb29uIGFz
IHRoZXkgd2lsbCBiZSBtZXJnZWQgaW50byB0aGUgSElEIHRyZWUuDQo+IFlvdSBzaG91bGQgYmFz
ZSB5b3VyIGNoYW5nZXMgb2ZmIG9mIHRoZSBISUQgdHJlZToNCj4gaHR0cHM6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvaGlkL2hpZC5naXQvbG9nLz9oPWZvci02LjMv
aGlkLWNvcmUNCj4gDQo+IFRoaXMgaXNzdWUgaXMgZXNzZW50aWFsbHkgdW5sdWNreSB0aW1pbmcu
DQo+IA0KPj4gICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeDQo+PiBkcml2ZXJz
L2hpZC9hcHBsZS1pYnJpZGdlLmM6IEluIGZ1bmN0aW9uICdhcHBsZWliX2hpZF9wcm9iZSc6DQo+
PiBkcml2ZXJzL2hpZC9hcHBsZS1pYnJpZGdlLmM6NDM2OjEyOiBlcnJvcjogZXhwZWN0ZWQgJygn
IGJlZm9yZSAnaGlkX2lzX3VzYicNCj4+ICA0MzYgfCAgICAgICAgIGlmIGhpZF9pc191c2IoaGRl
dikNCj4+ICAgICAgfCAgICAgICAgICAgIF5+fn5+fn5+fn4NCj4+ICAgICAgfCAgICAgICAgICAg
ICgNCj4gDQo+IEFzIHRoZSBlcnJvciBtZXNzYWdlIGluZGljYXRlcywgdGhpcyBpcyBpbnZhbGlk
IHN5bnRheCBhbmQgbWlzc2luZyBhDQo+ICcoJy4NCj4gV2hhdCB5b3Ugd2FudCB0byBkbyBpcyB0
byBjaGVjayBmb3IgDQo+IA0KPiAgaWYgKCFoaWRfaXNfdXNiKGhkZXYpKQ0KPiAgICByZXR1cm4g
LUVOT0RFVjsNCg0KSXQgd2FzIGEgdHlwbyBvbiBteSBwYXJ0DQoNCisJLyogY2hlY2sgYW5kIHNl
dCB1c2IgY29uZmlnIGZpcnN0ICovDQorCWlmIChoaWRfaXNfdXNiKGhkZXYpKQ0KKwkJdWRldiA9
IGhpZF90b191c2JfZGV2KGhkZXYpOw0KKwllbHNlDQorCQlyZXR1cm4gLUVJTlZBTDsNCg0KVGhp
cyBpcyB3aGF0IEkgaGF2ZSBpbiBteSBwYXRjaCBzZXQgbm93Lg0KDQpJZiB0aGVyZSBpcyBzb21l
dGhpbmcgd3Jvbmcgd2l0aCB0aGlzLCB0aGVuIGRvIHRlbGwgbWUNCg0KVGhhbmtzDQo+IA0KPiAq
YmVmb3JlKiBjYWxsaW5nIGhpZF90b191c2JfZGV2KGhkZXYpOw0KPiANCj4+IEluIGZpbGUgaW5j
bHVkZWQgZnJvbSBkcml2ZXJzL2hpZC9hcHBsZS1pYnJpZGdlLmM6NDg6DQo+PiBkcml2ZXJzL2hp
ZC9hcHBsZS1pYnJpZGdlLmM6IEluIGZ1bmN0aW9uICdhcHBsZWliX3Byb2JlJzoNCj4+IGRyaXZl
cnMvaGlkL2FwcGxlLWlicmlkZ2UuYzo1NDQ6MzU6IHdhcm5pbmc6IHBhc3NpbmcgYXJndW1lbnQg
MSBvZiAnX19oaWRfcmVnaXN0ZXJfZHJpdmVyJyBkaXNjYXJkcyAnY29uc3QnIHF1YWxpZmllciBm
cm9tIHBvaW50ZXIgdGFyZ2V0IHR5cGUgWy1XZGlzY2FyZGVkLXF1YWxpZmllcnNdDQo+PiAgNTQ0
IHwgICAgICAgICByZXQgPSBoaWRfcmVnaXN0ZXJfZHJpdmVyKCZhcHBsZWliX2hpZF9kcml2ZXIp
Ow0KPj4gICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+
fn5+fn5+fn5+DQo+PiAuL2luY2x1ZGUvbGludXgvaGlkLmg6ODk4OjMxOiBub3RlOiBpbiBkZWZp
bml0aW9uIG9mIG1hY3JvICdoaWRfcmVnaXN0ZXJfZHJpdmVyJw0KPj4gIDg5OCB8ICAgICAgICAg
X19oaWRfcmVnaXN0ZXJfZHJpdmVyKGRyaXZlciwgVEhJU19NT0RVTEUsIEtCVUlMRF9NT0ROQU1F
KQ0KPj4gICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fg0KPj4gLi9p
bmNsdWRlL2xpbnV4L2hpZC5oOjg5Mzo0Nzogbm90ZTogZXhwZWN0ZWQgJ3N0cnVjdCBoaWRfZHJp
dmVyIConIGJ1dCBhcmd1bWVudCBpcyBvZiB0eXBlICdjb25zdCBzdHJ1Y3QgaGlkX2RyaXZlciAq
Jw0KPj4gIDg5MyB8IGV4dGVybiBpbnQgX19tdXN0X2NoZWNrIF9faGlkX3JlZ2lzdGVyX2RyaXZl
cihzdHJ1Y3QgaGlkX2RyaXZlciAqLA0KPj4gICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+DQo+PiBkcml2ZXJzL2hp
ZC9hcHBsZS1pYnJpZGdlLmM6IEluIGZ1bmN0aW9uICdhcHBsZWliX3JlbW92ZSc6DQo+PiBkcml2
ZXJzL2hpZC9hcHBsZS1pYnJpZGdlLmM6NTU4OjMxOiB3YXJuaW5nOiBwYXNzaW5nIGFyZ3VtZW50
IDEgb2YgJ2hpZF91bnJlZ2lzdGVyX2RyaXZlcicgZGlzY2FyZHMgJ2NvbnN0JyBxdWFsaWZpZXIg
ZnJvbSBwb2ludGVyIHRhcmdldCB0eXBlIFstV2Rpc2NhcmRlZC1xdWFsaWZpZXJzXQ0KPj4gIDU1
OCB8ICAgICAgICAgaGlkX3VucmVnaXN0ZXJfZHJpdmVyKCZhcHBsZWliX2hpZF9kcml2ZXIpOw0K
Pj4gICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+
fn4NCj4+IC4vaW5jbHVkZS9saW51eC9oaWQuaDo5MDA6MzU6IG5vdGU6IGV4cGVjdGVkICdzdHJ1
Y3QgaGlkX2RyaXZlciAqJyBidXQgYXJndW1lbnQgaXMgb2YgdHlwZSAnY29uc3Qgc3RydWN0IGhp
ZF9kcml2ZXIgKicNCj4+ICA5MDAgfCBleHRlcm4gdm9pZCBoaWRfdW5yZWdpc3Rlcl9kcml2ZXIo
c3RydWN0IGhpZF9kcml2ZXIgKik7DQo+PiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gDQo+IFRoZXNlIGFyZSBhbGwgYmVjYXVz
ZSBhcHBsaWJfaGlkX2RyaXZlciBjYW4gbm90IGJlIGNvbnN0Lg0KPiBTb3JyeSBmb3IgdGhlIHdy
b25nIGFkdmljZS4NCj4gDQo+IEJlbmphbWluOg0KPiBISUQgZHJpdmVycyBjYW4gbm90IGJlIGNv
bnN0IGJlY2F1c2UgdGhleSBlbWJlZCBhICdzdHJ1Y3QgZHJpdmVyJyB0aGF0DQo+IGlzIG5lZWRl
ZCBieSB0aGUgZHJpdmVyIGNvcmUgdG8gYmUgbXV0YWJsZS4NCj4gRml4aW5nIHRoaXMgaXMgcHJv
YmFibHkgYSBsYXJnZXIgZW50ZXJwcmlzZS4NCj4gDQo+PiBtYWtlWzZdOiAqKiogW3NjcmlwdHMv
TWFrZWZpbGUuYnVpbGQ6MjUwOiBkcml2ZXJzL2hpZC9hcHBsZS1pYnJpZGdlLm9dIEVycm9yIDEN
Cj4+IG1ha2VbNV06ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDo1MDA6IGRyaXZlcnMvaGlk
XSBFcnJvciAyDQo+PiBtYWtlWzVdOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2Jz4oCm
Lg0KPj4gDQo+PiBTb21lIHdhcm5pbmdzIGFyZSBhbHNvIGR1ZSB0byBhIHR5cG8gaW4gaWYgYW5k
IGNvbnN0YW50aWZ5aW5nIGBzdGF0aWMgc3RydWN0IGhpZF9kcml2ZXJgLCBhbHRob3VnaCB0aGV5
IHByb2JhYmx5IGNhbg0KPj4gYmUgZml4ZWQuDQo+PiANCj4+IEluIHNob3J0LCBUaG9tYXMsIGRv
IHlvdSByZWFsbHkgd2FudCBtZSB0byBjb25zdGFudGlmeSB0aGUgc3RydWN0dXJlIEkNCj4+IGFt
IHRhbGtpbmcgYWJvdXQgaW4gdGhpcyBlbWFpbCwgYXMgd2VsbCBgc3RhdGljIHN0cnVjdCBoaWRf
ZHJpdmVyYD8NCj4gDQo+IHN0cnVjdCBoaWRfZHJpdmVyOiBEb24ndCBjb25zdGlmeQ0KPiBhbGwg
b3RoZXJzOiBEbyBjb25zdGlmeQ0KPiANCj4gVGhvbWFzDQo=
