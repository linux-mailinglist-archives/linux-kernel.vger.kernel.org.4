Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E079703E48
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 22:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243766AbjEOUMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 16:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243149AbjEOUMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 16:12:23 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2113.outbound.protection.outlook.com [40.107.114.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8E735B1;
        Mon, 15 May 2023 13:11:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKcS0wNSpxKCVTW3mtBsTMTW2g9TyJthBh4a5NlQ3TjNsvseuhF9Pp6XgN2MCICPJ6vhi8ZQkB4ZPTMT2lkwWF8vqQN/533OzaJ1BnjPIKPP1aqtuDxPNfxhvY4m20sX8S/8hvD0k/ATMFO1oZW5tb4sLZlaBW5LtfBZyH2Zu6La4iWgmnBv+o7fZap/lHt42sAz2Uuz+CIZYICiQbFh+MHBHjgIlr/FolM2BosjxeEfV4MHIB7vRj3NHe9EimULhW+/+N+TjL0CDiF8bWUboE5PUXX9dgAUyoiEjJqU7LrGTHuv4+BJyT6EghOh3vHQaf1HDfU8221rKIBHd2fv0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHWY2TRi4IipX1FWntQhQ3juVgY8kivJxEjLJVLW3Mc=;
 b=fyBJOx0lzCTP5f0Sfc0vIGbwy1K6f/S0tiSyeGQJDvj4OcddSNnG3TpKVpXgg9t0L3vCAeveEG8x0uRc0Pc9MEvlhIcvMVl+SyxIH4iPuoPZtOYJqCF1jO++oVs9Uufhn/gU8JDuZZlgYZoy9Ma3wMqO3jMSQjlCLsxekluh4RnmI6pUj8krBPVGTrGD7eqvaYOfSVAkdPuAKcyPA+ghwrbpzk0O8bOYdsN41xip0eVe++SXCtN+FW5SolI5J20vyrBl7Lh+21wmUVCngoBbbt8PP2zWdFfKFEIm6GZ5nbeFMZcGFNbLjGCT/5/PUHYNsr/L6kOmvmfPWHHvsNLOew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHWY2TRi4IipX1FWntQhQ3juVgY8kivJxEjLJVLW3Mc=;
 b=RzYbtF26RxuLDQ5OwmfpAiem/rY7kQcXFrdgvcMZ89/HZPxCvFfWRzpFflwsBn1VcBu2HohBn0UvAaLDd4vAri4N/+LX355XVvBSWbs6U/JFvOdKIM4eXQvDEsefo+WsGun0FDflEINSW+fRYbu/rVCYyASR0yfkIbrTzxGSsuw=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OS0PR01MB5459.jpnprd01.prod.outlook.com (2603:1096:604:af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.31; Mon, 15 May
 2023 20:11:23 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a7d8:4c3a:9cfd:2e79]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a7d8:4c3a:9cfd:2e79%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 20:11:23 +0000
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
Subject: RE: [PATCH 5.15 000/134] 5.15.112-rc1 review
Thread-Topic: [PATCH 5.15 000/134] 5.15.112-rc1 review
Thread-Index: AQHZh1L/8+ZnZt0BZUW29AF9JppBH69bwjBQ
Date:   Mon, 15 May 2023 20:11:23 +0000
Message-ID: <TY2PR01MB378855CEFC30E28117B29E7CB7789@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230515161702.887638251@linuxfoundation.org>
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OS0PR01MB5459:EE_
x-ms-office365-filtering-correlation-id: 0151db0a-baf1-40b5-8c5e-08db55808e5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7DyV8Q9TVpUrUvEnWmPBpUpbFJ5vyoXO68jcha2E2a7TqOYRckltM/8Y3RGyw14t1QCFk+gL49xvr+ApGL9X5POeuTRzAilv6EXyDuOYhqxT2xV2ikb9o5SucWnGK5rYLSlHb3D0TpXhscLpKLlcoc7XF6a3lxO+c8zMTK6dWWGfAReJpdspfouEyugFTU8oCRE8T3ftqsMzE7e8exd1X1hNkYFadGIHciDwSILALlX0fZv5uNtTN0lO0P0qbNaKUmTuD+kUp9DNjaDGh+WUJP1N4q9vxTGqJbQKcU4GbwL4770jmjm+mMDHbiYpTW3VObldrgE4LBhw4yh6MZVjsUQxlVWL682RCVzfXdjvEt9fe/pFi6r7bKZhkbUYuFwNBnN7qw09HmSQdqfDWLxDwk9Zqng1wuImLi+6HZmeYJSmg+OJS1EdEmrBPU99+9aJ50WNgtI2RZwo79JmgV/SwV6Ko7TJ/PHZD2mBy9Lquvrhv78nGFkH78kpMYhB9Dqy2Svq+eycmJ7HCERgkiDPn/uan3A84tSvVxZkJnQ4wWrXNDLjRrJfQqMmZuxEMcC8pHb/dYRnln0lEWv9cNtYk9Bc8Js6tnfLMzckkPMdhlCNp7wzefl/LfaEOCl3FanSHADl9V9p537c5K5yM+tnYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(366004)(346002)(451199021)(52536014)(8676002)(8936002)(5660300002)(7416002)(4744005)(4326008)(316002)(41300700001)(2906002)(478600001)(66946007)(66556008)(66446008)(64756008)(66476007)(76116006)(55016003)(54906003)(33656002)(110136005)(7696005)(966005)(26005)(186003)(9686003)(6506007)(38100700002)(38070700005)(71200400001)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-9?Q?yrHLIh1KWT6acYKpCyvHa3PjBbF6v69AFZgTpdyTRCU2L2Yo/xUxLSXY/+?=
 =?iso-8859-9?Q?NYusjmiMRo5KIuwNm+5FyDQulYtDwUjtXf5xbSzrXV3sWELEf93Mr/SewO?=
 =?iso-8859-9?Q?6Zm8j9PzwHmQjvgvGXnsCkHWLdTFQ98sko4R50jNM4eEUxw8hkAJDT6UlW?=
 =?iso-8859-9?Q?Up3/jTlKaRmEBXzTyqeWRN/BKxqq27813iN0pyKUJMlBhOrxloUjRLNq2l?=
 =?iso-8859-9?Q?Y2qhBygRRpBCYFmiLPgbaWvwr3dG9Zqzw5u7Fb9rTNLI76S+Z1iNe/9pQT?=
 =?iso-8859-9?Q?GCdwga2exZnZ9RaHKzWIHJS1/SChlkt50YUbvbMeS7E+zvCjRe3qtm8wEu?=
 =?iso-8859-9?Q?xjUUtijqIP720I+DZ0ALgsBeA38nzKwRsY8+2J8mfU1czbSjp4r9ZhiI9e?=
 =?iso-8859-9?Q?YQ6596Wbj0cH2i6qpHeNFtYNgcM048Blpj8jS/6LIgTP0C1yuNMjt5Te4i?=
 =?iso-8859-9?Q?KijVBfmDKJ5zP8XeEm56VwX17vFWuX/4NWL8MqU2nXBL5QxM+PTvktbHpZ?=
 =?iso-8859-9?Q?lxt2ePSrofDawVvNQPN/0CDuiaTjLzY7VnrZAaO0EoEoQM+oLe97kmE06I?=
 =?iso-8859-9?Q?JsZjJXIHMDUUkqFChaxA1yQlL8WmN8daijDbGuG3qNApgGbc8fQjkiZjYB?=
 =?iso-8859-9?Q?QCznAOmqsqCeU7tl3q7NPyB0toUOqwju6ujKNtvM3UH2ATM34ah8TJBiJu?=
 =?iso-8859-9?Q?hCQOooOA42yMCqz37282Bl4p5t5WRmbONFqNh0Q+iL7Wuw24UvRIFl+uoI?=
 =?iso-8859-9?Q?9FbHp0bSTbiiPWOZVyj04SkfBjgr/o1aQI9bDvMh49HuJGKrfhRZjEjsVY?=
 =?iso-8859-9?Q?jEL40iGQ1mxYvF4nq3FKJuDhqV+2sK3O0iwIaG64JZF/UoyM1+ffO8U9gM?=
 =?iso-8859-9?Q?VcZpXidlv4vx3aJKs+2pynbO7stDTvlz/z2R9B7WUS+sNYrFUS9DN6QqZ2?=
 =?iso-8859-9?Q?ZRZv+VYInbW2L63MALEguYGN1v04hSqGHnF04U/6pkP9o57wmODJdJN7uf?=
 =?iso-8859-9?Q?Fs4Z+owJth0idvwEcNnhBmnY9WWMS7nHl4aPaTlvGIBwk8ravEJ3OVQ48O?=
 =?iso-8859-9?Q?18fxqnEva4zGHJY7LpajjXzBog5zPz2IL4ncKP1/gNox6uO7QKjNEczYC4?=
 =?iso-8859-9?Q?aPtivYediggbUJjKWEfoRK5m5YjXit3WByLMqWcxIJIQobt3Y5mjxH3X2C?=
 =?iso-8859-9?Q?oS40nlwyiydl1AwDsEORDWs6MgS34YFiQDig1DuLkTgRzAjAvf1xT2KZbF?=
 =?iso-8859-9?Q?+XoWvmMACzkYX5ggJawFCdn+F5tc5ihkcJ5eA201POWrLZRD8JWSX8xIjI?=
 =?iso-8859-9?Q?w87fdgriyVljLo46gDf8houTXGyhQLFCx4uCLqENpHsC4kE/la0ZxSaf6F?=
 =?iso-8859-9?Q?1s3Iiw0URAZdEmr5DobxshKdcSM4eLfVGQ+wowjQe12R+zsdR2rAaZjfcD?=
 =?iso-8859-9?Q?PhC1BCy5Teosd7SgjG2Bs30cYybplBbt4+BJo9C7KcNUe5xaQYcAthKsef?=
 =?iso-8859-9?Q?+6vfE9E52v7ObsrgXBUPwFwotSfxjdViRzrSpAOEUrEhG02R+chuSmykqF?=
 =?iso-8859-9?Q?9QmhdrszugcgnKk1bhZeJjCkSeR4dEJPOpa3CCnQghi+EKHKLNo18jleMZ?=
 =?iso-8859-9?Q?dDEfev1wgWyVj7I0pjcns0f++6q8utLIBpXl3AL0piHl3zuFfPfiW8gQ?=
 =?iso-8859-9?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0151db0a-baf1-40b5-8c5e-08db55808e5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 20:11:23.5706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7NsXr0fUGo5U/iv1G/dv1Urwpb6Lm0O2Hp0Vc8GY4cNjIVzC3SFNsycWCJfVDncseITgh4dqnnNkbyIIDvyOZBYxjhqRin/ewLLZ85YDYpE=
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
> Sent: Monday, May 15, 2023 5:28 PM
>=20
> This is the start of the stable review cycle for the 5.15.112 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.

CIP configurations built and booted with Linux 5.15.112-rc1 (070cc2c270b1):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
67957735
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-5.15.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
