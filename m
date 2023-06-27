Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CCC73F945
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjF0J4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjF0Jzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:55:37 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2083.outbound.protection.outlook.com [40.107.12.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B44E30DE;
        Tue, 27 Jun 2023 02:54:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/B/BlAV1BVfoAZH0XU1tCHaLpA3CZsU4iXIjRzpOkBg31f5kOpe6PcH5Zsd6pPzO55hhO1m5fiJVsdmK3g4b8Z18eQBy09q1vBmJHkyzVXUwQT3s7oVqE2XM7D3SSI61e0HMnWk0YkZfh3gkrJ65jtvFWXIKV9RR/aWco8e/aEOWo3UfbLyHiVHcVX4XPL2tRrFEmB4/u9Km+bXrhsg0HWENRAdhNjhtWWZcjnU5zlUFa8uzKB6FAKdpdsgxb0SUcJoBGFXxryt8otP4ujrbh3oHbe31hZ1ZOMvXu1geXmv/xy5Pw6M57x2AHul1i4x0UVmASuoyihe3SObXo2J3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPjrG3BAnMDPejdJq16rjEk0hx7FNOrocwOiE6wrfX8=;
 b=fFcBwzL9EHO47XfscaJnRig0u8TMKAON/Gdl2oEjjwbY4+yl83FpteDhJ9EuvCDZnXlgchBxCj2KShlfe6j4tJmy/Y0P2EDrvUsNCfNdie6aHy2GfsRi2cch2DlnWHiVIjgedYC4C9zB18n3m7xRSQMiRbRx5RP1av9YQ+byo/u5wXYReAydeLMq6TWikfWcGAURBAkql+QxhESAgXwtpkS9Ez3d73Zzxm6uRWoI/yQKxZz3B0ppE1wER8drxbC095ENUJxmGmxSVkCKif3KuVYroJ9wd6kQzLu4B4UWsLFOVCki172IPCKRrA8TYjtEDSjiAxtcXDT6hG99irXVRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPjrG3BAnMDPejdJq16rjEk0hx7FNOrocwOiE6wrfX8=;
 b=I8bm9yUQdwxymYvbGmho5j1OcSAiZvHzVWj5f9HTuPllvqeO285gBFVJkX7J6Un8A03z5VPDaGc80EtESuBcMbhVEb+PJu7cPUTMhm8Ei45jlOJTnBQ3VLTGziK0nFgyS5B2Mx8nZpLSNixVuqntee+pcahX2VOyf/vuNGCHw3yGcQY9baRiCpXhaRhV66/fzT8q0ZTusuXOjr5lUO4IKnBw//Vn8rvzKGiwrYEA13XK4hBWoC4p6PgZU8gLpACC6b6Sq5bUqa7TxAjLSHrPHP7g3JJMsGITd4dyH8rvcGTBrrStX8N/WcQEERz4knLD7jQUGuPDzyE5TeajNwe9Mg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB2481.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:32::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 09:54:49 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::802b:33:561c:4217]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::802b:33:561c:4217%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 09:54:49 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 01/13] ASoC: dt-bindings: Add audio-iio-aux
Thread-Topic: [PATCH v6 01/13] ASoC: dt-bindings: Add audio-iio-aux
Thread-Index: AQHZpbDo7Vp4s+yhqUadHDn9az7Fl6+eb28A
Date:   Tue, 27 Jun 2023 09:54:49 +0000
Message-ID: <cd833799-c2c6-d0b8-1809-055ab8a40454@csgroup.eu>
References: <20230623085830.749991-1-herve.codina@bootlin.com>
 <20230623085830.749991-2-herve.codina@bootlin.com>
In-Reply-To: <20230623085830.749991-2-herve.codina@bootlin.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB2481:EE_
x-ms-office365-filtering-correlation-id: 3dd62111-bb5f-433b-6436-08db76f48be3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fn9bLdY5TDvZz/jvja5Q8bkHvu1N3LXODOgC09g/RBPA37I1/1IpE1NfXUCTeIb5p/xEwq+oj0veuInTnPpISn2aEg/IpuBckQugqUfp6sSzBeuic1IIg4JA2P1eAzTYSwSf2CSNWn2oxJbDpqbh5SWrPYFpXkT1sKzAFWwWhL7DShZVuj/rEK+YupJ/sS8Qj2GjNj75OULFGX3fh6Hxa551El2DXf7ebRG+TRl2tdP8SBs1H8MBrDX0rh5KdBSqiwmVoWXjkfy+r7mCpEFkbS8uoYI6WZDHzJBvUrx0jAZOg1ZLoRT0FUTr3/eEZJGpPi8L45Vd9lhOmvgsku4n0tL34WdEEYpvEZoC6FXOI7WTJli5KraXlpxEIKXneLQmvZshCqExgqeQucVW8E3jojWMCirn3wv0Xc3Ldv2oeKgN+ni+1WfoOSv58l95y5GILZ1n1VL4x7jx7xh/jDE8d13YE+qosTKA8BGGNCAiaGCKZASQuInf8lBUbimfQ1z9N8ZSJ7ARcz6f/HOF43LJ5wtj20S2M/EL7Ew6M994NQ2Ho6dYqarLy2I6LAPARSAko5WoWRHbK9pi3fHwADkXPFozL/GKoCoUENNDh1o3z83AWxJALtP6OJAF6KDTWFlB3VOSpQ8AvAfs3Dy+9LV/0NbwzX9T8v8SjOcvd80AnuZSblBZg89F09eoohs5D2Og
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(66574015)(966005)(6486002)(71200400001)(122000001)(38100700002)(921005)(26005)(83380400001)(2616005)(186003)(6506007)(6512007)(41300700001)(110136005)(2906002)(31696002)(86362001)(54906003)(38070700005)(478600001)(4326008)(316002)(76116006)(66946007)(66476007)(66446008)(66556008)(64756008)(44832011)(91956017)(8936002)(36756003)(31686004)(7416002)(8676002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGF3YUV2TnRMTk9EUXZ1OXB2bERkaXBwOGhnU0xTZ3ZwMzh6TFN0OUJaM3Vx?=
 =?utf-8?B?Y2o0QmxvREI2Y2hUZzI5RzFZRWVIRXVuK2lpaTkvbFQ3QTNYUVFScm1ZSDVw?=
 =?utf-8?B?TDVxc0tpeHJGQWdhNjJWWTIzM1BOWGlUVHp3MHlCMk05aG1jU3pMdHp1VVNv?=
 =?utf-8?B?V2p6TW5HaUZxSkxjelNiM1hDODduek5OZFJQR3E3SFFDaUxoaGVhN1ZNcWZl?=
 =?utf-8?B?Q2NWbVZ1aWs3cWx4SmFVWThFaFRNVytycXV2eEhTcTA3SjQxdkNOV2RtVHlU?=
 =?utf-8?B?NnNYV3NFN3dOWi9HVUl1QVZzYWVVQzV3WjdlY0t0VVpZVGgybnNjQk05Rmg0?=
 =?utf-8?B?UlhkRG9MMm03VjJlR2gzWXJaemFVYjJOSjNyYjZrWE56S1ZWRGxGM0RnVksw?=
 =?utf-8?B?N3VnT3c5eGRtc2h3RnJCZ0hKc0VlQ2pNODVIcGw3TmZpdWlaenhNSVJPdmlE?=
 =?utf-8?B?R0dRY1VmOHVDV05lbXcwQnNKSHlPY1E4WnErNnlzS0xMMlVrUzhsREVPNk13?=
 =?utf-8?B?R3lHRWdQK2U1T05SNStrUnkxclZKb3J0MVFlK1Z2OEJtdEZGWE9GQWVyby9r?=
 =?utf-8?B?R29LYTZ4UzNINzUzQW04WlZhcy9hMTdZRUxialNGU1hsZU5ZQVE1MUJGdURy?=
 =?utf-8?B?eGRVZ3c3YjU1b004aXpsQ3JwbWtqWmltZEFPZDEwOHZHYTJzZmlpQmtYV21X?=
 =?utf-8?B?MldFYW8vM2xXYjVWTmI5d2I0aWZ0VE1HcjV0d0lURzJiSHRPVDhhY0pSdkxh?=
 =?utf-8?B?MFMwTFJxL0J1UVNlZmxjUlZ3NVBhemhJM3RNS0lPb20xaGZidkdsTjU2VW95?=
 =?utf-8?B?Rk82S0dUUWZCT3BTaUNsK216T0VhVEV1dHllbU9oTlJXT3ZLQjNncEZsY3NZ?=
 =?utf-8?B?ckEvR252Tkc5QXRMMnYzWjluYW4zQStCeTBJem9IWE1yemFKWjlCN3lCR3hG?=
 =?utf-8?B?ejJoZUUwNEhJQlhBQ1JRdnpPY3I2ZVlsc1VFWmY5ODJkbVlJZ3AxMmtnTVZD?=
 =?utf-8?B?ZGc5ZWlmMkI0YzFNRkg1S01QL0xZRlhSQVFTMHl3MnUzSkpscURob2ZtdTVs?=
 =?utf-8?B?OGM3Y1M4NGR4ZTIxMGdJYXZyMWlPT1QxQ0tjTzBEN1JPVVRpY3Jsbno0VS9G?=
 =?utf-8?B?OTBmaThnNHFYRkRRUFAyMjg5NmJ0enc0N3lZeVB1eXNudzRIeU1BZ3hTTnM0?=
 =?utf-8?B?YThVbU1ST2kvNEpEbnczM1k4K1JBYlBPS203T3c3QUcxUXVNdU4zQWlUWFQz?=
 =?utf-8?B?OHozSUx4QmZtR1JiampSYmQva2IxZEwxRDBIdFVSei8zN0pTK29ENms5YXVK?=
 =?utf-8?B?VTQ1QUU5UFpPMU4xS2VwSVZwTjltLzFmWm1TZm1hajRYS21zb05rdUU2dklT?=
 =?utf-8?B?aDl5UUFEWWVIaFhqU1p5a3NXZUwrVWQwSC9sc0RzZ0Irb0pKbEtDMDBocVg0?=
 =?utf-8?B?K2E5ejdyc3VPV0psaXpSYzBKQmhZSnMwSTMxMXpCWkE1U3FBaHllaG43Rkla?=
 =?utf-8?B?eTdwWHFLUzNRTWNjelNCTW5Ma1ZUZ1FabFB4UE8wMUlkbXRoUXRQV1BLTkR3?=
 =?utf-8?B?SyswODJaOEFUMEdlUGV6aDZhMjhyTGEzeVNUOXdleXQwRFF5bVNnSDlwUEZE?=
 =?utf-8?B?bzZBaVY0VTUyVENXc20wUm84SUhNVlJHVExvMW43M2NBcUhpVkYxR3JwYzZF?=
 =?utf-8?B?OVoyRy9HN1J1dmg3T1RYd1cxRnJNR0FuSUs2KzVjUzVUR1QrUk9Ga2owam1T?=
 =?utf-8?B?bmlmRVdoVnpXZzAvQ0Vud2lVRzN6K29pcWtqNGV5SWMzVmxMTit0bHdDVjgv?=
 =?utf-8?B?c29lWEdqTXhvNW9aRFBRUDZEQmdoczB0Sm03bTVhVWx0OE9TTWxOYWx4TW93?=
 =?utf-8?B?M1NEMDBNMFRKMkFXekVsbUhmMVd5WjdEZnlRamo0aWxyeWwxcnZwWExydUJu?=
 =?utf-8?B?SWs4eXExN0doOWRPVDJTeDFOeTB1YTMvalNQb29TWm9PZHBsTEcyQjBxa1Qr?=
 =?utf-8?B?Q2ZkQ2FrdDRWLytiVDNnY2FJV2FjRkZOYUo2OWlGSWlVdThDQWcwNFFBdFRa?=
 =?utf-8?B?YTJWNDNrWW1IZ3BBRmlCSmlDV1E4bHliWEpkZnVZdGdhM21lN2plejFBd1ZX?=
 =?utf-8?Q?SegGmooPo1yo5RK9c2CWOdYNH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <679C8E4943C0C0408249E18BB4A6682A@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd62111-bb5f-433b-6436-08db76f48be3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 09:54:49.3746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 93tXtXEE7mK5pmR0NJ1fEf93VSjO+CEtA7m853DBfxEiviDXXZaPy4ZROaLvXxE0sH11EdwuGMMIOmpo8ubppzYqOjO+mwBwaFaa8huJBVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2481
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDIzLzA2LzIwMjMgw6AgMTA6NTgsIEhlcnZlIENvZGluYSBhIMOpY3JpdMKgOg0KPiBJ
bmR1c3RyaWFsIEkvTyBkZXZpY2VzIGNhbiBiZSBwcmVzZW50IGluIHRoZSBhdWRpbyBwYXRoLg0K
PiBUaGVzZSBkZXZpY2VzIG5lZWRzIHRvIGJlIHZpZXdlZCBhcyBhdWRpbyBjb21wb25lbnRzIGlu
IG9yZGVyIHRvIGJlDQo+IGZ1bGx5IGludGVncmF0ZWQgaW4gdGhlIGF1ZGlvIHBhdGguDQo+IA0K
PiBhdWRpby1paW8tYXV4IGFsbG93cyB0byBjb25zaWRlciB0aGVzZSBJbmR1c3RyaWFsIEkvTyBk
ZXZpY2VzIGFzDQo+IGF1eGxpYXJ5IGF1ZGlvIGRldmljZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBIZXJ2ZSBDb2RpbmEgPGhlcnZlLmNvZGluYUBib290bGluLmNvbT4NCj4gUmV2aWV3ZWQtYnk6
IEpvbmF0aGFuIENhbWVyb24gPEpvbmF0aGFuLkNhbWVyb25AaHVhd2VpLmNvbT4NCj4gUmV2aWV3
ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQoNClJldmlld2VkLWJ5OiBDaHJp
c3RvcGhlIExlcm95IDxjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+DQoNCj4gLS0tDQo+ICAg
Li4uL2JpbmRpbmdzL3NvdW5kL2F1ZGlvLWlpby1hdXgueWFtbCAgICAgICAgIHwgNjQgKysrKysr
KysrKysrKysrKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2NCBpbnNlcnRpb25zKCspDQo+ICAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3Vu
ZC9hdWRpby1paW8tYXV4LnlhbWwNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc291bmQvYXVkaW8taWlvLWF1eC55YW1sIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL2F1ZGlvLWlpby1hdXgueWFtbA0KPiBuZXcgZmls
ZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLmQzY2MxZWE0YTE3NQ0KPiAtLS0g
L2Rldi9udWxsDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3Vu
ZC9hdWRpby1paW8tYXV4LnlhbWwNCj4gQEAgLTAsMCArMSw2NCBAQA0KPiArIyBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+ICslWUFNTCAx
LjINCj4gKy0tLQ0KPiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9zb3VuZC9h
dWRpby1paW8tYXV4LnlhbWwjDQo+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0
YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4gKw0KPiArdGl0bGU6IEF1ZGlvIElJTyBhdXhpbGlhcnkN
Cj4gKw0KPiArbWFpbnRhaW5lcnM6DQo+ICsgIC0gSGVydmUgQ29kaW5hIDxoZXJ2ZS5jb2RpbmFA
Ym9vdGxpbi5jb20+DQo+ICsNCj4gK2Rlc2NyaXB0aW9uOg0KPiArICBBdXhpbGlhcnkgZGV2aWNl
IGJhc2VkIG9uIEluZHVzdHJpYWwgSS9PIGRldmljZSBjaGFubmVscw0KPiArDQo+ICthbGxPZjoN
Cj4gKyAgLSAkcmVmOiBkYWktY29tbW9uLnlhbWwjDQo+ICsNCj4gK3Byb3BlcnRpZXM6DQo+ICsg
IGNvbXBhdGlibGU6DQo+ICsgICAgY29uc3Q6IGF1ZGlvLWlpby1hdXgNCj4gKw0KPiArICBpby1j
aGFubmVsczoNCj4gKyAgICBkZXNjcmlwdGlvbjoNCj4gKyAgICAgIEluZHVzdHJpYWwgSS9PIGRl
dmljZSBjaGFubmVscyB1c2VkDQo+ICsNCj4gKyAgaW8tY2hhbm5lbC1uYW1lczoNCj4gKyAgICBk
ZXNjcmlwdGlvbjoNCj4gKyAgICAgIEluZHVzdHJpYWwgSS9PIGNoYW5uZWwgbmFtZXMgcmVsYXRl
ZCB0byBpby1jaGFubmVscy4NCj4gKyAgICAgIFRoZXNlIG5hbWVzIGFyZSB1c2VkIHRvIHByb3Zp
ZGVzIHNvdW5kIGNvbnRyb2xzLCB3aWRnZXRzIGFuZCByb3V0ZXMgbmFtZXMuDQo+ICsNCj4gKyAg
c25kLWNvbnRyb2wtaW52ZXJ0LXJhbmdlOg0KPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlh
bWwjL2RlZmluaXRpb25zL3VpbnQzMi1hcnJheQ0KPiArICAgIGRlc2NyaXB0aW9uOiB8DQo+ICsg
ICAgICBBIGxpc3Qgb2YgMC8xIGZsYWdzIGRlZmluaW5nIHdoZXRoZXIgb3Igbm90IHRoZSByZWxh
dGVkIGNoYW5uZWwgaXMNCj4gKyAgICAgIGludmVydGVkDQo+ICsgICAgaXRlbXM6DQo+ICsgICAg
ICBlbnVtOiBbMCwgMV0NCj4gKyAgICAgIGRlZmF1bHQ6IDANCj4gKyAgICAgIGRlc2NyaXB0aW9u
OiB8DQo+ICsgICAgICAgIEludmVydCB0aGUgc291bmQgY29udHJvbCB2YWx1ZSBjb21wYXJlZCB0
byB0aGUgSUlPIGNoYW5uZWwgcmF3IHZhbHVlLg0KPiArICAgICAgICAgIC0gMTogVGhlIHJlbGF0
ZWQgc291bmQgY29udHJvbCB2YWx1ZSBpcyBpbnZlcnRlZCBtZWFuaW5nIHRoYXQgdGhlDQo+ICsg
ICAgICAgICAgICAgICBtaW5pbXVtIHNvdW5kIGNvbnRyb2wgdmFsdWUgY29ycmVzcG9uZCB0byB0
aGUgbWF4aW11bSBJSU8gY2hhbm5lbA0KPiArICAgICAgICAgICAgICAgcmF3IHZhbHVlIGFuZCB0
aGUgbWF4aW11bSBzb3VuZCBjb250cm9sIHZhbHVlIGNvcnJlc3BvbmQgdG8gdGhlDQo+ICsgICAg
ICAgICAgICAgICBtaW5pbXVtIElJTyBjaGFubmVsIHJhdyB2YWx1ZS4NCj4gKyAgICAgICAgICAt
IDA6IFRoZSByZWxhdGVkIHNvdW5kIGNvbnRyb2wgdmFsdWUgaXMgbm90IGludmVydGVkIG1lYW5p
bmcgdGhhdCB0aGUNCj4gKyAgICAgICAgICAgICAgIG1pbmltdW0gKHJlc3AgbWF4aW11bSkgc291
bmQgY29udHJvbCB2YWx1ZSBjb3JyZXNwb25kIHRvIHRoZQ0KPiArICAgICAgICAgICAgICAgbWlu
aW11bSAocmVzcCBtYXhpbXVtKSBJSU8gY2hhbm5lbCByYXcgdmFsdWUuDQo+ICsNCj4gK3JlcXVp
cmVkOg0KPiArICAtIGNvbXBhdGlibGUNCj4gKyAgLSBpby1jaGFubmVscw0KPiArICAtIGlvLWNo
YW5uZWwtbmFtZXMNCj4gKw0KPiArdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0KPiArDQo+
ICtleGFtcGxlczoNCj4gKyAgLSB8DQo+ICsgICAgaWlvLWF1eCB7DQo+ICsgICAgICAgIGNvbXBh
dGlibGUgPSAiYXVkaW8taWlvLWF1eCI7DQo+ICsgICAgICAgIGlvLWNoYW5uZWxzID0gPCZpaW8g
MD4sIDwmaWlvIDE+LCA8JmlpbyAyPiwgPCZpaW8gMz47DQo+ICsgICAgICAgIGlvLWNoYW5uZWwt
bmFtZXMgPSAiQ0gwIiwgIkNIMSIsICJDSDIiLCAiQ0gzIjsNCj4gKyAgICAgICAgLyogSW52ZXJ0
IENIMSBhbmQgQ0gyICovDQo+ICsgICAgICAgIHNuZC1jb250cm9sLWludmVydC1yYW5nZSA9IDww
IDEgMSAwPjsNCj4gKyAgICB9Ow0K
