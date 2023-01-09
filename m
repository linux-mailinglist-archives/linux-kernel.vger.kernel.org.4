Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3856620B8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbjAII4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbjAII4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:56:11 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AA315F3E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:49:02 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 431F738;
        Mon,  9 Jan 2023 09:49:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1673254140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gluxVvcJmCU0vVgleE42V7l99rpup+5K6uOqI+hdG2w=;
        b=XV+ROy/Eaime+q/+idJ04KuJYgXrzAtTfUhc1/dT4co5hfZnP+PBov+3k8tSg1yrCkI8xv
        LOk0W/BggzyUNS9w+X3TurnTodbPpcxbZqhslXI4GaH6zSU827kwImchNE6vzapDkJCZ5W
        VPHl8zAmgqN1oH4js6APUIYhxR13QXr7kV+qQbsE+bFrDw0Hs+T1hBdlb4VTzM8yRDz29a
        bQ4rzhh5o5aOt+3NL14nhRbZIwyndP60cRM0ky8kGV3pAkYUTQ/XtcHbow+Lychd3ZNBlk
        0ev7VaAAsKSCPadoeIwzwYMoYQnsejDZ0Bop7pSPYwD+1+X/O+KwW0bLlFSfgw==
MIME-Version: 1.0
Date:   Mon, 09 Jan 2023 09:49:00 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org,
        Alexander Usyskin <alexander.usyskin@intel.com>
Subject: Re: [PATCH v2] mtd: spi-nor: macronix: add support for mx77l51250f
In-Reply-To: <20230107214345.2524851-1-tomas.winkler@intel.com>
References: <20230107214345.2524851-1-tomas.winkler@intel.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <5076cc829fb5a9c5959687a401b120ca@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-01-07 22:43, schrieb Tomas Winkler:
> $ cat /sys/bus/spi/devices/spi0.0/spi-nor/partname
> mx77l51250f
> $ cat /sys/bus/spi/devices/spi0.0/spi-nor/jedec_id
> c2751a
> $ cat /sys/bus/spi/devices/spi0.0/spi-nor/manufacturer
> macronix
> $ xxd -p /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
> 53464450060103ff00060110300000ffc2000104100100ff030001020001
> 00ff84000102c00000ffffffffffffffffffe520f3ffffffff1f44eb086b
> 083b04bbeeffffffffff00ffffff00ff0c200f5210d800ff8341bd0082a7
> 04db4403373830b030b0f7a9d55c009e29fff050f985ffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffff7f0ff0ff215cdcffffffffffffffffffffff
> ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
> ffffffffffffffffffffffffffffffff3c9b96f0c5a4c2ffffffffffffff
> ffff003600279df9c064fecfffffffffffff
> 
> $ md5sum /sys/bus/spi/devices/spi0.0/spi-nor/sfdp
> 36fb8e3e6f82c45bfabea45ec73c08a8
> /sys/bus/spi/devices/spi0.0/spi-nor/sfdp

Thanks for the dumps, as Dhruva mentioned this should go
in the comment section of this patch. But also see below.


> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -100,6 +100,8 @@ static const struct flash_info macronix_nor_parts[] 
> = {
>  	{ "mx66u2g45g",	 INFO(0xc2253c, 0, 64 * 1024, 4096)
>  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
>  		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
> +	{ "mx77l51250f", INFO(0xc2751a, 0, 64 * 1024, 4096)
> +		PARSE_SFDP },

With the newest generic spi nor driver [1] this patch shouldn't
be needed at all anymore. Could you verify, that your flash will work
without it?

-michael

[1] 
https://elixir.bootlin.com/linux/v6.2-rc3/source/drivers/mtd/spi-nor/core.c#L1637
