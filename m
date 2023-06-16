Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF6C7329B9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 10:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243321AbjFPI0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 04:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbjFPI0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:26:32 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EAB2D65
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 01:26:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGF8miMcTbQKyf8UHKat4gGSorZVSEHQLHTv5g5aIrHkf34iH3fW7dZdN4dI9wyEyLbKZ20qUcUTRZJUko5tYe07DSSC+3AbI391mjeJRT7jDC4IWOyH2QLvrmiksXfv1MpmZnKK8t32mgtAl5LoGkn1117irOQadnrhfBcxWAjiHZkfb/VR4o7/sqnUdQx2Gaj0UYbMowhIxt3eFDI7q5VPWltnaQvVUpjhNGpkqX5PgOmuzSEjHjNwsUN3pFCpZxyg4Oc3yBnCJG9jdY7TdrX3VdPu11Qt47uc+m7Sdlf5BiBTez96U97bPwYaX/4hsCwfewu8s5s89ZKxlB0C5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0scWIfbg9Q746rJSH3pBsjU7l7rz8cYuPy1mNOh4yos=;
 b=Xl8a506IiqwT9htbuQ+LX33oZUSWfferZMqrGx4jBpkBxOdVbHSQ1DcD3D8Z/iFU1l5+C3ozqVZqE7xNVihfsXGyyORmD+N3S+qu7VUVFAuNFfNlLqw+QPr3sWBhDbk9bQiQ0KRnHnJhfRFdW3xziFItkciqXWCW+QUu9SwXxqlA2pndaXluELKXklWOYOt2bdEJOnDSCpLRbGYUBCnhYof7Qfdi7FgVmNDjUDbkH1z+lRPfyLjOdQG39Oq8ByckThsgo3HuCiXFbJL08zXbx+tZJA77NHJeihjhhv/D8gHHixwX0I6LRvJ6jfXEIIzLeFKx8oOV1+MyZpvwkt8hCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0scWIfbg9Q746rJSH3pBsjU7l7rz8cYuPy1mNOh4yos=;
 b=lx/GP/LMWUOMLv4ditw38xVj/E/7wgFeM3NiW+xbyAKriLdGh869tOqeivO6E6V7KmNiAYbF+u1GaKrlSdA/WiFeGWPkr/eB9q/MMzUdbHKcLAO901hDIpxvh6tmYLOO2OlCS6hTxOj22ayDrmJrJUzRtPpXcL6Epyea2BSQkBo=
Received: from AM9PR04MB8907.eurprd04.prod.outlook.com (2603:10a6:20b:40a::22)
 by AM8PR04MB7219.eurprd04.prod.outlook.com (2603:10a6:20b:1d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 08:26:28 +0000
Received: from AM9PR04MB8907.eurprd04.prod.outlook.com
 ([fe80::95c3:f23e:1b24:e99e]) by AM9PR04MB8907.eurprd04.prod.outlook.com
 ([fe80::95c3:f23e:1b24:e99e%7]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 08:26:28 +0000
From:   Alison Wang <alison.wang@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Leo Li <leoyang.li@nxp.com>, Forrest Shi <xuelin.shi@nxp.com>,
        "X.F. Ren" <xiaofeng.ren@nxp.com>, Feng Guo <feng.guo@nxp.com>
Subject: RE: [EXT] Re: [PATCH 0/8] ethosu: Add Arm Ethos-U driver
Thread-Topic: [EXT] Re: [PATCH 0/8] ethosu: Add Arm Ethos-U driver
Thread-Index: AQHZoBrqYkp0PJ1ox0W6AGConHurtK+NAzmg
Date:   Fri, 16 Jun 2023 08:26:28 +0000
Message-ID: <AM9PR04MB89076472B9A29DDFFB2F958CF458A@AM9PR04MB8907.eurprd04.prod.outlook.com>
References: <20230616055913.2360-1-alison.wang@nxp.com>
 <2023061647-upward-petty-7695@gregkh>
In-Reply-To: <2023061647-upward-petty-7695@gregkh>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8907:EE_|AM8PR04MB7219:EE_
x-ms-office365-filtering-correlation-id: a07d73c1-55ce-4e9f-da98-08db6e4361a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N6S/Uo9oWzJj8lncIVdUvJCUmiSRVG7w8+EElq9j0uw83368xD/f5hKuBRF03FCKEQMWHiCkxjhLfnmDwPFh46T9zQP1O9yigojQNGfBXAmYTwVfqbWRDmAQtQHtmiaUnfyh8Q7MEKAm7jr6eSsOk15MEeXL8vLEllpbSlWet3OjC4HwkzYV2neObF7PrdK1bh9D9oBEVtfFecFTkxBbgBc5oQyETViG7O6yuKtc8LFSM3/uBwmzrEBvK1vN+dKkhGsl0oAaWgsBpKntETktWu7bZm3Y+yfr4/ed7kRPy+/n0Mdltvq7J78ylGpeXJDda4/y3hWU+ZE+txs2Qi1SzAhjyx8ZFc65bZob+5tDwo33HemXdWUBoPEjyxtwe4Y4sZD+7G7mZ5tr7XtMjtYsSqqNsMBw7+m1cKwhv2aNYJQ27gEBtHPVvQHNp88b0uKNx34cbwECnqcq+qUdOs2PItGOWkT+5i9sMCzpa1Vr7pLSceclVIZ2rFe7BAMIa00CbHPeihCygt5hZGz6BRzF31mdkKi/7pr5P4NO6JyLPNk9adzC6vj8zOYAyLWCl86ZHGM4TiwXC8i8uQRhprnrwNGHHtR3mvPaXMdy2mrDRwc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8907.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199021)(4744005)(2906002)(38070700005)(122000001)(38100700002)(55016003)(966005)(41300700001)(316002)(7696005)(6916009)(64756008)(66446008)(66476007)(66556008)(71200400001)(4326008)(52536014)(86362001)(5660300002)(8936002)(8676002)(54906003)(33656002)(478600001)(66946007)(76116006)(44832011)(9686003)(6506007)(26005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1jfBVI07IFm5ksmVY45IEz99LbQNl/2lGiqcMbb3sjLmfsSvNjLboDPC/unL?=
 =?us-ascii?Q?4JWywtaHS0JDP3ppFMwCdBMWjtFG7z4OeBBLYcau+JjVXKphH49eY0HLK3Nt?=
 =?us-ascii?Q?12xelFqiOHQtBHc2/upa3Rc31VdDRr9BEav+xDrNEBttoufqNONuSFT7qfEc?=
 =?us-ascii?Q?BC2MxVBVXqHEiCyK0jJQjidaHl0ZmLKML3DJOBGGEqY8bK2ao0QIFX80qWck?=
 =?us-ascii?Q?R36MwRE9FF02rDRi+Sr/XhpGL0gUn9LDCKGrxPolEWuHD+nbrEtjRKLzrt1u?=
 =?us-ascii?Q?5HCU4pih2aMZDQaeMhOElnvK91iuM8H/KGbV9kzSSrQ6VBnl7asz0Y27cGTl?=
 =?us-ascii?Q?ehtksfmR3ltCQHvedDff81MVhZYeo/K53JxEYYjUK8LnrCsJsFFbu0Thk6P/?=
 =?us-ascii?Q?EDovX21kbz9rYKE7wP4mvWWtSMNv7qnR3aVEt9S0bm34gdmHV2y9l56iX20A?=
 =?us-ascii?Q?PbcPWfkxzpPplt8BnbNWkrc4aOBssw3pzisq/iZ4empmcBJ6rY+wTnl8Bpgw?=
 =?us-ascii?Q?33qbo9ZqL2Ml4SzrhEvZSoOvFf5V+Mbpu6vve5AyEKUwWAekLQs835ynb1VR?=
 =?us-ascii?Q?7St5XA32HQVZDB118NYJ0D/16AhdxWRPIP3zAYkvPztJcI+uVxZrty3ynpyG?=
 =?us-ascii?Q?Aj8d6E+4xRjiFS3C/MLSZ9Mp99nP1k5clJKidEh6/LMhIR2CUz6D4+PfCL9i?=
 =?us-ascii?Q?mNzcBs4gFSh3TOPkm1kYPITSzybUQbwiYIadMz6S/2uwZK6J9m7m9yAVxfKk?=
 =?us-ascii?Q?EmHhclLXuqIEpHNs2wH5O7PgJZsSTx3vdMDuFsdBAmFTzmw3sKa5rP6lyaSX?=
 =?us-ascii?Q?hEqvUzBCHLRY2zbs5cDGt+IovQSGcehGcYamPRMN1AS5dr2WhxYZ9jKMz96q?=
 =?us-ascii?Q?7mbumm6kEfkM10igLITgQDD4L2DapNauqt85/uen4UEEr2ExEwVx+V52sokf?=
 =?us-ascii?Q?cXV3yD0lDzLdqY0VuE4voYRaSCxqKXXcWnwWrIVsP/CpEDSNk+DCiKwxNz81?=
 =?us-ascii?Q?OY3pGaYXydh/J/t/MuyueCJrfOCweShqi+2qoLVjXuW0ImYiXInPlIOp3fq7?=
 =?us-ascii?Q?CR0pVlGRBqDq1u91xMsxP/dqVuul15Lnmz4HpBQsebkq3IXdWChjdJwUDdp6?=
 =?us-ascii?Q?dgOuidzwFK9ZEk5thsteNins5U/HtY7riSAYXNx6k9eav2H1dxgNnp6G2L8M?=
 =?us-ascii?Q?A6B0928cEGKxkFgda0qJBJzmfjFjVsMMP/s8Oxl3aB4VAOtXWi9gktSCfA73?=
 =?us-ascii?Q?hKVILpnE/HG1ho6NXYy07DDLzzx9YMjJvE9AExaq8v/L86LmOJdGp6dQD5zQ?=
 =?us-ascii?Q?Kbvxq2i56ffU0YWPdur3QLIVLGikQ2wPy+9u5LciJVxpfafE6S6bTAs5wede?=
 =?us-ascii?Q?e7CA5NMJoDqrpCyMPPjUKuBl42EZH1wM4Z2ENKPqlX1Ij4bAozh1PVIQKwTp?=
 =?us-ascii?Q?7kkeN3MlycNBGs4nqyuGSHyFgrrzkH6tRrahYy2vMCsFw8AfME9paNQGE0BL?=
 =?us-ascii?Q?AVJXoD+IKorursB5UtrwPkPWgq/PF/DMYQaeTt+7BTekQRhcUozUOI9jWK1a?=
 =?us-ascii?Q?P2iDpkZ+0xpDrCLCdLK70wrbQ64ABZgfn97MnIM7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8907.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a07d73c1-55ce-4e9f-da98-08db6e4361a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 08:26:28.2559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X5k33XpzXocIj54vBTTIeVp5nMlDgV7Uh5FEWqgNf7JA+6tb1ukJd1PFoi/DDQxEuVcnjjuMKZDyQheA7JkQAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7219
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Jun 16, 2023 at 01:59:05PM +0800, Alison Wang wrote:
> This series contains Arm's NPU Ethos-U driver for NXP i.MX93 platform.
>
> Ethos-U Linux driver is to provide an example of how a rich operating=20
> system like Linux can dispatch inferences to an Arm Cortex-M=20
> subsystem, consisting of an Arm Cortex-M and an Arm Ethos-U NPU.

What is an "inference"?
[Alison Wang] The inference here means machine learning inference. It is th=
e process of
running data points into a machine learning model to calculate an output su=
ch as a single=20
numerical score. For example, we use this driver, user space application an=
d Cortex-M firmware
to complete an inference about image classification.

Where are the userspace tools (if any) that are needed for this driver to w=
ork properly?
[Alison Wang] You could refer to https://github.com/nxp-imx/ethos-u-driver-=
stack-imx.git .


thanks,

greg k-h
