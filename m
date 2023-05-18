Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46669708856
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 21:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjERT3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 15:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjERT3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 15:29:20 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BD9194
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 12:29:19 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f4234f67feso13735e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 12:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684438158; x=1687030158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIFdF8GT7zUenP4B/UoN0byarsJ8CzDEiV0NqRPRUiQ=;
        b=Uxo5R0yZohoUeJJFTQrwM/0iDUM8s/ZhBeLXvqBwIGBhosJvSUZY/pVw5D/kK5YqBX
         t0YUZ9PJRPbSBA1cAXgrFlmyRu22QDs2vk9LwoS1Vc/BLgT33eNrFh2gR7RMixMdU9pF
         8P01mTJth058rQOO5TmeFThj0TmYFHxendJ35CKKe0wpv+KSFOx9FbGk+vSsbmtjdJmF
         MoKqNialoSnEDU27YOgQHSeSfgbH3RwmpqCCAHYQW9TQlFT8KOxl4iLKhN8Q4nRG0k3C
         vTIffa26u7CrKoYTKHxbPYN7OQkEBh7C7utYywfWTfxfYempEHiTHfbsjZAafRzuys/3
         coEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684438158; x=1687030158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIFdF8GT7zUenP4B/UoN0byarsJ8CzDEiV0NqRPRUiQ=;
        b=ToQA3xkVDs8z6Fcn+EpvR69D7FQcaF0aMptcXBo67PPE5C9i/pcSTW884+W23dLY6v
         Yd0RmihmhpLJPR95dVwdRdMRf4dNPYmyayCLCVaE3TFvUKZTYuByIE6r/rs6njfLlYtO
         YX6/T5rDKQbrDD/pF9LjzW07Gf0bH3QGGAgJ6VMKw/ZNv0/DvqkZXM1gEQNBiPBSjiIJ
         SkBbUT9cpbmO6wg9ycHRiTJ9Zb1uZ2Xlk4+s7uvqLXjS75x/ZEz7iDLP0W8OYHy75Urz
         L4clzozLeN1ac6/rHyy0ueLhL3kJ3GsizGBgzEx9qYZWLLRUMb4Y6oufaqwpSmPGyC+l
         xeRA==
X-Gm-Message-State: AC+VfDyAlmQUp8iAHsEByq354JENmG9T+6AMoVP42scjOAezGiTTDIVh
        bksT0duS7uvsHMv1rozvI80W9KAiyAeQqmTPUL1anw==
X-Google-Smtp-Source: ACHHUZ5CjeOl+/lEZTX8Uee0Ftthe9E4dunYZK5dMRfMgke26RmSp2LBtvDHRXHjW5Kbw5GABsfsakJxT5P3YD+q7Z4=
X-Received: by 2002:a05:600c:46d0:b0:3f2:4fd2:e961 with SMTP id
 q16-20020a05600c46d000b003f24fd2e961mr3080wmo.0.1684438157716; Thu, 18 May
 2023 12:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230518110727.2106156-1-ryan.roberts@arm.com> <20230518110727.2106156-5-ryan.roberts@arm.com>
In-Reply-To: <20230518110727.2106156-5-ryan.roberts@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 18 May 2023 13:28:35 -0600
Message-ID: <CAOUHufZaiTCxk4M4w5GaA-+5FoMnHZt+fzoU=cYCA1Ldk7CVEQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mm: Add new ptep_deref() helper to fully
 encapsulate pte_t
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 5:07=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> There are many call sites that directly dereference a pte_t pointer.
> This makes it very difficult to properly encapsulate a page table in the
> arch code without having to allocate shadow page tables. ptep_deref()
> aims to solve this by replacing all direct dereferences with a call to
> this function.
>
> The default implementation continues to just dereference the pointer
> (*ptep), so generated code should be exactly the same. However, it is
> possible for the architecture to override the default with their own
> implementation, that can (e.g.) hide certain bits from the core code, or
> determine young/dirty status by mixing in state from another source.
>
> While ptep_get() and ptep_get_lockless() already exist, these are
> implemented as atomic accesses (e.g. READ_ONCE() in the default case).
> So rather than using ptep_get() and risking performance regressions,
> introduce an new variant.

We should reuse ptep_get():
1. I don't think READ_ONCE() can cause measurable regressions in this case.
2. It's technically wrong without it.
