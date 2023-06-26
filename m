Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2FA73E656
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjFZRWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjFZRWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:22:14 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C7C1BC9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:21:48 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f14865fcc0so211e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687800107; x=1690392107;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EXUwrqbW0CXJtQS1yFwwf9wv/D/LvsteOPvVyPaUfSk=;
        b=joXIcqK3i0h55kc3s/d55vUiOTlQn7SbDLMMwxUdUM32dFRmUikiTbdHjDkcwnmwN6
         PPRmf2gf7wIFemHUiB+cbt7ZOlP9kCbfsztX9lftQAfYs5JRPqwFhrPhZvLyYJYkbZnj
         ftxvRH5aEru0CqtiHCIW7k7WIB6U1R6D8pdSJZLx0GH9BTZIKfilbrHcnnGLPFk+Btzi
         VoxskFgaeZksRGudmUxt4UDBTtmipInWBm+wVj5JgoITmadJPzMFDCSniRjQSRT8+WQs
         RaMjBz7Ta3BWcbsFlukXE/YfevMKzd2z/60B4UoAGUa3avALlD0bZyB5Kcbo6Kqn82P3
         t2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687800107; x=1690392107;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EXUwrqbW0CXJtQS1yFwwf9wv/D/LvsteOPvVyPaUfSk=;
        b=ka4brX8DdK8iFyFabQ2gmZOlkfbKgNtGuohmFMzA0tLJmtFNUA4mPtoWkuT5N7hcxg
         LYnprA+hIqQqEMWy8PAwMlG7QTfUh/iZp64Yx8SAqFTnXb36fQVzCZ85LyQEynnQ/wKo
         fzo5BDnjaGt3e/AcJ8f5dO2iDm8hNVzUF0dzupIguVB1Ac21YnPpEaoQVBBZPmmvF+md
         gNEN15Ux4vd2dwK6nrDuqySakEEgVA3cMp8z7rW7IGasC2ECSc/Eyo07Aunb35+770DV
         0exx/tNm/r6e0qQq4U2AvDjDC6x7nOyS0BL719MFgGyJO6KCp+SqhbvNJfuOrdydtM9t
         6Lzg==
X-Gm-Message-State: AC+VfDx7RgYoEFwgtevRvK94+M9TrACNL5ZGnhC7Wh3M9zd/JJkaEUh+
        DNlYrGkh5LuxI0O62q+6zlC4zu9K6MzOwEKHuegctQ==
X-Google-Smtp-Source: ACHHUZ49Xf5imMxxHbAmq1pZx/TUMlMscTGGSxt0e3GzZZiP4TlUcTbpNc4E0xG6h1gjBiXYnz/qs9qKmdpeeaaY9Do=
X-Received: by 2002:ac2:4470:0:b0:4f3:a7c6:590e with SMTP id
 y16-20020ac24470000000b004f3a7c6590emr116784lfl.7.1687800106702; Mon, 26 Jun
 2023 10:21:46 -0700 (PDT)
MIME-Version: 1.0
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 26 Jun 2023 19:21:34 +0200
Message-ID: <CACT4Y+bif9Wek-g10F5y0aLbH=JbCcqryi2nOUAFxGFo0O2B9A@mail.gmail.com>
Subject: Thread-safety annotations for irq/rcu/atomic contexts
To:     clang-built-linux <clang-built-linux@googlegroups.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Previous Lukas' attempt to apply clang thread-safety annotations to the kernel:
https://clangbuiltlinux.github.io/CBL-meetup-2020-slides/lukas/tsa.pdf

I am thinking if the annotations can be used to check for functions
that must/must not be called from irq/atomic/rcu_read/etc contexts.
Namely, we create global fake locks that denote these contexts, then
annotate spin_lock_irqsave/irqrestore/etc as taking releasing these
locks, and finally annotate functions are requiring/excluding these
contexts:

void foo() require(irq_context);
void bar() exclude(irq_context);
void baz() require(rcu_read_context);

This may help to catch "suspicious RCU usage", "scheduling while
atomic" and similar bug types statically. I suspect it may also be
simpler (?) to do rather than annotating all normal locks.

Does it make any sense?
