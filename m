Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2D85BEFD0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 00:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiITWKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 18:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiITWKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 18:10:09 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9510F6DFBF;
        Tue, 20 Sep 2022 15:10:07 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x27so6274716lfu.0;
        Tue, 20 Sep 2022 15:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=f4wrYrX9xUZASPQBsArSMfjud8f9nT+j2jwCVZE2lEI=;
        b=X+GmKtaxKp3WxkDSZeka74Kfmp2Fn5YeUd+Ah8yoSmqWqtm6m81+XfOVgwbsoE7do9
         /qJ188ee3UCQIW+Iw9rWkF3syGO1VTsuuAxku44mei8Bdc+EWqIRK+wyHB4tp5p9ykbh
         HhOq1PVRHKOWU/6f4mk+0Fe498Oarl+DCkeFCVdrX7RN0G+eLetK00GKjNi35bcOp46b
         0WGvJHd9IJGa+MEE9BHflFXiUznZHOkUTIs2bUm9hjmeY4wD/P9WICTbfKy1wmO58i25
         a8eFasFdZym2qlxV3gvneQIfd8tq29xZ6ZKwZP9sJsYKqSWQJhrpEgJCKG5VleApbPwb
         ZM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=f4wrYrX9xUZASPQBsArSMfjud8f9nT+j2jwCVZE2lEI=;
        b=07E+kxOc3vooLKduuI8+fkGkMQ+A+FBGz/z7hM2AkH0WniWhhhxDJEmi2ZOAXYtbp8
         /ci72nlukEg/bXCPCO9qwAwZ4Tf1vjIHiOU9xFgzzlTfhTcsq7D5qfJaKUfpC97CUK0+
         fCbpGnYQ1g+160usCaWOlOS+0+q9cGNRusQLQBxZa41vjNiHhOVh9dhFQpRXdJarTA9P
         c9YM8tSbLIHEEdS6aIZX5IQImnst6piO2IYPeJCBef3u3/hTa8X9IUXtDcB845nCXBL5
         y8LEYolWUnrzQmNpnWhi2x3y0ewMrw1M4Dl0JbyGLgiqPSUJEteCrTjfkK0S4BcFQrX7
         nzKw==
X-Gm-Message-State: ACrzQf0EzdR2OTne5NFVzkW/zlD/B6etZbHhrZTzGIPgQWiQj7rtelvm
        zaz9YtvsqKQozV/S5fePEERSbGtT3kyqS8qxzS3M8KxTddQ=
X-Google-Smtp-Source: AMsMyM7aDWqh28Ry4Osnrwf5fY0mpMvcr2IWwW18V3L1JmB8kr4Ge5OhCfLR8DIvpupi5cJf1nP83qs5PzU/RJCYvIU=
X-Received: by 2002:ac2:4a61:0:b0:497:ae0c:4f66 with SMTP id
 q1-20020ac24a61000000b00497ae0c4f66mr8561527lfp.660.1663711805984; Tue, 20
 Sep 2022 15:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220415100432.23453-1-icenowy@aosc.io>
In-Reply-To: <20220415100432.23453-1-icenowy@aosc.io>
From:   Daniel Ogorchock <djogorchock@gmail.com>
Date:   Tue, 20 Sep 2022 18:09:53 -0400
Message-ID: <CAEVj2t=zcyRvn=eCvB1CtGNPOr9_g4catjPkV+WNKk-bvGmymA@mail.gmail.com>
Subject: Re: [PATCH] HID: nintendo: deregister home LED when it fails
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 6:06 AM Icenowy Zheng <icenowy@aosc.io> wrote:
>
> Some Pro Controller compatible controllers do not support home LED, and
> will fail when setting it. Currently this leads to probe failure.
>
> Change the code that fails probing to deregistering home LED.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/hid/hid-nintendo.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 2204de889739..ed93287c3afc 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -1900,9 +1900,8 @@ static int joycon_leds_create(struct joycon_ctlr *ctlr)
>                 /* Set the home LED to 0 as default state */
>                 ret = joycon_home_led_brightness_set(led, 0);
>                 if (ret) {
> -                       hid_err(hdev, "Failed to set home LED dflt; ret=%d\n",
> -                                                                       ret);
> -                       return ret;
> +                       hid_warn(hdev, "Failed to set home LED dflt, unregistering home LED");
> +                       devm_led_classdev_unregister(&hdev->dev, led);
>                 }
>         }
>
> --
> 2.35.1
>

Reviewed-by: Daniel J. Ogorchock <djogorchock@gmail.com>

Thanks for the patch. I haven't done any work to make the driver
compatible with non-official nintendo controllers. I suppose there
aren't many other options for controllers lacking full functionality
other than disabling those functions during probe, as demonstrated
here.

-Daniel
