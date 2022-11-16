Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D9562C09A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 15:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiKPOLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 09:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbiKPOKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 09:10:43 -0500
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8E910F7;
        Wed, 16 Nov 2022 06:10:39 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id ECF841863FE5;
        Wed, 16 Nov 2022 17:10:35 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Iq0guvWvdgAR; Wed, 16 Nov 2022 17:10:35 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id A05BC1863E3F;
        Wed, 16 Nov 2022 17:10:35 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ARbProRY4lWh; Wed, 16 Nov 2022 17:10:35 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.20.20])
        by mail.astralinux.ru (Postfix) with ESMTPSA id 0C96C1863CD8;
        Wed, 16 Nov 2022 17:10:34 +0300 (MSK)
From:   Anastasia Belova <abelova@astralinux.ru>
To:     Steve French <sfrench@samba.org>
Cc:     Anastasia Belova <abelova@astralinux.ru>,
        Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] cifs: add check for returning value of SMB2_set_info_init
Date:   Wed, 16 Nov 2022 17:10:27 +0300
Message-Id: <20221116141027.10947-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the returning value of SMB2_set_info_init is an error-value,
exit the function.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 0967e5457954 ("cifs: use a compound for setting an xattr")

Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 fs/cifs/smb2ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 880cd494afea..c77e49b3fcc6 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -1116,6 +1116,8 @@ smb2_set_ea(const unsigned int xid, struct cifs_tco=
n *tcon,
 				COMPOUND_FID, current->tgid,
 				FILE_FULL_EA_INFORMATION,
 				SMB2_O_INFO_FILE, 0, data, size);
+	if (rc)
+		goto sea_exit;
 	smb2_set_next_command(tcon, &rqst[1]);
 	smb2_set_related(&rqst[1]);
=20
--=20
2.30.2

