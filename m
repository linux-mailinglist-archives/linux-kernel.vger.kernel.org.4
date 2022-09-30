Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08B25F077D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiI3JXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbiI3JX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:23:28 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD352156C07
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:23:25 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id iv17so2511056wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=nwlBl3WOkWLYbhwBjRVN6J+CiBOcKIf/v3V3IeAcAlc=;
        b=MTorrQUAx1IYO4kxQkmj7WvYivInhFhB8vf6WREOiadarHTPrj0ixugxIsFm/dR8yc
         ZrGE/0Sid7ajP4qzyqs04hw9Et4+8i7MqkxcQ55Wdq4K8YcrXahfZqz7FJqLxhtC7XFS
         NvB/noDUb/gRUkB+RCR8FVgr4trWos03RHFQi0F9f1IBLGQHI6NJY9bxWBW91rPmSsPO
         tsUxvwqoNJGg0RlbK+QVMbPQd6eNmDATGtjyjxSir52l4ao2qDCDtcZeNabHAfQpplO2
         k3r8Uk8SPUgdPy/RicsezGiaW+w9WG9m+dyO1tXGlcI3cPWW3K+K3RdUkcfP3cH8DUXv
         pjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=nwlBl3WOkWLYbhwBjRVN6J+CiBOcKIf/v3V3IeAcAlc=;
        b=gkBBweNAxKhsj37AZwh166uESnGJkk70cLO3BOhcHP4QfIxTkagMbED7phOsQfKSsv
         QCx0LdpLfhWcvafChAYhfyjdHF3KrpBXkPyEAEKSWMfYVMo0x5x3RBInViYndiUpRgsG
         ySNVhHrTMuo9qDJXwO4sz8GoI2Z9aLRP+YUYX8KJhNfHgEP3BKfSMS4LMuAaCX6acdrH
         eS4j+FU8ZK/HffdHyghgMLj2SHvsxV+2hpZL4hJiwqCGuv3Y7T3c3D+bLNZumQZaO+VE
         p28vPbkAX0U4MfLtck727YNpbDLwMGvhc2xlZYBiz5QUOwJefm8/3xFqTBQB6DwSrTFe
         Onnw==
X-Gm-Message-State: ACrzQf2qvht6TpdOeRoYeWqMFBXhiPKcaOEyfHqlNEkDg0so4elEqUXj
        Znp6FXjg5damc0WrpSENvxve71JhNOtElGtHHt0Y9w==
X-Google-Smtp-Source: AMsMyM7hZgvnLQUTJbSF5GKcGr/+Z7KDuVSmXLaw2NbCT4ELsxprkIBVb+XVrJTCNVy2yMc/Fs+8PhMEwFrMsWbUiBc=
X-Received: by 2002:a05:600c:b42:b0:3b4:7580:a995 with SMTP id
 k2-20020a05600c0b4200b003b47580a995mr13825515wmr.30.1664529804145; Fri, 30
 Sep 2022 02:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220920103108.23074-1-jay.xu@rock-chips.com> <20220920103108.23074-14-jay.xu@rock-chips.com>
In-Reply-To: <20220920103108.23074-14-jay.xu@rock-chips.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 30 Sep 2022 11:23:13 +0200
Message-ID: <CAMRc=Md9Bzjn16eU73SOKeRnBgk3Fg_wNXjpnG_xZJxy6i08SQ@mail.gmail.com>
Subject: Re: [PATCH 13/20] gpio/rockchip: disable and put clocks when remove
To:     Jianqun Xu <jay.xu@rock-chips.com>
Cc:     linus.walleij@linaro.org, heiko@sntech.de,
        andriy.shevchenko@linux.intel.com, robert.moore@intel.com,
        robh@kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, lenb@kernel.org, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 12:31 PM Jianqun Xu <jay.xu@rock-chips.com> wrote:
>
> Match to the probe, do disable and put the clocks when module to remove.
>
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> ---
>  drivers/gpio/gpio-rockchip.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
> index 511e93a6a429..1a800f972594 100644
> --- a/drivers/gpio/gpio-rockchip.c
> +++ b/drivers/gpio/gpio-rockchip.c
> @@ -757,7 +757,10 @@ static int rockchip_gpio_remove(struct platform_device *pdev)
>  {
>         struct rockchip_pin_bank *bank = platform_get_drvdata(pdev);
>
> +       clk_put(bank->clk);
> +       clk_put(bank->db_clk);
>         clk_disable_unprepare(bank->clk);
> +       clk_disable_unprepare(bank->db_clk);
>         gpiochip_remove(&bank->gpio_chip);
>
>         return 0;
> --
> 2.25.1
>

You're putting the clock before disabling it? That doesn't look right.

Bart
