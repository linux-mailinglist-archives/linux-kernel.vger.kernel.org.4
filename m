Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDAE742E20
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 22:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjF2UCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 16:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbjF2UBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:01:00 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2AE3A9E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 13:00:55 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-992af8b3b1bso117236066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 13:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688068854; x=1690660854;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fECowZNpcpA0gZRwlMHH3UbCOy7cdW91Ppc09VLxieo=;
        b=APCoejVbi7NPMCZ2ZxiifT4LT8K/VyJGzCeCBDfFOHnI5/Jy6Xwp+h76TJGuOJ5aD6
         8RimehdJ3vIONWDNXYJeJ9wXiV9KmY+uzqNgh18Qvyl8N4fA2N674gN1VnosnhCOdDmK
         4Ewfg7R8FfHvizv0sza1ZAutc5FGL140rBvOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688068854; x=1690660854;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fECowZNpcpA0gZRwlMHH3UbCOy7cdW91Ppc09VLxieo=;
        b=G7W8DbwLZ2B5GGK2EksuCfBCWVpzD/hvMHZLzXZt9LEkyq+umdYPBAr2vO0kssPtQT
         Wo7vb2WZsz4nJ0a8IhZHMSA7EEHkNo2F2+p48dChyh8WvWLKYEiMPbC3pg41Lh46RQvD
         zp/MwAgaY3SBWs8jd6mEO1jHQ7VFK92fZTAb9fE4q0vBY1LGtwn4bqJ2f1O+aiWmlrYm
         RHqQAFvYeYgU4JzlSgQit6TQeFpYiaOgAW64IzvLZn/U7P1UjfyiNwKkIcywdPiRxlK+
         EEZwRLbR9NENGDGPF4r5USG5CDDB9L3GlmNbXuLk0D/tSbIp65Ey3ntYLQrq8zkcl2Ub
         gUqw==
X-Gm-Message-State: ABy/qLbHLMANpPZyj1njaVVyt8CPuCVk0NicbR9uFvUSp5x5urGRfp2g
        5Id5ZEq0yQyiINPTgpd2EUbz6BuBoY6Z1NP4EyQhwnNG
X-Google-Smtp-Source: ACHHUZ567mCMdWEdOPC7iAiWXwDcl0n3jKp6q8uB6vvmf439EBy6hSzPFQfdBhE4HejaHXyup0IDHw==
X-Received: by 2002:a17:906:b811:b0:992:ba2c:2e0f with SMTP id dv17-20020a170906b81100b00992ba2c2e0fmr387004ejb.30.1688068854306;
        Thu, 29 Jun 2023 13:00:54 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id dk18-20020a170906f0d200b00992b3ea1ee4sm927063ejb.149.2023.06.29.13.00.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 13:00:53 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-98e0c1d5289so128554566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 13:00:52 -0700 (PDT)
X-Received: by 2002:aa7:d7d8:0:b0:51a:5e8f:ac1 with SMTP id
 e24-20020aa7d7d8000000b0051a5e8f0ac1mr220186eds.23.1688068852598; Thu, 29 Jun
 2023 13:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230629191414.1215929-1-willy@infradead.org>
In-Reply-To: <20230629191414.1215929-1-willy@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Jun 2023 13:00:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiuXi4KmjgTocOZMpHTZuZP+y8r5wYynvvT_ZPXyG+TYA@mail.gmail.com>
Message-ID: <CAHk-=wiuXi4KmjgTocOZMpHTZuZP+y8r5wYynvvT_ZPXyG+TYA@mail.gmail.com>
Subject: Re: [PATCH] mm: Always downgrade mmap_lock if requested
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 at 12:14, Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> Now that stack growth must always hold the mmap_lock for write, we can
> always downgrade the mmap_lock to read and safely unmap pages from the
> page table, even if we're next to a stack.

Can we please also fix the really odd return value semantics?

Right now that function returns either an error - meaning that it
didn't downgrade, or it returns 0/1 as a success to show "did I
downgrade as you asked me to"?

That is *really* confusing, but it was needed in that bad old world order.

But now that the downgrade is not a "try to downgrade if you can", but
something reliable, can we please just make the success case be 0, and
make the callers all know that on success, it was downgraded?

And yes, I realize that that means do_vmi_munmap() also has to be
changed. The documentation for that function is horrid, btw, in that
it says

 * Returns: -EINVAL on failure, 1 on success and unlock, 0 otherwise.

which is just not true. It can return other errors than -EINVAL
(through exactly that do_vmi_align_munmap() function), and the "1 on
success and unlock" is not true, it's a "success and downgrade if you
asked me to".

So I think all of those callers should also be changed to "if you
asked for a downgrade, and do_vmi_munmap() returned success, then you
got a downgrade".

Then some of the callers of *that* can be simplified too.

Please?

                 Linus
