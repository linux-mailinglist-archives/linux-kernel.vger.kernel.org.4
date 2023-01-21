Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC78E676269
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 01:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjAUAa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 19:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjAUAay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 19:30:54 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2088.outbound.protection.outlook.com [40.107.13.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F541420C;
        Fri, 20 Jan 2023 16:30:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMaPeHn3aiTcPWz87zq/+mRo43UDsjSI97rya43BicXqSU9aYU1EpxJbHr6FMHbHHJUTXPyuVHpNVbnRbyFZSN0TDwTRzRZTLSWjeXOs4mDd+TbyGsjAG4yx7ullQ0HxHJg3/YCGyH/nwvvfbvgos90YgnmDgmWVixl7NnKQSb/Sv0nNC4ZusugVWkWH3j1TrZwdZYkDPW71vitjDnMQ24LhUDChZP0x46yESCe33jlEIdNDhdnszp1hv5iRDgtYPA4iXDs3ZQRfDQjyHWPbLFgNB8TIWyBEVmJwAT0Gq33ToCTLd52PcFYHc1ZDg6ucnMEdlrzUsd2izHCWgxHxwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLJsI2qztjOPtvG3i8jT8a7lKhYJPz213YuhXcFNtKc=;
 b=I7QGYIvbJWVwGY0TA2V/rzjXbhqbQt6qxQAOgOiWTMdFw5SHhPLYNYvhTQvBqXS3d4pMCugWP3eR5zvUxYJhRdUSZovuoimUIyvRcfvdY2keBYoWIHCuR5QI4fxNClw+UThbNc5UEHjZwdpzoLql/m5Obd0bC+1LGmoIOIZWNYkvKM7hcEXrTARyTUQ5TI90hFYEIjK7Ougg8/dRHBjlWH6op++XycQ3zsGkSDaruCH160slgus9h/XF2s4qU1BXjMHBx0M93Q7X01+GUFYOJDm76I29MfJU9JjPydIn/b3TSVyu4CwSm9KeDt5mn1ibhFV8/ilKmKqB/E8kZjOgbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLJsI2qztjOPtvG3i8jT8a7lKhYJPz213YuhXcFNtKc=;
 b=Uc7r/uSCZ4KClDl/WK5YWUSmwcP9yTUWmTdlrgwNp3nKRUFmdcncokqDmKM4E8vdxXGJLaRxzGW9lpx5dH9uY6LXmEXMJL5DeHQWT4OCaPE2D1wpAwkdHyX2InSdtte5BBWjpGq1PNoYnW68F+GpmONWj+YPTlazFL+UE4r8blK41ISCcyD7yAuuxakGGVZadrTmIv5Bmo8kYm/FxDVsyFfaPPGS3xfbMoROi/X/kqS1Z9C7ZvppiH7F2bfAz+ns1n+AFrzSDKkr2hLxd3s845OkUG54FI9Oew+eWe5RJBlT/yUPtWLEo5SJoZC//jt0+WklcdrwafyK8nkNHZhnQA==
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by DBBPR08MB6169.eurprd08.prod.outlook.com (2603:10a6:10:205::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.28; Sat, 21 Jan
 2023 00:29:46 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::4e5b:51c8:1237:1fee]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::4e5b:51c8:1237:1fee%5]) with mapi id 15.20.6002.027; Sat, 21 Jan 2023
 00:29:46 +0000
From:   Pierluigi Passaro <pierluigi.p@variscite.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eran Matityahu <eran.m@variscite.com>,
        Nate Drude <Nate.D@variscite.com>,
        Francesco Ferraro <francesco.f@variscite.com>,
        "pierluigi.passaro@gmail.com" <pierluigi.passaro@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] gpiolib: fix linker errors when GPIOLIB is disabled
Thread-Topic: [PATCH] gpiolib: fix linker errors when GPIOLIB is disabled
Thread-Index: AQHZKbP8HePARHu89kiREi8q9tdvPK6iWtyAgAALPlOAAdbngIADzjYK
Date:   Sat, 21 Jan 2023 00:29:45 +0000
Message-ID: <AM6PR08MB43766A842F8B9252E3BC6345FFCA9@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20230116140811.27201-1-pierluigi.p@variscite.com>
 <CAMRc=MfeQ_92Vb6inv-1_h=kc1d2as6LLPqJHHtbNk1pK1xRuA@mail.gmail.com>
 <AM6PR08MB437640AB4B959DD356162F2BFFC69@AM6PR08MB4376.eurprd08.prod.outlook.com>
 <CAMRc=MfN5o32AminWbjHVh_OBy-uAOJZyvb-1zhn7zs6EVyhMw@mail.gmail.com>
In-Reply-To: <CAMRc=MfN5o32AminWbjHVh_OBy-uAOJZyvb-1zhn7zs6EVyhMw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR08MB4376:EE_|DBBPR08MB6169:EE_
x-ms-office365-filtering-correlation-id: 28bd1ca0-ddae-4ccc-3fdc-08dafb469909
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Of2L8sJD+HW+gkJHju7A9ZeP0zPlSC0SKf2efndz47sFf5B/31u52A89T3e+53agJDyco0kaW/8bT1X5rP2Ykfl8eK0qV0hCSj6wyaQXzSwbC3x5Q3+E4ed3LZSnUiSYk3kVc/9GsHBWaVphCHrKr/ynStU2Z6Zc5PyE2h4G5doQZkoIT4HfKuUVt5FG98FZ/SBlCLjJTn6MTD+VHO9zO+Jrl93x84u68QTQAcFJDgbn640dhJjYJwYhXEHSwIfQZLo3GTNPNT96Ip8e0zjG8RI0Oz167wJHQEYNyUyqVLr4QDhcNa7KeWi1bfD2mHADKGmu29H3iNVG+KrPn+HfpxqgKiIzDx3ZfrfgKdmSgdAXVsuLZaeCL4yQ6bV3F0VnZk3QxBzj+lkkVrsi9TROqTkWG8yaEbGsm8nnkKArOGcXbn7Lyquy67/zcLbhMihsmlhscGl+lKhvCJ6cV2UtXtHuC/RwMLrbZ56kvcHwCgzqAJ2YW7kazffgNr+qfpV/F2RgXbIN+Q0qv4mfV1FV44Mpjpu/MFkdOO4rNfNzxAzZf4GlXAH2MWunZE0ZaIeA8IK2u2gJawgLQik4bE+kPvRh+lIHmNFdnRh8oPssCSoQMAheFBqJBkSilBpyDKF4dFERkKGJ2Ixhx1GRZ2N4K5/mPgn6MwAppdSbj/ooPK/x8XnERM+Ht0rbhNewolksuMNQLOSceY5EgCa4bkYOeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(396003)(376002)(39840400004)(451199015)(478600001)(33656002)(66946007)(76116006)(91956017)(122000001)(38100700002)(66556008)(66476007)(66446008)(55016003)(2906002)(71200400001)(7696005)(6506007)(54906003)(38070700005)(316002)(64756008)(8676002)(6916009)(4326008)(41300700001)(83380400001)(26005)(53546011)(5660300002)(52536014)(186003)(86362001)(9686003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eFynr4kwLYoCouWYCt/nzV0ILfK7cqBXSQlTORwsS0TRffpcdQZYphYbiu?=
 =?iso-8859-1?Q?17wBfKg0uQjaqmloPJGwRgaKHS3GMjDe9UZoK0BVmMs1h7HjiikptZjtAS?=
 =?iso-8859-1?Q?fgmEQ5/XIctuaJBCZDkgJ6NFjlD5cdbPCnBWLJ7dl8fThfVvRy1Xxy1k1e?=
 =?iso-8859-1?Q?qQoV0I9oKmI7vkrKW0AcFwy2rLM5YDqVTkDnEN3pOticM3KTH8ynL5osF8?=
 =?iso-8859-1?Q?ZhHQO88mF518tFN7l4bdKt3M5PpjsjihML+j+WMYv4sMRhfJuSdb8A7i7L?=
 =?iso-8859-1?Q?y2fODIw1ioTHjkImR8ZQPqCKUv6s2Fjn0JDJdbtF/3556XjwLXiBOCbR8T?=
 =?iso-8859-1?Q?KfHscP41vRepcZXkrs11abuxB6mGv6THAk0AN7tQn4fETpvqk+jxR+xXLF?=
 =?iso-8859-1?Q?ypQyfJ//U4NPvDn5mLNfXPxWtm2LbODYq6UPFBZREqUOncdnUW4LcIV6wF?=
 =?iso-8859-1?Q?/WL8WxQvTnBsJYNQBlysECFC9gXVB+8f9giUnHOenhnlaJtBoKctc2N+ev?=
 =?iso-8859-1?Q?xTSPO2hwOMnyTVIEmjWPtOmQ7WumVMpOLEbe8j0CmnD7se3cTzNr6TdS+6?=
 =?iso-8859-1?Q?Rbl4mUo+1yAu6iq6gaQtst0KmvpSIgqBfFRYsNjj9we/n1ffpw5Sci71U6?=
 =?iso-8859-1?Q?3/GRid70DUJKulXaAoIDnRNbTCBOy/fmsPqVm8qnz1V5+yqT9hoMq9C3Mz?=
 =?iso-8859-1?Q?AmF0pLb05/juQYc10evQs38VUEHjk97yiDsqddWmKgfTqXvkAgkZ122hrR?=
 =?iso-8859-1?Q?/hbbH0H83yv7Uey8dDzAP5nXb+hYEFcC9fkterFEpBrAFMlw9OI0NS1+Zz?=
 =?iso-8859-1?Q?zLrPNm7PXIxzYyWIi+MTG0NQdPZUKsj/k48y1GRIS1iWldvF4oc/R8abzO?=
 =?iso-8859-1?Q?/MocvRjCJxofzD+aFoxNyEbnaHgcPKucpJL4rIdhnR+hFgOzwUFYAEy5da?=
 =?iso-8859-1?Q?tuiG290tWIRZNTD9H0Mp0ZLi8O+7loh8bbnSsSlO5yFPhlSPTK117HAb/e?=
 =?iso-8859-1?Q?AcD5OX3jKu1oqyxvvuBIpY/uKWSfiI85C134YEX97O2bMinebq/0ZULxf1?=
 =?iso-8859-1?Q?bsJ0MDnv9bzPlBMTVqMLfbzeRSim/YblgbZuTXX8mw2x0kSzwh/WJZAliM?=
 =?iso-8859-1?Q?BDqONzKG5fa0SynFpeUBjpNfbdkpCdnw7f8PJUB+Ec8ULvaj+WlqwcdHiI?=
 =?iso-8859-1?Q?E0Pr+DMd7L3LNHB2xlDZSL7RFtTzYbD1WqMoXNcx7ajzPaVVUlTPvldMMp?=
 =?iso-8859-1?Q?rErtI1sDNaTl48gH0ah4I1SZby4ZfC6113LyPPPeRauGfJH37BNiBdHFYT?=
 =?iso-8859-1?Q?/kvbbQe81C2y8P58wsuRwQEWp6k9K7B1WMLqvsdAqRHIx8HjgLYNZ7a1ql?=
 =?iso-8859-1?Q?Wresd4kHXOjqtFwHUPDinJ/B447zX/fvcTGzEcn/9/Ts5abGt9iAOni+J3?=
 =?iso-8859-1?Q?R57p4aO7+1SLaUEU8yhyBWSxKRicsEZwaeAbOBC2G1CVBCB7BJi+1fBoPi?=
 =?iso-8859-1?Q?I+JV7pRsi4bt8C1avptVS2jfxAdKK5TD9ibSO8E0n8X2c50kgXu56piWJw?=
 =?iso-8859-1?Q?trTqU4niffbfwzgCH3DKaSPNIxBsXDK/pYvMTBXwJN4uDXtdOB17+EzfK+?=
 =?iso-8859-1?Q?UoVt1kkqdpvA8aRbUGR9OgexLu03h5CbDs?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4376.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28bd1ca0-ddae-4ccc-3fdc-08dafb469909
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2023 00:29:45.9524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qhCsFcCGQEbBclSPKvlaO18oPH2Ewnqd0fSMpNEEWXufXeDPHORlmTZEdOeSiZySsLFUPVVxJ74WVpI4UXNd/y/xhOXZlT3zW5wlEMf7cgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6169
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 3:22 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:=
=0A=
> On Tue, Jan 17, 2023 at 11:17 AM Pierluigi Passaro=0A=
> <pierluigi.p@variscite.com> wrote:=0A=
> >=0A=
> > On Tue, Jan 17, 2023 at 10:36 AM Bartosz Golaszewski <brgl@bgdev.pl> wr=
ote:=0A=
> > > On Mon, Jan 16, 2023 at 3:08 PM Pierluigi Passaro=0A=
> > > <pierluigi.p@variscite.com> wrote:=0A=
> > > >=0A=
> > > > Both the functions gpiochip_request_own_desc and=0A=
> > > > gpiochip_free_own_desc are exported from=0A=
> > > >     drivers/gpio/gpiolib.c=0A=
> > > > but this file is compiled only when CONFIG_GPIOLIB is enabled.=0A=
> > > > Move the protototypes under "#ifdef CONFIG_GPIOLIB" and provide=0A=
> > > > reasonable definitions in the "#else" branch.=0A=
> > > >=0A=
> > > > Signed-off-by: Pierluigi Passaro <pierluigi.p@variscite.com>=0A=
> > > > Reported-by: kernel test robot <lkp@intel.com>=0A=
> > >=0A=
> > > Please add a Fixes tag.=0A=
> > >=0A=
> > I beg your pardon for the question: how can I "add a Fixes tag" ?=0A=
> > Can you point me to any reference documentation / instructions ?=0A=
> > Thanks=0A=
> > >=0A=
>=0A=
> Look at the output of `git blame` on the file in question and see who=0A=
> added the changes that introduced the problem. Then, before your=0A=
> Sign-off in the git message add: Fixes: <12 chars of the commit hash>=0A=
> ("<commit subject>"). See Existing commits with fixes for reference.=0A=
>=0A=
> Bart=0A=
>=0A=
Thanks for the guidelines: I've just sent patch v2 with Fixes tag.=
