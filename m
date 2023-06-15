Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758BE732190
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 23:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjFOVW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 17:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbjFOVWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 17:22:22 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7976D2962
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 14:22:20 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5703cb4bcb4so1196037b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 14:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686864139; x=1689456139;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S2y2ag2VSA5iJWjnLMJgW21sD26IXOkwRb84bIEjNFc=;
        b=xQ0UEfbeHsvyF9P9GSzV8sPaDnCduWem82QRocOPVTimyNaz+TtzXunPSdeRzXvvAi
         vai/I3V4xnGwkuPBK2C8BxgXmG/grI3PNJPpvIXErHwA9uzmeBRdld+oVJisQfogsxl0
         vGLKSwM0YFacwx/AmX5Id6XW9gRfBLJoOHHDKed5GhoMi63Kk25c1kBjAvC4IVlUHe3e
         oelGGGI8RCOSrTPLR5K32xFZslyRFLZPbM5b3aFNmrO++aNzcuug8bpdMx1IF1HOO2ol
         NHDhCqI2eK44IOXmk4glSuyplwnvkIK/n7XkQCIImv5fgRh6qF4f64HAb8zfCbRE0z7D
         2CQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686864139; x=1689456139;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S2y2ag2VSA5iJWjnLMJgW21sD26IXOkwRb84bIEjNFc=;
        b=kqQylgoja4ynKyyMz/Evsu9IlawHt3wX03Zdxmkwoye1jWt/pEUGXJOO4snegcHvp1
         +FX21tjTr6WPSOhOiJ1SJ6TBUkNBeZGXtuBrP3EoC3zFiB+Vk5+A0oWqhRUhPRT7QqWY
         2sKUPc99lBxdVLA4kgBeYh9RXS/Qr9utApnhrI5lcoxaTEODHS5lMp2Imq/4LKBPZfV5
         D21ESZXd8l33m3MPi1llSYSkfa9G0zqmp+R4xfiAKNf0tqBgT97+FeABDihLYHi5s5DU
         m7Jvsj5DhfnMWmozeW7H2wmNzgzKtIj6/3j4D/lvnrIOspqoofm2gRaNzHCcIqaO2T1j
         uQTw==
X-Gm-Message-State: AC+VfDw7zLxxQqHnH6ydNPWln4W/juXoL94lL5EBQ7SePxsRUHteMCUD
        722mxbQg0wo2dFjK6m1xUA9WYg==
X-Google-Smtp-Source: ACHHUZ7Wn443nNp7TXnOUS1g0CwvPfeS1ec2zVwJBnOAceqd4kD8IQUnTLQfS40NfWgzNKeH64ll/A==
X-Received: by 2002:a81:83d3:0:b0:56c:ea2c:5cb2 with SMTP id t202-20020a8183d3000000b0056cea2c5cb2mr5787878ywf.49.1686864139515;
        Thu, 15 Jun 2023 14:22:19 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id s189-20020a0de9c6000000b0054f80928ea4sm4626438ywe.140.2023.06.15.14.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 14:22:19 -0700 (PDT)
Date:   Thu, 15 Jun 2023 14:22:15 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Nathan Chancellor <nathan@kernel.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 07/23] mips: update_mmu_cache() can replace
 __update_tlb()
In-Reply-To: <20230615155059.GB3665766@dev-arch.thelio-3990X>
Message-ID: <76b41825-30fa-b9e8-d043-2affcba24317@google.com>
References: <a4963be9-7aa6-350-66d0-2ba843e1af44@google.com> <178970b0-1539-8aac-76fd-972c6c46ec17@google.com> <20230614231758.GA1503611@dev-arch.thelio-3990X> <f5526f17-9d78-f7ea-427a-7e76bfeb6b8@google.com> <344a4da-3890-45fd-607e-b5f85ca6ad48@google.com>
 <20230615155059.GB3665766@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2023, Nathan Chancellor wrote:
> On Wed, Jun 14, 2023 at 10:43:30PM -0700, Hugh Dickins wrote:
> > 
> > I do hope that you find the first fixes the breakage; but if not, then
> 
> I hate to be the bearer of bad news but the first patch did not fix the
> breakage, I see the same issue.

Boo!

> 
> > I even more fervently hope that the second will, despite my hating it.
> > Touch wood for the first, fingers crossed for the second, thanks,
> 
> Thankfully, the second one does. Thanks for the quick and thoughtful
> responses!

Hurrah!

Thanks a lot, Nathan.  I'll set aside my disappointment and curiosity,
clearly I'm not going to have much of a future as a MIPS programmer.

I must take a break, then rush Andrew the second patch, well, not
exactly that second patch, since most of that is revert: I'll just
send the few lines of replacement patch (with a new Subject line, as
update_mmu_cache() goes back to being separate from __update_tlb()).

Unless you object, I'll include a Tested-by: you.  I realize that
your testing is limited to seeing it running; but that's true of
most of the testing at this stage - it gets to be more interesting
when the patch that adds the rcu_read_lock() and rcu_read_unlock()
is added on top later.

Thanks again,
Hugh
