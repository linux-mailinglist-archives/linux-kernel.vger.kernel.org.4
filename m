Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771666562C0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 13:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbiLZM55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 07:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbiLZM5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 07:57:54 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307911F2;
        Mon, 26 Dec 2022 04:57:53 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id y16so9977306wrm.2;
        Mon, 26 Dec 2022 04:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zzKvBwGrGZqlmHNrTPVabDsnxi1Vb5DLo53RO5lTTug=;
        b=lMMnEduGp+dJ2rD+CcY9BqL+9PtAlwA/fUaNCiKIyMJRRLFlSgqgAoH/t5Rd0ijAnH
         UbF7rX5HVxghhGlIasFnphAJ/fzeU0lzxInlsGE3wIAX9RAmU3DxkGxwiaZ/uKbDRgQJ
         wd7Zjv7LDmylirRXQd+/YtcZuturhmjjJlWzoBS7XGF1UTvbosOvaLzXvtbyOqxuR5xk
         8TUvxae+CEhcSRqX9QXBM3wOmq6kQpTU+Rudy4R60zI69ogD9pEJhRDyMNADYth3kjkz
         ch1tmM8baMr4MrRbSHyMxH1SiuLPH6xLpE5uxw8KsU97AZnvT7gM9vk7pbcJqvmtrnbz
         yFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zzKvBwGrGZqlmHNrTPVabDsnxi1Vb5DLo53RO5lTTug=;
        b=ntb3krUrOaSsO7kDOcKX56LqINR8SzZ+SaFcYtk7p+BntUcYWL1YdItFy7igNedguP
         7ekoLoXjVdTqU/DNhI81SC4zxDUnUXC1EaUWvzQ9C46xsvDR1Ae/J3xJNbEerTgcxwjf
         FZhgSGjCjR287R8XT3Lha9iKxpmlWR7m4Jv4d8q7BwuGFX5J0vCefgJ1FvwpuRBBeW2Z
         /tIMtq/RoM8frKhVUPKM+yqiRUuuqKykCJ3j4+L3GHeICVbJr8q05qp62I+QHhbapBB3
         OouVvNQv64Seyarx0RgqQvTDWO+27SXoPFKi9kiliZilD+tXnB1Y2t7HZLiZPrgj3OGS
         gE8w==
X-Gm-Message-State: AFqh2krmlydPod3um+KTCh6aJ4eRJ/embKVPsZDv+RtMGP/vTsCGbN+0
        4oGrjHb6/Zgod+s86iawrEc=
X-Google-Smtp-Source: AMrXdXtRzegJTuODg070keipRJX+eD5VEI7pzy6NOe/dNzgeNr/cs0pLEeBUSDMPSpuvTRnBPhYRuQ==
X-Received: by 2002:adf:e5ce:0:b0:27e:520f:1093 with SMTP id a14-20020adfe5ce000000b0027e520f1093mr1778753wrn.37.1672059471722;
        Mon, 26 Dec 2022 04:57:51 -0800 (PST)
Received: from localhost.localdomain ([94.73.32.212])
        by smtp.gmail.com with ESMTPSA id l7-20020adfc787000000b002238ea5750csm12406285wrg.72.2022.12.26.04.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 04:57:51 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, mcanal@igalia.com,
        mairacanal@riseup.net, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH] HID: uclogic: Use KUNIT_EXPECT_MEMEQ
Date:   Mon, 26 Dec 2022 13:57:36 +0100
Message-Id: <20221226125736.18053-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b8a926bea8b1 ("kunit: Introduce KUNIT_EXPECT_MEMEQ and
KUNIT_EXPECT_MEMNEQ macros") introduced a new macro to compare blocks of
memory and, if the test fails, print the result in a human friendly
format. For example, this is the output of a test failure:

 Expected res == params->expected, but
     res ==
      01  02  aa  00  00  00  03  bb  00 <00> 00  04  05
     params->expected ==
      01  02  aa  00  00  00  03  bb  00 <01> 00  04  05

Use this new macro to replace KUNIT_EXPECT_EQ + memcmp.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-rdesc-test.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hid/hid-uclogic-rdesc-test.c b/drivers/hid/hid-uclogic-rdesc-test.c
index b429c541bf2f..90bf4e586e01 100644
--- a/drivers/hid/hid-uclogic-rdesc-test.c
+++ b/drivers/hid/hid-uclogic-rdesc-test.c
@@ -197,8 +197,7 @@ static void hid_test_uclogic_template(struct kunit *test)
 					   params->param_list,
 					   params->param_num);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res);
-	KUNIT_EXPECT_EQ(test, 0,
-			memcmp(res, params->expected, params->template_size));
+	KUNIT_EXPECT_MEMEQ(test, res, params->expected, params->template_size);
 	kfree(res);
 }
 
-- 
2.38.1

