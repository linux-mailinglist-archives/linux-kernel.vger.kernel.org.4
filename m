Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F5F699CBF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 20:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjBPTAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 14:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjBPTAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 14:00:10 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9984C6FD
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:59:56 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id l2so2859204wry.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 10:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=16NwX6E/MJZLYXtvH88vb9mQe/rSJJo8cnIM1GgMvfg=;
        b=pAvCpLSIgO1x1G4Bn7wqyClAVkP3a/hIFiOwWBqd5mHzoyergvav7nACd8mIvPdtUa
         iUwgEhqm+7T/U2cj9qDu5MZ/36YK+zqpWhv9n7Psh7yPUUEHaVaGYYpYVEAI+eEIa/R2
         qTcLa1m51tD21o8nCEOBnlcP7mvNGkC33+oT2Vy1YGJVRoP9vGfvTli2/1VLtvhTYg5R
         U5Jnge0+9TNyKMBtiwn29bc/uhlck+sl0kfwFt9pZQhYFpPo5l1Bd9N1IikIoFzMPeps
         hNh3AeaHjEgHVIVoizu2yEhXDfnOm9OhElcgIJhT+P5UFW2H75nGW40HPPe54EFdGW1o
         mfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=16NwX6E/MJZLYXtvH88vb9mQe/rSJJo8cnIM1GgMvfg=;
        b=rxHaBSkFlPMzeGGn5nVebMY6vb0vOhgoA6gb1XeVFaLiuN78KBU2zshWW4Ld0DY/Qi
         AtU2sZxzi3FMtOkmgfhSDtFnRicWYOS1W3pMCFk7j0LauMU5cOYwcGTk93wR5TtNwi60
         8JMtr+lrbIAARZVUpi3ORYokYB90auDZlIdY2APCWRgHbp1tvSVC+iVq4D53kMHqzgJy
         x1SqCiibqezHdWvNs5yVDjgE3SM6hHXGJtv7y3x9prQ/QYlWUfc5sT9uXI9h4zOGSL8J
         /wRBLmAZ1gkBTeGT/WDkpZTtVB8QxX9A1HTq6W3NslYGKfHGnA+BpuyvWbhnGQyUU4No
         kmRA==
X-Gm-Message-State: AO0yUKUEwf3a88IAaHpFN7N55e7h3G+bdkbZHwOZ9dtJxwDyWg3h1xSG
        P7dA5ncjPdL3Y/0gU4l7BLRoNIIZ2ribGi9qmjvZyA==
X-Google-Smtp-Source: AK7set8Oneh95L7B1A7lxQ1bkQVa+zW1TlDHlb9LkoKPPo7JGd2outto4zwJErETE9iymz7a4hfE69hDXy9xCgyeaoI=
X-Received: by 2002:adf:f6c6:0:b0:2c3:ea81:64bb with SMTP id
 y6-20020adff6c6000000b002c3ea8164bbmr152263wrp.479.1676573994742; Thu, 16 Feb
 2023 10:59:54 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYvZqytp3gMnC4-no9EB=Jnzqmu44i8JQo6apiZat-xxPg@mail.gmail.com>
 <CAG_fn=V3a-kLkjE252V4ncHWDR0YhMby7nd1P6RNQA4aPf+fRw@mail.gmail.com>
In-Reply-To: <CAG_fn=V3a-kLkjE252V4ncHWDR0YhMby7nd1P6RNQA4aPf+fRw@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Feb 2023 19:58:55 +0100
Message-ID: <CAG_fn=VuD+8GL_3-aSa9Y=zLqmroK11bqk48GBuPgTCpZMe-jw@mail.gmail.com>
Subject: Re: next: x86_64: kunit test crashed and kernel panic
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Jakub Jelinek <jakub@redhat.com>,
        Peter Collingbourne <pcc@google.com>
Cc:     kasan-dev <kasan-dev@googlegroups.com>,
        open list <linux-kernel@vger.kernel.org>,
        kunit-dev@googlegroups.com, lkft-triage@lists.linaro.org,
        regressions@lists.linux.dev,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
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

>
> > <4>[   38.796558]  ? kmalloc_memmove_negative_size+0xeb/0x1f0
> > <4>[   38.797376]  ? __pfx_kmalloc_memmove_negative_size+0x10/0x10
>
> Most certainly kmalloc_memmove_negative_size() is related.
> Looks like we fail to intercept the call to memmove() in this test,
> passing -2 to the actual __memmove().

This was introduced by 69d4c0d321869 ("entry, kasan, x86: Disallow
overriding mem*() functions")

There's Marco's "kasan: Emit different calls for instrumentable
memintrinsics", but it doesn't fix the problem for me (looking
closer...), and GCC support is still not there, right?

Failing to intercept memcpy/memset/memmove should normally result in
false negatives, but kmalloc_memmove_negative_size() makes a strong
assumption that KASAN will catch and prevent memmove(dst, src, -2).
