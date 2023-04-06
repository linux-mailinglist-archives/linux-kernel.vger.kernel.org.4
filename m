Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC336DA606
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 00:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239373AbjDFW56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 18:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjDFW54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 18:57:56 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2D959D8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 15:57:55 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j14-20020a17090a7e8e00b002448c0a8813so2629989pjl.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 15:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680821875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXgNfES2xPmLIzA9XQu7yHUn8Ass15lCW/P1iL99/uE=;
        b=HR7UuBf4gWbhbVlkBYitBViCVWlQ/s3oikpp4qMOZGC23Wn7C+/HAg9G3DJaHwPKjI
         /4kFwj7mU8d768xogqeRJbJXcsUQ7YOFigy3I3fttmqsZdBwQy5P68Ti18yaKUjvNx8E
         ob9nwpa2t3NZCxfEdG89sJjAPcVWust+QqYLfTetUNrgsSuZzuGeR6ylQQKpy5hwLbMx
         YCvjNrTV5e4AeS5RG4HlfE8fh78Tz32Dy6s+gbvkufNeO+GORoX7obpDKuap4MLo9ael
         R+A+INy2D5jQTW85sR97Sd5j8GPJX6pdhXUYVbLyPPn91497VoWvQ55Vqt3Ox+HsPl8Y
         l8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680821875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXgNfES2xPmLIzA9XQu7yHUn8Ass15lCW/P1iL99/uE=;
        b=bpybsfauoOZKg+09vkvLsgG/CMX3D4Qhll54avDZAbECg4hQuz4fEsx2cHDhk3qyaW
         r+xuBF4bW14CDjks+yQtkDlBeBp0kDR2YVHyo9Cfj5di3uKks868DaTyahfZlVaN124y
         ZJxmhkkXlCrL8VhGwv/HfM0IZmiuqK/OQzB60vjEQmPY33nsx+WbC2cf4qdii/OH9mnW
         RLIK6hkUtu40H5PIPCWc42I8HpbFyUWzLYb4cV1nOWVQdyg94mxAuvbu/XGqAtQMkLZS
         +PitoBlaN/zpdEaEuDxAgQguu4/aXQrTQqucuCfO1Mx+oHCRbHOiLmK8h7saIjM8GFDh
         tBxA==
X-Gm-Message-State: AAQBX9c6tJtkxC4M4sbutK2Nacg7gQ/oihFHgfpV8QR+c3C1jJOtXSDS
        cOsizoWthaijOEbGGwe3z+7k2vpxyYYO6Hm50XvFJdjQ
X-Google-Smtp-Source: AKy350Yh8xcHrviJawO8dzK8guWnatfjmYEClFJYOUxp53fgYbHjXiICm9F7JoMQh0LwehWyiEjx8T3vVLTGlkq9LzY=
X-Received: by 2002:a17:903:2449:b0:1a0:1f4e:a890 with SMTP id
 l9-20020a170903244900b001a01f4ea890mr266381pls.1.1680821875058; Thu, 06 Apr
 2023 15:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230406082004.2185420-1-naoya.horiguchi@linux.dev>
In-Reply-To: <20230406082004.2185420-1-naoya.horiguchi@linux.dev>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 6 Apr 2023 15:57:43 -0700
Message-ID: <CAHbLzkrMu2SsmbWP+1WDd7f6Mu8U-rmMA1_Gah9BJmGUUXYTMQ@mail.gmail.com>
Subject: Re: [PATCH v1] mm/huge_memory.c: warn with pr_warn_ratelimited
 instead of VM_WARN_ON_ONCE_FOLIO
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Xu Yu <xuyu@linux.alibaba.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 6, 2023 at 1:20=E2=80=AFAM Naoya Horiguchi
<naoya.horiguchi@linux.dev> wrote:
>
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
>
> split_huge_page_to_list() WARNs when called for huge zero pages, which
> sounds to me too harsh because it does not imply a kernel bug, but just
> notifies the event to admins.  On the other hand, this is considered
> as critical by syzkaller and makes its testing less efficient, which
> seems to me harmful.
>
> So replace the VM_WARN_ON_ONCE_FOLIO with pr_warn_ratelimited.

Makes sense to me. Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> Fixes: 478d134e9506 ("mm/huge_memory: do not overkill when splitting huge=
_zero_page")
> Reported-by: syzbot+07a218429c8d19b1fb25@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/lkml/000000000000a6f34a05e6efcd01@google.co=
m/
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Cc: stable@vger.kernel.org
> ---
>  mm/huge_memory.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 81a5689806af..06bcdd6f5060 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2649,9 +2649,10 @@ int split_huge_page_to_list(struct page *page, str=
uct list_head *list)
>         VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>
>         is_hzp =3D is_huge_zero_page(&folio->page);
> -       VM_WARN_ON_ONCE_FOLIO(is_hzp, folio);
> -       if (is_hzp)
> +       if (is_hzp) {
> +               pr_warn_ratelimited("Called split_huge_page for huge zero=
 page\n");
>                 return -EBUSY;
> +       }
>
>         if (folio_test_writeback(folio))
>                 return -EBUSY;
> --
> 2.25.1
>
