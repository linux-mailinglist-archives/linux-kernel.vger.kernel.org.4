Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8F35FF852
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 05:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJODv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 23:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiJODvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 23:51:54 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFA4659FF
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 20:51:53 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n12so10291159wrp.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 20:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ESb+w0sZ/kunb6ly4j7hr3fkhT75cLSi893Zn1ULp8=;
        b=qFjEoVO4aWz9hjMGNTVpmwzdk+zUvLfRe3wjG+chUX76xgBuHBrxkbbCtQ3nq2dZ0a
         U1bSOvnDe4MalILyZLg0DmrUNaU8IDtecosOopv1iFzty0MkGsiIMWQLykNcX2RRzeq4
         lb5klPzNr/TDPsXPSjwnDG+e2h4KImUHKsc5oMdXcpIx+CgfWY9HDDbrOODVCYEF0FbM
         wnaoBdO1H2nxT7MZ25fV9haN828WP9fpUAgCEo5O0TMH/mM5Bi7ojEnyY28OMVp2Rft1
         T7MOppLXMhwgE/bKBjoCjWzt1PK580Wo+E8rH/heMZ0R61s00yjbLy2GEziv9NZll7WQ
         72KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ESb+w0sZ/kunb6ly4j7hr3fkhT75cLSi893Zn1ULp8=;
        b=YQAyT9L8FdkdlD04iDB84hlk8O9IW3lGNwU6Yk6ILoeGxR0CuCIIFr0n1ukT7tx/Rv
         HqcJ6eJKciDmxthSTLek/ZjU4tADnm+6xYiU4PA4BBxbXISC5/xHQFs7HTICYrPTFsYW
         o5eQyrng1juSdO5DcZMU8tM4xUH2xHk0Reb4si++mdtQ1311I/USo3PsOpIB9LlyzZnx
         FqU+BGeKTfX0TkqQVjRGCoH5At6v/mpFXS36ZTlu3jCfmMGst/RfqYzH4js5i2QQlLp8
         iISFIVQ1hKUtWESbodOY3PnsocMotm74v7a/b4Hhqu5/OgpXZmt3E0mLN7nkeP/Gpcw4
         vKVg==
X-Gm-Message-State: ACrzQf1EcV7nPqoKVcmBGlaixAUbphMXwLkoXFbn4Y8VGgo9U463Fsnl
        aH8uMW1v0W1/akU1MnUypLB+306Vj/18p4/K
X-Google-Smtp-Source: AMsMyM512CYhXqYkmtPrL0iSLTUq9tDLGI0xE6cFEH8JXxXL6Fro2nrx4Jm80Ak21HE6isp6SD51pw==
X-Received: by 2002:a05:6000:144c:b0:230:816f:3167 with SMTP id v12-20020a056000144c00b00230816f3167mr418442wrx.532.1665805911395;
        Fri, 14 Oct 2022 20:51:51 -0700 (PDT)
Received: from smtpclient.apple ([5.29.15.194])
        by smtp.gmail.com with ESMTPSA id f16-20020a056000129000b0022dc6e76bbdsm3145105wrx.46.2022.10.14.20.51.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Oct 2022 20:51:50 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [BUG?] X86 arch_tlbbatch_flush() seems to be lacking
 mm_tlb_flush_nested() integration
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <CAG48ez0B18eh3Q1853Cug8WSip7dPb2G9fhgqsPWzr0D_TBjRQ@mail.gmail.com>
Date:   Sat, 15 Oct 2022 06:51:47 +0300
Cc:     Andy Lutomirski <luto@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@suse.de>, Rik van Riel <riel@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sasha.levin@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0484E294-D6D6-45CE-87F7-5AFDA5309BA1@gmail.com>
References: <CAG48ez0B18eh3Q1853Cug8WSip7dPb2G9fhgqsPWzr0D_TBjRQ@mail.gmail.com>
To:     Jann Horn <jannh@google.com>
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

On Oct 14, 2022, at 9:19 PM, Jann Horn <jannh@google.com> wrote:

> Hi!
>=20
> I haven't actually managed to reproduce this behavior, so maybe I'm
> just misunderstanding how this works; but I think the
> arch_tlbbatch_flush() path for batched TLB flushing in vmscan ought to
> have some kind of integration with mm_tlb_flush_nested().
>=20
> I think that currently, the following race could happen:
>=20
> [initial situation: page P is mapped into a page table of task B, but
> the page is not referenced, the PTE's A/D bits are clear]
> A: vmscan begins
> A: vmscan looks at P and P's PTEs, and concludes that P is not =
currently in use
> B: reads from P through the PTE, setting the Accessed bit and creating
> a TLB entry
> A: vmscan enters try_to_unmap_one()
> A: try_to_unmap_one() calls should_defer_flush(), which returns true
> A: try_to_unmap_one() removes the PTE and queues a TLB flush
> (arch_tlbbatch_add_mm())
> A: try_to_unmap_one() returns, try_to_unmap() returns to =
shrink_folio_list()
> B: calls munmap() on the VMA that mapped P
> B: no PTEs are removed, so no TLB flush happens

Unless I am missing something, flush_tlb_batched_pending() is would be
called and do the flushing at this point, no?

IIUC the scenario, we had some similar cases in the past [1]. Discussing
these scenarios required too many arguments for my liking, and I =
would=E2=80=99ve
preferred an easier-to-reason batching coordination between the batching
mechanisms. I proposed some schemes in the past, but to be fair, I think
all of them would have some extra overhead.

[1] =
https://lore.kernel.org/linux-mm/69BBEB97-1B10-4229-9AEF-DE19C26D8DFF@gmai=
l.com/T/#u

