Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC206FBCAA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 03:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbjEIBur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 21:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjEIBuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 21:50:39 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754109EF5
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 18:50:38 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-643557840e4so5697011b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 18:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683597038; x=1686189038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69dtD77xWGRukQB2MDn4hI1tJ2O9vxVlVuI3XoQDR04=;
        b=AwWm5gb76OB4SKaLAzgqBacTPLuC/BNCfvcmrLdYW+xfwFs/3tbHMiFvUgWDLiLBQC
         6S6pvbaHRT6niLxq62NVz0ePJwzK9L4U1REPXCdsZnFlKoXuo6BwjZRtmgAEaKxDum0Y
         4bGiCNs1iSz8kKfH/SnwBm5YfDtNxdb6G4EfOU5Z9qdTOxQX83bZ8p4yUB22wQqm0yUx
         /r0jUFlpXap7gQSkFZPXxiXVOJndefpIfsc5u0y3sOXJzZUVox75UD89oElys4PwVM+A
         P2Nw9EMNngpzMQl9IdR0OVNhIEmme0tTSvUBuyCVipW/f+ZWLDn/2BwMvaF0y28dMJUD
         u3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683597038; x=1686189038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=69dtD77xWGRukQB2MDn4hI1tJ2O9vxVlVuI3XoQDR04=;
        b=c1Ng89ckOhdr/t9RaYdo6ZnUpgpnMe2BXbUD0qJXvVEbN0/qRvaZBR1Eau73snIymD
         u+9IbQtRMoU6Xm93zFT8k/kFUoRJt/VXtkZ/X9ZIhmDJUzYSscbnEBmEqPOB50ctp0KF
         zt8dZWhryu2t0/q2pMTKR4Eu1YG6ICkmN0HAk3dDMfcJCTN/gYqy93BI09TPkqxoUwlM
         XTi/2P0bbL6BFRanfOQGhcdn66ispl/RnjDQYDt5QXc9OtMuKzUvm4dA14+GnSFzizfz
         JfqcJBBkUudjjbure9BENbPBuT+XpgAJqd4GClz3EqYwNiiBpxillX4SIhs9ejJLJvny
         KFHA==
X-Gm-Message-State: AC+VfDykZRvv3PfIM34TSU6N1IP4+CKF58uTxB3LYnJ/0QeU3YOA9VYr
        TMCJpxEglz8/SkHFU9Ax0KE=
X-Google-Smtp-Source: ACHHUZ4D2ELQZ7aT2FO+kepRe59bMVZMua7XlfOR08p7jt0bfVGDeU4sw0M5d8sj94oxN90Kzo6hFw==
X-Received: by 2002:a05:6a00:2d25:b0:643:6b94:374b with SMTP id fa37-20020a056a002d2500b006436b94374bmr18692731pfb.1.1683597037710;
        Mon, 08 May 2023 18:50:37 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id k13-20020aa792cd000000b0063f1430dd57sm597843pfa.49.2023.05.08.18.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 18:50:36 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 01/13] scsi: ncr53c8xx: Use default @max_active for hostdata->work_q
Date:   Mon,  8 May 2023 15:50:20 -1000
Message-Id: <20230509015032.3768622-2-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509015032.3768622-1-tj@kernel.org>
References: <20230509015032.3768622-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hostdata->work_q only hosts a single work item, hostdata->main_task, and
thus doesn't need explicit concurrency limit. Let's use the default
@max_active. This doesn't cost anything and clearly expresses that
@max_active doesn't matter.

Signed-off-by: Tejun Heo <tj@kernel.org>
Finn Thain <fthain@linux-m68k.org>
Michael Schmitz <schmitzmic@gmail.com>
"James E.J. Bottomley" <jejb@linux.ibm.com>
"Martin K. Petersen" <martin.petersen@oracle.com>
linux-scsi@vger.kernel.org
linux-kernel@vger.kernel.org
---
 drivers/scsi/NCR5380.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
index ca85bddb582b..cea3a79d538e 100644
--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -417,7 +417,7 @@ static int NCR5380_init(struct Scsi_Host *instance, int flags)
 	INIT_WORK(&hostdata->main_task, NCR5380_main);
 	hostdata->work_q = alloc_workqueue("ncr5380_%d",
 	                        WQ_UNBOUND | WQ_MEM_RECLAIM,
-	                        1, instance->host_no);
+				0, instance->host_no);
 	if (!hostdata->work_q)
 		return -ENOMEM;
 
-- 
2.40.1

