Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D182704497
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 07:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjEPFUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 01:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjEPFU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 01:20:27 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0F949CD;
        Mon, 15 May 2023 22:20:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIJQvnup60Thvh9hT5Ul+N54vDV2nt02bdW+Se2ItozK7Ma3RGED7PITdai7uXQZ0adEWu8nCtlXbm0C/HKkmeS0VHXQ/f0ki4tAYEDjslMs8O8suYlxJUVQNQrU15EMhbp1t3KNAsPxu4rhLkpg2st7BuoOciCxN+BqsNOhe9/gSYVP0HUPbUbN2GJnPqprVDX+xJZIe5refVzcb2FfTX5zJrUvulmR/AP8KRuabbIK6i1XZTxqNKN77+ApNKcL07SKFEPNKNANz54njl05r6J3ruY3SxId+JwyE/HgUo4Phlk1Io0ioPgugNv6EFmAmtNbkt+/afBIDikD6kkrow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7KER3rwkmdDGUcEWezOEW9wzAnWECBhvHz5wRVIAY4=;
 b=YVEZX5iGGjKWHfglnWHSlzQcgq8bzyxOBBro1YE1BZ8/oVzxiI/zlTpFnlTifGFRxFahSKRMLFs6kISaEOCrQOqn5/ypjrcqYmDXF+qCrXuUrNZGADsF8qDqxNS6HPTAAO4RPo/K1EnYxYAUIoH4VP9LdVzEKbzcBhuz3a6CtiC2mAQZ6WqeBiuRX9mmIEbXmOk9P9AS/fCEjXkxR0epadothEoScDK5kwpox6iMSc4cGZB6DJkthqnc5NqfPLtlbCpCLel0/LXeuxWkrsZWmKPRDwqHnwI0fEzTzX4fan1N5hJ4cMa4C/4zUTyX6WRdHmIDoxt31tLnL6mSb62G1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7KER3rwkmdDGUcEWezOEW9wzAnWECBhvHz5wRVIAY4=;
 b=h6mVGMDJOYB1ssPVuOPnesPUXfzXqyuJOFR1QtvqBcWQ34DXXCvyIMlEmSCIth/qIyqbqhPr8wrRYQh5ZW3bvyc59XyM/1g/TK2ozBfs8P9gR77F2tsbh8xf9pG58OQ5FEbizYV0BzkME+iw9dqKkOY9W3/H7C3HBxti0hK3Vug=
Received: from BN7PR12MB2802.namprd12.prod.outlook.com (2603:10b6:408:25::33)
 by MN2PR12MB4319.namprd12.prod.outlook.com (2603:10b6:208:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 05:19:41 +0000
Received: from BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::4db:e158:60d:21e4]) by BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::4db:e158:60d:21e4%6]) with mapi id 15.20.6387.033; Tue, 16 May 2023
 05:19:41 +0000
From:   "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To:     "Larson, Bradley" <Bradley.Larson@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alcooperx@gmail.com" <alcooperx@gmail.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Larson, Bradley" <Bradley.Larson@amd.com>,
        "brendan.higgins@linux.dev" <brendan.higgins@linux.dev>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "davidgow@google.com" <davidgow@google.com>,
        "gsomlo@gmail.com" <gsomlo@gmail.com>,
        "gerg@linux-m68k.org" <gerg@linux-m68k.org>,
        "hal.feng@starfivetech.com" <hal.feng@starfivetech.com>,
        "hasegawa-hitomi@fujitsu.com" <hasegawa-hitomi@fujitsu.com>,
        "j.neuschaefer@gmx.net" <j.neuschaefer@gmx.net>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "samuel@sholland.org" <samuel@sholland.org>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "tonyhuang.sunplus@gmail.com" <tonyhuang.sunplus@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "vaishnav.a@ti.com" <vaishnav.a@ti.com>,
        "walker.chen@starfivetech.com" <walker.chen@starfivetech.com>,
        "will@kernel.org" <will@kernel.org>,
        "zhuyinbo@loongson.cn" <zhuyinbo@loongson.cn>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v14 8/8] soc: amd: Add support for AMD Pensando SoC
 Controller
Thread-Topic: [PATCH v14 8/8] soc: amd: Add support for AMD Pensando SoC
 Controller
Thread-Index: AQHZh1nnZuixcg8+RU2ugBFS+FPqRK9cWbUw
Date:   Tue, 16 May 2023 05:19:40 +0000
Message-ID: <BN7PR12MB2802CE1DBDB6ED8413AECD53DC799@BN7PR12MB2802.namprd12.prod.outlook.com>
References: <20230515181606.65953-1-blarson@amd.com>
 <20230515181606.65953-9-blarson@amd.com>
In-Reply-To: <20230515181606.65953-9-blarson@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR12MB2802:EE_|MN2PR12MB4319:EE_
x-ms-office365-filtering-correlation-id: 5eefc3cb-e187-4bee-6fad-08db55cd26c6
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D8asVs/yxugZI68shfXXkJPday8xafgcekmUxmTfXpJEEbbvIOGuniLZEGXSm3zmDYQpo5nmE7K/eO14L7HbEL8bm7T4LrZqxSCTQPSZ25MR6182jxKLwVaDajiOMWornKrMOdQ801UvnFXdh2ulUv6IaLK25SpCEy9ZU/qvUPSIn0HVHdz4t+d0g9qSbHPJj0mu57eb8Yyf1kInvPFv3ITzrx4FVmxkNZxmFL3AUi13DtFz2WxkMpfMYNdtAMYcbemSzZI3OLQ4l0MdjHKINTtmqd40VJF9+22cFhIrCjZzWReAOQ8DsKSCp+TaxoRVRpVvHq4Y1cc+eOV5P4wHN4WFSLhIbbgZ5MaP2zLjlXbcsT8fQe6t+xFXhMnjmNFxnCqr51tqDAZXLjzWGj+8i+p3AG5cP0z+2oZcL9BQ2WBCatAVYkkA+sT3Biaq6GgdW2WAMWvBYl88T0L2+Rb+NVU3EHaAXFcWHGtoW2GF2HHeWo+OCfkSjcvpkbnzvgI4mI0NVu6hEW2NVMdP2duWS43/LoY2Fy9nch8XUtJ+9jy+MUB9BD1+U7S3BNPlQARoVcKfna+ZGMPOuYZXd18C4c+TQpSmwiJVccWhjXXdi+NBR1Q3LSF5ycz9K/cj5OMroZarcQuFQ+LO3JhQ+WChSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199021)(83380400001)(71200400001)(38100700002)(38070700005)(7416002)(2906002)(7406005)(4326008)(30864003)(86362001)(8936002)(66476007)(55016003)(8676002)(316002)(64756008)(66946007)(66446008)(41300700001)(66556008)(76116006)(5660300002)(122000001)(52536014)(966005)(54906003)(478600001)(186003)(53546011)(6506007)(33656002)(26005)(9686003)(7696005)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YD6K/KA6u9rsBW6rCBuhwGlw1T6RsSNsNWPVWUiOzf34Xo+ItEs0sahBDbRO?=
 =?us-ascii?Q?OYNxCTcBzCxUCZysirJmVWukehIHqBrNGOi4283YoPBQR4NuQzjMpTUcLSXu?=
 =?us-ascii?Q?cP7aaTWHwKRA0OObPetQoIcs8ozPQlcewYB9kDJnkXppGx7tOkePHoy3dOWp?=
 =?us-ascii?Q?z2nD3SJrHHpJI69crIYOEHzAv6wiRlcYspsJWZRr5c11x5sZOYTenaNEzWkV?=
 =?us-ascii?Q?kUSg9SXtJrzNWas3hEWB4A2F52Wo31OyQfudMQAq+Sn6wvfht6z6/tINc+x8?=
 =?us-ascii?Q?phwapmNlPJOOaDsHTLbCCn96NennIrAf5DgLwM3F+kr7NXbInRVwUZfs8a4e?=
 =?us-ascii?Q?z93LdHYHbD3TJrwIJW2KxLl09WV4dRH/+ze8OCTjK26Ia9SBO4Fd3EmrvGqW?=
 =?us-ascii?Q?H8WpQEMy9JqVKWi+s1M2a15sB80ez8Y6VmuQcG0dNz+iD4KyoYW9gxlq4k+q?=
 =?us-ascii?Q?FsU30/Ds4XMb131HG9k6/SiF7jnJT2J2nKJT8Vm3hpyAw+IXHzj6lWD3xa8n?=
 =?us-ascii?Q?DWSItjMpEQv6bHdGbYg+syOV9m9RbIi3lzGbfySGXkxBNAxdEkORjpbTCRPz?=
 =?us-ascii?Q?5wvQ2ce3UZhh8F655Sefsw5wBsHTjaKP9tZkznpqTq5OUrmTWnTwPiKbaZVe?=
 =?us-ascii?Q?WuEOljbhIzjyFLvrlELbyyQM8n0w7oz2euHhb+LOPlhO4Hd7IjLpjIv4VlF+?=
 =?us-ascii?Q?XiGvPF+kQfGzM3NGkYdTWLg1XLOCOt6EWwTWT4C/hcoPLQUA2Fd1yQFCaR99?=
 =?us-ascii?Q?bEwlsuL/WJzvur4TumVGsMEFloiTxPgSIXp8CesGh6iB6JnneueeAxI9hrVl?=
 =?us-ascii?Q?xnRWj7LdH3M6S6CLgKyEqjEWzWwzFvnP8oL+4prJmIKT8mu3m5Evu/skeNbK?=
 =?us-ascii?Q?k/rde1czqNJm5kMLGbcClfg6Et0DqWV5ZyNECRXpVAonyxYIZpuVf/vfGFiD?=
 =?us-ascii?Q?uvZKwdqxOTwV417cuIRpyC4pEh3VB03KoOjacgf1eDWJMy0C0fgZ0CK8aYHb?=
 =?us-ascii?Q?cdTB/z0wTyrpoosJiyIBkZpGcPynVJXJQT4cxEI95GnNv+YFr3oPyV10QXUX?=
 =?us-ascii?Q?gxShEGnRHX7fZp/dGFIPMIuYHyzswD98gBMk97Ld2BY6Fkpm0gRCC7chlCNj?=
 =?us-ascii?Q?wl+2n2n4Y5kVWeFv1nWqFm7CC9rLx1SWJKnj7gFz2/cY5845mhu2qp/xyH4U?=
 =?us-ascii?Q?zExT/iQscvnauqXr/KwZ7wrOPbc5J5an8EVbwwDZ4Lf4PehD+Rpu+G0h+ZTT?=
 =?us-ascii?Q?Lh5ki/7VsDCDOEuZt0KxEbIQ8Es+i9gDxG8n6ymgaqCsLHMQVYNSJuBlJjn5?=
 =?us-ascii?Q?HJ7porHxp3adG0JQQwzODGVt9Xn8FCNEuet2XGL83/+IINJ+OpKDTW1+WyrG?=
 =?us-ascii?Q?huFQxtPnJmznNQcMONy6y7LvB1X/s5HrTo1VJTfKWeSnwxoAZqcpfv+uGiWl?=
 =?us-ascii?Q?4kkVmpCjtin+lmyQ6+4llLVo6pMnh080p2TYfRIMQI0RWMoKAnMh84BbdE9e?=
 =?us-ascii?Q?GAt1CRoxPnzUkFI0BPBwSHVFHuUECNbRclmTFBuLD49qRDye/pa/RtniAfqq?=
 =?us-ascii?Q?EfvFFo6cKq/TpxhRDyA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eefc3cb-e187-4bee-6fad-08db55cd26c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 05:19:41.0092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: djms5C3I5XkJpZea2dyM3D4KciPZwosdyIeckeF8tmiOS3wzYAKCdujYGQ4as0S94j1cMOSUw1zh5LWE5f+aaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4319
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Brad Larson <blarson@amd.com>
> Sent: Monday, May 15, 2023 11:46 PM
> To: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org; linux-mmc@vger.kernel.org; linux-
> spi@vger.kernel.org; adrian.hunter@intel.com; alcooperx@gmail.com;
> andy.shevchenko@gmail.com; arnd@arndb.de; Larson, Bradley
> <Bradley.Larson@amd.com>; brendan.higgins@linux.dev;
> briannorris@chromium.org; catalin.marinas@arm.com;
> conor+dt@kernel.org; davidgow@google.com; gsomlo@gmail.com;
> gerg@linux-m68k.org; hal.feng@starfivetech.com; hasegawa-
> hitomi@fujitsu.com; j.neuschaefer@gmx.net; joel@jms.id.au;
> kernel@esmil.dk; krzk@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> lee@kernel.org; lee.jones@linaro.org; broonie@kernel.org;
> p.zabel@pengutronix.de; rdunlap@infradead.org; robh+dt@kernel.org;
> samuel@sholland.org; fancer.lancer@gmail.com;
> skhan@linuxfoundation.org; Suthikulpanit, Suravee
> <Suravee.Suthikulpanit@amd.com>; Lendacky, Thomas
> <Thomas.Lendacky@amd.com>; tonyhuang.sunplus@gmail.com;
> ulf.hansson@linaro.org; vaishnav.a@ti.com; walker.chen@starfivetech.com;
> will@kernel.org; zhuyinbo@loongson.cn; devicetree@vger.kernel.org
> Subject: [PATCH v14 8/8] soc: amd: Add support for AMD Pensando SoC
> Controller
>=20
> The Pensando SoC controller is a SPI connected companion device that is
> present in all Pensando SoC board designs.  The essential board managemen=
t
> registers are accessed on chip select 0 with board mgmt IO support access=
ed
> using additional chip selects.
>=20
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
>=20
> v14 changes:
> - Save 8 bytes of code size by swapping spi_device and reset_controller_d=
ev
>   in penctrl_device
> - Code simplification and clarity from review inputs
> - Set penctrl_spi_driver.driver.name to match compatible pensando-elba-ct=
rl
> - Remove unused include in amd-pensando-ctrl.h
> - Rebase to linux-next 6.4.0-rc1 class_create() API change
>=20
> v13 changes:
> - Update include list in pensando-ctrl.c
> - Change variable spi_dev to spi throughout
> - Removed unneeded variable initialization, simplification of
>   error checks, remove extra castings, and use dev_err_probe()
> - Sort the includes in amd-pensando-ctrl.h
> - Updates to cleanup if there is an error in penctrl_spi_probe()
>=20
> v12 changes:
> - Fix gcc-12.1.0 warning:
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202303120925.SxLjwOd2-
> lkp@intel.com/
>=20
> v11 changes:
> - Fix the compatible to be specific 'amd,pensando-elba-ctrl'
>=20
> v10 changes:
> - Different driver implementation specific to this Pensando controller de=
vice.
> - Moved to soc/amd directory under new name based on guidance.  This
> driver is
>   of no use to any design other than all Pensando SoC based cards.
> - Removed use of builtin_driver, can be built as a module.
>=20
> v9 changes:
> - Previously patch 14/17
> - After the change to the device tree node and squashing
>   reset-cells into the parent simplified this to not use
>   any MFD API and move it to drivers/spi/pensando-sr.c.
> - Change the naming to remove elba since this driver is common
>   for all Pensando SoC designs .
> - Default yes SPI_PENSANDO_SR for ARCH_PENSANDO
>=20
> ---
>  drivers/soc/Kconfig                    |   1 +
>  drivers/soc/Makefile                   |   1 +
>  drivers/soc/amd/Kconfig                |  16 ++
>  drivers/soc/amd/Makefile               |   2 +
>  drivers/soc/amd/pensando-ctrl.c        | 368 +++++++++++++++++++++++++
>  include/uapi/linux/amd-pensando-ctrl.h |  29 ++
>  6 files changed, 417 insertions(+)
>  create mode 100644 drivers/soc/amd/Kconfig  create mode 100644
> drivers/soc/amd/Makefile  create mode 100644 drivers/soc/amd/pensando-
> ctrl.c  create mode 100644 include/uapi/linux/amd-pensando-ctrl.h
>=20
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig index
> 4e176280113a..9e023f74e47c 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -2,6 +2,7 @@
>  menu "SOC (System On Chip) specific Drivers"
>=20
>  source "drivers/soc/actions/Kconfig"
> +source "drivers/soc/amd/Kconfig"
>  source "drivers/soc/amlogic/Kconfig"
>  source "drivers/soc/apple/Kconfig"
>  source "drivers/soc/aspeed/Kconfig"
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile index
> 3b0f9fb3b5c8..8914530f2721 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -4,6 +4,7 @@
>  #
>=20
>  obj-$(CONFIG_ARCH_ACTIONS)	+=3D actions/
> +obj-y				+=3D amd/
>  obj-y				+=3D apple/
>  obj-y				+=3D aspeed/
>  obj-$(CONFIG_ARCH_AT91)		+=3D atmel/
> diff --git a/drivers/soc/amd/Kconfig b/drivers/soc/amd/Kconfig new file
> mode 100644 index 000000000000..011d5339d14e
> --- /dev/null
> +++ b/drivers/soc/amd/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0-only menu "AMD Pensando SoC drivers"
> +
> +config AMD_PENSANDO_CTRL
> +	tristate "AMD Pensando SoC Controller"
> +	depends on SPI_MASTER=3Dy
> +	depends on (ARCH_PENSANDO && OF) || COMPILE_TEST
> +	default ARCH_PENSANDO
> +	select REGMAP_SPI
> +	select MFD_SYSCON
> +	help
> +	  Enables AMD Pensando SoC controller device support.  This is a SPI
> +	  attached companion device in all Pensando SoC board designs which
> +	  provides essential board control/status registers and management
> IO
> +	  support.
> +endmenu
> diff --git a/drivers/soc/amd/Makefile b/drivers/soc/amd/Makefile new file
> mode 100644 index 000000000000..a2de0424f68d
> --- /dev/null
> +++ b/drivers/soc/amd/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_AMD_PENSANDO_CTRL)	+=3D pensando-ctrl.o
> diff --git a/drivers/soc/amd/pensando-ctrl.c b/drivers/soc/amd/pensando-
> ctrl.c new file mode 100644 index 000000000000..a7ddd181dfe8
> --- /dev/null
> +++ b/drivers/soc/amd/pensando-ctrl.c
> @@ -0,0 +1,368 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * AMD Pensando SoC Controller
> + *
> + * Userspace interface and reset driver support for SPI connected
> +Pensando SoC
> + * controller device.  This device is present in all Pensando SoC
> +designs and
> + * contains board control/status registers and management IO support.
> + *
> + * Copyright 2023 Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/cdev.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/reset-controller.h>
> +#include <linux/spi/spi.h>
> +
> +#include <linux/amd-pensando-ctrl.h>
> +
> +struct penctrl_device {
> +	struct reset_controller_dev rcdev;
> +	struct spi_device *spi;
> +};
> +
> +static DEFINE_MUTEX(spi_lock);
> +static dev_t penctrl_devt;
> +static struct penctrl_device *penctrl;
> +static struct class *penctrl_class;
> +
> +static long
> +penctrl_ioctl(struct file *filp, unsigned int cmd, unsigned long arg) {
> +	void __user *in_arg =3D (void __user *)arg;
> +	struct penctrl_device *penctrl;
> +	u8 tx_buf[PENCTRL_MAX_MSG_LEN];
> +	u8 rx_buf[PENCTRL_MAX_MSG_LEN];
> +	struct spi_transfer t[2] =3D {};
> +	struct penctrl_spi_xfer *msg;
> +	struct spi_device *spi;
> +	unsigned int num_msgs;
> +	struct spi_message m;
> +	u32 size;
> +	int ret;
> +
> +	/* Check for a valid command */
> +	if (_IOC_TYPE(cmd) !=3D PENCTRL_IOC_MAGIC)
> +		return -ENOTTY;
> +
> +	if (_IOC_NR(cmd) > PENCTRL_IOC_MAXNR)
> +		return -ENOTTY;
> +
> +	if (((_IOC_DIR(cmd) & _IOC_READ)) && !access_ok(in_arg,
> _IOC_SIZE(cmd)))
> +		return -EFAULT;
> +
> +	if (((_IOC_DIR(cmd) & _IOC_WRITE)) && !access_ok(in_arg,
> _IOC_SIZE(cmd)))
> +		return -EFAULT;
> +
> +	/* Get a reference to the SPI device */
> +	penctrl =3D filp->private_data;
> +	if (!penctrl)
> +		return -ESHUTDOWN;
> +
> +	spi =3D spi_dev_get(penctrl->spi);
> +	if (!spi)
> +		return -ESHUTDOWN;
> +
> +	/* Verify and prepare SPI message */
> +	size =3D _IOC_SIZE(cmd);
> +	num_msgs =3D size / sizeof(struct penctrl_spi_xfer);
> +	if (num_msgs > 2 || size =3D=3D 0 || size % sizeof(struct
> penctrl_spi_xfer)) {
> +		ret =3D -EINVAL;
> +		goto out_unlock;
> +	}
> +	msg =3D memdup_user((struct penctrl_spi_xfer *)arg, size);
> +	if (IS_ERR(msg)) {
> +		ret =3D PTR_ERR(msg);
> +		goto out_unlock;
> +	}
> +	if (msg->len > PENCTRL_MAX_MSG_LEN) {
> +		ret =3D -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	t[0].tx_buf =3D tx_buf;
> +	t[0].len =3D msg->len;
> +	if (copy_from_user(tx_buf, (void __user *)msg->tx_buf, msg->len))
> {
> +		ret =3D -EFAULT;
> +		goto out_unlock;
> +	}
> +	if (num_msgs > 1) {
> +		msg++;
> +		if (msg->len > PENCTRL_MAX_MSG_LEN) {
> +			ret =3D -EINVAL;
> +			goto out_unlock;
> +		}
> +		t[1].rx_buf =3D rx_buf;
> +		t[1].len =3D msg->len;
> +	}
> +	spi_message_init_with_transfers(&m, t, num_msgs);
> +
> +	/* Perform the transfer */
> +	mutex_lock(&spi_lock);
> +	ret =3D spi_sync(spi, &m);
> +	mutex_unlock(&spi_lock);
> +
> +	if (ret || (num_msgs =3D=3D 1))
> +		goto out_unlock;
> +
> +	if (copy_to_user((void __user *)msg->rx_buf, rx_buf, msg->len))
> +		ret =3D -EFAULT;
> +
> +out_unlock:
> +	spi_dev_put(spi);
> +	return ret;
> +}
> +
> +static int penctrl_open(struct inode *inode, struct file *filp) {
> +	struct spi_device *spi;
> +	u8 current_cs;
> +
> +	filp->private_data =3D penctrl;
> +	current_cs =3D iminor(inode);
> +	spi =3D penctrl->spi;
> +	spi->chip_select =3D current_cs;

New set/get APIs for accessing spi->chip_select were introduced by=20
https://github.com/torvalds/linux/commit/303feb3cc06ac0665d0ee9c1414941200e=
60e8a3
please use these APIs instead of accessing spi->chip_select dricetly.=20

> +	spi->cs_gpiod =3D spi->controller->cs_gpiods[current_cs];
> +	spi_setup(spi);
> +	return stream_open(inode, filp);
> +}
> +
> +static int penctrl_release(struct inode *inode, struct file *filp) {
> +	filp->private_data =3D NULL;
> +	return 0;
> +}
> +
> +static const struct file_operations penctrl_fops =3D {
> +	.owner		=3D THIS_MODULE,
> +	.unlocked_ioctl =3D penctrl_ioctl,
> +	.open		=3D penctrl_open,
> +	.release	=3D penctrl_release,
> +	.llseek		=3D no_llseek,
> +};
> +
> +static int penctrl_regs_read(struct penctrl_device *penctrl, u32 reg,
> +u32 *val) {
> +	struct spi_device *spi =3D penctrl->spi;
> +	struct spi_transfer t[2] =3D {};
> +	struct spi_message m;
> +	u8 txbuf[3];
> +	u8 rxbuf[1];
> +	int ret;
> +
> +	txbuf[0] =3D PENCTRL_SPI_CMD_REGRD;
> +	txbuf[1] =3D reg;
> +	txbuf[2] =3D 0;
> +	t[0].tx_buf =3D txbuf;
> +	t[0].len =3D sizeof(txbuf);
> +
> +	rxbuf[0] =3D 0;
> +	t[1].rx_buf =3D rxbuf;
> +	t[1].len =3D sizeof(rxbuf);
> +
> +	spi_message_init_with_transfers(&m, t, ARRAY_SIZE(t));
> +	ret =3D spi_sync(spi, &m);
> +	if (ret =3D=3D 0)
> +		*val =3D rxbuf[0];
> +
> +	return ret;
> +}
> +
> +static int penctrl_regs_write(struct penctrl_device *penctrl, u32 reg,
> +u32 val) {
> +	struct spi_device *spi =3D penctrl->spi;
> +	struct spi_transfer t =3D {};
> +	struct spi_message m;
> +	u8 txbuf[4];
> +
> +	txbuf[0] =3D PENCTRL_SPI_CMD_REGWR;
> +	txbuf[1] =3D reg;
> +	txbuf[2] =3D val;
> +	txbuf[3] =3D 0;
> +
> +	t.tx_buf =3D txbuf;
> +	t.len =3D sizeof(txbuf);
> +	spi_message_init_with_transfers(&m, &t, 1);
> +	return spi_sync(spi, &m);
> +}
> +
> +static int penctrl_reset_assert(struct reset_controller_dev *rcdev,
> +				unsigned long id)
> +{
> +	struct penctrl_device *penctrl =3D
> +		container_of(rcdev, struct penctrl_device, rcdev);
> +	struct spi_device *spi =3D penctrl->spi;
> +	unsigned int val;
> +	int ret;
> +
> +	mutex_lock(&spi_lock);
> +	spi->chip_select =3D 0;

Same here.

> +	spi->cs_gpiod =3D spi->controller->cs_gpiods[0];
> +	spi_setup(spi);
> +	ret =3D penctrl_regs_read(penctrl, PENCTRL_REG_CTRL0, &val);
> +	if (ret) {
> +		dev_err(&spi->dev, "error reading ctrl0 reg\n");
> +		goto out_unlock;
> +	}
> +
> +	val |=3D BIT(6);
> +	ret =3D penctrl_regs_write(penctrl, PENCTRL_REG_CTRL0, val);
> +	if (ret)
> +		dev_err(&spi->dev, "error writing ctrl0 reg\n");
> +
> +out_unlock:
> +	mutex_unlock(&spi_lock);
> +	return ret;
> +}
> +
> +static int penctrl_reset_deassert(struct reset_controller_dev *rcdev,
> +				  unsigned long id)
> +{
> +	struct penctrl_device *penctrl =3D
> +		container_of(rcdev, struct penctrl_device, rcdev);
> +	struct spi_device *spi =3D penctrl->spi;
> +	unsigned int val;
> +	int ret;
> +
> +	mutex_lock(&spi_lock);
> +	spi->chip_select =3D 0;

Same here.

Regards,
Amit

> +	spi->cs_gpiod =3D spi->controller->cs_gpiods[0];
> +	spi_setup(spi);
> +	ret =3D penctrl_regs_read(penctrl, PENCTRL_REG_CTRL0, &val);
> +	if (ret) {
> +		dev_err(&spi->dev, "error reading ctrl0 reg\n");
> +		goto out_unlock;
> +	}
> +
> +	val &=3D ~BIT(6);
> +	ret =3D penctrl_regs_write(penctrl, PENCTRL_REG_CTRL0, val);
> +	if (ret)
> +		dev_err(&spi->dev, "error writing ctrl0 reg\n");
> +
> +out_unlock:
> +	mutex_unlock(&spi_lock);
> +	return ret;
> +}
> +
> +static const struct reset_control_ops penctrl_reset_ops =3D {
> +	.assert =3D penctrl_reset_assert,
> +	.deassert =3D penctrl_reset_deassert,
> +};
> +
> +static int penctrl_spi_probe(struct spi_device *spi) {
> +	struct device *dev;
> +	struct cdev *cdev;
> +	u32 num_cs;
> +	int ret;
> +	u32 cs;
> +
> +	ret =3D device_property_read_u32(spi->dev.parent, "num-cs",
> &num_cs);
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "number of chip-selects not defined\n");
> +
> +	ret =3D alloc_chrdev_region(&penctrl_devt, 0, num_cs, "penctrl");
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "failed to alloc chrdev region\n");
> +
> +	penctrl_class =3D class_create("penctrl");
> +	if (IS_ERR(penctrl_class)) {
> +		ret =3D dev_err_probe(&spi->dev, PTR_ERR(penctrl_class),
> +				    "failed to create class\n");
> +		goto unregister_chrdev;
> +	}
> +
> +	cdev =3D cdev_alloc();
> +	if (!cdev) {
> +		ret =3D dev_err_probe(&spi->dev, -ENOMEM,
> +				    "allocation of cdev failed\n");
> +		goto destroy_class;
> +	}
> +	cdev->owner =3D THIS_MODULE;
> +	cdev_init(cdev, &penctrl_fops);
> +
> +	ret =3D cdev_add(cdev, penctrl_devt, num_cs);
> +	if (ret) {
> +		ret =3D dev_err_probe(&spi->dev, ret,
> +				    "register of cdev failed\n");
> +		goto free_cdev;
> +	}
> +
> +	/* Allocate driver data */
> +	penctrl =3D kzalloc(sizeof(*penctrl), GFP_KERNEL);
> +	if (!penctrl) {
> +		ret =3D -ENOMEM;
> +		goto free_cdev;
> +	}
> +	penctrl->spi =3D spi;
> +	mutex_init(&spi_lock);
> +
> +	/* Create a device for each chip select */
> +	for (cs =3D 0; cs < num_cs; cs++) {
> +		dev =3D device_create(penctrl_class,
> +				    &spi->dev,
> +				    MKDEV(MAJOR(penctrl_devt), cs),
> +				    penctrl,
> +				    "penctrl0.%d",
> +				    cs);
> +		if (IS_ERR(dev)) {
> +			ret =3D dev_err_probe(&spi->dev, PTR_ERR(dev),
> +					    "error creating device\n");
> +			goto destroy_device;
> +		}
> +		dev_dbg(&spi->dev, "created device major %u, minor
> %d\n",
> +			MAJOR(penctrl_devt), cs);
> +	}
> +
> +	/* Register reset controller */
> +	penctrl->rcdev.dev =3D &spi->dev;
> +	penctrl->rcdev.ops =3D &penctrl_reset_ops;
> +	penctrl->rcdev.owner =3D THIS_MODULE;
> +	penctrl->rcdev.of_node =3D spi->dev.of_node;
> +	penctrl->rcdev.nr_resets =3D 1;
> +
> +	ret =3D reset_controller_register(&penctrl->rcdev);
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "failed to register reset controller\n");
> +	return 0;
> +
> +destroy_device:
> +	for (cs =3D 0; cs < num_cs; cs++)
> +		device_destroy(penctrl_class,
> MKDEV(MAJOR(penctrl_devt), cs));
> +	kfree(penctrl);
> +free_cdev:
> +	cdev_del(cdev);
> +destroy_class:
> +	class_destroy(penctrl_class);
> +unregister_chrdev:
> +	unregister_chrdev(MAJOR(penctrl_devt), "penctrl");
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id penctrl_dt_match[] =3D {
> +	{ .compatible =3D "amd,pensando-elba-ctrl" },
> +	{ /* sentinel */ }
> +};
> +
> +static struct spi_driver penctrl_spi_driver =3D {
> +	.probe =3D penctrl_spi_probe,
> +	.driver =3D {
> +		.name =3D "pensando-elba-ctrl",
> +		.of_match_table =3D penctrl_dt_match,
> +	},
> +};
> +module_spi_driver(penctrl_spi_driver);
> +
> +MODULE_AUTHOR("Brad Larson <blarson@amd.com>");
> MODULE_DESCRIPTION("AMD
> +Pensando SoC Controller via SPI"); MODULE_LICENSE("GPL");
> diff --git a/include/uapi/linux/amd-pensando-ctrl.h
> b/include/uapi/linux/amd-pensando-ctrl.h
> new file mode 100644
> index 000000000000..e5f9f0dfe146
> --- /dev/null
> +++ b/include/uapi/linux/amd-pensando-ctrl.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Userspace interface for /dev/penctrl
> + *
> + * This file can be used by applications that need to communicate
> + * with the AMD Pensando SoC controller device via the ioctl interface.
> + */
> +#ifndef _UAPI_LINUX_AMD_PENSANDO_CTRL_H #define
> +_UAPI_LINUX_AMD_PENSANDO_CTRL_H
> +
> +#include <linux/types.h>
> +
> +#define PENCTRL_SPI_CMD_REGRD	0x0b
> +#define PENCTRL_SPI_CMD_REGWR	0x02
> +#define PENCTRL_IOC_MAGIC	'k'
> +#define PENCTRL_IOC_MAXNR	0
> +#define PENCTRL_MAX_MSG_LEN	16
> +#define PENCTRL_MAX_REG		0xff
> +#define PENCTRL_REG_CTRL0	0x10
> +
> +struct penctrl_spi_xfer {
> +	__u64 tx_buf;
> +	__u64 rx_buf;
> +	__u32 len;
> +	__u32 speed_hz;
> +	__u64 compat;
> +};
> +
> +#endif /* _UAPI_LINUX_AMD_PENSANDO_CTRL_H */
> --
> 2.17.1

