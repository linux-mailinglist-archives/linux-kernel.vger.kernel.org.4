Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC41D73EDCB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 23:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjFZV4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 17:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjFZVyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 17:54:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C324935B6;
        Mon, 26 Jun 2023 14:52:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DC3D60F9C;
        Mon, 26 Jun 2023 21:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E733C433CB;
        Mon, 26 Jun 2023 21:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687816295;
        bh=Ht7BFAuQNdkZPjp5QshRZsflIZ67JZ/A71R/ITugmmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fpVZhiC/xagZz/9b4qsG2Qi2NkACDaURhjGi3+odfGVVcxQZdCqlJEMSIcwt4TROa
         t+01fEOYWNF4XdYPAzXKP6evHRCnQo55THYCc82KMbU++q8/Vz/BJHS3OWc19q7mxX
         K0+MtX+tYL6wCwdlBf1w/1Cao4MbPw64FCPcJUZ0h/E1R1TNHYXwAvIP09Q4lCXLj2
         5Cwwhvicu5sD1qbLiUPhI0faU90Bs0F2nhIWZtg5vT9FttvxzgDVss5zv0EeDrIuBa
         +zKJuEsh3MNqYyqq5hEk+WcLpqhkIxjrfa7i3nwoGzcurcKJdutHd9zDZ3RLBsWnuk
         AV91Zn36kx1PQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shyam Prasad N <sprasad@microsoft.com>,
        Bharath SM <bharathsm@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, pc@cjr.nz,
        lsahlber@redhat.com, dhowells@redhat.com, ematsumiya@suse.de,
        pc@manguebit.com, vl@samba.org
Subject: [PATCH AUTOSEL 4.14 4/5] cifs: add a warning when the in-flight count goes negative
Date:   Mon, 26 Jun 2023 17:51:29 -0400
Message-Id: <20230626215130.179740-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626215130.179740-1-sashal@kernel.org>
References: <20230626215130.179740-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.319
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

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit e4645cc2f1e2d6f268bb8dcfac40997c52432aed ]

We've seen the in-flight count go into negative with some
internal stress testing in Microsoft.

Adding a WARN when this happens, in hope of understanding
why this happens when it happens.

Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Reviewed-by: Bharath SM <bharathsm@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2ops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index dec306a3b0f41..3287795c648e5 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -78,6 +78,7 @@ smb2_add_credits(struct TCP_Server_Info *server, const unsigned int add,
 		*val = 65000; /* Don't get near 64K credits, avoid srv bugs */
 		printk_once(KERN_WARNING "server overflowed SMB3 credits\n");
 	}
+	WARN_ON_ONCE(server->in_flight == 0);
 	server->in_flight--;
 	if (server->in_flight == 0 && (optype & CIFS_OP_MASK) != CIFS_NEG_OP)
 		rc = change_conf(server);
-- 
2.39.2

