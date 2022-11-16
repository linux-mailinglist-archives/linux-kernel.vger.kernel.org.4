Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B66162C8FD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 20:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbiKPTbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 14:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbiKPTbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 14:31:34 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26695627D6;
        Wed, 16 Nov 2022 11:31:33 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id l14so31623009wrw.2;
        Wed, 16 Nov 2022 11:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Trwv5nmiMu3txEdazub9avWN4gnKwT8sOlk30QnmJwg=;
        b=TpR01OSJYvsdxK5CvtEpxvA38/rAnBpnwSoKmqIekRAqZwQBoPSV9Xj2Ne3wK/Sdof
         4eWzngjNSKuqa81iPoDWL5je0mOPCWG/Rvv/u8jQP+/ajPySKZ+sqlRMO67N8boUB9k4
         ZocpAowec4j3kY7AZvLkvV2OAVf022ACl133s5a7KDtK7/C+l8eGMgEZ876c098nNCOL
         Lo4pNKwoZE8NyCgxjjmXojeBiGsTQEPC3vz4QdBFueYOZdMNv9EnOIxnbW4yalJJEr+u
         dGn1MNb9q3nBlGxmR75VnEmsEybTFq0fHX+pqkkAnPNfo/vEEg3gT9IQOh1JR6IhhzP8
         qBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Trwv5nmiMu3txEdazub9avWN4gnKwT8sOlk30QnmJwg=;
        b=tCu6vaXNNFe1E0zJ8PM3qs9sINsFhG5jawUAOefgwyzbFUF/cdkDhxU0/LTrxiQyoP
         Z92Oo6YX/pnbgsK/wGlRzAr3r0cCRvTTn6QkOlzAtd6d6NEdcSbjCH0H6wP56bhaecqq
         YEn0T9Hwr7twyYXjupA7sJgzNvO/PhmopAEiV4UA6YuoMOWHIsGjRxRhCJ+FJD6wjoZn
         ga2m5KDq0HMpsgzkm760F35vlPKGyr1zxEH8chy6K/3QdiuRLn26ykO83WurLAtTMl76
         ttoSLVL3Xi9SqRGXE56/Tfi8NIaiVaSmACLPrOvgCAi1LTnvNq1q++7Q6CfdOXFz3QiZ
         tzRA==
X-Gm-Message-State: ANoB5pkHNvmGvrnZA9j8v3+IRe5VhK/GGtPYmJZYyeowKNnCaLf5wwx9
        pgLG3YqGIJIuDtDJYCV64IrhvvX2wXcqWA==
X-Google-Smtp-Source: AA0mqf7/xPmVf0Rh22RU3CMEhI/LOjiRILBHHKXXqC9ktwO3Ja61VlrpZ4x4Cinr+HUtE54Y/6SXaQ==
X-Received: by 2002:adf:ea4d:0:b0:236:8fa1:47cf with SMTP id j13-20020adfea4d000000b002368fa147cfmr15476153wrn.50.1668627091714;
        Wed, 16 Nov 2022 11:31:31 -0800 (PST)
Received: from kista.localdomain (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id q125-20020a1c4383000000b003c6cd82596esm3044646wma.43.2022.11.16.11.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 11:31:31 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        samuel@sholland.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 0/2] arm64: allwinner: h6: Add second IOMMU reference to Cedrus
Date:   Wed, 16 Nov 2022 20:31:03 +0100
Message-Id: <20221116193105.363297-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.38.1
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

It turns out that Cedrus on H6 actually uses two IOMMU channels. Manual
mentiones two IOMMU channels, but it doesn't specify which is used when.
Page faults were also observed from both.

This series updates binding to allow up to two IOMMU channels and fixes
H6 DTSI.

Please take a look.

Best regards,
Jernej

Jernej Skrabec (2):
  media: dt-bindings: allwinner: video-engine: Fix number of IOMMU
    channels
  arm64: dts: allwinner: h6: Fix Cedrus IOMMU channels

 .../bindings/media/allwinner,sun4i-a10-video-engine.yaml        | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi                    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--
2.38.1

