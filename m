Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7CA665076
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 01:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbjAKAnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 19:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbjAKAnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 19:43:08 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1704FCC9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 16:43:08 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so18304396pjj.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 16:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RwApjXazBy03AXl+7agcNPkcdHcmXYisquD+XWuObQI=;
        b=p9Wy3geb4xUP52+NseHNDVhKtGAQ5RMSaJ1ssvzqE+bTGTb2SAwk+nIUX42kU9MOz1
         2hT90NzjYPZ7hZcZDqwAtSO3vrND+xIvSn7OVqn46nCmbbwCaD8i3Qg+cYdcY/cXobRM
         OUHGej7izgzQK95Z+JoD+06+BbKhO0J1WWWgcnnv+i698TWxwh3GsRDCvpsPtvYm0bFI
         95u5TIxGn9ZkRdQ5Q9zJ2n5E6CETzFSfAf/uvLyM8r+vvJl9kgonI57UzVh1PsV7bdXD
         b9KATQ0sVJP+mc4JNYGIAdn2QS78+7//yYUquuIhS2RKZmW61nREKPV49d0VofiiY1oW
         q7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RwApjXazBy03AXl+7agcNPkcdHcmXYisquD+XWuObQI=;
        b=ni9wHrayUoLCHsV/I4KW4xzmNlrYomdkkcHAe8xtYG+utXDsp/e3o+4tstUTijK8uR
         FEBTUulKduZmEwKuQnGAeqJzn6/uuEggUL4Tc8hpNYk8m5qjyzy8MjJODv0kjBsqWPCh
         W0BOMro3GKiLMgmXFvgjTLVn/qkQguUqISshtpf1lFrk33+bYeJAX5Dp39Le7IABuL03
         L1Wpbg4GhXUkpY0pbnNTjf9++dXmgPZsaOcwOOkyugKkpBSZ0IU0S8lc7emKNKs1g4kv
         Px3U/JrPeCoUsbxNaXaw5X9OdrLRuM/JwYcpckYK/MPaje6xlXGsRCZSzcmVmWp15S3z
         /TUg==
X-Gm-Message-State: AFqh2krCycYXKFBBROxBzT3uZwijUk43vxM/GWUAAq7IqVtMIpt25qev
        lO3MrcSYzGY/+IlYKqiQ+2SLEk2oEGtw1Q87uE3qZg==
X-Google-Smtp-Source: AMrXdXvjEJJTwOkPTxwNBMMNhDdENz7RjrHD8iSpfmOBhUPOzKLbPDpIns1ZcBITJYIhnXze4nsYdsIAmJXGjyU39Is=
X-Received: by 2002:a17:90a:1c96:b0:226:3fc:ec4f with SMTP id
 t22-20020a17090a1c9600b0022603fcec4fmr5550824pjt.85.1673397787297; Tue, 10
 Jan 2023 16:43:07 -0800 (PST)
MIME-Version: 1.0
References: <20230110091409.2962-1-sensor1010@163.com> <CANn89iL0EYuGASWaXPwKN+E6mZvFicbDKOoZVA8N+BXFQV7e2A@mail.gmail.com>
 <20230110163043.069c9aa4@kernel.org>
In-Reply-To: <20230110163043.069c9aa4@kernel.org>
From:   Wei Wang <weiwan@google.com>
Date:   Tue, 10 Jan 2023 16:42:56 -0800
Message-ID: <CAEA6p_AdUL-NgX-C9j0DRNbwnc+nKPnwKRY8dXNCEZ4_pnTOXQ@mail.gmail.com>
Subject: Re: [PATCH v1] net/dev.c : Remove redundant state settings after
 waking up
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        =?UTF-8?B?5p2O5ZOy?= <sensor1010@163.com>, davem@davemloft.net,
        pabeni@redhat.com, bigeasy@linutronix.de, imagedong@tencent.com,
        kuniyu@amazon.com, petrm@nvidia.com, netdev@vger.kernel.org,
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

I was not able to see the entire changelog, but I don't think
> -               set_current_state(TASK_INTERRUPTIBLE);
is redundant.

It makes sure that if the previous if statement:
    if (test_bit(NAPI_STATE_SCHED_THREADED, &napi->state) || woken)
is false, this napi thread yields the CPU to other threads waiting to
be run by calling schedule().

And the napi thread gets into running state again after the next
wake_up_process() is called from ____napi_schedule().


On Tue, Jan 10, 2023 at 4:30 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue, 10 Jan 2023 10:29:20 +0100 Eric Dumazet wrote:
> > > the task status has been set to TASK_RUNNING in shcedule(),
> > > no need to set again here
> >
> > Changelog is rather confusing, this does not match the patch, which
> > removes one set_current_state(TASK_INTERRUPTIBLE);
> >
> > TASK_INTERRUPTIBLE != TASK_RUNNING
> >
> > Patch itself looks okay (but has nothing to do with thread state after
> > schedule()),
> > you should have CC Wei Wang because she
> > authored commit cb038357937e net: fix race between napi kthread mode
> > and busy poll
>
> AFAIU this is the semi-idiomatic way of handling wait loops.
> It's not schedule() that may set the task state to TASK_RUNNING,
> it's whoever wakes the process and makes the "wait condition" true.
> In this case - test_bit(NAPI_STATE_SCHED, &napi->state)
>
> I vote to not futz with this logic.
