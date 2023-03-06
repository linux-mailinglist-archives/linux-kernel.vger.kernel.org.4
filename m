Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529986AB881
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjCFIjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCFIjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:39:32 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E571AE06D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 00:39:30 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c18so5092368wmr.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 00:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678091969;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdXHSSzFb0wf4Z5ebFpbSvGWzd8D68jDgoc9WISe18M=;
        b=L/xCTT9oGeZPl+49XiWu7haaTjDD4Czfx7sdxvdImv6E0n4BYBAn3D4PuTH6iu1EfT
         Qc+MRFZRe1qydY49icg8KJFQ51W7cm3Rxef7sE2j1vhiQUa4J11pURkUFQGRsIpom2Ys
         Aa9qUv1vtAj+Mrxe/aA2EeDG+Uw8FMt2DE+kag/IMs6L4wFKz1Js3mmfscN1/k4JzxDD
         pnP/u0qTCwjArowyXg0pmVt94fig6sxuZYh8GMOu+48+IsQwkeUxUvKMeT/A+R1NjqUi
         umfU76E9s2VN2ERxo3ELDHjmiebm1GYGa+K4XsHT0v05y9chlfiMhOLeTgOM2hRtKM23
         4k1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678091969;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdXHSSzFb0wf4Z5ebFpbSvGWzd8D68jDgoc9WISe18M=;
        b=eaQWGqWHnOWK7B10Iyy+mSObNvClaItdnRTHZaQeTWE0DmLqEnXnacOIVN0kUT7qr0
         nPVcSMKwBYmGz5IUVYKCX2kTplxRWEv4i2K5F0umhqGkjXO76Bd+TrKdxW66zlmp7R7u
         vUTak7ms9UfG8AvyOnEV+Ckm+r+ZAod7xU0vk/kMoYBkX24nzbm0TFNurQmcdm5okTD9
         z6uM1u1TokmZZ0k7BNYFuAgaSONlOq1Ow8ry6JOSXr/1dMz8i842TdpxQzZrUqhSR/33
         KCUG/P4yL8nCnmb9/m2mBmsDVSSd3aEml5qQGg9O5LLnCOkBuHwiTjKTL6bjQkafY/4g
         07Sg==
X-Gm-Message-State: AO0yUKUlMcpTKvn3ZLoFNzuGqXhVNoh2gN5vxMYZdN8tOs4msbk+G2lt
        SBJ/0gL6wnDdwEvUobVN4B/W/g==
X-Google-Smtp-Source: AK7set+ZWZw+hQJ/2sk3ResOt44ySPYhF3lJa5MGYX4FLkyMzo9GSQeeqZSK5eB9zmeofrYdEnx6Gw==
X-Received: by 2002:a05:600c:350c:b0:3dc:40a0:3853 with SMTP id h12-20020a05600c350c00b003dc40a03853mr6535425wmq.11.1678091969437;
        Mon, 06 Mar 2023 00:39:29 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id d1-20020a5d4f81000000b002c54e26bca5sm9190736wru.49.2023.03.06.00.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 00:39:29 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
In-Reply-To: <20230209-b4-amlogic-bindings-convert-take2-v1-0-c4fe9049def9@linaro.org>
References: <20230209-b4-amlogic-bindings-convert-take2-v1-0-c4fe9049def9@linaro.org>
Subject: Re: (subset) [PATCH 0/6] dt-bindings: second batch of dt-schema
 conversions for Amlogic Meson bindings
Message-Id: <167809196860.10551.9031776722379367022.b4-ty@linaro.org>
Date:   Mon, 06 Mar 2023 09:39:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
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

On Thu, 09 Feb 2023 14:41:36 +0100, Neil Armstrong wrote:
> Batch conversion of the following bindings:
> - rtc-meson-vrtc.txt
> - amlogic,gxbb-clkc.txt
> - amlogic,gxbb-aoclkc.txt
> - clk-measure.txt
> 
> And in addition document the System Control registers top node.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.4/drivers)

[2/6] dt-bindings: soc: amlogic: convert clk-measure.txt to dt-schema
      https://git.kernel.org/amlogic/c/2227e738b30bf20380a48391a73752c52f5f5c6a

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

