Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB815712C08
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242838AbjEZRrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237296AbjEZRrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:47:16 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DC2A4;
        Fri, 26 May 2023 10:47:15 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-bad142be0ebso1238788276.3;
        Fri, 26 May 2023 10:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685123234; x=1687715234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6CgerKgLDb+oz0xSGVFgair4y7BOc3TVieOSwAdfKBY=;
        b=jzReXWnsrfCVm/qRO2GA0IRNZFsfmNELIqi6GYheR6lx3tlEdWHPfk8rmaPzVoDauF
         6gAndj9bJiGl6Mziv5QWOqfJghfXRHGzxqfepSG2vaL5L5UXRmos/wwf2VU5mpiUfmzq
         ysOU+bRjvnxfYcT1EgyNIQIme/exlG++FdbpJ7U+BkDnbPQmCo6PG3XSm+KichSQx4B1
         YT0SImUYx9XJws5H8j6YK3WsNRMN58YZK3XYChGgR7j/AzYpLFMbYh3JAA846iLtH9kc
         LFCrRE0J7HSbAQCfS4TbhmPDZnPfmJzn5RewGV/2WqVxzhAZclyON5u2TcfiZttRkq2/
         tgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685123234; x=1687715234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6CgerKgLDb+oz0xSGVFgair4y7BOc3TVieOSwAdfKBY=;
        b=YRJKFGL7HUm3mdBuZuaMS1lJb5PBk0bqSnjZKM93i0qjUZbBIEC6GSEoknAGDK4hPP
         NJBLoTwzC78NaWx23/Y75vj6BMUQh18RQvHDDCOamK5Gr9LIBNnGp7SXYSQGac09wTUj
         CKOMPJevYb6KBCuY8LOl3Y2JCU8hCvQwPrU3C2c+MdScJMIQ0Lgen+Da5Iy2ZtR2RlVo
         E6OXo2SMUSGSipgejn27/dQ9BlODPnEhS4vOCAUvwX9QO3d/iTJzYKDO1rKWYfMFhOMg
         su7SOPfmy9v6U5HJxuIsYk5G8LRZVFrsaa09UjrZv3oURafR6Or//a1o0IRSUAaqV9r3
         CpWg==
X-Gm-Message-State: AC+VfDwVb1LeS1YKeNoL3ZnJVlOCamOTjoOHRRO1UOqjGy6xoPYXC6P+
        gHOmAtdf7/T4jcsXh0yQkUhJwXGYcUBPVyUffbI=
X-Google-Smtp-Source: ACHHUZ4zZdQ1OyE283XyEGqpTqmrswifJPDYZ7nrTVJ9mPxQUh0rJPLTrj29G3HM3uhWCePyDZnMZuCQnfenstG2dk8=
X-Received: by 2002:a0d:e805:0:b0:555:d983:f4f0 with SMTP id
 r5-20020a0de805000000b00555d983f4f0mr2753497ywe.24.1685123234701; Fri, 26 May
 2023 10:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230517190841.gonna.796-kees@kernel.org> <168512138720.187005.8346289423859319616.b4-ty@chromium.org>
In-Reply-To: <168512138720.187005.8346289423859319616.b4-ty@chromium.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 26 May 2023 19:47:03 +0200
Message-ID: <CANiq72=38mdTnJ3cicgwPB2xWqtbnGsL8Rtr4pwq7xGRr-m=Wg@mail.gmail.com>
Subject: Re: [PATCH v2] Compiler Attributes: Add __counted_by macro
To:     Kees Cook <keescook@chromium.org>
Cc:     ojeda@kernel.org, qing.zhao@oracle.com, morbo@google.com,
        llvm@lists.linux.dev, trix@redhat.com,
        linux-kernel@vger.kernel.org, nathan@kernel.org,
        linux-hardening@vger.kernel.org, gustavoars@kernel.org,
        ndesaulniers@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 7:16=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> FYI, applied to for-next/hardening:
>
> [1/1] Compiler Attributes: Add __counted_by macro
>       https://git.kernel.org/kees/c/86a76e91cbab

Sorry, I was going to apply it soon -- in case you want it:

    Acked-by: Miguel Ojeda <ojeda@kernel.org>

And thanks Nathan for resubmitting the `Reviewed-by` from v1!

Cheers,
Miguel
