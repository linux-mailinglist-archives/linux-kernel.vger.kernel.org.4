Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2E56147E6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 11:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiKAKrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 06:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKAKrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 06:47:37 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84B3193C7;
        Tue,  1 Nov 2022 03:47:36 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so3448756wmg.2;
        Tue, 01 Nov 2022 03:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/FwRGP8BwKaXmW2k8HRZR6WmbigXa5hHO418FZc4xNY=;
        b=IYUBIIujNue24apx8G7zfTr2uVehnwGWmFGKSj8tMpOF+Ijp6Kdf9CHhtWytPZNtph
         oUfaVr7ehmUa/xfLoMVwaMttid8d2jzeGLFBo+sWcoEyLod4ByVcdLZsCiS+99SgNUXw
         K2M1pZvnlDDCFNfyR55CQs+Co6DK1hPAwFpbxhnxeCJsCo2a+/ChoYZJq/nWAVs4X7Cv
         fsHnMm6cKOnkecIVJQl32CFaFdBlote6ir8KIm3rHOHwvqqfUFN7dX8VMlaI+00pA1A0
         Kx4WC5aagh0tB6PPByiVvZeZHywxkKUGikLfoJ14Bx+vQeZ66MHwDp7Lh46KjZUbi+GF
         +Q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/FwRGP8BwKaXmW2k8HRZR6WmbigXa5hHO418FZc4xNY=;
        b=TLWer3gKsolbVbDTg4xikZX8+fOWC8xovJ5kuJ2xhSEqjGbGYYhhfcKvWwRzaDJFDm
         iC+J2sI/ZW8Ld03+uzjWoZXD9v+vJC/tmShVILBbgjCJ+xO8iTJx9Ky1EH5A9IjDfyFm
         /693EK3jty4nDLN9lNAlf0YezA1G/Cl1wKf/HonRh/9PLcLD9b8HyAMCmarwqyxwziy7
         Y6lyqk+VFnb8d4pBtOqZEqv/NR8q7BeLDnu5sHAJlpL/Ut+LNxYKnotB/NLjuB2/53L9
         bkZpH65ziYrD7JqhfPNdgoF7E1QK4O6m3LmPfntMWm0uZvN8IfgduS0LJu+oRtlNeEG7
         /EWQ==
X-Gm-Message-State: ACrzQf0ANDQm9mIiIAs4siwakd3XwP/pf6J1LIkhVlhfQTcYQw59o1HR
        RywEnmGEBHloRde8vC4buwDmIL0qDfIPu1UP
X-Google-Smtp-Source: AMsMyM5Vr5sdPnHnvs6v1i04Xc34hhFJ8JVAijUkr1z367YlFbXW/kgLoViWk7S/5mBU6BsCxGPBUQ==
X-Received: by 2002:a1c:6a10:0:b0:3cf:699f:c03 with SMTP id f16-20020a1c6a10000000b003cf699f0c03mr9621554wmc.23.1667299655129;
        Tue, 01 Nov 2022 03:47:35 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003cf4c1e211fsm10738270wmq.38.2022.11.01.03.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 03:47:34 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qla2xxx: Remove unused variable found_devs
Date:   Tue,  1 Nov 2022 10:47:33 +0000
Message-Id: <20221101104733.30363-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable found_devs is just being incremented and it's never used
anywhere else. The variable and the increment are redundant so
remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/scsi/qla2xxx/qla_init.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index e12db95de688..8f737d80bce4 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -5546,7 +5546,6 @@ static int
 qla2x00_configure_local_loop(scsi_qla_host_t *vha)
 {
 	int		rval, rval2;
-	int		found_devs;
 	int		found;
 	fc_port_t	*fcport, *new_fcport;
 	uint16_t	index;
@@ -5561,7 +5560,6 @@ qla2x00_configure_local_loop(scsi_qla_host_t *vha)
 	if (N2N_TOPO(ha))
 		return qla2x00_configure_n2n_loop(vha);
 
-	found_devs = 0;
 	new_fcport = NULL;
 	entries = MAX_FIBRE_DEVICES_LOOP;
 
@@ -5720,8 +5718,6 @@ qla2x00_configure_local_loop(scsi_qla_host_t *vha)
 
 		/* Base iIDMA settings on HBA port speed. */
 		fcport->fp_speed = ha->link_data_rate;
-
-		found_devs++;
 	}
 
 	list_for_each_entry(fcport, &vha->vp_fcports, list) {
-- 
2.37.3

