Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1A86BB954
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjCOQP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbjCOQPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:15:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C101113D8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:14:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7327961DBF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 16:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCC9C433D2;
        Wed, 15 Mar 2023 16:14:11 +0000 (UTC)
Date:   Wed, 15 Mar 2023 16:14:08 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        =?utf-8?B?6KKB5biFKFNodWFpIFl1YW4p?= <yuanshuai@zeku.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        =?utf-8?B?5qyn6Ziz54Kc6ZKKKFdlaXpoYW8gT3V5YW5nKQ==?= 
        <ouyangweizhao@zeku.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Weizhao Ouyang <o451686892@gmail.com>,
        =?utf-8?B?5Lu756uL6bmPKFBlbmcgUmVuKQ==?= <renlipeng@zeku.com>
Subject: Re: [PATCH v2] kasan: fix deadlock in start_report()
Message-ID: <ZBHu0Jk/erSOhD7e@arm.com>
References: <93b94f59016145adbb1e01311a1103f8@zeku.com>
 <CACT4Y+a=BaMNUf=_suQ5or9=ZksX2ht9gX8=XBSDEgHogyy3mg@mail.gmail.com>
 <CA+fCnZf3k-rsaOeti0Q7rqkmvsqDb2XxgxOq6V5Gqp6FGLH7Yg@mail.gmail.com>
 <b058a424e46d4f94a1f2fdc61292606b@zeku.com>
 <2b57491a9fab4ce9a643bd0922e03e73@zeku.com>
 <CA+fCnZcirNwdA=oaLLiDN+NxBPNcA75agPV1sRsKuZ0Wz6w_hQ@mail.gmail.com>
 <Y/4nJEHeUAEBsj6y@arm.com>
 <CA+fCnZcFaOAGYic-x7848TMom2Rt5-Bm5SpYd-uxdT3im8PHvg@mail.gmail.com>
 <Y/+Ei5boQh+TFj7Q@arm.com>
 <CA+fCnZdFZ0w33GcUWRfWhNmYkhszQ0gwVKGeY0uSOzBEJJe27A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZdFZ0w33GcUWRfWhNmYkhszQ0gwVKGeY0uSOzBEJJe27A@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 12:42:20AM +0100, Andrey Konovalov wrote:
> On Wed, Mar 1, 2023 at 6:00 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > Yes. I'm including Vincenzo's patch below (part of fixing some potential
> > strscpy() faults with its unaligned accesses eager reading; we'll get to
> > posting that eventually). You can add some arch_kasan_enable/disable()
> > macros on top and feel free to include the patch below.
> 
> Ah, perfect! I'll send a patchset soon. Thanks!
> 
> > Now, I wonder whether we should link those into kasan_disable_current().
> > These functions only deal with the depth for KASAN_SW_TAGS but it would
> > make sense for KASAN_HW_TAGS to enable tag-check-override so that we
> > don't need to bother with a match-all tags on pointer dereferencing.
> 
> Using these TCO routines requires having (at least) migration disabled, right?

Not necessarily. The TCO is set per CPU and disabling preemption (I
don't think migration is sufficient) would work but these routines are
also called on a uaccess fault path, so it needs to be preemptible. We
used to clear TCO on exception entry prior to commit 38ddf7dafaea
("arm64: mte: avoid clearing PSTATE.TCO on entry unless necessary") but
we restore it anyway on exception return.

I think the only problem is if between these routines, we invoke
cond_resched() directly. Not sure what the kasan code does but disabling
preemption should avoid a reschedule. Another option is for
mte_thread_switch() to context switch the TCO state.

-- 
Catalin
