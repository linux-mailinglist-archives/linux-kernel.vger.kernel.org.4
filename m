Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DD9747794
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 19:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjGDROA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Jul 2023 13:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGDRNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 13:13:50 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14EE10C1;
        Tue,  4 Jul 2023 10:13:49 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-98e1fc9d130so168211166b.0;
        Tue, 04 Jul 2023 10:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688490828; x=1691082828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQKhnCmaIDvejxS8LkI+gcLKUdx8AcXpbHEb1fE42Fg=;
        b=DiA7K2LQ0LqS+iHGljjJC7hq2fc4uOr+xTZllyyvr2qikCtGtKkqVoUppdfP6CU+92
         pNfVBhWOKmTkjjsPI47+RurfS6mPYlblsbBtw8QEPlicZWFg3kCgUSBL/mtr8fcfiQp5
         B8E1XYKG00QxftlbcuYNRv6k8TmRr4ymKPE5+wpOq3uqNkYq/zR8hs+gXqyK1Na7/TWK
         xSwnJpJlG8p5TMNiHRA0Y+7cCbG1eeN4qGT0WITl5cILS8Cyqj3taWnmUkPIO5bUY6OC
         iYI5kKUU58epqeKm+feZy5asFlUDUegcvWtl5sXBz0XLzAjbhLkKI5O/g+DJIyoYHm8u
         rxNQ==
X-Gm-Message-State: ABy/qLaudPvL9IHEzTnvhh3CaGlKFMFh/WM3Vz0LKoX6RJnPgXoXrRjb
        XBpONtRSo0ZtBNV8SX2q27y233Lfs1t+X6jItg8=
X-Google-Smtp-Source: APBJJlHAIbpQItK6pdbHUwUGaZ76XsFnmfU6rIg/pYib4a1K0UaSOIiQBPGD3ERFuN7RlEAOsqNUFSa92jugnz5lPts=
X-Received: by 2002:a17:906:ccc3:b0:98d:b10f:f3cd with SMTP id
 ot3-20020a170906ccc300b0098db10ff3cdmr10655695ejb.7.1688490828020; Tue, 04
 Jul 2023 10:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230703124831.979430-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20230703124831.979430-1-ben.dooks@codethink.co.uk>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Jul 2023 19:13:37 +0200
Message-ID: <CAJZ5v0igZsoNkc9tsC6YTQb8qHoO89K58b4LHMpowcJykiXWtg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: fix undeclared variable warnings by including sleep.h
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        lenb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 3, 2023 at 2:48 PM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>
> There are two pieces of data being exported from drivers/acpi/scan.c
> (acpi_device_lock and acpi_wakeup_device_list) that don't have their
> definitions declared in anything scan.c is including.
>
> Fix the following sparse warnings by including sleep.h to add the
> declarations of acpi_device_lock and acpi_wakeup_device_list to
> fix the followng sparse warnings:
>
> drivers/acpi/scan.c:42:1: warning: symbol 'acpi_device_lock' was not declared. Should it be static?
> drivers/acpi/scan.c:43:1: warning: symbol 'acpi_wakeup_device_list' was not declared. Should it be static?
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  drivers/acpi/scan.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 1c3e1e2bb0b5..9556aff69453 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -23,6 +23,7 @@
>  #include <linux/dma-direct.h>
>
>  #include "internal.h"
> +#include "sleep.h"
>
>  extern struct acpi_device *acpi_root;
>
> --

Applied as 6.5-rc material, thanks!
