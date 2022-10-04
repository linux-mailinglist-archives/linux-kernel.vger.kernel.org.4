Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C575F49F4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 21:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiJDT6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 15:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJDT6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 15:58:13 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0A969F5C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 12:58:10 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a26so31173508ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 12:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=dguxz/Ezdu52FMs/VeEtnrfjn86z366LIxkOOBNVZZw=;
        b=wGoTNPdbibA40hw/Gip8cARqKnr3cokUnOVXBSFFmhfmIsGvVIyoFLTMdfBJfLEUzs
         g/CWopjmJiIy3IjjUdxk9wOpgnduT5ICx387b7NDe0X273MHtArOfEnRTmNf1ON8NLN6
         wiWpr7wf7ZrHhejyn6VRskLGS/dmmG7XPAWWfYPuKZc2/HKPJeRijIF1rwtiSo7J2y0y
         vILm0/NooyR8An2Yxs4hNcDpJinWxDlpYxKyBwbPbuCWqDLWgPtYHOFXJcZGJ8R9vF/L
         BGRorq1xUOY76dGXP4M2XZNrz2LfLUszvyibPg8Ox0nWsC2np0/LUI8eAY/8XfixAMuD
         sXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dguxz/Ezdu52FMs/VeEtnrfjn86z366LIxkOOBNVZZw=;
        b=4F9+CpTEPMoeq3S2iN7LUpIzxqJYFix19NP1VIkUSp90zkRqlFvluhlnPRuEQ2Hvow
         15Sc8G3wsm3+Xqa+G56Uh1672CCKxKT9qABk3BFtDzEO/+aKgkFjrjgRNcC8PrsNPXtF
         khKq1+PhKvNnGTRfK+aAUc/byOxEzRE01Scs5bv6LuQesI6Go0N/W9bIioGeGeYHg8iN
         xXHiZtjOr87h52Lpcrcik7ibd0bEl7cN8EofPlI7zFAy57bPZUDxTMTrkolcNOzXteMI
         V9x8Yn86vkpw80uxEMZejY4YCEAacDJxewBVzvV8TLM9p520JTyT5aJvlzhqEx6Rlp4A
         vMjQ==
X-Gm-Message-State: ACrzQf3DMis97y5OKSq7fkktChZa7IIDaLq+peTeWTZ/PRbC4cwtSh83
        f67hKmuPG2zjOlBCgg/GhpRwRvfI0sqlnoL4+gy97w==
X-Google-Smtp-Source: AMsMyM50nurAIJk16mylb/lVVdRmBZHVQM0yRvlYzbMPxncfnaAmgDZ62Ts57Pqj3A2usDwHEdD21wmKJHfxnzjLmqk=
X-Received: by 2002:a17:907:7b9e:b0:783:10cb:2826 with SMTP id
 ne30-20020a1709077b9e00b0078310cb2826mr21077478ejc.208.1664913489372; Tue, 04
 Oct 2022 12:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220925021258.1492905-1-yangyingliang@huawei.com> <CACRpkdZijkQAT84mfP06SgxBjHmrqSbWwctBBA0pvb_1xYzGvA@mail.gmail.com>
In-Reply-To: <CACRpkdZijkQAT84mfP06SgxBjHmrqSbWwctBBA0pvb_1xYzGvA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Oct 2022 21:57:58 +0200
Message-ID: <CACRpkda6kCL-FbEdfu9msXH6xnLn9fLC-q6hcm=e_H_AT_uVEQ@mail.gmail.com>
Subject: Re: [PATCH -next v3] pinctrl: ocelot: add missing destroy_workqueue()
 in error path in ocelot_pinctrl_probe()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, horatiu.vultur@microchip.com,
        andy.shevchenko@gmail.com
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

On Tue, Oct 4, 2022 at 1:46 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sun, Sep 25, 2022 at 4:06 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> > Using devm_add_action_or_reset() to make workqueue device-managed, so it can be
> > destroy whenever the driver is unbound.
> >
> > Fixes: c297561bc98a ("pinctrl: ocelot: Fix interrupt controller")
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > ---
> > v3:
> >   Using devm_add_action_or_reset().
>
> Patch applied, after deleting the hunks removing .remove because
> that was already gone upstream.

Ah, the patch introducing that is in the MFD tree is it not?

Either ask Lee to apply it or wait until -rc1 it's no big deal
anyway. Remind me in two weeks.

Yours,
Linus Walleij
