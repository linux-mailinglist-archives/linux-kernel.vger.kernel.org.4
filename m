Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783416F757E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjEDT5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjEDTzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:55:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8617E11DAE;
        Thu,  4 May 2023 12:48:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83AA2637F4;
        Thu,  4 May 2023 19:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01A0C4339C;
        Thu,  4 May 2023 19:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229734;
        bh=WS58CYiJ3a3L3SSRv26u1PXDWf5YPu1FiWNg+9WF2sw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pC3mvl6yJIG2BSo3vCUmZ6HJcu8WGPlBxvNrVvEiYvXfSzGBfOFlKwbTr5480hm/k
         UpdR9pdyLad2rW1dHs7h5OLwuuFNlli/4Edgrkqxi/3MJE1MmrNaXPik6XwxySk8qa
         oKiUCwLlnZ+BHsu+lg/L24fwuSaBPeaGdkIfDi/zB8Jki727rI3vl6+65ajd5AfX7m
         ROZn52ALIzDj8bAjPJVQrDiYjTH1egSl+0wUtazS+3+vlGWhF31vM2qfT8NK7x/H0f
         DmLANSXy5NUJhyl+tt6Do0l7PT35jT5SPYdXAKRh0a4TrifcQuruTfnL4T50F3YNHV
         2mJgyz2F1qufA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Bogdanov <d.bogdanov@yadro.com>, Forza <forza@tnonline.net>,
        Mike Christie <michael.christie@oracle.com>,
        Maurizio Lombardi <mlombard@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, mgurtovoy@nvidia.com,
        mingzhe.zou@easystack.cn, justinstitt@google.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 10/30] scsi: target: iscsit: Free cmds before session free
Date:   Thu,  4 May 2023 15:48:03 -0400
Message-Id: <20230504194824.3808028-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194824.3808028-1-sashal@kernel.org>
References: <20230504194824.3808028-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Bogdanov <d.bogdanov@yadro.com>

[ Upstream commit d8990b5a4d065f38f35d69bcd627ec5a7f8330ca ]

Commands from recovery entries are freed after session has been closed.
That leads to use-after-free at command free or NPE with such call trace:

Time2Retain timer expired for SID: 1, cleaning up iSCSI session.
BUG: kernel NULL pointer dereference, address: 0000000000000140
RIP: 0010:sbitmap_queue_clear+0x3a/0xa0
Call Trace:
 target_release_cmd_kref+0xd1/0x1f0 [target_core_mod]
 transport_generic_free_cmd+0xd1/0x180 [target_core_mod]
 iscsit_free_cmd+0x53/0xd0 [iscsi_target_mod]
 iscsit_free_connection_recovery_entries+0x29d/0x320 [iscsi_target_mod]
 iscsit_close_session+0x13a/0x140 [iscsi_target_mod]
 iscsit_check_post_dataout+0x440/0x440 [iscsi_target_mod]
 call_timer_fn+0x24/0x140

Move cleanup of recovery enrties to before session freeing.

Reported-by: Forza <forza@tnonline.net>
Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Link: https://lore.kernel.org/r/20230319015620.96006-7-michael.christie@oracle.com
Reviewed-by: Maurizio Lombardi <mlombard@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/iscsi/iscsi_target.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 2c54c5d8412d8..2142ee8c49978 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -4385,6 +4385,9 @@ int iscsit_close_session(struct iscsi_session *sess, bool can_sleep)
 	iscsit_stop_time2retain_timer(sess);
 	spin_unlock_bh(&se_tpg->session_lock);
 
+	if (sess->sess_ops->ErrorRecoveryLevel == 2)
+		iscsit_free_connection_recovery_entries(sess);
+
 	/*
 	 * transport_deregister_session_configfs() will clear the
 	 * struct se_node_acl->nacl_sess pointer now as a iscsi_np process context
@@ -4408,9 +4411,6 @@ int iscsit_close_session(struct iscsi_session *sess, bool can_sleep)
 
 	transport_deregister_session(sess->se_sess);
 
-	if (sess->sess_ops->ErrorRecoveryLevel == 2)
-		iscsit_free_connection_recovery_entries(sess);
-
 	iscsit_free_all_ooo_cmdsns(sess);
 
 	spin_lock_bh(&se_tpg->session_lock);
-- 
2.39.2

