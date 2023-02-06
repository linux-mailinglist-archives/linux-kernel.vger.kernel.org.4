Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03F768C315
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjBFQWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjBFQWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:22:51 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6D84C23
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 08:22:47 -0800 (PST)
Received: from vefanov-Precision-3650-Tower.intra.ispras.ru (unknown [10.10.2.69])
        by mail.ispras.ru (Postfix) with ESMTPSA id 821C140737B4;
        Mon,  6 Feb 2023 16:22:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 821C140737B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1675700563;
        bh=TGRW7oLa9p6QrdKgqvOA9ex9g7VxGA9RY8Zwhpjk/Hs=;
        h=From:To:Cc:Subject:Date:From;
        b=rgADJgr47gcvbQfxfFwUgH2zqu3V64iRCEuovOZEfmj2OrNA0xkH/5m5m4x/XEf3L
         Iush1eYZlYnm7XHq+65xW++ZL0IRhY4uXlUANB96iXYFl1XA5rZG/bR0q1hf864Rmw
         fADw+RDkkqs9c8GNRjMlP7MOOiOrnrAjYoStso00=
From:   Vladislav Efanov <VEfanov@ispras.ru>
To:     Jan Kara <jack@suse.com>
Cc:     Vladislav Efanov <VEfanov@ispras.ru>, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH] udf: KASAN: slab-out-of-bounds in udf_readdir
Date:   Mon,  6 Feb 2023 19:22:06 +0300
Message-Id: <20230206162206.845488-1-VEfanov@ispras.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KASAN report is:
[ 1922.586560] BUG: KASAN: slab-out-of-bounds in udf_readdir+0xe00/0x19e0
[ 1922.586922] Write of size 89 at addr ffff888000cd9ea6 by task rm/18493

udf_readdir() tries to write file name out of allocated memory
buffer bounds. The UDF_NAME_LEN_CS0 (255) is used as max length
for file name in udf_put_filename(). But UDF_NAME_LEN (254) is
used as the size for buffer allocation in udf_readdir(). As the
result out-of-bounds write happened.

Found by Linux Verification Center (linuxtesting.org) with xfstests

Fixes: 066b9cded00b ("udf: Use separate buffer for copying split names")
Signed-off-by: Vladislav Efanov <VEfanov@ispras.ru>
---
 fs/udf/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/udf/dir.c b/fs/udf/dir.c
index be640f4b2f2c..b95607c42ad4 100644
--- a/fs/udf/dir.c
+++ b/fs/udf/dir.c
@@ -169,7 +169,7 @@ static int udf_readdir(struct file *file, struct dir_context *ctx)
 				nameptr = (char *)(fibh.ebh->b_data + poffset - lfi);
 			} else {
 				if (!copy_name) {
-					copy_name = kmalloc(UDF_NAME_LEN,
+					copy_name = kmalloc(UDF_NAME_LEN_CS0,
 							    GFP_NOFS);
 					if (!copy_name) {
 						ret = -ENOMEM;
-- 
2.34.1

