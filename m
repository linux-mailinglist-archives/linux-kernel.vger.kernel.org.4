Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D537458A1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjGCJpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjGCJpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:45:04 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F002C12C
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 02:45:02 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso35823155e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 02:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688377501; x=1690969501;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWRijkh1Cz7shs1vKxqe0+Zs7DVoINyukGAI1yjyh98=;
        b=zEJijkuwKNKpNjqksGIZlSAxW70/gyObVFg0GUnC7m4lBJ+Lg0AfxasdG39w1xA+hn
         RSFyob+aXfHL8qxITEZDI8M32O4fWeqGC7LvyO6O3ao1hpvbb5Z32s2LtoNxxgVmgp2r
         zwc9gmzCGRnVogReVfOIzhlStaAaBMUtez6EhICZa7aRw1t9rz4en2o5+rnXXCRLXH1z
         fR0xIbUap1SSwnM2kWB36Q+jwliXGxJh8yFBNDa/aQU9ew6qtvO5wM3B9EV0jTA5xIm9
         odfeHOwc4IkecenPDrHKJ4Adws4gh7qThsZMmikVp8Ls7VBHU4r/70mX6fnN8I+hPlb4
         LgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688377501; x=1690969501;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWRijkh1Cz7shs1vKxqe0+Zs7DVoINyukGAI1yjyh98=;
        b=f325GZDt6N5hfOvQghR7K7DO6vYDFtSmn+aTh0PU6oCjP5udmsP5dRcGHdtCxK5oC6
         j19n52Lg7WzMfEx1/oyQOjoBPHPTYf/L2y7PCYG+whjcMRpbVDvTzYwYQ3dRv8YzFxHK
         r7N2Nk0vOyh9I8V4i67VHeRNHmT4uSVPGQYLqQYR6bdCU7vSItp9/6OAIi9JuXU7xJRE
         OTBH1/qXnN1C+HH4ep7in5sV9emCI4AKAu36ozr46+5w3fofx9my1rQTUjnCbJm+nL2T
         zIt+HbJDsfWmSu0ahmNcsz67l9hOXHxX3LUWGooj9StwmsYRy9cl4GDTo4o+2gd5f3mS
         OpsQ==
X-Gm-Message-State: AC+VfDwtNATgyeufzfn8M07ccCIIAohVGb7YChZVd2xizJs0mewJLiOV
        j+bLx65xrdvh57ii9N4GP+jloQ==
X-Google-Smtp-Source: ACHHUZ6ZtFY37tY6pT1zUZzqmiG5cyIFC7oVykZP9ABODyv8PakLWqRyvRQngHCYivyFbNw9XuRhNA==
X-Received: by 2002:a05:600c:2259:b0:3f7:aee8:c23a with SMTP id a25-20020a05600c225900b003f7aee8c23amr12700275wmm.19.1688377501390;
        Mon, 03 Jul 2023 02:45:01 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c290700b003fbb346279dsm13805286wmd.38.2023.07.03.02.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 02:45:00 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>,
        Lucas Tanure <tanure@linux.com>
Cc:     Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20230629073419.207886-1-tanure@linux.com>
References: <20230629073419.207886-1-tanure@linux.com>
Subject: Re: (subset) [PATCH v7 0/4] Add Amlogic A311D2 and Khadas Vim4
 Board Support
Message-Id: <168837750049.1068586.16885145268136151183.b4-ty@linaro.org>
Date:   Mon, 03 Jul 2023 11:45:00 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 29 Jun 2023 08:34:15 +0100, Lucas Tanure wrote:
> The Khadas VIM4 uses the Amlogic A311D2 SoC, based on the Amlogic T7 family.
> This chip is not the same as A311D used in Vim3 board.
> 
> Work based on Khadas 5.4 branch:
> https://github.com/khadas/linux/tree/khadas-vims-5.4.y
> 
> The current status is Vim4 board booting to emergency shell via uart.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.6/arm64-dt)

[1/4] dt-bindings: arm: amlogic: add Amlogic A311D2 bindings
      https://git.kernel.org/amlogic/c/19f1263230b6c665d950d63290de6648ed81e0a9
[4/4] arm64: dts: amlogic-t7-a311d2-khadas-vim4: add initial device-tree
      https://git.kernel.org/amlogic/c/419b6066cf1ff2a5f29edf565d5ece55fceb4230

These changes has been applied on the intermediate git tree [1].

The v6.6/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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

