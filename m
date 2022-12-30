Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7CD659B5B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 19:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbiL3SUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 13:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiL3SUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 13:20:12 -0500
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A641838F;
        Fri, 30 Dec 2022 10:20:11 -0800 (PST)
Received: by mail-il1-f182.google.com with SMTP id u8so11663368ilq.13;
        Fri, 30 Dec 2022 10:20:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEV/3zSntt+UaXA5p0c29rCuY/gKh7c0ufcCVeDhPu4=;
        b=vMGaB9JFMSKGtv+mnZ4QqlikDbDxR/qRIbDr+wIC6NXzA7bHmwUUx/Fv/epNqfMxUz
         rkWS1YtqtqgZMqmtFV/R3X6Ktay3xBO5Em1mLubHRsQ9+Qk+6FFO1+fAHisdSKRWIuZh
         rXKj3fP9JPgrpm2A57sPrLh3jb0eb1xKP0CvvTE0yi+WemZWBdt62p6nuXzGMq8wvLC0
         gB6vV0mP1SBlFeqapdwSzWg3dOWm9YaXT96evDmr2UdWqyjlH1HduLxiJOwW1g8FRR/U
         RJKdUEUvM5dPw5FHJ7K89X0mNLEQHaaVNiwkxZk4UOoAFrerZPZw/nPWeP0XqceM/XZF
         JK0Q==
X-Gm-Message-State: AFqh2kqgSIQkb/NmA6mf0UtGIfoJzDkc5ONlgJXbeaufM/l2CKUi6ui7
        Rqq9d3YOj3eLFZW8MUXu2uMOXsYM1oVxJIXzSb0=
X-Google-Smtp-Source: AMrXdXsxr5/8VmOEZ8b0dpGHcdwOowSTKBPwiTX1J510bfAD/Cnp4ztJTKUROU7Y26GoiZ9PSJxJesuA6LJkSwg++3g=
X-Received: by 2002:a05:6e02:144:b0:30c:41d:2006 with SMTP id
 j4-20020a056e02014400b0030c041d2006mr1240951ilr.314.1672424411227; Fri, 30
 Dec 2022 10:20:11 -0800 (PST)
MIME-Version: 1.0
References: <20221226030242.5127-1-chuanjian@nfschina.com>
In-Reply-To: <20221226030242.5127-1-chuanjian@nfschina.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Dec 2022 19:19:59 +0100
Message-ID: <CAJZ5v0ghCMtU1qtLCO6PcVa6qfXk_tStzXh5h=Hki_6RaMSr=g@mail.gmail.com>
Subject: Re: [PATCH] drivers/acpi/acpica/evmisc.c : eliminate unnecessary type conversions
To:     Dong Chuanjian <chuanjian@nfschina.com>
Cc:     robert.moore@intel.com, rafael.j.wysocki@intel.com,
        lenb@kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 26, 2022 at 4:06 AM Dong Chuanjian <chuanjian@nfschina.com> wrote:
>
> remove unnecessary void* type casting.
>
> Signed-off-by: Dong Chuanjian <chuanjian@nfschina.com>
>
> diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
> index 6172cddc1b39..94d83e7dc90f 100644
> --- a/drivers/acpi/acpica/evmisc.c
> +++ b/drivers/acpi/acpica/evmisc.c
> @@ -160,7 +160,7 @@ acpi_ev_queue_notify_request(struct acpi_namespace_node *node, u32 notify_value)
>
>  static void ACPI_SYSTEM_XFACE acpi_ev_notify_dispatch(void *context)
>  {
> -       union acpi_generic_state *info = (union acpi_generic_state *)context;
> +       union acpi_generic_state *info = context;
>         union acpi_operand_object *handler_obj;
>
>         ACPI_FUNCTION_ENTRY();
> --

ACPICA changes require (at least) a pull request to be submitted to
the upstream ACPICA project on GitHub.

If such a pull request is created, please resend the Linux patch with
a Link tag pointing to that pull request.

Thanks!
