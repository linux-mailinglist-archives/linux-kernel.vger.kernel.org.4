Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FE36AC35A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjCFOdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjCFOdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:33:07 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E9034C3C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:32:41 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-536c2a1cc07so186983787b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 06:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678113119;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p4Vf/GiLha2pSMEvHIjTJV0zZlY5SiXWt3VfrpMrw9Y=;
        b=MD3mhzZd4GyfZJ5pnBwVGQ4v47i4/8LL1auO/sbdGCU5nD/49suJr3mo7IhcCcqBFk
         7LSNi9qb+LuCT7VitagPWqYyapc/aDfTARE13UX+36F00XZPdfgfB2VnbBtPZzLavTKv
         z+8x+0I1at2+WVpQIWiIOS9MEreNcYpLvWR0HOYIPIWVCXU6U1U/J+r7BRwx7lrIlbiB
         c3HeckQnoaKYT/h0teEg3Sk+48vPCyKOaro8eNq45nXxLBN8ZJnGTPJ270fxeB6Kg0ee
         AA1HoLaChosx3ddMVD86+ObZcohUs6fQbpl/33amMr6d5jJYyDbFs47HgsJrACplqJGP
         iEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678113119;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4Vf/GiLha2pSMEvHIjTJV0zZlY5SiXWt3VfrpMrw9Y=;
        b=7G2NGA65UoESeLOVkVQ8bZ9aCt9OhOnWaPZMEYzsqTFblOsKxWsHTY+dxCcXdeAtSc
         u+MybXa4ul7Sncqv2B66SLflzJ1y7bMqaTXrcunvyN0C02lozbskpBj14gnslPae7QyK
         JytzINiNjI0G6Zx9kz5J3JS0Km9oUXp9Ob9VOakv4ASBje5CLg+jyDNlZZPDkls0JEzO
         hn6Hvt+ukBinh5xOhYoZCMPQHZmGfYargh7oDM00ju1CarxzTbyTl0KfSe19jdYKsVfA
         Rycm0gwsVoA4YY8ZhHTEGZUR9TVWokJ4k872qOlDb2mCviiWoqvNEoLWT+5zV3FqpqZU
         IPRA==
X-Gm-Message-State: AO0yUKXma5dtvfmOmRsb7q5TYDynz6J1e35caUW2h+jhgoWrD0Yjw9rY
        RaLqTzUNVN10TM4GXLuVxiLkSF8MDup294To/XjjyMhIn6toasVl
X-Google-Smtp-Source: AK7set/n8BLSpbkCEy3a4qm95upY/2HMv3F6GdIP+lCqGyyMSVbkr0y4BuVYE7xyzvcDBhJP5Fr9x0ECyU/7lNdQ1Dc=
X-Received: by 2002:a5b:647:0:b0:932:8dcd:3a13 with SMTP id
 o7-20020a5b0647000000b009328dcd3a13mr6562490ybq.5.1678112538925; Mon, 06 Mar
 2023 06:22:18 -0800 (PST)
MIME-Version: 1.0
References: <20230228065618.2686550-1-xiang.ye@intel.com> <20230228065618.2686550-3-xiang.ye@intel.com>
In-Reply-To: <20230228065618.2686550-3-xiang.ye@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Mar 2023 15:22:07 +0100
Message-ID: <CACRpkdZ4iiN-zeJautqk==kcUh1cRdyrhmeACEBppPYdJwA=Xw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] gpio: Add support for Intel LJCA USB GPIO driver
To:     Ye Xiang <xiang.ye@intel.com>
Cc:     Lee Jones <lee@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Tyrone Ting <kfting@nuvoton.com>,
        Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-gpio@vger.kernel.org, srinivas.pandruvada@intel.com,
        heikki.krogerus@linux.intel.com, andriy.shevchenko@linux.intel.com,
        sakari.ailus@linux.intel.com, zhifeng.wang@intel.com,
        wentong.wu@intel.com, lixu.zhang@intel.com
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

On Tue, Feb 28, 2023 at 7:56 AM Ye Xiang <xiang.ye@intel.com> wrote:

> This patch implements the GPIO function of Intel USB-I2C/GPIO/SPI adapter
> device named "La Jolla Cove Adapter" (LJCA). It communicate with LJCA
> GPIO module with specific protocol through interfaces exported by LJCA USB
> driver.
>
> Signed-off-by: Ye Xiang <xiang.ye@intel.com>

Check my comments on v4, with those addressed:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
