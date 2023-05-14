Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3618701EAE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 19:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbjENRYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 13:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjENRYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 13:24:04 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18231985
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 10:24:03 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-510634bba37so4423a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 10:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684085042; x=1686677042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bhdn8N3vjt5NpRXjd0CXpQ3x1s9gcdBgiJ6kPjy6i+k=;
        b=ZmAk5vL9yNEtkeODSVlHMUipUbsEG3xzA46o8BdUVqDQlN3FKOxOxR2LMx9Dh682s7
         5VrOnk2VAhIsNq/cTrRLmgQ4gEhXB4FKbHK92rCi8pnrFZ/sDfDXGSAaiwq/UVlLvhkV
         wJ6tkyjX8LYHmS8t7bMawnus6kXhMOxQrj8XxCrguUOlECf7OlVomgE+bLbjVW9kDHMT
         wjMZic4f86Z276EgD0cBUhg6CXHnUtWH5+FvaoSvhpJX+fa5kxizw1WBXnBBLWDnALlP
         qi08IHgzKHYdsOY+72oUVlyKpFssCiLqNMoHzf6APU4s4VC+haT6QoZiQzuHjt0gPg0V
         J0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684085042; x=1686677042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bhdn8N3vjt5NpRXjd0CXpQ3x1s9gcdBgiJ6kPjy6i+k=;
        b=KaYX3uiXCT9DntwGliu/jkXzSrdqyZHp8wo3B8K3sLahJCOB1ekCBvhoNHmLZuqYsy
         5vv7g8vr6sOCK6MdjYTCql7j6HWnUiO4Wx/zEZnxNeux7IiN9fGbOeJny4SuN6NpPBDQ
         MBL+qbaAXuueoi2mat6LI3tmnwoM2hNN52y4f+T41+btH9xAuVqlVLaeL7XVzkXF4gGi
         /suR64PkVk1fwV6oqXwQD36T/vlpN0PTNhLETlM3ZMWPhjeGtJBE6SMS3BxIOyOYmkgc
         zoFEXmrZqtzXwYQuEpirCj/6o1VC0BAoeqaeCqO5ZoOuax+mPaaMZo/q6ISscRZqj1m5
         ajqA==
X-Gm-Message-State: AC+VfDw9q9LyhvGKgduPMrzmKTttbGH7uN0q9jO+xT/dZ6v0WxbR9+se
        dJXERRRB4VhNl6KGIo3TYcA=
X-Google-Smtp-Source: ACHHUZ7V/E1SXJmh0CcocZMAWa/YKLC03nZJyLWERYojD9FXz+CaJzep3o7rHLaWpWdYTH0XHSlZmA==
X-Received: by 2002:a05:6402:510e:b0:506:c24e:667d with SMTP id m14-20020a056402510e00b00506c24e667dmr29993006edd.4.1684085041883;
        Sun, 14 May 2023 10:24:01 -0700 (PDT)
Received: from ivan-HLYL-WXX9.. ([37.252.94.55])
        by smtp.gmail.com with ESMTPSA id ig13-20020a1709072e0d00b0096623c00727sm8405986ejc.136.2023.05.14.10.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 10:24:01 -0700 (PDT)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] debugfs: Correct the 'debugfs_create_str' docs
Date:   Sun, 14 May 2023 21:23:53 +0400
Message-Id: <20230514172353.52878-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation of the 'debugfs_create_str' says that the function
returns a pointer to a dentry created, or an ERR_PTR in case of error.
Actually, this is not true: this function doesn't return anything at all.
Correct the documentation correspondingly.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 fs/debugfs/file.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 1f971c880dde..b7711888dd17 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -940,15 +940,6 @@ static const struct file_operations fops_str_wo = {
  * This function creates a file in debugfs with the given name that
  * contains the value of the variable @value.  If the @mode variable is so
  * set, it can be read from, and written to.
- *
- * This function will return a pointer to a dentry if it succeeds.  This
- * pointer must be passed to the debugfs_remove() function when the file is
- * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, ERR_PTR(-ERROR) will be
- * returned.
- *
- * If debugfs is not enabled in the kernel, the value ERR_PTR(-ENODEV) will
- * be returned.
  */
 void debugfs_create_str(const char *name, umode_t mode,
 			struct dentry *parent, char **value)
-- 
2.34.1

