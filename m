Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6E873173A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344182AbjFOLkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344134AbjFOLjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:39:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200033A98;
        Thu, 15 Jun 2023 04:38:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E95A1638FA;
        Thu, 15 Jun 2023 11:38:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313FBC433C0;
        Thu, 15 Jun 2023 11:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686829113;
        bh=mmdudRkuSbiUU5LPtsxAkTPhX5voY/Mn+ojKMk7dSZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pwZQ/HLMttogt2rqrniQHwDukRaay1tHnkrZ07T1rz1tGSLKq2vfy4sXZQsi1Ls6p
         uCdtDyYGlKL9oWffkWQsUpdSMcyUqMOwksvbfIPpRE76OzYo+IOYBv7mqa5ycsKOcZ
         xZBZaTPuz/rxUgQ/I6q7bgJIGO7gVJ+qEAf8Go3ymu6L5tXDGFoX3HW43Tkx/NWeSm
         0CaYB73ho/CONjjLD18TYM5Kxjmw/a0g60GA+w9iY/5fnIfShovCVhFmRTmUbwNdzh
         7nyXIcVbWsDA8mYq+8DBVWfTrKrhmBtgtMDN8ZNzjh7Ntazh5xI7b9yrVtSN3S4mtn
         SIFuTUADiimUA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Steve French <stfrench@microsoft.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        Sasha Levin <sashal@kernel.org>, pc@cjr.nz, pc@manguebit.com,
        ematsumiya@suse.de, lsahlber@redhat.com, sprasad@microsoft.com,
        vl@samba.org, metze@samba.org
Subject: [PATCH AUTOSEL 6.1 07/16] smb3: missing null check in SMB2_change_notify
Date:   Thu, 15 Jun 2023 07:38:07 -0400
Message-Id: <20230615113816.649135-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230615113816.649135-1-sashal@kernel.org>
References: <20230615113816.649135-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.34
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

From: Steve French <stfrench@microsoft.com>

[ Upstream commit b535cc796a4b4942cd189652588e8d37c1f5925a ]

If plen is null when passed in, we only checked for null
in one of the two places where it could be used. Although
plen is always valid (not null) for current callers of the
SMB2_change_notify function, this change makes it more consistent.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/all/202305251831.3V1gbbFs-lkp@intel.com/
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 537e8679900b8..3ca593cdda76e 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -3779,7 +3779,7 @@ SMB2_change_notify(const unsigned int xid, struct cifs_tcon *tcon,
 		if (*out_data == NULL) {
 			rc = -ENOMEM;
 			goto cnotify_exit;
-		} else
+		} else if (plen)
 			*plen = le32_to_cpu(smb_rsp->OutputBufferLength);
 	}
 
-- 
2.39.2

