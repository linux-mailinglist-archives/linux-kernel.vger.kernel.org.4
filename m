Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430316663D7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjAKTkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjAKTj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:39:59 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F5C261D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:39:58 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id h192so11260318pgc.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1XSlpg+EdrcmXerZzrmLDNjZ4Nt/uQNre9/vPO6WsZk=;
        b=IMDrIWgY+v/D6xkyv5JggUKl5j/Pndtiy1QZmDjFblaLCFbBwXba/FvXxUw/mLuvTk
         SQb1rrBdoCPPOiHvpagAlDSixDR54r9p5KReZ/PEOqF+WTvqAYaDZIn5bZfpVgwAJ02+
         Gox8rK6fVp6ReI2nUYtahzFTotrERuUlSyQXDfa8pM7Q3ANEMbHrRxDLOZGQvgsJLLzH
         GIYzSY3RAoxxTYsw+igFmhqeDAFOQlOpZvplzQzbUEm8FoxBpbtmQrCTGAx0yR/RUIrd
         J+6Eyc6hGV99RhEnDdJVPsKoLSrKqyR8D50ITeYxhZckvSkQY6hgOrx9gLG5g7klMykt
         xDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XSlpg+EdrcmXerZzrmLDNjZ4Nt/uQNre9/vPO6WsZk=;
        b=M+qKsq7UpPfmH+sVz8fh1RXkn582PTldnUhqGEk459eW849Rcmb2/2BvNGopymKlqu
         Fb6NPLGcm4kP89MfS4Rp9KG0To/lAo//rW/fht08b9yXmKIIYUNuxgnHZnuJSMyT7xc5
         IMQ7fjgx1aUnERuN5ctHz14PvA0/jRyOnQJn7JiwubLEjMF7Kb6MRF+z0X/xJQmtTzFT
         j05PQjxbgMQBq9Uiyz/tjI1enyFyVxwvF6GgKR5vMCGKvbmcyE2VRGEgG/2xLFuJEufS
         3FNJj9A6z5BE48UqX0fjjPQONSruoyPZE3bD+LGI0aaGDDGdicHl+hE6c+wakQoFyWVq
         aw3A==
X-Gm-Message-State: AFqh2krwROXBlgijAkqj0kL9sQrgazUEz0irj0CMSUHkxePL1blNFUAw
        Qm93a3gTrutCL96zvHzNbIjkBSUQMWZXBgLId1jDk6eEVTQwOjNd
X-Google-Smtp-Source: AMrXdXumOD/ey3V/QkyeIC5FqYO4pBXInckHjGXoe4n57mB6xK/THa7v841uX5NKTNeaUD0/JJVYKoOLmQnMj1tSyi4=
X-Received: by 2002:a05:6a00:52:b0:583:4fd0:61b2 with SMTP id
 i18-20020a056a00005200b005834fd061b2mr1660859pfk.63.1673465997832; Wed, 11
 Jan 2023 11:39:57 -0800 (PST)
MIME-Version: 1.0
References: <20230110091409.2962-1-sensor1010@163.com> <CANn89iL0EYuGASWaXPwKN+E6mZvFicbDKOoZVA8N+BXFQV7e2A@mail.gmail.com>
 <20230110163043.069c9aa4@kernel.org> <CAEA6p_AdUL-NgX-C9j0DRNbwnc+nKPnwKRY8dXNCEZ4_pnTOXQ@mail.gmail.com>
 <Y75mGsoe5XUVtqqa@linutronix.de> <20230111102058.144dbb11@kernel.org>
In-Reply-To: <20230111102058.144dbb11@kernel.org>
From:   Wei Wang <weiwan@google.com>
Date:   Wed, 11 Jan 2023 11:39:46 -0800
Message-ID: <CAEA6p_AsyhQbGPrj71iKaScAHbrEBCDLeLyZE1kcT59GS=anzg@mail.gmail.com>
Subject: Re: [PATCH v1] net/dev.c : Remove redundant state settings after
 waking up
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        =?UTF-8?B?5p2O5ZOy?= <sensor1010@163.com>, davem@davemloft.net,
        pabeni@redhat.com, imagedong@tencent.com, kuniyu@amazon.com,
        petrm@nvidia.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 10:21 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 11 Jan 2023 08:32:42 +0100 Sebastian Andrzej Siewior wrote:
> > It made sense in the beginning but now the suggested patch is a clean
> > up. First the `woken' parameter was added in commit
> >    cb038357937ee ("net: fix race between napi kthread mode and busy poll")
> >
> > and then the `napi_disable_pending' check was removed in commit
> >    27f0ad71699de ("net: fix hangup on napi_disable for threaded napi")
> >
> > which renders the code to:
> > |         while (!kthread_should_stop()) {
> > |                 if (test_bit(NAPI_STATE_SCHED_THREADED, &napi->state) || woken) {
> > |                         WARN_ON(!list_empty(&napi->poll_list));
> > |                         __set_current_state(TASK_RUNNING);
> > |                         return 0;
> > |                 }
> > |
> > |                 schedule();
> > |                 /* woken being true indicates this thread owns this napi. */
> > |                 woken = true;
> > |                 set_current_state(TASK_INTERRUPTIBLE);
> > |         }
> > |         __set_current_state(TASK_RUNNING);
> >
> > so when you get out of schedule() woken is set and even if
> > NAPI_STATE_SCHED_THREADED is not set, the while() loop is left due to
> > `woken = true'. So changing state to TASK_INTERRUPTIBLE makes no sense
> > since it will be set back to TASK_RUNNING cycles later.
>
> Ah, fair point, forgot about the woken optimization.

Agree. I think it is OK to remove this, since woken is set, and this
function will set TASK_RUNNING and return 0. And the next time, it
will enter with TASK_INTERRUPTIBLE and woken = false.
