Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC4261DBA2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 16:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiKEPYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 11:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiKEPYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 11:24:15 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38EA2250D
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 08:24:14 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id a67so11502475edf.12
        for <linux-kernel@vger.kernel.org>; Sat, 05 Nov 2022 08:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+5dhhpEm2vjr+dohjgCHieQfUi2Cv1HFwBa9cJjBXSc=;
        b=lJiJsZPJkboi64dkjl01wtXWTldXAJ/4J7bLaOGgRPlxxem8mLhOvauJKFeUUu0dJe
         3J8BgmD5bT8u1KzgIkUTntNrwvS/NaSxlfDz8gugDP8cOWHCF1gB8TT3hMAsAs0RqOHf
         Knia3iilAy6sPIG+t5FpIiSZtT+TdO9cUjZhDlqrG63rdGQrvHxmtBZnRP/g/s+zWw04
         odhb7Qe2zFWiGK9xI/xcaqIV1ouIH54EXntkLjWptaq1nH1OOvevWks840BgIu3bUmgI
         Ssfjd16cJTAsy9tGzBtm+DpBWhZC9kRY+9ctY8wQKTSmAmT5natIj8ohabxd+wWZ/So/
         Gk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+5dhhpEm2vjr+dohjgCHieQfUi2Cv1HFwBa9cJjBXSc=;
        b=bxhIHT9AZ1K+cFgTA+dkMLW/+vY12HR1PgTJ6kovqiwMdFPG9zhZ57Wi4E7Ger6RsW
         Z/lArP7zkVOEzErLlHMKsts3NQMcWpNVC8GfGKd13juy1RDw15/Zxp1Tt6eoo0DDfRqI
         2LtK6I4ic4h4b6v232yh3KJOJi3k59jZ88rkbyi/doY2lDJRHHtOQdFOExF9iyGTldSt
         NEJryX1Myye6LUpxDtbHMkndFj0HRRoKA6fksnDjbtRErtRZyrx9bCfhiqnd1V5w9mBM
         7lDeP77A/Ict7nFiLGTWDCGmLaHfC5elIrDS7cCLxW8GiRfvlj/DVI1XZ+Qdgnq561Bj
         OcXA==
X-Gm-Message-State: ACrzQf3Hm47DSEsyL306b5hPijflbLgy6nMBPj9s1avfmgGhf5I41sut
        p7tP9isaYVaGcBbPhIQle3kv8h7ywqWUx4pA6VUB7S9Z
X-Google-Smtp-Source: AMsMyM4beHDnS+yj02GSUjuQkm/8qjD+8Ztqqm3V1IlGLQ5jfxGx3T79EMKt9zEA4pCplWvDTJzHwNzSC3Nj8uVklu8=
X-Received: by 2002:a05:6402:1808:b0:461:52dd:499c with SMTP id
 g8-20020a056402180800b0046152dd499cmr40666793edy.120.1667661853089; Sat, 05
 Nov 2022 08:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221105033623.259053-1-jqlhn@163.com>
In-Reply-To: <20221105033623.259053-1-jqlhn@163.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Sat, 5 Nov 2022 10:24:01 -0500
Message-ID: <CABb+yY1moe2DmU9xJ0xR=U12ECmeHjN-cxfDYiw9ZBpcxRFp-g@mail.gmail.com>
Subject: Re: [PATCH] drivers:mailbox Using kfifo to store buffered message data
To:     jqlhn <jqlhn@163.com>
Cc:     linux-kernel@vger.kernel.org
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

On Fri, Nov 4, 2022 at 10:36 PM jqlhn <jqlhn@163.com> wrote:
>
> In current mailbox, a self implemented message array to be used
> as message fifo, I am replacing it with kernel kfifo,
> in order to make code cleaner.
>
> Signed-off-by: jqlhn <jqlhn@163.com>
> ---
>  drivers/mailbox/mailbox.c          | 33 ++++++++----------------------
>  drivers/mailbox/omap-mailbox.c     |  3 +--
>  drivers/mailbox/pcc.c              |  3 +--
>  include/linux/mailbox_controller.h | 10 ++++-----
>  4 files changed, 14 insertions(+), 35 deletions(-)
>
The circular buffer was implemented using an array because it is
simple enough and we wanted to keep tight control over the efficiency.
While you do manage to reduce 21 lines from 4 files, I am not sure
that is a reasonable tradeoff between readability and history plus
actual overhead of execution.

thanks.
