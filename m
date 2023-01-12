Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2226A667D5A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjALSEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240058AbjALSCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:02:42 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6543558FA4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:26:35 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-4a263c4ddbaso250272107b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JQaxMdq7NWcf4bCI8LzrzNOqDFAvMvCGdVrazsaMUbg=;
        b=W4wxupf3b1VDZ2kK6t05NvPi9QnOdlaIGbf0oy2xfkAO/sAjUM5wkEvsZGMKbQvtVg
         ZLWaHBbweAXMralx+uJcadPRWiaoAAqpKQxuDig0+zHgcAtQkA4HrHk0vBWlFDvp1fef
         r6IT7meS0z5bBJX89TNJfWJcEEMwVpDUyxRPCp51J/l+KrY049N9MsqTwIt2kqKrwNU7
         Ze6fXwIGAC+9m3laBcY/cFI5sxuynHu/z8qb9AMZt6F4Jv6iio+t/jWsy8UMQNxPhafa
         q5GQ/jbYPt2Zum4BYQalMP2rAFL6rYmQsYHVYpWDqvMmDVaabqClElWeba929jlAv5uq
         MfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JQaxMdq7NWcf4bCI8LzrzNOqDFAvMvCGdVrazsaMUbg=;
        b=BcMT9ggKMTzJEWC2L+LucQZU7MGf0RyI5a4NTgp/tTwTD4mCEudgaTziCxnbMqRStu
         YrcEaQece+0NE9uUVHu7dxh4Pob4KTzOaqgCIh36gCpozCPpDLGCJOjEBaOGV2g4Kk0i
         QljbB9uQPH4fgZXgXdc8CvGzdSu8ww/2a9Eeyzw4bizT1GfVPaHTQQBbq2QwEo6ymxJS
         ClUK4RrvLBfBxPc/4pRnje1fmfuAU/p345hN3yvizgaQjfTcR3+BiwL/6+vMnjue+JaO
         g4biqkjBzzrT1Ya7tg3UlNBqgODT1xd8yC57hVrRhTBELVJiOsONmDvb/2mK/GDpgjut
         ONZw==
X-Gm-Message-State: AFqh2koB0Qg/74FHKBXBiQkpAyBVHxVKMZInW7Df44ITiXXNsWYb2Nlq
        j00iiNJH5x0En+WSJok3ii5kiqaLwyV4QzMYfHLeYw==
X-Google-Smtp-Source: AMrXdXsoFkmLucb+Srq6knqX3clTfw6PCkJ0VK93uLlsfcauE4qS4cjj7Jur72WWirRTc7JFs4admBJaXLG7ah45CQI=
X-Received: by 2002:a0d:fc84:0:b0:3df:6a50:40ec with SMTP id
 m126-20020a0dfc84000000b003df6a5040ecmr3487272ywf.340.1673544394482; Thu, 12
 Jan 2023 09:26:34 -0800 (PST)
MIME-Version: 1.0
References: <20230112043908.2938964-1-wenst@chromium.org>
In-Reply-To: <20230112043908.2938964-1-wenst@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 12 Jan 2023 09:26:23 -0800
Message-ID: <CABXOdTeFKyn8nYivWcXATDJmaqM7eJ++VEu_GNLcRpY2cB4iOw@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec: Initialize panic notifier block
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
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

On Wed, Jan 11, 2023 at 8:39 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> Commit d90fa2c64d59 ("platform/chrome: cros_ec: Poll EC log on EC panic")
> added a new notifier block, but failed to initialize it properly,
> resulting in a warning and stack trace (omitted):
>
>         INFO: trying to register non-static key.
>         The code is fine but needs lockdep annotation, or maybe
>         you didn't initialize this object before use?
>         turning off the locking correctness validator.
>
> Initialize the notifier block properly.
>
> Fixes: d90fa2c64d59 ("platform/chrome: cros_ec: Poll EC log on EC panic")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: Guenter Roekc <groeck@chromium.org>

Didn't I already see this ?

Guenter

> ---
>  drivers/platform/chrome/cros_ec.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
> index 4ae57820afd5..b895c8130bba 100644
> --- a/drivers/platform/chrome/cros_ec.c
> +++ b/drivers/platform/chrome/cros_ec.c
> @@ -182,6 +182,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>         int err = 0;
>
>         BLOCKING_INIT_NOTIFIER_HEAD(&ec_dev->event_notifier);
> +       BLOCKING_INIT_NOTIFIER_HEAD(&ec_dev->panic_notifier);
>
>         ec_dev->max_request = sizeof(struct ec_params_hello);
>         ec_dev->max_response = sizeof(struct ec_response_get_protocol_info);
> --
> 2.39.0.314.g84b9a713c41-goog
>
