Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDD8649914
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 07:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiLLGsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 01:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiLLGsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 01:48:37 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F06F2DD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 22:48:37 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id u5so10970340pjy.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 22:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=98dSCzjjeyt2RiBMKzyLEVGv9smR4thOQJ6eBPuKnH0=;
        b=c5xxxFCe66C4WPZd/IpfOcWdr+rUwPOfif0fBX0U2xNDi4GDZrXVDTgZybOp7DOTSG
         3BIlSleg+ygfMkpDTdeo3t2nKKo1SospL5cXDpv9nyTvekAumiPe7CqxOT2KhPj2k81j
         6KIsMs2cRe5JUgjBK2GEQw2oSji6ObY+hQf/mORKZ5+vsmogy45Ie3qpaw2N4j6guNDV
         t1MRFR6RAMezTGWViDBjfDEdtC7u4zLMIAxD+gH3atnOYDxF/4bzOM9GL7fjWZPmTLKC
         k78ma1I2RdcbvanmXN5ZP10fJfnDFeK/Gtzm9UtN0ZAPXYMfSawUhGjUpsm5hsFIWe4A
         G4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=98dSCzjjeyt2RiBMKzyLEVGv9smR4thOQJ6eBPuKnH0=;
        b=QHDDlsPVX2xNTVaoxiqawRD7Efl3fHLCMkED5uTzOq9dRGq6vgf29M/QgbBKBZuH/l
         JysdbUmNTnR0a5rGzOq8BxkIs+JBdbztklS0a7YwzIK/Xk3pozTf4vIhp6EREXnc94Bx
         pmocM2VMg7ZNpr3E5wa4DtC1PM3qaXOLQs+v2cav14jY5SIbyBfPpJBvcPIHmwS/IYvO
         64UHV1FqAMn3C+kfomVlDweRbNmguHZn7mifk+N3dPqM1VY+l75dxxiH2K1iEp8JJxUp
         3ZhlIIba6hxHLRtGdBMMhKS1Z0hEL7rTA1BtSKsKWEs/S1ZyMorBIML4/fqFwhJ6D9cI
         vHjA==
X-Gm-Message-State: ANoB5plOwAwxbA4EbQe1qEyjah/DrIvH/Gl+f2bK90I6ssfvu8+zXN0H
        TuWsGbH/1vjk8P+2PQpndT3MuUK2d0ZyItLZ8PA=
X-Google-Smtp-Source: AA0mqf7eKWIfCkxw/ewlX50SMbwed+z2uMrJRgMTcJwFUEVxPVq2UE1biaKFpqhmBZZbahDwO7lUTVHr5FgJbGv5kDk=
X-Received: by 2002:a17:90a:e542:b0:219:9bdc:b0f with SMTP id
 ei2-20020a17090ae54200b002199bdc0b0fmr28211115pjb.220.1670827716628; Sun, 11
 Dec 2022 22:48:36 -0800 (PST)
MIME-Version: 1.0
References: <20221212061836.3620-1-richard.xnu.clark@gmail.com> <Y5bI9ZbjpzNFpk/8@slm.duckdns.org>
In-Reply-To: <Y5bI9ZbjpzNFpk/8@slm.duckdns.org>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Mon, 12 Dec 2022 14:48:25 +0800
Message-ID: <CAJhGHyA=qGtktv6BPavo5HRrDkcORqpkD3C7nhnxyFtt8WNJMg@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Prevent a new work item from queueing into a
 destruction wq
To:     Tejun Heo <tj@kernel.org>
Cc:     Richard Clark <richard.xnu.clark@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 2:23 PM Tejun Heo <tj@kernel.org> wrote:
>
> On Mon, Dec 12, 2022 at 02:18:36PM +0800, Richard Clark wrote:
> > Currently the __WQ_DRAINING is used to prevent a new work item from queueing
> > to a draining workqueue, but this flag will be cleared before the end of a
> > RCU grace period. Because the workqueue instance is actually freed after
> > the RCU grace period, this fact results in an opening window in which a new
> > work item can be queued into a destorying workqueue and be scheduled
> > consequently, for instance, the below code snippet demos this accident:
>
> I mean, this is just use-after-free. The same scenario can happen with
> non-RCU frees or if there happens to be an RCU grace period inbetween. I'm
> not sure what's being protected here.

I think it is a kind of debugging facility with no overhead in the
fast path.

It is indeed the caller's responsibility not to do use-after-free.

For non-RCU free, the freed workqueue's state can be arbitrary soon and
the caller might get a complaint. And if there are some kinds of debugging
facilities for freed memory, the system can notice the problem earlier.

But now is RCU free for the workqueue, and the workqueue has nothing
different between before and after destroy_workqueue() unless the
grace period ends and the memory-allocation subsystem takes charge of
the memory.



Thanks
Lai
