Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357F861F0A5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 11:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiKGKaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 05:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbiKGKac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 05:30:32 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF7B186C2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 02:30:31 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id g4so6307764vkk.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 02:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+8+uu9kKMEq8Y9OytB8gsVKut4lj3U0/a/S35uT3UQU=;
        b=MDTYVKCNb0/qgY91nHj/Ep35Uoawu+BRg898hqS8zg/Je5DSaYTXknBqq7645UiEGb
         mKIf5IfDCiYNikSC5gV+YsfKpkEZBFDrtQW+E7SGZl53VB1+CSORJ1wKHVVWBIbWfGa5
         nepqOj5o1L74FadAoIMIuvYubN3MPSHk3Jf3HhhZgTjPMVdKvTe9dY1+/2BEsJRRY9/3
         qdvNqs+AN6uFaVshhSTH9LgLvI0Z13z/iiSBHmbbIMo2sRKh8O3SYIRl6BFN8D299Yms
         9F2l99bQgu4KlGxqwV0y8DKInddibkNB2OmXb7QBjn+76h7KtF/Rhn33LSn6Kq2kmUJy
         Vzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8+uu9kKMEq8Y9OytB8gsVKut4lj3U0/a/S35uT3UQU=;
        b=xEl0Mr3Qe/am+c7OIH/J9xQd5hsC5B8s9xY/UIxmEf41wAfl+m9zxQeulNllBIPB/P
         jD+cSQZehkjXkH5tk2sYiQPiXUIH1qCafDpxqvEvXEP91/1ux+0qBgLa2fDhD4wBApPc
         4PdDMJCehtnVOBIdFNSSwLpsKgFtVbHI51SiM337k02zS+ej7sUs2Mc1Dnyd/zJu1999
         XoqYWZRER96cH0pgDEsscJiWrM2MyvMwGGteasz49zQ6qiDn7bUrveiUzWikb8/aWaf0
         5buNWGPFoWHhA3GBqrHRJit54F6fNyi0fl4npT/yPGPP2CcNSTuMYtT9lnMjkHHixIIr
         CkoQ==
X-Gm-Message-State: ACrzQf2wZegAzICzrqdDJS3MwTH2AcD64RFs2Z+s/tSS0XAfYZ223xOT
        9Mod3j4N9D95HzVEkMv4dWDDkfMNdbUEEpw3eUEz1g==
X-Google-Smtp-Source: AMsMyM40dfLheNyJpxRKrlruFqXHZd3uAgc7HrLOqZvbFfPbKtA0whtMMMLzf5d7lWMkSxfcWdRjVful/T9eocL8Dsk=
X-Received: by 2002:a1f:e5c2:0:b0:3b7:3aca:9868 with SMTP id
 c185-20020a1fe5c2000000b003b73aca9868mr7842964vkh.33.1667817030498; Mon, 07
 Nov 2022 02:30:30 -0800 (PST)
MIME-Version: 1.0
References: <20221027130859.1444412-1-shenwei.wang@nxp.com> <20221027130859.1444412-6-shenwei.wang@nxp.com>
In-Reply-To: <20221027130859.1444412-6-shenwei.wang@nxp.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 7 Nov 2022 11:30:19 +0100
Message-ID: <CAMRc=Mf+ByrcBt64gMdiWTgBRETuNHoJZNud1ZkW1T77rR6+QQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] gpio: mxc: enable pad wakeup on i.MX8x platforms
To:     Shenwei Wang <shenwei.wang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 3:10 PM Shenwei Wang <shenwei.wang@nxp.com> wrote:
>
> On i.MX8QM/QXP/DXL SoCs, even a GPIO is selected as the wakeup source,
> the GPIO block will be powered off when system enters into suspend
> state. This can greatly reduce the power consumption of suspend state
> because the whole partition can be shutdown. This is called PAD wakeup
> feature on i.MX8x platform.
>
> This patch adds the noirq suspend/resume hooks and uses the pad wakeup
> feature as the default wakeup method for GPIO modules on
> i.MX8QM/QXP/DXL platforms.
>
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
