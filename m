Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2CB60671B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 19:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiJTRgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 13:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJTRf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 13:35:58 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6891FBCF9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 10:35:56 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id o2so370403qkk.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 10:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VWECp01B4Xx6nEq/eutNw6SLXu9E/6fw2YNROX2OzQ0=;
        b=P6c+wo34AHTMfodvTE1hZyTqBtPJJ77PhKMVQAaKwNRySnWfFI9yAQGjHMkEVJisdj
         9fZvZ6fEOePG9WvMJeKEpcZto4/3bQvN3pJJFTtHOOlxLef94+44CI9Iv65zXqL4gIi8
         UgfZkHMq6og8I2COhZV0d/QiI51DItYR6+vNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VWECp01B4Xx6nEq/eutNw6SLXu9E/6fw2YNROX2OzQ0=;
        b=uq1kSU8ops15ulToFcO9lU5V1QIthCc85J/1kU+y+cH1eyrTIgCMM1q5SdoMvEt7Qg
         CDd8eyDqLf2z8Jennmk8FlbshyZU2efAZaQUUxlPW+D4TOmIQnTYfQbIwpybKv4Z/QVo
         8TshFMthqxeA/7kYoqxttWtx49Axo4I+S/doYvhb/KRSY4x9qw3zpdzh1ePqx4KL39Nc
         fbWrzA9UplEQlTLSRZONJNT2ClcbC1f8VEyOMqGtPlGCLDGd0cw7wKVfvX2OpL8NC6wD
         V/MGMGFif4r3yE2y4g9oHGQ12VV9iqxe1ycyceRfJ4pYCSVbNFQ4AbczFvOAr9WFHify
         h+kA==
X-Gm-Message-State: ACrzQf3dF0nFNxh3Bj+g5vGoCRWqajwyQbv7bnhjpDRSDSf2s0TwFN7/
        MTceL98rVSJt1SWcWfbFmtX+kImN1xkalQ==
X-Google-Smtp-Source: AMsMyM5TZ2/jwzkFTGBNequCmS+4CMxDZFp8sSG/zbd4H/3VafbViFUloFSkNSjohh84+dU3EidVEA==
X-Received: by 2002:a05:620a:261c:b0:6ee:8dfc:3b6c with SMTP id z28-20020a05620a261c00b006ee8dfc3b6cmr10058928qko.246.1666287355775;
        Thu, 20 Oct 2022 10:35:55 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id u3-20020a05620a454300b006a6ebde4799sm7919359qkp.90.2022.10.20.10.35.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 10:35:55 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-36847dfc5ccso981337b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 10:35:55 -0700 (PDT)
X-Received: by 2002:a25:bb44:0:b0:6bb:a336:7762 with SMTP id
 b4-20020a25bb44000000b006bba3367762mr11999002ybk.501.1666287344812; Thu, 20
 Oct 2022 10:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220815071332.627393-1-yuzhao@google.com> <20220815071332.627393-9-yuzhao@google.com>
 <Y0go8wWtdcyH1+Ch@hirez.programming.kicks-ass.net> <CAOUHufa9+FTO3Pv-5jC-e3S5goPsUGu-5KcPVHa4bWb0X+d2ug@mail.gmail.com>
 <CAHk-=wj1rc2t5noMtVOgu8XXeTM4KiggEub9PdcexxeQrYPZvA@mail.gmail.com> <Y1FXpHdyvXjrjbLw@hirez.programming.kicks-ass.net>
In-Reply-To: <Y1FXpHdyvXjrjbLw@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Oct 2022 10:35:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=whQchubuDpRGFabhmcZuzdt13OOF8wznXb+Dbi3GzBQhQ@mail.gmail.com>
Message-ID: <CAHk-=whQchubuDpRGFabhmcZuzdt13OOF8wznXb+Dbi3GzBQhQ@mail.gmail.com>
Subject: Re: [PATCH v14 08/14] mm: multi-gen LRU: support page table walks
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        page-reclaim@google.com, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 7:14 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> So I've been sitting on these here patches (and never having time to
> repost them), which is how I noticed in the first place:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=x86/mm.pae

Well, that seems an improvement. I don't love how GUP_GET_PTE_LOW_HIGH
now affects the PMD too, but if it's ok for all the three users, I
guess it's ok. Maybe rename it now that it's not just the PTE?

That said, I reacted to that cmpxchg loop:

        } while (cmpxchg64(&pmdp->pmd, old.pmd, 0ULL) != old.pmd);

is this series just so old (but rebased) that it doesn't use "try_cmpxchg64()"?


               Linus
