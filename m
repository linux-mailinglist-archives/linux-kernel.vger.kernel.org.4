Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D3A6E46AF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 13:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjDQLmn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Apr 2023 07:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjDQLml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 07:42:41 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8F55FE8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:41:42 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50671ef0c48so360836a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681731625; x=1684323625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03PjCQ3N7SikDY1UXq9Hky+G0kxWjdaJcpffT4OU8uE=;
        b=LFkJV5UzUaU/W5DPDXPuV0LKGpDY/DkfQguCcF+mNGUd0nA/h3OzINPpu9Wf+YIzU3
         1CFQUhGqYZAu5MgXzyuJLZxS8NC4BxgK6N/BezzO+WSFGrAHihtq14lDeQIonObj5Dra
         cjPiuVJAYUeJiDL62mxSeCBr+5BP/AHMvnhX8D0eK9Fg6ldxHLWN4Z7ZzUix7fKsvujS
         h0QObKg5BsRmeLcSjNiO0XMZP/CU1AkGRlDT9G0FqTFjGMRB87HF4pR+sEn++/ZLaA5C
         ao93NB07XasE52AspsF1XJ1pTkhSje9JTAFpw3EpZQHT+W0Z+D4zsjxBsRTmg+Kas1wV
         s7SA==
X-Gm-Message-State: AAQBX9c0Bw1MWpEhk/Xcu7rfsQn8l/MXw2KL60CpsiD5/kxewnNubh20
        bAkTwDIQE5EALlt+GT53a+v7dlWQZUgWifabA2o=
X-Google-Smtp-Source: AKy350YO3uIFCApCzDyCKTiNafmfJsFugBEEjUeBxzmGjFF2KS2/gZNuKZBtWxyHKAYtejU+lV+qgG3z5kzK/zcTOQQ=
X-Received: by 2002:a17:906:72dd:b0:92f:27c2:13c0 with SMTP id
 m29-20020a17090672dd00b0092f27c213c0mr9389915ejl.6.1681731625181; Mon, 17 Apr
 2023 04:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230417104817.30254-1-jirislaby@kernel.org>
In-Reply-To: <20230417104817.30254-1-jirislaby@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 Apr 2023 13:40:14 +0200
Message-ID: <CAJZ5v0iYRxGLWgiTD5ouWLy84YN4ddnVshCNgiYJMbLdpK_ZRA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Add backlight=native DMI quirk for Lenovo
 Ideapad Z470
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 12:48 PM Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
>
> From: Hans de Goede <hdegoede@redhat.com>
>
> The Lenovo Ideapad Z470 predates Windows 8, so it defaults to using
> acpi_video for backlight control. But this is not functional on this
> model.
>
> Add a DMI quirk to use the native backlight interface which works.
>
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1208724
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Hans, can you please give your S-o-b for this one?

> ---
>  drivers/acpi/video_detect.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 69ef2d9710c2..af5cea005f54 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -459,6 +459,15 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>                 DMI_MATCH(DMI_BOARD_NAME, "Lenovo IdeaPad S405"),
>                 },
>         },
> +       {
> +        /* https://bugzilla.suse.com/show_bug.cgi?id=1208724 */
> +        .callback = video_detect_force_native,
> +        /* Lenovo Ideapad Z470 */
> +        .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +               DMI_MATCH(DMI_PRODUCT_VERSION, "IdeaPad Z470"),
> +               },
> +       },
>         {
>          /* https://bugzilla.redhat.com/show_bug.cgi?id=1187004 */
>          .callback = video_detect_force_native,
> --
> 2.40.0
>
