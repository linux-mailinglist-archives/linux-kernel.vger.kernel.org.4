Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CC45FEB84
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiJNJ1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiJNJ1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:27:10 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96709EA685
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 02:27:09 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id o28so1976027vkn.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 02:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LLgktRizxyiSlwLKUxpQrKAYFD0bpIdLB68C0J0ci5Q=;
        b=SOH9kLRJs09NOGGSf1tXxzGQfwSN+h5ohkSyeeMIWFv0toX7xszn6IguWhPHsvZSgF
         5J3nKvRA/xGz64vOzukVoVG5ZiWfdBDbmzbAz+ovNxfJpMSfdPkEYQIgbOOJ0MZ1eTlg
         DlNnSG8698LwLXwIG7zpnhshTuHS7LeiUoIQboN3yfWfu0AKucsktS2P2kMiBykz7mph
         YnY1ehXE9BMkONDUH9RigTii0NDDiCh14Jy/DXvrVdTU2MzXyuOn2WbS1hTGMI7WVuij
         tJ152ND9Er9fOQioSk6vmJ07o8lrKS32E2qLjaslpJLn8mTdxK2osJTu3aL4m3ePDy/c
         LBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LLgktRizxyiSlwLKUxpQrKAYFD0bpIdLB68C0J0ci5Q=;
        b=0VFk0va6oujKF9W6OhAUTGGsGNm2z4wxGAEogcuaXcaxOJvGmtWKFE4MSD+yfk/+AI
         BBY63ik/wStZBzJoyk5tttNkoJZnThmURabWrzsmdba/fgXvHAP3J4Jb9HlUqa8CML0q
         ck7/Bpnwn3WV4gSCtUscXSL0sq4eJpz8UvoZ7cw3owcH9Suw0P5mXsQ87BJV1EgX+gWq
         uMZ3VVBcftMcGHDYycHQyJalOzAfMn1jkr21qaGnT90f0dwKn9D3S2Vn6qxVJQI13zWA
         kej3pUmAsp9VBso4VXhWqofY8+htJ/cekw55luuQHi1iZolJZCufPZ1pQwX3NBYIqJHe
         aZRA==
X-Gm-Message-State: ACrzQf0u6/bvt98NYyLm6h+RrQL0CnToqMKn/r+51HblYpvrMVz5AHWU
        0SUDQHU26tSHrZeznvkk/oypN8yo/7aN7oYxsQs/dA==
X-Google-Smtp-Source: AMsMyM4pd7ei8k7Iee4vxwNY7YzxX4DvVMIzjklo8h8WqSBzwNC+7Mw/jT7qdxsx6E9wPShJqgRTRnHU7iFar8UNzYs=
X-Received: by 2002:a1f:e944:0:b0:3ab:334d:2896 with SMTP id
 g65-20020a1fe944000000b003ab334d2896mr2056953vkh.5.1665739628732; Fri, 14 Oct
 2022 02:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221013001842.1893243-1-sashal@kernel.org> <20221013001842.1893243-23-sashal@kernel.org>
In-Reply-To: <20221013001842.1893243-23-sashal@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 14 Oct 2022 11:26:57 +0200
Message-ID: <CAMRc=McRO9p5y9SGoE=z-_d_AkdNijxL_xoSczXN1JBo=b9_-A@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.19 23/63] gpiolib: rework quirk handling in of_find_gpio()
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 2:19 AM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> [ Upstream commit a2b5e207cade33b4d2dfd920f783f13b1f173e78 ]
>
> Instead of having a string of "if" statements let's put all quirks into
> an array and iterate over them.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Sasha,

This is not a fix, it's code refactoring. Definitely not stable material.

Bartosz
