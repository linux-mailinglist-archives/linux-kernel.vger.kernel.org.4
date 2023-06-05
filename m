Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1297221E8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 11:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjFEJTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 05:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjFEJS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:18:56 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2092.outbound.protection.outlook.com [40.107.113.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAACD2;
        Mon,  5 Jun 2023 02:18:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pkrh42HevNEXx/VimAwRBN6HF5OoEz1YsWCc1ILZ+Qe01at+vo9Wm4I42IIQI9y4aNxVUJ4l3KnNsWmqRAXQxxVTOBaA4uhMiupE1rquHdRmtJJZcY108kXFpX4sAkDjR6AQIrVBBn8/9aPbBku6f3ZZFrOGxeW6MvxXrUWSmJcxwKP8O+ba5kqaXFQELqx0dBy9HlQXUKILtZatpht59o2nKLr66ku7kH934DO64g5QEmOetsUtj+pfHs8/PjaGNa2U+WLWlEgDVf1YtrsUezDsZNxKtCKErhdUDXA2WcDd+U1CwV8L4KxEE78HNHH7MDX9xvLk4tmzUF7YJXUSpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2cZ2pUxGfVkRhb6R9s13fxEEuoU5fBTnJVmfQVIHmc=;
 b=NyCrpq00ZBIyEtc9P6ZGDRHf8/MzKKhLSFqeIizpnk7msHPREc0v07msMg1aZgsTFHmFzJr0+3YrQjASx+8ONjv+Jd3xdYnHDcDno4FQPtilhMCK1yAP47HigSO49xPbG8NNJdZB521ajGAvW8y0shQGb+l4zqPU5FVpvpY295tuy/soJkSrZuvQvnYrmJ94QxC0/XupQ4W/GMHba9rRY7/xuF8HSwUT4yjFXfvnYOKvSU8rE37cDItw1QPwldruycmzXGATiFLxrDKO0TqQMBQ8MciVbHya2WJYtZjC31uGAS/RpNXSL+2cuQ7oO3tzuxKE2y6O92MPP8KUsFpzUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2cZ2pUxGfVkRhb6R9s13fxEEuoU5fBTnJVmfQVIHmc=;
 b=mLOSldJXDSKk6g0U5UMlT7Br3DoQbB6FiJ0gi4QPPqI+8qLZKXEPT8HBRPj53u9aSmcoA/gkO/MwbUI06glC8uNKlDAb6zA1HZqIFniOGCadHdgkO4mjPH/+KsDG2T011JgKJIJBbBesTg1ijOva9hdhpUBn1LptcR6mLBesgWE=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OS3PR01MB7996.jpnprd01.prod.outlook.com (2603:1096:604:1be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 09:18:52 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 09:18:52 +0000
From:   Chris Paterson <Chris.Paterson2@renesas.com>
To:     Chris Paterson <Chris.Paterson2@renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: RE: [PATCH 6.1 00/39] 6.1.32-rc2 review
Thread-Topic: [PATCH 6.1 00/39] 6.1.32-rc2 review
Thread-Index: AQHZlJZ+L4ZtpJsasUCPMekq0AWPM6978vyggAAA7mA=
Date:   Mon, 5 Jun 2023 09:18:52 +0000
Message-ID: <TY2PR01MB3788DC2D9C270EB8196CA330B74DA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230601143327.479886832@linuxfoundation.org>
 <TY2PR01MB3788252907425104BE825F0FB74DA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB3788252907425104BE825F0FB74DA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OS3PR01MB7996:EE_
x-ms-office365-filtering-correlation-id: 159d793e-6127-4d47-a4e4-08db65a5e0ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 15aVj8XqvNuQrWvuqiM4u9ud5vHLo8a1VVzw+qGfNOvyKYxtvM02xgGaccchX8ZzT0SDwFOJR5FOYs9JL+JDZ12YYvFAy3R1Y2AqXgZdVdJxwhMTew5E2jWy8wW1pLM5qrk1FbbcwSGGOzxwbX1V5b/MywuAPurx0zpRHcDYKyE5SaD+N3ex78IM3k5ZsAGPC0ySeV9D1A0RLVOUyefe2Gr7jksZFgnoudeVP+EjG0kj5LdEGS326dJHjOO8w4aSmF0+qOy2sBq2sFBB3lBQF++/RTkj/Ln5yec3xAjai57pNDlcZQfrCqmPehee9sh4kyIS6Sz94TBablFy6SDhTJKtkDbwNcBtUovimaoIyZqL2ypdcFjQ7ighMLhsbBOHVz99pO8XHaxRyLIQkFR8PMq3sP22e+8xtClVcPhcpA5XOnE76wwb3NVcLzQla1oOb+wYDmhBbU76iXV4GrTgtgc98nh3UzFA05J3MThrQXe1jRwxPmNTaVdaC7mIFZqfkqKO7Mi1eslfDsA3NRQeqb2N3xP0kXGBgs1teKme4QDOZm/9SOU14EppZmQnE0kiAzutlUqdrRTfgFnnW/IE+6yHN5sv+xh6Jgam7xw9pwc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(966005)(7416002)(110136005)(33656002)(478600001)(55016003)(8676002)(8936002)(38070700005)(316002)(41300700001)(66946007)(52536014)(76116006)(122000001)(4326008)(66556008)(66446008)(64756008)(86362001)(66476007)(5660300002)(38100700002)(54906003)(7696005)(71200400001)(2906002)(4744005)(2940100002)(186003)(6506007)(26005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?7CIIjZEswUJbdEin9odWqTmysOda3ujlzgBe4lOfGL2BdCO4OsueUSsS?=
 =?Windows-1252?Q?YvP6pzxOzfE+AyJm09IwbXWNU3i2zyiz+530g1zNP8J6ESEGkYhLxN0/?=
 =?Windows-1252?Q?GEkF8VViJgpOFqALRFzx06ekydbo/2lpaYxoAcTPNDzQ7HSvK7L/7UVY?=
 =?Windows-1252?Q?BV9O120Y2bEDsWGcTTwfQDPVzzfRvr6XsM5ERxpsAMiBFOWpDDSFyYj3?=
 =?Windows-1252?Q?Pt6a4xQTynkyt0dHOAw0DBWPzrP5fYnK1K2Ak9gBlvsFoYb4IjiOEGw3?=
 =?Windows-1252?Q?g05QvnJGap4PvaCv6cISJerzww5im1P0zN0rqIjhDXA18zn32Gm+i39S?=
 =?Windows-1252?Q?jksoU9JrP0MQOaS5LWzP22vTOZy5VgOJ+nBGzO2y4hrR7SzfmfNK7L+i?=
 =?Windows-1252?Q?1Wr1zEE9j+p/ODNFU7FWWSQuUavjmN5i7rXE22hm7kywtMYdWc4yjnsd?=
 =?Windows-1252?Q?LJMvc7dWzR/XN/L83XT0CZ80PlB87MCzkZMGc+sAdW55vOPCLXVLItSX?=
 =?Windows-1252?Q?7R1qX1XCXRC5x3gzF9ZprzSH6r1ZOLNQcwWQknD7n/rORiKZNzDsKEj7?=
 =?Windows-1252?Q?wFNFMIlORaQwhoedOAus8oFA2xTV/sXdxBFtz4ovy6s1opJQEFr8OKIw?=
 =?Windows-1252?Q?Pm35YpgOjdG5WOzJjC7Dts99ieHsFCSZeiUHw+admeTd1sLutdBzRUuO?=
 =?Windows-1252?Q?OkQhbL2h1k5WQnKW4aQyTAWfZYmSbCnlUSpmzchLfhaFw6hVnDklX0Tx?=
 =?Windows-1252?Q?W8/02yTYkQrcBRsrKsXq/m/9myoIpdXmmvcSO60CK3t+URUHTPo6IZEW?=
 =?Windows-1252?Q?UPcUg1V8fYg3nR2n2GsmVYbEyf6+5qbUiYGISUOKBp5EU4jSbycH5yHy?=
 =?Windows-1252?Q?lIQuw1Q3ovMWIQgcPoxAZGl4WfddTIxH/rhddZ07c38RC96LMcQikg+O?=
 =?Windows-1252?Q?7lZXN9zC7+H++ZuiXf/RpFJ4nDo5SC/wJh50P2W+1Ok2jXHIOqGalIxc?=
 =?Windows-1252?Q?1/KB8LlHcpgGUx7SDQj9v7oLuH/qamGU/4CpYxwdWIF6mL+u0c3k6xT0?=
 =?Windows-1252?Q?kvxqDpEfDr7jnEnb7ehImhFU06GwNSb/KT6fH7V8X/1T6MwAAdt26o6a?=
 =?Windows-1252?Q?nuaPj7mMnVsXDxMxVhAO23wr4T9lUntsK5BP2e7oNa/fpEZvNxtOvUQF?=
 =?Windows-1252?Q?QSi11cA+b+yoO+tUpGu7PHgE5T92bZ0BnIMAq9r15sKkvPAWwR7NCSu6?=
 =?Windows-1252?Q?21L/ywms70Vd2w4xmymv+ibhGpI1F4zyW//vuwuO4bovfVtMxnKBSwIq?=
 =?Windows-1252?Q?4QUsZyMfkO38n+92GzCozLl5q28ZA5XjwnlKwv9A19AfG7n5rqUAdSQI?=
 =?Windows-1252?Q?4lMNuWKfnehXKq4Vtrrs+9veltP8Jl1CoUbbRhVf7jKfyfKSrfDvLOBC?=
 =?Windows-1252?Q?cSwOd2EyWi38quBqEUpDRb8DzdUybRxnOjTD2+OHg+7RjT+x7IhxNC37?=
 =?Windows-1252?Q?oxtwfPCrD5EFa0m+KEyG5ghuxjdTRjPWQPRERj2sJnOZYIzE813bkWWL?=
 =?Windows-1252?Q?TN70ZSmH6SZ4Mft5cr2DxdlJniVBbvI3Vc3xLjsdqZhD/yaVkBCc/tjn?=
 =?Windows-1252?Q?AcyIDPCWmDIzUywGJgpltkMLEYNeRkfPaerWhM/YgZornZtF17DjtxsN?=
 =?Windows-1252?Q?aEtJ3fZOeBl8e2p6QdpWS/9hh6ju94+SBwQzV7zlqc17N9i9NzMQrw?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 159d793e-6127-4d47-a4e4-08db65a5e0ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 09:18:52.0337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w512e+mvszedcc0ef20Ya+IqwtEK+xOLRtzLIKi9oEbiCmsbCYLu4B9EdsN0MoZi5HU8REaPIMo0Qhr8o/xg106tOrjl5V2VIrsjHaKRs2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7996
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Chris Paterson <Chris.Paterson2@renesas.com>
> Sent: Monday, June 5, 2023 10:17 AM
>=20
> Hello Greg,
>=20
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Thursday, June 1, 2023 3:36 PM
> >
> > This is the start of the stable review cycle for the 6.1.32 release.
> > There are 39 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 03 Jun 2023 14:33:15 +0000.
> > Anything received after that time might be too late.
>=20
> CIP configurations built and booted with Linux 6.1.32-rc1 (91b86c5080c5):
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines=
/886202580

Oops. This should have been:
Linux 6.1.32-rc2 (7d0a9678d276)
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
86460585

Chris

> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/l=
inux-6.1.y>=20
> Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>
>=20
> Kind regards, Chris
