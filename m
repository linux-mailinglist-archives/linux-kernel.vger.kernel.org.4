Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84CAD6D6A86
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbjDDRZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbjDDRYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:24:03 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE3510EB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 10:23:18 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b20so133612893edd.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 10:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680628994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8H0YgMUpIWLdD2v+hIJLczLnys0/j8ZGQWwWDvOJPQ=;
        b=uj6aPbjT5mFUfaBgt+1hNn+3Ve2/ulCqReD2aJ9yhmDXwd8YJI36fj9GsjxakVwpls
         AkUGeosrKe6RNbWmDBKNoBb4p08m+82m0QmPnQq8l4JmyhMUP6g0rGyfs1K/z4BlCLep
         PjteFCDFJClPQgf6veciNtekP2MLkfoAM+4KT6YAPb6niJ+TC1WSstEjSIAWLHW7AjK1
         GCg0/36qlCMleX0619KJ/gh83gaJy2/hDdocZfjeLOEaKSmhlt0MjUkYCACMV6B4pAOo
         7V0b/jKQAHRgW9O+bn9AiDbvxT6iKg9T/8zeMqzcA3p3MdwDZFalBpz6ihSPqnaFkscZ
         WVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680628994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8H0YgMUpIWLdD2v+hIJLczLnys0/j8ZGQWwWDvOJPQ=;
        b=B4GOPZTJqSIVPPNFc6cygiVt2CNH0uTHFovLEl/e7IDyqRxvx6OZw/Xg1JhrAgFps9
         h6WcQQkEXtLqZ7lSR8UaIwvqHqSMfXLHqTfzqo8c3nqhoOM1Qr6BSHOB8oiEz+9x7t9N
         WKPAXTk2qNNN/FwLLmPku1fAsCDdLouH+wNP0saDhH+WVgYXf/hDF7Oqc5nhXmJyQAY+
         p9AyWtR0Nyr7lCWfyVOjzZx58MPRgDujp2BEL6tLCK8mAtfmmCYhotVMC4JaBJ25vNZx
         +vhEWgPszqmSsW+5vJZO/NMc/2mT90Y7AZjID9wbb3m6b0eGVvqpQUcVCBNBjDrnolh7
         bGhw==
X-Gm-Message-State: AAQBX9eHl5B4ZVq2e4ITP+Xz86u7q9cddPp15nxSgOXxDN3FaNw5Eszl
        YHODAy/aNlYB1NpreVVtDwLjHA==
X-Google-Smtp-Source: AKy350Zs3+ZoCTl+rhZsIgm6tXx8kKe2NrdWHP0thfF2vR+BQhZ9rfF3yh5QqWMXjVDm9AC9ly8HQw==
X-Received: by 2002:a17:906:c407:b0:931:a321:7640 with SMTP id u7-20020a170906c40700b00931a3217640mr273152ejz.74.1680628994738;
        Tue, 04 Apr 2023 10:23:14 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id bv20-20020a170906b1d400b009447277c2aasm6208333ejb.39.2023.04.04.10.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 10:23:14 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 38/40] nvmem: layouts: onie-tlv: Use module_nvmem_layout_driver()
Date:   Tue,  4 Apr 2023 18:21:46 +0100
Message-Id: <20230404172148.82422-39-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
References: <20230404172148.82422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

Stop open-coding the module init/exit functions. Use the
module_nvmem_layout_driver() instead.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/layouts/onie-tlv.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/nvmem/layouts/onie-tlv.c b/drivers/nvmem/layouts/onie-tlv.c
index d45b7301a69d..661093de33b4 100644
--- a/drivers/nvmem/layouts/onie-tlv.c
+++ b/drivers/nvmem/layouts/onie-tlv.c
@@ -237,19 +237,7 @@ static struct nvmem_layout onie_tlv_layout = {
 	.of_match_table = onie_tlv_of_match_table,
 	.add_cells = onie_tlv_parse_table,
 };
-
-static int __init onie_tlv_init(void)
-{
-	return nvmem_layout_register(&onie_tlv_layout);
-}
-
-static void __exit onie_tlv_exit(void)
-{
-	nvmem_layout_unregister(&onie_tlv_layout);
-}
-
-module_init(onie_tlv_init);
-module_exit(onie_tlv_exit);
+module_nvmem_layout_driver(onie_tlv_layout);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Miquel Raynal <miquel.raynal@bootlin.com>");
-- 
2.25.1

