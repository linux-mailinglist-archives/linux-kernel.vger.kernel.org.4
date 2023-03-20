Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3761C6C1DA4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjCTRVI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Mar 2023 13:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjCTRUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:20:47 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0160C31E33;
        Mon, 20 Mar 2023 10:16:36 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id x3so49577734edb.10;
        Mon, 20 Mar 2023 10:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679332544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k87jmpjlNLfn6Eu0wWSVrI81rlQ/q/jsPiIAGLWAuyA=;
        b=Pb6NaKdbPR6zXij/zmyd3+Gxu0xpeguQARTNicpsRXG/TRP2eoBCW0ANT6xURxFu4J
         x+189dYnP6pEFgkOdnLcja3bzx3w1gKV13trA2omx6oI/yfYN7XFJ0Mx13Bx+YQvHGkL
         aQkm/LJLPIuPeCObGxbQQ0mC/71/l1Shs/hvXAuCZc2gj//xv0jeY6XBqXtr8PWepUxo
         MijahzKf8myMa6u+ZqaMyagmIB3xg/1TN08kZGS1lp2S4Dkn2wlkJDv0s+yKMJYc1pPb
         WWPPwO9odrmmFeHe8X1oixnsthq9MI26Xih6isuMUYSMYT4lSgbgQS+YXpzxCZEFSJjo
         BWHg==
X-Gm-Message-State: AO0yUKV2KnmgECXkqSF9eAuC2U4s4mK5wygW1lJfxyLLpZaQeoVdddhO
        T5ON5MSvZmeTZPELJnJdg2MYNlVYivVsr+x/AWY=
X-Google-Smtp-Source: AK7set9KDcXIH6JRWcUJXsHj6hNrkEL2ZM830wmLgVeOVdVzvlpOwMsIPDvNyLssiFAy9ageTzPSCFJ1P5Zpq8qN8w4=
X-Received: by 2002:a17:906:228b:b0:931:6921:bdbb with SMTP id
 p11-20020a170906228b00b009316921bdbbmr4081391eja.2.1679332543822; Mon, 20 Mar
 2023 10:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230302071327.557734-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20230302071327.557734-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 20 Mar 2023 18:15:32 +0100
Message-ID: <CAJZ5v0gB7WSB3F3+kTnB-r83xO9G7Sk1Vyh2os0=AeYNvHK_Mw@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: sysfs: Enable ACPI sysfs support for CCEL records
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Rafael J Wysocki <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 8:13 AM Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> The Confidential Computing Event Log (CCEL) table provides the address
> and length of the CCEL records area in UEFI reserved memory. To access
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
>
> Original-patch-by: Haibo Xu <haibo1.xu@intel.com>
> [Original patch is for TDEL table, modified it for CCEL support]
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/acpi/sysfs.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index 7db3b530279b..afeac925b31b 100644
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
> +           !(ccel->log_area_start_address) || !(ccel->log_area_minimum_length)) {

The inner parens in this line are not necessary AFAICS.

Otherwise I have no objections.

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
