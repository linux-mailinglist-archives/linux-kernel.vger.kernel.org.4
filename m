Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC15C6D6A66
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbjDDRXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236042AbjDDRW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:22:58 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2F255AD
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:22:30 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y4so133656962edo.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WRr5ZoNNmYrvvcmB8++Bz7tz2TbhDH2e47FZUrzItY=;
        b=faQGny6wvH9NTbqTtJHiNEpgIZ5ncUCxiGMDBpYBuf1JjueNmg9oyH9amtFQ287jxU
         jwLWU+qxMMAT2oyKrIUK+i2g7wqcG3+CBpfY47Y4lKZnk1k4PNeQYEkrzcRyh8ttfjSr
         r7JgBE1S6zq4OFAPJwTAmuXrXiZIetaxIc7rVlYT8mAGzOdExmtE2/eJdytJrxPfkbf1
         Syc4a5oOewFfo2y5DQbt34ijCa1Y8G0CbbYoSPFHhLT+x/ohFXVXyxcSePfftzzM+RgK
         u7IP3zN7Fgmce4hI0TqzZRiBKjw8PCErwMDi8TYVyCIcY5Fp5KHShWFfXvWeJ+spzrDs
         z/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WRr5ZoNNmYrvvcmB8++Bz7tz2TbhDH2e47FZUrzItY=;
        b=y4Won/g7fYdji6+oSnAMBoE24cwHmKoqmJNsXanDcKVMBOPB+efy13wdV39VFXKxe6
         iNRJEvq+nbnl2sadhRkEt6VXlc73ejdmsZGuaFg3sotrt9FfES2bDVaqnbfV32S75U2y
         KSUM9/XMuXU1lnJ4roqdpUPhsAfNktRIzrzq3nV/48gCFrwMHhOPeOS/wLoLKLWonzM6
         hela7k+xQxet7kLreladzPlubOok+0qYSskALxxwt4wNTw9qfzHnwmAcMEHf3tiIIOON
         knJGw19tbC0Wree0LcJSphdZuSE7zp0EnlsW9X5LWvbFwXxakcWk2Wqhnz42tt/GeIP5
         pwdw==
X-Gm-Message-State: AAQBX9c38HLKSYzM9DrULQClA9Zs1nkkQo0q/rEQE8473yiJtvU25SiJ
        Hq3IIyLyCFQv9wHDs1QW31THllp7s0W7xuZ1Bt8=
X-Google-Smtp-Source: AKy350bvHQrDCRfMMD/MbptzFT7+yOCsFPu4MOplBhLqZY2raHjeWZnSvN9zGPlke75h1C6r9BpOGQ==
X-Received: by 2002:a17:906:4c54:b0:947:d9b1:89a1 with SMTP id d20-20020a1709064c5400b00947d9b189a1mr285395ejw.44.1680628948847;
        Tue, 04 Apr 2023 10:22:28 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:22:28 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Colin Ian King <colin.i.king@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 06/40] dt-bindings: nvmem: Fix spelling mistake "platforn" -> "platform"
Date:   Tue,  4 Apr 2023 18:21:14 +0100
Message-Id: <20230404172148.82422-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.i.king@gmail.com>

There is a spelling mistake in platforn-name. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
index 5a0e7671aa3f..714a6538cc7c 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
@@ -61,7 +61,7 @@ properties:
     type: object
     additionalProperties: false
 
-  platforn-name:
+  platform-name:
     type: object
     additionalProperties: false
 
-- 
2.25.1

