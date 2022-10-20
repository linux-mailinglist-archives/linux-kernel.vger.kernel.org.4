Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5549F606B23
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 00:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJTWTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 18:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJTWT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 18:19:29 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C5422B3A0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 15:19:14 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id y129so538673vkg.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 15:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yPAtFjxnM9QnPlCbiawpwzjKWBbf/HX4WSc2JVqLBOY=;
        b=O84ATMDl80Y3SemMzzwQ8EhGpuSf7ld5bfiznIEopm2rGgtJ2AVff2EKS4z/g8jvTY
         TJ6ZQhu7eyriq8P5/K15dRBQhTAfMSJ+7o7KzFVtV3sgCdVxWauKyzIl08agFdTedz3Y
         irvKUAJktENQYFrv8APfpioWxRUhrGliDoj9F2tT+0H0vZdE0rckcKhXI6YJ+8yloUVa
         jbt+raQSAqWX2CUGU2pPAs9icMIgJRQZShjYbgpAkxgPlg6IuxAwG9v16Yv417TJnEc3
         blZ7tpFUJGB9fjfkFlBd1hLZK7WCCOHcxjHC08Br+8ru/MXjmXbf2gdYDMNyYI3aA5xx
         4lxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yPAtFjxnM9QnPlCbiawpwzjKWBbf/HX4WSc2JVqLBOY=;
        b=B3llGa6rERJ1GTCxkh7IqY3dXlmDWa2cv9k9gamdnW4idKWVL6N3dpB0kWX+BWQGX8
         RSegyD2eIIjNgRB0mVQBBUVlqTX96iHjijjWyRIRIzxw2ZabS2iI49Li5hym201kL6fg
         OfnpjoG0KA72+nFFM88igZjhSAxQNmpDCI+HsGB1BKWn7sdeJddKyws9pEd0s+LC0rX8
         ZjjdOziEXzOYAT86M+ORMdFXir9TXCeab2kvuOv/SZB8xGSI/xY+4OXHtbnegcajM754
         OFFeMqlObxwfL3kyKDtwuRFCJKg0UmJfPTzKdhJxFNIqHkfduVIbRIybu/eMJ4pmjq5b
         LtCw==
X-Gm-Message-State: ACrzQf3vr28VqkK3suMoxaZH84oJJhmYlJPU8NCgT0vyLnNXp2l5Tc85
        jN5cnHVQK4fiO7DYa74zErsYMzlKUFXKGvVcr0AdTv+FLz7+jA==
X-Google-Smtp-Source: AMsMyM6xkQz9a/gQKoWalavcV/VMmLVHiTXvwYuHIgv3jfm/DBzxvgR9gq6NZaYBHO17UoOHWK1SA4j2k8/IhBKP3AQ=
X-Received: by 2002:a1f:b453:0:b0:3ab:2c49:57df with SMTP id
 d80-20020a1fb453000000b003ab2c4957dfmr8495848vkf.29.1666304353774; Thu, 20
 Oct 2022 15:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <1666289686-22798-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1666289686-22798-1-git-send-email-ssengar@linux.microsoft.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 20 Oct 2022 16:18:37 -0600
Message-ID: <CAOUHufbkcdyg8RAEa08DvKE=+bsxjuReiP4iscTV99sZ1oBQ2g@mail.gmail.com>
Subject: Re: [PATCH] mm/gup: fix gup_pud_range() for dax
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     ssengar@microsoft.com, akpm@linux-foundation.org, jack@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jostarks@microsoft.com, Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 12:14 PM Saurabh Sengar
<ssengar@linux.microsoft.com> wrote:
>
> From: John Starks <jostarks@microsoft.com>
>
> For dax pud, pud_huge() returns true on x86. So the function works as long
> as hugetlb is configured. However, dax doesn't depend on hugetlb.
> Commit 414fd080d125 ("mm/gup: fix gup_pmd_range() for dax") fixed
> devmap-backed huge PMDs, but missed devmap-backed huge PUDs. Fix this as
> well.
>
> Fixes: 414fd080d125 ("mm/gup: fix gup_pmd_range() for dax")
> Signed-off-by: John Starks <jostarks@microsoft.com>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  mm/gup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index 05068d3d2557..9e07aa54a4cd 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2687,7 +2687,7 @@ static int gup_pud_range(p4d_t *p4dp, p4d_t p4d, unsigned long addr, unsigned lo
>                 next = pud_addr_end(addr, end);
>                 if (unlikely(!pud_present(pud)))
>                         return 0;
> -               if (unlikely(pud_huge(pud))) {
> +               if (unlikely(pud_huge(pud) || pud_devmap(pud))) {

Perhaps s/pud_huge/pud_leaf/ ?

>                         if (!gup_huge_pud(pud, pudp, addr, next, flags,
>                                           pages, nr))
>                                 return 0;
> --
> 2.25.1
>
