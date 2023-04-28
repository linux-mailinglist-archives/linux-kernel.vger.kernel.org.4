Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C547C6F1B50
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 17:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345591AbjD1PT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 11:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjD1PTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 11:19:25 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8FD559F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 08:19:25 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1a92513abebso654845ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 08:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682695165; x=1685287165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uc6SVgjQVy/8xdDmpqE6kegdWc2XYcBn7ME2NMVrIWg=;
        b=a2wQcCSzJiPV6HLT5OJe0dVPUYI8Gp/tKxtd34p+7dwTrPOe9YQf5HbEYpT8Ww1Kot
         j8r6LIiaBBa5egkwwkWxG6RDsIfc+/f8BNe5dpNw6a8LBOs+UkiIsbWHTH+O5n/8GJjV
         2jPvoOTj8CVAeWgkXROOO1oAEqQJrcNIjXG6qKw5625/c2EJLk5sUgLvV0IUq3vkXT8q
         PXfhfGkGEF2dj51VOShoMbTPW9WubD9RVl5unUt0+hsmDhCYwlCDuuBcXuEg9ugORrbj
         BVASkxZCltbuQXj6VI8/ya9MaoHC8kaxrYSO/e1I55+WF03+eJAV2Y3PG58vkrj7kBJD
         QUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682695165; x=1685287165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uc6SVgjQVy/8xdDmpqE6kegdWc2XYcBn7ME2NMVrIWg=;
        b=c0Q/U3cYneBbtINNbg69GD2+KPBAvSwJwOPUKaF/m4fthqzIBNvdtr7H+y4iX2MT0x
         QxDuUhWzPsWQUU3BaOq0zr9rYUQyORlKyfcnLNm23DkLTcO+jgIc2zdkfvc2sS9uB1wQ
         vNQZGHQBP2T5SnovM6tQBk83Nfnysxv1zLiFK4GBIzZViXl+82ok4lQuDbBiIkil2liv
         CI6PPOT6uIhwjKKAJX+RD4ZvcWjlleO/IQ5uHYh9JCJCVc9chVlKLOkO20drvHgaV6/6
         l+Q87iJQy3MJgwV42YP7oa0Gzc6UPiXu4Eo3GhSiT3fiC8NKZ2F0KAkw6zm8SVfCkIhG
         D2cA==
X-Gm-Message-State: AC+VfDzOEYRu3K6fSiQ5GOVMPA9nktp3HDq05ydb6oprS6drxiiQtSZi
        2jKI1el8BK7Jp1ER1kuzmDk=
X-Google-Smtp-Source: ACHHUZ7BLsWWcbRarrz0mQrYzfShIHbxWuszM2234lMPlr3N3XzHsw31s2mCGyVvwEJqJj2f/GAcsA==
X-Received: by 2002:a17:902:f681:b0:1a9:736a:5251 with SMTP id l1-20020a170902f68100b001a9736a5251mr6464854plg.16.1682695164211;
        Fri, 28 Apr 2023 08:19:24 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id io13-20020a17090312cd00b001a212a93295sm1505828plb.189.2023.04.28.08.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 08:19:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 28 Apr 2023 05:19:21 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     jiangshanlai@gmail.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 4/5] workqueue: Automatically mark CPU-hogging work items
 CPU_INTENSIVE
Message-ID: <ZEvj-eet6anRUR6o@slm.duckdns.org>
References: <20230418205159.724789-1-tj@kernel.org>
 <20230418205159.724789-5-tj@kernel.org>
 <20230425131254.GF1335080@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425131254.GF1335080@hirez.programming.kicks-ass.net>
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

Hello, Peter.

On Tue, Apr 25, 2023 at 03:12:54PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 18, 2023 at 10:51:58AM -1000, Tejun Heo wrote:
> > If a per-cpu work item hogs the CPU, it can prevent other work items from
> > starting through concurrency management. A per-cpu workqueue which intends
> > to host such CPU-hogging work items can choose to not participate in
> > concurrency management by setting %WQ_CPU_INTENSIVE; however, this can be
> > error-prone and difficult to debug when missed.
> 
> Well; you could use this very heuristic, and instead of silently trying
> to fix up, complain about the missing CPU_INTENSIVE thing.
...
> But why not keep it a debug mechanism? Now you're got a heuristic with
> all the down-sides that they bring.

I'm working on improving the locality of unbound workqueues and it isn't
clear whether there's enough space for per-cpu CPU_INTENSIVE work items -
ie. if it's gonna saturate the CPU for extended periods of time to the point
of requiring CPU_INTENSIVE, it might as well be an unbound work item if the
baseline locality can be good enough. There aren't that many users of
CPU_INTENSIVE in tree and we can decide based on how unbound workqueues
actually work out for them.

As for warnings, yeah, that'd be great to have regardless of how
CPU_INTENSIVE turns out. Just gotta make sure it doesn't fire spuriously and
become a nuisance.

Thanks.

-- 
tejun
