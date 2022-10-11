Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059F85FB8FB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiJKRLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJKRLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:11:31 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51E55A88E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:11:30 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-134072c15c1so13429599fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BvBn0lntalCDidDjbA7w+SCkEO+LKl4O05VhkDUH/vU=;
        b=bSmudPi0IHNcb0hgJsa7o3HQK6sOc4zIc1Wi+JzL70zSd7KHq+fSMonbswMWenz8N+
         DsVjCGftVd99UWuC3joXnTdOtUDqKC3VemMBEqWpIXL0wgXZU4YFZ09mdJOMwW5A/UZC
         ee7ZWWmjM1hBBgyteKApw8WZ1kZsheIqG+sxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BvBn0lntalCDidDjbA7w+SCkEO+LKl4O05VhkDUH/vU=;
        b=8RuOVEQ6w0GDTt4mxuJLZe6QOKnrM4Qcz7zOU+0XDCN2hOaIZ4z3m1CgrCBadw+9Tg
         3zyij0X5GPn1Sr1RR1wWm5gOLXhA+6YHSgsJh82eU6A00abX3BeJA0Q8rK9ii1I+nxRP
         x2DsvDZzlg8qgYkik7hvsrkXyKUQtMUN2ba2QigVREVrcL6qo74Idsyko+NX/RmfDalq
         iN6CMSaYNC4RS9UU1Iy4ft9zx8tZmHu9I6Ey+ATDLvbeUuu1hKZlFvFIA6kfv4INrbZP
         r7KbRkJhY8l9ttToCu+1Nf9gidAoeGPGp9U6s23wgc4+pXdN6NYNf9G8JQ0wT1U49eC4
         +pXA==
X-Gm-Message-State: ACrzQf2u4kuevkLzf5Oq9CdQyxsHnY3cgSwMWJSclX5geDWaNd4UBsta
        x5T6OE32hUPlhM5S6wgKmtgSyCJSEa8p/Q==
X-Google-Smtp-Source: AMsMyM6z6WIGqM0F9tPEhfTV8a/+FjzdNI6P2iMMkWq5yfbqq8FE9tR1YmIRItCqz1LVqnlTJbdSjg==
X-Received: by 2002:a05:6870:f2a6:b0:136:6442:4b52 with SMTP id u38-20020a056870f2a600b0013664424b52mr86398oap.282.1665508288993;
        Tue, 11 Oct 2022 10:11:28 -0700 (PDT)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com. [209.85.167.169])
        by smtp.gmail.com with ESMTPSA id g25-20020a9d6499000000b00661a30ea0d4sm2003066otl.2.2022.10.11.10.11.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 10:11:28 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id y72so9837175oia.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:11:27 -0700 (PDT)
X-Received: by 2002:aca:b957:0:b0:351:4ecf:477d with SMTP id
 j84-20020acab957000000b003514ecf477dmr73295oif.126.1665508287655; Tue, 11 Oct
 2022 10:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221008132113.919b9b894426297de78ac00f@linux-foundation.org>
 <CAHk-=wigZoriP8ZB+V87Jf+EQV=ka6DQe_HCAQmh3Dmus2FFhw@mail.gmail.com> <CAG_fn=WuMUKjdNwpcc7Msh6wrXFEkigYJJv9rS9+iMJO2d5Y-w@mail.gmail.com>
In-Reply-To: <CAG_fn=WuMUKjdNwpcc7Msh6wrXFEkigYJJv9rS9+iMJO2d5Y-w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Oct 2022 10:11:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-_peVY71FK7nX7p36VYacf2mFD5i4fKQpqk77J8K9Aw@mail.gmail.com>
Message-ID: <CAHk-=wj-_peVY71FK7nX7p36VYacf2mFD5i4fKQpqk77J8K9Aw@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.1-rc1
To:     Alexander Potapenko <glider@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 2:03 AM Alexander Potapenko <glider@google.com> wrote:
>
> Small nit:
>
>      - Dmitry Vyukov introduces KMSAN: the Kernel Memory Sanitizer. It uses
>        clang-generated instrumentation to detect used-unintialized bugs down
>        to the single bit level.
>
> s/Dmitry Vyukov/Alexander Potapenko/ ;)

Uhhuh. I just took what Andrew told me for the commit message, so we
have that error in the history now.

Then when I reported my conflict resolution, at that point I actually
looked at the commit that introduced it, which is why I cc'd you.

So you got all the blame, and none of the glory. Sorry about that,

                   Linus
