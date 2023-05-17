Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1D1705F04
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 06:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbjEQEzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 00:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjEQEze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 00:55:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C502610D8;
        Tue, 16 May 2023 21:55:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DltmDkWbwWFr21v3SeLx5d1eVyRO01kvvWgDAco48tuhnbFFFDM8H4xETZkflH5DQpTlhoUbys8bhJyPDl6lwX2pK4MZYm8RKAZSIytZT+uVHzAPBd1wvCcikITH7t8rAEQS1uQHW4BkvGgV0RWq8zoG8xcjzC4ARcb/Iq0cHnkeD/ymfdByufGaf1VMWqiLNJE5uSh1/bGTuoS7pICP7qzZ6/b0gkO9KErtgQb9vQ8m//EFrsn7mwGCnBqfNwhQ0RxtNmJlMAU7rh6DhowRBZpLD499+zKiYDBoqBLMoxwtGuKOyrHacrIuAeQsskjRXWa1RPtaGaUlte8U1WsqIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jvqz/QLVvqOibG2OwCXiaeOUQaAiwwaWbJ4aXdxR/3Q=;
 b=BnZW2DeVQN33SZv/Q7hCZuhPCykS2CzaMEPIv9NpyKcWGbglTnohGTdJCDzxafND5YrTNeaUv9mo3DDP8vxnvYYUKH1UnVqsGJxY7AiJdTA9iyFth/6Rr5x3hcYCEPHQ06gk2WQh5uZULID5BMWW7wXY0FFsUKgTPRd14yOeobTjOpwaYt+8oVzZr9Ft5RNPIk2I/C+HYSgPQHuq3E9gJ8OyvcVuzA1q08Rvfe4kLW39OCY100pqSu398mu9niznAuPoEU0YnWHo3if4SrwSdQCClzOwbSw+HKlxGffvwHNDyiGlPSAwtNsHwQVoYgHZH5MnpUmDTsrrt3MkbJFt+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jvqz/QLVvqOibG2OwCXiaeOUQaAiwwaWbJ4aXdxR/3Q=;
 b=392fc8/GK2TGd8dkiai0t/YrHnm+rFuaNve6Bn3pyLnFyUsgD1RBuPesSfXRAejJEbBWE3q87AVMZqXiMa5EI9GBQHj+mkm9B1tahAA6gszFhX61O6GWyrroV0XTMk9yRhQYjUTtiRvWoFGhEwRY3UtgnnfFyNzRNbF+mZDUT8M=
Received: from BN7PR12MB2802.namprd12.prod.outlook.com (2603:10b6:408:25::33)
 by DS0PR12MB6655.namprd12.prod.outlook.com (2603:10b6:8:d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 04:55:28 +0000
Received: from BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::4db:e158:60d:21e4]) by BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::4db:e158:60d:21e4%6]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 04:55:28 +0000
From:   "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jianmin Lv <lvjianmin@loongson.cn>,
        "wanghongliang@loongson.cn" <wanghongliang@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>,
        "loongson-kernel@lists.loongnix.cn" 
        <loongson-kernel@lists.loongnix.cn>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v10 2/2] spi: loongson: add bus driver for the loongson
 spi controller
Thread-Topic: [PATCH v10 2/2] spi: loongson: add bus driver for the loongson
 spi controller
Thread-Index: AQHZh/gczx78IS8W1UeqJcmH5eNipK9d5lXg
Date:   Wed, 17 May 2023 04:55:28 +0000
Message-ID: <BN7PR12MB2802A6A9106C50F919693E4BDC7E9@BN7PR12MB2802.namprd12.prod.outlook.com>
References: <20230516131224.25481-1-zhuyinbo@loongson.cn>
 <20230516131224.25481-3-zhuyinbo@loongson.cn>
In-Reply-To: <20230516131224.25481-3-zhuyinbo@loongson.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR12MB2802:EE_|DS0PR12MB6655:EE_
x-ms-office365-filtering-correlation-id: 38f848c7-98b8-4818-3aee-08db5692ef68
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XE16pgd56Jq2dLryipwWC7bG7J/+Kl+yx2rcEVCHimD2/TjfilDVZRY3aWmJI+waaZK7tXzCrvjVtBrIqtiGZ7mRYFhdlvTJVGP/wIjOKsdN8gA2zpniICLG8Tp46OxIN9CmxHQLEHOacskVV3zvDp9TdmSta71wxxUziuom/iys7ePlHCJ1MATf2+9pPDICRDul+FBXvUlm16DFWBhpoBIvULhxqGAJ/B85LtfL+ZYsoUwfCk7EYJXDDHzOXvBUgYoxuC3/OtNjO5j61oaib0XexmNpydf7Qo55B+ok+elYm4Fc1uIyxXtrHM/N+Or71BY3zyI26B2qXYgz2coXBBafLxHbIYklCrPaJPatP7y+iUJMUlSBahJQOyFjJNlb4RZgaeWkhHHFwk5SCc8jYN47obDzzbQZ+smoIacRQTi+L+cNsAlqszL5qQhxilsXAKAWSzccugG+yQFVs9BIJMqTUguHUhkK3mfbLYP22eJNukgH4ar5kYlT/exiuHKvKm49gfIBUk9ZsIiQKpWTKSz9HcdQsemBCBtDhduaBU09J37/lPFQVNbfkhcD+q6upjhqBhVNpZ1uJ8pak9kcQNxhWbrp3cZGs2/hTLpqcRE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199021)(76116006)(4326008)(316002)(66946007)(64756008)(66446008)(66476007)(8676002)(8936002)(66556008)(7696005)(478600001)(54906003)(110136005)(30864003)(2906002)(41300700001)(7416002)(5660300002)(52536014)(71200400001)(966005)(6506007)(9686003)(53546011)(26005)(186003)(55016003)(83380400001)(38070700005)(86362001)(38100700002)(33656002)(122000001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Eue0hNoWF5mjMaIzyCc9XWZETgkQxDDhTpvjQBOz1S/YSwaLnN7N/YExXwnu?=
 =?us-ascii?Q?qdWumGZrBT/1NLApOgR7w3UJdR1e32bIE+eydDZHrU+sjvOdZVV+FQltIbcS?=
 =?us-ascii?Q?fxEwCkna0Oq64HmM7o5uIzs8tEmLztteqDj5UmD/Nw7Gts92dYke1totrZmW?=
 =?us-ascii?Q?jiAZhjT1SDqwt6h29A0CLYxV4OX64SePdU20IC7ZVAiLznKuR45jh5lmMNlU?=
 =?us-ascii?Q?whOx0nxLRgkqqpJ2PEahzrHm2IKYt2SmtPnB0XQidOK2CgAz5jVpb/O+ro9u?=
 =?us-ascii?Q?pTJ6M9Xao8ycvAn84q+nq6LUv9VlfsVrSn+nPUXIFDGjTTO54D6lOqISUOp/?=
 =?us-ascii?Q?ugVq7t1UGqQTDTyjxL3KYCtTY7FnmU8nH73pjeVzCFSesUJVPxIuykzve/aj?=
 =?us-ascii?Q?4CsiwsnaP19tXgMEW1bmTqAqgiMzam1zKd/Bqdjj+jSOWtbhMWkRX3NvRYfa?=
 =?us-ascii?Q?QKq0gQREFtvsCyXvsSXq+lc7EKt3+EAWc468KVUNROOePZMaid6d2T2xXMFI?=
 =?us-ascii?Q?Q7IRYAe17MhxcRVPVipQxqOeb9zU4GOKncnvjF3DhsGiPswcheh2wGhF9O31?=
 =?us-ascii?Q?3VeKonAAzk7SqcwNrO0NHXJBVP+VyqJG1ILpXKQ4PN1mCwteLKy6ppNTBTAI?=
 =?us-ascii?Q?FtboWPMfGC41fq/s2nXOjaGFTsvrEk37ubtX1+3qTo0vSDa4reB4ZH1gth58?=
 =?us-ascii?Q?8kvCAPjbO7CD1gP8cvD4zzpviNEt/MI2rgjY2gFaXyyTFNXn/4pbSyyixCAC?=
 =?us-ascii?Q?8GFuCmKKNVy4IDBRco9mV1cn+biwwPvB44Ggbp/6qsZ0LLehOiLK1tvt9n4z?=
 =?us-ascii?Q?mBL3jRD1wDh2WRh2WhtBJrzyGM64fSUW5qvUn1wrM+zm1H/nje+12E0oBVay?=
 =?us-ascii?Q?eRWfwUTTfo7JoUaKiDID6nLColo+Ke9GGM5yUvT6dF517zc7XULLddqDjE1E?=
 =?us-ascii?Q?HWY8ivlo9uLWa3VvMcmsCAzP5j+x9jHuz50bnx+oJ1SMGK/kLUU+DlcjBsmh?=
 =?us-ascii?Q?6wNvcbT5WIQi+nmmmNFncUYj0tE+zEf+rML/H1WV9e7zJoOxVyvbd9iwK9bP?=
 =?us-ascii?Q?bBl4ipsQeQTgX/uUVTL2TCAo943TQZalnMZimHw/F+ZF+Hplw4g+XbOfYxJb?=
 =?us-ascii?Q?ZG9FoJqA3Jb39aWgHfU/nJNurOwW/6sFW+c0VXQgpeZ9zBEWqm2Bnkem4JK9?=
 =?us-ascii?Q?PstWGe8IV627WqyjvhUq2BgqGmpHH3burRqneFBKsX1F7exbSs0lqS9IJO7j?=
 =?us-ascii?Q?oljaFACHk1T91Il6m+EDpqIb3J5L6TFuqnFL3u0l4gZZk9RdSNnLK9QPVm71?=
 =?us-ascii?Q?cvyG4stC3bc32tR2F4NJE/5NJ4ypsqZw7dk95XAF7c3EXMD4JpEYmWp32lX3?=
 =?us-ascii?Q?MNc1AIBWje0mRghbdIZDsSCarCDJgwnyLmzlMXJLkU/KEcxYzzdFjaEc9uld?=
 =?us-ascii?Q?gswVfLCHlXRdOALtY/EVExTwk/nDaqmCrFEjmlrUU7/42VljHk1rD1PugKLq?=
 =?us-ascii?Q?HuO1TdS0C49T849ZNyDs6aDlA3HSfxllhmHbn/8UT9KfALkSw//OKONTA8ul?=
 =?us-ascii?Q?XdC7hsGIqn2PiCkBO3g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f848c7-98b8-4818-3aee-08db5692ef68
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 04:55:28.4698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O8AhPMg4p96kGxbGcHlWLTyEuDFSAIRp59k2zKeyj/KOK/ZfAgnjcBvVa7JoDVSTAbNjU3e0QfGcXGe7YyjT7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6655
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

Hello,

> -----Original Message-----
> From: Yinbo Zhu <zhuyinbo@loongson.cn>
> Sent: Tuesday, May 16, 2023 6:42 PM
> To: Mark Brown <broonie@kernel.org>; Rob Herring <robh+dt@kernel.org>;
> Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; linux-
> spi@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Jianmin Lv <lvjianmin@loongson.cn>; wanghongliang@loongson.cn; Liu
> Peibao <liupeibao@loongson.cn>; loongson-kernel@lists.loongnix.cn; Yinbo
> Zhu <zhuyinbo@loongson.cn>
> Subject: [PATCH v10 2/2] spi: loongson: add bus driver for the loongson s=
pi
> controller
>=20
> CAUTION: This message has originated from an External Source. Please use
> proper judgment and caution when opening attachments, clicking links, or
> responding to this email.
>=20
>=20
> This bus driver supports the Loongson SPI hardware controller in the Loon=
gson
> platforms and supports to use DTS and PCI framework to register SPI devic=
e
> resources.
>=20
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  MAINTAINERS                     |   4 +
>  drivers/spi/Kconfig             |  26 +++
>  drivers/spi/Makefile            |   3 +
>  drivers/spi/spi-loongson-core.c | 279 ++++++++++++++++++++++++++++++++
> drivers/spi/spi-loongson-pci.c  |  61 +++++++  drivers/spi/spi-loongson-p=
lat.c |
> 46 ++++++
>  drivers/spi/spi-loongson.h      |  47 ++++++
>  7 files changed, 466 insertions(+)
>  create mode 100644 drivers/spi/spi-loongson-core.c  create mode 100644
> drivers/spi/spi-loongson-pci.c  create mode 100644 drivers/spi/spi-loongs=
on-
> plat.c  create mode 100644 drivers/spi/spi-loongson.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dfcc5db4bbc0..ab08aba965f3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12218,6 +12218,10 @@ M:     Yinbo Zhu <zhuyinbo@loongson.cn>
>  L:     linux-spi@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
> +F:     drivers/spi/spi-loongson-core.c
> +F:     drivers/spi/spi-loongson-pci.c
> +F:     drivers/spi/spi-loongson-plat.c
> +F:     drivers/spi/spi-loongson.h
>=20
>  LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>  M:     Sathya Prakash <sathya.prakash@broadcom.com>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig index
> 3de2ebe8294a..6b953904792e 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -516,6 +516,32 @@ config SPI_LM70_LLP
>           which interfaces to an LM70 temperature sensor using
>           a parallel port.
>=20
> +config SPI_LOONGSON_CORE
> +       tristate
> +       depends on LOONGARCH || COMPILE_TEST
> +
> +config SPI_LOONGSON_PCI
> +       tristate "Loongson SPI Controller PCI Driver Support"
> +       select SPI_LOONGSON_CORE
> +       depends on PCI && (LOONGARCH || COMPILE_TEST)
> +       help
> +         This bus driver supports the Loongson SPI hardware controller i=
n
> +         the Loongson platforms and supports to use PCI framework to
> +         register SPI device resources.
> +         Say Y or M here if you want to use the SPI controller on
> +         Loongson platform.
> +
> +config SPI_LOONGSON_PLATFORM
> +       tristate "Loongson SPI Controller Platform Driver Support"
> +       select SPI_LOONGSON_CORE
> +       depends on OF && (LOONGARCH || COMPILE_TEST)
> +       help
> +         This bus driver supports the Loongson SPI hardware controller i=
n
> +         the Loongson platforms and supports to use DTS framework to
> +         register SPI device resources.
> +         Say Y or M here if you want to use the SPI controller on
> +         Loongson platform.
> +
>  config SPI_LP8841_RTC
>         tristate "ICP DAS LP-8841 SPI Controller for RTC"
>         depends on MACH_PXA27X_DT || COMPILE_TEST diff --git
> a/drivers/spi/Makefile b/drivers/spi/Makefile index
> 28c4817a8a74..3e933064d237 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -71,6 +71,9 @@ obj-$(CONFIG_SPI_INTEL_PLATFORM)      +=3D spi-intel-
> platform.o
>  obj-$(CONFIG_SPI_LANTIQ_SSC)           +=3D spi-lantiq-ssc.o
>  obj-$(CONFIG_SPI_JCORE)                        +=3D spi-jcore.o
>  obj-$(CONFIG_SPI_LM70_LLP)             +=3D spi-lm70llp.o
> +obj-$(CONFIG_SPI_LOONGSON_CORE)                +=3D spi-loongson-core.o
> +obj-$(CONFIG_SPI_LOONGSON_PCI)         +=3D spi-loongson-pci.o
> +obj-$(CONFIG_SPI_LOONGSON_PLATFORM)    +=3D spi-loongson-plat.o
>  obj-$(CONFIG_SPI_LP8841_RTC)           +=3D spi-lp8841-rtc.o
>  obj-$(CONFIG_SPI_MESON_SPICC)          +=3D spi-meson-spicc.o
>  obj-$(CONFIG_SPI_MESON_SPIFC)          +=3D spi-meson-spifc.o
> diff --git a/drivers/spi/spi-loongson-core.c b/drivers/spi/spi-loongson-c=
ore.c
> new file mode 100644 index 000000000000..435a58b0d9da
> --- /dev/null
> +++ b/drivers/spi/spi-loongson-core.c
> @@ -0,0 +1,279 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Loongson SPI Support
> +// Copyright (C) 2023 Loongson Technology Corporation Limited
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +#include "spi-loongson.h"
> +
> +static inline void loongson_spi_write_reg(struct loongson_spi *spi, unsi=
gned
> char reg,
> +                                         unsigned char data) {
> +       writeb(data, spi->base + reg);
> +}
> +
> +static inline char loongson_spi_read_reg(struct loongson_spi *spi,
> +unsigned char reg) {
> +       return readb(spi->base + reg);
> +}
> +
> +static void loongson_spi_set_cs(struct spi_device *spi, bool val) {
> +       int cs;
> +       struct loongson_spi *loongson_spi =3D
> +spi_master_get_devdata(spi->master);
> +
> +       cs =3D loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SFCS_REG)
> +                                          & ~(0x11 << spi->chip_select);

New set/get APIs for accessing spi->chip_select were introduced by
https://github.com/torvalds/linux/commit/303feb3cc06ac0665d0ee9c1414941200e=
60e8a3
please use these APIs instead of accessing spi->chip_select directly.

> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SFCS_REG,
> +                                      (val ? (0x11 << spi->chip_select) =
:

Same here
> +                                      (0x1 << spi->chip_select)) | cs);

Same here
> +}
> +
> +static void loongson_spi_set_clk(struct loongson_spi *loongson_spi,
> +unsigned int hz) {
> +       unsigned char val;
> +       unsigned int div, div_tmp;
> +       const char rdiv[12] =3D {0, 1, 4, 2, 3, 5, 6, 7, 8, 9, 10, 11};
> +
> +       div =3D clamp_val(DIV_ROUND_UP_ULL(loongson_spi->clk_rate, hz), 2=
,
> 4096);
> +       div_tmp =3D rdiv[fls(div - 1)];
> +       loongson_spi->spcr =3D (div_tmp & GENMASK(1, 0)) >> 0;
> +       loongson_spi->sper =3D (div_tmp & GENMASK(3, 2)) >> 2;
> +       val =3D loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG=
);
> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, (val =
&
> ~3) |
> +                              loongson_spi->spcr);
> +       val =3D loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPER_REG=
);
> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, (val =
&
> ~3) |
> +                              loongson_spi->sper);
> +       loongson_spi->hz =3D hz;
> +}
> +
> +static void loongson_spi_set_mode(struct loongson_spi *loongson_spi,
> +                                 struct spi_device *spi) {
> +       unsigned char val;
> +
> +       val =3D loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG=
);
> +       val &=3D ~(LOONGSON_SPI_SPCR_CPOL | LOONGSON_SPI_SPCR_CPHA);
> +       if (spi->mode & SPI_CPOL)
> +               val |=3D LOONGSON_SPI_SPCR_CPOL;
> +       if (spi->mode & SPI_CPHA)
> +               val |=3D LOONGSON_SPI_SPCR_CPHA;
> +
> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, val);
> +       loongson_spi->mode |=3D spi->mode; }
> +
> +static int loongson_spi_update_state(struct loongson_spi *loongson_spi,
> +                               struct spi_device *spi, struct
> +spi_transfer *t) {
> +       unsigned int hz;
> +
> +       if (t)
> +               hz =3D t->speed_hz;
> +
> +       if (hz && loongson_spi->hz !=3D hz)
> +               loongson_spi_set_clk(loongson_spi, hz);
> +
> +       if ((spi->mode ^ loongson_spi->mode) & SPI_MODE_X_MASK)
> +               loongson_spi_set_mode(loongson_spi, spi);
> +
> +       return 0;
> +}
> +
> +static int loongson_spi_setup(struct spi_device *spi) {
> +       struct loongson_spi *loongson_spi;
> +
> +       loongson_spi =3D spi_master_get_devdata(spi->master);
> +       if (spi->bits_per_word % 8)
> +               return -EINVAL;
> +
> +       if (spi->chip_select >=3D spi->master->num_chipselect)

Same here

Regards,
Amit

> +               return -EINVAL;
> +
> +       loongson_spi->hz =3D 0;
> +       loongson_spi_set_cs(spi, 1);
> +
> +       return 0;
> +}
> +
> +static int loongson_spi_write_read_8bit(struct spi_device *spi, const u8
> **tx_buf,
> +                                       u8 **rx_buf, unsigned int num) {
> +       struct loongson_spi *loongson_spi =3D
> +spi_master_get_devdata(spi->master);
> +
> +       if (tx_buf && *tx_buf)
> +               loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_RE=
G,
> *((*tx_buf)++));
> +       else
> +               loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_RE=
G,
> 0);
> +       readb_poll_timeout(loongson_spi->base + LOONGSON_SPI_SPSR_REG,
> loongson_spi->spsr,
> +                          (loongson_spi->spsr & 0x1) !=3D 1, 1,
> + MSEC_PER_SEC);
> +
> +       if (rx_buf && *rx_buf)
> +               *(*rx_buf)++ =3D loongson_spi_read_reg(loongson_spi,
> LOONGSON_SPI_FIFO_REG);
> +       else
> +               loongson_spi_read_reg(loongson_spi,
> + LOONGSON_SPI_FIFO_REG);
> +
> +       return 0;
> +}
> +
> +static unsigned int loongson_spi_write_read(struct spi_device *spi,
> +struct spi_transfer *xfer) {
> +       unsigned int count;
> +       const u8 *tx =3D xfer->tx_buf;
> +       u8 *rx =3D xfer->rx_buf;
> +
> +       count =3D xfer->len;
> +
> +       do {
> +               if (loongson_spi_write_read_8bit(spi, &tx, &rx, count) < =
0)
> +                       goto out;
> +               count--;
> +       } while (count);
> +
> +out:
> +       return xfer->len - count;
> +}
> +
> +static int loongson_spi_prepare_message(struct spi_controller *ctlr,
> +struct spi_message *m) {
> +       struct loongson_spi *loongson_spi =3D
> +spi_controller_get_devdata(ctlr);
> +
> +       loongson_spi->para =3D loongson_spi_read_reg(loongson_spi,
> LOONGSON_SPI_PARA_REG);
> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG,
> + loongson_spi->para & ~1);
> +
> +       return 0;
> +}
> +
> +static int loongson_spi_transfer_one(struct spi_controller *ctrl, struct
> spi_device *spi,
> +                                    struct spi_transfer *xfer) {
> +       struct loongson_spi *loongson_spi =3D
> +spi_master_get_devdata(spi->master);
> +
> +       loongson_spi_update_state(loongson_spi, spi, xfer);
> +       if (xfer->len)
> +               xfer->len =3D loongson_spi_write_read(spi, xfer);
> +
> +       return 0;
> +}
> +
> +static int loongson_spi_unprepare_message(struct spi_controller *ctrl,
> +struct spi_message *m) {
> +       struct loongson_spi *loongson_spi =3D
> +spi_controller_get_devdata(ctrl);
> +
> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG,
> + loongson_spi->para);
> +
> +       return 0;
> +}
> +
> +static void loongson_spi_reginit(struct loongson_spi *loongson_spi_dev)
> +{
> +       unsigned char val;
> +
> +       val =3D loongson_spi_read_reg(loongson_spi_dev,
> LOONGSON_SPI_SPCR_REG);
> +       val &=3D ~LOONGSON_SPI_SPCR_SPE;
> +       loongson_spi_write_reg(loongson_spi_dev, LOONGSON_SPI_SPCR_REG,
> + val);
> +
> +       loongson_spi_write_reg(loongson_spi_dev, LOONGSON_SPI_SPSR_REG,
> +                              (LOONGSON_SPI_SPSR_SPIF |
> + LOONGSON_SPI_SPSR_WCOL));
> +
> +       val =3D loongson_spi_read_reg(loongson_spi_dev,
> LOONGSON_SPI_SPCR_REG);
> +       val |=3D LOONGSON_SPI_SPCR_SPE;
> +       loongson_spi_write_reg(loongson_spi_dev, LOONGSON_SPI_SPCR_REG,
> +val); }
> +
> +int loongson_spi_init_master(struct device *dev, void __iomem *regs) {
> +       struct spi_master *master;
> +       struct loongson_spi *spi;
> +       struct clk *clk;
> +
> +       master =3D devm_spi_alloc_master(dev, sizeof(struct loongson_spi)=
);
> +       if (master =3D=3D NULL)
> +               return -ENOMEM;
> +
> +       master->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
> +       master->setup =3D loongson_spi_setup;
> +       master->prepare_message =3D loongson_spi_prepare_message;
> +       master->transfer_one =3D loongson_spi_transfer_one;
> +       master->unprepare_message =3D loongson_spi_unprepare_message;
> +       master->set_cs =3D loongson_spi_set_cs;
> +       master->num_chipselect =3D 4;
> +       device_set_node(&master->dev, dev_fwnode(dev));
> +       dev_set_drvdata(dev, master);
> +
> +       spi =3D spi_master_get_devdata(master);
> +       spi->base =3D regs;
> +       spi->master =3D master;
> +
> +       clk =3D devm_clk_get_optional(dev, NULL);
> +       if (!IS_ERR(clk))
> +               spi->clk_rate =3D clk_get_rate(clk);
> +       else
> +               return dev_err_probe(dev, PTR_ERR(clk), "unable to get
> + clock\n");
> +
> +       loongson_spi_reginit(spi);
> +
> +       spi->mode =3D 0;
> +
> +       return devm_spi_register_master(dev, master); }
> +EXPORT_SYMBOL_NS_GPL(loongson_spi_init_master,
> SPI_LOONGSON_CORE);
> +
> +static int __maybe_unused loongson_spi_suspend(struct device *dev) {
> +       struct loongson_spi *loongson_spi;
> +       struct spi_master *master;
> +
> +       master =3D dev_get_drvdata(dev);
> +       spi_master_suspend(master);
> +
> +       loongson_spi =3D spi_master_get_devdata(master);
> +
> +       loongson_spi->spcr =3D loongson_spi_read_reg(loongson_spi,
> LOONGSON_SPI_SPCR_REG);
> +       loongson_spi->sper =3D loongson_spi_read_reg(loongson_spi,
> LOONGSON_SPI_SPER_REG);
> +       loongson_spi->spsr =3D loongson_spi_read_reg(loongson_spi,
> LOONGSON_SPI_SPSR_REG);
> +       loongson_spi->para =3D loongson_spi_read_reg(loongson_spi,
> LOONGSON_SPI_PARA_REG);
> +       loongson_spi->sfcs =3D loongson_spi_read_reg(loongson_spi,
> LOONGSON_SPI_SFCS_REG);
> +       loongson_spi->timi =3D loongson_spi_read_reg(loongson_spi,
> + LOONGSON_SPI_TIMI_REG);
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused loongson_spi_resume(struct device *dev) {
> +       struct loongson_spi *loongson_spi;
> +       struct spi_master *master;
> +
> +       master =3D dev_get_drvdata(dev);
> +       loongson_spi =3D spi_master_get_devdata(master);
> +
> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG,
> loongson_spi->spcr);
> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG,
> loongson_spi->sper);
> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPSR_REG,
> loongson_spi->spsr);
> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG,
> loongson_spi->para);
> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SFCS_REG,
> loongson_spi->sfcs);
> +       loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_TIMI_REG,
> + loongson_spi->timi);
> +
> +       spi_master_resume(master);
> +
> +       return 0;
> +}
> +
> +const struct dev_pm_ops loongson_spi_dev_pm_ops =3D {
> +       .suspend =3D loongson_spi_suspend,
> +       .resume =3D loongson_spi_resume,
> +};
> +EXPORT_SYMBOL_NS_GPL(loongson_spi_dev_pm_ops,
> SPI_LOONGSON_CORE);
> +
> +MODULE_DESCRIPTION("Loongson SPI core driver");
> MODULE_LICENSE("GPL");
> diff --git a/drivers/spi/spi-loongson-pci.c b/drivers/spi/spi-loongson-pc=
i.c new
> file mode 100644 index 000000000000..c351a689150a
> --- /dev/null
> +++ b/drivers/spi/spi-loongson-pci.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// PCI interface driver for Loongson SPI Support // Copyright (C) 2023
> +Loongson Technology Corporation Limited
> +
> +#include <linux/pci.h>
> +
> +#include "spi-loongson.h"
> +
> +static int loongson_spi_pci_register(struct pci_dev *pdev,
> +                       const struct pci_device_id *ent) {
> +       int ret;
> +       void __iomem *reg_base;
> +       struct device *dev =3D &pdev->dev;
> +       int pci_bar =3D 0;
> +
> +       ret =3D pcim_enable_device(pdev);
> +       if (ret < 0)
> +               return dev_err_probe(dev, ret, "cannot enable pci
> + device\n");
> +
> +       ret =3D pcim_iomap_regions(pdev, BIT(pci_bar), pci_name(pdev));
> +       if (ret)
> +               return dev_err_probe(dev, ret, "failed to request and
> + remap memory\n");
> +
> +       reg_base =3D pcim_iomap_table(pdev)[pci_bar];
> +
> +       ret =3D loongson_spi_init_master(dev, reg_base);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "failed to initialize
> + master\n");
> +
> +       return 0;
> +}
> +
> +static void loongson_spi_pci_unregister(struct pci_dev *pdev) {
> +       pcim_iounmap_regions(pdev, BIT(0));
> +       pci_disable_device(pdev);
> +}
> +
> +static struct pci_device_id loongson_spi_devices[] =3D {
> +       { PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, 0x7a0b) },
> +       { PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, 0x7a1b) },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(pci, loongson_spi_devices);
> +
> +static struct pci_driver loongson_spi_pci_driver =3D {
> +       .name       =3D "loongson-spi-pci",
> +       .id_table   =3D loongson_spi_devices,
> +       .probe      =3D loongson_spi_pci_register,
> +       .remove     =3D loongson_spi_pci_unregister,
> +       .driver =3D {
> +               .bus =3D &pci_bus_type,
> +               .pm =3D &loongson_spi_dev_pm_ops,
> +       },
> +};
> +module_pci_driver(loongson_spi_pci_driver);
> +
> +MODULE_DESCRIPTION("Loongson spi pci driver"); MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(SPI_LOONGSON_CORE);
> diff --git a/drivers/spi/spi-loongson-plat.c b/drivers/spi/spi-loongson-p=
lat.c
> new file mode 100644 index 000000000000..2e0388d84044
> --- /dev/null
> +++ b/drivers/spi/spi-loongson-plat.c
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Platform driver for Loongson SPI Support // Copyright (C) 2023
> +Loongson Technology Corporation Limited
> +
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +#include "spi-loongson.h"
> +
> +static int loongson_spi_platform_probe(struct platform_device *pdev) {
> +       int ret;
> +       void __iomem *reg_base;
> +       struct device *dev =3D &pdev->dev;
> +
> +       reg_base =3D devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(reg_base))
> +               return PTR_ERR(reg_base);
> +
> +       ret =3D loongson_spi_init_master(dev, reg_base);
> +       if (ret)
> +               return dev_err_probe(dev, ret, "failed to initialize
> + master\n");
> +
> +       return ret;
> +}
> +
> +static const struct of_device_id loongson_spi_id_table[] =3D {
> +       { .compatible =3D "loongson,ls2k-spi" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, loongson_spi_id_table);
> +
> +static struct platform_driver loongson_spi_plat_driver =3D {
> +       .probe =3D loongson_spi_platform_probe,
> +       .driver =3D {
> +               .name   =3D "loongson-spi",
> +               .bus =3D &platform_bus_type,
> +               .pm =3D &loongson_spi_dev_pm_ops,
> +               .of_match_table =3D loongson_spi_id_table,
> +       },
> +};
> +module_platform_driver(loongson_spi_plat_driver);
> +
> +MODULE_DESCRIPTION("Loongson spi platform driver");
> +MODULE_LICENSE("GPL"); MODULE_IMPORT_NS(SPI_LOONGSON_CORE);
> diff --git a/drivers/spi/spi-loongson.h b/drivers/spi/spi-loongson.h new =
file
> mode 100644 index 000000000000..5dca9750efa3
> --- /dev/null
> +++ b/drivers/spi/spi-loongson.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/* Header File for Loongson SPI Driver. */
> +/* Copyright (C) 2023 Loongson Technology Corporation Limited */
> +
> +#ifndef __LINUX_SPI_LOONGSON_H
> +#define __LINUX_SPI_LOONGSON_H
> +
> +#include <linux/bits.h>
> +#include <linux/device.h>
> +#include <linux/pm.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +
> +#define        LOONGSON_SPI_SPCR_REG   0x00
> +#define        LOONGSON_SPI_SPSR_REG   0x01
> +#define        LOONGSON_SPI_FIFO_REG   0x02
> +#define        LOONGSON_SPI_SPER_REG   0x03
> +#define        LOONGSON_SPI_PARA_REG   0x04
> +#define        LOONGSON_SPI_SFCS_REG   0x05
> +#define        LOONGSON_SPI_TIMI_REG   0x06
> +
> +/* Bits definition for Loongson SPI register */
> +#define        LOONGSON_SPI_PARA_MEM_EN        BIT(0)
> +#define        LOONGSON_SPI_SPCR_CPHA  BIT(2)
> +#define        LOONGSON_SPI_SPCR_CPOL  BIT(3)
> +#define        LOONGSON_SPI_SPCR_SPE   BIT(6)
> +#define        LOONGSON_SPI_SPSR_WCOL  BIT(6)
> +#define        LOONGSON_SPI_SPSR_SPIF  BIT(7)
> +
> +struct loongson_spi {
> +       struct  spi_master      *master;
> +       void __iomem            *base;
> +       int                     cs_active;
> +       unsigned int            hz;
> +       unsigned char           spcr;
> +       unsigned char           sper;
> +       unsigned char           spsr;
> +       unsigned char           para;
> +       unsigned char           sfcs;
> +       unsigned char           timi;
> +       unsigned int            mode;
> +       u64                     clk_rate;
> +};
> +
> +int loongson_spi_init_master(struct device *dev, void __iomem *reg);
> +extern const struct dev_pm_ops loongson_spi_dev_pm_ops; #endif /*
> +__LINUX_SPI_LOONGSON_H */
> --
> 2.20.1

