Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F6A6C37CF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjCURHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCURHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:07:14 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F143D0B0;
        Tue, 21 Mar 2023 10:06:40 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r29so14436382wra.13;
        Tue, 21 Mar 2023 10:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679418395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G2HoYoANsB+VvNaGXuuO9KcciwMkPoJj0KD18LbionU=;
        b=bMDI99RhOSW5vpSfE3GaWRu+pk0/tZcfKlMx/azfWpsGxXvt/Y4W8YPe49olPSmDq1
         avoK8x45BZyNoPvPal8UNnq1DUfb1owzNIno7rF8CYpcUrdl+J/Xlzx5DUX40UZcHeVO
         mT7nisyrxvGJoIssKJgF/ejYz8FTnXs6fbMTANuGoh0g9tn51Z3VSqPrp2MRic/P2k0i
         bp/MqDxjvddqC6GiVSmy4utJbrHT2uGw8sar8SU26siKxo+aZhuIQHuD+Wx5z4l725yl
         5n0ab3geMztsR4Cl6HlfAqnLsIuHhhawc1NhB3v6qm+fU8Pgwa9rmp5bMR5y15Svj+C5
         jGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679418395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2HoYoANsB+VvNaGXuuO9KcciwMkPoJj0KD18LbionU=;
        b=5DArywQcLcA/eeVzu1sQ6rXKPG5GE5Y8eTCER9PJcH/egaOZ3R6jQujTCQdybeF2k3
         q4v/XmCp95RlNanHHuDlPu6XlsfZ+gJnK4iwikAHf2auWlxtUEYXfQD/LmBB2mdwmzo8
         W53uHLsJx5NTVPG3EGsCeZpUL5UjpmG7sX81yNpzUqxJ8N4ljlcBQ+JgpBr96Jqzedbj
         tGbifFHmp+w2JzDC4tJ8jbsZOr2qrLOcfrdQRUA/knCKs28A/P0evswQ2DPQbHoIKGQo
         fZzxxsxUdk2Nx/IaEa7llE5dGRO0Oy0lMWQ+usx7SWYgBfZ3IV7LQghQRwetLHCCVQEa
         eeTA==
X-Gm-Message-State: AO0yUKXgvWTSxXGFzFbV9ezmRXYRKODXhhXGgoIbp1eXm9D6+fQnLZ2w
        0W8hS0UKlfxwneUZ3ZxRTPo=
X-Google-Smtp-Source: AK7set9p0814di118+c/TjT6mOORVqCK0RYOtIblfktO2fICJkJphjRKlMUiMPxWlGGvfOs/l592VA==
X-Received: by 2002:adf:ed0e:0:b0:2d3:bfcc:1b11 with SMTP id a14-20020adfed0e000000b002d3bfcc1b11mr2780971wro.42.1679418394749;
        Tue, 21 Mar 2023 10:06:34 -0700 (PDT)
Received: from krava (net-93-147-243-166.cust.vodafonedsl.it. [93.147.243.166])
        by smtp.gmail.com with ESMTPSA id n2-20020adffe02000000b002cfeffb442bsm11743267wrr.57.2023.03.21.10.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 10:06:34 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 21 Mar 2023 18:06:31 +0100
To:     Florent Revest <revest@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org
Subject: Re: [PATCH v2 0/7] Refactor ftrace direct call APIs
Message-ID: <ZBnkFz4aXwOjqInu@krava>
References: <20230321140424.345218-1-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321140424.345218-1-revest@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 03:04:17PM +0100, Florent Revest wrote:
> Differences since v1 [1]:
> - Use a READ_ONCE() to read the direct call address in call_direct_funcs
> - Added an Acked-by from Mark
> 
> This series refactors ftrace direct call APIs in preparation for arm64 support.
> It is roughly a subset of [2] rebased on v6.3-rc2 and meant to be taken by
> Steven's tree before all the arm64 specific bits.
> 
> The first patch was suggested by Steven in a review of [1], it makes it more
> obvious to the caller that filters probably need to be freed when unregistering
> a direct call.
> 
> The next three patches consolidate the two existing ftrace APIs for registering
> direct calls. They are only split to make the reviewer's life easier.
> Currently, there is both a _ftrace_direct and _ftrace_direct_multi API. Apart
> from samples and selftests, there are no users of the _ftrace_direct API left
> in-tree so this deletes it and renames the _ftrace_direct_multi API to
> _ftrace_direct for simplicity.
> 
> The main benefit of this refactoring is that, with the API that's left, an
> ftrace_ops backing a direct call will only ever point to one direct call. We can
> therefore store the direct called trampoline address in the ops (patch 5) and,
> in the future arm64 series, look it up from the ftrace trampoline. (in the
> meantime, it makes call_direct_funcs a bit simpler too)
> 
> Ftrace direct calls technically don't need DYNAMIC_FTRACE_WITH_REGS so this
> extends its support to DYNAMIC_FTRACE_WITH_ARGS (patch 6). arm64 won't support
> DYNAMIC_FTRACE_WITH_REGS.
> 
> Finally, it fixes the ABI of the stub direct call trampoline used in ftrace
> selftests.
> 
> This has been tested on x86_64 with:
> 1- CONFIG_FTRACE_SELFTEST
> 2- samples/ftrace/*.ko
> 
> 1: https://lore.kernel.org/all/20230316173811.1223508-1-revest@chromium.org/T/#t
> 2: https://lore.kernel.org/all/20230207182135.2671106-1-revest@chromium.org/T/#t
> 
> Florent Revest (6):
>   ftrace: Let unregister_ftrace_direct_multi() call ftrace_free_filter()
>   ftrace: Replace uses of _ftrace_direct APIs with _ftrace_direct_multi
>   ftrace: Remove the legacy _ftrace_direct API
>   ftrace: Rename _ftrace_direct_multi APIs to _ftrace_direct APIs
>   ftrace: Store direct called addresses in their ops
>   ftrace: Make DIRECT_CALLS work WITH_ARGS and !WITH_REGS

lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> Mark Rutland (1):
>   ftrace: selftest: remove broken trace_direct_tramp
> 
>  arch/s390/kernel/mcount.S                   |   5 +
>  arch/x86/kernel/ftrace_32.S                 |   5 +
>  arch/x86/kernel/ftrace_64.S                 |   4 +
>  include/linux/ftrace.h                      |  61 +--
>  kernel/bpf/trampoline.c                     |  12 +-
>  kernel/trace/Kconfig                        |   2 +-
>  kernel/trace/ftrace.c                       | 438 ++------------------
>  kernel/trace/trace_selftest.c               |  19 +-
>  samples/Kconfig                             |   2 +-
>  samples/ftrace/ftrace-direct-modify.c       |  10 +-
>  samples/ftrace/ftrace-direct-multi-modify.c |   9 +-
>  samples/ftrace/ftrace-direct-multi.c        |   5 +-
>  samples/ftrace/ftrace-direct-too.c          |  10 +-
>  samples/ftrace/ftrace-direct.c              |  10 +-
>  14 files changed, 101 insertions(+), 491 deletions(-)
> 
> -- 
> 2.40.0.rc2.332.ga46443480c-goog
> 
