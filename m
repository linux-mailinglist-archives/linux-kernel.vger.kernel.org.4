Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E8B72377A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbjFFGUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234962AbjFFGTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:19:44 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2074.outbound.protection.outlook.com [40.107.255.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671EDE6B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:19:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuAHWYgQWepfvX3Hh9CYjwmm7+2/s7O9LyibOeEtura19Cd+vN2+6Ql9aDBTSD5RpbciAtSf2QtQXsFUrRJji9ldYjXeaEs732mc+68T3ofx+Csb+V2tf55dmIcgU46W801KIc2xugn5wdEFdV7+Tt/+czmCdVQ5/1tw63EAnKwxUirpb3+G3t6azpg9pCOzgPw9geh/Taal1eYMgICaVRJsNc5HZbYysE/gUms10JGzppYNnh+hIC3WDKAc4dG076xgEU/sNzxM2XadnohyEli7t3VLT+J2f9EK/YoiPOiRCuI9TX+YDXgIF0ekm0/bYfyibUZkpVDvX/x03uFixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wkgsOXvkDZMDlfGYtZEr8I14GB2W0QYdbwGrJujnkvA=;
 b=OgmMjNgm8jut45d83LTPrJFy8tGEPlmdBq05e/WFXAu06wcCaELPcsTws8RjYPhU0D5bCbIaOdffgGAgoZd+D0FeLfV1zrPqCXtqT21a5DOOuegBE3+/7tmEUH84H8zT9q8k0UlgAlAsflEnm+1LdsCPF8TRECuow5fsrK5q5q3J1CnHTQoOKVKtfS3CZ+hiGxNKofhHkqYi4DWEtWpWX1ISn4kbyT0E1SVSYX8Wel+wslCVHTArBIm6pG4X/7MJ7e3hRvZkQfc96GlKZ3X/UEa2wi0bAtVnw0Pm9ke6RUfvXLfcBFGVQ3b70dX+izW/02mmBKNJTNXhmvGh8J0xzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wkgsOXvkDZMDlfGYtZEr8I14GB2W0QYdbwGrJujnkvA=;
 b=NW4gKb+f+n1iRmZRBk8GN2iPh2QS4/gmrKWselt+iLppGkxCRKWqjSiIYMOkB1tKrPv3daVrMxIsKbx4uuSxBdz/orTl4LnAEfudmEVOnFyNEBBhAE9hY8/O4sc33DQWe7ePYNp3xJImP37pTfKQls+cYLjOhWzjCuTfsRa5xCrLehUWRzt7AnH2q87HFbChQve/PabfS5ec5XT9GdNUBETEekNe7oU5neABvRbKlk6bF96+4hSRh947clzbLoU19hWKrWKCfQnO85iH3Vb58r8mNi/sWf2k+GJvJYjCws+Acw/kK47x/QGG4qDRVMoDIw+sI37uawAtXW2FlA52BQ==
Received: from SG2PR06MB3420.apcprd06.prod.outlook.com (2603:1096:4:9c::20) by
 TYZPR06MB3885.apcprd06.prod.outlook.com (2603:1096:400:6::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.32; Tue, 6 Jun 2023 06:19:35 +0000
Received: from SG2PR06MB3420.apcprd06.prod.outlook.com
 ([fe80::331:7924:e95c:bad3]) by SG2PR06MB3420.apcprd06.prod.outlook.com
 ([fe80::331:7924:e95c:bad3%4]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 06:19:35 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     "mst@redhat.com" <mst@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] vp_vdpa: Check queue number of vdpa device from
 add_config
Thread-Topic: [PATCH] vp_vdpa: Check queue number of vdpa device from
 add_config
Thread-Index: AQHZlSTAZTdsntY69UKPiVqdv9xAWq97yrQAgAAbhLA=
Date:   Tue, 6 Jun 2023 06:19:35 +0000
Message-ID: <SG2PR06MB342012C05627EA6456EF59B18552A@SG2PR06MB3420.apcprd06.prod.outlook.com>
References: <20230602073442.1765-1-angus.chen@jaguarmicro.com>
 <CACGkMEtCr-LGVH9QJRaMJ2VF3fyDX2zEVwOSJtb-gB_VtSTV2A@mail.gmail.com>
In-Reply-To: <CACGkMEtCr-LGVH9QJRaMJ2VF3fyDX2zEVwOSJtb-gB_VtSTV2A@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR06MB3420:EE_|TYZPR06MB3885:EE_
x-ms-office365-filtering-correlation-id: 9ac98166-c646-4398-3ec6-08db66560002
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LMfmSV+ZOqhFc+m9G6UpyWBREOd/piX4oIroMufvz0TCsJ676EzFKBWfItrBJjvzyOn7ASXzy4kV5ZqsJJvSNwsH7y0Zk4nv3AsQjkVPA2i/uxVSm9FcfViZxf1e/OikqH2Z4nMzKOynIhCFo+9TSQkRNTkMXFJgllMIZwk8ZX4pgQgLddOYfltnil0en9VzdR7qWniu3StH03b79/KzXsw2PtpOrelYHkM/buU18DP0M4/PnjyIFtluy5damakvlYPkY9slKxYtATXKB1gVz9u8yfVPqaMuaGetysU11uCbi//QxvXgy6+6y/LQ+C1mt+IDdDeqvUaReHh4VZ5z8UM7FbeIrPGSWlHzh3WrjDj72+t0Lls87LE6sqoYCNJVX8zP0v1crjpo0Z5/AFzKAwYKL8yFQr06TRllmXHlGfId47pQTk8ab9K7mDtWBbUqyk1REBWbZAds9r0+cVvGyFEpmYbWRcbevNhbNuhQcRCt0hUP2Zl0hlydQlMJbrU3Py2BCHn6PrQn4HYYxYypD+1OoJvjrKRLdntXjaYd5Q/b1MhGZLgKkJ2lLEkp4QI3CG5ZDZveOzSiwwqYXiPp4qrT2vwMcLHZuZdk8apkfg3hQZNxbhUK+n/ptYCgYYnR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3420.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39830400003)(376002)(346002)(366004)(451199021)(54906003)(71200400001)(478600001)(52536014)(8936002)(8676002)(4326008)(5660300002)(44832011)(38070700005)(33656002)(2906002)(86362001)(66476007)(66446008)(122000001)(6916009)(64756008)(66556008)(66946007)(316002)(55016003)(76116006)(6506007)(38100700002)(41300700001)(53546011)(9686003)(186003)(26005)(83380400001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDZDbTZNa3lvTytWVWRhYWhNRXBzQWZXRmFROURPS0RJQmY2U21GUjlISE5U?=
 =?utf-8?B?aFlHYnp0QzluR1VjQ2xneXVjaUxUSTc5dXVVM1N6MExJaDBEZDlmRzY1ZjNK?=
 =?utf-8?B?bmovbnIwVU0zNG9RNW8wUHIxRGI3ZzUzNkxackhxUXRWTWgyeGlhbnZUMEFX?=
 =?utf-8?B?WjB1bjNDNGFEd3Z2aHA2b3pyTTlUNUdEL2F5NHpXeTdPeFczMm4zK3kvTDZi?=
 =?utf-8?B?TTg2OWlhdEZVTk04SDdYZldsYTNMdXorZWo3dUJQbHlQNnh3SUlLcHZmVUtm?=
 =?utf-8?B?M2RFYm81UTU3ZFVKK20rL1VxKzkzMDVqTEp6dVFkQWRvUjg3VFRyNWZjSXRz?=
 =?utf-8?B?NzJBL0VwTkFaZXdVL1Uxa3d3UU5yS1VCZnloY1JJY05EMlE5T0dUdUpIR3NL?=
 =?utf-8?B?NDQ1UldSdHpIVTQ3dkl6SUdxN2xjMjZWdi9IUlhhdVZQL1RUdnJUR0RUei9P?=
 =?utf-8?B?NE9oS1plSXhGZXF3eTlKNmRQYlJaVlBCTGJJUmV0ci90emtoYWtPWUJjVFZG?=
 =?utf-8?B?c21SV0IxTlVHZmZqZ0xiTE40NHZ1aWR5YjRFTDc3Y2NhcUo5SitLV0diWTh0?=
 =?utf-8?B?TVFlSEEvc3hUVHZpM2pkR0ZjUERmb1lEN01tbUVkZFJyY2J4OThXazJVVWxH?=
 =?utf-8?B?akdzUmszbk1ZeDNTcS9RMTQybldKeDBlTzdhVGVCdkNYbjJjQWFFQm5va3RP?=
 =?utf-8?B?VFF6UGRGY05BSW5lZXIwbEIvR1BQbitIYnpQcHZkR0s0Tk9zTFlIK1ZERU02?=
 =?utf-8?B?MjNoQytkblp6dXJsR0hZT2F4QTgrMHpMa2xPT1ZpSEl1YjlNMmw2VVhneUxk?=
 =?utf-8?B?eHRTV25zanpVNTFUYlJuamtIZ0tOTDI4cDJDZlgzb3RleUpKYzhMcHk2UXlO?=
 =?utf-8?B?VExaU1RzTnNvLzdZUnh1YXdkdE5najNUaG50MHU4WmFuMHBKZy92ajFRelhI?=
 =?utf-8?B?aUNrM2x4M1dZVXJxWHFXTFN4MDlyOXQ5ejFWNEU4d3hKVTcvOTNTOExPL1VE?=
 =?utf-8?B?MWZSOVdsSXZnaE9ROXoxWWgrc05KWlBPbERvNmRPS1YvQ0R6R3VoRDh5aWwr?=
 =?utf-8?B?ZXdWMXY1MEhyZjgwMUZjcHFCejVmMExvWStVZ3prRzhFcyttQ0tNeTVQRWQy?=
 =?utf-8?B?ckJFREtvMHFZaFl1d1VLTlV3Rk12RUJyTGNYdllqUVEzSHZobS9LUWVUS0RN?=
 =?utf-8?B?TFlTeW05VkhsSTVLM25CWVBieUt3SVVwUjV0c2xZUTRRdlk5dnBrdGpVd2pG?=
 =?utf-8?B?UndqYnptMWh1NThZeWN5NE5idTNGblBoaDk2UTRocHRyN1lNNURTV1JoOTdw?=
 =?utf-8?B?eURnNTNHNUsxbUgzc2trTlVCaGZhc2hwdVJ4Mmlab3pGVHZTdUdyeWhhUTBL?=
 =?utf-8?B?RjFROEFCM0FsUW9oQ1RNKy85ZmUwcDl6Zi9oTVdoeXlBdUxDekRPMmg3TGFt?=
 =?utf-8?B?amRUZ2VDWVR6WlBFeHBzR0Vud3dtdGgra3VuSzI2Y3ZjM3FYT2VPV3FjNzR1?=
 =?utf-8?B?cWRiUHNkUTZNckZ3Yy9nQysyK01sYXhvVTZlM1VBY2VYYlBHTlFuZlkyWnNP?=
 =?utf-8?B?NGFRcjJYVFRPQ3JtUGZXdDd6TWttcmZVYnJNdnF6VUdEZk9pVGc3YitkQm0w?=
 =?utf-8?B?L2VEaHU0MzBSYjltdnBDSU9SNS9RalVuQmZUdk5NdEV2MTlGTTdjc3VnVVRH?=
 =?utf-8?B?TS93NC80TjEwU0s4dE9VMWE4a3cwbytLQmhMN2RvdndIaS9QSE1taXZxdmEv?=
 =?utf-8?B?cWVyOE1BYjFsZ1FPS3VjODlDSFZ3NUhJL3JqaVk2aWZtbGFOdFVrQVNZVElt?=
 =?utf-8?B?VmVMZVF2MkVIZ2R6Y3NUTk9Ca2c1dEFhNGZHU29QTFFsQzQ4SzhNbS91T0lz?=
 =?utf-8?B?SEdvNVdOTHdnVHB4bHZjRUVNSG5nRkU3eE9LSVRSQkVXclpqQ0Z3TnFLdE4r?=
 =?utf-8?B?SGJidzFXNWxqTW5xMjY0QUNjWEJSOUZQbzhWQ2pwMEtzdTh1NkVPMFNnMjQz?=
 =?utf-8?B?RUZQbkU5L1NkdTl6VlJPOWE1eTI4VUg5WTVVWDBNQmpMNGxwYUE2SkV0L3ho?=
 =?utf-8?B?Z2tIQTFFYjAvOG5BdVcxR1dUY0V5Mmh5aFJqSEx4SW0rSjNHdXRQWnlZMjEv?=
 =?utf-8?Q?zeUSloAd9xuCFxrdWR9cpO0sM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3420.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac98166-c646-4398-3ec6-08db66560002
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 06:19:35.6413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sTgjysI/btBDQV5mmRFP6iA8ZIBlZhv4Ne+fiYxsYBOrRTMJ7EExtVrbV+6zGVR6p/3rbe1SjNqfMzU/J9I6g+br7vVlefbmCocXKteBZ5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3885
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksSmFzb24uDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24g
V2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogTW9uZGF5LCBKdW5lIDUsIDIwMjMg
Mjo1NCBQTQ0KPiBUbzogQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+DQo+
IENjOiBtc3RAcmVkaGF0LmNvbTsgdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSF0gdnBfdmRwYTogQ2hlY2sgcXVldWUgbnVtYmVyIG9mIHZkcGEgZGV2aWNlIGZyb20NCj4g
YWRkX2NvbmZpZw0KPiANCj4gT24gRnJpLCBKdW4gMiwgMjAyMyBhdCAzOjM14oCvUE0gQW5ndXMg
Q2hlbiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gV2hl
biBhZGQgdmlydGlvX3BjaSB2ZHBhIGRldmljZSxjaGVjayB0aGUgdnFzIG51bWJlciBvZiBkZXZp
Y2UgY2FwDQo+ID4gYW5kIG1heF92cV9wYWlycyBmcm9tIGFkZF9jb25maWcuDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBBbmd1cyBDaGVuIDxhbmd1cy5jaGVuQGphZ3Vhcm1pY3JvLmNvbT4NCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5jIHwgMTEgKysrKysr
KysrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBh
LmMNCj4gYi9kcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMNCj4gPiBpbmRleCAyODEy
ODdmYWU4OWYuLjRiZjFhYjYzN2QzMiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmly
dGlvX3BjaS92cF92ZHBhLmMNCj4gPiArKysgYi9kcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92
ZHBhLmMNCj4gPiBAQCAtNDc4LDcgKzQ3OCw3IEBAIHN0YXRpYyBpbnQgdnBfdmRwYV9kZXZfYWRk
KHN0cnVjdCB2ZHBhX21nbXRfZGV2DQo+ICp2X21kZXYsIGNvbnN0IGNoYXIgKm5hbWUsDQo+ID4g
ICAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiA+ICAgICAgICAgc3Ry
dWN0IHZwX3ZkcGEgKnZwX3ZkcGEgPSBOVUxMOw0KPiA+ICAgICAgICAgdTY0IGRldmljZV9mZWF0
dXJlczsNCj4gPiAtICAgICAgIGludCByZXQsIGk7DQo+ID4gKyAgICAgICBpbnQgcmV0LCBpLCBx
dWV1ZXM7DQo+ID4NCj4gPiAgICAgICAgIHZwX3ZkcGEgPSB2ZHBhX2FsbG9jX2RldmljZShzdHJ1
Y3QgdnBfdmRwYSwgdmRwYSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBkZXYsICZ2cF92ZHBhX29wcywgMSwgMSwgbmFtZSwNCj4gZmFsc2UpOw0KPiA+IEBAIC00OTEs
NyArNDkxLDE0IEBAIHN0YXRpYyBpbnQgdnBfdmRwYV9kZXZfYWRkKHN0cnVjdCB2ZHBhX21nbXRf
ZGV2DQo+ICp2X21kZXYsIGNvbnN0IGNoYXIgKm5hbWUsDQo+ID4gICAgICAgICB2cF92ZHBhX21n
dGRldi0+dnBfdmRwYSA9IHZwX3ZkcGE7DQo+ID4NCj4gPiAgICAgICAgIHZwX3ZkcGEtPnZkcGEu
ZG1hX2RldiA9ICZwZGV2LT5kZXY7DQo+ID4gLSAgICAgICB2cF92ZHBhLT5xdWV1ZXMgPSB2cF9t
b2Rlcm5fZ2V0X251bV9xdWV1ZXMobWRldik7DQo+ID4gKyAgICAgICBxdWV1ZXMgPSB2cF9tb2Rl
cm5fZ2V0X251bV9xdWV1ZXMobWRldik7DQo+ID4gKyAgICAgICBpZiAoYWRkX2NvbmZpZy0+bWFz
ayAmDQo+IEJJVF9VTEwoVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BWF9WUVApKSB7DQo+ID4gKyAg
ICAgICAgICAgICAgIGlmIChhZGRfY29uZmlnLT5uZXQubWF4X3ZxX3BhaXJzID4gcXVldWVzIC8g
MikNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiArICAg
ICAgICAgICAgICAgcXVldWVzID0gbWluX3QodTMyLCBxdWV1ZXMsIDIgKg0KPiBhZGRfY29uZmln
LT5uZXQubWF4X3ZxX3BhaXJzKTsNCj4gDQo+IExvb2tzIGxpa2UgeW91IHdhbnQgdG8gbWVkaWF0
ZSB0aGUgbWF4X3ZxcCBoZXJlLCBidXQgd2hhdCBoYXBwZW5zOg0KPiANCj4gMSkgaGFyd2FyZSBo
YXZlIDQgcXVldWUgcGFyaXMNCj4gMikgdnBfdmRwYSBjYXAgaXQgaW50byAyIHF1ZXVlIHBhaXJz
DQo+IDMpIGd1ZXN0IG1heSBzdGlsbCB0cnkgdG8gZW5hYmxlIDQgcXVldWUgcGFyaXMNCj4gDQpZ
ZXPvvIx5b3UgYXJlIHJpZ2h077yMdGhpcyBzaXR1YXRpb24gY2FuIG9jY3VyLg0KPiBGb3IgMyks
IHRoZSBrZXJuZWwgbmVlZHMgdG8gbWVkaWF0ZSB0aGUgY29udHJvbCB2aXJ0cXVldWUgd2hpY2gg
c2VlbXMgbm90DQo+IGVhc3kuDQo+IA0KPiBIb3cgYWJvdXQgc2ltcGx5IHN0YXJ0aW5nIGZyb20g
ZmFpbGluZyBpZiB0aGUgcHJvdmlzaW9uZWQgI3FwIGlzIG5vdA0KPiBlcXVhbCB0byB0aGUgb25l
IHRoYXQgaGFyZHdhcmUgaGFzPw0KT2ssWW91IG1lYW4gd2UganVzdCBjaGVjayBpdCBpbiB2cF92
ZHBhIG9yIGNoZWNrIGl0IGluIGFsbCBvdGhlciB2ZHBhIG5ldCBkcml2ZXJzPw0KPiANCj4gVGhh
bmtzDQo+IA0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIHZwX3ZkcGEtPnF1ZXVl
cyA9IHF1ZXVlczsNCj4gPiAgICAgICAgIHZwX3ZkcGEtPm1kZXYgPSBtZGV2Ow0KPiA+DQo+ID4g
ICAgICAgICBkZXZpY2VfZmVhdHVyZXMgPSB2cF9tb2Rlcm5fZ2V0X2ZlYXR1cmVzKG1kZXYpOw0K
PiA+IC0tDQo+ID4gMi4yNS4xDQo+ID4NCg0K
