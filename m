Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6179E73A442
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 17:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjFVPFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 11:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbjFVPE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 11:04:57 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F25A1FE3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:04:51 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57003dac4a8so14974367b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 08:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687446290; x=1690038290;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vZO0bLWsCUzvZiCFoSnFZwrtuz12yaBesFgNlWXPmT0=;
        b=O4AQJntmNrrzpA/osOkPU0d1y9/b3wfMewtlOXTOG5Pkz+psJggS/9wWf7apbcG6as
         cAnVTf9k+WP71BQEkHdZKkIv5GfJSWEm0zMljR8RE1LB5GBR4fbULYo6KFxYNwdDyWgy
         s5i3fr9/Km/GH6EjoblamoRcI6pmodeaHt6tKJweOD1zPHK/tceQ15xB5ThAPsg43Ekl
         KicSBo4d4GlRP7uFMqDKUsI5n3Ll1dgpa8WgqvyxbJxTIGdBW87/8XR3l2pLgSsv7T8/
         D4Vsy9L8rsjqxAj9BuIASWaBIkOJWN/9I0o2Qadw0R4/wOwO6mtYgRhUz/srI1lEL9RO
         cgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687446290; x=1690038290;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZO0bLWsCUzvZiCFoSnFZwrtuz12yaBesFgNlWXPmT0=;
        b=A11M6dFBneoiZ0qsYtQl59bfA5CoV/o4OEBzcldGJ07XYlSvAF9TbIyNuNb76NLqez
         khSPb1tQr1SYWvLPgEV8AqldXYxVSkbqY0d4fyVAuGkkCSNgjsRWX1P5XO27ykvEj2fB
         4+0FtYn10LsrnoN2XUecXiMcUFUU/TOFQGvrxAea6rVZEh+3rC9zI/mWk49cAN6fwrKS
         UA99b9OmTNv6B7EzKOLibjEDy0ftahndoWIiQCdNte0vADpmfON646yjLhzyT/kTTuiR
         o2ctWgbg1Nu6fTNmbpveq3hCoAkAA8YIClIqd83zcxzuOGK3GpESndlckWHhp8ka2gIZ
         aIXQ==
X-Gm-Message-State: AC+VfDyWRQvw1T81FBKPyc80NHiXfGcbPmcud1yzDRg9dcvCtkziPpY9
        lCG/ET2Yvm6RuUwu3ge7y6tHnlx/UpeO
X-Google-Smtp-Source: ACHHUZ7eMdBNde25i7j4MRD+O/BRZV9gU7ydeOols5A25Lz1pht25onjLAZ9R30ou8GxtYCBOlpV+PS8UyTb
X-Received: from kyletso-p620lin01.ntc.corp.google.com ([2401:fa00:fc:202:b1ba:4098:b043:5e54])
 (user=kyletso job=sendgmr) by 2002:a05:690c:b92:b0:565:8b2e:b324 with SMTP id
 ck18-20020a05690c0b9200b005658b2eb324mr12338278ywb.3.1687446290808; Thu, 22
 Jun 2023 08:04:50 -0700 (PDT)
Date:   Thu, 22 Jun 2023 23:04:22 +0800
In-Reply-To: <20230622150423.3726894-1-kyletso@google.com>
Mime-Version: 1.0
References: <20230622150423.3726894-1-kyletso@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230622150423.3726894-3-kyletso@google.com>
Subject: [PATCH 2/3] usb: typec: Iterate pds array when showing the pd list
From:   Kyle Tso <kyletso@google.com>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointers of each usb_power_delivery handles are stored in "pds"
array returned from the pd_get ops but not in the adjacent memory
calculated from "pd". Get the handles from "pds" array directly instead
of deriving them from "pd".

Fixes: a7cff92f0635 ("usb: typec: USB Power Delivery helpers for ports and partners")
Signed-off-by: Kyle Tso <kyletso@google.com>
---
 drivers/usb/typec/class.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 3b30948bf4b0..e7312295f8c9 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1277,8 +1277,7 @@ static ssize_t select_usb_power_delivery_show(struct device *dev,
 {
 	struct typec_port *port = to_typec_port(dev);
 	struct usb_power_delivery **pds;
-	struct usb_power_delivery *pd;
-	int ret = 0;
+	int i, ret = 0;
 
 	if (!port->ops || !port->ops->pd_get)
 		return -EOPNOTSUPP;
@@ -1287,11 +1286,11 @@ static ssize_t select_usb_power_delivery_show(struct device *dev,
 	if (!pds)
 		return 0;
 
-	for (pd = pds[0]; pd; pd++) {
-		if (pd == port->pd)
-			ret += sysfs_emit(buf + ret, "[%s] ", dev_name(&pd->dev));
+	for (i = 0; pds[i]; i++) {
+		if (pds[i] == port->pd)
+			ret += sysfs_emit(buf + ret, "[%s] ", dev_name(&pds[i]->dev));
 		else
-			ret += sysfs_emit(buf + ret, "%s ", dev_name(&pd->dev));
+			ret += sysfs_emit(buf + ret, "%s ", dev_name(&pds[i]->dev));
 	}
 
 	buf[ret - 1] = '\n';
-- 
2.41.0.162.gfafddb0af9-goog

