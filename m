Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231C9720251
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbjFBMm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjFBMmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:42:54 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2108.outbound.protection.outlook.com [40.107.14.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A75E13D;
        Fri,  2 Jun 2023 05:42:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9ztqL75GCUAxGqTkOfR38UdgeHSy/FcjHUojxK52B4Rr0UxR/NI7fi1rb6D3F0GeI5yQ6fyzYLzFNsTaIKznHgJWeuyNrUl/x9+Z3/NWRiH+x6ozwP7QR5YpVEXr8EAWBtlZdmniAD+0OsbaaYAbpGP9KnZ/UN0i5CrOUm/otv3/F+HY4L8NcSRMmv5pJoY9cvJLqs/fon5OTS8JILESm8GsfyWYXn7RVDLe1CB48syAlE9le5+jAD4oNU5XvgVVVafBVkUtXJyAS258YQfqo/xG8gUZgWdmLQLiqavYyAohvh0LJviWUG7SBL4Mt6DAg/Rbnf4lSubf2nGzP6/Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wX1+TYU0MZMAaBkK4kccaBi6kfgni4Gww6sFk1F7b04=;
 b=cx8d3p6egj2BftMeVMUtRoqYfiU+PnsZOT/89yNFOu3hUccHDkdKhWob/7GoV88EfBG5ZWFdhe9fdqUjxk5Cac00x7MyJkb+k7S8emIHVYhkmyPyDp+uC+KhnFMY5VhxrArlOoE1l6LNCrBDQOiol/iIullonlPnPXFwRazqO0lHz/vBOw041OZ6tyVfwidhLcS6k1wBatNKGIoDxPP45g5oKjKkQyJHORoHRnwHLhxGFD5mDHlxYSDF+Hs4y1hTK5UsX9zaHnOXjtVW6RuyuYAKeA2bvYmO86+F9N5uT7SOWDOz+Nmc/+jpkLFeBFdL4BxlSRtWHanIRNARC9ahIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wX1+TYU0MZMAaBkK4kccaBi6kfgni4Gww6sFk1F7b04=;
 b=hPhsqys0jyDYh2d6nf8az6VEYu95YXN4og2b5PGKYFpRDSbflOYoN6vdO4ceVdaAJEcB5Zsy8TONAxrefONMFdMChv0YNN9rSijea9azs+c+QUIaQKVEWNvaLbDxm7M5FKJs7UJpdTDZ2QHWkhW36HCOZCCJEAgtjj/3B457uj4=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by DU0PR03MB9732.eurprd03.prod.outlook.com (2603:10a6:10:44c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Fri, 2 Jun
 2023 12:42:49 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::b8e6:a92f:367e:801f]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::b8e6:a92f:367e:801f%7]) with mapi id 15.20.6433.024; Fri, 2 Jun 2023
 12:42:49 +0000
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
Thread-Index: AQHZlTEkbjROoMVD8k+Rhl00q7eUT693ZJ6AgAAIGwCAAAHAAIAABp6A
Date:   Fri, 2 Jun 2023 12:42:49 +0000
Message-ID: <aesymtpx5bkfkvlbt2d6o3gn4zjzsbyiwxiuqziohgovy7oaoo@kt2n6v7kmuw7>
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
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|DU0PR03MB9732:EE_
x-ms-office365-filtering-correlation-id: 23d78e2d-e27c-43ec-52ad-08db6366dfb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yYvTejDcU1CXMTq52pfqQUW+zVjdrhuFFuUZR6oODRqVaTIe4F/fkT+IrzZwsFZZfUfUMFfGhXYnOJZtDXKDSqXSgF1mB/9EHiNAHziNivKMoPVCduPUElBZcrLHZeW78/79w2AAZM61wnGsKoiVdzhHNhd2mPvHoxrbTK0gEDZFZCM1lVYytuXR/MivLPHgY5hJECZTX6C3Tnzhbt5trc6nss7mIK78zDlnvLSnqpiND4ZklfAzUEepy0jy6xoFyHc7Q0959+krb9zkYkgB8NwcPDQ2dRLzZra0bwZBJcQz9psb1W87NZb/8EvI0JfAne8yD6s2HyOYxvTvB2uxWAbhZi3GFW/bOjGKbeWBkhN459wfP+a4M7cdfynA12meUDNXp5Jan+JOFS0P9MmMu4L7kUgbC99j9wfpplznoxJPzqz0VYXK9t7Hx0sa5TOttYbrbFFnM0PXMz06FlZny92z/MDdyWLe6Bobo/ny3HH/4m9FjIqtwLtd2AzRZk5LK/yqeFwFt+2OfSfkvAs2IwsYE8hGAn+RQK2C9+JF3SH0cm8Jej/kyd3nBKBhqPCauiRfo78kPIMSWifS8HK9kNNwhM4ym7svKfbm3bQSIPjywHxD0fBTByVnHwEd1poK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199021)(6486002)(33716001)(478600001)(66574015)(85202003)(6506007)(26005)(6512007)(85182001)(9686003)(186003)(83380400001)(71200400001)(41300700001)(38100700002)(4326008)(8676002)(6916009)(76116006)(64756008)(66556008)(66446008)(66476007)(122000001)(66946007)(316002)(7416002)(86362001)(2906002)(38070700005)(5660300002)(8936002)(54906003)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEpYcnA2a0dQZ2Q3ejV0Y0VGaDdGVWRjb2IrbERGcm9vZG85Y3duRzByNkx0?=
 =?utf-8?B?eE8rQzh5RzNLeHM5c1RNS2d1N3Y3dFNzR0pUcnJXVDRiMHVYRlhsalArTGpl?=
 =?utf-8?B?ckxJSi9FRzVtc1d5SHBkeFM1SUM3QzYrUmVhUk9QdmxPNkd0aS93MnlsQ2Y2?=
 =?utf-8?B?ZHJYc2JlWjVjRHM1T20vWCtvc0pxWUtPTUx6Q3NIejBPQ1E0WG5MNEdoTkdn?=
 =?utf-8?B?eTExTDZYZURlQ3RwYTE1cnJLSHFSdFdhcGZFb0lFRTEzbVNFZWFMbTV5U0Ev?=
 =?utf-8?B?TzhiVW84ckMzOUQ2Zkh6YlhVTXdITTZIZ2JkUkNCTHByN3RjWGlPaFkzQVdI?=
 =?utf-8?B?eStnL1dsZFlGYk4rdmxOQjhlUHk4UG16TGplL1NvTjc2c21pdENxdVUrV2lr?=
 =?utf-8?B?bEJHRGRqNUtBeHFpTWRFRjV3bjhjRU5WcCtjVmRRMW9tQ0pLOW5QaitJVmtx?=
 =?utf-8?B?V0NUV2FYVFc3c1VrcDBCb2F1SGQwVDYyWFdKTmF0SU1CNmxWNjBVYWRmMGFN?=
 =?utf-8?B?VGtMVmUxOGxrRys3SU1WK0VWK1FnakhXK1FRSERFWjR1c0c2cUo4R0d2NVFP?=
 =?utf-8?B?MFVnb3A4ZlU0U04zNFJBdjZ6Z0Z3ZmhGWFBNR2RHakZWRSticmc3N2JPNGtJ?=
 =?utf-8?B?cWJCdlhUeE1DQ21HRkl5YUhPUWRpMU5Vbzk2UnhxdXlraVl3aVJVY1Q1K0Vn?=
 =?utf-8?B?RGFpNkxHSTRGbjVoZExVc2VXdHl2dXIyd1JZQm9TaXVUQ0ZsMnkxc3ZrMTZG?=
 =?utf-8?B?QWx3SVVZR2VvcXpiQ0FCOGM0OTZtQ1Nnbk9URmhxTUFtUmozejdqWnFoZWsx?=
 =?utf-8?B?OE1jYzIzbE15RmkrWDRRcldoSnNhK0p0UTNhR1U2VVFhMUs1Qmc3cHU5OG5M?=
 =?utf-8?B?N0ltR1V5b04wM2U0c1NrcE94V0t4eFQyZGlmcXJyU2htT0l1bU5ubWJKWGlJ?=
 =?utf-8?B?Q1BPZEpsTUtyd0o5T2duNHNTY2VnYnJqTzBQWFNEeUtOaXpXU0JJc09uMUs4?=
 =?utf-8?B?amV6WTA4TWxJeGZsUU1ReTd0UUZZaC9pQis3QUtaeGYzWDB1VXgzcHdrbXo4?=
 =?utf-8?B?NnNvcW5aaU9OWnBNRHZpODU0aTNJOFVrcEREekQ1eWxaVFdWdlhoZGJ2VlNH?=
 =?utf-8?B?eGlaTlNKYm4yeit6bzlsTTlXUkFGcXMvZnR5L1RvUzlQMUwrME1ydzRiTWJw?=
 =?utf-8?B?VlBVM1g0SFBQQktlVG5SMzhSd292aXdJVUJJOUsyMjZDeUV5amxFUWwwR0pJ?=
 =?utf-8?B?eDdXODc4U1VNQWRvZ2NYUGEybEUrc0w4U2pPM3U0RGVSNy8wTksrUXF2VUty?=
 =?utf-8?B?eS9TY1RxZGVqK2dsOXRZUlF2TlB2L1lSK1F4eU9tYmhGL2dhbXdWRy9ON3ND?=
 =?utf-8?B?VnF1NEFKVWZiYjFWNEJsV0ZPbmlJZ3A2NmhESGwvUGgzYmI0NWtVeHJvamh4?=
 =?utf-8?B?YUk5eSs1S1NBYm5TdWNLczVSajd4WGZiVWtWQk16d2xFdFA5WTNxS3htbmRM?=
 =?utf-8?B?VnJQQjQyNUZORzRBem04Y3pyWitYcW5FaGJ4R1dqVmRJaFVrbFkyMS9GMDdE?=
 =?utf-8?B?eXRpbzNiWU0vek01a2RsRDFJUVNjZEppbzlBWDBOZHdlZEpjRGhrcWlvZkFq?=
 =?utf-8?B?dkVKOU8wUmFOQnhJaDhieVBTNlAySm5VOXpMUVVPb3FTTkIzY08xMm80aDho?=
 =?utf-8?B?SEtyM1B3a2tqSzFFNnlGSXQvU0R2WG5VMWlmbThVRE56ejlkNC9HRnVRV0I1?=
 =?utf-8?B?cDlqNEpxb091L3VYeDlVd1p0YmpuTCtmUUIvVVhkSDBRKzJ1dkg0QnBpWnc3?=
 =?utf-8?B?TExEYVNRQjBvaXJBbUdGM2ZVTmNldVc3cjNWMzA3YmVYOHJDWTBOdE9MSElt?=
 =?utf-8?B?OW5NNFZqMjc2cGF2THNlNDdMM2V2ZDNlRUVKRFVyZHF6ZEpkQ2J0ZHJ1cUky?=
 =?utf-8?B?Z0h1dDUybXNxSVpoeWpOQWQwZ2ZuVnNDekg0alJmSHNKWHQ2djMvb1NTNzFV?=
 =?utf-8?B?R0lyWjJmQ2UwTEJ4YnBmYkF5TysrN1FFY1VTY0ZIa1lWN0VqZE5RK2pZcHdY?=
 =?utf-8?B?VXJOOFpxYU12WjZqSE5ob21lalcxUytPRmNwaFpSdUh4dkNlUC9SM2tEVXZ0?=
 =?utf-8?B?ck5wM2lIYU04dUdZUndHOWtEbklycWdxdXJWRDlCYXpHakRkRFRraFdsSWdP?=
 =?utf-8?B?d3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B38978195DD7F5499DA28BD90226E7AC@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB3943.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d78e2d-e27c-43ec-52ad-08db6366dfb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 12:42:49.3280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kW0SYXRQ6FpJp81ZsHva6/poP4KdghQavnZalFxDu3dIe9aW0LxMBnNp2ijx/PXZhH6BCSv+P6j0px1niXWOJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9732
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
ZSB3aXRob3V0IGhhdmluZyB0byBzcGVjaWZ5IGFueSBtb3JlDQo+IHByb3BlcnRpZXMuDQoNClll
cyBJIHNlZSB3aGF0IHlvdSBtZWFuLiBPbiBteSBwbGF0Zm9ybSB0aGUgY2xvY2sgc291cmNlIGlz
IGFjdHVhbGx5IGRlc2NyaWJlZA0KYnkgdGhlIGNvbW1vbiBjbG9jayBmcmFtZXdvcmssIHNvIEkg
d291bGQgd2FudCB0byB1c2UgdGhhdC4gSWYgaXQgd2VyZSBhDQpjb21wb25lbnQgZHJpdmVyIHRo
ZW4gaXQgd291bGQgbW9zdCBsaWtlbHkgYmUgYSBjb2RlYyB0aGF0IGlzIHBhcnQgb2YgdGhlDQpk
YWktbGluayBhbnl3YXkuIFNvIHdoYXQgYWJvdXQgaGF2aW5nIHR3byBzdHJ1Y3QgY2xrIHBvaW50
ZXJzIGluIHN0cnVjdA0Kc25kX3NvY19kYWk/DQoNCiAgICBzdHJ1Y3Qgc25kX3NvY19kYWkgew0K
ICAgICAgICAvKiAuLi4gKi8NCiAgICAgICAgc3RydWN0IGNsayAqYml0Y2xvY2tfcHJvdmlkZXI7
DQogICAgICAgIHN0cnVjdCBjbGsgKmZyYW1lY2xvY2tfcHJvdmlkZXI7DQogICAgICAgIC8qIC4u
LiAqLw0KICAgIH07DQoNCklmIG5vbi1OVUxMIEkgY291bGQgdGhlbiBoYXZlIHRoZSBBU29DIGNv
cmUgZW5hYmxlL2Rpc2FibGUgdGhlIGNsb2NrcyBvbiBkZW1hbmQ/DQpJIHdvdWxkIHNheSBpbiBo
d19wYXJhbXMvaHdfZnJlZSwgYWxiZWl0IHRoYXQgcnVucyBhZnRlciBzZXRfZm10Lg0KDQpIYXZp
bmcgc2FpZCB0aGF0LCBJIHNlZSBBU29DIGRvZXNuJ3QgcmVhbGx5IHVzZSB0aGUgQ0NGIG11Y2gu
Li4gYW0gSSB3YXkgb2ZmPw0KDQpJIGRvbid0IHRoaW5rIGl0J3MgZmVhc2libGUgdG8gbW9kaWZ5
IGV2ZXJ5IGNvbXBvbmVudCBkcml2ZXIgdG8gZXhwbGljaXRseQ0KaGFuZGxlIHRoaXMgYW5kIHRo
ZW4gaWdub3JlIGFueSBDQlBfQ0ZQIGJpdHMgc2V0IGluIGl0cyBjYWxsIHRvIHNldF9mbXQgLSB0
aGlzDQppcyB3aHkgSSB3YW50IGhlbHAgZnJvbSB0aGUgQVNvQyBjb3JlLg0KDQo+IA0KPiA+IFRo
ZSBvdGhlciBpc3N1ZSBpcyB0aGF0IGZvciB0aGUgc2ltcGxlLWNhcmQgdGhlIERBSSBmb3JtYXQg
aXMgb25seSBwYXJzZWQgaW4gb25lDQo+ID4gcGxhY2UgYW5kIGFwcGxpZWQgdG8gdGhlIHdob2xl
IGxpbmsuIEFyZSB5b3UgcHJvcG9zaW5nIHRoYXQgaXQgYmUgbW9kaWZpZWQgdG8NCj4gPiBleHBs
aWNpdGx5IHRyeSBhbmQgcGFyc2UgYm90aCBlbmRzIGluIG9yZGVyIHRvIGRldGVybWluZSBpZiBi
b3RoIHNpZGVzIHdhbnQgdG8NCj4gPiBiZSBjbG9jayBjb25zdW1lcnM/IEluIHRoYXQgY2FzZSBJ
J2QgaGF2ZSB0byBhbHNvIGludHJvZHVjZSBiaXRjbG9jay1jb25zdW1lcg0KPiA+IGFuZCBmcmFt
ZWNsb2NrLWNvbnN1bWVyIHByb3BlcnRpZXMgdG8gbWlycm9yIHRoZSBleGlzdGluZyBiaXRjbG9j
ay1tYXN0ZXIgYW5kDQo+ID4gZnJhbWVjbG9jay1tYXN0ZXIgcHJvcGVydGllcywgYXMgYW4gZXhw
bGljaXQgYWJzZW5jZSBvZiB0aGUgKi1tYXN0ZXIgcHJvcGVydHkgb24NCj4gPiBib3RoIHNpZGVz
IHdvdWxkIGhhdmUgdG8gZGVmYXVsdCB0byB0aGUgb3JpZ2luYWwgQVNvQyBiZWhhdmlvdXIgZGVz
Y3JpYmVkIGFib3ZlLg0KPiANCj4gSWYgc2ltcGxlLWNhcmQgY2FuJ3QgYmUgbWFkZSB0byB3b3Jr
IHRoYXQncyBmaW5lLCBpdCdzIGRlcHJlY2F0ZWQNCj4gYW55d2F5Lg0KDQpBaCBPSywgSSBkaWRu
J3Qga25vdyB0aGF0LiBSaWdodCBub3cgSSdtIHVzaW5nIGdyYXBoLWNhcmQyLCB0aGF0J3Mgbm90
DQpkZXByZWNhdGVkLCByaWdodD8NCg0KS2luZCByZWdhcmRzLA0KQWx2aW4=
