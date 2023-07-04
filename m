Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC1D747759
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjGDQ7I convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Jul 2023 12:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjGDQ7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:59:07 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EA2E7A;
        Tue,  4 Jul 2023 09:59:05 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-98273ae42d0so172555066b.0;
        Tue, 04 Jul 2023 09:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688489944; x=1691081944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAlSSxBehGH6lUwuQMai6c7y1ew80Y5pcnFyOnaXcsM=;
        b=ILyd5PFbo7345lbPiobk+RvEk53V9ETVPH8Nt2YCkAet6VsS3Xl53LbYj9ye6Trswk
         A51tEj7gYkWngixh4h3bPYgJNB84Yn7ga88DIL1jxx4ItpyVdx4HabCPHY0Z3rZajCbk
         4x/0pSt2QQioNVOwRwK63xtR4NxjWnW3N7+hmmNsivjwsETEkgj2AyZpsX+O7vcxUih1
         3bem1Q6azcPxGlKXTFz5RU0eFh1sq1o9CNUmaLjaAKAylKRoJCpob0zzhE4fAFIEtFc4
         aZZsl2EoXc1KmAFwLN2XK7EFnPEWgQ41KNxuY761udumzD2h//JwLzQKHaMJR6DX+HQW
         Fv7Q==
X-Gm-Message-State: ABy/qLavIGB+OZycVDHK/OjZvsrpzcLPBPxcfEAy96anvUuui7mER8nk
        4yzyh2bxWxbtI8eU72At49UsDHeAjJL8LuJ/IH3T9IvZ
X-Google-Smtp-Source: APBJJlE8/xMyNdRtuI1jlQtIf6BWl4dUxua12L5DUFMQxeCsWS1oh8+0+LOear6ys+nGi6Wr8ydtc5szpYFhf3KPBYo=
X-Received: by 2002:a17:906:35d5:b0:98d:eaa8:8c27 with SMTP id
 p21-20020a17090635d500b0098deaa88c27mr10842186ejb.1.1688489944072; Tue, 04
 Jul 2023 09:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230704074506.2304939-1-kai.heng.feng@canonical.com>
In-Reply-To: <20230704074506.2304939-1-kai.heng.feng@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Jul 2023 18:58:53 +0200
Message-ID: <CAJZ5v0jwO1NJ_x2t3RV-kYDmVY9UtyexznCSZMAmQ-gK4dWCmA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Invoke _PS0 at boot for ACPI video
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, Jul 4, 2023 at 9:46 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Screen brightness can only be changed once on some HP laptops.
>
> Vendor identified the root cause as Linux doesn't invoke _PS0 at boot
> for all ACPI devices:

This part of the changelog is confusing, because the evaluation of
_PS0 is not a separate operation.  _PS0 gets evaluated when devices
undergo transitions from low-power states to D0.

>     Scope (\_SB.PC00.GFX0)
>     {
>         Scope (DD1F)
>         {
>             Method (_PS0, 0, Serialized)  // _PS0: Power State 0
>             {
>                 If (CondRefOf (\_SB.PC00.LPCB.EC0.SSBC))
>                 {
>                     \_SB.PC00.LPCB.EC0.SSBC ()
>                 }
>             }
>             ...
>         }
>         ...
>     }
>
> _PS0 doesn't get invoked for all ACPI devices because of commit
> 7cd8407d53ef ("ACPI / PM: Do not execute _PS0 for devices without _PSC
> during initialization").

And yes, Linux doesn't put all of the ACPI devices into D0 during
initialization, but the above commit has a little to do with that.

> For now explicitly call _PS0 for ACPI video to workaround the issue.

This is not what the patch is doing.

> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/acpi/acpi_video.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 62f4364e4460..793259bd18c8 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -2027,6 +2027,8 @@ static int acpi_video_bus_add(struct acpi_device *device)
>         if (error)
>                 goto err_put_video;
>
> +       acpi_device_fix_up_power_extended(device);
> +

I would like to know what Hans thinks about this.

>         pr_info("%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
>                ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
>                video->flags.multihead ? "yes" : "no",
> --
