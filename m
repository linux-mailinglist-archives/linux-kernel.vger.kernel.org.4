Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F396C7315
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 23:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjCWW2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 18:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjCWW2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:28:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269442BECE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:28:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5DA9B8228A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 22:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 856ACC433A0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 22:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679610517;
        bh=WVjaeAT0x0YIE9dh+8oT/MKnhAfcKJy/PIi5H1aahxM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nUNR8vw9J/bm2bDfuWRSbtn/i1A5klJhvU/Lq7TKerNUL0AM+jQ217sRpLjnwkife
         B6wl36j5h/KboZPA6qxKjoCJd4yLsliDiYNfMtnn+HXixDOocmd2hqfiWzRQb1f7sb
         edyi0DQymf18Op3IVfK1zFgxi6ydH4wDGtdgUG6OM6ItDP31uwDkyc4pOFEEoWLDnd
         XoqcJCGOJ1uCkeT9awHE+iReMOVk7RxpV87STl7oBZjkDHNAJQUpRDvQTFagcnkas2
         v4VfCkBIvcEvq011hQ0ya7zHs/RnNnMdpWq/EZVDfjKCX4U+0bpnOpUkcWoqQJLvG6
         8z7G9gb0yI8xQ==
Received: by mail-lf1-f42.google.com with SMTP id br6so29709125lfb.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:28:37 -0700 (PDT)
X-Gm-Message-State: AAQBX9cF5WZgtE/s9m2fdoeNoKo6yv3TCCqF0urFnb4XJGWYAeUuumCO
        khpl9+wbSPc8nsC0yUJTp6nJ9/fA9V1jXVHkJrU=
X-Google-Smtp-Source: AKy350YJbnX2hENfL7t/TDtfJsLhUHpUQoLvIEhiigVbNsat1oGb/jZjFkIZrE8MbCUQodxanIMx/roFaG8fesqz0bI=
X-Received: by 2002:ac2:5d72:0:b0:4ea:e296:fead with SMTP id
 h18-20020ac25d72000000b004eae296feadmr108743lft.3.1679610515504; Thu, 23 Mar
 2023 15:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230307052036.1520708-1-stevensd@google.com> <20230307052036.1520708-4-stevensd@google.com>
 <866d1a75-d462-563-dfd7-1aa2971a285b@google.com> <ZBzK99dSmbPB7vjA@casper.infradead.org>
In-Reply-To: <ZBzK99dSmbPB7vjA@casper.infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 23 Mar 2023 15:28:22 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5pTh2+S7VjRbRy=WUAb7-GLQpi6HKCW0ehxs5HAup_dQ@mail.gmail.com>
Message-ID: <CAPhsuW5pTh2+S7VjRbRy=WUAb7-GLQpi6HKCW0ehxs5HAup_dQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] mm/khugepaged: maintain page cache uptodate flag
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>, Song Liu <songliubraving@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        David Stevens <stevensd@chromium.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 2:56=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Thu, Mar 23, 2023 at 12:07:46PM -0700, Hugh Dickins wrote:
> > On an earlier audit, for different reasons, I did also run across
> > lib/buildid.c build_id_parse() using find_get_page() without checking
> > PageUptodate() - looks as if it might do the wrong thing if it races
> > with khugepaged collapsing text to huge, and should probably have a
> > similar fix.
>
> That shouldn't be using find_get_page().  It should probably use
> read_cache_folio() which will actually read in the data if it's not
> present in the page cache, and return an ERR_PTR if the data couldn't
> be read.

build_id_parse() can be called from NMI, so I don't think we can let
read_cache_folio() read-in the data.

Thanks,
Song
