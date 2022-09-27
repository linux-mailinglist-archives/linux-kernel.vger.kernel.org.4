Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4785ECA88
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 19:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbiI0RKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 13:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbiI0RJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 13:09:59 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CF43FA2A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:09:52 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id i3so6437868qkl.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 10:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=v8DRSrWjsVtOzpUcdyfjM/wUO+MHVSat9Cgl6y+qF6k=;
        b=dNquM4AtuPl7/Uu3LuNhxvUr5tLLsPm7z/b+Zbiyg23gPLNcoqdk5MA5HaRDpm7LFf
         PeQ9kX05+tjqnCXZSjP7eu5usjRdwN7sZh2EM9FWORXUlpyjtWE3JbS8JWN6S558jVmJ
         DLBpjmBLUY5AS4ucZAIOWr7sKtMIyKlnSsqP8ZzxoNmJHXORCD7nT51gqBXGA7ZjpgTz
         qcs+V4qjmK3pc/YPbKiftfuxxDDqVGIIybSkQwS4GWD+MiFvhMmCaLEDqCK+9cnKJFZB
         AEBx6c5hv0CqkDPIhXxcVabevLDgPORgxWXNOYtVm1iK/XCmKXd33j0gZ40lR241CXFw
         xm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=v8DRSrWjsVtOzpUcdyfjM/wUO+MHVSat9Cgl6y+qF6k=;
        b=pIKlO8d4tPSHTLfq22Se37nURYcGxGBGU7i2I53GUAD+aV721Zg/OCmyxlCj5bApuR
         0FchU25UtbSXMD7yKX5HMwd+vmH0VloWNX+yzuUWhRXpaHGHtampk8Rbr7wwr6WW6yBj
         aSqFllHjTj9Ld1sC7qOuJo/84jzm5aO+ZP2JU0XTq6XKVuORQCLfgEXTISfK+MSP1YLs
         bRQvoGqCrFSPRY5xthkD0LaBSkw4DBUUZ126LvLiuptm8Dp/EJbsUdyyBUhoNp4NcDIX
         SWKhcpVNL8KNJBMQCFpXLb4Ban3fgEgK7/YiAIRRW+y9cImt/7RIZsG5eflr5FFlOtSH
         T0ew==
X-Gm-Message-State: ACrzQf0JTy7jqnv1fbzDcBVcoZnpojCNXJZTiAAS+mByUBmCpHfbbjFX
        NZKYuDSuOpeFZaSG0TayQ3P5oYfYH8Oa8R/xN2Q=
X-Google-Smtp-Source: AMsMyM4PiPzezyIgX+qbqcaSBwDl9QF0Nvb/atfUs+eaajxoY1Og1PbL+Mib/oJ3+HWzIvHsZ8OX1cVfXgS3e+ZlCoI=
X-Received: by 2002:a37:aac4:0:b0:6cb:d070:7842 with SMTP id
 t187-20020a37aac4000000b006cbd0707842mr18700315qke.386.1664298591243; Tue, 27
 Sep 2022 10:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <653d43e9a6d9aad2ae148a941dab048cb8e765a8.1664044241.git.andreyknvl@google.com>
 <YzL29buAUPzOa9CG@elver.google.com>
In-Reply-To: <YzL29buAUPzOa9CG@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 27 Sep 2022 19:09:40 +0200
Message-ID: <CA+fCnZfus5WL9_-DQ8+jraQ79bE93VvGpd9iKRWcb6+rGv_mOQ@mail.gmail.com>
Subject: Re: [PATCH mm 1/3] kasan: switch kunit tests to console tracepoints
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
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

On Tue, Sep 27, 2022 at 3:13 PM Marco Elver <elver@google.com> wrote:
>
> > -static struct kunit_resource resource;
> > -static struct kunit_kasan_status test_status;
>
> Also remove this struct from kasan.h?

Done in v2. Thank you, Marco!
