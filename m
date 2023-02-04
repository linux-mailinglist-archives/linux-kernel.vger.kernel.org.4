Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64ED68AC4A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 21:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjBDUjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 15:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjBDUjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 15:39:20 -0500
X-Greylist: delayed 546 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 04 Feb 2023 12:39:19 PST
Received: from mr85p00im-zteg06021901.me.com (mr85p00im-zteg06021901.me.com [17.58.23.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2CC2915A
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 12:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1675542613; bh=wdmroSnk2VRzxsnC/4QQ06ZZXjkhU/5Tb87n4HWe2pE=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=wQhqV4pIgexziHbg3XW/PmP8qVUeu4uc9JxffwW1lMjgHnQ6ypKJbmbPvMnhM+4th
         EiGOCmKt+YKR2VxC9pYLbU9PMcp80qv1EVdZlfHWjfDbdtm7GiMa9uDftDrBkynjeB
         Y5DD4UjOxnhoVrwqfpvgiJIfK9HFKA7nBVwINx3zQZ1ZKmFysPKPOS/k9CsjmUSoHE
         anBYVzUetYwN1vhlwRsL8VkQHQFQMJAezpBTG5jAJQ20ZxBkSotoa+IZOiUTffRZ1t
         96Ifvq8kNNgj/5pDzT1ACS67VLZyTrkDedU+qwIS/puUk39ze2X5TOIf1ElSdenz17
         8PvQO0o2w60+g==
Received: from localhost (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-zteg06021901.me.com (Postfix) with ESMTPSA id E25E3740A0B;
        Sat,  4 Feb 2023 20:30:12 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Alain Volmat <avolmat@me.com>, kernel test robot <lkp@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] media: sti: c8sectpfe: drop of_match_ptr() to avoid unused variables
Date:   Sat,  4 Feb 2023 21:29:40 +0100
Message-Id: <20230204202941.139974-1-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -y6n3fMLjC9oNm25ppWtRkpNx3LCANb_
X-Proofpoint-ORIG-GUID: -y6n3fMLjC9oNm25ppWtRkpNx3LCANb_
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=958 bulkscore=0 clxscore=1011 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2302040184
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_OF is not set, "of_match_ptr(<match_table>)" compiles to NULL,
which leaves <match_table> unused, leading to warning such as:

drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c:1175:34:
warning: unused variable 'c8sectpfe_match' [-Wunused-const-variable]

Drop the of_match_ptr usage to avoid such warning.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alain Volmat <avolmat@me.com>
---
 drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
index c38b62d4f1ae..67d4db0abd8a 100644
--- a/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/st/sti/c8sectpfe/c8sectpfe-core.c
@@ -1175,7 +1175,7 @@ MODULE_DEVICE_TABLE(of, c8sectpfe_match);
 static struct platform_driver c8sectpfe_driver = {
 	.driver = {
 		.name = "c8sectpfe",
-		.of_match_table = of_match_ptr(c8sectpfe_match),
+		.of_match_table = c8sectpfe_match,
 	},
 	.probe	= c8sectpfe_probe,
 	.remove	= c8sectpfe_remove,
-- 
2.34.1

