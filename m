Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AA962B037
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 01:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiKPAqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 19:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiKPAqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 19:46:31 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2072.outbound.protection.outlook.com [40.107.255.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9832E13DF5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 16:46:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5EhzfULFyHTPudPupz86hOoBG9TGHprWKez0TBQhfw5KAGItGXAQdxAWaTFJIqFarblWl6Speejl9+ber7LvF4Eubqg+naGyDpysn0XNDydzsHaa//948U65TGJslMjvcYSSgr0vUy/Vq9zHG2LDhfkgmeliMiat8C53IVvRimyMaj+LKocDcOJ4pCW2P/SuUejE3+UiGgslsxdmRdl3Njk31BQdLglV8l3LlxOFrvRaZn49A5QKI1b+33sUuk17KWiqUmly/my3bXkztuJ3G1XX7MuAUmPJPY84WFnQF2+g9OIsCMyJe8AiRZ4fmWvG2744mQpVwPZOv9qhNvtGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtnM5pYFE0yqAtgXlsDOuIzfm83ACkuEGY9zgeTlhWc=;
 b=kVI8h0itbi0bN37unv4elBqvV9iFo1YGZUoG9aYJelUyPD+ufOtE2in+1s0inC2A5k1n10uemtJ2FLaemn7R9l1q+y4G6eztv67X0XXznFqx2s1zrlYZvxHNuc+fAyf3oUddtCSEWQ4zXPaXfh3KcedqO++uK1DaEMsE8a6wWJMfNM7h2KtnzSF2QWrw3P2ST9p+MSxRCsfVUasZuuCXKY+VJZKgde924Hdwkle+GLuZBx9Ecu6BRCIZzruGFSW8obtepd78yG/4lO1TSayywbS0vEYc8/SUlZV/UOnvlqzK9pygg9Q/8AGYA6T5Plnl3hs6c8aZ71avGJ0AsnMP2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtnM5pYFE0yqAtgXlsDOuIzfm83ACkuEGY9zgeTlhWc=;
 b=HIZ1YGr6czmhLsUOt1PnjHl2FK5Opac7vR4GBigKmynnpgWv39o2koO7EvjInC0GRYlQ/Zo9DPhrAjNiSXBI7jwY72e3DYnZVCpfvX0Jcin7AAuaY39ycRj5rupya2utY2Yimkt7k0EBxZqdb9R0QJ+jbGmPgaOig4OKQT4cNefMbAkBIM/hngWYnTeBQC4HvdkJNG0YEvQkboZbCdv1pn1gugzLewxS4oRzyWaVjrvaUxcpAz7QnbdQD8l9YOm8rBMu5QNrmzqgXS+0pqxmR1twPuBL32hF5y523mMF2clQrec3dBMv20aSc3L0QKDNC2wWZ247zxEBievCZjYbxw==
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by SI2PR06MB4522.apcprd06.prod.outlook.com (2603:1096:4:156::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 00:46:27 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::3fde:75ae:e50a:7b24]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::3fde:75ae:e50a:7b24%7]) with mapi id 15.20.5813.014; Wed, 16 Nov 2022
 00:46:26 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: RE: IRQ affinity problem from virtio_blk
Thread-Topic: IRQ affinity problem from virtio_blk
Thread-Index: Adj4GDwuFWHl+dEdQ1up6lA52hDITABKCKOAAADen4AAAK+KgAAAs48AAAH5VoA=
Date:   Wed, 16 Nov 2022 00:46:26 +0000
Message-ID: <TY2PR06MB34248DB15CBBDA7624DAFAE185079@TY2PR06MB3424.apcprd06.prod.outlook.com>
References: <TY2PR06MB3424CB11DB57CA1FAA16F10D85049@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <87v8nfrhbw.ffs@tglx> <20221115174152-mutt-send-email-mst@kernel.org>
 <87sfijrf9o.ffs@tglx> <87o7t7rec7.ffs@tglx>
In-Reply-To: <87o7t7rec7.ffs@tglx>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3424:EE_|SI2PR06MB4522:EE_
x-ms-office365-filtering-correlation-id: 8bffb027-9daf-451d-60c5-08dac76bfe3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IFMy/FSutDnqAXMc1npHMak1jCJxJT5IXfzjoo38C9UQE7oqJKthNHedlPk1h07frYVc1Hz7o6e2pU5vhZHwx+BxRcGC6TEztKCb/oX+1+jJOLSTbaIQuV0K9OoO/JsrcYUlDlBXBrdJUJ9IwqjnQw5DIhGpofchZ4Y5XpJp76gmhecvfOa+8lf+NYhUeZfddpc66FLLfJUcZb9FENTI+E9OYvZX9/xbz6kLibq+Ln3vWocAsNUq1SJQrFRB0/vkN0EwKcbfXWEyNYdJvWInRkEgcInugHAlWMKbes71pbs588xHY8wCWEtFk0LHov5O2ujK+i13lSQP6xXfGFfY28L7bHD+9OxtKyNymMIhbo2bMyMzcvaoQpYdJWJ81FxGMzF/b9QHA/OC0jtUebgVca7WfecmdYmY5WEh36vcpUO0zdz1oUHqpo2is7V2yW3LyrwpQYqExzNneIQaqsFFKBN8yEiIlsnAzmSk9yhXvvegCRPud+HG7rfLIEdNgRAfkjjUxu9TeCiRog+9y16azynzEYW6zgZK19p1BTKx792PmsJPpRQJb5N/VWBiEZItgrJetDeGpRIoQbNqgafz2CBnHLxnw6Av2C8DAbRi1X06nFC4DzQx4KBgIZhlg3nCN/g3ONXndQeqtxJgiNoL4A9y47TNTA3eSo6Tj+5ciT/kg/gLdo/Ozh8M2yWyJgoI9PVX6P9Op1Acsk9xHtW2/Aca3gSAzbFhSg62QzdBYItEYF0bEYfOLTwWzb56Wy8oGBZBYs9e9AKZ6nRetUkjqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39840400004)(376002)(136003)(366004)(396003)(451199015)(33656002)(38070700005)(86362001)(83380400001)(55016003)(44832011)(2906002)(5660300002)(7696005)(186003)(9686003)(26005)(6506007)(54906003)(38100700002)(53546011)(122000001)(110136005)(76116006)(66556008)(66946007)(66446008)(71200400001)(52536014)(64756008)(8676002)(8936002)(478600001)(41300700001)(66476007)(4326008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1lMR2F1akp4K0tvZSt3TlpTeHFnamVZaGQrd1I2aERVb0krK0UxTUVqSzRK?=
 =?utf-8?B?ZEcwMXhadXpoT24zbGhoR0ZJV2J2NmRKc29Wb29QQm1nbVBJRFlzczl3elVq?=
 =?utf-8?B?U2pvNk5BTWdrUFdaZ1pvMjRvSnlMcGF4d1VnQ0ZCQkNIRmhUSFlKdG8yL3Vs?=
 =?utf-8?B?aUJabUNXdC91N0JmYXBNVkFvT3NDbWdvR0lReUtDMVZaOTNtZWNzUjh4ZS9n?=
 =?utf-8?B?amJvekJTVDFqbjJTVWltQTBxbC90MGhDZlZucjJaeEMyVjB6MUhWUkdOenZH?=
 =?utf-8?B?NWlVVVBOeUxvL1ZFczBVVi81SE1rbUQ3YndscnZwa2xMUThmZzVXR0pGZERC?=
 =?utf-8?B?aFNHZUhJMlI3cWhwS1ArR3BSVGRCNGlZVmc2WlFrRWJUTzJubFJpVDNsQ2dm?=
 =?utf-8?B?dnN3M3grNG4zd3JWcW5CSnphQjBmZXpnSzlhVGJwR01OM2ExRkl6MkJXRTRK?=
 =?utf-8?B?ZWQyWFV1bDd2Um1TNHpuaDJPZCt6U0RzNWF6cjc1djZJRXROZDlYVzhYQ1RG?=
 =?utf-8?B?Sk1OUWlLQk05YVJ6NS84YjdqYiszNDE2MFpGbjFnbWZpWGpSMTduUEx1VlFW?=
 =?utf-8?B?cFVxOTFKdUxwQVE4VjhLUjFwSmV1NWhUYzd0dHBiZFdVSGhzVkp0MUtPdkh6?=
 =?utf-8?B?QUV5TDZoNDlTYmZvd0s4b0U2cW1ZeFk2WkhnTFlyeTJ3VnIvdHl3UzJyOEpG?=
 =?utf-8?B?VGgvNjZJN1dqWTRUeGgzOGRTWTFQWThwdi9IRHlWRzRBaDFyYVhxcE5vRnNH?=
 =?utf-8?B?Z3V5ZExJaytKL3JXb1JWZngzbmtwV2JrNUFqNjl2blRBMEtrOUNMU09vdXgx?=
 =?utf-8?B?dzVyWXQ5dmRwOUpOQjd2YkpibHZYTnpjRlE1bXF6N2N5cFFEWlpJNVJnSnJ6?=
 =?utf-8?B?YXJIRTQ3QzNxZ2UwVmltVWY4cldjcXhpcEZTMCtpSDNWSGZUTVk3aE1USmRG?=
 =?utf-8?B?T1RMRVVYcit5SURFazNaZWcyREdLQ0FnRXU5cldTRVYwK3haVXJzUHlvRW1T?=
 =?utf-8?B?clRoK00vMVE4ckZpVENVRVVqUC9kbXhTZ3daWkhIcWx4MG5MSXBBdTRYeGVa?=
 =?utf-8?B?N1RHVDFpcHpEUmFNMW1aQUN0aDRPbnNmeklMbzhmY29UQjFZSjRnRnhGVERM?=
 =?utf-8?B?REZON2FaL3NEWWlnNWVNdlNKaEhJRU9KM2ZhbHVvQjhZVEhJVkROdWFLYmlC?=
 =?utf-8?B?ZnRQbG5xeFF1NVE4MHJqZ3Q1RzNZTXRobHV1Y2MyNXA0bWUxTkc5akRGQXAx?=
 =?utf-8?B?cUx1dW1ZV3FZcnJOQlIwbTVYelg1OER3T1p1OHpoTHdMdjFCam1CaWtESjMx?=
 =?utf-8?B?T056UWNrY3cwdnltZDZNZHBiNk4vMVpSZm9kbnBMVllRTHNWU3BIZDA4M2NF?=
 =?utf-8?B?aHFCUFJvZUtMR1pXMEtEeVZxdHM1Z2pqZ3BRYThVRHJDNEpkU3RpdjJxazJl?=
 =?utf-8?B?b1FDQ1JLWlFOTDRHK1NYc0lOU0NFRzRkT2xpbWtBZ1Y4cUYxNXJBU1NQZ0E0?=
 =?utf-8?B?WnVzV0k5WEt5dHozTy96V1I2N01XK3BkVGxXL05sNnRQcHVCVUFHSkhPUjdq?=
 =?utf-8?B?NlFuNERveVA5T0JhdDZpM0NSbVFEV2QxOHlPVmlETlpqYzdxaTNSWjlLMUVq?=
 =?utf-8?B?NTFHUy9mcmh1cDVpMThUZmwxT3BCS2pZVGozSlNwc3p6L1FwMGNXUWJLakRV?=
 =?utf-8?B?MjhtRXcvcjE4UHpXZzl1bGVOZUtxTFRQUkF6Wis4RWgyR2dBZnRWdVJFbkJv?=
 =?utf-8?B?aGxFWHhIc1lSTWdONHR3N1VKT3BDODFVdEVPOUZzZVRnOTVtZERMb25JSjR3?=
 =?utf-8?B?UUlmbVZCMmx5Tmo3Y1NvUUh0S0RPc3RnbXJWcVVsMTg2cDZDRVlHQ0FTQ3BH?=
 =?utf-8?B?UjB2Q1FsYk4ybmQrbG9RODl1SW9YYkRqTDRNaWI0SDFyMEt3OVlLTlJROHU2?=
 =?utf-8?B?cHJvWmZXUlcrd2U5MmpDSGRnTkpNZXBZczNTZ0crK0JaUmQ1cXk5WFllK2RI?=
 =?utf-8?B?Z1F0VGNHamJ5VHNIZ1o0bE9LM2tXdnNrMDNoN05WZFFkRzdzbzZsMWlObGZj?=
 =?utf-8?B?Q0VWOHpKTUlWVzJxQjdzYTlXalprWnBMWU5Lc1BrbWVuS01lTmh6OXhsUFlt?=
 =?utf-8?B?Vkg1SUJqWDBRSGtlY0djS1VYa1RHLzkzOWwxdXlwVDFDN1Vic0dtSDk5elND?=
 =?utf-8?B?QVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bffb027-9daf-451d-60c5-08dac76bfe3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 00:46:26.6872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aNfHbKMviqPur0znginBZB9CJybCb65y+ZEKS8ep6GlHcOqNPLB2QoEqkE8cBxGIGFikEIFYoAleI1leOyafnTWf3ZK8QzNlxzQJswx6oXI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4522
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGhvbWFzIEdsZWl4bmVy
IDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMTYsIDIw
MjIgNzoyNCBBTQ0KPiBUbzogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj4g
Q2M6IEFuZ3VzIENoZW4gPGFuZ3VzLmNoZW5AamFndWFybWljcm8uY29tPjsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsNCj4gTWluZyBMZWkgPG1pbmcubGVpQHJlZGhhdC5jb20+OyBKYXNv
biBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBSZTogSVJRIGFmZmluaXR5
IHByb2JsZW0gZnJvbSB2aXJ0aW9fYmxrDQo+IA0KPiBPbiBXZWQsIE5vdiAxNiAyMDIyIGF0IDAw
OjA0LCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6DQo+IA0KPiA+IE9uIFR1ZSwgTm92IDE1IDIwMjIg
YXQgMTc6NDQsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToNCj4gPj4gT24gVHVlLCBOb3YgMTUs
IDIwMjIgYXQgMTE6MTk6NDdQTSArMDEwMCwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPiA+Pj4g
PiBXZSBjYW4gc2VlIGdsb2JhbF9hdmFpbGFibGUgZHJvcCBmcm9tIDE1MzU0IHRvIDE1MjczLCBp
cyA4MS4NCj4gPj4+ID4gQW5kIHRoZSB0b3RhbF9hbGxvY2F0ZWQgaW5jcmVhc2UgZnJvbSA0MTEg
dG8gNDEzLiBPbmUgY29uZmlnIGlycSxhbmQNCj4gPj4+ID4gb25lIHZxIGlycS4NCj4gPj4+DQo+
ID4+PiBSaWdodC4gVGhhdCdzIHBlcmZlY3RseSBmaW5lLiBBdCB0aGUgcG9pbnQgd2hlcmUgeW91
IGxvb2tpbmcgYXQgaXQsIHRoZQ0KPiA+Pj4gbWF0cml4IGFsbG9jYXRvciBoYXMgZ2l2ZW4gb3V0
IDIgdmVjdG9ycyBhcyBjYW4gYmUgc2VlbiB2aWENCj4gPj4+IHRvdGFsX2FsbG9jYXRlZC4NCj4g
Pj4+DQo+ID4+PiBCdXQgdGhlbiBpdCBhbHNvIGhhcyBhbm90aGVyIDc5IHZlY3RvcnMgcHV0IGFz
aWRlIGZvciB0aGUgb3RoZXIgcXVldWVzLA0KZW4saXQgbm90IHRoZSB0cnV0aCxpbiBmYWN0ICxJ
IGp1c3QgaGFzIG9uZSBxdWV1ZSBmb3Igb25lIHZpcnRpb19ibGsuDQoNCmNyYXNoX2N0cz4gc3Ry
dWN0IHZpcnRpb19ibGsubnVtX3ZxcyAweGZmZmY4ODgxNDdiNzljMDANCiAgbnVtX3ZxcyA9IDEs
DQpJIHRoaW5rIGlzIHRoZSBrZXkgd2UgdGFsayBhYm91dC4NCj4gPj4NCj4gPj4gV2hhdCBtYWtl
cyBpdCBwdXQgdGhlc2UgdmVjdG9ycyBhc2lkZT8gcGNpX2FsbG9jX2lycV92ZWN0b3JzX2FmZmlu
aXR5ID8NCj4gPg0KPiA+IGluaXRfdnEoKSAtPiB2aXJ0aW9fZmluZF92cXMoKSAtPiB2cF9maW5k
X3ZxcygpIC0+DQo+ID4gdnBfcmVxdWVzdF9tc2l4X3ZlY3RvcnMoKSAtPiBwY2lfYWxsb2NfaXJx
X3ZlY3RvcnNfYWZmaW5pdHkoKQ0KPiA+DQo+ID4gaW5pdF92cSgpIGhhbmRzIGluIGEgc3RydWN0
IGlycV9hZmZpbml0eSB3aGljaCBtZWFucyB0aGF0DQo+ID4gcGNpX2FsbG9jX2lycV92ZWN0b3Jz
X2FmZmluaXR5KCkgd2lsbCBzcHJlYWQgb3V0IGludGVycnVwdHMgYW5kIGhhdmUgb25lDQo+ID4g
Zm9yIGNvbmZpZyBhbmQgb25lIHBlciBxdWV1ZSBpZiB2cF9yZXF1ZXN0X21zaXhfdmVjdG9ycygp
IGlzIGludm9rZWQNCj4gPiB3aXRoIHBlcl92cV92ZWN0b3JzID09IHRydWUsIHdoaWNoIGlzIHdo
YXQgdGhlIGZpcnN0IGludm9jYXRpb24gaW4NCj4gPiB2cF9maW5kX3ZxcygpIGRvZXMuDQo+IA0K
PiBJIGp1c3QgY2hlY2tlZCBvbiBhIHJhbmRvbSBWTS4gVGhlIFBDSSBkZXZpY2UgYXMgYWR2ZXJ0
aXNlZCB0byB0aGUgZ3Vlc3QNCj4gZG9lcyBub3QgZXhwb3NlIHRoYXQgbWFueSB2ZWN0b3JzLiBP
bmUgaGFzIDIgYW5kIHRoZSBvdGhlciA0Lg0KPiANCj4gQnV0IGFzIHRoZSBpbnRlcnJ1cHRzIGFy
ZSByZXF1ZXN0ZWQgJ21hbmFnZWQnIHRoZSBjb3JlIGVuZHMgdXAgc2V0dGluZw0KPiB0aGUgdmVj
dG9ycyBhc2lkZS4gVGhhdCdzIGEgZnVuZGFtZW50YWwgcHJvcGVydHkgb2YgbWFuYWdlZCBpbnRl
cnJ1cHRzLg0KPiANCj4gQXNzdW1lIHlvdSBoYXZlIGxlc3MgcXVldWVzIHRoYW4gQ1BVcywgd2hp
Y2ggaXMgdGhlIGNhc2Ugd2l0aCAyIHZlY3RvcnMNCj4gYW5kIHRvbnMgb2YgQ1BVcywgaS5lLiBv
bmUgZW5kcyB1cCBmb3IgY29uZmlnIGFuZCB0aGUgb3RoZXIgZm9yIHRoZQ0KPiBhY3R1YWwgcXVl
dWUuIFNvIHRoZSBhZmZpbml0eSBzcHJlYWRpbmcgY29kZSB3aWxsIGVuZCB1cCBoYXZpbmcgdGhl
IGZ1bGwNCj4gY3B1bWFzayBmb3IgdGhlIHF1ZXVlIHZlY3Rvciwgd2hpY2ggaXMgbWFya2VkIG1h
bmFnZWQuIEFuZCBtYW5hZ2VkIG1lYW5zDQo+IHRoYXQgaXQncyBndWFyYW50ZWVkIGUuZy4gaW4g
dGhlIENQVSBob3RwbHVnIGNhc2UgdGhhdCB0aGUgaW50ZXJydXB0IGNhbg0KPiBiZSBtaWdyYXRl
ZCB0byBhIHN0aWxsIG9ubGluZSBDUFUuDQo+IA0KPiBTbyB3ZSBlbmQgdXAgc2V0dGluZyA3OSB2
ZWN0b3JzIGFzaWRlIChvbmUgcGVyIENQVSkgaW4gdGhlIGNhc2UgdGhhdCB0aGUNCj4gdmlydGlv
IGRldmljZSBvbmx5IHByb3ZpZGVzIHR3byB2ZWN0b3JzLg0KPiANCj4gQnV0IHRoYXQncyBub3Qg
dGhlIGVuZCBvZiB0aGUgd29ybGQgYXMgeW91IHJlYWxseSB3b3VsZCBuZWVkIH4yMDAgc3VjaA0K
PiBkZXZpY2VzIHRvIGV4aGF1c3QgdGhlIHZlY3RvciBzcGFjZS4uLg0KPiANClRoYW5rIHlvdSBm
b3IgeW91ciByZXBseS4uDQpMZXQncyBsb29rIHRoZSBkbWVzZyBmb3IgbW9yZSBpbmZvcm1hdGlv
bi4NCi4uLg0KTm92IDE0IDExOjQ4OjQ1IGxvY2FsaG9zdCBrZXJuZWw6IHZpcnRpb19ibGsgdmly
dGlvMTgxOiAxLzAvMCBkZWZhdWx0L3JlYWQvcG9sbCBxdWV1ZXMNCk5vdiAxNCAxMTo0ODo0NSBs
b2NhbGhvc3Qga2VybmVsOiB2aXJ0aW9fYmxrIHZpcnRpbzE4MTogW3ZkcHJdIDIwNDgwIDUxMi1i
eXRlIGxvZ2ljYWwgYmxvY2tzICgxMC41IE1CLzEwLjAgTWlCKQ0KTm92IDE0IDExOjQ4OjQ2IGxv
Y2FsaG9zdCBrZXJuZWw6IHZpcnRpby1wY2kgMDAwMDozNzoxNi40OiBlbmFibGluZyBkZXZpY2Ug
KDAwMDAgLT4gMDAwMikNCk5vdiAxNCAxMTo0ODo0NiBsb2NhbGhvc3Qga2VybmVsOiB2aXJ0aW8t
cGNpIDAwMDA6Mzc6MTYuNDogdmlydGlvX3BjaTogbGVhdmluZyBmb3IgbGVnYWN5IGRyaXZlcg0K
Tm92IDE0IDExOjQ4OjQ2IGxvY2FsaG9zdCBrZXJuZWw6IHZpcnRpb19ibGsgdmlydGlvMTgyOiAx
LzAvMCBkZWZhdWx0L3JlYWQvcG9sbCBxdWV1ZXMtLS0tLS0tLS10aGUgdmlydGlvMTgyIG1lYW5z
IGluZGV4IDE4Mi4NCk5vdiAxNCAxMTo0ODo0NiBsb2NhbGhvc3Qga2VybmVsOiB2cF9maW5kX3Zx
c19tc2l4IHJldHVybiBlcnI9LTI4LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS10aGUgZmly
c3QgdGltZSB3ZSBnZXQgJ25vIHNwYWNlJyBlcnJvciBmcm9tIGlycSBzdWJzeXN0ZW0uIA0KLi4u
DQpXZSBhcmUgZWFzeSB0byBnZXQgdGhlIG91dHB1dCBpcyA6DQpjcmFzaF9jdHM+IHAgKnZlY3Rv
cl9tYXRyaXgNCiQ5NyA9IHsNCiAgbWF0cml4X2JpdHMgPSAyNTYsDQogIGFsbG9jX3N0YXJ0ID0g
MzIsDQogIGFsbG9jX2VuZCA9IDIzNiwNCiAgYWxsb2Nfc2l6ZSA9IDIwNCwNCiAgZ2xvYmFsX2F2
YWlsYWJsZSA9IDAsLS0tLS0tLS0tLS0tdGhlIGlycSBpcyBleGhhdXN0ZWQuDQogIGdsb2JhbF9y
ZXNlcnZlZCA9IDE1NCwNCiAgc3lzdGVtYml0c19pbmFsbG9jID0gMywNCiAgdG90YWxfYWxsb2Nh
dGVkID0gMTg2MSwNCiAgb25saW5lX21hcHMgPSA4MCwNCiAgbWFwcyA9IDB4NDYxMDAsDQogIHNj
cmF0Y2hfbWFwID0gezE4NDQ2NzQ0MDY5OTUyNTAzODA3LCAxODQ0Njc0NDA3MzcwOTU1MTYxNSwg
MTg0NDY3NDQwNzM3MDk1NTE2MTUsIDE4NDM1MjI5OTg3OTQzNDgxMzQzfSwNCiAgc3lzdGVtX21h
cCA9IHsxMTI1OTA0NzM5NzI5NDA3LCAwLCAxLCAxODQzNTIyMTE5MTg1MDQ1OTEzNn0NCn0NCg0K
QWZ0ZXIgdGhhdCAsYWxsIHRoZSBpcnEgcmVxdWVzdCB3aWxsIGJlIHJldHVybmVkICJubyBzcGFj
ZSIuDQoNCklmIHRoZSBwZXJjcHUgaXJxIHZlY3RvciBpcyBtb3JlIGFzeW1tZXRyaWMsdGhhbiB0
aGUgbW9yZSBxdWlja2x5IHdlIGdldCB0aGUgJ25vIHNwYWNlJyBlcnJvciB3aGVuIHdlIHByb2Jl
IHRoZSBpcnEgd2l0aCANCklSUURfQUZGSU5JVFlfTUFOQUdFRC4NCg0KPiBUaGFua3MsDQo+IA0K
PiAgICAgICAgIHRnbHgNCj4gDQoNCg==
