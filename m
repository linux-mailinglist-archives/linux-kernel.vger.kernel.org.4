Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF506AD8AA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCGIGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjCGIGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:06:35 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB2588DB0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 00:06:26 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso9822173wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 00:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678176385;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlixcmRPU0kwlxyRa6XJ1Wvf4b87DZOdNPk167ILrOo=;
        b=he6cKusNCUpkvICX9VIckGy2epdvPViwko/K7fRoU5NihoUHmLgLPMeeh2w/Zz3jrh
         /GlaAAxI5qDtv3W5/Jf43SezLl5FaSNnS9V8OZI8j+nw9zYh+UAQy47tH/mUNa8KXAsi
         6VT/fSI4f9wwXxHzc79DQhVAumzXWp7XgiQiNN0S/LaofJgq951JLwgUbhCZySVnO1cl
         o4/dtStSWUIQWH/orQI/LnfwjFCq7iGbsrlYWPx/fmzNXErTi31vKGx3W/wnCzzbl7ub
         9BS9uhbdAcWHvpPFfB2ruYbTBI2Q/GkodWJh6QVauTmxHF7xN2xftPvNPF/1dAFoJefj
         xBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678176385;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wlixcmRPU0kwlxyRa6XJ1Wvf4b87DZOdNPk167ILrOo=;
        b=BMCt4a+9KE+s8sKpRZUlHvSbcy1qSSIQ3J1xXoCkMQOtjwvg73pE4VkSWRa0Sfd7HE
         4UHkkjKPukI8jbbL5+u7aRcXcOqMVJ+Shrf+BPdltEQyBnz9Xr1xTqcNVOOwFgsmmk3Y
         8lsJwDz4dMhuI0nmq9a0wxtBljpn1bPWPEHUch0MwV6ZIYSr/k7AD/EzSI4bvar2IXP7
         kLJwkKTNmCkXJXFHI4I5dMyJVXDWdRgIblh6An9jFYZ5adKd/U7upVJ+FCJF//IXxBDC
         2zAhcZCRgxns+eToydpViaaBX/Iw9ITU4fT3SklkqiLRerbcpRpD2UQEieyaHTYx+iBy
         geRw==
X-Gm-Message-State: AO0yUKVS6lpQDrD0BsY2PiRzT1MMgp5dd/eUXZhsyZXDjYIsts9VzQKl
        JOj+i+7iklliKaZu1SaiH5HN9w==
X-Google-Smtp-Source: AK7set9/dRT/dzFhPvrICG4vwvaMfeiVpFBx/GhL+4bReBNVsMts2vq/bj2VLCXRaf4cWgBN6DcMlA==
X-Received: by 2002:a05:600c:3b9b:b0:3eb:3998:36f1 with SMTP id n27-20020a05600c3b9b00b003eb399836f1mr12408519wms.41.1678176385065;
        Tue, 07 Mar 2023 00:06:25 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id s17-20020adfea91000000b002c6e8cb612fsm11671889wrm.92.2023.03.07.00.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 00:06:24 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20230303-topic-amlogic-upstream-bpi-cm4-v2-0-2ecfde76fc4d@linaro.org>
References: <20230303-topic-amlogic-upstream-bpi-cm4-v2-0-2ecfde76fc4d@linaro.org>
Subject: Re: [PATCH v2 0/2] arm64: amlogic: Add initial support for BPI-CM4
 module with BPI-CM4IO baseboard
Message-Id: <167817638406.768652.1431202103503389441.b4-ty@linaro.org>
Date:   Tue, 07 Mar 2023 09:06:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 06 Mar 2023 09:31:37 +0100, Neil Armstrong wrote:
> Add support for both the BananaPi BPI-CM4 module and the BananaPi
> baseboard which is comnpatible with the RaspberryPi CM4IO baseboard.
> 
> The BananaPi BPI-CM4 module follows the CM4 specifications at [1],
> but with a single HDMI port and a since DSI output.
> 
> The current CM4IO baseboard DT should work fine on the Raspberry CM4
> baseboard and other derivatives baseboards, but proper DT should
> be written for other baseboards.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.4/arm64-dt)

[1/2] dt-bindings: arm: amlogic: Document the boards with the BPI-CM4 connected
      https://git.kernel.org/amlogic/c/92c0b261c294f12e329976a6d4ef72651e8f07f2
[2/2] arm64: dts: amlogic: Add initial support for BPI-CM4 module with BPI-CM4IO baseboard
      https://git.kernel.org/amlogic/c/0262f2736978b1763363224698f47112a148dab0

These changes has been applied on the intermediate git tree [1].

The v6.4/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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

