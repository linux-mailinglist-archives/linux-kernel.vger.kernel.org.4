Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9550C6A1F25
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjBXP7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBXP7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:59:40 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326926CF24;
        Fri, 24 Feb 2023 07:59:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVYYmc5jUQTwY8xyBs0FzuItM5WT9xw60WIyo81BQAFFHgFRJQUe14zZZfhFx/aCj+/BVMNm8fZEqUHwMLdlHUr79vhy2WBd4OZsvtIj/KnHNoeHF8eaGfo7ZzAkkxEVUCsAs3XhaeCORpUBL7/zLRYOHj9hTQqyG2+bNZpAmlAjyYqdzlq9PZJ+UKsCNoNfcTTqDyIYxWLoWPxLhDNHzTK7cnijQvFFa/F6fglw++vBTQhEK2FI04sj5K2IPYHf6ryl7om9ln4JLiWOJPupwjdxeFhrnmBiz4bh8WbMmFCp9P/UQCLGxs/JW1n0o0HlJldra2kFJ7lEZA7mQ681JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9nKTIQI1XbA0mMxvL2sPQPfgF1pKAwHa1LU/3y2Bi4=;
 b=Pcc7CV2Chwxe1S0kksTKrtsNWGHuGTYn8SKvPKzHZ06g5qsx93YEvweuzfCjxyzvi3T7yAYku3oID2uch3HMOeSHvzCC46/7HyK7OX8ZFf5NAAsoMZrDZsbMgAExHdAHlAtqQ7lbQD6Lg/c9fC8itjAj6OgmdPeACysc32RxR3qN/ge3+1+4bSOxfBOKS9vjihKCRlm9ZUJc9OoWqOC6dWlP75ORCIblRM0RkjKPq+BDydz9ljTKgMiL6ZyegSGwoX6gNCNUfHLi/RD1Zs7IXbRp+9gbkcIx8sSM2tX3X2Dotvyao/uyZw3MmwVIGih3Vjt/tKpmz4Ej50tacPrKqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9nKTIQI1XbA0mMxvL2sPQPfgF1pKAwHa1LU/3y2Bi4=;
 b=SeKtVyeZNS0YvBzlHqS/zoyTNv6v+Z+mvBQCQii9L/oogFPxq7lVQ7BQGrkIOSdhq0SK7ylReOe+7mgQV3be/g7fHKfVIRZ/kEAxBgj2ZhZDdH/+unxJmpR28DbG8UQ7+q4HqKcPQZeu7iPraV+Fv1+6IzeIlGhv/WMM6pJyRUeW7L/qwzcZltV2n6gc+RSAIzay2wAlDoC/Q9VQTcw+U5EFPKJHiYvbLEkwDm8pdKXGqc6etyNOreBOq7u5W/k13SH6Vwb617IuRzrUpex1/G/SxaR32VheOxYJ5rf1W2Mm58xc74GwOJdrCWzFjeDpp1AScpWuVyFMjweg0Ult7w==
Received: from CH2PR12MB3895.namprd12.prod.outlook.com (2603:10b6:610:2a::13)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Fri, 24 Feb
 2023 15:59:33 +0000
Received: from CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::5f35:2f2d:94a4:f7c3]) by CH2PR12MB3895.namprd12.prod.outlook.com
 ([fe80::5f35:2f2d:94a4:f7c3%4]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 15:59:33 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v4 1/2] gpio: gpio-mlxbf3: Add gpio driver support
Thread-Topic: [PATCH v4 1/2] gpio: gpio-mlxbf3: Add gpio driver support
Thread-Index: AQHZQxaSlkLDlqQj4USzupFOvdT5/67TwvwAgAeH+DCAARyQgIAAhNPAgAAP7gCAAC3a0IAAuciAgABPpICAAAsLgIAADIHQ
Date:   Fri, 24 Feb 2023 15:59:32 +0000
Message-ID: <CH2PR12MB389570356FFCCE60DE13AB4FD7A89@CH2PR12MB3895.namprd12.prod.outlook.com>
References: <cover.1676042188.git.asmaa@nvidia.com>
 <cover.1676668853.git.asmaa@nvidia.com>
 <28f0d670407c127614b64d9c382b11c795f5077d.1676668853.git.asmaa@nvidia.com>
 <CAHp75VdeVpjzg5Y_4Y+Ke9=3wog28vUBN4Fd8zxfa8dWGrqUUA@mail.gmail.com>
 <CH2PR12MB3895520749883D912E5021F1D7AA9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CAHp75Vc+iSt2XvpOYzwZnzX7Qg013e-E27CPjPaO-QmtferWVg@mail.gmail.com>
 <CH2PR12MB389509F68E6AFE776C5B0AC6D7AB9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CAHp75VdoUDMvVk1uMQcAKQteL6gbYGpoKpFn96ysdS81LjPGCQ@mail.gmail.com>
 <CH2PR12MB389530C5929100CB54396CF5D7AB9@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CAHp75VfZ1r_sNus_qMYumja3YrJawA6hRHUbi-uPFUprorQ_Kw@mail.gmail.com>
 <CH2PR12MB3895124032E3276B54570676D7A89@CH2PR12MB3895.namprd12.prod.outlook.com>
 <CAHp75Vc8=_bfuLrpygCFnDcAZMyGMQXN7xEiZv=Yn3u3NzRpjQ@mail.gmail.com>
In-Reply-To: <CAHp75Vc8=_bfuLrpygCFnDcAZMyGMQXN7xEiZv=Yn3u3NzRpjQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB3895:EE_|BL1PR12MB5755:EE_
x-ms-office365-filtering-correlation-id: 131f7624-bc7e-49b2-b54b-08db16801ea8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l4tozmI+6ZEVGqDTSGA4SGFJjTx7GXf2/j4dl9DiYIqU1kDc0mCgVJlP96OVpUWE8F4n0voFdfE8v1X4lx5HPeEkxIdz80CwlhnGOdvaR6kwByHh4PSUxqYsKOJSLXPTcBIcXQoB9cGHrx5v2QfiN2vqwwEP4uCZI96MTnjMBI6xoUs2ZzVtRymMiwSbY2kLEBx1eAml5fxQvY2DUUc21VZQIj2ZlYdnPo5W/v5cOjODGg9TF3hDXOQwgRdukSHYi9J3MkADujj9l3Bo4hzXCyDEJJrUHbcwWr/LkdDlKV8yku7IS5gc8H+wBqGlM8AOFeIw89AdTnyfYRBDRnjpYsSckTYaaBC+Qhpd8d8p11xrrtPKpczRFVtB3kClY7MtRVtUKc+3RnX5HOtjCJxSvZnmPFQxlcHfCU1oaTIZkQ+ZDX7jc/YDcoXaBLHy3dGZ4faE9++1HttqcYvUmSxR93uxkqKnGeqvg+KAk1a/aIdFFOU3Q7laxd06YydLkCvXdXidnr8A6S4OCvqpPACq2ZTKXAWaNlLn7JYlHjLFmHJy7VbG445b3/RDfWmVTGf+cqVED1D8r+6gcRKoKGmq6Z0x+IsirGRIIhRNwacqzv0UH6MhlwH+tuWoVyr5xNcOsE9pPW/tk7sJF2UnhHSsuPD4B2kNaULwRxUZDWepEZGwSmxVvWuf2GrVfF7X24Us4Kpo4YhdNwq+851lI9vblA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3895.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199018)(2906002)(66446008)(33656002)(64756008)(66556008)(122000001)(316002)(66476007)(71200400001)(7696005)(41300700001)(6506007)(66946007)(76116006)(5660300002)(9686003)(55016003)(478600001)(6916009)(4744005)(38070700005)(186003)(4326008)(8676002)(8936002)(54906003)(86362001)(38100700002)(26005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTdmTDJWeVM0am1jS1lsNVZTZkV0MysweVZreTlqZ1lPT0I4WSsvQ1d4aHRk?=
 =?utf-8?B?TVJmTHdaOHljR2E5dDVHVEdmTHNuOTEyQkV1RWhCbGdsTnZua2o0WEF1SGlr?=
 =?utf-8?B?K0dROWtxcGo0Q2hPNHFqS01ncitmd3l1MWNTaE92dDF1cENHdUhmT2hRMG13?=
 =?utf-8?B?dEZWOGtLSTJHQXRkZWVlajE0T1BkZ3FUdnlyMGlrVEI3UVRSUFRTRmt4aDNM?=
 =?utf-8?B?L0VDRlZwblpkZmFKMUYweFptczNWb21POUl0TWNtdGIyblJHMzRZWWhvZEc1?=
 =?utf-8?B?dkRQbDBmTWd1blZSWno2bkEyY2NldlhWQlRJYXA3SDE5Ty9HKzhhMVdNWEdN?=
 =?utf-8?B?ZU9GSHQ4OVZNSGR1aVhVQ0lKczEzbHJ6TjlkUE9vLy82bjc5Q01UNEk3S1pL?=
 =?utf-8?B?Y1owTE9qWUNTWnViSklTMTN2SVRWTDdnSFJ5OHoreGZ5MjVkZnZiYitEVE4x?=
 =?utf-8?B?dHFib0VzWXNDeHFOOURvMXFEekd2cVpXOThobnlYMWZQaktyVGxUQlgyS2Nu?=
 =?utf-8?B?N3d6cWdEY3daYmpzRFB1ZkEwTHJHVzBwRE5lZWNSZE41b3NCV3ROWWlvaHJJ?=
 =?utf-8?B?bnNjeXhVYUJNUm90dTZwenhuSXdwWUJ2bUFEOTJmV0srMUo5ZEZxWGNVYWJR?=
 =?utf-8?B?aEpoaVE2bTZLQU1wTml3SUR2V2VHNUNwd3Y1UmEzQ1dTOFpESGZQL2RERTZH?=
 =?utf-8?B?Nk1wWERXMjZFOTFvbkVJeDNtZ2R3QkZqNUpZMnd4V2pRaGxQYnJKZGZxVVYr?=
 =?utf-8?B?VUx6Skd5MXpjZHFDUEJYd0VnZ1JSVnhqd2d1U0dVZTh1SXNUVUQyVXlIOVdI?=
 =?utf-8?B?MjBzMFI0S2R1MzBCcjBXMkIrSFFYTElDaFlwd09jUTl5Zk5BdThOa1hVdDlW?=
 =?utf-8?B?dktLYzhobWc5U1U5ejJRMjU4RFB1K3hQUVRTZGluKzJGRzI1UHErcXZPV09C?=
 =?utf-8?B?KzJYOVRMM0xOUjllQWJqSDV1TFNacjM3VzJZcm5FQ0xWUHFOS3EyZnZJdnZl?=
 =?utf-8?B?cGdUaHZSMGhIakpBNTVId3cxb2lPQ2FrVklReDBTR1Z5dWZldkEvbWZFU2ZP?=
 =?utf-8?B?ckoyN1pVSi9SNlI3YzhLWUtjWVd1bVM5MmU2SG9yUzhwbVJmb3prZmpXM0gv?=
 =?utf-8?B?ZEQ1WnJDdCt5WnlRbkJGRnU4T2M1dFZFdjhRNmFSeUtoQjFRajhGR3haa0JO?=
 =?utf-8?B?R1BuelJtTXpDRXdtdUFuaWwybVZCZEtUVUxxLzR3RG93a2VOcmJnRDZjNFRD?=
 =?utf-8?B?SFlSYnA2OGxqUENzbElleFkxUmxDMzJhZFVHQUtkQjAvZTNDblNySGlGMkRX?=
 =?utf-8?B?RHRyMmtnQldwUnpNYUM3OExTRGVNUjM2c2J4L3ZtQWk5cHErZngzUVNrd3Nz?=
 =?utf-8?B?cUdDY1g1WW1ZT3lPUDZmZDZiU0tyUUpmOE0rdlhSOWk1KzRyOU5Gek0xdU5B?=
 =?utf-8?B?UFQvcXhVNjF3MEo2akU4QzczVFR6OHE4WTdnS1ZQMUdMNjA0OVJKWTE5NG91?=
 =?utf-8?B?UDdPVVVhYXQ4WXkzdVZhalgvQW5sYUdWcFEvVWJOY2hxVkZ4Wm9yZ09XelZT?=
 =?utf-8?B?QUp4YndYSmU1THR1akVabldTV3pFL20wdUFRTDhyM3BMNEtlYm45MEZBWHg3?=
 =?utf-8?B?WHl0R1FKa2x5UmdqcVRZNnE3a3FLQzdtQVErM1lSUFE1aWJ6NHI4Vis5NSt6?=
 =?utf-8?B?SThBL2xJYkhaVVZIOEtFS2tEUm0vQXhQcjVHWDZvS3V2aUtPMHcwUTZtSHJQ?=
 =?utf-8?B?RnI0VTY4T2JwKzhWTEx2RjN1OWNMRVIvUmNidTdyQlJLR0tDT2RZNm9mazY5?=
 =?utf-8?B?ejdHUnp0aXdYYnRuOTZXREJ4VnJ1MkhwZFl3Lzc2UXFhQnZkM3ZYYjZMczB6?=
 =?utf-8?B?MVFrMkdVc1l2NnBiQUQwQXY1UzJSZ3dDY3lTMHZsYit3eW1zd3owVHNCc1Jj?=
 =?utf-8?B?QTRkNUo2NFRFZXVOcFNKUUdwUnFHNHpNb2xpTHc2NzJ5Q24xTWtRR3ovRXZh?=
 =?utf-8?B?dVlyM1NEbitRUjgzMU5uVnNoSmJaZGwxOG1WS1Rzb1hWQmtMVHgyVkdsTkQr?=
 =?utf-8?B?OXFDWWdvS3A0aW4zVTMxTlZXMUx5KzNmdHlQd2pHeUI2TkhKZFRHS2hiZVR2?=
 =?utf-8?Q?VeNY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3895.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 131f7624-bc7e-49b2-b54b-08db16801ea8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 15:59:32.8742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7R7lkT5ebw3/QXx7oXstyiu5i1AtVwUQUouw26ADzCpc2VEKOS/TfNT9YfFvy5vD+0MybdFKQmgFsaUNmg2rEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gPiBHcGlvY2hpcF9hZGRfZGF0YV93aXRoX2tleXMgb25seSByZWFkcyB0aGUgbmdwaW9z
IHByb3BlcnR5IGlmDQo+ID4gPiA+IChuZ3Bpb3MgPT0gMCkgd2hpY2ggaXMgbm90IHRoZSBjYXNl
IHdoZW4gYmdwaW9faW5pdCBpcyBjYWxsZWQuIGJncGlvX2luaXQNCj4gdXNlcyAic3oiDQo+ID4g
PiBhcmd1bWVudCB0byBwb3B1bGF0ZSB0aGUgbmdwaW8gaW4gYmdwaW9faW5pdCwgd2hpY2ggaXMg
bm90IHdoYXQgd2Ugd2FudC4NCj4gPiA+DQo+ID4gPiBNYXliZSBiZ3Bpb19pbml0KCkgaXMgbm90
IGEgZ29vZCBBUEkgZm9yIHlvdXIgY2FzZT8NCj4gPg0KPiA+IEF0IHRoZSBtb21lbnQsIGJncGlv
X2luaXQgaGFuZGxlcyBhbGwgdGhlIGRpcmVjdGlvbiBpbi9vdXQgZ2V0L3NldCBncGlvIHZhbHVl
DQo+IGZvciB1cy4NCj4gPiBTbyBJIGNhbiBlaXRoZXIgcmVtb3ZlIGJncGlvX2luaXQgc28gdGhh
dCB3ZSBnZXQgdGhlIGNvcnJlY3QgbmdwaW9zDQo+IHByb3BlcnR5LCBidXQgd2lsbCBoYXZlIHRv
IGRlZmluZSBnZXRfZ3Bpbywgc2V0X2dwaW8sIGRpciBpbiBhbmQgZGlyIG91dC4NCj4gPiBPciBJ
IGNhbiBrZWVwIGJncGlvX2luaXQgYW5kIGRldmljZV9wcm9wZXJ0eV9yZWFkX3UzMiBpbiB0aGUg
Z3Bpby0NCj4gbWx4YmYzLmMgZHJpdmVyLg0KPiANCj4gU28gZmFyIGl0IHNlZW1zIHRoZSBpc3N1
ZSBpcyBpbiBiZ3Bpb19pbml0KCkgdGhhdCBkb2Vzbid0IGhhbmRsZSBuZ3Bpb3MgcHJvcGVybHku
DQo+IE1heWJlIHdlIG5lZWQgdG8gZml4IHRoaXMgZmlyc3Q/DQoNCk9rIEkgd2lsbCBzZW5kIGEg
c3BlcmF0ZSBwYXRjaCBzaG9ydGx5IGFkZHJlc3NpbmcgdGhpcy4NCg0KPiBCdHcsIGhhdmUgeW91
IGNvbnNpZGVyZWQgdXNpbmcgdGhlIGdwaW8tcmVnbWFwIGFwcHJvYWNoPw0KDQpUaGFua3MhICBJ
IHNlZSBleGFtcGxlcyBvZiBkcml2ZXJzIGFscmVhZHkgdXNpbmcgdGhpcyAoZ3Bpby10bjQ4bS5j
KS4gV2lsbCB0YWtlIGEgbG9vay4NCg0K
