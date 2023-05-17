Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7044070633E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjEQIqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjEQIqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:46:07 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2040.outbound.protection.outlook.com [40.107.13.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE38469A;
        Wed, 17 May 2023 01:46:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cXo9ji59i/oXrZiFPMz1+GUyi6LOoaBDfIvKpEJOfJCnXT0+Mn53Du8zgPh6nFQrm9C/gRc7XH7tYWSN0hqq72peZ4/USmM1KHG69ymPZ1GmywXXMOIvIxYtslSykbk0IWpXHooXnxAJzMANRq9HWiZGn+IgN3sV73mAGPJ3xJlHYKDAq6gPWZyzdy2N85JfmdiTePxGgrLjZgAQJCcrwG47vxP3M/TDN1U2CIYftgHjWZkMhv2gINK4JH83wfGqZX2RmhUAgm57D91bK6dygulm2Zi0N+SPRP5SUh20WvhqDMc3+zhqqc4uPmhc3ChGMRudQdLh80gzk5+do2gjuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hj94s4uF7DK0IUOKBrn4r76upeMkUyaLhHti3YpJIaY=;
 b=hl3PDmdNUbaOesJdgoTxy1af6u0UcbMzQJ5sieirSAaoOwuZRWmyY25deTMiZj0bTCaeYwgL8MXXVNB8TK9vRnt/PNystEFrVqPHV65S783+4X3ikrNr8MdaLUSKRvnZ5gsCyVLeBMm4jSZyzwZe+aa8cQdhJvAf8mNF76n+2yU65EW8maviKiNb/lKDkjYiRKQaL1OUzUEooy7f7MwBxlBrRu34rFdi24R48Qq5IGrSrGjJrjtu31ZXmZssL4044mZRUbIh1Cc8R6abycVluz9ugA5R+BNz0FL026KglZFWcoEp84a00zc4xxNRvBObI5XW/iVXaPmQMxXJRO9qzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hj94s4uF7DK0IUOKBrn4r76upeMkUyaLhHti3YpJIaY=;
 b=kGiSIYXbUElUNDJILwKIOmlE8v81ZpuU4cvVuhE9g1SD34kctKxrQ6noizQQ19ccDQoMzv8JanIKQmK5YIgtS0vcsp1XowPKTwNJXJzEN8tqEdNwK8DJtZLF1q7fDKU1SO4f/vLO+nmC7gL/iJXgzIYIq1vkIQcLnain2IxefsQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB9647.eurprd04.prod.outlook.com (2603:10a6:10:30b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 08:46:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b999:f2c6:a8cc:7b4%7]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 08:46:00 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 2/2] nvmem: imx: support i.MX93 OCOTP
Thread-Topic: [PATCH V2 2/2] nvmem: imx: support i.MX93 OCOTP
Thread-Index: AQHZgaIRKwK+vOLcnU21oFKnZUVGfa9eNGyg
Date:   Wed, 17 May 2023 08:46:00 +0000
Message-ID: <DU0PR04MB94170540FC26F004372C38D0887E9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230508114639.1525521-1-peng.fan@oss.nxp.com>
 <20230508114639.1525521-2-peng.fan@oss.nxp.com>
In-Reply-To: <20230508114639.1525521-2-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB9PR04MB9647:EE_
x-ms-office365-filtering-correlation-id: 86ea2c3b-1737-4a6d-bbcc-08db56b323f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jXpxe/P2dSlDwqITodz/oSfF3K/eN2IcCxQ/rcPtEyBeUFAv/H9MhehgtZW3iakZrAMda3MBI+r/X7oolz7WjMO81evr4lh09s0AnGbm60q3zrgQOZ9EYGIGC2UyDDZZiulM0o25BnhMmUA1zugnq8xyr4ihznCkA8ky8AeUvgYLRIQregdhTNEgM1UENEt8HV52K3gfhuH9bU++clGQSz9JcedB/nlcAOECBqO94NEifJcC4c7B8veWlRdyQPg5oGIHG8dR70CBget5Aalk8M5Fa0zULOPA7ik1B5sNSuvrene7MrNVspiXe7YdxHau0op5uXN+uHYMYT61AMvy6tcuu1J3SV0yz1d3k8U9341IkbmAXgPqlO72PsMKwsjnEVqgyxjPMnZDirvD4XMPNpZYbjZSkgz1Z4vl15sBHqa6mDWcwf7g6sMb8SsWwXTSuBy+LlKiP422IFj3h5Wt2fhN54FqM1M0BcRnbfkR++WZIGi9tvRtwwJVm8kGXP7hlrMhD71ZyWIoo1RbpZPI0EtPGVu7TikmufOSPLnl7ReUXVlFNFv1MsC+SeWkP/xRR3s/uRz/Lo9w8xCKEBLhBCVH/qGtPmuSrwnrmvCZGKghvSOrbdz89viRrFwXop3O
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199021)(76116006)(66556008)(66476007)(66446008)(64756008)(66946007)(5660300002)(52536014)(8936002)(8676002)(54906003)(110136005)(478600001)(4326008)(316002)(41300700001)(7696005)(71200400001)(122000001)(55016003)(38100700002)(38070700005)(83380400001)(86362001)(9686003)(6506007)(44832011)(7416002)(186003)(33656002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gsUZmg0xXucFBz7UP7KHx2QodMoCXvkKBKt2TXL4bxBITKJ4/KQJpVdmxcEr?=
 =?us-ascii?Q?ulXyjtevixgIxzYcZE0UgEJPMWTe8UfwgNxSuNJcJF4n5uDNzA2HtWS9sEsu?=
 =?us-ascii?Q?CyaUNVP9i/bO4n2HOzUzMguZ+zLeIqHYeAkPh4rzopSMIdFRv9gJ8aCvd0K8?=
 =?us-ascii?Q?T8cbwCLb4HTeP6a7i/Jbju2julhdE7mcXC9XWiQ7aX3Bz9hR1M6+5erIZ+Ui?=
 =?us-ascii?Q?m6AClU8cjhzhGOx56F+6LGv9rPfHem9vVUxEJjQ6yr71OckZpGR3C6ceG0xp?=
 =?us-ascii?Q?fpV2E2R3W2oEvfv9cLyMte0C950Z1Kbe5RrLBKCSupLDViiYNcecMRGOQt5t?=
 =?us-ascii?Q?qwSX5i7QXPGnL1d9s/h0OvVr07zIVYXxuvsRScZFT2ZIzBlzrtf/Cg3ACaIw?=
 =?us-ascii?Q?EZMSsFPi21kBVUT6S62/6vwXL+MLCYq2RiSrpk5timajd92amn8bOt7wSmXQ?=
 =?us-ascii?Q?vD4RMWn806D6Jzf+spEYLoQV7/he47GaZKMSZeF+zhGqk5saotL+Cqg8UJqi?=
 =?us-ascii?Q?l/szqtoaiJXgFtCw6oFXN1pws4x+A2SSJ0NQbNDf7tnpr3QKDedLBGscPa5B?=
 =?us-ascii?Q?bEIG1obib06Tg4JgcQupmnrO2IP+1AIaKV/AFx2IbVgvo/PGOHwFw1wTeJ99?=
 =?us-ascii?Q?jETSvwOZkWE9/bWP6PXbYwZCHaY5BgSmGwG2+JF4KZAMMKl+9uHLrtPqgOKF?=
 =?us-ascii?Q?iPZmxv//VlgdNrvkq5ZoYZmRrPrynE10wCtwnuL2N7iyX06Xw7acOhYZp2RD?=
 =?us-ascii?Q?QbL51Dem2NWwo5USYcEFRqDpUcvdm3ZFtCpzVUVBEYSr5I28MxJfNOghxyC5?=
 =?us-ascii?Q?4e9b/OzHqL2no6Y/KfatIx6V1s401kDtIYJwbx8WZgiPJcWaCIwSqs96lI72?=
 =?us-ascii?Q?TYS2zFfEMMczeFkpXbEjlgaBZ9A7+vfEXNmAg+hFrSI4qV0Zcy00JiIVLEiI?=
 =?us-ascii?Q?3HfgAjObNn3ad5xFe16N0F417yIs9Yo32bFLvSMoeVHX9sc62+0pTBjiYTh0?=
 =?us-ascii?Q?ntB5jeyMNkN/BKO3hcoo/e+D9LN5B7Ww/i6Xr2Fc4eT7HeBeYGQLQCgU6DtJ?=
 =?us-ascii?Q?oAnx3KR5aOVm2HeRd5HzCe/+C3G0zoTqnXCxf13Uo+tTAD5fJD25Lw9m8BYb?=
 =?us-ascii?Q?+iZzinCBR1hzJx5kTZgVojgXWkkX4s8qNcLs2vaxX7vHk/CEQ7wHCixXe2HG?=
 =?us-ascii?Q?JO6WswOt5KGptXhiW35n0/zlYkuaVyUSqg7jaMlT2e8fKG4bIMcGNjin9RG6?=
 =?us-ascii?Q?46QoP3D/SnGRJjR6GTkZ5GR2kPsAcaOqMtOBdfQ1ERHXzOyLHJmnMNanXuMn?=
 =?us-ascii?Q?2vwtzrRvKMypX6gGF+39aASPi3+BhM9yhbYmSW5X7I9Nsu4IJjCNrCNuGScJ?=
 =?us-ascii?Q?WomBP4UGZiKq1iX9qVePCQ/8lRZ2zaM3J6bwYt9oE2srT0/BbCpETqRXQi3k?=
 =?us-ascii?Q?S45JNKxx4+BQkGO/oD9w8ad17lr8tC0yV4oTaaNcUfSwD7uTyYeSnlr9B6oV?=
 =?us-ascii?Q?X7JIT9ipYHdkaa/wZx29mb1kmDs0wSZ7+YmCWDGXQd9V5gcgcV9iBfR1hA?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ea2c3b-1737-4a6d-bbcc-08db56b323f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 08:46:00.4874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DceJ/7UluvXSeKcWmgNfkJ9TrH2ytN5MD5l7hmt1MzhEn1Sz81s7STnv5H92iJOBhouEFuOi06qGolVJj2ZrpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9647
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas

> Subject: [PATCH V2 2/2] nvmem: imx: support i.MX93 OCOTP

The patch v2 1/2 has got R-b from DT maintainers. Are you fine with=20
Patch v2 2/2?

Thanks,
Peng.
>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Add i.MX93 OCOTP support. i.MX93 OCOTP has two parts: Fuse shadow
> block(fsb) and fuse managed by ELE. The FSB part could be directly access=
ed
> with MMIO, the ELE could only be accessed with ELE API.
>=20
> Currently the ELE API is not ready, so NULL function callback is used, bu=
t it
> was tested with downstream ELE API.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>=20
> V2:
>  Merge ele & fsb compatible to use fsl,imx93-ocotp
>=20
>  drivers/nvmem/Kconfig         |   9 ++
>  drivers/nvmem/Makefile        |   2 +
>  drivers/nvmem/imx-ocotp-ele.c | 175
> ++++++++++++++++++++++++++++++++++
>  3 files changed, 186 insertions(+)
>  create mode 100644 drivers/nvmem/imx-ocotp-ele.c
>=20
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig index
> b291b27048c7..e7093726b28e 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -82,6 +82,15 @@ config NVMEM_IMX_OCOTP
>  	  This driver can also be built as a module. If so, the module
>  	  will be called nvmem-imx-ocotp.
>=20
> +config NVMEM_IMX_OCOTP_ELE
> +	tristate "i.MX On-Chip OTP Controller support"
> +	depends on ARCH_MXC || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	depends on OF
> +	help
> +	  This is a driver for the On-Chip OTP Controller (OCOTP)
> +	  available on i.MX SoCs which has ELE.
> +
>  config NVMEM_IMX_OCOTP_SCU
>  	tristate "i.MX8 SCU On-Chip OTP Controller support"
>  	depends on IMX_SCU
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile index
> f82431ec8aef..cc23ce4ffb1f 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -18,6 +18,8 @@ obj-$(CONFIG_NVMEM_IMX_IIM)		+=3D
> nvmem-imx-iim.o
>  nvmem-imx-iim-y				:=3D imx-iim.o
>  obj-$(CONFIG_NVMEM_IMX_OCOTP)		+=3D nvmem-imx-ocotp.o
>  nvmem-imx-ocotp-y			:=3D imx-ocotp.o
> +obj-$(CONFIG_NVMEM_IMX_OCOTP_ELE)	+=3D nvmem-imx-ocotp-ele.o
> +nvmem-imx-ocotp-ele-y			:=3D imx-ocotp-ele.o
>  obj-$(CONFIG_NVMEM_IMX_OCOTP_SCU)	+=3D nvmem-imx-ocotp-scu.o
>  nvmem-imx-ocotp-scu-y			:=3D imx-ocotp-scu.o
>  obj-$(CONFIG_NVMEM_JZ4780_EFUSE)	+=3D nvmem_jz4780_efuse.o
> diff --git a/drivers/nvmem/imx-ocotp-ele.c b/drivers/nvmem/imx-ocotp-
> ele.c new file mode 100644 index 000000000000..af9ce0ce4792
> --- /dev/null
> +++ b/drivers/nvmem/imx-ocotp-ele.c
> @@ -0,0 +1,175 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * i.MX9 OCOTP fusebox driver
> + *
> + * Copyright 2023 NXP
> + */
> +
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +enum fuse_type {
> +	FUSE_FSB =3D 1,
> +	FUSE_ELE =3D 2,
> +	FUSE_INVALID =3D -1
> +};
> +
> +struct ocotp_map_entry {
> +	u32 start; /* start word */
> +	u32 num; /* num words */
> +	enum fuse_type type;
> +};
> +
> +struct ocotp_devtype_data {
> +	u32 reg_off;
> +	char *name;
> +	u32 size;
> +	u32 num_entry;
> +	u32 flag;
> +	nvmem_reg_read_t reg_read;
> +	struct ocotp_map_entry entry[];
> +};
> +
> +struct imx_ocotp_priv {
> +	struct device *dev;
> +	void __iomem *base;
> +	struct nvmem_config config;
> +	struct mutex lock;
> +	const struct ocotp_devtype_data *data; };
> +
> +static enum fuse_type imx_ocotp_fuse_type(void *context, u32 index) {
> +	struct imx_ocotp_priv *priv =3D context;
> +	const struct ocotp_devtype_data *data =3D priv->data;
> +	u32 start, end;
> +	int i;
> +
> +	for (i =3D 0; i < data->num_entry; i++) {
> +		start =3D data->entry[i].start;
> +		end =3D data->entry[i].start + data->entry[i].num;
> +
> +		if (index >=3D start && index < end)
> +			return data->entry[i].type;
> +	}
> +
> +	return FUSE_INVALID;
> +}
> +
> +static int imx_ocotp_reg_read(void *context, unsigned int offset, void
> +*val, size_t bytes) {
> +	struct imx_ocotp_priv *priv =3D context;
> +	void __iomem *reg =3D priv->base + priv->data->reg_off;
> +	u32 count, index, num_bytes;
> +	enum fuse_type type;
> +	u32 *buf;
> +	void *p;
> +	int i;
> +
> +	index =3D offset;
> +	num_bytes =3D round_up(bytes, 4);
> +	count =3D num_bytes >> 2;
> +
> +	if (count > ((priv->data->size >> 2) - index))
> +		count =3D (priv->data->size >> 2) - index;
> +
> +	p =3D kzalloc(num_bytes, GFP_KERNEL);
> +	if (!p)
> +		return -ENOMEM;
> +
> +	mutex_lock(&priv->lock);
> +
> +	buf =3D p;
> +
> +	for (i =3D index; i < (index + count); i++) {
> +		type =3D imx_ocotp_fuse_type(context, i);
> +		if (type =3D=3D FUSE_INVALID || type =3D=3D FUSE_ELE) {
> +			*buf++ =3D 0;
> +			continue;
> +		}
> +
> +		*buf++ =3D readl_relaxed(reg + (i << 2));
> +	}
> +
> +	memcpy(val, (u8 *)p, bytes);
> +
> +	mutex_unlock(&priv->lock);
> +
> +	kfree(p);
> +
> +	return 0;
> +};
> +
> +static int imx_ele_ocotp_probe(struct platform_device *pdev) {
> +	struct device *dev =3D &pdev->dev;
> +	struct imx_ocotp_priv *priv;
> +	struct nvmem_device *nvmem;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->data =3D of_device_get_match_data(dev);
> +
> +	priv->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	priv->config.dev =3D dev;
> +	priv->config.name =3D "ELE-OCOTP";
> +	priv->config.id =3D NVMEM_DEVID_AUTO;
> +	priv->config.owner =3D THIS_MODULE;
> +	priv->config.size =3D priv->data->size;
> +	priv->config.reg_read =3D priv->data->reg_read;
> +	priv->config.word_size =3D 4;
> +	priv->config.stride =3D 1;
> +	priv->config.priv =3D priv;
> +	priv->config.read_only =3D true;
> +	mutex_init(&priv->lock);
> +
> +	nvmem =3D devm_nvmem_register(dev, &priv->config);
> +	if (IS_ERR(nvmem))
> +		return PTR_ERR(nvmem);
> +
> +	return 0;
> +}
> +
> +static const struct ocotp_devtype_data imx93_ocotp_data =3D {
> +	.reg_off =3D 0x8000,
> +	.reg_read =3D imx_ocotp_reg_read,
> +	.size =3D 2048,
> +	.num_entry =3D 6,
> +	.entry =3D {
> +		{ 0, 52, FUSE_FSB },
> +		{ 63, 1, FUSE_ELE},
> +		{ 128, 16, FUSE_ELE },
> +		{ 182, 1, FUSE_ELE },
> +		{ 188, 1, FUSE_ELE },
> +		{ 312, 200, FUSE_FSB }
> +	},
> +};
> +
> +static const struct of_device_id imx_ele_ocotp_dt_ids[] =3D {
> +	{ .compatible =3D "fsl,imx93-ocotp", .data =3D &imx93_ocotp_data, },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, imx_ele_ocotp_dt_ids);
> +
> +static struct platform_driver imx_ele_ocotp_driver =3D {
> +	.driver =3D {
> +		.name =3D "imx_ele_ocotp",
> +		.of_match_table =3D imx_ele_ocotp_dt_ids,
> +	},
> +	.probe =3D imx_ele_ocotp_probe,
> +};
> +module_platform_driver(imx_ele_ocotp_driver);
> +
> +MODULE_DESCRIPTION("i.MX OCOTP/ELE driver");
> MODULE_AUTHOR("Peng Fan
> +<peng.fan@nxp.com>"); MODULE_LICENSE("GPL");
> --
> 2.37.1

