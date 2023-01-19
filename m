Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7795674655
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjASWo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjASWoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:44:15 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8825A45F8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 14:25:00 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id x5so2817277qti.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 14:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ctnu63K1vpKs3li1zDRBlfCvzilGPBU0TfW6l2R0lmM=;
        b=l1A0s8xjLqdrWQb2OPBFli7rYKSUuTSQFfsJiLchd3T3547ogsK5hc3B33YLmBHC/F
         1rZuF+BMO23NF9NKXmpfvAixBEpYRAPi3tgYJ5YIcSpA52jKBzOtUY1rXXCnnMabwQ6m
         ior4UcOvFQcMPwdc2D8s6aHXmV5tdsiNLPSRdWdwn7ZaHqWY8yRM62bp4lGTwoJzOMkQ
         RDqxGgdk1WxNEhv/H6ZV9RBxpFJ8Hsm516QRnMGXNyQyNIt6f9powaCB7EXUZS0ypc+/
         xcdJ6V58xfYqLflhlIlLvHreQwNgOqy5XbAoGj8Nrc1XuuVG2NTv/NvW2yChSKvFFes7
         dyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctnu63K1vpKs3li1zDRBlfCvzilGPBU0TfW6l2R0lmM=;
        b=DrR4hn6DIxNW5ItfJK2vzZMYNyFoABqzVxXMFURCYf6O1wSSKco2icynmGvyVge1lw
         ChwmnXm+1CSHQCW3YjJR0O2kipXKXrsEcJXO3qNW9DxgzwXQr/5sndnU3Ih/Pxh/cQMW
         vKsFHiiGzcphJiuxnWgvdtLYNMniLQzTvn0FuDWkjASFWGpOF6yKcXEWASqnrmdoKML7
         CDVZcxA1VFZ1CKDestH778wgdkK3vuzrKL6SWlu3OuVjiEJXDllMZ8HWt2svToWo5pvL
         UZ3bh7ae69nXFq3sdL1CZaa2r/Dme3Eqt0ro/UXkCwVbaktAy+P6CVWhmkYaK/jraeRS
         alOA==
X-Gm-Message-State: AFqh2krfEUXGeWXb77tsVlKjXckfvC2yj/umgSEt36a0fiFbdKUa9W/5
        edvN/lh8HiVPtgwY56gI4DXvvg==
X-Google-Smtp-Source: AMrXdXu0twd0zjnaY/qCkc9qQ8Lz3ReKzVM3+2YEmANrJnL/ixSIiit1XYV0GR9YjcwY9Vda1UPaoQ==
X-Received: by 2002:ac8:7450:0:b0:3b6:320f:7580 with SMTP id h16-20020ac87450000000b003b6320f7580mr22393495qtr.17.1674167097200;
        Thu, 19 Jan 2023 14:24:57 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bbe8])
        by smtp.gmail.com with ESMTPSA id ez11-20020a05622a4c8b00b003afbf704c7csm3228529qtb.24.2023.01.19.14.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 14:24:56 -0800 (PST)
Date:   Thu, 19 Jan 2023 17:25:53 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Munehisa Kamata <kamatam@amazon.com>, Tejun Heo <tj@kernel.org>,
        ebiggers@kernel.org, hdanton@sina.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mengcc@amazon.com
Subject: Re: another use-after-free in ep_remove_wait_queue()
Message-ID: <Y8nDcY8EQDx+vSRv@cmpxchg.org>
References: <CAJuCfpEMEsSYcKakFiDK=QV+apW-2baLcUcw7uRyrmKkWVnR8A@mail.gmail.com>
 <20230113022555.2467724-1-kamatam@amazon.com>
 <CAJuCfpEH7kC=S8S_SRLW-X483kpaL4xdn5b35Ou08V7b56QdJA@mail.gmail.com>
 <CAJuCfpHV2-pnHd6U3paA1fO2gaYP1RTqAJwp_5QC7C2YR3JG5g@mail.gmail.com>
 <CAJuCfpFZ3B4530TgsSHqp5F_gwfrDujwRYewKReJru==MdEHQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpFZ3B4530TgsSHqp5F_gwfrDujwRYewKReJru==MdEHQg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 01:01:42PM -0800, Suren Baghdasaryan wrote:
> I spent some more time digging into the details and this is what's
> happening. When we call rmdir to delete the cgroup with the pressure
> file being epoll'ed, roughly the following call chain happens in the
> context of the shell process:
> 
> do_rmdir
>   cgroup_rmdir
>     kernfs_drain_open_files
>       cgroup_file_release
>         cgroup_pressure_release
>           psi_trigger_destroy
> 
> Later on in the context of our reproducer, the last fput() is called
> causing wait queue removal:
> 
> fput
>   ep_eventpoll_release
>     ep_free
>       ep_remove_wait_queue
>         remove_wait_queue
> 
> By this time psi_trigger_destroy() already destroyed the trigger's
> waitqueue head and we hit UAF.
> I think the conceptual problem here (or maybe that's by design?) is
> that cgroup_file_release() is not really tied to the file's real
> lifetime (when the last fput() is issued). Otherwise fput() would call
> eventpoll_release() before f_op->release() and the order would be fine
> (we would remove the wait queue first in eventpoll_release() and then
> f_op->release() would cause trigger's destruction).
> Considering these findings, I think we can use the wake_up_pollfree()
> without contradicting the comment at
> https://elixir.bootlin.com/linux/latest/source/include/linux/wait.h#L253
> because indeed, cgroup_file_release() and therefore
> psi_trigger_destroy() are not tied to the file's lifetime.
> 
> I'm CC'ing Tejun to check if this makes sense to him and
> cgroup_file_release() is working as expected in this case.
> 
> Munehisha, if Tejun confirms this is all valid, could you please post
> a patch replacing wake_up_interruptible() with wake_up_pollfree()? We
> don't need to worry about wake_up_all() because we have a limitation
> of one trigger per file descriptor:

Solid analysis!

Indeed, wake_up_pollfree() should fix it.

