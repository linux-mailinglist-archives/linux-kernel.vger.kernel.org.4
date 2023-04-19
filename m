Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F086E7773
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 12:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjDSKch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 06:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjDSKb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 06:31:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B70913858
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 03:31:46 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 37D6A1FD87;
        Wed, 19 Apr 2023 10:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681900305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OGKAy4N0T/4jotT8qmbcXDsH0pxSP2/5E3cQhQqsEOM=;
        b=FKLRDDvRY/q1fMiGAUd4FZEFgUYN6iaYwCJHaXFT9xCLGODWkcM1MIiJICE7d99t5RVDqD
        fEQC9R987THCUyTUIbUvE6yFY5+lhorpFNW4Bru6n3smZfbXKplRoRP/PPIYFMVDZc127O
        SuM56Eq8P1SvQIg0XeqldtSGdmY7Gw0=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BCF7B2C141;
        Wed, 19 Apr 2023 10:31:44 +0000 (UTC)
Date:   Wed, 19 Apr 2023 12:31:44 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Enough to disable preemption in printk deferred
 context
Message-ID: <ZD_DED6ttnLvUJsI@alley>
References: <20230419074210.17646-1-pmladek@suse.com>
 <ZD+lBU1PGkLadDMT@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZD+lBU1PGkLadDMT@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-04-19 10:23:33, Michal Hocko wrote:
> On Wed 19-04-23 09:42:10, Petr Mladek wrote:
> > The comment above printk_deferred_enter()/exit() definition claims
> > that it can be used only when interrupts are disabled.
> > 
> > It was required by the original printk_safe_log_store() implementation.
> > The code provided lockless synchronization between a single writer and
> > a single reader. The interrupt and the normal context shared the same
> > buffer.
> > 
> > The commit 93d102f094be ("printk: remove safe buffers") removed
> > these temporary buffers. Instead, the messages are stored directly into
> > the new global lockless buffer which supports multiple parallel writers.
> > 
> > As a result, it is safe to interrupt one writer now. The preemption still
> > has to be disabled because the deferred context is CPU specific.
> 
> Thanks for the clarification and explanation.
> 
> > Fixes: 93d102f094be ("printk: remove safe buffers")
> 
> Is this a fix though? I would expect some users to be changed from irq
> to preempt to disabling to be considered a fix.

Yeah, I am not sure about the Fixes tag either. I wanted to cross-link
the two commits. But it is probably enough to mention it in the commit
message.

Best Regards,
Petr
