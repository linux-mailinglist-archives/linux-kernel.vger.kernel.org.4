Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452B273017D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245555AbjFNORB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245492AbjFNOQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:16:46 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC7A2684
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:16:40 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-39ca0c2970aso3964586b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686752199; x=1689344199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f57lCLd7OdJQ5Blvl8wGJZyK116HtB6qFU6rPcmeblM=;
        b=LSQwn5MG67BP/+AQZt17SggoC4gLE3roHuhaYzIcFAuElnPEdILAfPsBHCJZVvqwh3
         XvRbYvSPgP+OkIUVaDnUpKqNbzGqO7UEnZ/Kr5+tV5tqa2pTaS05sj/LlavK0voHdg5L
         8Os8TgtX0c/OJgEg8I+w52z/UYhCY8r2Hp+whkOCH8c6XaK2i0IbpHBi81/XP6F+X4sG
         JUpz4BtXIoS/6LIAgNdOHbcppVUNc6RsHlF5i9Uso1MdJmjvGUHgFlU6pu0zYdCWXSNi
         RZEj9fvIVkWRC1tPlpNMCmmvB3/LwDnfcZGu8MDSIb+arT+zuNVIfTNeRTCkm1/j3d3e
         TZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686752199; x=1689344199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f57lCLd7OdJQ5Blvl8wGJZyK116HtB6qFU6rPcmeblM=;
        b=YBIpz35wSxJ9mqCVHXht/c0WeaeDvCgnIleRSd7o3H7dhjpjjLTrA74YD9hlxg76NM
         YyNhQ2/KLQAEirxa0E0nvrMhr0yWcih3KMhLITvGCoI+UBQ2wMB//SuBn7dCBHgofvEi
         dLRjkXZpASsYU+X1xZJhS0WbTdmnEiLbCtcTXBd+Nzc4bP8NOXBoc9pgdMY6ftfdvk+7
         Pc80G9FMbl1jIYD7MwGcB/tKOY76KxIheJWZDuVb2Eki+2HQcTmESsDHBuDDYJHGXzis
         CQ3qz+Z7f4vswhr6JHF719kbPI3KMT85hlgHpWR2n0MdaTbWm3Ifm7q2DU38e2t8/k1L
         Hn6g==
X-Gm-Message-State: AC+VfDx5LovFp2WFeJTEDpI/ImM6SjuBNEdmLrmk7MM1TBDapp92yNEs
        QAzBzuGMwbdtHZeJntLt03MUP0Mn/taO5MAXufL6VQ==
X-Google-Smtp-Source: ACHHUZ7wb3qZ+Qnq9csb+a5N85VcMfo3f7fVKEeFXq1y2jgoyp8xHBYXcB4Sf3yFT1UhZua9LFNTzQXcWOCxAZOfITE=
X-Received: by 2002:a05:6808:2984:b0:397:fbe7:a0fb with SMTP id
 ex4-20020a056808298400b00397fbe7a0fbmr10144901oib.18.1686752199333; Wed, 14
 Jun 2023 07:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230614141338.3480029-1-senozhatsky@chromium.org>
In-Reply-To: <20230614141338.3480029-1-senozhatsky@chromium.org>
From:   Brian Geffon <bgeffon@google.com>
Date:   Wed, 14 Jun 2023 10:16:03 -0400
Message-ID: <CADyq12xoEKpYOd7nFy+ET89ss-zTdKbbj6870UMDQeLe09=Zow@mail.gmail.com>
Subject: Re: [PATCH] zram: further limit recompression threshold
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Sergey

On Wed, Jun 14, 2023 at 10:13=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Recompression threshold should be below huge-size-class
> watermark.

Acked-by: Brian Geffon <bgeffon@google.com>

>
> Suggested-by: Brian Geffon <bgeffon@google.com>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> ---
>  drivers/block/zram/zram_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.=
c
> index 1867f378b319..5676e6dd5b16 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1753,7 +1753,7 @@ static ssize_t recompress_store(struct device *dev,
>                 }
>         }
>
> -       if (threshold >=3D PAGE_SIZE)
> +       if (threshold >=3D huge_class_size)
>                 return -EINVAL;
>
>         down_read(&zram->init_lock);
> --
> 2.41.0.162.gfafddb0af9-goog
>
