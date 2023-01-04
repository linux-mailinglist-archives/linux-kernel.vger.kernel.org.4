Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14EF65D6B7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239487AbjADO6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbjADO6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:58:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ED939FB2
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 06:58:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08AB5B81339
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 14:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DEBC43392;
        Wed,  4 Jan 2023 14:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672844324;
        bh=X1AAIn1JCwOQYsbeGXY+bK+m5zW1QQ+OXoCh04OSGhw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dsWfbzf6UpefT3nvlAW2+mmoBZrvwGHtzuXTpJea+7S8F1k14QDJtXD3pDFtSR6Ri
         nQKqkkzHY9XYQ0LRMdhZEab7uq7ZRguwsS4V9o6ZOn09ynNhaOZqHXZiDXTKBJvWIJ
         QEfIhnNjk0Lhsbcw169G+inpEOZjPBgMctZi3PgoOR0+Ovfnk1YTzCy1k17H4YIVot
         phl0bc/AeGj3Hlyx3vhJT7xqbsK5IxJLdWTCfv0TIX7rEkZUaVYY2WCFM7lAPa2m3Z
         W3w6yCaukh7TK7SsxE57XdRGg8K5hc1+pucJiNpMVjljGf2yJ5jRvSQVb83rtOT1ZY
         4YyP56K2uDI7Q==
Date:   Wed, 4 Jan 2023 14:58:39 +0000
From:   Lee Jones <lee@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Andres Salomon <dilinger@queued.net>,
        linux-geode@lists.infradead.org
Subject: Re: [PATCH] mfd: cs5535: don't build on UML
Message-ID: <Y7WUHyHiJbAgXcaM@google.com>
References: <20221201012541.11809-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221201012541.11809-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2022, Randy Dunlap wrote:

> The cs5535-mfd driver uses CPU-specific data that is not available
> for ARCH=um builds, so don't allow it to be built for UML.
> 
> Prevents these build errors:
> 
> In file included from ../arch/x86/include/asm/olpc.h:7,
>                  from ../drivers/mfd/cs5535-mfd.c:17:
> ../arch/x86/include/asm/geode.h: In function ‘is_geode_gx’:
> ../arch/x86/include/asm/geode.h:16:31: error: ‘struct cpuinfo_um’ has no member named ‘x86_vendor’
>    16 |         return ((boot_cpu_data.x86_vendor == X86_VENDOR_NSC) &&
> ../arch/x86/include/asm/geode.h:16:46: error: ‘X86_VENDOR_NSC’ undeclared (first use in this function); did you mean ‘X86_VENDOR_ANY’?
>    16 |         return ((boot_cpu_data.x86_vendor == X86_VENDOR_NSC) &&
> ../arch/x86/include/asm/geode.h:17:31: error: ‘struct cpuinfo_um’ has no member named ‘x86’
>    17 |                 (boot_cpu_data.x86 == 5) &&
> ../arch/x86/include/asm/geode.h:18:31: error: ‘struct cpuinfo_um’ has no member named ‘x86_model’
>    18 |                 (boot_cpu_data.x86_model == 5));
> ../arch/x86/include/asm/geode.h: In function ‘is_geode_lx’:
> ../arch/x86/include/asm/geode.h:23:31: error: ‘struct cpuinfo_um’ has no member named ‘x86_vendor’
>    23 |         return ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) &&
> ../arch/x86/include/asm/geode.h:23:46: error: ‘X86_VENDOR_AMD’ undeclared (first use in this function); did you mean ‘X86_VENDOR_ANY’?
>    23 |         return ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD) &&
> ../arch/x86/include/asm/geode.h:24:31: error: ‘struct cpuinfo_um’ has no member named ‘x86’
>    24 |                 (boot_cpu_data.x86 == 5) &&
> ../arch/x86/include/asm/geode.h:25:31: error: ‘struct cpuinfo_um’ has no member named ‘x86_model’
>    25 |                 (boot_cpu_data.x86_model == 10));
> 
> Fixes: 68f5d3f3b654 ("um: add PCI over virtio emulation driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: linux-um@lists.infradead.org
> Cc: Andres Salomon <dilinger@queued.net>
> Cc: linux-geode@lists.infradead.org
> Cc: Lee Jones <lee@kernel.org>
> ---
>  drivers/mfd/Kconfig |    1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
