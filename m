Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522DB7269DF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 21:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjFGTdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 15:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjFGTdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:33:44 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B981FFC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 12:33:39 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b1806264e9so41421965ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 12:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686166419; x=1688758419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJRf/E/pDX9mASkaBIZudG9noZ/G953gn9Y8AxnVnnU=;
        b=XoEFFTCHaGMKYPmH3BCRE3AliyixuhyfIRkMh4EEkqMJYMjVj5uO9kWRGMSqNVpPsR
         jHo8eebc0bYZGkzKv8HjV1uC1aNwUEYYuJlNB0/jQdEkWLx3Uu3METT6UOmrI2ulcesq
         x3gRDj0ui96/HefepOusXsSUZZedB1i/QxdN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686166419; x=1688758419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJRf/E/pDX9mASkaBIZudG9noZ/G953gn9Y8AxnVnnU=;
        b=ZuKuaHp5HNwuaUDZH++UX884Yr9aeZ/DC86Ud2unEFwEnmo3NlR0mEjuqeXvmqY5bw
         8PmjHMbA83+w+o3sbVyFmHi4M9OMEHIJ1cwcOao/4Uldlv+G1gGV5Lrib3gYHpy7Zh8p
         p6HaciKnkTgn2CuiuL6324D3clcSRxKhZH/6mx85ruD/14quCpAAqBfcwQ0vSCr/Q9/M
         JZBl7MTuUcMvuQzmEnVv5qkoS7UzAb3qnEJQRHjLMmuwxvcdWOh2Qs3sMsGJPaov/WZq
         EYAXn3D218TE/YilcWqq5tZe9ybUJpFCSZfUh5x8zrD9tv/tfrSgVpMaiTvv6uzl1Hfr
         Dbaw==
X-Gm-Message-State: AC+VfDxyXvlSR7COlyVtqX/yZgKJIOHqETbTbXHekPKfClxX33Ct++Jj
        kuwNhe2uLzKkO1MrhJ8lYRcF9g==
X-Google-Smtp-Source: ACHHUZ6snpK2J7S2OoJG69I0rKP8yod7RV1OY8FxAc7b9rhUKsoFXPtWp91+eZnph8l4Iezj0KBYFg==
X-Received: by 2002:a17:902:bcc6:b0:1a1:a800:96a7 with SMTP id o6-20020a170902bcc600b001a1a80096a7mr2919103pls.8.1686166419191;
        Wed, 07 Jun 2023 12:33:39 -0700 (PDT)
Received: from localhost (139.11.82.34.bc.googleusercontent.com. [34.82.11.139])
        by smtp.gmail.com with UTF8SMTPSA id p5-20020a170902eac500b001b03a1a3151sm10859823pld.70.2023.06.07.12.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 12:33:38 -0700 (PDT)
From:   Pavan Holla <pholla@chromium.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     bleung@chromium.org, pmalani@chromium.org,
        Pavan Holla <pholla@chromium.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: typec: Fix fast_role_swap_current show function
Date:   Wed,  7 Jun 2023 19:33:26 +0000
Message-ID: <20230607193328.3359487-1-pholla@chromium.org>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
In-Reply-To: <2023060611-coach-entitle-d4e4@gregkh>
References: <2023060611-coach-entitle-d4e4@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation mistakenly performs a & operation on
the output of sysfs_emit. This patch performs the & operation before
calling sysfs_emit.

Fixes: 662a60102c12 ("usb: typec: Separate USB Power Delivery from USB Type-C")
Reported-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Pavan Holla <pholla@chromium.org>
---
 drivers/usb/typec/pd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/pd.c b/drivers/usb/typec/pd.c
index 0bcde1ff4d39..8cc66e4467c4 100644
--- a/drivers/usb/typec/pd.c
+++ b/drivers/usb/typec/pd.c
@@ -95,7 +95,7 @@ peak_current_show(struct device *dev, struct device_attribute *attr, char *buf)
 static ssize_t
 fast_role_swap_current_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "%u\n", to_pdo(dev)->pdo >> PDO_FIXED_FRS_CURR_SHIFT) & 3;
+	return sysfs_emit(buf, "%u\n", (to_pdo(dev)->pdo >> PDO_FIXED_FRS_CURR_SHIFT) & 3);
 }
 static DEVICE_ATTR_RO(fast_role_swap_current);
 
-- 
2.41.0.rc0.172.g3f132b7071-goog

