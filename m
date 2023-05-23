Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C6C70E1B7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237379AbjEWQXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbjEWQXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:23:22 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73C9E5;
        Tue, 23 May 2023 09:23:19 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-64d2981e3abso4506989b3a.1;
        Tue, 23 May 2023 09:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684858999; x=1687450999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BSLFIjazbnmJuk1PaO8RBmpoDwlcGuPVoUx253JXMIg=;
        b=N/FkLRL7ItTCG2zSsiOw19DAcEG8xYItkOiFi2UcS9XVpCXu1yx7O0eLSb0WpkHhFl
         IbmPn5zRZBPfJ64YlADS4vKRFXpXfAWaqQBEav+bG6cuUgo8pOMN0o5QYQL/DA8XejEp
         5jXMdf+YuLLlIys7LGj7n2SkDYMCzHDojBA1BX5/HjWaGfc6gUVrEfICzlKu60q+H6nc
         6S61SSewNVRlXtbYFZkCC3ie9LaHg5QwVRrvjq0zTkgID6s70HFadVg/DE2ToHheB5wp
         PkcQfJt+izswOd5mwC7SyTlyV6KgVkGs7Lh3KFDkpWAcjdFA9sTl2NSRk1frfqQWyHmo
         KNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684858999; x=1687450999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BSLFIjazbnmJuk1PaO8RBmpoDwlcGuPVoUx253JXMIg=;
        b=Z0uHQCJRlD70VKZXyuRgdVq82Jky1ryOyW2rpEqsKQl1HuOJFAH/a8HZcqhU/Od1L5
         zbt6MASyWiXfyn41lFzliotPzbeZYnp+iCdFAodWISGHQ2d+D5sg9tI2vFMPRTHDVv5D
         W9F1JYpKxEoVx+J+S/Q69HevLxLfYxZ6dabhTksn/72tICgyKs+VOhsvTteI5Mf2oVgl
         n6OItlw5nCjddJdwojudW1lQkESdKjg1Xh8hzs8VAEGk5FS8WcZdH/4AKc3QggTr3rXb
         L3pj7f/MGUnERof2mJe9XPUCvCa1HX2kjUYCTdeQ5EiW2vgm2i16iKtb6hfjK47eQPg3
         28nw==
X-Gm-Message-State: AC+VfDxvPyKzlylT7QjSr1BeYmExQ1EK2ucEiz9z4kg6rNxMBgjhVkYk
        +ZjZXXMO4vFMSOlJoM4b0ik=
X-Google-Smtp-Source: ACHHUZ5Syl31doGd4JqexDKW+xM/ACKZ5a09sGX7hHRTYCLTLprkN/vhP8DA3KKKLbcs3tbpPXlZFA==
X-Received: by 2002:a05:6a00:a20:b0:64a:4bfa:6b8d with SMTP id p32-20020a056a000a2000b0064a4bfa6b8dmr20477802pfh.6.1684858998958;
        Tue, 23 May 2023 09:23:18 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-81-153.dynamic-ip.hinet.net. [36.228.81.153])
        by smtp.gmail.com with ESMTPSA id n18-20020a62e512000000b0064d6f4c8b0bsm3822212pff.94.2023.05.23.09.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 09:23:18 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: typec: ucsi: correctly access opcode
Date:   Wed, 24 May 2023 00:23:12 +0800
Message-Id: <20230523162314.114274-1-minhuadotchen@gmail.com>
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

hdr->opcode is __le32 type, use le32_to_cpu() to cast opcode
to integer in the switch..case statement to fix the following
sparse warnings:

drivers/usb/typec/ucsi/ucsi_glink.c:248:20: sparse: warning: restricted __le32 degrades to integer
drivers/usb/typec/ucsi/ucsi_glink.c:248:20: sparse: warning: restricted __le32 degrades to integer
drivers/usb/typec/ucsi/ucsi_glink.c:248:20: sparse: warning: restricted __le32 degrades to integer

No functional change.

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index b454a5159896..1fe9cb5b6bd9 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -245,7 +245,7 @@ static void pmic_glink_ucsi_callback(const void *data, size_t len, void *priv)
 	struct pmic_glink_ucsi *ucsi = priv;
 	const struct pmic_glink_hdr *hdr = data;
 
-	switch (hdr->opcode) {
+	switch (le32_to_cpu(hdr->opcode)) {
 	case UC_UCSI_READ_BUF_REQ:
 		pmic_glink_ucsi_read_ack(ucsi, data, len);
 		break;
-- 
2.34.1

