Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4CA5E86D4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 02:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiIXAyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 20:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiIXAyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 20:54:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70F21AD99
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:54:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BB9961782
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 00:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC061C433D6
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 00:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663980877;
        bh=FnlLM7x8wxEcudWIHD7/o9TYNzXmw7+Y0Qj/SzI2FIM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n0qFZ24BrF/Bg0ypFVOjJFSzcK+67L9EybHMnwga6QrX+5knZI2w+cTf7g034Fbw3
         y9bmcvPQsMqP66sfivoAwHaNR0LsOAZ7aSE1ZIyTG+qIMiYiExerwToHV1sxsHnUjG
         dRxmmm/6AID0aF+HQkM0poTKk0g/YDENtKtfdNtuoS57RhRUl97SPZKKirSK/NqQhf
         +l9qFBqMloKvgsQhbw0BQh/uRzcaJciHcpUN1ErbVubTg0/vr+XoW5JHSE7+KVGDdU
         n71HtjZjnndHEVM2t+QGaqDimOgB2ZofDCi8BKXno7W6aclk10IkryhWvvOwKg8GZU
         qfo2Dof7o2Itw==
Received: by mail-ej1-f45.google.com with SMTP id y3so3875263ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 17:54:37 -0700 (PDT)
X-Gm-Message-State: ACrzQf0zbq9u018D4BAOy4hlXDIEhml56HBjaIJXjlrNoFiFGYlfQWe4
        Z3odZP5w7RKPB80ROSOcHjVvH+TZ8drFodrwZWE=
X-Google-Smtp-Source: AMsMyM7IkQAexfwgmpoc5mweupDADxK1a85NncvpD4iuDrc8QqpcNLhPD90MgA+S7CVHeqi70T+YXQr9BlTgx0LNEyw=
X-Received: by 2002:a17:907:6d23:b0:782:c9fe:19fa with SMTP id
 sa35-20020a1709076d2300b00782c9fe19famr3230695ejc.707.1663980875842; Fri, 23
 Sep 2022 17:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220919172955.1196326-1-song@kernel.org>
In-Reply-To: <20220919172955.1196326-1-song@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 23 Sep 2022 17:54:23 -0700
X-Gmail-Original-Message-ID: <CAPhsuW42bjAEZwELabNKHpS2iWs9ps8NygU_G6cJ404PbJLi9Q@mail.gmail.com>
Message-ID: <CAPhsuW42bjAEZwELabNKHpS2iWs9ps8NygU_G6cJ404PbJLi9Q@mail.gmail.com>
Subject: Re: [PATCH] ftrace: fix recursive locking direct_mutex in ftrace_modify_direct_caller
To:     open list <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Kernel Team <kernel-team@fb.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

Does this fix make sense to you?

Thanks,
Song

On Mon, Sep 19, 2022 at 10:30 AM Song Liu <song@kernel.org> wrote:
>
> Naveen reported recursive locking of direct_mutex with sample
> ftrace-direct-modify.ko:
>
> [   74.762406] WARNING: possible recursive locking detected
> [   74.762887] 6.0.0-rc6+ #33 Not tainted
> [   74.763216] --------------------------------------------
> [   74.763672] event-sample-fn/1084 is trying to acquire lock:
> [   74.764152] ffffffff86c9d6b0 (direct_mutex){+.+.}-{3:3}, at: \
>     register_ftrace_function+0x1f/0x180
> [   74.764922]
> [   74.764922] but task is already holding lock:
> [   74.765421] ffffffff86c9d6b0 (direct_mutex){+.+.}-{3:3}, at: \
>     modify_ftrace_direct+0x34/0x1f0
> [   74.766142]
> [   74.766142] other info that might help us debug this:
> [   74.766701]  Possible unsafe locking scenario:
> [   74.766701]
> [   74.767216]        CPU0
> [   74.767437]        ----
> [   74.767656]   lock(direct_mutex);
> [   74.767952]   lock(direct_mutex);
> [   74.768245]
> [   74.768245]  *** DEADLOCK ***
> [   74.768245]
> [   74.768750]  May be due to missing lock nesting notation
> [   74.768750]
> [   74.769332] 1 lock held by event-sample-fn/1084:
> [   74.769731]  #0: ffffffff86c9d6b0 (direct_mutex){+.+.}-{3:3}, at: \
>     modify_ftrace_direct+0x34/0x1f0
> [   74.770496]
> [   74.770496] stack backtrace:
> [   74.770884] CPU: 4 PID: 1084 Comm: event-sample-fn Not tainted ...
> [   74.771498] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), ...
> [   74.772474] Call Trace:
> [   74.772696]  <TASK>
> [   74.772896]  dump_stack_lvl+0x44/0x5b
> [   74.773223]  __lock_acquire.cold.74+0xac/0x2b7
> [   74.773616]  lock_acquire+0xd2/0x310
> [   74.773936]  ? register_ftrace_function+0x1f/0x180
> [   74.774357]  ? lock_is_held_type+0xd8/0x130
> [   74.774744]  ? my_tramp2+0x11/0x11 [ftrace_direct_modify]
> [   74.775213]  __mutex_lock+0x99/0x1010
> [   74.775536]  ? register_ftrace_function+0x1f/0x180
> [   74.775954]  ? slab_free_freelist_hook.isra.43+0x115/0x160
> [   74.776424]  ? ftrace_set_hash+0x195/0x220
> [   74.776779]  ? register_ftrace_function+0x1f/0x180
> [   74.777194]  ? kfree+0x3e1/0x440
> [   74.777482]  ? my_tramp2+0x11/0x11 [ftrace_direct_modify]
> [   74.777941]  ? __schedule+0xb40/0xb40
> [   74.778258]  ? register_ftrace_function+0x1f/0x180
> [   74.778672]  ? my_tramp1+0xf/0xf [ftrace_direct_modify]
> [   74.779128]  register_ftrace_function+0x1f/0x180
> [   74.779527]  ? ftrace_set_filter_ip+0x33/0x70
> [   74.779910]  ? __schedule+0xb40/0xb40
> [   74.780231]  ? my_tramp1+0xf/0xf [ftrace_direct_modify]
> [   74.780678]  ? my_tramp2+0x11/0x11 [ftrace_direct_modify]
> [   74.781147]  ftrace_modify_direct_caller+0x5b/0x90
> [   74.781563]  ? 0xffffffffa0201000
> [   74.781859]  ? my_tramp1+0xf/0xf [ftrace_direct_modify]
> [   74.782309]  modify_ftrace_direct+0x1b2/0x1f0
> [   74.782690]  ? __schedule+0xb40/0xb40
> [   74.783014]  ? simple_thread+0x2a/0xb0 [ftrace_direct_modify]
> [   74.783508]  ? __schedule+0xb40/0xb40
> [   74.783832]  ? my_tramp2+0x11/0x11 [ftrace_direct_modify]
> [   74.784294]  simple_thread+0x76/0xb0 [ftrace_direct_modify]
> [   74.784766]  kthread+0xf5/0x120
> [   74.785052]  ? kthread_complete_and_exit+0x20/0x20
> [   74.785464]  ret_from_fork+0x22/0x30
> [   74.785781]  </TASK>
>
> Fix this by using register_ftrace_function_nolock in
> ftrace_modify_direct_caller.
>
> Fixes: 53cd885bc5c3 ("ftrace: Allow IPMODIFY and DIRECT ops on the same function")
> Reported-and-tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  kernel/trace/ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 439e2ab6905e..d308d0674805 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5461,7 +5461,7 @@ int __weak ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
>         if (ret)
>                 goto out_lock;
>
> -       ret = register_ftrace_function(&stub_ops);
> +       ret = register_ftrace_function_nolock(&stub_ops);
>         if (ret) {
>                 ftrace_set_filter_ip(&stub_ops, ip, 1, 0);
>                 goto out_lock;
> --
> 2.30.2
>
