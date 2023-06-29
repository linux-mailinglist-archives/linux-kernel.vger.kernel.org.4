Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB5A742A6A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 18:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjF2QPP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Jun 2023 12:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbjF2QPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:15:07 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E3E10E5;
        Thu, 29 Jun 2023 09:15:06 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-98e1fc9d130so24105666b.0;
        Thu, 29 Jun 2023 09:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688055305; x=1690647305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2asz2ubuH2qetgbcysClqW7znNeW2vYR8Y5n9yx7dNQ=;
        b=eu+XOq+FfQIO4gi1Qc8YdAEKGgZ6QaHJIZixs10PcPnzBF70b3h80B10tILnGlIzBX
         sq81ANntAvJ4C9zzyGgPkWbRdYwRZshtoerkEcxVgH9hSRl0qT/RJZy5kKil9qcYi9r6
         2k6Wc0JfEUUInKjxo6kWz1EVxpPu9YYtVi2khe51ZdMWp2c2AZ6CNqRA5dQmt0csyKt0
         DS9Rnzm+L6tzgGwDg5d8uPO+GjSWwFyDsd0kBgKtR4qywAKegDKMkSts0oE7+0WpRBYg
         QGhGigjS92A/F+XBAGyTIJKzSWD4v2hVwXAyR0qoTVCtbhq3JhoVc/hXlUUCclLD/2ok
         L45w==
X-Gm-Message-State: AC+VfDzAlzH09oGjawDwHx0xG/OmncATvEFOqhou0RcM6cazaql2Zz0i
        cV3zHfZfCYlvSyYmhddahOB6W7dUyttEahBzcwDF8wbW
X-Google-Smtp-Source: ACHHUZ5/QdCY5R7J3odu7HQae4qVM960Ldl0f0ONcSdWCpVyCWdGZEis60/MfjC11Ncx1onHXrhUbkrTUeasMlq2sJM=
X-Received: by 2002:a17:906:518f:b0:974:ae1d:ad0b with SMTP id
 y15-20020a170906518f00b00974ae1dad0bmr13460817ejk.3.1688055304918; Thu, 29
 Jun 2023 09:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230616165034.3630141-1-michal.wilczynski@intel.com> <20230616165034.3630141-9-michal.wilczynski@intel.com>
In-Reply-To: <20230616165034.3630141-9-michal.wilczynski@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Jun 2023 18:14:53 +0200
Message-ID: <CAJZ5v0hPY=nermvRKiyqGg4R+jLW13B-MUr0exEuEnw33VUj7g@mail.gmail.com>
Subject: Re: [PATCH v5 08/10] acpi/nfit: Improve terminator line in acpi_nfit_ids
To:     Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        lenb@kernel.org, dave.jiang@intel.com, ira.weiny@intel.com,
        rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev
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

On Fri, Jun 16, 2023 at 6:51 PM Michal Wilczynski
<michal.wilczynski@intel.com> wrote:
>
> Currently terminator line contains redunant characters.

Well, they are terminating the list properly AFAICS, so they aren't
redundant and the size of it before and after the change is actually
the same, isn't it?

> Remove them and also remove a comma at the end.

I suppose that this change is made for consistency with the other ACPI
code, so this would be the motivation to give in the changelog.

In any case, it doesn't seem to be related to the rest of the series.

> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> ---
>  drivers/acpi/nfit/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index aff79cbc2190..95930e9d776c 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -3455,7 +3455,7 @@ EXPORT_SYMBOL_GPL(__acpi_nfit_notify);
>
>  static const struct acpi_device_id acpi_nfit_ids[] = {
>         { "ACPI0012", 0 },
> -       { "", 0 },
> +       {}
>  };
>  MODULE_DEVICE_TABLE(acpi, acpi_nfit_ids);
>
> --
> 2.41.0
>
