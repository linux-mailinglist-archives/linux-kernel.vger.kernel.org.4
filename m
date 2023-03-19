Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB236C034C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 17:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjCSQs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 12:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjCSQsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 12:48:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27DA1E9FA
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 09:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679244470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VkDP5nwJg3NiX0wmWxZjf2UT2F8zhLNQEpn1rGiXRWY=;
        b=NXp+ni3eseIbvksloR4gYCqBR3QMn4TIbn8Pgm92Sld3HE4YYKOlpv5VzEcfAa1ppC4g+D
        AVmBYO8zbRPbpjQ3ljg4WWhum/WWxyiOQAywjfvNRK2q0CoJOrg4zRKoyyze7Ru4G8zAk5
        De09GnYhTK7VMdzr1xiyh4SOgreSP5k=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-tfeX634YOBqEJmv6c7-c4w-1; Sun, 19 Mar 2023 12:47:48 -0400
X-MC-Unique: tfeX634YOBqEJmv6c7-c4w-1
Received: by mail-qk1-f200.google.com with SMTP id o63-20020a374142000000b007467ef381beso579912qka.16
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 09:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679244468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VkDP5nwJg3NiX0wmWxZjf2UT2F8zhLNQEpn1rGiXRWY=;
        b=YXlJkNPNMf2vkiWy/sq1EIjy1j2R82Dixg1/fiDIBoHil9D2C8SleXdFahZkuHCD/h
         KDurPvhNLbXjr3idFZFcNkfN9zPSmn9ypXs2/Kb6qHcp33zwJq2IWP7/3yl0f9aywRLD
         49ybgrMrrxMeoZzEJu2dEp8obrEKgICGJYjnQaCXlzcwi+rcL8QEjFAV0qkLgITLxP95
         ggPbVOSuBKJVayT3KMDARf7Xcq1habytTckRtwh87NglfjsFwCDozgmRh0nRcoeGm0dI
         7ryvm2+F2XsfWPbKQpwkV625voqdSIF8HyWgYTl4hYYd5q5/D22zcnGVmjuJrE4Dd5X7
         B2jQ==
X-Gm-Message-State: AO0yUKXfrhr2v6bxCmSS6c3CKba1/HahakmUwaYcU7D15Gp7sW0yzgJJ
        OSTeQudwBwze2iqzw/8UA0j2E+DZQLNEvBp6yLc0Nh3zQ9GDYHV8twL0UeKhnwPgM2YjgC4AKW2
        f+08pzBwV/8pG1tWd+SD2WSXs
X-Received: by 2002:ac8:5f83:0:b0:3bf:d71e:5af4 with SMTP id j3-20020ac85f83000000b003bfd71e5af4mr22398127qta.26.1679244468431;
        Sun, 19 Mar 2023 09:47:48 -0700 (PDT)
X-Google-Smtp-Source: AK7set81mKcQVWIpj0FlTITDASkQiikMe5/r0glEegQKpqPmrpVC5hxR63neRzk9SnibKH7bRsoSwg==
X-Received: by 2002:ac8:5f83:0:b0:3bf:d71e:5af4 with SMTP id j3-20020ac85f83000000b003bfd71e5af4mr22398109qta.26.1679244468205;
        Sun, 19 Mar 2023 09:47:48 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 124-20020a370482000000b0073b929d0371sm5734012qke.4.2023.03.19.09.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 09:47:47 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     saschasommer@freenet.de, ulf.hansson@linaro.org, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] mmc: sdricoh_cs: remove unused sdricoh_readw function
Date:   Sun, 19 Mar 2023 12:47:44 -0400
Message-Id: <20230319164744.1707169-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/mmc/host/sdricoh_cs.c:104:28: error: unused function
  'sdricoh_readw' [-Werror,-Wunused-function]
static inline unsigned int sdricoh_readw(struct sdricoh_host *host,
                           ^
This function is not used, so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/mmc/host/sdricoh_cs.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/mmc/host/sdricoh_cs.c b/drivers/mmc/host/sdricoh_cs.c
index 76a8cd3a186f..57b8c1a96756 100644
--- a/drivers/mmc/host/sdricoh_cs.c
+++ b/drivers/mmc/host/sdricoh_cs.c
@@ -101,14 +101,6 @@ static inline void sdricoh_writel(struct sdricoh_host *host, unsigned int reg,
 
 }
 
-static inline unsigned int sdricoh_readw(struct sdricoh_host *host,
-					 unsigned int reg)
-{
-	unsigned int value = readw(host->iobase + reg);
-	dev_vdbg(host->dev, "rb %x 0x%x\n", reg, value);
-	return value;
-}
-
 static inline void sdricoh_writew(struct sdricoh_host *host, unsigned int reg,
 					 unsigned short value)
 {
-- 
2.27.0

