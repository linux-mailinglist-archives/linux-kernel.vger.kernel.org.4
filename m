Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54BE6131A8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 09:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiJaIXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 04:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiJaIXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 04:23:32 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138C9241
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 01:23:29 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j15so14863346wrq.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 01:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBjX1O1DcI8vaNSNvjRBLAcS9TKRieTO8wxKUL4zLUI=;
        b=kyiMogX3Fc6zyqQ+KCFc3VfGF95/6P/uf9wCnWpawXf2OL6+Wq5/hY8b6CsxexG1mL
         bDz1pGkcGZ+4Ho/NJ+wbYgJGbmHN01xEO/T6xdsVPtq1zk/eZK/qyNA2n2wt6ouOyhZl
         GOcnRyGBZS9dpDxWrb6mNBrtb1cbaJdMH/ULMf2M6Bu7aPw4bz+IRAZQN8bhUD/6RI4f
         9x/bcgz/lvpkOPPJrPssJ6gseFHsCIRKPXQK/HhCJzm4Fn/YqPWGBr382M3r2Bc5EVTq
         hAi/nkC8xsMvYTZg7hxK01Nnq4rElsM9L51KhbUQakpar9Dgym7BIB5UkE+zsB0zMZcg
         xzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GBjX1O1DcI8vaNSNvjRBLAcS9TKRieTO8wxKUL4zLUI=;
        b=N/2SlmvcMkRgXIijdHKKbls0fAbaUHr9mYk+0AjX0nLJS3PHZYlxLsdTKtcH7HnhPG
         oVOiytYLnExmVkua848x91PkEgWL8jfLH1dUsmb9x1MdmOUIaXKUw/sqaSh7aXvgjNRj
         Gmh5cb4QT9C1taq5OqsgV8D0XxqQ4Hqy/EXEIWa6naWIgYNsR4uuCIHRiZRq16mYLI83
         CWRQv3Jok1iHSdKFS2D74zkObzDQO65HiO72kYdnGfpujfLujUg4mL3y5n+x4wZ9Spgu
         62gFgqEuGrUiar7zCK6RmwBRDg7h2uCZxT8basG2IrqAThypYLSAUt3yuIBVM2zxbck6
         N0Hg==
X-Gm-Message-State: ACrzQf0tDO+zFwWXhf4dWECajqmCnBvM9C+yOnXePaz3vaUYv7AVybps
        tD5sgRhY0kjp5U8MPwhfl2WJbA==
X-Google-Smtp-Source: AMsMyM5IFBtq6DgiyrWcyRfDJxoQ0QJzxCDg8oD5MIyuqTVwTfLHW+/92iI1o7CJpSzKRfkKQ1ExSg==
X-Received: by 2002:adf:f883:0:b0:236:a6a3:d6ac with SMTP id u3-20020adff883000000b00236a6a3d6acmr7345634wrp.538.1667204607833;
        Mon, 31 Oct 2022 01:23:27 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id e7-20020adff347000000b00226dba960b4sm6416302wrp.3.2022.10.31.01.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 01:23:27 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-rockchip@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>, kernel@collabora.com,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>
In-Reply-To: <20221024165549.74574-1-sebastian.reichel@collabora.com>
References: <20221024165549.74574-1-sebastian.reichel@collabora.com>
Subject: Re: (subset) [PATCHv2 0/6] Convert HYM8563 RTC binding to YAML
Message-Id: <166720460675.3774207.3260903176135865754.b4-ty@linaro.org>
Date:   Mon, 31 Oct 2022 09:23:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 24 Oct 2022 18:55:43 +0200, Sebastian Reichel wrote:
> This converts HYM8563 binding to YAML and fixes
> the existing DTs.
> 
> Changes since PATCHv1:
>  * https://lore.kernel.org/all/20221021170605.85163-1-sebastian.reichel@collabora.com/
>  * Added patches fixing the existing devicetrees (Rob Herring)
>  * Dual licensed the binding (Krzysztof Kozlowski)
>  * Added maxItems for clock-output-names (Krzysztof Kozlowski)
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.2/arm64-dt)

[5/6] arm64: dts: meson: remove clock-frequency from rtc
      https://git.kernel.org/amlogic/c/2c5240a018afd6f46fe648ee2396983f5ce1e087

These changes has been applied on the intermediate git tree [1].

The v6.2/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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
