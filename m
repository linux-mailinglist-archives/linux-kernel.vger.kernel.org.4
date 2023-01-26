Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5AF67CB01
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 13:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbjAZMkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 07:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236057AbjAZMkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 07:40:12 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B1F5FE9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:40:11 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-4a263c4ddbaso21777707b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 04:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GEX5lf6MBwTPGO3Prne8BbweggqLOiMRFsUsGtWJrvU=;
        b=r6ToREH7Nx6sGWbq/rPNO6W/JE9gJlL6pBUnkMyjUJezIcPgXUy8fB/FsNEQ3sK3HJ
         g3UV1nuOXtoxVjwOwkfYENrgc7MChyKzoGrTZSELWQyoPBSoRqG7x/WJdKwN9ehOkd31
         dr+f51vyogIX4pmU9DldqJxUqafcz2R+wpSYzgxyOcmaBMFqZTnv5GeKNnzzsLskA3Ul
         QQxzx06sqFqe/Lp/g0XT5tTtl8JLGy/2dNrtTnIAPyqoTg3z3ohIgpCAAPuu0LyToK8Q
         9a7RPizX1HSbLP/NtfNlUNQlM2SBeeXOyHCJ7NkbDuJjOxgXYPUoXaa7iGGE4l4X6RUl
         kPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GEX5lf6MBwTPGO3Prne8BbweggqLOiMRFsUsGtWJrvU=;
        b=mdU2a1zfXXVXscAGOffocuXeyS6W7LlpvfxKlJSUoa8hGKVOG+W5vkpB9hRk2gewxJ
         C8izrMa2gWtVRNI7jCVyzGMKu35/GyX6PNT3Rjn1NCaALjd1+vfYdZ++LtIQACaQnU0m
         JNv4HcjUXCE+l0LUw8h3jjNzYS2VbSw26qZvCZrhxUGLfkvobA+litlKfi4siTLilySJ
         rGG7NrBdmYsp5HdMc3Cb3AW8KrRzvkz658DfmliAVNKZq/T2D+NTN0iaB76Vh5M4kJ19
         cWB/0Mq46QAcYT0aPZuzmAtSbwGDLN1JfIQcnbrgGDmPjl7c4o3dlH/QmnAuvAztCexe
         sYiw==
X-Gm-Message-State: AO0yUKWcyCVINJkE3hRj/VriKf0pNK3bDu3UifVCf5O+kr2ohCDkZC0m
        rJ98c2jkI2zGqmcKIFewZUpEc1QylHurryw14eIh6g==
X-Google-Smtp-Source: AK7set8RjLb7z41Gv76XqOKjR54TWgSgujYg8aDioQtjXKr37Z3orGgLa/HEhUfc3MhJwb3SxyzIBClY02+Cl7z9Z2A=
X-Received: by 2002:a05:690c:706:b0:506:6952:b9c9 with SMTP id
 bs6-20020a05690c070600b005066952b9c9mr752411ywb.477.1674736810953; Thu, 26
 Jan 2023 04:40:10 -0800 (PST)
MIME-Version: 1.0
References: <20230113215352.44272-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230113215352.44272-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Jan 2023 13:39:59 +0100
Message-ID: <CACRpkdZ+uVV3y83bPH9bC_6_umsHEXUMwBYY_zw1H8ABQKpnYg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] gpiolib: get rid of exessive ->of_gpio_ranges_fallback()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 10:53 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The ->of_gpio_ranges_fallback() repeats the idea that lies behind
> ->add_pin_ranges(), while the latter covers more cases that the former
> hook. Drop the former one for good.
>
> Changelog v3:
> - moved check of the property presense to GPIO library
> - split out the refcount fix in a separate patch
> - added cover letter

Patches applied! Sorry for taking almost 2 weeks :/

Yours,
Linus Walleij
