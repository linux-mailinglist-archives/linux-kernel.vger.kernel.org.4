Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D3667FB62
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 23:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbjA1Whu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 17:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjA1Whs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 17:37:48 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0651B0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 14:37:47 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id nn18-20020a17090b38d200b0022bfb584987so7939963pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 14:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g2fjqw/303bMNNUpoe3r4ayfN5p/kfqZGtLtAxKocJg=;
        b=gDrOrkXXN2+eZmzKxPlMyAE8toJamlTbn80o+fcvUjZ7VO1vm0sKjq19c1S+BkdkdX
         YpgziqRqC4MRufwEoEaUI7YMs10JaBQcKikCH/u1puk5BHeHFPu10Q9r1hnnAnlJTqtw
         W3nxPcuB2Xnj9vjSVt4nQhGUaFh35+1D9d9zZCr/T0Dmv7FzNbgXstcX959NB7q5lUoV
         fpTDRjZprkBWXam5MdsaRqGICXHN6LzYJKvetKNY2N2uyxVFpNiqmj936HyDVXV2MG66
         3vFIaWphhASTtmRFbVglFSfeaewYMCVxWAvbhzDUER8akBfzVaKyAThACtMtBldxr4S4
         gVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g2fjqw/303bMNNUpoe3r4ayfN5p/kfqZGtLtAxKocJg=;
        b=E3ruMXy0WbwsRTN4uBAy9++fqNFYaAmLwGbssVynYxWG1kwZoX+KKb2jxthyccjXmK
         KegX1feLyWtu4DCcNKZIuKKRNc4Wh5I1XMJTX2t/K0AD5ZuMZzV6ubuaTFXTV3shKz3z
         InL8U7cOJhmcKVu/wSE2dVG08g1jJJR5NfLyNtX9ymO9OzXfX/RxPlmdVj21oQGqbjcp
         6Zbk0oUz0OYQJThP4Y1sYLI+Cwfn0YvO3VBOx/6CP5zSLGNdyu8L1MJ9MJ5O4odEg7TA
         zj/AbfhhvIDhyigf8lvUcv1rcQ+y71TcT3gh25CK0+7lHpKpFb2/S760X+LPzZLcweoO
         tKJw==
X-Gm-Message-State: AFqh2krXV1L7yKrpQywoE0+Vitr0qTU5EMme495mCfAVuYTEWQbc4Ic1
        471iyFSH4CfP3xtLgNp3KVsyPvGQddXL98j1WZc=
X-Google-Smtp-Source: AMrXdXtbqhrkWuN3kvH3D0ysENqY7fYj+QQkOyLGPF9AvkSWJ0b3ZzL39F+bOKy1vdH+iKUE/aeoGMcYaqisLQQ+STw=
X-Received: by 2002:a17:902:aa4b:b0:194:b3c6:18ee with SMTP id
 c11-20020a170902aa4b00b00194b3c618eemr4707438plr.29.1674945466747; Sat, 28
 Jan 2023 14:37:46 -0800 (PST)
MIME-Version: 1.0
References: <20230128150025.14491-1-Kuan-Ying.Lee@mediatek.com>
In-Reply-To: <20230128150025.14491-1-Kuan-Ying.Lee@mediatek.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sat, 28 Jan 2023 23:37:35 +0100
Message-ID: <CA+fCnZdSvTR=Ug3P9ZVxq9AG9Dh+TqLxDMRVOhvE8Sr1a2Oq4w@mail.gmail.com>
Subject: Re: [PATCH v3] kasan: infer allocation size by scanning metadata
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        chinwen.chang@mediatek.com, qun-wei.lin@mediatek.com,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/On Sat, Jan 28, 2023 at 4:00 PM Kuan-Ying Lee
<Kuan-Ying.Lee@mediatek.com> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>

Ah, I think you need to reset the commit author before sending, so
that the patch gets recorded as authored by you.

> Make KASAN scan metadata to infer the requested allocation size instead of
> printing cache->object_size.
>
> This patch fixes confusing slab-out-of-bounds reports as reported in:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=216457
>
> As an example of the confusing behavior, the report below hints that the
> allocation size was 192, while the kernel actually called kmalloc(184):
>
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in _find_next_bit+0x143/0x160 lib/find_bit.c:109
> Read of size 8 at addr ffff8880175766b8 by task kworker/1:1/26
> ...
> The buggy address belongs to the object at ffff888017576600
>  which belongs to the cache kmalloc-192 of size 192
> The buggy address is located 184 bytes inside of
>  192-byte region [ffff888017576600, ffff8880175766c0)
> ...
> Memory state around the buggy address:
>  ffff888017576580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>  ffff888017576600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffff888017576680: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
>                                         ^
>  ffff888017576700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff888017576780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
>
> With this patch, the report shows:
>
> ==================================================================
> ...
> The buggy address belongs to the object at ffff888017576600
>  which belongs to the cache kmalloc-192 of size 192
> The buggy address is located 0 bytes to the right of
>  allocated 184-byte region [ffff888017576600, ffff8880175766b8)
> ...
> ==================================================================
>
> Also report slab use-after-free bugs as "slab-use-after-free" and print
> "freed" instead of "allocated" in the report when describing the accessed
> memory region.
>
> Also improve the metadata-related comment in kasan_find_first_bad_addr
> and use addr_has_metadata across KASAN code instead of open-coding
> KASAN_SHADOW_START checks.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216457
> Co-developed-by: Andrey Konovalov <andreyknvl@gmail.com>
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>

Or change the Co-developed-by/Signed-off-by tags.

I don't mind either approach.

Thanks!
