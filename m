Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C468667B8FC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 19:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbjAYSGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 13:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjAYSGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:06:46 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A7E126D5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:06:45 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id d10so13914685pgm.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RJhg8HWY73+ZEkyEoyDbcVYjsCE09nGUo617LE3EVXg=;
        b=pLxzQmAIUAIMWobm0n233MwU1wQhVJ0QKnw0EMMtm2Gy1sP91XLN8d7CoIdTSUGMQ0
         W/4G/8ivodKwA0d+WibgVa60QJqla1fBdnd/IjUC053U4WvIbfjmyiyoAx5syWdUsnBI
         Gawr56t96YP2CrZPSMAdIr1a2KfWXxkB4yEuc1T36omSNI/80n9GGQL6Lh8+S0J9jkPJ
         Xs9y2J/YdGQRLGxdJwt0/vJYEp3veWkOCP4xuNUPTaIQpSMaXfHO6nnCjvbbYQU5PJ/5
         1V7ZJhXzBvIZEiZchFW1oRk+3z8eSHx8IGUi1zJG8WMkqidBf3ncW72iCstVAFQEcykm
         mmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJhg8HWY73+ZEkyEoyDbcVYjsCE09nGUo617LE3EVXg=;
        b=GUtvyxBKH+un+3Y+PSSSH77h0AMQ2PHXZDsmp+/EOALHpKf2ELzXpAn1D2SYbMLmZG
         BeiunAk4+vqRSH/j241rIniBUXuMq2pQOWWB7tOl6QZs/wSGOeVhHyQgMxkVlVGqJXmM
         qjVTMN3B15Z27/F5x2UA9aY+Mydr3e6t2dSe8Wrd+9QgTwY5s1lJmKGa2X5zJtCZrieJ
         c3V51BfbYFFlMC/Ah0GVgZygVF+XDqVqRkqVkzZ1+J9daoQjpPoiJkde+LDcHrvfJELr
         WX7Vf34vRozPR+J3vjmm1eTTOJgTeOXvEToM6B05SEPCgP9Z5ZqtslqsF+UxnxUPFlCH
         TJaA==
X-Gm-Message-State: AO0yUKWuVa1GcoUN+SW74zqZLOBC/6gVUGwQgbmNpXGlmCcwpKBhzgNA
        jHlFXBzr9P7+vh2c634GryMH1zsvYJxa8+iQlwe5H3oQ
X-Google-Smtp-Source: AK7set8eyCwuwnpxHr9Cb5IrHAhzqgGXMkGPE2szqGUbIaxgkfmlbNTfJaxIJMYCjD35g51ztYgjh9Ar2jl4XnUdzOE=
X-Received: by 2002:aa7:9987:0:b0:590:7611:1c4a with SMTP id
 k7-20020aa79987000000b0059076111c4amr166067pfh.63.1674670004787; Wed, 25 Jan
 2023 10:06:44 -0800 (PST)
MIME-Version: 1.0
References: <20230125015738.912924-1-zokeefe@google.com>
In-Reply-To: <20230125015738.912924-1-zokeefe@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 25 Jan 2023 10:06:33 -0800
Message-ID: <CAHbLzkoF+gbgopWBSP0Xe0+g-DLF_n-NQ_7gvg+0EEGpv8Q7Tw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/MADV_COLLAPSE: set EAGAIN on unexpected page refcount
To:     "Zach O'Keefe" <zokeefe@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 5:58 PM Zach O'Keefe <zokeefe@google.com> wrote:
>
> During collapse, in a few places we check to see if a given small page
> has any unaccounted references.  If the refcount on the page doesn't
> match our expectations, it must be there is an unknown user concurrently
> interested in the page, and so it's not safe to move the contents
> elsewhere. However, the unaccounted pins are likely an ephemeral state.
>
> In such a situation, make MADV_COLLAPSE set EAGAIN errno, indicating that
> collapse may succeed on retry.

The page may be DMA pinned (for example, pin_user_pages()), it is not
worth retrying for such pages. But it may also not be worth optimizing
for this case at this point.

So the patch looks good to me. Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> Fixes: 7d8faaf15545 ("mm/madvise: introduce MADV_COLLAPSE sync hugepage collapse")
> Reported-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Zach O'Keefe <zokeefe@google.com>
>
> ---
>  mm/khugepaged.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index e23619bfecc4..fa38cae240b9 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2712,6 +2712,7 @@ static int madvise_collapse_errno(enum scan_result r)
>         case SCAN_CGROUP_CHARGE_FAIL:
>                 return -EBUSY;
>         /* Resource temporary unavailable - trying again might succeed */
> +       case SCAN_PAGE_COUNT:
>         case SCAN_PAGE_LOCK:
>         case SCAN_PAGE_LRU:
>         case SCAN_DEL_PAGE_LRU:
> --
> 2.39.1.405.gd4c25cc71f-goog
>
