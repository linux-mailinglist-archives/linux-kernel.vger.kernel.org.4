Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609C85B5C20
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiILOVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiILOVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:21:46 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1582F590
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:21:45 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id t184so13036116yba.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=lJ9faA7e8zJIwcDlhdQh8adJq8hVZtHCvAVg3S21zOk=;
        b=GMffjmBINzXW4wKiEt9sAB0fRO0xnMraNQV1JWwmez047uFqfA1mkyrmp25vIHAyw4
         8SPTW6iBqa+SCf5NyBp7QAUeW9WMCv6C9dBnxnBKzL0YZ5mW21C+IUJAzjQdY+34TLRN
         bwxEMAHenjwdoovJzR8AnGcTNUCkxxnlpZ2lxzeF6Mmi4VTNFah/XRi39po+vk01eUC9
         hP4cqRaDgK5rXuoJOwB8HmQMQneUC3O8Lxrb6mdy4OCovWyEMrvOqQyCAnFgviJ9riju
         9my4BZpc2i4JKwyCh2km94KQZ6VG2RLxyuoycJuRwgViisM8QjGNgLP8BTaI4JxAbomT
         tDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lJ9faA7e8zJIwcDlhdQh8adJq8hVZtHCvAVg3S21zOk=;
        b=Cdr+jSZO1VStDmuDFWi35mZQE6l3X99hXxID1SKc1wXdOswpgrFFOff6Tk9tfJS68y
         uHLLnOJSSHmqEICHad2J6gO2pSCmZ0mdUSQVLHxg+xOgDlRaFu46UyadvpaOhCLaiCo/
         EQ7JT7m0mKmNa2GaaevgJt+rTr7lD6eCnR8uhXl6fmYKZV5jZnjh7aTLXkTZFb+zRyDk
         MWuqhoqh8A8RlW7FidOVA3K1YRRc4mts7xseIIOkHOO0HnX+WM8V/M5tHo2lOwaiqwZU
         kxMQstwkLc8NhlleUb8CpGp5u9P1ThqgXV3XOQMT9Z+eS0Nct4cdMkDgknsX21gHJUwJ
         RmsQ==
X-Gm-Message-State: ACgBeo1cdh0xXRU+iHScjkn/ncnKyYU2K+MX2lJ6qoip91OSwh9qWWt6
        GduqmwvfhlE0VX9+0FDq/08an3M4APOc5UkdeEAEWw==
X-Google-Smtp-Source: AA6agR5NA4wc1j6Ej5esHmZ2f6KA36eCWZgWzp7qp5vkridF/7amLEACIsBscIlhpDFCKa4NdZ3TlCSVCw9MxieW4KE=
X-Received: by 2002:a25:3b04:0:b0:695:dc29:c206 with SMTP id
 i4-20020a253b04000000b00695dc29c206mr21802092yba.523.1662992504813; Mon, 12
 Sep 2022 07:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220912053755.156704-1-senozhatsky@chromium.org>
In-Reply-To: <20220912053755.156704-1-senozhatsky@chromium.org>
From:   Brian Geffon <bgeffon@google.com>
Date:   Mon, 12 Sep 2022 10:20:49 -0400
Message-ID: <CADyq12yWFMyTRCQmmGoLg7epvXRWu-XqKMS4N2vEomvvuWNpBA@mail.gmail.com>
Subject: Re: [PATCH] zram: do not waste zram_table_entry flags bits
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Sep 12, 2022 at 1:38 AM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> zram_table_entry::flags stores object size in the lower bits and
> zram pageflags in the upper bits. However, for some reason, we
> use 24 lower bits, while maximum zram object size is PAGE_SIZE,
> which requires PAGE_SHIFT bits (up to 16 on arm64). This wastes
> 24 - PAGE_SHIFT bits that we can use for additional zram pageflags
> instead.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/block/zram/zram_drv.h | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
> index b4eecef2a11f..138be8326866 100644
> --- a/drivers/block/zram/zram_drv.h
> +++ b/drivers/block/zram/zram_drv.h
> @@ -30,16 +30,13 @@
>
>
>  /*
> - * The lower ZRAM_FLAG_SHIFT bits of table.flags is for
> - * object size (excluding header), the higher bits is for
> - * zram_pageflags.
> - *
> - * zram is mainly used for memory efficiency so we want to keep memory
> - * footprint small so we can squeeze size and flags into a field.
> + * ZRAM is mainly used for memory efficiency so we want to keep memory
> + * footprint small and thus squeeze size and flags into a flags member.
>   * The lower ZRAM_FLAG_SHIFT bits is for object size (excluding header),
> - * the higher bits is for zram_pageflags.
> + * which cannot be larger than PAGE_SIZE (requiring PAGE_SHIFT bits),
> + * the higher bits are for zram_pageflags.
>   */
> -#define ZRAM_FLAG_SHIFT 24
> +#define ZRAM_FLAG_SHIFT (PAGE_SHIFT + 1)

Why not just hard code 16 with an explanation that it cannot be
increased further using the analysis you did in the other thread? It's
going to be tricky to reason about how many free flag bits actually
remain with PAGE_SHIFT across all architectures, especially given we
have no architecture specific flags.

>
>  /* Flags for zram pages (table[page_no].flags) */
>  enum zram_pageflags {
> --
> 2.37.2.789.g6183377224-goog
>
