Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0E25F566A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 16:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiJEO3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 10:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiJEO26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:28:58 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A527C77F;
        Wed,  5 Oct 2022 07:28:53 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id c2so3105586qvo.11;
        Wed, 05 Oct 2022 07:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N8pI7I5ab+a4QOVLrKQ1YzAPtKgXmSNDakBuY0ksuEA=;
        b=ABJiCeXx0fZkpNavMvF/ORlW5OO0sX6uyhAUqlqrb7iqsRibPPIA1RljI0ZtB5E4pt
         QjpJNLpw+yQue6tZWXLB485QbSdHT1fwm5zD/xq+KevvVCw7hroQlxuCln3Xv73Yw/vE
         IERv7u01b6nFZgTW94lF347MGntl8H0AYo8qFUSq/RIdjCB3VmwkazeC7OA9VWe3WiJ4
         N5KI6EF+PPaEZsHvUZQZBFYlxR77wxTK711YxzX3MkiDtl8Uqf0voxviHLpP7w55f2hf
         088aofA635csSsi/X0yhhVePIEzFobzXvr+sM8cKFHW2omvRDvdI9bPOQpk0+fKcccXn
         yz4g==
X-Gm-Message-State: ACrzQf3tUpjHgbUo3Jkk819T4I7h5i7xrp5vjA7lRA9/kWmk8IUnS05e
        cWjufb3NQhymw3CU8PHrhPCsxhhiJG5Gh0RYgO4=
X-Google-Smtp-Source: AMsMyM6T4AWz57OQSM9v2w7c8FKyTzATT5fhysEUhzNONmaQ1KdUJgfpDRxCXovL52Dy02H9+OsHv1DN6o8NvZ1Hb2c=
X-Received: by 2002:a0c:ac49:0:b0:4b1:ccd5:6bd6 with SMTP id
 m9-20020a0cac49000000b004b1ccd56bd6mr112721qvb.130.1664980131980; Wed, 05 Oct
 2022 07:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221004230541.449243-1-Ashish.Kalra@amd.com>
In-Reply-To: <20221004230541.449243-1-Ashish.Kalra@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 5 Oct 2022 16:28:40 +0200
Message-ID: <CAJZ5v0h72L+U60=fBK5LOaNr5bCj9ukwcW8Pn2CCgx0jt1e1Kw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: Fix num_ghes to unsigned int
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@acpica.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 5, 2022 at 1:06 AM Ashish Kalra <Ashish.Kalra@amd.com> wrote:
>
> From: Ashish Kalra <ashish.kalra@amd.com>
>
> Change num_ghes from int to unsigned int, preventing an overflow
> and causing subsequent vmalloc to fail.

So do you have a system where int is not sufficient?

> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  drivers/acpi/apei/ghes.c | 2 +-
>  include/acpi/ghes.h      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index d91ad378c00d..6d7c202142a6 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -163,7 +163,7 @@ static void ghes_unmap(void __iomem *vaddr, enum fixed_addresses fixmap_idx)
>         clear_fixmap(fixmap_idx);
>  }
>
> -int ghes_estatus_pool_init(int num_ghes)
> +int ghes_estatus_pool_init(unsigned int num_ghes)
>  {
>         unsigned long addr, len;
>         int rc;
> diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
> index 34fb3431a8f3..292a5c40bd0c 100644
> --- a/include/acpi/ghes.h
> +++ b/include/acpi/ghes.h
> @@ -71,7 +71,7 @@ int ghes_register_vendor_record_notifier(struct notifier_block *nb);
>  void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
>  #endif
>
> -int ghes_estatus_pool_init(int num_ghes);
> +int ghes_estatus_pool_init(unsigned int num_ghes);
>
>  /* From drivers/edac/ghes_edac.c */
>
> --
> 2.25.1
>
