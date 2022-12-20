Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB58652376
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 16:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiLTPJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 10:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLTPJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 10:09:55 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60645301
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 07:09:54 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id t17so29966044eju.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 07:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1MJr5lFV5nhRPoqsOj5t1c5SzwCs5Lg+OTuhWULRuVw=;
        b=MykL2hB5O5a1AHoo0FMfUfeBRgpfuNYmh6vyM3MsgKyDS+HgvfrF8B9UGkghR9VNOm
         RJvYcxPucN6awqURznsvrtQOSTiygajFgWBsUhk4r51xAOGxDv33l1gJ5xuw9lissQL/
         5vbqWT/Xh/qMZuwge27Zw6qwss4fSTcQADAi69lOivRVXZahHsxyxT01934JFSDyTmH7
         vNCk39LPxkzmn7Ehah1O4gW9CeUWdl6EI5/D4WX6YQPTMQUnLQHWmbkLleDjL/erB2MW
         9hX/GPosIN5eP705ZX10i9WjYlLKruiKXDKDniMS+EYR6kelsWcYDdHal77iIh06AZg7
         +NzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1MJr5lFV5nhRPoqsOj5t1c5SzwCs5Lg+OTuhWULRuVw=;
        b=1USc2svU6oUIVrLGtYP2Ew5DOFKH59jfzV4OjYumf7B4sd3804/BEHq7Cywx76kJHz
         OTPCLkg4++f/KUlSTyZoLXhzGnCKE9QjvkYCTLLyo2xBnLU9HKTJyu4zQMhMNtSdaPKn
         zSI3MLeDSsdyTMYioO1UrmjSDOpgzGwK6AeiyEoPeWdz3QGzNgZj4JLh0LvTmU3f+eil
         G+5VPIlOM/cEcbTFhtUzLOau1ZY3I4IXq9rCuXqAouTKJ/sj2IZXv2AQ4g6100kWJihP
         t4KFlprHXIw5PpXuT1v9MJv0ZSBzpukbFvxa3vlUdqy/4YKSPk9wrqG56GLthfxFhG/2
         yQfQ==
X-Gm-Message-State: ANoB5plRQuUDYMzEZ2BT+WOEQpzAfQ4+TJ7bDZyMRr8ZHUOvULxVYo0t
        nD0xzc3x54vEVBzHIM6RBrYbL5J0y8qhsIGm6Irs0g==
X-Google-Smtp-Source: AA0mqf7scMAiQ6lGJpfP2Y5U6FnUI3WNVJtfOpsp8aUPHgMcLgIDBBAEzETiZizCBQm672z5sVlGsDXzmPJTl/ZXkns=
X-Received: by 2002:a17:906:4d88:b0:7c0:bbac:1921 with SMTP id
 s8-20020a1709064d8800b007c0bbac1921mr25738321eju.530.1671548992860; Tue, 20
 Dec 2022 07:09:52 -0800 (PST)
MIME-Version: 1.0
References: <20221220055954.11197-1-zhouruihai@huaqin.corp-partner.google.com>
In-Reply-To: <20221220055954.11197-1-zhouruihai@huaqin.corp-partner.google.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 20 Dec 2022 07:09:40 -0800
Message-ID: <CABXOdTeJuFn-23OiTshJTQWMBvkiqOXUh6S8z354eEPzj+q4Ew@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: deferred probe when typec
 count mismatch
To:     Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>
Cc:     pmalani@chromium.org, bleung@chromium.org, groeck@chromium.org,
        knoxchiou@chromium.org, weishunc@chromium.org,
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

On Mon, Dec 19, 2022 at 10:00 PM Ruihai Zhou
<zhouruihai@huaqin.corp-partner.google.com> wrote:
>
> The kernel bootup is much faster with normal mode. In this case,
> there is a chance that the cros-ec-typec module get the actual typec
> port counts but not accurate from ec before ec is able to setup it.
> It will block the HDMI mux function.
> Hence, return -EPROBE_DEFER to put the device onto the deferred probe
> list when the typec count mismatch between ec and node.
>
> Signed-off-by: Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>
> ---
>  drivers/platform/chrome/cros_ec_typec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 59de4ce01fab..d821501e875c 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -382,7 +382,7 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
>
>         if (nports > typec->num_ports) {
>                 dev_err(dev, "More ports listed than can be supported.\n");
> -               return -EINVAL;
> +               return -EPROBE_DEFER;

I think that is problematic. It might as well be that nports >
EC_USB_PD_MAX_PORTS.

Is this really seen in the field ? The EC should never report a wrong
(random) number of ports. If it is not ready, there should be _some_
indication that it isn't ready. Does it really report a more or less
random number in this case ?

Guenter

>         }
>
>         /* DT uses "reg" to specify port number. */
> --
> 2.17.1
>
