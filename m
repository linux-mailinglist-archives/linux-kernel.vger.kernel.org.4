Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E9E5E77A3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiIWJua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiIWJu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:50:26 -0400
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01542F646;
        Fri, 23 Sep 2022 02:50:23 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id CEEA01250;
        Fri, 23 Sep 2022 11:50:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1663926620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rsjnwaPBUJPxsfvMj/cndZRq66fUnmrOrL2fxzRC6eM=;
        b=Vo/KwCDEpx4d40kwWFj++T4igYTLUw9NzlU2K1j6bQCcPM1bDONFO0p0SdHvB15ph73J5+
        ljXz7N5HJuJQbLXYxoYUN54ohBOjysdyQF3yVM3BsPZC9rorCg6hABoPxsAnTYup5yiXug
        T0D0FgvjxrI0iuZr09OgUs0UKDHA5/+b54VFiCrNQdkJF8D8UStNpcu6ROLR7i0ic2oZjm
        sxqrNAKm70I51CL6hiM4JpwlI9ULLO+imFkBFHiAV12naDwWmehQZMomlcS+DzN6j8eYWv
        tUWgjDh4kteHN/ud1yuB1WOyP15OgfD/ANhT3bh2kmORbw+JHgj/eTCn7nP9HA==
From:   Michael Walle <michael@walle.cc>
To:     sfr@canb.auug.org.au
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, naoya.horiguchi@nec.com,
        Michael Walle <michael@walle.cc>
Subject: Re: linux-next: build failure after merge of the mm tree
Date:   Fri, 23 Sep 2022 11:50:13 +0200
Message-Id: <20220923095013.1151252-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220923175554.59431f7b@canb.auug.org.au>
References: <20220923175554.59431f7b@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> After merging the mm tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> drivers/base/memory.c: In function 'memory_block_online':
> drivers/base/memory.c:186:34: error: 'struct memory_block' has no member na=
> med 'nr_hwpoison'
>   186 |         if (atomic_long_read(&mem->nr_hwpoison))
>       |                                  ^~
> drivers/base/memory.c: In function 'remove_memory_block_devices':
> drivers/base/memory.c:870:61: error: 'struct memory_block' has no member na=
> med 'nr_hwpoison'
>   870 |                 clear_hwpoisoned_pages(atomic_long_read(&mem->nr_hw=
> poison));
>       |                                                             ^~
> 
> Caused by commit
> 
>   69b496f03bb4 ("mm/hwpoison: introduce per-memory_block hwpoison counter")
> 
> This build has CONFIG_MEMORY_FAILURE not set.

There also seems be more missing stubs. I'm getting:

aarch64-linux-gnu-ld: mm/memory-failure.o: in function `unpoison_memory':
memory-failure.c:(.text+0x1c38): undefined reference to `memblk_nr_poison_sub'
aarch64-linux-gnu-ld: mm/memory-failure.o: in function `num_poisoned_pages_inc':
memory-failure.c:(.text+0x2c8c): undefined reference to `memblk_nr_poison_inc'
aarch64-linux-gnu-ld: memory-failure.c:(.text+0x2cbc): undefined reference to `memblk_nr_poison_inc'

On a board where CONFIG_MEMORY_HOTPLUG is not set, but
CONFIG_MEMORY_FAILURE is. So either there are stubs missing or
MEMORY_FAILURE should depend MEMORY_HOTPLUG (?!).

-michael
