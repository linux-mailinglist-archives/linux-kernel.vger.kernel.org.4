Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E6E626585
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 00:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbiKKXYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 18:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbiKKXYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 18:24:21 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49146637C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 15:24:20 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id v81so2472279vkv.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 15:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R0k27JYvEYUqXaeQVspvGGVqqBujev8+Mi45jTmwqQc=;
        b=GCMp/0g+b5vkP0vDg7ceN3zhH6JtqTUMLeoWbaBxaYO98xQy+4H2pxyHo/4MDyr/0x
         7LL8PzxceBHRVCRNFNHs5/+EMxLnfpeMIhgMcuIKkmG+xD32hywFFGykCSfG+iKGZZHk
         QR3v0KJF0IRiV/q6onxm1eJVRSa9Bbeb6NUx/1KCUPI5xRtxXB8TtTPQDatHyCiTuw45
         4BMNG8UMUtZHRSfh9g2OHq2mWleCQemkhb006o47iSAkF/TNncv+DbQKqgx7/CMu/YAQ
         n27sKdSilsXbNPQ/scXEssocN8a43rw9YrNMxodXXmiIseQEjvsEBVElAnkaAsT1GZl2
         NVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R0k27JYvEYUqXaeQVspvGGVqqBujev8+Mi45jTmwqQc=;
        b=iAoLv5AcfXhZwhZD2aWzZpVEOT3MCgrCwEzoW8IVsrmIsx+Ig5XqAAQWh7Eoe8NL7R
         PXFpmiK0R5ec/SJGr3mh44Xndtdh7G4NOOMibIWkTiw9TFg5WmeLFPQSNjNwA+LGe8XO
         Zsu4by2ttQxzX8x3s2IIMNHeWfFPb27Bol1+nNZANvdO3UuyObpBwK/k61S3F31FF56R
         LG+oR6WE9vwv3plA0zIpVNu0ANCb/f0zPDiUrT6j6tDMl3KnGxYWBRmTwMQ33KR/zMLj
         g3nlo9ko70LwiMOhgB40Tq94II8gKUJSjULQP08lVtH8ZYwlLParavxWqcu6A8cKqJUU
         Qb5g==
X-Gm-Message-State: ANoB5pmjQwNFnbYvfSWgLVbdZeNwvm0T9Mu7CdCgzBPtUTyTnOCGM5/H
        GAVaoVJm3mnDId9yV5E9W6eFYriJQHwUwDHFzCr0Tg==
X-Google-Smtp-Source: AA0mqf5CeRO/IBYvQ29CZknzZgbQkb4E7DDpv97ncsDk/AqWygzWceJF/cMuZet2yCgaDQsrt1Z8pIY0bc7DXmSTGFU=
X-Received: by 2002:a05:6122:12b2:b0:3b5:e89c:9351 with SMTP id
 j18-20020a05612212b200b003b5e89c9351mr2313158vkp.25.1668209059275; Fri, 11
 Nov 2022 15:24:19 -0800 (PST)
MIME-Version: 1.0
References: <20221111231302.3458191-1-briannorris@chromium.org>
In-Reply-To: <20221111231302.3458191-1-briannorris@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 11 Nov 2022 15:24:08 -0800
Message-ID: <CABXOdTfFbKRvyzcqFbYKX2Lagdm54=GEMEErBa9f-ODPwfMYHw@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: Force synchronous probe
To:     Brian Norris <briannorris@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 3:13 PM Brian Norris <briannorris@chromium.org> wrote:
>
> This reverts commit bd88b965ae8c ("platform/chrome: cros_ec_lpc: Mark
> PROBE_PREFER_ASYNCHRONOUS"), and then some.
>
> It has been reported that there are issues with 'cros-ec-keyb' devices
> that are children of this. As noted in the initial patch for its ACPI
> support (commit ba0f32141bc5 ("Input: cros_ec_keyb - handle x86
> detachable/convertible Chromebooks")), it's possible to probe an ACPI
> child device before its parent is probed -- hence the need for
> EPROBE_DEFER. Unfortunately, poking your parent's dev_get_drvdata()
> isn't safe with asynchronous probe, as there's no locking, and the
> ordering is all wrong anyway (drvdata is set before the device is
> *really* ready).
>
> Because this parent/child relationship has known issues, let's go the
> other direction and force synchronous probe, until we resolve the
> issues.
>
> Possible solutions involve adding device links, so we ensure the child
> doesn't probe before the parent is done; or perhaps some other larger
> refactoring (auxiliary bus?). But that might take a little more effort
> and review, as there are many other potential sub-devices of
> cros_ec_lpc that could need patching.
>
> Note that we don't have the same problem for non-ACPI cros-ec hosts,
> like cros-ec-spi (commit 015e4b05c377 ("platform/chrome: cros_ec_spi:
> Set PROBE_PREFER_ASYNCHRONOUS")), because its sub-devices aren't created
> until cros_ec_register(), or they don't exist at all (e.g., FPMCU uses).
>
> Fixes: bd88b965ae8c ("platform/chrome: cros_ec_lpc: Mark PROBE_PREFER_ASYNCHRONOUS")
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Trying again, this time in plain text mode. Sorry for the noise.

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
>  drivers/platform/chrome/cros_ec_lpc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> index 2e4dba724ada..7fc8f82280ac 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -557,7 +557,12 @@ static struct platform_driver cros_ec_lpc_driver = {
>                 .name = DRV_NAME,
>                 .acpi_match_table = cros_ec_lpc_acpi_device_ids,
>                 .pm = &cros_ec_lpc_pm_ops,
> -               .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +               /*
> +                * ACPI child devices may probe before us, and they racily
> +                * check our drvdata pointer. Force synchronous probe until
> +                * those races are resolved.
> +                */
> +               .probe_type = PROBE_FORCE_SYNCHRONOUS,
>         },
>         .probe = cros_ec_lpc_probe,
>         .remove = cros_ec_lpc_remove,
> --
> 2.38.1.431.g37b22c650d-goog
>
