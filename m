Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE687452F8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 00:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjGBWdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 18:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGBWdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 18:33:00 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E08E49;
        Sun,  2 Jul 2023 15:32:59 -0700 (PDT)
Received: from ideasonboard.com (85-160-45-219.reb.o2.cz [85.160.45.219])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5B7A36DE;
        Mon,  3 Jul 2023 00:32:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1688337135;
        bh=5sny6CY4ssurgOhg9dEm+wJ9LPpiuE4sHpxZ2EjTn8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PiOCpW9o3ljZWU3eadw0kKEZ6zf5KRhnMDZdLpUJLvRJQ8XdPp68XDDeQSd1hY9tW
         SGwEx/alQa7/E1TVw5ylOb9UA6/dtIgf+gq6WWh3OCUqOlijbRXXfIDcVTbIXXbsEW
         E1NfxjNE7dTA2gH5aildxC8tiPQZbXuPHF22LSIQ=
Date:   Mon, 3 Jul 2023 00:32:54 +0200
From:   Jacopo Mondi <jacopo.mondi@ideasonboard.com>
To:     Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: arch/superh: Suspicious coherent DMA allocations for CEU video
 buffers
Message-ID: <6hbvbciyyx7wcuwzhgaczqearmu2mu3h2u447mljbp24emtjaz@ciel5ezmehfq>
References: <20230629151124.34e72817@meshulam.tesarici.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230629151124.34e72817@meshulam.tesarici.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On Thu, Jun 29, 2023 at 03:11:24PM +0200, Petr Tesařík wrote:
> Hi Jacopo,
>
> I've just noticed a few calls to dma_declare_coherent_memory() which
> look suspicious to me, all authored by you:
>
> - arch/sh/boards/mach-ap325rxa/setup.c
> - arch/sh/boards/mach-ecovec24/setup.c
> - arch/sh/boards/mach-kfr2r09/setup.c
> - arch/sh/boards/mach-migor/setup.c
> - arch/sh/boards/mach-se/7724/setup.c
>
> In these files, the last argument to dma_declare_coherent_memory()
> looks like the last address to be used, but the expected value should
> be the size of the reserved region, e.g.:
>
> 	dma_declare_coherent_memory(&ap325rxa_ceu_device.dev,
> 			ceu_dma_membase, ceu_dma_membase,
> 			ceu_dma_membase + CEU_BUFFER_MEMORY_SIZE - 1);
>
> Do you (or anyone else on Cc) agree that this is a braino, and all these
> boards should actually use CEU_BUFFER_MEMORY_SIZE as the size of their
> DMA pools rather than membase + CEU_BUFFER_MEMORY_SIZE - 1?
>

Thanks for spotting this.. I tried to track down where this comes from
digging out the CEU and the platform file from 4.16, but it seems this
simply is a brain fart from my side.

I presume this is very much dead code, as the commit message of
39fb993038e1 ("media: arch: sh: ap325rxa: Use new renesas-ceu camera
driver") says: "Compile tested only." and nobody has ever reported
bugs.

Feel free to send patches and cc me, as long as this code is around
it's nice to have it correct at least.

Thank you!
   j

PS: if you ask me, as nobody clearly run this code in the last 5
years, I would simply drop all these platform files. But that's
maintainers' call.


> Petr T
