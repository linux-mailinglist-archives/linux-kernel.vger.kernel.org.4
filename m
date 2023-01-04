Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84CA65DCB0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 20:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbjADTYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 14:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjADTYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 14:24:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AA324F;
        Wed,  4 Jan 2023 11:24:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1981B818B9;
        Wed,  4 Jan 2023 19:24:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87942C433EF;
        Wed,  4 Jan 2023 19:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672860252;
        bh=HMofFnLD4nMl6SokG6q6jiqDbjpbt0AiauT5OjkYS2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RJEvnwImU36uFY+yMmoyC8R/9RuH1XfrnRgaWSPWcowLcfxDhjSgh8qAAn7TPp1hR
         /rk5d3RH33uspdhXhNqPA7OughkCDWxxWDIKPcTmfX/XktNsCpUxPVna95rT5z7mrW
         /XvadQMdOVqWlPUiOProIicHKaU/T4uGYfTt747fr8vAXz8jOLij4AhDsuQxExIhTR
         RdCyC5Jzze3BRmiZJW/sjbu5qlyNwV1d+3zXEmlwE2hge7CzJxSL61cgG2e3dbXDuo
         bJ5QdcWllh6RP0kAyIva0mAnKokhQIezd7oDegEaFqWArNUWGL+aPPfyINDp9790ee
         7eAdt5pNxspkA==
Date:   Wed, 4 Jan 2023 12:24:09 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>
Subject: Re: [RFC PATCH tip] rseq: Fix: Increase AT_VECTOR_SIZE_BASE to match
 rseq auxvec entries
Message-ID: <Y7XSWdLZqwEXWXml@dev-arch.thelio-3990X>
References: <20230104192054.34046-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104192054.34046-1-mathieu.desnoyers@efficios.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 02:20:54PM -0500, Mathieu Desnoyers wrote:
> Two new auxiliary vector entries are introduced for rseq without
> matching increment of the AT_VECTOR_SIZE_BASE, which causes failures
> with CONFIG_HARDENED_USERCOPY=y.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Link: https://lore.kernel.org/r/Y7XJKZhuU9VJZQ11@dev-arch.thelio-3990X
> Fixes: 317c8194e6ae ("rseq: Introduce feature size and alignment ELF auxiliary vector entries")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

This resolves the boot failure with the configuration I tested:

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  include/linux/auxvec.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/auxvec.h b/include/linux/auxvec.h
> index f68d0ec2d740..407f7005e6d6 100644
> --- a/include/linux/auxvec.h
> +++ b/include/linux/auxvec.h
> @@ -4,6 +4,6 @@
>  
>  #include <uapi/linux/auxvec.h>
>  
> -#define AT_VECTOR_SIZE_BASE 20 /* NEW_AUX_ENT entries in auxiliary table */
> +#define AT_VECTOR_SIZE_BASE 22 /* NEW_AUX_ENT entries in auxiliary table */
>    /* number of "#define AT_.*" above, minus {AT_NULL, AT_IGNORE, AT_NOTELF} */
>  #endif /* _LINUX_AUXVEC_H */
> -- 
> 2.25.1
> 
