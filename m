Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C08F68EFE7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 14:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjBHNg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 08:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjBHNg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 08:36:28 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C2D35AB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 05:36:26 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 1C55F41;
        Wed,  8 Feb 2023 14:36:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1675863383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZJ6nbZ7ZjxSMQlV2nrrI20Zzn6ZzSpDBwtS6grJkjEA=;
        b=U2jM433oONjJ6hcCWtUJG9pQ0/DRAAkH5rJTdUF4yC23saM0CWe40dt+kqvSb9Y75XaSU9
        3Mf9s9HKanvONOGqHDmN7oHCAmEn2EGq/z8+JDqK/RsythsR9pwwwANn7pujqq9fVnm5PT
        cGYV7Uo6KslEaRJTubl4+ho9GXutTME+LA/a2VjypmIdZ0/d91X7G8//n8YWOJ38R1Fqrn
        376Vg/XhxKlR0O04z3w18qymiCXftnzTI2pZ6NvfobMdWfEgfuQKbmoYXqrAM9qdt33yDo
        rfhpvC1ywoIjwvPjsDnOrm3+H6BaI/LiNdPzQLPWP7HOGOFW9BhdNMTIRc0YtA==
MIME-Version: 1.0
Date:   Wed, 08 Feb 2023 14:36:23 +0100
From:   Michael Walle <michael@walle.cc>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, stable <stable@kernel.org>
Subject: Re: [PATCH v2] mtd: spi-nor: fix memory leak when using
 debugfs_lookup()
In-Reply-To: <20230208125758.1515806-1-gregkh@linuxfoundation.org>
References: <20230208125758.1515806-1-gregkh@linuxfoundation.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <69fbf8b55dcb9c5c0a1a5d59b2248670@walle.cc>
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

Am 2023-02-08 13:57, schrieb Greg Kroah-Hartman:
> When calling debugfs_lookup() the result must have dput() called on it,
> otherwise the memory will leak over time.
> 
> Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Michael Walle <michael@walle.cc>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-mtd@lists.infradead.org
> Cc: stable <stable@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v2: fix up to work when module is removed and added, making the fix
>     much simpler.
> 
>  drivers/mtd/spi-nor/debugfs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/spi-nor/debugfs.c 
> b/drivers/mtd/spi-nor/debugfs.c
> index ff895f6758ea..af41fbc09a97 100644
> --- a/drivers/mtd/spi-nor/debugfs.c
> +++ b/drivers/mtd/spi-nor/debugfs.c
> @@ -242,6 +242,7 @@ void spi_nor_debugfs_register(struct spi_nor *nor)
> 
>  	d = debugfs_create_dir(dev_name(nor->dev), rootdir);
>  	nor->debugfs_root = d;
> +	dput(rootdir);

rootdir might either be the return value of debugfs_lookup() or
debugfs_create_dir(). dput() is probably wrong for the latter,
right? Also there is an early return, where the dput() is missing,
too.

-michael
