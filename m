Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32786BAC57
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjCOJli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbjCOJl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:41:28 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1FA25B93
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:41:27 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id e19so10090567vsu.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678873287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKozuywKlHNFG1M+fIENfKeYZSPH074aGyEOF/Nq6hM=;
        b=8BmfpCg3XZJDTeiOOcsSpYcw6Ijfu6fJD2TYIdzKVp6Z/j7N6ROo4qByH0fzqCyYt2
         3VDWxeo+dFKv1jrs3cXCiVKq4mRXQX20XhJ7sEV01Mb1k3rHTtjLWqhtjzeQJxF685dC
         ChcKfgo7z+NDFbcf9VBddQVg0iGfGnbJVQ0lBGw4Ed4Yhba9OLFgKRENj+J9WP3+FuLW
         q5YAvFLum4sUHOojWJS1iUuc116FepbAZ1pl6K3PuCpoQQQE9ZQuEM7eDB7RIwfdlC9R
         dyLqI4rRkGwVGcFKxIdk77vBMAdKWSvQ0oTmdzUX3DPFWoGf2U1gcSXx6pD4Vr4rOfoj
         bqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678873287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKozuywKlHNFG1M+fIENfKeYZSPH074aGyEOF/Nq6hM=;
        b=FonqbuEIxojaI5nUi7RAOpGTrHVunEwv2xJJ9fvarC0+BqWkDFh4/f4aUapYL9PXdI
         ogNvekMnTOabC70ypDe9jQyqbRpopYrdKb5cS800/4ja7VmGMEc4LPdnKZYM0Khqmc8F
         4d3Xr8DR5+AndFLTOuwk0K6vSGtydll9zaAI3PDnZHUu3XCcpuirD+EKQA2WwME6ltfk
         7qbBlARUQkk2WhuktFx9MfL4na+w4x/eB4f5l3/d41zEPJwz94yF2gqIUC5gVtxVduul
         uDYHFz3rPpWoxf4pbdjeVRxptVrqMn4y8sXRf9i/BW5zJVj9eCXDLgSQ3kWMppibuqT1
         GfOA==
X-Gm-Message-State: AO0yUKVl2IMdZZJWAovLzzOrrOQT2iVPAKvt+O6uy3SaoyWnIOYp5kG/
        Gve0djz8SZf6dx31+gkVxm18ympfMGCTcELXstYoTw==
X-Google-Smtp-Source: AK7set9Yge/FICFjx/6zQ2bG1iv5bwIl1WcG4yEKEoLejOW505qcqTYMR04dl2tLn1cchDe9FKQPzHH95gn+xAbtSvc=
X-Received: by 2002:a05:6102:10c:b0:425:aec3:694 with SMTP id
 z12-20020a056102010c00b00425aec30694mr2823481vsq.0.1678873287047; Wed, 15 Mar
 2023 02:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230309185600.84948-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230309185600.84948-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 15 Mar 2023 10:41:16 +0100
Message-ID: <CAMRc=Mfes=70xQQ=ZHsC0DCRVL3_bKc3SESJC-aK1NMzdd6Gig@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Get rid of devprop prefix in one function
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 7:59=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The devprop prefix in the devprop_gpiochip_set_names() adds confusion.
> Get rid of it.
>
> Note we have more than one function in the same module that handles
> one or more device properties. This change will unify the naming schema
> for all of them.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Applied, thanks!

Bart
