Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FA2732F30
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345322AbjFPK4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345012AbjFPK4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:56:13 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2077.outbound.protection.outlook.com [40.107.241.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ED87AB8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 03:48:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0bNs24cLbTz6P+1p7WIKbT+zLGfz2OWCvU+FeqWKCmUREV4LssbiSVlTUvtBDOwFJQhyFd9e5eaIZ6p2d9w3z6S/Qy1/zxQ9qvGus+0jSqirn7THcJBovmzqCmeLZHkDqYT/qCqk2py+fk6eNxWq3VHGCSPzb2ntrqYYqVlNu7n5KzvGC3naAet0Ml7m7u+5n6/OIIas794n74eHVpPvfxbw8Zri177rpnLJQd0HGOL+HxvTscb67yn4tLAAYoIvMsxkcctF+gTfMnBODq/wH7ANgbbfYH4lU4N9sEmrCQ15aXh/kG4uRWc0Sl+Xprwrk7TwsheXN16LIJGjLWfUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xn+Gg1fgvB34gJKPZ3mU6leXvknvC1ocD960UcTkz7I=;
 b=EJyJTay8CYMKS29oMnMx88YABKf5cNm19fOKJdmCftCkwMNtf33cBrJWKHRhQCszrbQKNG3nVvi+Dgm2/TklgmeELWe4gu7JfO8//tYiSbUIwcwlgjeox33iAkGRBS/k8Ry+WoXkxQkeeNkuy9qDRUSGgNwF1ireLKGqvnDYk+r8+/Xc+W/fF0x37G/w25us12E07ynbASe4ccG/NwDXJNwtaSTVFc7/hxwqeb11hHXUC9v6Khu3JBLOuVCHhrFT6Zao36p2IWWEz29t0LlXH7kz9m3Qe+yWRnAUrL0EETwnEIoHcxTVKHOAHAFeisMKRYVKgGhLFVeh8RtR5OOEhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xn+Gg1fgvB34gJKPZ3mU6leXvknvC1ocD960UcTkz7I=;
 b=RnAD/WQEmWK19vI0BroD+jTqkWF38g5JnJxkJbZZrw4Eo9ibqubgwzCGr88V46ZyBtIgOeuqB9fFSqwUDgs5f6LPg0jM7S01R27B3e0sNTdOZKnpI5RRNuBs7iqjztarJRWItJbfEHtbjca1IU48C6bwNPrficNN50d0k2DU1SI=
Received: from AM9PR04MB8907.eurprd04.prod.outlook.com (2603:10a6:20b:40a::22)
 by DBBPR04MB7610.eurprd04.prod.outlook.com (2603:10a6:10:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 10:47:56 +0000
Received: from AM9PR04MB8907.eurprd04.prod.outlook.com
 ([fe80::95c3:f23e:1b24:e99e]) by AM9PR04MB8907.eurprd04.prod.outlook.com
 ([fe80::95c3:f23e:1b24:e99e%7]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 10:47:56 +0000
From:   Alison Wang <alison.wang@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Leo Li <leoyang.li@nxp.com>, Forrest Shi <xuelin.shi@nxp.com>,
        "X.F. Ren" <xiaofeng.ren@nxp.com>, Feng Guo <feng.guo@nxp.com>
Subject: RE: [EXT] Re: [PATCH 0/8] ethosu: Add Arm Ethos-U driver
Thread-Topic: [EXT] Re: [PATCH 0/8] ethosu: Add Arm Ethos-U driver
Thread-Index: AQHZoBrqYkp0PJ1ox0W6AGConHurtK+NAzmggAAfpICAAA3DwA==
Date:   Fri, 16 Jun 2023 10:47:56 +0000
Message-ID: <AM9PR04MB8907BE77F4F57A89883B1CBDF458A@AM9PR04MB8907.eurprd04.prod.outlook.com>
References: <20230616055913.2360-1-alison.wang@nxp.com>
 <2023061647-upward-petty-7695@gregkh>
 <AM9PR04MB89076472B9A29DDFFB2F958CF458A@AM9PR04MB8907.eurprd04.prod.outlook.com>
 <2023061646-coil-broadly-9efc@gregkh>
In-Reply-To: <2023061646-coil-broadly-9efc@gregkh>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8907:EE_|DBBPR04MB7610:EE_
x-ms-office365-filtering-correlation-id: d1a9703b-88a4-4658-1c1e-08db6e572512
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y9lLYDuc85/yorlGhw6Qo1i0gYWXB6bLGtc8T3k35wqlK3Z+EXTpGrp7QlyC/LNfPAVLf+C0mr04C9N53RyIJkeE4hg/zO2M4+kt12bg4OVfDXyRjcnh1DU12EDIVsyVoLiibEUjKrVAzxucX0T10Z3I8eE4gbSed28cPrET8/TCeAjKW28J7DZhShjtmyhbjjFlWgj7jRba4JGXp51/+6bSstht25IMm1Y4/E5TtY7eycKid3rEsJlm6zB9ia5kse5mjdkd42O5cahgx9Chy96mkurLe8HHtCsrOu9PZJaHDMOMjTdZCg2SqptEXrKfA0HJUUXNW6nPOFBwHqeRfOPiHGc9AIuSvcFxDgfuGJZC3P1AHP4YdRfXFmzhj+6jmQJ03WVPd1VW//cT5HYxWm5tCxUQsGLKncPRYVsVmvshcYqIQD0bdG2X4zs68y/0z8Faj7Dha5xdvOTyKEAQBSfuZNhnBomuB5j63mnk/VBMZWHJm0eHkHZbdZFRpYj+wPUXI7KQ2K+IAxeG6Sm5eqDzYXYeqUyQloj1zayPIDfQSmmNkKsdiYRuuHqIoIhYJ5BQ5/O29I9xrPSJMqdeKzBXfkSfvaySgprwJ/Kxbog=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8907.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(366004)(39860400002)(136003)(451199021)(55016003)(2906002)(64756008)(41300700001)(5660300002)(33656002)(8676002)(52536014)(44832011)(8936002)(316002)(4326008)(76116006)(66446008)(66476007)(66556008)(66946007)(6916009)(71200400001)(26005)(186003)(6506007)(9686003)(38100700002)(38070700005)(86362001)(122000001)(478600001)(54906003)(45080400002)(966005)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rYjRUPnnqDXdSCoXrRSXvQwfJxSxqVaHHzZNJvv5d2DG+MhghpxY95oo8xcY?=
 =?us-ascii?Q?fTfJM9EcJ4aOiPSjYqEFE8X70OjgKaN5MrhgtAOJuQOS6WXf6ndj+ag0p0JB?=
 =?us-ascii?Q?pxKjlFpqFmSEXgDK5U5RhdtlonIBZJo9njzU/B6PRRCdYaGmiw8p8f19uIUM?=
 =?us-ascii?Q?uk1sYTkFYmrSSZsImeM0dhkG9OgV5vCcmEujn5frKjD9sv4rgZ/MRtm9FgFg?=
 =?us-ascii?Q?yKEXMy9y/plyn/hxX2FsdLF2xiFzGCu++/BUPzFuA8PfVJAoROkY5bzA1R/K?=
 =?us-ascii?Q?SXCtla7ZvMJ5JKslptJeXMJk+Voawan9XfjapbiY1B6Ceihky1gIDmBT6vhG?=
 =?us-ascii?Q?7NbH1zk56cZ892f2GIoMMjD8bhQ2N9qAmjC4jzKBl96DQmI2r2YUvIZxFwNq?=
 =?us-ascii?Q?VXoUQh3xMeZdEJfhvDCH7TV1VLTqcrTrJuwYZ9G+X9lHzLRSNrUUexQv0ioE?=
 =?us-ascii?Q?yFLMGc/YaJqIfnd0bKYJESQkPnnshYmeHh4WmqJV56SW0qle5cje5dtHuuI5?=
 =?us-ascii?Q?RgPKkWtoShgCiucijbWKvVWECYXo0NQSboPoZ5BCMjN7MSSYa65Z1jg9ldu2?=
 =?us-ascii?Q?66FzblOj3Tujejup2gMn4baiF4jGw0J5PnG1uhUMXR1ICw9uFfXqHO5ogtEc?=
 =?us-ascii?Q?LLwBBKowlHrd0y25ntD1XyduY5GM2Hz6131p2J6kBSMNel2HeGmpawE2puMG?=
 =?us-ascii?Q?gyicp1zJPYVsDMCaNnhhD2F0Ghhra57vG2sTlLaT+oeVpI0ncbrQi8k23J/0?=
 =?us-ascii?Q?wCkgreKnUbKRIol8RP2S3skxrxDahP4Nj/OFjqutqArKPLL6qC18oNA+Tetw?=
 =?us-ascii?Q?bjrpTCY57e2RUvqpjLJmqd7a0HDvPbfroOWIzndKwkdsSaKKJ6wuZdFteqLl?=
 =?us-ascii?Q?hp9iPhDQlypSGyGrnqVtsUb1ERDhV/JpVj9WovEFyDdknnmaBjK+wjIEk03x?=
 =?us-ascii?Q?ASwMzsRALL0X41t6WmQCBx333wvCVzQSZc+ySJesGSa0VXqD+OiEIBFSqY4b?=
 =?us-ascii?Q?stHyBOgVX5zFckEkwaw2BWePnLlcxFKNKVUppulbdKwWVtGBejQA+LORmZlQ?=
 =?us-ascii?Q?M5haoWrzKEQ977MjlR42bqMimGo+lSLhxqe8KQdZNNxiJpYQ3fosRa2oAJlY?=
 =?us-ascii?Q?3/bMQel3dq+dXLgfPhX6yfC/LOA2LD4nIR2kbBB+zFVumeoamAsRgF3SgyRB?=
 =?us-ascii?Q?raJcRNd5kjnROsdkCSuBctJI8LrsyaP0u4wzOv1CZ/dwSkHMFuBuCIlM3uJn?=
 =?us-ascii?Q?8ijre8M5GoaeazOyznrThcmw5KT1Yi03i/IWBHJuE8oLfFtxRscB+JelbHiP?=
 =?us-ascii?Q?vT6KlBMy44yhujrvL2MIeIlA7/jilIzN61wVXVToLCZ88JvfBACkt6fWJrBO?=
 =?us-ascii?Q?08mJowJOHPiJoIl7k8Zb47/Xcrt90ZW2X3Cd2EaTvvAvwBMQ3F5lN40fNr7t?=
 =?us-ascii?Q?KcozZSQRI0XaTtmAHbpGj8q3enIQx/ZyVoFEqNfHqozIUU74PIjy9/GzBMk4?=
 =?us-ascii?Q?o4PkG3yphkkRAePTYepBzoJhkLi76OlSC/ERUJwB2/Oby4BH907LS0FAiJ6s?=
 =?us-ascii?Q?qmwjuETtlvmAVaIURzCAitJd9VVar7YGBTZbwyD2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8907.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a9703b-88a4-4658-1c1e-08db6e572512
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 10:47:56.5860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SKlUXye+8MqPLk5Nh8zyOnmxZCCq8gFSFabIhCmW3o3qB/Cdx+XX1h7iD2R1JfyqZd5J4eJ4hp843VzQH3oaBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7610
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 08:26:28AM +0000, Alison Wang wrote:
>
> On Fri, Jun 16, 2023 at 01:59:05PM +0800, Alison Wang wrote:
> > This series contains Arm's NPU Ethos-U driver for NXP i.MX93 platform.
> >
> > Ethos-U Linux driver is to provide an example of how a rich
> > operating system like Linux can dispatch inferences to an Arm
> > Cortex-M subsystem, consisting of an Arm Cortex-M and an Arm Ethos-U NP=
U.
>
> What is an "inference"?
> [Alison Wang] The inference here means machine learning inference. It
> is the process of running data points into a machine learning model to
> calculate an output such as a single numerical score. For example, we
> use this driver, user space application and Cortex-M firmware to complete=
 an inference about image classification.

Nice, so why isn't this under drivers/accel/ then?  Does it not need that f=
ramework?
[Alison Wang] This driver doesn't need that framework.

> Where are the userspace tools (if any) that are needed for this driver to=
 work properly?
> [Alison Wang] You could refer to https://github.com/nxp-imx/ethos-u-drive=
r-stack-imx.git .

Please put that in the documentation for the commit.
[Alison Wang] Sure, I will.

thanks,

greg k-h
