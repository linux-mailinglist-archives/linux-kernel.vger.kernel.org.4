Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506C6719A73
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbjFALCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbjFALBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:01:44 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B2E128;
        Thu,  1 Jun 2023 04:01:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bayxSJTlnE604mXtn51MapUBlv7SmvxUUoz8TMZOmnOLryYcMtYfxFn5OTXvJqQUlSfw/R8vTMuSO58VLa7ZHLdfuaJ04Z7aH4KgFtYQZSQSFQV60J0beMF3RZU9o1zJw7fBjJie0b4UeTbSogjjRTN/SzWu4cLA//GiizzRrNlzYwX5hfqrt/un/q4nKmMloG5oytk9t/JzH72kajP/tN/rKLkx3oiXMizuecRSfIBpIgBLyIzeMWQ5gfE1HMGd27TmvhkXptYbYTa6kGWTAMIBQBVMffLluZZ0utXLUQdrGvLoZ7WEoi6BupNPtLOtcdvdaj5YdZDkqphWn6kfuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Q2PtWE7cqpL1/tHHT8h+6n6I/sHzBmw/rTopN7DgFc=;
 b=PqAmiJs5iFItkEiWXzBDn7XFhnu1V8yGkZqUbRxh84BbMEuEY5xYn1MS1x5bo1iHq8mkrCnla0hz58qHdsRV9rz9gTdm58yKpl4I31CnntP3ku8eiWzDl1iPR0W1+vMxWrbnpX7tsA2NJmqp8N0JBxyH4BWcVK+GzBy+RudOe5NjIXtdXqgdaWGrahNDWBuyFsdj6c9VLHx9rejLTecyYC1usw5DIEQA1f7GIY8TWiRIPqszPUAa5cyBssDDgENUl2EwreErcjHOtsiGNEc7bDVOensX1572QwGbXfaxCimvbTRNAqac5gnnS7VqQRb2IE/2x5uj9E/H1O+orpY/PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Q2PtWE7cqpL1/tHHT8h+6n6I/sHzBmw/rTopN7DgFc=;
 b=Vswon7wZhjGoUUmeU5dNVSseBumlBgFJn3z1jLfouB+jus82t6cs3KtZ/RYOJofm32sl0bIG/DGxfLljbBdp9v8LiJXAG8/WyWkLNVZvKtLozRoCtRAryMtpof8pHI9vwyAm8LxiqAgSaKgVcBEx6u6yQ2iJ447RRBs5Jss6MoUWdkIRt1Ke/izjFgdzQky9aQxgggXVhzOZoy/R2ET1X2RWR7UkZLuYzkNBcVUR5yI2oT70LHyS8uZ/Fb4HKmWpHwqOy9H5T1kgZNd6O0UO80oIVDMQ+t8JE9zU8RGB7Ao7uqVZ5J+TAKku0XKV1jNXxlZnJcHekC2Iv6YktyOQhQ==
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by SA1PR10MB5733.namprd10.prod.outlook.com (2603:10b6:806:231::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 11:01:40 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::f01a:585:8d6:3d3c]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::f01a:585:8d6:3d3c%6]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 11:01:39 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "perex@perex.cz" <perex@perex.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] ALSA: usb-audio: Logitech P710e: Add quirk to fix setting
 sample rate.
Thread-Topic: [PATCH] ALSA: usb-audio: Logitech P710e: Add quirk to fix
 setting sample rate.
Thread-Index: AQHZk76tOTrERb/qZ064LfUyAGXe4691wx+AgAAGQwA=
Date:   Thu, 1 Jun 2023 11:01:39 +0000
Message-ID: <4c0d3476f554530e61a7c41580997e021056cce9.camel@infinera.com>
References: <20230531125148.892100-1-joakim.tjernlund@infinera.com>
         <bef94a3bbcb933e0c9128b602a973b7996ba337e.camel@infinera.com>
In-Reply-To: <bef94a3bbcb933e0c9128b602a973b7996ba337e.camel@infinera.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB4615:EE_|SA1PR10MB5733:EE_
x-ms-office365-filtering-correlation-id: 74954b38-a82e-4cf3-f042-08db628f9379
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pexXtAFGsE2twvcuunEYmjbneR2unR56xcKha8P9iazAVUag+iVpR8nJRnGWB72f8r0Zs4hOKBifagqL9QU14IsZ8UxHOilWAcUk4niJ3rCgZ50SFWMmNMvT5T18Uviy2vIzWcjN14iU9Jnfe2APW03L4b/x4iP/n7Z+TCsPabeJl35cxx2q7qLkhutmQGvkAA6Zybkkl+V5xoCKOjFZNnoGQKruPBWyXAORX279o28ycLCSij+HXrP1ddFPu3xrnTBmbDqvQ0PglB5ZrsolY2oV0NsCvUujmhTZ+S5l0SayIBzARfsB2U6C5gZaJhVSikw3cVKHpEBtryRu9FneE6iur13GJjflFZYrgZ0c5LOU2A/fSRncxejdpiDDhxRWjZdcuCNKbuebTr+Lg12G1BYKRBPW0vO8ozZaArJXu9pBzPTYx1at3TY4aATt8XnyoMvQDB01DYFJksDF/CeRrKojRMbm7n1BDz4MMhPg8iyD/hZNmYgZXyQUpLRQ2JOrxJn0ntJAL02CoesO2NXmJWXT1g7LQczbSyPfCigA9+CLTBMcTKAbr8aJ2Z+Fn8EDYRIgyHBI/pTtlTmlDxtISHomTmlqsqWTit1wvbpD6xnXBYE+clhn1ZcUKh3CVhLu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(451199021)(86362001)(36756003)(122000001)(38100700002)(38070700005)(71200400001)(478600001)(110136005)(64756008)(6486002)(8936002)(5660300002)(66446008)(2906002)(91956017)(66476007)(66946007)(66556008)(316002)(76116006)(41300700001)(8676002)(4326008)(6506007)(2616005)(186003)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TG1ESHlqa0h3QmZpazU3V3lWNURLNWpSdDBmeFpGd3hHakNHSGs4NGxzNWI3?=
 =?utf-8?B?VHlUNCsrZmJ4UXpzOFc4b0lHSVYzUU9KQ2l3NG0vbDN4KzNtYnpJMVE5Q0Rl?=
 =?utf-8?B?WEtFRHovYTJaYmt5a0w3S0tadDhndTdZdlRtODAwUkJ1bXp0dk50UXU1dXh1?=
 =?utf-8?B?N1NJVU5Za3d6dVc1NmIyYWVYN0tOL2w3czNsclNDWDFGTkdvL2J1Tkg0dmdl?=
 =?utf-8?B?eVVPM3BFeHRpbEF2YTJpWWNrN3pYK21xUFZUTjk1TnJMWmZDNUNyVTIxalNH?=
 =?utf-8?B?cG5PeHFPbVErVWQ5TW5Sa1JyS0JLYTRGNFFOSFhwNWNSQjhGZW03RzlZbmNI?=
 =?utf-8?B?OUFwUW1Xby9vV1VySnpmSG5RZDl5bVdoRk83aGp3UUtHL3JwMWxaUHVnNlhX?=
 =?utf-8?B?aHoxb2c3U3VmMXIwUWhjMHNzMjM3R08rZ0pOTEtxcnlLbG1PdDRXSE9QZUxm?=
 =?utf-8?B?eFJaUGd2eVRCdk1wV1pEdG92NlhtaXpBZ0JBT3pkdTFlOUlpc3lxZXZWblRK?=
 =?utf-8?B?U2x4cG1QUmUxbVZNZ3c3aDFtbC9HUkY4eitxTjBuM1pLdnFpUTJLdldGVXc2?=
 =?utf-8?B?UWFpQmZzejlvaFRoWE1pRklNZThSeld5d3Nmb1R5ejRQSDJCWE1uTDRIcW8v?=
 =?utf-8?B?azZTcHkrZnhSM2c5dndZcHdKSGVDaWxOd2poZkFrOVQxdHdNMERPR2FqMXJN?=
 =?utf-8?B?TGZUUFlaK1pNc2dGc1N5cnpWWm81T0lwM3JqTkpkQnQ1YUhYbUEyWkUrcGtN?=
 =?utf-8?B?Tkk2emFHQzhLK01sV215VE1QRkxuVXNvODdFeXZFUVdxUmI2SkdLUDNlZDhm?=
 =?utf-8?B?VjhiT0hwTGNwZTZ2RzIveE5Id0NVMENSclhRVkRuUnhjSkRqR1BOQzdMWkcw?=
 =?utf-8?B?OXEyRVFJWGdQRHNsRUdNWlZlTlZ2Y0J1TUpNT0dnTmc4SWtPbmxvK1ZxdCtz?=
 =?utf-8?B?THpBTHBXb3R0b0JKS2hMUlVuMmd6dzVtU1piVnhyTU5mT0NxbU5OOEU2dkt3?=
 =?utf-8?B?ZlZmc3c2U0x1SktxL1gwei8wM0tjL3RiVGRJdHhRR0NmV3VTZjVBQ2o4L09q?=
 =?utf-8?B?clBETHcyQ09aUWlPbHZGMnJVNjQ3ckVPLytDM21zMm9hd044aE4xY2lLN2No?=
 =?utf-8?B?d3dCTDRObkpHV3k5ZEFhakM4b1ZOeXJWU0Iva0JmMVU3eE1tazFoS1hDS1VZ?=
 =?utf-8?B?OEZzVjZlMkc1ZzRpbXgyZXhweEtSTkRUb3B3UytnTldtbjBoNEExbW9IY3Y5?=
 =?utf-8?B?Sm9QeXVOd2pMRnpjV2E5b1hJakFLOW5naGxkVUY5T29kRk1TKzROWW9OQm1R?=
 =?utf-8?B?V0R6Ukp1NFBQVHhSeG44ay9vMVV1SHY5Tm05RS9Vc2hoMVNXYnRBTkw1M24z?=
 =?utf-8?B?S3Y3bFpIQUl4UUFTU0Z2Szh1bVRCZjdwTU83dFFpZjRmTjZaa09LdU5aSU81?=
 =?utf-8?B?dnU0L2p4aWhPeUUvNzVFd2hhbXhvU1h6Wlpya29mY09DWFFsOEptVm9aVlBT?=
 =?utf-8?B?N3pSK1IxeFJiOWllbEtaVnUxbm56UFFybFhlMExPNDRuK1o1VUV3dS9JbTJY?=
 =?utf-8?B?dUNjVWRMQXZrdkVPekw5L3k5WkN0cVUwQkE3aHhnY3kyZ1FnUnYrR0x2aGUr?=
 =?utf-8?B?VEVGU2dpSmdwbTN3V2dzdzBIWTczNFM4TUI0VVVGeG9ZWExYbE4wSlZ4MWdL?=
 =?utf-8?B?Q3k0RHc4dkpRZEh1ZHkrRHQ3bGYvZDg1WVdyV2ovZllJb1JSOXc1cldjeEZv?=
 =?utf-8?B?L0M0TFVhM3lBK2FFUW9FSldFK0dRNXNlbXI1ajZ5STZLL0ZJdlNGM1hJSllD?=
 =?utf-8?B?TitDUTd6UW91MnJyRVB2dHI3cTJhMVA0YXY5aVNTMnlkY3oyOWl4S0t3QjUx?=
 =?utf-8?B?dGdscG5xZGMvRXQ4TWJERTJhQVBFZ3J6TmFiK0Jja2tyb3lvNmVicEJ0dzg5?=
 =?utf-8?B?NVBYdmlHMUJyS205MFUzQWhSOVdUemlaNWhyTHhRd2VXR1llT05OLy9RZHFv?=
 =?utf-8?B?T2R4NE80MWZTRlh1RnVLWERWZnRUbkszdGZtYTRnTjY0ZjY4UlRiUDl6Z3Ay?=
 =?utf-8?B?WUwwbXpZQ0xMZkdXVXc0aFpYZExUZU5lMHRsemRMREw2cUloYnY5S0lxM0Ey?=
 =?utf-8?B?M0JmYzdRZGdCcmJudE4ySGpqUkYxMlZPSHpYZjQvdlEvREVLcDFBeTBaVFIr?=
 =?utf-8?Q?W41QzME3yTtSinqGt7jgwBBHRtwRlJIfR0zIbgnGDlez?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F037939D4339B438BA323C711386532@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4615.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74954b38-a82e-4cf3-f042-08db628f9379
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 11:01:39.6602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X6Z1jaIgEDBhsv9QkqzG2+qy5UbEurZtLdufvUXGUe262k3zXtXPOFkDot3q+/eGD0O4BHy6YKSgYkJ0j0jgbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5733
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA2LTAxIGF0IDEyOjM5ICswMjAwLCBKb2FraW0gVGplcm5sdW5kIHdyb3Rl
Og0KPiBPbiBXZWQsIDIwMjMtMDUtMzEgYXQgMTQ6NTEgKzAyMDAsIEpvYWtpbSBUamVybmx1bmQg
d3JvdGU6DQo+ID4gUDcxMGUsIHdpbGwgdGhyb3cgYW4gImNhbm5vdCBzZXQgZnJlcSA0ODAwMCB0
byBlcCAweDMiIGVycm9yLCBubw0KPiA+IG1hdHRlciBhZGRpbmcgbWRlbGF5cyBhcm91bmQgc2V0
dGluZyBzYW1wbGUgcmF0ZS4NCj4gDQo+IFBsZWFzZSBpZ25vcmUgdGhpcyBwYXRjaCwgdGhlICJj
YW5ub3Qgc2V0IGZyZXEgNDgwMDAgdG8gZXAgMHgzIiBvbmx5IGhhcHBlbnMgd2hlbg0KPiBrZXJu
ZWwoNi4xLjMxKSBpbml0aWFsbHkgcHJvYmVzIHRoZSBkZXZpY2U6DQo+IA0KPiBbICA1NTUuMjAw
MTY2XSB1c2IgMy0xOiBVU0IgZGlzY29ubmVjdCwgZGV2aWNlIG51bWJlciAxNA0KPiBbICA1NjAu
OTA2NTUzXSB1c2IgMy0xOiBuZXcgZnVsbC1zcGVlZCBVU0IgZGV2aWNlIG51bWJlciAxNSB1c2lu
ZyB4aGNpX2hjZA0KPiBbICA1NjEuMTA0MzQwXSB1c2IgMy0xOiAyOjE6IGNhbm5vdCBzZXQgZnJl
cSA0ODAwMCB0byBlcCAweDMNCj4gWyAgNTY2LjM0MjQyMF0gdXNiIDMtMTogMjoxOiBjYW5ub3Qg
Z2V0IGZyZXEgYXQgZXAgMHgzDQo+IFsgIDU2Ni40OTcwNTZdIGlucHV0OiBMb2dpdGVjaCBTcGVh
a2VycGhvbmUgUDcxMGUgQ29uc3VtZXIgQ29udHJvbCBhcyAvZGV2aWNlcy9wY2kwMDAwOjAwLzAw
MDA6MDA6MTQuMC91c2IzLzMtMS8zLTE6MS4zLzAwMDM6MDQ2RDowQTRFLjAwMDgvaW5wdXQvaW5w
dXQyOQ0KPiBbICA1NjYuNTQ4ODI4XSBpbnB1dDogTG9naXRlY2ggU3BlYWtlcnBob25lIFA3MTBl
IGFzIC9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxNC4wL3VzYjMvMy0xLzMtMToxLjMvMDAw
MzowNDZEOjBBNEUuMDAwOC9pbnB1dC9pbnB1dDMwDQo+IFsgIDU2Ni41NDkwODZdIGhpZC1nZW5l
cmljIDAwMDM6MDQ2RDowQTRFLjAwMDg6IGlucHV0LGhpZGRldjk3LGhpZHJhdzU6IFVTQiBISUQg
djEuMTEgRGV2aWNlIFtMb2dpdGVjaCBTcGVha2VycGhvbmUgUDcxMGVdIG9uIHVzYi0wMDAwOjAw
OjE0LjAtMS9pbnB1dDMNCj4gDQo+IEkgaGF2ZSBhIEphYnJhIFNQRUFLIDUxMCB3aGljaCBiZWhh
dmVzIHRoZSBzYW1lLg0KPiBPbmNlIGF0dGFjaGVkIHNldHRpbmcgc2FtcGxlIHJhdGUgd29ya3Mu
DQo+ICANCj4gU2VlbXMgbGlrZSB0aGUgZGV2aWNlcyBhcmUgbm90IHJlYWR5IHRvIGhhbmRsZSBz
YW1wbGUgcmF0ZQ0KPiB0aGlzIGVhcmx5IHdoZW4gZGV2aWNlIGlzIGJlZWluZyBhdHRhY2hlZC4g
RG9lcyB0aGUga2VybmVsIG5lZWQgdG8gbWFuYWdlDQo+IHNhbXBsZSByYXRlIGJlZm9yZSBkZXZp
Y2UgaXMgZnVsbHkgYXR0YWNoZWQ/DQoNClRoaXMgc3dhcCBhcHBlYXJzIHRvIG1ha2UgdGhlIGlu
aXRpYWwgZXJyb3IgZ28gYXdheToNCmRpZmYgLXUgc3RyZWFtLmMub3JnIHN0cmVhbS5jDQotLS0g
c3RyZWFtLmMub3JnCTIwMjMtMDYtMDEgMTI6NTQ6NDEuMjI5MTQ1OTg5ICswMjAwDQorKysgc3Ry
ZWFtLmMJMjAyMy0wNi0wMSAxMjo1Nzo0Ni40Mjc1MTQ2MzggKzAyMDANCkBAIC0xMjI2LDggKzEy
MjYsOCBAQA0KIAkJLyogdHJ5IHRvIHNldCB0aGUgaW50ZXJmYWNlLi4uICovDQogCQl1c2Jfc2V0
X2ludGVyZmFjZShjaGlwLT5kZXYsIGlmYWNlX25vLCAwKTsNCiAJCXNuZF91c2JfaW5pdF9waXRj
aChjaGlwLCBmcCk7DQotCQlzbmRfdXNiX2luaXRfc2FtcGxlX3JhdGUoY2hpcCwgZnAsIGZwLT5y
YXRlX21heCk7DQogCQl1c2Jfc2V0X2ludGVyZmFjZShjaGlwLT5kZXYsIGlmYWNlX25vLCBhbHRu
byk7DQorCQlzbmRfdXNiX2luaXRfc2FtcGxlX3JhdGUoY2hpcCwgZnAsIGZwLT5yYXRlX21heCk7
DQogCX0NCiAJcmV0dXJuIDA7DQogfQ0KDQpCdXQgSSBkb24ndCByZWFsbHkgbm93IHdoYXQgSSBh
bSBkb2luZyB3LnIudCBVU0IvQXVkaW8gDQoNCiBKb2NrZQ0KDQo=
