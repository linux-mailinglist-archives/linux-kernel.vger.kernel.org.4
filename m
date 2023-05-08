Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6584D6F9D10
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 02:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjEHAgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 20:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjEHAgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 20:36:11 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2045.outbound.protection.outlook.com [40.107.114.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3ED98A55;
        Sun,  7 May 2023 17:36:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENQD5aU9VmNq+6QbDbfvPAKDggMjSYwKMbD4nS6fuIZDfTh4WapKlqImLTMsw9ibc/oNw9VvegHZqcGd0F4evv8InCN4rZXxZiZQsL7MuzGJPvLg4wp/n9dVjfcV5hmIAK+Rnp1LefRpzaSwPhw+8lzDmMxL3KszDxpHCt8/zzM77psS9dsuCxR/t7fjSKA7vFhlKDp7GHJZH5rH/XDmvmOgr6U/9OZ/ZVwHWXZaTDFSWYI1DfczM9X4buaA8RtIGugNImpdSNjRAzGYj5cw+Fs1uOlBj/o+iYuPMJo10vOjq25Jv84yfVhSF0FJZ8BYU2LMf91XhvUk6hxb2eBTkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBjx701N6W9A0jI3mdc6Z90QNy5ooLXyUUk3SXB3Cw4=;
 b=Z36RveF+YTC+Cz1L6Cfh1BQtjxfjtmnFksK4dOH3eRUOrnpacSehf0A/LozkSgmOqKEMW+zGRiBRpYqnuM09E0ynP+Om3MqmK/ZkPMZFroBrHQuts4f0wCu8ak8wOSfgiFeXpGTMgnKvq8NLKMIGzlTe0oXYmEUkxxbRcI8XeZsrmwZz9U+OhyIeHKaMpj7Tafy+pvUPKiTZ/9Cc7BGJ9T8G+Su40VE+STjse46JoVoKiAEI3+GDnQ9bJKUgKGh7tNP/CQIYrVaQPHhk9S+w6YtbPdNbcBvPAamaelrskUcD37WvgR0sPwywBAGwvOpSPtuOvD6FwHHZEkUQ8TFqvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nskint.co.jp; dmarc=pass action=none header.from=nskint.co.jp;
 dkim=pass header.d=nskint.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nskint.onmicrosoft.com; s=selector1-nskint-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBjx701N6W9A0jI3mdc6Z90QNy5ooLXyUUk3SXB3Cw4=;
 b=hnSucoTi/vP7njHzxyC//ZcYzZ4ISsYJe4Z2hA5LbeQdnoDPEHZHbbN0mqjNWaF+Znu9YTZ/fl3Tq1l/6JcBZlARERDb4Az3t4+NLqNRW4oPwebZFQI4AZlBVv37iVHK+NAMaupvCvxlYXrxL8RqWS4cIws5SHDbcSNVKMAdc8Q=
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com (2603:1096:604:13c::9)
 by OS7PR01MB11880.jpnprd01.prod.outlook.com (2603:1096:604:239::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Mon, 8 May
 2023 00:36:07 +0000
Received: from OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::148a:7cac:32d9:1c03]) by OSZPR01MB7004.jpnprd01.prod.outlook.com
 ([fe80::148a:7cac:32d9:1c03%5]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 00:36:07 +0000
From:   Yoshitaka Ikeda <ikeda@nskint.co.jp>
To:     Dhruva Gole <d-gole@ti.com>
CC:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Takahiro.Kuwano@infineon.com" <Takahiro.Kuwano@infineon.com>,
        Pratyush Yadav <ptyadav@amazon.de>,
        Mark Brown <broonie@kernel.org>
Subject: RE: [PATCH v2 4/4] spi: cadence-quadspi: use STIG mode for small
 reads
Thread-Topic: [PATCH v2 4/4] spi: cadence-quadspi: use STIG mode for small
 reads
Thread-Index: AQHZMJVBHgHXafuso0ywMCCxmHrW5689ZDXggABfGwCAARZ4MIAA3JcAgBBuwJA=
Date:   Mon, 8 May 2023 00:36:06 +0000
Message-ID: <OSZPR01MB7004907B2FB95F45E9B83FEC8B719@OSZPR01MB7004.jpnprd01.prod.outlook.com>
References: <20230125081023.1573712-1-d-gole@ti.com>
 <20230125081023.1573712-5-d-gole@ti.com>
 <OSZPR01MB70048CE259A3D63C4179199A8B659@OSZPR01MB7004.jpnprd01.prod.outlook.com>
 <044a723e-b81e-f6f2-8bf7-3680a10abc86@ti.com>
 <OSZPR01MB7004D229048A950C93B40CC88B6A9@OSZPR01MB7004.jpnprd01.prod.outlook.com>
 <b1d30948-ba3d-a4cc-e1ed-851a9dedba7c@ti.com>
In-Reply-To: <b1d30948-ba3d-a4cc-e1ed-851a9dedba7c@ti.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nskint.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7004:EE_|OS7PR01MB11880:EE_
x-ms-office365-filtering-correlation-id: f46a438b-370d-4de2-1b14-08db4f5c365a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pmieUeMuznMDVJbSVcJgrSWB4ezzV4g6W/+U6krT1kr38J0iW/w60ZkFhxG4c/qfaNrVm74vmqueB9sk92v5RCTyRVLrQopjeuMkyMMDkRrOXN50NrJzW3vqpXLqOVapyuAK/AIVb6Vmp15txxiTqFjX6VokuFSmN6wmZf5ryaEy5hFYbDUn0Q3X5E0PrCfNcOmuMql5px/Af0kT2H5j/ICcxU8SLkqWQyZslfhw1DHUvXZ1NLXt0zCRGHij2KjI2e9b76U6Tnvn1fjzYnkiPk2vCy3pvLRvZaLne5rlXZO1hkql/gjJGEvMeBScQmuJ3vSI7pb3G/EMn8TokEA0bZy1EHi4daoDZWTkBu2Caex1ELSpBdFh+JXpKIEQSLifDLtdGw/hH4ov/AvUNvUd00muIp7qXqhvD2JVIxVTcYKBOfak4XAC6BB0+cIxU1a5mxqNCj9rsXJ9aw1OQd2L9wYG8F943AVFhVbxcu+rw+ixxy5Qi555r2KEYN9Jwy7OA/3LFzEFq6XB3UAqj8zh2R8ps+nstw6/aDaxFRmX0JWMU+a/9CDrbGGOGBQDhR/WIxSR5rMmTF3/KiADLOD7BKy7Mk+Y24wbYtsNBmZ3aYYcfYQ17WoKCLkDu/l+JHg0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7004.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(366004)(39830400003)(396003)(451199021)(83380400001)(478600001)(7696005)(71200400001)(54906003)(9686003)(6506007)(26005)(186003)(7416002)(2906002)(33656002)(52536014)(38100700002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(6916009)(122000001)(4326008)(41300700001)(5660300002)(8676002)(8936002)(38070700005)(86362001)(55016003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVVnTzNMUTh4bUxERFBmZ2hMcm81M0xwL0VZZFZ2dGdRRXIzUEM0c1NGelVI?=
 =?utf-8?B?Ui8xcDUwc0sxQ0N6cHpXZTRUMXVWdlk1OTlnMkkzSFhreGthNzIrckkzK2R2?=
 =?utf-8?B?K2gyTXdScit4dkdqQ2ZrZDVWUWVOdWVVbUlpTTJxOTZaazVhZG1QS3BzVHdu?=
 =?utf-8?B?OXFVdUVuWTV0OEVDTC80SDFxOXZHZzlBNTk1YVdUMVBHbjNMa1A3ZUg1emFh?=
 =?utf-8?B?bktrNHMvckp1VG5OYm1Ca1EyVmJoTy9zbTlPWU9uSnNRQmJ5U21ybW43ektH?=
 =?utf-8?B?Skhkd3B5cUt0cHZkZFRBeEczdDJCY3h0Y1VlTHB1U01vSDlvRS83Mitmb1NM?=
 =?utf-8?B?VkVFM01pSzkzYUxFTlQxUkVDMStyd2xyNms1L1gwZFFpamFPdi80azJNZXdP?=
 =?utf-8?B?NXJMV1puNm1DRG5yWStEQ3BhaFZXNzU1VUtSSFhVUEljVStRdy9tZkprTEJj?=
 =?utf-8?B?OXpYTkhGWjhIV2I5bVRCTjdaVlo3Q3g0dlpZVUxIb21EVVlZVlJSSGVmRUhK?=
 =?utf-8?B?VWtlUGJtZ216MHFUd2toWms0NERDNkNnUnBZM05uWGx1SGkwNlF1SmhWUjhK?=
 =?utf-8?B?MWlMdUZHOHF2NE5zSXdESlNvVHR3VGZQZ3VOdVZLTXFvQ3FtRU1NODJ4UHlP?=
 =?utf-8?B?RDVoTVZlY1FuY25ZWGhwd2RjaEorc3RXYmpFSzVyTEJpMDZ5a3ZlYTgrSUs0?=
 =?utf-8?B?V2hNT21QYU85OUdCWWJySzViMW9KMDdNSEVjSTdqQmt3TWdFMUpXZHZZc3VO?=
 =?utf-8?B?aVlBQmxRayt0NytpQXVTN2R4ZEk2YlB1Z3dJbU4rM0djazdXSXZnd29kWUJN?=
 =?utf-8?B?bitrLzlzL1BzTmQwek94VnMxV1ZKUUJxalJXZjg0SmJuUW5pNjJiOEJGbDdi?=
 =?utf-8?B?cnJwekdpbTQvYkVKUGdPSUpMTlZQcVZYUEkybDZTcEFFQXVGb2V5SnVQb3F4?=
 =?utf-8?B?QlZ6MktzZ3lta3JqNG9RS0tjcVR3N3UwVngwWW1xbWw2SFZteFZBUDJiUXUr?=
 =?utf-8?B?SDhjUTB6bjZoLzNESHNsR3k5SW5xRTJOSi91SDVXYm9vbFBaZURqNTlUdkZx?=
 =?utf-8?B?azJ0Y2czNmVPU0w0ZnJwbTVlT2Nveml5Y1BTZGd3YjkraUlxQkY3Ry9kbStv?=
 =?utf-8?B?eWlKd052QVRPcTR1ZkxHNzFmZlk0ZUcwRnVadHlVbFhJVlhWOVZUVGxjeWVZ?=
 =?utf-8?B?YXZrRmR1QzRkcmdZbE5LeTBOa0J0MGxwaEliak5SbVFZdmpURzJrRlNMazVa?=
 =?utf-8?B?NXcyRm5Wc2RNeDYrTmVYSDVJd25XMjdlK3NyTmcvbGlMczhsVE1MMUFkR1k3?=
 =?utf-8?B?QkYyNEhzaHl3Z1NWTC9VNkVSdW1ubGwzcWJUUnNkbXorL25QTE9oTGxLeE5m?=
 =?utf-8?B?YU0yWTZXRzFza2o2aWdQcXBQOXQ0dnYwbWdGcEc5NUFCMko1VUdrSjRic0VP?=
 =?utf-8?B?S2JDN0FnUTBXY2dlaGUvUk9VdExCb2tpV2xpczBmVEVNZHN6dXIvWStDYmZS?=
 =?utf-8?B?VHM2QTAxOXJLajdBa0xHamo3RXZUUE1MNGlRdjVraVpsOGFjemJWQXc4eHZl?=
 =?utf-8?B?bEZhcTNjOHZRaXgzVDdBN01rQ0QydkErQk0rUE1IN1NnSnA0ZkxzUVgzWi8w?=
 =?utf-8?B?RXFYNW9jMmNkYWF0VlJ3ZkVMa3ZvQkRUb1cxMXBuekdVL3VLYUNKSjZidTY3?=
 =?utf-8?B?UTh4OGdJL2JzWWt1UW02Z1V3Z3JTcElqRTRLY2pJVTVwZUFEZGxreXc5ZFhF?=
 =?utf-8?B?NUlKb2dYdW5IelZjNzNzT1pFdGFFWUI5UmJ2NGhEeVRJMkd4Q2RIbk9YcHdP?=
 =?utf-8?B?Q3FIN0JoU045SU9YSDhaSE12UDdIaW91bXovWUFOYjg1QlE3bVR4QW5rVWor?=
 =?utf-8?B?WUxuTHoraUd0eEgxblVlalhHUlFyRTc2U3FJcFF2OVRaRUl4Q1k3c1p1d3BU?=
 =?utf-8?B?a1BHQkVmZFFCNGVxZGUrUDV5OC9XZ0p3TGduaHB1QkNDc1FzbEpIYUlvdmha?=
 =?utf-8?B?dzRucExYbTJWWmFzb0lJRDR2Yi91TzF4akRrbzVLZk1RQlA5Z0JXTm16L0Yy?=
 =?utf-8?B?dm9SNzFwU1ZlSDlTWjZSUTAwVktrNnViZlNoNHJnSHBYNEwrRStjaTF5anZG?=
 =?utf-8?Q?FVvuvWzJazPCX53dUshhRUEkj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nskint.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7004.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f46a438b-370d-4de2-1b14-08db4f5c365a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 00:36:07.0152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 727455a2-9822-4451-819f-f03e059d1a55
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6b5IbwUJyLPpCd+G9kBgpMKC9XYqbYYQ+6VZ4hIj8R0ziLHtRkl6glvDeSIIbU80JokBBXjtcPDPmGwafLbwrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11880
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGhydXZhLA0KDQpTb3JyeSBmb3IgdGhlIGxhdGUgcmVwbHkgYXMgSSB3YXMgb24gYSBsb25n
IHZhY2F0aW9uLg0KDQo+IFRoYW5rcyBmb3Igc2hhcmluZywgSSB3ZW50IHRocm91Z2ggYW5kIGNv
dWxkbid0IHJlYWxseSBmaW5kIGFueSBtYWpvciBjaGFuZ2VzDQo+IGF0IHRoZSBjb250cm9sbGVy
IGxldmVsLg0KPiBTbyBJIGFtIHdvbmRlcmluZyBpZiBzb21lIHNwZWNpZmljIHNlcXVlbmNlIG9m
IGZsYXNoIG9wZXJhdGlvbnMgb24geW91cg0KPiBkZXZpY2UgaXMgZXhwb3Npbmcgc29tZSBpc3N1
ZXMgaW4gdGhlIGRyaXZlcidzIFNUSUcgcmVhZHMuDQoNClRoYW5rIHlvdSBmb3IgbG9va2luZyBp
bnRvIHRoaXMuDQoNCj4gUGxlYXNlIGNhbiB5b3Ugc2hhcmUgc29tZSBsb2dzIHdpdGggdGhlIGZv
bGxvd2luZyBwYXRjaDoNCj4gSSBhbSB0cnlpbmcgdG8gc2VlIGEgcGF0dGVybiB0aGF0IG1heSBi
ZSBjYXVzaW5nIGlzc3Vlcy4NCj4gSSBhbSB1bmFibGUgdG8gcmVwcm9kdWNlIHRoaXMgb24gbXkg
ZW5kIGF0IHRoZSBtb21lbnQuDQoNClRoZSBsb2dzIG9idGFpbmVkIHdpdGggdGhlIHBhdGNoIGFw
cGxpZWQgYXJlIGFzIGZvbGxvd3M6DQoNCi0gRXJyb3IgYXQgc3RhcnR1cA0KICAtIEtlcm5lbCBs
b2cNClsgICAgMC45ODA1OThdICoqKioqKioqKipzcGlfbWVtX29wIGR1bXAqKioqKioqKioqKioq
Kg0KWyAgICAwLjk4MDYxM10gYWRkcjogbmJ5dGVzOjB4MCAsIGJ1c3dpZHRoIDB4MCwgZHRyIDB4
MCwgdmFsIDB4MA0KWyAgICAwLjk4NDIyM10gY21kOiBuYnl0ZXM6MHgxICwgYnVzd2lkdGggMHgx
LCBkdHIgMHgwLCBvcGNvZGUgMHg5Rg0KWyAgICAwLjk4ODY1Nl0gZGF0YTogbmJ5dGVzOjB4NiAs
IGJ1c3dpZHRoIDB4MSwgZHRyIDB4MCwgZGF0YSBkaXIgMHgxDQpbICAgIDAuOTkzMzYyXSAqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioNClsgICAgMC45OTgzMjldIHNwaS1u
b3Igc3BpMC4wOiBmb3VuZCBtdDI1cWw1MTJhLCBleHBlY3RlZCBuMjVxNTEyYQ0KWyAgICAxLjAw
NjU3NF0gKioqKioqKioqKnNwaV9tZW1fb3AgZHVtcCoqKioqKioqKioqKioqDQpbICAgIDEuMDA2
NTgzXSBhZGRyOiBuYnl0ZXM6MHgzICwgYnVzd2lkdGggMHgxLCBkdHIgMHgwLCB2YWwgMHgwDQpb
ICAgIDEuMDEwMTUwXSBjbWQ6IG5ieXRlczoweDEgLCBidXN3aWR0aCAweDEsIGR0ciAweDAsIG9w
Y29kZSAweDVBDQpbICAgIDEuMDE0NTk2XSBkYXRhOiBuYnl0ZXM6MHgxMCAsIGJ1c3dpZHRoIDB4
MSwgZHRyIDB4MCwgZGF0YSBkaXIgMHgxDQpbICAgIDEuMDE5Mjg1XSAqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioNClsgICAgMS41MjQyNzFdIGNhZGVuY2UtcXNwaSBmZjcw
NTAwMC5mbGFzaDogRmxhc2ggY29tbWFuZCBleGVjdXRpb24gdGltZWQgb3V0Lg0KWyAgICAxLjUz
MzQ4M10gKioqKioqKioqKnNwaV9tZW1fb3AgZHVtcCoqKioqKioqKioqKioqDQpbICAgIDEuNTMz
NDg5XSBhZGRyOiBuYnl0ZXM6MHgzICwgYnVzd2lkdGggMHgxLCBkdHIgMHgwLCB2YWwgMHgxMA0K
WyAgICAxLjUzNzA1NV0gY21kOiBuYnl0ZXM6MHgxICwgYnVzd2lkdGggMHgxLCBkdHIgMHgwLCBv
cGNvZGUgMHg1QQ0KWyAgICAxLjU0MTU3OV0gZGF0YTogbmJ5dGVzOjB4OCAsIGJ1c3dpZHRoIDB4
MSwgZHRyIDB4MCwgZGF0YSBkaXIgMHgxDQpbICAgIDEuNTQ2MjY2XSAqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioNClsgICAgMS41NTExMjNdIHNwaS1ub3Igc3BpMC4wOiBv
cGVyYXRpb24gZmFpbGVkIHdpdGggLTExMA0KWyAgICAxLjU1ODUzMV0gc3BpLW5vciBzcGkwLjA6
IG10MjVxbDUxMmEgKDY1NTM2IEtieXRlcykNCg0KLSBFcnJvciBhdCBhY2Nlc3MNCiAgLSBBY2Nl
c3MgY29tbWFuZCBhbmQgbG9nDQojIGhleGR1bXAgLUN2IC9kZXYvbXRkYmxvY2swDQpoZXhkdW1w
OiAvZGV2L210ZGJsb2NrMDogSW5wdXQvb3V0cHV0IGVycm9yDQoNCiAgLSBLZXJuZWwgbG9nDQpb
ICAgNzUuNDAxMjk3XSBjYWRlbmNlLXFzcGkgZmY3MDUwMDAuZmxhc2g6IFFTUEkgaXMgc3RpbGwg
YnVzeSBhZnRlciA1MDBtcyB0aW1lb3V0Lg0KWyAgIDc1LjQwMTMzN10gKioqKioqKioqKnNwaV9t
ZW1fb3AgZHVtcCoqKioqKioqKioqKioqDQpbICAgNzUuNDAxMzQzXSBhZGRyOiBuYnl0ZXM6MHg0
ICwgYnVzd2lkdGggMHgxLCBkdHIgMHgwLCB2YWwgMHgwDQpbICAgNzUuNDAxMzU0XSBjbWQ6IG5i
eXRlczoweDEgLCBidXN3aWR0aCAweDEsIGR0ciAweDAsIG9wY29kZSAweEMNClsgICA3NS40MDEz
NjRdIGRhdGE6IG5ieXRlczoweDIwMCAsIGJ1c3dpZHRoIDB4MSwgZHRyIDB4MCwgZGF0YSBkaXIg
MHgxDQpbICAgNzUuNDAxMzczXSAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioNClsgICA3NS40MDEzODJdIHNwaS1ub3Igc3BpMC4wOiBvcGVyYXRpb24gZmFpbGVkIHdpdGgg
LTExMA0KWyAgIDc1LjQwMTQwN10gSS9PIGVycm9yLCBkZXYgbXRkYmxvY2swLCBzZWN0b3IgMCBv
cCAweDA6KFJFQUQpIGZsYWdzIDB4ODA3MDAgcGh5c19zZWcgNCBwcmlvIGNsYXNzIDINClsgICA3
NS45MTEzMzldIGNhZGVuY2UtcXNwaSBmZjcwNTAwMC5mbGFzaDogUVNQSSBpcyBzdGlsbCBidXN5
IGFmdGVyIDUwMG1zIHRpbWVvdXQuDQpbICAgNzUuOTExMzcyXSAqKioqKioqKioqc3BpX21lbV9v
cCBkdW1wKioqKioqKioqKioqKioNClsgICA3NS45MTEzNzldIGFkZHI6IG5ieXRlczoweDQgLCBi
dXN3aWR0aCAweDEsIGR0ciAweDAsIHZhbCAweDEwMDANClsgICA3NS45MTEzOTBdIGNtZDogbmJ5
dGVzOjB4MSAsIGJ1c3dpZHRoIDB4MSwgZHRyIDB4MCwgb3Bjb2RlIDB4Qw0KWyAgIDc1LjkxMTM5
OV0gZGF0YTogbmJ5dGVzOjB4MjAwICwgYnVzd2lkdGggMHgxLCBkdHIgMHgwLCBkYXRhIGRpciAw
eDENClsgICA3NS45MTE0MDldICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
Kg0KWyAgIDc1LjkxMTQxN10gc3BpLW5vciBzcGkwLjA6IG9wZXJhdGlvbiBmYWlsZWQgd2l0aCAt
MTEwDQpbICAgNzUuOTExNDQzXSBJL08gZXJyb3IsIGRldiBtdGRibG9jazAsIHNlY3RvciA4IG9w
IDB4MDooUkVBRCkgZmxhZ3MgMHg4MDcwMCBwaHlzX3NlZyAzIHByaW8gY2xhc3MgMg0KWyAgIDc2
LjQyMTMzM10gY2FkZW5jZS1xc3BpIGZmNzA1MDAwLmZsYXNoOiBRU1BJIGlzIHN0aWxsIGJ1c3kg
YWZ0ZXIgNTAwbXMgdGltZW91dC4NClsgICA3Ni40MjEzNjVdICoqKioqKioqKipzcGlfbWVtX29w
IGR1bXAqKioqKioqKioqKioqKg0KWyAgIDc2LjQyMTM3MV0gYWRkcjogbmJ5dGVzOjB4NCAsIGJ1
c3dpZHRoIDB4MSwgZHRyIDB4MCwgdmFsIDB4MjAwMA0KWyAgIDc2LjQyMTM4M10gY21kOiBuYnl0
ZXM6MHgxICwgYnVzd2lkdGggMHgxLCBkdHIgMHgwLCBvcGNvZGUgMHhDDQpbICAgNzYuNDIxMzkz
XSBkYXRhOiBuYnl0ZXM6MHgyMDAgLCBidXN3aWR0aCAweDEsIGR0ciAweDAsIGRhdGEgZGlyIDB4
MQ0KWyAgIDc2LjQyMTQwM10gKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
DQpbICAgNzYuNDIxNDExXSBzcGktbm9yIHNwaTAuMDogb3BlcmF0aW9uIGZhaWxlZCB3aXRoIC0x
MTANClsgICA3Ni40MjE0MzZdIEkvTyBlcnJvciwgZGV2IG10ZGJsb2NrMCwgc2VjdG9yIDE2IG9w
IDB4MDooUkVBRCkgZmxhZ3MgMHg4MDcwMCBwaHlzX3NlZyAyIHByaW8gY2xhc3MgMg0KWyAgIDc2
LjkzMTMzMF0gY2FkZW5jZS1xc3BpIGZmNzA1MDAwLmZsYXNoOiBRU1BJIGlzIHN0aWxsIGJ1c3kg
YWZ0ZXIgNTAwbXMgdGltZW91dC4NClsgICA3Ni45MzEzNjVdICoqKioqKioqKipzcGlfbWVtX29w
IGR1bXAqKioqKioqKioqKioqKg0KWyAgIDc2LjkzMTM3MV0gYWRkcjogbmJ5dGVzOjB4NCAsIGJ1
c3dpZHRoIDB4MSwgZHRyIDB4MCwgdmFsIDB4MzAwMA0KWyAgIDc2LjkzMTM4Ml0gY21kOiBuYnl0
ZXM6MHgxICwgYnVzd2lkdGggMHgxLCBkdHIgMHgwLCBvcGNvZGUgMHhDDQpbICAgNzYuOTMxMzky
XSBkYXRhOiBuYnl0ZXM6MHgyMDAgLCBidXN3aWR0aCAweDEsIGR0ciAweDAsIGRhdGEgZGlyIDB4
MQ0KWyAgIDc2LjkzMTQwMV0gKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
DQpbICAgNzYuOTMxNDEwXSBzcGktbm9yIHNwaTAuMDogb3BlcmF0aW9uIGZhaWxlZCB3aXRoIC0x
MTANClsgICA3Ni45MzE0MzddIEkvTyBlcnJvciwgZGV2IG10ZGJsb2NrMCwgc2VjdG9yIDI0IG9w
IDB4MDooUkVBRCkgZmxhZ3MgMHg4MDcwMCBwaHlzX3NlZyAxIHByaW8gY2xhc3MgMg0KWyAgIDc3
LjQ0MTI5N10gY2FkZW5jZS1xc3BpIGZmNzA1MDAwLmZsYXNoOiBRU1BJIGlzIHN0aWxsIGJ1c3kg
YWZ0ZXIgNTAwbXMgdGltZW91dC4NClsgICA3Ny40NDEzMzBdICoqKioqKioqKipzcGlfbWVtX29w
IGR1bXAqKioqKioqKioqKioqKg0KWyAgIDc3LjQ0MTMzN10gYWRkcjogbmJ5dGVzOjB4NCAsIGJ1
c3dpZHRoIDB4MSwgZHRyIDB4MCwgdmFsIDB4MA0KWyAgIDc3LjQ0MTM0N10gY21kOiBuYnl0ZXM6
MHgxICwgYnVzd2lkdGggMHgxLCBkdHIgMHgwLCBvcGNvZGUgMHhDDQpbICAgNzcuNDQxMzU3XSBk
YXRhOiBuYnl0ZXM6MHgyMDAgLCBidXN3aWR0aCAweDEsIGR0ciAweDAsIGRhdGEgZGlyIDB4MQ0K
WyAgIDc3LjQ0MTM2N10gKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqDQpb
ICAgNzcuNDQxMzc1XSBzcGktbm9yIHNwaTAuMDogb3BlcmF0aW9uIGZhaWxlZCB3aXRoIC0xMTAN
ClsgICA3Ny40NDE0MDFdIEkvTyBlcnJvciwgZGV2IG10ZGJsb2NrMCwgc2VjdG9yIDAgb3AgMHgw
OihSRUFEKSBmbGFncyAweDAgcGh5c19zZWcgMSBwcmlvIGNsYXNzIDINClsgICA3Ny40NDE0MjNd
IEJ1ZmZlciBJL08gZXJyb3Igb24gZGV2IG10ZGJsb2NrMCwgbG9naWNhbCBibG9jayAwLCBhc3lu
YyBwYWdlIHJlYWQNCg0KLS0gDQpUaGFua3MgYW5kIFJlZ2FyZHMsDQpZb3NoaXRha2EgSWtlZGEN
Cg==
