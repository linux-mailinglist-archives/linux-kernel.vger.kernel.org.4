Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A17663FBA6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 00:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiLAXJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 18:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiLAXJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:09:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FCEBDCD7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 15:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669936126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WPrzspswmnM04Pzvw/sX2KvWfaVbj7fPyU5av4wS70Y=;
        b=XMEsDOCZIQA4RKU2NMAAH054LBClzG5ATdwZsvmve2PeLODw15gX8/DMpv6pEu9Rg2wwR/
        oPPdA4CTTuTP83Qx8v7ezziYakiQNKiUOaYsVnVRX0/zpzMRrrZKv80m9GLtgRcJsM8NpH
        M6SMF6FThyX58Bxmmedb+alVv4TjWSE=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-303-QkiUJZ20O668WnMewDC_Aw-1; Thu, 01 Dec 2022 18:08:45 -0500
X-MC-Unique: QkiUJZ20O668WnMewDC_Aw-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-13bf576ffa6so1494811fac.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 15:08:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPrzspswmnM04Pzvw/sX2KvWfaVbj7fPyU5av4wS70Y=;
        b=YPJodtHJaX1e9pSdBxrZFP6ZcAuzy97dUCYHYIgMCaa1SZKmJNWa3g9+jP5jjtEaOo
         XgihW4gNr9Enw151xmQyQ90y2pg2yqtkVDIs+j1naDIRIi3V/kepZtSbP+eGSQtAkLGG
         LGEhCHir++74RHBe51M73J9z6nvVk03nw58GIjgVRAOOtXvu53kyG3Oxa3oMb6HF4Kdf
         Ai9d/gkazH8zbwEv2ylh6f7uIAKlrVOxp3sWZ0YEE+C706+FOXKAN8kA6mL5ja//K8VS
         YHkkv20nrKTLyNEuT3bnDLpnwik6eYsvAQ0SD+AayVaIzyFbNKJyO8kU5yF8ciOR+Yba
         PYfQ==
X-Gm-Message-State: ANoB5pnGsFoq0A5IHIDVgHNbJkN911HbZg7zxOpE4UZHScFKrEjvk8ZO
        jnmwEFSMihU/AqMti6hj0pJMTYIohsTkY7s7Qd/4dbP1VkOiz/KFD5ky23ex9ySJ3cSds037frt
        uc5gUqvzM5O5H6j7xIfHvHHdv
X-Received: by 2002:a4a:960d:0:b0:49f:e673:83e with SMTP id q13-20020a4a960d000000b0049fe673083emr23060992ooi.11.1669936124505;
        Thu, 01 Dec 2022 15:08:44 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5YlOgKdDN8wHAmpjNDhFeopPIS0YT5zwTbSpx4fpb8bL8HSsnIOoDDopUdZlbaSXKTV+oKew==
X-Received: by 2002:a4a:960d:0:b0:49f:e673:83e with SMTP id q13-20020a4a960d000000b0049fe673083emr23060981ooi.11.1669936124291;
        Thu, 01 Dec 2022 15:08:44 -0800 (PST)
Received: from halaney-x13s.redhat.com ([2600:1700:1ff0:d0e0::41])
        by smtp.gmail.com with ESMTPSA id y22-20020a4ade16000000b0049fb2a96de4sm2320393oot.0.2022.12.01.15.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 15:08:43 -0800 (PST)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     andersson@kernel.org
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, manivannan.sadhasivam@linaro.org,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH 1/4] scsi: ufs: ufs-qcom: Drop unnecessary NULL checks
Date:   Thu,  1 Dec 2022 17:08:07 -0600
Message-Id: <20221201230810.1019834-2-ahalaney@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221201230810.1019834-1-ahalaney@redhat.com>
References: <20221201230810.1019834-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
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

This code path is only called through one function, and the hba
struct is already accessed in ufshcd_vops_dbg_register_dump() prior to
calling so there is no way for it to be NULL.

Likewise, the print_fn callback is always supplied within this driver
and is always provided.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/ufs/host/ufs-qcom.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 8ad1415e10b6..70e25f9f8ca8 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1202,15 +1202,6 @@ static void ufs_qcom_print_hw_debug_reg_all(struct ufs_hba *hba,
 	u32 reg;
 	struct ufs_qcom_host *host;
 
-	if (unlikely(!hba)) {
-		pr_err("%s: hba is NULL\n", __func__);
-		return;
-	}
-	if (unlikely(!print_fn)) {
-		dev_err(hba->dev, "%s: print_fn is NULL\n", __func__);
-		return;
-	}
-
 	host = ufshcd_get_variant(hba);
 	if (!(host->dbg_print_en & UFS_QCOM_DBG_PRINT_REGS_EN))
 		return;
-- 
2.38.1

