Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA886C9CC1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjC0Hui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbjC0Hud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:50:33 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2994FD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:50:22 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id t17-20020a05600c451100b003edc906aeeaso4488843wmo.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 00:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679903421;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2/+o3CjS5oOZ++bbODl8k+jnt9IdZ9tkak/3JMK7t0=;
        b=kET1HgTtkyGztmzPv5rYte5NwafcMxGi9Gi1UhkEZ5F2Q2AGcxrq9LIvKKfnOmgCAs
         mxq/Sh4eHz2GT+4mm2xZ2BgRgzVmQOxccxBwCK8g1qhfC6Aqpsd6QFXVvIxOFFanJCMO
         V7Pdj1wyTmsUjpEkN/uTuOte6P6OITJhvKLE8rAFNp7T+9NGW4/Ko6bsqSgEpgIr5wwc
         o2TQpMZUGC3/iY5N7cQwrX2iDmQ6e4x1L1KGv4qbJve8U29mwy4FchCjESwboVrfO+IS
         4cj8QQ8Uzl/mefqvYwCgMAnF2HKgfOykF1tH115foqpkhpu+Jr1R+QonghVB1h6tR9AF
         nswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679903421;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2/+o3CjS5oOZ++bbODl8k+jnt9IdZ9tkak/3JMK7t0=;
        b=CbZh3S53gV8pDhqh0737/Yb7TgLWwCJjcc99NmyY+iAJkCDRQ1PzGm7phIOqDoqFoZ
         cEZcIkPDScWYzKBI+Fe2KCFBYMBk1ZQOZUwbZfDw/+gnBLZxDbcEwLZxilMkQcTv9Yvp
         dUGxO9cOzNQtDsANAE/+9ieEQWyk7RkU1/M/iOmYtBiDgLDSyQDFJmxmC8d8yotreJ30
         QDRlehtTFpYWeDRaozZwQjXmTV2RtTDC7+5H7B1pB/OQJd3FxxyEKdRwdzfDE1J60rjp
         BwEzxLZ52dBmJYsdCet1n1BI9GGXRGSidpScbVe8Ezc0K+83dYUc2vmXREAD8LfB2kXG
         AtYQ==
X-Gm-Message-State: AO0yUKXR32MiBmjD+4vg0drmxjZHex6DkDs9RbS26oKgZs31xfnAR5Kn
        bOh/gIk5yFkiSe7qan/vlD5lYeN7BXc44fvb2TvL7A==
X-Google-Smtp-Source: AK7set/H65ARWER2L8lAV5SPxt5sN6JG7yyU9dVo+BNava17+gn6Bz3R62wLpTmeq239RuFisYQNTA==
X-Received: by 2002:a7b:c448:0:b0:3ef:294c:de50 with SMTP id l8-20020a7bc448000000b003ef294cde50mr8538861wmi.29.1679903421304;
        Mon, 27 Mar 2023 00:50:21 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c358500b003ef6f87118dsm1673614wmq.42.2023.03.27.00.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 00:50:21 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     ye.xingchen@zte.com.cn
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <202303241016261854322@zte.com.cn>
References: <202303241016261854322@zte.com.cn>
Subject: Re: [PATCH] soc: amlogic: meson-pwrc: Use dev_err_probe()
Message-Id: <167990342066.283186.4060194256735806968.b4-ty@linaro.org>
Date:   Mon, 27 Mar 2023 09:50:20 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 24 Mar 2023 10:16:26 +0800, ye.xingchen@zte.com.cn wrote:
> Replace the open-code with dev_err_probe() to simplify the code.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.4/drivers)

[1/1] soc: amlogic: meson-pwrc: Use dev_err_probe()
      https://git.kernel.org/amlogic/c/78e812f0406c765fc5623b1d68e3c6e86cb32e5a

These changes has been applied on the intermediate git tree [1].

The v6.4/drivers branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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

