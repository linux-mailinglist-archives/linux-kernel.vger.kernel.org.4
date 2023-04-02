Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E146D39DE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 20:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjDBSlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 14:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDBSlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 14:41:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CFE1BDA
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 11:41:14 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1680460872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vOAe02m0v3qDETcBzJiDSGNWOB01qggz4Kl6zoi37XU=;
        b=wyGqL9lMerN9OZdPk08ub4F9a1DhP3JEe6JuaNIDjK2ZLolaYKrfASJZfSNMB8tbIKsFzU
        SPp/rMxWHP8JCucf7dXS5m4hMV4z99Y6ol1cJuzhCRY3ziKM9Ra/hW7Etam+4/C7dhqC9M
        RboNXVvG8DegcjDfVlY6MV3qemTYKimVwrUZ59zJBlPQs2YRiyy9prcFKLGGEIyXzRhFk2
        FhB2h0kOOB+VNW6NxrRoIFwT/H17FhMDt+xXixaajzquMepepMJoAYGTYSIrbJU4ufULRR
        /Uh+8FCs2MDGH/Hh+kSPmGfmgY2FG+KN+I9mbzcdVKdVA6u8LPDDtLImlMaBJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1680460872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vOAe02m0v3qDETcBzJiDSGNWOB01qggz4Kl6zoi37XU=;
        b=XlX+XaVh1vMbwHKbwGiJaohCm3pWyGmwsYWu0Oq49Nkaybn5/9zR29tq2eI2KQQC0x22CT
        smAwAbGQYlLfASAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: simplify: was: Re: [PATCH printk v1 06/18] printk: nobkl: Add
 acquire/release logic
In-Reply-To: <ZBnPEaJKdHyTtUNS@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-7-john.ogness@linutronix.de>
 <ZBSkoKCdG5uiVNPq@alley> <ZBnPEaJKdHyTtUNS@alley>
Date:   Sun, 02 Apr 2023 20:45:27 +0206
Message-ID: <87h6ty9li8.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-21, Petr Mladek <pmladek@suse.com> wrote:
> I would prefer to do the logic change. It might help with review
> and also with the long term maintenance.

As a test I have implemented many of your suggestions. Following your
ideas of simplification, I have also found other areas where things can
be simplified without sacrificing functionality. Thanks for taking the
time to propose an alternate simplified implementation.

John
