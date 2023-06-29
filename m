Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F22742E37
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 22:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjF2UUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 16:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjF2UUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:20:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3079212C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 13:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=G4aKGQZW2tDX+vXfJyGauKoWl6DfTIBE5I6uDMBxHgE=; b=L8K5AWNrb89HzyB4OAJUBaOZm7
        C6f1gpe9BXwFc5vYRJFo8yEcTkOX3ei8JdPb91W6hJ81BzNcOJIalQL9CMEa7dzBXuQYPUizjP8sF
        zBMiuvee3YtAsP3cZGn2DH2vfExLZ5lqBZmSeIf1EoBgK2W5rke2VezSAC7EJzPHcNFuktYoEDHg4
        yfavK46M4KplZA1479Ni9ZtdmR0OCB2+ql5xyHMv4wPuFPbUepEJappzlcO2SiDoRUnV8eZhX142E
        XLAxPsWfbDaZHX8i/LPnNKvQ8qCDnjn0gM3KiywB87YfWJtu/oYPfG7ulkay/Ik3/UY5x5ArbGJ6M
        jH3+66XA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEy7P-0023jo-0n;
        Thu, 29 Jun 2023 20:19:55 +0000
Message-ID: <2192df88-a17b-301d-54ff-310c031b2561@infradead.org>
Date:   Thu, 29 Jun 2023 13:19:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] powerpc: Include asm/nmi.c in mobility.c for
 watchdog_hardlockup_set_timeout_pct()
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Haren Myneni <haren@linux.ibm.com>,
        Jilin Yuan <yuanjilin@cdjrlc.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20230629124500.1.I55e2f4e7903d686c4484cb23c033c6a9e1a9d4c4@changeid>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230629124500.1.I55e2f4e7903d686c4484cb23c033c6a9e1a9d4c4@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/23 12:45, Douglas Anderson wrote:
> The powerpc/platforms/pseries/mobility.c calls
> watchdog_hardlockup_set_timeout_pct(), which is declared in
> <asm/nmi.h>. We used to automatically get <asm/nmi.h> included, but
> that changed as of commit 7ca8fe94aa92 ("watchdog/hardlockup: define
> HARDLOCKUP_DETECTOR_ARCH"). Let's add the explicit include.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/r/af19b76d-aa4b-6c88-9cac-eae4b2072497@infradead.org
> Fixes: 7ca8fe94aa92 ("watchdog/hardlockup: define HARDLOCKUP_DETECTOR_ARCH")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
> 
>  arch/powerpc/platforms/pseries/mobility.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
> index cd632ba9ebff..0161226d8fec 100644
> --- a/arch/powerpc/platforms/pseries/mobility.c
> +++ b/arch/powerpc/platforms/pseries/mobility.c
> @@ -24,6 +24,7 @@
>  #include <linux/stringify.h>
>  
>  #include <asm/machdep.h>
> +#include <asm/nmi.h>
>  #include <asm/rtas.h>
>  #include "pseries.h"
>  #include "vas.h"	/* vas_migration_handler() */

-- 
~Randy
