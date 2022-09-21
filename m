Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DE75BF31C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 03:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiIUBur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 21:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbiIUBui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 21:50:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CBE7C1D4;
        Tue, 20 Sep 2022 18:50:37 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id 13so10387013ejn.3;
        Tue, 20 Sep 2022 18:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=6BQ+n+4VW6hHwhXqAlkDoSlNz/771IN91baTY6cW3mc=;
        b=Hsxb1h+EMvvkdsefMmznixkb9yPc3ROIaG+LUt0+8GdgrzGiBW3AgAI0RjPjnW1a93
         DY3sKYF7CvzXAe00TGJRDY77eMBmAM0480SdlHfjxG4lyc5EbwrTXa15468ciTechEYT
         WGETfvgoH53XN8KYelN7OAjCyWHBudaSxMJ2L8rTgdvY1WUYvP7Q8KL14RK4KdBht206
         uGl//hA7A5//q7f7eaYrI0DnwnygQF2ZaOGzjx7l19o32olfp0XYIWQPV7GeFwqwofTY
         VpclnNyeiusjibhMe9Hq1ilMiZtIFMoCJZSuw0/xwB2H0iVevrwbGzuhW+Knat88VluT
         5vvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6BQ+n+4VW6hHwhXqAlkDoSlNz/771IN91baTY6cW3mc=;
        b=TJHGcfyBKSk6vYGyfMLVd3+0GT2a7G0au4ZTOC/RJK3s7s9vyCpcuCFu02Bb59xJon
         CWJj8e6OaKmWftZhezdYl30z3zmGWTgfQfn9okORzCbF1FdQUQhI9H9smJTKutg/FTu2
         qUPB9+PxVi9mVzwIuFg2DljcaiOPdx4oNLS8Z3kQXcNHoxfloqnSwsQoM6Ucy9p57uXl
         sg6AGZL7JLcYvOUm4TjTtEd+5XcNR+wOOgwIaEPRcpVl8tZpQFC5mRFC+rS6Ub1ypTG8
         Vd4vn0sNDFV0xK4aQtfO/fGvf3CeFYYXfCOlpY45sJIQBaVmWRYcyRHkoxjW53P8dbZ1
         IQbA==
X-Gm-Message-State: ACrzQf27pmRdv/YozkakJIZYrQJg5OSybYcpsSdCl0itoBFoMyh1q9NN
        TvxrV3+FQ0XJIyhEuqnhSuFrqUjyOT3QUlvc3zo=
X-Google-Smtp-Source: AMsMyM4BpJG31Gs91JHdJmZGt8F5S3yEOSSf/UDOFiYo+s9qWWQwy3OlMqr27Xca6ZiQ4/GcrUZCaWrZRKbnRXNpOoI=
X-Received: by 2002:a17:907:3e89:b0:779:4869:b799 with SMTP id
 hs9-20020a1709073e8900b007794869b799mr17924838ejc.91.1663725035280; Tue, 20
 Sep 2022 18:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220822082120.8347-1-yangyicong@huawei.com> <20220822082120.8347-5-yangyicong@huawei.com>
 <302febae-508c-d73e-8676-d51752946645@arm.com> <CAGsJ_4ywwFJFi+q3Ra5UE3twzS9eExtvuXgoGK-8u4c1ZdXCBw@mail.gmail.com>
 <8c4f103b-8f04-d0ad-b30a-2db7e52b36a3@arm.com>
In-Reply-To: <8c4f103b-8f04-d0ad-b30a-2db7e52b36a3@arm.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 21 Sep 2022 13:50:24 +1200
Message-ID: <CAGsJ_4xCpSFneh7dPriGeM2_z5njB71cXKGfrarc8Kq0CA37CQ@mail.gmail.com>
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

On Tue, Sep 20, 2022 at 8:45 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 9/20/22 09:09, Barry Song wrote:
> > On Tue, Sep 20, 2022 at 3:00 PM Anshuman Khandual
> > <anshuman.khandual@arm.com> wrote:
> >>
> >>
> >> On 8/22/22 13:51, Yicong Yang wrote:
> >>> +static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
> >>> +{
> >>> +     return true;
> >>> +}
> >>
> >> This needs to be conditional on systems, where there will be performance
> >> improvements, and should not just be enabled all the time on all systems.
> >> num_online_cpus() > X, which does not hold any cpu hotplug lock would be
> >> a good metric ?
> >
> > for a small system, i don't see how this patch will help, e.g. cpus <= 4;
> > so we can actually disable tlb-batch on small systems.
>
> Do not subscribe ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH based on NR_CPUS ?
> That might not help much as the default value is 256 for NR_CPUS.
>
> OR
>
> arch_tlbbatch_should_defer() checks on
>
> 1. online cpus                  (dont enable batched TLB if <= X)
> 2. ARM64_WORKAROUND_REPEAT_TLBI (dont enable batched TLB)
>
> > just need to check if we will have any race condition since hotplug will
> > make the condition true and false dynamically.
>
> If should_defer_flush() evaluate to be false, then ptep_clear_flush()
> clears and flushes the entry right away. This should not race with other
> queued up TLBI requests, which will be flushed separately. Wondering how
> there can be a race here !

Right. How about we make something as below?

static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
{
    /* for a small system very small number of CPUs, TLB shootdown is cheap */
    if (num_online_cpus() <= 4 ||
unlikely(this_cpu_has_cap(ARM64_WORKAROUND_REPEAT_TLBI)))
          return false;

#ifdef CONFIG_ARM64_WORKAROUND_REPEAT_TLBI
    if (unlikely(this_cpu_has_cap(ARM64_WORKAROUND_REPEAT_TLBI)))
         return false;
#endif

    return true;
}

Thanks
Barry
