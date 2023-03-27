Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2A86CA0DC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233460AbjC0KIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbjC0KIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:08:30 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1699A4C2C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:08:27 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l8-20020a05600c1d0800b003ef6708bbf6so2779988wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679911705;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGoH4KvFumE/aZ3oDDGGiwEflY/XB6nXZQrLqw1tSnI=;
        b=syqWTErWORaOaEkKGE/WcSpMeaCjSH+kWTHXltMv3KacuoG1iBMJjyyI3Ypgi7VVKM
         IbhfWcST7FfiXNazxPT/YvX3zxOy2cOeWQVrPykLdYfRBUi1XNSHD/zx+OHmDSixjtNQ
         R6pqNc9Y0OhUc8j/4jPZY3QT/mfxgyCst7FYxHm/mZ445Gti7eA4lksC4qowfX9Qb2Gt
         shnL4UuD9LMgbeFQwgTadf15bkqQAsB76+Yjd/n0YQ0EowXaFTAKPzpUWrVTxf3DWsLB
         egmG8uVz3EAfN0mw82ZUhaowpyC/ZgJ8eP9sVbc0X2Nn/yyKo/7R2X7Zt78Nd9LFhxfN
         IMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679911705;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGoH4KvFumE/aZ3oDDGGiwEflY/XB6nXZQrLqw1tSnI=;
        b=lUn1v5UpSdRvN2z0tGAspMxuBzHJIi73L3mQ7xfRWR79y0PM3CzARASs03SuckWiOF
         +4iah3SmCw68FPXX7NZdkSaOx5O+2y2t8WU/lM8XU9f7G3P1MV1tNWz18lRpU3Pniaot
         Wq0irL/aDVuWfu1rYp6Ol05eRITtrB5r+JWp7cOSqFpKpRUSjUwXtr2qDQkJ4SOW4VhO
         zDm9d/ZoX3GDYUSYnLtV4rNDHDdc2uqj9iYwBFQg6t4HAL8cIGyTwEBzTZPfVKDG7Yv0
         EnpsCya+s0BwBV+nm3v2Pkfk7KKgVIZAk7TDlunppgs/xAgHyd10zJzAXJKZijXU7NGy
         7y1g==
X-Gm-Message-State: AO0yUKXtmLPMI7Nq/cNe0rLaZOleRM711gHsIO68LFCcEB8Vcknz28m7
        GNnMDbe8BXGbc9F6kX1tBQLGMA==
X-Google-Smtp-Source: AK7set8wE+/BnkmdZ5WYVo08VavTEhx5WcZTtPZM/fOa76aeYHFRLlZQ9S5YiCxFmmadow+sa0nakQ==
X-Received: by 2002:a05:600c:21c1:b0:3ed:8c60:c512 with SMTP id x1-20020a05600c21c100b003ed8c60c512mr9202174wmj.17.1679911705511;
        Mon, 27 Mar 2023 03:08:25 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m21-20020a7bcb95000000b003eeb1d6a470sm11182003wmi.13.2023.03.27.03.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 03:08:25 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     krzysztof.kozlowski@linaro.org, robh@kernel.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, jianxin.pan@amlogic.com,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     kernel@sberdevices.ru, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        rockosov@gmail.com
In-Reply-To: <20230324145557.27797-1-ddrokosov@sberdevices.ru>
References: <20230324145557.27797-1-ddrokosov@sberdevices.ru>
Subject: Re: [PATCH v3] firmware: meson_sm: populate platform devices from
 sm device tree data
Message-Id: <167991170468.420117.8412879129199021084.b4-ty@linaro.org>
Date:   Mon, 27 Mar 2023 12:08:24 +0200
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

On Fri, 24 Mar 2023 17:55:57 +0300, Dmitry Rokosov wrote:
> In some meson boards, secure monitor device has children, for example,
> power secure controller. By default, secure monitor isn't the bus in terms
> of device tree subsystem, so the of_platform initialization code doesn't
> populate its device tree data. As a result, secure monitor's children
> aren't probed at all.
> 
> Run the 'of_platform_populate()' routine manually to resolve such issues.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.4/drivers)

[1/1] firmware: meson_sm: populate platform devices from sm device tree data
      https://git.kernel.org/amlogic/c/e45f243409db98d610248c843b25435e7fb0baf3

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

