Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C05F70245F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238825AbjEOGTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjEOGTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:19:42 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 9E24E1722;
        Sun, 14 May 2023 23:19:37 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 1007018011BD54;
        Mon, 15 May 2023 14:19:28 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu
Cc:     codalist@coda.cs.cmu.edu, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Su Hui <suhui@nfschina.com>
Subject: [PATCH] coda: return -EFAULT if copy fails
Date:   Mon, 15 May 2023 14:19:23 +0800
Message-Id: <20230515061923.767680-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The copy_to/from_user() functions should return -EFAULT instead of -EINVAL.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
 fs/coda/upcall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
index cd6a3721f6f6..1517dc3bd592 100644
--- a/fs/coda/upcall.c
+++ b/fs/coda/upcall.c
@@ -510,7 +510,7 @@ int venus_pioctl(struct super_block *sb, struct CodaFid *fid,
         /* get the data out of user space */
 	if (copy_from_user((char *)inp + (long)inp->coda_ioctl.data,
 			   data->vi.in, data->vi.in_size)) {
-		error = -EINVAL;
+		error = -EFAULT;
 	        goto exit;
 	}
 
-- 
2.30.2

