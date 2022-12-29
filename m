Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276AA658874
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 02:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbiL2BoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 20:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbiL2BoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 20:44:18 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E2613F4C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 17:44:17 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id o66so16147603oia.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 17:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zvdOLhpklxGCmWEN9Iaf07R7XE10xtjvHpit1Qusal0=;
        b=mE5xqhhcOPU4N2vFU8nNavqToI162YB0dt48dLnGlaOPeGoEyGB/EbCARDvlzu0+Dx
         sPfK3ybkaQqvCO4wqzoQ/Wdk6sfC8/Pg6ESGqd80YGqe+mXvrMx7CFmhA8cxlT9F5GD0
         PQKZEXSTTXyd+IcNbHxvhFH7TvDBuRrsV7mJ7bO9yIxQlltS1m4a2MT/ftceR+JLgmHO
         y8uXgnSpuq5czS93dSnYfSCX7Xlo0NyXcQXR7Hclm44dwhjLCLv6uJXFQu2Blh//Vz5B
         m61QljdLacTab1BGAZnxxuvgSUyJp7BDdPiz+CQgilZEAgC/qHTtEXkLfXhMIa/vXRca
         saaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zvdOLhpklxGCmWEN9Iaf07R7XE10xtjvHpit1Qusal0=;
        b=zn0ZRcuQ2Ip6ughxaNfNtwD9f0uWo/acu9lCcUqPr9Ltz8jbilWc2GhH3GCjy+w+g5
         32IoS7ddrwrcj+TMdgbEfo0fmwkdqa8VFUcBos0d+5/+R+484lQMB3wwmMF7LWVz3DAS
         QfsdDYoFBwGQFnhdjN035QZtYSXZfmtk0v7IL/QlbOCvv2U737a0lYWJ4Gh3E8XBoQC1
         Je7/DBFvEfcDPUjlwcHHQHb+KGOMFgoCxEXHeltL/DBjcfIEPTgUB/0IGugUZacGxCcs
         Y7DTcWzy07vs32oGpANvYZuEONbfnnjvGey/cE8/DtKgXkf1SosH/1NDxl9jMitJVY8+
         6pZw==
X-Gm-Message-State: AFqh2kpnbjZwJzOtpmxsDil6Qwc/8kvvia2L5+LGGttYDK4Uh7HK9uYd
        1lMMqGosM6cTn/pOT1bx4fJ3GiUKiVWqZIRhyJnys4ZwCqfQ7weV
X-Google-Smtp-Source: AMrXdXsMq5fa8H3sJx0sGFLHNUhzXE+kHXhnSuKTKJ3iHPQSwoYzkQHu8BRrKD5yF23pDFoKMOnVXhXMuOoWVA54ZuQ=
X-Received: by 2002:a05:6808:152b:b0:359:c6de:916a with SMTP id
 u43-20020a056808152b00b00359c6de916amr1846176oiw.42.1672278257186; Wed, 28
 Dec 2022 17:44:17 -0800 (PST)
MIME-Version: 1.0
References: <20221220090248.1134214-1-haibo.chen@nxp.com> <20221220090248.1134214-2-haibo.chen@nxp.com>
In-Reply-To: <20221220090248.1134214-2-haibo.chen@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 29 Dec 2022 02:46:10 +0100
Message-ID: <CACRpkdaPQODoiG+ARAiT-6X2u6n7_aCO7Ywj4z=76A65iUhTpA@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: vf610: Support building gpio-vf610 driver as module
To:     haibo.chen@nxp.com
Cc:     brgl@bgdev.pl, stefan@agner.ch, linux-gpio@vger.kernel.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 10:02 AM <haibo.chen@nxp.com> wrote:

> From: Haibo Chen <haibo.chen@nxp.com>
>
> To support Android GKI, need to build this driver as module.
> So change the config as tristate type, and add module license.
>
> Signed-off-by: Jindong Yue <jindong.yue@nxp.com>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

OK...

>  builtin_platform_driver(vf610_gpio_driver);

Then you want something like module_platform_driver() here.

Yours,
Linus Walleij
