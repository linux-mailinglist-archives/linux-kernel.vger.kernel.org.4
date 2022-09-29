Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAD95EF0E2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbiI2IwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbiI2IwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:52:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA99312ED89
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:52:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 74B1B21B9B;
        Thu, 29 Sep 2022 08:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664441523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ffWNYmFzwrjWe/3G6b1ASR1aTachXTJ2+796fvJOEPg=;
        b=mkdGZEPVkeuo0nZiAXHPXQDBjcYkjILKqlyu9PP5fPa8TSAnOHSmaUh23EOcypGiMOU5zr
        DDYDaI+NAxcWMgEzb/nncqpFRieZveBnnEFS6G3W5BAhh/gzBzHL/Cb8P3+ruQ2/hFd0eY
        5UyUpukd8tA7fPd22QRNxCs4VCWJLq4=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 58F652C146;
        Thu, 29 Sep 2022 08:51:56 +0000 (UTC)
Date:   Thu, 29 Sep 2022 10:52:02 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4 2/2] lib/vsprintf: Initialize vsprintf's pointer hash
 once the random core is ready.
Message-ID: <YzVcsvw3wv0FVOZO@alley>
References: <20220927104912.622645-1-bigeasy@linutronix.de>
 <20220927104912.622645-3-bigeasy@linutronix.de>
 <YzMnb8NWlCpqsqSG@alley>
 <YzQP2OEVKgWtwsD4@linutronix.de>
 <CAHmME9qzBRDfUh1vN6qW6BFuFz_qcuaEOR13Ojx2CzC_+CHxUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9qzBRDfUh1vN6qW6BFuFz_qcuaEOR13Ojx2CzC_+CHxUw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-09-28 11:21:05, Jason A. Donenfeld wrote:
> On 9/28/22, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> >
> >> I could replace "system_unbound_wq" with "system_wq" when
> >> pushing. Is anybody against it, please?
> >
> > so schedule_delayed_work() then?

yup.

> > I don't mind at all. I used that one just because serialisation is not
> > needed and neither is the CPU important.
> 
> Indeed, given that this very much is unbound, I think Sebastian's
> original patch makes most sense.

Yes, the work does not need any specific CPU. The thing is that the
normal system_wq is the preferred one. Any other workqueues should
be used only when there is a particular reason for it.

The unbound_wq should be used only when:

    + the work needs a lot of CPU time.

    + there are waves on related (sleeping) work items that might be
      triggered from different CPUs.

In our case, the work is only one and short. The preferred
system_wq is perfectly fine.

Best Regards,
Petr

PS: It is not obvious. Tejun told me this when I converted a kthread
    into the workqueue API. Also I spent quite some time understanding
    the workqueue code recently.
