Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918A365AF99
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjABKeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjABKeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:34:02 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA94B10E5
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 02:34:01 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id ay40so20127003wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 02:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mgGt+WDil8dXaAkpJ8qZ0avMhy4Myb58QPGVDym6jk=;
        b=yNsiE5cnW7N2EYqUIgR6oylWXDpokhhUBC++Hyr5GSKhbbGYxxLF6AxDzhQlxgp8bB
         iP9FHXzLpMBT4+H0U+GeaOZgaqPkosrF71zTJbgP0DTCTH9Iep+XVGkqJPQ1AOwrWdKi
         gyUCqDrOD0r3EbPZfuAHfx4yVfSW0Ww1GfTy/GOP7wWX+VgUzWfWDepBAvPLMOsoNCmn
         0CJyADgaPbJFbsBqtM5gEmmtlJ+ndqG80yihZN4wiwzcNdNQv/eJbAfTVlioeKWnBQ8g
         u7Mk+2qHk6PzpoxLBm+ikqT+ux1UVPpr6X6D0Oxepk3AV8ORdC3Fqr22906Vtn31Ju5R
         mL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mgGt+WDil8dXaAkpJ8qZ0avMhy4Myb58QPGVDym6jk=;
        b=H8KEc4cXEU2WzA+VzHVjxoiREAmrLDDlpJEq4Ehl3+otvzKCxmulVmJUAzIsdkF4rY
         7YtbGlhpZa4sSaOg5VBtHzNnPNm6u99Ak5BtRfdycDX6l4eau6tT37ACYdDUX1SCUSn2
         JMlGp3ErHK9fqzFFBji5VcwshLd/Bv41WEldr/W94TXKZLD7DPcvkXOrVbzTnZVDEmde
         Qi66crTs8Pu+X8NWIY/B+OipqHJj2A2Zi2sNW9xUpGQ5GR4Vqfz2h3ae1OytrEn8Kh17
         p8V9APaRkGeggE9QLeqBsk5kqueDhJhmaPOH3ElDzDV4vaH/s7RLkWKQem/3/U6DTjXe
         hwOg==
X-Gm-Message-State: AFqh2kr4kyv0iG4TJRyX5Vpv3IJLqTMnPmHnzUiXNYDbNEisByB72hLz
        ss5Fe25o1hBLfzO+oF/a3uHLNSrrvo++d4RR
X-Google-Smtp-Source: AMrXdXtR8Zpqr1OOrcZbsXvxGi2rMh686vRDHyobS4MDPmdqNXmhUxFGkbSoZEpsVKm7yR6UFphmcg==
X-Received: by 2002:a05:600c:1e09:b0:3cf:b73f:bf8f with SMTP id ay9-20020a05600c1e0900b003cfb73fbf8fmr28237316wmb.7.1672655639818;
        Mon, 02 Jan 2023 02:33:59 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c0a0a00b003d96efd09b7sm39558447wmp.19.2023.01.02.02.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 02:33:59 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        "open list:DRM DRIVERS FOR VIVANTE GPU IP" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        italonicola@collabora.com, Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "open list:ARM/Amlogic Meson SoC support" 
        <linux-amlogic@lists.infradead.org>,
        "moderated list:DRM DRIVERS FOR VIVANTE GPU IP" 
        <etnaviv@lists.freedesktop.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Amlogic Meson SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Christian Gmeiner <christian.gmeiner@gmail.com>
In-Reply-To: <20221202115223.39051-1-tomeu.vizoso@collabora.com>
References: <20221202115223.39051-1-tomeu.vizoso@collabora.com>
Subject: Re: (subset) [PATCH v6 0/8] Support for the NPU in Vim3
Message-Id: <167265563884.375287.14738065029964626826.b4-ty@linaro.org>
Date:   Mon, 02 Jan 2023 11:33:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1
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

On Fri, 2 Dec 2022 12:52:12 +0100, Tomeu Vizoso wrote:
> This series adds support for the Verisilicon VIPNano-QI NPU in the A311D
> as in the VIM3 board.
> 
> The IP is very closely based on previous Vivante GPUs, so the etnaviv
> kernel driver works basically unchanged.
> 
> The userspace part of the driver is being reviewed at:
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.3/drivers)

[3/8] soc: amlogic: meson-pwrc: Add NNA power domain for A311D
      https://git.kernel.org/amlogic/c/9a217b7e895313a4d42f7a6c48b6237a595945f4

These changes has been applied on the intermediate git tree [1].

The v6.3/drivers branch will then be sent via a formal Pull Request to the Linux SoC maintainers
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
