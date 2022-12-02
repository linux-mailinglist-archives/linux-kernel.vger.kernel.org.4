Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2032863FD97
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 02:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiLBBTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 20:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiLBBTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 20:19:45 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B55ECEF93
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 17:19:45 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id j196so4346356ybj.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 17:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b7S/Lk010656nN0nZxqgfS6l85QGHGwdF8mVU2ojAvw=;
        b=AT27u0tgCh7uOLyY8Ql580WvVeAiLYjcI4f7NZQk46/CLU3/+7buoJ9V9c45rcuscx
         vO3aJrqhgyS83lteGHszZNkkP6VWo3MZjH2Qjet5VpEKr0WGC7ohz8eweYOlk/r4/M3N
         2re1dOKiEt2z8CUlhFFmVe1BO2uIxZ+/7iLECz027ISRWR5OSHZtMIrQ3EJwwv+7BrA8
         HuFq/TFGiHrpGVs5rpDfrSJezKlFjz8vkxbLERmHxYGvM66JGx9bqyz+9LTQMpygTbAX
         obXKGb1YCfLqFUB3LT2WKVMxMV0uKAc214ok+1DRf56odpooPaRsD/tiliqpYyz/Ar2b
         LRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b7S/Lk010656nN0nZxqgfS6l85QGHGwdF8mVU2ojAvw=;
        b=4yIutYJO8h0SsGNYJA5J706mFukml5W370iwBMioJqbzT6QhUeKHf1kTzMpbz2Mnux
         My6TbUuTd2MR78zGNyyx87mBsVuxOiRfmE07rJ52EvUCgr1vBZezMn9H/6PFhNBpGWSx
         QzWDnRiV221ipOz20W3ETrbI7FMtZmLM37Z4YYfGFhx3JuwZSxbOQ4qEcCI8NMK6vHUW
         J5N9d7jc+vdB+LLFpkixS2FUL4DBkuJd4kXSOGB2CXJ/tYRMw+dhMEkbbgwAhwFj+m2Y
         ER/a0RBCTgQZS6vieUBAKKbeqKezwFeZHezVEr2AnCfHMhkUcAADcNb7kgym1uKvva1S
         Ycew==
X-Gm-Message-State: ANoB5pkcBHjp+wBXirUGW7lpWxEi5QHuHHQEp9rO6A9E25Vq+UcMm99t
        86Ewj5wsjEGyAuqkGr+Hmkzn6+GApmoy3sfqFpV12qDoYVI=
X-Google-Smtp-Source: AA0mqf5T9Ra5V6yzXWV8vxb2tO65VZIyhze90LfjaKJK9kFL4fvKtrfCro9CM2DGiAIYQHU0Nn4aBh3Rm5cSdQPsKak=
X-Received: by 2002:a25:ef09:0:b0:6fc:63f6:eb89 with SMTP id
 g9-20020a25ef09000000b006fc63f6eb89mr3768398ybd.587.1669943984310; Thu, 01
 Dec 2022 17:19:44 -0800 (PST)
MIME-Version: 1.0
References: <20221125084306.1063074-1-davidgow@google.com> <202212011652.4E8CB40@keescook>
In-Reply-To: <202212011652.4E8CB40@keescook>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 1 Dec 2022 17:19:33 -0800
Message-ID: <CAGS_qxotC7jCXewCoa3CwP0pxs=FRqZPF0oY67La0dUN1ay7LQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] kunit: Provide a static key to check if KUnit is
 actively running tests
To:     Kees Cook <keescook@chromium.org>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 1, 2022 at 4:53 PM Kees Cook <keescook@chromium.org> wrote:
> > +     static_branch_inc(&kunit_running);
>
> Is it expected there will be multiple tests running? (I was expecting
> "static_branch_enable").

It shouldn't normally happen, no.

One possible use case:
KUnit's unit tests for itself create fake test objects and operate on them.
They don't currently exercise this particular code though, afaict
(maybe they should).

>
> > +
> >       for (i = 0; i < num_suites; i++) {
> >               kunit_init_suite(suites[i]);
> >               kunit_run_tests(suites[i]);
> >       }
> > +
> > +     static_branch_dec(&kunit_running);
> >       return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(__kunit_test_suites_init);
> > --
> > 2.38.1.584.g0f3c55d4c2-goog
> >
>
> Regardless:
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook

Daniel
