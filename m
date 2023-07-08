Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE0574BF40
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 23:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjGHVS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 17:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGHVSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 17:18:54 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488701BC
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 14:18:50 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fb73ba3b5dso5026287e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 14:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688851128; x=1691443128;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NYkpMcCqLkVQ1Acc1vLb6z5Gk8ZLjHpR5RYSSOrvZGs=;
        b=Nb3QCbvkIpeTDcpUQ65nqxbIAfPmInaCnV0Kn+S1p+cWlTmFngKhFoWR/L/+W5m6f1
         AyBgaXE9ZNr/xXLKhklSQHcGCB0KoKMN5zQd8RVI6cKw9IyADeXsgg7JxiRDExhiBOiL
         X/3IXLdza+9v4CmV3u+di3BhkYQFm7NBZzYrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688851128; x=1691443128;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYkpMcCqLkVQ1Acc1vLb6z5Gk8ZLjHpR5RYSSOrvZGs=;
        b=FglmtHsBt8pXjwgplJHS5EOgDgIPxeCqfQuUtoQ/h+NiOatlFQMdYLD0Fh7ZBDF5Wt
         s2wXubRddkv2Es6a4nSfn1zE7/7NNlC9RWKE3SkMMJZYUqsmaJ2c+pDljIdQzOc1HcQT
         7uU9iWk3m6QLS+nktBcsxq59bJHbGN6pT6ZU1Wdm/1H5f3s70DhgnydU0coMDhT1fH2F
         KQ8N4+2JfVvkvj4pc+UoTirmJ1JsKctRdz4/EyS7EaSwVdiB2gY5MPiwIQTVg3EfjTCE
         kCqKosGde1QT1Y95NIRIFlpo6wCRvXYRmtMJPV0iMNlJbPh57mp4oeBSonF/AGCxMl5r
         YkyA==
X-Gm-Message-State: ABy/qLZ1OLOHhyhW67rA0wp/aKxy2N12VyuHUCXVvn40rzS8ryRnZYGv
        1JSU9RCDVruJ9vBXr6IMEJ/3jKbkzxxwzu9ZdhDb9qUm
X-Google-Smtp-Source: APBJJlEfVL2tMwqqryHZZ8Xk5yFxKcoYeROsyXjzlnX51TKyUt9kx7NLlujksmQ07AQAa7s7YoUpHg==
X-Received: by 2002:ac2:58ef:0:b0:4f9:72a5:2b76 with SMTP id v15-20020ac258ef000000b004f972a52b76mr5550955lfo.65.1688851128389;
        Sat, 08 Jul 2023 14:18:48 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id x11-20020ac259cb000000b004fb745fd21esm1126347lfn.122.2023.07.08.14.18.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jul 2023 14:18:47 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so5041864e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 14:18:46 -0700 (PDT)
X-Received: by 2002:a19:670b:0:b0:4f8:742f:3bed with SMTP id
 b11-20020a19670b000000b004f8742f3bedmr6097080lfc.37.1688851126226; Sat, 08
 Jul 2023 14:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230708191212.4147700-1-surenb@google.com> <20230708191212.4147700-3-surenb@google.com>
In-Reply-To: <20230708191212.4147700-3-surenb@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 8 Jul 2023 14:18:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=whhXFQj0Vwzh7bnjnLs=SSTsxyiY6jeb7ovOGnCes4aWg@mail.gmail.com>
Message-ID: <CAHk-=whhXFQj0Vwzh7bnjnLs=SSTsxyiY6jeb7ovOGnCes4aWg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fork: lock VMAs of the parent process when forking
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, regressions@leemhuis.info,
        bagasdotme@gmail.com, jacobly.alt@gmail.com, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        regressions@lists.linux.dev, Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2023 at 12:12, Suren Baghdasaryan <surenb@google.com> wrote:
>
>  kernel/fork.c | 1 +
>  1 file changed, 1 insertion(+)

I ended up editing your explanation a lot.

I'm not convinced that the bug has much to do with the delayed tlb flushing.

I think it's more fundamental than some tlb coherence issue: our VM
copying simply expects to not have any unrelated concurrent page fault
activity, and various random internal data structures simply rely on
that.

I made up an example that I'm not sure is relevant to any of the
particular failures, but that I think is a non-TLB case: the parent
'vma->anon_vma' chain is copied by dup_mmap() in anon_vma_fork(), and
it's possible that the parent vma didn't have any anon_vma associated
with it at that point.

But a concurrent page fault to the same vma - even *before* the page
tables have been copied, and when the TLB is still entirely coherent -
could then cause a anon_vma_prepare() on that parent vma, and
associate one of the pages with that anon-vma.

Then the page table copy happens, and that page gets marked read-only
again, and is added to both the parent and the child vma's, but the
child vma never got associated with the parents new anon_vma, because
it didn't exist when anon_vma_fork() happened.

Does this ever happen? I have no idea. But it would seem to be an
example that really has nothing to do with any TLB state, and is just
simply "we cannot handle concurrent page faults while we're busy
copying the mm".

Again - maybe I messed up, but it really feels like the missing
vma_start_write() was more fundamental, and not some "TLB coherency"
issue.

            Linus
