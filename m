Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC6A604062
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiJSJxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbiJSJwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:52:47 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on0629.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0e::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880FE102DF0;
        Wed, 19 Oct 2022 02:27:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQ+6gng6DjHKYbKQ3oci+T0voxOBKQ8KpCzGeoGcXQaALF6PLWAywIowFEn+WgJKFoFrz2JwlDYYNvhYsh0SRTyscuBFmyUI4Iabusd9ARPMg7VDy40hhuF9SIp7wxHEPURz2zT2I0rJ7FSWIIFe5KHGQJ1AoFNfRKVdUfI4qxKMzG6XNiaPWtnbpdfOWcVx/7htzZsU/PqXoHtSRfo2D4WhM5G5qnNqZebTsMMdVjsY9VcqZXVZg3J9JTigtD83Ylu1GGgkptORyduGSds4SDmnaf77A4LwFWcgIYt/igdAaTQoBWEKzVCOwE1MbE1Eu3+4/Gd79/OEf1qRMgyIhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5u/hyWQaLXj2XyypO4EKDEY4DcKmY7uLi7GO7y0L16M=;
 b=W8JPSBdtBQMAkJaFQdA98x9TYBC0E4yICj3KoDKqONKaQHzLgD3847kJNtn+sau6A8C/+SHZVbtn0uogRS5uBAaocjAzvXNuoZRKFirSxyDkuoBzoQGrAXOt8IRfvMKffSW1raUBuWaDDHSPyPElVvPto62kRMcUaFLr895DQAVo1CrFd0Ygvm3a3r2MEO0B9Q7DmwmZmzjAMsGTQN0fr16GZnIj7Uogy5HQu04HkivrzQUIPHlEPRYpZvJYiY9MLhgRvpPC2Fg1QrZKmQpuoWbu9zrEUFLFk7v+7Rw8I2/WW5gPuKlH+k3scaLjWSoamjtm/6LII/pgB+9DkzHwrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5u/hyWQaLXj2XyypO4EKDEY4DcKmY7uLi7GO7y0L16M=;
 b=Bv4RkG2RLL0MawytoA/gGT1ibFy74ytoiwbNsPHMVMu19lk/8HKmpGea0630o747fLhY+JokWw6Vp6TrELRAgkGIJZ4uggvUdMr0lPFS/WM7D3sittwkPp1r/z2ZUjKjdhhYSBBCttcfVAPWEwhOhGa3c5xvYjpRuyhw2IJDLu4=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB7799.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.28; Wed, 19 Oct
 2022 09:24:35 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::84cf:df3f:2012:79ea]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::84cf:df3f:2012:79ea%5]) with mapi id 15.20.5723.033; Wed, 19 Oct 2022
 09:24:35 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] tty: serial: fsl_lpuart: don't break the on-going
 transfer when global reset
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: don't break the on-going
 transfer when global reset
Thread-Index: AQHY44iARFl/4Y+5J0aC1pv8VFXDu64VcMsAgAAAyNA=
Date:   Wed, 19 Oct 2022 09:24:34 +0000
Message-ID: <AS8PR04MB840479BF6EFBF25F648D1DEE922B9@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20221019065854.12397-1-sherry.sun@nxp.com>
 <34564f52-cae1-fdc3-8676-ce3d8e645672@linux.intel.com>
In-Reply-To: <34564f52-cae1-fdc3-8676-ce3d8e645672@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|AS8PR04MB7799:EE_
x-ms-office365-filtering-correlation-id: b7eccd60-023e-44ed-e070-08dab1b3bccc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: idmVMP423zoK7MIVi8cfM5fYJfv3mO0FGyCr9BzFchMQ2krz1MTMUirUg7+299qFoF2WaJL3W0c7juuaaT3bcngg4LfBN1Uayp0CNA9ECeeI/lMcgmklzYrxMhpGZJnhcNuHaeCczEX3RseRI+7fIknbmnku3BX39a1SFnj1QyrAgSnIz4gpkvNOscttggZKMsMhknKTI8ow4kIfyZB9ALX9JPiKabniTz2/FbgtGb7+fOTF6dX5aPSKd04ObD5aC3t67SqKPatrlP2PG3vZP4aKWWmPyo2cluhExftN2iT6YdhHdYHK4xf15uRMiT0/YsEJo6DwVWYBN4QwQpdwgPXS/1lTa2HSxVsZ4ajNFmLLoRERKIkmjs91JOkgZke94PHBwp46qruvTC3DfhIx53vP09UOvoLLKJa6spWKz2GfykrfWrrhHQO0MfNCv3c5/Vtj8nieTPT53cnHC9M3M+7BEvFoid1MizrU5Ce1atkx4psil6l+b5xJtxg79Z5EsZ4F+dqffowh0Hf/skaWjKfCBv31NNEyyd61eWqKde9cjhp5lmwPDuSgYNZnKDr+c+1cBepEXVb9jrAmOVbcDeevGOEooiuS/FtiUk+SDl/b0JmJpk+GKTPQy98Hup9f3ilXDSBbNaoeQaTdaypFuWefV6tNr3zV+RH1hdTic2vrbli+2pTp3qkgSfBHmGmPICbtKhzfAelZ83p49Kb0f31ezT0Z5FZMLwD8fa+F5mGQdwBnm3Vl48B+KCqyqzMHexxMnW9d1roY0Ke5pDQ4Mg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199015)(316002)(54906003)(6916009)(9686003)(83380400001)(8936002)(52536014)(64756008)(33656002)(5660300002)(2906002)(44832011)(66574015)(76116006)(66446008)(66946007)(66556008)(66476007)(8676002)(86362001)(186003)(122000001)(41300700001)(53546011)(26005)(38070700005)(4326008)(55016003)(7696005)(6506007)(71200400001)(38100700002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTlpUkVOVGFjeXk5WVB0L0pWWC9GdzFmU3dVby9ud2lxQisxb2ZVTno1Tk51?=
 =?utf-8?B?elRWZE9jaVZrTjBZN2wwd2oydlA5SGlJT2FIdXluR0VCUE1FcXF0YWQxeDVu?=
 =?utf-8?B?d01sUEkvV1VWVWorckVoeTFoSkJiZFlONkx5bW5xam9qUXQ5dmhaaUx4ay96?=
 =?utf-8?B?TUI3N2RrbFpwQ0ZrcG5jN2ppTXJKbThpNVVMWGYvWDlLVENrc1dPc2hhVURw?=
 =?utf-8?B?dEpzV1VqRkdjOVMwVkt1UWJwSTRKL0RMazRQVDJ0d1o5ZzFoRTNYTDBmN2NN?=
 =?utf-8?B?bEFFTUhmd054QTNtMHZJNXczMXpGbktqQkdiNGJFbmpOY2I2UEtNT2d1VjhB?=
 =?utf-8?B?ZUM5N255Wkw3Y0ErS2M3czVUckh6QnBoV1VrYVAwR0ZGa1F4U2pjY3NsL21y?=
 =?utf-8?B?dUZlTmdGYXdTbG5FMUVSNVBCbDBQdWtIQzY4RnVXNWJtTDQrYks1aTdDTEdB?=
 =?utf-8?B?cFR6YUdrM2xJcER6MDNpNDM2SFh1TGRQdFEyRnVZM2g2WU9seTcxOU5QM0xY?=
 =?utf-8?B?VkkybHRMNUMzUndzR25wNlJLbE9hY3I4QmtaVThuRDlvdGpRQnVBTmZLcXlY?=
 =?utf-8?B?aDgySDJMTVJVTldHYVFWdWdOSk9VczRveUh5Y3Fyb1llNGlzc3NhWHNVUWY0?=
 =?utf-8?B?REEwQjUzcytsaHFuK0VWSDEvcS9JdHQwM1NzeFpSZCtqUkhOOTAwUGhDVmhV?=
 =?utf-8?B?bEVNc2lNcEhlTzhKNG5sV2YydG54TzQ2VCtTMzhqbkdJZlJacEwyVHlWUm0v?=
 =?utf-8?B?ZkZYNHZRckhSc3g5WmgyQnMwWnF1bVNPdGNka1lKSklBeGVVUS9vZWR3ekJn?=
 =?utf-8?B?bVpZcEUvY20rTUdtZCtlU2JwZnNvL1RIYmVLYkdSSlJIL2RkWGlxSHVsaWk0?=
 =?utf-8?B?V2gwczZZdzBGajdIMk5ISlFMZHVjVmN6WGNRL29FVG9veWxEQVBzY1ZYeDhJ?=
 =?utf-8?B?d0h6Q2FtNWRXbVk4VmxzYjRldkZ5bm5ENFoyMmdGL3d5aEhNZHNUUVRLK3Q4?=
 =?utf-8?B?VFhLUHkxRk14WkY0Q1dJMWNrcTBpTk1qRHR0R0htSnhCWnBncUZJUGo0c1dz?=
 =?utf-8?B?RVRjc1RqTlROYXFqS1hrYm1OMElVRXNQbGI4N0IvbWJvcEE4d3BZZDVraTRK?=
 =?utf-8?B?RzFTOCt2RGNFSTNnOWJIZ2NVdU5hd1NzTGhCOUJRQXREaEpHTzJnMjluTTAv?=
 =?utf-8?B?dG85RnVRNWpkR3lMVzFmQkNCazl2QzFld2tCeU9lbmJ6OHBMV3grU1pEaDBw?=
 =?utf-8?B?NkY5SkwzYVdBcU9OTWZrTDAvbGNCcXJuL2hiMTM5b0RpcDI3VndMNkd5RjlB?=
 =?utf-8?B?Sk1JcVM4L0M2SUs3aXFzZk1nZFo5ZHlFeFl1ZnRIYXZsbGNNOUZ5Q2hyV3JJ?=
 =?utf-8?B?VUJhcy9CZHI3Q1pFdWQwQWVlY3pldG9VVW42TWY4QncrNkd6RU1YWThjVDhE?=
 =?utf-8?B?emJ3T041M2h2UUZweW1QNlRVWG45ZTBxbC80aGxKMGVQR2w2S0JoRVVTNGJL?=
 =?utf-8?B?T1hJQ3pENXpZZHl5OGljNmtFZTB1UlFEWVRNQ0U5dzZRL2pEbUVua2F1dG9T?=
 =?utf-8?B?Q29SOHoreXJObWROd2pXOENhVUhuVmt1WlFKalhVT2FQZWN3VkxPRlowN1c1?=
 =?utf-8?B?RnA2Q2pwQVNsSUZFQXNDNkd0OXZBMTlFMzJKR280ekF1M0tVWk1xRXJKNWty?=
 =?utf-8?B?RFVQeWVFeUZpOTBjTVJKZ0dhaUc0cjBCN3VYQk9NNEdvR1RnMEdyQlFUN2dT?=
 =?utf-8?B?UU5nbDI3dWNka1l1cXpZUlE3TW5QZUV4MXpFNlpxd1FwclU5RTJQTUdMWDdC?=
 =?utf-8?B?S2t6YlA2UjNQK0k4MUtJTFFwY3BsVWpzNW5NZlJWMVAzMlBLSzUrZU90cVcx?=
 =?utf-8?B?bythMTlkMU01UDl3enBqTjRDd29jYk1BK2dLK0p0ZjRSRCt1T1A1Vi9NNGlJ?=
 =?utf-8?B?SXV2K2svbW96dWU4aWM2dTlwVnVuMGt4YXY3NU5zMDl5WE5Bdy92NmFodjZ3?=
 =?utf-8?B?Z1dlQnk0STRvdHlQTGVGOFNjSDBPemJnLy9yZzVRdHN4MmJRQWhvRS8wZlpw?=
 =?utf-8?B?ZjF5WmVWWVppQVJtbjAwelBTNnI4dTNsUXZIWXBRZGlsNUoyTzZnelp0Z2tB?=
 =?utf-8?Q?B2zLr+CfH5cYLK93UygYviGK8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7eccd60-023e-44ed-e070-08dab1b3bccc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 09:24:35.0527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1i7ioDMCWDorebMr2PlisdcCKVpqRQnuzdMWixNBf9VYAWUh99OUcmmMmqfpBsxfCecvsJvKdgm60UxW4UhKDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7799
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSWxwbyBKw6RydmluZW4g
PGlscG8uamFydmluZW5AbGludXguaW50ZWwuY29tPg0KPiBTZW50OiAyMDIy5bm0MTDmnIgxOeaX
pSAxNzoyMA0KPiBUbzogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPg0KPiBDYzogR3Jl
ZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IEppcmkgU2xhYnkN
Cj4gPGppcmlzbGFieUBrZXJuZWwub3JnPjsgTHVrYXMgV3VubmVyIDxsdWthc0B3dW5uZXIuZGU+
OyBsaW51eC1zZXJpYWwNCj4gPGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmc+OyBMS01MIDxs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgZGwtDQo+IGxpbnV4LWlteCA8bGludXgtaW14
QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHR0eTogc2VyaWFsOiBmc2xfbHB1YXJ0
OiBkb24ndCBicmVhayB0aGUgb24tZ29pbmcgdHJhbnNmZXINCj4gd2hlbiBnbG9iYWwgcmVzZXQN
Cj4gDQo+IE9uIFdlZCwgMTkgT2N0IDIwMjIsIFNoZXJyeSBTdW4gd3JvdGU6DQo+IA0KPiA+IGxw
dWFydF9nbG9iYWxfcmVzZXQoKSBzaG91bGRuJ3QgYnJlYWsgdGhlIG9uLWdvaW5nIHRyYW5zbWl0
IGVuZ2luLA0KPiA+IG5lZWQgdG8gcmVjb3ZlciB0aGUgb24tZ29pbmcgZGF0YSB0cmFuc2ZlciBh
ZnRlciByZXNldC4NCj4gPg0KPiA+IFRoaXMgY2FuIGhlbHAgZWFybHljb24gaGVyZSwgc2luY2Ug
Y29tbWl0IDYwZjM2MTcyMmFkMiAoInNlcmlhbDoNCj4gPiBmc2xfbHB1YXJ0OiBSZXNldCBwcmlv
ciB0byByZWdpc3RyYXRpb24iKSBtb3ZlZCBscHVhcnRfZ2xvYmFsX3Jlc2V0KCkNCj4gPiBiZWZv
cmUgdWFydF9hZGRfb25lX3BvcnQoKSwgZWFybHljb24gaXMgd3JpdGluZyBkdXJpbmcgZ2xvYmFs
IHJlc2V0LA0KPiA+IGFzIGdsb2JhbCByZXNldCB3aWxsIGRpc2FibGUgdGhlIFRYIGFuZCBjbGVh
ciB0aGUgYmF1ZCByYXRlIHJlZ2lzdGVyLA0KPiA+IHdoaWNoIGNhdXNlZCB0aGUgZWFybHljb24g
Y2Fubm90IHdvcmsgYW55IG1vcmUgYWZ0ZXIgcmVzZXQsIG5lZWRzIHRvDQo+ID4gcmVzdG9yZSB0
aGUgYmF1ZCByYXRlIGFuZCByZS1lbmFibGUgdGhlIHRyYW5zbWl0dGVyIHRvIHJlY292ZXIgdGhl
DQo+ID4gZWFybHljb24gd3JpdGUuDQo+ID4NCj4gPiBGaXhlczogYmQ1MzA1ZGNhYmJjICgidHR5
OiBzZXJpYWw6IGZzbF9scHVhcnQ6IGRvIHNvZnR3YXJlIHJlc2V0IGZvcg0KPiA+IGlteDd1bHAg
YW5kIGlteDhxeHAiKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5A
bnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYyB8
IDIzICsrKysrKysrKysrKysrKysrKysrLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMNCj4gPiBiL2RyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1
YXJ0LmMgaW5kZXggNjdmYTExM2Y3N2Q0Li41MDY0ZmRiYTFiNjENCj4gPiAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jDQo+ID4gKysrIGIvZHJpdmVycy90
dHkvc2VyaWFsL2ZzbF9scHVhcnQuYw0KPiA+IEBAIC00MDgsMTEgKzQwOCw5IEBAIHN0YXRpYyBp
bnQgbHB1YXJ0X2dsb2JhbF9yZXNldChzdHJ1Y3QgbHB1YXJ0X3BvcnQNCj4gPiAqc3BvcnQpICB7
DQo+ID4gIAlzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0ID0gJnNwb3J0LT5wb3J0Ow0KPiA+ICAJdm9p
ZCBfX2lvbWVtICpnbG9iYWxfYWRkcjsNCj4gPiArCXVuc2lnbmVkIGxvbmcgdHhfZW5hYmxlLCBi
ZCwgc3RhdCwgc2ZpZm87DQo+ID4gIAlpbnQgcmV0Ow0KPiA+DQo+ID4gLQlpZiAodWFydF9jb25z
b2xlKHBvcnQpKQ0KPiA+IC0JCXJldHVybiAwOw0KPiA+IC0NCj4gPiAgCXJldCA9IGNsa19wcmVw
YXJlX2VuYWJsZShzcG9ydC0+aXBnX2Nsayk7DQo+ID4gIAlpZiAocmV0KSB7DQo+ID4gIAkJZGV2
X2VycihzcG9ydC0+cG9ydC5kZXYsICJmYWlsZWQgdG8gZW5hYmxlIHVhcnQgaXBnIGNsazogJWRc
biIsDQo+ID4gcmV0KTsgQEAgLTQyMCwxMSArNDE4LDMwIEBAIHN0YXRpYyBpbnQgbHB1YXJ0X2ds
b2JhbF9yZXNldChzdHJ1Y3QNCj4gbHB1YXJ0X3BvcnQgKnNwb3J0KQ0KPiA+ICAJfQ0KPiA+DQo+
ID4gIAlpZiAoaXNfaW14N3VscF9scHVhcnQoc3BvcnQpIHx8IGlzX2lteDhxeHBfbHB1YXJ0KHNw
b3J0KSkgew0KPiA+ICsJCS8qDQo+ID4gKwkJICogSWYgdGhlIHRyYW5zbWl0dGVyIGlzIHVzZWQg
YnkgZWFybHljb24sIHdhaXQgdHJhbnNtaXQgZW5naW4NCj4gY29tcGxldGUNCj4gPiArCQkgKiBh
bmQgdGhlbiByZXNldA0KPiA+ICsJCSAqLw0KPiA+ICsJCXR4X2VuYWJsZSA9IGxwdWFydDMyX3Jl
YWQocG9ydCwgVUFSVENUUkwpICYgVUFSVENUUkxfVEU7DQo+ID4gKwkJaWYgKHR4X2VuYWJsZSkg
ew0KPiA+ICsJCQliZCA9IGxwdWFydDMyX3JlYWQoJnNwb3J0LT5wb3J0LCBVQVJUQkFVRCk7DQo+
ID4gKwkJCXN0YXQgPSBscHVhcnQzMl9yZWFkKHBvcnQsIFVBUlRTVEFUKTsNCj4gPiArCQkJc2Zp
Zm8gPSBscHVhcnQzMl9yZWFkKHBvcnQsIFVBUlRGSUZPKTsNCj4gPiArCQkJd2hpbGUgKCEoc3Rh
dCAmIFVBUlRTVEFUX1RDICYmIHNmaWZvICYNCj4gVUFSVEZJRk9fVFhFTVBUKSkNCj4gPiArCQkJ
CWNwdV9yZWxheCgpOw0KPiANCj4gVGhpcyBsb29wLCBpZiBldmVyIHRha2VuIG9uY2UsIHdpbGwg
bG9vcCBmb3JldmVyIGFzIG5laXRoZXIgc3RhdCBub3Igc2ZpZm8gYXJlDQo+IHJlcmVhZCBpbnNp
ZGUgdGhlIGxvb3AuDQo+IA0KSGkgSWxwbywNCg0KR29vZCBjYXRjaCwgeW91IGFyZSByaWdodCwg
d2lsbCBmaXggaXQgaW4gVjIuDQoNCkJlc3QgUmVnYXJkcw0KU2hlcnJ5DQoNCj4gLS0NCj4gIGku
DQo+IA0KPiA+ICsJCX0NCj4gPiArDQo+ID4gIAkJZ2xvYmFsX2FkZHIgPSBwb3J0LT5tZW1iYXNl
ICsgVUFSVF9HTE9CQUwgLQ0KPiBJTVhfUkVHX09GRjsNCj4gPiAgCQl3cml0ZWwoVUFSVF9HTE9C
QUxfUlNULCBnbG9iYWxfYWRkcik7DQo+ID4gIAkJdXNsZWVwX3JhbmdlKEdMT0JBTF9SU1RfTUlO
X1VTLCBHTE9CQUxfUlNUX01BWF9VUyk7DQo+ID4gIAkJd3JpdGVsKDAsIGdsb2JhbF9hZGRyKTsN
Cj4gPiAgCQl1c2xlZXBfcmFuZ2UoR0xPQkFMX1JTVF9NSU5fVVMsIEdMT0JBTF9SU1RfTUFYX1VT
KTsNCj4gPiArDQo+ID4gKwkJLyogUmVjb3ZlciB0aGUgdHJhbnNtaXR0ZXIgZm9yIGVhcmx5Y29u
ICovDQo+ID4gKwkJaWYgKHR4X2VuYWJsZSkgew0KPiA+ICsJCQlscHVhcnQzMl93cml0ZShwb3J0
LCBiZCwgVUFSVEJBVUQpOw0KPiA+ICsJCQlscHVhcnQzMl93cml0ZShwb3J0LCBVQVJUQ1RSTF9U
RSwgVUFSVENUUkwpOw0KPiA+ICsJCX0NCj4gPiAgCX0NCj4gPg0KPiA+ICAJY2xrX2Rpc2FibGVf
dW5wcmVwYXJlKHNwb3J0LT5pcGdfY2xrKTsNCj4gPg0KDQo=
