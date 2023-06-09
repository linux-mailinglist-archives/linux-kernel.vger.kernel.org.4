Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99F1729170
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239054AbjFIHnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239020AbjFIHm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:42:29 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2093.outbound.protection.outlook.com [40.107.113.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7461FEC;
        Fri,  9 Jun 2023 00:42:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1Kk1N1hStq6F1p0jFSmv1H99OzWxqHImcwDVUTNrWNTNaYDmc+F+qxClZdsERSZh+zpfCNKmSzlbp57wJE/LZa9Pn6wJMN1KkhePXV8LeZaH642zHb1tG/tEbA1BaRS1edMg3M6p/6HtNSRLtP5/nBjzvkAU/EM8V3+svBBdIu3q0CuBADLJzXXDEC5/My/EOx/T57jl0nbBskZyCgRMrUK54OvOMfyrNr1WZl1/1UcdRGnUCThIiIF04S1fb8o2Xzufy8TWY6mEmCHi//QuUgz8gQlJn6lWqc8TMWVi9kapO5Uck6/nXIFDHtip7fhKS2Zw6evpyBqUAbskQqbdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4itxGTRkV6CYv0KWB2Q88lmMAS0n0fi22xPlbmkA4E=;
 b=GtoBDZj9ZPmtNNNcUmADoDVnwjvwlEKLrYAlgOm9fZqjSpTBrtiWr3rRya8bHdNlGGGXSMcd5rxIVh0LfvXyTAukBCM5L0uuyyyYaZrKr4nGgzuaTVzuGKAmufFWyDOU+ziRH8k8iGdPthXXrEtW9rBO9l0+FhnWhrnL//I6GplYJk407dR/2HUcLfGbB4k5tE75fmOxoHCRJ9+EVCxFmNfACQI8dtym7Auf4atfdYZEbAwITSdpe0a2xb5u7A3SGGtjn41hG7DvESCKPlfESruZ8HES6J4PFVTb/P0+s+oG8mTMEMIp4vcdMpsvMjUxe5K20SShpKxPzympiFn2DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4itxGTRkV6CYv0KWB2Q88lmMAS0n0fi22xPlbmkA4E=;
 b=n9KGZ3XX32/jXn2om+M0PvfW7kouSwz5P5m7G6frnEKneR3DKV5mkv60I1oFVtLx26RKVWXPq1AgKmgEvCBeaGsjLbwJNxBo7zqWzCWa3rW2FDcIVAxZ5oSMu8UjAj2rbElVO8l5ZNyrsoGKmmhX65oqf50Ho9C5Qv8RuWXu6Jo=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYBPR01MB5549.jpnprd01.prod.outlook.com (2603:1096:404:8020::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 07:42:22 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 07:42:22 +0000
From:   Chris Paterson <Chris.Paterson2@renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC:     "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "patches@kernelci.org" <patches@kernelci.org>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "pavel@denx.de" <pavel@denx.de>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>,
        "srw@sladewatkins.net" <srw@sladewatkins.net>,
        "rwarsow@gmx.de" <rwarsow@gmx.de>
Subject: RE: [PATCH 6.3 000/285] 6.3.7-rc2 review
Thread-Topic: [PATCH 6.3 000/285] 6.3.7-rc2 review
Thread-Index: AQHZmjM1y9kpcS2qaEGG2TMTDX1mVK+CFuxg
Date:   Fri, 9 Jun 2023 07:42:22 +0000
Message-ID: <TY2PR01MB378815F4C89E3DB5B57F6F0EB751A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230608175722.489602717@linuxfoundation.org>
In-Reply-To: <20230608175722.489602717@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYBPR01MB5549:EE_
x-ms-office365-filtering-correlation-id: c6ecc507-472a-4d96-d2bd-08db68bd0fd4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uRw9E2cTa02GmOvGF11L+izpxOsTc+Ry7hrbS77zXVfla6sUNZJ+La7dH/L5RnVBqM+rJ15lL3cpR/TkiIKVX7ALbbnqQ2VO7/AeBfNn2/ICq7ctisdlkGZEOZ+G2knolQw4e+Cg/Qssuz2Tjvm0CQgFZyiNeImSdQuUlgLR5EcEmQEs/k4vSy/vpi6xXvU9Q0rCYZ039dr7UUXwXalXdO/24Ml7K9CUX8SEgxe+Iwg4l4KEFCpEA64tF/D4IREicmMrTzReKWPdh+iBYVo+rxIevl9YhfqQvUCLKiptP0VPXOawqDgNa3jZC5FrkDYUofywSusgtjWDFLFDsP5SSeJEOD6igGGjkiQsN0jbHWuPmt27CWA1zyLO2NX2QDQxqVGfvjvSGM8BNxRluYdEssNFetw6zB+Ft+J+A5jmAU1CFRltcfEMs4u7gK1rDeb4yjZFJVpmMHyXrErkhURUmbwYjJ2hln9EVQqA0+omY0FAWGL4rVcXNUu1prDuHGN3S+tFc/p/kTTEsacMyTVWb7TvDj8tBI/wL5HTnQgAgG+RxWHq9VNfTL5pKG44U/c9YWk9GR2DQ2fgNLsI+jyyyYQO/bMZIYD8jP7/JxJ7jhASK+SfP7dLyJgVXT5dwSwrVRuZW1rCU5hbMoQrsCjW1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199021)(41300700001)(8676002)(66446008)(4326008)(66556008)(66476007)(76116006)(8936002)(66946007)(64756008)(110136005)(5660300002)(7416002)(316002)(52536014)(54906003)(55016003)(2906002)(4744005)(38100700002)(122000001)(26005)(9686003)(86362001)(186003)(6506007)(71200400001)(478600001)(7696005)(966005)(33656002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?f+rQh673yEK3TKGcnG/3Y+rrCuIlxREs1rLJQQzV2+KR38rFvuPOwNu2Vt?=
 =?iso-8859-2?Q?RBHexrnIfFaUNu0Wqlrj+SbfTrcZZbX5EVZZuYZ6bKZcoqd7ZUrQ4vxia5?=
 =?iso-8859-2?Q?x+C2J+weTAb9hDwuakJ0HFyh3CwibTQzQutO1ptZhri6TnLIaHvoFFZe5T?=
 =?iso-8859-2?Q?9nBcemYlc4m1OndIQVDznQaNcakN6wCFQkRzxQujN/AST5nLn5h31QA8Ne?=
 =?iso-8859-2?Q?WVvmqS6APrnKT5OXdBKmkKSsXX2gAYcKA7pl6yvrH6EeO3Img8d5BXfsCR?=
 =?iso-8859-2?Q?XXoMyCrneO1FcN6kqoCzDtJMO1gqTbynh6QQ4JxrDQSoBbXZzQ0N4LiwCl?=
 =?iso-8859-2?Q?uny4fFoarJNYcA1jukqjiTg0jg18EDzMD3EnoimwmmVrK0ZGYJnJp9WiWf?=
 =?iso-8859-2?Q?1NwHI+qumRv98//R5fOf0COt9ppPk5G2+6frDus/hcPaR0dT3zd9vdBLOT?=
 =?iso-8859-2?Q?zECnjW7HDUo6TztjpW2vVkO/LMRmTL6zG90XpSADuhhLh+23h3Gq0+sMcp?=
 =?iso-8859-2?Q?+oXC63eLJaZVlEJtUMpk9jdDXp1wov4jXoNIQ258U/Gl5UUMqV0EQM2J6t?=
 =?iso-8859-2?Q?/WwaYD88F1Mx/pExg4jc+254FJZeG/SstYJ4+xb98GDHLz6ZgWbWrDumAw?=
 =?iso-8859-2?Q?VcLziy5fpdlpefa/BES82v76cGte/PJyFbxf9y/v80pSjU18+n+VoBOJ66?=
 =?iso-8859-2?Q?xYePKwgZZGFeThX4h/K0nDoDWLY6F39cbBKiJSHnbo6oUlhX5qHEJpUUoZ?=
 =?iso-8859-2?Q?Nf+2OuUNSDMz6wrN63fQKi5QVKBft5NmFJWnadMLhDCV0FcLNmpivpIDJL?=
 =?iso-8859-2?Q?YubvCqCnF+oOTlx1H407b9HXH9ec4i6QvmH9pUNmu/nQ86/tTg6FUh2Y/1?=
 =?iso-8859-2?Q?rgptqqvNLCAp1yEi6q7hzbL5BhzFE9R5xj+s9dmbsEJFO8HtoXp0FpEt1V?=
 =?iso-8859-2?Q?7aVqaQjN31777wDLl2os/DFIVH7tjtji6scppRypfLuVBOnplOpWrznKvL?=
 =?iso-8859-2?Q?Hbw/yOHa60IzEJtBSssmVezZuvyFNZa6i7bPMObrFoLrpdpsKOKJnRH/RO?=
 =?iso-8859-2?Q?Vgx4ChMqyzl6B8jDnlmVe3/ksEiia4dt4PCyRwveYR/Ez9UhCeoLJPNDqn?=
 =?iso-8859-2?Q?CNUp7LJ4n3zDpa91RsRRbVMMZ7Nv/uzGDTnOpNpO/WXzHCU+V3rYYk4vGH?=
 =?iso-8859-2?Q?hWpSBOARCSwaDtw+cMEAHT/SnS9NdQ+1SXf5sMtwKu50nvEYUm3uWbGqdY?=
 =?iso-8859-2?Q?sOsSP82baPgyNi2kZfVFx1V+6E0bXDfaNxfrZftikZKPOpUWeM1Mk072Md?=
 =?iso-8859-2?Q?i2zgUb9PcacMxY4TNeB2/nTWF6MvPkO2lBsMNruqWd6TJY2trY5cS45224?=
 =?iso-8859-2?Q?sD/wrDX80oCVKJHg9HGJ9Tj8sHBYhAeuhn0atkiXOAhjaNjGvOxfJdhCQR?=
 =?iso-8859-2?Q?nZpzOOAhqiNNe2tdUL4iyNi8JQlTkRIlLx8iJuOiNS8rhq4cI4FFGPGOdH?=
 =?iso-8859-2?Q?C7KOFuly8Gh1NEF2Q46ypXhQqP+2HllvGI7mEJ9PH3GFygO/oO9BPw212w?=
 =?iso-8859-2?Q?8kOD/tcogOv2LbA1WEyIEx7cv4uEWJ/yOhe4/Zeysc5LOwheYcVIvTLAuD?=
 =?iso-8859-2?Q?nDhvom9j8tTlywnBHOl81U4ctHiPmKj1dDVcrSQQ0QleV0uEKxKonSzQ?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ecc507-472a-4d96-d2bd-08db68bd0fd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 07:42:22.6445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K6NBL+xu+sti6ucdTvC/URYE/XvuIxK+OusUSh8D77uk6vU/HpaPiu6qexI0SC3uHtkmDEAYI2xk9CFOLliQMHzG/ycR4GHhecbKp09yYoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5549
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Thursday, June 8, 2023 7:01 PM
>=20
> This is the start of the stable review cycle for the 6.3.7 release.
> There are 285 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Sat, 10 Jun 2023 17:56:29 +0000.
> Anything received after that time might be too late.

Thank you for the release!

CIP configurations built and booted okay with Linux 6.3.7-rc2 (6f9b6a83bd08=
):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
94212015
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-6.3.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
