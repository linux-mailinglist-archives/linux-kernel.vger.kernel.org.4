Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB12E604F10
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiJSRlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiJSRlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:41:11 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97861B94CB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:41:10 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-132fb4fd495so21503308fac.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o7oESz5tomQbWcoWEgo0/iqd576fd8JG2PTmQCWKHUY=;
        b=LhnaCxQkYe9bL+uXUquBP284q0FFjCfp0v3tEE3Ew7ycTxf8ce+iI79qb3MGCCRuuU
         zjTJ8I9g99kNf5YqHMJEIgBBUDmx8TSibPKQcCCydysOcjqO4Oy0SigG4t1dTfmwSk9p
         Q8Xw+hnWgAzZpeoedADsV2vwGfcmjwBSuWbS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7oESz5tomQbWcoWEgo0/iqd576fd8JG2PTmQCWKHUY=;
        b=4WACj2NMiFklvx5MQ2/mT6K0eFxOh3QQeas3GOetKJ/BAsY+7BkwpEnnYRgWDw/CU+
         YwfIBKKAUz+g910afD1CNCoGjDoAxhrM/9blj6oQkI3XzORP3kIpieti9uO36zqDebsM
         DXT8cN8r7HCee7twBkP/pYJ9H4+gbiMqPGMGFZ1hP5zXl3j3mEkyIFig8Z9IWAkLXPrW
         Xh5oFp/QSkvepjSH84C5ZbgaSRgcEf5kiYA5afgjhner44efC+c9NS4MAkczBajHjGse
         FDJI2Dqi/lcdWY6ha7jk9qoI3qiVtMy5KHgsWiOWqk0diT4zq+OLwDITUXCHT9uq2WQX
         K9cQ==
X-Gm-Message-State: ACrzQf3tXoS96i3GhQGyj7kbybaYXCgPJcVxmHzYNG5VqohZpkfWxyGk
        Of37vOPPKThAIaYaPLw9ohRHTmGmm5TBHg==
X-Google-Smtp-Source: AMsMyM5T7cDGSIo0V+9GPVoGjJiStdmYSZc+dsYVTwNG2H99512/hegyxrZZ+PSHdbRnYQzvHya7mg==
X-Received: by 2002:a05:6870:e30e:b0:132:e934:5c0a with SMTP id z14-20020a056870e30e00b00132e9345c0amr5872143oad.202.1666201269297;
        Wed, 19 Oct 2022 10:41:09 -0700 (PDT)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com. [209.85.160.45])
        by smtp.gmail.com with ESMTPSA id a130-20020acab188000000b00354978180d8sm6926715oif.22.2022.10.19.10.41.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 10:41:08 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1364357a691so21524275fac.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:41:07 -0700 (PDT)
X-Received: by 2002:a05:6870:c0c9:b0:127:c4df:5b50 with SMTP id
 e9-20020a056870c0c900b00127c4df5b50mr6076270oad.126.1666201256175; Wed, 19
 Oct 2022 10:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220815071332.627393-1-yuzhao@google.com> <20220815071332.627393-9-yuzhao@google.com>
 <Y0go8wWtdcyH1+Ch@hirez.programming.kicks-ass.net> <CAOUHufa9+FTO3Pv-5jC-e3S5goPsUGu-5KcPVHa4bWb0X+d2ug@mail.gmail.com>
In-Reply-To: <CAOUHufa9+FTO3Pv-5jC-e3S5goPsUGu-5KcPVHa4bWb0X+d2ug@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Oct 2022 10:40:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1rc2t5noMtVOgu8XXeTM4KiggEub9PdcexxeQrYPZvA@mail.gmail.com>
Message-ID: <CAHk-=wj1rc2t5noMtVOgu8XXeTM4KiggEub9PdcexxeQrYPZvA@mail.gmail.com>
Subject: Re: [PATCH v14 08/14] mm: multi-gen LRU: support page table walks
To:     Yu Zhao <yuzhao@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 10:51 PM Yu Zhao <yuzhao@google.com> wrote:
>
> pmd_read_atomic() should have a built-in READ_ONCE() in the first
> place.

I really think that is the right thing to do. Let's just move the
barrier in *there* instead.

It really should use 'READ_ONCE()', but it sadly cannot do that
portably, because 'pmd_t' may be a multi-word structure.

Of course, the x86-32 code does this all *almost* right, and
implements its own version of pmd_read_atomic(), but then sadly does
it _without_ actually using READ_ONCE() there.

So even when we could do it right, we don't.

But the x86-32 implementation of pmd_read_atomic() would be trivial to
fix to just use READ_ATOMIC, and the generic implementation should
just have a "barrier()" in it so that we wouldn't need crazy barriers
in the users.

Because as you say, the function is already called "read_atomic", and
it should damn well *act* that way then.

Hmm?

                 Linus
