Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216856686D2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240163AbjALWXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240526AbjALWWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:22:41 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3E51C42A
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:16:33 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id a30so14840669pfr.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkTLc1JhoYqMaaSpYl6NjHEmEMaKe24mQDtcgzRm6SA=;
        b=NwLL3cGlWAqecjjWMIePO/VbFJDy2XUOI5/qdVpiCUq0EckUGu/5j6Vp9tvJRzjoYQ
         GQdfLylJSd4qj5BMlvzNNJ/mHcln91tySW6DlhghM4B6qEFYGV06w88nAgHdpOrjqPkg
         gpd8k0s0/DytaeePtdTqyGeWCK8Iw990vOn9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HkTLc1JhoYqMaaSpYl6NjHEmEMaKe24mQDtcgzRm6SA=;
        b=UPc56rT8rtLMluLuyOk4ZN0s7QBigig5iYxygmeMYXwcjb78LhQeZYD82jJHyxbhwg
         bOcZHPIDPQdYTDCsP7+x9tf27qiwPuqE6+twjAMD3luNeJzRPYO0BVCgVoHotnbZnARh
         lO0rZZzCCWlp+6XQb90qIK4otuGmslP8aKow40WfMDjdJzHqPsLYL8UEqAoU1FlPvMju
         SmDUGXeaBPsJ1nkD1C655w+RzjJkKvD3KxXBKGs5bQAh8dJtXeT8rYLfN4ngneGPRe7D
         k/v9VYxeQBGLsB0p2VNeRppSdRlGmMVS+04v4LSTFfjrwC5rnzRXwAwnApngSIPAWs0A
         dH5Q==
X-Gm-Message-State: AFqh2krK45dA9RXwJhpQNNTgAByWCcTU9I37zExHJce11Q4FiMXL3F5r
        2I5VY8jWT+JHkByMLw7An2HUDTmawKxRWKGV
X-Google-Smtp-Source: AMrXdXu7TKCZLDuVqub1CbHP5FcMT2Ikb234wbbgK+KrHmlZ69SXJ33Vm/CgeCPW7pI4tTF273r0bQ==
X-Received: by 2002:a05:6a00:3311:b0:582:6732:ee03 with SMTP id cq17-20020a056a00331100b005826732ee03mr8142964pfb.9.1673561793131;
        Thu, 12 Jan 2023 14:16:33 -0800 (PST)
Received: from pmalani.c.googlers.com.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d191-20020a621dc8000000b0058193135f6bsm12330658pfd.84.2023.01.12.14.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 14:16:32 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     bleung@chromium.org, heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/3] usb: typec: Make bus switch code retimer-aware
Date:   Thu, 12 Jan 2023 22:16:08 +0000
Message-Id: <20230112221609.540754-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230112221609.540754-1-pmalani@chromium.org>
References: <20230112221609.540754-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since ports can have retimers associated with them, update the Type-C
alternate mode bus code to also set retimer state when the switch state
is updated.

While we are here, make the typec_retimer_dev_type declaration in the
retimer.h file as extern, so that the header file can be successfully
included in the bus code without redeclaration compilation errors.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/usb/typec/bus.c     | 22 ++++++++++++++++++++++
 drivers/usb/typec/retimer.h |  2 +-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/bus.c b/drivers/usb/typec/bus.c
index 9f1bbd26ca47..0c8d554240be 100644
--- a/drivers/usb/typec/bus.c
+++ b/drivers/usb/typec/bus.c
@@ -11,6 +11,22 @@
 #include "bus.h"
 #include "class.h"
 #include "mux.h"
+#include "retimer.h"
+
+static inline int
+typec_altmode_set_retimer(struct altmode *alt, unsigned long conf, void *data)
+{
+	struct typec_retimer_state state;
+
+	if (!alt->retimer)
+		return 0;
+
+	state.alt = &alt->adev;
+	state.mode = conf;
+	state.data = data;
+
+	return typec_retimer_set(alt->retimer, &state);
+}
 
 static inline int
 typec_altmode_set_mux(struct altmode *alt, unsigned long conf, void *data)
@@ -31,6 +47,12 @@ typec_altmode_set_mux(struct altmode *alt, unsigned long conf, void *data)
 static inline int
 typec_altmode_set_switches(struct altmode *alt, unsigned long conf, void *data)
 {
+	int ret;
+
+	ret = typec_altmode_set_retimer(alt, conf, data);
+	if (ret)
+		return ret;
+
 	return typec_altmode_set_mux(alt, conf, data);
 }
 
diff --git a/drivers/usb/typec/retimer.h b/drivers/usb/typec/retimer.h
index e34bd23323be..d6a5ef9881e1 100644
--- a/drivers/usb/typec/retimer.h
+++ b/drivers/usb/typec/retimer.h
@@ -12,7 +12,7 @@ struct typec_retimer {
 
 #define to_typec_retimer(_dev_) container_of(_dev_, struct typec_retimer, dev)
 
-const struct device_type typec_retimer_dev_type;
+extern const struct device_type typec_retimer_dev_type;
 
 #define is_typec_retimer(dev) ((dev)->type == &typec_retimer_dev_type)
 
-- 
2.39.0.314.g84b9a713c41-goog

