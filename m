Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A3A5F4904
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 20:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiJDSFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 14:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiJDSFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 14:05:19 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D74B4BD07
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 11:05:12 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id i9so6955924ilv.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 11:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=sLLzbroKqpxLu0HQF1QulfhBmT3Qy5q0rRY0h0xXoW8=;
        b=QDTMRLES+3c9wfPuGJ1UDQsP5WFZWafybw40aij4Uchx9/VI8x77Kd6QQGUp4rZDOO
         3/3fX6+wZKuZrNtHh0ltXVCGpNk0UOYFcEz6UpMSSfhSkpR6ekbN+UBF1OA4kd7YVlW1
         cE7G13glkKpDJUHPZKXiZJs8gOv0PhBxlcVg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=sLLzbroKqpxLu0HQF1QulfhBmT3Qy5q0rRY0h0xXoW8=;
        b=BEa0PNkwpNMiLvHfL4mlRwGehmSwd1KE+PHe3WzripID9ChdyB60uMX7J1+AvUSuy4
         weg89CXcZo5jE1hlTIXJNYydLSDWeG9kRMgTiKwk9bvYwwqz9ae4zZUpSNKrtayUf6vY
         vYpdhqSXO0+w7EIAt4pmlx8BdXS5iyF8jeJJ8QJ0m4BJwYRFOzsKohZ0Cec96ZaAo9bL
         Px5ekQUWwzn1UNIGJe0AKavTgs4E495ToNQ5xklLKsVpVTB3ettkZMFtCd285juJFPxL
         3Khih9x3ngnaR398Xkks7/ImsMIBr1652tn8HaYLExKBsoOyrr1OgtRUSEWmlDXeegsh
         3HZQ==
X-Gm-Message-State: ACrzQf1/+3ogzcTxpSIbc8Dp43lNE3G061CjJIT+jBGlvf7+uLOTglNk
        gaVGzOn2hU+aZ1SxLOYmM3nYojmRpk2O8yZhePppZw==
X-Google-Smtp-Source: AMsMyM7YKsigDeRdaCpRPiK9JEbG1nQ9TQCAOsAfj0pv6RhDXc9ZX8BR78UCcu98nemAHx9h6sIHVySYcDk0L3U2/yM=
X-Received: by 2002:a05:6e02:2191:b0:2f5:aade:9ea0 with SMTP id
 j17-20020a056e02219100b002f5aade9ea0mr12907928ila.79.1664906711403; Tue, 04
 Oct 2022 11:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221004024157.2470238-1-joel@joelfernandes.org>
 <20221004024157.2470238-3-joel@joelfernandes.org> <Yzwb8vgYhAvDJzK+@pc636>
In-Reply-To: <Yzwb8vgYhAvDJzK+@pc636>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 4 Oct 2022 14:05:01 -0400
Message-ID: <CAEXW_YScPPbZeCzidU8bwSKKm=pJjEwxNHnFK-XYfnzqSK7ShA@mail.gmail.com>
Subject: Re: [PATCH v7 02/11] rcu: Make call_rcu() lazy to save power
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     paulmck@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, rostedt@goodmis.org,
        youssefesmat@google.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 4, 2022 at 7:41 AM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> >               trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
> >               rcu_nocb_lock_irqsave(rdp, flags);
> >               lockdep_assert_held(&rdp->nocb_lock);
> >               bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
> > -             if (bypass_ncbs &&
> > +             lazy_ncbs = READ_ONCE(rdp->lazy_len);
> > +
> > +             if (bypass_ncbs && (lazy_ncbs == bypass_ncbs) &&
> > +                 (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_till_flush) ||
> > +                  bypass_ncbs > 2 * qhimark)) {
> Do you know why we want double "qhimark" threshold? It is not only this
> place, there are several. I am asking because it is not expected by the
> user.

I am following the qhimark conventions in existing code. However
qhimark does not mean that your callbacks cannot exceed these many or
something, it is not a hard limit on queued callbacks.

qhimark (And Paul can correct me) was introduced to reduce the number
of callbacks after which RCU will not limit execution of callbacks to
a batch of them. That has nothing to do with limiting the maximum
number of callbacks, per-se. However, its usage certainly seems to
have grown since that introduction.

Maybe you are confusing it with blimit:

#define DEFAULT_RCU_QHIMARK 10000 // If this many pending, ignore blimit.
static long qhimark = DEFAULT_RCU_QHIMARK;
#define DEFAULT_RCU_QLOMARK 100   // Once only this many pending, use blimit.
static long qlowmark = DEFAULT_RCU_QLOMARK;

thanks,

 - Joel
