Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E6D716FCB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbjE3VdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjE3VdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:33:05 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE767C7;
        Tue, 30 May 2023 14:33:03 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-96fd3a658eeso718620566b.1;
        Tue, 30 May 2023 14:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685482382; x=1688074382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p4thltDnvTnlkXvabi6DDHwtW6w1tP1Qc9yaZzyE2MQ=;
        b=U8KP4kB/s7nu+wU162TLn0eIBYFn/6Jk1IGiotrCuctoVw3pToCkDkzwQLIbuNbxBa
         lSz460Y7M9tIr4/aGlZX/eChDnU+qXgOTZjHq+fsLHZdHJhqQPdiHpKKSpcJzba8hkep
         i8c/pvQMP8AatGGBDBgc1Ge3SAMDMdvy+Th5/yGu3OUHvJ+Auwm6LVNlAm0p3Wbvye9Y
         10JOp27Jx2wQ9BVYttdCoxoVEAu1QG4q3hBCg+6k7VIOY2QUkb4EofO6v9Ma2cH0caTE
         K7oHz7zpCjELKHhjqjnM+GEaCXPQ1Y3v6rRCRWeVNPOPDQXVl7LGXAbY6NXTFgcDBB2f
         Ce2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685482382; x=1688074382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4thltDnvTnlkXvabi6DDHwtW6w1tP1Qc9yaZzyE2MQ=;
        b=BiVvqjKetaxNPmS0/bawaBwxYYaDWZdnmnZGdCyVJNnASrqv4yt95wyU5YKI/GXMuu
         UGD1ghKfo5pmJOK8mFd6PIHWFGf0s0230awnDnstIOZZYpxUtTXs8tjytkjGpE0XIi0e
         cDRoNeH8UjAOF5i0i7bp9xziYuTJNL9i6UDyIs8Kl2XjfCGv2MWSUEo4tt9QuFoBLUuW
         XO4iZv5uMk5ftDhZEtTsPsRgrGFwtZaPs7OF6I1qTGEb/nNNyS4rCRFg1ZBpaW2YvBuE
         c1o4tLTp4p60euYTCFbB8+iJirjln4NOKmjfxbNSoUtLG+HKikeXtRx4XVDkvZ2Nul6H
         ydCw==
X-Gm-Message-State: AC+VfDxeATk7910ogVVJS9W7d7Z/8cQHfDnGr2IkXIvAXWEtPayWuDKL
        YiRB2jUMQIdadlTM65EEbYJgOOuw6/vp7w==
X-Google-Smtp-Source: ACHHUZ7IUr+LIWtnWyG1qV8KGuO3RCzBQYbVYmk5lq+PPP9SwjJVQKChp5O+fM5V4K8Iy5ujZnsXaA==
X-Received: by 2002:a17:907:72cc:b0:96f:baa4:cda7 with SMTP id du12-20020a17090772cc00b0096fbaa4cda7mr3341540ejc.68.1685482382070;
        Tue, 30 May 2023 14:33:02 -0700 (PDT)
Received: from fedora.. (dh207-97-232.xnet.hr. [88.207.97.232])
        by smtp.googlemail.com with ESMTPSA id oq27-20020a170906cc9b00b009662c57b4ffsm7882319ejb.96.2023.05.30.14.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 14:33:01 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     ulf.hansson@linaro.org, windhl@126.com, avri.altman@wdc.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH] mmc: core: disable TRIM on Micron MTFC4GACAJCN-1M
Date:   Tue, 30 May 2023 23:32:59 +0200
Message-Id: <20230530213259.1776512-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.40.1
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

It seems that Micron MTFC4GACAJCN-1M despite advertising TRIM support does
not work when the core is trying to use REQ_OP_WRITE_ZEROES.

We are seeing the following errors in OpenWrt under 6.1 on Qnap Qhora 301W
that we did not previously have and tracked it down to REQ_OP_WRITE_ZEROES:
[   18.085950] I/O error, dev loop0, sector 596 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 2

Disabling TRIM makes the error go away, so lets add a quirk for this eMMC
to disable TRIM.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/mmc/core/quirks.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index 29b9497936df..77caa0c903f8 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -100,6 +100,13 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
 	MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
 		  MMC_QUIRK_TRIM_BROKEN),
 
+	/*
+	 * Micron MTFC4GACAJCN-1M advertises TRIM but it does not seems to
+	 * support being used to offload WRITE_ZEROES.
+	 */
+	MMC_FIXUP("Q2J54A", CID_MANFID_MICRON, 0x014e, add_quirk_mmc,
+		  MMC_QUIRK_TRIM_BROKEN),
+
 	/*
 	 * Some SD cards reports discard support while they don't
 	 */
-- 
2.40.1

