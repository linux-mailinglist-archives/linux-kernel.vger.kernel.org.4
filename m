Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736666FE481
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 21:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236253AbjEJTa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 15:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbjEJTaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 15:30:25 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E836865A0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 12:30:24 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-643a6f993a7so4487840b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 12:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683747024; x=1686339024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lDQeDrUgQr9ns4tR7WjjBfCsJgY0JHbmPWw81YSldjI=;
        b=dntUFt1jUz1mLR9xeX6JZKi6rXqV2nwLbcaew1g+FoL4kYUf4bMS/MoQWW91p4gmul
         786l7hOVlSiBOTc/qk1mbG9lyW4JgYjkQ6xrQiHpEap8KxW+uTUKFCiCWzZWo36/T6IP
         nQAoAjTkSt4v6aL2IPYvkUsjwHbwAOGudPub1gymJ+bPvN1McaSN9yKbo+QfNBG5s4Yb
         Izsz+Ul50ba7SvgZvla+k4Z5HZHcpI0vsZs9E5/H+8oFobsv6GjG1rGOYULb7XXcbe6i
         TeeGAEKAb/nS+MUOEv7/uFhQvnXJgvwjA5KzUOxaZus8xey05ub70HYdYxklSdDLJpeP
         DB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683747024; x=1686339024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDQeDrUgQr9ns4tR7WjjBfCsJgY0JHbmPWw81YSldjI=;
        b=ULvHaXFyJ/r+jYdaSH8XZ1Auj/7CuAWIpprlOFaQ8ys1uYmwVKNkKnQuKOdzzaKmSu
         Zbldidw+sKboihWm6/BSwfhcz2LqMnLDIlN9asm94h0qqDF9JdJlgobeeFw7tBzl05I7
         DrrosSmkJ/QtjVvXmYf/ZGtC+B29dqBo6GI+yK/uIcF9bA64LFoYC4AxnHGvrkfHSJuG
         3LlW807/vQr42WxzpfVHteI4qEA9VfqFcohWplLxoDQqs7EwlMMs48leCPlh0bEjteDD
         +ps4Z1IRix797Il69SeFa88RAC5jyIshjXPKfZrEZiEtU8wS9lpbODK52umUtkBbTmcu
         ozRg==
X-Gm-Message-State: AC+VfDzX18kykdxTPBl7YVuULi04fzmdAcNwE3eEkiUdOflroAJ3QLqv
        vavnk/+8XCPBwOuUrTe1wSBV98nzHnQ=
X-Google-Smtp-Source: ACHHUZ4TiIJ6Qo+UJlvURSn60GARm76V0j7Jf8YA9TNQZ/NvveIFkVA7+cDSeUlGdE01ihmqg2+uiA==
X-Received: by 2002:a05:6a20:3d01:b0:100:c3ad:79b4 with SMTP id y1-20020a056a203d0100b00100c3ad79b4mr13168746pzi.32.1683747024211;
        Wed, 10 May 2023 12:30:24 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id y21-20020a63ce15000000b0051ba9d772f9sm3581921pgf.59.2023.05.10.12.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 12:30:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 10 May 2023 09:30:22 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v6 08/21] workqueue: Use global variant for add_timer()
Message-ID: <ZFvwziQbEKxcAb9G@slm.duckdns.org>
References: <20230510072817.116056-1-anna-maria@linutronix.de>
 <20230510072817.116056-9-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510072817.116056-9-anna-maria@linutronix.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 09:28:04AM +0200, Anna-Maria Behnsen wrote:
> The implementation of the NOHZ pull at expiry model will change the timer
> bases per CPU. Timers, that have to expire on a specific CPU, require the
> TIMER_PINNED flag. If the CPU doesn't matter, the TIMER_PINNED flag must be
> dropped. This is required for call sites which use the timer alternately as
> pinned and not pinned timer like workqueues do.
> 
> Therefore use add_timer_global() to make sure TIMER_PINNED flag is dropped.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Please feel free to route the patch as you see fit.

Thanks.

-- 
tejun
