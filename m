Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA5F670F95
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjARBJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjARBIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:08:10 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96481193F9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:02:53 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 7-20020a17090a098700b002298931e366so642417pjo.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7/mtfAEiznKTs6LljSjzgO8ce+jXldLwxAog2qB3K6U=;
        b=TLkv8I36T8svQHzBurky16JF9NaohSi44H3po39FOfSOhftznrWgK2/wMmZ5V3Zp+w
         Is3AexGXfjwZoha/7x6LUbsLbqOcSIEInugOIu28rvnoOAAy6BXDh23d8MQgAgiNMe3s
         oxVyjVTMkZfyv/1qQD1peJ8Xn02/7pgzvSxuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7/mtfAEiznKTs6LljSjzgO8ce+jXldLwxAog2qB3K6U=;
        b=63zva3lH0knlpI3wGGyuP3fo009xgBi1YZl3h12xSx+6mI80fWpAiTHIxUXokU9gN/
         Wqo2Eti0qsfVt7aSxqANmbH6GF+LIzbq6ScyI0/V0U4PjfroMplo6lKu/CO48yF25YtH
         6nZi+KOWzPnFIiIYAZzJimy6m68083Xcl9WqnqpToMe6sSBh/e6YEAE1ojDxqU1atJte
         yMAJArYNmWVk1aeyV9XvpdR91RYV7o+u7mJh1FcXtLu1y+FjHWlraIvIi01ApF5/1GEM
         VP4LPrjp+E92HvHOQNhJI2hoOGAdX1rN2CezlPsPye1SQRsvYMjJi0jbLTqriM0B0IqI
         BKNg==
X-Gm-Message-State: AFqh2kpjJr4nydYmCFxUaQ/+XwQ78hSlbfOlUttzWTM7QmVkO2mn0WFy
        X944VJsfPHHf4BAVPmtbifEUWw/OwFSzkYGO
X-Google-Smtp-Source: AMrXdXt1EMyWu87VHXWBfxnQnROvKSYrYA7iFgYoKAjHN9BvJwpqVhhVYuD2asdrVj16faBYKdRU2Q==
X-Received: by 2002:a17:902:a614:b0:192:8ca0:b86e with SMTP id u20-20020a170902a61400b001928ca0b86emr4457621plq.35.1674003773175;
        Tue, 17 Jan 2023 17:02:53 -0800 (PST)
Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2d4:203:ab54:d6ee:36f5:912d])
        by smtp.gmail.com with ESMTPSA id x24-20020a1709027c1800b00192588bcce7sm126133pll.125.2023.01.17.17.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 17:02:52 -0800 (PST)
From:   Khazhismel Kumykov <khazhy@chromium.org>
X-Google-Original-From: Khazhismel Kumykov <khazhy@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Khazhismel Kumykov <khazhy@google.com>
Subject: [PATCH] gsmi: fix null-deref in gsmi_get_variable
Date:   Tue, 17 Jan 2023 17:02:12 -0800
Message-Id: <20230118010212.1268474-1-khazhy@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can get EFI variables without fetching the attribute, so we must
allow for that in gsmi.

commit 859748255b43 ("efi: pstore: Omit efivars caching EFI varstore
access layer") added a new get_variable call with attr=NULL, which
triggers panic in gsmi.

Fixes: 74c5b31c6618 ("driver: Google EFI SMI")
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 drivers/firmware/google/gsmi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index 4e2575dfeb90..871bedf533a8 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -361,9 +361,10 @@ static efi_status_t gsmi_get_variable(efi_char16_t *name,
 		memcpy(data, gsmi_dev.data_buf->start, *data_size);
 
 		/* All variables are have the following attributes */
-		*attr = EFI_VARIABLE_NON_VOLATILE |
-			EFI_VARIABLE_BOOTSERVICE_ACCESS |
-			EFI_VARIABLE_RUNTIME_ACCESS;
+		if (attr)
+			*attr = EFI_VARIABLE_NON_VOLATILE |
+				EFI_VARIABLE_BOOTSERVICE_ACCESS |
+				EFI_VARIABLE_RUNTIME_ACCESS;
 	}
 
 	spin_unlock_irqrestore(&gsmi_dev.lock, flags);
-- 
2.39.0.314.g84b9a713c41-goog

