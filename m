Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3333B74995A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjGFK0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjGFK0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:26:48 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2131.outbound.protection.outlook.com [40.107.113.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2611723;
        Thu,  6 Jul 2023 03:26:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSkQ+ZxVdIWLChoeTWUfOgmTQrmU0ZNtCu6oD6kGWP6H+HFUc92iID6Llmn63qPNWW+52n/bVWNl/JJbs3BaVfx0SvnUI8vCiSV07PLg4P5eGGZXSFGpzuaKEwr2tmHv6xeRIKl6+nUURytSIzk/8kz+5o1hHBAoZ6v5Dld8p07PMcR23NvNNzJO5czjfiBZuR6qcwyKqyRXIOB2DpeNB001BW4V5Qxyrhh2mAxW68vZzQ/vZPwqDLJ5PCDZsVthDgK1HuuosALetuXYxIFAcvRJuV/mOjxehDFN8JbHR4JBv/JHfk5bd5kTt2lAVYEycPMktzKtrt1yRJEpmEGJLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7QP8NQ1TZDF8MlBZHLiKpLe3Ridwg5sw1xtgtmJcC8=;
 b=LFm0ygCDaLfIMGTj9dfRjewoguUCgzIU6ud9FIL9KEOIlzBmj8zf1uAXvetTZF/+f9BvUHIyeRXR9jdez2ccoiqS21LoypV2A4BFppGisFrpBe9RjzHGsE9d7PVi9mPc1ih9kVTZwZEI8wXiFzQvhaJz/2QfPrv/boN2Cm9v0VuOsZfNyOl7Syqn6lQomYzw+6oLnly/nDCoBGH2P4QjxuwCe9O4O/anVbFGvHxoJ9sXBvyfvJmz+odlq78EzA8PS/SGx7fWwcoIJ0vljyTygkKHAzvhxT4K4jeXxGKvEYuQ5EHg2TaI1HPI0g2XcEBZAAmwNrIY3t/0EWOOANAGEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7QP8NQ1TZDF8MlBZHLiKpLe3Ridwg5sw1xtgtmJcC8=;
 b=XEk9EaDHGFg+B8d4RZ0umxj958qNisk8s0Dpj70tFL1BfjvXocT5I/PnF65mZj2csJN/5EYxy6HMbvp8t8BEsJ6pySvNB+qecFbPqHqMRQDFUlQjWFQKQ+TTYLXUD6tlXjiYa2Y70iE2KhXVRzx808SlptR5VML4pjR/I6wWjnQ=
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com (2603:1096:404:dd::14)
 by TY3PR01MB9666.jpnprd01.prod.outlook.com (2603:1096:400:228::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 10:26:44 +0000
Received: from TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3]) by TY2PR01MB3788.jpnprd01.prod.outlook.com
 ([fe80::a4f8:4204:cbe6:6cb3%3]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 10:26:44 +0000
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
Subject: RE: [PATCH 5.15 00/17] 5.15.120-rc2 review
Thread-Topic: [PATCH 5.15 00/17] 5.15.120-rc2 review
Thread-Index: AQHZrlSC62CxW8ipcUaHFZw3vo6lYq+si6Lg
Date:   Thu, 6 Jul 2023 10:26:44 +0000
Message-ID: <TY2PR01MB378835520A5296864AC61263B72CA@TY2PR01MB3788.jpnprd01.prod.outlook.com>
References: <20230704084610.981452877@linuxfoundation.org>
In-Reply-To: <20230704084610.981452877@linuxfoundation.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR01MB3788:EE_|TY3PR01MB9666:EE_
x-ms-office365-filtering-correlation-id: 973655ec-2e52-483b-32d8-08db7e0b7edf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WdnNiSr7Yweau5TVs739D906S9tejW4RLOtMk0QbGKeLk/nR1A/qq1XuInkexQ07fJFr5D4bPDvd6H4TX6jjGWzocnhgkCYMEr/red1ya8sgaq4OPiHwWF3gkpIfOI3X0dvve2Fy3+QXzIazkPsK6aExE7PjZ7pkMuEiTiw7OudTp6vu7gCrzLI81cowYQH8+uryaPIG9ShyiVGkMPskSE8fIn9F7ylgbXfAllHi9YZ8yQ6gYMdFeXunFIlrsdGUsPXF2O1hBo2ZG7BwwFH53fX4yoxZ9bQbNDCPdDak2vvxaYIaE3dZauyAScLy5O4CldTvBCIC3Qc58M0JzYe48xxsHvF+rF1c2nrrfHOgBngvpWP4wK/r1F9yvAtO+T7Bq704entxOk0R/6ljxprhP2zN/VCX6q9WuouLkJ+/BrRNlcURbBXKGRIKe1BIdif6+pQ/noWYyFrhKBTFt4jzVxtY9h1I0wL1TETeQW9RImaFdnLqSlfhfEkiMujLW0hZthF0cwgTyeDe8ZBr7NcbYk5hvj3pSJC2QwItQzm0nJQbWJ7wVY5SQ6qz1gQdhgrcDgStAKWhGhfCe8XB8EeBklvPXMtaNGkKfyoIAfnvboi3zHwDzULisUvVxNx2MFvV7YIAxQzO1nGsUlyBihxfgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3788.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199021)(5660300002)(4744005)(8936002)(8676002)(41300700001)(316002)(7416002)(2906002)(52536014)(66476007)(122000001)(55016003)(64756008)(66446008)(4326008)(66946007)(76116006)(66556008)(86362001)(38100700002)(186003)(9686003)(110136005)(478600001)(26005)(54906003)(6506007)(7696005)(33656002)(966005)(38070700005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?CX16GuKvGL3N7HL9v3zfRD2R/rkFeaafviqL1fmGcvW/REoNn9cEWXbS?=
 =?Windows-1252?Q?tB4K/PV8tVQJngwmGV4a64AQzQY9mWCtCbUmIS0YZwfzr+/7MV/mtyy2?=
 =?Windows-1252?Q?hq++Qc8Hqov9/vXjchwMA6Fxzq8Z/iSPHb68cW5D3mwuZxhA6HzXe6yv?=
 =?Windows-1252?Q?0N48zRPJIQX7FGinD0Q5jqvJRU3FEWbQj024CkyGj+peRzCen5+kWHG6?=
 =?Windows-1252?Q?QQs6Z58YNMAzIIoTDtKEuMP+GjqnzydtP2SMBKuxO3JjoEaVeeNLraPF?=
 =?Windows-1252?Q?1qoqBxFPaFvgOORWNRglZbFrr+Y5bgVwjfkvKQB4DKkxjUEdPVZoNJQ6?=
 =?Windows-1252?Q?wcEBFHCb0jzYH2wrkqJDvXkXaFkUEqOtN52E1GAzGSmRXfNv0n+RGW02?=
 =?Windows-1252?Q?quGBu7jjXzZPqwAsf++cOKhZH92edQ2XSR4xtLjxdkumkRsDecDAIUhi?=
 =?Windows-1252?Q?13Tz1E5+br2i4XheRKVDcWN3Zg0DUdubb5XrMLxTWgBxk8O2O+mO5VQg?=
 =?Windows-1252?Q?+7wMdIQGqL2dHRqp9qFX7n8upccDs86H5JeKgaA0c4f1wKns3H127LH2?=
 =?Windows-1252?Q?oEs/TIIweAxdEF6BnrLvUaNK9WMly5zrwkERQ8NsCbCPHv/hb+vsp4BM?=
 =?Windows-1252?Q?R2Au3Gy1NNGaKsiHsrJcC8Qj8kfZdjtaG3AtGcmvpeZGRsteVZdVXWm5?=
 =?Windows-1252?Q?RxJ0HKG+xGWHzVOaeb4Qkom1O+YPzywTzZ1PpyNIcjUHpHW8ClOHX81t?=
 =?Windows-1252?Q?U8Iuew6hLl4EvWvCVrs7+vaUvNT8eGdO+e6rNQkyombAvZFtzR0wF6Md?=
 =?Windows-1252?Q?kuFCFq+904THEd0shFGLw+X7xeJ48lFH7WGuA9nj9Zv4OfMgJsyIatDA?=
 =?Windows-1252?Q?t4zEA2rk4O5WN+RJbsaWBU63AOz/uQCUEr7J6cdF+HjncKcbDAaErjFu?=
 =?Windows-1252?Q?m0nCl3qHZsOnUwLZRVx4kt7tMHrl9WL55YdwLgUwMDlVk+dKCZ9du37I?=
 =?Windows-1252?Q?Hue9niqJJvnqMiiClVtgOQkHtB986nJ/WlhpdDjgQy/sGJfXo81vg6O7?=
 =?Windows-1252?Q?L9RgiCjH1wxm4Av7vJs2JiIw+CgyQno1U8L02kV4JO0VpUuxnxfSJzi5?=
 =?Windows-1252?Q?sdapgZ0lGgc/hoZ9h2cpZc5UV5jGle2wP5g7n9dPSDFRlYo9PFbHeloT?=
 =?Windows-1252?Q?+1/SvwULgkFbE7I7UgKCzau/ZLBBjrXFe8CWxRCzfEau/5A6l8l3FHFb?=
 =?Windows-1252?Q?tbbkp7txTVQ2QrSQT5mASa9K2F03auZhv76rIS4+jtBdfp4VzkeqPOmw?=
 =?Windows-1252?Q?Lbibxcpqy2urmhTAEVrmBbvl44KQOuigKKdIbkF7BehXH0mw6PN+rWcR?=
 =?Windows-1252?Q?hntThJL4BHnB2VjPeU1MjW+rPoVitpkn5kWDPaU/5keZJ1d6UuUdvZ9E?=
 =?Windows-1252?Q?LTi2VImAZabaa4v8/o4PpPhNri+rStBWpIONqrO6UNzwJOyqMG9QbiwH?=
 =?Windows-1252?Q?nKm2ZWKpZVumwxM7DvyZBHbPj8DGdjHGnfbYA0X8CAKiw8VdHrAaHoMo?=
 =?Windows-1252?Q?ixj1zwU5PNJcEiq5QMWn3YnX56wX9hzL2QnUt4MWlDTrFSk8hruTBI3u?=
 =?Windows-1252?Q?JZT6kXTW/LQnQFflxkVVdS3cPnZtcyK7/6fxV2IgbwMCIhjiUv2+6aUK?=
 =?Windows-1252?Q?wFqLMHmFkr9qsMLnklbpPOlnQKwdfxc/wNe2R7aA3lw8W0t58SjVpw?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3788.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 973655ec-2e52-483b-32d8-08db7e0b7edf
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 10:26:44.0921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WVQ+N8Zhja/FqBT6MsW/BGnDpS8xtsGWSD++G+m3FxEtBTFfHEbf0eop2cN6alr98HTbCJV5+IvPfHf4PlBvK2aOL+X9eiMffTOW9FqGyv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9666
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
> Sent: Tuesday, July 4, 2023 9:49 AM
>=20
> This is the start of the stable review cycle for the 5.15.120 release.
> There are 17 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Thu, 06 Jul 2023 08:46:01 +0000.
> Anything received after that time might be too late.

Thank you for the release!

CIP configurations built and booted okay with Linux 5.15.120-rc2 (492521f41=
846):
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/9=
20271863
https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/commits/lin=
ux-5.15.y

Tested-by: Chris Paterson (CIP) <chris.paterson2@renesas.com>

Kind regards, Chris
