Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D8A71600B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjE3MjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjE3MjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:39:05 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on20726.outbound.protection.outlook.com [IPv6:2a01:111:f403:700c::726])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069DFE64;
        Tue, 30 May 2023 05:38:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICIRiPmGBBoThAfgATMX36p9oIcAbdjoz2BSn2h9zZH1sw0PPf3J3Rd/k5F6ngl3l4sxuoUQ33CLLGin2EATqdAfCb9olMepjNGSkCzOTT0nG40Gch6JK0ZU4E+q47BnoWSKhHcJDrvCnWarSN19exJjMgOn6wr+XsADWchsSvYt5Ce3xsQNcnUYWNmlRiBQCWEG7H2DZHv/ECWlzwwW7Jzcvs619OzHsV18Mh2viyUP6RFmFy4Wne2RlOQjI6m3UcgZ1l1ECHTuUgEujUjiiMD6Y43Q9TJHI0k5b9FY5lC4uwtJo1/JGvwKfMCPFXVA2IGpSjY4a1AwKoQhD7OWAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuntB6zHtTS5UJBwxK8lSz4ZI669ELMqKVVtcehAKd4=;
 b=GPgeacrEjIyZhaWM+KDJsU4ZUR9aCgwEZBOcMJngM2kC6knICPvUaizi7Zq8RI9Q4D+cVy/9FgP9qjxqjnF/WGMTWZaI8TcqHkDJSecd3UEmbK6YkmG4g9foA5yChGVHG6NKV35o+qotBaD1St3Q9IqRhwBLV7te89x4nwKNmYWBkfC7HWi89syqZpA4A9E30Sw+V8cs8v1v/Kh+4Q9mmtdSIQOorp5lWH3GMv8l/4s/V7kGCy14dc64xJAoyqOPZoJS2Zuz/1L3biuFWBNp+XGHJCps96VzncaCcyydmlwbalPeSExCSS/Ta+BpAf4dwRXBEosTHHgCbhnVlrW89w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuntB6zHtTS5UJBwxK8lSz4ZI669ELMqKVVtcehAKd4=;
 b=T7s3qEMOtxcfh8dVFT+LGpbkCiapxeF2JbA5Jw9TXH9y3rW+gKhjjIAxKpzmLagC3DHtDgdtqzHhFIhlkdJvJftF2y3YdTHGI1bB2/OzNM15SVCDluuY3Ap6u4pQs4jlOU/tRPl9XXZnR+GaqpJK9GMV55YKicDSawkyUhIw7BM=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB9665.jpnprd01.prod.outlook.com (2603:1096:400:22d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 12:37:33 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::bd0a:a38d:b4d2:5d2%6]) with mapi id 15.20.6455.020; Tue, 30 May 2023
 12:37:30 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Marc Zyngier <maz@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zheng Wang <zyytlz.wz@163.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
 {modprobe,bind} error
Thread-Topic: [PATCH] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
 {modprobe,bind} error
Thread-Index: AQHZj99wvrGBFYOn5Ea9mIuOTwGccK9wyqwAgAAi9sCAAAmpAIAABFqAgAF9FPA=
Date:   Tue, 30 May 2023 12:37:30 +0000
Message-ID: <OS0PR01MB59227AF1F83A73620179CDF8864B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230526143615.372338-1-biju.das.jz@bp.renesas.com>
        <20230529061714.GA25984@pendragon.ideasonboard.com>
        <OS0PR01MB592296756992262EC6D382D0864A9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
        <20230529085656.GL25984@pendragon.ideasonboard.com>
 <86a5xncxhc.wl-maz@kernel.org>
In-Reply-To: <86a5xncxhc.wl-maz@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB9665:EE_
x-ms-office365-filtering-correlation-id: 9016c0d9-5841-473f-d783-08db610aa25b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SgPj5tSu3Iq2qDF7bDwv9rEsL0zo55K7ht6jBpwO18aNx9WdMfykGWIkTzp3rajaOJ7v9cH4f2t6MPh2qPQE9gZiZSo99qR0aamUUVwhlEZldtu/Yag++8BgW/7r0HbAVsOdND+iltoWUm7td/I91x6SnYHCoTvu1nUKDVxFeBbO762BPRiebLkgVfy7Xwzmirb4nHhFIea76sLcg1CJeuBJ2i2wcI+Ej5z81regHaOys8y6sFOXL7j0I5LPW9/wP9jWdIRNFM5J7EgZl4kqGdxsfBEDW2qM+1biT2+7UpP1ocLF/Wbj2My6lnx2MrGrm0pTuBNOORHLwJTCbtRfmNkBhSqkcXS8odOxCeCcH9A5/QQzY8UoFyYO6W6QOWX1TtXZh9fVkQFQWaYh5T0QNZRgPdcnwjy3eAiax5ENJIRf4kUF0xd4Is9q/gh6bAtQjFHyGqVz0KnrYlrX9aP2Q+mm4K80hmetDkM3tJ7YAPp6i7r6wW7Rbuk2XA9MqCryr3mbW/D1Mww/6y51P8AV22O19jqhL4g5IWC32dG3bshP6HjlJjBIbbSlo6Tt11Wd0q0d02Tn7CLw7yl+CjyVFnSXhIbY/IQ8NGUTTxKol7I8sH+Apwp6MpXyWNR70Vpw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199021)(71200400001)(478600001)(110136005)(54906003)(8676002)(8936002)(7416002)(52536014)(5660300002)(4744005)(38070700005)(2906002)(86362001)(33656002)(66476007)(4326008)(122000001)(64756008)(66556008)(66446008)(76116006)(66946007)(316002)(55016003)(38100700002)(41300700001)(186003)(9686003)(6506007)(26005)(7696005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B3Vg3xpriwtLXO2amJvb7Fk28jaL8ge/Fc32m3hcvvvMEhizH8pXmDFF1zFe?=
 =?us-ascii?Q?JjaRvfTxYTvn+IANJSTg92FaPpvaixMH7IkTj49GLBz2k1i7fPA8dENedMi+?=
 =?us-ascii?Q?k3fSaHXPr91jHdZXb+9Qxz9r0nXF43hhOMzf8DOPU880LyVZiZ3LiIYVemeP?=
 =?us-ascii?Q?h4SkiIbGMubsop6zVezEPhowdapW5KtGZUgDW4eSSYESlxpLPrKlzA7bJrDv?=
 =?us-ascii?Q?fh/4pY+QEAhbO2SfcKsynhHGJGIvo3sPWtsIkRAUJELQ4tDVkDQV1mucOkQG?=
 =?us-ascii?Q?O3VjDU2DzCm3UR9uCtDjWbk8tbnpjDYiGGCr7flXNLQc7yqXdpMZSvAW/SIC?=
 =?us-ascii?Q?pbVKMhWY4EPIW6PhfJOTwY41M8+QydE9vU2bal1DhtTwyMbJIP56hBvexYX5?=
 =?us-ascii?Q?dlR4eE1Dmp1WVXQ+dGY910J97Y33PY/CmuMRAReuna1aR1Ty2JiGHMiHR9Ja?=
 =?us-ascii?Q?qV87jwNDWy27opAe2Miiony911r5NI1mqaf0Rz2JPXV1HXwiQTxKT6hA26nn?=
 =?us-ascii?Q?sG9LZQasJ6fH5ykiH1dVsf4Hv+iGoS7nA1iDu0ycJ5jd+MhooY3zi2b6xXB/?=
 =?us-ascii?Q?YkkPINk2K9rNnQzImpHVah5yl5WC/mr/4yxr0rHHyHIC5N47sDJbVaUVqNN/?=
 =?us-ascii?Q?3GFVGB1jG6Uy+b153bIDZ4/SVAp/MxBM7QXI1liOadS/kqOpv5eVxohlXWv8?=
 =?us-ascii?Q?76iOheiDDxRLFl0vRzTgdIPhgw8w4zUr2PqKpnS9IlkKvrrjOKjcF2mgCrRd?=
 =?us-ascii?Q?M7QhDvEzVJyBCdzLzGJwYRyx3HwbVi2WVVaEkl8gDKq6l3hyMHtzoTZTt84v?=
 =?us-ascii?Q?JUo5u2qaUt0+/fbc1V5peCTQ7aOGNfJNF5bVOzvVUlbzKoB68BbGUSVdwHgI?=
 =?us-ascii?Q?ka3GWZ5ds9SBAFL9QscBrF6qCpoqXSmlVbfmxtRXYVZTbEfxn7bnY7mWDNlq?=
 =?us-ascii?Q?wME/lcWR5dlLDFK+ut0nG4VT2qvL6tBPTkBWxyQR61fLwNK7mYQF30TJKDGU?=
 =?us-ascii?Q?7HOXkQwDJTWh/FRMG9xIZiVip/Ff8hh30uHtFoBdgue1ARbzzlCuzS0uiSWo?=
 =?us-ascii?Q?t/A3Im1wtSZprzXLibaVhiSCpHC/CXxQkUuqgMLn/1DSOUMGmHj+5n0xrkC3?=
 =?us-ascii?Q?vmrwKJPydVOcoulQBK/BwQuBfj8P4ylRzfFoaoWKLOmydI3+od0G3C2fCqY0?=
 =?us-ascii?Q?OqMRFAcC5PecC8Hb9P1nxi3iU0vBfR106tZ6ib8mbXJ7FDBfPE5Y3uX4B2YF?=
 =?us-ascii?Q?gpg/n0GcA/BpmOzgVchQamDXj7Vr1/b2XfVe2a/egV2qkdgsvUo/pg6mci+D?=
 =?us-ascii?Q?3R1TAQYy3xc5kR/cZr9Tr7PcGxP8TnXlrOEmGFxDFnH568DrJM00ofeAtGd2?=
 =?us-ascii?Q?9nC/xPQLU983oM4WgeYLxhpiWakAm3HQE+ylwELcY+YfFbJnG58l3n42BhBV?=
 =?us-ascii?Q?JeQwrahSGQjOw21YdpGorArawBaKbIVBWKY6bIFcuK8ZgOuJnqh63JC5SfMe?=
 =?us-ascii?Q?Rju8NZkELZUNPIQJsrXkQVUVzwimw9D9zVcY/PyOgH/jtOC6OY/T0eEYrbsN?=
 =?us-ascii?Q?pkSBB1tMPK8PDWMJ0eacwPdtYPf1Z7v4XrOOArf4Ot2prqXVsnyilAqqw/TI?=
 =?us-ascii?Q?gA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9016c0d9-5841-473f-d783-08db610aa25b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2023 12:37:30.3995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NYmU0zpxdoKUifIp49UeDEBKce0Qkk9uO7a/gZK1HoWAttS8NG5PXKqLHjxVpKYq/+b9prpB5IYPfT7G1c/lSBm+F3qqOxa+methg4H2ryo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9665
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent and Marc,

Thanks for your feedback.

> Subject: Re: [PATCH] usb: gadget: udc: renesas_usb3: Fix RZ/V2M
> {modprobe,bind} error
>=20
> On Mon, 29 May 2023 09:56:56 +0100,
> Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:
> >
> > The name is just informative so I suppose it's ok. It makes me wonder,
> > though, if the usb3drd driver shouldn't register the interrupt handler
> > itself.
>=20
> Well, it registers it itself, but pretending to be another device.
> Which is wrong on many levels.

OK, Will register the handler in usb3drd driver and expose register/unregis=
ter handler API
with cb function to avoid duplication of the code with renesas_usb3 driver.

Basically, there will be 2 exported functions + 1 spinlock introduced in us=
b3drd driver

USB3DRD driver register the IRQ handler

Probe/remove from renesas_usb3 driver register/unregister the cb function. =
Whenever there is drd irq
cb function will be called.

I will send next version with these changes.

Cheers,
Biju
