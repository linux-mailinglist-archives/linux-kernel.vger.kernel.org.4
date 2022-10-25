Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8887660CF7E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbiJYOqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbiJYOqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:46:47 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDC018C95E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:46:46 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id v130-20020a1cac88000000b003bcde03bd44so11817049wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LopGlgKhvm32wTid0qhleNX0zRA4//F/8VxaJyDktKs=;
        b=I1z3mKWiVt9ra7NqgGZ1lxmax+gR+Rpbh9s0z951uLuFibjIOotScr3Z66je20grqL
         seFqrE7edY/wHTOz8DsJSYwC4eOGM7lxK8Xrzez5SggsisUUWpxBVHI4nezoSOn8/mq8
         hi8ZTJJKQE4vAlFEVnwTc9tw3jYMvtCTg/mpdvZgVplsO9SeGWDW+h7oeXgfoKS6x0Ly
         pqJw8g4atH/15PRQmVBblJzp9+eBW1Yl5fnPoD/SJr0upUCJVzVcs/hOaDzMTdJ98cS2
         2DQqJoZOX8aqC1ez3W3TWFh5X8ZeOYmd6ajYm9WbNJKIFwJzXr7HrlWAyTF5C184j95A
         1dWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LopGlgKhvm32wTid0qhleNX0zRA4//F/8VxaJyDktKs=;
        b=1Q0Zsoyt6bNCH+5Nvy/vif18Onz//hhSqc+8JVP6rea9MTUmwBVQnJFfhPx/xp4R62
         sYEIEes6A9AO/rxf4iZhPgU3PXODevzVap3T8i3d6ZbdzzEkNXlP7mFuawXXcNIwvLAw
         3/UHAAZZTVplyaM+iBl6DLIoS8UuXTMzRyQW81pN2NMdlxiCin5AQ/m4XxpC4bh+qgS5
         CoOCvAnAbHlnRmn1jc1d6bjKIIGUlaI0yRYyFZXW+G9ocytYvGgeaUtQ8I0ztGYMyvlA
         TzKGZ2eu1DaJo8sSkEkc0TKdX4oJ3vLFUz6ju342GwkqyaC9ievvLr3ztwj5I2e+3SAL
         v2AQ==
X-Gm-Message-State: ACrzQf3S+l1+MVBJYLcMPtqWlKsrRLAbCOlrtdINUe6W82L/yHOEMk/q
        dXsLGPGuy4siI9LHyqPhR1S5XA==
X-Google-Smtp-Source: AMsMyM5viWsVZbx2LjdqeTusxCj/brx91Qs9pRD+VOokyVVP3l/Uvnu+D5ZYZjuVFJWVtiLM9KvaYg==
X-Received: by 2002:a7b:cbce:0:b0:3c6:fb29:6084 with SMTP id n14-20020a7bcbce000000b003c6fb296084mr29912467wmi.131.1666709205331;
        Tue, 25 Oct 2022 07:46:45 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id q6-20020a1ce906000000b003c6d0f8c377sm2498670wmc.7.2022.10.25.07.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 07:46:44 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Dan Johansen <strit@manjaro.org>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20221021050906.1158-1-linux.amoon@gmail.com>
References: <20221021050906.1158-1-linux.amoon@gmail.com>
Subject: Re: [PATCHv2] arm64: dts: meson: Enable active coling using gpio-fan on Odroid N2/N2+
Message-Id: <166670920454.4012520.12238178333554890690.b4-ty@linaro.org>
Date:   Tue, 25 Oct 2022 16:46:44 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 21 Oct 2022 05:09:03 +0000, Anand Moon wrote:
> Odroid N2/N2+ support active cooling via gpio-fan controller.
> Add fan controls and tip point for cpu and ddr thermal sensor
> on this boards.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.2/arm64-dt)

[1/1] arm64: dts: meson: Enable active coling using gpio-fan on Odroid N2/N2+
      https://git.kernel.org/amlogic/c/44a201df71739a3c5ef3c40e58ebaccfd052d430

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
