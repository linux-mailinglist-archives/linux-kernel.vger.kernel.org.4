Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6A066285A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 15:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjAIOVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 09:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbjAIOU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 09:20:27 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF44515721
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 06:20:25 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id D1C9A125C;
        Mon,  9 Jan 2023 15:20:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1673274023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DyTntcXGnalnFdsHW0+05dfmoCRtXXqGoOJ38tx3Qjg=;
        b=rHvEXkd7pS/Yc68kEcJCrc7wVwe5mQnP9xVyS6z19jMT4iyTLn1J8IcfMCq0MlQuPRJqxj
        6d6tFkhSMyxGcsEvCLpnPlATCUAe5JLKpam3ME8xiPDiTeFOgwnpURNJINi84x/MO+Ob1s
        YBfDxgtw8E5hltVraC/dHEVPLIt/OL/MYgcjjexATK4Mif2rnSYB+HS51Q8TPa68mLhlYy
        Y5Xv6nrwjoSjo2c8vKKpxkY/OlYOu0xfHiUPO5+TjPYCF2ZSUyMYZuYphVupx4v+ZUZUf8
        /XZfo6qYAVyxviYvt2m97XULJvd3s8gngau81UZi8UhkJOFC54rSN8iWPKu0Uw==
MIME-Version: 1.0
Date:   Mon, 09 Jan 2023 15:20:23 +0100
From:   Michael Walle <michael@walle.cc>
To:     "Usyskin, Alexander" <alexander.usyskin@intel.com>
Cc:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mtd: spi-nor: macronix: add support for mx77l51250f
In-Reply-To: <CY5PR11MB636696A89B94C4C659738290EDFE9@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20230107214345.2524851-1-tomas.winkler@intel.com>
 <5076cc829fb5a9c5959687a401b120ca@walle.cc>
 <CY5PR11MB636696A89B94C4C659738290EDFE9@CY5PR11MB6366.namprd11.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <6b4780f5366de7f0dd59da0ed4f9a948@walle.cc>
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

Am 2023-01-09 15:09, schrieb Usyskin, Alexander:
>> > --- a/drivers/mtd/spi-nor/macronix.c
>> > +++ b/drivers/mtd/spi-nor/macronix.c
>> > @@ -100,6 +100,8 @@ static const struct flash_info macronix_nor_parts[]
>> > = {
>> >  	{ "mx66u2g45g",	 INFO(0xc2253c, 0, 64 * 1024, 4096)
>> >  		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>> SPI_NOR_QUAD_READ)
>> >  		FIXUP_FLAGS(SPI_NOR_4B_OPCODES) },
>> > +	{ "mx77l51250f", INFO(0xc2751a, 0, 64 * 1024, 4096)
>> > +		PARSE_SFDP },
>> 
>> With the newest generic spi nor driver [1] this patch shouldn't
>> be needed at all anymore. Could you verify, that your flash will work
>> without it?
>> 
>> -michael
>> 
>> [1]
>> https://elixir.bootlin.com/linux/v6.2-rc3/source/drivers/mtd/spi-
>> nor/core.c#L1637
> 
> Tested now, the v6.2-rc3 recognizes the chip.
> Does this mean that all SFDP-supporting chips will be recognized 
> automatically?

As long as you just want to use the standard features described by SFDP,
yes. There might be lacking support for some SFDP features, though. 
These
should then be added to the SFDP parser.

But, there are also features, which aren't supported by SFDP, i.e. 
locking
or OTP. If you want to use these, you still need a flash table entry.

-michael

> Tomas, we can abandon upstreaming effort, I'll save the patch if it
> will needed by older kernel versions.

