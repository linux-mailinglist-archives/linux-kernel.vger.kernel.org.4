Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54018652DD5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 09:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbiLUIWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 03:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbiLUIWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 03:22:08 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04591F5F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 00:22:06 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 15BB19EF;
        Wed, 21 Dec 2022 09:22:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1671610925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CrOp+4yXKStdKI6+nRU+X23Qjw/ID5T0E5jOpfRWtV0=;
        b=ebDXBQ81UhX36K5+JykVoeqLlqKwYvyJG7BblORAz7657NNNDLDTwQVcwQW1xV3jaMIFH1
        whATaOEgA1wsrqXp2nrOzjKWEeTk07LvfDq9EzXxyLoMj/oiKp6WTtfnj30AFS2GMNTMfD
        z1oQ+CbUGK1kb0a48kVOO2Dfm/zytRsAdwJUOc48frxWkCPZPzaAwtdEgwipu0NQlGZqkr
        17ye63O+02ttuLp+XqMnNgNHMopnzKT4eb468ZGg/Nd7hpUM32FnFDNAw0R70Up4j4TFms
        GWr6DdxRbDdt0BCTwrOQZDDuqBmmXPlDoxMG/q1yLhfqoK4Hx7UySKY5FmWaoA==
MIME-Version: 1.0
Date:   Wed, 21 Dec 2022 09:22:04 +0100
From:   Michael Walle <michael@walle.cc>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, greentime.hu@sifive.com,
        jude.onyenegecha@sifive.com, william.salmon@sifive.com,
        adnan.chowdhury@sifive.com, ben.dooks@sifive.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mtd: spi-nor: issi: is25wp256: Init flash based on
 SFDP
In-Reply-To: <20221221003009.GA280250@roeck-us.net>
References: <20220920184808.44876-1-sudip.mukherjee@sifive.com>
 <20221221003009.GA280250@roeck-us.net>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <9cf53ca3bfb39c85da968f9b46dbe6d7@walle.cc>
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

Hi,

Am 2022-12-21 01:30, schrieb Guenter Roeck:
> With this patch in place, qemu emulations with is25wp256 fail to
> instantiate the flash. Specifically, this affects the qemu sifive_u
> emulation. The resulting error message is:
> 
> spi-nor spi0.0: BFPT parsing failed. Please consider using
> SPI_NOR_SKIP_SFDP when declaring the flash
> spi-nor: probe of spi0.0 failed with error -22

qemu is to blame here. It doesn't fully emulate the flash. Esp. not
the SFDP tables. See also [1]. Adding the .sfdp_read hook with the
corresponding binary [2] should fix your issue.

[1] 
https://lore.kernel.org/qemu-devel/7827c791b7f91f4eb216b33473dd6103@walle.cc/
[2] 
https://lore.kernel.org/linux-mtd/CAHyZL-ch=mr0x_19e6P9G+Z4sW2iJXW9nTnXUNAhn+pTptN2ww@mail.gmail.com/

-michael
