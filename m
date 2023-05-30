Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25319715C3B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjE3Ks7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjE3KsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:48:23 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B40B129;
        Tue, 30 May 2023 03:48:21 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-96f6e83e12fso671733366b.1;
        Tue, 30 May 2023 03:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685443699; x=1688035699;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0/shAfU3X+9Ct8Swm+aM2sg+XEWHH3/NKe5ZiJuDcpQ=;
        b=Peo7zpDLzJpHLeGfk14ydqqtN3Aov4htfKG/Zi86lcc3B0VypdsWSAjzxA6kLT3CZs
         fVQQLQbU6dmArhXDGtmX+EWlrd/ZbX5jEX/qepRiyayNrJ3bwQKiB4JaouRsrXXjZ3Hs
         tA09dPp16sjjz0jBBU/vWrVP9Z1VIaDQWDe9SWMUj4gd7j9hkK5grrCwzdmNPEw1mPnW
         Lb6BViih7nE286g+f2wGUY3LPMvHTkd+iORqKk/OXLiI0kiKhta9zBqAwm+Mr5Z09dAq
         URZ9XNvTKHZa14IuW/fYCGVXBu9z8xrppYOm9G6IHbUAh9TzUYPznCiyeaRDcO8WrKvF
         j87Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685443699; x=1688035699;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/shAfU3X+9Ct8Swm+aM2sg+XEWHH3/NKe5ZiJuDcpQ=;
        b=ds0unpu4yvwp2MpsE+S3f2we/5nBQiBHlC2MqYXzmoMbml2WbUZT8Th+8BinFixik4
         RMN10UwDB2Jx2w5GOcINBSvggJn4OTLlsCPjqpUp/fxJBOsJJyALFYThik2nTNaYsrN/
         QBhW6eUkxYaa6y7+Fyx1uKqwp+B32jdG1X5nZxCkejfhObt/3mtNYbvuxUIChdysEy+h
         kIWSZmq/x98WcXFJFNTw7AIAMCzAzsQM8fSb2pnRfzehvXekhmOLPcVzZ6ShrMBlmlpn
         BNGngJr7iynR6oMn0vkC2BPX2Ec7IcsPXvV8Dk88zKHS0IZyOgdk9qdps3buujZZq2Ru
         5H6g==
X-Gm-Message-State: AC+VfDyK7q9Ux+2qOjR1jbLC+xxXZYQpfy/WG5yE1U2e5whjthWiaJZ7
        yy1uUEo0q6Aje4GHtfJMUwo8fg4oTLpx3yCayyw=
X-Google-Smtp-Source: ACHHUZ66aUpGdx3SrVI039+GRR+P6nqV61bDu+MzpxcBQzP2ImGNj7ti4xvmYnokcVD1/KsKvVga8Ea6Bbr6HOQ5Pu0=
X-Received: by 2002:a17:906:5d04:b0:96f:bd84:b89c with SMTP id
 g4-20020a1709065d0400b0096fbd84b89cmr1803433ejt.70.1685443699262; Tue, 30 May
 2023 03:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230523171240.12930-1-osmtendev@gmail.com>
In-Reply-To: <20230523171240.12930-1-osmtendev@gmail.com>
From:   David Rheinsberg <david.rheinsberg@gmail.com>
Date:   Tue, 30 May 2023 12:48:07 +0200
Message-ID: <CADyDSO7Lchnraz8pZJkgDBg=YiEG51kcSd+_yg55GpJOuHk6wg@mail.gmail.com>
Subject: Re: [PATCH] hid-wiimote-debug.c: Fix error checking for debugfs_create_file
To:     Osama Muhammad <osmtendev@gmail.com>
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, 23 May 2023 at 19:13, Osama Muhammad <osmtendev@gmail.com> wrote:
>
> This patch fixes the error checking in hid-wiimote-debug.c in
> debugfs_create_file. The correct way to check if an error occurred
> is 'IS_ERR' inline function.

Please have a look at fs/debugfs/inode.c, especiall the docs of
debugfs_create_file():

477  * NOTE: it's expected that most callers should _ignore_ the errors returned
478  * by this function. Other debugfs functions handle the fact that
the "dentry"
479  * passed to them could be an error and they don't crash in that case.
480  * Drivers should generally work fine even if debugfs fails to init anyway.

I think the current code is fine. If you feel like adjusting it, I
would rather just remove the NULL-check.

Thanks
David

> Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
> ---
>  drivers/hid/hid-wiimote-debug.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hid/hid-wiimote-debug.c b/drivers/hid/hid-wiimote-debug.c
> index a99dcca2e099..eddd981fee1a 100644
> --- a/drivers/hid/hid-wiimote-debug.c
> +++ b/drivers/hid/hid-wiimote-debug.c
> @@ -183,12 +183,12 @@ int wiidebug_init(struct wiimote_data *wdata)
>
>         dbg->eeprom = debugfs_create_file("eeprom", S_IRUSR,
>                 dbg->wdata->hdev->debug_dir, dbg, &wiidebug_eeprom_fops);
> -       if (!dbg->eeprom)
> +       if (IS_ERR(dbg->eeprom))
>                 goto err;
>
>         dbg->drm = debugfs_create_file("drm", S_IRUSR,
>                         dbg->wdata->hdev->debug_dir, dbg, &wiidebug_drm_fops);
> -       if (!dbg->drm)
> +       if (IS_ERR(dbg->drm))
>                 goto err_drm;
>
>         spin_lock_irqsave(&wdata->state.lock, flags);
> --
> 2.34.1
>
