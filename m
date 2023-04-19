Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737CE6E7B3A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjDSNsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbjDSNsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:48:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9B51563E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:47:56 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681912075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2W7cHF0CcQVLza/dOUxMzsRdhC8wDgpB3UnYTaoj0vs=;
        b=RlKCya9H4v6vfKb4ZlndgGiZ6y4i7HdLu76HXvUl/ZK4Gf15RKzQvxcO2GzJb34GOj4kh0
        YAoNMgyipj36kVv5+WgrR9WBihM2SHd8Qca5Mbtk3MhLFwkkTcAnyL1/A8ET+chnYkMrgI
        X2qdNp7NDjwHEc2YytyIiW5puHnEDYIHEWai84FhWvnGEMpu1ZHMUCrSgn4cxnlYx0vVUy
        D26pT5RMgNX8iZFofod51y/kKfi7OFIJOTeqN8pHW616TdfG57UNFYhfr2aOupcUn1iIop
        nS0lg7Qnf8x2L/clpniNiMCI5OkM2OuVniSpvEQCKToQONuoBNgg28kP2JBt5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681912075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2W7cHF0CcQVLza/dOUxMzsRdhC8wDgpB3UnYTaoj0vs=;
        b=S4Gey5r+1JkeRHNygoE3P0PENGILKoD31pw52OQPTkzuvzjuURP5x0GZUB7AWF4s5LrQyX
        v2KXGiMiWWZGcLAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Enough to disable preemption in printk deferred
 context
In-Reply-To: <ZD_Yka6MJ_-HOKpj@alley>
References: <20230419074210.17646-1-pmladek@suse.com>
 <87r0sg5jin.fsf@jogness.linutronix.de> <ZD_Yka6MJ_-HOKpj@alley>
Date:   Wed, 19 Apr 2023 15:51:56 +0206
Message-ID: <87edog56jv.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-19, Petr Mladek <pmladek@suse.com> wrote:
> A solution would be to make this more clear in the comment.
> Something like:
>
> /*
>  * The printk_deferred_enter/exit macros are available only as a hack.
>  * They define a per-CPU context where all printk console printing
>  * is deferred because it might cause a deadlock otherwise.
>  *
>  * The API user is responsible for calling the corresponding enter/exit
>  * pair on the same CPU. It is highly recommended to use them only in
>  * a context with interrupts disabled. Otherwise, other unrelated
>  * printk() calls might be deferred when they interrupt/preempt
>  * the deferred code section.
>  */

I an happy with this comment. I saw Michal's follow-up suggestion, but
would prefer this one. It is a more technical desciption of the issue
and clearly recommends that the user should disable interrupts.

If you use this comment:

Reviewed-by: John Ogness <john.ogness@linutronix.de>

> Another solution would be to stay on the "safe" side and keep the
> comment as is or even enforce disabling interrupts by the API.
>
> I would personally just improve the comment. It is good to describe
> the situation correctly. We could always add restrictions when
> there are problems in practice.

Agreed.

John
