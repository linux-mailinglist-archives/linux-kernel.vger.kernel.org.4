Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9D25EC754
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbiI0PNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbiI0PMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:12:52 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910F81181D1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:12:50 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y8so13631117edc.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=zXKimN4auJa1FuNCWZCgoPHdaRZI8eUov4kEfskoTHY=;
        b=AXbWSfSsDnVMo9fDM5F5y422Ri0feMPF3EugH6ubSc0sV85QBBJXCyfJ9l/1rUrgfY
         /dzLE7gyd6vr81gUg0Mke6nHbdptrtlzUuW80uSHgtSF4pQCsDcRgI8079Y8WrXTP3h0
         cVrhac99DGCiIeFmew2y+7Ke/MXmiibqzFPm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zXKimN4auJa1FuNCWZCgoPHdaRZI8eUov4kEfskoTHY=;
        b=TzEnll2R3DKUNeWRZgx3kVkVZZ4RSud+zP9GhOSB8tDrxTsziBs9dt0IuHfw+7V1BY
         IMyK26fmvHP2le+Lr8EqvrLb4UkDfHhF7u2N7Ip5j0y5AjGJLaUXvuxYtywkj9u9Kvts
         hZY1PI9ONm/0SeZEgrgMt08mdEi4gMNxYWN9eKg6027u0wUz5J54zObhv6bLqmSSxaR0
         Cash3Yg8MkO2QaT2m9Uj+aOFSAYEygx00teNe6lEHWDBR8wtmJ6ACUO5XedFD+YSIION
         UTqY4sk3qMUkkH2Im3L04Ud/Sah3o/QlkUM/lr083Xx4rfqaZQ0wTLiFcCa44iX7WgWV
         9Mlw==
X-Gm-Message-State: ACrzQf0j6dDHUe7P6bJuI4/tbdLPAUthPr1cGeRrCMkeeCL1BTjaMoYG
        Th0Pq28l9NikJYeUzftAj5JKIBMsTwhRjNyJ
X-Google-Smtp-Source: AMsMyM5B3v0U4dKkAh9t3m0cIMExRQAHmi8SKitgwgB8QNui5YG6PawVHobiIaGG9jpknI8ZQIFn6Q==
X-Received: by 2002:a05:6402:2693:b0:450:a807:6c91 with SMTP id w19-20020a056402269300b00450a8076c91mr28556705edd.33.1664291568596;
        Tue, 27 Sep 2022 08:12:48 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id n1-20020a170906164100b007824c5fe95esm939072ejd.50.2022.09.27.08.12.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 08:12:47 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id c192-20020a1c35c9000000b003b51339d350so7231764wma.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 08:12:47 -0700 (PDT)
X-Received: by 2002:a05:600c:1e18:b0:3b3:b9f8:2186 with SMTP id
 ay24-20020a05600c1e1800b003b3b9f82186mr3218712wmb.151.1664291567062; Tue, 27
 Sep 2022 08:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220927021835.488803-1-sean.hong@quanta.corp-partner.google.com>
In-Reply-To: <20220927021835.488803-1-sean.hong@quanta.corp-partner.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 27 Sep 2022 08:12:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UGZnW1dvjprT2Or=+4Tv54DqTK35zUQ4z-Y9e6LHE+Bw@mail.gmail.com>
Message-ID: <CAD=FV=UGZnW1dvjprT2Or=+4Tv54DqTK35zUQ4z-Y9e6LHE+Bw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Fix delays for INX N116BCA-EA2 (HW: C1)
To:     Sean Hong <sean.hong@quanta.corp-partner.google.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 26, 2022 at 7:18 PM Sean Hong
<sean.hong@quanta.corp-partner.google.com> wrote:
>
> This panel has the same delay timing as N116BCA-EA1. So, fix the
> delay timing from delay_200_500_p2e80 to delay_200_500_e80_d50.
>
> Signed-off-by: Sean Hong <sean.hong@quanta.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Please include "Fixes" tags for patches like this, like:

Fixes: c7bcc1056cff ("drm/panel-edp: Add INX N116BCA-EA2")


> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> index 102ab9f5d40a..e25851de7954 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -1893,7 +1893,7 @@ static const struct edp_panel_entry edp_panels[] = {
>
>         EDP_PANEL_ENTRY('C', 'M', 'N', 0x114c, &innolux_n116bca_ea1.delay, "N116BCA-EA1"),
>         EDP_PANEL_ENTRY('C', 'M', 'N', 0x1152, &delay_200_500_p2e80, "N116BCN-EA1"),
> -       EDP_PANEL_ENTRY('C', 'M', 'N', 0x1154, &delay_200_500_p2e80, "N116BCA-EA2"),
> +       EDP_PANEL_ENTRY('C', 'M', 'N', 0x1154, &delay_200_500_e80_d50, "N116BCA-EA2"),

You just sent two patches that touched adjacent lines in the same
file. That means that they will conflict with each other and I've got
to resolve the conflict. :( It's not that hard in this case, but it
would have been better if instead you did:

1. Put both changes in one patch. I think that would have been fine in
this case.

-or-

2. Send both patches in a 2-part series.

In any case, I won't ask you to spin just for this since it's trivial
to resolve, it's just more work for me. Please don't do this in the
future.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

43113fd4c5f5 drm/panel-edp: Fix delays for INX N116BCA-EA2 (HW: C1)
