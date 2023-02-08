Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B2768F1FD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjBHP2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjBHP2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:28:48 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13C52B288
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 07:28:47 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 1AE7D41;
        Wed,  8 Feb 2023 16:28:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1675870126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UUOsinKT95zdvP+DuwsEu/6FCF+W9T+lwViOXbsC0Cg=;
        b=GAsHcMbSvB/qufQyWOM797Et6E16LUSaXlA3V1MIX9LIu1195TosiheZ64C5ZT5vy8As4X
        TCHzVM5j+VL1ARz+Dv6a3LVGeafaY0vOQQugn8DUJpcIZwItwJ/4Q75gq4lTvCR5yuPOdM
        /dBYks1zeylukqEsOhVf3DBN/QK7whvOiBrNTQamn24RHT4XGWcVPl+W3MAigAxk3iEGk5
        rN2xCsNDAtqC1Df+D4PWgY4oIl68O6Lx3lUA6ZNwh7bKfWVmY65TI2qfMUAfUqZRfMhZ00
        Oh55QgGkUxZKrPb+1X+xUWkIMg9sHWuxe+e750q/KMgBV9CGsEdNuKBzrlcI+A==
MIME-Version: 1.0
Date:   Wed, 08 Feb 2023 16:28:45 +0100
From:   Michael Walle <michael@walle.cc>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3] mtd: spi-nor: fix memory leak when using
 debugfs_lookup()
In-Reply-To: <20230208145301.2169646-1-gregkh@linuxfoundation.org>
References: <20230208145301.2169646-1-gregkh@linuxfoundation.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <68d10a9b27a0a3894a290b28c1a22085@walle.cc>
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

> +static void __exit spi_nor_module_exit(void)
> +{
> +	spi_nor_debugfs_shutdown();
> +	spi_mem_driver_unregister(&spi_nor_driver);

Hm, does the order matter here? I didn't test it, but this will
lead to:

rootdir = debugfs_create_dir("spi-nor", NULL);
nor->debugfs_root = debugfs_create_dir("spi0", rootdir);
debugfs_remove(rootdir);
debugfs_remove(nor->debugfs_root);

If that's ok, then this looks good.

-michael
