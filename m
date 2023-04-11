Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921836DD436
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 09:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDKHbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 03:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjDKHa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 03:30:56 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2066.outbound.protection.outlook.com [40.107.117.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DF11FE2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 00:30:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LlQlCm2W7X9YBMbozsXvJJwW261O2/m6j1y6A2DDwjOMde/mGgGK5/gvtgQ4wN+mkCf6O6BoWTumfbxukC6hInz5fPfMmqsWsXscNkDzArayXJUmpo1wL1tsCz5sr9zu9kboJpMJ2Lv3aZDNycAqVdpjY+hdcWuUCsqkqAY1H15jT2lmtZ/enb8zq5IqyqwSzNCjw/Ucb79Clc0IWpr3S1BvK/z3EmLk36Wp7SWcljsR7ZWZhg80vUmQysTQosrHgaS8Z3cTY3IHM4X8/tUtFhhHtYfDAVSl/S+Vu95fskGyosjMcHLu/9n0Stlj1aqOeDftsrWODJg4F9AVrZKDeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYQ+iTMizkOdz1rSguxuRNItqVPZJ1XsPPjlTHt9z9M=;
 b=OzDnTioKl6Hq0sjG31uncGJtS1nInsfROQZ8wW8K2BnIRPIYb7V+BVAPV1kZV5Y1KFPn4YNtlXl553TDngbD+ya1LJIX0+vJYOgjHTyAXQghNIBu9eSErv6yhXD286fzmca+7++Ld6sezJhg1sPlhdwT9t6L74s6AFbXUDJG7eEU+/zU6sgX+zglJQ9IHNv1mgz1PyUq6Uc4b32Pi4EkN2H/5EWgpx3K7idWvIvecABmXheVTY9pSqfDMRtQK0BxtKdRlVEaUy4loTMZOC3FhtVCuSr4nDHCKeJS4hcNyfic8gZnsSk0ajanN3ImZTOTLtR9Kf23yoF1c4KRHW/E+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYQ+iTMizkOdz1rSguxuRNItqVPZJ1XsPPjlTHt9z9M=;
 b=hz/WymJ69hbpeqdFKQO/SfqIWOSh2FBSRS6ONYgKVJ5wij13L3uf/Ip5ctS4Yyt25H1aBK/dtdfe1sN+jlcTN/C8k96u2Xh+FnCNEzL57rOqzX7nOOqbNdUbYKiilHL3Orv0dj4V62Rqtt7aZV6BErdQPGYzJikpqkb6paAoM8KolM/SX7lrjt5/I2AJnUAtlQg8UMI3HqO34JqGT1SkLwsSXd5X5EG5zvJDgwa7UsYQ+7XEM2ilGUutOQ+X2Xt2hrNE1bqGUGas9GkuKD8G/z3z0sJ5C2v+4iXu5LRJ6j39NhOn2YC5tVbTAV1pJ+IVvsHctM8pe8Qg7qE48m3dVQ==
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by KL1PR0601MB5510.apcprd06.prod.outlook.com (2603:1096:820:ba::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 07:30:49 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::9e20:dc84:28e8:3c6]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::9e20:dc84:28e8:3c6%3]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 07:30:48 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] virtio_pci: Wait for legacy device to be reset
Thread-Topic: [PATCH] virtio_pci: Wait for legacy device to be reset
Thread-Index: AQHZbBZh3jvrK38aOUOklBMw4wCkQq8lk3uAgAAOhKCAAAi3AIAAADGAgAACIwCAAAP1EIAAAzUAgAAAfRA=
Date:   Tue, 11 Apr 2023 07:30:48 +0000
Message-ID: <TY2PR06MB3424DE523E669A3B1910D7F0859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
References: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
 <CACGkMEscqtaTpCed_f2cfknO4--mXCyp33u1CmZwNEZxyf=ifQ@mail.gmail.com>
 <TY2PR06MB3424BACFA8B6CB463C12E31E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20230411024459-mutt-send-email-mst@kernel.org>
 <TY2PR06MB3424E3C222C3B896BB583DFD859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20230411025335-mutt-send-email-mst@kernel.org>
 <TY2PR06MB3424DB10784CA5504A10099E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20230411032014-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230411032014-mutt-send-email-mst@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3424:EE_|KL1PR0601MB5510:EE_
x-ms-office365-filtering-correlation-id: 6526c32c-c717-4b9c-0c7f-08db3a5eabed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lI0KbpPc7jtg8Km6KPcS+a9xrZfcD35dZxN9f8MZBn3mehfXoikf8logRogQCSLnhmcAkEEuzoPq6edTtaLnnfAj6NCtCCS+avXdtHUD3nMjyjkzQeLf893iB7JNGro/uhDOTULqXizmYqdj7k4ERtQQB2EmfGLgay/w3zGFd222X7Cnu52DVJnWMhfFlwDWjvDTsF9EBQrTvJlzVrtu4N8oUR1TAUpGhfXDLnLXGQ6w3I0VZkVX3Q+a3hT1BuyjfTeG2Sj6B1yfxJcCjYOyYaJxbP/4xLkoQnYCxTNJPtBu0Ghp+EIIZTfkHR3xwr6lrHiJ9dy1d7XZC4J7NgHH3laf3htMpfNbJn4B8nz54zqblieobVP0OQgbkQElc/rQ2Zxm5Oc/sikuop0PgDWBLBXEZ4ogU/uOX0xBLNZtdbf7k63Dp0/yhX/90SCrOv00dFLgxgxqRBoH8RLdvOxqARYxY+xuknTdci2ywtviCzfdyraSNpRZ36juLGkXWdlpkoy4+7ujmTN5EdbmDboZ7RC3xKst1oeFSIOolGEzeRfu1ZD3D8F5BXgZJi93qG0OfIBQ/Ssacuwt6hhizSqy5J30EGuMe6AHse41YXGFXqJuKT/gGRyUmcyRC6N38BJu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39840400004)(366004)(396003)(136003)(376002)(346002)(451199021)(316002)(54906003)(33656002)(186003)(7696005)(71200400001)(478600001)(6916009)(66946007)(64756008)(66476007)(66556008)(66446008)(76116006)(83380400001)(41300700001)(53546011)(6506007)(9686003)(26005)(4326008)(38100700002)(8936002)(8676002)(122000001)(2906002)(52536014)(5660300002)(38070700005)(44832011)(86362001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N00zK1pMekZZLzVBN1VKeEFUcW9VWTdua0UyREF3THB1NThWZDBvK280K21Q?=
 =?utf-8?B?Y3lXVG56ZGZpUUtud2k0REpaTFR4SEhTV293OTNFQW55Wkpia3J1NDNUNHJW?=
 =?utf-8?B?dkFENUZ6WGJkR1ZpV0VwNElER2FuQUp0MTZOUWlYQys4TGR3SnRvbWdENFdI?=
 =?utf-8?B?UnNQcUdFYzJ1SVZoTXFnZ3VhN0RwV1B2MDZmV3BKWFVOQ1FkZlZDM2hreVJq?=
 =?utf-8?B?Y2Vvc1FnVjh0RUFmcXp4ZVV4QmtBb1dEZnVVUFRWZHY5bXliemdaUFNodUxX?=
 =?utf-8?B?ZnpzSlQ0SmxEczZrZHJGbDFtbmU2SXp1eWU0T1dObVhpT1dHdW85WXhvL0Jw?=
 =?utf-8?B?QXhSZUczR1lTUkVYZUgzS0dZME1qUFBmT3RBRzVhM2NISjdoR2lXbDRGZG9p?=
 =?utf-8?B?aE5lTlZnQ1RaZlVOb1NWM21qY2hsY2xKK3k5cW01TDdCaHAxU1lrM1d3dTd3?=
 =?utf-8?B?cnQ4UVV4Qk1vcUFKRDJ3MTcrSEhGUERPU1M2Wk4wVjB6NFdneW85LzJBeEJ1?=
 =?utf-8?B?cC9ZaFIrODJGTUY5VzFRVEVXRE5PTmtvOUwyaVJ4R215WUVsa1lWY2x3N1Q5?=
 =?utf-8?B?VUpRYnhDMi95MW93UTUyRkVzaW4rMDBVaDFDanBiU1JZbWpueGw5ajc5N2k1?=
 =?utf-8?B?YVpGNU9GYWNsdDZrVEtSUEJBM200THpaRmRCbE81ZExYL0hrQy8ydjRaYzR4?=
 =?utf-8?B?MG52b3pjLzVFaG4ydWhSV0dHL0pVM1FWb016MEYzdG0ya1pGcktBZ0ovemQ2?=
 =?utf-8?B?QVNmS0huTHlkWG1oVlNOb3dER01wUCtkMFIwMkJ2MmlrbnJ2M3pqNGp1TWFs?=
 =?utf-8?B?dXlrUzV3dHRVSEJ3Q0hFZXBjYWxIbGlqMVQvQjFsZ3NqQWdjS2JuYUpMMkhB?=
 =?utf-8?B?OHlBWm9xMm9ONzVCeGNwQUtMK2laSHJFWDFGVFYvVUp4ZTlEU0tOb0s4Zndm?=
 =?utf-8?B?b3lnVWV5RUFvSGxIM1RTOVo3aWNwNUpNc2M2OGlWMVBNYnRLMWgxNVArUkJ4?=
 =?utf-8?B?VG5naEdNSHh5YVhRRnQvTkFiVDFYWWpYN1grUVAySEFOVTZ6V00ydjNqTUth?=
 =?utf-8?B?cHQ1aUtmWFg4c2pQNFFyR09YYlRKV01PREp0ZmlWNmtoMkxndWRKY3BIbHJy?=
 =?utf-8?B?N081b2l5VnZmMmZvRmhrQ0ZBbEhaVVNIR09pb04zWURLelBPaDR5NlU0czhU?=
 =?utf-8?B?d09YcXdHSzdMaDk4KzdncG5hV3hERHBBaXYxbmVPNzJzenNXOURaYjBhKzU2?=
 =?utf-8?B?b0xmMFNRZHY2SWFvTGVBMVBmSTBwUHYvRGE4TG1POXhZYnpZSFVnWnpyREFz?=
 =?utf-8?B?cE5xdGYzUHJaRERhcnV1Z2ZERHZ2QXcwSHZzcHB1eDJPejJFQ2hEckg5cEd4?=
 =?utf-8?B?RDZrU2JZRkZzMmc0S0doa0hURjQ3MjNVQm9JblJvcXhFTEU2SVlDNHpyWno5?=
 =?utf-8?B?eXMvMkhTbThtSlQzK2oxL0xER1FVZjZOMERvanZXTzdweFU4UlpsRUpJdTVU?=
 =?utf-8?B?NSsydTkyMUpQQmp4TmdJRnR4QUlncHNKNTlSUlJNL2VZK1o1VE1vYVJ3eEtu?=
 =?utf-8?B?bWxUQ29VYUtHbXhvZDRVNERtb0FmV0FCS1VnVFdmS0EvQzc4L2k5b3hwdVFn?=
 =?utf-8?B?bG11RHo0NDhLVGRpSHRwRW8rdGRybG84VlU4TzJaRVRqbkpXamo0Y09DQnQr?=
 =?utf-8?B?VzBBNWk5bGxDdGpzODJhdC80azE0SmI3QW9KSEJwMTdkMlNPenVPL0l0b0dp?=
 =?utf-8?B?WEh6eVFOdUVwSXVOZ2lQR0hsc3d3ZjJEcHRoNTJPMXR6Vm1sNlJMd0ZlOEdu?=
 =?utf-8?B?MWlBejlnSmZ0ekNwZlpkVnRvK205UElvR2xUamdJS09IZWRPU3NPZVFOOGhx?=
 =?utf-8?B?V3lMSE1PKzZNU0ZmaDZGa3BEZjBYRDRwRWI5WUFRYjBBQVNvYi9oVUhYY0Zy?=
 =?utf-8?B?S1BEQXVHVE5IWk1qdHA0ZHN4RzdNenI2UWRlT0c1b3VFL3FxcWJDT0x1WCta?=
 =?utf-8?B?K0RaWjhFdUZHSHlQZE5reVZTMXNka1NkbExkbHFKa2dCeUhaMTRjTUhlZHJa?=
 =?utf-8?B?ckE0blhXcThOc0VEWE1raEUzOC9TZGtZZmlHL2tNMEFpOGFYaWxVcnAxTm5C?=
 =?utf-8?Q?vTqvyibfEz0hoDe2fWCchiA2S?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6526c32c-c717-4b9c-0c7f-08db3a5eabed
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 07:30:48.8814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L7gg2XHVH3Eb0jBlVqdNJPtW5uMnpF488i/zH+CRLkJheX73sRptePj10Hd6f0lRKp7NKQAh0Tq6gKHvj7v+Lq3VdcH2T8+RRg2/IQnSppw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5510
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFlbCBTLiBUc2ly
a2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gU2VudDogVHVlc2RheSwgQXByaWwgMTEsIDIwMjMgMzoy
MSBQTQ0KPiBUbzogQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+DQo+IENj
OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPjsNCj4gdmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4g
U3ViamVjdDogUmU6IFtQQVRDSF0gdmlydGlvX3BjaTogV2FpdCBmb3IgbGVnYWN5IGRldmljZSB0
byBiZSByZXNldA0KPiANCj4gT24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgMDc6MTc6MTRBTSArMDAw
MCwgQW5ndXMgQ2hlbiB3cm90ZToNCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiA+ID4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4N
Cj4gPiA+IFNlbnQ6IFR1ZXNkYXksIEFwcmlsIDExLCAyMDIzIDI6NTYgUE0NCj4gPiA+IFRvOiBB
bmd1cyBDaGVuIDxhbmd1cy5jaGVuQGphZ3Vhcm1pY3JvLmNvbT4NCj4gPiA+IENjOiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPjsNCj4gPiA+IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBT
dWJqZWN0OiBSZTogW1BBVENIXSB2aXJ0aW9fcGNpOiBXYWl0IGZvciBsZWdhY3kgZGV2aWNlIHRv
IGJlIHJlc2V0DQo+ID4gPg0KPiA+ID4gT24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgMDY6NDk6MDNB
TSArMDAwMCwgQW5ndXMgQ2hlbiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiA+IEZyb206IE1pY2hhZWwgUy4gVHNp
cmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+ID4gPiA+ID4gU2VudDogVHVlc2RheSwgQXByaWwgMTEs
IDIwMjMgMjo0NyBQTQ0KPiA+ID4gPiA+IFRvOiBBbmd1cyBDaGVuIDxhbmd1cy5jaGVuQGphZ3Vh
cm1pY3JvLmNvbT4NCj4gPiA+ID4gPiBDYzogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT47DQo+ID4gPiA+ID4gdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BB
VENIXSB2aXJ0aW9fcGNpOiBXYWl0IGZvciBsZWdhY3kgZGV2aWNlIHRvIGJlIHJlc2V0DQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiBPbiBUdWUsIEFwciAxMSwgMjAyMyBhdCAwNjozNjozOUFNICswMDAw
LCBBbmd1cyBDaGVuIHdyb3RlOg0KPiA+ID4gPiA+ID4gSGkuDQo+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiA+ID4gPiBGcm9tOiBK
YXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiA+ID4gPiA+ID4gPiBTZW50OiBUdWVz
ZGF5LCBBcHJpbCAxMSwgMjAyMyAxOjI0IFBNDQo+ID4gPiA+ID4gPiA+IFRvOiBBbmd1cyBDaGVu
IDxhbmd1cy5jaGVuQGphZ3Vhcm1pY3JvLmNvbT4NCj4gPiA+ID4gPiA+ID4gQ2M6IG1zdEByZWRo
YXQuY29tOyB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsNCj4gPiA+
ID4gPiA+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gPiA+ID4gPiBTdWJq
ZWN0OiBSZTogW1BBVENIXSB2aXJ0aW9fcGNpOiBXYWl0IGZvciBsZWdhY3kgZGV2aWNlIHRvIGJl
IHJlc2V0DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IE9uIFR1ZSwgQXByIDExLCAyMDIz
IGF0IDk6MznigK9BTSBBbmd1cyBDaGVuDQo+ID4gPiA+ID4gPGFuZ3VzLmNoZW5AamFndWFybWlj
cm8uY29tPg0KPiA+ID4gPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4gPiA+IFdlIHJlYWQgdGhlIHN0YXR1cyBvZiBkZXZpY2UgYWZ0ZXIgcmVzZXQsDQo+ID4gPiA+
ID4gPiA+ID4gSXQgaXMgbm90IGd1YXJhbnRlZWQgdGhhdCB0aGUgZGV2aWNlIGJlIHJlc2V0ZWQg
c3VjY2Vzc2Z1bGx5Lg0KPiA+ID4gPiA+ID4gPiA+IFdlIGNhbiB1c2UgYSB3aGlsZSBsb29wIHRv
IG1ha2Ugc3VyZSB0aGF0LGxpa2UgdGhlIG1vZGVybiBkZXZpY2UNCj4gZGlkLg0KPiA+ID4gPiA+
ID4gPiA+IFRoZSBzcGVjIGlzIG5vdCByZXF1ZXN0IGl0ICxidXQgaXQgd29yay4NCj4gPiA+ID4g
PiA+ID4NCj4gPiA+ID4gPiA+ID4gVGhlIG9ubHkgY29uY2VybiBpcyBpZiBpdCdzIHRvbyBsYXRl
IHRvIGRvIHRoaXMuDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IEJ0dywgYW55IHJlYXNv
biB5b3Ugd2FudCB0byBoYXZlIGEgbGVnYWN5IGhhcmR3YXJlIGltcGxlbWVudGF0aW9uLg0KPiBJ
dA0KPiA+ID4gPiA+ID4gPiB3aWxsIGJlIHZlcnkgdHJpY2t5IHRvIHdvcmsgY29ycmVjdGx5Lg0K
PiA+ID4gPiA+ID4gICBFbixJIGZvdW5kIHRoaXMgaW4gdGhlIHJlYWwgcHJvZHVjdGlvbiBlbnZp
cm9ubWVudCBzb21lIHRpbWVzIGFib3V0DQo+ID4gPiBvbmUNCj4gPiA+ID4gPiB5ZWFyIGFnby4N
Cj4gPiA+ID4gPiA+IGFuZCBJIGZpeCB0aGlzIG91dCBvZiB0cmVlLm91ciB2aXJ0aW8gY2FyZCBo
YWQgYmVlbiBzb2xkIGFib3V0IHRob3VzYW5kcyAuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4g
ICBOb3csd2UgY3JlYXRlZCBhIG5ldyBjYXJkLCBpdCBzdXBwb3J0IHZpcnRpbyAwLjk1LDEuMCwx
LjEgZXRjLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSSBhbSBub3QgMTAwJSBzdXJlIHdoYXQgZG9l
cyB0aGlzIG1lYW4uDQo+ID4gPiA+ID4gU28gaXQncyBhIHRyYW5zaXRpb25hbCBkZXZpY2UgdGhl
bj8NCj4gPiA+ID4gSGkgbXN0LGl0IGlzIGEgcmVhbCBjYXJkIGluIHRoZSBJbiBjbG91ZCBjb21w
dXRpbmcgLG5vdCB0cmFuc2l0aW9uYWwgZGV2aWNlLg0KPiA+ID4NCj4gPiA+IHllcywgYSByZWFs
IGNhcmQuIEJ1dCB5b3Ugc2FpZCBpdCBzdXBwb3J0cyAwLjk1LCAxLjAgYW5kIDEuMSBndWVzdHMs
DQo+ID4gPiBzbyB0aGlzIGlzIHdoYXQgdGhlIHZpcnRpbyBzcGVjIGNhbGxzIGEgdHJhbnNpdGlv
bmFsIGRldmljZSwgcmlnaHQ/DQo+ID4gPg0KPiA+ID4gCVRvIHNpbXBsaWZ5IHRyYW5zaXRpb24g
ZnJvbSB0aGVzZSBlYXJsaWVyIGRyYWZ0IGludGVyZmFjZXMsDQo+ID4gPiAJYSBkZXZpY2UgTUFZ
IGltcGxlbWVudDoNCj4gPiA+DQo+ID4gPiAJXGJlZ2lue2Rlc2NyaXB0aW9ufQ0KPiA+ID4gCVxp
dGVtW1RyYW5zaXRpb25hbCBEZXZpY2VdDQo+ID4gPiAJCWEgZGV2aWNlIHN1cHBvcnRpbmcgYm90
aCBkcml2ZXJzIGNvbmZvcm1pbmcgdG8gdGhpcw0KPiA+ID4gCQlzcGVjaWZpY2F0aW9uLCBhbmQg
YWxsb3dpbmcgbGVnYWN5IGRyaXZlcnMuDQo+ID4gPiAJXGVuZHtkZXNjcmlwdGlvbn0NCj4gPiA+
DQo+ID4gPiBvciBkaWQgSSBtaXN1bmRlcnN0YW5kPw0KPiA+ID4NCj4gPiBZZXMsIEknbSBub3Qg
c3VyZSB3aGV0aGVyIEkgbWFrZSBteXNlbGYgY2xlYXIuDQo+ID4gV2Ugc3VwcG9ydCB0aGUgdnJp
dGlvIHNwZWMgIDAuOTUsIDEuMCBhbmQgMS4xIGluIHRoZSBzYW1lIGNhcmQuDQo+ID4gQW5kIHRo
ZSBudW1lciBvZiBkZXZpY2VzIGlzIDFrIHBlciBvbmUgY2FyZC4NCj4gPg0KPiA+IEJ0dywgdGhh
bmtzIGEgbG90IGZvciB0aGUgd29yayBvZiByZWRoYXQsIHdlIGp1c3QgSW1wbGVtZW50IHRoZSB2
aXJ0aW8gcHJvdG9jb2wNCj4gYnkgaGFyZHdhcmUuDQo+IA0KPiBZZXMsIG5vdCB2ZXJ5IGNsZWFy
IHN0aWxsLiBXaGF0IGFyZSB0aGUgZGV2aWNlIGFuZCB2ZW5kb3IgSUQgb2YgdGhlDQo+IGNhcmQ/
IERvZXMgaXQgaGF2ZSB0aGUgdmlydGlvIGNhcGFiaWxpdGllcz8NCj4gVGhhbmtzDQpJdCdzIGhh
dmUgdGhlIHZpcnRpbyBjYXBhYmlsaXRpZXMuIA0KV2hlbiBpdCBpcyB1c2VkIGluIGJhcmUgbWV0
YWwg77yMDQogICBpdCBqdXN0IHVzZSBQQ0lfVkVORE9SX0lEX1JFREhBVF9RVU1SQU5FVC4NCldo
ZW4gaXQgdXNlIGluIHZtLA0KIEl0IGlzIGp1c3QgbGlrZSA6DQp7IFBDSV9ERVZJQ0VfU1VCKFBD
SV9WRU5ET1JfSURfUkVESEFUX1FVTVJBTkVULA0KICAgICAgICAgICAgIFZJUlRJT19UUkFOU19J
RF9ORVQsDQogICAgICAgICAgICAgUENJX1ZFTkRPUl9JRF9KQUdVQVJNSUNSTywNCiAgICAgICAg
ICAgICBWSVJUSU9fSURfTkVUKSB9LA0KICAgIHsgUENJX0RFVklDRV9TVUIoUENJX1ZFTkRPUl9J
RF9SRURIQVRfUVVNUkFORVQsDQogICAgICAgICAgICAgVklSVElPX1RSQU5TX0lEX0JMT0NLLA0K
ICAgICAgICAgICAgIFBDSV9WRU5ET1JfSURfSkFHVUFSTUlDUk8sDQogICAgICAgICAgICAgVklS
VElPX0lEX0JMT0NLKSB9LA0KDQoNCj4gDQo+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+ICAgQW5kIHdlIHVzZSB0aGlzIGhvc3QgdmRwYSsgbGVnYWN5IHZpcnRpbyBpbiB2
bSB0byBob3QgbWlncmF0aW9uLHdlDQo+ID4gPiBmb3VuZA0KPiA+ID4gPiA+IHRoYXQgdGhlDQo+
ID4gPiA+ID4gPiAgIExlZ2FjeSBtb2RlbCBvZnRlbiBnZXQgdGhlIG1pZGRsZSBzdGF0ZSB2YWx1
ZSBhZnRlciByZXNldCBhbmQgcHJvYmUNCj4gPiA+IGFnYWluLg0KPiA+ID4gPiA+ID4gICBUaGUg
U29jIGlzIFNpbXVsYXRlZCBieSBmcGdhIHdoaWNoIGlzIHJ1biBzbG93ZXIgdGhhbiB0aGUgaG9z
dCxzbyB0aGUNCj4gPiA+IHNhbWUNCj4gPiA+ID4gPiBidWcNCj4gPiA+ID4gPiA+ICAgSXMgZm91
bmQgbW9yZSBmcmVxdWVudGx5IHdoZW4gdGhlIGhvc3QgdXNlIHRoZSBvdGhlciBrZXJuZWwgbGlr
ZQ0KPiA+ID4gdWJ1bnR1IG9yDQo+ID4gPiA+ID4gY2VudG9zOC4NCj4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiAgIFNvIHdlIGhvcGUgd2UgY2FuIGZpeCB0aGlzIGJ5IHVwc3RyZWFtIC4NCj4gPiA+
ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gVGhhbmtzDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4g
PiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbmd1cyBDaGVuIDxhbmd1cy5j
aGVuQGphZ3Vhcm1pY3JvLmNvbT4NCj4gPiA+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ID4g
PiAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYyB8IDQgKysrLQ0KPiA+ID4gPiA+
ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0
aW8vdmlydGlvX3BjaV9sZWdhY3kuYw0KPiA+ID4gPiA+IGIvZHJpdmVycy92aXJ0aW8vdmlydGlv
X3BjaV9sZWdhY3kuYw0KPiA+ID4gPiA+ID4gPiA+IGluZGV4IDIyNTdmMWIzZDhhZS4uZjJkMjQx
NTYzZTRmIDEwMDY0NA0KPiA+ID4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19wY2lfbGVnYWN5LmMNCj4gPiA+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcGNpX2xlZ2FjeS5jDQo+ID4gPiA+ID4gPiA+ID4gQEAgLTE0LDYgKzE0LDcgQEANCj4gPiA+
ID4gPiA+ID4gPiAgICogIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+ID4g
PiA+ID4gPiA+ID4gICAqLw0KPiA+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gKyNpbmNs
dWRlIDxsaW51eC9kZWxheS5oPg0KPiA+ID4gPiA+ID4gPiA+ICAjaW5jbHVkZSAibGludXgvdmly
dGlvX3BjaV9sZWdhY3kuaCINCj4gPiA+ID4gPiA+ID4gPiAgI2luY2x1ZGUgInZpcnRpb19wY2lf
Y29tbW9uLmgiDQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBAQCAtOTcsNyArOTgs
OCBAQCBzdGF0aWMgdm9pZCB2cF9yZXNldChzdHJ1Y3QgdmlydGlvX2RldmljZQ0KPiAqdmRldikN
Cj4gPiA+ID4gPiA+ID4gPiAgICAgICAgIHZwX2xlZ2FjeV9zZXRfc3RhdHVzKCZ2cF9kZXYtPmxk
ZXYsIDApOw0KPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgLyogRmx1c2ggb3V0IHRoZSBzdGF0dXMg
d3JpdGUsIGFuZCBmbHVzaCBpbiBkZXZpY2Ugd3JpdGVzLA0KPiA+ID4gPiA+ID4gPiA+ICAgICAg
ICAgICogaW5jbHVkaW5nIE1TaS1YIGludGVycnVwdHMsIGlmIGFueS4gKi8NCj4gPiA+ID4gPiA+
ID4gPiAtICAgICAgIHZwX2xlZ2FjeV9nZXRfc3RhdHVzKCZ2cF9kZXYtPmxkZXYpOw0KPiA+ID4g
PiA+ID4gPiA+ICsgICAgICAgd2hpbGUgKHZwX2xlZ2FjeV9nZXRfc3RhdHVzKCZ2cF9kZXYtPmxk
ZXYpKQ0KPiA+ID4gPiA+ID4gPiA+ICsgICAgICAgICAgICAgICBtc2xlZXAoMSk7DQo+ID4gPiA+
ID4gPiA+ID4gICAgICAgICAvKiBGbHVzaCBwZW5kaW5nIFZRL2NvbmZpZ3VyYXRpb24gY2FsbGJh
Y2tzLiAqLw0KPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgdnBfc3luY2hyb25pemVfdmVjdG9ycyh2
ZGV2KTsNCj4gPiA+ID4gPiA+ID4gPiAgfQ0KPiA+ID4gPiA+ID4gPiA+IC0tDQo+ID4gPiA+ID4g
PiA+ID4gMi4yNS4xDQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4N
Cg0K
