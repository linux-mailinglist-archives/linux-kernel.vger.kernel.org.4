Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CFF73D355
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 21:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjFYTi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 15:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjFYTiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 15:38:23 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77AE127;
        Sun, 25 Jun 2023 12:38:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4dmip88Azsn7allXjsZnSseV9u9kH5hKE4GekNMHYz2gKq31HvsZSEXQ6VX2hcJFoi28cGc1qcZ08vpG8nDe5rv9cfnRctZLVvuKcN4AhtlFZydhvfUmgUDizE+wIJ2OdHfqV4MA1B9qmsszmU+MDalQOCW2JUA1hSzgw/ggelUNVpkriTy0YUVQ76V6XLnF0z07b72KdOZX7rXx1lMNMnDUlJg/tgXfbVv2fdMKIoWjadBJVrzZVYQY/IyqJIu/UVKIU91Owm1ZCKESIxhT+crhQvZDYyY5iEhMXDnhlPA1DB4+0EMiooP+aTsGtWKvbCTpus1fG6NGf+DjNkNqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+uf57z3virbR+bXRHJoh6ZGTQtFCRCrv+WsIa8Hu7o=;
 b=EQ+6qiSyOfgZhjtoRbGypb6EAm1g6SvMBpCkputWZNvvGuhQCSjFgJaay0y0yNaLUcRMyRxmK14l6HxGJi0lO/D3gNRhPQDeMoeCT/9J//IH8FBd6yMb8heHOVYxjoHNe7rDm1l2eYEb7Am6GJvM0tTAoCFkFTQA+lMQAecKaeEfmn24v2MZHK777UJ7lgmIRZIqkB11RdsRZCRBPLI9tzdbW02HTxNb3l7RxP0ZcH1BwawqMZYzO8XfSuF/Qp7YyLh4jiRJ1LTXFJfXyjN53tfq4+ca9Mxouo6IrdVbW0uY8ux6rhmzCf22MNssAOiVmj3h/ZcRGcyU8nWejqysjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=labundy.com; dmarc=pass action=none header.from=labundy.com;
 dkim=pass header.d=labundy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NETORG5796793.onmicrosoft.com; s=selector1-NETORG5796793-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+uf57z3virbR+bXRHJoh6ZGTQtFCRCrv+WsIa8Hu7o=;
 b=d2U4m103RDeSPFyHfysYlBMaNX7ignRDNc+Vq0hyzjLancbRTiSlJM4BFbEPcqUwlf+LwHjqNHZx09+PqmT5IKbH0VTslE7iaQ9IoXQryYBqe3HApXPYVty84JG9qAWhy5tzWFou2OmAXDvLUEFNrEcVAJmraEt0GXvhsLdPkvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=labundy.com;
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21) by SA1PR08MB7133.namprd08.prod.outlook.com
 (2603:10b6:806:187::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sun, 25 Jun
 2023 19:38:17 +0000
Received: from SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::b94e:6032:56d4:35b2]) by SN4PR0801MB3774.namprd08.prod.outlook.com
 ([fe80::b94e:6032:56d4:35b2%6]) with mapi id 15.20.6521.024; Sun, 25 Jun 2023
 19:38:17 +0000
Date:   Sun, 25 Jun 2023 14:38:10 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] input: touchscreen: add SPI support for Goodix
 Berlin Touchscreen IC
Message-ID: <ZJiXopmFr4dPbqll@nixie71>
References: <20230606-topic-goodix-berlin-upstream-initial-v3-0-f0577cead709@linaro.org>
 <20230606-topic-goodix-berlin-upstream-initial-v3-4-f0577cead709@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606-topic-goodix-berlin-upstream-initial-v3-4-f0577cead709@linaro.org>
X-ClientProxiedBy: DS7PR03CA0038.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::13) To SN4PR0801MB3774.namprd08.prod.outlook.com
 (2603:10b6:803:43::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR0801MB3774:EE_|SA1PR08MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ec54ef-8d3c-4895-fae6-08db75b3b900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WMzD9KVMd/RV60FkvtKmIZnQwc1uz08a5R9XUg8UCu1BowsEU+W97z0KS8WXSe8nNJZJcv+d/Nl2PU8WQ/2uFeQRgVfQ3fyPM8d5EChOk8l5knLhciTgfIZgVKZ2+g0ORVMBheG3/oaexKv259u6Rk773qjJeVRHNbAjmlazTYdAaMZ1Eq22pM/18NkUScoHP/rmhSPEnLLhcCgaHxt7ZibZnnZ7mb4IebFZ/N7e40CL2dtfqd99D6oP/6tQLvU9UjkUE7Oja9Rq2QbBtXQTMXgGo6tVU3khtfbDiMvenanSuJrf6I2XAF8HL+hZmgljnYzEMOXOT6RmeDeq0OQBTobruUq8EacyJmhEfXYTjyh0P2g/hSVvJZ8rNxPXVXJmE2q29tAzo/m+Vk7zWWKxDsnFuy1MojSC8hU5X97GjmSFvUCHAs67KxbqpoKkR0trXtGIkZSzgyKcm9frUPRloKFg+34+lMHD4QlWs+9Jp+digmX8mZqc3q30U9XVY8LbpZvjGBrxkDXveqVIz+GiEhLs7fEksVxUhaJmNVngU9I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0801MB3774.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(376002)(136003)(346002)(39830400003)(396003)(451199021)(5660300002)(7416002)(33716001)(6916009)(8936002)(8676002)(41300700001)(86362001)(66556008)(66476007)(38100700002)(4326008)(316002)(66946007)(966005)(6506007)(9686003)(26005)(6512007)(2906002)(186003)(478600001)(6666004)(83380400001)(54906003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1d1ze/Bo6BO4DlEzw7lGBmRuY8qtX7Fco6H0YCnctrYn5W3a00qFeBhqTBDe?=
 =?us-ascii?Q?FPCHE1yi7dZl/CzBSGslpWXhmTtwrSPtUy2C6sf44vLTa/z4KlAvhdAuZDr3?=
 =?us-ascii?Q?pIFnGwAA89fBZPXH2hQxWKUiKlCsbPnsz3vAmt+TjTw1otSEIgLvs3/odQcZ?=
 =?us-ascii?Q?khsbVqijfLBdUu4FXU+hlamJBFCNinLzaMAqUQRrtcEL0Cz4NJy+K5o1Y5RP?=
 =?us-ascii?Q?+GX5M/PR6j+vs4NMaBPr0I8pLdzbIlUaETfBk4WWEc5cD/LjzOKWLSKQwVeX?=
 =?us-ascii?Q?3XJdLdJ7X8EBWa11SVgDq01O4Z0csoNmg/jUh81ouY2fOMde3/F4CKbZE5y4?=
 =?us-ascii?Q?gcA4ltKE6d1LQmZXcPzjskH2Y5d71dRnFD9ewvWS7T62J3EzMAhFShDGYyjY?=
 =?us-ascii?Q?vNcrQab6yzmEPOrAVB6maaBNeZmlWY89qcxdsgZItSx55cr/X4D1tY+suItn?=
 =?us-ascii?Q?CUQKCrCRzNE8ZCPL+UO5BS9BwTmdxco+UHuE28vkFRJ5Wdfs2yqa6N2ciI6U?=
 =?us-ascii?Q?GIJpNxxVeAWYwK4+K8SJpTy/rk006A1K0rclTY4tyIj6KMrERPlJrlDiJ89K?=
 =?us-ascii?Q?6VaEy3gWnLU2q8LG95QTwnpinC/s6cc2990Y0SvdTpEVE3uAHgcStWzfAUt2?=
 =?us-ascii?Q?OBF2DSg2Uk7UzT4P7J7A2loBX5cuEvV23TNL2cVw6Pk1wf0iHEIeyDRhJMje?=
 =?us-ascii?Q?Sc57XOQDds5h8kNGHhb+aGPg3gUrRGi9fQwSPuXN08TQCZ0ZPMDDc0tcu6Ga?=
 =?us-ascii?Q?46UGXhkCaVUOPnnRkRO8W4Yx3x0WXIZgDuh9ou3N0b5WY8lUiJfq80ayo0XX?=
 =?us-ascii?Q?GVTbjjoctSFnizSH56INJotYJ2CbW0M2ZkIPW0Ztjl9P3mV6+3vSpIJBljA7?=
 =?us-ascii?Q?y2AzWthnM2naFIa7xZoxrBHS5yHhzFn+wjkHaKucGplHOV7nln8gb4D+CZdv?=
 =?us-ascii?Q?nlY7L8y8I/yiLJXy0G4E+dZapx2ZIF4UZn6mq3zA0u0fnAZZX1lV5WJlTgfa?=
 =?us-ascii?Q?khsJxIgrnFFFML+DqSBGEqjsJ5PPUnC+s2i3fR2FTZu24yGZK8CMZGSEM+jp?=
 =?us-ascii?Q?qszc/PexmHuZsYUMWqkS/ZK9l+b0VkNeP69Yn9ksmlwkhWlocURrCdSkOVBo?=
 =?us-ascii?Q?UxlN6KUmYR6tftdyj5bgwyJcJjMm0mV3S3WCAYcHoJh9y8lcXFkPqr1VJlTc?=
 =?us-ascii?Q?Vg8sEvZJ4YIR2rMW7doOLhVoYD3F7LDiozgDvM/bWR0z3k/DkBNUHr6WSPYp?=
 =?us-ascii?Q?INwg1z5GzGujWEVLiZGe1xydlJRV4GsfDVdeYxvuMxuElb01OeIo4C0g5w/E?=
 =?us-ascii?Q?uinUkcyX9lo/i5nD+ZvjmF6dO4qc32aKbCJt4vrMIUc/CepG6GDl+cLq9D60?=
 =?us-ascii?Q?HNByvJpYJAMwcxVUO9cTEEb5nSzY85dA8V8zTMG1kxdMwRE+pGw1ixpOO4Lu?=
 =?us-ascii?Q?KR65mKHB0KO9XXL9uAKzyVERv7B62Af9QdB4k3maWjpc25kcnCKcUuW/9czz?=
 =?us-ascii?Q?LDPWGYtXM8NVh2KlEje528otJRxZazkBUnzNuajgSjVtFgpZZWMbmmX53yJA?=
 =?us-ascii?Q?HJ9hEFGeb98rIOxr26WMmt0UVGaM3rqB0zxDtoib?=
X-OriginatorOrg: labundy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ec54ef-8d3c-4895-fae6-08db75b3b900
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0801MB3774.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 19:38:16.9626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00b69d09-acab-4585-aca7-8fb7c6323e6f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KBvooQ+ExT9DvCeFINP1/SVyc7Z9nRqHdTNi3k6t5EPG0hcI6n8uZvGSb6RCGBsFqNjN51lMb9mZVrRecu6zGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR08MB7133
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Thu, Jun 22, 2023 at 04:29:02PM +0200, Neil Armstrong wrote:
> Add initial support for the new Goodix "Berlin" touchscreen ICs
> over the SPI interface.
> 
> The driver doesn't use the regmap_spi code since the SPI messages
> needs to be prefixed, thus this custom regmap code.
> 
> This initial driver is derived from the Goodix goodix_ts_berlin
> available at [1] and [2] and only supports the GT9916 IC
> present on the Qualcomm SM8550 MTP & QRD touch panel.
> 
> The current implementation only supports BerlinD, aka GT9916.
> 
> [1] https://github.com/goodix/goodix_ts_berlin
> [2] https://git.codelinaro.org/clo/la/platform/vendor/opensource/touch-drivers
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Just a few comments below, then feel free to add:

Reviewed-by: Jeff LaBundy <jeff@labundy.com>

>  drivers/input/touchscreen/Kconfig             |  13 ++
>  drivers/input/touchscreen/Makefile            |   1 +
>  drivers/input/touchscreen/goodix_berlin_spi.c | 172 ++++++++++++++++++++++++++
>  3 files changed, 186 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 5e21cca6025d..2d86615e5090 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -435,6 +435,19 @@ config TOUCHSCREEN_GOODIX_BERLIN_I2C
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called goodix_berlin_i2c.
>  
> +config TOUCHSCREEN_GOODIX_BERLIN_SPI
> +	tristate "Goodix Berlin SPI touchscreen"
> +	depends on SPI_MASTER

select REGMAP

(keep "depends on SPI_MASTER")

> +	select TOUCHSCREEN_GOODIX_BERLIN_CORE
> +	help
> +	  Say Y here if you have a Goodix Berlin IC connected to
> +	  your system via SPI.
> +
> +	  If unsure, say N.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called goodix_berlin_spi.
> +
>  config TOUCHSCREEN_HIDEEP
>  	tristate "HiDeep Touch IC"
>  	depends on I2C
> diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> index 921a2da0c2be..29524e8a83db 100644
> --- a/drivers/input/touchscreen/Makefile
> +++ b/drivers/input/touchscreen/Makefile
> @@ -49,6 +49,7 @@ obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix_ts.o
>  obj-$(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_CORE)	+= goodix_berlin_core.o
>  obj-$(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_I2C)	+= goodix_berlin_i2c.o
> +obj-$(CONFIG_TOUCHSCREEN_GOODIX_BERLIN_SPI)	+= goodix_berlin_spi.o
>  obj-$(CONFIG_TOUCHSCREEN_HIDEEP)	+= hideep.o
>  obj-$(CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX)	+= hynitron_cstxxx.o
>  obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+= ili210x.o
> diff --git a/drivers/input/touchscreen/goodix_berlin_spi.c b/drivers/input/touchscreen/goodix_berlin_spi.c
> new file mode 100644
> index 000000000000..3a1bc251b32d
> --- /dev/null
> +++ b/drivers/input/touchscreen/goodix_berlin_spi.c
> @@ -0,0 +1,172 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Goodix Berlin Touchscreen Driver
> + *
> + * Copyright (C) 2020 - 2021 Goodix, Inc.
> + * Copyright (C) 2023 Linaro Ltd.
> + *
> + * Based on goodix_ts_berlin driver.
> + */
> +#include <asm/unaligned.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +#include "goodix_berlin.h"
> +
> +#define SPI_TRANS_PREFIX_LEN	1
> +#define REGISTER_WIDTH		4
> +#define SPI_READ_DUMMY_LEN	3
> +#define SPI_READ_PREFIX_LEN	(SPI_TRANS_PREFIX_LEN + REGISTER_WIDTH + SPI_READ_DUMMY_LEN)
> +#define SPI_WRITE_PREFIX_LEN	(SPI_TRANS_PREFIX_LEN + REGISTER_WIDTH)
> +
> +#define SPI_WRITE_FLAG		0xF0
> +#define SPI_READ_FLAG		0xF1

Please namespace all of these as you have done in the core driver.

> +
> +static int goodix_berlin_spi_read(void *context, const void *reg_buf,
> +				  size_t reg_size, void *val_buf,
> +				  size_t val_size)
> +{
> +	struct spi_device *spi = context;
> +	struct spi_transfer xfers;
> +	struct spi_message spi_msg;
> +	const u32 *reg = reg_buf; /* reg is stored as native u32 at start of buffer */
> +	u8 *buf;
> +	int ret;

	int error;

> +
> +	if (reg_size != REGISTER_WIDTH)
> +		return -EINVAL;
> +
> +	buf = kzalloc(SPI_READ_PREFIX_LEN + val_size, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	spi_message_init(&spi_msg);
> +	memset(&xfers, 0, sizeof(xfers));
> +
> +	/* buffer format: 0xF1 + addr(4bytes) + dummy(3bytes) + data */
> +	buf[0] = SPI_READ_FLAG;
> +	put_unaligned_be32(*reg, buf + SPI_TRANS_PREFIX_LEN);
> +	memset(buf + SPI_TRANS_PREFIX_LEN + REGISTER_WIDTH, 0xff,
> +	       SPI_READ_DUMMY_LEN);
> +
> +	xfers.tx_buf = buf;
> +	xfers.rx_buf = buf;
> +	xfers.len = SPI_READ_PREFIX_LEN + val_size;
> +	xfers.cs_change = 0;
> +	spi_message_add_tail(&xfers, &spi_msg);
> +
> +	ret = spi_sync(spi, &spi_msg);

	error = spi_sync(...);

> +	if (ret < 0)

	if (error)

> +		dev_err(&spi->dev, "transfer error:%d", ret);
> +	else
> +		memcpy(val_buf, buf + SPI_READ_PREFIX_LEN, val_size);
> +
> +	kfree(buf);
> +	return ret;
> +}
> +
> +static int goodix_berlin_spi_write(void *context, const void *data,
> +				   size_t count)
> +{
> +	unsigned int len = count - REGISTER_WIDTH;
> +	struct spi_device *spi = context;
> +	struct spi_transfer xfers;
> +	struct spi_message spi_msg;
> +	const u32 *reg = data; /* reg is stored as native u32 at start of buffer */
> +	u8 *buf;
> +	int ret;

Same comments here regarding 'error' vs. 'ret'.

> +
> +	buf = kzalloc(SPI_WRITE_PREFIX_LEN + len, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	spi_message_init(&spi_msg);
> +	memset(&xfers, 0, sizeof(xfers));
> +
> +	buf[0] = SPI_WRITE_FLAG;
> +	put_unaligned_be32(*reg, buf + SPI_TRANS_PREFIX_LEN);
> +	memcpy(buf + SPI_WRITE_PREFIX_LEN, data + REGISTER_WIDTH, len);
> +
> +	xfers.tx_buf = buf;
> +	xfers.len = SPI_WRITE_PREFIX_LEN + len;
> +	xfers.cs_change = 0;
> +	spi_message_add_tail(&xfers, &spi_msg);
> +
> +	ret = spi_sync(spi, &spi_msg);
> +	if (ret < 0)
> +		dev_err(&spi->dev, "transfer error:%d", ret);
> +
> +	kfree(buf);
> +	return ret;
> +}
> +
> +static const struct regmap_config goodix_berlin_spi_regmap_conf = {
> +	.reg_bits = 32,
> +	.val_bits = 8,
> +	.read = goodix_berlin_spi_read,
> +	.write = goodix_berlin_spi_write,
> +};
> +
> +/* vendor & product left unassigned here, should probably be updated from fw info */
> +static const struct input_id goodix_berlin_spi_input_id = {
> +	.bustype = BUS_SPI,
> +};
> +
> +static int goodix_berlin_spi_probe(struct spi_device *spi)
> +{
> +	struct regmap_config *regmap_config;
> +	struct regmap *regmap;
> +	size_t max_size;
> +	int error = 0;
> +
> +	regmap_config = devm_kmemdup(&spi->dev, &goodix_berlin_spi_regmap_conf,
> +				     sizeof(*regmap_config), GFP_KERNEL);
> +	if (!regmap_config)
> +		return -ENOMEM;

Is there any reason we cannot simply pass goodix_berlin_spi_regmap_conf to
devm_regmap_init() below? Why to duplicate and pass the copy?

For reference, BMP280 in IIO is a similar example of a device with regmap
sitting atop a bespoke SPI protocol; it does not seem to take this extra
step.

> +
> +	spi->mode = SPI_MODE_0;
> +	spi->bits_per_word = 8;
> +	error = spi_setup(spi);
> +	if (error)
> +		return error;
> +
> +	max_size = spi_max_transfer_size(spi);
> +	regmap_config->max_raw_read = max_size - SPI_READ_PREFIX_LEN;
> +	regmap_config->max_raw_write = max_size - SPI_WRITE_PREFIX_LEN;
> +
> +	regmap = devm_regmap_init(&spi->dev, NULL, spi, regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	return goodix_berlin_probe(&spi->dev, spi->irq,
> +				   &goodix_berlin_spi_input_id, regmap);
> +}
> +
> +static const struct spi_device_id goodix_berlin_spi_ids[] = {
> +	{ "gt9916" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(spi, goodix_berlin_spi_ids);
> +
> +static const struct of_device_id goodix_berlin_spi_of_match[] = {
> +	{ .compatible = "goodix,gt9916", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, goodix_berlin_spi_of_match);
> +
> +static struct spi_driver goodix_berlin_spi_driver = {
> +	.driver = {
> +		.name = "goodix-berlin-spi",
> +		.of_match_table = goodix_berlin_spi_of_match,
> +		.pm = pm_sleep_ptr(&goodix_berlin_pm_ops),
> +	},
> +	.probe = goodix_berlin_spi_probe,
> +	.id_table = goodix_berlin_spi_ids,
> +};
> +module_spi_driver(goodix_berlin_spi_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Goodix Berlin SPI Touchscreen driver");
> +MODULE_AUTHOR("Neil Armstrong <neil.armstrong@linaro.org>");
> 
> -- 
> 2.34.1
> 

Kind regards,
Jeff LaBundy
