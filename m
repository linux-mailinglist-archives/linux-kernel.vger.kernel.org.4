Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D377571102A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241814AbjEYP6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjEYP6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:58:31 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E704BB;
        Thu, 25 May 2023 08:58:30 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9707313e32eso153267466b.2;
        Thu, 25 May 2023 08:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685030308; x=1687622308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p0SyaWafeaO92rAJilaK8J8zpaESqC5U4EG8uSUxpmE=;
        b=NJaGmSfFDQfEvhGlHs4jc0o9BsWZfCx9O6WOoxFPc7jW9izgi0u3wCS/ILu5/qyQOs
         R1dOXTI+YdGf9et+0qhFiIzD70MDvP5GAd6JRYwWGfMwRStrVZ/Bh6ZjmEho4UCbRGO2
         wpLSNUZ5+rFvXc8quaboZP0hok6MWitQ+Hl+DeGSC0HvBPAAZi67sPhTc8j81IlhMOL/
         nBxk1aWDhIcdHFOuoRgKheL7p3+anq1qst4ZnWWg+0kglOSpZ/AZBeHTatQSzEFsTntw
         BfvF+qNPYR4TT7YD37sWQz/tXSqLYMl/m1Iq70maXtcXyK/juMpbMeK59bhtu0GYuuY4
         1W3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685030308; x=1687622308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0SyaWafeaO92rAJilaK8J8zpaESqC5U4EG8uSUxpmE=;
        b=OGnlkL3V+HlIdWfrwF5OlBsHbTaC9lfCoAtEgAckf2gzCdSijApyeDbinZYTjN8Bp2
         FOjv8Fk8wE8iSP4/ZfqCLidTCI0+r/rndsA3cItp203f3G/JXQ3KK3Xd9tVCLNr4WGi3
         7w5i5DRgA/Cvql6vwFSiNABXEPKaPfiV/4BMjrrVO8IcDFXkeBEijD2p5NQHjFveIGUb
         FXr/eVFZCG2MBNbk0EIF20Q21wtSYFYgLouHT7BnPpDVUEubjmSYV+tvS25eLv1rolYb
         CmOJVLdjgfnvLKg9d5V1HKb3m7xvgyzdKAAsVoFJFZLDiw8Y7FEfncZ3iaVv62EJMKl6
         3EFA==
X-Gm-Message-State: AC+VfDzSzXNJoVOp3pZAgET0aG6qBg0r3Jc+vswEb+8lYcXmP+xHTm7e
        C2MdXToKjLG9kFbeidy8YxFcH89ZHhLuCA==
X-Google-Smtp-Source: ACHHUZ5xX5DhzOFm4j2x2B8WyfZhd/gc356MLb/fIhdzi9MxVsr97MyzrPSMzxibR4ayP/D+o0p2fw==
X-Received: by 2002:a17:907:86a0:b0:96f:98f1:6512 with SMTP id qa32-20020a17090786a000b0096f98f16512mr1960294ejc.41.1685030308025;
        Thu, 25 May 2023 08:58:28 -0700 (PDT)
Received: from Osmten.. ([103.84.150.78])
        by smtp.gmail.com with ESMTPSA id x23-20020a170906149700b00969dc13d0b1sm999164ejc.43.2023.05.25.08.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 08:58:27 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH v2] adm1266.c: Fix error checking for debugfs_create_dir
Date:   Thu, 25 May 2023 20:58:06 +0500
Message-Id: <20230525155806.14690-1-osmtendev@gmail.com>
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

This patch fixes the error checking in adm1266.
The DebugFS kernel API is developed in
a way that the caller can safely ignore the errors that
occur during the creation of DebugFS nodes.

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>

---

changes since v1:
	-Dropped the error checking for debugfs_create_dir
---
 drivers/hwmon/pmbus/adm1266.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index d88b6115b42e..184d75269d2b 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -340,8 +340,6 @@ static void adm1266_init_debugfs(struct adm1266_data *data)
 		return;
 
 	data->debugfs_dir = debugfs_create_dir(data->client->name, root);
-	if (IS_ERR(data->debugfs_dir))
-		return;
 
 	debugfs_create_devm_seqfile(&data->client->dev, "sequencer_state", data->debugfs_dir,
 				    adm1266_state_read);
-- 
2.34.1

