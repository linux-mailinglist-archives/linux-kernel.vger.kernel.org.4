Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EE0661A8A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 23:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjAHWoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 17:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjAHWot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 17:44:49 -0500
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA577F036;
        Sun,  8 Jan 2023 14:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1673217671;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=gaLa1rSJhxlmjdIWXyAhwDAq4r+726KZF2WV60kFgUw=;
    b=fZY2SLl7U6f8IAx1H6o6cM6awDRvZZOvSh9gE8wDoNzM5D8zGYwervlmL8XKgiDxXI
    UkBcsVrmVvmLBOD303uyd537xPTnXWXVlG4K6DfeLiqvZ10nNiJZrYM5epRt2Y+1JObe
    swK5COZHXDKT7tWzgxXtTOMheoWHrqUygpDvSz0T0QEvY28/lOK3hA1Gn73+RP18C7f3
    +W3DSCMHo6dMaTlDVhF0WBQR7qW/6CG8bQ3cW2CFn6mLaicM1JVLvsjUtGpjtrsMrOwK
    bEmseA/N20T54Kb/MHsU7J6anrdLZUeRAjX1sAv6f4WkHgZ9cabYqs5cRenk0O2ogHvD
    S5ng==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1UnWvo/SqbTSXcQZxAZvLxWc5msS6txu0oUh"
X-RZG-CLASS-ID: mo02
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id 905423z08MfAAeA
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 8 Jan 2023 23:41:10 +0100 (CET)
From:   Bean Huo <beanhuo@iokpp.de>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com, bvanassche@acm.org,
        quic_cang@quicinc.com, quic_xiaosenh@quicinc.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] scsi: core: Fix invisible definition compilation warning
Date:   Sun,  8 Jan 2023 23:40:56 +0100
Message-Id: <20230108224057.354438-3-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230108224057.354438-1-beanhuo@iokpp.de>
References: <20230108224057.354438-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

In 'include/ufs/ufshcd.h' file, 'enum dma_data_direction' will be used,
which is defined in linux/dma-direction.h, however, this header file is
not included in ufshcd.h, thus causing the following compilation warning:

"warning: ‘enum dma_data_direction’ declared inside parameter list will
not be visible outside of this definition or declaration"

Fix this warning by including 'linux/dma-direction.h'.

Fixes: 6ff265fc5ef6 ("scsi: ufs: core: bsg: Add advanced RPMB support in ufs_bsg")
Reported-by: Xiaosen He <quic_xiaosenh@quicinc.com>
Reported-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 include/ufs/ufshcd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index dd5912b4db77..e44a41abcc05 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -17,6 +17,7 @@
 #include <linux/blk-mq.h>
 #include <linux/devfreq.h>
 #include <linux/pm_runtime.h>
+#include <linux/dma-direction.h>
 #include <scsi/scsi_device.h>
 #include <ufs/unipro.h>
 #include <ufs/ufs.h>
-- 
2.25.1

