Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54D46E02E2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 01:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjDLX6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 19:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDLX6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 19:58:20 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4671D3C27
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 16:58:19 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1842f69fe1fso15725508fac.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 16:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1681343898;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h14IXfl6VI9SuhAposhxFPgNYy3NIZJ+euYHkvPtrS8=;
        b=A9U2FcAH8vYTUo3Dr88BbCkEufDyB5gtC3uZKeNq9PGK7g1wgdn7LrGjnfqksodTF9
         8lbW+CHd16ZJ22pv7xHNTBBHcWI2zBh1JNmJdtsOKqo/Zsg4vMq4+WLlqzUM2cOSfUhK
         09EuRcDediQlJViX8u3LmpToPBXp3euHegDmjAyQkx7zYFg0ydGUcO1UA0Tjj8VydSqO
         DAYDspbZfpse5Ku9yoWbEZV8rczUo0Yxi0EmkYWFO0NMurGDwgjOqGSnn5WFzX8+Bt8D
         jiN1g6FpbiYZwClBA63aVN3LddnJ3NqBXMuZ11z9Nw9IpWK5vxFMJ4dz8XRSm15hOV5+
         Po7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681343898;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h14IXfl6VI9SuhAposhxFPgNYy3NIZJ+euYHkvPtrS8=;
        b=b/x+38GsLyQy/qrqfU5ofxYbklrUpowm8NApOUohwTTYzHpquQNKCKVWMeXxLiMYwQ
         apRynXdIEVUcwtJhsEihxuYMaS+Fm3lY8cTeF3Z1bkQ315/BubRyTl1sxhumcl87URDq
         NHJLKcb+nTJChgZR/7AvruITin6tMeGqTZRnj6rfznpIOjNL7LXTDFWFzY6dHWkqib22
         0KLv9lQCr8/ujGyNx1u2aNiduLpT0XUWI6X6Mr1Oia1ByyoJE7VLP+i7VjqpzKIX7u5m
         vZ1FXvmUX4+Tlja+QNuXSa822rMn7TqPun2scf6mlUvntmZyLnUg/ikqtgEChOIoD3xl
         1Z8w==
X-Gm-Message-State: AAQBX9eS2jgIPTTgY6tVhwJ9R68tzsqAgR1l9SNH+8ow7wt2SZSCDwyp
        PSOnDI9yKz3iqV2UCNIpdoLPTnAKX6CMIzs51JjWFA==
X-Google-Smtp-Source: AKy350aTQ1AJ/VfRTneWmBCNG22VeJS1FeIAxR8JzxVmwLw9/RBWe8LeIkBS39U4GyXofj6zPC/lfg==
X-Received: by 2002:a05:6870:73cd:b0:187:8ab7:c0f6 with SMTP id a13-20020a05687073cd00b001878ab7c0f6mr428264oan.9.1681343898677;
        Wed, 12 Apr 2023 16:58:18 -0700 (PDT)
Received: from localhost ([2600:1700:eb1:c450::35])
        by smtp.gmail.com with ESMTPSA id b31-20020a4a98e2000000b0051a6cb524b6sm40178ooj.2.2023.04.12.16.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 16:58:18 -0700 (PDT)
From:   Steev Klimaszewski <steev@kali.org>
Date:   Wed, 12 Apr 2023 18:58:17 -0500
Subject: [PATCH] Bluetooth: hci_qca: mark OF related data as maybe unused
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230412-bluetooth-v1-1-377b9bf7b08e@kali.org>
X-B4-Tracking: v=1; b=H4sIAJhFN2QC/x2NQQqDMBBFryKzbiCOVmmvUrpI4mgGbFJm0lIQ7
 27s8vHf522gJEwK92YDoS8r51ShvTQQoksLGZ4qA1rsbN+i8euHSs4lmjBeb5bmAXHqoPreKRk
 vLoV4Pl5OC8k5vIVm/v0jj+e+H8HlPEZ0AAAA
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1250; i=steev@kali.org;
 h=from:subject:message-id; bh=ympCbGntj3/wcMctjECb4BD9NMjn+TgpsO4HeYNDsEw=;
 b=owGbwMvMwMUosahgcqykaSbjabUkhhRz15l69nasbDwvzmkXXV5rcP3pfLtQDf+6tO9JK/fNr
 XrBfuNqJ+NkFgZGLoZaMUUW1nsa3q4fD1XO9Uh4AzOIlQlkSrxIAwMQ6DFoZBYXl6YW6aYVFDnk
 5ZcklmTm5xXr5Rek5hWkF+ilZaaVZGTkFxWn5ibm6eWllhiYurgaWZg4mZi6GTobmVtauphYmBm
 4OhtaOBqZG1gam7oYAgkzSwYuTgGYjb+i2H+zp257wcYgd9Hs0RTL2/u45K9PlvWRrlSVXbx6Je
 vU9OsCk947bvh3XyLzlppn7hPHsCfbl/oYP+9YNrt6n1Xg+Q8Kay0uHvJ8Jh81d7PG1L9G5lITF
 +qffJpXc3SmbknCPCE1tXuC2zOXcqYF9qyuV7xTfcu1IJxp0w0F5cXFsgKW/xamZwR0nPE6v639
 WL6u6je+/MeThPa9SD28Wep49+XKV8ei8ia8MUuI3jeTc4F7dJjRdoaigl/b4k5u3iLpuqM3qIZ
 5hfONLQfvufr83jBp3aXYrQy+C1Iaf+rVrHIz+77Dc3fyrw3fyzon3TiczafBpXPS2Pi31aWmGs
 fmiw2fL9/xtpD6o8bKpn8YAA==
X-Developer-Key: i=steev@kali.org; a=openpgp;
 fpr=70D5FB3206291ED5EC1FAC57FF5F35DF030F380E
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can be compile tested with !CONFIG_OF making certain data
unused.

Signed-off-by: Steev Klimaszewski <steev@kali.org>
---
There was a patch to mark OF related data as maybe unused in flight when
I was doing my bluetooth driver work and I didn't notice it.  Since I
don't build on !CONFIG_OF systems, I hadn't seen the warning.  This
patch simply marks our data as maybe unused as well.
---
 drivers/bluetooth/hci_qca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 1597797ff169..1b064504b388 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1891,7 +1891,7 @@ static const struct qca_device_data qca_soc_data_wcn6750 __maybe_unused = {
 	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
 };
 
-static const struct qca_device_data qca_soc_data_wcn6855 = {
+static const struct qca_device_data qca_soc_data_wcn6855 __maybe_unused = {
 	.soc_type = QCA_WCN6855,
 	.vregs = (struct qca_vreg []) {
 		{ "vddio", 5000 },

---
base-commit: 7d8214bba44c1aa6a75921a09a691945d26a8d43
change-id: 20230412-bluetooth-c7590ef622d3

Best regards,
-- 
Steev Klimaszewski <steev@kali.org>

