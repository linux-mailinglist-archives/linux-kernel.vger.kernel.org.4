Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9B66FFCD9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 00:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239425AbjEKWw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 18:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238953AbjEKWwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 18:52:54 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B646359DA
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 15:52:53 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-517bdc9e81dso4784487a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 15:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683845573; x=1686437573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ud3/0Yzc+Y/Q0QLkoATRFkF/BFu3lDXkfQFnlUMfGjo=;
        b=PtximVHZrXWp2cDy37+mbedUeS71ZQmR8Ny/1Trr059RFSyiffDdQuN2zAbBPRqDNg
         EXR5Rl7WMX+g1yjuwdTG1g+P0CCyBEsshLZp+bBo8yannG3wgm+QeHGdai9ye+YZxAMj
         y9gtvF4i4VzdvpAOi+UTn4Zwa8kmiRUzImEx3XJxEnQ0uk+jnuBuVv4JnI2qOGti37el
         nT8u6OmMIXZdugCNCwpEsPkjIcgwY/zdad9wDXoQAHrISpeH0V17tFqh98kZOlCjUZv4
         o/j745SphA4+iEJGJxzLpLip5q81sxCXGMoGIvJnQAXP5CTfawwBNh5cQVzlV7DLNIW7
         hrxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683845573; x=1686437573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ud3/0Yzc+Y/Q0QLkoATRFkF/BFu3lDXkfQFnlUMfGjo=;
        b=QBBPbZ6ZHzkz6nnkcCuSqHwZFOUeuPSkxdKSEqdqCetRuoHq9SgdHLjigegRrJDYaa
         0IWSmKRAsYKhRf7VFx81K1qMJkl/NrO3o5dB6kBvofZtx0/PmaE4F3Lo9trCwI4eD5Mp
         PJ5LQTxGvOoE5SfU3V7QLQNVFypaNexvThmvqwAtDorulXDl+n8iIv39pKuk8XmNJd4b
         3Fgb0z/YsgPwdWPDQ+jD8mTIlMOK357RVY1JKXECcL8C26Zj2XbYf77GvY2UjsZI0XS7
         zcUT/lzxwMmjd6xTOFEnHvlbOLxM7WjwisodUasbCBQETpfvjBuMgYEJfGRSEVQPhg+o
         nFmQ==
X-Gm-Message-State: AC+VfDxKD7rB93nYgkcVd7DucKal5vFx2Rc4482k2SP5Q05ufjJL4QY2
        yyj6hYhAWS4J1a7Z/5xv+gQ=
X-Google-Smtp-Source: ACHHUZ7xuBLG5y7Qcbr7OisVerNmZLaxF0myI51giFtWtcvLnPe3PgNpexK5oojaFoLyRV5wKfQMyA==
X-Received: by 2002:a17:902:ecc3:b0:1ab:528:5f85 with SMTP id a3-20020a170902ecc300b001ab05285f85mr30165389plh.59.1683845572671;
        Thu, 11 May 2023 15:52:52 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id bd8-20020a170902830800b001a967558656sm6419192plb.42.2023.05.11.15.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 15:52:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 11 May 2023 12:52:51 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     jiangshanlai@gmail.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 6/7] workqueue: Report work funcs that trigger automatic
 CPU_INTENSIVE mechanism
Message-ID: <ZF1xwy-gtR6F5jUC@slm.duckdns.org>
References: <20230511181931.869812-1-tj@kernel.org>
 <20230511181931.869812-7-tj@kernel.org>
 <20230511212606.GI2296992@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511212606.GI2296992@hirez.programming.kicks-ass.net>
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

Hello,

On Thu, May 11, 2023 at 11:26:06PM +0200, Peter Zijlstra wrote:
> On Thu, May 11, 2023 at 08:19:30AM -1000, Tejun Heo wrote:
> > Workqueue now automatically marks per-cpu work items that hog CPU for too
> > long as CPU_INTENSIVE, which excludes them from concurrency management and
> > prevents stalling other concurrency-managed work items. If a work function
> > keeps running over the thershold, it likely needs to be switched to use an
> > unbound workqueue.
> > 
> > This patch adds a debug mechanism which tracks the work functions which
> > trigger the automatic CPU_INTENSIVE mechanism and report them using
> > pr_warn() with exponential backoff.
> > 
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> 
> I did do wonder why you chose for external storage for this -- I figured
> it was to keep the cost down since it shouldn't really be happening, so
> storage in the normal data structures is a waste etc..?

The only releveant data structures are workqueue and work_struct. The former
is too coarse because a given workqueue can run any number of different work
items (e.g. system_wq). The latter is too transient to record anything on.
In a lot of cases, the only meaningfully identifiable thing is the work
function pointer, which doesn't have any data structure attached by default,
so...

Thanks.

-- 
tejun
