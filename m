Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E528711084
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbjEYQJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjEYQJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:09:32 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211D910D1;
        Thu, 25 May 2023 09:09:01 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bcb00a4c2so4135568a12.1;
        Thu, 25 May 2023 09:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685030939; x=1687622939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IcWAv44UOzgNnQAtx1ryJsdICiVGnUV50w5gHYxHJdU=;
        b=fbFXoVxPVQEDK7R8QBWEC1K7HGxa802C//fMX4YnZw56/6do6hgNWVtWFd0pT0D7cB
         MgnUBF1qWGggCG/RHGZeovTjKBygDmm6a4B9CbLVgjnLNDkM1Xsmm+nW4pEZtz6ceD6f
         hGEea4ie7UGIAJX/jej/kVh75RNnaQv5bfUEnDeCv3aYyUxX58fHipmAVlrjyfvNMLdn
         I2qywoGy2W5Ly3KvxSmu1cXeNl9q+u/iOkzlgSlJVcMU36SjpovBaAgZA16nefeCqbHh
         oNj4YPjA39Qk8cKiF7hHabev8Nq35vPVnXxtlzYewwerqQZcFZXxXKasdFB8zO7LmSb5
         Y9uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685030939; x=1687622939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IcWAv44UOzgNnQAtx1ryJsdICiVGnUV50w5gHYxHJdU=;
        b=J5WZ4xsrUtiGlNT9d3iybEU0LFpNY6oFirVH+IqKfUn1oP94TvIoozgd8aJXFu82ti
         NuZMUJ+Diyb2BReEr9YFYztreyr7cHqpjDDPvlvYE3JG/leTwEhRKzWgpQ/vA0VNUN9J
         m+RmjrtXYxsJfvpyPzDtiqOODt4GWirIHQ8etGiUHxqgZBnvzJGiYqoZA/Yq3Qm+RwXw
         rL8mnnzesETdUi+V5YTMtCuRA8deR2LTdTBxBL71qE2ayGg9vjbgDuutf52z4pXaSW2G
         OWFOrVP6nC32qBF2m/UXkWe/WKlwFjGpJ7kGd+iS3bcZjOmHZfJYGNzRWLpE8yao93b6
         Yj+g==
X-Gm-Message-State: AC+VfDzMILB192OXMjkzIy1g+2TGRaQTEiYVEz5prepTkMe6ZoAX2TGp
        WCuONJbTPivsuVSGOEZO51A=
X-Google-Smtp-Source: ACHHUZ5aRnoSIRNdiIHvkgCkLYnZLc8qfPsO3XjpYKTNfLJB6im8Hvz60RomEksrR7SmVMKhDhgvSA==
X-Received: by 2002:aa7:d484:0:b0:50d:b7e5:fdde with SMTP id b4-20020aa7d484000000b0050db7e5fddemr4782214edr.19.1685030938612;
        Thu, 25 May 2023 09:08:58 -0700 (PDT)
Received: from Osmten.. ([103.84.150.78])
        by smtp.gmail.com with ESMTPSA id a15-20020aa7d90f000000b00510d8e43fe0sm696613edr.7.2023.05.25.09.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 09:08:58 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH] adm1266.c: Drop error checking for debugfs_create_dir
Date:   Thu, 25 May 2023 21:08:27 +0500
Message-Id: <20230525160827.15285-1-osmtendev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the error checking in adm1266.c.
The DebugFS kernel API is developed in
a way that the caller can safely ignore the errors that
occur during the creation of DebugFS nodes.

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
---
 drivers/hwmon/pmbus/adm1266.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index 1ac2b2f4c570..184d75269d2b 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -340,8 +340,6 @@ static void adm1266_init_debugfs(struct adm1266_data *data)
 		return;
 
 	data->debugfs_dir = debugfs_create_dir(data->client->name, root);
-	if (!data->debugfs_dir)
-		return;
 
 	debugfs_create_devm_seqfile(&data->client->dev, "sequencer_state", data->debugfs_dir,
 				    adm1266_state_read);
-- 
2.34.1

