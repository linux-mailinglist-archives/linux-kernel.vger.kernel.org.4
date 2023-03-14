Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6750E6B8CE7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjCNIR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjCNIQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:16:42 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9795487D99
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:14:59 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-54184571389so139831947b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678781698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNImQ4Ug8xoniJtv59trmGana2zv4AZXvsOw6yY/IZk=;
        b=ZESwWyVJww+MC2/YKyK1vRi5uSzGgGP6YywlmCAjypWmeWsfjEwTqxQMtS4Sy2VY4J
         egCAyZP8W+gAgeML3lkGbYEgvku5Jhn3ox+l/9ywo9jaYdaOWDhuQz1cYXx3u3vbTIna
         HwnQl4eV0Nchz1tGjkuggZfl6Ddk5F0Iaj9NlbeCDaRKSLNuxTHJnj9INwd4pPGrtEkD
         mfKSdfq2bVEGavisOvb7wD/cAYdKfLcPqUP2BtuHSZVj9OIZgYO5cB6FtiXcPbCvIpjP
         XuuKHdricLCqzI0+EqsXD+YIYRobhBys7ZYEyOvo2bb1Xxdtq0rYykraNpO2tqwEcooH
         mj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678781698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CNImQ4Ug8xoniJtv59trmGana2zv4AZXvsOw6yY/IZk=;
        b=1O1ikisrUyoz7kptZyPU25FVSVr3i+fWFRHI62VgmGqNka/DGgrFBH/jXSIzPyLocK
         XzniL/Q8eA1nsA7N4qyQmFbP5wzavdYjaItOvmTWjSFwnbV1qvR1MWHV2PxwxkQoGHdp
         Q4D1ReUWFpDg5XGJyOUFMigqxqwZlwsQKK9TjDKxo+SBL5RbFHQaCyN48LvR4RGLgFc9
         oZ9kfF1DMERWjOP6rVNNmfGioerjxFcoShbZDDHZNWK01u/0WAFWqVCMm38/hjON0hqP
         a+yKXTV8hqZl9BrE4flmBeWoytLDsDZskE9AYfgmR5lYat5mTCZjx//exrsQfNa743xu
         Hy7g==
X-Gm-Message-State: AO0yUKVkz7vI38fTNhGQFKwiIhY7KGEZ0gd3h55jZGAjVGioKlq445Dw
        gYq+5bAzwtREfrtOpdgTSedYEwbzqRJDzQamWlY6Rw==
X-Google-Smtp-Source: AK7set9p5PSnuy8b2Mj9t4qbjMvSgNGjF5/7MtGP9ezjbWqSQGvcnH+t8Y5IMz+134ETL/DJXkO8OG0fpKShJk+8XyI=
X-Received: by 2002:a81:ad63:0:b0:52a:9f66:80c6 with SMTP id
 l35-20020a81ad63000000b0052a9f6680c6mr23817685ywk.9.1678781698204; Tue, 14
 Mar 2023 01:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230309225041.477440-1-sre@kernel.org> <20230309225041.477440-5-sre@kernel.org>
 <CACRpkdaa6ZOt7U+iLwjrTGx87BdgXX6wbW2Ab_bHye_TNzi9Tg@mail.gmail.com> <1fdf00a0-4830-465a-801c-147472fdcd22@mercury.local>
In-Reply-To: <1fdf00a0-4830-465a-801c-147472fdcd22@mercury.local>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 14 Mar 2023 09:14:46 +0100
Message-ID: <CACRpkdZFBE=AFtzLShFGCpdRngK-7bZ8iD89_5buZKcXLvJK+g@mail.gmail.com>
Subject: Re: [PATCHv1 04/11] power: supply: generic-adc-battery: fix unit scaling
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 12:17=E2=80=AFAM Sebastian Reichel <sre@kernel.org>=
 wrote:

> There is no mainline board using this driver and I think there
> never was one. I did add a Fixes tag now, but its probably not worth
> any backporting trouble considering it has no users.

Good point. If a tree falls in the wood an no-one is there to hear it,
it doesn't make a sound.

Yours,
Linus Walleij
