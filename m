Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F66726821
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjFGSLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjFGSLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:11:05 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652EE2126
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:10:55 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D4DF63F16E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 18:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686161453;
        bh=Yx9DhBwZ0J2oRahK7SO/c3VRSYe4JEpen4id9pbwqa8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=YWBfUtHa7qRlgcCQb+3PMmpH/RucR2nd/znRz5zYKeEQkF/XDMDfmWXuhTE2BBJcB
         SyrL+PfAhqDe1sKzZklRKAjRhR54BHdXkMk2ssC/x2Mgkg3ntW1YS3a3lBVGTK5TjL
         Haa6Wa0ZwNf09Yt9AM7/ZYJLOndSeSoV5LS0+8nfbSYIz286oMSmzN4HbCY+pWO0wS
         EVOP1L62LpyMklONjq80XxHNssxN+Ux5lHAXIgfnIha22Z9VkDxelXug7djwaBys2S
         4ICaC4h4jrA5ZVgqzmZ39jqrHoEbnuZXXfbgT59gUnNW/dUBst4i0hX5KTs/wxLdja
         qbL9xnqGr5/qQ==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-977d0333523so459087666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 11:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686161453; x=1688753453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yx9DhBwZ0J2oRahK7SO/c3VRSYe4JEpen4id9pbwqa8=;
        b=b7mQqZHPGtOs5eVl5hDx6pwZ7uSkzYZWUqAR+8OnLkYKYUmyhtcACnQd3bP8mNpSCq
         ykErzRIDvwTyKFXlpiExpkhndLIVoTfthw5IuNb2LTx0FVYzotM6Ao19KOxviJMz4iec
         2Cze/NLt8QuQ5cmmflhLI4bCbbGE8/BoVTCA4s2ZYuuXMY1sFkjE842fkRCmPTIXo0nb
         oysztiDQEC5EZWcwmyg3OnqC1fgVUTD454Ld6IIg7NzUDxagQr21tcTMu2qrfRCNsAQ9
         P6qEAo8taYn6LNMlY2y8eDEUYdQqG0WVwFqrLd/8O0gsoFt7SwUGqNU8VFsNUGtM1/vw
         dZsQ==
X-Gm-Message-State: AC+VfDzCzMC7TtNbDxOZEkqz/9BgIOTp5p6ub5M15xfjJzR/mt2SBmuP
        hy4tIFkCeKsAAnrM84Zp+s3OZwk6q4F0RmX8ks5TkQR1A3ZCFuPiY5ZicOSflYUPdPEz5ZL2mIH
        uB9Jxe6jiFfRhRokM3A2jChB/bxTCgbfmczFIYFX/zQ==
X-Received: by 2002:a17:907:3da2:b0:96a:3e39:f567 with SMTP id he34-20020a1709073da200b0096a3e39f567mr7202641ejc.47.1686161453349;
        Wed, 07 Jun 2023 11:10:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Y4EZF3oDO9KQHXjJRRbjW/E8b2iZk8j6UhQXdR4OzME2Ryqk98zEbdjZ4t0q/JTaCL8k8ZA==
X-Received: by 2002:a17:907:3da2:b0:96a:3e39:f567 with SMTP id he34-20020a1709073da200b0096a3e39f567mr7202627ejc.47.1686161453170;
        Wed, 07 Jun 2023 11:10:53 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id oz17-20020a170906cd1100b009745edfb7cbsm7170494ejb.45.2023.06.07.11.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 11:10:52 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/14] ceph: allow idmapped permission inode op
Date:   Wed,  7 Jun 2023 20:09:52 +0200
Message-Id: <20230607180958.645115-10-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607180958.645115-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230607180958.645115-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable ceph_permission() to handle idmapped mounts. This is just a
matter of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 2e988612ed6c..37e1cbfc7c89 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2408,7 +2408,7 @@ int ceph_permission(struct mnt_idmap *idmap, struct inode *inode,
 	err = ceph_do_getattr(inode, CEPH_CAP_AUTH_SHARED, false);
 
 	if (!err)
-		err = generic_permission(&nop_mnt_idmap, inode, mask);
+		err = generic_permission(idmap, inode, mask);
 	return err;
 }
 
-- 
2.34.1

