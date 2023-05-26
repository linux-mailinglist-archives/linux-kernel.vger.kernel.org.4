Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FE67126A3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243504AbjEZMaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243570AbjEZM3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:29:50 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25404E6C
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 05:29:29 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-4393c1b8d1cso162548137.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 05:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1685104168; x=1687696168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qs34JzNiVRl4b2e/FfxvYd1zSDbIvD7rTBt6yG8u7ZQ=;
        b=D1uQXQWfbis8V/HHd+efA4wAeLIvY5uO+GGez7KOL8eDaYp0T8yU/iORvAMJz+bg51
         yDIhzb1MXXU3BNFWLSAX5a1qnBhfbecDUamjfP76Q3Sc213VTBs23JGsQZU7uQbHTO2f
         hkVqMWjWe9noohA7TMTCo3xGbm0ZkJ89OLGin9QtS2DMMj+0LOIkfo5+4NbCVIHrSvZd
         IJFsTRlcccKFmRD3f2bLl9OjVMU9UG93kZIPX/U1vAhgdMwHMZEcZzHOU7YXK+fnBDUl
         jxp4zbbvwe64F55RfAAeiFSM8nK7zei00gMzx0WmN4fQLRXSEEZ1cQmYqwgll/Q2nJm8
         E5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685104168; x=1687696168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qs34JzNiVRl4b2e/FfxvYd1zSDbIvD7rTBt6yG8u7ZQ=;
        b=KlRlL9IukhdV+0de/vUH6D9PSoFJ0zyihl8KCT7Ri/+LI3eRlQzsjriNC4bmVWp8jT
         5kPBWS3URzF2XOyOZ8SVTh4p1TKT4T0QIy9y+eEJeK1M63YeXl38jfsHVX9cUro/xOoa
         IE7sqfBOdSeY77PcdedcYTpU8+Q9pjncUp3E4GQEpauFW3a5f8mRtlP/LfHNTAWLtOPv
         Wwt50xkbDq46JmE9FROu6D8AxOeq8ngx5VVCGi1Eebate9vnxjWRozo+bchgxQN8sdFK
         QPGTQDnkCKDCluKf4tta5AvADq61aexmGFHC/o5LRV5bYE84spaclh7Zhj3Uf5FK0DEk
         ncgw==
X-Gm-Message-State: AC+VfDyI0mLgsf7LvuJqLybKA8xILVFwl9B0Ix2BDLSR8xxmfq6igu5+
        pfjjw5ZH39J46bq07qXZpzIzCVTZJvqFF3/TyTWj8g==
X-Google-Smtp-Source: ACHHUZ7mBDT7uDE0hTE8QZu9Fx8Yf8rnmeHeBHz97azhVrFzBldYfh+UoieLxWqgej+bytGK85tzT+zWBGEbIpFS2Ns=
X-Received: by 2002:a05:6102:c5:b0:437:e137:3346 with SMTP id
 u5-20020a05610200c500b00437e1373346mr390286vsp.14.1685104168771; Fri, 26 May
 2023 05:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <ZGztRb_CreLi_rYv@surfacebook> <20230524105021.9418-1-pshete@nvidia.com>
In-Reply-To: <20230524105021.9418-1-pshete@nvidia.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 26 May 2023 14:29:17 +0200
Message-ID: <CAMRc=Md+--VhGkyz5+1f+yS6nmNwpxf09HaFTnhyEAzJ6xSavw@mail.gmail.com>
Subject: Re: [PATCH v4] gpio: tegra186: Check GPIO pin permission before access.
To:     Prathamesh Shete <pshete@nvidia.com>
Cc:     linus.walleij@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        smangipudi@nvidia.com, Manish Bhardwaj <mbhardwaj@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 12:50=E2=80=AFPM Prathamesh Shete <pshete@nvidia.co=
m> wrote:
>
> This change checks if we have the necessary permission to
> access the GPIO. For devices that have support for virtualisation
> we need to check both the TEGRA186_GPIO_VM_REG and the
> TEGRA186_GPIO_SCR_REG registers. For device that do not have
> virtualisation support for GPIOs we only need to check the
> TEGRA186_GPIO_SCR_REG register.
>
> Signed-off-by: Manish Bhardwaj <mbhardwaj@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> ---

Applied, thanks!

Bart
