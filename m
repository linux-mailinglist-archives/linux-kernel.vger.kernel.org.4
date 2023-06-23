Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA7A73B283
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjFWIQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjFWIQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:16:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465E82101;
        Fri, 23 Jun 2023 01:16:01 -0700 (PDT)
Date:   Fri, 23 Jun 2023 10:15:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687508158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2w10Bg1hP0PyHU+ZgyHBS1JxUz7cUF7arvkGjIAKjoE=;
        b=D8myK6qLyHRdO1I/CYnAqxD7Pin/G4Z0Q7ieSFjQBctFoD78v0mqxD9ZDNu1weQSiicypU
        xQJZ+e6CpF28h+9ZFrVHf51h9aOlKrZYvd9Eol/uA+a4KLg+5QanvxC2gmklIU7A4Fvnov
        /tL5baq5gq+0amqnSs87KaLDBCjSf0ZbfTTFsFaJEEw3+T1nuqaIKv56zodwj8ODxvahS8
        uelOiK0ycjc0kMlkXuwvzgQDIszBwLyad+qayIBOopwRMZHfgBzPkE3CwUijfon31YPVRM
        hwKHEgcZ20jt4JN4bV6jnz99ZYKLqfIk6OqtfSDtR6TRPYipw0hK1K7D13divg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687508158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2w10Bg1hP0PyHU+ZgyHBS1JxUz7cUF7arvkGjIAKjoE=;
        b=e/RyvS2LothzM8LaAY3PrI6/2QR4j9vr5W47+EU/qP64klC6cu8lI5sd9memtdnypr+rn5
        CnSpW1x6fS2DuHDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Aaron Lu <aaron.lu@intel.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [tip: sched/core] sched: Fix performance regression introduced
 by mm_cid
Message-ID: <20230623081557.gf5xCGdD@linutronix.de>
References: <09e0f469-a3f7-62ef-75a1-e64cec2dcfc5@amd.com>
 <20230620091139.GZ4253@hirez.programming.kicks-ass.net>
 <44428f1e-ca2c-466f-952f-d5ad33f12073@amd.com>
 <3e9eaed6-4708-9e58-c80d-143760d6b23a@efficios.com>
 <ddbd1564-8135-5bc3-72b4-afb7c6e9caba@amd.com>
 <a73761e4-b791-e9a2-a276-e1551628e33b@efficios.com>
 <6c693e3b-b941-9acf-6821-179e7a7fe2b8@efficios.com>
 <f94cd9fa-1a83-1f54-0259-123fcd86d549@canonical.com>
 <20230623063726.ejuc6v9D@linutronix.de>
 <1d8d0032-261f-fe35-0c12-23043083e676@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1d8d0032-261f-fe35-0c12-23043083e676@canonical.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-23 00:16:35 [-0700], John Johansen wrote:
> With that said the patch does work, and seems to be stable in the broader
> testing it has gotten. Its more complicated than I would like, and wanted to
> play with ideas around improving it. I also wanted get some better benchmark data.
> All things I just haven't had time for

If you tell me what to do (as in run this) I could try to run it on a
machine. The current version, your proposal and kmalloc() instead.

> I am also not opposed to using some version of this patch now, to solve the
> immediate needs and working to improve it after the fact.

Sebastian
