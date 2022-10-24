Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F25E60C047
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiJYA7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiJYA6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:58:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D69B1D52E1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 16:49:06 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k8so9717088wrh.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 16:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=INM0X9nAcAvNb9TJaNUKsyqVPgEHr1UlnG5q98DRrSI=;
        b=t5GVk+k5k+51LqxpwlfF1A3PiSI603YNrmNPV2GMBI1fqcXRXlT7FCTqMmWDzASAV7
         JUrulPot3hiZ0lA84kB9v71cJDZg3Yuia0oc9owu5BKeHdVyDpehosmMfGkEqu7+yYYU
         /SMSVd3I7JvUE2/s+UsvuYlR9GC0BONbOSTAgpyNJUKW+THukQNbzzqzjy+KjxWriWtS
         x5p5wSaPlw7O5Aeyy0xDd+V2qUePfoCcLNtytZrAH/01i1SFeaKWqbGtMW02IjzwGfKq
         T9xJZkw2s4WU3mMtNr/HykQtRCd5xR7qD0A1Hknjz5hvzDe4K40P8dONgbtG8OoLajg5
         Kghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=INM0X9nAcAvNb9TJaNUKsyqVPgEHr1UlnG5q98DRrSI=;
        b=e5MxRVh7MgL1gJyLzq5iXZ5qMQj7J/1AYctZDlbd0VF3THabu+jH6/sOLGByroSi8k
         JMvK+J4IdAb3/reGQ4Iv/OM/VJj1FMhF2zrVriLhsh0IFS/7sL4TdwJrw01E1hqTpoVP
         y2kyRd990n2DJJ1l7AI/rxwHRoI2OGdIiguWzyMqLyi8k1oStLba8xSTSgVRCZo75Msd
         bBWgzjvLFPRiZs+Ad6aWEl2N27Cv/IhoLfr412qQs2y06m/Tn6U2M1bgVvnf1JVjhiSX
         mw5fPsyRZauwxvLcWr+9vpNyGZyKgg6SFgY4syLTz1Z7f+eJ7UBKfqPmqmU1qczqrjjh
         Qdqw==
X-Gm-Message-State: ACrzQf2CiaCGCtYGqQo0KxN8iSRhBrLppAyIT2a1pqAuYjNOz+Ecggrm
        lTtBN5vs10OxeKmjq7lTfAyKfg==
X-Google-Smtp-Source: AMsMyM735urZrNFZGTxRr30NpBKG66yBbTZicBVsvTjJL1NrHfL2Ka2HlE/TCdi9Pko9YlE46Glexg==
X-Received: by 2002:a5d:5a82:0:b0:224:f744:1799 with SMTP id bp2-20020a5d5a82000000b00224f7441799mr23154371wrb.582.1666655344946;
        Mon, 24 Oct 2022 16:49:04 -0700 (PDT)
Received: from localhost.localdomain (cpc76482-cwma10-2-0-cust629.7-3.cable.virginm.net. [86.14.22.118])
        by smtp.gmail.com with ESMTPSA id iv13-20020a05600c548d00b003b4fdbb6319sm9783809wmb.21.2022.10.24.16.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 16:49:04 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     Alex Elder <elder@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jami Kettunen <jami.kettunen@somainline.org>
Cc:     Caleb Connolly <caleb.connolly@linaro.org>,
        Alex Elder <elder@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH] net: ipa: don't configure IDLE_INDICATION on v3.1
Date:   Tue, 25 Oct 2022 00:48:50 +0100
Message-Id: <20221024234850.4049778-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.38.1
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

IPA v3.1 doesn't support the IDLE_INDICATION_CFG register, this was
causing a harmless splat in ipa_idle_indication_cfg(), add a version
check to prevent trying to fetch this register on v3.1

Fixes: 6a244b75cfab ("net: ipa: introduce ipa_reg()")
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
This will need to wait for Jami's Tested-by as I don't have any v3.1 hardware.
---
 drivers/net/ipa/ipa_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 3461ad3029ab..49537fccf6ad 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -434,6 +434,9 @@ static void ipa_idle_indication_cfg(struct ipa *ipa,
 	const struct ipa_reg *reg;
 	u32 val;
 
+	if (ipa->version < IPA_VERSION_3_5_1)
+		return;
+
 	reg = ipa_reg(ipa, IDLE_INDICATION_CFG);
 	val = ipa_reg_encode(reg, ENTER_IDLE_DEBOUNCE_THRESH,
 			     enter_idle_debounce_thresh);
-- 
2.38.1

