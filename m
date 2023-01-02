Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9833965AECF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 10:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjABJpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 04:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjABJpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 04:45:24 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628A45583
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 01:45:23 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so23526092wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 01:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0LrOzQPa8gD5g9L4P3t7SIyp2Mv9DEJkOptQ3B3iXV8=;
        b=BafktxLPHJuCW6QiDiEOMJh2F3XBEG/ttPYufCQmdjkjvw8Kd8B1JCbLPJDbtv81Pb
         lfTkbJrgND0waoiT9qaArWhLT/I5XmtLFeVKGdJhmL72GkJ9N2Lkl96CNeF3ZiCCshCd
         NxFbz9fF7a7SKsW37+qGDsDp0EcWAAOLd1SFtEnzBYdiC/enBNJqbNhsEFCskSlF5DE2
         CePuOlCKvNn1OyUnhUKJUWckxPiapr8lAFHp5+3TRU53Q/1tYiKdz3ELzttdmexcNhTV
         sRYhWvnVT2Ot38IjeqGUh02oV5ZNSXyWRPXLQVMN4ZBKsAvk5flxeMdK89r/eBB5kayG
         oEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LrOzQPa8gD5g9L4P3t7SIyp2Mv9DEJkOptQ3B3iXV8=;
        b=WNBHkS3YWhtMjZ3JXeM3uWYjWfTA7vaeLgwJIDicm+dASFNFwgQJOTU1IqHzgV7LTy
         z0dScb+AgRaJQ7yu6mkGSrnuc4twKczdS6MsNceKi/yDCYAQv+fDa2c9g1DInAp7QGsZ
         aJkpATtOUr6DDtikaXamOooOtGSbxKeof97Et+SL0E+9x1mcdC1mwCkq2US/VPIsyR03
         xz+JyA1URF8sb82o6w8zqpmkovVkUwsND3FCCauKrfN1sp5eb4mpuz+CUqQGo8X0vaR5
         DQp6NEankb8e0I7LVzTasTyP8Gg5PBUqOeHdlSyRZLRmfu6t5syoClEpzT7+MF/yyLUD
         mJBQ==
X-Gm-Message-State: AFqh2koEijt5sI01sIPNIRjy8Bxj1qoNeGsIDPZlrCSMkD1VVIT1l8vT
        jpVKaK84K3a3Sx2NGzfT2afpaQ==
X-Google-Smtp-Source: AMrXdXuN+K1vBJMRelJpQcZd+lJtspet80eKKFN6LeiLPG1BkFP4jO4WEIszB8YePk86AM6y94MHAA==
X-Received: by 2002:a05:600c:4f48:b0:3d6:8570:1239 with SMTP id m8-20020a05600c4f4800b003d685701239mr35213480wmq.16.1672652721945;
        Mon, 02 Jan 2023 01:45:21 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m1-20020a7bca41000000b003d1de805de5sm37458526wml.16.2023.01.02.01.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 01:45:21 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        linux-amlogic@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>
In-Reply-To: <20221125144120.476933-1-krzysztof.kozlowski@linaro.org>
References: <20221125144120.476933-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ARM: dts: meson: align LED node names with dtschema
Message-Id: <167265272108.284515.8939989113770770752.b4-ty@linaro.org>
Date:   Mon, 02 Jan 2023 10:45:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 25 Nov 2022 15:41:20 +0100, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern:
> 
>   meson8-minix-neo-x8.dtb: gpio-leds: 'blue' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.3/arm-dt)

[1/1] ARM: dts: meson: align LED node names with dtschema
      https://git.kernel.org/amlogic/c/efccf602b37fc1064214e6b5fdfa9e77879a9bca

These changes has been applied on the intermediate git tree [1].

The v6.3/arm-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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
