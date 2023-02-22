Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D62469EE65
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 06:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjBVFhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 00:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBVFha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 00:37:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80C034F5A;
        Tue, 21 Feb 2023 21:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:Subject:Cc:From:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ZaFQaEhC0Y47Z5XC2rGkKe6thR+pRJg3kA0++NA4kj8=; b=M5MP3jm2Abz0PZrxM7dbWT6KFB
        5pIFqTaSP9PmHSBwS/DNAs2MCC9T4cYX+SaaJsCJt3UXP+K2cFpWypNYcdk7KgCm0oZ2YpvRZKr/h
        VQElFyvXIioD2mpimnR7tho3uudnoym/OX4YYNe0pSLLLN05ujXhjVaKFQgcMoGlFL8PqItOpW5+M
        ipStejeY0bNEo7pbWYz7gXeO3AQIArnjLfDQKA87zCxNok1MKKfaHmOQgvfWDsq4STeo2lKiI8CxI
        apofzYhGOadkilyfo5t8rZILu7fvuLJtvv/W+7SXEHwSaryDf09HnveRu8RJBiMnp4R8yrHMqHOtH
        qY6OOOlA==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUhog-00ArO0-4d; Wed, 22 Feb 2023 05:37:22 +0000
Message-ID: <4da501dc-65af-ee89-441d-d3ef8867c64d@infradead.org>
Date:   Tue, 21 Feb 2023 21:37:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-alpha@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Alpha MTD_TSUNAMI BROKEN?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In an alpha kernel config with CONFIG_ALPHA_TSUNAMI=y
and CONFIG_MTD_TSUNAMI=y, the MTD driver build fails with:

../drivers/mtd/maps/tsunami_flash.c: In function 'tsunami_flash_read8':
../drivers/mtd/maps/tsunami_flash.c:21:20: error: implicit declaration of function 'tsunami_tig_readb'; did you mean 'tsunami_readb'? [-Werror=implicit-function-declaration]
   21 |         val.x[0] = tsunami_tig_readb(offset);
      |                    ^~~~~~~~~~~~~~~~~
      |                    tsunami_readb
../drivers/mtd/maps/tsunami_flash.c: In function 'tsunami_flash_write8':
../drivers/mtd/maps/tsunami_flash.c:27:9: error: implicit declaration of function 'tsunami_tig_writeb'; did you mean 'tsunami_writeb'? [-Werror=implicit-function-declaration]
   27 |         tsunami_tig_writeb(value.x[0], offset);
      |         ^~~~~~~~~~~~~~~~~~
      |         tsunami_writeb


The tsunami_tig_{readb,writeb{}() functions are completely missing.
I don't see any macros that would generate such function names.

I have searched both kernel/git/history/history.git and
kernel/git/mpe/linux-fullhistory.git (both at git.kernel.org)
and found no such functions. (It's possible that I could have
missed something here: all I did was 'git grep tsunami_tig'.
Do I need to do 'git checkout <something really old>' first?)

Should these functions just be tsunami_readb() and tsunami_writeb()
like the compiler asks?
Or should we mark this driver as BROKEN?

Thanks.
-- 
~Randy
