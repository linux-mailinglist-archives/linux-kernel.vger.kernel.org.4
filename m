Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDA1734875
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 22:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjFRU6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 16:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjFRU6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 16:58:11 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09324E4E
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 13:58:09 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f9d619103dso205581cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 13:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687121888; x=1689713888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZtyfCTAVMiPGQWHjgwoE9XDDUe5Zitl3naYIJu5u8M=;
        b=ZVT9TlvXekbzjsIk4FVN6w5b3V3bL2g07xM58CsOQEKlBliMaOMo4yZji4Q+4M2pTX
         PwOyYLy6AVqkAYYG8oZQzsoJ5wXO3fYU4dvuBveWcoPn/DBqA76dOm2wErETk5RMX4DF
         Pdjj7y7tVBfSg3bUPlVpNbbP9RKpJTFpWfMqG6NS8ogCoI9SFLLQjHjuiJCl9wmx/QMI
         sfudbAhw5Fv3ydEbSaSvd7K7sWgk9eaIp4KEVRbqeVVI+v27ojzRWzN3DHLLYoRPb3Uw
         6IMcAn+rqIjZUCyYlDlj0BpHHcpwknOPBIBYMxSFkst2yjNHbhKR20MPChNpYuTjpIYD
         wwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687121888; x=1689713888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZtyfCTAVMiPGQWHjgwoE9XDDUe5Zitl3naYIJu5u8M=;
        b=DsDLCOdAUcqkOnVFZKY+voUPiB9b6MPocp+PjWN+IZE5OffHcHIhsPDra+yV2qIgsj
         pCD5pDhw8VPfyfHi3hP7WohlB+E9LkBa0s3d2DZcOU04bnnZFUQU99jYKhKMgPEwOARD
         NtQbQOd2wHXdcMUMZBds5HEXyWzVhAdHHFA3xt2xUyX+M1JqU+vG14cX5APEY2PbHAiq
         zV5Xp8oc1aiz1u3lbkK9L6zPyMTGgkJ8oUflAyu0VabLahoNu+vIC6ToKhkQFpmmjG0t
         mcFQ8p8ErW7m+8k9vgsU+aeuF2i+Whz8f6jyRngJQuDRrheVfeYDgR1XpTmGcy2eOvFp
         BjSA==
X-Gm-Message-State: AC+VfDz7anqEwNh2Wl8IVmAWnk5g0IGndYJCy4ELlvMp5vGAFLMaaSFH
        kkNkT0BKvqqjNqjiGIToHh9j5uQv00n3TLgis2TgSA==
X-Google-Smtp-Source: ACHHUZ6ZDWbPtAWRuLjADFFa6FEUQ3GypTx245KPaUVC0BHZGX9Wd0LOXtVKSGnZtQDaYiPHdDlVEaUz0sYg2vTadSQ=
X-Received: by 2002:a05:622a:20a:b0:3f9:a78f:c527 with SMTP id
 b10-20020a05622a020a00b003f9a78fc527mr291449qtx.21.1687121888063; Sun, 18 Jun
 2023 13:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <a4963be9-7aa6-350-66d0-2ba843e1af44@google.com>
 <178970b0-1539-8aac-76fd-972c6c46ec17@google.com> <20230614231758.GA1503611@dev-arch.thelio-3990X>
 <f5526f17-9d78-f7ea-427a-7e76bfeb6b8@google.com> <344a4da-3890-45fd-607e-b5f85ca6ad48@google.com>
 <20230615155059.GB3665766@dev-arch.thelio-3990X> <76b41825-30fa-b9e8-d043-2affcba24317@google.com>
 <addfcb3-b5f4-976e-e050-a2508e589cfe@google.com> <ZI0uh8P/akwkGo0D@google.com>
In-Reply-To: <ZI0uh8P/akwkGo0D@google.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sun, 18 Jun 2023 14:57:31 -0600
Message-ID: <CAOUHufbAjZd4Mxkio9OGct-TZ=L0QRG+_6Xa7atQVFN_4ez86w@mail.gmail.com>
Subject: Re: [PATCH v2 07/23 replacement] mips: add pte_unmap() to balance pte_offset_map()
To:     Hugh Dickins <hughd@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        Michal Simek <monstr@monstr.eu>, Helge Deller <deller@gmx.de>,
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
        linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Jun 16, 2023 at 9:54=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Thu, Jun 15, 2023 at 04:02:43PM -0700, Hugh Dickins wrote:
> > To keep balance in future, __update_tlb() remember to pte_unmap() after
> > pte_offset_map().  This is an odd case, since the caller has already do=
ne
> > pte_offset_map_lock(), then mips forgets the address and recalculates i=
t;
> > but my two naive attempts to clean that up did more harm than good.
> >
> > Tested-by: Nathan Chancellor <nathan@kernel.org>
> > Signed-off-by: Hugh Dickins <hughd@google.com>
>
> FWIW: Tested-by: Yu Zhao <yuzhao@google.com>
>
> There is another problem, likely caused by khugepaged, happened multiple =
times. But I don't think it's related to your series, just FYI.
>
>   Got mcheck at ffffffff81134ef0
>   CPU: 3 PID: 36 Comm: khugepaged Not tainted 6.4.0-rc6-00049-g62d8779610=
bb-dirty #1

...

>   Kernel panic - not syncing: Caught Machine Check exception - caused by =
multiple matching entries in the TLB.

In case anyone plans to try to fix this - the problem goes back to at
least 5.15 stable. My (educated) guess is that nobody complained about
it because all the testing is done in QEMU, which does NOT detect
conflicting TLBs. This means the verification of the fix would need to
be on a real piece of h/w or an updated QEMU.

In target/mips/tcg/sysemu/tlb_helper.c:

static void r4k_fill_tlb(CPUMIPSState *env, int idx)
{
    r4k_tlb_t *tlb;
    uint64_t mask =3D env->CP0_PageMask >> (TARGET_PAGE_BITS + 1);

    /* XXX: detect conflicting TLBs and raise a MCHECK exception when neede=
d */
...
