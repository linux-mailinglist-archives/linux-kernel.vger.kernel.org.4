Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EE7731776
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344413AbjFOLnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344285AbjFOLmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:42:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15DD30FF;
        Thu, 15 Jun 2023 04:39:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C31B660F23;
        Thu, 15 Jun 2023 11:39:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24328C433C8;
        Thu, 15 Jun 2023 11:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686829184;
        bh=VvcDlxUQaRiX2ruxjT8DhrhgUh+QPAZStuGAHH2eEFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BFTbIG4F95727E1Yj7SXmajheqXbePlOczW1ruZjSP0tzshVSqFyY5f2dVO8CDKV6
         3/x2f2p/ccvDfDXzka1EPQEL0bcDuH8yUbzIpSBmKYLFpov1pwrCT1OlJusRyRMqCF
         QaVjKG11lipRBAxOidFNZaWfYthT/WdaGID0V9M1Af64m6jlm1u6zntuVl06w2t256
         XDrY1fJfHzxplj61gMxDLGCgFkq+U/Jlpm5PKrzXkT/2aLACqDHjaXwnicl9i+aUhZ
         h3tjhb+IXzpD9oXFO29nsAqIMImSge/5Vu/HwMv3X1vA/kXEymO3baYm5v3NVYWcTp
         cCdayddVQ9Kfw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Maurizio Lombardi <mlombard@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, d.bogdanov@yadro.com,
        peilin.ye@bytedance.com, yang.lee@linux.alibaba.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 2/8] scsi: target: iscsi: Prevent login threads from racing between each other
Date:   Thu, 15 Jun 2023 07:39:32 -0400
Message-Id: <20230615113938.649627-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615113938.649627-1-sashal@kernel.org>
References: <20230615113938.649627-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.247
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit 2a737d3b8c792400118d6cf94958f559de9c5e59 ]

The tpg->np_login_sem is a semaphore that is used to serialize the login
process when multiple login threads run concurrently against the same
target portal group.

The iscsi_target_locate_portal() function finds the tpg, calls
iscsit_access_np() against the np_login_sem semaphore and saves the tpg
pointer in conn->tpg;

If iscsi_target_locate_portal() fails, the caller will check for the
conn->tpg pointer and, if it's not NULL, then it will assume that
iscsi_target_locate_portal() called iscsit_access_np() on the semaphore.

Make sure that conn->tpg gets initialized only if iscsit_access_np() was
successful, otherwise iscsit_deaccess_np() may end up being called against
a semaphore we never took, allowing more than one thread to access the same
tpg.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Link: https://lore.kernel.org/r/20230508162219.1731964-4-mlombard@redhat.com
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/iscsi/iscsi_target_nego.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/iscsi/iscsi_target_nego.c
index e32d93b927428..4017464a5909b 100644
--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -1053,6 +1053,7 @@ int iscsi_target_locate_portal(
 	iscsi_target_set_sock_callbacks(conn);
 
 	login->np = np;
+	conn->tpg = NULL;
 
 	login_req = (struct iscsi_login_req *) login->req;
 	payload_length = ntoh24(login_req->dlength);
@@ -1122,7 +1123,6 @@ int iscsi_target_locate_portal(
 	 */
 	sessiontype = strncmp(s_buf, DISCOVERY, 9);
 	if (!sessiontype) {
-		conn->tpg = iscsit_global->discovery_tpg;
 		if (!login->leading_connection)
 			goto get_target;
 
@@ -1139,9 +1139,11 @@ int iscsi_target_locate_portal(
 		 * Serialize access across the discovery struct iscsi_portal_group to
 		 * process login attempt.
 		 */
+		conn->tpg = iscsit_global->discovery_tpg;
 		if (iscsit_access_np(np, conn->tpg) < 0) {
 			iscsit_tx_login_rsp(conn, ISCSI_STATUS_CLS_TARGET_ERR,
 				ISCSI_LOGIN_STATUS_SVC_UNAVAILABLE);
+			conn->tpg = NULL;
 			ret = -1;
 			goto out;
 		}
-- 
2.39.2

