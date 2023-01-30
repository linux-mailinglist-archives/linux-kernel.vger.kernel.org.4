Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61D1681C89
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjA3VS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjA3VS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:18:28 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B610A3525D
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:18:26 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id qw12so19912464ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUYTF6x1+3qI4HVoC6YXhtrodY1iWYPp8EGg4UuNUhI=;
        b=YrgcYpuHu56l99WKEko7b9aJXLBqAiFMNuwyhELT6f6XOGaFUdPQZcNRNYpggTgJuB
         99/1gr+oXzyxVUMt3vGqYXVLBXDL5fh57URDwjVmE3AQGs6u9IYEc+j5ev8xUnZxPw9n
         Kv4zxq2mlfD2N8A3MjQ0hq8B9fJwIbWlgv6crIGz3zYwfgURKKWP32BgQYzXukj0lU0k
         aZjmrj/KDrolFiZQLSdzmZNaui5ROMUhw5I0r5o8OGvbN70NiHmjhD8yuxvVnY9dRd5U
         33twbfLDWL549zt6TqQzUfEPPEki9m+r3datJC/z3jc/W20qlev2pMFHBnCxsacUsnS+
         y3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUYTF6x1+3qI4HVoC6YXhtrodY1iWYPp8EGg4UuNUhI=;
        b=vOZQQk63TecELhNhJTf3Xfu9iSYa4DFE6/yOl1BxUF1xsN9EGtdHvQgbfPz0h0rrp0
         n8YLmrXTdwMHrIKGjNpn2mQUvBHYf9lnmyyfGpP3badvXGppq4BYprJQzGyCueQlTTlN
         ZzjFYmnBEK+Z2QWr+VxwKQPRgW+97NEOtUw2ii89UL6EYSuKsxtzf6iRW8+lECfndVbP
         N8eHunbE6t7ZFLzh0GHzBpkhZAkmJKxiXE3+cPiX8Nkz92F9UZCIOQa0I4j5uWh+iDZF
         I58B0NX2KK44zSsnGMnWcX009eYbNJJmy2Zl0zsL9lVJXPPlLyCQb4vZNvkn/Er6lAZJ
         2opw==
X-Gm-Message-State: AO0yUKWbijpr/qxRPZzgvqNe8DpazpAtd9Blz74ARET2IIOWhwaVibPn
        5+2AytId+EBSOyDHMhvZdd4=
X-Google-Smtp-Source: AK7set82o23fzdPkIJFFGVSZ+utY+unOY3z/FoRJyDSfrsNVF+mI2rRxDdr04iimoYlGpzNJjZwByg==
X-Received: by 2002:a17:906:b187:b0:88b:28ea:5bdc with SMTP id w7-20020a170906b18700b0088b28ea5bdcmr2295828ejy.42.1675113505146;
        Mon, 30 Jan 2023 13:18:25 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id h15-20020a170906584f00b00886ec4f2fc7sm3088920ejs.17.2023.01.30.13.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 13:18:24 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: sunxi: select CONFIG_PM
Date:   Mon, 30 Jan 2023 22:18:23 +0100
Message-ID: <4802479.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20230130130453.379749-1-arnd@kernel.org>
References: <20230130130453.379749-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 30. januar 2023 ob 14:04:47 CET je Arnd Bergmann napisal(a):
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Selecting CONFIG_PM_GENERIC_DOMAINS without CONFIG_PM leads to a
> build failure:
> 
> WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS
>   Depends on [n]: PM [=n]
>   Selected by [y]:
>   - SUN20I_PPU [=y] && (ARCH_SUNXI [=n] || COMPILE_TEST [=y])
> 
> drivers/base/power/domain_governor.c: In function 'default_suspend_ok':
> drivers/base/power/domain_governor.c:85:24: error: 'struct dev_pm_info' has
> no member named 'ignore_children' 85 |         if
> (!dev->power.ignore_children)
> 
>       |                        ^
> 
> drivers/base/power/domain.c: In function 'genpd_queue_power_off_work':
> drivers/base/power/domain.c:657:20: error: 'pm_wq' undeclared (first use in
> this function) 657 |         queue_work(pm_wq, &genpd->power_off_work);
> 
>       |                    ^~~~~
> 
> Unfortunately platforms are inconsistent between using 'select PM'
> and 'depends on PM' here. CONFIG_PM is a user-visible symbol, so
> in principle we should be using 'depends on', but on the other hand
> using 'select' here is more common among drivers/soc. Go with the
> majority for now, as this has a smaller risk of introducing circular
> dependencies. We may need to clean this up for consistency later.
> 
> Fixes: 0e30ca5ab0a8 ("soc: sunxi: Add Allwinner D1 PPU driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Although, would it be better if commit in question is fixed and another PR is 
issued? That way we can avoid issue with broken config.

Best regards,
Jernej


