Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C013F6B5AE7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjCKLPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjCKLPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:15:08 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E331E1F3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:14:12 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id ec29so30734516edb.6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678533245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqnFWHdK7OkL6s/x+Horh58nZE+IP653IunDnJQbJV4=;
        b=wn7FVQFl7D3LMIfw29Qi1jtJ1MVwkM0EDx7SDmMVlQpPZ5Z8OlHgNky0ImuXoqfRPH
         HOIBqaVfLiMYyvenIsfFpJilxjljVUcOfIlgnqBk+mRvo/SWhWQF64W2CdhCzeQ68l+c
         JLHt6bAMGJVOWiphYP/YUW7qz0QALjbqRPxYK8QTi4EL1dX4/vYfi145nYdkd5ioNFPx
         YcV3bsrvZ41Q6CCxd73yqKiSRoOL8cHmuIzg1R/Co0Y5ryPOtRY4bb72pGfD5Arr7eoq
         /i5vHp2yfNDSzSrc/YDFxPvyaX2mx/q7nkH/1KSTA46KnLsPcmcJgDngsRDyam/mWby1
         GFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678533245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqnFWHdK7OkL6s/x+Horh58nZE+IP653IunDnJQbJV4=;
        b=XOJ1oEequtW6z1idvMpIzTocXscYUydKDlmOVzZBaxr9TIp0OUDJT0XToFg8zR2JGO
         TgUQNKPAmxhVhmL26mOLeJ0D+2KbUBb3xkpX0XLbqCa3bAgOzuBjy/k2iiTgYlgyO63s
         W+KZiLXi7iOpUNqLL5d4xoOlw0qNe4/lBEI7jHNOYr/19MzY2JnbpZfeEI7U2VUC6IWk
         FP0HK3FWLPurkAxTXZOWjqtsxRp44lX+nsO8NK25ExQWfpge1qqIDHjAH8qpasOTvuMA
         aKFvlTTkRS1fCWR4/HQi5Lm8l+8bQRt9ahgY06bNxjJC2rpeeYyB1FvWuz7sG2t9VXD+
         IIXg==
X-Gm-Message-State: AO0yUKWRhJ/3rs1IyiQl0r/t6ZDIFOlkWcC8yvTad/OsAiUckByH2BvW
        fz8E24zk/3zvB7Bi7IqrEKQA2Q==
X-Google-Smtp-Source: AK7set8FKt7DgZJCxADdonM8M5e0Zncbtd5P2PQt9Jg/NcC9iy3KbzD1PtBGcdMWo1JVDQsA6rHrqQ==
X-Received: by 2002:a17:907:7f87:b0:881:44e3:baae with SMTP id qk7-20020a1709077f8700b0088144e3baaemr4671177ejc.54.1678533245427;
        Sat, 11 Mar 2023 03:14:05 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:fa97:2d7c:bdd7:e1b])
        by smtp.gmail.com with ESMTPSA id q12-20020a50c34c000000b004bf2d58201fsm1053859edb.35.2023.03.11.03.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:14:05 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] Bluetooth: btmrvl_sdio: mark OF related data as maybe unused
Date:   Sat, 11 Mar 2023 12:13:52 +0100
Message-Id: <20230311111354.251316-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230311111354.251316-1-krzysztof.kozlowski@linaro.org>
References: <20230311111354.251316-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/bluetooth/btmrvl_sdio.c:43:34: error: ‘btmrvl_sdio_of_match_table’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/bluetooth/btmrvl_sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index ba057ebfda5c..d76c799553aa 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -40,7 +40,7 @@ static struct memory_type_mapping mem_type_mapping_tbl[] = {
 	{"EXTLAST", NULL, 0, 0xFE},
 };
 
-static const struct of_device_id btmrvl_sdio_of_match_table[] = {
+static const struct of_device_id btmrvl_sdio_of_match_table[] __maybe_unused = {
 	{ .compatible = "marvell,sd8897-bt" },
 	{ .compatible = "marvell,sd8997-bt" },
 	{ }
-- 
2.34.1

