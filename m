Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E0364DEC8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiLOQjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLOQjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:39:22 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1269A1B794
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 08:39:21 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id b16so4258228yba.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 08:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ReHOnZb4ThrmNXkDfGJFFUAl9tq1r2FhymWmrkBvIJs=;
        b=L8PwH57Kb+Z342tvtmtxtM7bgTOCUr6+BiE2AObo4OWPDKovqhRZ8JANBa9oYEZt4e
         CYdBloHOgr/TDS0acjD2O5q8fJt3Fc2ArOBzmMgkUPi6YWcol+hW8HzonlhZ+JzR7PfD
         epW1DmPSnBmOmDm1jrX/uIoS1jZ1Xusyktq8J5uZwDh43Vaf0TXN7uIPturdp48UI9iN
         ByDCw01D70KpDPcQ1FpSKLVeqzRurQpvM7CxrxW1uu9YTiNeUownymwDvbkZkOGE27EO
         fIiPim9i2SN3bmeQ+ljZBS2zGC9xWBJHL8r4VL1WsFhzU3dNx3Gdvh06IYx/Ju4tRhoE
         XILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ReHOnZb4ThrmNXkDfGJFFUAl9tq1r2FhymWmrkBvIJs=;
        b=YizBx4mfd4eNYlsl6x+pcZW3f/4xc7wGyZOL7IlWbHK4e7ZNn/w/Ozg4MhuGC1oQZi
         31NH97LVME/Jolm7iW6vbZ57etMnyclDpTn6K2A5IAHS1qLf6Gl07ltJkcGtyNQsppb/
         UEQGKPaEbvkrLz7Ptiq7XN1rrA4CJpgblPWk3YO6N36TWEgKk1501LWVxDNdzERu1zPN
         3O8DA0hYcRcCzsNfpHRvoaECSHrkr1gwThAlmxkkyu4W6o3DC5bPilrnbJr8ZDQP3HQF
         +/pOJLZGKTkoujQnWZsy+wmyc39boXwU7+AwdV+0YzaPzt41wOkLn8aivM8S6uX9cpkd
         Flow==
X-Gm-Message-State: ANoB5pnAseDkHIEQ2jAjtv9mIiopKso9oYlp1eQcyncbJ6m5l+izaI5O
        0MFXeP+KjcFiYgDqxlRHn0EfV2oRcBwViJQpUj7JEw==
X-Google-Smtp-Source: AA0mqf4QZSLqhfniTv7CeQAMuG6fxzwZ76PMfbp82+YiUNcmOGjqQXFAlDebLrdW8i5ptaKBUbG/Tc2UqPdGTsJDE9A=
X-Received: by 2002:a25:d9d5:0:b0:6fd:ef90:2ae5 with SMTP id
 q204-20020a25d9d5000000b006fdef902ae5mr25586080ybg.376.1671122360068; Thu, 15
 Dec 2022 08:39:20 -0800 (PST)
MIME-Version: 1.0
References: <20221215162710.3802378-1-arnd@kernel.org>
In-Reply-To: <20221215162710.3802378-1-arnd@kernel.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 15 Dec 2022 17:38:43 +0100
Message-ID: <CAG_fn=UcY0qE8OXRui1-du3TnMA06TZh0ANpDj9pqoUT4aqknQ@mail.gmail.com>
Subject: Re: [PATCH] kmsan: export kmsan_handle_urb
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Dec 15, 2022 at 5:27 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> USB support can be in a loadable module, and this causes a link
> failure with KMSAN:
>
> ERROR: modpost: "kmsan_handle_urb" [drivers/usb/core/usbcore.ko] undefine=
d!
>
> Export the symbol so it can be used by this module.
>
> Fixes: 553a80188a5d ("kmsan: handle memory sent to/from USB")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
>  mm/kmsan/hooks.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
> index 35f6b6e6a908..3807502766a3 100644
> --- a/mm/kmsan/hooks.c
> +++ b/mm/kmsan/hooks.c
> @@ -260,6 +260,7 @@ void kmsan_handle_urb(const struct urb *urb, bool is_=
out)
>                                                urb->transfer_buffer_lengt=
h,
>                                                /*checked*/ false);
>  }
> +EXPORT_SYMBOL_GPL(kmsan_handle_urb);
>
>  static void kmsan_handle_dma_page(const void *addr, size_t size,
>                                   enum dma_data_direction dir)
> --
> 2.35.1
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
