Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5370C5B4765
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 17:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiIJPvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 11:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiIJPvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 11:51:22 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F15F4456F;
        Sat, 10 Sep 2022 08:51:21 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-3450990b0aeso51479037b3.12;
        Sat, 10 Sep 2022 08:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4JzkWMW1R9Eqdlm4Wh2PefNJgbAts1pyGK7y7lGC84U=;
        b=icbGbe4lYMyQyBnGa7bBh7ijNhmDweHujsOmWEh1s8vPbnX63oxRmGBcEMvhaE1gSi
         VG0qaQwbpSOQLhXpql34WQQKp24AcWpQbSsHscd7faVJSYJJNkUD+BOgv9NREH3yoXor
         9ETEY8L7QQ+/Nn9H3LduPc6kA22d2D2/cSfUlPQ+dRQT1YDMOeO6Q2kvs8+kyTV9cQF9
         QQDdCa6txljIpL8+eBCwAxLeXdKrX74gwmpLiuIMu7KvNCCcLgpQOrPwvGnx4Xl6isud
         AuNnURLcp3ioyvHCbXUT9JfJkvjj7bCwADQE3pHXWmClwjld6K9CYmDDO4t6LEW/kAG1
         YEWg==
X-Gm-Message-State: ACgBeo3jkiTr91juitPvGCjnFwOu4j3RmkZ0bGzV/Uf2t9a0XqbSLSzG
        j7MpLqpsghQRDxHuCiqz8uS7nAvU1sor3FlOg1g=
X-Google-Smtp-Source: AA6agR7vNfpKlHg1wDlGylGX1vEbU2ecUiyXe3OAAbcAErrVomfcsiqR741iFQzrIo/8Fq/sZ8d2u9hD6df7v5y885A=
X-Received: by 2002:a81:48c6:0:b0:345:4835:f62e with SMTP id
 v189-20020a8148c6000000b003454835f62emr16388588ywa.149.1662825080637; Sat, 10
 Sep 2022 08:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220831033123.301988-1-ye.xingchen@zte.com.cn>
In-Reply-To: <20220831033123.301988-1-ye.xingchen@zte.com.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 10 Sep 2022 17:51:09 +0200
Message-ID: <CAJZ5v0gFPgGAO_w8yRrHVO+JBZu1BAo-YdU8iOBv2PfwKuAseA@mail.gmail.com>
Subject: Re: [PATCH linux-next] ACPI: APEI: Remove the unneeded result variable
To:     cgel.zte@gmail.com
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, Len Brown <lenb@kernel.org>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 5:31 AM <cgel.zte@gmail.com> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Return the value erst_get_record_id_begin() directly instead of storing it
>  in another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/acpi/apei/erst.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
> index 31b077eedb58..247989060e29 100644
> --- a/drivers/acpi/apei/erst.c
> +++ b/drivers/acpi/apei/erst.c
> @@ -1020,14 +1020,10 @@ static int reader_pos;
>
>  static int erst_open_pstore(struct pstore_info *psi)
>  {
> -       int rc;
> -
>         if (erst_disable)
>                 return -ENODEV;
>
> -       rc = erst_get_record_id_begin(&reader_pos);
> -
> -       return rc;
> +       return erst_get_record_id_begin(&reader_pos);
>  }
>
>  static int erst_close_pstore(struct pstore_info *psi)
> --

Can you please combine this patch with the other analogous one you
sent for APEI?
