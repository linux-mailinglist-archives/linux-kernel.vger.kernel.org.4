Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7903C741CE7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 02:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjF2A2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 20:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjF2A2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 20:28:12 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A752122
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 17:28:11 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40079620a83so163201cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 17:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687998490; x=1690590490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3sxRrExQR7lJV6jvWZ5R7RjbSffn5YHmj9jbb61spI=;
        b=r2Ch6dd3Oy5ATuKjb580eq8/KXAABw0eOUHkyDtSlLZiQoaZjpTJL/7bARwrgsW66k
         d2gMqg+IrkJCoNVDp2q+/9sCHmVd53nm0vMnZ0uitf5p0hbRBrL4EmdKnkJHDiZK5Oc4
         9oauP8LfD9PAmECrNwlGnV/GIPOUxtyckNSg8ttFE6DANxvYAoTyhysJxBmF7iaOW2Dw
         +uODy5JlFkcEFh0BMppTXoOmmYbFyaKVIgNS3q7JjDNRYN1XUwoy2z0fBIfWvecERfpQ
         soehKD9L2ke2xP6yQiqOAYGP5UH3iItDNw0fQTZK7Xg98xvlIYZg/e0AeDMJg7Ulwxb6
         t2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687998490; x=1690590490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3sxRrExQR7lJV6jvWZ5R7RjbSffn5YHmj9jbb61spI=;
        b=WGRrojK/TzYf4vvl9t5Hvy4vraIzenz70bkoRouaEW6n4/MJF74AL0OGdfUXgJeKUH
         vhUybMaT/0BxcD9HaUkwPeMBJWo88symMkTKHmurw9ErUqNP6B8sgXqKsZfABjW0AzgU
         c1ZKpe1xzgJmxnV1evIXxejOS7tznZqDFLySK4yd7F8sZEtE+kjLmXR6WKtGQRYnpIfS
         SX9jHDhMm3M4qW/cnq/j6DV7pRnnHjCNzoVSptXEj36uBOYRLe4/vgoNQ0WespDpmPyv
         KZjR3azLET6ikaA+N20ygVTMQKmMup023l3UxXOEKnDiSw2eV3Xr3xtOegovD72d7Q2n
         C7KA==
X-Gm-Message-State: AC+VfDzlr6yH2INkNZqeW8gzs6kNsqRSCT93q43BUGKA5E2FgDw/zEJB
        1IvWQ/TD8Tgn8QpM8Q1XLk6aP9nQkAszxH2lJnXvtA==
X-Google-Smtp-Source: ACHHUZ5cgzeZsCkQVE5oXJ8aWyDwEbuY/Fyio8PQe622ucd9axAZhja7G4hziS8H14gRW3UCdBVkuxQvLWsO//xg7PA=
X-Received: by 2002:ac8:7f4e:0:b0:3f8:1f30:a1f2 with SMTP id
 g14-20020ac87f4e000000b003f81f30a1f2mr447680qtk.26.1687998490244; Wed, 28 Jun
 2023 17:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230626171430.3167004-1-ryan.roberts@arm.com>
 <CAOUHufaUTbUw9MTzw8D=sVrEB+RP6LSBQVGn93TWk=ozV8XobA@mail.gmail.com>
 <CAOUHufa0S_ayrys0XzDbH8KJi5HxvbGCh_bSAhDpAgcmSJjFUQ@mail.gmail.com>
 <1fb0c4cb-a709-de20-d643-32ed43550059@arm.com> <CAOUHufbtNPkdktjt_5qM45GegVO-rCFOMkSh0HQminQ12zsV8Q@mail.gmail.com>
 <dcbbea37-7fbf-3a7c-6cfb-04dae715e967@intel.com>
In-Reply-To: <dcbbea37-7fbf-3a7c-6cfb-04dae715e967@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 28 Jun 2023 18:27:34 -0600
Message-ID: <CAOUHufbC76OdP16mRsY3i920qB7khcu8FM+nUOG0kx5BMRdKXw@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] variable-order, large folios for anonymous memory
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org
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

On Wed, Jun 28, 2023 at 5:59=E2=80=AFPM Yin Fengwei <fengwei.yin@intel.com>=
 wrote:
>
> Hi Yu,
>
> On 6/29/23 02:22, Yu Zhao wrote:
> > And please make sure it's disabled by default, because we are still
> > missing many important functions, e.g., I don't think we can mlock()
> > when large() && !pmd_mappable(), see mlock_pte_range() and
> > mlock_vma_folio(). We can fix it along with many things later, but we
> > need to present a plan and a schedule now. Otherwise, there would be
> > pushback if we try to land the series without supporting mlock().
> >
> > Do you or Fengwei plan to take on it? (I personally don't.) If not,
> Do you mean the mlock() with large folio? Yes. I can work on it. Thanks.

Great. Thanks!

Other places that have the similar problem but are probably easier to
fix than the mlock() case:
* madvise_cold_or_pageout_pte_range()
* shrink_folio_list()
