Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8517B65E878
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 10:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjAEJ6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 04:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjAEJ6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:58:33 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0105689E;
        Thu,  5 Jan 2023 01:58:31 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r2so753269wrv.7;
        Thu, 05 Jan 2023 01:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ldFg3aZw07BJ9cU7ZJDK8xVVuOKTTlOr8J5in8ahzW8=;
        b=QQZ44LwQ8wGfemMyYwwMHDkuzk6deiBa+FkJXibRyPY8B1jfi5SPgKbPuf/tZ1OH0G
         Zb5J9wZVqm3Gufy/2kYm173CvA+vsNlzLyAVPuQUUpjWm6LYB08M+Z2z822lLz/KFIlt
         NFD/fR+1BpBYcETJ6+nZyRaoN4uvDpthNaZs4KDChWloDCCKZcQvBXKHkod+D4xp+TVU
         1DMzS0dRl42jKy6O3Y5VwVCHbw6ssYYRhwxe/5ZBHfRqSLK7i+gzHwjlNv9xTvc7f5L+
         +vlUBGgaEcGzhjIKZEGPVe0MgcN/eO3DO341N8xWQxwVwE5zL/gnXR+f3CcIy2OB3+li
         BPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ldFg3aZw07BJ9cU7ZJDK8xVVuOKTTlOr8J5in8ahzW8=;
        b=LPBe1G1dvfchRsht/2yiPGVvtKrQKgK7+YlBY5oY0kdKCQclcrQ35Vgg8IuIkJ5/tz
         X/iw8YjryxZxU3ZGZlFHRWJNIvNoBhNiJz4Va2+nR25a/lGLYGs+K2f2rgr0FsXN2Li3
         5i2rNHWwo88V7DQgIZrbMxgsZiq9KDIpxdV4eFhxh0XSWQmh3Rr6YqAuFyI6vmnjwRV8
         OPlCCsRly/3g5jrY4nxQUdC+a7uYPbbnqdk3o2fQ+pepW2PevTBMnpZfhD4JxlGNcE6W
         CgRpL/X2+lGhp0dIMDPBXq3y3ZLyZwr24RX8UsDW4rlzBhP1PsAV0IzoYuZYmNzal44V
         J4aA==
X-Gm-Message-State: AFqh2krNBwOlBDZiN8AfHZxA2k3BV0VwHsLIV5I6Gmd5f2QUfxL5FKnW
        LyP6WS8qzUWO3BB64h3ndNU=
X-Google-Smtp-Source: AMrXdXsACOTeoOaKfAPi4wKydIQXBPrKWoHqRfg1yWr07UKBdPbkQ75uFPnLyu52Cj1Wwk02xr2XNg==
X-Received: by 2002:a5d:55c7:0:b0:242:19ba:c325 with SMTP id i7-20020a5d55c7000000b0024219bac325mr29691829wrw.30.1672912710036;
        Thu, 05 Jan 2023 01:58:30 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id q3-20020a5d6583000000b002b57bae7174sm498446wru.5.2023.01.05.01.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 01:58:29 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2][next] nvmem: layouts: Fix spelling mistake "platforn" -> "platform"
Date:   Thu,  5 Jan 2023 09:58:27 +0000
Message-Id: <20230105095828.2951-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in the literal string. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/nvmem/layouts/onie-tlv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/layouts/onie-tlv.c b/drivers/nvmem/layouts/onie-tlv.c
index 074c7c700845..767f39fff717 100644
--- a/drivers/nvmem/layouts/onie-tlv.c
+++ b/drivers/nvmem/layouts/onie-tlv.c
@@ -48,7 +48,7 @@ static const char *onie_tlv_cell_name(u8 type)
 	case 0x27:
 		return "label-revision";
 	case 0x28:
-		return "platforn-name";
+		return "platform-name";
 	case 0x29:
 		return "onie-version";
 	case 0x2A:
-- 
2.30.2

