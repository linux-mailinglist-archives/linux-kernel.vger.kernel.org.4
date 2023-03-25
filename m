Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E7B6C8E82
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 14:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjCYN2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 09:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjCYN2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 09:28:39 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B673EEF86
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 06:28:36 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h8so18226508ede.8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 06:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679750915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyY2R9QNNXGK8lmhcVSCQDWNmU1D4Zz0mD1roX5FYPQ=;
        b=mzuOkHGbLxSKepiU+jo5J/HKy3Y+rUjpFmiMwAAN7Yu9zbvih3jmgyDa3aYJtjqZt3
         zlV4wg2aQ67i+Jyocb8c6QmJuu+2167aYgENoDJR56fyR2n9xJuhEw3h9gE/aj9Q5Npg
         QfOXSMe7qycC6nS5lNaCrfSTGvxR62Hd75nHlKVrrelJ9mU9Qs1TxLsOhAKFEUMiBMY3
         jUguKEVDlv27jiY9wcdIiU0ToD+HDgxPjHbuA3LNcuALCOlD0EMR6CxWPgarzpLvpE+S
         fkR+7MjRONnSJIXAni5LDfX3aZDSFOP/sMKV1okEFtdoRwhATE5TWcfuB5vHemI6ZaYh
         v12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679750915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UyY2R9QNNXGK8lmhcVSCQDWNmU1D4Zz0mD1roX5FYPQ=;
        b=nBhrj1o7M3JX1gzQJVlLewxA+TODnVVF6KSIlAkc6AY9vL3cHHawTGCn0Lqm4/C23+
         FPC+SqW6x7AuH64EoXR3KjniRzJXmT6rJxLGoUriZF7YQb8CbJLxlK6rjtdiNI+TRiBp
         ORXxSAJhDiotldkygX9aETYpTt5Yc/oQuDh5sclFiFAVyjJRez061QrdRzuulLXPMm5L
         Prl/kUpHcgORpyhtrYQ+73llm0VtG7+FwNNxnBDdP0jHsOAaMdh+WNU8SL/e6DLIYB7X
         Y0mG6Rsyd+RCHFC/dl8bRmnPe/NlF9fei0ONZJU6a6eOaPpChkCjG81ku2np0+L7WDWY
         cpyQ==
X-Gm-Message-State: AAQBX9f4f18M82pdVMtJNyy4nm8/IDnjKi4vCUIyOB6SeUFAT8GHdNrn
        YlkvNrlCIpHc/Z0KVtOd/e4=
X-Google-Smtp-Source: AKy350bCXInC7huNhl9zCnXVyDc8DADdI6kTaSpaiRuZxQKFiN47xeBNrxJkaLK5N9hp80FJuLFfNQ==
X-Received: by 2002:aa7:d50e:0:b0:502:1cd3:d0fb with SMTP id y14-20020aa7d50e000000b005021cd3d0fbmr6204820edq.20.1679750915271;
        Sat, 25 Mar 2023 06:28:35 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abbe9.dynamic.kabel-deutschland.de. [95.90.187.233])
        by smtp.gmail.com with ESMTPSA id lt11-20020a170906fa8b00b008e54ac90de1sm11727610ejb.74.2023.03.25.06.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 06:28:35 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/4] staging: rtl8192e: remove redundant setting of rf_type
Date:   Sat, 25 Mar 2023 14:28:21 +0100
Message-Id: <20230325132823.22872-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230325132823.22872-1-straube.linux@gmail.com>
References: <20230325132823.22872-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At this point the value of priv->rf_type is RF_1T2R already. Setting
it again is redundant and can be removed.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index 3027d43cb362..0e0096ef4943 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -350,10 +350,6 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 			tempval = (rtl92e_eeprom_read(dev,
 						      (EEPROM_RFInd_PowerDiff >> 1))) & 0xff;
 			priv->eeprom_legacy_ht_tx_pwr_diff = tempval & 0xf;
-
-			if (tempval&0x80)
-				priv->rf_type = RF_1T2R;
-
 		} else {
 			priv->eeprom_legacy_ht_tx_pwr_diff = 0x04;
 		}
-- 
2.40.0

