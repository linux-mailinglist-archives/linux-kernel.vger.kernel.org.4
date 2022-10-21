Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CC0606C97
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 02:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiJUApB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 20:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiJUAo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 20:44:58 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D70EEA69D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 17:44:55 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 20so1103565pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 17:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hLPmj/VRDorPV86U866UtyTHo0FkCCw2PTVAt0IuaWY=;
        b=PoX/ydw2mj/1cAhUtw0/3vUCgCzMlATz5tsSMM8auB7AYdC8A0x7Nab20kP2coohHQ
         /U8ER+O0a2/lpamJ5B/uzVs/sAgLh2Mx4YWDfBBF7tFGARdYXHtzETCj5la5wjEsXNBk
         B0CYgpPhwtWTpnwtGpYhlhVbsglEsauv/tEPAWV9WuLQZm/ERjmU3aR+IYeS0ah8qGDl
         dhGejecWnHul/4ZJ6afFqtxp2MrLRt4v5c6oeqciW/H5HrldTZof2qVys7U+ZVGUsj05
         FFRfufwmWyb5ikwPxop2aSmTJXSz0Zgsi7v+5VmjBMTpR8SalGzdLSxN1bik/cCMp/5d
         dhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hLPmj/VRDorPV86U866UtyTHo0FkCCw2PTVAt0IuaWY=;
        b=fw6cV4TjpOaueRUcht6in67twzmmVLvvoLRF7RPekH29hdBTTxKDaHLj+HbbvguGBr
         ml0TOaR56eJbBsYEJA0KXawytsz8RMygNDEfyvbygTHXK70QtVXPVkStIlMy+jk6UixG
         JPFHSEURMWJSVRv0fuMghZWI5YdqSrKZT8vv7RwARA3ArsgpTMnXhzOkoMzt4Twd95s1
         Y1NcI0kyXSU1g/P6ERs6fN1zKzb4aqCBQAXja4oqdHG+Od9MPeCNsimcgMF3YqgHYJwD
         HegoJHoMYqUqMzM2af3AGJTFos+mOvXA9gcUo+9eChf8ZCVSXsMbIowMRKv1jNK+N2qB
         QFqQ==
X-Gm-Message-State: ACrzQf1d+MbV4l7mgEXLzgLPbLDXybAc8FbgSDIRFF3b/2hMo3ezBv28
        qVfms1XmtFIZNi8NLoE+LfA=
X-Google-Smtp-Source: AMsMyM5k8P+qXta43uF0TCaW9l8UrwcG9V2aVYpdHkgtWoBWKLiDUonIiHnP+jv+N86r05SgPiYkSA==
X-Received: by 2002:a62:1e83:0:b0:545:6896:188 with SMTP id e125-20020a621e83000000b0054568960188mr16487464pfe.51.1666313095153;
        Thu, 20 Oct 2022 17:44:55 -0700 (PDT)
Received: from gmail.com ([2a00:79e1:abc:1e04:de9a:68c:c1e8:7e8f])
        by smtp.gmail.com with ESMTPSA id o66-20020a625a45000000b00551d9fab742sm13863203pfb.218.2022.10.20.17.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 17:44:54 -0700 (PDT)
Date:   Thu, 20 Oct 2022 17:44:51 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <brauner@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 3/5] sched: add a few helpers to wake up tasks on the
 current cpu
Message-ID: <Y1Hrg/sqPhuSr+PY@gmail.com>
References: <20221020011048.156415-1-avagin@gmail.com>
 <20221020011048.156415-4-avagin@gmail.com>
 <Y1FX6FmPHCsdQn9A@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y1FX6FmPHCsdQn9A@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 04:15:04PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 19, 2022 at 06:10:46PM -0700, Andrei Vagin wrote:
> > Add complete_on_current_cpu, wake_up_poll_on_current_cpu helpers to wake
> > up processes on the current CPU.
>
> There is an astounding lack of *why* in this changelog.

I use them in the next patch to handle seccomp user notify requests
faster.

The seccomp notify mechanism allows less privileged processes to offload
specific syscalls to more privileged processes.  In many cases, the
workflow is fully synchronous. It means a target process triggers a
system call, the kernel stops it and wakes up a supervisor process that
handles the system call and returns controls back to the target process.
In this context, "synchronous" means that only one process is running
and another one is waiting.

New helpers advices the scheduler to move the wakee to the current CPU.
For synchronous workflows like described above, these helpers makes
context switches a few times faster.

For example, using these helpers allows to reduce a seccomp user notify
rountdrip time from 12µs to 3µs.

Thanks,
Andrei
