Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDF65E6BB4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 21:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiIVTam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 15:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiIVTah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 15:30:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215527F0A0;
        Thu, 22 Sep 2022 12:30:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C582CB83A37;
        Thu, 22 Sep 2022 19:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6FDC433D6;
        Thu, 22 Sep 2022 19:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663875034;
        bh=vqFQno4mcDNf9adb3pKJgK0yhZw6i/lB0mWMPuO/jgo=;
        h=Date:From:To:Cc:Subject:From;
        b=ej6nGhbI6wgK7QB9ktkzYQYIVLi6f0tvrt13oKgLQnfuiFgLVef4FwW4Ox5Vj8T2F
         9IkpcCdIXAIIdBt8e25w8zX+PlSeCE0Mcy1WzTIleF47YhRowp7TRtvx7lXwEhWii0
         DAJEGyhUjqZxg5MYdephpf69O7VpTdOxRlL/9vz/vNuejBgiAOsc4uKmZmtC6mPL5K
         rm5gfCf41/N4FFMxXTYY5dqYCiEqTfaoNmvDuFxOui/qlkuCEmQIzobs+MaXLepyFk
         jB/bild6k65pPkADSFDgaJI96IvLu+bRJ19XpvA6jcZrOAnphiZtpBhcWd5elPhljW
         9hq1CeCIrpBnw==
Date:   Thu, 22 Sep 2022 14:30:28 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH] scsi: pm8001: Replace one-element array with flexible-array
 member
Message-ID: <Yyy31OuBza1FJCXP@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are deprecated, and we are replacing them with flexible
array members instead. So, replace one-element array with flexible-array
member in struct fw_control_info.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/207
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/scsi/pm8001/pm8001_sas.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index c5e3f380a01c..b08f52673889 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -612,7 +612,7 @@ struct fw_control_info {
 	operations.*/
 	u32			reserved;/* padding required for 64 bit
 	alignment */
-	u8			buffer[1];/* Start of buffer */
+	u8			buffer[];/* Start of buffer */
 };
 struct fw_control_ex {
 	struct fw_control_info *fw_control;
-- 
2.34.1

