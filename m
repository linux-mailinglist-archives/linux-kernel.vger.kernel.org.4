Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3DA691D09
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjBJKlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjBJKlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:41:15 -0500
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2078.outbound.protection.outlook.com [40.92.102.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D220F173E;
        Fri, 10 Feb 2023 02:41:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtV/uFlYI5Fsqh/7CltyYKcRgg8dHU2uEaTSAGuaQOegmd2gKoysJviQPLYjtw4h2Dv48Vk9VKTsbSEAwzZILnoGyIT0NUBupP+3bBT7FeTRfdRidcO2WJuoNY6asxYg8C57btD4aMlMKhg9ePBDuGQeWArA4mJogcYJMEovuXcVEyXPvpeFmu16FHNfzbyxG3NAkwqoupqGTov+/uBZfLDUuZFEHh8DkEVVoG6VbnzVtR4JMwZ6AGo51ODj8rf/578T02h8woHiRPldnnnt6eT4Ucq3cuGzpbYWzPMqNBGeLf6bXBYp9+MB0sdYPcqp+KJyTtOmRswikZeBtYSf3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S78FLvnTsuUACB1y3iY5pPmZMSX/X5gCYsBrBJHUl+w=;
 b=Ctq6Zk9mtQkgu+NHY/VZ01RpvoSYtSFF7Eat+lWCBlHlPSq3E5qAni4aHQ9HwB+Mjz+RJ2f1fnl8mneRNSvq6J/TQpMauqu53V1c7AlOBaGNzgxVyv/LsV0qqg6DpE3R6K2GT25yzF3zp7lSUBvGZ9LNr1+/CQNjhap06/yu4URC1GHdNTDSKw8AAK7nDTeYsnrjTRSeZWyRC3z+GZHHzERy5j5XXTOi9Ns2nsgqGs9aL1Fjg4eGdBoUMMgGAQGil3WpZzJDwMRMixa1h1oozhaWlyaamM3/WehGJfkTnLi43+UrP6Paee4rkJPdJuRIL7RJJ8ufrgDc3qrF52zU2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S78FLvnTsuUACB1y3iY5pPmZMSX/X5gCYsBrBJHUl+w=;
 b=FJhtWwjRCNZrFf8OIiykVXp+H0pC9KahdZvinuMIOOTj0FxYhwWTR9SDQRCEMax6uEbyZN/mcyz/1+bGM2RZhRTo0V/869bgTPQAlNv43ThEOx8HV2QUzxU/BUlYmdxmqxp4ziSMk4I1AFf8IjayiB7pCMe5EIaSqfqrOMsOLAL//foilfuZGnXaiYJ50UXkwW3zpjUbY97bfd+M3WT3os9wuBySE2pPNuCn7gb5847EvB1zE5WWcf73br+0lFY8hPwc4Teicgm18d7lwKeAQX6jOHuF3UClkKtwPe3uetzF7l9ED3sEsiFF/3+XSDdoghpuV3Pw92fpKbGxyV+VAg==
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2::9) by
 MAXPR01MB4120.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:1::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.5; Fri, 10 Feb 2023 10:41:08 +0000
Received: from BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::9dc7:9298:c988:474d]) by BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::9dc7:9298:c988:474d%11]) with mapi id 15.20.6111.005; Fri, 10 Feb
 2023 10:41:07 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jiri Kosina <jikos@kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "ronald@innovation.ch" <ronald@innovation.ch>,
        "kekrby@gmail.com" <kekrby@gmail.com>,
        Orlando Chamberlain <orlandoch.dev@gmail.com>,
        =?iso-8859-1?Q?Thomas_Wei=DFschuh?= <thomas@t-8ch.de>
Subject: Re: [PATCH 0/3] Touch Bar and Keyboard backlight driver for Intel
 Macs
Thread-Topic: [PATCH 0/3] Touch Bar and Keyboard backlight driver for Intel
 Macs
Thread-Index: AQHZPQGZTwQRpFeUtk2HcjRMT4BOJ67H+ByAgAAGMAA=
Date:   Fri, 10 Feb 2023 10:41:07 +0000
Message-ID: <57D52CFB-228D-4071-94CB-D32883BF872A@live.com>
References: <E5D8BEBA-3C5B-460F-BD2C-39470A793CC3@live.com>
 <CAHp75VcPPDTmpx9jpu3ZoaVH_xBgtaEbDQcJJdqcaXi1J+_q0A@mail.gmail.com>
In-Reply-To: <CAHp75VcPPDTmpx9jpu3ZoaVH_xBgtaEbDQcJJdqcaXi1J+_q0A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [Q6szODXhu7HIA2+8unjlxcNFzWvsjPJ8]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BM1PR01MB0931:EE_|MAXPR01MB4120:EE_
x-ms-office365-filtering-correlation-id: 4fe113de-e439-4cf7-5255-08db0b535163
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gfFI2G2/CWubwLytTI9bixrmDy8HAaVIeNB7AyF36cDC/iE0oBsy3kRBARpOdeaFdCCO5y9qxbDJsrju89W6HSz1X2Yy2kA33Ej/CxFzmWYHrxnBRdVHpGEo4QV27+IPwreDGq4vhoCNqMlVjywk6TstcNAc1nUFWJI8gbpsLreLqkq5L/kqVA4RxHT3E4j9UDIru3FEBVisFN9pRo+5MtJyWzMo5CFZaN8eSYgvqO7gzaL/EFHL6MK4IcaOrV0xZevrKd/2VMLYISHwdxQ6LKbONA+3ulb0WaqwD2FQn3+0hb5N29H4idNUaxOMC67BOh7AyobP6e1czhBnI65/O37NkoGfRxYJNKc14J2IRsSI2Ml7ZHvwKrp20aDiGhUu79MlqpeUWlrZM5eojyd3yW25myKg3Mc7J+WCbtyo4W7Q0lSYkdpmHDv7MALQvuHbvL4pYRyXo+tFDe5b5fwn8dNwbXpYJwZAIP/OGR29HuwpQN3OS2U+RdTLUtFCVPPb1rpnZCZ61HA3XXBvhiGP7s9CTH8dw2C+wkGkxXyjAA0fhD6BGotn3g/d/ohcY1CWVa9A3Rovukg88lOqbB4A2Y8yTz9opoF4cHSnl9i6Ebp7rXsJMXtIA/59lz11LtS3PlD2Y0uuSSaMBKdWMTm16g==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jvcF3XbadVyI9UG/sSSundVYg1xLzjR1Ks/q2+jRAf5pkSSXtH7pe44+QL?=
 =?iso-8859-1?Q?hLKpXlwY9DF72oGQe0k8SNhcOMo68Entzs9yX6TZGn7Dr5n9LqQr4IhiIO?=
 =?iso-8859-1?Q?DXM2lV6A880TiDWQ7TbgF1ksXnLBI6RMw8wLg4Dq7328cPD+LEJYtRVDrx?=
 =?iso-8859-1?Q?AfACuPS4I2odBwjlNmf1nKzqZVfe9OGr3a7SgzaN8lvGqjkOjJyAwE3KbB?=
 =?iso-8859-1?Q?VAhhhVmhpyJCJvg17fTXIlbOua+SSIUpbwif7HUfHOrxNptoldZ9AbOLBI?=
 =?iso-8859-1?Q?4FAJEMV58fTTxeqD4ApyGS+tQFH1eONZvJh22E/Pqoi6hTL1hGcnEQWpdy?=
 =?iso-8859-1?Q?pR9KxNnOX1/3lH99I7gfH8ngJ9nQQylt+gi6FUuRMvjkw8s87HRJmoi95U?=
 =?iso-8859-1?Q?DNspcf+vO5/muZ9F3GhLQpYf68AKHiXPO0Xk0A0uH5jHrkurk5EcyjtQI7?=
 =?iso-8859-1?Q?g+IcHwrEhkVb5MiMTK405+K4mtPCrBNuLHOC3vLOPAB36xEY0ZcUmHywJU?=
 =?iso-8859-1?Q?izefetBiLzH2K90PCmgKxzuP9g4UTR+n7MUYXBuRH41/4npxPWC7Rkxfb3?=
 =?iso-8859-1?Q?vcCLIgNxLjzXmgT4N5hmD2NsXYoOK4CeRk0ambkLv2P495FGpIQOW+6nWS?=
 =?iso-8859-1?Q?4x0/h2ve2Ehb8ZNdx2mpcJVN3HfBHgCG3tFx4qgTh+Vj4mNDUb4/UTGphI?=
 =?iso-8859-1?Q?4MSKqQmuHQt/qVQ/gZ+gElAOxKBdWLZG3AAzYiHKvqC7D/uaYhCUV0uO/u?=
 =?iso-8859-1?Q?9LNK2dP0f4nP3w5hxWk/M4pjgnsZqMdToxNNnL8eZ5GXIsISZUDqGpX59h?=
 =?iso-8859-1?Q?uD4ODifEU0Jo6HkZC9gTLx/o6EPvPbPCbaWDtaoKmVCHUO64Sr2G+xKx8n?=
 =?iso-8859-1?Q?fVwC4Ab2a/ynx4TOzeagWGE18dhL4HNic0/094Cb+PL5IOxclgPClou+v5?=
 =?iso-8859-1?Q?eR1dLo8gkngJhBqDvjuyBKljCl7/+Rk6OgLNTQqA2DosgyfYGGEhP8ZJuN?=
 =?iso-8859-1?Q?euBtwwUP/8sYVnrbutT3Hp02gmEL8mXquRtBG/4PTCRgyf/gXRijELUV0M?=
 =?iso-8859-1?Q?yTh5U+VAX3OuGPMxvTWZFcMPftQbTfsFxugevEvUgizG8IlZlHsj8BEdbB?=
 =?iso-8859-1?Q?yvWkn+80Imz8wAGYtOcg5hFW6nbMP7Wqgit3d8B56wmRW3WEc/Pwm2RZIB?=
 =?iso-8859-1?Q?pbdJypP5cTkUdETxA4W+2lw0DWCfkAGhEFzZ2DoMIFfptfR4ElF+4K0Y80?=
 =?iso-8859-1?Q?AaGSq8vbNslJe5d/mBWdxKhZW+8GhNnHmOj23LnhQ186dL9FtelE4uGYPH?=
 =?iso-8859-1?Q?EvKO1zPsbfTH10kq6MXMDEpWBg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <D755A1FE0D294E40BD61ABD8B8859FF7@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB0931.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe113de-e439-4cf7-5255-08db0b535163
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 10:41:07.8243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAXPR01MB4120
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>=20
> Quick observation. Do you miss the Co-developed-by: tags in the patches?

Most of the changes are minor in the 1st and 2nd patch, we haven't changed
most of the code. The changes were written as per the documentation given
in https://www.kernel.org/doc/html/latest/maintainer/modifying-patches.html

Do you think a Co-developed-by is still required?

The third patch was actually written by 2 people, so there is a Co-develope=
d-by there.

>=20
> --=20
> With Best Regards,
> Andy Shevchenko

