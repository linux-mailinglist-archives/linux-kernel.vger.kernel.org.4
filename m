Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E426DCE0D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 01:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjDJX1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 19:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjDJX1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 19:27:36 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388901FD7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 16:27:32 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id g74-20020a9d12d0000000b006a131458abfso1549882otg.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 16:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681169251; x=1683761251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hHSsnVLxNGJM3Ez93hi8dq4uDehdSbUPmnwM+uX5lMI=;
        b=J8fEaJhwJxGf+T/XGUMV3iPv600mkm/Oep3x0jSDlRobJLBDBBrgRh/qZW6U2wYs+e
         0Vsnl+5W3hfZKMfCxB4NtvnO9cmpFBxQd4Gk+ntlo31/yH3sh6bhxkdmAVp7A0pNDQTP
         f2TO7RvvgtUt3SyHedQa8Ejlo9V9SxTeM7jcvBvs8GXHoFaWuBVmObXmdrOh5lqdGfiq
         mweCu9hU8iDPYgj+fwiWpI6Fjbz5srnRxWboH7g6kvl3dMQC3ukLjAVnnOscyG02DSPF
         34rU4IDTNtagTsL3TmlDmlvWuQ9OBqTCoysSucgTq/kj/hsEHdSx+ADnLKRRnBB6l3Za
         DPpQ==
X-Gm-Message-State: AAQBX9d8TQC643E+zyEWDBFrTYUqE02XllA4C7S4MzkDxFiC7aPw8RNT
        MR2Kph8CMbc+L0wB4zPp3A==
X-Google-Smtp-Source: AKy350Z1yILcQOoNNAMkNcstW3sSatfTIbbHAlTtJ4fh8jkmcLnqPgVjO+Ny9STtH0cSx3h7UopeAQ==
X-Received: by 2002:a9d:7514:0:b0:6a2:fbe9:9db4 with SMTP id r20-20020a9d7514000000b006a2fbe99db4mr5352515otk.4.1681169251406;
        Mon, 10 Apr 2023 16:27:31 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r20-20020a9d7cd4000000b0069fb87285fdsm4772777otn.59.2023.04.10.16.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 16:27:31 -0700 (PDT)
Received: (nullmailer pid 1562198 invoked by uid 1000);
        Mon, 10 Apr 2023 23:27:30 -0000
From:   Rob Herring <robh@kernel.org>
To:     Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] bus: vexpress-config: Add explicit of_platform.h include
Date:   Mon, 10 Apr 2023 18:27:26 -0500
Message-Id: <20230410232727.1562115-1-robh@kernel.org>
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

vexpress-config uses of_platform_* functions which are declared in
of_platform.h. of_platform.h gets implicitly included by of_device.h,
but that is going to be removed soon. Nothing else depends on
of_device.h so it can be dropped.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/bus/vexpress-config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/vexpress-config.c b/drivers/bus/vexpress-config.c
index a58ac0c8e282..472a570bd53a 100644
--- a/drivers/bus/vexpress-config.c
+++ b/drivers/bus/vexpress-config.c
@@ -10,7 +10,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
-#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/sched/signal.h>
 #include <linux/slab.h>
 #include <linux/vexpress.h>
-- 
2.39.2

