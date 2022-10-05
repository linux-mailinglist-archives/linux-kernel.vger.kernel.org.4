Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF335F5804
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 18:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbiJEQIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 12:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiJEQH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 12:07:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D635C35E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 09:07:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E06E1B819BB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 16:07:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C90C433D7
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 16:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664986074;
        bh=5lKDK2r6yCQdUeHp185v5alf3NbvtLs++aqbdrzyX3c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ln83tHkJNp5W5R4+ZxNsUCp15uxvmzqdOC+inNttSjNJsGO8IutqP0wtaFe99Vll/
         /zFzOqpXN0rViEIq+8JkoH9XmPGNWSTEU/mWBmAxS1dl0Wy4hQk3HX5soYG+dLGX9c
         oYsjxPwtNeE1wmVZRjKZmVnDIjexsGnaNn6BkgLxHVlBU5KQSVBqCKH2VN4VZJ9ckB
         DwR+5Yhxk83hiTuN0v3+JEABGdelf+TcKB/qaR8eZ4Qm0KwYM3/YIv/myrEYo6U2bd
         CNTUi+h9V3/7CbGowosm0RXtHns0LtUp4AkCkY/FMuNq5abIAAGD1wIpAMYO8W01Bk
         AT1ktN2KjjGKg==
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-35711e5a5ceso127584977b3.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 09:07:54 -0700 (PDT)
X-Gm-Message-State: ACrzQf1ISNPWW7Hbody0FCfV9WsaiOhk3l43Da+TwTvv7yOIpYwuma/u
        UV6jTcHs7GOHjt7dsnSPUOT+p3rnWLUif9BdVCg=
X-Google-Smtp-Source: AMsMyM6o8xIDKPBcvx/VwQfTfTPequWddmuF4HIgYYiKmOC0WqJ0THLwFTTlD08ltnwoyJczvl3ZIWmkaGjH1ft22qk=
X-Received: by 2002:a81:7154:0:b0:356:6f31:aa7b with SMTP id
 m81-20020a817154000000b003566f31aa7bmr433578ywc.115.1664986073593; Wed, 05
 Oct 2022 09:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221005113757.041df7fe@gandalf.local.home>
In-Reply-To: <20221005113757.041df7fe@gandalf.local.home>
From:   Ross Zwisler <zwisler@kernel.org>
Date:   Wed, 5 Oct 2022 10:07:42 -0600
X-Gmail-Original-Message-ID: <CAOxpaSU7EPHi6Z4PccTkuPJah8C04Tx54gv9e=WcAhbLEKgtwA@mail.gmail.com>
Message-ID: <CAOxpaSU7EPHi6Z4PccTkuPJah8C04Tx54gv9e=WcAhbLEKgtwA@mail.gmail.com>
Subject: Re: [PATCH v2] tracing: Do not free snapshot if tracer is on cmdline
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 5, 2022 at 9:37 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> The ftrace_boot_snapshot and alloc_snapshot cmdline options allocate the
> snapshot buffer at boot up for use later. The ftrace_boot_snapshot in
> particular requires the snapshot to be allocated because it will take a
> snapshot at the end of boot up allowing to see the traces that happened
> during boot so that it's not lost when user space takes over.
>
> When a tracer is registered (started) there's a path that checks if it
> requires the snapshot buffer or not, and if it does not and it was
> allocated it will do a synchronization and free the snapshot buffer.
>
> This is only required if the previous tracer was using it for "max
> latency" snapshots, as it needs to make sure all max snapshots are
> complete before freeing. But this is only needed if the previous tracer
> was using the snapshot buffer for latency (like irqoff tracer and
> friends). But it does not make sense to free it, if the previous tracer
> was not using it, and the snapshot was allocated by the cmdline
> parameters. This basically takes away the point of allocating it in the
> first place!
>
> Note, the allocated snapshot worked fine for just trace events, but fails
> when a tracer is enabled on the cmdline.
>
> Further investigation, this goes back even further and it does not require
> a tracer on the cmdline to fail. Simply enable snapshots and then enable a
> tracer, and it will remove the snapshot.
>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: stable@vger.kernel.org
> Fixes: 45ad21ca5530 ("tracing: Have trace_array keep track if snapshot buffer is allocated")
> Reported-by: Ross Zwisler <zwisler@kernel.org>

With this patch I'm able to successfully use the function_graph tracer
with boot snapshots, thanks!

Tested-by: Ross Zwisler <zwisler@kernel.org>
