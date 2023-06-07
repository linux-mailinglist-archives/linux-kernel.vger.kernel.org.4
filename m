Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155E572521F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 04:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240762AbjFGCeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 22:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjFGCeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 22:34:18 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDE81732;
        Tue,  6 Jun 2023 19:34:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nA8qhwoKN05Nqkh7aqUN17WqzneZAMXkzth5uBAq9+5PWIePjzeGBZ2fNvGbcXHVkNHMqCEcP3zIERgodvgDmm/fE+z8Mz9Rlk0ZxWyNxwxUclt8tz0DJpfpkFhECcladddLUSvKK6m/pLfcWlkWhFWtAs4hu4wOp+AU+BZ8KjBr39USdiju9eSUZP2/cqMwmatBgYMJlfEOlqPRzqkxatEq7321I9cD9HQVHhII4ak7iQMIuVdQlrOJwqVCh7uOJ2RirZXsGe1EZYUduodehb+uKJqFe+0QLW72Ecp6pTGPhGXu7Fs0YSu4U62XdgnmkMmJf40KIEtHX4ZkOcionQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDAvHCyKqMROtXh2lb0480Nn3oFyI935lfHS+N9vzXE=;
 b=DoM66j/AM7fJsBYGdrF3xTXH+dLEcLqUesu1n8pUK1tA1aPXkzcSYyE6l6E0qGjC+2UK3HsWE0CLuX75LciAygI6/nF/ydUaAzCifQ7RxTJqY9jI7XOsZWyWUxxYNtalxF2wYsTsLyIYcFrMEgf7FK7QGmoePfQFJhFiB4EMilneBbcHtxaFHyYrXe6S7jyzCmbPPf83fVwFrtAO3+0xkCH9uTYS+jtpGz3ajvsaEwtezT65Osmlkhwox17HoymeDGpV9bmt1GrRyQOpwMaVf1Ed1NLFDasTz8+joGSkI75LkSV20xY1QYiuN9rOQm2N47ZGwLqXxk5X8EFsiwGiMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDAvHCyKqMROtXh2lb0480Nn3oFyI935lfHS+N9vzXE=;
 b=mAuJfMIVJUffpBg1PMmEKB+CIDvj+nUq8mmVCScmjMzD270M+PT8PkS6jjSbPWfUn7cNWwVhEXdQLXc/D6OOQBiy5qGrOCNEuBOVlmRF78ybWiEdB8bHxR63EaulIulGolWcOpLnUQa1mM5sKbmNyJdoqkdfny1Wk/cBxrXAWfIkuhilNY88dQ4LZNcp+ANDthtjXLu172YLEBQEvWRf2ywp3eul6wTh/hqGxJMgp+eSWY0K3c1SmfyxGw9GFeeowqDm0/mlIMg2GYBWOf/8Tk1LtEf3pYmRPWdNt1nK0cRqotEIKEZ2hQmGhPOvGBkB7fl77DkcY/JtO5fzcrrXHw==
Received: from DM4PR12MB5988.namprd12.prod.outlook.com (2603:10b6:8:6b::20) by
 BY5PR12MB5015.namprd12.prod.outlook.com (2603:10b6:a03:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 02:34:15 +0000
Received: from DM4PR12MB5988.namprd12.prod.outlook.com
 ([fe80::2388:c64f:4a08:c45b]) by DM4PR12MB5988.namprd12.prod.outlook.com
 ([fe80::2388:c64f:4a08:c45b%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 02:34:15 +0000
From:   Haotien Hsu <haotienh@nvidia.com>
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>
CC:     "kishon@kernel.org" <kishon@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        EJ Hsu <ejh@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Wayne Chang <waynec@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Jui Chang Kuo <jckuo@nvidia.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
Subject: Re: [PATCH v2] phy: tegra: xusb: Fix use-after-free issue
Thread-Topic: [PATCH v2] phy: tegra: xusb: Fix use-after-free issue
Thread-Index: AQHZgZRkKXYDv7i5b0KUq0xSyjnxwK9947UAgADqOwA=
Date:   Wed, 7 Jun 2023 02:34:15 +0000
Message-ID: <377c2bd5aa9d2363c2a9a0e63849207c12f47289.camel@nvidia.com>
References: <20230508100320.345673-1-haotienh@nvidia.com>
         <ZH8oKiteNGxYmw9l@orome>
In-Reply-To: <ZH8oKiteNGxYmw9l@orome>
Reply-To: Haotien Hsu <haotienh@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5988:EE_|BY5PR12MB5015:EE_
x-ms-office365-filtering-correlation-id: a05fd8d2-8fe7-4f87-6751-08db66ffafad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0hyxlOrLxce7vGhg7+SU0DGd3A00E67AJlWARGfjozctQJ1zBeiNi/bPjXUmNG4TqmWQf581F/D2sxjW/gI7Q/4vL9N9Qv0FwrnU4vBpW+EhcaC/FZaZ0ewnayxKAvoOKuX+EfUdeO2v0hLnQu9WgEEzBcgDOAGvpLV8Fn1mZ4utuSmNiuWn7zK/RATYQbUTF8ouZPuOv1ZftlhuOJY6748LF3SYQJ3Zy5IRPlwbVCdpeoGHvmgZXn+p9xpL5Omy4fEMEUXEYVT78ovzcwGdWwtFlc+6sEAIk8POCMxNk9NCCQ4G5crrYs51jg0vSoIRYv7eoDKhtnxW5+wwwrvNiqMQDNAi24ttXlFPWZ7HiPjIVGVM449IaKE9GWR16uUrnl/V1XRc18Qs9qN0q1tENnLoOZcqbPAbXgp3xz8Y4KtQW5AyO3hhs2KRQAX6F2/vAFSZHUKpdvFIxxxQaMppht847s3PxZvSz9LXtiNiZ41vKSp9xOialgucuebIOH9Nyk8ajn485FkhOiUyKZjZeK64Ljs+SKg0pEvIq2Iv6Wq1lh5c9oCMXu06AB9+XqKzWtVIExOAayjL593zhCjsmrYFYvbCjuE3ms0VtCVKFaEQNfhmYviL+b2xT6lLHvnw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5988.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(451199021)(36756003)(2906002)(54906003)(38070700005)(3450700001)(71200400001)(478600001)(86362001)(38100700002)(41300700001)(8936002)(8676002)(5660300002)(316002)(6916009)(66556008)(4326008)(64756008)(122000001)(66476007)(66946007)(76116006)(91956017)(66446008)(6506007)(2616005)(6512007)(26005)(186003)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Wi9GSUhaTTF0ZzJzTnZxZGhHSXlQeldIT2JDOGRUVHhZZFg2Kzk5MHBubWpv?=
 =?utf-8?B?YlNXWThkVlRKZm5KaEdTaFNNL3Y3RWNQeEtkUG5aSzhrK1JPTmJwSUVwVm9w?=
 =?utf-8?B?dDV3UnJDS0RvZjMyRUd5UHYzeHNUcnN6Yk5uZ1pNMHBvSjZvUzNRRFZrRWJO?=
 =?utf-8?B?Ly8zQ0tTVlpNS3RDMTluSWdRUjdwRG9CT0s1Qyt4RkRkVzFyQWR5NWhwajM4?=
 =?utf-8?B?TGc2S3lTY0ZSbU1GR1JRRDRjRlpubk05eXJ5L0lUZTdUdWcvcFdQdDlyc1RZ?=
 =?utf-8?B?VUcyTFVWMlYvUDVjcnNCUHZnMlhHY3l1NEh3eDNBTXZDaXJrS0xTbmRSbnp6?=
 =?utf-8?B?L0hrTXRLbVFSUmJkZkNKaVZpNW5FdXVDNjQrR2F6L0FxR1RPQXZXdU5YNXQ2?=
 =?utf-8?B?cDlaaFJQMmFMYmRwY1RVVmNtQ3NIdElTeEJvbmdWQkl3eU9BZWUwaEduYWxI?=
 =?utf-8?B?MWIxaGZtcHVlZVVxK3JqNy9oa3hxcGtGcDhWUlkzWG9KSnFWbG90Wk1jcTFq?=
 =?utf-8?B?M2tUTXVHcUIyMmh0Z0h4N29vUTFrMzdDZVI5Tk1jSVQvRGhPbE5SMFowQkpt?=
 =?utf-8?B?bmtiTTNqNFMzL3A0dVZTekJKQUlpUDJhdGk0WmN1MFdBbGRwOGVWUVJIdjZ1?=
 =?utf-8?B?a1hEQW03T0hYQWFCdmJNY2s3YVY5UVZGYm9wR0drb2ZXVTBXS1A0LzNMcFBP?=
 =?utf-8?B?bGJ2SDFWWloraTBRNENVYWZSTWJWeW5EN1MxcytEZ0o0Tmg0dy8xOHBLWFZq?=
 =?utf-8?B?WThBV2F2MmVLZjE1U1VVTmJCSnAwTkM1UjlNcExkcVhJWVFWTjJlU1VmR3Rp?=
 =?utf-8?B?RnlYcVZXN3hhNGdUS2t0dStlZ0VtVm1VNHozRFJHa1JGY3ppSUM3c201eUNu?=
 =?utf-8?B?QXhnNkMyWWRsakxyWmFvOFJNMzI5eU83S01mNU9mNkVVdkpRTmtRa2JUbGxR?=
 =?utf-8?B?VHZqbXVrU3VPdzZBaHRYTDUza0lpSEFVT3BHek9pR1hGbjN2L3ZnMGxVQ09Z?=
 =?utf-8?B?RE9aalR1cWpVd2VJalJsTGcxamM1V04vWkI3U21tclN5Q0V5QkpqZzJIT21w?=
 =?utf-8?B?NUY4VzR1RWRuQTB1d01WSFVoMmRMaml2Q1ZoUnpWS01rTiswMXBKUWJZd2dv?=
 =?utf-8?B?Y3NWS1pKOU1zRXd3dzN4K1ByUEtRN3ZqenFmU0FHNXJ2OVVzM0orUk9kdHl0?=
 =?utf-8?B?RGNxQkY3RUpVU3dVR1NNYmt5elB1ZXFBVXArY294c3g1ZVp3Z1dOeG1yOEEw?=
 =?utf-8?B?aFNzcVVCbVpIWkkyWEV3cGhsZ1RYV0NpTGMzZC94M05YR0VlS0FLMGwvY0Iy?=
 =?utf-8?B?aDZNNTg3d054dG5TTTBBMm1Ka1RIVStXdkVoczZ1cVg0dlB2T3VqY0tnT29T?=
 =?utf-8?B?d0NJSmdUU042RW42Zi9PcGJzQXpPQTNhWndZTWNHWFB1RHRTV3cyQW1Ec2E1?=
 =?utf-8?B?QTA4L1lsNHUvQjdLbWNBQ0FkVEV6eTdQRUtlcWQwZUUzQUFmM0FoNE8wWFdN?=
 =?utf-8?B?TWdWSmtFTlBaTU5mL3o3L0N0cjlrckYwZEJUemNZVG1NZGtaZXBSNUFMOW85?=
 =?utf-8?B?NEZGZTU2NWUrOTRhblR5U0FmWGNPaU8vc0VLU1l4MVJMeWpoSkcvN29yVzlw?=
 =?utf-8?B?VTFMMFNyZHFja3dOSHBJVUhGSnhQMGdGUldmZ2s0eEQzTmo3bHB6VEN6Wnlw?=
 =?utf-8?B?ZDRZamwvSUliM1MzbjZwUU1sU3ZKenZCLzZpNS92K2VWWXZpb1NVbjNDdE5E?=
 =?utf-8?B?UE5ITStwZC9Gczdud1NBa1d0aXloNFAvUVovczNYR3h3SnBHRm9KTm5YTkxW?=
 =?utf-8?B?TTNUTWFsbDVER0tWNHBWdXc0b29oZkpIQk5HZUxNbHlXbVk1TjdtMlVUcVZz?=
 =?utf-8?B?T3RFdU50dUJubGZOUXlaOVUxTk50Skd3UzdUeTZyb293WG8wSUlYYjQrdVlH?=
 =?utf-8?B?UDNCYWsyZk12d054V1dOb0cva291ZXM3akIxZURUdGtOSlQ3N3p5eHNJa3I4?=
 =?utf-8?B?YnVEMG1TWUE3TnNZM0Q1T0oyRzZ2MUNyK1JBUkZBREhBWG0venVMczVaNHlz?=
 =?utf-8?B?Yld1U3JEc1hZM0ZYQ01EaVBIcGtFTmpwMW9oZVNBQzNEMDR6WTZQdCtja3hL?=
 =?utf-8?Q?w1iDEv3Ekjr6PCdA5RVWTGkLy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <797C94DD92476545AF447FA94F5C4EBA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5988.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a05fd8d2-8fe7-4f87-6751-08db66ffafad
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 02:34:15.2676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UJ9sOaFl1IXVHw6KyjJv3PEIwNOJLnrmGnxCFabH/65a7WFVG8lDiV4l4iIYrOK+CASdUzHw16Yt4smXugZIQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5015
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA2LTA2IGF0IDE0OjM1ICswMjAwLCBUaGllcnJ5IFJlZGluZyB3cm90ZToN
Cj4gT24gTW9uLCBNYXkgMDgsIDIwMjMgYXQgMDY6MDM6MjBQTSArMDgwMCwgSGFvdGllbiBIc3Ug
d3JvdGU6DQo+ID4gRnJvbTogRUogSHN1IDxlamhAbnZpZGlhLmNvbT4NCj4gPiANCj4gPiBGb3Ig
dGhlIGR1YWwtcm9sZSBwb3J0LCBpdCB3aWxsIGFzc2lnbiB0aGUgcGh5IGRldiB0byB1c2ItcGh5
IGRldg0KPiA+IGFuZA0KPiA+IHVzZSB0aGUgcG9ydCBkZXYgZHJpdmVyIGFzIHRoZSBkZXYgZHJp
dmVyIG9mIHVzYi1waHkuDQo+ID4gDQo+ID4gV2hlbiB3ZSB0cnkgdG8gZGVzdHJveSB0aGUgcG9y
dCBkZXYsIGl0IHdpbGwgZGVzdHJveSBpdHMgZGV2IGRyaXZlcg0KPiA+IGFzIHdlbGwuIEJ1dCB3
ZSBkaWQgbm90IHJlbW92ZSB0aGUgcmVmZXJlbmNlIGZyb20gdXNiLXBoeSBkZXYuIFRoaXMNCj4g
PiBtaWdodCBjYXVzZSB0aGUgdXNlLWFmdGVyLWZyZWUgaXNzdWUgaW4gS0FTQU4uDQo+ID4gDQo+
ID4gRml4ZXM6IGU4ZjdkMmY0MDlhMSAoInBoeTogdGVncmE6IHh1c2I6IEFkZCB1c2ItcGh5IHN1
cHBvcnQiKQ0KPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogRUogSHN1IDxlamhAbnZpZGlhLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIYW90
aWVuIEhzdSA8aGFvdGllbmhAbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4gPiBWMSAtPiBWMjogUmVt
b3ZlIGV4dHJhIG1vdmVtZW50cyB0byBjbGFyaWZ5IHRoZSBjaGFuZ2UNCj4gPiAtLS0NCj4gPiAg
ZHJpdmVycy9waHkvdGVncmEveHVzYi5jIHwgMSArDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQ0KPiANCj4gSGFvdGllbiwNCj4gDQo+IEkgaGFkIGFscmVhZHkgZ2l2ZW4gYW4g
QWNrZWQtYnkgb24gdjEuIFR5cGljYWxseSB5b3Ugc2hvdWxkIGFkZCBzdWNoDQo+IHRhZ3Mgd2hl
biB5b3UgcG9zdCBuZXcgdmVyc2lvbnMgc28gdGhhdCBwZW9wbGUgZG9uJ3QgaGF2ZSB0byByZXBl
YXQNCj4gdGhlbS4gQW55d2F5LCBoZXJlIGl0IGlzIGFnYWluOg0KPiANCj4gQWNrZWQtYnk6IFRo
aWVycnkgUmVkaW5nIDx0cmVkaW5nQG52aWRpYS5jb20+DQoNCkhpIFRoaWVycnksDQoNCkkgc2Vl
Lg0KTXkgbWlzdGFrZS4NCg==
