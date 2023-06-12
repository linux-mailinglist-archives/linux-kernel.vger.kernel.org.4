Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8937472D3F7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 00:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbjFLV7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbjFLV7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:59:40 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32CCE65
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:59:39 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-543d32eed7cso2128636a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686607179; x=1689199179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLgFlmrwGHFojofRCOBcCy0uqVKvL62eTYXx07rbD5s=;
        b=myc3EmpZMXXYpMTpTggL4Lnje9n7a/UxxmFD5LgWcQhVipEpkH7qFsXBEmfCeJX5vH
         uEASlz2XNaxfdybThNtmgP9FngfJaUajLWde2BJyt3c0XTjbAFAGOU8QokRL/R/TcNWh
         0XOtCE7eL9I1ohexZmXMyBSjoJPJdD61SxF5CGrpnSJl/Q2V0qV48evebb3n0P/TRL83
         vGOdacV8SUS7jj0q7fd0pu12VpVN5jxxFwfI4y8PLJN6QE4w5mFLCPwT6hMS9Q0YPIJi
         CPxhhVGdth3XWjgQ+z8mDT7/K8qClg7SC0rsyRBur9/eVH+dhzJ56HYXZSOjwlykasFP
         12YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686607179; x=1689199179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLgFlmrwGHFojofRCOBcCy0uqVKvL62eTYXx07rbD5s=;
        b=HqX3fJ8Rrt8T3BlZ8lW/thf+BWAvGsmNcjo2SnfDsKyzmOXC3K/x6BK/iCfAQ1u1J4
         hOEc55nUElFoI1fSEhriAiNaM/9HSa6YsH7WXI3rkYHSfwfl84e9Y0KmZcOQnto16zNF
         YpfRgzgiT32GHYbpM3vFj1T//tf1jzpXvJmZiwZ2OWN5UfbWPzLts/KE35nLMpwVbFte
         wXYFy5eeKCW+NqcoIHBGFVaaZFG4KsIt+Um8e4lmSjHkMtEVzmsmU5LT2dD+CbbTmt5n
         OXLhTG/b/ugn84OfYHYFIT1L3lYlkHvdVzq+ypXWws4jf6w0EXuC6x1QU2bINSiOU9FX
         CAfQ==
X-Gm-Message-State: AC+VfDz0OKYmObPIFlLwqucqiHhQajFPyhyEtMapwH9HPYyHcF7z/Wxl
        IDSXy7fiq8jFOWR+bDfd4aOu+WlFoq4Ll2L3u5E=
X-Google-Smtp-Source: ACHHUZ4hHouejIGEFo/58CX4x8uXkC6mOkfNn1V1t1hCCorbIfjuyAVwq3PNOZJrDl9CvwTcyWY5BWqwQTzRfAsY3lI=
X-Received: by 2002:a17:90b:ec7:b0:25b:ce40:7dd6 with SMTP id
 gz7-20020a17090b0ec700b0025bce407dd6mr4989957pjb.33.1686607179324; Mon, 12
 Jun 2023 14:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230609-khugepage-v1-1-dad4e8382298@google.com>
In-Reply-To: <20230609-khugepage-v1-1-dad4e8382298@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 12 Jun 2023 14:59:28 -0700
Message-ID: <CAHbLzkr4cf7XqsCR29_-qLysuELaaFvThJ3eoNd-nvkhVdKrYg@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: use DEFINE_READ_MOSTLY_HASHTABLE macro
To:     ndesaulniers@google.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 4:44=E2=80=AFPM <ndesaulniers@google.com> wrote:
>
> These are equivalent, but DEFINE_READ_MOSTLY_HASHTABLE exists to define
> a hashtable in the .data..read_mostly section.
>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/khugepaged.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 6b9d39d65b73..e7dc49214413 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -88,7 +88,7 @@ static unsigned int khugepaged_max_ptes_swap __read_mos=
tly;
>  static unsigned int khugepaged_max_ptes_shared __read_mostly;
>
>  #define MM_SLOTS_HASH_BITS 10
> -static __read_mostly DEFINE_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS)=
;
> +static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, MM_SLOTS_HASH_BITS);
>
>  static struct kmem_cache *mm_slot_cache __read_mostly;
>
>
> ---
> base-commit: 64569520920a3ca5d456ddd9f4f95fc6ea9b8b45
> change-id: 20230609-khugepage-09ea340b378e
>
> Best regards,
> --
> Nick Desaulniers <ndesaulniers@google.com>
>
>
