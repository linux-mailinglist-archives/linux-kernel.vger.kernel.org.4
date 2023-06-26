Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1B373DC5D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 12:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjFZKkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 06:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjFZKkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:40:00 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2096.outbound.protection.outlook.com [40.107.114.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B2DE60;
        Mon, 26 Jun 2023 03:39:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaK63OLpr1X1S32NUVnyR775R/Feu2mtoSrrBvYiPVUAvTQ9QI5UYPVlLVCP8MNUlz7pgEFMOjDYFwwEtI9AT6R/a4HEYpvjQdnVJ26NVi154r/kMdmu37hCue97YdzTKHYV7EQ2hmqtYckcFYrofyE9niomFfs10CdHcBxzLqgAxMNx+R7osssykPfYAJt7E+PPeP7NGHOL/ZSC0JDYvu90a3kyF6EMUKWXMou1sn1+naWYJz8HMcJUAWoviSfOMr6M72SJ9ajbyoxiWFw5XSIxajQ7AK4CTTwo65AeYJLuhR/fwu1dK9ZWNZfXGQGEBo3jmnU9d6dp/dZldY/l8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcLbl1H6CCbpkLr3jQks6vKKGlECGtuFUjFpGlylIDU=;
 b=mS1FCXctugma0zQH9glRKj9F3GO99RFFvZ9El4OmK7FFjdPDwZEbDYkXARI3zOoM47JGE5kEnrzuP60W6W85ixD6LsGo2QkWivpEiTjc8MH5dsA10SUoyl3BgQxOcdAaRccvppZG7kSwOmYJ7a9jTl5IBe1A8L7C6MfpkXa/8Ulutubx/Jng6J9PE0rbKIip5gpNckkuoADwib/Kp8C4t5BYeW7zHC15GqhSBeHZkrhfXQYSoNxIxfANJ6tMjig06lB6k+XFQa1CKbkG/a+0/Gtto3522uY9pGi0mXhq97i9fnEbTzwG/YmwiHwXwESXfNPPgUdZPabzGQjgfHrDFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcLbl1H6CCbpkLr3jQks6vKKGlECGtuFUjFpGlylIDU=;
 b=dj83qkAI+Wp9Vm+sERG0eF9knmUB6HwgYZSVNStzx2+JqD/VnqoNFnFiAwcSBxTg5hqp316KYYwLJfE9Zn5GsUfpXEbruVdWuupKeZVXJQll5fXbY3tgB7PXbgwpIBokfx4MUHzHUDK5Np6QlfsshI/886bHgHa/Dft3Q1JvxaE=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYCP286MB1730.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:187::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.26; Mon, 26 Jun 2023 10:39:56 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b429:5aa3:12f1:6b8]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b429:5aa3:12f1:6b8%4]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 10:39:56 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "andy@kernel.org" <andy@kernel.org>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] gpiolib: cdev: Fix &lr->wait.lock deadlock issue
Thread-Topic: [PATCH v2 1/2] gpiolib: cdev: Fix &lr->wait.lock deadlock issue
Thread-Index: AQHZqBNf7gwzAWjB50ahRCRRc44o1w==
Date:   Mon, 26 Jun 2023 10:39:56 +0000
Message-ID: <TYCP286MB1188A94580A60F47CAF892C88A26A@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCP286MB1188:EE_|TYCP286MB1730:EE_
x-ms-office365-filtering-correlation-id: 378b0103-0138-4c50-f7e2-08db7631af2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7xi9sYGTueX1qzm6o513b23B0f2ImRAPTZRfSM/hJbGCCY/ovNFRwdQDdN/9dkaY4w1L03wENhd3JoV2okkhWji78vyMWv/WcHGWJRy327C69/nrojncCFSDB36YLrfJ+QzbP7YjQ7llanCLoNp+twjjiaLQHBS4N4yS7cpTE73/RH8hBaEf7/B0wNFdeJCIUmS3Fy+Eiz3Ta9cU/YcyimJpe3Cy3DJ2Q2qbdr6FiWmYoE238HGOMMBzhV+66zN5TgMB5rj8Le2YJ7uTvYJa0hz8U2XPWI5vSsgTrPdZSYH7i6bAZabDb8t89uKk4SP2H2/Lgdq6lLofykLgjFWvaa8cdS7uku3YxA9BiMvBzm7CabYYSnQjTpuiGO3lz6d0QN28284a+oJs2+UXrrSVYSSXIX67zclA89dHU93Hu3bc5aqtXS458cmWpJQ2BkF0NPA2pKPquUYn7xGEsNeqImp99X8QRjIzIezAssE681kcAjoabTsWJ4zmH0lP72oksTii2ZgNXf5X2/GYuAfCSGN8c4e9O1er1y/6Y8i0PeJdN0G+E/prbCcjDc+RRTc2PVzNndv/m4Q3nAlkf8dIbHy9TlJNvC61xmwINK+FtVabBfS0YqYYk9KjNNzsxzPg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199021)(8676002)(8936002)(66446008)(76116006)(55016003)(66476007)(66556008)(66946007)(41300700001)(786003)(316002)(64756008)(4326008)(6506007)(26005)(9686003)(186003)(478600001)(54906003)(110136005)(7696005)(71200400001)(91956017)(2906002)(52536014)(5660300002)(38070700005)(122000001)(38100700002)(33656002)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UERvQ2ptSEVPcmFTYmVXSzAyZElyM0JBeHVRN2Q0UEMzUlo5SkpqenNCdWtQ?=
 =?gb2312?B?Z251dG9HbkZWMFZrTVo2VmQ5ZW1zeXJlcmkzTFhjdHMwRkpOZTN0dGEyaFMx?=
 =?gb2312?B?VkZ1NXJpVGNaL2hGRHp5R3hqU3pZUVNBb0FobXJiQ2hwOTVTdEJ1NEk4ZDJW?=
 =?gb2312?B?VEU3VEEyTEpDYmVWN3krU1V1cVNNczB2V2ZwQjdZZGFUakVhUFlhWUVRdUR2?=
 =?gb2312?B?M0ZIbGxwQWkxOTJqNTJpNVEvMGVpbngralpBaC9PQU1xTlI4ekNTaDF2WlA2?=
 =?gb2312?B?Q28xQU56T0lKUjQ1UFFUK1FDZHBMMlpURWhqejh2Q0F1K1NESlJlWlU0dDVn?=
 =?gb2312?B?ODdnVnMrMFU5MkxEYnYrMHBJWStsa0p4bjJHeTM2ZjJvWVAvUDI3NEN3b3Ir?=
 =?gb2312?B?ZTJ3K0dMYW5qZ1hRVE5RUjE5c3R5SmJSelBiRzY3bUNGUFhoTG5iUWZSazdi?=
 =?gb2312?B?NWFsdHFaV2M1aVBySFhEMmxOK0tUa0x2azh0M28yZmo0dGdURXVTZG8vWnJs?=
 =?gb2312?B?ck5Hckxsd1VXayttdTR6WWF3MzVncnRVNVRCVXRHaVFxZjI3VHRDUEVIUENP?=
 =?gb2312?B?czc2V1VobmFQWEhGSDROTkNIMUJTTnNMSXMrdndYc3lLK3ZjaXBnKzFLVkx2?=
 =?gb2312?B?ZmlvSFE1UHVrWUJxckVRSE9pSlVCMnBPbFY0a1JkVFZ1ZlF0UlNFaWFkdWJE?=
 =?gb2312?B?aWlmUldJOVpLUFNrWVFBWitFNlNxd1dKdHNSUjg0cUVNVncrRnpQUFN0OUl4?=
 =?gb2312?B?V29RUzFVN2RjUitMYWpQU1hyRytaS2ltbjhmQXp2bnhYMGFZcHBVdEtHd0Q5?=
 =?gb2312?B?aEdCc1Z0MHM0NW83cWRUZWJDbVBnUXJqM1VMVUNqU0xKYVZlaDU2eVg0ZVM3?=
 =?gb2312?B?Tms1bmJSYzBkNHhPalRLcHdUMnFyWHRGKzRycWxWdU5vVFdrMTFWQnF3M3I1?=
 =?gb2312?B?Z2s4NEUxZjBKcDVseEkyV2Y0OGRrZ2sxc24zU0xRNEEvNHhxeWpnVGV1WjlL?=
 =?gb2312?B?MzMzcDVVQ2QxY1pYdHpqZDhVOXhZZ1dTbFhQbVpJZ2tvUUtWQUxNc1FtWG1U?=
 =?gb2312?B?WDY3YTU3UzFLOHRZTERKQnVmcUNoeTJHZFl1ZlJvVzg2b0l3b0tvTXlzd24v?=
 =?gb2312?B?M1VUa2I3T09PNEVJUU5rMDhyeG1XYjhHT045d0xiSVVqNEd2WGs1bFMzQlR6?=
 =?gb2312?B?U3dkMU5pVHZjTmFpcytQb05lTEdEZGZKbExGZ29TRW5URC9oWTZSM2lwb08y?=
 =?gb2312?B?eXFndEE2WVhTbTRYdk5uMWx3RjR2a3JCYWhWUDMyVncwOGlIdWxxbTNWcGwy?=
 =?gb2312?B?aDVDQWlONDAzanhSbE9rS1RxS0RGbmN5cG80V0FRVXhXeE9haG1OTHJuYi9M?=
 =?gb2312?B?YUFuSXF3TjhlTnE4UjAyTExEZW5ZU2czQ0UrSnlwNlBua052S2w5bWFPSGJt?=
 =?gb2312?B?cXd1Y0JpRzJNZHNhUGlFWnFrRjFxL1JxUVlyNlNrMUpDUHFacjVFdW4za3Va?=
 =?gb2312?B?UDhNRXlTcStpQ241OEwxaURnYWhaNklsQXo4Z3A1TVNIUDNQMDJJclpobE9K?=
 =?gb2312?B?V2d4d0hlVjBuZVZyMWh6dGNGdUYvRVlyVHNLajdaSW9yQ1dZdHRSZEZwalU4?=
 =?gb2312?B?Vm5uS2o1S0dYM3pTckp0SlE4S0xTRkR6VHpWSERGc1g2ZEdTbWQvOVdzZ2tF?=
 =?gb2312?B?WWpIS0xuMytKS09oMTVlMHhUeXRBL3V4L3BMYjhJS25EdDdWd0xjNmFDUXhi?=
 =?gb2312?B?YnlrMTVZY0FpNCtsOGdNbmVHY2xyQmx5dHllcHZJb2NocXI2bE1yNEJTR25s?=
 =?gb2312?B?ekc1SXRwYTBsK1Q0cUUvMjhmNTIzakpORmxUalJQNGFjMTNWVDFKVjFBNnQw?=
 =?gb2312?B?RUNaQVI1QVluSWMrOTk3Vk42c2wvV1Qvb3hJU1RZRGMvckVkTUF3cXA1TDVY?=
 =?gb2312?B?cnpjM3NQR2Z1eTdHNytlS28xcHlSMHhHS2hZcmFpazNseCtaZXFLRkUxNTl6?=
 =?gb2312?B?QU1FSnQvMCs3LzRBbWRaZnZrckE5Z0Z0YWdESm9VSDNuZ1hRRVAyc2x1TmhP?=
 =?gb2312?B?L2tmRnd4dXlLN0VqSGRTR2FCWk1tYkROcVdjczNBdUFsNmt3clJqaXZxRkZo?=
 =?gb2312?Q?EbCQRgA1i+S29VD7hIobyKvq5?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 378b0103-0138-4c50-f7e2-08db7631af2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 10:39:56.7464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IjlxLxpJIOA3qd2F1Jn2m6nkiQ1mWPITlHmH2lhbw7JlUPj1UR1NjfRf5GLkx/uMC353P2DLG9+ScDfEc3MAhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1730
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bGluZXJlcV9wdXRfZXZlbnQgaXMgY2FsbGVkIGZyb20gYm90aCBpbnRlcnJ1cHQgY29udGV4dCAo
ZS5nLiwKZWRnZV9pcnFfdGhyZWFkKSBhbmQgcHJvY2VzcyBjb250ZXh0IChwcm9jZXNzX2h3X3Rz
X3RocmVhZCkuClRoZXJlZm9yZSwgaW50ZXJydXB0IHNob3VsZCBiZSBkaXNhYmxlZCBiZWZvcmUg
YWNxdWlyaW5nIGxvY2sKJmxyLT53YWl0LmxvY2sgaW5zaWRlIGxpbmVyZXFfcHV0X2V2ZW50IHRv
IGF2b2lkIGRlYWRsb2NrIHdoZW4KdGhlIGxvY2sgaXMgaGVsZCBpbiBwcm9jZXNzIGNvbnRleHQg
YW5kIGVkZ2VfaXJxX3RocmVhZCBjb21lcy4KClNpbWlsYXJseSwgbGluZXJlcV9yZWFkX3VubG9j
a2VkIHJ1bm5pbmcgaW4gcHJvY2VzcyBjb250ZXh0CmFsc28gYWNxdWllcyB0aGUgc2FtZSBsb2Nr
LiBJdCBhbHNvIG5lZWQgdG8gZGlzYWJsZSBpbnRlcnJ1cHQKb3RoZXJ3aXNlIGRlYWRsb2NrIGNv
dWxkIGhhcHBlbiBpZiB0aGUgaXJxIGVkZ2VfaXJxX3RocmVhZApjb21lcyB0byBleGVjdXRpb24g
d2hpbGUgdGhlIGxvY2sgaXMgaGVsZC4KCkZpeCB0aGUgdHdvIHBvdGVudGlhbCBkZWFkbG9jayBp
c3N1ZXMgYnkgc3Bpbl9sb2NrX2JoKCkgYW5kCnNwaW5fbG9ja19pcnEoKSBzZXBhcmF0ZWx5LgoK
Rml4ZXM6IDczZTAzNDE5OTJiNiAoImdwaW9saWI6IGNkZXY6IHN1cHBvcnQgZWRnZSBkZXRlY3Rp
b24gZm9yIHVBUEkgdjIiKQpTaWduZWQtb2ZmLWJ5OiBDaGVuZ2ZlbmcgWWUgPGN5ZWFhQGNvbm5l
Y3QudXN0LmhrPgotLS0KIGRyaXZlcnMvZ3Bpby9ncGlvbGliLWNkZXYuYyB8IDE2ICsrKysrKysr
LS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncGlvL2dwaW9saWItY2Rldi5jIGIvZHJpdmVycy9ncGlv
L2dwaW9saWItY2Rldi5jCmluZGV4IDBhMzM5NzFjOTY0Yy4uZjc2OGQ0NmJkZWE3IDEwMDY0NAot
LS0gYS9kcml2ZXJzL2dwaW8vZ3Bpb2xpYi1jZGV2LmMKKysrIGIvZHJpdmVycy9ncGlvL2dwaW9s
aWItY2Rldi5jCkBAIC02MTUsMTMgKzYxNSwxMyBAQCBzdGF0aWMgdm9pZCBsaW5lcmVxX3B1dF9l
dmVudChzdHJ1Y3QgbGluZXJlcSAqbHIsCiB7CiAJYm9vbCBvdmVyZmxvdyA9IGZhbHNlOwogCi0J
c3Bpbl9sb2NrKCZsci0+d2FpdC5sb2NrKTsKKwlzcGluX2xvY2tfYmgoJmxyLT53YWl0LmxvY2sp
OwogCWlmIChrZmlmb19pc19mdWxsKCZsci0+ZXZlbnRzKSkgewogCQlvdmVyZmxvdyA9IHRydWU7
CiAJCWtmaWZvX3NraXAoJmxyLT5ldmVudHMpOwogCX0KIAlrZmlmb19pbigmbHItPmV2ZW50cywg
bGUsIDEpOwotCXNwaW5fdW5sb2NrKCZsci0+d2FpdC5sb2NrKTsKKwlzcGluX3VubG9ja19iaCgm
bHItPndhaXQubG9jayk7CiAJaWYgKCFvdmVyZmxvdykKIAkJd2FrZV91cF9wb2xsKCZsci0+d2Fp
dCwgRVBPTExJTik7CiAJZWxzZQpAQCAtMTUxNCwyOCArMTUxNCwyOCBAQCBzdGF0aWMgc3NpemVf
dCBsaW5lcmVxX3JlYWRfdW5sb2NrZWQoc3RydWN0IGZpbGUgKmZpbGUsIGNoYXIgX191c2VyICpi
dWYsCiAJCXJldHVybiAtRUlOVkFMOwogCiAJZG8gewotCQlzcGluX2xvY2soJmxyLT53YWl0Lmxv
Y2spOworCQlzcGluX2xvY2tfaXJxKCZsci0+d2FpdC5sb2NrKTsKIAkJaWYgKGtmaWZvX2lzX2Vt
cHR5KCZsci0+ZXZlbnRzKSkgewogCQkJaWYgKGJ5dGVzX3JlYWQpIHsKLQkJCQlzcGluX3VubG9j
aygmbHItPndhaXQubG9jayk7CisJCQkJc3Bpbl91bmxvY2tfaXJxKCZsci0+d2FpdC5sb2NrKTsK
IAkJCQlyZXR1cm4gYnl0ZXNfcmVhZDsKIAkJCX0KIAogCQkJaWYgKGZpbGUtPmZfZmxhZ3MgJiBP
X05PTkJMT0NLKSB7Ci0JCQkJc3Bpbl91bmxvY2soJmxyLT53YWl0LmxvY2spOworCQkJCXNwaW5f
dW5sb2NrX2lycSgmbHItPndhaXQubG9jayk7CiAJCQkJcmV0dXJuIC1FQUdBSU47CiAJCQl9CiAK
LQkJCXJldCA9IHdhaXRfZXZlbnRfaW50ZXJydXB0aWJsZV9sb2NrZWQobHItPndhaXQsCisJCQly
ZXQgPSB3YWl0X2V2ZW50X2ludGVycnVwdGlibGVfbG9ja2VkX2lycShsci0+d2FpdCwKIAkJCQkJ
IWtmaWZvX2lzX2VtcHR5KCZsci0+ZXZlbnRzKSk7CiAJCQlpZiAocmV0KSB7Ci0JCQkJc3Bpbl91
bmxvY2soJmxyLT53YWl0LmxvY2spOworCQkJCXNwaW5fdW5sb2NrX2lycSgmbHItPndhaXQubG9j
ayk7CiAJCQkJcmV0dXJuIHJldDsKIAkJCX0KIAkJfQogCiAJCXJldCA9IGtmaWZvX291dCgmbHIt
PmV2ZW50cywgJmxlLCAxKTsKLQkJc3Bpbl91bmxvY2soJmxyLT53YWl0LmxvY2spOworCQlzcGlu
X3VubG9ja19pcnEoJmxyLT53YWl0LmxvY2spOwogCQlpZiAocmV0ICE9IDEpIHsKIAkJCS8qCiAJ
CQkgKiBUaGlzIHNob3VsZCBuZXZlciBoYXBwZW4gLSB3ZSB3ZXJlIGhvbGRpbmcgdGhlCi0tIAoy
LjE3LjE=
