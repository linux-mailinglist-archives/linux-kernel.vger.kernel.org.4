Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A77B617C06
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiKCL42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 07:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiKCL4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 07:56:23 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC18B1106
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 04:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667476568; bh=/NLwbR49Avnf18FfogKpbZ5T40/76ghuIMELqgmgUkY=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=X+HOMa6Cqoa27KMD5oT1MjY3Gz7vKXD/EPT7mnn+e2u8/jdt+Wa/5NI46KgaFlst5
         fTU2aE87wU4JlJvUxqPZXEVz6g0qAviYe19VUTb4WTAAYMyS9QqVGyJ50modG1ya16
         p3NWP+ln9ofRwUjnWtprBu3dajdSkNnXfY9Wu09k=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via [213.182.55.206]
        Thu,  3 Nov 2022 12:56:08 +0100 (CET)
X-EA-Auth: fZNaHUg4jtpGZewYR6tJSl4CE3GuUAnFJlzHa26bu/s68tjys15zyF84sNeCegVJFSM5djMwkw2RoegSYSsa5vTs/Mtwkcxh
Date:   Thu, 3 Nov 2022 17:26:01 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: r8188eu: replace one element 2D array by 1D array
Message-ID: <Y2OsUYcBYe1fZR1W@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A single element two dimensional array is constrained to index 0 for
that element. This constraint makes it similar to a one dimensional
array.  Hence convert such array to a simplified one dimensional
equivalent. Resultant code is simpler and easy to maintain.

Suggested-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c | 2 +-
 drivers/staging/r8188eu/include/odm.h        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 622f95d3f2ed..c0706c5b3fd8 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -886,7 +886,7 @@ void PHY_IQCalibrate_8188E(struct adapter *adapt, bool recovery)
 /* by sherry 20120321 */
 	if (final_candidate < 4) {
 		for (i = 0; i < IQK_Matrix_REG_NUM; i++)
-			dm_odm->RFCalibrateInfo.IQKMatrixRegSetting.Value[0][i] = result[final_candidate][i];
+			dm_odm->RFCalibrateInfo.IQKMatrixRegSetting.Value[i] = result[final_candidate][i];
 		dm_odm->RFCalibrateInfo.IQKMatrixRegSetting.bIQKDone = true;
 	}

diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 89b01dd614ba..0008615ba858 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -166,7 +166,7 @@ struct odm_ra_info {

 struct ijk_matrix_regs_set {
 	bool	bIQKDone;
-	s32	Value[1][IQK_Matrix_REG_NUM];
+	s32	Value[IQK_Matrix_REG_NUM];
 };

 struct odm_rf_cal {
--
2.34.1



