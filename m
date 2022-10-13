Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAC05FE1FD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJMStx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiJMSsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:48:53 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF2B1905EE;
        Thu, 13 Oct 2022 11:47:10 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id hh9so2277376qtb.13;
        Thu, 13 Oct 2022 11:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jae7zEaFZOKi5wYvzAJM8ag+uUJf+3HKkiEPd4WrjYE=;
        b=lPQ9JPdLwT5scU7M5HnvHv7nut6LQ8CuXQWMUzp7Z0lQNaUeyFWeHjO6C6ojHeFIA1
         A0Evf5OL6wcxauHFW07IBN5XzSjBO6smQsh2oj/yRMSJ5p2X3JIhaJJWbmrLFzeaPZIg
         fn+PzBYegX3qQtwddvnfEwpnE2R/5guAqzQaaV9EjO3SER/3otezyoTFexYXiRVt7iMW
         b86nJ5yMZH9LRL6W9N3pQYETfJQQApJsOklHdyrcCxdNKGrBceKF1cj/XbuIArEYCif6
         Q6PUyp592wuHS7V5iUV4DwpCPwZIRVDpVT9t1ZQLXSttZZLFNnLn0r0hG6vbek3/4vIQ
         KohA==
X-Gm-Message-State: ACrzQf12WL0WBy6k7UAVlxzwCk7is5youFtOWQtJKgKNMbUyQMzw8S7j
        cOdYJr9BJsP003XG3vBJWZwEXAUvqktwVy1k4So=
X-Google-Smtp-Source: AMsMyM6XqtTdFSQRLAVpsaJboO1CJLydS6mW4adPKjiYAvHpBRKdAgYxtR0P2x2BMCv5pgvi99XSlFyCRLFHEuN7kIE=
X-Received: by 2002:ac8:5a07:0:b0:39c:1de3:e75c with SMTP id
 n7-20020ac85a07000000b0039c1de3e75cmr1090357qta.49.1665686702643; Thu, 13 Oct
 2022 11:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20221006163258.318916-1-tony.luck@intel.com> <20221010203423.24300-1-tony.luck@intel.com>
In-Reply-To: <20221010203423.24300-1-tony.luck@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Oct 2022 20:44:51 +0200
Message-ID: <CAJZ5v0iuv9e4+kvuKHLX+VyYHptW6_pRLJK4Qz3ZX0aEPcKwxA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI / extlog: Handle multiple records
To:     Tony Luck <tony.luck@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 10:34 PM Tony Luck <tony.luck@intel.com> wrote:
>
> If there is no user space consumer of extlog_mem trace records, then
> Linux properly handles multiple error records in an ELOG block
>
>         extlog_print()
>           print_extlog_rcd()
>             __print_extlog_rcd()
>               cper_estatus_print()
>                 apei_estatus_for_each_section()
>
> But the other code path hard codes looking for a single record to
> output a trace record.
>
> Fix by using the same apei_estatus_for_each_section() iterator
> to step over all records.
>
> Fixes: 2dfb7d51a61d ("trace, RAS: Add eMCA trace event interface")
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>
> Changes since v1: Oops. Cut & pasted the apei_estatus_for_each_section()
> line, but forgot to change the argument from "estatus" to "tmp". Need to
> walk the *copy* that was made, not the original because BIOS is allowed to
> stomp on it as soon as it sees block_status has been cleared.
>
>  drivers/acpi/acpi_extlog.c | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index 72f1fb77abcd..e648158368a7 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -12,6 +12,7 @@
>  #include <linux/ratelimit.h>
>  #include <linux/edac.h>
>  #include <linux/ras.h>
> +#include <acpi/ghes.h>
>  #include <asm/cpu.h>
>  #include <asm/mce.h>
>
> @@ -138,8 +139,8 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>         int     cpu = mce->extcpu;
>         struct acpi_hest_generic_status *estatus, *tmp;
>         struct acpi_hest_generic_data *gdata;
> -       const guid_t *fru_id = &guid_null;
> -       char *fru_text = "";
> +       const guid_t *fru_id;
> +       char *fru_text;
>         guid_t *sec_type;
>         static u32 err_seq;
>
> @@ -160,17 +161,23 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>
>         /* log event via trace */
>         err_seq++;
> -       gdata = (struct acpi_hest_generic_data *)(tmp + 1);
> -       if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
> -               fru_id = (guid_t *)gdata->fru_id;
> -       if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
> -               fru_text = gdata->fru_text;
> -       sec_type = (guid_t *)gdata->section_type;
> -       if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
> -               struct cper_sec_mem_err *mem = (void *)(gdata + 1);
> -               if (gdata->error_data_length >= sizeof(*mem))
> -                       trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
> -                                              (u8)gdata->error_severity);
> +       apei_estatus_for_each_section(tmp, gdata) {
> +               if (gdata->validation_bits & CPER_SEC_VALID_FRU_ID)
> +                       fru_id = (guid_t *)gdata->fru_id;
> +               else
> +                       fru_id = &guid_null;
> +               if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
> +                       fru_text = gdata->fru_text;
> +               else
> +                       fru_text = "";
> +               sec_type = (guid_t *)gdata->section_type;
> +               if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
> +                       struct cper_sec_mem_err *mem = (void *)(gdata + 1);
> +
> +                       if (gdata->error_data_length >= sizeof(*mem))
> +                               trace_extlog_mem_event(mem, err_seq, fru_id, fru_text,
> +                                                      (u8)gdata->error_severity);
> +               }
>         }
>
>  out:
> --

Applied as 6.1-rc material, thanks!
