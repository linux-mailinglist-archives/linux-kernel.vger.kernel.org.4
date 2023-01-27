Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A8967E67D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbjA0NVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:21:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbjA0NVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:21:09 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDD683958
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:20:56 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so5413379wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 05:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iw0lautMML9+B9oBLxXJ8thF9HPKzqCb+aG8qr+zu50=;
        b=uXKcQwboXefuGg34DkvLPbnO42hDpxiN0i9AeKvmVXXjwlAnXHR4GiFOkhE5R6uyLk
         lLGVldCh5cYb+LXp8lCEsaTAzPQdTZkCWraK5jm/CoCvG4G6ahz2+BOK49cjKOK5VrHz
         s1dimII/1cH7RJQ6G/7DUJqlOKsm6LlrrrjbIPQQjnIBc4EnDeU/6TfofV8amZIorAlc
         9qJ5a8SMefycA/vLSCcDLvZo3IAIhC8nuhLVG0pQc+SrjeUuyd6rQ+Z6bpBj5jfTnmLB
         ySF38h8CY5sgcyW90AyzdHOz+576x7Sz648KFvpmx4zXuDF38UFwxImHehhLtRNj8bZg
         oJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iw0lautMML9+B9oBLxXJ8thF9HPKzqCb+aG8qr+zu50=;
        b=K1Y1fLsF2vut/h+fvOzJizYbVsh3PSgOP2QXn6bvbGyGMVrHw3+ig0QhFCfDAl98bO
         r93fuGKT/lxiFtuoMJqrlhT6bOyVfKuZa8AM6lYsGapv7o+w4fCeCvFoKp2Z9gnMLyVg
         tIL6d2zyNWsAd7ff3NbJvIE0+HPuyMTEMulWrcGBmtfLoGkJDlQoazrO976w14Y1yffZ
         XhOu36BJDyv+0Jncq/U5gCh2mLiwuvRHZLfu26piUedZnbghX1GTvLSRx3lGhRaerzGN
         oj+dH4qkrUEBzlhCtPcgxTnU1Vx90/WsYkUMSxjSBONg6vvOzWDAVYnhVSNpktwtIiA/
         mj0g==
X-Gm-Message-State: AFqh2kpsmmkBgm0MDnFQdkCEq7AFkfIQ6g1d96B38RaRZNxX+8s7Q5i7
        NNAWYRy1ZaIW29Nkom57kBBhhA==
X-Google-Smtp-Source: AMrXdXvdCH47nU7ML39r6l1guaL9tDkEaE32Ak6WDXsKPnrT6ag+MUHNn49hIMPBp5XqjlWMArP2iw==
X-Received: by 2002:a05:600c:ad4:b0:3db:11d0:21e2 with SMTP id c20-20020a05600c0ad400b003db11d021e2mr36391836wmr.29.1674825655058;
        Fri, 27 Jan 2023 05:20:55 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id bg6-20020a05600c3c8600b003db06493ee7sm8906473wmb.47.2023.01.27.05.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 05:20:54 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20230127103913.3386435-1-christianshewitt@gmail.com>
References: <20230127103913.3386435-1-christianshewitt@gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: radxa-zero: allow usb otg mode
Message-Id: <167482565422.1669662.8122640004261744864.b4-ty@linaro.org>
Date:   Fri, 27 Jan 2023 14:20:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
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

On Fri, 27 Jan 2023 10:39:13 +0000, Christian Hewitt wrote:
> Setting dr_mode to "host" prevents otg which can be useful on a board
> with limited connectivity options. So don't force host mode.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.3/arm64-dt)

[1/1] arm64: dts: meson: radxa-zero: allow usb otg mode
      https://git.kernel.org/amlogic/c/ce43ea00b927805c1fd0450ccc9b4b6069e292c5

These changes has been applied on the intermediate git tree [1].

The v6.3/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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

