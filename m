Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E3D661ED7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 07:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbjAIGvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 01:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjAIGvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 01:51:20 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6208E12633
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 22:51:18 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b3so11530751lfv.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 22:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8fHjJ5mqa9cPGpS5KD+GC/eZ7abKkX/dkmk/DvDpfNA=;
        b=OyMUf+5B6frZZs4hQkljDvf/Xom1i0Hqd9XJHQkHyv7eihmEw1hjihNs3D99WNWYdr
         z9hevlf2PG4glj9VEoG+tDPk2ZYWsPeICavudYQWLYiTye6iTYirV+zuwBaHqWXWGeHQ
         ioBbj5QAhnOumJ6vGSvi90hV9Z9Ns8tD50zqOfwwZC2qgL+8cpoQ+sNQCW6bq+wJiCEu
         3+RHv073gwOCssDoZeVPmWmk2a4LhYJOSejGG1NRazdFDx6z6MoQuP1NFKSwnqPI93LM
         xHGIK/3IDfUZ2L6jP8bddwAIfVCkmPe458adq7vFG6hlA/WlyRNAzQzc1JIrIZJNMPsi
         KVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8fHjJ5mqa9cPGpS5KD+GC/eZ7abKkX/dkmk/DvDpfNA=;
        b=rz7IxW7Ia3jEswp2KNIncUL+rZ6RSVbERqIvcMCtCJfjPHZYlwjcdUwxI3VXy6Mgtb
         c6GTh4cmlMSTAguJmEfhqtO3vCER+OXGIkl9Q6LvYwA8XWzfJaerdJh8oiCkDL9efRuV
         hNnYbBc4PrTLx70ELotzpSfzfDWkXiad6Z7+9idksIwBVQ0m2Nwx7abhkL3O3jnpcePm
         xXDEe2SHelNTM9vyX6QNkcHSCSSt/pXWuOfV9Gxwio2WsM07saMZ1I99BYALEQz8nlbV
         Jz+TBfQEqi4z//42HtaEFRYfj95jc/nGVWzxg7GJSDi6bpSrrrhgrZ7Nw1YaJO753WPL
         14Fw==
X-Gm-Message-State: AFqh2krurPbWiB+uuZs/poXB2HsQRo80YTtrnjWr2YL83pCB2mxXbsxV
        0bsNsD37DfwnDNCKozLi/h0UP6+c4Z/fjjrwRJDqWQ==
X-Google-Smtp-Source: AMrXdXuVTKk1ETT5Fbh/qF7a1Xz+KlgI8zhmIxManlxld7viGQP54p+iATQQMAy1889O+cOC7C/yKyGSSxzC7jPT3r8=
X-Received: by 2002:a05:6512:12c4:b0:4a2:676e:cf60 with SMTP id
 p4-20020a05651212c400b004a2676ecf60mr2640163lfg.624.1673247076285; Sun, 08
 Jan 2023 22:51:16 -0800 (PST)
MIME-Version: 1.0
References: <20230103075603.12294-1-Kuan-Ying.Lee@mediatek.com>
In-Reply-To: <20230103075603.12294-1-Kuan-Ying.Lee@mediatek.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 9 Jan 2023 07:51:04 +0100
Message-ID: <CACT4Y+b5hbCod=Gj6oGxFrq5CaFPbz5T9A0nomzhWooiXQy5aA@mail.gmail.com>
Subject: Re: [PATCH] kasan: infer the requested size by scanning shadow memory
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        chinwen.chang@mediatek.com, qun-wei.lin@mediatek.com,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
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

On Tue, 3 Jan 2023 at 08:56, 'Kuan-Ying Lee' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> We scan the shadow memory to infer the requested size instead of
> printing cache->object_size directly.
>
> This patch will fix the confusing generic kasan report like below. [1]
> Report shows "cache kmalloc-192 of size 192", but user
> actually kmalloc(184).
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
> After this patch, report will show "cache kmalloc-192 of size 184".
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216457 [1]
>
> Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
> ---
>  mm/kasan/kasan.h          |  5 +++++
>  mm/kasan/report.c         |  3 ++-
>  mm/kasan/report_generic.c | 18 ++++++++++++++++++
>  3 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 32413f22aa82..7bb627d21580 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -340,8 +340,13 @@ static inline void kasan_print_address_stack_frame(const void *addr) { }
>
>  #ifdef CONFIG_KASAN_GENERIC
>  void kasan_print_aux_stacks(struct kmem_cache *cache, const void *object);
> +int kasan_get_alloc_size(void *object_addr, struct kmem_cache *cache);
>  #else
>  static inline void kasan_print_aux_stacks(struct kmem_cache *cache, const void *object) { }
> +static inline int kasan_get_alloc_size(void *object_addr, struct kmem_cache *cache)
> +{
> +       return cache->object_size;
> +}
>  #endif
>
>  bool kasan_report(unsigned long addr, size_t size,
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 1d02757e90a3..6de454bb2cad 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -236,12 +236,13 @@ static void describe_object_addr(const void *addr, struct kmem_cache *cache,
>  {
>         unsigned long access_addr = (unsigned long)addr;
>         unsigned long object_addr = (unsigned long)object;
> +       int real_size = kasan_get_alloc_size((void *)object_addr, cache);
>         const char *rel_type;
>         int rel_bytes;
>
>         pr_err("The buggy address belongs to the object at %px\n"
>                " which belongs to the cache %s of size %d\n",
> -               object, cache->name, cache->object_size);
> +               object, cache->name, real_size);
>
>         if (access_addr < object_addr) {
>                 rel_type = "to the left";
> diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
> index 043c94b04605..01b38e459352 100644
> --- a/mm/kasan/report_generic.c
> +++ b/mm/kasan/report_generic.c
> @@ -43,6 +43,24 @@ void *kasan_find_first_bad_addr(void *addr, size_t size)
>         return p;
>  }
>
> +int kasan_get_alloc_size(void *addr, struct kmem_cache *cache)
> +{
> +       int size = 0;
> +       u8 *shadow = (u8 *)kasan_mem_to_shadow(addr);
> +
> +       while (size < cache->object_size) {
> +               if (*shadow == 0)
> +                       size += KASAN_GRANULE_SIZE;
> +               else if (*shadow >= 1 && *shadow <= KASAN_GRANULE_SIZE - 1)
> +                       size += *shadow;
> +               else
> +                       return size;
> +               shadow++;

This only works for out-of-bounds reports, but I don't see any checks
for report type. Won't this break reporting for all other report
types?

I would also print the cache name anyway. Sometimes reports are
perplexing and/or this logic may return a wrong result for some
reason. The total object size may be useful to understand harder
cases.

> +       }
> +
> +       return cache->object_size;
> +}
> +
>  static const char *get_shadow_bug_type(struct kasan_report_info *info)
>  {
>         const char *bug_type = "unknown-crash";
