Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E6C70CB1A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjEVUcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbjEVUcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:32:48 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2092.outbound.protection.outlook.com [40.107.113.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89E693;
        Mon, 22 May 2023 13:32:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+Y5gJiYGPJ6WIB4WPMqmSRNAtdD5F9YvoWwwaoIyba/yziBg30lW4FCRgWmyalDHIjOvFSbSEDiXaac12N/wJh7HfPUDEoHHS1H2KSucgdKvRGvf6xAR/L4KhRMrm7pwGOFd36kSh/WYESDYMiTuA08HiH4IlizYcet/4RlcYt1Gtmkzj4mRvnVSH9RTl8CEp6j/5q3dMzBe2Hgb6PY6YcAVqYBdgugiSOmBGu24xcP/N6vUxgmJHbhJMohP5p8oBenzXmpuXSxyEsapPw1ymjETaEyPkXNcRANp9LxGTYTIOZpWGUZjHjyvz7RNlIknmd7swzSlpR1ucMk1tOYBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9xe5CMnbupFstfwqFKVaRwdjj+TSrLX/VKV4UuTs6g=;
 b=jACNsTRfXWqKLhgM3Y8QNKQEHtq0/uL26RSPUO99d+C5eWqBcjf048zTaiIGCIAJdaqTv7GHDYx2Rh1WH5ofyFKEFXnB1YnBgiSmAJq+LCchOqd41PMK2WbWB1t2e1okRPEgehWZsrv6sZPQBGd46uJNpeeUQZ4b3zsQ1Q7bGL6tfnYZeZtSfmElMN0JxkOU594eE9voLK4Nvt85uf8V5/zMwIv/Wr3gOpMj0w9NAY0gjOhLV/81MVbdIlkbTOhL7tPaRzlmR5yUFOVZfzYTPOMGX9mLWx9L4e92zIBnpyhosfIz8LDRDRcPCDByfNMP8KoyTcvPgMTdz0hgSSVY/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9xe5CMnbupFstfwqFKVaRwdjj+TSrLX/VKV4UuTs6g=;
 b=Ciu5Qb8t6Kx+KO3i1+iD+s09FaWVaCN8CA+W/WwVtyC82ycBaUXwgwgqPi0n9s3078yMBcFXIPtGnbULiP/HwhgxWdYkSLNK4uPVMWK/DCZBjBNkMyDr/c+TKF9mAn4BIP6mpiCdm8Yy2e+OL0RBsoic4lEcYICHIk254cCIpOo=
Received: from OSBPR01MB3783.jpnprd01.prod.outlook.com (2603:1096:604:43::11)
 by TYWPR01MB11194.jpnprd01.prod.outlook.com (2603:1096:400:3f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Mon, 22 May
 2023 20:32:04 +0000
Received: from OSBPR01MB3783.jpnprd01.prod.outlook.com
 ([fe80::edc3:42b8:8199:d907]) by OSBPR01MB3783.jpnprd01.prod.outlook.com
 ([fe80::edc3:42b8:8199:d907%5]) with mapi id 15.20.6411.029; Mon, 22 May 2023
 20:32:04 +0000
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
Subject: RE: [PATCH 5.15 000/203] 5.15.113-rc1 review
Thread-Topic: [PATCH 5.15 000/203] 5.15.113-rc1 review
Thread-Index: AQHZjOGOTV1iFdbVhEiin9UzYwJ/cq9mvuTg
Date:   Mon, 22 May 2023 20:32:04 +0000
Message-ID: <OSBPR01MB37833FF2B6A74409A5132EA8B7439@OSBPR01MB3783.jpnprd01.prod.outlook.com>
References: <20230522190354.935300867@linuxfoundation.org>
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSBPR01MB3783:EE_|TYWPR01MB11194:EE_
x-ms-office365-filtering-correlation-id: c4c5856b-281f-491f-55c7-08db5b039ae0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sa059uAxrmI75VQ026dxK3K6WP+FlzXUlkJGuxEN1LrDXWEEwWA5vrb3s9BNq6tEljvfgNwDFW1O3S4LwhDG845w8OyIvAh0iDPUer+bARexs9hzFE40MAQlv3smEeiFS74+aIHoOcQo21f24Coi0rAyyK3myItliYPP+uJUP/cEQivuo0s2/BpOyasAo3g7aItvjLZZVMnNSLiht54QOXcmgav3qMotSBf/MGwtRy22GW4ttuj6qa7x6j607J9sS+C4rxxlAedeBA74+sr6cJWwn3rm2dIXOX2RjY7DNmCbH3q3XTm3W4eh3AuvZbtrsyN/vYxmo9GZlTmu6kEIYzhWciCkAHN4mc1c8bMqcAWwRM7MeccyEStVN9N4ss/S2gwxk5LfcnevDSRSokJtkEdREFjBk5N0Mtc4jvYCjaJqHKuGK7h695nHVhdnApbtD2EFwewvRjLhZhvKcKsiWKsE4y95FrfYBsdFECBulWSuMY44tQBQBclgoOShdbA7XcgZ2HPThjhhFyyFTZjY00PL+aEDeAebAv9C/PotV+P5jZObcPv09rbIGw/9VyfshejvNFuEm5/VUzKGpD8XjgLkC5XrPNGuiY+ZmAIxC1LKJnpKzcYkM1+KBk2r/x4CNVUDrbhnfJlPp5KpFoDHZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB3783.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(451199021)(64756008)(86362001)(4326008)(66446008)(66556008)(66476007)(316002)(4744005)(2906002)(7416002)(52536014)(33656002)(5660300002)(478600001)(41300700001)(66946007)(76116006)(8936002)(8676002)(38070700005)(55016003)(110136005)(54906003)(966005)(7696005)(122000001)(38100700002)(71200400001)(6506007)(9686003)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?O3nmRYRwoRhiDvNT1MwbY3dCOfJjACKmF/cVBUTnJcdg6uea0xz8aHjw?=
 =?Windows-1252?Q?tkNj/JHEuUF22mzizKTh7iZiTk8diO78q6FiiUEwmAzJxbrr8JIL0klY?=
 =?Windows-1252?Q?mD+9bs3E01P5HtKxkmsjL4SlvFU/UifGrmKihsHVfgrvqws6389xdWLs?=
 =?Windows-1252?Q?d0ptJoFgu7ilXfyFQBjWFb0uW5FsLyRrLSWv8raH0SkhiTjHGp99eQzp?=
 =?Windows-1252?Q?MDU8rlCp9ukp2+UfY+do6IdKKBwK9H6dQfqYElFNRg4zIvgJO7Tjeg98?=
 =?Windows-1252?Q?kMq5PT0SiZmAs9VlE5nzwxFqZ8FsM4grlJv68jj3ec7Xcab/xlM80sWR?=
 =?Windows-1252?Q?ybEfV1dzuIn95kGuBs9MoPzba8MfeToRG/qakmXAsSw4x++7omp1KHU9?=
 =?Windows-1252?Q?qgth05MW6NsFNR1G0SjEYSvD3CyawvkrkJsAacgKC5f94CYwLlIUwi/t?=
 =?Windows-1252?Q?8wjJLbXVg6mpCa4Cwuq3yptbCVaO2CAt5neta+xwgdsApuBWa2dUfxxP?=
 =?Windows-1252?Q?Gl4afyv4xYkok+SmD92rYk4LOmzmRK50Ti0eOW5KTqAjffQTKSD3D3pK?=
 =?Windows-1252?Q?TYZo+OIr7FLUV8xsSbN7KEkJiC9d3XU1oOdTPrm55VAOCV3u3DqHpgZi?=
 =?Windows-1252?Q?zIHNDzzXQOVmM5A4ojfisbLOk9JCcUJPvzwih3JDpkiQFHlGtm1FsCA7?=
 =?Windows-1252?Q?hsAnXBeLLGGQOgRzk3RfAUKzQRtwxNmNY94BMtFGwWkwnteQprLvRAJ6?=
 =?Windows-1252?Q?A9xKUAlTOplf/QFW8wxe/3jVFsLSGZV4US6qV91orQowb+ABjfkN4vOe?=
 =?Windows-1252?Q?leyHOOQXuOgh60ZIy96mbssYXrPuxpycXLJ9uUpQC/sFIh6ckmOUWiaw?=
 =?Windows-1252?Q?Zf8bMD2dMnKxvcF61Bmz6LYIDIKlol0KBncy4lE/QyQBg9Ej/lOWR6AH?=
 =?Windows-1252?Q?oSy1AMeD4Q48QKWVAkcDmnZExdIdGzL3maBva718MJUK10FRYuIt/6Xa?=
 =?Windows-1252?Q?F/BYP2lhJ61aHZKW7koy4Q1uRTKh9Zh1hfT03b4OgXJR9c5C/ai3rdK5?=
 =?Windows-1252?Q?O33+iW98t2g90+2UfXLjeXy101B3ahSrCxJHnevhT5F1vmNkX13d+/ec?=
 =?Windows-1252?Q?AMkO+PIQe7h9uxX6t2yPaN5tsEmQFVjJxCsEhesC+g2fn3+ZCz+hO0Cv?=
 =?Windows-1252?Q?/vVV4InuATMYWRkQv4J1u3E9l5tjL5QB972P2o+no9zJsaOxI1JJcRx3?=
 =?Windows-1252?Q?wRvF2dNbt0TL4NScZ0QBxKaS38eJMEfE0dwIWbbLV7l8OR7s28A50NzU?=
 =?Windows-1252?Q?7W5k+Suhzu8DCf7zIQBuCafclI6S0Uf91PtbzJnvTG6ZZKHiJJaVvmyy?=
 =?Windows-1252?Q?iQRlfySj5JofZxbAYz9EFPizHN6yiqUmX4aUCAkRQgKc0cHsYHR6NCN7?=
 =?Windows-1252?Q?sbiUHt5/zhBVDtOH7aMjSZ14mzwAS4HtyZS232PIc+aoOUXEZVEfFOlq?=
 =?Windows-1252?Q?M0LyEWtUhEA/4RMMeIFNU1/VdEGn3VAVaYmaGAFSApHKfNK/zjbzpSZO?=
 =?Windows-1252?Q?J0++jK8+UVAmjt+7CsP8k0jZUKOLm1X1Iy1XNeF0ORv/pTVEU2ZAW+hU?=
 =?Windows-1252?Q?F2IA0tHCU9GRNHTJV6C30H6QXAW13ouwMZZ0TcKuXTbEehfC9FHBf80L?=
 =?Windows-1252?Q?mfW2lG8Dr1A=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB3783.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c5856b-281f-491f-55c7-08db5b039ae0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 20:32:04.4337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4bdlNHzOyCEL5wzG6j3V59jfoh3FCwUFs19bMQKWPadFVh9+wEcfRc+GNyMcxTh8k188xBSCKJrQlYE+0tVgqyJY1vnBSRd+x0WZbuyJNEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11194
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Monday, May 22, 2023 8:07 PM
>=20
> This is the start of the stable review cycle for the 5.15.113 release.
> There are 203 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 24 May 2023 19:03:25 +0000.
> Anything received after that time might be too late.

CIP configurations built and booted with Linux 5.15.113-rc1 (30213a86a6fe):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
75108833
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-5.15.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
