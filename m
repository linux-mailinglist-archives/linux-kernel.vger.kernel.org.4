Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEE97224D4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjFELmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbjFELmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:42:50 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2139.outbound.protection.outlook.com [40.107.104.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19449C;
        Mon,  5 Jun 2023 04:42:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIhpxwslfDMeIaGUciiHDFB4QSxRPYJaMoIcuKARpKC3ecAFohn0hFfdsA+8dnsvdt0ueFjf6znmZMMIpAQ8c+qYnfBG3adG16PRmiD4VVeSEgvQyW88gdg/pfPVv6aQLQCca94NcGPQ58YbRpJaa2WZOAvoKmdWu5u8FzUb4DbXihgJ4W+784eEh1xlc0hBnF8dKxj7xO7geZoOduYZoF9maxA6irj5CjAjyxssn3KXASzAw2eSFd527EzyoDiBWPXzkCG9wVbKekuxUoqWl3LWx07RofKtp4GR7PHvNJTlK+S8v0LSoBHFKiVOpR6VSaZ3ubgJtnDVJyxBX0hFIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PW/7TuyGczVznWIf05w+hmMxYtm4F7K9onGBVc8t6LE=;
 b=Nof8WijzpHI5r6CiCGa9Je6qQH7WyqkZIseG4odK+7g1mzIoK+hKGo42HBaR1Ydhum+aLBriu86xWy6Eb7ULBOixyJrSa2p9CvqXATnzrVXCpFN3PE9Hxpb6lV7IplP/cSWDTZAAnR0rXHsuE6EfxnChdz2SoIjdmVogqwdAOf/ZMCSjzeoUFd3Viob+x66La/T8P0ulekQYz8IWSCWVv40u+BSGIxhydraXuQfFn9RtfdFpiFm1gds0vswD1yZ2kbNVu3FIZ09jPt09X5MpKWdwE54zwTzMD4MWX3pPl7ZPYIXoqqkPYaPU33CJMBZnXSGLNSixvUMj57t/ZqFWUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PW/7TuyGczVznWIf05w+hmMxYtm4F7K9onGBVc8t6LE=;
 b=Irv+8CaE/DsZj39OfkbBR9eFDdLCzOf1Y6c1KBln0izpC+qmUtZrKwBSlXe85djeMcUPH0CLfuxJOxulVB5lMyusIYXkexBtV3ucq9bLIGdq4VuOkmh9/Z6r6mQhQ3wAsrwHMgSIIFfZkOcZHFvu7iuviAMgGcsErIp404tamWk=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by AS4PR03MB8183.eurprd03.prod.outlook.com (2603:10a6:20b:4f4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Mon, 5 Jun
 2023 11:42:44 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::b8e6:a92f:367e:801f]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::b8e6:a92f:367e:801f%7]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 11:42:44 +0000
From:   =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To:     Mark Brown <broonie@kernel.org>
CC:     =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <alvin@pqrs.dk>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] ASoC: dt-bindings: document new symmetric-clock-role
 flag
Thread-Topic: [PATCH 1/4] ASoC: dt-bindings: document new symmetric-clock-role
 flag
Thread-Index: AQHZlTEkbjROoMVD8k+Rhl00q7eUT693ZJ6AgAAIGwCAAAHAAIAErNKA
Date:   Mon, 5 Jun 2023 11:42:44 +0000
Message-ID: <epx43xeghpqcourix74uyjdm6kpovlqocx7l34z3bvumk7ehfb@sfvjvladp2oh>
References: <20230602090322.1876359-1-alvin@pqrs.dk>
 <20230602090322.1876359-2-alvin@pqrs.dk>
 <3fe93662-82b0-4834-b6c3-473669c66210@sirena.org.uk>
 <7csvw25vhyal2jsznb3jykuijxqpk7bzyguxvl7cyitosgga2w@pxmkce22cm3d>
 <91b6d02a-25d5-4835-942e-3f8072bd8897@sirena.org.uk>
In-Reply-To: <91b6d02a-25d5-4835-942e-3f8072bd8897@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|AS4PR03MB8183:EE_
x-ms-office365-filtering-correlation-id: 65fa999f-6aab-4803-712a-08db65b9f9ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fplj57rCnE0UCXNRM/vZF8xxFuIRImvbe12p1+qObwLsIYOGE28qo6eKFYybuRM5+5eZdVK/hoo3wnx/7iiwvnOD+Dk9KwkgfwUEvG9NJqo5X9ZoXm+w8ekroTthYkLhsKMCcRaXOLDgyJWrUrCZmmDdhcVxUYeKUy0uOqH/dbA9TdMRDXcUdLm+tD0MdIkgSANFTdwioAORgw6xOwmYP+xbjAsqFG3y5Za94JOcxsot+UaCIFBvHJrgzWP6ZLfuPcaacoCcZ6U73w+Ck4Gx1E+nvpU/xYSO4kQIY8sUDkHCtjiKqkB7NoxqECg8O5kgk1IB7MVdiSHh+jnFosDV8SkD/QZz+wUqDDV77R9f550vXqzvJ9qOmw/9GDbETrl5DzECkdHViE5h3MqokrD5HxzmbHvMCZ9UZz+pCLJE3Rnsm8tDXfwbPlR+b+8n0NOX9aHbZ7VRgqSgDSQ1cZ8iGa9OriGrbNrIZnwZFsac0BVjdOIc7BbeqIU2fBvThr62fDOqVK2WF4Pp+YT0Pv9fwG/Uz/f6uIFE2CtRO/nzCkHSiY7tZ88hlGu666e5z8U2zrXryJXGsd+l57Ic0wm0Tab4HEvhS4sM0W2iW7pxCvOuOQk5+SVG9LLpE1a64OdP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(346002)(396003)(136003)(39850400004)(366004)(376002)(451199021)(71200400001)(478600001)(6486002)(86362001)(66574015)(83380400001)(33716001)(85182001)(9686003)(186003)(38070700005)(26005)(85202003)(38100700002)(122000001)(6512007)(6506007)(4326008)(7416002)(6916009)(66556008)(64756008)(76116006)(66946007)(66476007)(91956017)(66446008)(2906002)(5660300002)(8676002)(316002)(41300700001)(54906003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TExXWXJGNElVY1RJcmhuMHNpVnBQUHBRWFZ1Rng2TVBENUhLMG5MMFBXR3Nq?=
 =?utf-8?B?YXRWQnRVbVlXMllkU245Q2JpdjlPdi90eXZDbW5oa0NDN0pzNzNyY05kUk5R?=
 =?utf-8?B?T0JzRG4xY3Y0U2YyN1hhc1RlTDREbGZsUEEzU3g3WnV0Z3NYUitub2F6UGM2?=
 =?utf-8?B?TWNwSjUyZWdiTW1EMThEK2FNY0pndmY1WFExSWxCM2t3Z3lYWnFNTDFYK2tq?=
 =?utf-8?B?cHQ4T2h2ZTM5YVk2b09icmk2VFREZkhISmsvd3l5NHdmbDRaemlYcjRkMmxh?=
 =?utf-8?B?UGhOQi92K2RjbHY4ZGVjUTZtRElWN21XQU14ZHVRUFdBM1F5aEVDUUIzQi90?=
 =?utf-8?B?bndZM2gxWGsyM0UvSzRkN1Frc29oRWxjVHhLd1hxVDJ6UW92SXJzcFZ2WXp1?=
 =?utf-8?B?dUZxdlFON0hYTmVabi9IVURidW5scms0M05odmRzZXJaVnFOS3FvNzd1Qnly?=
 =?utf-8?B?V2t3dzc1Rk4ydnI3dk56UmE5aFhzTEZ1WU1oemwwMGdUUU5Jdm9PM3FIbUZl?=
 =?utf-8?B?Q1R1eHBvcjRnWXdqbU5lMElYZVg1SFZvdGJUYjhGWU96a1I4Z2pINHhDdlMv?=
 =?utf-8?B?Y3VUR3lvKzVRQjhRWjFkSTVGNGVlNW5pZG5kWjRka1d1T1Q1a1Z0WWZFdHR0?=
 =?utf-8?B?c0k0ejhKelo3cHlNN2JSc3ZCNXMwbTZhT2xLck1JcjREbGY5elArN3ExNktO?=
 =?utf-8?B?NzlETm5lNGw3MXp2c3Z0Qm5rUzhheSs0Z1pzVElzTHFyWUsyR0ZMaHE2ZzhP?=
 =?utf-8?B?U3F0ZC9yQlFkZjRkeHd5RzJEY2RmbjZVWlR4OVIyYTVCTnBTK3hLaTZDWDc3?=
 =?utf-8?B?blJ2Z2xwMjB3bTIzcXp1UnE1RlVTdUFEbG5rRmMrRElRa3VNUC9CdDcxSEhU?=
 =?utf-8?B?Zk83UjNzamkzU2FhRTJqZk96YmI4VXRud1ZFL21WUWgrTlNsOUp0aDdMcGdl?=
 =?utf-8?B?WXpVckFwUWQxM2loeE1jZWNhVUJkTTJhbGgrcloyTVc4VXowSElUbnBudzJJ?=
 =?utf-8?B?VE1NY3JWOWJ2cVFwNFNwendZQ3BVSFQ4UVBQWmxoUXRlZWRCa0N5d0pXeXdo?=
 =?utf-8?B?bWJ4RndTd0hlRzJSUGw1dXRNWllMYlA0aFoyTldBVG1iS1RWRzVjZ05icHBm?=
 =?utf-8?B?Q3RiTm5tV2h2L0VqMEJUTkM0elVKTGZCcGkxWCtBVjdMUXJ5V01oeStNOHFk?=
 =?utf-8?B?YnEzYTRlVWlEb1ZTcjR3RnJBRHVCRUxtVXJiVW1BbkdjNzg3eEFBT3g0cHBM?=
 =?utf-8?B?Z3E5Q3VROU90WXk0a0dqVStEK25ySHVleDdsRmJ6OVkxdU44c2RQY1hlK1R1?=
 =?utf-8?B?K2Jyc2F4d3gvT2FmbUFvVVpMaFR1VWE0a3oxZmloenFSaExPYXlDUk1QR0cr?=
 =?utf-8?B?Ky9NMnhmMSszV2wrWDB2eUloU2haUFgyYk1PdisxNHdJME5mM0xGd1gyM2k0?=
 =?utf-8?B?dGpER3FLRXlZOC9zcXY1UDlJTFd2NVZzQTRpR25WVXozaEFTd010SmNYSTd1?=
 =?utf-8?B?RjVHdzlVVHdJM3dSYU1XaVU4V1VZcEhmTkxWZVdvam8xWXNLalU4aVg3eWRm?=
 =?utf-8?B?RUlTN3VJbG5Bd2N2SDJRNitoQkx2eUxCTjA2eXNXN2lrdnlpdzYwYmp5N0lw?=
 =?utf-8?B?cmlOT2F6cVBzRHZsSGM1ZEJUc0hFekhDb25ITVJzU3A1cjNqK2pGUFF5Q0VZ?=
 =?utf-8?B?OGFEdXdpWHJHcnp0YmR4YmVyRHN2WUxYRHhUYVR1THBqdGMwSkpRNTFMRGhj?=
 =?utf-8?B?SGpVVXVHUHB1WTNSZUdiSGxwUmhXeHhCbzJWNnd2RW1HUUhNNG5WdDA2VGpG?=
 =?utf-8?B?VmJHS3dYQXE0THd0TW1pK0JIMUZqZjl1TUJabENmbFlqVmdKdGtRUHREMlNK?=
 =?utf-8?B?Q1lPdVFjeEV4citJSURma1NQY3YwS1BhTDJkMG9hUzBhRkllaWNPYW5KbDZK?=
 =?utf-8?B?MWdjSC94S3MrZmlzQTM4aWtmR2FkZ2JIV09TamVPdDRYVEIwaVArcWhlNXZn?=
 =?utf-8?B?aGJSbzYzSjV2WHFxelJ4WmtJelZBWXRHN1lPYWxnWjhUTU4ybGpyUm5tWSt1?=
 =?utf-8?B?ejdUeFRmRWVyZW5qKzFNQmFEY3F5ZjFGQXlUU3VuZTdpeW8yNFNzTDhrQ0Ji?=
 =?utf-8?Q?Wh2ADpE8vG/JNzItZ/goxwQ1H?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48648B97CCF33B45937F9EF3A440A99F@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB3943.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65fa999f-6aab-4803-712a-08db65b9f9ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 11:42:44.0409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gJxmoetPZHBjiuY0Z+y6E1msU7p7j3f+BS7hahjQSKv4Hr25t5Pc0CYNfSXtwbNuZB9q7uZE3W/7in5bS7w90Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR03MB8183
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBKdW4gMDIsIDIwMjMgYXQgMDE6MTk6MDhQTSArMDEwMCwgTWFyayBCcm93biB3cm90
ZToNCj4gT24gRnJpLCBKdW4gMDIsIDIwMjMgYXQgMTI6MTI6NTJQTSArMDAwMCwgQWx2aW4gxaBp
cHJhZ2Egd3JvdGU6DQo+ID4gT24gRnJpLCBKdW4gMDIsIDIwMjMgYXQgMTI6NDM6NTFQTSArMDEw
MCwgTWFyayBCcm93biB3cm90ZToNCj4gDQo+ID4gPiBXaHkgd291bGQgd2UgaGF2ZSBhIHByb3Bl
cnR5IGZvciB0aGlzIGFuZCBub3QganVzdCBkZXNjcmliZSB3aGF0ZXZlciB0aGUNCj4gPiA+IGFj
dHVhbCBjbG9ja2luZyBhcnJhbmdlbWVudCBpcz8NCj4gDQo+ID4gU3VyZSAtIGxldCBtZSBqdXN0
IGVsYWJvcmF0ZSBvbiBteSB0aGlua2luZyBhbmQgbWF5YmUgeW91IGNhbiBoZWxwIG1lIHdpdGgg
YQ0KPiA+IGJldHRlciBhcHByb2FjaDoNCj4gDQo+ID4gVGhlIGNsb2NraW5nIGFycmFuZ2VtZW50
IGlzIGVuY29kZWQgaW4gdGhlIGRhaV9mbXQgZmllbGQgb2Ygc25kX3NvY19kYWlfbGluaywNCj4g
PiBidXQgdGhpcyBpcyBhIHNpbmdsZSB2YWx1ZSB0aGF0IGRlc2NyaWJlcyB0aGUgZm9ybWF0IG9u
IGJvdGggZW5kcy4gVGhlIGN1cnJlbnQNCj4gPiBiZWhhdmlvdXIgb2YgQVNvQyBpcyB0byBmbGlw
IHRoZSBjbG9jayByb2xlcyBlbmNvZGVkIGluIGRhaV9mbXQgd2hlbiBhcHBseWluZyBpdA0KPiA+
IHRvIHRoZSBDUFUgc2lkZSBvZiB0aGUgbGluay4NCj4gDQo+ID4gTG9va2luZyBmcm9tIGEgRFQg
cGVyc3BlY3RpdmUsIGlmIEkgZG8gbm90IHNwZWNpZnkgZS5nLiBiaXRjbG9jay1tYXN0ZXIgb24N
Cj4gPiBlaXRoZXIgc2lkZSBvZiB0aGUgbGluaywgdGhlbiB0aGUgZGFpX2ZtdCB3aWxsIGRlc2Ny
aWJlIHRoZSBjb2RlYyBhcyBhIGJpdGNsb2NrDQo+ID4gY29uc3VtZXIgYW5kIChhZnRlciBmbGlw
cGluZykgdGhlIENQVSBhcyBhIHByb3ZpZGVyLiBUaGF0J3MgdGhlIGRlZmF1bHQNCj4gPiBpbXBs
aWNhdGlvbiBvZiB0aGUgRFQgYmluZGluZ3MgYW5kIEkgY2FuJ3QgYnJlYWsgY29tcGF0aWJpbGl0
eSB0aGVyZS4NCj4gDQo+IE5vbmUgb2YgdGhpcyBhZGRyZXNzZXMgbXkgcXVlc3Rpb24uICBUbyBy
ZXBlYXQgd2h5IHdvdWxkIHdlIG5vdCBqdXN0DQo+IGRlc2NyaWJlIHRoZSBhY3R1YWwgY2xvY2tp
bmcgYXJyYW5nZW1lbnQgaGVyZSAtIHRoaXMgcHJvcGVydHkgZG9lcyBub3QNCj4gc3BlY2lmeSB3
aGVyZSB0aGUgY2xvY2sgYWN0dWFsbHkgY29tZXMgZnJvbSBhdCBhbGwsIHdlJ3JlIHN0aWxsIGdv
aW5nIHRvDQo+IG5lZWQgYWRkaXRpb25hbCBpbmZvcm1hdGlvbiBmb3IgdGhhdCBhbmQgaWYgd2Un
dmUgZGVzY3JpYmVkIHRoYXQgY2xvY2sNCj4gdGhlbiB3ZSBhbHJlYWR5IGtub3cgaXQncyB0aGVy
ZSB3aXRob3V0IGhhdmluZyB0byBzcGVjaWZ5IGFueSBtb3JlDQo+IHByb3BlcnRpZXMuDQoNCk1h
eWJlIEkgb3ZlcmNvbXBsaWNhdGVkIHlvdXIgcG9pbnQgd2l0aCBteSBwcmV2aW91cyByZXBseS4g
U29tZSBxdWVzdGlvbnMgdG8NCmNsYXJpZnk6DQoNCjEuIFlvdSBkb24ndCBsaWtlIHRoZSBEVCBw
cm9wZXJ0eSBiZWNhdXNlIGl0IHNob3VsZCBiZSBpbmZlcnJhYmxlIGJ5IG90aGVyDQptZWFucy4g
Q29ycmVjdD8NCg0KMi4gQXMgZm9yIHRoZSBmbGFnIGFkZGVkIHRvIHNuZF9zb2NfZGFpX2xpbmss
IGRvIHlvdSB0aGluayB0aGF0IGlzIGFuIE9LDQphcHByb2FjaD8NCg0KSnVzdCB3YW50IHRvIHVu
ZGVyc3RhbmQgd2hpY2ggZGlyZWN0aW9uIHlvdSB3b3VsZCBsaWtlIG1lIHRvIGZvY3VzIHRoZQ0K
ZWZmb3J0Lg0KDQpLaW5kIHJlZ2FyZHMsDQpBbHZpbg==
