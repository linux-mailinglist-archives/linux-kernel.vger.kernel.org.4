Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB1F70E794
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238480AbjEWVl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238575AbjEWVls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:41:48 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFCC12B
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:41:47 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-53f06f7cc74so184678a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 14:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684878106; x=1687470106;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p0y4TtuUdT60W21aKygGNQwI4gipZiKpcs4SNuMEkSY=;
        b=ssXbTfLiWJHzNKyW9cRLv4qJz0+wozWiG0m+T7u/6ikFqQa5Y1voVgqWwarbUqIA4B
         QOGC04YUxTx/kg90d6Y65h2gFL9dQ/u9STNqIgjXo8DmBHwII50n3e3q0pHw3cuN9t2A
         HYS7AzQLooXf0NDESkkjAvVK0LVfnduzvb2mGkfN17NuhdhrAOMHoIkw0ygPw2Xy0ill
         kZgs7ZSv+m2jod/FW+qOuDrpSIzv3CyPqc6/cKJsmeTeaDtRvoU0H2X9ooys5QbLADPK
         G0ycwST00lBJntyLG1Vk1zR6xO+8MY05IJFbFiSmfbk0OqQeS5vSRghj1LBju+M8ek0I
         SmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684878106; x=1687470106;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p0y4TtuUdT60W21aKygGNQwI4gipZiKpcs4SNuMEkSY=;
        b=Z7YQniEk0K2EoLk8lzv/4rrZ8r2StiZRQ/0MqGYDUNISe7S1F08dXEL/QQUZX2Kz8Q
         aUBGLkV07+SHvUiH0+UFSCxM/rHwOxphW+c4t82Wp5+9f7U4aiBTe6/i/Qi8Ajpu+Xmx
         yuy+RsLfkQTHE/ZU+gRdt9FASt6pVi1gsheQSXMtOuWHi8uWRksEO9OtEAlEIOl+P46N
         DOuOowr2Jliuj7BRuN0NX002STcfRu8JQOiM2mrPj6nCG0q0K6673aMo2x/4Swpzw9vy
         FwdI1ND67ck2ZK0aQbbwxOZDn/hdJA4f9HISm8OuLrTxSd/OCGz/ys4bAIryGWI/UNoD
         WHDQ==
X-Gm-Message-State: AC+VfDwV/watvtbh55CPxOIOoASUK0F2JNIXMZxluBQZTdMjuGAA1ofY
        MLvh0Ty0DRJ7FzgdtR5UNcBCAO3PCtsyMw==
X-Google-Smtp-Source: ACHHUZ5WbWCRwFFb7/v5db2npTTTZeheQ9Ywyi+pn2dnNcfvDn7hCXLkYgl5gQEaWlkCabgD3PZgzaIkuZyHrQ==
X-Received: from pranav-first.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:390b])
 (user=pranavpp job=sendgmr) by 2002:a63:111a:0:b0:530:236e:1bfe with SMTP id
 g26-20020a63111a000000b00530236e1bfemr4372514pgl.1.1684878106282; Tue, 23 May
 2023 14:41:46 -0700 (PDT)
Date:   Tue, 23 May 2023 21:41:27 +0000
In-Reply-To: <20230523214127.4006891-1-pranavpp@google.com>
Mime-Version: 1.0
References: <20230523214127.4006891-1-pranavpp@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230523214127.4006891-3-pranavpp@google.com>
Subject: [PATCH 2/2] scsi: pm80xx: Add fatal error check for pm8001_lu_reset()
From:   Pranav Prasad <pranavpp@google.com>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Pylypiv <ipylypiv@google.com>,
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

From: Igor Pylypiv <ipylypiv@google.com>

This patch adds a fatal error check for pm8001_lu_reset().

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
Signed-off-by: Pranav Prasad <pranavpp@google.com>
---
 drivers/scsi/pm8001/pm8001_sas.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index b153f0966e5d..e302d5879bb7 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -918,6 +918,16 @@ int pm8001_lu_reset(struct domain_device *dev, u8 *lun)
 	struct pm8001_device *pm8001_dev = dev->lldd_dev;
 	struct pm8001_hba_info *pm8001_ha = pm8001_find_ha_by_dev(dev);
 	DECLARE_COMPLETION_ONSTACK(completion_setstate);
+
+	if (PM8001_CHIP_DISP->fatal_errors(pm8001_ha)) {
+		/* If the controller is in fatal error state,
+		 * we will not get a response from the controller
+		 */
+		pm8001_dbg(pm8001_ha, FAIL,
+				"LUN reset failed due to fatal errors\n");
+		return rc;
+	}
+
 	if (dev_is_sata(dev)) {
 		struct sas_phy *phy = sas_get_local_phy(dev);
 		sas_execute_internal_abort_dev(dev, 0, NULL);
-- 
2.40.1.698.g37aff9b760-goog

