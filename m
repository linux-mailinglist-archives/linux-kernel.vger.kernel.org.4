Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6FA690D5C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjBIPnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjBIPnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:43:25 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5410765697
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 07:42:45 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id r18so1713122wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 07:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mzvCaAOpYzaP487+BqgN7Jr/isnyXVDVjSzZh2DR0yM=;
        b=dfs88JgsLidyay+sxi+vKR7hgo3w7zTuP7BefDgQ6Dm3cdKzcaDVcpSIdDcIK53vWW
         zf+H59Ez5k9pXcfdW4yKKtpZBQMANdUXfZ5JXDXsads+GWrv2tvcFASjcLTZzmx3smlq
         Y+tBHxnIhSrJ7OHgEkRY7By9FXa73eowBufZjpAtRkAxKM3NEJCWDr4FLfSQYlpw8Wd8
         XJDLJSsVZpXUeLWk6ExPuBThKf1cBX8hCNefkSyFynrTLU7wq47HZGtOCijM6HbzZzY5
         Rz3KfSKpWuMW0rdVuurNr6xl3tDJIE/nku4SVf+22nQic4R8AGA6HyQ8totwTAxy6HbL
         ghZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mzvCaAOpYzaP487+BqgN7Jr/isnyXVDVjSzZh2DR0yM=;
        b=gNltIXHmGJvSODVq7KsMA2KpzNF5XRmnn2nydshEYWl6hstNdaG8zvu1Abgsao8QDP
         71dzspeE7tZ+kBvG8joRSKFRjfz/xsr8hoTRG5IMsfAw8cbeO4O9mGriQqu7WfD/bopc
         yFQSvS2a4rAl+vLBxUKM7kHc5VdQ/2wwPAxMf2Yjv4rxAJTt7rxSYE5u6OEJjaV/qDbj
         ZzjwT6ChDrmAfL+HvlL/nHhbYHx9UygpzRnvg6KFPQOF1nhaM+o3eBnAQigAUiiyyDUU
         tWadmKbdB3m2irE/Tw07AsFTrm+av7PS9Pqf0HUkUC8zFf/X+xs3BYjenbGhwygk6ggu
         zICA==
X-Gm-Message-State: AO0yUKUqYy58L6f3wpqgrgTQWBxWP3+FAtGl5HT6D+uRwk5f7wMqVFum
        DinSt5zCBVY4fUctZRX1K/QGFtDB3wMA0elygnMeMA==
X-Google-Smtp-Source: AK7set8W0PWVGUPhjBZ2DYlfA+2RGsoCXqAPdWpK2WKjVHGh1hIwTceUzAAPDsn2K01NuAuKA910e2dsSWb7dGR+mEI=
X-Received: by 2002:a05:600c:29ca:b0:3dd:67c6:8c58 with SMTP id
 s10-20020a05600c29ca00b003dd67c68c58mr732120wmd.51.1675957362869; Thu, 09 Feb
 2023 07:42:42 -0800 (PST)
MIME-Version: 1.0
References: <20230208164011.2287122-1-arnd@kernel.org> <20230208164011.2287122-2-arnd@kernel.org>
 <CANpmjNNYcVJxeuJPFknf=wCaapgYSn0+as4+iseJGpeBZdi4tw@mail.gmail.com> <7a62bc92-e062-4d33-9c3f-894b49452f1c@app.fastmail.com>
In-Reply-To: <7a62bc92-e062-4d33-9c3f-894b49452f1c@app.fastmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 9 Feb 2023 16:42:03 +0100
Message-ID: <CAG_fn=VCTvUF39ORV4FnuhzD0tgRq3mGurTQrwD-_cCwEgXazw@mail.gmail.com>
Subject: Re: [PATCH 2/4] kmsan: disable ftrace in kmsan core code
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Marco Elver <elver@google.com>, Arnd Bergmann <arnd@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Wed, Feb 8, 2023 at 8:32 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Feb 8, 2023, at 18:00, Marco Elver wrote:
>
> >>  CFLAGS_REMOVE.o = $(CC_FLAGS_FTRACE)
> >
> > That means this CFLAGS_REMOVE.o didn't work, right? Can it be removed?
> >
>
> Ah, I missed this. Adjusted the patch and description accordingly.
>
>     Arnd

Acked-by: Alexander Potapenko <glider@google.com>

(assuming you did, b/c I couldn't find the new version)
