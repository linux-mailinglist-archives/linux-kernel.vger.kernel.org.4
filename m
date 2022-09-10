Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435345B476F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 18:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiIJQLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 12:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIJQLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 12:11:01 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520ED638E;
        Sat, 10 Sep 2022 09:10:59 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id a67so6872630ybb.3;
        Sat, 10 Sep 2022 09:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zHbX9+Jwy8L2oKNcGKzxX15MKHHqOVzM3+4CA7qaqzc=;
        b=R0gORb/5LgTQkP7TbQ4oxkL1bFf3QvBHuviqBTyDndAJ2D74/P9miMdUm3leaSVS2W
         EGP5E8zrxfTYT9MVT4ha1w9NOxTke7uHOqyMd0Zpw6H0Et2wJI0/CBF8HcRM/1NbpjFJ
         qPiTzq/ienvaJ3t8hqI7J5k/U9w1XdaaDpYOFvGXbKorVjQHUdQzMz928domiMwLduHg
         3mmsCzZ3qLgikAxO5Gy3J6gLrineJxCAW0k8wdS6dEe7TAQH7GQbgQiLcunj8hgdRBSZ
         XiWCO5TXHAEX4xgdUO/An9CaB125BCEic/pg3/4ImP+fcd4+Wb7FXOUEWVjvIoZJ1igQ
         jlHA==
X-Gm-Message-State: ACgBeo31DoGKaP9G0ZZFwC5qL1AXzIyhPyqb1iyZoV6XpSq5vLPS7d9q
        nsB6GGfKe9gwyLSsf9IO6hYO9qeSzoD3E0CUOgc=
X-Google-Smtp-Source: AA6agR5nimTW8pOVuM5dooWZmN1fJHZMRpKjJEUZwyQdOXD7ZZhT/7FPQPw7oXHX6NprC/CWX0SiSDCTEQnqlN4B+uo=
X-Received: by 2002:a25:d154:0:b0:6a8:cfcc:49e8 with SMTP id
 i81-20020a25d154000000b006a8cfcc49e8mr15553274ybg.482.1662826258551; Sat, 10
 Sep 2022 09:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220828205416.1957305-1-floridsleeves@gmail.com>
In-Reply-To: <20220828205416.1957305-1-floridsleeves@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 10 Sep 2022 18:10:47 +0200
Message-ID: <CAJZ5v0hdbvZALerJHXViDypvFGOZNK7bTPiJd8KVZa2VE-355w@mail.gmail.com>
Subject: Re: [PATCH v1] drivers/acpi/processor_idle: check the return value of acpi_fetch_acpi_dev()
To:     Li Zhong <floridsleeves@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 28, 2022 at 10:54 PM Li Zhong <floridsleeves@gmail.com> wrote:
>
> The return value of acpi_fetch_acpi_dev() could be NULL, which will
> cause null pointer dereference if used in acpi_device_hid().
>
> Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> ---
>  drivers/acpi/processor_idle.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 16a1663d02d4..519f8f741da3 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1117,6 +1117,8 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
>         status = acpi_get_parent(handle, &pr_ahandle);
>         while (ACPI_SUCCESS(status)) {
>                 d = acpi_fetch_acpi_dev(pr_ahandle);
> +               if (!d)
> +                       break;
>                 handle = pr_ahandle;
>
>                 if (strcmp(acpi_device_hid(d), ACPI_PROCESSOR_CONTAINER_HID))
> --

Applied (with some edits in the subject and changelog) as 6.1 material, thanks!
