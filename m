Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90DF473ED53
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 23:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjFZVwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 17:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjFZVvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 17:51:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4F130C2;
        Mon, 26 Jun 2023 14:51:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C72460F83;
        Mon, 26 Jun 2023 21:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D64C433C9;
        Mon, 26 Jun 2023 21:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687816248;
        bh=1NbO7uTL9DouzB9hf1xS42ta8S5JzWf70xDYV/H+7kY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D2sSiICcmZdghVLpVCssr7PiBQ5vsHSqYmuHO1Hgq3tyVwt+kSpaFJXqZflQ4ZYjM
         2CgGCK4FImZ/Zi4nQZIFQkKphws1/xocbLQz359v8+uxz5kDtUZCvMcxFbzd7aetP/
         F9GMXkZ3bpIsPDe3AvbBvzjD1qdbJryv7nkQXZvqzXm8Hey62HP/dkBOSrf0DKEzfJ
         Pal12yvqiFQGSFsuDSB+W3zZtFw1qzbZhWix6t5V38Q+3LUKrST8vyREkQf5+IXeDh
         8c0zIEzOmwo+T/b9DIG3q6mar9GQSu1C/V3fNYBxixNP8TfQhi2UTeVQcfF6lfLHU2
         1gYHFpybZWetg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shyam Prasad N <sprasad@microsoft.com>,
        Bharath SM <bharathsm@microsoft.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, pc@cjr.nz,
        lsahlber@redhat.com, dhowells@redhat.com, ematsumiya@suse.de,
        pc@manguebit.com, vl@samba.org
Subject: [PATCH AUTOSEL 6.1 09/15] cifs: add a warning when the in-flight count goes negative
Date:   Mon, 26 Jun 2023 17:50:25 -0400
Message-Id: <20230626215031.179159-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626215031.179159-1-sashal@kernel.org>
References: <20230626215031.179159-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.35
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
index 4fd377185c2ca..d5586f731dbc3 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -93,6 +93,7 @@ smb2_add_credits(struct TCP_Server_Info *server,
 					    server->conn_id, server->hostname, *val,
 					    add, server->in_flight);
 	}
+	WARN_ON_ONCE(server->in_flight == 0);
 	server->in_flight--;
 	if (server->in_flight == 0 &&
 	   ((optype & CIFS_OP_MASK) != CIFS_NEG_OP) &&
-- 
2.39.2

