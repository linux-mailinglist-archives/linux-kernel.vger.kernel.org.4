Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1C2634E07
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 03:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbiKWCwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 21:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbiKWCwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 21:52:00 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6FBE2B60
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 18:51:59 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so679250pjc.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 18:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiw3VQM4iG9ywox0YWD0HMAieBlTQbVXVQ/U0gyBGQ8=;
        b=c9GCdkcTSNAeiBCFWMFQLvOs1sVJBRSmadaiAVokHXoBiX/LzltS5lrusu68bB2VEU
         wHdgqFif2juw+2FD+Th3xwCatI4fDE0jhnvpnAr4XIHylCPYnOahNxSRGs5STmg4Dajf
         k0x3stKh7HKokcIR6OYimRZiMeqFVlMLwHfvMmZ+sGpio07TMy31JYH6O7u+PfdEeG+a
         PgP7jWw5hbTqetfTPZlfok2Oqg4pW7ydku23J2cl5dzk9mBci/7QcA80paI9BTT5m6Z5
         yGNgt6tsDo2ubxYkZOgFqplCDCSmS3y1Lad9B6/fX3TL6MJJo1otcDlJmbfzm2ECD8Wc
         98Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oiw3VQM4iG9ywox0YWD0HMAieBlTQbVXVQ/U0gyBGQ8=;
        b=6OBREMRsmn1/Iz3vmRzGp/yx2Hski/Ixfc4AqTKsUtFV0gyCfavg0rffL9sG5wpcft
         aYBXfB1BwhzzCfgB5y5tsPCMF5ip2HoY5l3wx+zV4grFeK0EYiGjZOMJd9/AMw+yxlHl
         vwvlNtLy+wEFTJyh7ahYomopacpP77lladKVo4Txf/i/9KZ6MhtFAUSLd5Eo6dTdFIJt
         ec25RRfIxI8LTUgWecn45cGCBYHgEV3BnoUoSCcEHx7JJfbJ6cK3iWq8xdJHfE8TgV5w
         8gtmsXiBIdHwFysaY3BrreuJLRFQ9mYNhnFnCh0NwKcejDg4kYfewACUT/KsDMGDh3/i
         oevg==
X-Gm-Message-State: ANoB5pmrq9RO97ydtYk1yCSFy/JJ+igfnrCQ1MotjiXkNnC5FFvFAjOD
        KXtzCVJegpp1f1B1bl9ViBPQCi3xSnk=
X-Google-Smtp-Source: AA0mqf4D6kdx7JF6AMfo7Q/5n575iYLs6EC+A0/yVrdX686qpvH/GM1Gh22rvb+nvjj+rkymXkoMlQ==
X-Received: by 2002:a17:902:ced1:b0:179:ee31:1527 with SMTP id d17-20020a170902ced100b00179ee311527mr19886465plg.138.1669171919326;
        Tue, 22 Nov 2022 18:51:59 -0800 (PST)
Received: from localhost.localdomain ([123.51.145.88])
        by smtp.gmail.com with ESMTPSA id u8-20020a1709026e0800b001745662d568sm12565057plk.278.2022.11.22.18.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 18:51:58 -0800 (PST)
From:   JaimeLiao <jaimeliao.tw@gmail.com>
To:     linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org
Cc:     jaimeliao@mxic.com.tw, leoyu@mxic.com.tw, alvinzhou@mxic.com.tw,
        juliensu@mxic.com.tw, JaimeLiao <jaimeliao.tw@gmail.com>
Subject: [PATCH] memory: renesas-rpc-if: Fix missing setting address
Date:   Wed, 23 Nov 2022 10:51:41 +0800
Message-Id: <20221123025141.4012-1-jaimeliao.tw@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the RPC manual mode, if the data direction is not set
(such as the flash erase command), the address misses the
setting.

Signed-off-by: JaimeLiao <jaimeliao.tw@gmail.com>
---
 drivers/memory/renesas-rpc-if.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 4316988d791a..bdf0a7f68ff2 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -571,6 +571,7 @@ int rpcif_manual_xfer(struct rpcif *rpc)
 		}
 		break;
 	default:
+		regmap_write(rpc->regmap, RPCIF_SMADR, rpc->smadr);
 		regmap_write(rpc->regmap, RPCIF_SMENR, rpc->enable);
 		regmap_write(rpc->regmap, RPCIF_SMCR,
 			     rpc->smcr | RPCIF_SMCR_SPIE);
-- 
2.17.1

