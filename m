Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2226567C5EE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 09:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236397AbjAZIfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 03:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbjAZIfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:35:02 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A377729D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:34:23 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso3730776wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 00:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8K+2b6qYGhmrfMApP1JL3olzeZ2YP6lL+7+ixOQ9ZM=;
        b=wZTc+VS63T54L++Dg9SWngu8T2SVoeTNy0W/Z1PzOO9b5RxByDYJDJ+us87HIOHZXC
         jgZ+02pGdY55M73FZVGymHp0dYwN/nrKcl8lS+VjEaqg8wTxGe/vodlxnCik0u26DS2P
         iih6YNSyAXU02uf1bV3gd/5hWFK80QxMO0JivFc99xWDhFloJlc/TKKRHaG/S4L62xpq
         bMq6klHfhm6xopM8BFklBsnDyDjasKwqXxpv801JhSUQ819QQZnopjsB24uTf9j04I+m
         6YUM9JX+/yh9WA1+loY4wxQCeQFy0nq+0+59xqYMrohoIUDVHG2DYAbjCAt/UOqxGIPy
         hrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W8K+2b6qYGhmrfMApP1JL3olzeZ2YP6lL+7+ixOQ9ZM=;
        b=ySUGgryaMeq7wZCHxWQBq1dko4UjGHKUG19yk9U0wYJn4lsnhQz34NZMVWWGeymYhq
         KM2nYwVlEvsOBxa8vqGJTtpZnjQcJNj4yeZUkKTsb/XPC/NHfBg0juP+poCqxU8hCBja
         mrxR9DI/jexqFWK5sWL2LVuwjx6g3eKhZf3LM7Y5sYROnCehvPDyZbe05P1HyFSPKm/w
         IdBB443SV1rYhYLSk8G7Xcg6/C4XhiQ7L8/LCe8jxqTiSh5nevYMew8mPzNhwBY74lP2
         1uebVjUCJDtYFiIcnL78cxRd0SB/Srs20cpIO652RcuP1EnD3ow8IwaWHMIBVR/vMtNh
         12cw==
X-Gm-Message-State: AFqh2kpHgjo8vcTx/iy79c/vftTE+Wyta3yJPBvILC4rM7SDpzwBqb8G
        tilN7VzOvO2GAQqpLSTXWjIDzQ==
X-Google-Smtp-Source: AMrXdXvUlBtNOqLtKPqGUlEcp3fxlZ8HEpJE7yzJc6lt9UmTN/nHDTyQna7hQ9xXWwN3B4tf6G3DSg==
X-Received: by 2002:a05:600c:6014:b0:3da:2032:6c0f with SMTP id az20-20020a05600c601400b003da20326c0fmr41886222wmb.31.1674722042720;
        Thu, 26 Jan 2023 00:34:02 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c328a00b003d9a86a13bfsm757709wmp.28.2023.01.26.00.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 00:34:02 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ricardo Pardini <ricardo@pardini.net>
In-Reply-To: <20230124-topic-odroid-hc4-upstream-fix-fan-trip-v1-1-b0c6aa355d93@linaro.org>
References: <20230124-topic-odroid-hc4-upstream-fix-fan-trip-v1-1-b0c6aa355d93@linaro.org>
Subject: Re: [PATCH] arm64: dts: amlogic: meson-sm1-odroid-hc4: fix active
 fan thermal trip
Message-Id: <167472204189.456104.2228463020906844378.b4-ty@linaro.org>
Date:   Thu, 26 Jan 2023 09:34:01 +0100
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

On Tue, 24 Jan 2023 12:39:08 +0100, Neil Armstrong wrote:
> Add an active trip tied to the on-board fan cooling device, which is better
> than describing it along the passive cooling maps.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.3/arm64-dt)

[1/1] arm64: dts: amlogic: meson-sm1-odroid-hc4: fix active fan thermal trip
      https://git.kernel.org/amlogic/c/1d2f14117aa7773efff50f832b85fc7779e586e0

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

