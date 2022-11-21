Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B572631AA7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 08:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiKUHwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 02:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiKUHv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 02:51:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4963B31DC2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 23:51:58 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1ox1ak-0002dr-1P; Mon, 21 Nov 2022 08:51:46 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1ox1ai-00058n-B2; Mon, 21 Nov 2022 08:51:44 +0100
Date:   Mon, 21 Nov 2022 08:51:44 +0100
To:     Michael Walle <michael@walle.cc>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 17/18] nvmem: layouts: Add ONIE tlv layout driver
Message-ID: <20221121075144.GL3143@pengutronix.de>
References: <20221118185118.1190044-1-michael@walle.cc>
 <20221118185118.1190044-18-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118185118.1190044-18-michael@walle.cc>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
From:   Sascha Hauer <sha@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 07:51:17PM +0100, Michael Walle wrote:
> From: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> This layout applies no top of any non volatile storage device containing

s/no/on/

> +	table_len = hdr_len + data_len;
> +	if (table_len > ONIE_TLV_MAX_LEN) {
> +		dev_err(dev, "Invalid ONIE TLV data length\n");
> +		return -EINVAL;
> +	}
> +
> +	table = devm_kmalloc(dev, table_len, GFP_KERNEL);
> +	if (!table)
> +		return -ENOMEM;
> +
> +	ret = nvmem_device_read(nvmem, 0, table_len, table);
> +	if (ret != table_len)
> +		goto free_data_buf;
> +
> +	if (!onie_tlv_crc_is_valid(dev, table_len, table)) {
> +		ret = -EINVAL;
> +		goto free_data_buf;
> +	}
> +
> +	data = table + hdr_len;
> +	ret = onie_tlv_add_cells(dev, nvmem, data_len, data);
> +	if (ret)
> +		goto free_data_buf;
> +
> +free_data_buf:
> +	kfree(table);

This is allocated with devm_kmalloc(), you shouldn't free it here.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
