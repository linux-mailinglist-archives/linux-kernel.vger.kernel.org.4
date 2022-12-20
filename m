Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0826525DE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 18:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbiLTR4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 12:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiLTR4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 12:56:30 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D51DFDC;
        Tue, 20 Dec 2022 09:56:28 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id bx10so12570503wrb.0;
        Tue, 20 Dec 2022 09:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Unl6QfwtHEjfkMdy1Yw/MGc3MT3pIvqz7ripxlsDJwM=;
        b=EJ1/cehcjfRl7EyInh5Z/uLfXOFn4tMBnMQQ6rcV4YHol8i34pvIst2Ahka5JldZaP
         lgVnL2M95Kx7ZtPmQOiOxQrdK43tDxqmZzIJ812UKMFrrOiNznIlnm/GaQjLBl+/8DV+
         ap27LBUVSlFidCzIIR8b7smAgZrmeNOmkjq7ypf+LfWlhNxBaTIX8190o8X7xLv8B/8a
         KfD6Y/OQ5F/pPuEo5+VmjXfIvpoW0oPYALDh51UTtJeshDp6JLpuALDQKJnj4f513YgC
         97yryLVIiNobqGU5OyKP0oScWZiHPoMCcTcWjZSpv5Q8hTni76Fm9/WtO8fwkmWo/hzS
         Tnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Unl6QfwtHEjfkMdy1Yw/MGc3MT3pIvqz7ripxlsDJwM=;
        b=eVRh/+00BlvApbIGihanaj4p3yLmTKHwURf24BOg873Co/DnNst9UBNV8P1aGRj/sU
         XQp4ajO9eeyzkgKGECO6CT2N3oErHTkEG7I+B8ZbfE3YGw0Lsp9aoOGLLHbO7F/oUFP1
         KUnPlvMze5Vn0EY6ZOWEZCRtyuL/niJuHB5Nmq+kTq4BO2lX/ksd4rHmKSw8z/5h+Y98
         qqsYFudn3Xc2mTLV8EC87gykyUyK0pWsuWv8hiaueBJxaWB/jmreezJbcWZdOmJXKIIm
         bOyBQvernTvRR22GupEsy1pOj0PoWPU6ZFrc2ZzxQvrzxPV/e30Cr0Z7Lpy/m21Dr+8n
         NK0g==
X-Gm-Message-State: ANoB5pnoFDUEqwcon/sr2by1yvf5a3JX4JGZQ7cdQW4Me2lucvRGDkhZ
        c9TfZMpgEzDSl7KZArujMchFfbHihEk=
X-Google-Smtp-Source: AA0mqf5k4KBGN5C8h8zW51eNSSAnzEWtuRSO5cEDFNQ1ez9Ol0mqDVlVrZfId73bwnnWDFTcIvsYlA==
X-Received: by 2002:a5d:40c1:0:b0:242:81da:f3c3 with SMTP id b1-20020a5d40c1000000b0024281daf3c3mr30834520wrq.63.1671558987030;
        Tue, 20 Dec 2022 09:56:27 -0800 (PST)
Received: from xws.localdomain ([194.126.177.41])
        by smtp.gmail.com with ESMTPSA id u18-20020adfeb52000000b002423dc3b1a9sm13206300wrn.52.2022.12.20.09.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 09:56:26 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] platform/surface: aggregator: Add missing call to ssam_request_sync_free()
Date:   Tue, 20 Dec 2022 18:56:07 +0100
Message-Id: <20221220175608.1436273-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.39.0
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

Although rare, ssam_request_sync_init() can fail. In that case, the
request should be freed via ssam_request_sync_free(). Currently it is
leaked instead. Fix this.

Fixes: c167b9c7e3d6 ("platform/surface: Add Surface Aggregator subsystem")
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/aggregator/controller.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
index 43e765199137..c6537a1b3a2e 100644
--- a/drivers/platform/surface/aggregator/controller.c
+++ b/drivers/platform/surface/aggregator/controller.c
@@ -1700,8 +1700,10 @@ int ssam_request_sync(struct ssam_controller *ctrl,
 		return status;
 
 	status = ssam_request_sync_init(rqst, spec->flags);
-	if (status)
+	if (status) {
+		ssam_request_sync_free(rqst);
 		return status;
+	}
 
 	ssam_request_sync_set_resp(rqst, rsp);
 
-- 
2.39.0

