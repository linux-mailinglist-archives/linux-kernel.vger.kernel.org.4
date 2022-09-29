Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EE85EF3FA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 13:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbiI2LKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 07:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbiI2LK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:10:28 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80084.outbound.protection.outlook.com [40.107.8.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EC96581C;
        Thu, 29 Sep 2022 04:10:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThpZ2px/wSuAhszs+GCAQD86mHZF1UrgGXqLmx8lHWd9Tqh7dBFRud68kHsY5JlQDY42X6au8heTu+QLcrxlvV4LUhqMfLncnsHFO5K+DIj9LEVPm06HwG0lsRvFR0mnC0PdijjIHDTfXSdPowfqUsmrJIDIuS7kNuEmGFKJPGDlKJUrjecHT239byy241pbv60Ifok+fSzJmxadoN3402e84DKowzVMK3mjtfCm86aetCoG7AdApfZHDcPgFF0R4sR59YNjT+6PB8CprMYKwsW+rDMMmG89sFAPGWVN9zWj+lmvXHyQmcqTR4apMLNfwQpB3QZwLRBRdgr8f0Awng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsHVZxI+ciNn3MhgrSb5mh1MXg1iiv23Jy+J70BTmlg=;
 b=DFE4ijmeoql8p69It8EldmutUKZEeBbvwCmeId5e+9Gt0wA9VOpHFGiQ8I0I1FPTIW7kXU2ccFevUPAsqOxyOXNuVMYqWcQDvq/tlnguiqqbV6cICe1ikHTsZ5r3xfXmh/cU4QeMGeX3FWLpe/O9EDtXvWU/4Ag7V+FtZOulsx3IAkC9Xs5SSz+UgozWzTMlsQuGPjcmGHnjueWPKW82QlhDuI+WAXieU72/8260m38/JQIkiOMsK4SschXjx4nOJcOR4cK+I73drBayO3FcAC6kVpUKK1cmA8xs3ARiA6ll8YNjFkyDEQ/0WqeNwxOaBSko4xrsBPWSTiBMaxvASw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsHVZxI+ciNn3MhgrSb5mh1MXg1iiv23Jy+J70BTmlg=;
 b=jmVSsaG6BWNGMtDnTpSheejd57zgkglea3IkzPOnXHHCAxblgHmSJ7hTAXezc4b/TP1y8Gj5m4Ny6wKjml38GTid/Lqkb8cLhUCquyS3bM0i/WD1PRli5tXRaRar0dXmsFoEMT+WoAbg2gKkrwP2mhWrsKHn/BIzjkPIzkJfl6U=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DB9PR04MB9497.eurprd04.prod.outlook.com (2603:10a6:10:361::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Thu, 29 Sep
 2022 11:10:22 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::121:6a2a:2d4b:cb8a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::121:6a2a:2d4b:cb8a%8]) with mapi id 15.20.5676.017; Thu, 29 Sep 2022
 11:10:22 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] Revert "serial: fsl_lpuart: Reset prior to registration"
Thread-Topic: [PATCH] Revert "serial: fsl_lpuart: Reset prior to registration"
Thread-Index: AQHY0+EeaAH9c/DrIUi1YG5YmLZWk632OyYAgAAB3mA=
Date:   Thu, 29 Sep 2022 11:10:22 +0000
Message-ID: <AS8PR04MB84044F397918A3475B5D8D1D92579@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20220929085318.5268-1-sherry.sun@nxp.com>
 <1265873d-28f9-d39c-5cce-858dbed1e8e8@linux.intel.com>
In-Reply-To: <1265873d-28f9-d39c-5cce-858dbed1e8e8@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|DB9PR04MB9497:EE_
x-ms-office365-filtering-correlation-id: eb760671-d11a-4b74-33cd-08daa20b340a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w5dpelV8dFvlnXOY6d83hYgq1msfh7552Xuny1W8LNHpGHDj9hbW0qrt+xRY79V7id6Gzxsf/xzWs+mXRWv8e8WKmQMxNb/FTfr7kozqjXxCEmAbSJDakBA3oZMHDznE9dz1ox2Iuug3a6SfJf9j2oKbe49dG8Fo5eRZb4D8A0x80C+kwSqAOJeVRMWTtozOGvUQ1N79Da7XgUYWJXKGr6J+l9bnH7DEyW7knz5bnJhbB1cU5vsxPF37v/y8jrhEzroYC0Mj9ULL3FeCnb9sdoXbU4eptahtYwlQLZ/F1BZOKBDYqDZqhWAXn/jgLCPTk3USoN+zqqP+5Z2nD1tjGbypizEzraNhV9lOtSegz+QK1ZxSuBgCmfYVL5Ex4vZURpMjlLOooJnj2eajMFlfcZP/XxyMB7+Kzm02pQ8iDV5TiaBvareb094moxfaofo9S3mSiga+dYssC74FRilsDNKB38Jg1jYaSO4RWf0/y023pyebU0SiQb8vWaAsiDhlx0sC4gEzIt+eu10aR63+cWcvYuJic4lWG0Lwvkmfu+htp3JHQTFKtrCi4yNA9QtLqWrKnPPvv1aCjkb2PbSma6LtSW1lI4cQPxpS0ZA6BEPYCOWoKx5UjeW9HjZH82c12qSKSE6unVNIfJKCDfH3wTMdR6lA36A5nQ/GZXGiYju0yi1LQ9kUye0TBbweDeES8YJXMtjA4NDj8F+k+3dLaZVkv5mZZSuMXQ8N4cCyir/f4dyPwlFcJsZRp3V6PwFzZt4Vqd361CpiRO7gujo7Yw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199015)(71200400001)(2906002)(66446008)(6506007)(7696005)(54906003)(83380400001)(478600001)(38070700005)(38100700002)(33656002)(316002)(122000001)(66946007)(8676002)(76116006)(64756008)(4326008)(66556008)(41300700001)(86362001)(44832011)(55016003)(8936002)(52536014)(6916009)(5660300002)(186003)(66476007)(9686003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?e+qkrp8mQFXKXZbv3gM6nbswNJJ9vFp25qdpWmL+ADs0y4aRieUxfZChly?=
 =?iso-8859-1?Q?aBJR2QykQ0MVkwj06AbRD3/NbHZuHQHNl2Pg3myCfUtfM8wmc31IcPlcDg?=
 =?iso-8859-1?Q?Psdvxw53eoqx3nQT99L9wl3V17TsElHa/4YSE/b9kM5FQ/aj0PHXj57g4d?=
 =?iso-8859-1?Q?o2sxTE5yvrcguA2Q9RTdfEmivwneBwBLSGKH1IVqnp2LPRVRgf6AuVp2m8?=
 =?iso-8859-1?Q?H2MkrdYXYKbgDhDNMdlsRVo/Qi8Tpk6lJnEeLn7sGbUHJm0bvfYkUgM7Ij?=
 =?iso-8859-1?Q?cp0i3dl7eTLLYwdm7j4gHvUhzgbuxCIhPw8jfKjoIylmkMg7uoKQtqdZl5?=
 =?iso-8859-1?Q?idRUxJlU+aKcpq+hy9mF8PcQjIrJMM62INhexfiJQEpds2FCYpG0n/amYc?=
 =?iso-8859-1?Q?FwkeciKYzRbXZQXNIdejvjca8CEC0AD19FhRyUPyKlJbKkpEX8AiYle0n8?=
 =?iso-8859-1?Q?ft+TcOrvhCNJBA6hmaLBg3AFiJs78qA3vz8uwAiwq/hhx6Oq/IvWSf7NQr?=
 =?iso-8859-1?Q?VfucfAoT/JQZ9TfGWI7vICb5PDKI1cG9koUw3kiwJUeNoEXtkihijLoBFU?=
 =?iso-8859-1?Q?T82TB7WGUTkjIV8oGLotdBlNtZGgFD0B3sTH61zzrWkvLEOnXINGCPWOsC?=
 =?iso-8859-1?Q?/WTgzG1WWWry8U5V1QvWfmyN4oA+3LPMSulBeplg8jw7O6ceyF4i540r2l?=
 =?iso-8859-1?Q?u3sy+SYeGF8QkOGYKTgVdQwvz+IPOOd31YQXDimwmG+X88h84GckD2d5tK?=
 =?iso-8859-1?Q?fn3Chk+0EqvZiPWX5dBNDlW6mguFVYxg97bdGXyci/lMOoTnK+JRlkJ0Rg?=
 =?iso-8859-1?Q?3yqUf0dpVSk6hRNh+5xXw1NxfoyiEQKPAaMwWYDcqLMBqdWLGsNZk34GJG?=
 =?iso-8859-1?Q?LBDmbcoDCE99OfHlsczF7kzRfBEielU5+EGy8czfPd/oPuIcokyS5+boL5?=
 =?iso-8859-1?Q?cNOYMDOdBtNyxDw0RLAjK0i/Yhs0av0gmMXqafrNGQqKMGuzurK/7vG6jj?=
 =?iso-8859-1?Q?7+nKQjB5fo7k/pTFyT7379/zD9+zMxx6mmD/bik5jW4xDAji9WeO6T8tUE?=
 =?iso-8859-1?Q?s6THBWg1mmAY7u06BEYgBkeIM/bQP0XsfmQSZ6V+8L4pSr5mcpw4Pbf7Ss?=
 =?iso-8859-1?Q?hHjdSvsIM1nBi9kP5iJNQTL1qaXgzrikvEmRTuCYkOABZhpuMJ62d0nKOG?=
 =?iso-8859-1?Q?l+BjQziNVx65Bo1tJbVdfpWzc1QMWh7z5huuhto6z0L/gKVUa4YKAQDqZm?=
 =?iso-8859-1?Q?7oMn9Iwvf9Q2AMtJXoediTYoqDzPlflnfEzc5rsYkxTG4vPUILmuMtpf3x?=
 =?iso-8859-1?Q?nVZfqmV49S5zYiy9PbYwP8tb+FvsSFpqEpLMoGVTooGr0GY7hekMWntZvM?=
 =?iso-8859-1?Q?QN5w31N7lHCiIxumVtufmirVw+jDPO1WxUecTd1tGxdkNY1eRtl3MjqW/o?=
 =?iso-8859-1?Q?cXSk69FwP85QF1aLOkPHEstmN71BVnbs7V2zm6Ynu47OYCTew3mdBv11yd?=
 =?iso-8859-1?Q?pU2+TG87wczC42kYAB41GW/SQP1pfX1J0RVSHgyi19T5qD/Dp1Q+S5IuBo?=
 =?iso-8859-1?Q?Mb1bHO5/wRhxDmaRBuAORG0fTschCA4bqWxhPyGMjIWCp+RA+skgnPgtK3?=
 =?iso-8859-1?Q?WVNi/OQxjqJvsPnkLx+SICWzXDsKlR9Rg9?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb760671-d11a-4b74-33cd-08daa20b340a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 11:10:22.7457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a7+pMj380yTOLb617siI+x0HoPtlj1YODk/Ox0FRtDdppGswzoJmUVyXoUDji4EgmhnvIPkeRODSHJY/exmBpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9497
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>=20
> > This reverts commit 60f361722ad2ae5ee667d0b0545d40c42f754daf.
> >
> > commit 60f361722ad2 ("serial: fsl_lpuart: Reset prior to
> > registration") causes the lpuart console cannot work any more. Since
> > the console is registered in the uart_add_one_port(), the driver
> > cannot identify the console port before call uart_add_one_port(),
> > which causes all the uart ports including the console port will be glob=
al
> reset.
> > So need to revert this patch to avoid breaking the lpuart console.
> >
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > ---
> >  drivers/tty/serial/fsl_lpuart.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/tty/serial/fsl_lpuart.c
> > b/drivers/tty/serial/fsl_lpuart.c index 67fa113f77d4..7da46557fcb3
> > 100644
> > --- a/drivers/tty/serial/fsl_lpuart.c
> > +++ b/drivers/tty/serial/fsl_lpuart.c
> > @@ -2722,10 +2722,6 @@ static int lpuart_probe(struct platform_device
> *pdev)
> >  		handler =3D lpuart_int;
> >  	}
> >
> > -	ret =3D lpuart_global_reset(sport);
> > -	if (ret)
> > -		goto failed_reset;
> > -
>=20
> So the problem with this being so early is uart_console() in
> lpuart_global_reset() that doesn't detect a console because sport->cons i=
s
> not yet assigned? Couldn't that be worked around differently?
>=20
> Or is there something else in addition to that I'm missing?
>=20
Hi Ilpo,

Yes, the root cause of the console cannot work after apply the commit 60f36=
1722ad2 ("serial: fsl_lpuart: Reset prior to registration") is lpuart_globa=
l_reset() cannot identify the console port, so reset all uart ports.

Actually I've been thinking about any other workaround all afternoon, seems=
 no other good options to me till now. And after a further check, I think t=
he original patch is not needed, as uart_add_one_port() won't open the tty =
device, it should be safe to global reset the non-console ports after uart_=
add_one_port().

Best Regards
Sherry
