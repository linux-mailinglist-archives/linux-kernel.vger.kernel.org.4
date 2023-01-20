Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E268E675423
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjATMIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjATMI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:08:28 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BFF4A1DC;
        Fri, 20 Jan 2023 04:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674216507; x=1705752507;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AZ/jvlZjDAGzwVeZ5n8u21laCDo/f+erT+mJrrLfC7E=;
  b=Z60xQK/Ak8OOa45s6jDFuGp/Um+pmnOICvCuhkceSPRQrcHoQB6XicW9
   CrXZnkj5pR63xF14LnCOli6dDEE4zoLI7A443s8z/un8V8HDJzf1RPMwf
   CvrVQlPhkFE1bsqddvF0AyX/5aYiugsFBZHEPz5loixqOHNADSYsMsAHL
   4gI6Kljohn8e9d3Ej4YJqyzUft94A5kHPnIpKbOWoy1794M9KCjuupg+s
   Qj0SCYN92d5QcJNWJHEtt77MUQVgARuQiotNT7pxc7RhoBIxCe5Pk3MoT
   6ekBEWhe4pOuPg+iybM4sCbOuBxohOQbyh0TpQb3Ey0+FCIoVklgyodNX
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="323255751"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="323255751"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2023 04:08:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="834392629"
X-IronPort-AV: E=Sophos;i="5.97,232,1669104000"; 
   d="scan'208";a="834392629"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 20 Jan 2023 04:08:24 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 50A4A36D; Fri, 20 Jan 2023 14:08:59 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Steve French <stfrench@microsoft.com>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Cc:     Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] cifs: Get rid of unneeded conditional in the smb2_get_aead_req()
Date:   Fri, 20 Jan 2023 14:08:57 +0200
Message-Id: <20230120120857.60444-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the smb2_get_aead_req() the skip variable is used only for
the very first iteration of the two nested loops, which means
it's basically in invariant to those loops. Hence, instead of
using conditional on each iteration, unconditionally assing
the 'skip' variable before the loops and at the end of the
inner loop.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 fs/cifs/smb2ops.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 519e6124d73d..7fcb79ce6a94 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -4280,6 +4280,12 @@ static void *smb2_get_aead_req(struct crypto_aead *tfm, const struct smb_rqst *r
 	sg_init_table(*sgl, num_sgs);
 	sg = *sgl;
 
+	/*
+	 * The first rqst has a transform header where the
+	 * first 20 bytes are not part of the encrypted blob.
+	 */
+	skip = 20;
+
 	/* Assumes the first rqst has a transform header as the first iov.
 	 * I.e.
 	 * rqst[0].rq_iov[0]  is transform header
@@ -4287,17 +4293,15 @@ static void *smb2_get_aead_req(struct crypto_aead *tfm, const struct smb_rqst *r
 	 * rqst[1+].rq_iov[0+] data to be encrypted/decrypted
 	 */
 	for (i = 0; i < num_rqst; i++) {
-		/*
-		 * The first rqst has a transform header where the
-		 * first 20 bytes are not part of the encrypted blob.
-		 */
 		for (j = 0; j < rqst[i].rq_nvec; j++) {
 			struct kvec *iov = &rqst[i].rq_iov[j];
 
-			skip = (i == 0) && (j == 0) ? 20 : 0;
 			addr = (unsigned long)iov->iov_base + skip;
 			len = iov->iov_len - skip;
 			sg = cifs_sg_set_buf(sg, (void *)addr, len);
+
+			/* See the above comment on the 'skip' assignment */
+			skip = 0;
 		}
 		for (j = 0; j < rqst[i].rq_npages; j++) {
 			rqst_page_get_length(&rqst[i], j, &len, &off);
-- 
2.39.0

