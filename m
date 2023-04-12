Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B526DFE1A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjDLS4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjDLS42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:56:28 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABF765AA;
        Wed, 12 Apr 2023 11:56:26 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so14691677wmb.3;
        Wed, 12 Apr 2023 11:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681325785; x=1683917785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vsdADzxjpVh6QL3C9hLrK2BcPe1u8rSv1rhYITO+59s=;
        b=jt9NaYrVPc2v7sd2EXR1GdF5ofeN8UvVwlbP8lL0DzYTJl6LGcy3HCuHVxjrA6auCK
         HVKV8jHMn/AFGinSgnRG/YNJ4wHK/5zCRXTVjGYHGQJ3Xn08tA2MAUTElRpSyFfDQBqe
         WLp4YERHvzBiabrHqjFexaGLpNUpHwSblwZRLE0FUgYU04NqToaEArl2wz1dB0O2rEJQ
         yXXldYKIK17o5ItXgMy2rGxSEw1fnJvuW7B8PSPJkKs8woom7XPZJ5c0AnWkQjfFQXCa
         FbbNj4OArOQh2assr2lLWi0CdeImRv83vqloXm4LXN1AZO/En5tVRNHH3YG1eQUJcWM3
         U5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681325785; x=1683917785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vsdADzxjpVh6QL3C9hLrK2BcPe1u8rSv1rhYITO+59s=;
        b=eRXjg3OvcY04dvsvEOGH0/+T1OnxEW8Hqbzs28EcY02oDptVj5lTMYOql0YGBcwN+d
         DewBUNAVhhnPqq5XUlpTwvJv8vVjvEkzJ1ZxR2FnFE7n/9f9ulXurD1fXgas1CF2Me6R
         wMOiny0saOcY/SG//jj+ySId84EjSCXg09U8cYLgCFYIOQ+NSCkOXQsmobaNp+Jydas+
         lbcNSLQuDyMuoyxpEZTTNnExg4+dXZnljYGKUEEynrDi6NgRj2ow4S3/pul/VkzdyqGo
         +a2IrD1uUzzCdo25lWF+/eeMc2Yz1QK7kyyqwZ3ZModC1ci1o0VP0vSoZmKwCbY57bTh
         qB0g==
X-Gm-Message-State: AAQBX9eIHhCkMlHHXBYreAz5h2xgbb6aBjTz9YA4etBDmNPcNbPz/UnU
        Z3jNa8gdQUy/KV/o5PszUYY=
X-Google-Smtp-Source: AKy350b3VYstOoOvxv0MTS4IY2rGX89EIxyMPGAUcHuZhhUjgkBr8OsAPRn84l7moSFdPrFHRUNs7A==
X-Received: by 2002:a05:600c:21d7:b0:3ef:561d:255d with SMTP id x23-20020a05600c21d700b003ef561d255dmr12921319wmj.41.1681325784614;
        Wed, 12 Apr 2023 11:56:24 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:a00d:9fa0:9d0c:b9db])
        by smtp.gmail.com with ESMTPSA id r13-20020a05600c35cd00b003ede03e4369sm3362705wmq.33.2023.04.12.11.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 11:56:23 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/2] RZ/V2L: Add CRU, CSI support
Date:   Wed, 12 Apr 2023 19:56:06 +0100
Message-Id: <20230412185608.64628-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This patch series adds support for CRU and CSI support to RZ/V2L SoC
and enables it on the RZ/V2L SMARC EVK. Also ov5645 node is added which
connects to the CSI2 node.

Cheers,
Prabhakar

Lad Prabhakar (2):
  arm64: dts: renesas: r9a07g054: Add CSI and CRU nodes
  arm64: dts: renesas: rzv2l-smarc: Enable CRU, CSI support

 arch/arm64/boot/dts/renesas/Makefile          |  1 +
 .../r9a07g044l2-smarc-cru-csi-ov5645.dtso     |  2 +-
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    | 79 +++++++++++++++++++
 .../r9a07g054l2-smarc-cru-csi-ov5645.dtso     |  1 +
 4 files changed, 82 insertions(+), 1 deletion(-)
 create mode 120000 arch/arm64/boot/dts/renesas/r9a07g054l2-smarc-cru-csi-ov5645.dtso

-- 
2.25.1

