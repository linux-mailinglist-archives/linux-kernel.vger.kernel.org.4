Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA8A73860B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjFUOBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjFUOBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:01:03 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38561BF1;
        Wed, 21 Jun 2023 07:00:58 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f8fe9dc27aso45838415e9.3;
        Wed, 21 Jun 2023 07:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687356057; x=1689948057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e0TQPSS7a9Jk8gsZ9aLEqJ9x+mgzVCzVi1FpIGNdrBw=;
        b=ZY+A+AK+0hrEqCQD5smhWHxGBgM513DkVqUqEYh8CTkbDkfBqlijxtada3pe1oO6RU
         qAnRJTWbOw7A82AmMVkjSnGgvX4adfXs8QGiXJrf6X7elEipSkUouVQM6KxJnfJaRw+8
         vdbu4y6FXWx7It3diymV26tO8gGqKRoKSSoMTKckwFi82e0p3wvuaMs8aGQchu5XJApv
         QkZrVCkbKpxYOjOFUwzBkcJUPPHlM8kE7qx8DZKyA5a6EVkt5cdvnNqjMdW4F9A2c0YB
         cR94RYWH0IbE/c70GB4u4tsRVhXZX3L3HbV4cX8rncCg6FMQcXkp4KO/kfrnykD+lcBw
         f4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687356057; x=1689948057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e0TQPSS7a9Jk8gsZ9aLEqJ9x+mgzVCzVi1FpIGNdrBw=;
        b=EMLmnNOykIzH40j0JFdOmpmPlrnVyMp1JddyM1zX0xCXrJ/A+T84PO+OnDPkD3Svpk
         n/u2C/2ARy95f2AGPm5A9bvRqGVG0MjFfMRYPb5yN+oafB/0IJzLTm8IfHaRgXzhjL7t
         6lMrf5++Jn1SzPAyd/YZ6kIWbxt/yMgIIVDvVMoBfFcJqjEsHm1pYhI9HfCoI5qFfTdJ
         U1dHqir0jK5G7fRAtO/gfeJcaHBdObiIi/QruGAN6imk+rcvXH34lUwxGYbAqo+Xwzr7
         5lFESThKITTGHpXXQCFsoUBqci85KUqHW2fCumR/yhzEMcC0LNEVDp2jZalDkGZHzdxm
         Gdnw==
X-Gm-Message-State: AC+VfDyg2vKw1f1UVE+EVRc7VK7ZLI2FfLqv67IMjuhtVwQ1cJYLrsJA
        v6JqjSml5dIfAJFIX1oDOA95RrTb8tS4ZQ==
X-Google-Smtp-Source: ACHHUZ6USQ+jPF1zdYOcOD+fTnKNaYk6s6ff02iOn4dDuGOymqK21PvMoHXjGTGWe7LJlza2cc3yvw==
X-Received: by 2002:a05:600c:2158:b0:3f9:aaa:37e7 with SMTP id v24-20020a05600c215800b003f90aaa37e7mr7285270wml.0.1687356056879;
        Wed, 21 Jun 2023 07:00:56 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c210f00b003f18b942338sm5118938wml.3.2023.06.21.07.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 07:00:56 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] hpfs: remove redundant variable r
Date:   Wed, 21 Jun 2023 15:00:55 +0100
Message-Id: <20230621140055.2679143-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable r is being assigned a value that is not being read, the
assignment and the variable are redundant and can be removed. It
is also useful to remove r as it's a confusing shadow of another
variable r declared in a higher scope. Cleans up clang scan build
warning:

fs/hpfs/namei.c:560:8: warning: Although the value stored to 'r'
is used in the enclosing expression, the value is never actually
read from 'r' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/hpfs/namei.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/hpfs/namei.c b/fs/hpfs/namei.c
index 69fb40b2c99a..d892a6f74431 100644
--- a/fs/hpfs/namei.c
+++ b/fs/hpfs/namei.c
@@ -556,8 +556,7 @@ static int hpfs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 	de.hidden = new_name[0] == '.';
 
 	if (new_inode) {
-		int r;
-		if ((r = hpfs_remove_dirent(old_dir, dno, dep, &qbh, 1)) != 2) {
+		if (hpfs_remove_dirent(old_dir, dno, dep, &qbh, 1) != 2) {
 			if ((nde = map_dirent(new_dir, hpfs_i(new_dir)->i_dno, new_name, new_len, NULL, &qbh1))) {
 				clear_nlink(new_inode);
 				copy_de(nde, &de);
-- 
2.39.2

