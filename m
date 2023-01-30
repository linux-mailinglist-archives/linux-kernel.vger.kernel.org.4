Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138DD681776
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 18:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237784AbjA3RUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 12:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235989AbjA3RUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 12:20:37 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B7D2F7BE
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 09:20:35 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id bb40so3263119qtb.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 09:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BrsBUBgNgJpeJwfPSLgPW4cYzXKkUkqJeLurEgVFBvc=;
        b=e+ydzywhD50AlIneG126hNOaWzSz7WikqeahTj6y7F0YaCURJalHIeVE4ABw/7sxVO
         m/3ONdqr9MSPu7D7CTSai9UauHJI281QP2hXt+MKIGoOscPaGV2whzM92UsCoyo5J4EB
         fLz3E2evnvdnTZMAvV987t7Qn7dSJZrOEBt6WQHVY81jkBD57jqajUTYkpesy9Dx4Yw3
         8pVoPOscYE/k3Pbq+VlvjaD0oE+QFDrtJ4zQ4LWxCn3ZvJPkkAudndDCOswBZEvCnHvT
         MCfSPE84Ugnh4GEZkABPP+/k7rWmEUv1qM2mVsFn4+Ntxte4gbeuqF2ESRrIsV69GYUK
         Lgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BrsBUBgNgJpeJwfPSLgPW4cYzXKkUkqJeLurEgVFBvc=;
        b=V3BmHhg/sxAIJ5UmGnVNEvh8sSN6mKkFUfPqwY5vyQrESglC6N9MCK0rEQtjgzZla2
         EhM9kUnL2nr6pRQoR6xxIF/PgrNS0u/yiczyn9CniDZHk04Qx8UvTcAL4n0w8aQsVJ+J
         iMxOBMFawcXU0nOkCpmQcYtu+WdQVxp1Auh1lBZOv9/z8FDkDzPxJdSD/SrLJ9E4rbcD
         HpOWoxISoU/x5DCenLtni6nXCddoTAjiO85O2ObahedkIfeN7TFWfgApeEgbbO291LjD
         K9RSCWGZGujDEuFht+xDs23SFJAm9p0J7IuuPAGp5zKBghXcUPXmxUqOgGr53DbjZW3p
         DiLQ==
X-Gm-Message-State: AO0yUKUb//g11iTeSDGBe7fPa4fSVnStIKTx1aIM1KtnbcIwv21EaK8B
        XM23ZRUItVFUGHUEOnBgRx5f3Vnpjmu2IarwdCEX3g==
X-Google-Smtp-Source: AK7set85qwFb9Qlw4P1CLRjHWKhUUqR7Y9GnLcrwx2XjDh1/2RDOFjTZjB3GMRx2Q2qm8ZWsz1MqPstnRa5cu1JQ+z0=
X-Received: by 2002:a05:622a:1a0a:b0:3b9:a428:68d with SMTP id
 f10-20020a05622a1a0a00b003b9a428068dmr97209qtb.482.1675099234975; Mon, 30 Jan
 2023 09:20:34 -0800 (PST)
MIME-Version: 1.0
References: <20230130130739.563628-1-arnd@kernel.org>
In-Reply-To: <20230130130739.563628-1-arnd@kernel.org>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 30 Jan 2023 12:19:58 -0500
Message-ID: <CA+CK2bCQPxcXX0uAZUkfjEAHyyCfGz08s0=iDkWr0_9O19nRxw@mail.gmail.com>
Subject: Re: [PATCH] mm: extend max struct page size for kmsan
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Alexander Potapenko <glider@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 8:07 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> After x86 has enabled support for KMSAN, it has become possible
> to have larger 'struct page' than was expected when commit
> 5470dea49f53 ("mm: use mm_zero_struct_page from SPARC on all 64b
> architectures") was merged:
>
> include/linux/mm.h:156:10: warning: no case matching constant switch condition '96'
>         switch (sizeof(struct page)) {
>
> Extend the maximum accordingly.
>
> Fixes: 5470dea49f53 ("mm: use mm_zero_struct_page from SPARC on all 64b architectures")

No need to add the above "Fixes:". The above patch works as expected
everywhere where the struct page is 80 bytes or smaller (as specified
by the comment).

I also agree with others that the KMSAN should be part of page_ext
instead of increasing the complexity of "struct page".

Otherwise,
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Thanks,
Pasha
