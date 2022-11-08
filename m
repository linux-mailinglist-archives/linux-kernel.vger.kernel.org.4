Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA3C621E33
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 22:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiKHVFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 16:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKHVFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 16:05:44 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1402961B82
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 13:05:43 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so18977840pjc.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 13:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKI87OExUpz/SA+Wz6oxCLS24A1uuiiZj1NsUHkplvE=;
        b=mcJaYuu25CE1SjcCXkIg35/3w9UmXjO0hm9kX7JtHp9uK0ODioTlnLz5qx3SF4Aks8
         PeYrdYzOGuyw3rI8utzb0QaEGGj8ffbYlUzbtS9fS/CrQUcKIM8zSu2eP1+dpokUybUI
         wed1AqUv+QZwR2dvwwlUTGsjRwulDa6nE8VekduI1Oz23cnIOdG+t2DkQN2WFUQ/Y6VE
         /e2Qt1fbazYqtfZCjFaSBApqHKrDU6wheQwHaoCMZ8h6jy9ISVj5MZzbG364+wFtLN+K
         3uC1vbN/OO5LluYgA8x5SFbaMaoKXO5iVc+ePXSNCPRphK1N9/2dsY7QEmFl8cJQHPUD
         QFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKI87OExUpz/SA+Wz6oxCLS24A1uuiiZj1NsUHkplvE=;
        b=loEmgEQpSzjlY6XrtmoHm4Qg7xMNDyRbCZ9Ac/pw3YlaOUSR+d2K31XQjhcjlbodki
         YTtxNEsoism/TVGCq363JiLUkDG+/e0a4Bf6yhKwju+KkH++i6keyjwWCri8hzONBLvH
         DHfVtdEQL7ZFqKGxwQIQIYVCATSmeLlkePwRkkOSaJzgFqRVeHOEsgDEF6T/QwSdUq4Q
         bLKTFopS4EIHBrtfwy/xLpWwU1mQ6zFvFcW2LN8HdOZHGI/EOKJjJ6BT8OdhZLa0Jh5h
         QAe6V18ccPHbcn4sTF6hpY9xIRhmSO+u98CTzPpTdAv+6lS811FuaUDyMRfaDznxKZvw
         77qg==
X-Gm-Message-State: ACrzQf0ES1L4dSAfWBxWhnDdcBCjlNFOb0/E/2ZSfc7YEpXSC94vbEsv
        4JlQq78DRPk/Gw/7B2mkzoU=
X-Google-Smtp-Source: AMsMyM7jZVkfz1Tj3OC34o3Rx8LB+9qVSkpR8rngeFKy85GRtXtb1/9g2VOTioYNnJhhtv4T3uKdkg==
X-Received: by 2002:a17:902:b602:b0:188:620d:351c with SMTP id b2-20020a170902b60200b00188620d351cmr27459552pls.111.1667941542355;
        Tue, 08 Nov 2022 13:05:42 -0800 (PST)
Received: from smtpclient.apple ([66.170.99.95])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902e5ce00b00186c5e8a8d7sm7402730plf.171.2022.11.08.13.05.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Nov 2022 13:05:41 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 4/4] mm: delay page_remove_rmap() until after the TLB has
 been flushed
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20221108194139.57604-4-torvalds@linux-foundation.org>
Date:   Tue, 8 Nov 2022 13:05:39 -0800
Cc:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Will Deacon <will@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <519E803D-4D58-4252-B596-A40D7C156BC1@gmail.com>
References: <CAHk-=wh6MxaCA4pXpt1F5Bn2__6MxCq0Dr-rES4i=MOL9ibjpg@mail.gmail.com>
 <20221108194139.57604-4-torvalds@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 8, 2022, at 11:41 AM, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:

> When we remove a page table entry, we are very careful to only free =
the
> page after we have flushed the TLB, because other CPUs could still be
> using the page through stale TLB entries until after the flush.

The patches (all 4) look fine to me.

I mean there are minor issues here and there, like s390=E2=80=99s =
tlb_flush_rmaps()
that can have VM_WARN_ON(1);the generic tlb_flush_rmaps() that is =
missing an
empty line after the =E2=80=98page' variable definition; or perhaps =
using __bitwise
for sparse (as David pointed) =E2=80=94 but it can all be addressed =
later.

