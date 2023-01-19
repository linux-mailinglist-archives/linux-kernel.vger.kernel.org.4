Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE90672EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 03:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjASC3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 21:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjASC3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:29:02 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAEC3253A;
        Wed, 18 Jan 2023 18:29:01 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id t8so39248pjj.4;
        Wed, 18 Jan 2023 18:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/nnDmMmj8DCiWBvavTR7rDDek9BtJKWmbpkPWik9/o=;
        b=WjS/w1/HFx8yR3TckvdaBFHXP8QfnyybctzIgONyokaNuV9KuO4ITvhU4Bdom7nJ4N
         hpkcjVMJpxA/YGdozH0k3rlknRkdLV9Cx2W4r68y3r0OivjixIejnyekpF61AH8lTUkA
         SCryyvF3Wwi47+qGo97kTuykkzuaLhYyPU61ZuYRoauILy1nKiD/xU0PDOf3sSFzq4Zf
         W7DEI//JYvJWt98JleKg7S43QvP7X9A3fEEaQlNVMzj+rt15kGABbqUFE9YAsCst66sK
         gk7rLT3rJhHLLYiC6kNWTIkh8XMMdqBfKZ7UGWDhGW5t8Y/rOfuYJRzlyt6l7GT0ikMj
         a2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/nnDmMmj8DCiWBvavTR7rDDek9BtJKWmbpkPWik9/o=;
        b=tiTuaD6Hw094vb6sOqUf5F36VhLyEI1D+JkTMO4rSyyZ+ehhRVklQsGQkcUK/r5eLf
         ihcinDeJMRBi5tIdzibExokCGoWKoTVZg2CEjA2sH1foJq+63tiMumSWvkV5xu9bmb+r
         62ViNg98qfaLq9LBImkH7/IMuilYN4LCcrvVWBmartprUfgO/ALlmN7LmhQ+8EPNkZHO
         0xXKcA65YbniPRBn2CzVH48dUak1tx7rV6t9dfFg7GguFmLNdAOMBmCMGK5TrN5Yg4t7
         ZvoVZAV/1tUEtuDcDS/lgZywToHzi37SLm2Bt0EjHKoWygn1HOqfy89zx3MCkZdkGDtI
         poiA==
X-Gm-Message-State: AFqh2kqIpi2irgxmzcEdZ8r3b7B6xJO/4G0+nmxA7rH/l+iSRzQWHl1j
        ydJ5ekRTkAoBHdm3kV4enNM=
X-Google-Smtp-Source: AMrXdXuv7Ge6RS9jbru1XsHch+oH048KEE3jmw/irIexrjag4KmKCqiWmtE/HFFnhhOdMyLN9512Og==
X-Received: by 2002:a17:90a:74c3:b0:229:1df9:bc73 with SMTP id p3-20020a17090a74c300b002291df9bc73mr9941743pjl.26.1674095340774;
        Wed, 18 Jan 2023 18:29:00 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id k1-20020a17090a7f0100b00223f495dc28sm2001145pjl.14.2023.01.18.18.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 18:29:00 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 18 Jan 2023 16:28:58 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     Sandeep Dhavale <dhavale@google.com>,
        Daeho Jeong <daehojeong@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] workqueue: Add WQ_SCHED_FIFO
Message-ID: <Y8iq6gLtmX1c8VSf@slm.duckdns.org>
References: <20230113210703.62107-1-nhuck@google.com>
 <Y8HI+42TxxlJxT6D@slm.duckdns.org>
 <CAJkfWY4Az45dNkPu5JpDsiMV-gRLe2VjVuixQd9xNG7zdLb4jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJkfWY4Az45dNkPu5JpDsiMV-gRLe2VjVuixQd9xNG7zdLb4jA@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jan 18, 2023 at 06:01:04PM -0800, Nathan Huckleberry wrote:
> Do you think something similar should be done for WQ_UNBOUND? In most
> places where WQ_HIGHPRI is used, WQ_UNBOUND is also used because it
> boosts performance. However, I suspect that most of these benchmarks
> were done on x86-64. I've found that WQ_UNBOUND significantly reduces
> performance on arm64/Android.

One attribute with per-cpu workqueues is that they're concurrency-level
limited. ie. if you have two per-cpu work items queued, the second one might
not run until the first one is done. Maybe people were trying to avoid
possible latency spikes from that?

Even aside from that, UNBOUND tends to give more consistent latency
behaviors as you aren't necessarily bound to what's happening on that
particular, so I guess maybe that's also why but I didn't really follow how
each user is picking and justifying these flags, so my insight is pretty
limited.

> From the documentation, using WQ_UNBOUND for performance doesn't seem
> correct. It's only supposed to be used for long-running work. It might
> make more sense to get rid of WQ_UNBOUND altogether and only move work
> to unbound worker pools once it has stuck around for long enough.

UNBOUND says: Don't pin this to one cpu or subject it to workqueue's
concurrency limit. Use workqueue as a generic thread pool.

I don't know what you mean by performance but HIGHPRI | UNBOUND will
definitely improve some aspects.

> Android will probably need to remove WQ_UNBOUND from all of these
> performance critical users.
> 
> If there are performance benefits to using unbinding workqueues from
> CPUs on x86-64, that should probably be a config flag, not controlled
> by every user.

It's unlikely that the instruction set is what's making the difference here,
right? It probably would help if we understand why it's worse on arm.

I don't think ppl have been all that deliberate with these flags, so it's
also likely that some of the usages can drop UNBOUND completely but I really
think more data and analyses would help.

Thanks.

-- 
tejun
