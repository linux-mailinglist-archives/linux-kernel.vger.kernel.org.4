Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE3F63530A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbiKWIox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236280AbiKWIou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:44:50 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B46232BA3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:44:50 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id n188so12701248iof.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3lZfEI82UmUSMiDuvBd158Y70vafqY1tMfhM8D96RtI=;
        b=HBAIRoNWWQ9cExkfQ8sq0k283bcqZABHuJWJnKhqZlOxG64aVwVkOg4cCSijv7dnbc
         yD89wMwCSX51YB3lv6ZjYuzK4ERSAmZuGYmIG0rB9I717Y0GCbbrM9kktrdKJblYQjnN
         nTF4V6o1UVqirwksVoorAncCBskzjeppUX058=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3lZfEI82UmUSMiDuvBd158Y70vafqY1tMfhM8D96RtI=;
        b=w077E+8mfql9uBR7CD9w/Ak9t26HClnF3vJZWWy9LCkmCZPPkybVpwTD41Rkxu3BQh
         IN0inwu6xYznjxChtUroHDbtAKBIIan0jho/+Fup6WT0bRcUsSCtufcmOSgT4s5zz9Yt
         NJDzi6jMiOP6ENNoJxIoCuIPoRerPOol77Vw6pmO1ANzgwfnFLTb08OzNfgs446zkWTA
         P4BpgFdpawk2pCVulswF9cxMuHzTVRFEzXMwxBWiW4xQ5IzAE60UiJEG3E97sWkqDSGg
         4x9JE1+mjB6YrAwTFWEe9+KZshrozntOJZx7yU1TeDyrXzrK6Y8wZbQsn6BlgnA3IXzD
         7pCQ==
X-Gm-Message-State: ANoB5pn5l+UG4uw/tnY7ZB6LxsICi9+4DGs2VmCzsPcuCs+QOimP1nfY
        8vA1xRMV9yu9zyPT/KdeXl+Ptv4oReoRFw==
X-Google-Smtp-Source: AA0mqf6TEe2ocPpTfUK7MgxQtM4pB8LbkMuHFVZ2ezZjyDkW+awqf22lKU4DBnaFYnn/wfCxmpWi8w==
X-Received: by 2002:a02:cd23:0:b0:375:8bcb:a486 with SMTP id h3-20020a02cd23000000b003758bcba486mr12040195jaq.134.1669193089596;
        Wed, 23 Nov 2022 00:44:49 -0800 (PST)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id q17-20020a02a991000000b00363a4fcd3a8sm6155790jam.5.2022.11.23.00.44.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 00:44:47 -0800 (PST)
Received: by mail-io1-f44.google.com with SMTP id i85so1427035ioa.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:44:47 -0800 (PST)
X-Received: by 2002:a02:c897:0:b0:374:100a:b0c7 with SMTP id
 m23-20020a02c897000000b00374100ab0c7mr3898004jao.185.1669193087058; Wed, 23
 Nov 2022 00:44:47 -0800 (PST)
MIME-Version: 1.0
References: <a50fa46075fb760d8409ff6ea2232b2ddb7a102b.1669046259.git.geert+renesas@glider.be>
In-Reply-To: <a50fa46075fb760d8409ff6ea2232b2ddb7a102b.1669046259.git.geert+renesas@glider.be>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 23 Nov 2022 09:44:35 +0100
X-Gmail-Original-Message-ID: <CANiDSCvb_HXpx-a9ZmAJ-s23YvefPPJfUy5kHLcEzLUkaKFqnQ@mail.gmail.com>
Message-ID: <CANiDSCvb_HXpx-a9ZmAJ-s23YvefPPJfUy5kHLcEzLUkaKFqnQ@mail.gmail.com>
Subject: Re: [PATCH resend] media: staging: stkwebcam: Restore
 MEDIA_{USB,CAMERA}_SUPPORT dependencies
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2022 at 16:58, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> By moving support for the USB Syntek DC1125 Camera to staging, the
> dependencies on MEDIA_USB_SUPPORT and MEDIA_CAMERA_SUPPORT were lost.
>
> Fixes: 56280c64ecacc971 ("media: stkwebcam: deprecate driver, move to staging")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/staging/media/deprecated/stkwebcam/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/media/deprecated/stkwebcam/Kconfig b/drivers/staging/media/deprecated/stkwebcam/Kconfig
> index 4450403dff41fb64..7234498e634ac61c 100644
> --- a/drivers/staging/media/deprecated/stkwebcam/Kconfig
> +++ b/drivers/staging/media/deprecated/stkwebcam/Kconfig
> @@ -2,7 +2,7 @@
>  config VIDEO_STKWEBCAM
>         tristate "USB Syntek DC1125 Camera support (DEPRECATED)"
>         depends on VIDEO_DEV
> -       depends on USB
> +       depends on MEDIA_USB_SUPPORT && MEDIA_CAMERA_SUPPORT
>         help
>           Say Y here if you want to use this type of camera.
>           Supported devices are typically found in some Asus laptops,
> --
> 2.25.1
>


-- 
Ricardo Ribalda
