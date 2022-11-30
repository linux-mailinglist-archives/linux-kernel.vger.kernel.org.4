Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C4963E382
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 23:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiK3Wc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 17:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiK3WcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 17:32:23 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F871880C4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 14:32:22 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 838AF124D;
        Wed, 30 Nov 2022 23:32:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1669847540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TCPLE07GprHeCRJB1dOgcZEjpdPq49lqGAMoL1+eQr0=;
        b=mfMl55jkYAJIhjINB/HjyFEsUrIiGUHzbyK1aIIeJVWi6OMlUFZ2doGG9hxm6FB5RLE9Fv
        N0TOv9sHIlEknxKTMM+wrXz8LLH2UJgh5PGREUAgIEE3nBJjCIi+W39fZETW7io4YqotqF
        9iOFKR5UmuDYXBfGQ5QuMWSjpNIibL+VPVh5wBmr/PsyVXXN0Dv8yk+iMdm0aDJ7k0VNyR
        8J+F5fe2dzCa9X4LWDRyDOapSmrUC8L9ElSwbExccBkm3jCq4YDzYBZ21cgN554ulgsA9u
        Hy/p3cVRrftASdon1Aqjml5WBAinQUXyytoX1bw1PaDPeeYH5cCVeDWV+S9lqg==
MIME-Version: 1.0
Date:   Wed, 30 Nov 2022 23:32:20 +0100
From:   Michael Walle <michael@walle.cc>
To:     Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc:     greg.malysa@timesys.com,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: issi: Add in support for IS25LX256 chip,
 operating in 1S-1S-8S mode.
In-Reply-To: <CAPE2wM0LZRX2SXmntNFo25zOwYtZ7NQS+G=5VgeeW-iON4UN2g@mail.gmail.com>
References: <20221128172455.159787-1-nathan.morrison@timesys.com>
 <2acae3be377a5d8c3df66f860d944dbb@walle.cc>
 <CAPE2wM0LZRX2SXmntNFo25zOwYtZ7NQS+G=5VgeeW-iON4UN2g@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <e07105d41ec62a6ee47ca0295ca347dc@walle.cc>
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

Am 2022-11-30 16:34, schrieb Nathan Barrett-Morrison:
>> Does this flash have SFDP data? If possible, this should be
>> derived from that. Could you dump the SFDP table and
>> post it here [1].
> 
> # hexdump sfdp
> 0000000 4653 5044 0106 ff01 0600 1001 0030 ff00
> 0000010 0084 0201 0080 ff00 ffff ffff ffff ffff
> 0000020 ffff ffff ffff ffff ffff ffff ffff ffff
> 0000030 20e5 ff8a ffff 0fff 0000 0000 0000 0000
> 0000040 fffe ffff ffff ff00 ffff 0000 200c d811
> 0000050 520f ff00 2224 00a9 8e8b d103 01ac 3827
> 0000060 757a 757a bdfb 5cd5 0000 ff70 b081 2238
> 0000070 ffff ffff ffff ffff ffff ffff ffff ffff
> 0000080 0e43 ffff dc21 ff5c
> 
> Looking at the latest SFDP document from
> https://www.jedec.org/standards-documents/docs/jesd216b, I see
> 1s-1s-8s would be in BFPT DWORD 17, which appears to be 0xffffffff if
> I'm reading this hexdump correctly.

There is no dword 17, the table is shorter than that. But
there is a 4BAIT table at the end, starting at offset 80h.
And from what I can parse with my sleepy eyes, it says
"support for 1s-1s-8s via 7Ch" and "support for 1s-8s-8s via
CCh", which is consistent with the datasheet.

So all you'd need to do is to extend the sfdp parser to parse
that modes in the 4bait table.

Btw there is a newer JESD216F (you can get it from JEDEC for
free, you just have to sign up there).

>> why?
> 
> This was because ISSI's default_init was setting a quad_enable
> function pointer which is not relevant to this part.  This probably
> doesn't need to be done though, as SPI_NOR_QUAD_* isn't being set in
> the flash_info table and therefore quad_enable will never be used?

Yes.

The SFDP specifies 111b as the enable method which is reserved
according to JESD216F. I still vote for setting the quad_enable
to NULL if there is SFDP which should know better. This should
be "fixed" (IOW unset) by the following patch (but it never
made it):
https://lore.kernel.org/linux-mtd/20220304185137.3376011-1-michael@walle.cc/

-michael
