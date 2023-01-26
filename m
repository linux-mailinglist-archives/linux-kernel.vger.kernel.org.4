Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D797D67C5ED
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 09:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236338AbjAZIfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 03:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236171AbjAZIe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:34:58 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8671725
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:34:16 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id f19-20020a1c6a13000000b003db0ef4dedcso2764655wmc.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y3TzVEfEJ82Zcir6qMcrdd/Fw4l7IDS+8TiKObawjuc=;
        b=TH1l+DrVsmgeFj7NTgYxoGCraCHc5HR5VUTpjIxdUYxbflqE6+yfxwl2+nCMdykwLK
         BB5/5/raFp+gzICKmf/iIWIQ3nqCJ7OKdMYBNxSlj6YLuHpMGiO/qG3KMzyhegwAzOaN
         JxHcLY/yWtXbjPWYhJA+HPaFCZxIR36TAms4hYroiqJrwUc/5hg/xHtzREr/ESEUFYpL
         9XH37Tw2mz9UZixZ+3BwcscTlHtkww6Anv6EWzNUR43DKzb5bHPp9/vFRWlLeJZtL66k
         5fhc2U4Xvqi5b4A8qz2oofsPBihcDoxzHNE6KiIIlCqCc+h0o24qzOcm/rcT4l9EfVMx
         1pVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3TzVEfEJ82Zcir6qMcrdd/Fw4l7IDS+8TiKObawjuc=;
        b=cEmrSKy4q/s99CatnG7c70jfIadl/924+x+s16Y9YzFqy0na71vzeslCnMI/KqXlPX
         taYtyPxORx/p0eovCggQsbQeLYyzhHWmshJSsi4uuXG4U7xetMJRN7KBBCjnP2zchluD
         Yuy4/3SujfmdprVDDiYKwVU7pI2wx7UJcWWzdL7vBtwlIPlz5ItlOBS+WrQfDC6tbwx1
         Bz/oZbzrcyBuo4dszfC4y7Qv3td1BvfRngIUCmsMxTcgZ3nogdQL29+25Ob3uoaIppPv
         00KnP1TQzh+YZr/GA98IaVsMabnSK4/+I64alWgnP39d38YuaraC82RKZrjqNmBkYWll
         U4cg==
X-Gm-Message-State: AFqh2ko+/NFG/x3yAo2kOjk2mH1c0PBL0IHuFWjUpyDaK1PkICPhPHHy
        MReIKufvin+iuomcN5VjiLWYmQ==
X-Google-Smtp-Source: AMrXdXt75Poh2V5szcz9pL/nP4XYvAND7gBaK6soFPsY8rk9bokbpwvJ9xGN3KkBu1q+UAXnvVz93A==
X-Received: by 2002:a1c:ed1a:0:b0:3da:c07:c5fe with SMTP id l26-20020a1ced1a000000b003da0c07c5femr31661418wmh.5.1674722041781;
        Thu, 26 Jan 2023 00:34:01 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c328a00b003d9a86a13bfsm757709wmp.28.2023.01.26.00.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 00:34:01 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20230123065834.2670125-1-christianshewitt@gmail.com>
References: <20230123065834.2670125-1-christianshewitt@gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: add audio playback to S905X-P212
 dts
Message-Id: <167472204102.456104.8089896495896736557.b4-ty@linaro.org>
Date:   Thu, 26 Jan 2023 09:34:01 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 23 Jan 2023 06:58:34 +0000, Christian Hewitt wrote:
> Add initial support for the HDMI and Analogue i2s audio outputs.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.3/arm64-dt)

[1/1] arm64: dts: meson: add audio playback to S905X-P212 dts
      https://git.kernel.org/amlogic/c/7e01e14e9f75385910d1e42f97a5e98f36244967

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

