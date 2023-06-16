Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BDD7330FF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245211AbjFPMSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245178AbjFPMSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:18:14 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3D830DF
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:18:13 -0700 (PDT)
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 942F43F04C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 12:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686917890;
        bh=soiKTuNI2szr+B3DMv/HAX9nLtIBEiY4szgRtPOrfZw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=JXcYAdLaAV/oPZuyO0OvgdflLlZQpKFsff3mxithdfqthvrae5VgqqJ07S+NLz6wj
         iyROW9JyNVh7AZNjfYiHbtgiPlgruiQRH2G10rkzAV25FKL8LB+cl/+TYVzRDUUJVF
         GU435JqfLruHu4OhjlO78iAzT9AGpg2ABBdauMlOFECEecF43kUgxq1AocjjgcD9BT
         ffYfQnWpFq/GAlNSeW4oJvbIMmlsGQH5elaw/ZbZDwbL0UkQZ8xFCwR4Xzv7ZRrY9f
         cKv69zJUEqr5eJ1kxuIL0Ixy5Bp7lJ7widVmR/l9nQ2Wwt3pYBKSubni5ajLwBRR8i
         QPBLpSfjU4rrw==
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-4f63eed2413so553382e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686917890; x=1689509890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=soiKTuNI2szr+B3DMv/HAX9nLtIBEiY4szgRtPOrfZw=;
        b=N5HFeeJUfUgbdR3YPM1ptfjQQCFrf+c6yYqI5o4VManTL383U/T/X8jYIatEg5TX3W
         /2a3C3UYBK4Nf4dxd5QK6C1ahF+PSkz1dDTXHmln57JqXut3XW3RwQGrYJLss4hkxRaM
         Z7HAP+fphwN0GyQTegRo2jlzjzT2qKaDkUpVHxuNEqhSiy2aTSIhC3nXA5pQIVzey/as
         VrDuwqf90Z8QyHN9uPtNXW188qY5wieDlMHbxsRssD0c1lr6LWLs1Mc5Kcd+bPOPCfw7
         MEywjY9eVWlaxtgJaCWCO6W1Dt/sERZt/g/BdWhS29argQ6cuusKaNszr0XNg9BsjJX1
         w9nQ==
X-Gm-Message-State: AC+VfDwuyMWrXevyPt15NTFvfyd4Br6smqPGHLNtEeyQEQ740YW1oduV
        oYnr+CKsXfrm0HgihgOe9pVWmybqLjsywK+3qIKsX6EBNfSAGU33yJcVflNJmqts3o+rmevftql
        inbYTjaUE19YvUhY5QBhMSIvTDFBfzTqNY7R072uUhA==
X-Received: by 2002:a19:e308:0:b0:4f8:4673:26ca with SMTP id a8-20020a19e308000000b004f8467326camr1292302lfh.47.1686917890090;
        Fri, 16 Jun 2023 05:18:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4/crAkK52hQhs4lvyn5+P+QYCK7oaPxGTbDvwaNgwbMhqTFQaK3EOu886oH2s+W1wZI3bZJg==
X-Received: by 2002:a19:e308:0:b0:4f8:4673:26ca with SMTP id a8-20020a19e308000000b004f8467326camr1292275lfh.47.1686917889721;
        Fri, 16 Jun 2023 05:18:09 -0700 (PDT)
Received: from localhost ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c229100b003f7ff6b1201sm2045217wmf.29.2023.06.16.05.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 05:18:09 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     michael.hennerich@analog.com, alex.aring@gmail.com,
        stefan@datenfreihafen.org, miquel.raynal@bootlin.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-wpan@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH] ieee802154/adf7242: Add MODULE_FIRMWARE macro
Date:   Fri, 16 Jun 2023 14:18:07 +0200
Message-Id: <20230616121807.1034050-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module loads firmware so add a MODULE_FIRMWARE macro to provide that
information via modinfo.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 drivers/net/ieee802154/adf7242.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index f9972b8140f9..a03490ba2e5b 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -1348,3 +1348,5 @@ module_spi_driver(adf7242_driver);
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("ADF7242 IEEE802.15.4 Transceiver Driver");
 MODULE_LICENSE("GPL");
+
+MODULE_FIRMWARE(FIRMWARE);
-- 
2.37.2

