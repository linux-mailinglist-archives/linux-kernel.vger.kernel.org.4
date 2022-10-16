Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D955FFD5B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 07:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJPFbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 01:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiJPFbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 01:31:49 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70D236BFE
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 22:31:48 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id a3so13700220wrt.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 22:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9D55kcxJPfSr4uC7lrTBeIrdbazIcQsUG0uBUHU+RpE=;
        b=RvAjObri22TFWIEm1z7bKNe1iq3npeuDeXgDJ6ccka3jO2O5Awq26AykZI/CkElPKI
         oOis1ogoCJVAAihsJuxwyKBgaicfVIFOA5AmC4e1u+H64P6F4yJq5OThF9apID2R0SjX
         Zy2Fwld1z7GBQHf2BRP4JIptqwoQYdzveu8ot/iBpR2+p5urSO8lYmOOOk6FBNrzWTnd
         evgsxu8vLB6I7CFbXdtn+dsI8ci5lIboIWd4KF6/baO7/i/EOjHzsewnUGocTk8cN+iq
         o0lnZf+71dLla3WGEP6Bdk1EVL6He4g/iuxcSfmzkODAVjmumVmZL4q+nEfQ2tBmXGcP
         3vXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9D55kcxJPfSr4uC7lrTBeIrdbazIcQsUG0uBUHU+RpE=;
        b=tRdSgF1KsuFdyE6TUa7CEdJ3SX1FEUzSpJxf802MGJPWmfpd5i5sVS5zeed/albOE1
         kbb8dyLaj5D0LvhNWZ3vvEThfi8ZJxniHXANERVGcjFHsLAeOb3PeNgqJ1mKoL+MFkig
         uWaD8rhGUzjqPrLhfTer+ZkRZWyqjkA81PQb+ra4G2bvsocgh2ZVw41WKH/gWxGFiT9x
         ix2ggPwQ2S9e7y6f9qjfGEvSTr9lUCdTRmF8evNXYj7KG+1toM2BnyfYSxUCs8j1a6h1
         ThUbK9eCIgX13VE1vx6QcsfhUm58U+MqXXEJflz1k+g/XKz5SA0bTSnvXKEynuX4Unje
         Mrvw==
X-Gm-Message-State: ACrzQf1EPqNzejcdNKKGZPTmkgH99uY0YK7/PQiCphYFprBO/sJmj19E
        3xz247QPyFwDsWD+jbCL31Y=
X-Google-Smtp-Source: AMsMyM6ViCpN6wr5owNw5is0YYv4UENj8HWI+Ly8s+gNySpEGBC2dmExXe5kSfIObdI4/BDq57i5hQ==
X-Received: by 2002:a05:6000:2aa:b0:231:ac4f:196d with SMTP id l10-20020a05600002aa00b00231ac4f196dmr2708249wry.121.1665898307032;
        Sat, 15 Oct 2022 22:31:47 -0700 (PDT)
Received: from smtpclient.apple ([77.137.77.214])
        by smtp.gmail.com with ESMTPSA id k5-20020a5d6d45000000b0022e57e66824sm6459092wri.99.2022.10.15.22.31.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Oct 2022 22:31:45 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [BUG?] X86 arch_tlbbatch_flush() seems to be lacking
 mm_tlb_flush_nested() integration
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CAHk-=wh+dMSbeuEDatZbtycm9_RFyLe60nigQA8o5w0W_HkQSg@mail.gmail.com>
Date:   Sun, 16 Oct 2022 08:31:42 +0300
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <2C85D898-7D10-4E5C-9B2C-017B202C7026@gmail.com>
References: <CAG48ez0B18eh3Q1853Cug8WSip7dPb2G9fhgqsPWzr0D_TBjRQ@mail.gmail.com>
 <0484E294-D6D6-45CE-87F7-5AFDA5309BA1@gmail.com>
 <CAHk-=wh+dMSbeuEDatZbtycm9_RFyLe60nigQA8o5w0W_HkQSg@mail.gmail.com>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
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

On Oct 16, 2022, at 2:47 AM, Linus Torvalds =
<torvalds@linuxfoundation.org> wrote:

> On Fri, Oct 14, 2022 at 8:51 PM Nadav Amit <nadav.amit@gmail.com> =
wrote:
>> Unless I am missing something, flush_tlb_batched_pending() is would =
be
>> called and do the flushing at this point, no?
>=20
> Ahh, yes.
>=20
> That seems to be doing the right thing, although looking a bit more at
> it, I think it might be improved.
>=20
> At least in the zap_pte_range() case, instead of doing a synchronous
> TLB flush if there are pending batched flushes, it migth be better if
> flush_tlb_batched_pending() would set the "need_flush_all" bit in the
> mmu_gather structure.
>=20
> That would possibly avoid that extra TLB flush entirely - since
> *normally* fzap_page_range() will cause a TLB flush anyway.
>=20
> Maybe it doesn't matter.

It seems possible and simple.

But in general, there are still various unnecessary TLB flushes due to =
the
TLB batching. Specifically, ptep_clear_flush() might flush unnecessarily
when pte_accessible() finds tlb_flush_pending holding a non-zero value.
Worse, the complexity of the code is high.

To simplify the TLB flushing mechanism and eliminate the unnecessary TLB
flushes, it is possible to track the =E2=80=9Ccompleted=E2=80=9D TLB =
generation (i.e., one
that was flushed). Tracking pending TLB flushes can be done in VMA- or
page-table granularity instead of mm-grnaulrity to avoid unnecessary =
flushes
on ptep_clear_flush(). Andy also suggested having a queue of the pending =
TLB
flushes.

The main problem is that each of the aforementioned enhancements can add
some cache references, and therefore might induce additional overheads. =
I
sent some patches before [1], which I can revive. The main question is
whether we can prioritize simplicity and unification of the various
TLB-flush batching mechanisms over (probably very small) performance =
gains.


[1] =
https://lore.kernel.org/linux-mm/20210131001132.3368247-1-namit@vmware.com=
/=
