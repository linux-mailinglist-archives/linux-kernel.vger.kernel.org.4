Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5DE703E4B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245208AbjEOUMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242402AbjEOUMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:12:47 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2113.outbound.protection.outlook.com [40.107.114.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D90C3AAA;
        Mon, 15 May 2023 13:12:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odwKms96BHIeyUdjGL1pJ4rBCwqIU6CP1zyJheeFbsCTGnD6FVTQwXoOWSa6aXIZFTUdNUzsMKz3CLroOIPvDor/yCscUT8tOAs3moeDuw9e0X7HznFXTX+2iyUkjU2TEVixXldaJs6sPy6fiSkJlSib+h2bMm7dgoucHsqFjkAShiBSnz70pRAksJkf2l02/5nNKU5JP3uVw6GahX6YSBPbqzfJsUNBXTQ0Hr+JZtSR06INN+O/BpYD+Pe4kUBR4e4NKFE1EWXypC4rFoVW25mIig6dKzb2s+m1v6NMWi6ceYmAhx2SDdTNm/WmvHQUOO+4cmOwMT6vExKZ0xJ2jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXK+ycS1N4+xJJprmVCC9XjRdO2Yr+5V8ZJkN2hlyTg=;
 b=oWvPBbe+Iy17RRX5/4k876/FXyHgoEd++AKeW0yLBO6RHuEamuF1IiKYkXW4guoMXgDWC0BDs/8L8o6Esuc4+NXxUG4MbzDzmtFHaux8lAHBiKH+AK7a44+xP+ntkGYYy3qG5rAhq1GKsV9AhM7pErXht11fw1B2DMN8NJmWz5j9X1JYyGYNv1MSeHUxFBgwtx8pvGqK3m6xGUjoKWYmxiHENmxg+fxGvr5dN6qzh9t6EhsGGh/nOSTwWywt1UTABOg3MVMIFIGBWmb9NEVIHk7Kh7wiAj789ualExSDP4XQORzyiZwgJYbLmb4DFqsVp23CceaWgUneNNwBtM0WUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXK+ycS1N4+xJJprmVCC9XjRdO2Yr+5V8ZJkN2hlyTg=;
 b=p2MS5YWYbiZHS+Ij+xkUn8bJLugsM7kbKJJ9yTC4Pcj2X0r/N4MJ+giXp1kR0wkHotjAsIfnC/0F5toSG3SoO3QYsE6qzADMMiddnovJa6hkTqkEsmjZ9ANi4lsMFBpqZeVl5Ja0EkE8sr2R+zIityBm94uBVQrZL+/losK0usM=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OS0PR01MB5459.jpnprd01.prod.outlook.com (2603:1096:604:af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.31; Mon, 15 May
 2023 20:12:10 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a7d8:4c3a:9cfd:2e79]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a7d8:4c3a:9cfd:2e79%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 20:12:10 +0000
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
Subject: RE: [PATCH 6.2 000/242] 6.2.16-rc1 review
Thread-Topic: [PATCH 6.2 000/242] 6.2.16-rc1 review
Thread-Index: AQHZh1DfWwnO3PRs4k+Y6Aybz39Hvq9bwhfQ
Date:   Mon, 15 May 2023 20:12:10 +0000
Message-ID: <TY2PR01MB3788DC9559EB05FDAE66F8D2B7789@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230515161721.802179972@linuxfoundation.org>
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OS0PR01MB5459:EE_
x-ms-office365-filtering-correlation-id: d6ae3693-ed93-438e-5d44-08db5580aa7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u/u59x9Pkxr6utF1PgyYtgbhYK2FQifVk37bW6Olf8JZ35YWLB9TNsF16o9Okm4qY8yxscjuRby7GYvBFB67974EikmtGe5baFP9SKT29z7vC4YKfQvi3lvtJlXYcjqdZyTTpJWxMkNHBs7S+uhvB76nAH4tWVdnpoQXaM2lv2r/uJIC4D3gFW7Zj3cI2aw71c1dIv3dSEhCq/XwXf4AYiKW3pRgKiFk7VFPPuLpiwQvofdFudHbnZp/S5RtrGOcFrn/uIXwjnjJ8xUhSy45RZXDu1VugxKK8+G8nRTLd6AbGg5UTOBJyugyIiENhdMEAa/LV8lgiLGfyoP+I/AORnyRJQeV530Gyw+DL1kWhy1kvyaBwd+ODBwUolskE3qMS17Ph1Ue8xk8dF2IUUZJi8G1oj9UuNHHgKyFnEPxFB0Wj6X1Mbtk5vPyE9JIHGR2MXRSm8KzDbld50tQWimPYd0mPgC+alwDDbGgVZnvRAURXj7NOBMHaS1H9NYgyM9HZxRoVubMWRNp/lOltEQgHsPBMGGPcwflPrKhjNLa3TOAY1QYKepFOXmv710l2PR62mcAdqhCEW67/6R5sga95beoDrCu5KG8w8fx07up8JLitFtOe3+upY91j7rae/CJsAvFUIaXw0A0eJIr170wDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199021)(52536014)(8676002)(8936002)(5660300002)(7416002)(4744005)(4326008)(316002)(41300700001)(2906002)(478600001)(66946007)(66556008)(66446008)(64756008)(66476007)(76116006)(55016003)(54906003)(33656002)(110136005)(7696005)(966005)(26005)(186003)(9686003)(6506007)(38100700002)(38070700005)(71200400001)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-3?Q?ZU5glLzzdGPDPACMOFXnq/fw9kIWckkKzXQZCAp1sw1zysOp8LPuiIizzE?=
 =?iso-8859-3?Q?zBcpjyt47UCDc2lPMqohUiR6CXJXYjdpCUBVOriQ4eNNjgx7h2oPvO0ZHC?=
 =?iso-8859-3?Q?eHk4p4wngR59KbBSLK2coNPKMWnOLeGXySTEVdXlgt6986/N9YYsdla1Hl?=
 =?iso-8859-3?Q?P+kcr1td5u48L/aHoDHVO3YfTAy8qQGlQC1mxTwfX4j+L5l6lQ5tfE0ufT?=
 =?iso-8859-3?Q?mT37lKeI6WsX8EgKMQs5XRkFjN5PIltx+FEFVphy4Uj0p1RXL07VOZrstJ?=
 =?iso-8859-3?Q?+lMf3tMCa9vnrTC99/YRJu2FoKIFjRLO7ur4aHKsaMUwjWbmaaLpvX4EHC?=
 =?iso-8859-3?Q?iqqBEL7c5SOPNi0oMA3QoqxCdypG89lE+JMEkRJ0x2m7V1YapUpZ5Xby0a?=
 =?iso-8859-3?Q?sGHqMsq+4Ppq4Rtsz6Ze/AZMvXz/5vsc7sIR/gf5/wOTeGKgeBSuUjIyuX?=
 =?iso-8859-3?Q?uA2f2f+egKyK3WyHFGTcKSWTPJizfpaFP6mYKEljPHC5BJiGiwIoYdDjnV?=
 =?iso-8859-3?Q?EH0m+lrWhyfBvHulHxBZroHLDWD8iJ+sPgPVxiNfUHxwMSLEubyR35r9UP?=
 =?iso-8859-3?Q?Mz//p5t82DkF7xWjr89kK3XSbvsQbhQVTIQAndiD/eVa0p+hF580dhi80L?=
 =?iso-8859-3?Q?69ERynqJIAIiJeiZtyQdQ2AXJ5Yd6Y2z0nj4616VlEZwTSaXjO/n3ozicd?=
 =?iso-8859-3?Q?e5vGAk7QmbcgOMcKQrbDcSONaYU5tQzMPQ8xkbj8Dps8eAZSRMS226cwt2?=
 =?iso-8859-3?Q?wwM6DUVbIkU0o68lH4VZRTnz7StMSTC1ybf/Xuhh9xAfaVkC/GNy+HwcGy?=
 =?iso-8859-3?Q?MxMvRyHu0LIFXLJr0AvP6PvOFqSjbPVuNoFOEhhfsxCsBqIsoW9QYzz+bq?=
 =?iso-8859-3?Q?2CrLSb953RBwGp140Lj1WCg6kkCbzN5K4UumsosFa1N+P++s+kRvfIiWw/?=
 =?iso-8859-3?Q?5Z0wpPIAYdQXWaiTe/ocORPXpcmxrIKBDQps1nsIYqA6OqgjL2rKMMVUtW?=
 =?iso-8859-3?Q?HUojpvPdcGbQO5edZMlVBJ45DMixTJqH69TAisJGCl5sUj6L34U4aRV9RF?=
 =?iso-8859-3?Q?jdwmXutynqdoXG3Zd/HQXtqZ03jl8fRfPg6MUAkc5beb6UCQZjCoitQWKY?=
 =?iso-8859-3?Q?Ee9Fql/Bi3M0moPqrjL/gU149E8w/HWWGeWu+9wf+px6bPrwG2vuLFWd6v?=
 =?iso-8859-3?Q?7nM4kwgObCoxb9P8vQixhm+rwMIa1cPfKiwPffZ2zbqroI4CzrIf4hdqIH?=
 =?iso-8859-3?Q?0U7nkBpt2hGJfYgJRTnGcOJnAksgyRZXaN/71oI/e8mYQD3yDkBZVnIoOm?=
 =?iso-8859-3?Q?ymzLleXRqjbn4vhaKS+wxQzjiNi07vH3bnIorYIfWcxg7pl5s2pkCZfLk5?=
 =?iso-8859-3?Q?08J/jTYyrQaeWsBHQMcNsO8NGcVTs0cgcoAPcRezq9jFkIXUvU2B3Vyors?=
 =?iso-8859-3?Q?nd7QZkrn5sd9z63WOgD9BI2RSN+/rJiU2RXJNfdcTJY9A0zrRSWqFAOHvh?=
 =?iso-8859-3?Q?fCAoUFpJ0oVvrYuad/Wj/dTTE6pf+ZItKbjWET4OLjB1MK1GLv3JoHunSS?=
 =?iso-8859-3?Q?Mktwh2Tz5Gaffd3+WSHSYJDrYHsfXhaS43keIav88wpdbZsI3BLHvYwBNt?=
 =?iso-8859-3?Q?wH5QBTK4ttFhgc8TcX9lS2vrMWsPJ1JwHkbvjhefi6l1vp7okAhlMseQ?=
 =?iso-8859-3?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-3"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ae3693-ed93-438e-5d44-08db5580aa7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 20:12:10.7506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +WQR9FJTghR3Qg1dcKYd4x1WHVdyJU8CWS+Tjjj76oMq0p1tIqqJosbstvR1bg32mgyRR7He0Rpj4iif57rEhpM+SLY4VW2KeH3YRSun89Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5459
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
> Sent: Monday, May 15, 2023 5:25 PM
>=20
> This is the start of the stable review cycle for the 6.2.16 release.
> There are 242 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.

CIP configurations built and booted with Linux 6.2.16-rc1 (704eace42a14):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
67957754
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-6.2.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
