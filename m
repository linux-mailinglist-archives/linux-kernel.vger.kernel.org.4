Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A15169099A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjBINNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjBINNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:13:50 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8E342DF0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 05:13:49 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id bg5-20020a05600c3c8500b003e00c739ce4so1472531wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 05:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZXq8dEw8EGIO/pGDRaHOOzvG+p+V2k3SWMSCz374AM=;
        b=DX+gWntv9kzkTbjK0gkqW7XZcfeX5kAYrPiXrCQo21K0scAgIXpVJAP1rndjdvAOMg
         3whWi/KWru5IkCXPKpJ4ShsNfXompA7GSrV/b0dE6EOGjxmSCoIe+bMxEf7GZWxEZ4aq
         DHfe35AEE8QEF/FxgngYLPkbVxAvxK0ayyKDFV1om9I7xdIG5+7m0ycVnGhdSr9tHRKn
         schucCCwbIDdqWoYmE1GXdDa1dGPxa4Ky4b+1bLpWDBwr0xasXjMwEPrYlpqbfT0YMa6
         lXjNl36Og+9c2kjZnZxqNpB9B47TUlgJBy424l8ja96M7rV0ikg36ZcxUnAJtrEuggmM
         KMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZXq8dEw8EGIO/pGDRaHOOzvG+p+V2k3SWMSCz374AM=;
        b=EZZmMGxsjQCaOOLD1mHw8PX3or87fc9cM/PUnK+Gu3QqiZ47gtMwCAtc57XDq9a18T
         caQsREZE9ffuuFzhMmVYPM4JBm70v7qA7qWw7hw5yJBdbqtIq/aiNPGOK3khNsJR5XlP
         mIkK2LdxmIaz7EFVBnkJZXmKPd5iUL2scrZGn7lUkOatKgcllEBFz0b/iIr90Q8M5K01
         PYVsNTIPvup3dcOoj0yPGS+nb5LUKS1J0NLnOaMrUI69ilFEeyzE+kEED6mhmckP7csp
         iPeYz/mWnCGxd+BF52otxJuvaZHkpJVktkX/mZJ84Cv1eXp4BGTSRWmRJZPM0soCu+QY
         l7YQ==
X-Gm-Message-State: AO0yUKXT51OL7AaALm9XE/IGNm6Aveq/yILtiDbQ6+ZuVB2S4K+1NBSx
        jFyy/JTOrMVycKSX9fY36BUjMgc1ZexZ5/jc
X-Google-Smtp-Source: AK7set9UDllZp++Y9sSAO87/EiOBjOXXsU2IfXA+F46MbiAOkm7RnkGwp/TzTkkcsgE8um4uO9+/8w==
X-Received: by 2002:a05:600c:331b:b0:3dc:4356:533c with SMTP id q27-20020a05600c331b00b003dc4356533cmr9840352wmp.5.1675948428277;
        Thu, 09 Feb 2023 05:13:48 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ja13-20020a05600c556d00b003dc4b4dea31sm1789394wmb.27.2023.02.09.05.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 05:13:47 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        johan+linaro@kernel.org, quic_bjorande@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/5] soundwire: qcom: update status correctly with mask
Date:   Thu,  9 Feb 2023 13:13:32 +0000
Message-Id: <20230209131336.18252-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230209131336.18252-1-srinivas.kandagatla@linaro.org>
References: <20230209131336.18252-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 335424870290..9d8ae77bad0a 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -434,7 +434,7 @@ static int qcom_swrm_get_alert_slave_dev_num(struct qcom_swrm_ctrl *ctrl)
 		status = (val >> (dev_num * SWRM_MCP_SLV_STATUS_SZ));
 
 		if ((status & SWRM_MCP_SLV_STATUS_MASK) == SDW_SLAVE_ALERT) {
-			ctrl->status[dev_num] = status;
+			ctrl->status[dev_num] = status & SWRM_MCP_SLV_STATUS_MASK;
 			return dev_num;
 		}
 	}
-- 
2.21.0

