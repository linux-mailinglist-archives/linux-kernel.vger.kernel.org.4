Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D967964DFF7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiLORtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiLORtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:49:00 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F57827DFC
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:48:59 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id q6so16799902lfm.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 09:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cjIQxwghSX8UYWFnSTuWJDMMlMgaiz3CsovlV0p8Z9c=;
        b=yXTN/7+3cSAVFqup8NKvO4wwdLWZxKsw2oi/mRzXdSj44pOVStpEmq6kMm6rPvNhFW
         2MHOygN6xDMfFWLDdT5/JsX04/WCp/LIV2ktFR5vDCAb5IgWqNdFohkNS869FJtwpabS
         3HdmbPCH/GqldfcSylZT9MgEd+f55rhloNQQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cjIQxwghSX8UYWFnSTuWJDMMlMgaiz3CsovlV0p8Z9c=;
        b=mxDvfrOD1PU7FdQWGCJHDZ8+Kaxnf7PW139s9/06RbExzkgK6iuBAq1zWPjIsimD8+
         of/rFs+IUTjU3Cq0BWpL29+oS0VCfM+82qFPtmBzBcNy37wZkRscZQ5fYdtF4PZQifKz
         s0Jm8cMwO5PXHQw9Dw3mzKdhNSzH9m7wbGR7AlZ1qaoSO0Hr8W8DJ/jciubZTJ1BYa0J
         2y2FX3nBGFZ6lWbEy2WuZHdFZKfzKamWqNYuFbj9OitEh5fWYEwHQ7bBBMEGAdB8vYOz
         wqvNTbypDC+l7rPa+48YjTPXAnguFPGeV910Pnbdgdvaz7k58ZhoNbsXI55/EBzoktP9
         CMAw==
X-Gm-Message-State: ANoB5pkq7XtiWlsi1Fy4I5skgAKtsGmn1/Fpfr/p2PkIVxyz6G8dEvZL
        JdgMaY0WLRfVIba/GFtVDzxnL6QbOHGWK32eGx6A1iakISBheiBd
X-Google-Smtp-Source: AA0mqf7daUaCFb3JfrNGJSySwxgbyBUwvfSfCwEW+dBO5hzUx7WvfucJ1n/LMnjdTxOfU53AE0Pt2WdV3/Q46UfAWjs=
X-Received: by 2002:a05:6512:224c:b0:4b5:ad89:8174 with SMTP id
 i12-20020a056512224c00b004b5ad898174mr2261149lfu.84.1671126537736; Thu, 15
 Dec 2022 09:48:57 -0800 (PST)
MIME-Version: 1.0
References: <20221214191355.GA2596199@paulmck-ThinkPad-P17-Gen-1>
 <20221215165452.GA1957735@lothringen> <20221215170834.GH4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221215170834.GH4001@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 15 Dec 2022 17:48:46 +0000
Message-ID: <CAEXW_YTSW9kr3DsJm6hTQ0FfwVbVjzDa8=7H29+ysD10ZCbnHA@mail.gmail.com>
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

On Thu, Dec 15, 2022 at 5:08 PM Paul E. McKenney <paulmck@kernel.org> wrote:

> > Scenario for the reader to increment the old idx once:
> >
> > _ Assume ssp->srcu_idx is initially 0.
> > _ The READER reads idx that is 0
> > _ The updater runs and flips the idx that is now 1
> > _ The reader resumes with 0 as an index but on the next srcu_read_lock()
> >   it will see the new idx which is 1
> >
> > What could be the scenario for it to increment the old idx twice?
>
> Unless I am missing something, the reader must reference the
> srcu_unlock_count[old_idx] and then do smp_mb() before it will be
> absolutely guaranteed of seeing the new value of ->srcu_idx.

I think both of you are right depending on how the flip raced with the
first reader's unlock in that specific task.

If the first read section's srcu_read_unlock() and its corresponding
smp_mb()  happened before the flip, then the increment of old idx
would happen only once. The next srcu_read_lock() will read the new
index. If the srcu_read_unlock() and it's corresponding smp_mb()
happened after the flip, the old_idx will be sampled again and can be
incremented twice. So it depends on how the flip races with
srcu_read_unlock().

Also, since this is all hard to reason about I started making some
diagrams, LOL. For your amusement, here is why need to scan both idx
during grace period detection: https://i.imgur.com/jz4bNKd.png

thanks,

 - Joel
