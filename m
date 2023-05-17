Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6303707229
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 21:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjEQT2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 15:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEQT2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:28:45 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65787A5D7;
        Wed, 17 May 2023 12:28:10 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ae4c5e1388so12985685ad.1;
        Wed, 17 May 2023 12:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684351686; x=1686943686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MTGzcnwjQ4xJ2Wkwnqn9RSpjpoInTurXDa8iPfKEJtc=;
        b=KVITzgibmYp4fo0QtLoUgDa7cy8blgbnz8iO4lnJmyH8vFLBso+EocArB8Tom9nZ8g
         1l9OaWFsuXa5pmrIqApOBBbuFNL5iidzM2mSyWBa59SqS0bWrQuw7KUemiE6LH3hLmvQ
         Z5GPjuGgixcQn2vYyaS5qPofqtWLhUmMX5rySbBssivDkJzgwAp6BQD7bNNj/iiMbPAt
         UD29S7TRwapkEoVg28+jib9gM/n4RAWvd2J9wwIUxn448X+V/6H7iZC2I5cJzJ3cs2ig
         GCG9Y8+K7P4jVatLpEGzCrh1JmoY+1/clgKOFRU0c/Uiqip/X1oM4mmd3zzH98zohXqP
         JvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684351686; x=1686943686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MTGzcnwjQ4xJ2Wkwnqn9RSpjpoInTurXDa8iPfKEJtc=;
        b=dQp8khIM+9hlg4BZWv6FYGihGJCvaszLkhFv3PMV3f+gOW9O0fYBFgfhxyrZxxQBrA
         bMT7/srGxQnP1VmztKS41qqlWiyROylFLScYCws6ayzx5+HPGSTWRFn8V9Xy17pmBh9w
         NkLJg9pISIhNbxGMhg6fodMUi/I5pHQg7l/Sg6U0kiNeT2OgXFCCDRUSJE8/FemCFeOz
         X1/+EE2zLd8FPuhHkMZM14i0jgdovWXdutDETzBPWd/W9y3UpPL2pEkjXsaAKdtD1MPM
         5FdgMmiMacpKVKR4/A5Adjw8APkmkf/6QNqEXvRByK4wBkS4iVrmf3IFIc3SQ2EiPhfJ
         7aCw==
X-Gm-Message-State: AC+VfDw6RmWEIGD9jHe9hn/Ch/mwPBT8TtOxIR9WbOajQ6bnl9E7id8u
        yxVwlGYwUplhDeU9KlvFuB8=
X-Google-Smtp-Source: ACHHUZ6P9uutxrRk6xX3VkoQvVslYTJhJi44kGdTHZkQYguykJ67TGOFgAUk7oNT1qcDneRgRiDYcw==
X-Received: by 2002:a17:902:e5d0:b0:1ae:66cf:b90f with SMTP id u16-20020a170902e5d000b001ae66cfb90fmr57873plf.66.1684351686212;
        Wed, 17 May 2023 12:28:06 -0700 (PDT)
Received: from localhost.localdomain ([111.201.128.95])
        by smtp.gmail.com with ESMTPSA id jo13-20020a170903054d00b001a641e4738asm18005630plb.1.2023.05.17.12.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:28:05 -0700 (PDT)
From:   Yeqi Fu <asuk4.q@gmail.com>
To:     ulf.hansson@linaro.org, CLoehle@hyperstone.com,
        adrian.hunter@intel.com, avri.altman@wdc.com, axboe@kernel.dk
Cc:     Yeqi Fu <asuk4.q@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ivan Orlov <ivan.orlov0322@gmail.com>
Subject: [PATCH] mmc: core: Fix error checking
Date:   Thu, 18 May 2023 03:26:54 +0800
Message-Id: <20230517192654.367892-1-asuk4.q@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
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

The functions debugfs_create_dir and debugfs_create_file_unsafe return
ERR_PTR if an error occurs, and the appropriate way to verify for errors
is to use the inline function IS_ERR. The patch will substitute the
null-comparison with IS_ERR.

Suggested-by: Ivan Orlov <ivan.orlov0322@gmail.com>
Signed-off-by: Yeqi Fu <asuk4.q@gmail.com>
---
 drivers/mmc/core/block.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 00c33edb9fb9..507bebc22636 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2908,7 +2908,7 @@ static int mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
 			debugfs_create_file_unsafe("status", 0400, root,
 						   card,
 						   &mmc_dbg_card_status_fops);
-		if (!md->status_dentry)
+		if (IS_ERR(md->status_dentry))
 			return -EIO;
 	}
 
@@ -2916,7 +2916,7 @@ static int mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
 		md->ext_csd_dentry =
 			debugfs_create_file("ext_csd", S_IRUSR, root, card,
 					    &mmc_dbg_ext_csd_fops);
-		if (!md->ext_csd_dentry)
+		if (IS_ERR(md->ext_csd_dentry))
 			return -EIO;
 	}
 
-- 
2.37.2

