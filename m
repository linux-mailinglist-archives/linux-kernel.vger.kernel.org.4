Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E817130AD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 01:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjEZXwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 19:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjEZXwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 19:52:36 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CCD19D
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 16:52:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba2b9ecfadaso2808512276.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 16:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685145120; x=1687737120;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3gkL2ZysifCX6QuWFr+kemlXIPFMHwY6YLDYqUvek4g=;
        b=zzD3toTUDIquQRqQxVbpkGZCNhAGQJVkVodWmJyBF5PKTm6ASrqgwxniGFDtinz9zZ
         rboUSdqPDY+nHOBIzLtsP21/bNWzI9bLvYAmHorq/VHjS7xRK/yiS6CWXeIZjKevCtiA
         rjoHoRVpwUMcwyr4JSKijQTllPlzGJ1wgpeE1BfSABrAFhBfXGQCtSDxLUmcfIgmcwLe
         HXFGe62HDokUZj7jztEtEHeN4T9lgksA7NLqGeVeDc4sEP7PCe5unSRKAoiNSmfgzuvq
         G0Y8e6sSFKWowXQUAQnE1h1qByiWfWeICT8bks9Kp2ja+EyUU/p+iGMDlXHUBJVk5+JN
         HPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685145120; x=1687737120;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3gkL2ZysifCX6QuWFr+kemlXIPFMHwY6YLDYqUvek4g=;
        b=NF9KBnh/5dk03y5BNMlcw8U+fGtR66MLxeM3yoL2Sc1MhuRguhNmKzKCWFIs5+s6Vd
         D9qdkcdLZkOGYceU03eIGNchko8lUkUf+sapSWHJzaAgUgUtG4oTIOwl/s+Cmcm4P3QH
         HcXde2MjrzWLeUsl7dmGUfbS5v2qKSxmx819/7F4Xym6enoGV5E61OzBfNp6Z7DOp8PX
         95b7tmXCTl9tFhNpRM5h3YDb8QvyIHiKYMeA4JBhgUyAi/YGG03RsixI7Ct0ZLxHb9qZ
         rjtusUUC2cw2Yk8VucLpfKiMO7ttFkOhaSSNbwgLHyNz9SJrWf+QiENHXy0lDvH0JsJE
         glAg==
X-Gm-Message-State: AC+VfDxtgjCrMMqyKsLJ7Y7jiCRm0sQRqGuN8v9eTSCZuWcItSowFFRG
        zSneQbniBQStkIM5anjH+aQEEgXBwBT4qw==
X-Google-Smtp-Source: ACHHUZ5j0DjM8sq5pG0MJ56RrsWclxTU1KJd7CMJmIXPcL0xUwk9eY/XbzgabbsKPXKeyfU+QWGDnMxOSK626w==
X-Received: from pranav-first.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:390b])
 (user=pranavpp job=sendgmr) by 2002:a25:4582:0:b0:ba8:91c2:268a with SMTP id
 s124-20020a254582000000b00ba891c2268amr1885823yba.0.1685145120249; Fri, 26
 May 2023 16:52:00 -0700 (PDT)
Date:   Fri, 26 May 2023 23:51:55 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230526235155.433243-1-pranavpp@google.com>
Subject: [PATCH v2] scsi: pm80xx: Add fatal error checks
From:   Pranav Prasad <pranavpp@google.com>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changyuan Lyu <changyuanl@google.com>,
        Pranav Prasad <pranavpp@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changyuan Lyu <changyuanl@google.com>

This patch adds a fatal error check for the pm8001_phy_control()
and pm8001_lu_reset() functions.

Changes compared to v1:
- Changed the patch series to a single patch.
- Added empty "/*" line to the comments as requested
  by Damien Le Moal.
- Aligned function arguments in pm8001_dbg() as
  requested by Damien Le Moal.

Signed-off-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Pranav Prasad <pranavpp@google.com>
---
 drivers/scsi/pm8001/pm8001_sas.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index e5673c774f66..a5a31dfa4512 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -167,6 +167,17 @@ int pm8001_phy_control(struct asd_sas_phy *sas_phy, enum phy_func func,
 	pm8001_ha = sas_phy->ha->lldd_ha;
 	phy = &pm8001_ha->phy[phy_id];
 	pm8001_ha->phy[phy_id].enable_completion = &completion;
+
+	if (PM8001_CHIP_DISP->fatal_errors(pm8001_ha)) {
+		/*
+		 * If the controller is in fatal error state,
+		 * we will not get a response from the controller
+		 */
+		pm8001_dbg(pm8001_ha, FAIL,
+			   "Phy control failed due to fatal errors\n");
+		return -EFAULT;
+	}
+
 	switch (func) {
 	case PHY_FUNC_SET_LINK_RATE:
 		rates = funcdata;
@@ -908,6 +919,17 @@ int pm8001_lu_reset(struct domain_device *dev, u8 *lun)
 	struct pm8001_device *pm8001_dev = dev->lldd_dev;
 	struct pm8001_hba_info *pm8001_ha = pm8001_find_ha_by_dev(dev);
 	DECLARE_COMPLETION_ONSTACK(completion_setstate);
+
+	if (PM8001_CHIP_DISP->fatal_errors(pm8001_ha)) {
+		/*
+		 * If the controller is in fatal error state,
+		 * we will not get a response from the controller
+		 */
+		pm8001_dbg(pm8001_ha, FAIL,
+			   "LUN reset failed due to fatal errors\n");
+		return rc;
+	}
+
 	if (dev_is_sata(dev)) {
 		struct sas_phy *phy = sas_get_local_phy(dev);
 		sas_execute_internal_abort_dev(dev, 0, NULL);
-- 
2.40.1.698.g37aff9b760-goog

