Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919466F237C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 09:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347049AbjD2HEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 03:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347317AbjD2HDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 03:03:49 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B24744A4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 00:03:33 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-94a34a0b9e2so97220766b.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 00:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682751812; x=1685343812;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dsrsUmlr1ov5EDpYQZRfJPTgGycp1vV5Zj7Lyz1c0zQ=;
        b=NU8A/682x8p5SoxJqfgHtgdo27SzAJUdk+y7kbffXte7lptFP69Zf0OHYIJp+XjvFg
         jhAiZbHujUkFJ5lytv8wMocbt6ECPVP866NLEiUVwFT5jRtEAxSU+h8FSKQw8YJ4TKlg
         o2sWRy4gZ7jHl3+J7RXxXBHKLgJGOZuyqqizwOiwSLPXzRvFfMUbpIPf92qZ0aKb4HMs
         9PAdeZYxdA360q2WlnKS08Rx/RRX6F3UU+jCGa0+C2NqZJgP5fYGqF1GmkBpL3IqYoSe
         kcCVL4qxTkFx5OUKek2zq108piFkLcrTld9dTIcYxVB45UVD523ZTq6BfKpA91h5ppOK
         oHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682751812; x=1685343812;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dsrsUmlr1ov5EDpYQZRfJPTgGycp1vV5Zj7Lyz1c0zQ=;
        b=PuJU4xxueOfA4zfoXPS6WhcMp/71cW3IVhey91KV5prz4SV6vlmWOLiQTO3bPIVUae
         LzjwD95dabcubPNyGeR2ira+VtX4oNHyLsWpj98cr9qBJ18vZVmQ0fKwZA8tRLkkAqRS
         Oz7hmbbVJ34FrwA6PZpcBfnKqI4nWTzMWEIrtlV3ylCmjB6bNC3DcUJ+uquDH3Jjjl+b
         Naq5KjDwbtJk4wdBmwrZBSQ6J5AVerOGOHX2AuZ9YuXXmNtk3Bg+2b4wBZYBMMPqOuxC
         ZtiTFLZrrdgi+nXrIM/hF2QEqcCePTggflzQusuYvSMD07DGT2Je8uzZmNRZDajW9RSK
         vWCw==
X-Gm-Message-State: AC+VfDxJi372cDQyXkbFQvrAVv6wKi/Z9qOAqmbNFl3/wVncMB+nOVy9
        rj8Mbm+4JG4krUP32JRman0=
X-Google-Smtp-Source: ACHHUZ43rOwme3jK9tYCKBIB1Yn9yuBcdQpU2YSgpK8FyH547hmb5Ts6f1Clt2nhwUVx+5QX49DuIg==
X-Received: by 2002:a17:907:16a9:b0:94a:4fc5:4c2e with SMTP id hc41-20020a17090716a900b0094a4fc54c2emr8140307ejc.49.1682751812045;
        Sat, 29 Apr 2023 00:03:32 -0700 (PDT)
Received: from gmail.com (1F2EF38A.nat.pool.telekom.hu. [31.46.243.138])
        by smtp.gmail.com with ESMTPSA id n2-20020a1709065e0200b00951755d0c79sm12236592eju.104.2023.04.29.00.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 00:03:31 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 29 Apr 2023 09:03:26 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: Re: [GIT PULL] scheduler changes for v6.4
Message-ID: <ZEzBPiOp+QylKD4A@gmail.com>
References: <ZErgOfOLrBwluTbd@gmail.com>
 <CAHk-=wj-t1N7a2dH=y7MCjctk_Zw77C8_V6cfS-UC7f3jXAF6g@mail.gmail.com>
 <3f452ee7-6430-e7a9-590b-b211ad4c7ea5@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f452ee7-6430-e7a9-590b-b211ad4c7ea5@efficios.com>
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2023-04-28 18:02, Linus Torvalds wrote:
> > On Thu, Apr 27, 2023 at 1:51 PM Ingo Molnar <mingo@kernel.org> wrote:
> > > 
> > >   - Fix performance regression introduced by mm_cid
> > 
> > This causes a conflict with commit b20b0368c614 ("mm: fix memory leak
> > on mm_init error handling") that came in through the MM tree.
> > 
> > That conflict is trivial to resolve, and I did so.
> > 
> > Except I also checked my resolution with what was going on in
> > linux-next, and it's different.
> > 
> > I'm pretty sure the resolution in linux-next is wrong, but I thought
> > I'd mention this, since clearly this wasn't caught in linux-next.
> > 
> > Or maybe it's me that did it wrong, but hey, that couldn't actually
> > happen, could it?
> 
> I've reviewed both merge commits (c79e0731da from next-20230428 and
> 586b222d74 from master) and I confirm that your conflict resolution
> is correct. The one in next was wrong.

Indeed - mm_alloc_cid() happens after the MM context has already been 
initialized, so the fail_cid label needs to deinit the context aka call 
destroy_context().

So the resolution by Linus is the correct one:

        mm_destroy_cid(mm);
 fail_cid:
        destroy_context(mm);
 fail_nocontext:
        mm_free_pgd(mm);

Thanks,

	Ingo
