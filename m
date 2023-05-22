Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B118470CC05
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 23:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjEVVMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 17:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjEVVMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 17:12:10 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0597A9C;
        Mon, 22 May 2023 14:12:10 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-517c840f181so3539719a12.3;
        Mon, 22 May 2023 14:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684789929; x=1687381929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+XNhMRDIcd5RhQtvp0YIKYqZLNH6+pbXq+kWmpBSynM=;
        b=k1K1HyzvnqnBe8r2Rpb2ATAXebNjQ+9Bj004eYb67TIX3qkCYFzgQYrfbfof/qs3fV
         E3bOOixQ4DIcMdIMfzpQ4RfAjXDQoDqAOGWrbfUxf2/ZNc+KM0OYHZ9lU2A+SK8usHdg
         dc/ZvHPzmHRsXxUFogSaI7+kAzu1XXJiiGb5QhVJAxWHDSGYx4O/aRabFYIT9yYBpg0S
         oDgmbR7SKYkH53aRuo/PUAuGIz7l4rya+8MXmoqmBJbDcvBs40ChsEt9FeVe2iBICoBa
         Dvl/vll4zbsfzri82BmGt63uVS0Ge5oAnStn/7nZqW4C8ZRrmMwWkd/j5S4GA/kkWEc7
         iHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684789929; x=1687381929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XNhMRDIcd5RhQtvp0YIKYqZLNH6+pbXq+kWmpBSynM=;
        b=LrPKcO6TZT8ziB/0SSh8hFN//5qdAqtfgE+lDarjwKro80W1dTtEjBNEwIHYF9t+Bw
         ktGUdGXY78AUjMeRoBhZoMBPWQfZg5Q1rXcrjEZi4nwo2nya7O8WtkBFxy7IZHAoAV6e
         PWpfhBH/hgwj6WcxFe8/R4zTskGhOh4hL3jlM7/7ANDi/NkzBhdX35NvBk6ezr5peMGb
         IYXGnVJGrBwFoBksOAqPZCTAlWOvcubELFkd7Wd05qbjGCfR8HSMTj/LG2BPkS1s8fM2
         q9dI3gSKwXGclveKTE8HucGYvX3Zgwt3fWojLuDOOHFWpxiJ/f9t/EQR2LItqN9T/fje
         AYiA==
X-Gm-Message-State: AC+VfDwvr0So5/DyW8CAgSUTPDYibwAVUD7cQMOWqTACLUFZwS4+IJ9P
        iN5DR1ZGjKTVkLercSGq5Gg=
X-Google-Smtp-Source: ACHHUZ60CLOp7DtHkbt5u0VTx8QiCC05myGgdTMUzzuhOr29K4CA9z9bUTYJaQhqyLyPqXt0bMuqYA==
X-Received: by 2002:a05:6a20:7295:b0:103:ef39:a832 with SMTP id o21-20020a056a20729500b00103ef39a832mr12188478pzk.23.1684789929229;
        Mon, 22 May 2023 14:12:09 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:39c])
        by smtp.gmail.com with ESMTPSA id lt11-20020a17090b354b00b0024df400a9e6sm4556611pjb.37.2023.05.22.14.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 14:12:08 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 22 May 2023 11:12:07 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Z qiang <qiang.zhang1211@gmail.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        clang-built-linux <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: next: WARNING: CPU: 0 PID: 63 at kernel/workqueue.c:1999
 worker_enter_idle+0xb2/0xc0
Message-ID: <ZGvap5qi0OKAOfqX@slm.duckdns.org>
References: <CA+G9fYud2YH1c9Hxekd-pi8VsD4HmA4v9g-mr-vRPqaRQd2F5w@mail.gmail.com>
 <CALm+0cXew-QX9gkHkL7majJuENP1C_WLVG=pQ_6RGZ1UgQ79Eg@mail.gmail.com>
 <ZGuydp0KToLf55vY@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGuydp0KToLf55vY@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 08:20:38AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Mon, May 22, 2023 at 09:24:09PM +0800, Z qiang wrote:
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index 9c5c1cfa478f..f8d739fef311 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -1060,10 +1060,9 @@ void wq_worker_running(struct task_struct *task)
> >          * and leave with an unexpected pool->nr_running == 1 on the newly
> > unbound
> >          * pool. Protect against such race.
> >          */
> > -       preempt_disable();
> > +       local_irq_disable();
> >         if (!(worker->flags & WORKER_NOT_RUNNING))
> >                 worker->pool->nr_running++;
> > -       preempt_enable();
> > 
> >         /*
> >          * CPU intensive auto-detection cares about how long a work item
> > hogged
> > @@ -1072,6 +1071,7 @@ void wq_worker_running(struct task_struct *task)
> >         worker->current_at = worker->task->se.sum_exec_runtime;
> > 
> >         worker->sleeping = 0;
> > +       local_irq_enable();
> >  }
> 
> Ah, yeah, this is correct. Now we're modifying nr_running from timer tick
> too, so if don't block irq, the timer tick can ruin the not-irq-protected
> read-write-modify nr_running update from wq_worker_running(). Naresh, can
> you please confirm the fix?

Z qiang, while waiting for Naresh's test result, can you send the fix as a
proper signed-off-patch?

Thanks.

-- 
tejun
