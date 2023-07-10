Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530F974D8CD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjGJOS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjGJOS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:18:26 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2100.outbound.protection.outlook.com [40.107.114.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541FA90;
        Mon, 10 Jul 2023 07:18:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QE5L7axDZXl+eF9mylLaWQuYglyMbt202/IwRCMeDxOrWNQXUuTJ5zJG2ibtRq3S1RZO3q4qiesCHDYhxiLBehmeYpJRowUQSd3z1MyqpUuTfqTbEKIVKsCGZDj9aOR+LI0oZq+K94q2H8r+qGa60W22JOVCINPiQeWsP0PD+lbGYV6kRD6VuyBllRRhqoBRq3vnrYGetsX+CDdeuV4ewW+equc2fNWDe2gRsd84GXebfCWarumcY999ClEsDk3H6ZWaSMMst7JcWm1PkFFBe+cNwg7yHR2vDHoLoRH8q+qJW7BeKY9aLtQ6c0bz0p8bbDStr/qAIcpvQQ0lchr3BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Go/qEYT/FyQXH9z2U2NBDapdDuOAdX6whj4yiUNYKs=;
 b=lDmz+vn4J7/rStY7NhMi97fQgZ3CVcDVbSaczaL7ArdR0X6w9Mq8p/+rZNzv3LPLM9J5GwR/2c45Cs8ZUte6f95LSk5ZtyK6VqUzPZb4rGSzwNSTcDkUCTAuqwIBUYUiPTOjBZ+TH4RB1LySqdkSo8N1QUvxo3WLe03rtwFJE9Xhxc3K8fZrM/srkQIbdqAZo04L9XtwpkuZuKmnNasdXjuuan0b6I0zAXZdIrkj+YixHOFgCEN27Sjeb4y5M3pHV7JNGu5aK9T5JYWUjOK9h7ga4bw4B97bsLTZsMkSi3xRE1rzYBcW0hdCAw0HMt6YijdDhMlESYk62iYz+92C7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Go/qEYT/FyQXH9z2U2NBDapdDuOAdX6whj4yiUNYKs=;
 b=NBmvIqyw0GZvZzCGFrhHGz9LQ6N6Af37zId14lFIqGYUuhW0QfiLCm7LRZjtzU8o8GFP0ZyGC3MGytnSpvfmMpCZuZSPRtcqR37GyjFDpLFnen5M2I//NMrFcy1tbj96A/B1Qt56Pg0GLDnbz6OaxjCGiJeV5UAa/kaYOf/k0iY=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TY3PR01MB11259.jpnprd01.prod.outlook.com (2603:1096:400:3d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 14:18:21 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::6f67:84a4:13d9:2f28]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::6f67:84a4:13d9:2f28%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 14:18:21 +0000
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
        "rwarsow@gmx.de" <rwarsow@gmx.de>,
        "conor@kernel.org" <conor@kernel.org>
Subject: RE: [PATCH 6.3 000/426] 6.3.13-rc3 review
Thread-Topic: [PATCH 6.3 000/426] 6.3.13-rc3 review
Thread-Index: AQHZsvJ1mXxVL4YMfEWhRkQoYwRBqa+zDIJg
Date:   Mon, 10 Jul 2023 14:18:21 +0000
Message-ID: <TY2PR01MB378835A1769A6747F00189D2B730A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230710054619.475084489@linuxfoundation.org>
In-Reply-To: <20230710054619.475084489@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TY3PR01MB11259:EE_
x-ms-office365-filtering-correlation-id: acd2764c-0832-4a62-a185-08db815083f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uOoVpZ4VbsWoC592rQvhRdldWB5fWo8wqikJMSY/NBcKpW8bQG1MyhGGoxEB4nHHvsfl02gtpTjRxozmoJ8vp2zFir/0Dzdn9W+SmUNVxJUmGYKMqvc3mZUwN8GP0nG+NlZaloMaEqhBWFsUv3Q6rHuVGigqmer5RLoHqywBKtOSYo1YkKJZVI03aiFkbCrS6/0TJCItiKmzkwl+piY9AKdcOOvoc65mPtApABJN/R4Kf5TJBxqy03jYQUpSpmkF6xpnFypwj3cdkrELA//jdUETAqmufPja27lrnBGpttmby4F/PqMj0msNbmch9TBFetrj9t09jZw8Oss7LX5ZM94CSlVaYta6ed5CCklFC1ZpUeqikgWR2KrGFraNkhFvLvhNRXYKxACZ6g+upxLwgfOGYq4TRVF9dqzea4StmVCc1kK/9rOzInIE0qFAqjnsDkx3n88KMgtENgBHPVVe5Vbxa0i4iVMylxtzyUtbDLNMZcBU6NxmM5lCx7kTF1pEbuHW8CON801dvBOl646R8wgbLQOPfGDWkKTX9vkSoBlbXRvFqcWa3e0sqfTd2nNplhx4KpJE/+yo9FvnS9E9rOrLoynhZO9PeikS5gMJn6t2t7tb5jJjM7Rzup3yPKUSr3C57L51g7OyV5ssJP/43A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199021)(7696005)(33656002)(71200400001)(478600001)(26005)(6506007)(186003)(9686003)(55016003)(966005)(316002)(2906002)(41300700001)(4744005)(38100700002)(122000001)(64756008)(66446008)(66476007)(76116006)(66946007)(66556008)(4326008)(86362001)(7416002)(8676002)(8936002)(38070700005)(5660300002)(52536014)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?1JfYtZoABKBA0So0Y4+KeCyZbWwqDq7GHRvU3x5ITyjBudQPQzw3WE+Q?=
 =?Windows-1252?Q?Y9P26ZHOao5qJU2WGuizNLchusvOZRJ4v+NAfx2qUOLb57VacXuC6IB4?=
 =?Windows-1252?Q?iTwA4uTZbS/dtZQqTFMfSzasrvW9iLu4ubJ3FLRmEZIvRj3eSEcpDU3l?=
 =?Windows-1252?Q?eyV8zXLj9W4hejWlucvpPLvRzfLwpE65Ur9eRxHcYtOSGedmwqx8ZfuU?=
 =?Windows-1252?Q?TLfm3E1n9QnN258O8rsmO2+H+pkrcQRLv/7etJ3EHfSXauOZGfLRCO4+?=
 =?Windows-1252?Q?ng2SlSNFtkqTYt78+4nkcbUCPYReHoT6Y43W/j1tVZ67QfD7gNCe2lBW?=
 =?Windows-1252?Q?vNT+KsPTBEW9A/yQxnKQ267jQP7OaWHB8gt/EPDqT8yY0PmycenBf17z?=
 =?Windows-1252?Q?/FiUFsPeIK2t8NwHPpQGWe68ME++gdOXD0NwFdpmlSS4dsh0n7gnz475?=
 =?Windows-1252?Q?66JqMplLheHp4lBJlYMkYkgUWLhDGayr8veti6PIvmU1SE7OP1B6gBSh?=
 =?Windows-1252?Q?yN16NJDyY1cabYQKxMGOioZMJWzuIlONas0R9e3nDGzLv0gzTZkds6I5?=
 =?Windows-1252?Q?RJSW0N+64AHR6JYR4BGL+iquREEyAPCOHhu0N4WjWcNFOfftXc3rviOs?=
 =?Windows-1252?Q?1OU0NduKbUdgzaBNVyRnlzMhSjhAQuUSWY0qNTwI9DlAfuXLjSJTpwwH?=
 =?Windows-1252?Q?nMcfyeoTWhAp3EC/3SZCAD3b23EuwRDHJTim7V4jxG5A9IAzbJ5ykzDI?=
 =?Windows-1252?Q?VCRkjhDwX10EvytMY9aatXgJpkUumgpQ9mCnaIuTn6jNcSAaPzKY1dGc?=
 =?Windows-1252?Q?ZdtDpxTnaYR1J6cATPt659+4b7B6bVjYWJhe1lRK04fhGYfNIwdJRf9F?=
 =?Windows-1252?Q?Lo5c5JYrFiNOjEDD3USCMFWSWoIrHWfkiq8h6TVIxgqINibfTRSHujWD?=
 =?Windows-1252?Q?kIlEN3wvLotLxpaGHPG6Vc8ZJmdGBEFoiYLVsndureKPhI1Rn8TTma1K?=
 =?Windows-1252?Q?cyIgPp7AKFUQqA2OJ1uaPNfiD7hYWcgGa5jSIWk1hR/l5h2N5LFGeAp0?=
 =?Windows-1252?Q?2f9/FjzsIG6FalNTzvd1K9Q6pyDdmEvGftDFdT+z8hgRqOWvjy6Jx+PU?=
 =?Windows-1252?Q?7gnNFD5+ffg9QjU7u4ekhSrnWKUsCfALFacpSJND/K3W7MNhM256K57/?=
 =?Windows-1252?Q?w4dqLrqdWnq/RqW4JENnNZ4qS6GJCAOow2r9RmbDgfnWNFsKAKV9gDTm?=
 =?Windows-1252?Q?qiGNXL2SZ1bSMhNXiOCAVhGhz30xZNpAElqyVxxrV2Ph8TOZMOcwaqLZ?=
 =?Windows-1252?Q?v8xwMzg9/0GXO6J6RD1QCEzissnoAIaOOIUhTtlY1HfDhl5jNG07R/2i?=
 =?Windows-1252?Q?QtkJSsDb50lplWki6BS8AJLzom8NFjFg5ZIp8v4MN7/hgJhV6OSUKbAZ?=
 =?Windows-1252?Q?Ikd/pAEF8a7+lxEeFohagb35GYfNLP66bnXD6m2RsFDT4MQagO9+yNLX?=
 =?Windows-1252?Q?5Zyrxlpxtl2FLfYm3YdDu8mqWze04NpA5QH5IkmOWyIOFSe2LrWCylN/?=
 =?Windows-1252?Q?6ErMjnEgDrBpBgqNhpTwII9EdKbMCFP4M6J+H57/FL4j5Y8rHEGtZCF5?=
 =?Windows-1252?Q?oufP7HO4sBOE45EHUMJ5lG0dbMcrri3UrMVfekA1VqbhTYV0VjP/meQD?=
 =?Windows-1252?Q?50E+wV/UeM0VvqPRylVWravXR0U2C9sCo5iCV8SM/khK3YcGJyleUA?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acd2764c-0832-4a62-a185-08db815083f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 14:18:21.3724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0e9luPr2Nuef1QukLieADYOp6I79E31KW3QNj9C57v8dATOnMq799iE5S6hKsQD7HOOvlbnEBoAnd7QX++eJQ2ZUCSJIT0ZJQhE4ypxg96o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11259
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Monday, July 10, 2023 6:47 AM
>=20
> This is the start of the stable review cycle for the 6.3.13 release.
> There are 426 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 12 Jul 2023 05:45:32 +0000.
> Anything received after that time might be too late.

Thank you for the release!

CIP configurations built and booted okay with Linux 6.3.13-rc3 (b95b5708242=
0):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/9=
25837172
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-6.3.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
