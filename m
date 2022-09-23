Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951945E7E63
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbiIWP3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbiIWP2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:28:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4F71449E7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:28:52 -0700 (PDT)
Date:   Fri, 23 Sep 2022 17:28:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663946930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gk9gcvlo/Cf6nASsIYWh2vXbUIG2+pTAh4LHjw+3c+M=;
        b=aBLtD+Tj7TqIcPVJmD6wi/0l1qu6iREKQ/o/CPAlmGO7jicd5GNsBCiXDXToQ6RANTjYL7
        BjRon/3/nl+oUBhLZd9IqTZHZkKDPfbZvM1Rs5gbYc+MvpsgmDpKgxeHuss5/t63ZACLo4
        hmhNZEHExga9BIm+xpESmZb07kilYBRcj1AVofaWBCaibf6LRFc6D/82oTX2e9DIdPb+n7
        51hMlzX8fJqSo4bkeyjF54QUhYfUDwK83k7gl3cTZN+DujqkVETe5CeUuKE3wL8Y16lk7J
        qFnZr+EIDFngdt5/C+lq61AQXbd9XZnHnC7QCTGybPNWCkc7Y6v9KjlT8S8PGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663946930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gk9gcvlo/Cf6nASsIYWh2vXbUIG2+pTAh4LHjw+3c+M=;
        b=C5BkYACKkc7pEpurtnpsUiVKZWbSXWrNCoU1cM+u913KxWdo15ujYR+56BcQUNbKqbbj9J
        AEPK251Wafw8bKAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2 v3] lib/vsprintf: Initialize vsprintf's pointer hash
 once the random core is ready.
Message-ID: <Yy3QsWDaRAdYEiyg@linutronix.de>
References: <20220729154716.429964-1-bigeasy@linutronix.de>
 <20220729154716.429964-3-bigeasy@linutronix.de>
 <YuRtSGCfe2qxHrqT@zx2c4.com>
 <YueBnnnnvpxxjE4N@linutronix.de>
 <YueeIgPGUJgsnsAh@linutronix.de>
 <CAHmME9rZj9S62RngnYhkvj7is6Qi4wx0St-PiOwrLON-cW0OoA@mail.gmail.com>
 <Yy2MSm1zIRWa2BT4@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yy2MSm1zIRWa2BT4@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-23 12:36:58 [+0200], Petr Mladek wrote:
> v3 is still using two patches and there was some discussion about
> adding __read_mostly.
> 
> Sebastian, could you please re-send a cleaned up patch(set). Also it would
> be to get/add there also Acked-by from Jason.
> 
> Thanks in advance.

I wanted to have done that already but I'm backlogged. I hope to get it
done early next week.

> Best Regards,
> Petr

Sebastian
