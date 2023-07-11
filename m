Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BD174FBBD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 01:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjGKXLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 19:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjGKXLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 19:11:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA39CF;
        Tue, 11 Jul 2023 16:11:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA5D06163E;
        Tue, 11 Jul 2023 23:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F464C433C7;
        Tue, 11 Jul 2023 23:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689117100;
        bh=KIRd8DUSyWk0AEQuhquMChREFws8OSd5E3EodjVZs84=;
        h=Date:From:To:Cc:Subject:From;
        b=Vijf9kHawoUsAHCRdUShMMlww1WeNa5kLeyDy0vtDHn0UjBXtNB8CR0H3FUIrFBNe
         mniSZT6qLl4SVqtfIxZYqoEOvqi/XfOd6mS/ybTEDklNwFaDCgxdsNpzoUo8dhJvwT
         WgQ+1gs3sJDvs6yKrJbCfMr6j4RiW1DFsNpx+8DAtmzFcYzVy3GbLtOrfqNja0jF5I
         UHDS583jjfRisY18i3bzpE8eFM4I7bT944Werl1J2EwM18JsHLE4LboOpgje3x4H22
         3/xoHmBUqCBtM6ZefMrE6ywlWiuBdcqlSE7aYnqNrCWgRyiDpSr/FNebscYSboQbPH
         EpryJqUsX/ehw==
Date:   Tue, 11 Jul 2023 17:12:31 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH] smb: client: Fix -Wstringop-overflow issues
Message-ID: <ZK3h3+dHBGONHt+S@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pSMB->hdr.Protocol is an array of size 4 bytes, hence when the compiler
analyzes this line of code

	parm_data = ((char *) &pSMB->hdr.Protocol) + offset;

it legitimately complains about the fact that offset points outside the
bounds of the array. Notice that the compiler gives priority to the object
as an array, rather than merely the address of one more byte in a structure
to wich offset should be added (which seems to be the actual intention of
the original implementation).

Fix this by explicitly instructing the compiler to treat the code as a
sequence of bytes in struct smb_com_transaction2_spi_req, and not as an
array accessed through pointer notation.

Notice that ((char *)pSMB) + sizeof(pSMB->hdr.smb_buf_length) points to
the same address as ((char *) &pSMB->hdr.Protocol), therefore this results
in no differences in binary output.

Fixes the following -Wstringop-overflow warnings when built s390
architecture with defconfig (GCC 13):
  CC [M]  fs/smb/client/cifssmb.o
In function 'cifs_init_ace',
    inlined from 'posix_acl_to_cifs' at fs/smb/client/cifssmb.c:3046:3,
    inlined from 'cifs_do_set_acl' at fs/smb/client/cifssmb.c:3191:15:
fs/smb/client/cifssmb.c:2987:31: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
 2987 |         cifs_ace->cifs_e_perm = local_ace->e_perm;
      |         ~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
In file included from fs/smb/client/cifssmb.c:27:
fs/smb/client/cifspdu.h: In function 'cifs_do_set_acl':
fs/smb/client/cifspdu.h:384:14: note: at offset [7, 11] into destination object 'Protocol' of size 4
  384 |         __u8 Protocol[4];
      |              ^~~~~~~~
In function 'cifs_init_ace',
    inlined from 'posix_acl_to_cifs' at fs/smb/client/cifssmb.c:3046:3,
    inlined from 'cifs_do_set_acl' at fs/smb/client/cifssmb.c:3191:15:
fs/smb/client/cifssmb.c:2988:30: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
 2988 |         cifs_ace->cifs_e_tag =  local_ace->e_tag;
      |         ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
fs/smb/client/cifspdu.h: In function 'cifs_do_set_acl':
fs/smb/client/cifspdu.h:384:14: note: at offset [6, 10] into destination object 'Protocol' of size 4
  384 |         __u8 Protocol[4];
      |              ^~~~~~~~

This helps with the ongoing efforts to globally enable
-Wstringop-overflow.

Link: https://github.com/KSPP/linux/issues/310
Fixes: dc1af4c4b472 ("cifs: implement set acl method")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/smb/client/cifssmb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 19f7385abeec..9dee267f1893 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -3184,7 +3184,7 @@ int cifs_do_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
 	param_offset = offsetof(struct smb_com_transaction2_spi_req,
 				InformationLevel) - 4;
 	offset = param_offset + params;
-	parm_data = ((char *) &pSMB->hdr.Protocol) + offset;
+	parm_data = ((char *)pSMB) + sizeof(pSMB->hdr.smb_buf_length) + offset;
 	pSMB->ParameterOffset = cpu_to_le16(param_offset);
 
 	/* convert to on the wire format for POSIX ACL */
-- 
2.34.1

