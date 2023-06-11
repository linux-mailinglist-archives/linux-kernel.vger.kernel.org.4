Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A2972B23C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbjFKOGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbjFKOFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:05:31 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D183ABB
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:04:28 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-307d20548adso2261741f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686492254; x=1689084254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5RZ+PsFHSICdpk9dqdtalAc8LcTISQxgy8iMzkYMo4=;
        b=eUfnMdUSf3yiAKbwM1pB23vviIM+JMy8GDHeWPbhrnapSBef8q4Qyi/mSXanHRfX7t
         YNtbjDcm6AvwnowMiwWM7u/SS7KqY2W/Qo+kCOh5ktUJaoEhUINCqOUMLu5hVfIwyNhU
         1urrmeu2zBVfH3Necxr2jw11RlBrnwLCdzaI07uPbr5tiGUEkb6Qzeg7NpdBLx5tBAuc
         7y51R5JcdzoEXOAhbLUqS0CtlkEllKS4PX8NeUaoWrkre+JzAROzciK8WMTlwd88OZkU
         l1keDB8G0ksJZXvwk0VkYTKCYgmqS4C80tO/+mR+XVRC3opkxQVnv2pSZiDgne4sqU1E
         FboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686492254; x=1689084254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5RZ+PsFHSICdpk9dqdtalAc8LcTISQxgy8iMzkYMo4=;
        b=Ngxz6wtLbZn2zkyJtNDm7U1/cN2dTJZzOKjL6nETfW5tSRffHYDdFSzUx4Ci7nB90s
         sgpE27AdmgcSXrGYHYK1h8YAcPFa9r4CNRC4xaujJ1Xi80vU5yHYKamm1VyMJFmXeMFd
         SiM5c4J6jKVBjJUjXFQeXth508gB7gKJ2qV/cuvaoZI9SWcawDzSVgGsK/GID/xbCooc
         wT6oWz72bG1Tt81MAL9a30QcC6uNxkjCXUx2dGCxxLIyiPPDcr0oqk9SdeDfMnLJW1/L
         Xl7DF+FrxMB09sTzuHHsqd+INMD7zPRk2vBC0L5LGkOFTw7QiNgC8pJThrPkPA0LXoqv
         yrAQ==
X-Gm-Message-State: AC+VfDw7MeikSiOtjj0+twn6C4Qg0xo+kh5z9FqsJX1hySF1M/DKCgcc
        /Eq4k1m8KdjY0pEJrFywHt+86XFzv72Uoa0ui9U=
X-Google-Smtp-Source: ACHHUZ5uHgy1Av6Z3JSSZZS5BzgTHmvobX2DrpjDQCsudHPU2L2fmj5c301klWTl6BSLO4XeF9bUww==
X-Received: by 2002:a05:6000:12c4:b0:30f:c033:50df with SMTP id l4-20020a05600012c400b0030fc03350dfmr734253wrx.33.1686492253977;
        Sun, 11 Jun 2023 07:04:13 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c28d100b003f080b2f9f4sm8567222wmd.27.2023.06.11.07.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 07:04:13 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 22/26] dt-bindings: nvmem: mediatek: efuse: add support for mt7986
Date:   Sun, 11 Jun 2023 15:03:26 +0100
Message-Id: <20230611140330.154222-23-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
References: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add compatible string for mt7986 SoC.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
index d16d42fb98b6..7ec2988b597e 100644
--- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
@@ -27,6 +27,7 @@ properties:
           - enum:
               - mediatek,mt7622-efuse
               - mediatek,mt7623-efuse
+              - mediatek,mt7986-efuse
               - mediatek,mt8173-efuse
               - mediatek,mt8183-efuse
               - mediatek,mt8186-efuse
-- 
2.25.1

