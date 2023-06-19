Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F937351C1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjFSKPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjFSKPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:15:07 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBDBE51
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:15:04 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f81b83b8d5so102675e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687169702; x=1689761702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h6+4WUre3d5bVXKSjFFWZpGKa0679AOLoEWy8qr2V00=;
        b=2XPBs/hcyqpbJwohNBmCV7+YRJ5+24eq1+NRGRV0ouC9dQDeCiOirhWKrRYCMg8weO
         HCpm/6D1WA6dGvPxrGQpaiuZvjgAu7Uox2wZw5HbaPzD/bELuGDYp26bXEEFrnwxysZd
         axn8fcfsZCG88aN4QIUsLcYkpJX3FLFR2k5y1zfsbyRpjL9Z5GHEhQJKWRTKPe+NxVOv
         HggBIg1Pr0b1kcms1YzqwNCdkSut/V6x9sHKjxvPdXiZzvOqRFcVI9PsoYkiMZcq/U20
         rhE38oLIYLj3m/zoO26VTEYvc2K8k8CauJHofPsFjbjRy9Zt0LLJiuNV+yq96QRJFyd8
         +RQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687169702; x=1689761702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h6+4WUre3d5bVXKSjFFWZpGKa0679AOLoEWy8qr2V00=;
        b=QkRTEzECPeRgdZcP5znXSOuOTSFnw1Hn2qTD4d2qDASH11jpJxU1x2cwGsuXt6ysfb
         8vS7kLUwTUhFvDyvcI48f5I8MttSl+a6DBI5AOCaLT6b3wNe0yMKCn0UrFiTGNweEgwW
         TKfVJiNSlFlb8Q1ZFV3h1OMBUiDAuz7YV0gQU+0LD8loI4iyaB3hg1JFAMtlPrkqCD5i
         gYRUBEC3dWor6C1LXXgTCQQze/Ninwhash3BXsiA3WBIb1349ZdCLQX4G4X3gtGxbF3W
         +FprtK4MuJ9b8onkIZuhtVQJzlgUPuZr9cks76FsxQaOkkindC8tfGfFL7KBHc+0lP2a
         ssKA==
X-Gm-Message-State: AC+VfDwuPm5tapocTOn2Nzv/FYACJa1DqOGAPcN7iF1IXoQNf/HEZAi3
        1ak/yW3eqKR1ZJTBmWCjJ3XaLnceq6V4ZQKJjXxXVA==
X-Google-Smtp-Source: ACHHUZ7NjrNlAp0jQUMkRSh5vhYMpXSMJrGBNsK/wvbYmX8p+yqYKxvvQfZ7W5/tM4vY5I8oco2QlDLwVRkwNzV4maM=
X-Received: by 2002:a05:600c:691b:b0:3f7:3654:8d3 with SMTP id
 fo27-20020a05600c691b00b003f7365408d3mr141237wmb.2.1687169702435; Mon, 19 Jun
 2023 03:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230619101224.22978-1-chanho.min@lge.com>
In-Reply-To: <20230619101224.22978-1-chanho.min@lge.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 19 Jun 2023 12:14:49 +0200
Message-ID: <CACT4Y+Zn49-6R00buq-y_H0qs=4gBh6PBsJDFBptL8=h6GPQYA@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix mention for KASAN_HW_TAGS
To:     Chanho Min <chanho.min@lge.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        elver@google.com, kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, gunho.lee@lge.com
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

On Mon, 19 Jun 2023 at 12:12, Chanho Min <chanho.min@lge.com> wrote:
>
> This patch removes description of the KASAN_HW_TAGS's memory consumption.
> KASAN_HW_TAGS does not set 1/32nd shadow memory.

The hardware still allocates/uses shadow in MTE.
Though, it may be 1/16-th, not sure.

> Signed-off-by: Chanho Min <chanho.min@lge.com>
> ---
>  lib/Kconfig.kasan | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index fdca89c05745..5be1740234b9 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -124,8 +124,6 @@ config KASAN_HW_TAGS
>           Supported only on arm64 CPUs starting from ARMv8.5 and relies on
>           Memory Tagging Extension and Top Byte Ignore.
>
> -         Consumes about 1/32nd of available memory.
> -
>           May potentially introduce problems related to pointer casting and
>           comparison, as it embeds a tag into the top byte of each pointer.
>
> --
> 2.17.1
>
