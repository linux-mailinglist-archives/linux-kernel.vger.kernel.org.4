Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4575B6CADB5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 20:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjC0Spi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 14:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjC0Spf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:45:35 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57D511B;
        Mon, 27 Mar 2023 11:45:29 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id w9so40211343edc.3;
        Mon, 27 Mar 2023 11:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679942728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+foyrv0NPxQYFYNXu1z87ZeyW7A9es9zcBbNUhhtzU=;
        b=ILG6XqMfhx1dSbFz5TG5AyzDdV/dwa0eaB4P2rouIf/ena71aCNGRemyfx1k4Hb4aT
         CjebUQQ6vTLcstGMPYdtLDUj1CBV6Snz3JqNBPHqREs5jH/ncWytxzUk2vBSTgiN4SSp
         WvusyphhLV80WD5ZlnyDQYqWfayAkiK74o0CiRBYAWlrF5cL6o0lxLtl+KwqcW6dNjXG
         pIyjjKArIcrb2MOZV3gX6I3IuherGQQklHOfiDwHNnjmm3saWb/Uo5XNB6orFh3/X4/o
         aZFJ92/94i9QOEvtj8cbwyx1z2Z7y0JZwojwp3uyJeKFWwKW9j4KK+5uy/MpSla9Pg58
         nWog==
X-Gm-Message-State: AAQBX9eZvGRTqGd1W9M6FV7l66iGQZukXfeecGrJEcGlYK/XNVp/31AD
        9dx8Dy4EkuDSEOfhxRPyQ6k70tR/j+hhYHg1vCU=
X-Google-Smtp-Source: AKy350btpilZc+iXong2/3h7WtnYlg9nGYoTCcoNTiL94NlUGLd0H767OuFoyxdjPvme5UCSEBwunl/LvXIuVMg2Rcg=
X-Received: by 2002:a50:d49e:0:b0:502:148d:9e1e with SMTP id
 s30-20020a50d49e000000b00502148d9e1emr6362846edi.3.1679942728143; Mon, 27 Mar
 2023 11:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230322191313.22804-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230322191313.22804-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Mar 2023 20:45:16 +0200
Message-ID: <CAJZ5v0i3TWajRr1bMOVj7o7aCEEurt4b_SnyPCndJL8r3Mad7Q@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: sysfs: Enable ACPI sysfs support for CCEL records
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Rafael J Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 8:13 PM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> The Confidential Computing Event Log (CCEL) table provides the address
> and length of the CCEL records area in UEFI reserved memory.
>
> To allow user space access to these records, expose a sysfs interface
> similar to the BERT table.
>
> More details about the CCEL table can be found in the ACPI specification
> r6.5 [1], sec 5.2.34.
>
> Link: https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#cc-event-log-acpi-table # [1]
> Co-developed-by: Haibo Xu <haibo1.xu@intel.com>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>
> Changes since v2:
>  * Fixed the commit log as per review suggestion.
>
> Changes since v1:
>  * Removed unnecessary parenthesis as per Rafael's suggestion.
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

Applied as 6.4 material, thanks!
