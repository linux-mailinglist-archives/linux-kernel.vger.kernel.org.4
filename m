Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044C5639795
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 19:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiKZSQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 13:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKZSQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 13:16:30 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200F215FEE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 10:16:29 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id x66so6806988pfx.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 10:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JGpKt/08MfScwB6fADFvl3111rWPJnPqOlgX6pbF40Q=;
        b=o8y5SyU0VgwzDDto4f1d87fe5Ma97bZLuDXEaIfj4X7z35KEHrKeZtCowPmplEjt/S
         VvkeyUkaW7I0m34pJKJ70N+CyuYoqzgazNha+5kLAzIEnhc1NZIAxBqF73901cDr7f2f
         Xa0n/Cwzp2LAAMhK1JCbpc9+QDq6EwZ1BbuqbW9bw0WncNzqKj9CeFk028w+YUNg9ZA8
         ihtxHuFZ4ccuKElAoxEMOU3bOBpgTkZybAwqrMVzBctP8VYjLMI3RK+jRlasmJZ08qxD
         C0naUbiZdN7xz1eNJaDLQsqUSUQMSftjhAIQ5EOSzqQpBktNlR9PV7/42kQwUt0SJbgt
         wAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGpKt/08MfScwB6fADFvl3111rWPJnPqOlgX6pbF40Q=;
        b=W2EDkCoHm7JoFFaEyi+4MuLTwFEV8ZZt7OMbKszDGRjnm3uG2030Wfr3gSnUmyil9O
         eew86p5db0vQlodl2kg/vBtVcuqly1eYOquKlzKwySW8agVZxdnajQrUiCwFGmL6OkRJ
         j56nNbcSOUT07J5Xzk52XzAQ/Hj6wAe2qg+mWA8qGHs5i+VWCZpK05sIuAPidVmn92Hl
         fgDjEpHC8jPCeisYVcDUpLL3Twh6ZxRaEK59xAvocEBij2B0O/kj9ILnfdiXu48aBkhj
         bHGxVrtY53E6QmVkN5VvC5scU1ZCr0QjBSaAQu4HjVtV/+viVbmidO9Sj5wBTl9/47Do
         AJNg==
X-Gm-Message-State: ANoB5pln6jdhGgmYZrg+MPP5/T0o+3JSvoy3tLvZ6MX2cMgfQz/qssIm
        aa1gSjFbW3SEsjow0mL4pOh+TjbBzufFEL/0lfw=
X-Google-Smtp-Source: AA0mqf51KcRqZtGXIoWsZgkico2/FQwgiHzOCmxsRfJvot8tEPra8WaOtbgOeiN/65HKyfAVVAiZf+6BPg/nq7ya/MY=
X-Received: by 2002:a62:2702:0:b0:572:8766:598b with SMTP id
 n2-20020a622702000000b005728766598bmr24121255pfn.21.1669486588616; Sat, 26
 Nov 2022 10:16:28 -0800 (PST)
MIME-Version: 1.0
References: <655fd7e303b852809d3a8167d28091429f969c73.1669486407.git.andreyknvl@google.com>
In-Reply-To: <655fd7e303b852809d3a8167d28091429f969c73.1669486407.git.andreyknvl@google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sat, 26 Nov 2022 19:16:17 +0100
Message-ID: <CA+fCnZceUx+Vqj7nUPiLrexnmU11KkGGtJ3-9KfXm336e+cv3w@mail.gmail.com>
Subject: Re: [PATCH mm] kasan: fail non-kasan KUnit tests on KASAN reports
To:     David Gow <davidgow@google.com>
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        andrey.konovalov@linux.dev
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

On Sat, Nov 26, 2022 at 7:15 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> After the recent changes done to KUnit-enabled KASAN tests, non-KASAN KUnit
> tests stopped being failed when KASAN report is detected.
>
> Recover that property by failing the currently running non-KASAN KUnit test
> when KASAN detects and prints a report for a bad memory access.
>
> Note that if the bad accesses happened in a kernel thread that doesn't
> have a reference to the currently running KUnit-test available via
> current->kunit_test, the test won't be failed. This is a limitation of
> KUnit, which doesn't yet provide a thread-agnostic way to find the
> reference to the currenly running test.
>
> Fixes: 49d9977ac909 ("kasan: check CONFIG_KASAN_KUNIT_TEST instead of CONFIG_KUNIT")
> Fixes: 7f29493ba529 ("kasan: switch kunit tests to console tracepoints")
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Hi David,

Could you please check whether this patch resolves the issue with
non-KASAN KUnit tests for you?

Thank you!
