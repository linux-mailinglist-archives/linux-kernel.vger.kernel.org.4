Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7E9669017
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239960AbjAMIHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239237AbjAMIGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:06:46 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368B473E37
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:03:29 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id az7so20281710wrb.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4cg88Kvj07ysr7PkKeBFTLXDv0UkLAcK6N/8dHojlQ=;
        b=ygfMdWNuN2Z16VHFfsvMzsslRJmncYlx8ey16mv5SfPa6MmkB2lT66Wo4l6EBjARAB
         azqZFQ4UZzt3dX+0yqhdbmR/D8nvXcclLD9fhvSnIYXDs0aiLyyXXG3aS4yDlnk/miRG
         46xSCorwmANDOlRFh3/+GArMvqZSc38Ky6+YYWHi4W3iyXgTXYmzhP8FaC42QYZQQs3A
         WPMYAk/sFUvNQ8exZ0qIUsgbtqEsRX8sEwZgopuGbehKktSSR4jsqnlsrzcCOeJBv1UW
         GdCcPq8we34LMzE5UJYFVNOJiwejaWEXwq3De+0DxM24nzJkX1WJn9eDTgZNCPdsA10h
         n6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4cg88Kvj07ysr7PkKeBFTLXDv0UkLAcK6N/8dHojlQ=;
        b=BX1Pdza6fy2S03UwD4hhcJpyPoNYM4mAr6i91nd5CmOSCnnor8eVjc4Bb7w3bryzVP
         VH7LGqqyR7BAXQYi/Exi/sqTfQMRPSppFIJ1ZCi1fuAID4Luv0p64M5ocgrvgn9zY3HA
         wWX5dDTH22M8QqouLVjrqRyYsLDJmJfcAciV/elrsXi4071l923xyaVIeL11ZY2v7pRM
         sl58JnpM6C3XicIfh3CTzqMzXrsfHdrcyQSAsMHjXU0ObwXOVvRjX7Vo/9WyDSubATd/
         KZIVFNVmgRMxDxH97xvusdn0uPxhtjCDttdqyb4kB2MNY/7BWtmHTG7BoQ+xIoCp9lzq
         bpVg==
X-Gm-Message-State: AFqh2kp8O0p+98n/n2EV/8aDG0f1QGf+zg5Ay9iNiOfKxmCVvXzFr68e
        Dcxrkcc2biMS1kqgpWya5Eapag==
X-Google-Smtp-Source: AMrXdXuDaI+YoVgx3YLGtons/nw2H6aGdJuLoH2gqOGJh5Z6O6VljoPp9a/p4NafXMumh8+IsRd77A==
X-Received: by 2002:a5d:460c:0:b0:2bd:e208:1e3e with SMTP id t12-20020a5d460c000000b002bde2081e3emr588705wrq.62.1673597007754;
        Fri, 13 Jan 2023 00:03:27 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id o7-20020a5d62c7000000b002bbeda3809csm12609674wrv.11.2023.01.13.00.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 00:03:27 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20230111211350.1461860-1-martin.blumenstingl@googlemail.com>
References: <20230111211350.1461860-1-martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 0/6] arm64: dts: small .dts fixes
Message-Id: <167359700681.3617136.9064230631644160118.b4-ty@linaro.org>
Date:   Fri, 13 Jan 2023 09:03:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 11 Jan 2023 22:13:44 +0100, Martin Blumenstingl wrote:
> This series contains a few .dts fixes which were found during review of
> [0] (which is now the first patch in this series).
> 
> 
> 
> [0] https://lore.kernel.org/linux-amlogic/20230110215926.1296650-1-martin.blumenstingl@googlemail.com/
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.3/arm64-dt)

[1/6] arm64: dts: meson-gxl: jethub-j80: Fix WiFi MAC address node
      https://git.kernel.org/amlogic/c/f95acdb2b4af21caae2c76a48e565158181386ca
[2/6] arm64: dts: meson-gxl: jethub-j80: Fix Bluetooth MAC node name
      https://git.kernel.org/amlogic/c/cb199de1d3aecb02556d8a6e26393015effa0a9f
[3/6] arm64: dts: meson-axg: jethub-j1xx: Fix MAC address node names
      https://git.kernel.org/amlogic/c/2f66eeb06e3e8b1cac9e9093be3baadbac2709eb
[4/6] arm64: dts: meson-gx: Fix Ethernet MAC address unit name
      https://git.kernel.org/amlogic/c/8ed5310356bfa47cc6bb4221ae6b21258c52e3d1
[5/6] arm64: dts: meson-g12a: Fix internal Ethernet PHY unit name
      https://git.kernel.org/amlogic/c/e7303651bbc76c848007f1cfac1fbeaa65f600d1
[6/6] arm64: dts: meson-gx: Fix the SCPI DVFS node name and unit address
      https://git.kernel.org/amlogic/c/f189c869ad92787ddd753558bcbae89d75825bb6

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
