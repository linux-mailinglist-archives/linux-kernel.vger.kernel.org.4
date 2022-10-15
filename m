Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B075FFCA6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 01:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiJOXrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 19:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiJOXri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 19:47:38 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E85B402DC
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 16:47:37 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1321a1e94b3so9906748fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 16:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pW51aWKkKbcguul/KxxqOrX6YivwtnSy1U9SGxAFCa0=;
        b=GSrHz4Hbb5fYa/LvXohm4RndjnGkosrdyknxUH8A+XaqbvP1umB/QDbJakEJhqMyo3
         MdUO+sPGpAvBUcxDu0An0kBVvURdxiOsb2GYt8a6bWd1va1WIS1q1hsycNSSlsU3UBHi
         5oHwyQhFn+B/uvzOyqaDGIuY5fVXTrjSJDTWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pW51aWKkKbcguul/KxxqOrX6YivwtnSy1U9SGxAFCa0=;
        b=KLwsLMGixULhlx49KJh6QXrpZwKIFZCXO2n1QNijjOUmnuit69IkMK/EWNtj/Wf5Y2
         R8jNTTEjrcxStBWMuFYyDnqjg6goBWwmtbBqZPiaE1A9A/9/PKqCFwNmeAOpD74wqBtG
         wAzRYquM+MUucjCzvfQxbqTO8z5E5RkpkmLA2fuVohCgKEp2+Ifqz2YOyKZMfEsLgwhm
         AQL//72reyldgm9GMZkAFWdKBEwEkNketzwAOMgF/BSrx203qNCQUb5UHCOx29wWgM2T
         gPMXJsDAQs0w1TBwYAlJCTLx5STAVhsRN38ZxVsgIV2GyfC/+sO2Z+O8ezoyczXHfIfb
         5DCw==
X-Gm-Message-State: ACrzQf3Yj1ZUWGqlNx5wm2pQCVyfoHoDraIt8SZESdVboiUm+X1SMil+
        DqMvagq+SG7jua90voEeqj2aG66IlOLpxQ==
X-Google-Smtp-Source: AMsMyM5NeqzFiB0JiXIZbJ0Vgh6igBAOsCznRr3EbOzFMg/CZNHP/VqsxEBADaQ0tobMoNVpXcrEzg==
X-Received: by 2002:a05:6870:b155:b0:132:bf4:d451 with SMTP id a21-20020a056870b15500b001320bf4d451mr2316451oal.160.1665877656132;
        Sat, 15 Oct 2022 16:47:36 -0700 (PDT)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com. [209.85.167.178])
        by smtp.gmail.com with ESMTPSA id d21-20020a9d4f15000000b0066193fe498bsm3087150otl.28.2022.10.15.16.47.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Oct 2022 16:47:33 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id g10so8685066oif.10
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 16:47:33 -0700 (PDT)
X-Received: by 2002:a05:6808:23c3:b0:351:4ecf:477d with SMTP id
 bq3-20020a05680823c300b003514ecf477dmr2077092oib.126.1665877652709; Sat, 15
 Oct 2022 16:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez0B18eh3Q1853Cug8WSip7dPb2G9fhgqsPWzr0D_TBjRQ@mail.gmail.com>
 <0484E294-D6D6-45CE-87F7-5AFDA5309BA1@gmail.com>
In-Reply-To: <0484E294-D6D6-45CE-87F7-5AFDA5309BA1@gmail.com>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Sat, 15 Oct 2022 16:47:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+dMSbeuEDatZbtycm9_RFyLe60nigQA8o5w0W_HkQSg@mail.gmail.com>
Message-ID: <CAHk-=wh+dMSbeuEDatZbtycm9_RFyLe60nigQA8o5w0W_HkQSg@mail.gmail.com>
Subject: Re: [BUG?] X86 arch_tlbbatch_flush() seems to be lacking
 mm_tlb_flush_nested() integration
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Mel Gorman <mgorman@suse.de>,
        Rik van Riel <riel@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sasha.levin@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 8:51 PM Nadav Amit <nadav.amit@gmail.com> wrote:
>
> Unless I am missing something, flush_tlb_batched_pending() is would be
> called and do the flushing at this point, no?

Ahh, yes.

That seems to be doing the right thing, although looking a bit more at
it, I think it might be improved.

At least in the zap_pte_range() case, instead of doing a synchronous
TLB flush if there are pending batched flushes, it migth be better if
flush_tlb_batched_pending() would set the "need_flush_all" bit in the
mmu_gather structure.

That would possibly avoid that extra TLB flush entirely - since
*normally* fzap_page_range() will cause a TLB flush anyway.

Maybe it doesn't matter.

              Linus
