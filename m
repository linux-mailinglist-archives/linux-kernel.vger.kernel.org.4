Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8027973BB12
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjFWPIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjFWPIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:08:10 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2110.outbound.protection.outlook.com [40.107.113.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5241BCA;
        Fri, 23 Jun 2023 08:08:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ek4xBtpnIOmMI2msEF45m9rX5SobaFcCy6I3pQjgVpUL7fCLukzkdal+Q/B1AzfCu1CvF+PLS7Gk0k4mQVjmJQ1HS4mi5q8YobwKv1SwjtCXqtCSaTMvoMaBHHZCP01VKg6umU3p0va30MH05iKiAFItgcqkdM9y65S4flh6M/us+i7Y5Qer90MsOgySeB4p08WB+ymdem+rZsHC0hb512okQkTu6PzlYl7fE6xDCWxrEV1x0z/TOt7fETfXPZNUupn7FsLbww6+6JhPOU0D268lBiqks21cuJ424bhO678fCn4CwBnoJ+f0laXat0qcQSfWCf1ReZ+7JE6A1BMYdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFBJUCTRZgdMiEyyb1jjDvaJ1brRZmkHPpi3It3Amqk=;
 b=FjWEGadnV15l8JgVax839o2xB6svPO+bau7byfiH/ZvCy3gYcM/aJnqnhBFTQ42R6Ywyngk5FjJq9xGQjTZZToWlCX3Nf6XCo1EoHqzfeHuDT+p5puk+CjB9rYUqHQQCrENQ3YbeiTiJ91IZ9OS8YGbEUu0gy9pZhzr2adAywp+8uqhOs2LxncCFJVciz3zmO/oSr6pdZMS4qR4PFVgJq3jUxkwBwPwfyoGQN1tPgWCtdMSSIIwXMjRxIAePRpK+ykfdFR29krydUITymzg7iEji1oIQI4Mqbh11bKzV8bWx9z/0MPz7rIZGux/MapXnwi16k5pJXOhdEnPm1vAUaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFBJUCTRZgdMiEyyb1jjDvaJ1brRZmkHPpi3It3Amqk=;
 b=rX+wE6O8BJ6j8r0QYTbkkqNLBiMBDkVAgHNBQ8w0GP0t3AFot/TwkNm6afndaEYdtKHlh3IxUcXOXL4wINrN6P4Dc1iobjcW7D+jdFxLRhv5gNSODLyvQS+jyvE1wq4+lhkSR3QEhfPVF8wE2zg1spLD7DiXP0wRkH3wgQqXoAg=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB10533.jpnprd01.prod.outlook.com (2603:1096:400:315::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 15:08:01 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fc77:6148:d6a:c72b]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fc77:6148:d6a:c72b%4]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 15:08:01 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Wolfram Sang <wsa@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Trent Piepho <tpiepho@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH v7 00/10] Add Renesas PMIC RAA215300 and built-in RTC
 support
Thread-Topic: [PATCH v7 00/10] Add Renesas PMIC RAA215300 and built-in RTC
 support
Thread-Index: AQHZpdxkavVA64nn002doRrvHahzcK+YfNWAgAAAOoA=
Date:   Fri, 23 Jun 2023 15:08:01 +0000
Message-ID: <OS0PR01MB59221C8B147CEAD791AE8A428623A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230623140948.384762-1-biju.das.jz@bp.renesas.com>
 <ZJW08YIZROKg2a2c@finisterre.sirena.org.uk>
In-Reply-To: <ZJW08YIZROKg2a2c@finisterre.sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB10533:EE_
x-ms-office365-filtering-correlation-id: dc0bdf98-baa0-469e-0e9a-08db73fba355
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Om2YtZpBH2CHi1EJSZnE43lrOukCfZH/K63nVqI6LgFBX5B9KtstMuHpuD+frt9/WaU3YWSXDGHHpvLfIPCafHyT+xVNnuAKh+1hMr1e9ASYVgDZ+Ei4ywicGvHpendn6QuPRxRjIuyPtEHbBbQa4QhKwkN4VN48lFj5vrpv7RKP29lOdKW5phpIEzR2/fBQvxhflpzDiKobrcoQ1m1fpm0BbPMqVxl1fu+XzpNOPwGX95B474RD7z3ZZsyJhfDwBFZ3kQIuPld4nQiE1E1dV7TKKLOHV4uAuhGXj+W2ddGnDMdc84gtopkhg5bmMw8jVxiRl9+mBWZTuk9FzXx7gksNzE5AFvzf/gvoK3Anq6FApMncUc8/3CZ5IxMG+g8KU0X1px9wc62W29goCrJavPFQSlZN6OIlq2lGuUVQb9S29auO4unTULr8ei26Ebbd0Vi4Ox8LFqGBbEOANqrjUX4Ih9gOzHi9bZZGmhzCisoJd/YxbGizeXz4XbcFODtEQn+ywuhhbVejetxpPOlmFpdii2fgjriGMnkiHkOi6GAbibOnZ4Oy4A/sBNy3xsG+xZUngnVsn+fyHc9isimZUtUUiD2300JM9g0J6H0XwiQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(451199021)(122000001)(38100700002)(38070700005)(83380400001)(86362001)(33656002)(478600001)(7696005)(8676002)(71200400001)(54906003)(66476007)(66556008)(64756008)(66446008)(76116006)(4326008)(8936002)(66946007)(6916009)(41300700001)(107886003)(316002)(26005)(186003)(6506007)(53546011)(9686003)(2906002)(4744005)(7416002)(5660300002)(52536014)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KXf/SYmws1jaynhbznwh0DUmLsn3RIbVfXObNG/YqbaUG0PtyikcHBSiVbhS?=
 =?us-ascii?Q?FYhijn66Gl42juugCTC0yzpXkePqKzfBLgNVEwDF64xG/QSbSUhTRLsXS/Bf?=
 =?us-ascii?Q?FLv5NS/gqoD660KzVMiZO7+ZSSn/Vc76ukphu7SMbMdJgf9KchkN0g4I1ZKf?=
 =?us-ascii?Q?RnuBJGVTFbXTXuEzA0B+kXFMVJ1yScF/aWIrSKX4fMdJJEUYOacgpXgupLEo?=
 =?us-ascii?Q?X3td4YwkLLrvd10/hi6B7jmMF5QBrULWhCq0hWAd8h3Psbp171io5Frx6i8x?=
 =?us-ascii?Q?r6ZSpQSnRXgicJwKTmu+USAaGjfmS8Wr7afV+mJlJ448RyhtgAJIugdouVQB?=
 =?us-ascii?Q?VVjgDM6k50BSod70S6nfVeY6VS9+NrHXgN9oYnJVu8/2v1NKvf3Hs0ixg/uR?=
 =?us-ascii?Q?jqv20hX2HXRlGWYsyktxBjVcMEKg37zfwnFQdLKQ9KqrPhDsQf1bRBfMXyFO?=
 =?us-ascii?Q?0C+GEN6X2SuRqVALihGEjYTNEpedsQ+qP9Jd20cIVVYWes7N85K/yEfeJYp7?=
 =?us-ascii?Q?cQY/0/xUOHWHlt5IOB+2IFPTTeMptUIUrPiDMPxRTYC1Gt8ZN3Dyr/il/wA+?=
 =?us-ascii?Q?HIUS8i/Mq9YMhr8q5LrcqF09sUHdO+ZMxGxw5uyH/VuFbSwAis+hkwjJHbp9?=
 =?us-ascii?Q?J748WmSH9YCqG2iHjP0XY0PvkhNsq/xfs0QoJYiZu7jrC5rwfnrLekV8Kjwf?=
 =?us-ascii?Q?pyT76fidCd8Gx5wj9NtJ6EbeHGy4Js8Ohwy/hH+33iPNYZLxhGfRNjl7qqTq?=
 =?us-ascii?Q?FM6bX8GiA+PqALR7LLNIfoupZDjgNIC22a/HrWUL7YwHc9xch9oKO7pj5sft?=
 =?us-ascii?Q?2MDM4zFF5t5RpifF0UrQ6Zx+7QiTwkCV42YUWv0TWulXicItvIRhnbnkTJRN?=
 =?us-ascii?Q?nbMhNWk9gZJc1+q8hukxQvhvicH7tW423yhyD+4PawJ03QZVAxMN4Mzj9drT?=
 =?us-ascii?Q?BchA86MH7V+FZp7saczr0zL9iyFbrguS3FoCT7bDJhfpt38zWUlAkXYIsxDY?=
 =?us-ascii?Q?NBGQZZyMQZM1CdesVxVRv0AxgT6nnMBqBiYW65P81VVxPbwQVyYS7ilQKrG+?=
 =?us-ascii?Q?eOMYUrjm0HaWCruY2K0sYgrXyvv7WAaOIn8cYSYVpys/y9kSUP4PxzNToe2c?=
 =?us-ascii?Q?yvffu5Tnlva/i8R2xKKfAKRqEJjewxPziDpkOopASi3wTVAq7V+GOZXLH1n8?=
 =?us-ascii?Q?kXrodyS/lCjAyuM71XMIRHWtsS9XyKI71pziFDflB2PN0w0XBHEQuFn7Wt3o?=
 =?us-ascii?Q?4bxDNcRwjJPIhzlcS5dNJxRydZ1Mf76NOu540XyFeqBsU879uLNASI4xNvwF?=
 =?us-ascii?Q?i7fqwa3AK5XCywmnx26sDibdxFiyoDrg7s+M/9KBrZKl8uOCPd+ddMah7t7/?=
 =?us-ascii?Q?MbtqPDvj4bJvH+Q4KtV4nTlhM8IuuRGeFdZ54/yY8dY2hkU2z7dElJGwJOvX?=
 =?us-ascii?Q?K6dHVEiX50ZrYrkSCWo75f7/m7wCAu4YtP5p8mkeoKVoylcPjM082uQfZGBC?=
 =?us-ascii?Q?pKI2lI5gDDO5F8ZFte3AR2HsdIVHnfhRRtxHFui2LUln24kYGTQdFAqNYylZ?=
 =?us-ascii?Q?OA9T3ubyLo6Nc4WiYw8oK1EsUWldipq0W+0vtntSUl/iCmDRLvc7IFiQmin/?=
 =?us-ascii?Q?bQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc0bdf98-baa0-469e-0e9a-08db73fba355
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2023 15:08:01.7204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FdJD1HlOeFo3VTo2htf3Xtz9cD6RIm+jBeUoBS4Nqbb38CsBOzOrqw4DBuY2AfYiwhLgzsrXpV2owQfmfWYTasjy3oUHK5zRefau1KLky30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10533
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Friday, June 23, 2023 4:06 PM
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Wolfram Sang <wsa@kernel.org>; Alessandro Zummo
> <a.zummo@towertech.it>; Alexandre Belloni
> <alexandre.belloni@bootlin.com>; Rob Herring <robh+dt@kernel.org>;
> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Liam Girdwood
> <lgirdwood@gmail.com>; Geert Uytterhoeven <geert+renesas@glider.be>;
> Magnus Damm <magnus.damm@gmail.com>; Trent Piepho <tpiepho@gmail.com>;
> devicetree@vger.kernel.org; linux-rtc@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-renesas-soc@vger.kernel.org; Fabrizio
> Castro <fabrizio.castro.jz@renesas.com>
> Subject: Re: [PATCH v7 00/10] Add Renesas PMIC RAA215300 and built-in
> RTC support
>=20
> On Fri, Jun 23, 2023 at 03:09:38PM +0100, Biju Das wrote:
>=20
> > v6->v7:
> >  * Updated the test logs by running rtc_test.
> >  * Dropped patch#1 and instead using i2c_new_client_device() to
> instantiate
> >    RTC driver.
> >  * Replaced i2c_new_ancillary_device->i2c_new_client_device for RTC
> client
> >    instantiation.
>=20
> This means that there's now no longer any interdependencies for the
> regulator patches AIUI?

Yes, that is correct.

Cheers,
Biju
