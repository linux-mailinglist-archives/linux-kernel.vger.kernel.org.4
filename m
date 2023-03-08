Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3790A6B04FE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjCHKvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCHKvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:51:02 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D06AAF29F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:51:01 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id x1so10898189uav.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678272660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ef983/AOehfuTrHSl44XX8UHyvuKulox9O+KoFv9jPk=;
        b=Pze2C7lWpylDMzWq13sr1zuXSp3kgnKKJi30EgbeD0ZztiM3gdQwN0nbNJycnbOizo
         z7jRUgMo4PL4aReugZH8uTNZofdnScyvQFaYBX4TS0k2agdcGOmbVGFRCp6qgHltQ8HT
         ck5D0+pGkba/gQlEoGK63lb8dwEs04t8sLs8+LOxDudx3Hst9kypdEt+YhPMppFbstlt
         zG0yfCbxZgLSFaEdn2s6/9jGhCSOWGiBzNd33y5N/TLtSQ8aDkm0z1lONrITDXfjVJ4y
         AFQLSNzEkH9yPhYB7PofiLrz8vo9wSW1GmeMx6fo0REYpsgIloxi7SPjR8RwQG3Y5KDj
         7g5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678272660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ef983/AOehfuTrHSl44XX8UHyvuKulox9O+KoFv9jPk=;
        b=EpwtPrJyocW8NtP49Zrsw6iWf4Y4NCJwaK3ewu0aJaFXaP6ooJAdAdSA2kje6mdWpM
         7BOtn+VEu8IdSy7nPegz95lWqr/PQiHvKAsVs33hQi1uLh22dfcMK2G2JovDHA+qkAQB
         n6frDoQHn33zyEDmEra8RYQWxptyEC5T0zva0KyHLEWJ4zE1Aar2xRWBTRTEBOiCeMB/
         tWVKOsU8alVLJlM+g1PgB5UW20/ha73T2hvzxmQQLYgXT9UFB7jZ7NPC8nJVhTIjqDtM
         PhucdSH+98U4D2tSVBt9+Nf3BxRooTc6UBlERW2lDxoMExOZK5EagSO8mVwaKRXAiJor
         2W+A==
X-Gm-Message-State: AO0yUKUiCNbi/R4qxgCHdhJPieWGmrNEevzr408iDM+/WeyJFGf3nKRY
        nLsZbFjuibhCnI74hNwPCXSPgo5aoTLyRYz3Y2XPGn09mMO5316s
X-Google-Smtp-Source: AK7set/hautO/JuZVqVcpIjSQd/R1iuEi4e77QWPdm9ouCbUx2LGGQvzoei0RpLdyQQLnXwObBCEN0KebrcWJ4BSZ5Y=
X-Received: by 2002:a9f:37ab:0:b0:67a:2833:5ceb with SMTP id
 q40-20020a9f37ab000000b0067a28335cebmr13370413uaq.0.1678272660417; Wed, 08
 Mar 2023 02:51:00 -0800 (PST)
MIME-Version: 1.0
References: <20230307182557.42215-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230307182557.42215-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 8 Mar 2023 11:50:49 +0100
Message-ID: <CAMRc=MetDO+mr6F8oKSkW3G8vv3nV+K-8QHM+Eov0s_3eCG2HA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] gpiolib: cleanups WRT GPIO device handling
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 7:25=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> A few cleanups to GPIO device handling in the library code.
>
> Andy Shevchenko (3):
>   gpiolib: Access device's fwnode via dev_fwnode()
>   gpiolib: Get rid of gpio_bus_match() forward declaration
>   gpiolib: Move gpiodevice_*() to gpiodev namespace
>
>  drivers/gpio/gpiolib.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
>
> --
> 2.39.1
>

I applied the first two patches, for the third I have a comment.

Bart
