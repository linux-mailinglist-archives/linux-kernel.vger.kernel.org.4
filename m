Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2E3641E9C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 19:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiLDSTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 13:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiLDSTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 13:19:22 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E2C11A29
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 10:19:22 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-3b5d9050e48so97974887b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 10:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3yEuU4DRFv3QzERe46xRclJFevYw/altfSJbtDqBZ7E=;
        b=ihBB+Be7oJYSqMLWgkjGBD4gYyY7U8up04pCjLyxdnfAK5EwwYJf4Pw4XSDk7S8QhX
         CB0Ks4jgnm51olKjEDvhp6RLvngf9JnsJdIac0tCtzNmw2Htj0uKAy88zjtXWT3bm2tM
         swxFK+LgZx+SjDZXAB5XSBTuXfsT4yi/80Gim4OqV6dD0Uqye+Ca2rWNcQlx2M3jt7EA
         MAeDB3qX2VVGoEu+i4XxgrFCiWQ/H+CfN5QwqzPqTXDIGLxd8TnF4TvifK4Qzb4zUJdE
         gyLv7F/23amkHAV+priFql2xCkS0Hlm2bDN7x4RqWwRcScDx6cmEvz+KYG6FTs4Tq/+T
         mp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3yEuU4DRFv3QzERe46xRclJFevYw/altfSJbtDqBZ7E=;
        b=1/DruWN1u75j+LqqMOw8J3gJTVA39ucMun/4irZzC/H5yNsARE2GPbVoI0BGMg2rdh
         W1RWhkgsj+mUOVkzw2k57vBrIBbVJudWwKyzGWrPlnFLfTUMXikX+bwdRJny7NEC2Ouq
         FTqXmyTp7GanwXsn18f+NXwc92Nej7I+N2rzMYqpFl4rfPc2D9c7qrVlb5STfCb4U9Ab
         Z1b23uuNRfGxP0ECS5y0ua117Z52UzC6tpcQ/Ki1Vkrq79GPyuIztBAeUC6+LPNhHId+
         e92BbI1sXV2Lr0SDbBERaF75jPYV3LNoPfEABP+aGYdqVWi4B4Kb4IP99Xjwy2znQks1
         WzHg==
X-Gm-Message-State: ANoB5pn75qa0CyGYcee9VDFT6ebaEoAh6bXVAHGqK8oJ49pkdFW9jPnJ
        q9H6NlnPoGdAKJ7VN3qwt71vZ2ROsGPIYSIt5kchHw==
X-Google-Smtp-Source: AA0mqf4frd8J86JX72WVhEiBTwnOAyXLf43rOkzXA+jC2sGiNA+w3/AgEbOKJeWTM123ZZKMUEbo9lX6ZELjnnK3Pz4=
X-Received: by 2002:a81:65c1:0:b0:376:f7e2:4b12 with SMTP id
 z184-20020a8165c1000000b00376f7e24b12mr57563076ywb.0.1670177961227; Sun, 04
 Dec 2022 10:19:21 -0800 (PST)
MIME-Version: 1.0
References: <20221130101251.245399-1-yiyang13@huawei.com>
In-Reply-To: <20221130101251.245399-1-yiyang13@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 4 Dec 2022 19:19:10 +0100
Message-ID: <CACRpkdbmqx9iOeVQ7OMD=FHiKHWLVjrn=j_LOkJh1QoD9WCdnQ@mail.gmail.com>
Subject: Re: [PATCH] usb: fotg210-udc: fix potential memory leak in fotg210_udc_probe()
To:     Yi Yang <yiyang13@huawei.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 11:15 AM Yi Yang <yiyang13@huawei.com> wrote:

> In fotg210_udc_probe(), if devm_clk_get() or clk_prepare_enable()
> fails, 'fotg210' will not be freed, which will lead to a memory leak.
> Fix it by moving kfree() to a proper location.
>
> Fixes: 718a38d092ec ("fotg210-udc: Handle PCLK")
> Signed-off-by: Yi Yang <yiyang13@huawei.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
