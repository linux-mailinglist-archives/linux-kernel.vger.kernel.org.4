Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F230C6AC318
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjCFOV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjCFOVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:21:34 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E189572A6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:20:09 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id i6so8229154ybu.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 06:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678112332;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BSuWilkYCJFsV7IY3WrT2Gn2CfcAm+FHoFIi1EIJdfw=;
        b=CrCSn/hY/Pn3OIYiTzzC8GJtvWpUB9dzR3nWq6D52TKPxspzM5n1Pdvl94fz/mx87C
         m/1PEAwns2uSZyTOG8Mnyneu/EZmd8VLZU4KePObsSanw1hntLXEjaQMug6t1K8iIqdi
         fnmq9fsgDrAH/Mx+DTyy/d/YbQ+kgBGOpM3sBH4bjH0uOJ58CQp1p9K5g9rEUYBW9oxP
         DNwRhsNDFEw1ax6MCVyH3XbsNlUbvTFVOugDAwBLZSNkFL3Xitr2RedlbUajuyUHAgj8
         delve7oZI+VqEg28RCSoYlORT3B2T+RZ+RpsvG2tRn7VRyOBt1moQJmyx4IIr1xzcPkb
         8I5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678112332;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BSuWilkYCJFsV7IY3WrT2Gn2CfcAm+FHoFIi1EIJdfw=;
        b=lyFcw/hD7/Nh1swdYC/iHc6mDhJGu1ATHGrhyEzXAKLq1DgAwFtW8dv+InZCYjOVGR
         FpJq/7W5yBqBfuLi7NLCNr19jMON7QzEgbop+M3E+Doilcu4NO8hsSYfGhB+l+7a895L
         p/o/MC2HQpDkiWyA/WwkQ0GLQDGNTdwm+YSbqta4Yx6mMaaLQswXb416bBSGq8G6FsA2
         RT8XdeLw/6yBDb1UaneDS0UCbYaS0LX34MG3Kva+1+uN1Q9G2N3C07UPL0sXa455+Gk1
         TLXSLPNLv8qGrFJ0fa0JTVkgb3tHfQ1sUx9zpQXwVBO5rcTK38n/oWebHYv/3oAUOq8e
         Of1A==
X-Gm-Message-State: AO0yUKUUeQkdv+Mt/NQUHOfHJEQnJ7wdRnJr6fl8naGWQaqJQhya7bkg
        j9amqBxXIv0uJ/E31Z3eEMQyAJwxqLLNg+BaIOe642XttDwv6iMk
X-Google-Smtp-Source: AK7set8SLvtaEIzMFs/ct9lUoE90JnY9UNlhBsKArcGXEzrP5gpzowNx3909XhZ7n3C1qDJEkWxKzgtuWVYK6UiyEsg=
X-Received: by 2002:a5b:b84:0:b0:ab8:1ed9:cfd2 with SMTP id
 l4-20020a5b0b84000000b00ab81ed9cfd2mr6552182ybq.5.1678112332336; Mon, 06 Mar
 2023 06:18:52 -0800 (PST)
MIME-Version: 1.0
References: <20230206203720.1177718-1-horatiu.vultur@microchip.com>
In-Reply-To: <20230206203720.1177718-1-horatiu.vultur@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Mar 2023 15:18:40 +0100
Message-ID: <CACRpkdZsWFJEU7xoc-r+tBkD2TzRTW34x3RbeqMEqrRfq6A7YA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: ocelot: Fix alt mode for ocelot
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com, andy.shevchenko@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 9:37 PM Horatiu Vultur
<horatiu.vultur@microchip.com> wrote:

> In case the driver was trying to set an alternate mode for gpio
> 0 or 32 then the mode was not set correctly. The reason is that
> there is computation error inside the function ocelot_pinmux_set_mux
> because in this case it was trying to shift to left by -1.
> Fix this by actually shifting the function bits and not the position.
>
> Fixes: 4b36082e2e09 ("pinctrl: ocelot: fix pinmuxing for pins after 31")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Patch applied for fixes.

Yours,
Linus Walleij
