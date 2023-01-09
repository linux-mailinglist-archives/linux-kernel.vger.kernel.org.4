Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04363663404
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237875AbjAIWgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237865AbjAIWfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:35:50 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6B81A3B1;
        Mon,  9 Jan 2023 14:35:49 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id c124so9989317ybb.13;
        Mon, 09 Jan 2023 14:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=52Yp4ABn9IwKHczAHFLPCUw19xrvZxttBABJ3c0YKI4=;
        b=RCVr8mecrvtL/O6E/qBF81DQvb58HsZwdgJTH9veLCqWbv+Qt5J1UOwvTbzIjHOTrl
         CinVuPHJ0xnvCKbAbD3IV9YqW6esoZbpaL8beBWBtSOcy1xtsGkG5fBt+R8xiIr/a1nZ
         ndWdyy5gVsTpMn4sYnu1wZyU93rKiZ2Ib6MwsZspFK7jhRbjmcwWBSU0gd0mW2it1s9c
         4RQVL5DsD7B96cESSGaJwRSlDGZQ95OrfugcF8wxc2heL4Wrb1p4dgjGuQwUEbDgNayL
         zddfWqHdQxbEEaae8hRix7i782UZ3kn2B165vt77lyoLdZA32fsDv63YsnzsPmRZRlkq
         nfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=52Yp4ABn9IwKHczAHFLPCUw19xrvZxttBABJ3c0YKI4=;
        b=EpuTa5CdXCCjrgkwiajiO5xlDJ387Vs7If2pUDvH2VJ8TisVLWKU7HDK8uHCtyChxQ
         UIDv0WSy416ZVWwupj7qQU/sRG6qGCtUlJ/UoQC96U6zaC8Z0SS0ZKF7FC4jpXcnJLks
         7GRom/Z6LOB6MdNUXfV0xMm9Ilywtple9rb6w9l9PXWKkRK+Fl4llA34v9IHI/cCe7Iv
         9xmQTHEo5LtvYqhdJQTZTM0YQyLgtvP7MelDxRxew4KSL+s1FS2IASPDojK5JimdKBvs
         iWFPr+Ofge1yZQ0RLEMEPx78HWf4Do5tbUeki5m5IOnhyS1NbMitCPwTVMQ9UcNOXkB9
         EwOA==
X-Gm-Message-State: AFqh2koVP7BcA7AFtAGiLjJN1SDeVqOQWGFK7d3QsBvJXZs+nys87sls
        obKxVNMyAFhbjHuH+6lRZSPHIdc4mGZ8glccV5Y=
X-Google-Smtp-Source: AMrXdXvIgqHyx2PQsX1jelm9tHNRJNpUjVtta5I1yR1rH/j8hsnqR0y3tMH+8iClgeeXLA3OHzrSdxe+QtKI8Zg3IF8=
X-Received: by 2002:a25:bc43:0:b0:7b2:343d:6b11 with SMTP id
 d3-20020a25bc43000000b007b2343d6b11mr2539153ybk.75.1673303748797; Mon, 09 Jan
 2023 14:35:48 -0800 (PST)
MIME-Version: 1.0
References: <20230109135828.879136-1-mark.rutland@arm.com> <20230109135828.879136-2-mark.rutland@arm.com>
 <CANiq72kgmFYEO_EB_NxAF=S7VOf45KM7W3uwxxvftVErwfWzjg@mail.gmail.com> <Y7xJeHDcanUJoHt+@FVFF77S0Q05N>
In-Reply-To: <Y7xJeHDcanUJoHt+@FVFF77S0Q05N>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 9 Jan 2023 23:35:37 +0100
Message-ID: <CANiq72mUZRH4wxDF7L43z4Q1XoCdP=V_MmVTrCOTWRa8SHvwaA@mail.gmail.com>
Subject: Re: [PATCH 1/8] Compiler attributes: GCC function alignment workarounds
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        ndesaulniers@google.com, ojeda@kernel.org, peterz@infradead.org,
        rafael.j.wysocki@intel.com, revest@chromium.org,
        robert.moore@intel.com, rostedt@goodmis.org, will@kernel.org
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

On Mon, Jan 9, 2023 at 6:06 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> Sorry, that is something I had intendeed to do but I hadn't extracted a
> reproducer yet. I'll try to come up with something that can be included in the
> commit message and reported to GCC folk (and double-check at the same time that
> there's not another hidden cause)

Yeah, no worries :) I suggested it because from my quick test it
didn't appear to be reproducible trivially, so I thought having the
reproducer would be nice.

> I'm happy to move these, I just wasn't sure what the policy would be w.r.t. the
> existing __weak and __cold defitions since those end up depending upon
> __function_aligned.
>
> I assume I should move them all? i.e. move __weak as well?

Yeah, with the current policy, all should be moved since their
behavior now depends on the config (eventually).

Cheers,
Miguel
