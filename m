Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9C864E01C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiLOR6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiLOR63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:58:29 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095F6389EE
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:58:28 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id c1so16872539lfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=38UxcYPj+ZJxWmmAMOiK5v5tLaOBZZGjUg3oW8gg23w=;
        b=USelrgDSqDkdFFiYCI3jh0GYMDbbbVG7gDylGDCH8RxHaFKZ69JGRkY8gsn3xE/lr1
         VbgeLCPuc7vORPvoBpQDUL56lNvXCZaLSUOuCT9K1zvA6VRZoOYtD9uUQakmcEO/UuEH
         zqKevyFhEy1Sq/KIVk9b4ty9ubi2JpHluF87k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38UxcYPj+ZJxWmmAMOiK5v5tLaOBZZGjUg3oW8gg23w=;
        b=H75lpxVMXrt+Jg60erlxYPXXfEIX+eRHveaJtJxofGsDHisCdKAST+bxp0Z4e/NjOS
         oFUAlvuJggLOdFoOP+2w3z+Lwc8VK0gz1v1S1zekapw6XWPeZHyMdStdSQMXBHJm4RQM
         aZNCIfGxbSjVxtL0ug4iZYfg/9vwI5yMD1663bNTO9m/mb/Rx7E1+cQv+qKeg7zFNuSf
         O1iSmsj/4HzmA3JguI7PljvB0x3qiQaLzNXy5ezxR6AqwDbK2gAXR2eiWfZ7G26IxSUw
         dN0y7G5P/NFqGup4U//d7qn5Kn7nPyN+3B8t3i8+bLgPwagB71WdyNbesUUH3o6w2gZE
         Te6g==
X-Gm-Message-State: ANoB5pm/wK2pyFwBc9wdJixJGI/a29ocRorSUuStsj1cJfJbpC46JZLZ
        Ew0bBWe1ulZhLOSkuEgQKgPWX/1HR8UFeH5c5KbwEA==
X-Google-Smtp-Source: AA0mqf4sGvzUAZCYd6bjKQCt55zCHjMZISFnT6+9/M3mXfkjeqJUGbluZiuG/0KE8X0ROTr6HOmAvWmwwRi1wqq8Ux0=
X-Received: by 2002:a05:6512:224c:b0:4b5:ad89:8174 with SMTP id
 i12-20020a056512224c00b004b5ad898174mr2263391lfu.84.1671127106373; Thu, 15
 Dec 2022 09:58:26 -0800 (PST)
MIME-Version: 1.0
References: <20221214191355.GA2596199@paulmck-ThinkPad-P17-Gen-1>
 <20221215165452.GA1957735@lothringen> <20221215170834.GH4001@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YTSW9kr3DsJm6hTQ0FfwVbVjzDa8=7H29+ysD10ZCbnHA@mail.gmail.com>
In-Reply-To: <CAEXW_YTSW9kr3DsJm6hTQ0FfwVbVjzDa8=7H29+ysD10ZCbnHA@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 15 Dec 2022 17:58:14 +0000
Message-ID: <CAEXW_YQEZSdny005w314zNQMmS7MHMjp-WwAvV6k9hDhhzQmdA@mail.gmail.com>
Subject: Re: [PATCH RFC] srcu: Yet more detail for srcu_readers_active_idx_check()
 comments
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>, boqun.feng@gmail.com,
        neeraj.iitr10@gmail.com, urezki@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 5:48 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Thu, Dec 15, 2022 at 5:08 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> > > Scenario for the reader to increment the old idx once:
> > >
> > > _ Assume ssp->srcu_idx is initially 0.
> > > _ The READER reads idx that is 0
> > > _ The updater runs and flips the idx that is now 1
> > > _ The reader resumes with 0 as an index but on the next srcu_read_lock()
> > >   it will see the new idx which is 1
> > >
> > > What could be the scenario for it to increment the old idx twice?
> >
> > Unless I am missing something, the reader must reference the
> > srcu_unlock_count[old_idx] and then do smp_mb() before it will be
> > absolutely guaranteed of seeing the new value of ->srcu_idx.
>
> I think both of you are right depending on how the flip raced with the
> first reader's unlock in that specific task.
>
> If the first read section's srcu_read_unlock() and its corresponding
> smp_mb()  happened before the flip, then the increment of old idx
> would happen only once. The next srcu_read_lock() will read the new
> index. If the srcu_read_unlock() and it's corresponding smp_mb()
> happened after the flip, the old_idx will be sampled again and can be
> incremented twice. So it depends on how the flip races with
> srcu_read_unlock().

I am sorry this is inverted, but my statement's gist stands I believe:

1. Flip+smp_mb() happened before unlock's smp_mb() -- reader will not
increment old_idx the second time.

2. unlock()'s smp_mb() happened before Flip+smp_mb() , now the reader
has no new smp_mb() that happens AFTER the flip happened. So it can
totally sample the old idx again -- that particular reader will
increment twice, but the next time, it will see the flipped one.

Did I get that right? Thanks.
