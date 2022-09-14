Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD545B8202
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 09:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiINH10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 03:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiINH1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 03:27:23 -0400
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC146BD6F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 00:27:21 -0700 (PDT)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 0B3B516AE;
        Wed, 14 Sep 2022 09:27:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1663140440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HLwD8obQ6Qt890iBeArYKjMU9g5TO/AqEdCfATpDT6U=;
        b=Ad/dKRr2NUbPX1thLzfT8L6p6n6se2nT6bH9HclcRw3hlWtyEQoHLcRT76mGCGHfbnI/C4
        nkG3mplSPe12ExgM7fUebzXlQQJNZqGTfqOuLuTZebwUzpxn+4N9DmgVU8LtAzHVLdilZi
        5baAtkEqOZf+yhmFYHCRF3jwHJ9TQi3mbP6ZDcNP6l5Qknw3s6EAcVL0gWVnBvxXaBJSOh
        YZa9spwwiZEiSSsusDCpe1LhOAFFle0Oi7DYZS2TxsI8odjhlZm/gs+5mog6GbZY7J1Vek
        13c/GeRjGoEe/TBy45/CPS4CKblHrTECnT5ILStkJp3HjzFnIgZrqI3ACRLwJA==
MIME-Version: 1.0
Date:   Wed, 14 Sep 2022 09:27:19 +0200
From:   Michael Walle <michael@walle.cc>
To:     Yaliang Wang <Yaliang.Wang@windriver.com>
Cc:     tudor.ambarus@microchip.com, pratyush@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: gigadevice: gd25q256: replace
 gd25q256_default_init with gd25q256_post_bfpt
In-Reply-To: <948d4846-dd7e-04a3-51e7-588d266cc28e@windriver.com>
References: <20220913084023.2451929-1-yaliang.wang@windriver.com>
 <MN2PR17MB3375BC0E5878B19651475413B8479@MN2PR17MB3375.namprd17.prod.outlook.com>
 <948d4846-dd7e-04a3-51e7-588d266cc28e@windriver.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <9b87331960933687145688308e2ab97a@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-09-14 05:05, schrieb Yaliang Wang:
> In case the mail list can't receive the email, I'd like to send the 
> email again.
> 
> Sorry, I didn't make it clear.
> I'm doing this because the flash info member parse_sfdp is initialized
> to "true" by PARSE_SFDP macro, as you can see below
>         { "gd25q256", INFO(0xc84019, 0, 64 * 1024, 512)
>                 PARSE_SFDP
>                 FLAGS(SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | 
> SPI_NOR_TB_SR_BIT6)
>                 FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
>                 .fixups = &gd25q256_fixups },
> 
> And when parse_sfdp is true, the function spi_nor_init_params() will
> call spi_nor_parse_sfdp() to initialize the parameters, and I can't
> see any other place to call the original default_init() hook in the
> fixups other than in spi_nor_init_params_deprecated()  ->
> spi_nor_manufacturer_init_params().
> 
> After checking the history of why we are adding this, that is to say
> the commit 48e4d973aefe ("mtd: spi-nor: Add a default_init() fixup
> hook for gd25q256") and the corresponding disscusions, I believe it
> was added for some reason, and we need to add back this function.
> 
> On 9/13/22 18:46, Vanessa Page wrote:
>> **[Please note: This e-mail is from an EXTERNAL e-mail address]
>> 
>> Why are you doing this?

Vanessa Page is a bot/troll.

-michael
