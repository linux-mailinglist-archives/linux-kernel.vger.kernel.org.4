Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A026DD2F5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjDKGgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjDKGgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:36:46 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2044.outbound.protection.outlook.com [40.107.215.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E779D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:36:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrlzNdJeaAMKNZKcsVdcHXcHdLj0qMiDOCvPH7rprnF/ox1FzZNLcQJ6wUszh2Sl6Kg9tmvOAxoMMCrb0Iod8VC4ReoxvZ78kFjwfDKyzHIyfjKWJlkQ+l5A+tyX8PagJkUtI2gnN70QGwSDCJjLlmS/AtbfF6umjkZ+4qVCi7bKsPVWpASGvQ8/Vcw3RrPXIxOUKnNbbg1AQOllbUtKv3xzjcgkGz3lp+mY5f/ta8oUDdbJcu9CH/AxhSD598gWoGwHlvZSj+zCGJghDB+84UITS5TVV2eMppDxjDqWuOWQs9eNEYnON3RhQFKut9dO8uX274QKaP/kuLAEvedQ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogQ+o+1aWbVCd7Umc9RqajwiAt1RrvjWV6hNSRVTHSs=;
 b=FWZnbz4Hq/PNQ/kg7t5bAae8MUy6yo+6xeakzn+joL0fEHC/IisuTbp+TLL0M5r9/COxdU031WqpVHjlNnHhilrGecMOnGjFT4CEpMbUBTZheoW5kIkAJmknqTSXMCySJToG4GrbqY/GKxTfPtB0e/x+MhSxhO6lTq48dDoRSBN3RKAhy27U70LFmtKS2JdOArTc02C+XNCyPAaLggzzenBAvOOvLqfIVk2YWVJuilAyWtkYnHxpCmxE+IICNpb6a2S/jlaPhzuYqTaNv4Al8tByMYaMIIj8w7JH2CYiSZT/vEZ1L/TeTSgafgUI+A+ZRB3ntB8dMqE3r3riLyGEbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogQ+o+1aWbVCd7Umc9RqajwiAt1RrvjWV6hNSRVTHSs=;
 b=Xf8fYUeY8ayvDdJg/mYX1Zz0bLiRu97lPmLdqAhxDUwfRyXbqzB1x4yIGU7cUmLmrlt+2lb6HB2SZyM4P9Li7HU33jhsaBPuAeWNGs2R3gGBcv94paDjSZ430NskuwXeyZmwQwmSP7gGJJWeJ9D5v6+k9TXNcSHjq09bkwvVd3RjjpqQ1Rylj4Xht2B1BRy+JJCroTTV40mgoRd8twF+zJb9mmDFLqum99aLZffEA9zDWj77u12ycDoIASSnjj4YEclAL4uXkd39t9A6a5B6/9Mi3wzgI5GZo5uPW9ZBDmzPXspdr25vGmrVyWqOW6kONW7kBExfzHSc2KC877/EAA==
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by PSAPR06MB4341.apcprd06.prod.outlook.com (2603:1096:301:8a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 06:36:39 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::9e20:dc84:28e8:3c6]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::9e20:dc84:28e8:3c6%3]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 06:36:39 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     "mst@redhat.com" <mst@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] virtio_pci: Wait for legacy device to be reset
Thread-Topic: [PATCH] virtio_pci: Wait for legacy device to be reset
Thread-Index: AQHZbBZh3jvrK38aOUOklBMw4wCkQq8lk3uAgAAOhKA=
Date:   Tue, 11 Apr 2023 06:36:39 +0000
Message-ID: <TY2PR06MB3424BACFA8B6CB463C12E31E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
References: <20230411013833.1305-1-angus.chen@jaguarmicro.com>
 <CACGkMEscqtaTpCed_f2cfknO4--mXCyp33u1CmZwNEZxyf=ifQ@mail.gmail.com>
In-Reply-To: <CACGkMEscqtaTpCed_f2cfknO4--mXCyp33u1CmZwNEZxyf=ifQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR06MB3424:EE_|PSAPR06MB4341:EE_
x-ms-office365-filtering-correlation-id: 83d6a1b7-d582-4cb8-a454-08db3a571b0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Y//iTHgEYUFFo0ELnNWXY0ysWHRFMIlOYftiSHv+v0suKnJpnJO6GaGm/jdtBb1uji1KahttHu7OzZLIwYSb+lNr2pY9iCWmOepLfaqgzU2+Cz/KMrXcMfNdxLUGH87w3N0+6kGh+YfmCjs9OmxsF2x6J255t09crzR0/SX/HZgqUKKDq9JJiTfSkEjFbqgR5aM03oKXOppg43hw9M21VcCrhZLPz/Nns+sxesRvzvOcl3zVsa7PoevXArCESvAevzhTVOol/aa+Ie4QtHzjTGrsV3ccn9N40UWrRKCfb2jPbyBxC+EdEH1/EiSP1s3c/Apif+UfJORtqtrOlJ2eB151Urom6mkJiC0eg1DWJrvkuoq/6d5sd7yAn2eBKINmPPzWBP1sSBiXO07wxv0MJhqNXQYlvZdEuHhCSNi/7tMPcF3E2wds3XQNvKb0DgEk08cEGeORGUAAk9mhAf25Ed+wwjVIMDLqp89wJF2iayh0TySa7MUyPgwkudktRC7beGJ6bOKH6Ya7sUhN5HqKM9K0uQQEMpLirtsblvkj0njIGVypM7fJ013pfgtOa90zp4wCNB15GWE5KOnUHaBFIiW+gz1rqj8mv6MxlQX2zeixvq7eE0h1ivIuleubULO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(39830400003)(396003)(451199021)(478600001)(7696005)(71200400001)(6506007)(316002)(54906003)(53546011)(26005)(9686003)(186003)(2906002)(44832011)(66556008)(76116006)(66946007)(4326008)(52536014)(64756008)(41300700001)(5660300002)(66446008)(66476007)(8676002)(8936002)(6916009)(38070700005)(38100700002)(122000001)(55016003)(33656002)(83380400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0VuUEs4Mnh3SzlGdzk3MmlSd1MrRUQrSVdqV0RkcFhXUW1NUHRjaXBSWDVz?=
 =?utf-8?B?YXVXZm1DUHF2VEF2M2drTUg1N1lJTkZEVk1XNkpkTWpOellOaXRlYXlHS0Uw?=
 =?utf-8?B?akhzaVFablJsaVpsaTFPajVHVlhaK3dxdWxFQkpRZExwc0VPL3lOMTBHKzlL?=
 =?utf-8?B?cmRIaTJ5Z2tpazBseThIRm5ndllaMGk2S0oveGRZRS9hT0h1VEV5R2xvdzBU?=
 =?utf-8?B?d3lsRCt2VHVVcTI2dk9wODJBYmQ2ZG9mL2VudGpha2t4ZGh2d0VGOUFoRGxq?=
 =?utf-8?B?a3pDWTNtRnU0eWxxOWZOMmpIcTkyQU56Z0hsN0hBYVFUM2IyV3ZYb1dVT0NQ?=
 =?utf-8?B?N2NobXVwUXRGTkU5M1YxaFkvWXR2b0IvMmliNHJlR3RmWFROM1ZSZXBZcWtF?=
 =?utf-8?B?OXNqWGVreHhLZUphbDdpVk9WckpGaWx5MzBvcndFYWdxYVVONTBoVWhLRlE1?=
 =?utf-8?B?Slk4YkZMTklzT28zSGk3RWxOVTQ5aTZXTWtDd3JIVE5nUmZESnpaUllpRE55?=
 =?utf-8?B?TlJaWmx2bkZPcG5XUE5rUDdXbnlxRWp3SVF6a2ZTRGVsYkdnQTZRYlZjZVNk?=
 =?utf-8?B?SW4wRjVkcExzT29oOGUzcGJLSXF6cHF0cGZWTFRxcHBPSEVBS2hXQ2pxS1JH?=
 =?utf-8?B?T0NOL1dFK2QwUzVvajc4emtQRFQrVDhxeW1rL0xwRFNJRzI2S1hIVnBZRmNv?=
 =?utf-8?B?MWdMN0xBNmI0UlNWOFliLytTTDduZk4yZndZd0JlYWNFU3FzaEE4cTJWTklD?=
 =?utf-8?B?bGhlMnFiRGp4QlUwVnQrMkExbW5UMnp6ZTM1Z0ROUkZCOTVGcHdMS2V4Rkhr?=
 =?utf-8?B?WlVJR2x4V0NQOWJjWlJmVFo2TUNITHdGaXgxWVlNelhmckExWHJWWTFoa0Ry?=
 =?utf-8?B?ZmJYaThWTlFwSXpmbjRVUVdLVTB0bEJZeWlyOHJ1ZVg1SFhqTk1KL1ljT2la?=
 =?utf-8?B?NHB3dnVNWk9GMHgwSFVwaDZzRmVHZ3h4NnlFUGxOS0dSNXlZOU9GYjNFR2Ev?=
 =?utf-8?B?cDloa0lWV1YyeGpJVEJZTGdGMW4xOGFzbFF1RTV0bStDd0NvZXlhR1p3aDRw?=
 =?utf-8?B?RFVwK3krSmV4dEw2RFMyeXFYM1hManR1ZkIyU0JrakphVldsV3NCZ0FiaXJV?=
 =?utf-8?B?TTVYNGE0RXphVmJXcEtVNWNwUHJXWEFicWUybFptU1BXa2ZMa3dTWmQrZFpE?=
 =?utf-8?B?eUppRG8wSzBmMFhxUkR0bFliOHFQeTFBTkRzUWxJUE1OR29SbVdwaHJvQ0Ra?=
 =?utf-8?B?TTNuTE1lS1lrQk9ZclNnQ2RRSHBLMXl5VXBVZGF3VzBtMnlSaWFoUVl3MkU3?=
 =?utf-8?B?bmVZcjJLTVppVE9CZmY1cXl6Q3BBSDlyT0g4T1d2TFhvOGZ5eTJUZm5admNB?=
 =?utf-8?B?ZzBiT2lsS2ZtNHpYOVQzdk40VldQbFRPeE8wUmZFU0NyUFZXbXU0Zmw2KzBh?=
 =?utf-8?B?dGVDWi9pY0FtVWFyT0NOejVnNXU4MFlPVVdRTkd4WXZ6MmozMmt6c2N2dkFz?=
 =?utf-8?B?TytTUytlcVFDMUE5RzRRYlc2a3VQamYvZmtaaHZpNkNlenh1cytqZllWNlNw?=
 =?utf-8?B?RWNpWkxweExEdHpTdTJtWFlaeU1zaW1DOVczVEhDczU2eVBvVWhGY1ErWWRH?=
 =?utf-8?B?TG5aRWRtc0dYNEhBNlF4eE1vVGNKbkpKRm5Lc28xcG1SY1dCWldDdmU3STVF?=
 =?utf-8?B?eUQ4cGEvMEl4UVduRGt5d0V2alZWMERrMmRTRzN4Um9kREdHK004WkRrWElO?=
 =?utf-8?B?b3FPZ2FnMVlWUVJHMnlldlM4M2tEOUlsa2IxZzRtRGVmRjZ0OUNFMGkrcDQ5?=
 =?utf-8?B?c3lpZ1ZUMllFTE9jaExCK2p5bEUrVHZkMzBPRmZ2REpUaGdOVHYyQVVZbHIy?=
 =?utf-8?B?clZIWUZ6a1JBNDdmNUppSDVPRm5GV1RJcDRzS0tGYmdzekVzNmVENGc1UDZ5?=
 =?utf-8?B?dUVhcmdpd2Ixa29keldPSGxqMUVPaDEwMmpuMURCdXQwMkFreXJWWVYyaFQy?=
 =?utf-8?B?YWNtS0thanpTT3BnUCt2bS9TZVhZcWk0OHdqcFk1c1pQT0JpL0JoUmY5MzBN?=
 =?utf-8?B?S2FkWnJZQmtSN0trV2lqblhLQ2xSYWZYa2Nwc0dEcVpwSVRMMHl3Z3BET3VP?=
 =?utf-8?Q?/ddp/dcfrPiQTCRmXG0l4lD4X?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d6a1b7-d582-4cb8-a454-08db3a571b0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 06:36:39.2985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x+rI0NyO6sh+Msl/ZgGVeOBm8Isr2F7lajRtekMQjhJEzi0lzznmHovUDGyy1hLsTrCA32tIKr7qWcH91R6yTSj1hIJ0kZF5+pVT53b75i4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4341
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkuDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFzb24gV2FuZyA8
amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogVHVlc2RheSwgQXByaWwgMTEsIDIwMjMgMToy
NCBQTQ0KPiBUbzogQW5ndXMgQ2hlbiA8YW5ndXMuY2hlbkBqYWd1YXJtaWNyby5jb20+DQo+IENj
OiBtc3RAcmVkaGF0LmNvbTsgdmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SF0gdmlydGlvX3BjaTogV2FpdCBmb3IgbGVnYWN5IGRldmljZSB0byBiZSByZXNldA0KPiANCj4g
T24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgOTozOeKAr0FNIEFuZ3VzIENoZW4gPGFuZ3VzLmNoZW5A
amFndWFybWljcm8uY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IFdlIHJlYWQgdGhlIHN0YXR1cyBv
ZiBkZXZpY2UgYWZ0ZXIgcmVzZXQsDQo+ID4gSXQgaXMgbm90IGd1YXJhbnRlZWQgdGhhdCB0aGUg
ZGV2aWNlIGJlIHJlc2V0ZWQgc3VjY2Vzc2Z1bGx5Lg0KPiA+IFdlIGNhbiB1c2UgYSB3aGlsZSBs
b29wIHRvIG1ha2Ugc3VyZSB0aGF0LGxpa2UgdGhlIG1vZGVybiBkZXZpY2UgZGlkLg0KPiA+IFRo
ZSBzcGVjIGlzIG5vdCByZXF1ZXN0IGl0ICxidXQgaXQgd29yay4NCj4gDQo+IFRoZSBvbmx5IGNv
bmNlcm4gaXMgaWYgaXQncyB0b28gbGF0ZSB0byBkbyB0aGlzLg0KPiANCj4gQnR3LCBhbnkgcmVh
c29uIHlvdSB3YW50IHRvIGhhdmUgYSBsZWdhY3kgaGFyZHdhcmUgaW1wbGVtZW50YXRpb24uIEl0
DQo+IHdpbGwgYmUgdmVyeSB0cmlja3kgdG8gd29yayBjb3JyZWN0bHkuDQogIEVuLEkgZm91bmQg
dGhpcyBpbiB0aGUgcmVhbCBwcm9kdWN0aW9uIGVudmlyb25tZW50IHNvbWUgdGltZXMgYWJvdXQg
b25lIHllYXIgYWdvLg0KYW5kIEkgZml4IHRoaXMgb3V0IG9mIHRyZWUub3VyIHZpcnRpbyBjYXJk
IGhhZCBiZWVuIHNvbGQgYWJvdXQgdGhvdXNhbmRzIC4NCg0KICBOb3csd2UgY3JlYXRlZCBhIG5l
dyBjYXJkLCBpdCBzdXBwb3J0IHZpcnRpbyAwLjk1LDEuMCwxLjEgZXRjLg0KICBBbmQgd2UgdXNl
IHRoaXMgaG9zdCB2ZHBhKyBsZWdhY3kgdmlydGlvIGluIHZtIHRvIGhvdCBtaWdyYXRpb24sd2Ug
Zm91bmQgdGhhdCB0aGUNCiAgTGVnYWN5IG1vZGVsIG9mdGVuIGdldCB0aGUgbWlkZGxlIHN0YXRl
IHZhbHVlIGFmdGVyIHJlc2V0IGFuZCBwcm9iZSBhZ2Fpbi4NCiAgVGhlIFNvYyBpcyBTaW11bGF0
ZWQgYnkgZnBnYSB3aGljaCBpcyBydW4gc2xvd2VyIHRoYW4gdGhlIGhvc3Qsc28gdGhlIHNhbWUg
YnVnIA0KICBJcyBmb3VuZCBtb3JlIGZyZXF1ZW50bHkgd2hlbiB0aGUgaG9zdCB1c2UgdGhlIG90
aGVyIGtlcm5lbCBsaWtlIHVidW50dSBvciBjZW50b3M4Lg0KDQogIFNvIHdlIGhvcGUgd2UgY2Fu
IGZpeCB0aGlzIGJ5IHVwc3RyZWFtIC4NCj4gDQo+IFRoYW5rcw0KPiANCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEFuZ3VzIENoZW4gPGFuZ3VzLmNoZW5AamFndWFybWljcm8uY29tPg0KPiA+IC0t
LQ0KPiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jIHwgNCArKystDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jIGIvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3BjaV9sZWdhY3kuYw0KPiA+IGluZGV4IDIyNTdmMWIzZDhhZS4uZjJk
MjQxNTYzZTRmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVn
YWN5LmMNCj4gPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2xlZ2FjeS5jDQo+ID4g
QEAgLTE0LDYgKzE0LDcgQEANCj4gPiAgICogIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhh
dC5jb20+DQo+ID4gICAqLw0KPiA+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9kZWxheS5oPg0KPiA+
ICAjaW5jbHVkZSAibGludXgvdmlydGlvX3BjaV9sZWdhY3kuaCINCj4gPiAgI2luY2x1ZGUgInZp
cnRpb19wY2lfY29tbW9uLmgiDQo+ID4NCj4gPiBAQCAtOTcsNyArOTgsOCBAQCBzdGF0aWMgdm9p
ZCB2cF9yZXNldChzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikNCj4gPiAgICAgICAgIHZwX2xl
Z2FjeV9zZXRfc3RhdHVzKCZ2cF9kZXYtPmxkZXYsIDApOw0KPiA+ICAgICAgICAgLyogRmx1c2gg
b3V0IHRoZSBzdGF0dXMgd3JpdGUsIGFuZCBmbHVzaCBpbiBkZXZpY2Ugd3JpdGVzLA0KPiA+ICAg
ICAgICAgICogaW5jbHVkaW5nIE1TaS1YIGludGVycnVwdHMsIGlmIGFueS4gKi8NCj4gPiAtICAg
ICAgIHZwX2xlZ2FjeV9nZXRfc3RhdHVzKCZ2cF9kZXYtPmxkZXYpOw0KPiA+ICsgICAgICAgd2hp
bGUgKHZwX2xlZ2FjeV9nZXRfc3RhdHVzKCZ2cF9kZXYtPmxkZXYpKQ0KPiA+ICsgICAgICAgICAg
ICAgICBtc2xlZXAoMSk7DQo+ID4gICAgICAgICAvKiBGbHVzaCBwZW5kaW5nIFZRL2NvbmZpZ3Vy
YXRpb24gY2FsbGJhY2tzLiAqLw0KPiA+ICAgICAgICAgdnBfc3luY2hyb25pemVfdmVjdG9ycyh2
ZGV2KTsNCj4gPiAgfQ0KPiA+IC0tDQo+ID4gMi4yNS4xDQo+ID4NCg0K
