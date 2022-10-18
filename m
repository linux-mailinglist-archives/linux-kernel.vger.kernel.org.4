Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EDD603166
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 19:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiJRRPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 13:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiJRRPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:15:10 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFDC659D6;
        Tue, 18 Oct 2022 10:15:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4AD85CE1EEC;
        Tue, 18 Oct 2022 17:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0657EC433D7;
        Tue, 18 Oct 2022 17:14:58 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kE0dAHKc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666113296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QTxwDDkBi7Nfmm7TAv1OXY/ZLApGbnvU9OAPNLtk0Xg=;
        b=kE0dAHKcK7SrsLfWKGaibg1ejzoF8w0Vgb0eMX2VJWuv8+EEARLxzUChB72sbslVzsEM+k
        VXzNL6jCm6IRboffpl5tf23Ks+OSH7ltPaTnSTHeG7vekYkzd96SqUBsk99wIC92TgZQlV
        S3fKTYo8E/zjp8gJwSU27yOlybyiqHk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id abc57c68 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 18 Oct 2022 17:14:56 +0000 (UTC)
Received: by mail-vs1-f50.google.com with SMTP id 1so11151629vsx.1;
        Tue, 18 Oct 2022 10:14:56 -0700 (PDT)
X-Gm-Message-State: ACrzQf0iAQ+vvHU7UHd3BAs7XnhuxtIg9h9MjwhMVAJSpT0vDVLj4+bM
        vLQ+aDcldICpuIgpbpEveI+ObSUf0ZwC0jQLUlY=
X-Google-Smtp-Source: AMsMyM7B5gbmBOed9B0LhHaEjBvK0LfJG6SscWu/f4mfb7WZohB2Cko3AEvh9sbs3SZn9nilN+dHm7JQDdoKLlCqk/g=
X-Received: by 2002:a05:6102:7c9:b0:3a7:6261:935 with SMTP id
 y9-20020a05610207c900b003a762610935mr2159460vsg.73.1666113294705; Tue, 18 Oct
 2022 10:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221018100510.never.479-kees@kernel.org> <Y07bqnZVrA9FO03z@zx2c4.com>
 <202210181011.EA0B964@keescook>
In-Reply-To: <202210181011.EA0B964@keescook>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 18 Oct 2022 11:14:43 -0600
X-Gmail-Original-Message-ID: <CAHmME9r+9MPH6zk3Vn=buEMSbQiWMFryqqzerKarmjYk+tHLJA@mail.gmail.com>
Message-ID: <CAHmME9r+9MPH6zk3Vn=buEMSbQiWMFryqqzerKarmjYk+tHLJA@mail.gmail.com>
Subject: Re: [PATCH] siphash: Convert selftest to KUnit
To:     Kees Cook <keescook@chromium.org>
Cc:     David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 11:13 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Oct 18, 2022 at 11:00:26AM -0600, Jason A. Donenfeld wrote:
> > On Tue, Oct 18, 2022 at 03:05:46AM -0700, Kees Cook wrote:
> > > Convert the siphash self-test to KUnit so it will be included in "all
> > > KUnit tests" coverage, and can be run individually still:
> > >
> > > $ ./tools/testing/kunit/kunit.py run siphash
> > > ...
> > > [02:58:45] Starting KUnit Kernel (1/1)...
> > > [02:58:45] ============================================================
> > > [02:58:45] =================== siphash (1 subtest) ====================
> > > [02:58:45] [PASSED] siphash_test
> > > [02:58:45] ===================== [PASSED] siphash =====================
> > > [02:58:45] ============================================================
> > > [02:58:45] Testing complete. Ran 1 tests: passed: 1
> > > [02:58:45] Elapsed time: 21.421s total, 4.306s configuring, 16.947s building, 0.148s running
> > >
> > > Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> > > Cc: David Gow <davidgow@google.com>
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> >
> > I'll queue this up. Thanks for the conversion. Appears to work well.
>
> Cool! Thanks for looking it over. If we want to avoid some tree
> collisions, I could carry it in my tree? I've got some other conversions
> in progress. Though maybe this begs the question of "how should kunit
> tests be ordered in the Kconfig and Makefile?" so that collisions are
> obvious about how to order...

No problem:

Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>

Please use a lowercase "convert" in the commit subject, like the other
siphash commits.

Jason
