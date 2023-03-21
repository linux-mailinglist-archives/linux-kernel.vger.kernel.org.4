Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0D36C35FB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjCUPlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjCUPlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:41:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E6B1B9;
        Tue, 21 Mar 2023 08:41:39 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679413297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LXy5LgYiAHmmAkAVHJgMKUKL0Wktzd7T/FU/Lc2O9Hg=;
        b=SXdZpKkgw/SS0j59cY/a26Z/lg9fqxlA9xY4QxwV+HjegK6Z1xnoKgFbuMiXo0r4lEWG3e
        /O/bQldercnlCIS7k5moELVGf73k/Kpf2110n/dh7s9efIBatb5Cv8wf5MVCMATvSkZtqs
        Kc0KDmEcbsj0gBbI/9s4vYKXRTDzqu6uuOzx45MS833Isxr78BvDS8gVrm8JWXKkJspepj
        JYqlimu5CdBaH9jX2MlOhwiSKSf+yovqg01F+RF2/2YeEo9teMy62GuchOw019WQiD7DGp
        brNgkmh+XDY4Qz4D7SeeKb96/b1cjcCbkdiXXtTPZT56fdgvzYpG2AxDXXKfOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679413297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LXy5LgYiAHmmAkAVHJgMKUKL0Wktzd7T/FU/Lc2O9Hg=;
        b=AfdkmM7AM4K2iEIxkqTbNRIxfz23zw8XsHeL85ZU9l+S3J+N7LAC5w4rzH9Xw9JsTwgBvw
        MSaQ5WyI7hhSK0Dg==
To:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, oleg@redhat.com, avagin@gmail.com,
        peterz@infradead.org, luto@kernel.org, krisman@collabora.com,
        corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v13 1/3] syscall_user_dispatch: helper function to
 operate on given task
In-Reply-To: <20230301205843.2164-2-gregory.price@memverge.com>
References: <20230301205843.2164-1-gregory.price@memverge.com>
 <20230301205843.2164-2-gregory.price@memverge.com>
Date:   Tue, 21 Mar 2023 16:41:37 +0100
Message-ID: <87cz529kni.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory!

On Wed, Mar 01 2023 at 15:58, Gregory Price wrote:
> +static int task_set_syscall_user_dispatch(struct task_struct *task, unsigned long mode,
> +					  unsigned long offset, unsigned long len,
> +					  char __user *selector)
>  {
>  	switch (mode) {
>  	case PR_SYS_DISPATCH_OFF:
        ...

	case PR_SYS_DISPATCH_ON:
		if (selector && !access_ok(selector, sizeof(*selector)))
			return -EFAULT;

I'm not seing how this can work on ARM64 when user pointer tagging is
enabled in the tracee, but not in the tracer. In such a case, if the
pointer is tagged, access_ok() will fail because access_ok() wont untag
it.

Thanks,

        tglx
