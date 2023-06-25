Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D63E73D1BB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 17:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjFYPfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 11:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjFYPfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 11:35:53 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2123.outbound.protection.outlook.com [40.107.114.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09C3E50
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 08:35:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLywr+2Q0qS7HfzPyNs9qVUn7AxedHLtFUY89iiuf4/Kptak/2eme3Elwkwfkxcnyjtgyy4RN8SH4zorgcxmnXqDJySGryYrO2bhFpvtv6uZfewcQi7+WVuPdggIZ35gg8Gr6fFQPS/F03JseSilZYWh+Op5hoz0bUzt7AFfu0m8vVQPpnjywjkdDyUE7eAaefo+3aOrgmoEbC+aPgmgix8XVlbSHkgUewJloQVZrGMAu1BiC3VfsLnSX7IjALx5KTlgVmwhzXIG+niAYEshhSczv8mQyQq1qY0DXfkE9TnHZXYe/IlZmOf/UmJTZqelC4WbQb72D8aY+KD22zLQRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKTR/ZKDVGmH9mfeh6XyTyOSwVssM/91blIQPOx1O8w=;
 b=EOBmIxOFIvi14xHRibHH5HJL9phkVd7WX3qceY9fBoTeBtj5iZYZM/EEfNBALxCZjmsXzVi8KZxIRt1yUT1yH6Pqqh6Fj+/B838SYcq+IxjNga2Kx4d8BrhvNpF26d9ZeHUYxkzFC21sVIg6KV8aX6nKXyyiFW6sy/IeP0V8Uxww3ixQ0Oh+raeQ1/8timCDrK+wHEDUuzONKQxFF1ogixocx8Kb5tI8OZUtAq8rKg9pLHG/6lcAhQSYXTStayPGNZ0LMLqAXspTc2v/0OENMbx6v0zcqc77OiQ5ZAYf9WG2SzSZPyfmqwUXI9QWPbZ7a5dy2eEHXyUNGfmQDMQqzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=connect.ust.hk; dmarc=pass action=none
 header.from=connect.ust.hk; dkim=pass header.d=connect.ust.hk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connect.ust.hk;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKTR/ZKDVGmH9mfeh6XyTyOSwVssM/91blIQPOx1O8w=;
 b=i9mkEXbEhIw0AJxkCQIxWd36bQKNTY5AiZ7EWNyvMN+GadqktB8OyLh82/C9dWylslHVRv9S3Ycz+d0P4Z9AhwnSXrBybPrpHPSZekxY6An5DA2Xn2Y49nu5h7weomTDXtnHtuXOJ29iig5TQ/Aozn0GfIzw8FUhCrNArHSp/00=
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:b7::8) by
 TYWP286MB3192.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2d4::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Sun, 25 Jun 2023 15:35:48 +0000
Received: from TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b429:5aa3:12f1:6b8]) by TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b429:5aa3:12f1:6b8%4]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 15:35:48 +0000
From:   YE Chengfeng <cyeaa@connect.ust.hk>
To:     "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "yunjunlee@chromium.org" <yunjunlee@chromium.org>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA: dummy: Fix &dpcm->lock deadlock issues
Thread-Topic: [PATCH] ALSA: dummy: Fix &dpcm->lock deadlock issues
Thread-Index: AQHZp3fywsqsa+nIJUORNCRxL38reA==
Date:   Sun, 25 Jun 2023 15:35:48 +0000
Message-ID: <TYCP286MB1188FEE149369A32D90DCE288A21A@TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=connect.ust.hk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCP286MB1188:EE_|TYWP286MB3192:EE_
x-ms-office365-filtering-correlation-id: a99eeb09-9268-46f2-673a-08db7591d9c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L8t5qlKIErCyZCKvSHn8KJYo67P4AQmU4/C4/NTKgbDS0JgTlNjRdbsRVIVS5C9C9L0xj1vO3aoxJ5LoOGwyi0IusOdlnLsz3Z1Bi9Cf/6mrwNzT9FEQebIDj0A+XmK+MwXQXKiL2nKniSATrku9Yc+Oz35h0ICKJLh0PgTY2G1aObWsq41pekOJUjn0l8NZOFI0gMw+Y45pCWu9cRKYBHWShgUt3kUFgMJQ25HCRY50lW8M2D17ue3GzWmjbK4qkMfuve2hQpqgU7+U/yIce4K1mzVMDL3k5GFDHd3CVrJVWTbxZ1CGUBf0LM6aFo1klR4ng+ABPekgTTkpU8XYKURfbQoKasSN007cgzTkS583TAQiElwUqRbGhDB1XWFjiLNzjmFT/fVsR7x0/DkNjCzhxI/ckqjeVVlccDCN3SuSPi1h8vj0IR7mthaZ5RHxt0ZaCB8nX3MVIUL7sD7HR4xX6P7GK2QCyxkqg89CmzpPt2VKbYjuey2er3PZL3uMf8fiZIPRIVrHTvaMd5QSVkszPaY5kK8r6mIDy7JF/sdtUHfDRcwb1cOCXEIsH4a11YQb6dbuwuUuunuhw3zZx18GXmcS92YFYeoF8MZaVVR3mdtPqlR8QnICl3xTO++w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199021)(122000001)(38100700002)(38070700005)(83380400001)(33656002)(86362001)(478600001)(54906003)(110136005)(7696005)(71200400001)(41300700001)(66946007)(66556008)(55016003)(66476007)(786003)(64756008)(66446008)(316002)(8676002)(76116006)(8936002)(26005)(4326008)(6506007)(186003)(9686003)(2906002)(91956017)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?YXpCZVBTSTNOM0pYQ2FwOWVReEtDTytJL25pWkd3UVVURGw3ei9UWEdaNGdu?=
 =?gb2312?B?aVZ0WGJidmRKaDdXb2NXdzB3REtsUGhSeWJ5VnVEbGJ5bDJ2bHBKbE9Xb2Mr?=
 =?gb2312?B?TkVpbUFxWW5JZ3R3Q3MrSDJIVUwxakl6YXhsY0NwSHdXNGlXVHJFU3BWTEFY?=
 =?gb2312?B?YjdQNGVpbFliL3ZEZXRDTVhZZ1o4TTIrUWJtYU5MTGp0N09GTlF0eURLampn?=
 =?gb2312?B?SFBHQkRqYllmV3VieFRmSUdzS1kxaTRhdUwvVWswZmYyT1pnQ2k4d0NacFYw?=
 =?gb2312?B?MHhaRVJUTUdEcmZIVzI3V29QNnk1bG5CQ1ZJUEgvY1YxOCtZcmpZTmdKUVpl?=
 =?gb2312?B?Qnk1dFVaQXYycjFxSDBlRnBJQzNTRW9ZMjBYcEpBblg1SEVTdVozWmxZMGRl?=
 =?gb2312?B?SHVoVjhMaU5oNEdXTTlhdVpOOWsrY1llaUNYT3hZeEl1bkpnVDc5NndkdUVR?=
 =?gb2312?B?d0NUTk1TdDErZEZHZnQxakZ4cE5qcXY2WWZaWXZPdldVbWJBL0xCMkZTYWEz?=
 =?gb2312?B?TTc3SjhJWlIrcDNNNnpJaFVELzdxMHprdHpSTFVzNjNPTks1cVNNYkxGenJu?=
 =?gb2312?B?dWdoWnE5Sk1CbytxYWQ3UlcvMHloVmlYelpqdzNuQ1I4MUo3dTZyT1d2cTNa?=
 =?gb2312?B?WXdpVktOVkowRndUZVBwdTJJVlZ4VHJoQzduNVlzcUg5alB3S2dMV0ZBdVdK?=
 =?gb2312?B?MlltUUR4QWhUVzJaeWpQbVF1dkswakcyZFhuZ25sbzF5dWVTQUFmSDB5NmNI?=
 =?gb2312?B?MGNFRnVONitYdHpIS3FEV0lIODd4WHM2MHJhMWlMV1RqUHF0cS9HNkl6Wm1N?=
 =?gb2312?B?K0dyakJhRktHY1plYTRvbHNzQTBIaTVmQU9rckN5TTBQVW40cVlsb0JXU0sw?=
 =?gb2312?B?bVplR0hXT1Bxcy9Obk03MHpiWXNnbGtWRm1ZVnhnYUE2aUpGMHU4ZUhnaTg1?=
 =?gb2312?B?LzRaVzFGeUxiWjZ4RW12ajJEbWt3MzZwV0lBOWZSNXFQV0lZRFZQb1k0SkpD?=
 =?gb2312?B?LzRPZndrN09sa0FIVXVUdmt0c2d5TWtIZUlTN2hKM2R1bVdxcUkxQzBrVG1w?=
 =?gb2312?B?dFVLOWV5SUJjMGEwVjNpbC9obXpxcTV0a0JjRWtzcHRYTWY5Vy9HaU5jTmFr?=
 =?gb2312?B?bGdqYm54U05xUmlkL295N2gwbXp2cmZFQk1WbG9oMDlhaUY0WXFXUkVROUh3?=
 =?gb2312?B?ZEoxSUw0a3ZqSGI5OHdWYTNiYjRib2ZGVjhYdUlaY2VqcHgxbHV6eUZncmhl?=
 =?gb2312?B?T3I0bVozS04ra2ZrWk93U3Rrakp4bFJwV0FaM2Z5cnZzRE04Y2p2Zml6Y1lP?=
 =?gb2312?B?Q2ZFM2V4UFlVNjVFMkRtVFpxL0dSWm9SS21oTDlWSGw4aGRoR0NFQWVnb1F5?=
 =?gb2312?B?K1ZscHdKeS9ScUVMT1BPbWwyb3dvbk9vcldCbEF5ZGpxN09xRkVSOUUyVzFP?=
 =?gb2312?B?a0VETXJ5am0wcTZUMS9DMFNSd3FIRTl6QnBBRWlFeTVyR3pGeVlnbCtVb3hm?=
 =?gb2312?B?elpWOFM0ZktPM3NZY3RGdVZiSGJmWTdqR1EzSkI5MVNuVytzV0hrSlM3cStk?=
 =?gb2312?B?SUFDT0RPLzg2RGU0Uk1qU29GM05DQkdnMnhBb0RqRGt0S1ZmUnVlenRtRmdH?=
 =?gb2312?B?dEN2RWJ4QlkwUkpKNHlVdU51Q29JT2luT2lNM2NibmVNVHd1cEl6dXZFZHF6?=
 =?gb2312?B?NS84MWRGNGV3VCtRem5TbnBlSER3VkkrUWNXWmdZU3lmWFZzRzBVVkZuSXFV?=
 =?gb2312?B?TnlRSkxDdlpjTUlRSytVdWI4TTF2eUROamMxZ1M0VncySWVMa2xnSmJsbThH?=
 =?gb2312?B?bWNxeldBS0tlZUZ2aFMwdHlQL2FHVVlCTnlJMjF0bmh4b0ZzVWxnaEkwazFa?=
 =?gb2312?B?VFF0VGxEdTlyY25BOGNrMHgxWGFHdUE2N0ZaeHdweGhVaWgyUFk1dHR4dmRs?=
 =?gb2312?B?T1l2ODVHbFFlejFKRmtmQnYxOCtaYVR6TmM2RDZSUkxtNmRueWZWZVF4YUZI?=
 =?gb2312?B?MFJvRUhSMGtRbUlKL2U4amtZK1lnUGNuZU1sL2dNR01oVndlQ0dKa3dTbi85?=
 =?gb2312?B?K3p3RFNvVWtlWGpla3Nmbzl2QTZ5VFdHdGtQQVBObXEzNVpjeVNORTcxTm8x?=
 =?gb2312?Q?Xvsp9vFJiIRg1jy9JjpGKRWK4?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: connect.ust.hk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1188.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a99eeb09-9268-46f2-673a-08db7591d9c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2023 15:35:48.7207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6c1d4152-39d0-44ca-88d9-b8d6ddca0708
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YGlIBYG3Tkubc/8wkAjvE1bQ0FZuTnmwMnovWr2XQkhEHnJuiV5UhwveL79hFD7qJncvKHod2laKfDhKOBWT8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3192
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIHRpbWVyIGR1bW15X3N5c3RpbWVyX2NhbGxiYWNrIGlzIGV4ZWN1dGVkIHVuZGVyIHNvZnRp
cnEKY29udGV4dCwgdGh1cyBvdGhlciBwcm9jZXNzIGNvbnRleHQgY29kZSByZXF1aXJpbmcgdGhl
IHNhbWUgbG9jawpzaG91bGQgZGlzYWJsZSBpbnRlcnJ1cHQuIE90aGVyd2lzZSB0aGVyZSB3b3Vs
ZCBiZSBwb3RlbnRpYWwKZGVhZGxvY2sgaXNzdWVzIHdoZW4gdGhlIGNvZGUgZXhlY3V0aW5nIHVu
ZGVyIHByb2Nlc3MgY29udGV4dAooaS5lLiwgZHVtbXlfc3lzdGltZXJfcG9pbnRlciwgZHVtbXlf
c3lzdGltZXJfc3RhcnQsCmR1bW15X3N5c3RpbWVyX3N0b3ApIGlzIHByZWVtcHRlZCBieSB0aGUg
dGltZXIgd2hpbGUgaG9sZGluZwp0aGUgbG9jay4KCkRlYWRsb2NrIHNjZW5hcmlvOgpkdW1teV9z
eXN0aW1lcl9wb2ludGVyCiAgICAtPiBzcGluX2xvY2soJmRwY20tPmxvY2spOwogICAgICAgIDx0
aW1lciBpbnRlcnJ1cHQ+CiAgICAgICAgLT4gZHVtbXlfc3lzdGltZXJfY2FsbGJhY2sKICAgICAg
ICAtPiBzcGluX2xvY2tfaXJxc2F2ZSgmZHBjbS0+bG9jaywgZmxhZ3MpOwoKRml4IHRoZSBwb3Rl
bnRpYWwgZGVhZGxvY2sgYnkgdXNpbmcgc3Bpbl9sb2NrX2lycXNhdmUuCgpTaWduZWQtb2ZmLWJ5
OiBDaGVuZ2ZlbmcgWWUgPGN5ZWFhQGNvbm5lY3QudXN0LmhrPgotLS0KIHNvdW5kL2RyaXZlcnMv
ZHVtbXkuYyB8IDE3ICsrKysrKysrKysrLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0
aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3VuZC9kcml2ZXJzL2R1bW15
LmMgYi9zb3VuZC9kcml2ZXJzL2R1bW15LmMKaW5kZXggOWMxN2I0OWEyYWUxLi4wNGZiNGYxN2Uw
NWMgMTAwNjQ0Ci0tLSBhL3NvdW5kL2RyaXZlcnMvZHVtbXkuYworKysgYi9zb3VuZC9kcml2ZXJz
L2R1bW15LmMKQEAgLTI2OCwxOSArMjY4LDIzIEBAIHN0YXRpYyB2b2lkIGR1bW15X3N5c3RpbWVy
X3VwZGF0ZShzdHJ1Y3QgZHVtbXlfc3lzdGltZXJfcGNtICpkcGNtKQogc3RhdGljIGludCBkdW1t
eV9zeXN0aW1lcl9zdGFydChzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSkKIHsK
IAlzdHJ1Y3QgZHVtbXlfc3lzdGltZXJfcGNtICpkcGNtID0gc3Vic3RyZWFtLT5ydW50aW1lLT5w
cml2YXRlX2RhdGE7Ci0Jc3Bpbl9sb2NrKCZkcGNtLT5sb2NrKTsKKwl1bnNpZ25lZCBsb25nIGZs
YWdzOworCisJc3Bpbl9sb2NrX2lycXNhdmUoJmRwY20tPmxvY2ssIGZsYWdzKTsKIAlkcGNtLT5i
YXNlX3RpbWUgPSBqaWZmaWVzOwogCWR1bW15X3N5c3RpbWVyX3JlYXJtKGRwY20pOwotCXNwaW5f
dW5sb2NrKCZkcGNtLT5sb2NrKTsKKwlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkcGNtLT5sb2Nr
LCBmbGFncyk7CiAJcmV0dXJuIDA7CiB9CiAKIHN0YXRpYyBpbnQgZHVtbXlfc3lzdGltZXJfc3Rv
cChzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSkKIHsKIAlzdHJ1Y3QgZHVtbXlf
c3lzdGltZXJfcGNtICpkcGNtID0gc3Vic3RyZWFtLT5ydW50aW1lLT5wcml2YXRlX2RhdGE7Ci0J
c3Bpbl9sb2NrKCZkcGNtLT5sb2NrKTsKKwl1bnNpZ25lZCBsb25nIGZsYWdzOworCisJc3Bpbl9s
b2NrX2lycXNhdmUoJmRwY20tPmxvY2ssIGZsYWdzKTsKIAlkZWxfdGltZXIoJmRwY20tPnRpbWVy
KTsKLQlzcGluX3VubG9jaygmZHBjbS0+bG9jayk7CisJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgm
ZHBjbS0+bG9jaywgZmxhZ3MpOwogCXJldHVybiAwOwogfQogCkBAIC0zMjAsMTEgKzMyNCwxMiBA
QCBkdW1teV9zeXN0aW1lcl9wb2ludGVyKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3Ry
ZWFtKQogewogCXN0cnVjdCBkdW1teV9zeXN0aW1lcl9wY20gKmRwY20gPSBzdWJzdHJlYW0tPnJ1
bnRpbWUtPnByaXZhdGVfZGF0YTsKIAlzbmRfcGNtX3VmcmFtZXNfdCBwb3M7CisJdW5zaWduZWQg
bG9uZyBmbGFnczsKIAotCXNwaW5fbG9jaygmZHBjbS0+bG9jayk7CisJc3Bpbl9sb2NrX2lycXNh
dmUoJmRwY20tPmxvY2ssIGZsYWdzKTsKIAlkdW1teV9zeXN0aW1lcl91cGRhdGUoZHBjbSk7CiAJ
cG9zID0gZHBjbS0+ZnJhY19wb3MgLyBIWjsKLQlzcGluX3VubG9jaygmZHBjbS0+bG9jayk7CisJ
c3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZHBjbS0+bG9jaywgZmxhZ3MpOwogCXJldHVybiBwb3M7
CiB9CiAKLS0gCjIuMTcuMQ==
