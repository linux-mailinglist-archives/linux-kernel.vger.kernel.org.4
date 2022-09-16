Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6175BAEA4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiIPNyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiIPNyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:54:12 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF45AAE9D9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:53:58 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n10so5558521wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=F/++3j5vzbiWV6wQtfbpT+br4B/s5dtmbh359iA+BUU=;
        b=V4KuezOGi/JTNn5/6GMcwwzbP1cwJ2jYRWRJqXnawM1eJBg+CmGdlw+x/wMldl/++/
         N55q6J+zmIVsAFrJBtOukfYyPJiCztuNyWmfSVyg3xOZdEINJUhviurCMeII9AD6hKgG
         l6Z6u8H6TZDX5tcZ0l5GKRI3F1ar0BoCQMfN2kslNgSV8Ym8h+0hcQWpSJ7ECL/H9myy
         jlLEjswffFwIK4QG5lFLZGkrrJRJlu5z7qqDkdgCzK6uns9MYg6j6xqgHj+/MJliqaLD
         KPSjgPUkO1l9tdt/zAKVoXiw/NCGHwlL75BH1hin0QqMHw9d2xXeKi8OMMs0usfbhyhO
         ds1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=F/++3j5vzbiWV6wQtfbpT+br4B/s5dtmbh359iA+BUU=;
        b=bJvyG9G9hpWKwKhW3oWbGYQUAnGHo80hv5T/SdI7LtI/e4pA0Z4rdKmALQeuohpLpb
         CvMqnOax1AcSER3TbIay1LW9sTRe6Asl9bAb//O8jsvIiP0puR7UtohIuYwfQqFMrvg9
         FwHI5cHHF1FJezZQltQH9l3Wp4OZiOYgYxDBR0jzgKs8xg/w2aUfrA03EglcvkaPvlpu
         vSMv0npBSvbt7v0v8czzTqTyENp2z4CkpERP8LQtLuxNnL65dAo+GZVLHY8NkpxiVsm4
         aShhfd6ZKkJCjB9jz6D8b1ZB8vYcv7Hg8Y7mNPgL1mBAWHVNOj5M9By/aGAlfm0uFXPI
         WoTA==
X-Gm-Message-State: ACrzQf0EHPpdb6C8jiPBSF8/ipdTm5WxmxMu1FpLTxTc9q46RY2xrEEh
        xjD+uJOxXXeu8FS4SbR+7Ld0xQ==
X-Google-Smtp-Source: AMsMyM66mtWTrSH2i+OwN4eD0KuYmUQ7/S2/uesxpJ8irrIeofU4OyeQ3mLggy7e1a3yQyB+/AAIHQ==
X-Received: by 2002:a05:6000:1ace:b0:22a:c9a6:e203 with SMTP id i14-20020a0560001ace00b0022ac9a6e203mr3048283wry.694.1663336435835;
        Fri, 16 Sep 2022 06:53:55 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id m2-20020a7bce02000000b003b483000583sm2084767wmc.48.2022.09.16.06.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 06:53:55 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 2/2] soundwire: qcom: do not send status of device 0 during alert
Date:   Fri, 16 Sep 2022 14:53:52 +0100
Message-Id: <20220916135352.19114-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220916135352.19114-1-srinivas.kandagatla@linaro.org>
References: <20220916135352.19114-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device0 can not be in alter status. And for consistency reasons do not
send status of device0 to core.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index d3ce580cdeaf..a04a8863b228 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -428,7 +428,7 @@ static int qcom_swrm_get_alert_slave_dev_num(struct qcom_swrm_ctrl *ctrl)
 
 	ctrl->reg_read(ctrl, SWRM_MCP_SLV_STATUS, &val);
 
-	for (dev_num = 0; dev_num <= SDW_MAX_DEVICES; dev_num++) {
+	for (dev_num = 1; dev_num <= SDW_MAX_DEVICES; dev_num++) {
 		status = (val >> (dev_num * SWRM_MCP_SLV_STATUS_SZ));
 
 		if ((status & SWRM_MCP_SLV_STATUS_MASK) == SDW_SLAVE_ALERT) {
-- 
2.21.0

