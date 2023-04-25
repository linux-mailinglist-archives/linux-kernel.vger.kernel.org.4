Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CD96EDBDD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 08:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjDYGrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 02:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbjDYGrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 02:47:35 -0400
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D4130CF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 23:47:33 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id rCSWpcq9sDWp7rCSXpOke8; Tue, 25 Apr 2023 08:47:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1682405251;
        bh=xSNUhNscxEqVyr5Wkr8JJ5bNbQGHTG7dlAH1ZVdGGxI=;
        h=From:To:Cc:Subject:Date;
        b=Nw6mZSkYmqbR8DzTe0qATHJxdNCoJ2gaAENwPMxB70pbs2cD4zwXyPJC+RhvtWI8M
         jJ1yeE5sYoUUQP8rAZmfYjMpJMcHavsiDcGRNdJ1J8yGVRq6k7SqJPfFAO6+ZmAgi1
         1KuRbXiH+JkmNeZpp5pzShHo5lhGnW7FqFpUlBnPX6TUALps2hNzPRYLdJtFR8FSta
         jOlXI3E4EL9JIU6OlPcbO9T9rk3N8WraSZeVZQniIcen58IO3fFzAvJFCR0pyZpTZI
         QDOWvg0AJliSCA3NB5SlKQ1G1J8onJmmePwqFgOV2RYJyDIXXe2TqefrAEMGIo+M6F
         gfwiaFfcU01Jg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 25 Apr 2023 08:47:31 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Eric Van Hensbergen <ericvh@kernel.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        v9fs@lists.linux.dev
Subject: [PATCH] fs/9p: Fix a datatype used with V9FS_DIRECT_IO
Date:   Tue, 25 Apr 2023 08:47:27 +0200
Message-Id: <80bae984fd5ca49b691bb35f2fd8f345f8bb67f1.1682405206.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit in Fixes has introduced some "enum p9_session_flags" values
larger than a char.
Such values are stored in "v9fs_session_info->flags" which is a char only.

Turn it into an int so that the "enum p9_session_flags" values can fit in
it.

Fixes: 6deffc8924b5 ("fs/9p: Add new mount modes")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Un-tested
---
 fs/9p/v9fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 06a2514f0d88..698c43dd5dc8 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -108,7 +108,7 @@ enum p9_cache_bits {
 
 struct v9fs_session_info {
 	/* options */
-	unsigned char flags;
+	unsigned int flags;
 	unsigned char nodev;
 	unsigned short debug;
 	unsigned int afid;
-- 
2.34.1

