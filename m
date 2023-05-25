Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1628F710D5F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 15:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241217AbjEYNjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 09:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241137AbjEYNix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 09:38:53 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA491A7
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 06:38:49 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-30789a4c537so1469096f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 06:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685021927; x=1687613927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GVjrhO4+wX67tAd5gKWT8UX+KnLSIyA9RaY+rGVUm8=;
        b=X1Hw6XzqT2tCaEFAbBeyu2o+ljfzQPvtuTFskLmVPUAkg/4BkcJV8Zd6VaLsby29Gg
         vMDO16B7GXss94RdI/jUOvLfpkyHTCixhDSG+fvY5UT3CvijIF8j9RqwWAWaHgSzN+Tv
         HON9LXdlJsqIxG7l5Hmuq4m//jDrI++PiFLuHvdsbL5hjsRJ2UceFXWZ+077bluACqAq
         jh/fE4iwx5s5zAeh4bdbuGw15gcnYAeDlvHA4IgUpOz5IgW6EZZF0snzJR0d4MLxIMhx
         Fb7X4++8GSf7phrVGaBFNWP/7tAp8UzF4F5GHbdaGSHjCNGMpatzDStjoDJiVO22qBQ7
         cKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685021927; x=1687613927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GVjrhO4+wX67tAd5gKWT8UX+KnLSIyA9RaY+rGVUm8=;
        b=IZU1lpZ/alscbe5wuL/9kkkR9LGvq35Se7zRZHEk4z18yBnL78d5wD9twy0moPNSim
         0u4UvcvQnWfLA46sN7tl4V39iUo9vpbuKooygpgHo8SYpToS/ae7nZI1Lx49F7PMbNpq
         Fahnb1STvRVoqlR0jUfHdpL9xSOGUkdAZrKyw/Goapz2FR6789BpYPWZODt3+qDs0Ldc
         M0cHmfwobcHsvdfVfKbaOiqz8Sr1irLyNlgfYQRcsyJmFb5HrcUnecnL/6HFAnPcF0o5
         S5T0Q6USjVbeElUisYMmJxzS5XUucrPYyqlg4ttb1+yqgb9I8CGfWqmakXdrYkNHcmIK
         KPaQ==
X-Gm-Message-State: AC+VfDz7lMH3r1tZOMpCKceG8sa0u8T8/ea79Mv/q/3XsZxTtpKbAFYP
        lPdlHSQPwdYzVLMsp0E4tlT89w==
X-Google-Smtp-Source: ACHHUZ6Lu2fKZX/yZXuoFi3bejKut7TLYsvIETK97sRG+Lg3mxkQOniLqXLg/UUGGJm7TtAtx6mDdw==
X-Received: by 2002:a5d:4526:0:b0:306:36ef:2e3b with SMTP id j6-20020a5d4526000000b0030636ef2e3bmr2078354wra.70.1685021927652;
        Thu, 25 May 2023 06:38:47 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d6551000000b00301a351a8d6sm1803641wrv.84.2023.05.25.06.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 06:38:47 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     andersson@kernel.org, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/4] soundwire: qcom: update status correctly with mask
Date:   Thu, 25 May 2023 14:38:09 +0100
Message-Id: <20230525133812.30841-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230525133812.30841-1-srinivas.kandagatla@linaro.org>
References: <20230525133812.30841-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SoundWire device status can be incorrectly updated without
proper mask, fix this by adding a mask before updating the status.

Fixes: c7d49c76d1d5 ("soundwire: qcom: add support to new interrupts")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index aad5942e5980..9440787e924b 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -515,7 +515,7 @@ static int qcom_swrm_get_alert_slave_dev_num(struct qcom_swrm_ctrl *ctrl)
 		status = (val >> (dev_num * SWRM_MCP_SLV_STATUS_SZ));
 
 		if ((status & SWRM_MCP_SLV_STATUS_MASK) == SDW_SLAVE_ALERT) {
-			ctrl->status[dev_num] = status;
+			ctrl->status[dev_num] = status & SWRM_MCP_SLV_STATUS_MASK;
 			return dev_num;
 		}
 	}
-- 
2.21.0

