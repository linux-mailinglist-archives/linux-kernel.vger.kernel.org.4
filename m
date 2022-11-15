Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C54629C2E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 15:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiKOOfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 09:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKOOff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 09:35:35 -0500
X-Greylist: delayed 495 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Nov 2022 06:35:29 PST
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEC31401B;
        Tue, 15 Nov 2022 06:35:29 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 8147F1864269;
        Tue, 15 Nov 2022 17:27:10 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4-vJmt9wN1H0; Tue, 15 Nov 2022 17:27:10 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 352F4186422F;
        Tue, 15 Nov 2022 17:27:10 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id y9MG4Fq2LoDP; Tue, 15 Nov 2022 17:27:10 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.20.20])
        by mail.astralinux.ru (Postfix) with ESMTPSA id 7D4AC1864248;
        Tue, 15 Nov 2022 17:27:09 +0300 (MSK)
From:   Anastasia Belova <abelova@astralinux.ru>
To:     Steve French <sfrench@samba.org>
Cc:     Anastasia Belova <abelova@astralinux.ru>,
        Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, Aurelien Aptel <aaptel@suse.com>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: [PATCH] cifs: add check for returning value of SMB2_close_init
Date:   Tue, 15 Nov 2022 17:27:01 +0300
Message-Id: <20221115142701.27074-1-abelova@astralinux.ru>
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

If the returning value of SMB2_close_init is an error-value,=20
exit the function.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 352d96f3acc6 ("cifs: multichannel: move channel selection above tr=
ansport layer")

Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 fs/cifs/smb2ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 880cd494afea..9737296c0fbc 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -1126,6 +1126,8 @@ smb2_set_ea(const unsigned int xid, struct cifs_tco=
n *tcon,
 	rqst[2].rq_nvec =3D 1;
 	rc =3D SMB2_close_init(tcon, server,
 			     &rqst[2], COMPOUND_FID, COMPOUND_FID, false);
+	if (rc)
+		goto sea_exit;
 	smb2_set_related(&rqst[2]);
=20
 	rc =3D compound_send_recv(xid, ses, server,
--=20
2.30.2

