Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9054A5FE202
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJMSuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiJMStr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:49:47 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55965DBE6D;
        Thu, 13 Oct 2022 11:48:34 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id g11so2306708qts.1;
        Thu, 13 Oct 2022 11:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=myRigzNXG3k4UY83qj9yevV968JdHZojuu1Y05TXW7I=;
        b=s1o8QHWrOxXsNVBRTLhf8b/27CKbESls+s0KXe52jomX44Ix07bPOj7T7K6VCvub5m
         ebW5RUBUl8W0V6pdgvg8Fsoru1T8f7VJwnaILT0RgZnazw9tcFpiFwk3PldFl6yN2Qxy
         uYdXuA/NlYMIeJ7HucJPPBz1DyBP3cutYWM24syNB4Qqk77oMAjUzqct4dS7xgTBUyia
         bPj9uhmNTrY3i9gmw7sVJHm5Tnv1RDvdu3i7dJeMmX0XKBkJ4lMqkzg/yzeFx2tZHe11
         PPAONgT1jPu2KMkCQk6kBeWili9S1SUcehpCqN10QKKcDZ4fp/aLm7W7FHo9iT3O8zA/
         ZvVQ==
X-Gm-Message-State: ACrzQf1G2kNHUGcgO8yTE6J+6PgTte6635t2+jS3g2jQspGARimGjol/
        yTbaTUx4r0Kv1LvHn8FLtY+yqURYtn+9KW4V/Z0=
X-Google-Smtp-Source: AMsMyM58cV2G273bYp95dss3gDJzvQYc6JYdmrYwbtjZHdZy/tOT0FZJ78ERZdv5zsMwQy9Pz4Yitrvp3YYZwM6K8QM=
X-Received: by 2002:ac8:5a07:0:b0:39c:1de3:e75c with SMTP id
 n7-20020ac85a07000000b0039c1de3e75cmr1094335qta.49.1665686758938; Thu, 13 Oct
 2022 11:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <20221005163253.455910-1-Ashish.Kalra@amd.com>
In-Reply-To: <20221005163253.455910-1-Ashish.Kalra@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Oct 2022 20:45:48 +0200
Message-ID: <CAJZ5v0gsnVTwPX+hrB4-hUtESsBC1dot3vFh_8qe4cb8ChDYtA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: APEI: Fix num_ghes to unsigned int
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, robert.moore@intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@acpica.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 5, 2022 at 6:33 PM Ashish Kalra <Ashish.Kalra@amd.com> wrote:
>
> From: Ashish Kalra <ashish.kalra@amd.com>
>
> Change num_ghes from int to unsigned int, preventing an overflow
> and causing subsequent vmalloc to fail.
>
> The overflow happens in the ghes_estatus_pool_init() when calculating
> len during execution of the statement below as both multiplication
> operands here are signed int :
>
> len += (num_ghes * GHES_ESOURCE_PREALLOC_MAX_SIZE);
>
> The following call trace is observed because of this bug:
>
> [    9.317108] swapper/0: vmalloc error: size 18446744071562596352, exceeds total pages, mode:0xcc0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0-1
> [    9.317131] Call Trace:
> [    9.317134]  <TASK>
> [    9.317137]  dump_stack_lvl+0x49/0x5f
> [    9.317145]  dump_stack+0x10/0x12
> [    9.317146]  warn_alloc.cold+0x7b/0xdf
> [    9.317150]  ? __device_attach+0x16a/0x1b0
> [    9.317155]  __vmalloc_node_range+0x702/0x740
> [    9.317160]  ? device_add+0x17f/0x920
> [    9.317164]  ? dev_set_name+0x53/0x70
> [    9.317166]  ? platform_device_add+0xf9/0x240
> [    9.317168]  __vmalloc_node+0x49/0x50
> [    9.317170]  ? ghes_estatus_pool_init+0x43/0xa0
> [    9.317176]  vmalloc+0x21/0x30
> [    9.317177]  ghes_estatus_pool_init+0x43/0xa0
> [    9.317179]  acpi_hest_init+0x129/0x19c
> [    9.317185]  acpi_init+0x434/0x4a4
> [    9.317188]  ? acpi_sleep_proc_init+0x2a/0x2a
> [    9.317190]  do_one_initcall+0x48/0x200
> [    9.317195]  kernel_init_freeable+0x221/0x284
> [    9.317200]  ? rest_init+0xe0/0xe0
> [    9.317204]  kernel_init+0x1a/0x130
> [    9.317205]  ret_from_fork+0x22/0x30
> [    9.317208]  </TASK>
>
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

Applied as 6.1 material with some edits in the subject and changelog.

Thanks!
