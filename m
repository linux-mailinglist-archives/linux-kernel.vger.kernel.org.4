Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8B66E74EE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjDSIXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbjDSIXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:23:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74E8113
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:23:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 72D7C1FD8B;
        Wed, 19 Apr 2023 08:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681892614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=75D13D0LUebYcEJ9NM2sXESbsiUK/Wt0lgxoIsRvT1Q=;
        b=OLZ2UIpr7Cvswbp0AxgUGiRbBt1Md8aNcKzxAivVEwp1L24/nKJ8kDkcQlusgx4tDO6cAi
        nCDcK+wbvJcR6ZANOiIalnR0H9mOSTtC4bary7wDK2nUpwl7CaHGQ/xtokH+9dVfNvkR4c
        786qh0jzlu6swyZOKvis8GvzwWDwZJQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4CFBD1390E;
        Wed, 19 Apr 2023 08:23:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 95v1DwalP2Q1YgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 19 Apr 2023 08:23:34 +0000
Date:   Wed, 19 Apr 2023 10:23:33 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Enough to disable preemption in printk deferred
 context
Message-ID: <ZD+lBU1PGkLadDMT@dhcp22.suse.cz>
References: <20230419074210.17646-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419074210.17646-1-pmladek@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-04-23 09:42:10, Petr Mladek wrote:
> The comment above printk_deferred_enter()/exit() definition claims
> that it can be used only when interrupts are disabled.
> 
> It was required by the original printk_safe_log_store() implementation.
> The code provided lockless synchronization between a single writer and
> a single reader. The interrupt and the normal context shared the same
> buffer.
> 
> The commit 93d102f094be ("printk: remove safe buffers") removed
> these temporary buffers. Instead, the messages are stored directly into
> the new global lockless buffer which supports multiple parallel writers.
> 
> As a result, it is safe to interrupt one writer now. The preemption still
> has to be disabled because the deferred context is CPU specific.

Thanks for the clarification and explanation.

> Fixes: 93d102f094be ("printk: remove safe buffers")

Is this a fix though? I would expect some users to be changed from irq
to preempt to disabling to be considered a fix.

> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  include/linux/printk.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 8ef499ab3c1e..915a321b491e 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -161,7 +161,7 @@ extern void __printk_safe_enter(void);
>  extern void __printk_safe_exit(void);
>  /*
>   * The printk_deferred_enter/exit macros are available only as a hack for
> - * some code paths that need to defer all printk console printing. Interrupts
> + * some code paths that need to defer all printk console printing. Preemption
>   * must be disabled for the deferred duration.
>   */
>  #define printk_deferred_enter __printk_safe_enter
> -- 
> 2.35.3

-- 
Michal Hocko
SUSE Labs
