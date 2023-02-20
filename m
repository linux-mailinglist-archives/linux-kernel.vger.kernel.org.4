Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA37969D1DE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 18:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjBTRF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 12:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBTRF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:05:56 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02olkn2043.outbound.protection.outlook.com [40.92.50.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4A220549;
        Mon, 20 Feb 2023 09:05:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUmvJy9U95FBy+ovmMMRGfKuNFnu+EhyUuaD3X9WXniPGmcMKjTwUCYuUEqvw2sUHegBa2Dz2kefzVNdJqt541mzt7579b9u/PYjE/x39jIWnHsj5AtrlOSTnaMd30aJD3cHCbJAeCS1N5Ooy9CtQVM12T9B5hkdSHCV39po5jNBFh862Nvu32KISQo4TsyHAkOPuCRMu8nRVriyIZ1mDcNmZAITVynhPbDp0M4yJ0G/tXWDleag3kJ6L8jdxsxD397ufWe71Ye+faQqw0m0npu8L6rkiqyByvdQ50CqTgko60vAhQkrLd+2at+kfoijp6dBFi7daKa+Sdd62MYb0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKWczuGRG4c24DYZG7A+X+rwWo6Ycti31Kuz41J9WTg=;
 b=SjQ+a317QK3kdQtqCgiha6kQIU8ebSt85qzWc4/9KwIuLCXieKdntv7PLjohzQt/b+w/PEjgMVIrHVF1NrLtJcLCxfyf42w86vmYFm5rgKfJukkeuX3FKmQcfJOZMYO6UbkwgpcP016S4JK9fiy5TfdtlwQtN2ogH/XGP0H0yix5i4IvHgMFqZ/JhVe0bsE6sJdSiDlwz5U+0mTBQEbg6+OoVw6dnmm4YR4HLQRVrKoUUfPSsJdwub+aLwskhJEdtFXMXVIT+Ms/g+2rrecAq3KpEuM4EsIGRHMLR049yoXAeqhEiliq6JkxvtNWWon/3IRz6SrJCEJSLm2oeZinLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKWczuGRG4c24DYZG7A+X+rwWo6Ycti31Kuz41J9WTg=;
 b=jW3mTy2JQJHmBeYG0X2ywfsN6x2FRUSabc0auZJcL+qVGHok8tivzgv25PhqYAjBWljF7hSoVmjox7YL+JTaC35JmLy/v61/77SwrsP4rfWcjhIi3+15PJ7ECxqIPJNRb2CAWAsRrClufJsBwSx7g0btIHYSgit+Jerwame8Y4v0YYHQuwOew0exZP47GNW1UYb4BLlJVgET4d17ap+rMDcPOwO6cPd+GmbmOpeCFfeLYeRxnd/7NTmvy4cu7M6EsVkZ1e+XZ4RMSCo+ZxsGszEeBptl2mcroeHeD2kRW6PIwC3jfaCiU6u2DgGL39Xz7JdXhWHDg17PxsrV6T19Aw==
Received: from DB6P189MB0568.EURP189.PROD.OUTLOOK.COM (2603:10a6:6:31::16) by
 VI1P189MB2561.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:1c5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.19; Mon, 20 Feb 2023 17:05:52 +0000
Received: from DB6P189MB0568.EURP189.PROD.OUTLOOK.COM
 ([fe80::4a20:e1a:db8c:28d9]) by DB6P189MB0568.EURP189.PROD.OUTLOOK.COM
 ([fe80::4a20:e1a:db8c:28d9%3]) with mapi id 15.20.6111.019; Mon, 20 Feb 2023
 17:05:52 +0000
From:   David Binderman <dcb314@hotmail.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: possible bug in linux-6.2/drivers/spi/spi-sn-f-ospi.c
Thread-Topic: possible bug in linux-6.2/drivers/spi/spi-sn-f-ospi.c
Thread-Index: AQHZRUzb4j5iSQysFkim+9O41b8hsw==
Date:   Mon, 20 Feb 2023 17:05:52 +0000
Message-ID: <DB6P189MB0568F3BE9384315F5C8C1A3E9CA49@DB6P189MB0568.EURP189.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [ZRGhk7sTQ+BMItuctEWXfsbtcGBhkiJH]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB6P189MB0568:EE_|VI1P189MB2561:EE_
x-ms-office365-filtering-correlation-id: 7b0efe1a-7c8d-4232-af8d-08db1364b929
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PcUSiRB3A7CZQEWJBh35TdHUzQCxExxFSxbQEExjoWFOJzP8AJiwJSwccmbdzAekb+XfBdc0ehuFkFs2axi+/wDaZdPgA0rMZ8kbrJQEi5tOzYRiU1PSMzb6vPUI4rnVlC6/shhW1iPQzvbFO90PlY3RvbnDNYQt730vXaubJzo8nDusff8m1d4JoLDHb5eiBEFVUNhjdVgrIEiyVrjMNo2vNR9wiqicQYFlGK46B71tDUPy8ZwTotRsDYO3l3G4ZH9OLLXtamfjxFWg0pKFKdZjArLqekMKN7N1eQaPhufOrNad5BQ4dxb93LBGwwDsAt/5JOAjBXEgFBNhLFpak5+M9WbuSZAU9kcpVe0hwPe/IIlq3L+cNWJXPfagGNTKtvevmhYv1wKwbgCxiYK/Fm1NA3JckUeFRlLB6sUPfascJxxfparwy//As9BdoIWSB+kBACCBehRXU1xEtTQBxGUTeKn3A/dtUFcGGjVbOaTuF7RakAFaPQOrV8wZFX3MK6Tw/eRB8YB//r9gfIkhlZZ+TDvUL0Yn68Y7qDD89gI3O1+/MIrPJQGmLAAtzg8iS8VpQVBinjrpBZsi7FG/UPB18n0VX57+9JnFectqmYQ=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mEihLzO/yuSJR/k7t8QCgOabGXjSFXYkz+WQqm545TKX8DwI79IgOOoQoD?=
 =?iso-8859-1?Q?zKPHtF/gnArQEtiYDBsdZ0zNqLmauAq3OAt7mlHqgB2QNRR0OypUtldPG6?=
 =?iso-8859-1?Q?IDKOhp+FOajnwERuCNlqYseGhCZWGPuDvaf6rr8HATDXjI3ui31gWSU5Bg?=
 =?iso-8859-1?Q?89a/CY87KP3syLgC/94+lS4buBZZFOqNDfUfCo5Vpae4Gwz3MpPMg3+IYG?=
 =?iso-8859-1?Q?onvfFgttIkk6i+GV/SsXR7PaLQx4kwT9oObU1t6gPzLa+J5Bw4YxFBHZmI?=
 =?iso-8859-1?Q?jFPK8VZiwOj5792wc5qj9n0kLtmKTGi15qT5fldJN2fuvJFNW7Udz9IGT4?=
 =?iso-8859-1?Q?mSJPW14pPMo+ta3vl+awKTs2uoZd8wTKPr1NLp67vmRWoJHdZ9MASErMff?=
 =?iso-8859-1?Q?3baeVAStnyJlY+NwxALfUOrJ755uAHiJVmXTi7oUsych63dxUKKan+AZDu?=
 =?iso-8859-1?Q?MXICv130AiZ8ijdGjcIKmD6nrVSLfWQZeuRT6gUFZpzD/CaEXoVsYoaSGM?=
 =?iso-8859-1?Q?TZZ+FXdGALyLmbiDKRPo2Tv9tgW00sW9mBRoXSmpQOqjVtZrKs8NhcuevY?=
 =?iso-8859-1?Q?GxbaxDalOapx6kg/0n76KVWqr4CSjhZQzNht9D/P8HkWTcgsTPr0YxnS9g?=
 =?iso-8859-1?Q?WJhnT5v2zMvJSahiR8DcdhNWO7b/Ei4Jv2VRVeXmvcD9fGEB5zRYr9/Vlm?=
 =?iso-8859-1?Q?eIYn0YSY5HrJteCv9x4uHfdnRIDuQKxfhjZJ8jB7+B6/CRHBKD5f5i97tq?=
 =?iso-8859-1?Q?K5xLDE6Ojz2ZN5yrVYGd0aAjl/5e1Ng4s2KuV67Zvj8QufBYk223iUgyJ5?=
 =?iso-8859-1?Q?5nBxNIYhiwm8nlgUUgpDg4TqjmD2C2oupgkkDpq+odb5Rtjae7HrDPtxno?=
 =?iso-8859-1?Q?8na2FFmJ1yGp2EpNG708HU0zSvV5MuiIH+dlwORYHb/QN77MgHXo7TXIgp?=
 =?iso-8859-1?Q?A/kBYOU2GsSAHsuV0Gxi2063EADgS5Ob9Nx6/5Gf/7iwiD1BoszvnR2Nc/?=
 =?iso-8859-1?Q?RzHyGQj7XgVFB+oeiV3XVRPWypQprRfWPS+8myPRBoYx2yvEPzihF3xZ/5?=
 =?iso-8859-1?Q?nkG0iRYLsTLuQvkXp8pEM9oqmqKWUDxy8nOFTvpFj/WUZc1ffZ+EsK+El7?=
 =?iso-8859-1?Q?m3Ont81SnK5XVE3mxQlkYKhN9aH5+4lg/MusSfzC1tB9W9npdiyYYiEwAG?=
 =?iso-8859-1?Q?2v0e8DP0hXS8YMyIwgz+GmjFerlvHGvlBb4mcX8TrcNlaxs6LH6MSbDBVc?=
 =?iso-8859-1?Q?CjZvYUkTvN9pkaWLk7ebfDlv9bMdnPvsF79L2RE7GKT1f7s7Yyu1E1fzl5?=
 =?iso-8859-1?Q?i4Iu?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4734-24-msonline-outlook-c54b5.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6P189MB0568.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0efe1a-7c8d-4232-af8d-08db1364b929
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 17:05:52.6606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P189MB2561
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello there,=0A=
=0A=
Static analyser cppcheck says:=0A=
=0A=
linux-6.2/drivers/spi/spi-sn-f-ospi.c:614:31: style: Same expression 'SPI_T=
X_OCTAL' found multiple times in chain of '|' operators. [duplicateExpressi=
on]=0A=
=0A=
Source code is =0A=
=0A=
   ctlr->mode_bits =3D SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL=0A=
        | SPI_RX_DUAL | SPI_RX_QUAD | SPI_TX_OCTAL=0A=
        | SPI_MODE_0 | SPI_MODE_1 | SPI_LSB_FIRST;=0A=
=0A=
Maybe better code:=0A=
=0A=
  ctlr->mode_bits =3D SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL=0A=
        | SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL=0A=
        | SPI_MODE_0 | SPI_MODE_1 | SPI_LSB_FIRST;=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=
