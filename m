Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB8565F3F4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 19:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbjAESrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 13:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbjAESrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 13:47:18 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C345B14E
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 10:47:18 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 191-20020a6306c8000000b0049699771579so15089356pgg.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 10:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XZuxdDBhTxtm3sl01imrqslWnx2DLyZq2pIBjdBkdtU=;
        b=nY1jnv1a32uBxDuO5+tT8LwT5b7tNeasNcDHqg25ZhhkWQ8KBl5tFYwf+6r4Nznw+h
         lWkcpWmx5MFR8d+EI05kIZMWbRY7bn6zJUDb7EieF6hCh39MVswYSoxbGCwXeDcwMW5u
         Ffv8qRwoxYu59pRGqDELmVYlWbiPzRORv5UiTPHlzdMXPXQhI/vNKxIHh7zzFOBg8jEw
         7GHDEdXlsJ+RylQfGe/oCNQzy5JBRdHpu0JX8PdHXEzSv0stkVYMRPkzBjv7Uhw9W0iN
         vKeBbZOe6t3+1Yu3AUNhY7XVIZmi4/pZfdm+JtclSKFOep8FmdbKqhrxD/LzYYJCia16
         Y5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZuxdDBhTxtm3sl01imrqslWnx2DLyZq2pIBjdBkdtU=;
        b=F8IerA98v6bGfwtOt8LJYnhASdKYMm/L5z5l4+UOUVcleOep98U7MS9bdLUC4z1KU9
         wfrlkvnPj81/KFo6llbFvLV4P5QT9xfRkvUPJMzHI4RRBK2fqasI0EnXFIOasXhACvG3
         F4dEDRUOWiI6gP9n58HYrRW/Nx9QwDhZ5+KL7wlcVonV1HVhREnfPDxS+KEkOSIO4dT4
         GkrTeN/jAWcQ2CNYFaV9N/X3EreFuse0lYBsC+9ohmtZzVbMJTzYsrHpfe5Fvcwl1N49
         LJC4NWe50WUbuSvMJKLMT8+9OOt2qU5w+fYyayPB54Kaeld1efqaQzjE7I9nP1x+dbML
         bPyA==
X-Gm-Message-State: AFqh2kq7MafjbeO0eILVPxPo3eMf4u1N3vQDDaMcG9nKlAaGjeZAS55Q
        mf1GIe1IngKQQ9w/5tYqoIY0L50=
X-Google-Smtp-Source: AMrXdXuI6Xj0hFDOhwzWxjDGfk+OpJDiilxIIWG7/FCvwa/Jn7hcp4wZMn015IN0Xqo6W4q7FRLtJrY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:40c8:b0:189:7a15:134b with SMTP id
 t8-20020a17090340c800b001897a15134bmr2760642pld.143.1672944437584; Thu, 05
 Jan 2023 10:47:17 -0800 (PST)
Date:   Thu, 5 Jan 2023 10:47:15 -0800
In-Reply-To: <tencent_5695A257C4D16B4413036BA1DAACDECB0B07@qq.com>
Mime-Version: 1.0
References: <tencent_5695A257C4D16B4413036BA1DAACDECB0B07@qq.com>
Message-ID: <Y7cbM1D2YvB9tdqg@google.com>
Subject: Re: [PATCH bpf-next] libbpf: poison strlcpy()
From:   sdf@google.com
To:     Rong Tao <rtoax@foxmail.com>
Cc:     andrii@kernel.org, rongtao@cestc.cn,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "open list:BPF [LIBRARY] (libbpf)" <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>

> Since commit 9fc205b413b3("libbpf: Add sane strncpy alternative and use
> it internally") introduce libbpf_strlcpy(), thus add strlcpy() to a poison
> list to prevent accidental use of it.

> Signed-off-by: Rong Tao <rongtao@cestc.cn>

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>   tools/lib/bpf/libbpf_internal.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/tools/lib/bpf/libbpf_internal.h  
> b/tools/lib/bpf/libbpf_internal.h
> index 377642ff51fc..2d26ded383ca 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -20,8 +20,8 @@
>   /* make sure libbpf doesn't use kernel-only integer typedefs */
>   #pragma GCC poison u8 u16 u32 u64 s8 s16 s32 s64

> -/* prevent accidental re-addition of reallocarray() */
> -#pragma GCC poison reallocarray
> +/* prevent accidental re-addition of reallocarray()/strlcpy() */
> +#pragma GCC poison reallocarray strlcpy

>   #include "libbpf.h"
>   #include "btf.h"
> --
> 2.39.0

