Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB4A657178
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 01:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiL1Aov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 19:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiL1Aot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 19:44:49 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B103DFDF;
        Tue, 27 Dec 2022 16:44:49 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id pj1so6947056qkn.3;
        Tue, 27 Dec 2022 16:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AVmMB7LWgzdDIBRBEs9sPvtNNzf69pakGxYpB1OitTQ=;
        b=EmI/12RhYqoyRBOJGISVnnAJyd8SrqHywjQceEQHxUb4IWGfUxyMYH6Oj3vA2gemwl
         AanGkRJ/RL+HzJ161PC6ENC/uJJCwX2XqA22LpYHrrPko3aDo/QeFNPaUNFD0s92d/CB
         qqkU3L3cj92IJ6TUQjxR9oPutRRx9N1/CYePYuCCP5lN/wwtW1nzxu48xCXuPodMSsrn
         Us1gz2P/zfmPvH9fzhzU8hlHQWepG0ZLmXeq0yH8su++ManAM6QJos8zGvNrdAdaRptk
         wSXjVQSIJiBqbuMr3oJZ/fGSviUKaUe8EW1f8hE9yto9l8gqPedSSH94Vvsh03Q6OZMo
         kW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AVmMB7LWgzdDIBRBEs9sPvtNNzf69pakGxYpB1OitTQ=;
        b=iTEBb7leJd162y6P7lNeI0W9D8hiioiMrMS0JfrAHUobDZdoVfk4Rs4JDMZfE01V1r
         0jep++59uDOjp9SKyWfbeb9BQWPB632MRYWlBV0WgpswaFJkkDC8biq7SDRI3tXLCHAT
         cGRyQXbjftxntKO39QCpOxGIf4Z3j/MsRntvXQr7zfpGw7caYDDRKGNMKoyxO25/6u0K
         JtJSAJw8f17lN4I8W2npv1tR5fBJSxHiOxS3F941awG2h5Eo1MlDvWPsFOj0bfCu4niF
         EexunRmx9587UO442B5RChCaNE2SIajk7un9yj/t+1ROCm47adjXHwnLfSlX8nv6Rli8
         S/AA==
X-Gm-Message-State: AFqh2krBCA3AwMmxKhYfP4VMqJYGjPMWygd+G3Uf5OZJzQezpaGpJq6j
        RkfUjbw+fLbOiS6OAbQaC3dwubfM216h8L9KfAI=
X-Google-Smtp-Source: AMrXdXvR7x7YM6+Gq7ish224E78nPWdIqhJd3dcvNp6WaxeLjEbrEYNp+Z7vKscJjkyqHGwxbQLF4bHEsp3LditEKCE=
X-Received: by 2002:a05:620a:489:b0:6ff:c2e:c71c with SMTP id
 9-20020a05620a048900b006ff0c2ec71cmr1057568qkr.734.1672188287751; Tue, 27 Dec
 2022 16:44:47 -0800 (PST)
MIME-Version: 1.0
References: <20221227100659.157071-1-jjhiblot@traphandler.com>
 <20221227100659.157071-7-jjhiblot@traphandler.com> <CAHp75VceSOCiu=17jrmHVOaqAoaqw4He9DKgH8Vjw_oYZdi7Eg@mail.gmail.com>
In-Reply-To: <CAHp75VceSOCiu=17jrmHVOaqAoaqw4He9DKgH8Vjw_oYZdi7Eg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 28 Dec 2022 02:44:11 +0200
Message-ID: <CAHp75VfkcZCN+6i9bUAXQbj62GxBAJMwn-5xeU76yTKC7ek7wg@mail.gmail.com>
Subject: Re: [RESEND PATCH v6 6/6] leds: Add a multicolor LED driver to group
 monochromatic LEDs
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     lee@kernel.org, pavel@ucw.cz, robh+dt@kernel.org,
        sven.schwermer@disruptive-technologies.com,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        marijn.suijten@somainline.org, jacek.anaszewski@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Dec 28, 2022 at 2:41 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Dec 27, 2022 at 12:07 PM Jean-Jacques Hiblot
> <jjhiblot@traphandler.com> wrote:
> >
> > By allowing to group multiple monochrome LED into multicolor LEDs,
> > all involved LEDs can be controlled in-sync. This enables using effects
> > using triggers, etc.
>
> ...
>
> > +       count = 0;
> > +       max_brightness = 0;
> > +       for (;;) {
> > +               struct led_classdev *led_cdev;
> > +
> > +               led_cdev = devm_of_led_get_optional(dev, count);
>
> > +
>
> Redundant blank line.
>
> > +               if (IS_ERR(led_cdev))
> > +                       return dev_err_probe(dev, PTR_ERR(led_cdev),
> > +                                            "Unable to get led #%d", count);
> > +
> > +               /* Reached the end of the list ?*/
> > +               if (!led_cdev)
> > +                       break;
>
> > +               count++;
>
> If I understand the flow correctly, this can be moved...
>
> > +               priv->monochromatics = devm_krealloc_array(dev, priv->monochromatics,
> > +                                       count, sizeof(*priv->monochromatics),

Yes, here the + 1 will be needed instead. But I think it would be
better from the reader perspective, as we try to allocate memory for
existing amount + 1 as it would be clearly written.

> > +                                       GFP_KERNEL);
> > +               if (!priv->monochromatics)
> > +                       return -ENOMEM;
>
> > +               priv->monochromatics[count - 1] = led_cdev;
>
> ...here either as a separate line or a part of the above assignment,
> in either case the -1 wouldn't be needed.
>
>
> > +               max_brightness = max(max_brightness, led_cdev->max_brightness);
> > +       }

P.S. Bjorn's address is wrong.

-- 
With Best Regards,
Andy Shevchenko
