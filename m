Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2186D67627F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 01:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjAUAhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 19:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjAUAhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 19:37:10 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2045.outbound.protection.outlook.com [40.107.14.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71755FF07;
        Fri, 20 Jan 2023 16:37:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6GBcgJqQx1V24S7V4GFst7y2QG9Kcst+Dl9SZ1kVrSJuFmFSsdiY3rGd0ARGTnm66pBZSFTW+FWaxPuGDyXZqPAmeULtYjZXifqVSpWBFqrdn11FMtHn213yLuKCQJNP4+ph0UrU3xHrIBXTF6f30CdbhJTI43rGYe2T7O2fraJf8RIJVMauXXlkrty2Jyv1eH0jyrrmHm2d/HYMOx/Uan2EmUBKvgRtHER8Fcr+kIi/gXh21TmZv44Y+dKvdnLJpW5/yJFO0QT/cXEIj31KHm39FJuKOdjLMHmFY5uFV4nQYZYL+o4jAznS89TszM81YOnfLTg5n5o1PqHrUWT+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRWfdl4l/wPmxMpfDcboG7GcvcfmDbYcIg9kCWaBm9M=;
 b=FN230HusJC+SI+z0RA027Wlp0vOiT2b5Ltqq6XvbBR8q/DT79u7e8N0lbs2dV2VeiTMWaeB95YKbJWBBOr3S29IqnxeTbpvDBT252YsLm0TvptQbwDVbfUfYelYt+Tg7OgbUe12615ha6lvDr9NiyBt4Y4zMOi5hdgNSOnSEkxblN0YjpjRJLxPHl2N7UM4wULgj3NAai5v9NCGQYr6ZgNe8g1iIfzLo9nKwMY09u/CI2qhDRowwlgKwDKpGeAMzLwKbX8TYwEtbpWna6CYGkFZaAyQJTFcc9l2iw8Q0td+g5VZ3bhumgW6HPQ7CSZv6r4YpLpZXzF+TAOPdYa2R5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRWfdl4l/wPmxMpfDcboG7GcvcfmDbYcIg9kCWaBm9M=;
 b=OmTddshV1imCNfmeCaskPOXh1agkZZXvYmQmQECz1Nh8ElKhImKGzS3EVyLHtlg+PlYEBLD1tRmzmuBKPwknQkv0opwas5pcmXQ/FCz+mMu3P3psaQd3yk+ZwoLDQpOgSm5+amLnjCoEbZMSUbCn7FCn+ltEEto95IjmhMeekjR32ZEEeVTXOtglSJbC3e5XEu3kTQ9Lx0vqPcRLSjtSdQ4LHEuYXZMzl2eflGEOj7Goicphfvxk/DAREUoa3c5Wn2pGm8QckWKew4rvgVyBRid6c22Q9tCy1oM18FF5sFntZjTVT0hqpgNJ0853lxPKwHSrV2LBeu+Ve3vvxCfZNw==
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AS1PR08MB7403.eurprd08.prod.outlook.com (2603:10a6:20b:4c5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Sat, 21 Jan
 2023 00:37:06 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::4e5b:51c8:1237:1fee]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::4e5b:51c8:1237:1fee%5]) with mapi id 15.20.6002.027; Sat, 21 Jan 2023
 00:37:06 +0000
From:   Pierluigi Passaro <pierluigi.p@variscite.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "marex@denx.de" <marex@denx.de>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>,
        "marcel.ziswiler@toradex.com" <marcel.ziswiler@toradex.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eran Matityahu <eran.m@variscite.com>,
        Nate Drude <Nate.D@variscite.com>,
        "pierluigi.passaro@gmail.com" <pierluigi.passaro@gmail.com>
Subject: Re: [PATCH v2] arm64: dts: imx8mm: Fix pad control for UART1_DTE_RX
Thread-Topic: [PATCH v2] arm64: dts: imx8mm: Fix pad control for UART1_DTE_RX
Thread-Index: AQHZKSlAQOXuheNXtkq31tq4TNWRS66hbnKAgAaf5yk=
Date:   Sat, 21 Jan 2023 00:37:05 +0000
Message-ID: <AM6PR08MB4376C1F6E729E9608B472801FFCA9@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20230115213503.26366-1-pierluigi.p@variscite.com>
 <CAOMZO5APGzugbBZf0uAaF3vB61KuWDtAU9OHXVM5p8U8yipuXg@mail.gmail.com>
In-Reply-To: <CAOMZO5APGzugbBZf0uAaF3vB61KuWDtAU9OHXVM5p8U8yipuXg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR08MB4376:EE_|AS1PR08MB7403:EE_
x-ms-office365-filtering-correlation-id: 153c91fa-513c-4602-0f90-08dafb479f47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uk891daDeewC3mBH989KBR3F0oofErjARSJyMHxhiy0iq0v9qSa2DNTT4V9f+XLvP70hUPBPWl+3qykvm0tmenPdt4iHVk9y/p3/ZHjbNevOfY9AsTpNoBEtvpeee6E7KRSPcdoXW3DIJERn0xGxm7wY1rjTiABGQcb4qDlTw5XupzgxCQp/apoLxL+o7GA3i8q13u3ztazKsh1vv6igMlxTUg56w/sN1gMLkCAvojFPwEhAVjYEo1oTc8lAP0HRLU5gvzHk+mrzZ3SozrLU0n/cQaLIaT/9nuy91hmH0U8p4TIfHv7Ac5N6W+HrhyXgHcjtXbqvB96xiLMo6T8yQaxPw/6uKLlrEuEQPdlxPT7A/sPjIbBxaGldSyRj+a4Y04rrVQyZPSmX515O5kyP/KTE5LgeQfw5ApcrXIoK4ZcwDq2EmEouva0FjkVnjJmU3d6+Jeq5hrmZW6NGxrMf8LOlkOECXAVMsjPxjdKcwc6meoKIdnC0jX3kEytJMmQXJlzHSDVL1USmJ20VF8bQBgaIY5UxOT2quadfsUVUDs7qmfQXGrJyZjuC28CtscDbmkSbpnfO/pFKyQizNEvTf+Ac1+AsUfZgVUzesmmVZOy8xzV+5PtUMclqUJcHaRyVaRVD/dcmYdlfnZfkcDujTMjWik/aEQ44AyO+7zEkWhFWo8IsTLp26MpiHBodWWC/d/z0s73SpDDO4Oj25rqwdlkPAG1/SU2oGKaeZxMx4bo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(396003)(376002)(39840400004)(366004)(451199015)(6506007)(122000001)(53546011)(38100700002)(26005)(2906002)(38070700005)(186003)(9686003)(4326008)(66946007)(66476007)(91956017)(76116006)(66556008)(8676002)(478600001)(8936002)(7696005)(5660300002)(7416002)(6916009)(4744005)(64756008)(71200400001)(52536014)(86362001)(41300700001)(66446008)(55016003)(33656002)(54906003)(316002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2zl4O1bsjccGYg8xlKKUjPU0fYUR3ZX8slvIed1pKrLQMFtJdnJztGX0Ac?=
 =?iso-8859-1?Q?eIS5z0oJLgKZbb9+Q3WePgiC/L6Z9hdoJ4ftpiL6+4nBT0BkjBN0v+tKZG?=
 =?iso-8859-1?Q?ZXuCJmt/IqYgrUleXjZfJlhkKXu/ubEwumuRFg5xL5za4q8Blk5siDHSzh?=
 =?iso-8859-1?Q?hk75ReJ+qyHjUjpIEH4C2sKqm1ijSSCdR3x8eJrMR0QGZQJFIO5tmwGjrD?=
 =?iso-8859-1?Q?NDmGjYDNKiL3ctbOalo38aGPvPfWFQoQQZNa4IxVQAel4DOOqUjmaoi2l5?=
 =?iso-8859-1?Q?fZI/MLckewiwYca53hXanUcVWbvE65mHLumnFdzHHsf0GIVJ7RJO+SSSkp?=
 =?iso-8859-1?Q?RQVhS19uaLQ/JD8rNGn0/y8kxhFUKOVqdK9yE7Uf9DA6Tpy+WgVVmFaSoF?=
 =?iso-8859-1?Q?gEIx3ZELDfP1CRJJfsdtz0NVrPL7iKaYfD+qwVWBxqUkGi6CfDPvUU0381?=
 =?iso-8859-1?Q?hI1gxPBWQ1w6RAhcOvw2EmF3MNdfXMdg5z+WZCj4qwWPg1bSFj1aFwnIut?=
 =?iso-8859-1?Q?NaQDccVYCjWGPaaTrgqq0eeS7bOpvHXASeCf9zH20w9nJpsycnIDN0l/Qo?=
 =?iso-8859-1?Q?kMY15EVzUHWwDElS//q1B28MA+zbEF0mqcM8vllFAss0lq7h2glCPVvaUr?=
 =?iso-8859-1?Q?Rhr32KcPib07/b5pqFCD7LL4UPi27B4uIZx+EpclvaLzwznnpqO/U+yz9w?=
 =?iso-8859-1?Q?25Zlvyc2Hk2g4NzQ14MgCXjvsLs3E0HEySmIDTQsWtn1LtH98p9FYSr6Fk?=
 =?iso-8859-1?Q?OCCZkW8LFEZYM5xR6HX9W8zWfoVv1HXZN4HN8uKvSA7Hy3bpAOR29MbSL9?=
 =?iso-8859-1?Q?dfcOL1JpaW0cc1zlqiUOY1D+JRZX3PPIBQPkFjwMqm9AqXAZ4dLx/Yj5lb?=
 =?iso-8859-1?Q?o/ycQnRBPCZ1isopq6ye6is/qzc3rbZwT9xsFk1eF02ys29yuGlpqBE9y/?=
 =?iso-8859-1?Q?VJTLxgfMB0F3c4YIqVAHmbjmjuchAJsfyesqg1kVNFjzLjpqbGdsrh/DxH?=
 =?iso-8859-1?Q?Un4VXGpWWf0qxecwVEjnWLoCrRkMWy+uo1ovpf32FyVGaOjfrN7AhHaslL?=
 =?iso-8859-1?Q?7lxq9k9vFaIUmPDgahgsV/cr2q+W9CBfUhyo2fW03Ler6FNZb2/kR8ufIQ?=
 =?iso-8859-1?Q?YwvhdISLLfiGAlYO5gg8ykZ/Cp7ZsmLmng4js/N4IgS1qAi0Qzak5F/rmw?=
 =?iso-8859-1?Q?xIm1Ik+DbJ1NC/ZFN5oEJD1EPVKqoA/Dllp9ABPj37ovFWpOE9Q8Atto9x?=
 =?iso-8859-1?Q?yDC86bimB53ss7LWLDp+0O7MyPcRH70cVQU0LvE6D/xOOHVXcvWBgy0OaZ?=
 =?iso-8859-1?Q?hMPZiCnba3n7B83a2FipcCJOrA/pUoJJexS6c4bYfwadEFCYr2JdSI/KKt?=
 =?iso-8859-1?Q?fqX0uibPy5Rz4t/Fdvp+bxHZIjbu8vpNv1QsQcG4RpMb3lUQDB0aeE4F7c?=
 =?iso-8859-1?Q?miQyw5jjFhIFsOLwtpTJ4lTpw8D9yWjJw4Ynl4rG5UCEiuQpMcSDCW0jqE?=
 =?iso-8859-1?Q?I5KVc9fj7X1Vz7M40zHC2XNOpiFTCejLWNIsnw1FIm2f202BGeNhw8tmLU?=
 =?iso-8859-1?Q?X59q8iru1VxTahKQnEf4M0eUDWZqn0CLMHxG92Eqz5Qpi/xcPsM4W83zzH?=
 =?iso-8859-1?Q?M9ruP/yqN4YqtauDUwLyU/r1tSA408hVrZ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4376.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153c91fa-513c-4602-0f90-08dafb479f47
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2023 00:37:05.9674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2criu8i5Fm9XSRU2KZAwO3G/9ua6ckKxKlNCOpGj4PGEHuCSfNWVk3IQ1hGKizrlE1d9yYgkbeN9Lf7o2Ys/DvFDcF8tzVUPAC/AyPmJVk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7403
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 8:26 PM Fabio Estevam <festevam@gmail.com> wrote:=
=0A=
> On Sun, Jan 15, 2023 at 6:35 PM Pierluigi Passaro=0A=
> <pierluigi.p@variscite.com> wrote:=0A=
> >=0A=
> > According section=0A=
> >     8.2.5.313 Select Input Register (IOMUXC_UART1_RXD_SELECT_INPUT)=0A=
> > of=0A=
> >     i.MX 8M Mini Applications Processor Reference Manual, Rev. 3, 11/20=
20=0A=
> > the required setting for this specific pin configuration is "1"=0A=
> >=0A=
> > Signed-off-by: Pierluigi Passaro <pierluigi.p@variscite.com>=0A=
>=0A=
> Fixes: c1c9d41319c3 ("dt-bindings: imx: Add pinctrl binding doc for imx8m=
m")=0A=
>=0A=
> Reviewed-by: Fabio Estevam <festevam@gmail.com>=0A=
>=0A=
Thanks for reviewing.=0A=
Is there any further action required on my side ?=
