Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54866C53C1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 19:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjCVSbl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Mar 2023 14:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCVSbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:31:39 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CE05FA55;
        Wed, 22 Mar 2023 11:31:37 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id cn12so31073086edb.4;
        Wed, 22 Mar 2023 11:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679509896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMBGzMix3e1+wn1UGktWXWRXSZYz21zAxjtu3HzbOV4=;
        b=7K72JhSzss92vWMJ4dYGRDlJg2yQtio83uVhY9OQsxVAYsONgNK+mzRoByaXDqqZ6g
         uG5bUD8n0J3VcOFeIatCihgY0C+VjSPqEVTpKDdW3ajHUsFNwL4vmG49CYJaXr9aHTfA
         9qyZ63alPLTK7g68QPcp6hpQKSMAcPdTSsd35o+Nx00m19j+iK106UzuKeM3Ny7tdNTB
         eDyF/xz6gbfPDe8VQyTL2j93U+qmNlixO/Ew6IKwkxFW6Ub4hELbz8bsGEgDYYtV7zgk
         Bo9rq6qANi8wivTqbKSnnrS3lLtOyLTueEFhUBFKL2PybFba4nUGTigzPKlVGhOV27yI
         oq8g==
X-Gm-Message-State: AO0yUKX2rjXihNL/AMgxoah9KCVHJ6KvolVLakC+PmbqDUYLb1Oq9ruV
        CyyL4CKCeIxmX4TF1ZVpj8rD1L2L2N7fIngnwRc=
X-Google-Smtp-Source: AK7set+2KxH6n18hcPwVNha2Ag6dVKcUR1tjNRWOlqfYxJpiI2NWnBQpIv/s6BPGzTRDhYBr78WNcn0nxi3e2u7JXaI=
X-Received: by 2002:a17:907:d9f:b0:931:6921:bdbb with SMTP id
 go31-20020a1709070d9f00b009316921bdbbmr3760891ejc.2.1679509895830; Wed, 22
 Mar 2023 11:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230320212019.2479101-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230320212019.2479101-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Mar 2023 19:31:24 +0100
Message-ID: <CAJZ5v0ggn6q5WJsK7jP7EbxnRq6xxwzj2PwOMxhV6L6Rb5iSJw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: sysfs: Enable ACPI sysfs support for CCEL records
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Rafael J Wysocki <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 10:21 PM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> The Confidential Computing Event Log (CCEL) table provides the address
> and length of the CCEL records area in UEFI reserved memory.

The rest of this paragraph can be omitted.

> To access
> these records, userspace can use /dev/mem to retrieve them. But
> '/dev/mem' is not enabled on many systems for security reasons.
>
> So to allow user space access these event log records without the
> /dev/mem interface, add support to access it via sysfs interface. The
> ACPI driver has provided read only access to BERT records area via
> '/sys/firmware/acpi/tables/data/BERT' in sysfs. So follow the same way,
> and add support for /sys/firmware/acpi/tables/data/CCEL to enable
> read-only access to the CCEL recorids area.
>
> More details about the CCEL table can be found in ACPI specification
> r6.5, sec titled "CC Event Log ACPI Table".

Please provide a proper section number here and a Link: tag pointing
to the relevant section of the spec (which is
https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#cc-event-log-acpi-table
I think).

> Original-patch-by: Haibo Xu <haibo1.xu@intel.com>

If the original patch has been signed-off by that developer, you can
use a Co-developed-by: along with the original S-o-b tag here.

> [Original patch is for TDEL table, modified it for CCEL support]
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>
> Changes since v1:
>  * Removed unnecessary parenthesis as per Rafael's suggestion..
>
>  drivers/acpi/sysfs.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index 7f4ff56c9d42..687524b50085 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -458,11 +458,28 @@ static int acpi_bert_data_init(void *th, struct acpi_data_attr *data_attr)
>         return sysfs_create_bin_file(tables_data_kobj, &data_attr->attr);
>  }
>
> +static int acpi_ccel_data_init(void *th, struct acpi_data_attr *data_attr)
> +{
> +       struct acpi_table_ccel *ccel = th;
> +
> +       if (ccel->header.length < sizeof(struct acpi_table_ccel) ||
> +           !ccel->log_area_start_address || !ccel->log_area_minimum_length) {
> +               kfree(data_attr);
> +               return -EINVAL;
> +       }
> +       data_attr->addr = ccel->log_area_start_address;
> +       data_attr->attr.size = ccel->log_area_minimum_length;
> +       data_attr->attr.attr.name = "CCEL";
> +
> +       return sysfs_create_bin_file(tables_data_kobj, &data_attr->attr);
> +}
> +
>  static struct acpi_data_obj {
>         char *name;
>         int (*fn)(void *, struct acpi_data_attr *);
>  } acpi_data_objs[] = {
>         { ACPI_SIG_BERT, acpi_bert_data_init },
> +       { ACPI_SIG_CCEL, acpi_ccel_data_init },
>  };
>
>  #define NUM_ACPI_DATA_OBJS ARRAY_SIZE(acpi_data_objs)
> --
> 2.34.1
>
