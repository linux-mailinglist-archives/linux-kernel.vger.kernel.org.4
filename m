Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186A06288EF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 20:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbiKNTKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 14:10:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbiKNTKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 14:10:45 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2129.outbound.protection.outlook.com [40.107.113.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D1D23BFD;
        Mon, 14 Nov 2022 11:10:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iViOytUmkXj2030Egdlq1pGaQBjc9Aco6P2BgvOCkoijXbkHkmtd/OsBRmjhZHB/oWh4/L+X+/hGlg5BSJdJntssZubvElehkj7GzXKNAZeq1cdaE3pZnTGjzFlihvJfB+r2HTXqq1QIGn8FrSvlQE9iQiSoE29fzkM+ciWar+HmGw/kO3i/HYTgnjipzjnBzdHow65y0zbNAxQDmK6WbvtVDRXw1vEQ6g4A42P54zFEhGxC0YDjGbPygw2Ybj8KVTsz1eEapkAw1fCoPstzmA+RiPTXfGbeg+qfMoEgb8Q1yeTKgz3tyZJqCG/Wm2Y/VeiJehtSHxMZxuVbV26C+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhkP8o0r9NtuszZHdZxovivFQEQBalQ66NmL0A8nshg=;
 b=Gs66M6OYkaXkxBpa0eM5d4EOdWQi8/VpVwamr1WSeZZGGm2ZkATAis/YaKT9rxBl+Lxmh9nBQZRd8MjStPuXjhko25nXYV4Rqa/YTGkcEJ2mBdKVGHn37Dq7TZAQuDw+qSPXftFSLmryk5bjsWw+NA+MvreDaun3a1bcpB8smZG3GRNfOrEZKpjmLmumrzNkTLbzUlXkgNLHXMyIUKijQYSVS+IIhB+wA3bNl5KmQ8eqCBkoKj7CeWeLejzWPKkHzezUqbRzNFe37XNsBNrjul2fRFFHNxFSAU2fFC7fzUDzLydKxHKlvWwvrUUkfLnzoMzWyH3Vhu2eC+mdIZ9K8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhkP8o0r9NtuszZHdZxovivFQEQBalQ66NmL0A8nshg=;
 b=ivGxPnCGhFOsn+TBrwrSoEElCndXA3tBHJHhCZWO39j4PUd8AQFOZb/LQVQH0vBzAg3o/uqkUdOuV8Zpn3oLukOALPD4wo5OmE2OpWiiG7236EorbcSdAc4io5ZZBmoLtZt+s2+4NxadTkDNMY8EfPXfQgM+S9W2G4usV8LSGRc=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB9543.jpnprd01.prod.outlook.com (2603:1096:400:1a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 19:10:41 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::5b24:f581:85bd:6ce2%3]) with mapi id 15.20.5813.018; Mon, 14 Nov 2022
 19:10:41 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Prabhakar <prabhakar.csengg@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH] watchdog: rzg2l_wdt: Issue a reset before we put the PM
 clocks
Thread-Topic: [PATCH] watchdog: rzg2l_wdt: Issue a reset before we put the PM
 clocks
Thread-Index: AQHY+FQ3i7+8G/jXAEWaK/AAUJtKua4+wHcggAAGgYCAAAGLYA==
Date:   Mon, 14 Nov 2022 19:10:41 +0000
Message-ID: <OS0PR01MB59224DF03590185EFD5AF91386059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221114180843.1125308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB5922DDCE24ED6F6DD44B4B3F86059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdUFsOktkVG0T9yGoVSKZ=JP1bdWnhpyQ5rKFt545JYnHg@mail.gmail.com>
In-Reply-To: <CAMuHMdUFsOktkVG0T9yGoVSKZ=JP1bdWnhpyQ5rKFt545JYnHg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB9543:EE_
x-ms-office365-filtering-correlation-id: 5ab8559f-56b4-47dc-cd40-08dac673ec43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ocyt6nCzQPBzGXLLouUvva0vFLv15vWPNwbZY1zBFcVAIBkp+l9xfkh3iyEqgD4J2NQzdrkleNZg84osB9pfJ/c/rMDxM3vpn6tzYDFiEoTe6PTlkrxbDaYyWuuN+PkTgaI0zQt02iHqmOmglH+z1Hfu2GBH+KyMZaJ+a40/Ol5hbzA3x373hDDifL8LG2sKq5+rt9OLwiC1BeBIY1g2pxOm0AYnjhMXFeMyuImusCCuMLS8eMPFlFRcJ4TiQuBLE5WoteAo+YHLAcBlIAEFmkrHzXnjKXMexatFFqTf8fFhtD149ST9Oxhquyq9WOHWaKQtKbs6kVH8s+jMBnkyQa7NoCF3fPSZ33ELNTbfpoOo9tPOGdw7hbCZ8xepUzzzjIeIKAuUe6aCauvKMUcZhdQxWqMo4KsSToyDnboFUQdGLU6tXyRt4fGe2cEIqYzT8/Pmoesk3bzM3tWu5ZjFacwzIu8WZN1GYIkpd7fa+zw0ZF0meD779qJ0J0aS5t5+ufQHeXbllo6X+hmwGc+25f9Q8Mu9iy9ruYtZLSL2HNMHc1AgqQEULKxn3CGj83aET+tsjm/eZUQnChll7znnVh/idPxzuLZ6arO9XnBYLe+cJVeGwGSbn81G3mBhrpE8wMprY6K+UMHxESmM2vBS4ZyMKS4XkxG4N/wIGQw9tdfj79eQm8vTSBSAuMYyxsTBT162PRwvQeB5njNQR+uDQpbePyh+XZGARej9bisIq/8a+o1gExL/UvfBshZuZTFwnSDn7iuKpCZkQGnGoWJUwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199015)(76116006)(55016003)(66446008)(64756008)(26005)(8676002)(66476007)(4326008)(9686003)(66556008)(5660300002)(186003)(52536014)(41300700001)(316002)(33656002)(66946007)(8936002)(38100700002)(122000001)(86362001)(83380400001)(2906002)(38070700005)(53546011)(71200400001)(107886003)(7696005)(54906003)(6506007)(6916009)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkVOL2h6N1FHbTZnT3E1UEFEWFVBSGRhQmVwT0hEbUhZcS9RamZVV0tpNktR?=
 =?utf-8?B?L1ZKK0lxdUF6SGVvL1FrcFVMMU9OQnF3Ri96c3pGeWV6am9ET0c2emJWL3N6?=
 =?utf-8?B?eVQwalViNHU2eEFmRWVxRW5yTmdlcHJmblZnN0g1MTVpMzdCMkhSU0JDa3pm?=
 =?utf-8?B?UmFRcC9xaXorQ1U0WjU4ZGcvSXhHRzRXWmhnTHppaU9Td2hZMmlZNVZDK1Nw?=
 =?utf-8?B?alFuNTZIUnpOczl4L3J6SXJ4QUFORW53cUk1RWcrQUs4Z1YrUDFUQk5IbGRj?=
 =?utf-8?B?SlBrLzBiejJlNmV0U1kyMUxyMmoweWJ2NFZlUTlYVWpzMzNxbnU4cnFYTjEy?=
 =?utf-8?B?dGdGdGpLUnpPaWdYby9sSHR1Y0hPVVozMGx5cU91WEtuUWhYRCtheDdubkhF?=
 =?utf-8?B?VHpHQTFkdk9WNW1uKzZHaXdoQzZ2QmhIQWlSa1BnUjloUW9DWVdiSFppeFNF?=
 =?utf-8?B?RUY2aktMVnpwLzVjTG5tL0NHS3IvQVk1bjNDMld2REkzaUpHTjYzS01OUlpZ?=
 =?utf-8?B?V2I1dCtOS01McVNlTHlEcUN4cnZISERGOUdRRnlVaFV6YlltbGZnTXdDSUtm?=
 =?utf-8?B?N3dBejcwTHg1RHo4S1AxYlRwZDZUQmpoajZYUGxWVUJ5K1V6ODRnSEhKa0pr?=
 =?utf-8?B?SU4yVDVlQ2hxMld2Qk9tZU4yc3VNbzlCdCtUc3pFYkF1d2FuS3N2by9mMmJT?=
 =?utf-8?B?SS9FRFlrMXUvbmh4RmxVUWs1L2UzcFZDQWxwR1o3SERVdWFaaS84MFVDZE16?=
 =?utf-8?B?Rjh5TW1sbkJSelNvSjR2Y1AzV0xPMzE5WDZja0FDb2FPNms3bjJ6enh3eXRy?=
 =?utf-8?B?N1NnSDFpNkl0Q21MQ2hZVEw4RXFSeStsV2xpdWdiSFhhM0NPTFZyQmVmU1h6?=
 =?utf-8?B?cGFrLzVpNjRtZ1FEejJHR1psbFpJb0NTZVlEd0gzTDdOQXZCMjJzMDBTS20v?=
 =?utf-8?B?TmNtUTN0WHpaM0RJWDVuK0s4MUp1eUZYM2tCck00TGxGcDNQTVdCcW5kZXpn?=
 =?utf-8?B?anMyYU53Y3F0cnVsMlhnUW8xN0RyeDdwT1p4aXQzOVU2YWNFS29XNnJLSXhM?=
 =?utf-8?B?RjlmMWUvdmNKQlluckp6cFJCMjVRWEdoWVl3ZVBGcEl4TlQ2Z2tpRkllU1Nm?=
 =?utf-8?B?NldPdHJ2RGZWbm1uallueWdlK0gxUXZzc3ZUQXVRQ2xsenFLaDcrVmdUUTRE?=
 =?utf-8?B?RGNKL28xVExTQnBYVnA4Z0tlcjJqMHY2VFRPQ2pvdWRDVVJZR3Q1Sm5ZUGxS?=
 =?utf-8?B?OG8zQmRmUmNaSzFMbDFpdjl0QThxK0ZFKyt2S1AxTkJOc3VlY2dHVXF3Qlkr?=
 =?utf-8?B?aTlaZWgybG1XK08vckNtYXQ2akExM1FQRHlHa1Vrd3BSQU15eldCbVhaazR6?=
 =?utf-8?B?NFJDQ1dKb0d2U1MvQlBkVmY2ellMSHl3eVF2MUxVK2Z6bmNKcktra0ZvOGZa?=
 =?utf-8?B?UE1Ibm9UdE01M25iaDROMzdibTJRanE0aG1EVmNnMk1VdDFRempZNXpOcjU2?=
 =?utf-8?B?RndiUEFmUXZCSzRCNjJEWTZrTlJkcG8zM2NzMTBMejdCbDRIMWZUVHJTb2xl?=
 =?utf-8?B?ZVk5L2xCYVlkeWlsQi9sODd5WVdBZmhPenhIaFZjTloyalZjQW5ob0VCaUhS?=
 =?utf-8?B?TWtaSkt0L3A0ekEwT1hRZlBGdk1PWVNiblJxZzRtMkhhZUJxeXpZb0xSWXJZ?=
 =?utf-8?B?U0pOTlBlZlloNmZ4MTFCdU9lNFlNcWdoRkZvRWoxKzIzU2RNVVFiZTE2S3ZF?=
 =?utf-8?B?dDZiOWxvbTNHdjYzZjNQTWRNN3MwaVJrOVdrYzVuYllVL3l0UGFpcXh2Wld1?=
 =?utf-8?B?bGdPSFk5MUYrRllqT1VWYUpnMFVMSm9LV2w1eGtxQk42Y1pZUmFWcHBCMVh5?=
 =?utf-8?B?V21ub1I5dGU4bFhIdTg5V2tCeXYxV3BPYzJ3NkVXaHZ6ckE0QWlySnFCYzdS?=
 =?utf-8?B?TFpLUnF0TlZzVWh2a0xIZ3JZZmpLQnBzMUpCWUxBbE1nVDBvdDVsa042SENO?=
 =?utf-8?B?TXc5TEE3cFVCS3NRNm5NOWdqWXQxNEtINFp1bjlVbDFNbjgwUjY5amJoQkpP?=
 =?utf-8?B?b2pqOEQ4MVJDWEluVGQrNk1FN0dYTDRKbHcybnMxTHRnT0ptZC9Kd2d1WE1q?=
 =?utf-8?B?UG1mWmpIVlZHU2ZUQlEwTHhEeUI2cU15OHZwdFBoRGwrMGVZTWtxZTE5T0Ru?=
 =?utf-8?B?cXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab8559f-56b4-47dc-cd40-08dac673ec43
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2022 19:10:41.3595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sRmKoszY2RY2q1d3hyY9LOImBxcISaod1POFnHOJ6GFvH91en0v2bmVvXi4S0amAGJ16mGzNq7AiBMn5CWIraZIPbP97fzuYkSpsujcW6BQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9543
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR2VlcnQgVXl0dGVyaG9l
dmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gU2VudDogMTQgTm92ZW1iZXIgMjAyMiAxOTow
NA0KPiBUbzogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0KPiBDYzogUHJh
Ymhha2FyIDxwcmFiaGFrYXIuY3NlbmdnQGdtYWlsLmNvbT47IEdlZXJ0IFV5dHRlcmhvZXZlbg0K
PiA8Z2VlcnQrcmVuZXNhc0BnbGlkZXIuYmU+OyBXaW0gVmFuIFNlYnJvZWNrIDx3aW1AbGludXgt
d2F0Y2hkb2cub3JnPjsgR3VlbnRlcg0KPiBSb2VjayA8bGludXhAcm9lY2stdXMubmV0PjsgUGhp
bGlwcCBaYWJlbCA8cC56YWJlbEBwZW5ndXRyb25peC5kZT47IGxpbnV4LQ0KPiB3YXRjaGRvZ0B2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXJlbmVz
YXMtDQo+IHNvY0B2Z2VyLmtlcm5lbC5vcmc7IEZhYnJpemlvIENhc3RybyA8ZmFicml6aW8uY2Fz
dHJvLmp6QHJlbmVzYXMuY29tPjsNCj4gUHJhYmhha2FyIE1haGFkZXYgTGFkIDxwcmFiaGFrYXIu
bWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHdh
dGNoZG9nOiByemcybF93ZHQ6IElzc3VlIGEgcmVzZXQgYmVmb3JlIHdlIHB1dCB0aGUgUE0NCj4g
Y2xvY2tzDQo+IA0KPiBIaSBCaWp1LA0KPiANCj4gT24gTW9uLCBOb3YgMTQsIDIwMjIgYXQgNzo0
MiBQTSBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+ID4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFByYWJoYWthciA8cHJhYmhh
a2FyLmNzZW5nZ0BnbWFpbC5jb20+DQo+ID4gPiBTZW50OiAxNCBOb3ZlbWJlciAyMDIyIDE4OjA5
DQo+ID4gPiBUbzogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT47
IFdpbSBWYW4gU2Vicm9lY2sNCj4gPiA+IDx3aW1AbGludXgtd2F0Y2hkb2cub3JnPjsgR3VlbnRl
ciBSb2VjayA8bGludXhAcm9lY2stdXMubmV0PjsNCj4gPiA+IFBoaWxpcHAgWmFiZWwgPHAuemFi
ZWxAcGVuZ3V0cm9uaXguZGU+Ow0KPiA+ID4gbGludXgtd2F0Y2hkb2dAdmdlci5rZXJuZWwub3Jn
DQo+ID4gPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtcmVuZXNhcy1z
b2NAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gUHJhYmhha2FyIDxwcmFiaGFrYXIuY3NlbmdnQGdt
YWlsLmNvbT47IEJpanUgRGFzDQo+ID4gPiA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+OyBG
YWJyaXppbyBDYXN0cm8NCj4gPiA+IDxmYWJyaXppby5jYXN0cm8uanpAcmVuZXNhcy5jb20+OyBQ
cmFiaGFrYXIgTWFoYWRldiBMYWQNCj4gPiA+IDxwcmFiaGFrYXIubWFoYWRldi0gbGFkLnJqQGJw
LnJlbmVzYXMuY29tPg0KPiA+ID4gU3ViamVjdDogW1BBVENIXSB3YXRjaGRvZzogcnpnMmxfd2R0
OiBJc3N1ZSBhIHJlc2V0IGJlZm9yZSB3ZSBwdXQNCj4gPiA+IHRoZSBQTSBjbG9ja3MNCj4gPiA+
DQo+ID4gPiBGcm9tOiBMYWQgUHJhYmhha2FyIDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAu
cmVuZXNhcy5jb20+DQo+ID4gPg0KPiA+ID4gT24gUlovRml2ZSBTb0MgaXQgd2FzIG9ic2VydmVk
IHRoYXQgc2V0dGluZyB0aW1lb3V0ICh0byBzYXkgMSBzZWMpDQo+ID4gPiB3b3VsZG4ndCByZXNl
dCB0aGUgc3lzdGVtLiBUbyBmaXggdGhpcyB3ZSBtYWtlIHN1cmUgd2UgaXNzdWUgYSByZXNldA0K
PiA+ID4gYmVmb3JlIHB1dHRpbmcgdGhlIFBNIGNsb2NrcyB0byBtYWtlIHN1cmUgdGhlIHJlZ2lz
dGVycyBoYXZlIGJlZW4NCj4gY2xlYXJlZC4NCj4gPiA+DQo+ID4gPiBXaGlsZSBhdCBpdCByZS11
c2VkIHJ6ZzJsX3dkdF9zdG9wKCkgaW4gcnpnMmxfd2R0X3NldF90aW1lb3V0KCkgYXMNCj4gPiA+
IHdlIHdlcmUgY2FsbGluZyB0aGUgc2FtZSBmdW5jdGlvbnMgaGVyZS4NCj4gPiA+DQo+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBMYWQgUHJhYmhha2FyDQo+ID4gPiA8cHJhYmhha2FyLm1haGFkZXYtbGFk
LnJqQGJwLnJlbmVzYXMuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiBOb3RlLA0KPiA+ID4gLSBUaGlz
IHBhdGNoIGhhcyBiZWVuIHRlc3RlZCBvbiBSWi9HMkwsIFJaL1YyTSBhbmQgUlovRml2ZS4NCj4g
PiA+IC0gTXkgaW5pdGlhbCBpbnZlc3RpZ2F0aW9uIHNob3dlZCBhZGRpbmcgdGhlIGRlbGF5IGFm
dGVyDQo+ID4gPiBwbV9ydW50aW1lX2dldF9zeW5jKCkNCj4gPiA+ICAgYWxzbyBmaXhlZCB0aGlz
IGlzc3VlLg0KPiA+ID4gLSBEbyBJIG5lZWQgYWRkIHRoZSBmaXhlcyB0YWcgPyB3aGF0IHNob3Vs
ZCBiZSB0aGUgb3BlcmF0aW9uIFBVVC0NCj4gPiA+ID5SRVNFVC9SRVNFVC0+UFVUPw0KPiA+DQo+
ID4gSXQgbG9va3MgbGlrZSB0aW1pbmcgaXNzdWUsIE5vbmUgb2YgdGhlIHByZXZpb3VzIGRldmlj
ZXMgYXJlIGFmZmVjdGVkIGJ5DQo+IHRoaXMuDQo+IA0KPiBUbyBtZSBpdCBsb29rcyBsaWtlIHRo
ZSBkZXZpY2UgbXVzdCBiZSBjbG9ja2VkIGZvciB0aGUgcmVzZXQgc2lnbmFsIHRvIGJlDQo+IHBy
b3BhZ2F0ZWQ/DQoNClllcCwgcHJvdmlkZSBjbGsgc3VwcGx5IGZvciBhIGRldmljZSwgdGhlbiBh
cHBseSByZXNldC4NCg0KQ2hlZXJzLA0KQmlqdQ0K
