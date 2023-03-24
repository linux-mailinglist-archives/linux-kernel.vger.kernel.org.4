Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948156C7676
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 05:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjCXEIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 00:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjCXEH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 00:07:57 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC1494
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 21:07:55 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id dw14so491432pfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 21:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679630875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2LfQ4bUGZWvA0RhGgJPkL2wWDD5iJCeigY4j8HTk/bI=;
        b=aaHGmkeM2buhuAyL59PFubTTRpNOm1eOr6ux6+8muJ71E4GdLMqxN/ANXRS2Ff2iqT
         puytLloUQm/NIr3fW/m4egfG9EAzyZI0SVKcGavWJAQBHL+kju0K9cQxrovSDlaS6PR/
         EpyuHT9jOB/RAxUTzC09aziuazUj4QdQCE8jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679630875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LfQ4bUGZWvA0RhGgJPkL2wWDD5iJCeigY4j8HTk/bI=;
        b=tP/k7xH01qXwsp7rl3RhuI0ubgL2A2H1uUNotbJBn8d1kG1wjeL7GM9luX1rJTp6RV
         Tsxddn5Y1pWI7HQyXHgK9H6MK+eXjwMOejitAtEFJQW9LVSnBDIeXiOshJy7ibnp2ynD
         0iqxLMypVX98l6hZMFgFmz+kR0S03fbdXHi8naUG67heOzpvrSBx328PG7WHUYu5i9Zj
         GvXMC/1xrpCKsnbNxOcsKqrbbOSUueF3ev7/Q/4jxrNLYXagj/U2Fp6WcAL4Rky94XsV
         P+u3Jz/goozRBti+6QFeClUYf4OQrbACJiD1tm7oaZyT08JnwKSBW4tcpMs/eqvMtT2m
         JQhA==
X-Gm-Message-State: AO0yUKXlDbrxXb5NoHnvy7coGTNm8J6trM3rP0bsn5V7FZVL9ARFZDZS
        einGEfV7bYwX5f1hAXURSxDrBQ==
X-Google-Smtp-Source: AK7set/p6NEs60N0pJLkWHg1ERai59XDLTc6q2wAVfQjBCptyxS1eAAboGBNMuT6+4vwwc9JM6nMnQ==
X-Received: by 2002:a05:6a00:80d0:b0:627:e677:bc70 with SMTP id ei16-20020a056a0080d000b00627e677bc70mr7152042pfb.14.1679630875169;
        Thu, 23 Mar 2023 21:07:55 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id t19-20020a62ea13000000b005a8de0f4c64sm12678235pfh.82.2023.03.23.21.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 21:07:54 -0700 (PDT)
Date:   Fri, 24 Mar 2023 13:07:50 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Mike Galbraith <umgwanakikbuti@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] zram: Replace bit spinlocks with spinlock_t for
 PREEMPT_RT.
Message-ID: <20230324040750.GE3271889@google.com>
References: <20230323161830.jFbWCosd@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323161830.jFbWCosd@linutronix.de>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/03/23 17:18), Sebastian Andrzej Siewior wrote:
> From: Mike Galbraith <umgwanakikbuti@gmail.com>
> 
> The bit spinlock disables preemption. The spinlock_t lock becomes a sleeping
> lock on PREEMPT_RT and it can not be acquired in this context. In this locked
> section, zs_free() acquires a zs_pool::lock, and there is access to
> zram::wb_limit_lock.
> 
> Use a spinlock_t on PREEMPT_RT for locking and set/ clear ZRAM_LOCK bit after
> the lock has been acquired/ dropped.
> 
> Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Link: https://lkml.kernel.org/r/YqIbMuHCPiQk+Ac2@linutronix.de
> ---
> 
> I'm simply forwarding Mike's patch here. The other alternative is to let
> the driver depend on !PREEMPT_RT. I can't tell likely it is that this
> driver is used. Mike most likely stumbled upon it while running LTP.

Yeah, I'm curious if anyone uses zram in preempt-rt systems. I don't
mind this patch but would be nice to add new code when it solves some
real problems. Maybe `depend on !PREEMPT_RT` can be a better option.
