Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED0B63E829
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 04:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiLADGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 22:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiLADGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 22:06:09 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2115.outbound.protection.outlook.com [40.107.215.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519299075B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 19:06:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBsD5rJcnzE+3AhFBFxtmMobEct70GW93m2hM/f4afgOdFzO7/kc3PXtFF8Xuwm5u+WzufvQVQmrAgEeLHz0COWUK1veKUSHTVU0iZlWJU1y1AKLwt7dPkg5wJBbbsy6TKuisIMKlNqJ+sMYAAkbBRxQ7fqu0yis43mqnaCFweOAaFZa4D4LiHTiQyOzw244CHIu2wtLPJOawX/tL9CQlXn7VSvByaJU2mCv1NZKQT4bwJLCpbdQ129jGCOQPmM3vLHQmhxBA26PizV7AugIv9+PKjB9gB3NwIJaPgUWDQefbPhdFwSTBul6SC4G4MFT8R0Ure9PtPSxpR0q2rSh1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4V4osJ9pOiRLtoNq/x4hmkFT4VREFT6OGBlrT0iDNW8=;
 b=IZBz0/Vfurm/Y+FbXx1UEkOpHBg/JX5Ef0StWpOihsgCtsEWhkGkBFKqi6Mv18ZSdv4NE2o9w3l7eB5bB+eufAM5Chy+guHgMEUPw0jOgJnArGMq7HCYYndtqCVb3VjgyiktZ9d1buW6sP2en/8f9xxA1wZAwgqLoYHJAEzY0/Gf9Ml0a5Y362aRYoI9XJQDR99QyexcZ2XCzdKehbVtI3xvSWIR+ITZSA6JS02cRDu/m65Utiw25yXujgTpEiD5fnhUqz0ABeYTwFfryTHqYt5QfhVf/xk4Q1s3pndH1a+9dxfWvNYxCxcvgizGMapcVCqCFARpo66Dk8ZYvwLPuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4V4osJ9pOiRLtoNq/x4hmkFT4VREFT6OGBlrT0iDNW8=;
 b=gfN+qJC0PwItXhXdVyzd784sgu+rrDkWdI0obLsiMHj5NsPuOlGBPrnYLBp/Ai+gEuJbd451JBLF+Ld2xv7QBiMZ9YGwXEn217F9z1/9yBpOVgEZJPqI6Sj+aV/OPh0IfTHDB+TU9N6hfpq+mSOjJStlKAVvyZvPnYI/cNpqx43XRuqVxugNEzzQhxl2q1RqlM7inQsZJWQkaikdSiZDyvTSg1uGp9S9zyCW/XfjqoXmy170jGFI7IhCyZkGrlXIWJ1LP923gG+iTH01nfXFPOuWcg9hm+JT42A9BNwZqf4W7hpxLAqouJGQMMrH9RgYZl4P/VidqSgCr6GgJFiWRg==
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by KL1PR0601MB4082.apcprd06.prod.outlook.com (2603:1096:820:2f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Thu, 1 Dec
 2022 03:06:00 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::1a6b:94bb:3e8a:bdcc]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::1a6b:94bb:3e8a:bdcc%9]) with mapi id 15.20.5857.023; Thu, 1 Dec 2022
 03:06:00 +0000
From:   =?utf-8?B?5byg552/LeaLjeeFp+aKgOacr+W8gOWPkemDqA==?= 
        <zr.zhang@vivo.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjJdIHJlZ3VsYXRvcjogY29yZTogZml4IHVzZV9j?=
 =?utf-8?Q?ount_leakage_when_handling_boot-on?=
Thread-Topic: [PATCH v2] regulator: core: fix use_count leakage when handling
 boot-on
Thread-Index: AQHZBSq5GSXK6IYhF0KwkKBOQzwl6K5YV+HX
Date:   Thu, 1 Dec 2022 03:06:00 +0000
Message-ID: <PUZPR06MB47422C723AB46596A2E32B66EF149@PUZPR06MB4742.apcprd06.prod.outlook.com>
References: <20221201021448.2371707-1-zr.zhang@vivo.com>
In-Reply-To: <20221201021448.2371707-1-zr.zhang@vivo.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB4742:EE_|KL1PR0601MB4082:EE_
x-ms-office365-filtering-correlation-id: b05d33cf-e3f9-42ee-90e6-08dad348f9a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uxbl5LZOSsFoc5NsSd5syvXa2vjGvHmyaZgSfW+sn0yBcPvr/EC9SDRFEIVE/ROBQeTUa7VjnFzP1fbZB5fE9RC+oI1cvc/Oe0uuUtRJr8ORVtOCJ7jIGts9iG3LWloy/dZKlgADqsIng3sLQMp/ZHURZTj5mCaa3AbKUJs469pijf3lQ1ahPZIAfvFODbCZR+4W2tSvdKEhw1eYRu2QssR8jG+Zds2t1zYzmiErclzy8VIHziJMh1JxcFlKC5DzokQ/QekxjXa0z/NFcd1EBeGv4CfWEe6VS7rpmo0opkzRe5xbtkQ/IXA+pE2jsl6Ktpw6PGRT+hENbq5Q3w5MV1XCSafYKZI8OcQwVchLoYjUacLIufURXzn8V6bOPkWv7nOF85hQLoZxI+Ajlt4bc15YAF5EpE52+g5hZLo0KDLPg0lrjW0vJ7LwWwT8nLFP/XtwkpW4vEYugazCte7qYHp1s2bqm4P6euuYRLlKybhfjO6SPvMYZBCsLFojBFnXEjLYjn7Mky5Yee8rFsfxRjR84Q0hxypQ8DYHSGcGxmLo14yd5AYjOacg+++fcgE+OTfdvM0RwHOj5IcTW8PjoJoYhHCpaXV94CAnmg9oxYjLTInHJ0Dyb8vL2v9MKcWEQ3XSRVps26UwmCr28voDgNDkveDqCxYGdO6iGTJMQ0gfiEK9+CoM3BdQOSul1LV+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199015)(38070700005)(55016003)(91956017)(26005)(86362001)(71200400001)(83380400001)(85182001)(6506007)(9686003)(33656002)(7696005)(110136005)(478600001)(5660300002)(66476007)(316002)(66556008)(2906002)(64756008)(52536014)(41300700001)(76116006)(66446008)(8936002)(66946007)(224303003)(122000001)(38100700002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUJyTS9GK1FXbnpaeXpva1JKdXUzbmI5Sm1hblB1K0pJV0ZaVHhiclFpZm1n?=
 =?utf-8?B?Q0tHT2FLeitZNWlBSnNBNWJCWWZYb1ZpU3B1RVNZTVl5cmRXZE5rSG5OTkwv?=
 =?utf-8?B?dUN4QzQ0RzVGeUh5bm4yVTQvODgvVk4yM3phcmNPV1czejZ0S3EvNWU0clJw?=
 =?utf-8?B?WmxGc1ZaWXV1aTF6ZmFyMVZFWU9WSE9GTmlCTWxFQytpc0RrRmJLakdodldY?=
 =?utf-8?B?ZUxDVXhvcW1JcHEvRjNxSzFMNmNoYUl4d2hQZ2FWY3Bpb0R5d1pGeFBkYmIz?=
 =?utf-8?B?d1RiYVVFcGlEdHpuRGNXekxSZUNPbUxubjFwV1RmUTJGbGo2T1k3aitPa1hJ?=
 =?utf-8?B?NUlGWmtSc21tWTg2RG9UUENielRnVkE4MnhYR0h4TkU5Sk9BNExBRWVxS1k2?=
 =?utf-8?B?ZzBhUUd6WUcvbmJlV3N3R2U2RTB4TUtJSFpWNUJRZVJrelBuTDdNWWduNldi?=
 =?utf-8?B?c2RmWnBXQW1mOGQzQ3Q5UHZHTGg0MFh2ZlQ4TEVwSEJaVkdpK2laNklFM1ZR?=
 =?utf-8?B?L0EzZ1ZPQktXeHdzdjA3ZEF0RnZSdklwVTc2ekplTHhjcWlvRkVaOEFpN0kx?=
 =?utf-8?B?N2U2ZFlhd2tCZzQ2SjMxMUt0aE0yZU1Dd0ZlaDFqRFNDSkZJVVRGZE16NSs1?=
 =?utf-8?B?RGNsOXVlbzVOeGpNSy9FOWpaYk00WVc4MVhJMHo5WUZReGNXOG5WVEhwMTVj?=
 =?utf-8?B?a2syVEFFSW9rMDh2My9UVmJMTkhKcndvU28wMGZPb0Fac3RnZjFFbm9WZStB?=
 =?utf-8?B?L0l6SFJ4UGVucXBIS3plNi8yaFNPbEtoZWVpL3A0RUYvL09GZUtZbWZJbEd6?=
 =?utf-8?B?RG1sVHIvaUs1UUFwWEh2QloydHBZQnNnVFNrYU94bmhJOWQ5MUNQTVJCZE5n?=
 =?utf-8?B?S2NLcUlLSTF0ZFc0SmM0QkVLTzhtcHNoWUNnNmRXVEZGQTFGMVdrWVltTnhr?=
 =?utf-8?B?QVJ2M0MzOHY3U2xIeEx0RzhERlhIMENaSUhoYlJBWkRSNFJHb2c1aUVZbEth?=
 =?utf-8?B?NE4wRE5HWkxEa2c3MnBEbldGbk1mMzdWOTVxeXZpclpYbVNjVFZDM2Z4YndV?=
 =?utf-8?B?NzFYUE1sL2hWME4xWWJBZ3JzY01scVpSbm5xd2ZPQ2dKRXRQbmdmWWRDcFh1?=
 =?utf-8?B?NFVWd3VuNkhNeU5uUE1HLytMLzhBKy9FY2ViN1VJYVR4REk2T043T1ZKUDYv?=
 =?utf-8?B?Qmg3dk9oT2JHVC9BUktzajJ6dEl5QmpMY2NXWXYzRCtRbzRhZ0hyeVlxT3Ev?=
 =?utf-8?B?RUhLVUtsdnptZW9hNWN0VnlGbVpyRGlCRXVOSlU1TDFyQnZKZUlBRS9ieXhU?=
 =?utf-8?B?ZEdLNDdibC93VTQwenpBYjlLajEzY3BON0c3c2IxaDFNc25kc2Y1STRjWWJL?=
 =?utf-8?B?cFFyY2hncHVGZDhEeWYwNm56TldZcE5ad1lDajE4ZWJ3T1lSYXBUU05LTnlK?=
 =?utf-8?B?bktROXZ3b3E3MVhXUXM4UFpFTml3RkUrVVR4R0hHVkRzQWZxZDRSbWZzenNT?=
 =?utf-8?B?NXZCVHExbldjK3haVnVGSkF1azF4T0dJcE1lbXJjb3VQbU5DbjhabUpWOGpY?=
 =?utf-8?B?NkU5TExOeWUyVnhBeGlmWjJYY2t4QTFtUFdmZ3NmanlWU05Rc2VYcEpsaFpL?=
 =?utf-8?B?Z3FOWDhsaWd1SVlBQldqYXArdVNOclRheGNqQjd5L0U1UTB5OGg2ZnFjTnZy?=
 =?utf-8?B?a2hMRThPcGYvOWdraVdwS2Ribkp4ajVLRUZKVHRCR3htTVN5RUtMRnJpTktG?=
 =?utf-8?B?c2w1eHlwY3YwRVNyb05VdEN1eHM2enlLek5XVGNNZzV3dmVsRGtaWGhNdUVt?=
 =?utf-8?B?THEzTy9Cbkkvb0FKaUcxSFp4bmlFY2pLa0xLL00yRFZGdVFtRGV3THNUNUFP?=
 =?utf-8?B?STlQYzZIM0J5SS9VdW4zeURWdFl5dFB0SEltMnpsbHhwcHRxN1BpUzFEUGJT?=
 =?utf-8?B?V3UyTWZCelBIQkxnMGpaRGNoSjYvYi8xcXJ2My9vRnl0Q2dFMzV2bUVweUFy?=
 =?utf-8?B?aTFza3hBNVdOQTJHMGozVVNrMzJTNUZDVDUwYmxRdDdqVk5UOHUyNDlJbzBQ?=
 =?utf-8?B?Ykp2b2ZseXBCeklZNDBhOGgyNVAwV21iTXRPOWNFMmY5UjZrUW1WbmJxelJt?=
 =?utf-8?Q?6J8k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b05d33cf-e3f9-42ee-90e6-08dad348f9a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2022 03:06:00.5033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zs6AXGVcFo12YXxBfaDKlSV+uRzR7H9/syU+g3SnJi32GDKgKQPcTSLY0m3lpl/Lf2kDYeIkVbFtjFhwQh3l9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4082
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJIGZvdW5kIGEgdXNlX2NvdW50IGxlYWthZ2UgdG93YXJkcyBzdXBwbHkgcmVndWxhdG9yIG9m
IHJkZXYgd2l0aAo+IGJvb3Qtb24gb3B0aW9uLgo+IAo+IOKUjOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUkMKgwqDCoMKgwqDCoMKgwqDC
oMKgIOKUjOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUkAo+IOKUgsKgIHJlZ3VsYXRvcl9kZXYgQcKgIOKUgsKgwqDCoMKgwqDCoMKgwqDC
oMKgIOKUgsKgIHJlZ3VsYXRvcl9kZXYgQsKgIOKUggo+IOKUgsKgwqDCoMKgIChib290LW9uKcKg
wqDCoMKgIOKUgsKgwqDCoMKgwqDCoMKgwqDCoMKgIOKUgsKgwqDCoMKgIChib290LW9uKcKgwqDC
oMKgIOKUggo+IOKUgsKgwqDCoCB1c2VfY291bnQ9MMKgwqDCoCDilILil4DilIDilIBzdXBwbHni
lIDilIDilILCoMKgwqAgdXNlX2NvdW50PTHCoMKgwqAg4pSCCj4g4pSCwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIOKUgsKgwqDCoMKgwqDCoMKgwqDCoMKgIOKUgsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCDilIIKPiDilJTilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilJjCoMKgwqDCoMKgwqDCoMKg
wqDCoCDilJTilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilJgKPiAKPiBJbiBjYXNlIG9mIHJkZXYoQSkgY29uZmlndXJlZCB3aXRoIGByZWd1
bGF0b3ItYm9vdC1vbicsIHRoZSB1c2VfY291bnQKPiBvZiBzdXBwbHlpbmcgcmVndWxhdG9yKEIp
IHdpbGwgaW5jcmVtZW50IGluc2lkZQo+IHJlZ3VsYXRvcl9lbmFibGUocmRldi0+c3VwcGx5KS4K
PiAKPiBUaHVzLCBCIHdpbGwgYWN0cyBsaWtlIGFsd2F5cy1vbiwgYW5kIGZ1cnRoZXIgYmFsYW5j
ZWQKPiByZWd1bGF0b3JfZW5hYmxlL2Rpc2FibGUgY2Fubm90IGFjdHVhbGx5IGRpc2FibGUgaXQg
YW55bW9yZS4KPiAKPiBIb3dldmVyLCBCIHdhcyBhbHNvIGNvbmZpZ3VyZWQgd2l0aCBgcmVndWxh
dG9yLWJvb3Qtb24nLCB3ZSB3aXNoIGl0Cj4gY291bGQgYmUgZGlzYWJsZWQgYWZ0ZXJ3YXJkcy4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBSdWkgWmhhbmcgPHpyLnpoYW5nQHZpdm8uY29tPgo+IC0tLQo+
IMKgZHJpdmVycy9yZWd1bGF0b3IvY29yZS5jIHwgOCArKysrKysrLQo+IMKgMSBmaWxlIGNoYW5n
ZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3JlZ3VsYXRvci9jb3JlLmMgYi9kcml2ZXJzL3JlZ3VsYXRvci9jb3JlLmMKPiBpbmRleCBl
OGMwMGE4ODRmMWYuLjFjZmFjMzIxMjFjMCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3JlZ3VsYXRv
ci9jb3JlLmMKPiArKysgYi9kcml2ZXJzL3JlZ3VsYXRvci9jb3JlLmMKPiBAQCAtMTU5Niw3ICsx
NTk2LDEzIEBAIHN0YXRpYyBpbnQgc2V0X21hY2hpbmVfY29uc3RyYWludHMoc3RydWN0IHJlZ3Vs
YXRvcl9kZXYgKnJkZXYpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChyZGV2
LT5zdXBwbHlfbmFtZSAmJiAhcmRldi0+c3VwcGx5KQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FUFJPQkVfREVGRVI7Cj4gCj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJkZXYtPnN1cHBseSkgewo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIC8qIElmIHN1cHBseWluZyByZWd1bGF0b3IgaGFzIGFscmVhZHkg
YmVlbiBlbmFibGVkLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBpdCdzIG5v
dCBpbnRlbmRlZCB0byBoYXZlIHVzZV9jb3VudCBpbmNyZW1lbnQKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICogd2hlbiByZGV2IGlzIG9ubHkgYm9vdC1vbi4KPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aWYgKHJkZXYtPnN1cHBseSAmJgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKHJkZXYtPmNvbnN0cmFpbnRzLT5hbHdheXNfb24gfHwKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgIXJlZ3VsYXRvcl9pc19lbmFibGVkKHJkZXYtPnN1cHBseSkp
KSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQg
PSByZWd1bGF0b3JfZW5hYmxlKHJkZXYtPnN1cHBseSk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0IDwgMCkgewo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9yZWd1bGF0
b3JfcHV0KHJkZXYtPnN1cHBseSk7Cj4gCj4gYmFzZS1jb21taXQ6IDAxZjg1NmFlNmQwY2E1YWQw
NTA1Yjc5YmYyZDIyZDdjYTQzOWIyYTEKPiAtLQo+IDIuMzQuMQo+IAo+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCj4gCj4g5pys6YKu5Lu25Y+K5YW26ZmE5Lu25YaF5a655Y+v6IO9
5ZCr5pyJ5py65a+G5ZKML+aIlumakOengeS/oeaBr++8jOS7heS+m+aMh+WumuS4quS6uuaIluac
uuaehOS9v+eUqOOAguiLpeaCqOmdnuWPkeS7tuS6uuaMh+WumuaUtuS7tuS6uuaIluWFtuS7o+eQ
huS6uu+8jOivt+WLv+S9v+eUqOOAgeS8oOaSreOAgeWkjeWItuaIluWtmOWCqOatpOmCruS7tuS5
i+S7u+S9leWGheWuueaIluWFtumZhOS7tuOAguWmguaCqOivr+aUtuacrOmCruS7tu+8jOivt+WN
s+S7peWbnuWkjeaIlueUteivneaWueW8j+mAmuefpeWPkeS7tuS6uu+8jOW5tuWwhuWOn+Wni+mC
ruS7tuOAgemZhOS7tuWPiuWFtuaJgOacieWkjeacrOWIoOmZpOOAguiwouiwouOAggo+IFRoZSBj
b250ZW50cyBvZiB0aGlzIG1lc3NhZ2UgYW5kIGFueSBhdHRhY2htZW50cyBtYXkgY29udGFpbiBj
b25maWRlbnRpYWwgYW5kL29yIHByaXZpbGVnZWQgaW5mb3JtYXRpb24gYW5kIGFyZSBpbnRlbmRl
ZCBleGNsdXNpdmVseSBmb3IgdGhlIGFkZHJlc3NlZShzKS4gSWYgeW91IGFyZSBub3QgdGhlIGlu
dGVuZGVkIHJlY2lwaWVudCBvZiB0aGlzIG1lc3NhZ2Ugb3IgdGhlaXIgYWdlbnQsIHBsZWFzZSBu
b3RlIHRoYXQgYW55IHVzZSwgZGlzc2VtaW5hdGlvbiwgY29weWluZywgb3Igc3RvcmFnZSBvZiB0
aGlzIG1lc3NhZ2Ugb3IgaXRzIGF0dGFjaG1lbnRzIGlzIG5vdCBhbGxvd2VkLiBJZiB5b3UgcmVj
ZWl2ZSB0aGlzIG1lc3NhZ2UgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBieSBy
ZXBseSB0aGUgbWVzc2FnZSBvciBwaG9uZSBhbmQgZGVsZXRlIHRoaXMgbWVzc2FnZSwgYW55IGF0
dGFjaG1lbnRzIGFuZCBhbnkgY29waWVzIGltbWVkaWF0ZWx5Lgo+IFRoYW5rIHlvdQoKU29ycnks
IHBsZWFzZSBpZ25vcmUgdGhlIG1haWwgYWJvdmUuIFRoZSB1bmV4cGVjdGVkIGB0YWlsJyB3YXMg
YXBwZW5kZWQgZHVlIHRvIG9yZ2FuaXphdGlvbiBwb2xpY3kuIEkgd2lsbCByZXNlbmQgdGhlIHBh
dGNoIGxhdGVyIHdoZW4gdGhlIGlzc3VlIGlzIHJlc29sdmVkLg==
