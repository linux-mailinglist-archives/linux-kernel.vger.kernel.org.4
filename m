Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5378B6D303B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 13:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjDALfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 07:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDALfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 07:35:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD65B769
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 04:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680348879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=J5VnVhbHSvcA014php78QLEnB2oArEoTP1K4/6SYEVc=;
        b=FIod4lsoWLuA/q6g8xZFr9/GDdRHoRHHR4Saxn+EZ2rax/BZEQCMOsIFq+HRCTgKLe1m3D
        719ih0kyXnHUz51ymfKbcgEAqD5lXdU0OYXi7B9NTb97dRwJqtJnvRGLxblYw5KOeStbey
        HvTAx/5hQyD3QA6Ee25/ZpI4dV4NQpY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-jsXLX_NDOYumHfS3T3ZTrA-1; Sat, 01 Apr 2023 07:34:36 -0400
X-MC-Unique: jsXLX_NDOYumHfS3T3ZTrA-1
Received: by mail-qk1-f198.google.com with SMTP id s2-20020a37a902000000b0074a28a891baso976445qke.18
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 04:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680348876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5VnVhbHSvcA014php78QLEnB2oArEoTP1K4/6SYEVc=;
        b=Dv0XRV/Bo8HH40AwXe1SnNNEmZwrkeIJl5ScRaV9m+v2X3aNqDw5HXJNokCJwFqxwb
         VK2gJ4K5fc9hL0jsi4749Q1Qn6sjAX/aIAv7Fqoln/XW+maLFVITOWCfxwyjbtTLQOEF
         lcK0SdAyhyCo2WkX7DN7AiqyiqW3eGzuAYuVW62vu0rSMk5Upmsmj9YeOeK2YrgCDwKg
         BX0/0xd91Co84wmac3d/jYOs1bQv58qM/I/xrdP3B8Q7fwZiMsHcQZtVlM6KyARGmZCn
         LsU3anRd8zU1uQ5l0u0w2984P77PKigWJSInZyI4v26BCRaCQQZKuDIogM93wTIuvDXb
         KuDA==
X-Gm-Message-State: AAQBX9fHVBMqLk1mBVCO7lHkfG+RznyjAp13NF8fHYTqTJTf8FDIAjcz
        rzcPDFSVDmQc8EV4QyfvpnobpyAlmB75zslboPjdnL6q4k+BpfqQDycBpS8Nn5MRZmJT3ypleWp
        45qGD9yey1ObDxQwd4WUV3S6B
X-Received: by 2002:a05:6214:501e:b0:584:8c13:3041 with SMTP id jo30-20020a056214501e00b005848c133041mr18549535qvb.24.1680348875819;
        Sat, 01 Apr 2023 04:34:35 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZH/PIz9aT1vkMeJPCy77zunA2Q4o1S573i0+gKG+HwMtgD6hdQufuIhPWM0rPxuQRAce5LcQ==
X-Received: by 2002:a05:6214:501e:b0:584:8c13:3041 with SMTP id jo30-20020a056214501e00b005848c133041mr18549509qvb.24.1680348875582;
        Sat, 01 Apr 2023 04:34:35 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id s11-20020ad4524b000000b005dd8b9345d8sm1230100qvq.112.2023.04.01.04.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 04:34:35 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     sre@kernel.org, nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] power: supply: twl4030-charger: remove unused cur_reg variable
Date:   Sat,  1 Apr 2023 07:34:32 -0400
Message-Id: <20230401113432.1873847-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/power/supply/twl4030_charger.c:242:16: error: variable
  'cur_reg' set but not used [-Werror,-Wunused-but-set-variable]
        unsigned reg, cur_reg;
                      ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/power/supply/twl4030_charger.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index 7adfd69fe649..5fa5b2311330 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -239,7 +239,7 @@ static int twl4030_charger_update_current(struct twl4030_bci *bci)
 {
 	int status;
 	int cur;
-	unsigned reg, cur_reg;
+	unsigned reg;
 	u8 bcictl1, oldreg, fullreg;
 	bool cgain = false;
 	u8 boot_bci;
@@ -357,11 +357,9 @@ static int twl4030_charger_update_current(struct twl4030_bci *bci)
 	status = twl4030_bci_read(TWL4030_BCIIREF1, &oldreg);
 	if (status < 0)
 		return status;
-	cur_reg = oldreg;
 	status = twl4030_bci_read(TWL4030_BCIIREF2, &oldreg);
 	if (status < 0)
 		return status;
-	cur_reg |= oldreg << 8;
 	if (reg != oldreg) {
 		/* disable write protection for one write access for
 		 * BCIIREF */
-- 
2.27.0

