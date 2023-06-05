Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCB4721F83
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjFEH2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjFEH1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:27:50 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B3098;
        Mon,  5 Jun 2023 00:27:48 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b1a46ad09fso51084121fa.2;
        Mon, 05 Jun 2023 00:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685950067; x=1688542067;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsP0n5juNyauxV4ZzGiEHcjUixvHobJ7dhZs4yRrqJI=;
        b=h/7XCXusn51Z8gchWhBGbEfoI1f8wXzjmCmwyAV+YdrxWmws2wUFCK+9WUMNXmxLM3
         A5lDIMH5vr7hiosRq4hrPBbLukoEG1FWYPzLBBG41IPfIvt/ESeOWkL6QliA+x7rrhI/
         Vn7oGdOSfbgaP4hcSAxiwAtoHGA1PGC5mvOuMbH9oAcXDlJwSwUtGYSX6AcqbNrNMiNi
         E4V7csdznjg3FFvDMQv8UuATgEC07xMSCkb56wkAVhyDXbecGj+5y3LcPvfCwIGUQTWL
         fq+QB8K2iI5d2AFTy1avYEcBAX6OzrdeZDiB2FhvUcPbI0HEGOy36kLuRYehMhzZvA5w
         ZG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685950067; x=1688542067;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsP0n5juNyauxV4ZzGiEHcjUixvHobJ7dhZs4yRrqJI=;
        b=doeI1FvRhi2PJT59GBt5LLKl4c5B5E7nnnUx/yi6Z0OlBvCHpO+g2gwHTBe+OIsVmd
         qwT7K1jM+uVAcMYK46xD2+FpR/0709TC9/e0bFbU6muqlFOXZC+iDuIaY//1fQcmSeQh
         eQNisn0jyt2zGrNnxsNlTGSoJXe7/6nJv7eiV8DP7tmoKrR+OCAULoLVkjmVh7pIKsFL
         QPt9OkDrgUk0wEQDWsPR8fYYc4TFpVqtYIKMEf0I844DnphKIWThu+sRQTsidCsaSaiI
         /GYGKom/tcQahqcr9l/4TmIU5kqq41ULac1Aktj91QC1ipTiZ6pbPNoQvxn8yVfHMTh+
         evdQ==
X-Gm-Message-State: AC+VfDz+nB3szubGDdjtgZIcfhT7zepN0O8Jaq4emQe6+w+j2QJgTR7F
        QGRdbprw2pEXC3uwlCbOvw0=
X-Google-Smtp-Source: ACHHUZ4Wz4q+jZu5kAv6QOPm74HoKeM8yyFcMAonyqnL8xCKX2S2QjaBAoS+jo+0EcG7yzxfafXP/Q==
X-Received: by 2002:a2e:9d18:0:b0:2b0:3343:1c0a with SMTP id t24-20020a2e9d18000000b002b033431c0amr3192634lji.31.1685950066428;
        Mon, 05 Jun 2023 00:27:46 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:91ce:1f9c:f9d4:7837])
        by smtp.gmail.com with ESMTPSA id kj24-20020a170907765800b00965f5d778e3sm3911553ejc.120.2023.06.05.00.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 00:27:45 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jaco Kroon <jaco@uls.co.za>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] net/pppoe: fix a typo for the PPPOE_HASH_BITS_1 definition
Date:   Mon,  5 Jun 2023 09:27:43 +0200
Message-Id: <20230605072743.11247-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of its intention to define PPPOE_HASH_BITS_1, commit 96ba44c637b0
("net/pppoe: make number of hash bits configurable") actually defined
config PPPOE_HASH_BITS_2 twice in the ppp's Kconfig file due to a quick
typo with the numbers.

Fix the typo and define PPPOE_HASH_BITS_1.

Fixes: 96ba44c637b0 ("net/pppoe: make number of hash bits configurable")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/net/ppp/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ppp/Kconfig b/drivers/net/ppp/Kconfig
index 2fbcae31fc02..8c9ed1889d1a 100644
--- a/drivers/net/ppp/Kconfig
+++ b/drivers/net/ppp/Kconfig
@@ -141,7 +141,7 @@ choice
 
 		This hash table is on a per outer ethernet interface.
 
-config PPPOE_HASH_BITS_2
+config PPPOE_HASH_BITS_1
 	bool "1 bit (2 buckets)"
 
 config PPPOE_HASH_BITS_2
-- 
2.17.1

