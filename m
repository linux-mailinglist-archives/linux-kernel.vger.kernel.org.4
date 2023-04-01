Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D466D334D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 20:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjDAS7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 14:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjDAS7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 14:59:01 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742F4A5E6
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 11:58:58 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n19so14806407wms.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 11:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680375536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sko9Z5CnVDma/o7PSvt8vNVEBnsuPXKJXiQ9VWjweDc=;
        b=NLvQkRTIvi0BY2paFYr/cb0nN5C4Hq4FHkgox+BcEX5BE6ulPDArqjTZwJw1uH+EUQ
         4ZZRLX1+eVmtH6VsvtAM+G0Nfmj6DK8lNXpZ/vmVTUXcCQ7XSJFK+3iEZrPwUmOF6Kn2
         69uFj7kOFc4SDieuz9orYB7JBmTU1mnuMltxqiN0BL5WH7LfNshWAj8Ucn5XsdEDQ3u/
         bmypvt4dnfyxsDB0dajr8+klLKZ4b/APwLirHoxFKNPgbiCYmqvQs/Q0XZGxl438xq8o
         hG0sZuU3p4NOa/vkBoHx2Y5iIuHDBnyg08jlNgY1zb32gL6jKr2c/232QwSU7Kun8Lxd
         JUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680375536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sko9Z5CnVDma/o7PSvt8vNVEBnsuPXKJXiQ9VWjweDc=;
        b=oDNX5tjEC2ZiB+HyovSr408PVP0F7CbPwsaZKzNxEm4qYtAc6+o+6GWw+aiFbhw1ly
         0afdZ9k2o4MiUwVu7fijrnu0GOYFO6x6BsGYrQziPRhR1NNjC+uaCUqfPmWvwtSKWycK
         NGWKilwvObaS3UaurjED1U6S+IP1W1sbdSVROcfgsJqVvZNCenNhEedMQYSaoL8uiaxT
         /OUFU9I+3w/6bDqIaBdYhAs2cwTaGIrwJVpmECSEjpwCSJwSDhV/KatlPbIyhIJDb4G0
         ffHbAG5EMNRNeCWaBgks0C9tRdKDRmt4VM4vXeFqXfMHNXjlD/+aeZTDgr0qUjvknmVN
         Z2RQ==
X-Gm-Message-State: AO0yUKUhcOiJ7bWL9aoNAjINpzPqY9esK0MkxQjdMQCenY1AQMYPIkmC
        ExUjJXgPdyDNA4Xbn5Z3flo=
X-Google-Smtp-Source: AK7set/FOCm+hbdY9aVJM9ptQ8ar3Evveg+ODJLWNaFs8tEXCEifUW1cE95um8PkVTjP5lnwjfl6/A==
X-Received: by 2002:a1c:4c09:0:b0:3eb:1432:a78c with SMTP id z9-20020a1c4c09000000b003eb1432a78cmr23207658wmf.37.1680375536436;
        Sat, 01 Apr 2023 11:58:56 -0700 (PDT)
Received: from khadija-virtual-machine.localdomain ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id s17-20020a05600c45d100b003ed51cdb94csm14017463wmo.26.2023.04.01.11.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 11:58:56 -0700 (PDT)
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Deepak R Varma <drv@mailo.com>
Subject: [PATCH 5/5] staging: rtl8192e: avoid camel-case <dot11RSNAStatsCCMPDecryptErrors>
Date:   Sat,  1 Apr 2023 23:58:44 +0500
Message-Id: <f14ec250bbdc617936197c05d013b2829e4aa658.1680375200.git.kamrankhadijadj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1680375200.git.kamrankhadijadj@gmail.com>
References: <cover.1680375200.git.kamrankhadijadj@gmail.com>
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

Linux kernel coding-style suggests to not use mixed-case names. Fix
checkpatch issue by changing the variable name from camel-case to
lower-case.

Suggested-by: Deepak R Varma <drv@mailo.com>
Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
index 1783a2eaae66..3eb79bad4496 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
@@ -37,7 +37,7 @@ struct rtllib_ccmp_data {
 	/* .11 RSNA stats for CCMP */
 	u32 ccmp_format_errors;
 	u32 ccmp_replays;
-	u32 dot11RSNAStatsCCMPDecryptErrors;
+	u32 ccmp_decrypt_errors;
 
 	int key_idx;
 
@@ -297,7 +297,7 @@ static int rtllib_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 				pr_debug("CCMP: decrypt failed: STA= %pM\n",
 					 hdr->addr2);
 			}
-			key->dot11RSNAStatsCCMPDecryptErrors++;
+			key->ccmp_decrypt_errors++;
 			return -5;
 		}
 
@@ -377,7 +377,7 @@ static void rtllib_ccmp_print_stats(struct seq_file *m, void *priv)
 		   ccmp->tx_pn, ccmp->rx_pn,
 		   ccmp->ccmp_format_errors,
 		   ccmp->ccmp_replays,
-		   ccmp->dot11RSNAStatsCCMPDecryptErrors);
+		   ccmp->ccmp_decrypt_errors);
 }
 
 static struct lib80211_crypto_ops rtllib_crypt_ccmp = {
-- 
2.34.1

