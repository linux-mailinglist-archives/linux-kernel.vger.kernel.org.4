Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A946499AC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 08:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiLLHov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 02:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLLHor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 02:44:47 -0500
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583B3B4A5;
        Sun, 11 Dec 2022 23:44:46 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id v8so11656460edi.3;
        Sun, 11 Dec 2022 23:44:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bBnZPykCAh4sz3+fqSfhGJ93byeEe48wc65Uoxz5KJI=;
        b=eP6VHVOoH01W69+PcOWPuSTVRWTL7l0+vMMLk/bOopKjQotxTJcSIeeMV116XQ1EH3
         +LxdplPa5pdAOcttHx7InYVkYXamdQcSl0mdgKVi4KLWX2Es1khWemuaa6/YnjvffdMs
         LWgLrdFCbxQNEJcqT+08zvwvUVjP8h4fSua9eRh6kNOoocoqtsjB/HAk6oy2HwG4ksKg
         vcjQEEItaP772qcYFWJh2opIliclKN885JeKgwdfV5d4paaM+Ykqx7WF3vG4dMKHtdvf
         KJzVgljM/ibkUf6vyrCpFqPAF+rDC9Gn6cTxM5FBmlpGCVmXzxA5HZWVG95QsT93rgdq
         XV8A==
X-Gm-Message-State: ANoB5pm34GhJuLhI1Hsrrdp9J3igdEDZKPtQ+A1vNTnYb3ErBjHuG9nj
        Qssw5Lcig9bOWLVhXelVuMg=
X-Google-Smtp-Source: AA0mqf7GTwdzFULDPutFIxOEnMDdHclihgf/piSLsKw4XrRTobM+SOI7TzOtirheArkbDLvQiR1xxg==
X-Received: by 2002:a50:8d1c:0:b0:46c:97c2:8d75 with SMTP id s28-20020a508d1c000000b0046c97c28d75mr14230916eds.21.1670831084654;
        Sun, 11 Dec 2022 23:44:44 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:49? ([2a0b:e7c0:0:107::aaaa:49])
        by smtp.gmail.com with ESMTPSA id l4-20020aa7c304000000b0046b1d63cfc1sm3479639edq.88.2022.12.11.23.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Dec 2022 23:44:44 -0800 (PST)
Message-ID: <29c707e3-be9f-24fe-107e-591f3b3b3d49@kernel.org>
Date:   Mon, 12 Dec 2022 08:44:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        ilpo.jarvinen@linux.intel.com, macro@orcam.me.uk,
        andriy.shevchenko@linux.intel.com, cang1@live.co.uk,
        colin.i.king@gmail.com, phil.edworthy@renesas.com,
        biju.das.jz@bp.renesas.com, geert+renesas@glider.be,
        lukas@wunner.de, u.kleine-koenig@pengutronix.de, wander@redhat.com,
        etremblay@distech-controls.com, jk@ozlabs.org,
        UNGLinuxDriver@microchip.com,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
References: <20221211014730.1233272-1-kumaravel.thiagarajan@microchip.com>
 <20221211014730.1233272-3-kumaravel.thiagarajan@microchip.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v8 tty-next 2/4] serial: 8250_pci1xxxx: Add driver for
 quad-uart support
In-Reply-To: <20221211014730.1233272-3-kumaravel.thiagarajan@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11. 12. 22, 2:47, Kumaravel Thiagarajan wrote:
> pci1xxxx is a PCIe switch with a multi-function endpoint on one of
> its downstream ports. Quad-uart is one of the functions in the
> multi-function endpoint. This driver loads for the quad-uart and
> enumerates single or multiple instances of uart based on the PCIe
> subsystem device ID.
> 
> Co-developed-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
...
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
> @@ -0,0 +1,337 @@

...
> +struct pci1xxxx_8250 {
> +	struct pci_dev *pdev;
> +	unsigned int nr;
> +	void __iomem *membase;
> +	int line[];
> +};
...
> +static int pci1xxxx_get_max_port(int subsys_dev)

Both look like should be unsigned.

> +{
> +	static int max_port[] = {

const unsigned

> +		1,/* PCI12000 PCI11010 PCI11101 PCI11400 */
> +		4,/* PCI4p */
> +		3,/* PCI3p012 */
> +		4,/* PCI3p013 */
> +		4,/* PCI3p023 */
> +		4,/* PCI3p123 */
> +		2,/* PCI2p01 */
> +		3,/* PCI2p02 */
> +		4,/* PCI2p03 */
> +		3,/* PCI2p12 */
> +		4,/* PCI2p13 */
> +		4,/* PCI2p23 */
> +		1,/* PCI1p0 */
> +		2,/* PCI1p1 */
> +		3,/* PCI1p2 */
> +		4,/* PCI1p3 */
> +	};
> +
> +	if (subsys_dev > PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p3)
> +		if (subsys_dev != PCI_SUBDEVICE_ID_EFAR_PCI11414)
> +			return max_port[0];
> +		else
> +			return 4;
> +	else

No need for this else. And you should use {}.

> +		return max_port[subsys_dev];
> +
> +}
> +
> +static int pci1xxxx_logical_to_physical_port_translate(int subsys_dev, int port)
> +{
> +	static int logical_to_physical_port_idx[][MAX_PORTS] = {

const unsigned.

> +		{0,  1,  2,  3},/* PCI12000 PCI11010 PCI11101 PCI11400 PCI11414 */
> +		{0,  1,  2,  3},/* PCI4p */
> +		{0,  1,  2, -1},/* PCI3p012 */
> +		{0,  1,  3, -1},/* PCI3p013 */
> +		{0,  2,  3, -1},/* PCI3p023 */
> +		{1,  2,  3, -1},/* PCI3p123 */
> +		{0,  1, -1, -1},/* PCI2p01 */
> +		{0,  2, -1, -1},/* PCI2p02 */
> +		{0,  3, -1, -1},/* PCI2p03 */
> +		{1,  2, -1, -1},/* PCI2p12 */
> +		{1,  3, -1, -1},/* PCI2p13 */
> +		{2,  3, -1, -1},/* PCI2p23 */
> +		{0, -1, -1, -1},/* PCI1p0 */
> +		{1, -1, -1, -1},/* PCI1p1 */
> +		{2, -1, -1, -1},/* PCI1p2 */
> +		{3, -1, -1, -1},/* PCI1p3 */
> +	};
> +
> +	if (subsys_dev > PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p3)
> +		return logical_to_physical_port_idx[0][port];
> +	else

No need for this else.

> +		return logical_to_physical_port_idx[subsys_dev][port];
> +}
> +
> +static int pci1xxxx_serial_probe(struct pci_dev *pdev,
> +				 const struct pci_device_id *id)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct pci1xxxx_8250 *priv;
> +	struct uart_8250_port uart;
> +	unsigned int nr_ports, i;
> +	int max_vec_reqd;
> +	int num_vectors;
> +	int subsys_dev;
> +	int port_idx;
> +	int rc;
> +
> +	rc = pcim_enable_device(pdev);
> +	if (rc)
> +		return rc;
> +
> +	nr_ports = pci1xxxx_get_num_ports(pdev);
> +
> +	priv = devm_kzalloc(dev, struct_size(priv, line, nr_ports), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->membase = pcim_iomap(pdev, 0, 0);
> +	if (!priv->membase)
> +		return -ENOMEM;
> +
> +	priv->pdev = pdev;

What do you need pdev in priv for? It looks superfluous after passing it 
to pci1xxxx_setup().

> +	subsys_dev = priv->pdev->subsystem_device;
> +	priv->nr = nr_ports;
> +	pci_set_master(pdev);
> +	max_vec_reqd = pci1xxxx_get_max_port(subsys_dev);
> +	num_vectors = pci_alloc_irq_vectors(pdev, 1, max_vec_reqd,
> +					    PCI_IRQ_ALL_TYPES);
> +	if (num_vectors < 0)
> +		return num_vectors;
> +
> +	memset(&uart, 0, sizeof(uart));
> +	uart.port.flags = UPF_SHARE_IRQ | UPF_FIXED_PORT;
> +	uart.port.uartclk = UART_CLOCK_DEFAULT;
> +	uart.port.dev = dev;
> +
> +	if (num_vectors == max_vec_reqd)
> +		writeb(UART_PCI_CTRL_SET_MULTIPLE_MSI,
> +		       priv->membase + UART_PCI_CTRL_REG);
> +
> +	for (i = 0; i < nr_ports; i++)
> +		priv->line[i] = -ENODEV;

Why is this not a part of the following (same) loop?

> +
> +	for (i = 0; i < nr_ports; i++) {
> +		port_idx = pci1xxxx_logical_to_physical_port_translate(subsys_dev, i);
> +
> +		if (num_vectors == max_vec_reqd)
> +			uart.port.irq = pci_irq_vector(priv->pdev, port_idx);
> +		else
> +			uart.port.irq = pci_irq_vector(pdev, 0);
> +
> +		rc = pci1xxxx_setup(priv, &uart, port_idx);
> +		if (rc) {
> +			dev_warn(dev, "Failed to setup port %u\n", i);
> +			continue;
> +		}
> +
> +		priv->line[i] = serial8250_register_8250_port(&uart);
> +		if (priv->line[i] < 0) {
> +			dev_warn(dev,
> +				"Couldn't register serial port %lx, irq %d, type %d, error %d\n",
> +				uart.port.iobase, uart.port.irq, uart.port.iotype,
> +				priv->line[i]);
> +		}
> +	}
> +
> +	pci_set_drvdata(pdev, priv);
> +
> +	return 0;
> +}
> +
> +static void pci1xxxx_serial_remove(struct pci_dev *dev)
> +{
> +	struct pci1xxxx_8250 *priv = pci_get_drvdata(dev);
> +	int i;

unsigned as priv->nr is.

> +
> +	for (i = 0; i < priv->nr; i++) {
> +		if (priv->line[i] >= 0)
> +			serial8250_unregister_port(priv->line[i]);
> +	}
> +}
> +
> +static const struct pci_device_id pci1xxxx_pci_tbl[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_PCI11010) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_PCI11101) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_PCI11400) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_PCI11414) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_PCI12000) },
> +	{}

thanks,
-- 
js
suse labs

