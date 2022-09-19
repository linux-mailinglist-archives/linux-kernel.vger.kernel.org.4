Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418815BC167
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 04:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiISCdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 22:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiISCc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 22:32:59 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FBE140BA;
        Sun, 18 Sep 2022 19:32:59 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 102-20020a9d0bef000000b0065a08449ab3so1298198oth.2;
        Sun, 18 Sep 2022 19:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=OdBoUNqr+djzRo7sEuTlKaZ7X9EytKms13f4/L4fwss=;
        b=cCLUAsyLq4cR8fDNb7mRnLb8oipuwc2mijaZmy8153/TTA3+vchdeM5j5nbcRZPUD8
         CbLRWXjnpz57J/EwnFfy3LvS2607kSlEAMgv377cZQzcYBcSh3vYfz3XRgiJf24j8jnI
         tEJ73nNYLcFX6PzFpovUaXBUqilVdmk38Rfwl+wqnran2QRjUS81tA6eBu88iqWTvhcZ
         Pms34PS+GhuiznhAeb22qv+orzVCgSZNCgGuuEc9fspKM1n3t7hdPwY/6ZSGsNvUG7MH
         d+VwDG/Y+hJcHPpEOPj2z6wkzjfrghik6a9zKRYjXhqtMc5gMV2p8Zo0zRwZKRL5gUBR
         ZN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=OdBoUNqr+djzRo7sEuTlKaZ7X9EytKms13f4/L4fwss=;
        b=y/oN0R0+nupq1EMQytoXPJFTY8LwyjiYrl9zC3KrJMGrwpiBlMIyf+sHBpy2lqbvkz
         Hbcx4+irfPEChcHyV+MAduH4YQCTqK3WYKqxIbLu5Z96FCIYmsiNGbt4TghdWJ4KGGZg
         TGWjoN1ZyMYn+hrOIlpRjArWEtrTOWumez6CMS4139Pf6kjtj6HEOqiVGMi2IQekATjI
         dCOYZ4cueYnx5rbxGk8aF4P6D1eqSmoi8DrhJ9w9UstUbNuHk1UILBKnZQNO2SSEhACk
         TgEX6GcHfhpSEPd82YCgUpe5fCvWQ8EYPtF2/t49uHi0BVur+Xwmq7Dm463wb7cPrdn0
         ooGA==
X-Gm-Message-State: ACrzQf0gc6+W34Fe4fQMUpTosHXwKB30gUvC+szURLXob3w8IFOvxIWT
        nR9ziPxDpj8zSPPzFcgnUuDf8JomjBKQGA==
X-Google-Smtp-Source: AMsMyM6zY3yA1MDWO6rxorFDTCwCTmGXyhNQR4pILw08VIwBomh2IzA/vGrAEQT+E2TDBOkIA3Oxng==
X-Received: by 2002:a05:6830:610d:b0:655:dccd:5c2f with SMTP id ca13-20020a056830610d00b00655dccd5c2fmr6780281otb.265.1663554778282;
        Sun, 18 Sep 2022 19:32:58 -0700 (PDT)
Received: from macondo.. ([2804:431:e7cd:8cb3:e183:945:dc30:a2a8])
        by smtp.gmail.com with ESMTPSA id l66-20020acabb45000000b00344afa2b08bsm4459572oif.26.2022.09.18.19.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 19:32:57 -0700 (PDT)
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: i2c: ov5648: Free V4L2 fwnode data on unbind
Date:   Sun, 18 Sep 2022 23:32:46 -0300
Message-Id: <20220919023247.731106-1-rafaelmendsr@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The V4L2 fwnode data structure doesn't get freed on unbind, which leads to
a memleak.

Fixes: e43ccb0a045f ("media: i2c: Add support for the OV5648 image sensor")
Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
---
 drivers/media/i2c/ov5648.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/i2c/ov5648.c b/drivers/media/i2c/ov5648.c
index dfcd33e9ee13..95850f06112b 100644
--- a/drivers/media/i2c/ov5648.c
+++ b/drivers/media/i2c/ov5648.c
@@ -2598,6 +2598,8 @@ static int ov5648_remove(struct i2c_client *client)
 	mutex_destroy(&sensor->mutex);
 	media_entity_cleanup(&subdev->entity);
 
+	v4l2_fwnode_endpoint_free(&sensor->endpoint);
+
 	return 0;
 }
 
-- 
2.34.1

