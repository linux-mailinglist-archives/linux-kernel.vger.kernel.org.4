Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B987C743546
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 08:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjF3Gr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 02:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjF3GrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 02:47:25 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6D03595
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 23:47:23 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51d9123a8abso1625899a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 23:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688107642; x=1690699642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zlchbRYXZ2GmgikakdfRkYq9RUe43aExK7E5sqwL0Bw=;
        b=A4gTuuMIMizRixVdblSqw5SYKt+QwmRPLuUK4f4z0K2+yGZIDExa8f4XopC4/kPs9+
         YzKW+teF6Fq1kkS60487u5rbCRcCXk4xGumtHwFgLTCGDMvPXB2M0Q7nYK2m8trH5hCD
         kzCPDL3NWtWTtGWdXIfTVqxyXjmpZ+rgAJiSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688107642; x=1690699642;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zlchbRYXZ2GmgikakdfRkYq9RUe43aExK7E5sqwL0Bw=;
        b=dxUowiiJ4eqT6yNtK51H8oAWO0vGjPSRiKS6nPsT/UcuvV5c/FWbmhFZb3ZyGbum8I
         DeijpUdr3AbYNoBWOr1bF/9P/yPWoBa+NZbRslyBRvrIKzEhwCXniDUrNOOS1xBEgnr+
         O8t+1tjMnQ7JEKMIob08U77B19o7f/AQH0m5eHoBykklA6jiZYYeNiWgzibtuqhAoPnP
         9YyftqM+dH0Kt7JbALA+qjI40TDXa0Rd/GnS69OrlfI2Afk5/fwZ11YQLg3cb/IaJZv+
         IYBVlfGuHaXU4O+74qk9wAPq9Tv4hN/0Ae+iTNzT+V5SS7JDxJL43dR9nh/DwBT1UvKx
         /M4Q==
X-Gm-Message-State: ABy/qLZ6s0NBkNlMqO+QwJmhwJN6qJ3KaTk7YXoudZoGTLggKjxhbphq
        tecP5nGkYtougXqKyUjRsb7dGy/4BusnFoA/RWekobf4
X-Google-Smtp-Source: APBJJlHz1FHRaG77KC33KjXsRM+RJRQewLhV+2wCnj+GAj+UfGUGbp4rYFEtwTDGnbUcZJB0bRcXRA==
X-Received: by 2002:aa7:c489:0:b0:51d:eb90:4928 with SMTP id m9-20020aa7c489000000b0051deb904928mr974766edq.30.1688107642160;
        Thu, 29 Jun 2023 23:47:22 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id c20-20020aa7df14000000b0051d984e610esm4934785edy.66.2023.06.29.23.47.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 23:47:22 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-51d9850ef09so1639918a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 23:47:21 -0700 (PDT)
X-Received: by 2002:a05:6402:217:b0:51d:7ed9:c65 with SMTP id
 t23-20020a056402021700b0051d7ed90c65mr915784edv.21.1688107641560; Thu, 29 Jun
 2023 23:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230629184151.888604958@linuxfoundation.org> <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
 <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
 <fbe57907-b03f-ac8c-f3f4-4d6959bbc59c@roeck-us.net> <CAHk-=wgE9iTd_g20RU+FYa0NPhGSdiUDPW+moEqdHR4du1jmVA@mail.gmail.com>
In-Reply-To: <CAHk-=wgE9iTd_g20RU+FYa0NPhGSdiUDPW+moEqdHR4du1jmVA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Jun 2023 23:47:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiN5H-2dh2zCo_jXE7_ekrxSHvQcMw4xfUKjuQs2=BN4w@mail.gmail.com>
Message-ID: <CAHk-=wiN5H-2dh2zCo_jXE7_ekrxSHvQcMw4xfUKjuQs2=BN4w@mail.gmail.com>
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        linux-parisc <linux-parisc@vger.kernel.org>,
        sparclinux@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Helge Deller <deller@gmx.de>,
        Jason Wang <wangborong@cdjrlc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 at 23:33, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Oh well.  We'll get them all. Eventually. Let me go fix up that csky case.

It's commit e55e5df193d2 ("csky: fix up lock_mm_and_find_vma() conversion").

Let's hope all the problems are these kinds of silly - but obvious -
naming differences between different architectures.

Because as long as they cause build errors, they may be embarrassing,
but easy to find and notice.

I may not have cared enough about some of these architectures, and it
shows. sparc32. parisc. csky...

             Linus
