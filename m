Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0906E7973
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjDSMOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjDSMOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:14:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0064755BE
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:14:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6E6C81FD8B;
        Wed, 19 Apr 2023 12:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681906456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P75V+PHCMLRraJ75ssd9S6FUz/in7e36rjP7Uvyk1M0=;
        b=j1vKSRL4ILQL3REI4O2rzaEGsUxK5VAzhbkZMe3cXH2+EiMZ4JD0to7agaVvNPf4xX1GTt
        nWeh3DqzBRugu0RerHtiSW3a+mPmyaeEKf9k5EucFhUfLp93K5jdYJbBpTIUiga3yt9D6X
        0o3/vQsH2C7yJkgzXUE3PSX68xpt7bA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5283C13580;
        Wed, 19 Apr 2023 12:14:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 86TOERjbP2S8fwAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 19 Apr 2023 12:14:16 +0000
Date:   Wed, 19 Apr 2023 14:14:15 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Enough to disable preemption in printk deferred
 context
Message-ID: <ZD/bF6Tev9ujlkBY@dhcp22.suse.cz>
References: <20230419074210.17646-1-pmladek@suse.com>
 <87r0sg5jin.fsf@jogness.linutronix.de>
 <ZD_Yka6MJ_-HOKpj@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZD_Yka6MJ_-HOKpj@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-04-23 14:03:29, Petr Mladek wrote:
> On Wed 2023-04-19 11:11:52, John Ogness wrote:
> > On 2023-04-19, Petr Mladek <pmladek@suse.com> wrote:
> > > it is safe to interrupt one writer now. The preemption still
> > > has to be disabled because the deferred context is CPU specific.
> > 
> > Really it is enough to disable migration.
> 
> True. But it gets too far to my taste. As you describe below.
> It affects all printk's on the CPU.
> 
> Sigh, even the enabled intrrupts might be questionable. For example,
> when the iterrupt is from a watchdog and want's to report a stall.
> 
> > We need to keep an eye on the usage of this function. By allowing
> > interrupts and preemption, it means that other printk's on that CPU will
> > also be deferred if the context interrupted within the deferred block.
> 
> A solution would be to make this more clear in the comment.
> Something like:
> 
> /*
>  * The printk_deferred_enter/exit macros are available only as a hack.
>  * They define a per-CPU context where all printk console printing is
>  * deferred because it might cause a deadlock otherwise.
>  *
>  * The API user is responsible for calling the corresponding enter/exit
>  * pair on the same CPU. It is highly recommended to use them only in
>  * a context with interrupts disabled. Otherwise, other unrelated
>  * printk() calls might be deferred when they interrupt/preempt
>  * the deferred code section.
>  */

This looks better but I would argue that as a potential user of those I
would appreciate less internal implementation details and more
instructions on how/when to use it. What about something like this?

/*
 * The printk_deferred_enter/exit macros are available only as a hack
 * for code paths which are prone to printk related deadlocks. That
 * might be caused by locking context around printk which can be reused
 * directly or indirectly by lower level printk infrastructure.
 * 
 * Any new use of these MUST be consulted with printk maintainers as the
 * use might have some unexpected side effects on the printk
 * infrastructure.
 *
 * enter/exit pair must be called from the same CPU without any
 * preemption in between.
 */
-- 
Michal Hocko
SUSE Labs
