Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D705F8492
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 11:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiJHJPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 05:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJHJPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 05:15:51 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16F450526;
        Sat,  8 Oct 2022 02:15:50 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n7so6515810plp.1;
        Sat, 08 Oct 2022 02:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9QRuG6Uw2j9y9wt/YE1ELKRrBpnYSjy91D1kGeKSbxU=;
        b=f5IbGaEPqIwsAKicABoTcOEUuIvps29DIK//+bLUMriHWBywhTPTf/VbjmoQoaIRu4
         NA9wcATwghB0LNLb3cKBZbiwAVnna2RygvLJltHB8kePO1wvfQaGtF8J1TTFQLFXYYsh
         8F4LA7M+FvH/9IZg8LH4LwZCuGl01jDFymHnCGNbcJmcOf97YGTY4NxAB/arphlzF0q9
         n9mSW4M6tVTArTu4OX/7+Haw+8r8UjXevapZHFmBNst5Bxc4hcm+shyZc4q/uWcarClX
         BaDT8l5GzhgpszwwHRI/cUlqRrw2T0G41EKcomrhOAzbDtjYa1KTTIW9Fvxocxbtye/1
         JnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9QRuG6Uw2j9y9wt/YE1ELKRrBpnYSjy91D1kGeKSbxU=;
        b=eagIBEl+tT4t0x6box1I8s3fvw5vLg3vHwA+KFGjHOMnVL1+l+YiknP8ygWMjrEB0Z
         8wmHWxcwa7+JNyFA/S6HVxqrNTHJenDpZe3l+PMNcgE9hK8IYbAq51Cww5WtBuWGhVw0
         xagix4UuMmzptMqf4xU0RJQ2ibXuYd4CJ2oGha+H++ckTKan5+Qp/66LT6xlYMZfdPZo
         Qg52hnVwppc3mVfqKEKTecuQQM2Fk+1lqpEWYXmEh1GDlqeqnTSN1OLF9a0hg+mR0G4W
         jDKey5IbhaXVWMSb5hTAZjgnRrC6W40j02W64JVxNM1DWx3lDdb2A7Zei37mZgfHPyZD
         oriA==
X-Gm-Message-State: ACrzQf2Q0uPilWtXSDDxu5Koe6qNhRgsLBJC33CiZv9MlpjQkxoxw8lM
        XqgrVpnhoIA3xXO/GJ//pO4=
X-Google-Smtp-Source: AMsMyM7MbfLVOeXiYxHvfjvUhra8RY5xKrdFerhFcjQ4v/272v1aPmB0K8sx8bT/n+prkUJozaYTkw==
X-Received: by 2002:a17:902:d2cf:b0:17f:7b65:862f with SMTP id n15-20020a170902d2cf00b0017f7b65862fmr8672542plc.168.1665220550427;
        Sat, 08 Oct 2022 02:15:50 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902900b00b00179c99eb815sm2883600plp.33.2022.10.08.02.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 02:15:49 -0700 (PDT)
From:   yexingchen116@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     martin.petersen@oracle.com
Cc:     brking@us.ibm.com, jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>
Subject: [PATCH linux-next] scsi: ipr: replace !strcmp with sysfs_streq
Date:   Sat,  8 Oct 2022 09:15:43 +0000
Message-Id: <20221008091543.309401-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Replace the open-code with sysfs_streq().

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/scsi/ipr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 9d01a3e3c26a..f892ff74d56a 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -3685,7 +3685,7 @@ static ssize_t ipr_store_adapter_state(struct device *dev,
 
 	spin_lock_irqsave(ioa_cfg->host->host_lock, lock_flags);
 	if (ioa_cfg->hrrq[IPR_INIT_HRRQ].ioa_is_dead &&
-	    !strncmp(buf, "online", 6)) {
+	    sysfs_streq(buf, "online")) {
 		for (i = 0; i < ioa_cfg->hrrq_num; i++) {
 			spin_lock(&ioa_cfg->hrrq[i]._lock);
 			ioa_cfg->hrrq[i].ioa_is_dead = 0;
-- 
2.25.1

