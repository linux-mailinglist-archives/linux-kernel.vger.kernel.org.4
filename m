Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AD66FC46D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 13:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbjEILBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 07:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbjEILBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 07:01:10 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFC0AD22
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 04:01:07 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f42bcf5df1so5430545e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 04:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683630066; x=1686222066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDvQZ0wVubMTzkZKF7CKcTumclmjvLsh+AvVj9BSLoM=;
        b=AWn3wLUXd9hCtlvtO0hBqIuwBb3XjCU2WaiY6TpLtYyew2u6lFJR1PmqhbXGL3Ame+
         E/u3ItxCB00ahHmNRzX6P1nm+E91VlMzePxNUerZZObFlB0gkXhsjymPq1cgJS1gKSuW
         L211S2W6J73mapVtpnHe7+j5W89vwuBGexXO+lcO66vlEQ7Q0PM+X4/lpbkX/PY/Hr9X
         65HLHjQk42aNJ9LYF4eUA5mRAhfAG7jCd/5TtTdzkCME4QIPUCd/bU3qXgMOD7ixnmHc
         ht4DgI/sbSS3vZFRRxa4bUSETqYczN8aQws2+IpSrbVwGrE5KaPReMO1ov+8dLp4xGBW
         IF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683630066; x=1686222066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yDvQZ0wVubMTzkZKF7CKcTumclmjvLsh+AvVj9BSLoM=;
        b=cJNJo5dybP/B4Q9nVjfhtf1oTcPLieY/iEAJB4fp73umbRJnr+lDVZpntiTQrqo5Mk
         DnsblEDh+qZbr+LSCHe2FHXkGAh3imNDJdwqfcQmNxAJ875qpTT0/x60qNqQpUw9532X
         bim3uYCB5JTJOLR1F9Cjt1hK3cX0lyuoy3ztm/b0lG5VeAUqolXa7ydkhSac1he68mPv
         9tWydSDXmeTcGbTqIEh6OyajYkId+VhxOvB94qtHnCKd9GV1ACW1Hfdx7SKMeFa8ZUns
         b5iF/OLkUa42PzERaRo1amB0FBapVR0DyG4BZRbiaiy5Ykw/FaP8aAeQ0WkKWCPhSQ+q
         K7Bw==
X-Gm-Message-State: AC+VfDyp73Lq75UGuOYZRXGKUYwtEdNXqkMx1gPf70Oh4UvJGaslRCbj
        glrJ+/ZjUeyTIYmjbklxBzI=
X-Google-Smtp-Source: ACHHUZ70GPQopfTbtkVLnhTIHREmjiv6j5MrQhgyNYr/vBtjPnCEkCN07Kd6kSWghgvzoYwmXCYoww==
X-Received: by 2002:adf:fa50:0:b0:307:a3e9:8b93 with SMTP id y16-20020adffa50000000b00307a3e98b93mr1488786wrr.2.1683630065998;
        Tue, 09 May 2023 04:01:05 -0700 (PDT)
Received: from localhost ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id p8-20020a7bcc88000000b003f03d483966sm19371239wma.44.2023.05.09.04.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 04:01:05 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/6] regmap-irq: Fix typo in documentation for .get_irq_reg()
Date:   Tue,  9 May 2023 12:00:55 +0100
Message-Id: <20230509110100.3980123-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20230509110100.3980123-1-aidanmacdonald.0x0@gmail.com>
References: <20230509110100.3980123-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It refers to a non-existent "num_type_settings" value, which is
an old name I'd used during development of config registers and
later dropped because it wasn't very clear.

The correct bound for the range is num_config_regs, which can
be verified by checking the implementation.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 include/linux/regmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index c2b9cc5db824..45fdb6e93617 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1606,7 +1606,7 @@ struct regmap_irq_chip_data;
  *		 addresses. The base register will be one of @status_base,
  *		 @mask_base, etc., @main_status, or any of @config_base.
  *		 The index will be in the range [0, num_main_regs[ for the
- *		 main status base, [0, num_type_settings[ for any config
+ *		 main status base, [0, num_config_regs[ for any config
  *		 register base, and [0, num_regs[ for any other base.
  *		 If unspecified then regmap_irq_get_irq_reg_linear() is used.
  * @irq_drv_data:    Driver specific IRQ data which is passed as parameter when
-- 
2.39.2

