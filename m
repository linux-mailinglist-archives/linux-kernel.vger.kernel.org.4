Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8266A615CC6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiKBHMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiKBHMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:12:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD7B21273
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 00:12:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60930B820D2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 07:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EFBC433C1;
        Wed,  2 Nov 2022 07:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667373152;
        bh=ehQ7VwaNM30H0c86wZXvETCmaz99RqH3y0Oi3nAZ3D4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bnrvlbysWyB+7sfoRLVJQZbm/5vU50SjTnFoXpIq5CiiyaquZRhVwsmizFxUkH8Ws
         6h6Sx6c7TVlRAfOC64IPm0a3/kY7/x/XY6EjzHTdql+4qmkarCIJUNfUU9FpMUs8FU
         efepWxoD0iKscunEyxty3XLmateRbLUUaIwjXkkgrhpDYJ/zAH1JXYWyc1nta4pwrZ
         4qxhyuEcaGwrrfGJ+WgHh0Zfs8MV9LFTXLVtZEu4s/xOef7ZIYn0ik8g0DODkPtQ+N
         4KN4KnVlB5jmliczVCv0hE7zz0f4jr4+VCylbnSF06zhD1CpCTbCkuMzhv/NR0pFIr
         jy8s99mPG/YvA==
Message-ID: <ec160658-e251-bfdc-05ac-631bd4c716dc@kernel.org>
Date:   Wed, 2 Nov 2022 09:12:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Barebox / Kernel Omap ECC inconsistency?
Content-Language: en-US
To:     Colin Foster <colin.foster@in-advantage.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Pratyush Yadav <p.yadav@ti.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <Y2FvB5D0K4MBii8N@COLIN-DESKTOP1.localdomain>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <Y2FvB5D0K4MBii8N@COLIN-DESKTOP1.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On 01/11/2022 21:09, Colin Foster wrote:
> Hello,
> 
> I'm trying to revive a product that runs on a Phytec OMAP 4460 SOM. I
> submitted a .dts RFC a month or so ago, and plan to perform the
> suggestions and resubmit, but I'm up against one main hurdle that seems
> to be related to flash OOB/ECC. (get_maintainers on
> drivers/mtd/nand/raw/omap2.c is how I got this email list)
> 
> Barebox has "native" support for the Phytec SOM:
> https://git.pengutronix.de/cgit/barebox/tree/arch/arm/boards/phytec-phycore-omap4460
> 
> It seems like Barebox is writing and expecting ECC bits to start at an
> offset of 12 bytes, while the kernel (and Barebox comments suggest) the
> ECC bytes should start at 2. I'm seeing this with
> `nanddump -n -o -l 0x41000 -f mtdxnanddump /dev/mtdx`
> 
> Barebox created partition with UBI (mtd3)
> ...
> 00000800  ff ff ff ff ff ff ff ff  ff ff ff ff 56 49 fd 17
> 00000810  b2 25 60 1a 42 1d eb 56  5d ff ff ff ff ff ff ff
> ...
> 
> Kernel created partition with UBI (mtd4)
> ...
> 00000800  ff ff 07 73 04 ac 57 6b  9b 1f 92 49 ab e0 b9 ff
> 00000810  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
> ...
> 
> 
> My question: 
> 
> Am I right to assume this is an issue in Barebox? Perhaps this is just a

I'm guessing so. Both u-boot and Linux for OMAP put the ECC bytes right
after the Bad block marker which is 2 bytes.

https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/raw/omap2.c#L1729
https://elixir.bootlin.com/linux/latest/source/drivers/mtd/nand/raw/omap2.c#L134

> bug that has been fairly dormant for 15 years. If that is the case, I
> assume there's probably no hope in getting this mainlined, and "native"
> barebox support is just a ruse.
> 
> If that isn't the case, is there a hidden "shift OOB by 10" config
> option that I'm missing? Or am I interpreting this data incorrectly?
> 
> 
> Any suggestions would be greatly appreciated.

You should fix the OMAP NAND driver/config in Barebox to match that
with Linux OMAP NAND driver if you want them to run on the same system.

cheers,
-roger
