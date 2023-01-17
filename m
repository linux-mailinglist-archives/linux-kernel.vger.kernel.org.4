Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426D266E126
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjAQOpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjAQOpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:45:09 -0500
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BF96A6C;
        Tue, 17 Jan 2023 06:45:08 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id az20so56783319ejc.1;
        Tue, 17 Jan 2023 06:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JUWMF0bEE5vm1RPPRBpOipgEDDa425xqRegCU9n7Z9Q=;
        b=L7cYyClOepNL7OC5L1TymXlWA9w+4Wy2hp2ky4KCyPljbr0gQ9ec8aOt93UK4Lr4hJ
         G0dmAh068e9mvf7vv0W6LJtMFBseFd7QvfgdYo0tmTXg8fqmwoq04IblGV0y4XzoZW9+
         LzUvfnfa2Z76G8PMRJhmCdpfOTXyL2qILK/V16vxYvW3OGHyRhUenx6BE3ga3FGDCTrO
         aKzFsBOdVSPLA5DMhWIoPxuIPxMPNdm2QDAylv4vUN2TUCImnwr3b7jo0T8DgKuPdgQe
         FMVNZGd6ZRk1+uQrMwk0FKXbDF+t0Q1rgw+Oam3EZhAbDQ4eIAHFnyZ+JNGPW1ba1WpU
         z/YQ==
X-Gm-Message-State: AFqh2kqkR+PTmvIaaip4D1+xjm+05jLNiXZyn3V9rtvk9TupF+SJLIfh
        DU5HtG42EsGJ4C6PQa04mQQ8ponYGxapfBCS0MI=
X-Google-Smtp-Source: AMrXdXt72R3g8HPThCfNV4aIPbdhld65F0NWkeFUD0t90RzPiaZqJLaW0i4XCtBSmOB3zOZ0iMgxbLx3Fuk25kJ7kEs=
X-Received: by 2002:a17:906:a20c:b0:7c1:5ff0:6cc2 with SMTP id
 r12-20020a170906a20c00b007c15ff06cc2mr247274ejy.246.1673966707194; Tue, 17
 Jan 2023 06:45:07 -0800 (PST)
MIME-Version: 1.0
References: <20230114085053.72059-1-W_Armin@gmx.de> <20230114085053.72059-4-W_Armin@gmx.de>
In-Reply-To: <20230114085053.72059-4-W_Armin@gmx.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Jan 2023 15:44:56 +0100
Message-ID: <CAJZ5v0iyqHpCe+w6yHam8L65fLMEmobYjQpuiHxk2dmT3dEiEg@mail.gmail.com>
Subject: Re: [PATCH 3/4] ACPI: battery: Replace strncpy() with strscpy()
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sat, Jan 14, 2023 at 9:51 AM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Currently, strncpy() and manual NUL-termination is used
> when copying integers. Switch to strscpy() which takes care
> of NUL-terminating the result.
>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/acpi/battery.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 9f6daa9f2010..b39b84b8f3ae 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -449,8 +449,7 @@ static int extract_package(struct acpi_battery *battery,
>
>                                 break;
>                         case ACPI_TYPE_INTEGER:
> -                               strncpy(ptr, (u8 *)&element->integer.value, sizeof(u64));
> -                               ptr[sizeof(u64)] = 0;
> +                               strscpy(ptr, (u8 *)&element->integer.value, sizeof(u64) + 1);
>
>                                 break;
>                         default:
> --

This can be folded into the previous patch.

Otherwise you're patching your own patch which isn't particularly clean.
