Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92A7666B425
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 22:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjAOV3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 16:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjAOV3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 16:29:51 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1ED1630B
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 13:29:50 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id p25so21978303ljn.12
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 13:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=imIrwUXXSpGxJHX2IXIa4NzC1jMkxA/rgCDVCw5pEFE=;
        b=RWVPMLhj3nzukWBHC/0nsGVSXNfSsDSgW+QuchB/+fHdme4dQ77rAF0NrXjm/cnSO2
         +BxKMpMgJY85/EBZEaFUcTlSWeJ8CLONuZIKfYc0s00ztKHQhXEVDA8sMmdOyx/O21v8
         Kk6vJ1oidhdWGFl/HL5l5WvkmJvKlPhfletg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=imIrwUXXSpGxJHX2IXIa4NzC1jMkxA/rgCDVCw5pEFE=;
        b=JQOyHRu5aasmVZrwkAlJlgzsMN/534Vacq/QKUjAqkbMM6b3oqmtRylKq5CGdLVNdh
         SiQ29kFLtqa161R4Zh0YldqKTaBbix3N+7t9I2krz+j94CX2vJNjHLK8/Stfm7yttLx4
         XvZRxTr4kGtAzmHtVKibwjUCa1stKijzEMkpza1azle9l57uCGXw4iLDPzknXNa5Qds/
         YYrvtN9qCRxUryU2dgpyIiv8bZ4ak7RqhTWEbian05SCubqdNSYSF4LuKHR+2BzZxeVC
         AVa7lwKsQi5Tm4UHK8/mtQqvydvVDsXMVPF3aJ9NRC31tmZBhbn2y+37nxe8WhmyV9Kr
         3fsQ==
X-Gm-Message-State: AFqh2kqhWvyIE13+wT8RSy7AHUgMoaleMbuQ99Uvseb8Zx6zbeGOUZpx
        Hh9CvFsGpWBsPkf8ZfKQZ7LciOlzkL+nDgabnjsJFQ==
X-Google-Smtp-Source: AMrXdXvdy3taN11/dVs1uCoBkLM5Z3BbpAjjzT+Zg+zoauO3zWwSUCc2PjBReQ+vjgGadCr0ti/wUuBGWqao0CT5PVk=
X-Received: by 2002:a2e:964c:0:b0:284:6390:1f8 with SMTP id
 z12-20020a2e964c000000b00284639001f8mr2589023ljh.167.1673818188816; Sun, 15
 Jan 2023 13:29:48 -0800 (PST)
MIME-Version: 1.0
References: <20230112005223.2329802-1-joel@joelfernandes.org>
 <20230112005223.2329802-2-joel@joelfernandes.org> <20230115155455.0fb66c12@rorschach.local.home>
In-Reply-To: <20230115155455.0fb66c12@rorschach.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 15 Jan 2023 16:29:38 -0500
Message-ID: <CAEXW_YRjV0CqoALU6F_9LZKD_e84gWQ3a8juucmXxLUuDQ7DHw@mail.gmail.com>
Subject: Re: [PATCH v2 rcu/dev 2/2] rcu: Disable laziness if lazy-tracking
 says so
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        fweisbec@gmail.com, urezki@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2023 at 3:55 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 12 Jan 2023 00:52:23 +0000
> "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
>
> >
> >  static void
> > -__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy)
> > +__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
> >  {
> >       static atomic_t doublefrees;
> >       unsigned long flags;
> >       struct rcu_data *rdp;
> > -     bool was_alldone;
> > +     bool was_alldone, lazy;
>
> I'm curious to why the the extra variable.
>
> >
> >       /* Misaligned rcu_head! */
> >       WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
> > @@ -2622,6 +2622,7 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy)
> >       kasan_record_aux_stack_noalloc(head);
> >       local_irq_save(flags);
> >       rdp = this_cpu_ptr(&rcu_data);
> > +     lazy = lazy_in && !rcu_async_should_hurry();
>
> Wouldn't just having:
>
>         lazy = lazy && !rcu_async_should_hurry();
>
> be sufficient?

I prefer to not overwrite function arguments, it makes debugging harder IMHO.

 - Joel



>
> -- Steve
>
> >
> >       /* Add the callback to our list. */
> >       if (unlikely(!rcu_segcblist_is_enabled(&rdp->cblist))) {
> > --
