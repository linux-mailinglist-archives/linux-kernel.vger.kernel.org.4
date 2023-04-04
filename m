Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE696D616D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbjDDMp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbjDDMpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:45:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABBE93;
        Tue,  4 Apr 2023 05:44:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1553463364;
        Tue,  4 Apr 2023 12:44:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EC1C433D2;
        Tue,  4 Apr 2023 12:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680612298;
        bh=WFFW9qEQYe8+GiUD2bFU8d19Cj3lDDm8VtUlxAm+bH4=;
        h=From:Date:Subject:To:Cc:From;
        b=QZKS1I8yNLt22q8keAcuSLsiaXmUwcW3CtB65tSui+68PSR6a6y8o1zas3Gs6KBYc
         rvqMb8u37hnumuyK3xPVLSvPllfuT5Fsuv+zjtcScxUlKg/HbhG9jzCK2UjPatyL6L
         UyslQu58wAisIOZa8Rfhfr7mfefiGmO2aARQP/VgcsbBKKjnfDj/D6R7RHZywo8VbY
         oSzvoZkEh7vpAeSaKzWjpLV3/YonsqM1nVTWJup4TytlLQZ/sMx+InXEDhuN1vlsmA
         H+oYMa3j+iNycVjWMG9kK5wglimZUsSIxG1dNCzgD9q9Nka2204KAqSyBaaGI3UJ6h
         jPjSAF1FwG2Dg==
From:   Simon Horman <horms@kernel.org>
Date:   Tue, 04 Apr 2023 14:44:53 +0200
Subject: [PATCH] remoteproc: pru: remove always true check positive
 unsigned value
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230404-pru-always-true-v1-1-b1b55eeff188@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMQbLGQC/x2N0QqDMAwAf0XyvEC1Vdh+Zewh1mwWSifJ6ibiv
 xv2eAfH7aAsiRVuzQ7Ca9L0LgbtpYE4U3kxpskYOtd5F1zARSpS/tKm+JHK2Psh9lNLwzV4sGo
 kZRyFSpytKzVnk4vwM/3+m/vjOE45xyw+dgAAAA==
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Dan Carpenter <error27@gmail.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Simon Horman <horms@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In both cases they type of da is u32. And PRU_PDRAM_DA is 0.
So the check da >= PRU_PDRAM_DA is always true and can be removed.

Flagged by Smatch:

 drivers/remoteproc/pru_rproc.c:660 pru_d_da_to_va() warn: always true condition '(da >= 0) => (0-u32max >= 0)'
 drivers/remoteproc/pru_rproc.c:709 pru_i_da_to_va() warn: always true condition '(da >= 0) => (0-u32max >= 0)'

No functional changes intended.
Compile tested only.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://www.spinics.net/lists/kernel/msg4025983.html
Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/remoteproc/pru_rproc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index b76db7fa693d..095f66130f48 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -657,7 +657,7 @@ static void *pru_d_da_to_va(struct pru_rproc *pru, u32 da, size_t len)
 		swap(dram0, dram1);
 	shrd_ram = pruss->mem_regions[PRUSS_MEM_SHRD_RAM2];
 
-	if (da >= PRU_PDRAM_DA && da + len <= PRU_PDRAM_DA + dram0.size) {
+	if (da + len <= PRU_PDRAM_DA + dram0.size) {
 		offset = da - PRU_PDRAM_DA;
 		va = (__force void *)(dram0.va + offset);
 	} else if (da >= PRU_SDRAM_DA &&
@@ -706,8 +706,7 @@ static void *pru_i_da_to_va(struct pru_rproc *pru, u32 da, size_t len)
 	 */
 	da &= 0xfffff;
 
-	if (da >= PRU_IRAM_DA &&
-	    da + len <= PRU_IRAM_DA + pru->mem_regions[PRU_IOMEM_IRAM].size) {
+	if (da + len <= PRU_IRAM_DA + pru->mem_regions[PRU_IOMEM_IRAM].size) {
 		offset = da - PRU_IRAM_DA;
 		va = (__force void *)(pru->mem_regions[PRU_IOMEM_IRAM].va +
 				      offset);

