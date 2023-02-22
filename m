Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0417E69FA0C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 18:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjBVRX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 12:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjBVRXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 12:23:17 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73693124;
        Wed, 22 Feb 2023 09:23:15 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id e9so8563861ljn.9;
        Wed, 22 Feb 2023 09:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LgHb4LTNou/T4gwWZDZG1bAr2SS3s1D2HvmIKlyTtyo=;
        b=cuqTIWse5qx2sN8ejcmchMPEuaSlrGt9z4HkUkR65iRc/Ex4L8YE8Xc0SHh6GqLY2K
         RNVAEGeb5nWU9hg6IXeT2PECD1/8btD7B0wtugdnholzLaNVZifh9cnZwZVUHVjvNIvS
         LGPNS4EQuF6BgueXdQo7/LG4Rju+LTTfeNnDLwVJNmIPv1ZD6W6hH+vBmMjqcQfpIxnw
         7Y92P/bxVPQeYXGLh92Geo74JtO3qYOGnvOteoqifJuWCRGrf1mIPnrMUrOCICMyI9bi
         IMgg8GyvCf5+7si1LU2zV/GLh3kOD6yVkebYjpYy0k9CnJaSwRBG9zwKdtmSV78NBGKP
         AlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LgHb4LTNou/T4gwWZDZG1bAr2SS3s1D2HvmIKlyTtyo=;
        b=hpBToqMl5YWhKZp0yQ4opSlUPvkmds8JqQQznwyYEclbPcYJXQEN/sA05ss/8zhtxp
         zUFoFqO5Dn8AtBwIncl/ugdE9Wa+gKMQ6z10utPqwGL0LHBoFOZgY63BGQZdn84eDepb
         3E7tvKDZ7V1ugUcXUUPMi1A+GbiCgfcolGtZUkQflSdKRc6Q930O99uLE/oGCZuCJhNK
         xjGNpimjmXkcUcREvrDWSZH5yq1HFRfhWvTSbmYtmKAXl/Qpbd24+PW9/CydhNA+BR0B
         2J9bOpSqE5fNPb11ppZWXgdfSoHYcVU7ap4bxa3Dp3HVVqmE0OeE/c5cdfkW8hl9O9Gl
         LjfA==
X-Gm-Message-State: AO0yUKWbxzW8ksRIOZkat3OQPGwFuDYKXqWatx/ULfe3E5Nos7h5BpiT
        dEDya4/McqIjAYllXzx7W0E=
X-Google-Smtp-Source: AK7set/KWDvPSuMOkojBZB4RaqhrJysKCZKevJPXANsg0HBsYaa6OJZG6Ye7zg0PxpTbLNyKiuY/1g==
X-Received: by 2002:a05:651c:2051:b0:295:74f5:fcaa with SMTP id t17-20020a05651c205100b0029574f5fcaamr3070632ljo.32.1677086593514;
        Wed, 22 Feb 2023 09:23:13 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id p2-20020a2e93c2000000b0029477417d80sm721513ljh.85.2023.02.22.09.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 09:23:13 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 0/4] nvmem: cell post-processing & U-Boot env MAC support
Date:   Wed, 22 Feb 2023 18:22:41 +0100
Message-Id: <20230222172245.6313-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

U-Boot environment variables are stored using ASCII format. One of
important entries is "ethaddr" which contains base MAC address.

That NVMEM cell requires some extra processing when reading:
1. ASCII needs translating into binary MAC format
2. Final MAC needs to be calculated depending on cell index

This patchset was originally based on top of layouts implementation
which sadly ended up dropped for now. To proceed I rebased it on top of
the current NVMEM subsystem code. Michael's patch has applied cleanly
and this approach *will not* make U-Boot env transition to layouts any
harder so I believe it's fine to take those patches without waiting for
layouts updated implementation.

Michael Walle (1):
  nvmem: core: add per-cell post processing

Rafał Miłecki (3):
  nvmem: core: allow nvmem_cell_post_process_t callbacks to adjust
    buffer
  dt-bindings: nvmem: u-boot,env: add MAC's #nvmem-cell-cells
  nvmem: u-boot-env: post-process "ethaddr" env variable

 .../devicetree/bindings/nvmem/u-boot,env.yaml |  7 +++-
 drivers/nvmem/Kconfig                         |  1 +
 drivers/nvmem/core.c                          | 38 +++++++++++++++----
 drivers/nvmem/imx-ocotp.c                     |  8 ++--
 drivers/nvmem/u-boot-env.c                    | 25 ++++++++++++
 include/linux/nvmem-provider.h                |  7 +++-
 6 files changed, 71 insertions(+), 15 deletions(-)

-- 
2.34.1

