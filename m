Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDAD6288A4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbiKNS5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiKNS5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:57:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3DA1C405
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:57:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A66B61366
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:57:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6249C433D6;
        Mon, 14 Nov 2022 18:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668452241;
        bh=dqtnDCRCSgBFtivgXi8hVlUMz8eeEw/iDCweBbGxILw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YNAtHG/ZFiR8hnpoTpbNMdeN+M4V9GjLLoaPwkRom6Nre+4ygMdJjhTnExj7Rs2Rl
         wJXdMdzTNJW/G543NcBc3VQkihuM/uCC5C243Xk+aZzcMi+LuQkfRo68toaUGP/dak
         k0KLGvAJImJH2F5UewQc03uEw6wwCpjLELUDuGTdn8trtkzRycIIXsBSh/CnIAZuRF
         DAFQ7lYx2SsgMhKlqPOFCzXv17NyFMvWpLxrnWlD0vqlcD/WJHuQmMDEZQJLTxCMgC
         jGtsWZwQzdr5x5lpAYi/bOu/8aN92FOsWp9Yx5p5wyeMujzlGn3CUWhhJB9lFKZG2Q
         cIPoBsd4ZttnA==
Date:   Mon, 14 Nov 2022 10:57:18 -0800
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Martin Liska <mliska@suse.cz>, Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 08/46] static_call, lto: Mark static keys as __visible
Message-ID: <20221114185718.kladzjm4ulcnq7bj@treble>
References: <20221114114344.18650-1-jirislaby@kernel.org>
 <20221114114344.18650-9-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221114114344.18650-9-jirislaby@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 12:43:06PM +0100, Jiri Slaby (SUSE) wrote:
> From: Andi Kleen <andi@firstfloor.org>
> 
> Symbols referenced from assembler (either directly or e.f. from
> DEFINE_STATIC_KEY()) need to be global and visible in gcc LTO because
> they could end up in a different object file than the assembler. This
> can lead to linker errors without this patch.
> 
> So mark static call functions as __visible, namely static keys here.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Jason Baron <jbaron@akamai.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Andi Kleen <andi@firstfloor.org>
> Signed-off-by: Martin Liska <mliska@suse.cz>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  include/linux/static_call.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/static_call.h b/include/linux/static_call.h
> index df53bed9d71f..e629ab0c4ca3 100644
> --- a/include/linux/static_call.h
> +++ b/include/linux/static_call.h
> @@ -182,7 +182,7 @@ extern long __static_call_return0(void);
>  
>  #define DEFINE_STATIC_CALL(name, _func)					\
>  	DECLARE_STATIC_CALL(name, _func);				\
> -	struct static_call_key STATIC_CALL_KEY(name) = {		\
> +	__visible struct static_call_key STATIC_CALL_KEY(name) = {		\

Why not __visible_on_lto?

-- 
Josh
