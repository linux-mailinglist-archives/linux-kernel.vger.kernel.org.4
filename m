Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6A16187FB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiKCSxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiKCSx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:53:27 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2149FEF;
        Thu,  3 Nov 2022 11:53:24 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id hh9so1798029qtb.13;
        Thu, 03 Nov 2022 11:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e3P3zdhy8GKexWx3vyrC2poycFZmbZATTV4uCKdeI44=;
        b=BkmpreiOCbLX+dtUWJ+2YdF9+bdOs8FJkLKV/MOd138mAPNSrWqt2OisXMxL0B49gA
         Xkj9B+giyvQh4Vp/LghlyHW3gU8ruEist71r5kXjp0kXPDlFe4l+bhO0TfCYLv5Zslr/
         fPAwLT3SJ0lAJJvMPMOjMmE25nKsBIT1Ai6d95zcfZ0Vhn6Eu2MuTW59aDuUR5sok7KP
         PDrvjus151I2wZ8rFkbM5Md0piP2VR1tgQD/3wztWYW3UazR0kMaiSF7pK8oChyBbidc
         jYruMe3giJsXWjhDSWniiz5vl2nf/38WUtelp8IR2eemPPDaco0nlQXgI9z6wdMX9AeM
         SrYQ==
X-Gm-Message-State: ACrzQf0ihpYA6saMeAKUgr2ERNhOWhUmRqaySke5GELgHX+Ax34aUHZz
        cM14/O7ivZcvSlQlHaXOk3tz+UqzdaKabkOAt+A=
X-Google-Smtp-Source: AMsMyM4QSySjm+ZEB/jau7CJMJJfWL1+5ZQtQRrNl6i66knX97g4Qv73Gu/6SVigeCoz4CyrTFJzPtEC8KPqj3i61Aw=
X-Received: by 2002:a05:622a:1a25:b0:39c:b862:7318 with SMTP id
 f37-20020a05622a1a2500b0039cb8627318mr26133393qtb.147.1667501603818; Thu, 03
 Nov 2022 11:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <20221018215755.33566-1-giulio.benetti@benettiengineering.com>
In-Reply-To: <20221018215755.33566-1-giulio.benetti@benettiengineering.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Nov 2022 19:53:12 +0100
Message-ID: <CAJZ5v0hRBd8OEg1CJUQGhb6_59j-+-zZTid8kmMV9nUk2CF3EA@mail.gmail.com>
Subject: Re: [PATCH 1/3] ACPI: scan: substitute empty_zero_page with helper ZERO_PAGE(0)
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-raid@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Mark Brown <broonie@kernel.org>,
        Song Liu <song@kernel.org>
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

On Tue, Oct 18, 2022 at 11:59 PM Giulio Benetti
<giulio.benetti@benettiengineering.com> wrote:
>
> Not all zero page implementations use empty_zero_page global pointer so
> let's substitute empty_zero_page occurence with helper ZERO_PAGE(0).
>
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> ---
>  drivers/acpi/scan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 558664d169fc..4d2d274cc8ad 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -30,7 +30,7 @@ extern struct acpi_device *acpi_root;
>  #define ACPI_BUS_HID                   "LNXSYBUS"
>  #define ACPI_BUS_DEVICE_NAME           "System Bus"
>
> -#define INVALID_ACPI_HANDLE    ((acpi_handle)empty_zero_page)
> +#define INVALID_ACPI_HANDLE    ((acpi_handle)ZERO_PAGE(0))
>
>  static const char *dummy_hid = "device";
>
> --

Applied as 6.2 material, thanks!
