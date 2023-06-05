Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4A07221ED
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 11:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjFEJTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 05:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjFEJT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:19:27 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2132.outbound.protection.outlook.com [40.107.113.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BE4D2;
        Mon,  5 Jun 2023 02:19:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2Q/Hld78pFEsZRrYGkIFhyRslpWV/qN3UxKpkKukkh2VjuaCf+lT3Q9FTzLU03mfBXJSuab+fAzJrVcH4alPP41qLq9LkNzvRg6LztQ5BON3/YetA8BmlVwXQOUV24nbuuRj6Kf7n1HI+JwXtVmg2vFZu4TIhIsR0qA5rXA1iqs+7UeiqZFPubJFjIVLuzYZoK976MvWq1XUi7Zg1JPOMERo2wd62LgWR3ViHkX3HJc4GB6pHHLGIGGc2cKzlpjjPzRfaDKD+B6RLftVTFXcZ6y5cJwwmyEZaai9bf3crIxEMYhwAtNqE1Nbzg850PB2KpPh3fjN/R4/XfzYaqulA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nXDn/oBIWcxQICZfrVS6AG2pelkC81Op/yXwqC8uhFo=;
 b=m/aIaOOm+pv0i0kpWGfukESqQOjZWYyBeW4jiZ5zU9MXK5hou99TJXtdgm/EPoxINmRPnbWVctB+ckdi1dsEUfiqR/Tlp/eGFBEcXt2SAvokx8DixykBj9bJNB9PmWS1+Xl8GHhI5x6nsEQqlpDs7Jj1mGRkKKExO036rjpImgMEXz/SW99jyKcZezp4CxcODUwju/UELzY+UNsUBbXEiIhCc+a4kAnyCOlCzjIdzpUUw0Zw4eSrpAOurV0GBREuEP+Vq2uiwttZiZVIV2Eqje+UaREX6OK/SYJNe7TrkeEJYaYvjFakqH4QDj0v8Q6WaFx1I2bz6fvOnGeuMqe0fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXDn/oBIWcxQICZfrVS6AG2pelkC81Op/yXwqC8uhFo=;
 b=ZY5pPqHb0Hg4SZTorolqATYuk/B0rUxHox2+8SonbpuNz6MelvWozWp3ZRzRQ6RO7w++oyJBiBMdqK9WA2w/MnxzoL7Nd7eoyXqeW/LRmHtXHoaqdAphDgSTX7VjxroP+sm856g64EuBkNiovxrUpBmPjki4t7wVi2C3/qpetnI=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by OS3PR01MB7996.jpnprd01.prod.outlook.com (2603:1096:604:1be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 09:19:21 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 09:19:21 +0000
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
Subject: RE: [PATCH 6.3 00/45] 6.3.6-rc1 review
Thread-Topic: [PATCH 6.3 00/45] 6.3.6-rc1 review
Thread-Index: AQHZlIy7GmCaTWPvZkaKZr365pRIIa978vdQ
Date:   Mon, 5 Jun 2023 09:19:21 +0000
Message-ID: <TY2PR01MB37888963C497834364AB1776B74DA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230601131938.702671708@linuxfoundation.org>
In-Reply-To: <20230601131938.702671708@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|OS3PR01MB7996:EE_
x-ms-office365-filtering-correlation-id: 14d01285-3e9b-4128-4153-08db65a5f2aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9dfm/YOcwrJfmrL+TRQ8f3Ad3ZSQ/N0awFeTLOavPWujToUVoE/SM0DJSd2yhvddiCJuqj2+y/lPOxDNA/I9fpzt85lHuzdFIw1MuMU0hgd5kn/2XAAfUPMjTLSBjrKfiviGC+ec1T4Z9SJHoTj4A+PlpQcYjLm6IzeEZ8OCNEGeWkAosICeT6DdhKj4x4ph1709r+tYuwtSbHaiEc83LQrcQrptrnJqNKSCsWgZUQIF4D+b+ayMQKRtzUBptIkhAOFh9rOlp2ta1d0jpz3UD89khdv26LkaELpfm74FbBYA4glMme3tR1UCNLgyyeCobxKCmydJDGFHKcEIEXkDbnZ8lDu56+tnYnKAPyZFlocXlfG+N7ObZqKTN0+259JsNdQe0ptUxtKqKTVfvXx3JlCfqu/U17AmsM1k2VbpIwbdRlufYJlKkp/7qNr+9yiAY7p8FoEJSCPEZhz0kXSbCvdV4gXLJsSxnKfbb9Ld3VggFMGX6UAVdytrNaqmYyrWcEwn6A4IQ6aXfUd9F6UXeoaKR2hxHwmnVElT7QoxPqBivMGtgX/yMUvN7T2fmCh4QHEsekhvd4OYQtj3uaTQvX63RoUNcvjAh7YRGpHB+e8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(966005)(7416002)(110136005)(33656002)(478600001)(55016003)(8676002)(8936002)(38070700005)(316002)(41300700001)(66946007)(52536014)(76116006)(122000001)(4326008)(66556008)(66446008)(64756008)(86362001)(66476007)(5660300002)(38100700002)(54906003)(7696005)(71200400001)(2906002)(4744005)(186003)(6506007)(26005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-2?Q?iJn2lILCdnXkx+xHpV/gQ4T1Sj8qMineS2k7q/ML7WqwnW3jzZPqOdEJZH?=
 =?iso-8859-2?Q?kmFxpbz2ynL10jMlm2CjfqdP+5pof/NQE4sp7Xaf2dBYChCKNex4VxeMc5?=
 =?iso-8859-2?Q?SDlBQlQvt3wd1wpOxYmYNvjOQWBS8wDiTbaUYZnw8jPNxtdZMDBbBj9pmD?=
 =?iso-8859-2?Q?e6b09EB59Ypi/zxkdxcFr+bC2mXU8pIQ3djyLRbFgw9E7XL/eGdFzvGPE4?=
 =?iso-8859-2?Q?cAe4xcy1WV3IzdVkvbvwSAFSbUWcREleLldodA6ELxDaOCeOhSYVehfWiD?=
 =?iso-8859-2?Q?dKP3ifgCTBpika5TRU2OLEzCDVCMZsNXylBDvvUPwSuzuvtqxGkerNJu9w?=
 =?iso-8859-2?Q?EdIn8ZOFibi9tEXE0SqAyTGfRsytdYu8qV0J4y8A30ZUO5MIjwffO24Ktv?=
 =?iso-8859-2?Q?8TeOEucz4O4Cgggmzx46kwqXBaiw0gzSmcpHw/59wHWqm4e4rGEd3W/nxl?=
 =?iso-8859-2?Q?sPDAoiOtVkL85eSKUxw2dq3nf6cwVxRmw7IsmlmKhRnNY1CjsxbREjaGzS?=
 =?iso-8859-2?Q?nO3qlkJFbsdANq9c2C+h6r33UFO89pKH0XDRBwZvB1iahHPXKmK80NpCg4?=
 =?iso-8859-2?Q?wuiCZzCy4xYKZiO8orncmo/oXGucP2zPQkqQWbCv0K+xktfRvbLKKFVFmx?=
 =?iso-8859-2?Q?48cNye1RL0JLbt2QDHDqSeIWVXtBmTw2E1d3ClbPdfwOv6ljroaUHLYuIH?=
 =?iso-8859-2?Q?pe8t0M8mOkDtL4qeiPuleDbuPZp6AlVkFgnIRfRs5Jj1jZEhGVj2TihU4N?=
 =?iso-8859-2?Q?ReXk7HGlPIAXPZcLPldoAqJ6UzmmHvEneqvGKmwtO68dQBu0mIgYtk8NOn?=
 =?iso-8859-2?Q?MRL/JLcOFvP2jfe2EKF998vpZ8LRLmItlJUO+5g99c7J6kZ82dM/9sTYpD?=
 =?iso-8859-2?Q?Yob3hEhiL3U9s1JI3I+skhDi3y1cRYE81mCYz57K89FC0XLbr8VVK3Ok3J?=
 =?iso-8859-2?Q?Ie7xhDpD4x5N9KuyWz4rSnhcKvw+7qyZ5pysDrwg2Qf/Lv+ub6vFxMr5ef?=
 =?iso-8859-2?Q?VXzVp/TPZ4xIJmpsPSZZEmVsF6E7iD4Z5QB341mVlvUxyFFqM486NWOJMW?=
 =?iso-8859-2?Q?T9Jd8TZBG9AA4qeO0vlWSlVcZcCSM5TMJ1ShmJ2slHL8Nw6tiJxMGB5FOU?=
 =?iso-8859-2?Q?GUZTRng0qAay2D7r+XGXYJYADwsb6JCu+5VQtQAT1exkrzZvC5Cxg53Erz?=
 =?iso-8859-2?Q?m6zY9bBKrc3uVvYw4yb/XCMZ5TqwtD2/NNdcM6xTzSeYvprnqqnN7YwiHC?=
 =?iso-8859-2?Q?bQYOuebpyRcwym1HLvLZoj63hPvAWyOrUFYeR28q7n6DKJfwJawdiT/TtH?=
 =?iso-8859-2?Q?4wLzzqDNXqzLaKWEGYWtLX1NsCManZiMdKwp40oU6UgO1dEQd2NdGfk3ot?=
 =?iso-8859-2?Q?c+SRVx7LtYVczVs+O8ku3PLp7bMuxT5Mpez0E0bVHSmihR5pNRhAknSD2h?=
 =?iso-8859-2?Q?E4xzdRf1kc5nc1RFpazzB/IwkHVA4qh0F7ulHuCE/T+Rg1WLhaHUrsTe0w?=
 =?iso-8859-2?Q?LM8yIIqrl4qFLfs/3UeZpAEPNCaHkAFjcuiXD8PJprA2HmHId5AOMO8phL?=
 =?iso-8859-2?Q?PGPeMVA2T6LasgIPnQlQ2gH5x/KHBs0r8esdJi2X6qLqw1y87fjFIgtQLA?=
 =?iso-8859-2?Q?T/xBnG32TDIK54xF2UMA1+DzB5K9GwluOsdgV30hbAx9reMssnWxgjaQ?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d01285-3e9b-4128-4153-08db65a5f2aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 09:19:21.7979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1RdPBZFZ3/XUjhyPPHsn1Qa/2T8CulL1AqXGkGuABCzRRua+Oem47GtbhBUiqtO6O44sv3gubv3Sr4IgD4O8bydZqdELzzLilhK6wY+9Ov0=
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

Hello Greg,

> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Thursday, June 1, 2023 2:21 PM
>=20
> This is the start of the stable review cycle for the 6.3.6 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Sat, 03 Jun 2023 13:19:19 +0000.
> Anything received after that time might be too late.

CIP configurations built and booted with Linux 6.3.6-rc1 (b8c049753f7c):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/8=
86200492
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-6.3.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
