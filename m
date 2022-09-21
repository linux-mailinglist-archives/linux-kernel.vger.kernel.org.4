Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12785BF76A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiIUHPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiIUHPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:15:30 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17830659CD;
        Wed, 21 Sep 2022 00:15:24 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x21so179274edd.11;
        Wed, 21 Sep 2022 00:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=z9jXMKTsbXt/GY48g/wdOYArfXNGBa3cbn0t4HSGf7c=;
        b=UiTMai2YO907oZTmL2uRRBUvQZje672mf6EbZ9LgXUMIQqDtJoEU89YEJ98C1iKFq6
         6aeo1LqTpUmEdFw2CaSaL28YZg63X9PaAExd1UpR0MksLPUasxQTMUS69mrLKvm0i5tk
         e+hFnF/9spxfT0XRQ4XHRAw+QOtJoML5Vz1O2F4ZVoDwC/N5QPHI623PCIhl5qf2Uzs6
         VtL7p6OurNamkmgIdL4rb5sRfKwpRieDiY2ZiC2WZG4mXXiBevFcf0mmEL8JqIYWdM6i
         PRQdgQ5j9YvBGXmjMfUP4G3iqVPZJBS27lF04is8Z5yupn+hVJQtVn2lVCtMTZdQPasZ
         8cvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=z9jXMKTsbXt/GY48g/wdOYArfXNGBa3cbn0t4HSGf7c=;
        b=LuhoLUp5nG85L8YpdWpkS67JDjLXoLUSnQfZKPnhGB/O3MuEdunX4EV1beBfDWhEvr
         53MIXmGS8FfmcJoN1nTDmrsaDrA2PyO3tvj0cYMcaAN42XbXMsSulanU3bsJVd+U7yz/
         v6pwqd0LgYscpHnCM5N4WheaGzhFLN3WlgwYykAj2sh3aIboimbepSCSgNLqXlgIL0+u
         IyH5AUXwWk1ys66vw9EFmERC7adpoV7hWB+NU9Q94okl71zDMjQFeuRIRsOOjIGNVYSA
         2+PhQYFl+dDD5QoWC5B47p/bD7YHJpbH6jznjhbtP0piOLk0G3x8U/j+Ms8j7yYJv8KS
         aQoA==
X-Gm-Message-State: ACrzQf2rCFRcZR5Gps6u3XleDf0ttCSrFJEDNHcTFlTcNDP05r2ek6Mz
        G89Xp0lPW0kY01zSjrcCB0w5vKQTMrrCDIrr+o8=
X-Google-Smtp-Source: AMsMyM55Ybm0ogt2YynX5Ic5pid72Oh9X7U20E3TfVabrhaJXkQZyVhJOQK1a/CYV33WISOGkFZPMdCY+LA22ybkLZI=
X-Received: by 2002:a05:6402:1e8d:b0:441:58db:b6a2 with SMTP id
 f13-20020a0564021e8d00b0044158dbb6a2mr22952604edf.277.1663744522301; Wed, 21
 Sep 2022 00:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220822082120.8347-1-yangyicong@huawei.com> <20220822082120.8347-5-yangyicong@huawei.com>
 <888da5f3-104c-3929-c21e-c710922d6f1e@arm.com>
In-Reply-To: <888da5f3-104c-3929-c21e-c710922d6f1e@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 21 Sep 2022 19:15:10 +1200
Message-ID: <CAGsJ_4wtkSfH2DTDg10qTbUkxD1QTNBD09nx_H+S6H_-tBPQBw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] arm64: support batched/deferred tlb shootdown
 during page reclamation
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Yicong Yang <yangyicong@huawei.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        linux-doc@vger.kernel.org, corbet@lwn.net, peterz@infradead.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        darren@os.amperecomputing.com, yangyicong@hisilicon.com,
        huzhanyuan@oppo.com, lipeifeng@oppo.com, zhangshiming@oppo.com,
        guojian@oppo.com, realmz6@gmail.com, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        wangkefeng.wang@huawei.com, xhao@linux.alibaba.com,
        prime.zeng@hisilicon.com, Barry Song <v-songbaohua@oppo.com>,
        Nadav Amit <namit@vmware.com>, Mel Gorman <mgorman@suse.de>
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

On Wed, Sep 21, 2022 at 6:53 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
> On 8/22/22 13:51, Yicong Yang wrote:
> > +static inline void arch_tlbbatch_add_mm(struct arch_tlbflush_unmap_batch *batch,
> > +                                     struct mm_struct *mm,
> > +                                     unsigned long uaddr)
> > +{
> > +     __flush_tlb_page_nosync(mm, uaddr);
> > +}
> > +
> > +static inline void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
> > +{
> > +     dsb(ish);
> > +}
>
> Just wondering if arch_tlbbatch_add_mm() could also detect continuous mapping
> TLB invalidation requests on a given mm and try to generate a range based TLB
> invalidation such as flush_tlb_range().
>
> struct arch_tlbflush_unmap_batch via task->tlb_ubc->arch can track continuous
> ranges while being queued up via arch_tlbbatch_add_mm(), any range formed can
> later be flushed in subsequent arch_tlbbatch_flush() ?
>
> OR
>
> It might not be worth the effort and complexity, in comparison to performance
> improvement, TLB range flush brings in ?

Probably it is not worth the complexity as perf annotate shows
"
Further perf annonate shows 95% cpu time of ptep_clear_flush
is actually used by the final dsb() to wait for the completion
of tlb flush."

so any further optimization before dsb(ish) might bring some improvement
but seems minor.

Thanks
Barry
