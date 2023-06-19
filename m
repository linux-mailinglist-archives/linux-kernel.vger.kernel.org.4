Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55274734F06
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 11:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjFSJES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 05:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjFSJEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 05:04:13 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E49116
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:04:09 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f907f31247so13661275e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 02:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687165447; x=1689757447;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yGd3GSbLFhZ5atbejnGL2mGXHbrB6Og1PKpMLfAUrY=;
        b=WOlUKyrsHN+PneEtfTf4PaBEyfLL65+KwXaNw5Dkon4zNvm7CGRnc/jtNmpM3UvOvS
         1uvQm0wF+P0diAvmPDCO0zNETEwCtDclnRsONuk+SowkDZebLc4MAlfoE/SDi8Q0oGAJ
         Ju7H/F34CnjzJaHwnuqvzgBEge/e7ZcNsv91dsFYE1a1BQi0BD2Hxr/PLjk2pXeSqoE7
         jsIsoddCJLKPlN4dXu4FOGJh3q5wtR0KHhudgSmBKKXflbWqHN61HNSXcXFEnps2w1jy
         E19Illjnx+qpLCB1onuQHngO/C3H9PSeB9XWt2NfekFmtzg2TgBGgmyuBAcfuB7cUDym
         WsXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687165447; x=1689757447;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yGd3GSbLFhZ5atbejnGL2mGXHbrB6Og1PKpMLfAUrY=;
        b=lY6TRseOWmGTl6AJrzIRHrgQo8cufUlIH5W290BgE8uD+++rul/VDjxjEqYvc44lI/
         tpMMBAyO8oKVSqKegvOS4rNP/9V2xpVVmBk4qHroDql0RTQhotWWsWsK28GzKKWL/vae
         25XWs4i+xv/xNjMEHF0h9lJXusQ0GwjwKhMqayVCp0qGzDKclH84HtwEjalE6DOnnAA0
         B2tLcWJJmTcm7PnXm4p2nzF6coYXuiZkI9692B9g8avN+y5DhpxDY2Pf2zictIUBG3z2
         DN8MDn29iMlVY3g96cekS0wJUkodGHxlsDRXHHzJ24M+bAIXzS5VMz7GeeiJ3u769s+O
         gqbw==
X-Gm-Message-State: AC+VfDwcqOYDw4UNu672b0tYCmz0pKr2uPC3EH8aw9E0ARfj4HF5R+gD
        A3vBrhttKlqd/WgOimmw3W3/ug==
X-Google-Smtp-Source: ACHHUZ6Id4Zo9VfB9WYG29OMsmVG3Fwo8v35RDi9Sz8WnpwhfvScLCULE5Z4NMDRo39oZGxlqaxHCQ==
X-Received: by 2002:a05:600c:ca:b0:3f9:163:35d5 with SMTP id u10-20020a05600c00ca00b003f9016335d5mr3859462wmm.2.1687165447362;
        Mon, 19 Jun 2023 02:04:07 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id c6-20020a7bc846000000b003f8fb02c413sm8633213wml.8.2023.06.19.02.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 02:04:06 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Alexey Romanov <avromanov@sberdevices.ru>
Cc:     linux-arm-kernel@lists.infradead.org, kernel@sberdevices.ru,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230610090414.90529-1-avromanov@sberdevices.ru>
References: <20230610090414.90529-1-avromanov@sberdevices.ru>
Subject: Re: [PATCH v1] drivers: meson: secure-pwrc: always enable DMA
 domain
Message-Id: <168716544629.1449314.9025193999820850128.b4-ty@linaro.org>
Date:   Mon, 19 Jun 2023 11:04:06 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 10 Jun 2023 12:04:14 +0300, Alexey Romanov wrote:
> Starting from commit e45f243409db ("firmware: meson_sm:
> populate platform devices from sm device tree data") pwrc
> is probed successfully and disables unused pwr domains.
> By A1 SoC family design, any TEE requires DMA pwr domain
> always enabled.
> 
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.5/drivers)

[1/1] drivers: meson: secure-pwrc: always enable DMA domain
      https://git.kernel.org/amlogic/c/0bb4644d583789c97e74d3e3047189f0c59c4742

These changes has been applied on the intermediate git tree [1].

The v6.5/drivers branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil

