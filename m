Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBC6731772
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344284AbjFOLmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344330AbjFOLmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:42:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97114228;
        Thu, 15 Jun 2023 04:39:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C671639BD;
        Thu, 15 Jun 2023 11:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D51C433C8;
        Thu, 15 Jun 2023 11:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686829140;
        bh=sn2IKEwdj/SlpGfzBw23euWcHWfnYvBDBogcN0hFLGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gK3wP21RjFQhLsyCAIkOhR/0iqUI713EDIxRVRuTX47JaV/9jmklVS/OJ1lRa1YrU
         cgqdKf1FBanWyQGaPFP6VDZY/69sCnyLZ0NMOMHcN/DXetmjUJX4auWMZZYaVxab2B
         WCDApbV4tVf9oLoJXqMxJswOVKSSFEhswOYuewfkPhzew+Dkr/LqlNZ8J842YMmPhw
         UK2yh7wMgB7k35xVo0z5zBk1dwd9RlLUpC8ZFGso+D17Vcc0hDFHcP89exoV1n5Mcz
         Ga590MZIxTCyMZXeO0sqKlWtIe+73yutwt3+ruZ6WdJNOM0lucm/mAYN35jfyedh3V
         WG4Wsc4Nc+tlA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Maurizio Lombardi <mlombard@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, d.bogdanov@yadro.com,
        yang.lee@linux.alibaba.com, peilin.ye@bytedance.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 02/10] scsi: target: iscsi: Prevent login threads from racing between each other
Date:   Thu, 15 Jun 2023 07:38:46 -0400
Message-Id: <20230615113854.649370-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615113854.649370-1-sashal@kernel.org>
References: <20230615113854.649370-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.117
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index c0ed6f8e5c5b9..32a2852352db1 100644
--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -1071,6 +1071,7 @@ int iscsi_target_locate_portal(
 	iscsi_target_set_sock_callbacks(conn);
 
 	login->np = np;
+	conn->tpg = NULL;
 
 	login_req = (struct iscsi_login_req *) login->req;
 	payload_length = ntoh24(login_req->dlength);
@@ -1138,7 +1139,6 @@ int iscsi_target_locate_portal(
 	 */
 	sessiontype = strncmp(s_buf, DISCOVERY, 9);
 	if (!sessiontype) {
-		conn->tpg = iscsit_global->discovery_tpg;
 		if (!login->leading_connection)
 			goto get_target;
 
@@ -1155,9 +1155,11 @@ int iscsi_target_locate_portal(
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

