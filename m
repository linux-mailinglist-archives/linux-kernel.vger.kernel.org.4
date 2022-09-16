Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7F55BA593
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 05:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiIPD7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 23:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiIPD7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 23:59:35 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442DBC78;
        Thu, 15 Sep 2022 20:59:28 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1280590722dso50464817fac.1;
        Thu, 15 Sep 2022 20:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=1Q4Q9Drjvqq1OzQpeLiPQrhsLdnCghR5eiThiTgj0LA=;
        b=OFqboWUmjs/WYzHvErueQTrw09F5eFZuMDajiKvEPpDG8FZ35D/lr5vkWi/vYVRsKM
         9GK3qIPVvi/B/kkUS+StxyQoxTASuOVhbs5ZsY1qN95e6xaqJOQA9wmZQCx79PMdsh7P
         kSu1ior1aFxXjTZ6QQOuuK5VWmmt+l+s5M6oh20B26X/Iyo+hqiXY9HMSU2YOVXooHVw
         gL3r5EAUMxdLCp3DM0Mt8cai0AP9iLixRUb8x25GsTt5oIo/CbXwWbokBh6+s2RpnYVD
         wIs1WeMCAOTIH1ceVgGOmON/Z8iPjuIgUBm8RcbJXQiMnkbd41NASg/lIitHAnYAHL0x
         BaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=1Q4Q9Drjvqq1OzQpeLiPQrhsLdnCghR5eiThiTgj0LA=;
        b=weSClYkUfSUGlpR4lLxMI5rrH0PWJI27FVACxluArgw6i6iS+DGRaSyQsQYwSGnvuk
         QjmySDivrpg36MunyZ2f2bRNxZxAA/N79FYlnoZk++Ig6sBAywo8y2oGrl1twLwiP44S
         EnV45cJyctDEOsSEV43UHZHvuniCVjwXtQ8pSb+VQgafcUYbrdkOKs0Kd5ylXQA3hs28
         vqXvIzvFXB8Fupf9t9EOHcbfEnJLOT3lOKpiVv7Hlde4y8irPvRU1OV9MS2TtJTeiVCg
         rqyfIYMyT5ZhWiA3uAwEPrV0QLvm14NQz2fSwM9eyXHpWhS9B4gAqQouoPjCOq5pLdgH
         PQ8g==
X-Gm-Message-State: ACgBeo2ArmYCWC4sGsh8zGxTQi1Outd9cbyZJfh1fZ4kTMv0rbqbU1dl
        257rAcRJQEp8A3/JBxRW4/0=
X-Google-Smtp-Source: AA6agR7xj+5OeYbULd3eX6Qwve+ZgXBIf/zRlJXE/JNQe/Hop8uxIj6QG+rIq/IIlJy0a9W+hUU1KQ==
X-Received: by 2002:a05:6870:3116:b0:11d:342a:4419 with SMTP id v22-20020a056870311600b0011d342a4419mr7100187oaa.251.1663300767511;
        Thu, 15 Sep 2022 20:59:27 -0700 (PDT)
Received: from macondo.. ([2804:431:e7cd:8cb3:f8d3:a3e1:53c:3ab3])
        by smtp.gmail.com with ESMTPSA id m189-20020aca58c6000000b003450abf4404sm8566200oib.21.2022.09.15.20.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 20:59:27 -0700 (PDT)
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Gaurav Srivastava <gaurav.srivastava@broadcom.com>,
        Hannes Reinecke <hare@suse.de>,
        Muneendra Kumar <muneendra.kumar@broadcom.com>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        James Smart <jsmart2021@gmail.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: lpfc: Fix memory leak in lpfc_create_port()
Date:   Fri, 16 Sep 2022 00:59:07 -0300
Message-Id: <20220916035908.712799-1-rafaelmendsr@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

Commit 5e633302ace1 ("scsi: lpfc: vmid: Add support for VMID in mailbox
command") introduced allocations for the VMID resources in
lpfc_create_port() after the call to scsi_host_alloc(). Upon failure on the
VMID allocations, the new code would branch to the 'out' label, which
returns NULL without unwinding anything, thus skipping the call to
scsi_host_put().

Fix the problem by creating a separate label 'out_free_vmid' to unwind the
VMID resources and make the 'out_put_shost' label call only
scsi_host_put(), as was done before the introduction of allocations for
VMID.

Fixes: 5e633302ace1 ("scsi: lpfc: vmid: Add support for VMID in mailbox command")
Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
---
 drivers/scsi/lpfc/lpfc_init.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 55a1ad6eed03..6f572f0c5c45 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -4819,7 +4819,7 @@ lpfc_create_port(struct lpfc_hba *phba, int instance, struct device *dev)
 	rc = lpfc_vmid_res_alloc(phba, vport);
 
 	if (rc)
-		goto out;
+		goto out_put_shost;
 
 	/* Initialize all internally managed lists. */
 	INIT_LIST_HEAD(&vport->fc_nodes);
@@ -4837,16 +4837,17 @@ lpfc_create_port(struct lpfc_hba *phba, int instance, struct device *dev)
 
 	error = scsi_add_host_with_dma(shost, dev, &phba->pcidev->dev);
 	if (error)
-		goto out_put_shost;
+		goto out_free_vmid;
 
 	spin_lock_irq(&phba->port_list_lock);
 	list_add_tail(&vport->listentry, &phba->port_list);
 	spin_unlock_irq(&phba->port_list_lock);
 	return vport;
 
-out_put_shost:
+out_free_vmid:
 	kfree(vport->vmid);
 	bitmap_free(vport->vmid_priority_range);
+out_put_shost:
 	scsi_host_put(shost);
 out:
 	return NULL;
-- 
2.34.1

