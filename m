Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8177C620D68
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 11:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbiKHKfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 05:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbiKHKff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 05:35:35 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDDF4092C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 02:35:34 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id 13so37485067ejn.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 02:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yn7cGSh6ga+XvXC/WD382w/qtJjrRb9SC8qneI59x2o=;
        b=FsO3/LugMOTmbSku629MUN87TIXPdjbekhV0S/V+dwk2WUwZvdyWby++l3JW6P5p2+
         kBSL0ZPP2ttcPZsWoeGv3QKoYg8IUwN3NRCqzKNUgaMHet6UUT9upcylwAH28aZNWnTA
         0v9PWaxGz8F3O1Rqor7qQUOYIDZs7cUAWMkz3K9zq/D2TXImxsME0Bq7/++0vJ6EheLW
         KKzhyTa/83KmhKuBWFdYgwSqK6NDGcu9KApjX4T3No0kT8/10C+mxoylXIXefzg9R23t
         adxUteO4Ez2w/5n87FnSLfmi+rHzzhOhtfjqBOvyXP/Tcun+Zb6Gwo6UiI1NSUOj2EFN
         kBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yn7cGSh6ga+XvXC/WD382w/qtJjrRb9SC8qneI59x2o=;
        b=fxLqQ9tpfsafkCfFJFg7y6XwwvqJR2EjYPIy6egny9gQM57nnyiUCNMZgei5ZlG1vR
         I/ZnTdLMNx6hiAE6j/WVeXfqMp4WnRj+DyY8hM4Ede44PAsChjmkg1YjLzScYg6ydCGP
         a0q8K+VYDwFBYCLFKTmvdOGsh5HI8z4aMm309eZWegjyRn8cjsPJCFvl844rfy1cMlbX
         3K6mDjwOSdRnkuK68iRo6lxPtQYk47T9M/ZkK8hXjKuFdUMSM/lzix8MU63WmF+5pBN6
         9pi8G/lpfIjVEuVI8jTDlqACZyeFkW2VvaB7MeJhFZrnNReDrg6dpS3pUCRingPQ7sGD
         cgSg==
X-Gm-Message-State: ANoB5plJw8qi3WGBwFwVMhm2p/5LFifwMAhwaTKgagXqfj/RVqsHEiEv
        pUx/ypo0Lu1qFAYBv+S6DI/lviGozUaP6Quo07Phgw==
X-Google-Smtp-Source: AA0mqf7njpSPHTl5w0lEA2wQzjzeI8ZdHAIWGs0xbwdjixY+aGZD4R27BBbVJqGheaqnU2vWfLvZuUwIf7VewEqhzuo=
X-Received: by 2002:a17:906:6acc:b0:7ae:658c:ee45 with SMTP id
 q12-20020a1709066acc00b007ae658cee45mr10506662ejs.190.1667903733422; Tue, 08
 Nov 2022 02:35:33 -0800 (PST)
MIME-Version: 1.0
References: <Y1aa3/oJA2ElSGp0@orome> <20221026070614.24446-1-pshete@nvidia.com>
In-Reply-To: <20221026070614.24446-1-pshete@nvidia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Nov 2022 11:34:58 +0100
Message-ID: <CACRpkdaRuOUObmwWYDnmwbdFaKVQfzJ0xAuaK5VvrSHpFRj7bw@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: tegra186: Check PMC driver status before any request
To:     Prathamesh Shete <pshete@nvidia.com>
Cc:     thierry.reding@gmail.com, bgolaszewski@baylibre.com,
        jonathanh@nvidia.com, linux-gpio@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        smangipudi@nvidia.com, kyarlagadda@nvidia.com,
        Manish Bhardwaj <mbhardwaj@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 9:06 AM Prathamesh Shete <pshete@nvidia.com> wrote:

> This patch fixes the issue where even if PMC driver status is
> disabled still we are trying to look up for the IRQ domain
> that PMC driver would've registered if it had been enabled.
>
> Signed-off-by: Manish Bhardwaj <mbhardwaj@nvidia.com>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
