Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BB06E7948
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjDSMDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjDSMDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:03:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982854C1F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:03:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 46A18219A0;
        Wed, 19 Apr 2023 12:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681905810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zcbbH9f/2oMNPoZxU2kXYRve4Q/BaeK2CpvhClmUfIQ=;
        b=MOWHkpdEXMRZsgsLOlmkzSybu7a621wg5cincJDavuBB/6fqT3E8XJxmn9TfXn6oRlloCq
        rJ5bKBB2YltirfBEr1m4f11CTS89Caf1Z6S4m1nDmWf0AbNfbeXwX8XdCFiJA+cnulN+1N
        MWcjHbLRAq9QISsp1BgsYaEAVNZTO0I=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BC7C32C141;
        Wed, 19 Apr 2023 12:03:29 +0000 (UTC)
Date:   Wed, 19 Apr 2023 14:03:29 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Enough to disable preemption in printk deferred
 context
Message-ID: <ZD_Yka6MJ_-HOKpj@alley>
References: <20230419074210.17646-1-pmladek@suse.com>
 <87r0sg5jin.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0sg5jin.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-04-19 11:11:52, John Ogness wrote:
> On 2023-04-19, Petr Mladek <pmladek@suse.com> wrote:
> > it is safe to interrupt one writer now. The preemption still
> > has to be disabled because the deferred context is CPU specific.
> 
> Really it is enough to disable migration.

True. But it gets too far to my taste. As you describe below.
It affects all printk's on the CPU.

Sigh, even the enabled intrrupts might be questionable. For example,
when the iterrupt is from a watchdog and want's to report a stall.

> We need to keep an eye on the usage of this function. By allowing
> interrupts and preemption, it means that other printk's on that CPU will
> also be deferred if the context interrupted within the deferred block.

A solution would be to make this more clear in the comment.
Something like:

/*
 * The printk_deferred_enter/exit macros are available only as a hack.
 * They define a per-CPU context where all printk console printing is
 * deferred because it might cause a deadlock otherwise.
 *
 * The API user is responsible for calling the corresponding enter/exit
 * pair on the same CPU. It is highly recommended to use them only in
 * a context with interrupts disabled. Otherwise, other unrelated
 * printk() calls might be deferred when they interrupt/preempt
 * the deferred code section.
 */

Another solution would be to stay on the "safe" side and keep the
comment as is or even enforce disabling interrupts by the API.

I would personally just improve the comment. It is good to describe
the situation correctly. We could always add restrictions when
there are problems in practice.

Best Regards,
Petr
