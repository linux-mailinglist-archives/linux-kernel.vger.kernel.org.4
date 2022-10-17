Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A873600F23
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiJQMXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiJQMXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:23:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094B65C976;
        Mon, 17 Oct 2022 05:22:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4243C218B0;
        Mon, 17 Oct 2022 12:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1666009350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mewzSTIGGxkGiHot6bRTFd+4P1VqYOY9FFhGowKMq1s=;
        b=E5Zq/gfIBnkozXR3mViAhr7Z1y6MF/YsEvmi8JEQlvnz4KNoHkXkU3ZxuE9ersZfhZcEfk
        /DAJ4caKEsGeOm022IB+s7h+ktj4es/Ds5TxJnUbJOd5w3RGGaFIBFWZNHAov2crmHtPVk
        L7mM5g4vkCXYCRTuYWv18gtS7YhY2J0=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1F4382C141;
        Mon, 17 Oct 2022 12:22:30 +0000 (UTC)
Date:   Mon, 17 Oct 2022 14:22:27 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     mcgrof@kernel.org, david@redhat.com, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] module: Update a comment describing what is
 protected by module_mutex
Message-ID: <Y01JA8vzY3uVSJeY@alley>
References: <20221016123031.3963-1-petr.pavlu@suse.com>
 <20221016123031.3963-3-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221016123031.3963-3-petr.pavlu@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2022-10-16 14:30:29, Petr Pavlu wrote:

> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  kernel/module/main.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index a12e177ea81f..5288843ca40f 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -62,10 +62,11 @@
>  
>  /*
>   * Mutex protects:
> - * 1) List of modules (also safely readable with preempt_disable),
> + * 1) list of modules (also safely readable with preempt_disable, delete and add

This is slightly over 80 characters per line ;-)

It is not reported by checkpatch.pl because the longer line sometimes
makes the code better readable. So people asked to make checkpatch.pl
more relaxed and accept lines < 100. But the 80-characters per-line
rule is still there. It should be honored when it does not make things
visibly worse.

> + *    uses RCU list operations).



>   * 2) module_use links,
> - * 3) mod_tree.addr_min/mod_tree.addr_max.
> - * (delete and add uses RCU list operations).
> + * 3) mod_tree.addr_min/mod_tree.addr_max,
> + * 4) list of unloaded_tainted_modules.

Please, mention that this list can be safely read using RCU.
It is similar to the list of modules.

Also it would be nice to mention the commit 99bd9956551b27cb6f
("module: Introduce module unload taint tracking") in the commit
message. It helps to find the related code. Also this is kind
of a followup fix.

>   */
>  DEFINE_MUTEX(module_mutex);
>  LIST_HEAD(modules);

All the above are minor or cosmetic issues. Feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
