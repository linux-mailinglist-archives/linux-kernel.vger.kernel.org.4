Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB106DCE09
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjDJX1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjDJX1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:27:24 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8972708;
        Mon, 10 Apr 2023 16:27:16 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id f10-20020a9d2c0a000000b006a13f728172so941538otb.3;
        Mon, 10 Apr 2023 16:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681169235; x=1683761235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NKaVcQvN0/PLVPRKHDLb7YdFl+fwutR6IA+DxQh0OwE=;
        b=G+2ZBrZaVLMuakAk15/FRZaXMJe+am0RtPJE0y3fDseHOkymSwqvh3XwixYcoT1rgg
         rZEIl8/TmEIdlI4PcKq1oFOsT8irRhCLKqjCm4ku6jb93G8M205Ga4dwBMWlnVfygm4H
         j5dYytMSU8oGFZIVMtvpQjvhlLUy4uRNMRQ5/saSNSVKasDGlwOVqWWrkqFWXJnKw7MX
         72qwd4lwKEZNrzPMlcQgy3Fd1auJCh3izk/pK/NGw2m7gVhv5LO3WOPHgbfWtqCr114v
         SCM+3zWYB8XvLPwpyxD81S7lUsZ0synqICNhFle7zrz7cL267qhgcHd/K+tL2Un7UVwQ
         9Hwg==
X-Gm-Message-State: AAQBX9fJMeBfoRLLlBbFOa0l8gGomktJdcW64sqOFt5PDpYpKE3YY2F4
        pmPk8t1IVGx8elrhnfoUMDp/SCPiug==
X-Google-Smtp-Source: AKy350bh7NSbygDO6L3xRoKM3TvOkMZwiy28bxmJ/3Ay8IGTX1ZFtizq6b1MYKVaHmLSmpH6SwPpUA==
X-Received: by 2002:a05:6830:154d:b0:698:7192:b51e with SMTP id l13-20020a056830154d00b006987192b51emr3769504otp.34.1681169235385;
        Mon, 10 Apr 2023 16:27:15 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z9-20020a0568301da900b006a249e69aebsm4858705oti.81.2023.04.10.16.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 16:27:15 -0700 (PDT)
Received: (nullmailer pid 1561860 invoked by uid 1000);
        Mon, 10 Apr 2023 23:27:14 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bcma: Add explicit of_device.h include
Date:   Mon, 10 Apr 2023 18:27:01 -0500
Message-Id: <20230410232701.1561613-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bcma/main.c uses of_dma_configure() which is declared in of_device.h.
of_device.h gets implicitly included by of_platform.h, but that is going
to be removed soon.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/bcma/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bcma/main.c b/drivers/bcma/main.c
index 7b39f010bbb3..136fd7e5358a 100644
--- a/drivers/bcma/main.c
+++ b/drivers/bcma/main.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/of_device.h>
 #include <linux/of_platform.h>
 
 MODULE_DESCRIPTION("Broadcom's specific AMBA driver");
-- 
2.39.2

