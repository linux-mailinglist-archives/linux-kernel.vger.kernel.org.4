Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83B27336F6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 19:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344759AbjFPRAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 13:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346225AbjFPRAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 13:00:02 -0400
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85E24699
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:58:36 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qACmQ-00G7aQ-3M; Fri, 16 Jun 2023 17:58:34 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1qACmP-000IB5-2T;
        Fri, 16 Jun 2023 17:58:33 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] lib: zlib: make __gunzip always static
Date:   Fri, 16 Jun 2023 17:58:32 +0100
Message-Id: <20230616165832.69866-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __gunzip() code looks like it has not been referenced outside of
lib/decompress_inflate.c so make it always static to avoid the following
warning:

lib/decompress_inflate.c:42:17: warning: symbol '__gunzip' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 lib/decompress_inflate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/decompress_inflate.c b/lib/decompress_inflate.c
index 6130c42b8e59..e19199f4a684 100644
--- a/lib/decompress_inflate.c
+++ b/lib/decompress_inflate.c
@@ -39,7 +39,7 @@ static long INIT nofill(void *buffer, unsigned long len)
 }
 
 /* Included from initramfs et al code */
-STATIC int INIT __gunzip(unsigned char *buf, long len,
+static int INIT __gunzip(unsigned char *buf, long len,
 		       long (*fill)(void*, unsigned long),
 		       long (*flush)(void*, unsigned long),
 		       unsigned char *out_buf, long out_len,
-- 
2.39.2

