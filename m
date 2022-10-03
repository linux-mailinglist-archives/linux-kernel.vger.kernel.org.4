Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB3D5F2D06
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 11:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiJCJS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 05:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiJCJSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 05:18:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696CD2A948;
        Mon,  3 Oct 2022 02:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664788729; x=1696324729;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Hz/ZMNahLhit24oC7ocKRUZVV4ybyNBAWQ2Suiz069A=;
  b=nrLT5XxoA9HZNFkyxmbDEH04jlf1XIR2NPQdfUclJmrI+tDOBRiYV2Pz
   GuDvLVSQOrEKGaD3hMd56HkIg7olabNpOiaV36droR018rsvx3gz/jmQb
   m78Qmgl9C029VzHzDglcNa9iz6C+obAgtOZEyKfal7RHCjswRxi+Xutli
   N+9ejdgy0AGkdZe+BOA01ladpHK9bWOeCW82GVSIQffma2cPk6DTIoasR
   GqzewfLImpkDXMFUEPPQgxdjBcJYXnvwt04aVPnA9VyIKxDsLovvCyc4W
   uyEIjUetJey3L5vBGy5PT6J2K+A2Xf0HYxP0seNToqAVgKPlX2IS/3R9F
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="364431763"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="364431763"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 02:18:48 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="868518408"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="868518408"
Received: from rladysz-mobl2.ger.corp.intel.com ([10.252.38.50])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 02:18:38 -0700
Date:   Mon, 3 Oct 2022 12:18:39 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, andy.shevchenko@gmail.com,
        u.kleine-koenig@pengutronix.de, johan@kernel.org,
        wander@redhat.com, etremblay@distech-controls.com,
        macro@orcam.me.uk, geert+renesas@glider.be, jk@ozlabs.org,
        phil.edworthy@renesas.com, Lukas Wunner <lukas@wunner.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v2 tty-next 1/3] 8250: microchip: pci1xxxx: Add driver
 for quad-uart support.
In-Reply-To: <20221001061507.3508603-2-kumaravel.thiagarajan@microchip.com>
Message-ID: <3e11913-5cc6-5f45-34a8-f742f461158@linux.intel.com>
References: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com> <20221001061507.3508603-2-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Oct 2022, Kumaravel Thiagarajan wrote:

> pci1xxxx is a PCIe switch with a multi-function endpoint on one of its
> downstream ports. Quad-uart is one of the functions in the
> multi-function endpoint. This driver loads for the quad-uart and
> enumerates single or multiple instances of uart based on the PCIe
> subsystem device ID.
> 
> Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> ---
> Changes in v2:
> - Use only the 62.5 MHz for baud clock.
> - Define custom implementation for get_divisor and set_divisor.
> - Use BOTHER instead of UPF_SPD_CUST for non standard baud rates (untested).
> - Correct indentation in clock divisor computation.
> - Remove unnecessary call to pci_save_state in probe function.
> - Fix null pointer dereference in probe function.
> - Move pci1xxxx_rs485_config to a separate patch.
> - Depends on SERIAL_8250_PCI & default to SERIAL_8250.
> - Change PORT_MCHP16550A to 100 from 124.
> --- 
>  MAINTAINERS                             |   6 +
>  drivers/tty/serial/8250/8250_pci1xxxx.c | 394 ++++++++++++++++++++++++
>  drivers/tty/serial/8250/8250_port.c     |   8 +
>  drivers/tty/serial/8250/Kconfig         |  10 +
>  drivers/tty/serial/8250/Makefile        |   1 +
>  include/uapi/linux/serial_core.h        |   3 +
>  6 files changed, 422 insertions(+)
>  create mode 100644 drivers/tty/serial/8250/8250_pci1xxxx.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d30f26e07cd3..3390693d57ae 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -218,6 +218,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
>  F:	drivers/tty/serial/8250*
>  F:	include/linux/serial_8250.h
>  
> +MICROCHIP PCIe UART DRIVER
> +M:	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> +L:	linux-serial@vger.kernel.org
> +S:	Maintained
> +F:	drivers/tty/serial/8250/8250_pci1xxxx.c
> +
>  8390 NETWORK DRIVERS [WD80x3/SMC-ELITE, SMC-ULTRA, NE2000, 3C503, etc.]
>  L:	netdev@vger.kernel.org
>  S:	Orphan / Obsolete
> diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
> new file mode 100644
> index 000000000000..41a4b94f52b4
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
> @@ -0,0 +1,394 @@

> +#define PCI_VENDOR_ID_MCHP_PCI1XXXX	0x1055
> +
> +#define PCI_DEVICE_ID_MCHP_PCI12000	0xA002
> +#define PCI_DEVICE_ID_MCHP_PCI11010	0xA012
> +#define PCI_DEVICE_ID_MCHP_PCI11101	0xA022
> +#define PCI_DEVICE_ID_MCHP_PCI11400	0xA032
> +#define PCI_DEVICE_ID_MCHP_PCI11414	0xA042
> +
> +#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_4p	0x0001
> +#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3p012	0x0002
> +#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3p013	0x0003
> +#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3p023	0x0004
> +#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3p123	0x0005
> +#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p01	0x0006
> +#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p02	0x0007
> +#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p03	0x0008
> +#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p12	0x0009
> +#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p13	0x000A
> +#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p23	0x000B
> +#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1p0	0x000C
> +#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1p1	0x000D
> +#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1p2	0x000E
> +#define PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1p3	0x000F
> +
> +#define PCI_SUBDEVICE_ID_MCHP_PCI12000	0xA002
> +#define PCI_SUBDEVICE_ID_MCHP_PCI11010	0xA012
> +#define PCI_SUBDEVICE_ID_MCHP_PCI11101	0xA022
> +#define PCI_SUBDEVICE_ID_MCHP_PCI11400	0xA032
> +#define PCI_SUBDEVICE_ID_MCHP_PCI11414	0xA042

Usually lowercase is used for hexadecimal letters.

> +#define UART_ACTV_REG			0x11
> +#define UART_ACTV_SET_ACTIVE		BIT(0)
> +
> +#define ADCL_CFG_REG			0x40
> +#define ADCL_CFG_POL_SEL		BIT(2)
> +#define ADCL_CFG_PIN_SEL		BIT(1)
> +#define ADCL_CFG_EN			BIT(0)
> +
> +#define CLK_SEL_REG			0x50
> +#define CLK_SEL_MASK			GENMASK(1, 0)
> +#define CLK_SEL_166MHZ			0x01
> +#define CLK_SEL_500MHZ			0x02

FIELD_PREP(CLK_SEL_MASK, ..) for thse two.

> +
> +#define CLK_DIVISOR_REG			0x54
> +
> +#define UART_PCI_CTRL_REG		0x80
> +#define UART_PCI_CTRL_SET_MULTIPLE_MSI	BIT(4)
> +#define UART_PCI_CTRL_D3_CLK_ENABLE	BIT(0)
> +
> +#define UART_WAKE_REG			0x8C
> +#define UART_WAKE_MASK_REG		0x90
> +#define UART_WAKE_N_PIN			BIT(2)
> +#define UART_WAKE_NCTS			BIT(1)
> +#define UART_WAKE_INT			BIT(0)
> +#define UART_WAKE_SRCS			(UART_WAKE_N_PIN | UART_WAKE_NCTS | UART_WAKE_INT)
> +
> +#define UART_RESET_REG			0x94
> +#define UART_RESET_D3_RESET_DISABLE	BIT(16)
> +
> +#define UART_BIT_SAMPLE_CNT 16
> +
> +struct pci1xxxx_8250 {
> +	struct pci_dev		*dev;
> +	unsigned int		nr;
> +	void __iomem		*membase;
> +	int			line[];
> +};

> +static unsigned int pci1xxxx_get_divisor(struct uart_port *port,
> +					 unsigned int baud,
> +					 unsigned int *frac)
> +{
> +	unsigned int quot;
> +
> +	/*
> +	 * Calculate baud rate sampling period in nano seconds.
> +	 * Fractional part x denotes x/255 parts of a nano second.
> +	 */
> +
> +	quot = ((1000000000) / (baud * UART_BIT_SAMPLE_CNT));
> +	*frac = (((1000000000 - (quot * baud * UART_BIT_SAMPLE_CNT)) /

NSEC_PER_SEC

> +		  UART_BIT_SAMPLE_CNT) * 255) / baud;
> +
> +	return quot;
> +}
> +
> +static void pci1xxxx_set_divisor(struct uart_port *port, unsigned int baud,
> +				 unsigned int quot, unsigned int frac)
> +{
> +	writel((quot << 8) | frac, (port->membase + CLK_DIVISOR_REG));

Define mask for quotient part and use FIELD_PREP().

Remove extra parenthesis.

> +static int pci1xxxx_serial_probe(struct pci_dev *dev,
> +				 const struct pci_device_id *ent)
> +{
> +	struct pci1xxxx_8250 *priv;
> +	struct uart_8250_port uart;
> +	unsigned int nr_ports, i;
> +	int num_vectors = 0;
> +	int rc;
> +
> +	rc = pcim_enable_device(dev);
> +	if (rc)
> +		return rc;
> +
> +	nr_ports = pci1xxxx_get_num_ports(dev);
> +
> +	priv = devm_kzalloc(&dev->dev, struct_size(priv, line, nr_ports), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->membase = pcim_iomap(dev, 0, 0);
> +	priv->dev = dev;
> +	priv->nr =  nr_ports;

Extra space.

> +
> +	pci_set_master(dev);
> +
> +	num_vectors  = pci_alloc_irq_vectors(dev, 1, 4, PCI_IRQ_ALL_TYPES);
> +	if (num_vectors < 0)
> +		return num_vectors;
> +
> +	memset(&uart, 0, sizeof(uart));
> +	uart.port.flags = UPF_SHARE_IRQ | UPF_FIXED_TYPE | UPF_FIXED_PORT;
> +	uart.port.uartclk = 62500000;
> +	uart.port.dev = &dev->dev;
> +
> +	if (num_vectors == 4)
> +		writeb(UART_PCI_CTRL_SET_MULTIPLE_MSI, (priv->membase + UART_PCI_CTRL_REG));

Extra parenthesis.

-- 
 i.
