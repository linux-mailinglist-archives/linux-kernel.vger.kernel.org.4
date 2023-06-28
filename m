Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499AF7418CD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 21:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjF1TUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 15:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjF1TUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 15:20:03 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28D61FE8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 12:20:02 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f76a0a19d4so8901639e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 12:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1687980000; x=1690572000;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JyArVu4aB7TFdxCwRbf3XY40ntQA2MhFquVGiFkdvFo=;
        b=a/W8iJjlmmvCPEWuMe4BXKXFW/WMIAL9YlxN1j6FV80yakPKRKd4ztPijjeZesNjLb
         4SvO6nKPpHgHfx3087+APgp4brmIDPfDzlsx8HoWvaQOdFieUMRLxmKRKN2diFS2qvhU
         TI+48hX6WvnnwSpaHcAte1l6bqnvJYF1HXl6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687980000; x=1690572000;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JyArVu4aB7TFdxCwRbf3XY40ntQA2MhFquVGiFkdvFo=;
        b=XV6l6AVfVNOu5zZw/5M5prbG76/qQjdE3g9ehOewcQ3nWZNIp6hFllwK/xd7OUv36O
         EodL21dZQxcABsT7yqqWV+c0LI7iQ4fUNJSgoeF81gS08EML52XvdSrZSVyW5GKW9Sew
         QKeWy5XzZUFQznvu0ADjlYooDAszoGr7E8uTBd/6BVbKd9XX3USNnjDWKHJEthjFOZOf
         aTCwur3zlMcToFC9/yv9oyrGS63bzzq8WIrnbwz1vMksV+UjOUokbf/tzGgK8/7WVQLN
         P8E7/1MPS1R9PRAYz9nZt1wFIm87PEV+ilwpi0z8qMLE3FN0mtdhbnuV7xiy7XMfJSmc
         hnAQ==
X-Gm-Message-State: AC+VfDyVLUqsCFQzm8+AzbDhBMApI3kzYRZWbeM5u4wm+nH3hDEGGG1t
        5+ZJ842yOAhpOcq5XunHs8yA0gbxdBexx/6W2fQ8itNA
X-Google-Smtp-Source: ACHHUZ59uG1U7gBRD09BCsvTDzc1F8iCl5UQ3qJyYSVbsHBPPgoWe6g9gJZ6BKpQ7VMUCU5QGs6I2Q==
X-Received: by 2002:a05:6512:401e:b0:4f9:a232:f09c with SMTP id br30-20020a056512401e00b004f9a232f09cmr9113043lfb.63.1687980000462;
        Wed, 28 Jun 2023 12:20:00 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id z17-20020ac24191000000b004f846cd74bcsm326071lfh.245.2023.06.28.12.19.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 12:19:59 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4f76a0a19d4so8901590e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 12:19:59 -0700 (PDT)
X-Received: by 2002:a19:7b02:0:b0:4f8:83f:babe with SMTP id
 w2-20020a197b02000000b004f8083fbabemr20751801lfc.62.1687979999337; Wed, 28
 Jun 2023 12:19:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230626085035.e66992e96b4c6d37dad54bd9@linux-foundation.org>
In-Reply-To: <20230626085035.e66992e96b4c6d37dad54bd9@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 28 Jun 2023 12:19:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=whppqqPdjVOx0mONDFx+JjewZPacionbWCUUFdrfOon-g@mail.gmail.com>
Message-ID: <CAHk-=whppqqPdjVOx0mONDFx+JjewZPacionbWCUUFdrfOon-g@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.5-rc1
To:     Andrew Morton <akpm@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2023 at 08:50, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> Linus, please merge the MM updates for the 6.5-rc cycle.

Hmm. I have merged this, as pr-tracker-bot already noticed, but I
found a bug after merging it.

mm/memory.c: __access_remote_vm() is entirely broken for the
HAVE_IOREMAP_PROT case (ie all normal architectures), because it does
(skipping the non-HAVE_IOREMAP_PROT case):

        struct vm_area_struct *vma = NULL;
        struct page *page = get_user_page_vma_remote(mm, addr,
                                                     gup_flags, &vma);

        if (IS_ERR_OR_NULL(page)) {
                [ ... ]
                if (!vma)
                        break;
                if (vma->vm_ops && vma->vm_ops->access)
                        res = vma->vm_ops->access(vma, addr, buf, ...

but get_user_page_vma_remote() doesn't even set vma if it fails!

So that "if (!vma)" case will always trigger, and the whole ->access()
thing is never done.

So that __access_remote_vm() conversion in commit ca5e863233e8
("mm/gup: remove vmas parameter from get_user_pages_remote()") is
entirely broken.

Now, I don't disagree with removing the vmas parameter. I just
disagree with the get_user_page_vma_remote() helper use here.

I think the minimal fix is to just put the vma_lookup() back in the error case:

    --- a/mm/memory.c
    +++ b/mm/memory.c
    @@ -5592,6 +5592,7 @@ int __access_remote_vm(struct mm_struct *mm,
                 * Check if this is a VM_IO | VM_PFNMAP VMA, which
                 * we can access using slightly different code.
                 */
    +           vma = vma_lookup(mm, addr);
                if (!vma)
                        break;
                if (vma->vm_ops && vma->vm_ops->access)

and I'll commit that fix for now. Anybody who disagrees, please holler.

                 Linus
