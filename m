Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7277A68F2F2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjBHQPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjBHQPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:15:45 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550DB4A1CA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 08:15:44 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id E419E321;
        Wed,  8 Feb 2023 17:15:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1675872942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ntR/wlgNqt21ow8SuRQPW4QRtnHFkvNsYSwvNNaYGD0=;
        b=leHGVM16DNZv1jd5/Oa2Y1ftugL4roDER1DMeYJJkhTMa5DoB3iyalM9PAvgA9dN4Sdcfg
        VEJT3ZkbmGBqNHrLXqrOuMMiJTj4Gkv6YG8W8rw0ki0g/y75CeW+GNU2Vg1BMJjruXCI2J
        wINTP7tMtn5HfHGe5gFFgKqlbMqt5cdnwFNSuCWC1znnNGzgSeBXkTpJEPZPyMhZAp+2jc
        UShsntwaqpZ31MVmuXAElI85C8I5pkLYv0fqAEENzufmdtI+G/1EWMg7l5X1Qtq1dEgj6a
        R1nBZXKxlbTWqnWCjumYAP3TJZvy2X2JTEonsR2MVKJhNyKGZ+ojWsreNaO7lw==
MIME-Version: 1.0
Date:   Wed, 08 Feb 2023 17:15:41 +0100
From:   Michael Walle <michael@walle.cc>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v4] mtd: spi-nor: fix memory leak when using
 debugfs_lookup()
In-Reply-To: <20230208160230.2179905-1-gregkh@linuxfoundation.org>
References: <20230208160230.2179905-1-gregkh@linuxfoundation.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <f60870dee13900252e0b13fb2f5f05b5@walle.cc>
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

Am 2023-02-08 17:02, schrieb Greg Kroah-Hartman:
> When calling debugfs_lookup() the result must have dput() called on it,
> otherwise the memory will leak over time.  To solve this, remove the
> lookup and create the directory on the first device found, and then
> remove it when the module is unloaded.
> 
> Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
> Cc: Pratyush Yadav <pratyush@kernel.org>
> Cc: Michael Walle <michael@walle.cc>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Michael Walle <michael@walle.cc>

one nit below I didn't notice earlier, no need to send a new
patch version just for that.

..

> +void spi_nor_debugfs_shutdown(void)
> +{
> +	if (rootdir)
> +		debugfs_remove(rootdir);

debugfs_remove() already has a check for NULL.

