Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F36A73A445
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjFVPFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjFVPFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:05:02 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F521FC2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:04:55 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5704e551e8bso88215067b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687446294; x=1690038294;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6HP4+YvUJVAPeSikWLLN9lmrDsE6bkUx0eYDaGV1KtY=;
        b=KVoocYmnlhWTcw1lpk8n+2IXXtKbUtQpLc1W6m42G16fgk/46hQ24ls0r0EQJLHur8
         yi/2LxA0+duj7u/xyHLD2V+A9au+OpYQ5X5LOBaK7Eus9D3VJSr++d3qxu5VPTKcnYLd
         KsVUSfEZTrtYiWxSoHnHUbjM+rBdnkc/8HdJ7hYuGnau5poq/Xk/4LUpIXMeDp/4/5f4
         P3lmmusCUD0TDns0/jFuTafZF1gDDAsvnosK9q/2mMD4M0M11llif0owUxVojq9vx+kX
         5kmYk5e+yeRWtOKTvav3QYIHC3ZzjYLPL7f+yvmDTFP621TuKCGjiYHqAqskSEgoK9D7
         4KAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687446294; x=1690038294;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6HP4+YvUJVAPeSikWLLN9lmrDsE6bkUx0eYDaGV1KtY=;
        b=JrBj6UDwwM2Fe3QYyA7tNx+HZnd+OGj6VQcnnGLG9g5NaMW93QI9lyM+u9IpoWm+MT
         foDuIGATD0n4KMTPcUneXKo5ygP3GXjC1F7z4TorZNWaQa3b+BJMCnorjdVcC8nWWd3+
         msKspjbKoK9GKYbRTFq4lxgu8lGBRsDcog28ZV8tYZ6lS2AB/J1qn6XVl6+YBggIzDom
         nK0+lkeW6UFCtJ6HcCGO+NFr6RHbYiDoZfPWiOuxRJYX9Z8NEVLDTJqoUC+lg1VFKsqf
         zez+W8iEaELlleyjYIBVFm7MLX55aFzmlxbhxLviWRY3+Fuuy3eiXGT8kxrAfdVMXzWx
         801A==
X-Gm-Message-State: AC+VfDzjV497wacQ0KlxB0W9c2Mh/X53tlLsDNgB641FcLbMBRIZaGRH
        gfYpp1/p9kdAhb5qgqXTkNhpcpXjEGCt
X-Google-Smtp-Source: ACHHUZ496dL12nzIYLBFIu7BX5QCmCLSyZn7xI5fg8prNXpCnYIZvjhBPUphoZKuZ//HYYoKQleHSuToMCWm
X-Received: from kyletso-p620lin01.ntc.corp.google.com ([2401:fa00:fc:202:b1ba:4098:b043:5e54])
 (user=kyletso job=sendgmr) by 2002:a81:4318:0:b0:565:9bee:22e0 with SMTP id
 q24-20020a814318000000b005659bee22e0mr7091813ywa.0.1687446294377; Thu, 22 Jun
 2023 08:04:54 -0700 (PDT)
Date:   Thu, 22 Jun 2023 23:04:23 +0800
In-Reply-To: <20230622150423.3726894-1-kyletso@google.com>
Mime-Version: 1.0
References: <20230622150423.3726894-1-kyletso@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230622150423.3726894-4-kyletso@google.com>
Subject: [PATCH 3/3] usb: typec: Use sysfs_emit_at when concatenating the string
From:   Kyle Tso <kyletso@google.com>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buffer address used in sysfs_emit should be aligned to PAGE_SIZE.
Use sysfs_emit_at instead to offset the buffer.

Fixes: a7cff92f0635 ("usb: typec: USB Power Delivery helpers for ports and partners")
Signed-off-by: Kyle Tso <kyletso@google.com>
---
 drivers/usb/typec/class.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index e7312295f8c9..9c1dbf3c00e0 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1288,9 +1288,9 @@ static ssize_t select_usb_power_delivery_show(struct device *dev,
 
 	for (i = 0; pds[i]; i++) {
 		if (pds[i] == port->pd)
-			ret += sysfs_emit(buf + ret, "[%s] ", dev_name(&pds[i]->dev));
+			ret += sysfs_emit_at(buf, ret, "[%s] ", dev_name(&pds[i]->dev));
 		else
-			ret += sysfs_emit(buf + ret, "%s ", dev_name(&pds[i]->dev));
+			ret += sysfs_emit_at(buf, ret, "%s ", dev_name(&pds[i]->dev));
 	}
 
 	buf[ret - 1] = '\n';
-- 
2.41.0.162.gfafddb0af9-goog

