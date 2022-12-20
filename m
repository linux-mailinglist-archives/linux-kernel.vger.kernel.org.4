Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C886519E3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 05:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbiLTEHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 23:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiLTEHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 23:07:32 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC54558B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 20:07:30 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id j4so16844368lfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 20:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qDu+2HB9LCelBr6OwQ3TS8ifZcPH8YwgroAjWq1C00k=;
        b=Y86xtdv3XMJ+nN6oow1JLrJgBuF3civOC/ytVGb1nq+LnnsmCdw6yZQ1wsodZHZu+h
         ln3X2He+1mz1o7S8y46L4rQlGaYaBQ3m+ZhGRpa0x2Dr6YQUhUY/Or9zntk/NTPI0NQ4
         QIH1W0OWhRa+DH724vkVR9Fb504i+gqDmStIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qDu+2HB9LCelBr6OwQ3TS8ifZcPH8YwgroAjWq1C00k=;
        b=vlVFECtqjRVuD02MYWn567P8Fmh/RtXoEIwRTYcssoCfAjtU3uu5W74yW9/t6CP47c
         qc7AMUD6EVHsRfP8mPzDXe6bEcuXcZUV0IMwLKWI24nwer76vInEenoqR+B7hFBiRlq/
         Sb4jTMQwXXeJEKRdIGwNtUPfvUFvYtLzpTQ+5ZIKckU62J3touolb7NbLfvgAo+sxXmP
         MznNHozERLuXSeTzS72ovcpgZ8J9PROPpbimZ27MvfGdLEDLnl7BcrB3GIw4gesAFQ13
         vmFlJnRKgGFDx2NOQwSVOVH1aWxfjFmr5n9LogPhzlYGjlaPiBNA72xHgbLr0KaJmF4y
         tERQ==
X-Gm-Message-State: ANoB5pl6odnYXjGc3YPMOzedfIN1ad0m/6Vwm+nYH16nS0o/v8ODDXWP
        UNMO44dAcRSnJ8dSYn8UHcyR5Y4XNvTKBOuaiRqcs/txEEDmfbJJrQ0=
X-Google-Smtp-Source: AA0mqf6VnHU/0i+jLya+GHkKML+2c0Byt6jC+vJK2QzrSvQpzsNLCtjhYeKCE9zL7w5NgiRdEhGskhzdRPYMZSBcSdU=
X-Received: by 2002:a05:6512:224c:b0:4b5:ad89:8174 with SMTP id
 i12-20020a056512224c00b004b5ad898174mr3579330lfu.84.1671509248402; Mon, 19
 Dec 2022 20:07:28 -0800 (PST)
MIME-Version: 1.0
References: <20221218191310.130904-1-joel@joelfernandes.org>
In-Reply-To: <20221218191310.130904-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 19 Dec 2022 23:07:17 -0500
Message-ID: <CAEXW_YRjAsx0HCnmjvth+yi0COTiynPRvjyT2sf1utMw5bTgiw@mail.gmail.com>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
To:     linux-kernel@vger.kernel.org
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2022 at 2:13 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> Hello, I believe the pre-flip memory barrier is not required. The only reason I
> can say to remove it, other than the possibility that it is unnecessary, is to
> not have extra code that does not help. However, since we are issuing a fully
> memory-barrier after the flip, I cannot say that it hurts to do it anyway.
>
> For this reason, please consider these patches as "informational", than a
> "please merge". :-) Though, feel free to consider merging if you agree!
>
> All SRCU scenarios pass with these, with 6 hours of testing.
>
> thanks,
>
>  - Joel
>
> Joel Fernandes (Google) (2):
> srcu: Remove comment about prior read lock counts
> srcu: Remove memory barrier "E" as it is not required

And litmus tests confirm that "E" does not really do what the comments
say, PTAL:
Test 1:
C mbe
(*
 * Result: sometimes
 * Does previous scan see old reader's lock count, if a new reader saw
the new srcu_idx?
 *)

{}

P0(int *lockcount, int *srcu_idx) // updater
{
        int r0;
        r0 = READ_ONCE(*lockcount);
        smp_mb();       // E
        WRITE_ONCE(*srcu_idx, 1);
}

P1(int *lockcount, int *srcu_idx) // reader
{
        int r0;
        WRITE_ONCE(*lockcount, 1); // previous reader
        smp_mb();       // B+C
        r0 = READ_ONCE(*srcu_idx); // new reader
}
exists (0:r0=0 /\ 1:r0=1) (* Bad outcome. *)

Test 2:
C mbe2

(*
 * Result: sometimes
 * If updater saw reader's lock count, was that reader using the old idx?
 *)

{}

P0(int *lockcount, int *srcu_idx) // updater
{
        int r0;
        r0 = READ_ONCE(*lockcount);
        smp_mb();       // E
        WRITE_ONCE(*srcu_idx, 1);
}

P1(int *lockcount, int *srcu_idx) // reader
{
        int r0;
        int r1;
        r1 = READ_ONCE(*srcu_idx); // previous reader
        WRITE_ONCE(*lockcount, 1); // previous reader
        smp_mb();       // B+C
        r0 = READ_ONCE(*srcu_idx); // new reader
}
exists (0:r0=1 /\ 1:r1=1) (* Bad outcome. *)

thanks,

 - Joel


>
> kernel/rcu/srcutree.c | 10 ----------
> 1 file changed, 10 deletions(-)
>
> --
> 2.39.0.314.g84b9a713c41-goog
>
