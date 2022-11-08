Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F12621D8A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 21:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiKHUTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 15:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiKHUTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 15:19:13 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA2669DCC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 12:19:12 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id x15so9308829qtv.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 12:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rYTJsr3y3DSpzuW7jbv9zORF+HiPBsmrV3dtI+qjb2g=;
        b=RktMLy/W0Aalvj/azaMLVb1FNgDV1yEPtRfoOCAalX5a3JOa/QZKm/gQYlMeehBILF
         Z8FRelGTxwLlt2r/PHfGWfm7hcJhjQ+Ccxx9+6hwjwDVkjbRbmOXWEwQ5Og3WEMnSrUe
         jvI9rMDLZTywmAFs2PxsTOcuGTZL45ITlqnps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rYTJsr3y3DSpzuW7jbv9zORF+HiPBsmrV3dtI+qjb2g=;
        b=lZgVVTkGpCxXl6f2lkNOey1F/J4T/ctd3UIR5xuG0kKGaTC+AiqaQ3eoUVUl7XhrBd
         DRIHvYS+LN9ZpxmyQOyBQggoxtBxt27GEWz6o0pXrkgcYbQJGwZPH5ojLM8g3gKMhcH6
         EKUatB9gOeNajyB83KPcNScrCEEAuad0xGAAQEexbNYUg0MoK3J1P4q2JZffUXTpT2uf
         kLDcrScAuVYhlvCRLzU47PiSdfhx919msPhYEFwf3foioza9mAm4yXGyvTHoUY8BkRCK
         KspSDyPhNW5qg0vkWlWm7ZL6ZDCT/8Pb3LAaaiYoBpHdju5lgQFEu/zUloHZ/983iA48
         vsvg==
X-Gm-Message-State: ACrzQf2J/86neq2eUhHz1KDcM7LrWC5ZEQ66LCAsJxV10086M/px4rH8
        YN0cSAyJR4RBKw+2Cnxe/fscm0HhZdP1uA==
X-Google-Smtp-Source: AMsMyM46k3yEwpNJZNPNP7PmWkYeoxWQR8AqofyB1UQCM0Z3u3dFLIqRyQ32G41orCZ0MZ0kiSxJBg==
X-Received: by 2002:a05:622a:1f9b:b0:3a5:2425:baac with SMTP id cb27-20020a05622a1f9b00b003a52425baacmr38443529qtb.56.1667938751520;
        Tue, 08 Nov 2022 12:19:11 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id w5-20020a05620a424500b006f84ee3a4f3sm9680224qko.48.2022.11.08.12.19.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 12:19:06 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-3704852322fso144053047b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 12:19:03 -0800 (PST)
X-Received: by 2002:a0d:ef07:0:b0:373:5257:f897 with SMTP id
 y7-20020a0def07000000b003735257f897mr35789530ywe.401.1667938743084; Tue, 08
 Nov 2022 12:19:03 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjnvPA7mi-E3jVEfCWXCNJNZEUjm6XODbbzGOh9c8mhgw@mail.gmail.com>
 <CAHk-=wjjXQP7PTEXO4R76WPy1zfQad_DLKw1GKU_4yWW1N4n7w@mail.gmail.com>
 <Y2SyJuohLFLqIhlZ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <CAHk-=wjzp65=-QE1dg8KfqG-tVHiT+yAfHXGx9sro=8yOceELg@mail.gmail.com>
 <8a1e97c9-bd5-7473-6da8-2aa75198fbe8@google.com> <Y2llcRiDLHc2kg/N@cmpxchg.org>
 <CAHk-=whw1Oo0eJ7fFjy_Fus80CM8CnA4Lb5BrrCdot3Rc1ZZRQ@mail.gmail.com>
 <CAHk-=wh6MxaCA4pXpt1F5Bn2__6MxCq0Dr-rES4i=MOL9ibjpg@mail.gmail.com>
 <CAHk-=whi2BB9FviYiuUWV0KHibP_Lx_CWDWkxxv3SXA1PKV0Lg@mail.gmail.com>
 <CAHk-=wivgyfywteXoO7K0Mj_KoCRF-RyXDH-eGW0A_fev+dGug@mail.gmail.com> <20221108200345.xxcvnsnwgjyb7w3a@meerkat.local>
In-Reply-To: <20221108200345.xxcvnsnwgjyb7w3a@meerkat.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Nov 2022 12:18:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjFdzHxB+f9WOTM1jZKBig9sY0s_-ASCZEUGsQ1mirjgQ@mail.gmail.com>
Message-ID: <CAHk-=wjFdzHxB+f9WOTM1jZKBig9sY0s_-ASCZEUGsQ1mirjgQ@mail.gmail.com>
Subject: Re: mm: delay rmap removal until after TLB flush
To:     Konstantin Ryabitsev <mricon@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>, X86 ML <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Uros Bizjak <ubizjak@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        linux-arch <linux-arch@vger.kernel.org>
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

On Tue, Nov 8, 2022 at 12:03 PM Konstantin Ryabitsev <mricon@kernel.org> wrote:
>
> Yes, --no-parent.

Ahh, that's new. I guess I need to update my ancient b4-0.8.0 install..

But yes, with that, and the manual parent lookup (because otherwise
"--no-parent" will fetch *just* the patch itself, not even walking up
the single parent chain). it works.

Maybe a "--single-parent" or "--deadbeat-parent" option would be a good idea?

Anyway, with a more recent b4 version, the command

   b4 am --no-parent
CAHk-=wh6MxaCA4pXpt1F5Bn2__6MxCq0Dr-rES4i=MOL9ibjpg@mail.gmail.com

gets that series and only that series.

              Linus
