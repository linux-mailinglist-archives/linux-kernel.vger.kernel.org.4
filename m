Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A646EF641
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241345AbjDZOUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241325AbjDZOTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:19:42 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2106.outbound.protection.outlook.com [40.107.114.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288846E8F;
        Wed, 26 Apr 2023 07:19:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9ruaDik+TFxRgdc5R4rXfpR9KUg3DnEfXuPR0+SJQwMOdKOehch7pnu6hVFVKWgE2b3406kj0kuHvsEtmx/GI1FKkJkKl9H1auGwrFVUeXXaK4b8w8Y+1JM2gUgpHt5eYYgQ1O+hUKY3aURNx/nIV0iLTaouVhE/vICdREPOcBZpyygNaaB+HfmkvFqYZczFFf0TSH1dfj0nbPCj4lrRlGD0ipxIS4/HyeJGyKGHLGgg1So2P9CGStUnsrTSiyVP/P7czebTYKvLgXpSUNK1owhNNfZpMUuOhkLyr3gwzcO1XEaR87T05IJtCgA4WcaDiY7cv2coo2FjgFDcq3wbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68K44w79pdzxo6Q1Er3vExC0gel1rhHbebqkAPT8I0M=;
 b=TzBnWVxzb4VESoX4ngcEGUtKclvMBa1F230+gMihBZN3rzNOmMCLnFVq2c/4JgmLQmv9x/oz9R5UuJY+SSpzJgvjiv1qk2yZEL1YXAJzexoxZkQCC4YH0LAllRvDXD5eXgiFhzPRdqwPwvBFaGhD4QLBdEYJZmD9H8d/6d9uik+SDPKmhRw76pZ6Kokc+EAyuehU8DsBkwxXimTqGm7/i0o/g0ib3DYpUYXWKEo+g7eelFXbhMv6nbJud9NmaIsfUPtuZu/7Q0WNr3rVT7J3+RudiESFICw+z+xFRwg+Iz1lDJdvttdll1OJiMmaelv5CTgixhnqGihouUb74S5Pig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68K44w79pdzxo6Q1Er3vExC0gel1rhHbebqkAPT8I0M=;
 b=YbTPNMqY3LqWnUxyR2w5zlS8VoV8o3YBFOWJSRbbcXsgCOGVe0pUDBW04NpULEB0kKfP33s/7OW/pLaEG9xECD0t4QzUDiaU8yGAwNaARrq/ZsiwfF5cLpocaY0KgFPexOYAu3Wt+1jrnAuqCB5nXjTpnewD1XBlzUkHRUUzxS0=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYCPR01MB12041.jpnprd01.prod.outlook.com (2603:1096:400:387::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 14:19:38 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::f687:2c30:bf97:7ca2]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::f687:2c30:bf97:7ca2%7]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 14:19:38 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Chris Paterson <Chris.Paterson2@renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>
Subject: RE: [PATCH] dt-bindings: pinctrl: renesas,rzn1: Change maintainer to
 Fabrizio Castro
Thread-Topic: [PATCH] dt-bindings: pinctrl: renesas,rzn1: Change maintainer to
 Fabrizio Castro
Thread-Index: AQHZeCcBhlzEU7rSSEqZJZoXwEHZ2a89o7KA
Date:   Wed, 26 Apr 2023 14:19:38 +0000
Message-ID: <TYWPR01MB8775CFC7B401F55A22204F99C2659@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <20230426100802.11860-1-chris.paterson2@renesas.com>
In-Reply-To: <20230426100802.11860-1-chris.paterson2@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYCPR01MB12041:EE_
x-ms-office365-filtering-correlation-id: 4bdc7326-40a1-4f52-bcd7-08db466144ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PlJAuUXBsDsKc4ayAp2yk6BVmisxvo5RCKdYVU9zm2Oms+jhBQ5jQbhjsx3EdPFM7f+2nISlEB9GFGcpg2hrBMVjpoUx1zsZCvjDZjz3TU/iIEG8mu6VvqNtM8RXuBD3HVJSHfYwQUfwA3QmUv08MZS3Wxb8yHVwuf20IlfnEuxLAEN/zt3xH3JF+Hbm+RlzO4KPutPifJhKW/HVmJ1W5H6ZKOh4jdz9si5OBz89kdfc7Yq7olj+9EisJbM7EnBrcet1+9e9li5IwnqtzKweL+hiHuru2D6/j09pBTgEkYrK3xKWGSS5HLk/75eCDW6ay+PeK94IARfOhriEQMZSpnfNHdHllfwV+RChlMQ9zp1GqZDhIn/f/XapB+HdqjC6hbpMrl9YLiLy35INPjWAcPcqhk+JuJjyfKRqUZ5h5B2RewvlkC4T2B4ogfZ2aAp/NoXkVyYVJVIjtFuRuZY0FR2byn8/xwmsGbjiNJj+yxw+O2KsPZ0CRoe1G9Wi+QuFPa4q1jeCdmg5AJC29nSSaqJLAzmp3IFE3SmOEExavUVPBV3kJOle8DqF3XXC/FvPiNCd1c9eSs3OI07WyrCmX0MFUpexa+3GyNIBypzOW/Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199021)(7696005)(33656002)(5660300002)(52536014)(122000001)(558084003)(2906002)(38100700002)(71200400001)(478600001)(55016003)(316002)(41300700001)(38070700005)(4326008)(66946007)(66556008)(66446008)(64756008)(66476007)(76116006)(86362001)(186003)(107886003)(6506007)(9686003)(54906003)(26005)(8936002)(8676002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GBQ97rbE9SqnQv++MQ0teTs1cX17VfeRGMfcA6A8Mzt0ifDtYBD8rpfLNNcU?=
 =?us-ascii?Q?AapM9opcHEEj/GsehkTIx4a+Tb5lhETd72fTcVNoCy2njbeHZU8f3A5tFRdG?=
 =?us-ascii?Q?161nCGSF5hlRg498W6fmu3A1VBI5mkzBnBaMr+wxR3fm4WlXhW2HoCl/o1qU?=
 =?us-ascii?Q?knrBrYMTZDJGZ/BFU9Vw+Udyy+WYF1GtSE3xD5UKgdeYbUaKQY+T0e41HIYR?=
 =?us-ascii?Q?RPxkxeIk9/6M1Mou6kazAU8NxfhONT2ye6EClf9Gw+zRDTnopQZJi8ubk6J/?=
 =?us-ascii?Q?uppDyatMx/l7HMQyFZ94jjAj7S9iI/56lOgQOLpzU64mRty1QmUPq8sdbNlw?=
 =?us-ascii?Q?+VuANt0M3CU7Yhn/jtM9ztrxJmQ+TxHbdqlRf6/xBiOI+/DT8TJ/BRQX/jKE?=
 =?us-ascii?Q?RA8pZ8sINkLNEkr1j21fqUqFe8bkLUuP1ugWBuLDDRIW77+CQI3kAZRY8ENR?=
 =?us-ascii?Q?Fbw3bSINnhu1FA3335da33JV9IUOc58ZuOpH9r1l/1dtCOYu32Gt7b7zoee1?=
 =?us-ascii?Q?9C8X8bWgn4OQLLcfmY4p1lX6nmpumV9byeg8O4RFkIZH58yVbqiK18smPgC+?=
 =?us-ascii?Q?yw2SmSDBWFZdkuxWM4NuVGFFuCV+tMfhwCcYUj5e4QkwJy7xOd6XoOSS2m2l?=
 =?us-ascii?Q?ctOepgj3N/B7Goo9IztlveVJgl06JZkJUD4cdq8xVRbiKrjqeronql6yv9Aj?=
 =?us-ascii?Q?7QH5N9NvLdo1YZI4KkPqkWdwqzIWt509+80M4RyovkK+gdPCKvutKI5Qr+ph?=
 =?us-ascii?Q?7wS+jq9b8I+DzivDXXq3V04Fo61x+s86/dcrrujlYcRBQhCEdUjvhRuBXwQh?=
 =?us-ascii?Q?MBBEe1RyunUEBKMgcUn6O5uOLTZEEqgZz6IefKnFRFnz5DZX1IyWc1/RYjMc?=
 =?us-ascii?Q?u/qu1x0+blEBOmx50im74P/6ooTcAjao+oeT4d5LwwFzWeBelcbJJp2zCB8O?=
 =?us-ascii?Q?+I4OfSgOjXVpfhYT5DsfZPdJXfw5RSA2akVzZs3ggDwzaDA6+GseaYwW7RKT?=
 =?us-ascii?Q?H7dAMl0bHxADJNXce9Y+8KiTbDAd2vhJ3Rzly7lwiEsl1L+iDEjR/w9sGDNU?=
 =?us-ascii?Q?Iq20zs+gp5XhN1twphz0kSHVu3E6T+6u2/u2Z5sAvNsgUVFDudCK4FGfW2KG?=
 =?us-ascii?Q?m8R0COzb+jIbusml3KpaS49xbaN6pL3XYtCh61zc2egd4TlA+npgrkqp4xuu?=
 =?us-ascii?Q?B9J6OPadR8Y99mIoHPQhCxt22iM/Dxf+6W2P8+iqRxOwZrhhr91z69uOlHkn?=
 =?us-ascii?Q?Ebc9UthJ8qB/7l9v/0fqjpDQi0eQNRDi/SmrjBEkhEK5A/6RisOaPVjUjo4K?=
 =?us-ascii?Q?gHxWCklXOW9yxHAW6JXw+2t71hXItnNFpQxNYZdH4l8/6ebU3TT3uMnhDEBu?=
 =?us-ascii?Q?FFYXmWIoiEZEEfAaizBk2IT9NmWxCkiPjCmeS8KxY0U+suDAcaS/JSeSK70D?=
 =?us-ascii?Q?U2Gf0janpWJY9PVVQL827Qbz6infYyR1mWrU9HUTWnywGCUSDPjZh3Ji8lVI?=
 =?us-ascii?Q?Xl7+wEU2HIST5VpHoq0wYEi/ALJ+PZ18ypNcbfZb55/86d7jWlhVl+smlXDK?=
 =?us-ascii?Q?7svVP4b4AAfIdOf8RJfWwg6hta9mq8q0drodhEfU9jL8j90yqIdyTvndYCTJ?=
 =?us-ascii?Q?JA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bdc7326-40a1-4f52-bcd7-08db466144ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 14:19:38.5161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrDwFHBvldOltkvMLH5Vj/JzbnEm1vSd9UFZ5KiPPtjca/7IoE3B+BaUvnG8qEfdSaxKCHK81u5XfBL/lP0v1lQEm0We/BW+6cUxK+xJiiQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB12041
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

Thanks for your patch.

> From: Chris Paterson <chris.paterson2@renesas.com>
> Subject: [PATCH] dt-bindings: pinctrl: renesas,rzn1: Change maintainer
> to Fabrizio Castro
>=20
> Gareth no longer works for Renesas.
>=20
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>

Acked-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
