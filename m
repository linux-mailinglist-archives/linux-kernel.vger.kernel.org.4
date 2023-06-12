Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB96372D3A6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjFLVzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbjFLVyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:54:51 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2122.outbound.protection.outlook.com [40.107.114.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55C810C2;
        Mon, 12 Jun 2023 14:54:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/eQFcaGyNvJCtMZ1yaZSnjdmrO1MRxH82yl6AwfVD6XmJwr0p1ibxwyvRiXtnzWlH2VySWOQVEHPDoudDsUELcDWAxcqXUrVQ5VBFjDM9PyMxOHwcqXfyNzYVa65Bcn721Haq+QEabWLjTYiLVkXTWvyV2qpkzU9kVsZVXm/U9HAsscdfWkXwN+yzXgcmx2ImbNGOR9i4EzMv1yBZDyqXK9vFa5l9rMdWUQ40CicDh1lpxUwS9sc4HZnnlL02zGxDk5pc4UbGCYzpW5zfghIieJExNSCaJBUrp9dl/K4266MvQcIRDRMpYa1sC01/S91swcPljqQs5g6U/i+HnRSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nc9LR9XpozkqxMEbdbabbaq7QTkDPcMymjqTwiPTFqk=;
 b=YfP2bRvmx1tCi9UtB+m2hxOKo9XmZCbYqFrLcUEptEd8rUKXtDTMifk/Yn5cpXVU4b0OkOM5BmnmaZX4gGMrQoRzvaZ82ntjQU/GRcHnV7tzRLc8fUeTP3gX8ql3afd2irCRyyG872WaEWs3Wib+sRuL4DU/ZSb0/mpQLtTISMQhl4QfiLKRA+qHhyzMekAlC/6INhRno/OdUnXhVwTLIBXSQbWxtH+IPX0tmxq8alnImYk5Den37wBRLmSRzp4YGwUZ2EnIQodGEAjVDjUBSLpifkIoUMZeCk510U8GU3dK7FES6zM+cCDZWIRK2SCEEADl+pgyeQF2RmADrM0Mxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nc9LR9XpozkqxMEbdbabbaq7QTkDPcMymjqTwiPTFqk=;
 b=L6q0qyXHhhhlt0ewZ86sA3/FBnjQJGMXh7Qb1+AgroYYyDfjiijXPrVqkHSwJlKhI/5V0cSs0O8Os2z3Weldu+KHOtzk8G4F/ftDFdRJVNjGrlSnk/+MZyvlaRCSG9EFKUt58HEgf/YncavMsrtg2hLv8RBafoqQb0PVS0h9FmE=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TYCPR01MB8680.jpnprd01.prod.outlook.com (2603:1096:400:157::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Mon, 12 Jun
 2023 21:54:45 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 21:54:44 +0000
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
Subject: RE: [PATCH 5.4 00/45] 5.4.247-rc1 review
Thread-Topic: [PATCH 5.4 00/45] 5.4.247-rc1 review
Thread-Index: AQHZnRsyQf8l7QzxzUSR5KzCzuOwa6+HtErw
Date:   Mon, 12 Jun 2023 21:54:44 +0000
Message-ID: <TY2PR01MB3788FCFD0BE2497DCD1FBD51B754A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230612101654.644983109@linuxfoundation.org>
In-Reply-To: <20230612101654.644983109@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TYCPR01MB8680:EE_
x-ms-office365-filtering-correlation-id: 2279ed01-ed9d-43d1-5325-08db6b8fa23b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jsizpPjanyX3K8uskD3mDlr7ZIOTJBw7z8QNzB5z8GnzVk3qSbO31AundNW1YJ8ZA/77TmfJ/AKIZJc9SHBF2wqOfY8fBzuORj+mozuf2lVobJzWgPm8ryLBI+rSKwP5Hfvc9rORZIAf+xGB/XCYhbK2sj57qzvNUDLeeETSh5I17IKPGcfGdXid/TsQKokewcSXK6uFdF9+CJsRiIjA0M9uyxplEyVF4MBgtQHvPOZrAZVpQNxWVAPW3p7jsL1e39SvhyvjO4tK0ozX+bEm61nvNJ8ypty8tPJxnE9qDYOIGN/UymT+qjEq/znZvsOC+4nLJ8ImCn2u3Dqk8Wk7wxRS1GIeXMv5OtpOHk3xfEK6FIbbdCUu+nLrV897HW5Y5t7DBi8KiCYKZMco0DWwVJrptCOFiqDkij2Cr9g7FXoHKbKGW/ms0qsQwisX7gV162gUYIgG8+YuIb6naQkyaSVMgF38ZownkV4qLHizlfaRHSgifGMxJlxC5SaHpxrYhKeJxVmRQtvPfhKikiEE5mOwbGk8sLnVDyx9jPbOzpzOwXbVSeZErduVmo+e3g+XcYIRPHoqjAZnfWoZoQ+thW8J4vTuXVHr4YZWrtZsrXWnq8ki66JDYGu/HyNkhtlKvZj5wfDWT4s2eu6eQ0Sk1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199021)(64756008)(66476007)(66556008)(66946007)(316002)(7416002)(4326008)(66446008)(41300700001)(76116006)(186003)(4744005)(2906002)(110136005)(54906003)(478600001)(8676002)(8936002)(5660300002)(52536014)(71200400001)(966005)(7696005)(6506007)(33656002)(122000001)(26005)(55016003)(9686003)(86362001)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?Oeo0Wg7GCDhNdvkok4BJo+3kEoMRzHZnsKret5MEgDXA2JfE/xuuYMNQ?=
 =?Windows-1252?Q?2PaYTT9fGiioePAFG+sGRY6oJ6xaCUDHg0wzZwiaMmAl85JCjcfiDMuE?=
 =?Windows-1252?Q?/e0VoEEEgRxT7t4jmdFRrNa/VQA20yXBED2IuEN8TEeisGmBPLtEnEH0?=
 =?Windows-1252?Q?Y3wl6Ma5kVgxIVlT79+0Oyd+hHiTrWJDnvI5auP8MKL+pP45JSAJ1YBm?=
 =?Windows-1252?Q?esEnSa9XY9IRYyM6jlEB3tI6F+msz++3w+nyj7VyRD84/Ov/vBWgI7PB?=
 =?Windows-1252?Q?G9CqrYu3YXHOl50cM3V/W6agas5f16jDTnNuFX3LltGMKKkN/rR5yUfN?=
 =?Windows-1252?Q?t0vwv+DVxkjMsEUCG2/pZPzt1iR8BFc1ftbAKAZLmytsBs8fAFglACj0?=
 =?Windows-1252?Q?5gmXjw7dMaesf980+8A4xiKzIkcZ7ttgenX9vMevucDrkHJmHBz4iQrW?=
 =?Windows-1252?Q?jJW1Jjn4zW6tDuz8fFtOo77V2CMjJ4TebbDNsfHGm9LBHD6OeJNZZn68?=
 =?Windows-1252?Q?dadT3Wz7tIJSs6tOJp5W0s8t19DwnuCZf8YoGV9ui1FJR/wpoGWcC+3P?=
 =?Windows-1252?Q?YMqGB/cTHIz9forQti2I/l8xq1yJm7gip26Nt47m4aqscmijGvn8WTNi?=
 =?Windows-1252?Q?ljNOdQBn18kMentOKtxmtZoj6OFDE36Y8U/MWOWSWW8grEsUBym5wVd9?=
 =?Windows-1252?Q?860tBuvu8vgo531VqqgehQO/gBVe41A5oiBk3jPY7YpdAxycAjZZro7P?=
 =?Windows-1252?Q?xonNvI4geTwOY3jKppx2TkSyPSgaS+rO1gVyaEODOSVi3GedArezOngO?=
 =?Windows-1252?Q?3+BgJV2YqWmgFOVKn8GGNxFLnV9B+0AblpgH+QPASWwvu485ge273lQs?=
 =?Windows-1252?Q?G1fEBcN8UPREWZK76t1cLf+V2mJYBW77TxxYoi32hcd/NXQMMXcZKSdv?=
 =?Windows-1252?Q?i3NBJ9g3WLm5b9wF5JgVsH1/A9m/Lur3VH/ohuGIm8Bvjmeind1JBIpD?=
 =?Windows-1252?Q?ctFX55QuEx5BzXAndSceDrZS2iBRoI3FJhPA1o4STy/eVTbOXYIqiHE1?=
 =?Windows-1252?Q?rWnGwzC/CFahdPje1o4PyS81zcGhsrbdRvpzardlvKwVVRc1l3NmVsjC?=
 =?Windows-1252?Q?V8JFKWLPdGTlYv/Fme+APhoq8hEFOgj6qHYI0CJKmcneJU9ieOHJbrKg?=
 =?Windows-1252?Q?jjMhw3MLj+nEG4bFy+pmEEm8tfHOGUkE+3qO+CxzO4qxi4kAdMVQWe9C?=
 =?Windows-1252?Q?euNz7WpGTCoQznmdnyLS2rkFWOcSubQVUorptN4deCHEUE9ukzfqDu00?=
 =?Windows-1252?Q?OKQBcWdYcsltPADSHMiRRdtWB3jhtRlRAc37Jutor2AYMu8mYPSI0Iei?=
 =?Windows-1252?Q?CW8G4kJ3G9/X263ROHiUv1/g1rvfoxja0/qhV22laMYFddK8VMAtDMki?=
 =?Windows-1252?Q?8MgroJtaJBXHPZcoDljkNtBnFOvg+kKEUKrDmrgS66isbU+PsUARm6Nr?=
 =?Windows-1252?Q?GXV8V1mluXDGltG/JLXsuZTroxCDakdfA0+5U32QlxQMlyprV7e4Y0Ti?=
 =?Windows-1252?Q?/zcqOt7mBa0rlzwV01VjAcICR2OBSmQHmLfCgyxDvyPKFuCr1ivELfkD?=
 =?Windows-1252?Q?IUf5LHq/1itwqcpdoyVwgSPRFSp8Ibwdew+lRsgdYGBNh1/QfiepRweo?=
 =?Windows-1252?Q?YrpzBMo5pB33KSusxL/TNow8sFiQ+UTBi+ARnlG0e2BYh+neDW0cOw?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2279ed01-ed9d-43d1-5325-08db6b8fa23b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 21:54:44.9140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b9JrQOOKOkdUHaCn+fnvn1+MgdvJZtiO9jejANRVsfwOxwlUl36UkH2ark90MRHF3JfGssLCFvYOYPrJt+VvnJNXJvUMpZXrgU3ilP2GAko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8680
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
> Sent: Monday, June 12, 2023 11:26 AM
>=20
> This is the start of the stable review cycle for the 5.4.247 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.

Thank you for the release!

CIP configurations built and booted okay with Linux 5.4.247-rc1 (6385fa1037=
74):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
97026070
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-5.4.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
