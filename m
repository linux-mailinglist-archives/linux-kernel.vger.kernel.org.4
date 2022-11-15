Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A0862A2C7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbiKOUZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKOUZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:25:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD796577;
        Tue, 15 Nov 2022 12:25:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3FC2619FA;
        Tue, 15 Nov 2022 20:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4707AC433D6;
        Tue, 15 Nov 2022 20:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668543931;
        bh=wkeY+zmuuIfH0P91UWN754W6X7lV8EgxxsphFuXI3qQ=;
        h=Date:From:To:Cc:Subject:From;
        b=Fgg0M1Pa192/Avsm6D+UwDM5fJrY2sspV5S56Q+2trynAiKPqcStFT+abyT6XSc1/
         a3x5kEAWQ+sZwqGN2K0FTFXyAZdYfUN6Mki0F8ZAudv4vZfDZ+u0gGMe6RDRJXWukL
         UrAyFqTp5Mc39jkIyvLQ72CN/beRH3tKjCTt+cTA7RMKzxEC6PaGr0wIHueFBRSjUV
         bV2vE5peSGuf1XnRLsrqSIftx4J3h+OftKuhb14g3jryyWGSZJotmApNd3daqKV3yh
         +OD4viYDiq4mM10gITPiTO7iDtLGMwdaEAt/kDTFf2CzRk2MjUQIQVGWg29SM34K7J
         7Fj+EZ52eSMkA==
Date:   Tue, 15 Nov 2022 14:25:16 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] scsi: bfa: Replace one-element array with
 flexible-array member
Message-ID: <Y3P1rEEBq7HzJygq@work>
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
member in struct fdmi_attr_s.

Important to mention is that doing a build before/after this patch results
in no binary output differences.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE routines
on memcpy() and help us make progress towards globally enabling
-fstrict-flex-arrays=3 [1].

Link: https://github.com/KSPP/linux/issues/209
Link: https://github.com/KSPP/linux/issues/79
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/scsi/bfa/bfa_fc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/bfa/bfa_fc.h b/drivers/scsi/bfa/bfa_fc.h
index 0314e4b9e1fb..a12d693065ce 100644
--- a/drivers/scsi/bfa/bfa_fc.h
+++ b/drivers/scsi/bfa/bfa_fc.h
@@ -1548,7 +1548,7 @@ enum fdmi_port_attribute_type {
 struct fdmi_attr_s {
 	__be16        type;
 	__be16        len;
-	u8         value[1];
+	u8         value[];
 };
 
 /*
-- 
2.34.1

