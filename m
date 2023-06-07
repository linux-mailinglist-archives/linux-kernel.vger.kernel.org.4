Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DF672642A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240012AbjFGPWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241352AbjFGPVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:21:40 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE691FFF
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:21:27 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4458F3F19A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 15:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686151284;
        bh=E1ad9bQ1aGlayjQkBmzknmBzpwDvRLF1iaTT0A2Zyj8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=UREi0LMh9jD2Q/M+ow2Q9XYCMqinW4XhTuGB8+ANSUD1+DHS+eOQmIT5s754VXiQd
         ZHqeGPK/9F4SkGWcpkRUX9iJy6VJPlFEnKIL/Yep/AGIVd5HbyKgFsBGiMxUTXGrf4
         GACe3GGBS9/o8WD5NYmH/Mq4C8HlvkV72ojWzB4h5K875t1YLHcZ+rwo+Lb8KHhpp5
         VzgvCWOV7x8tPkW16HfEXVZf8mbpRLZTvPwXI0RVtxHPqH2FCfPUlTTsQQ4TDaXkyX
         ftQuyrjmdOPQVnAlrkrr8Kf+h2mbAfypfQMlug68W5we4RXrSGPV6AgIDjmud81pHs
         MsDqc+rI99Qeg==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5128dcbdfc1so919990a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 08:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686151284; x=1688743284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1ad9bQ1aGlayjQkBmzknmBzpwDvRLF1iaTT0A2Zyj8=;
        b=a3TQ2dbvlxv65mX5SOHxdWOCMfM0yriFp4i9xjlXmWs5W6WtWyZ/DqAVvjyn2JpWsN
         3wUALXzvVeshFiJwOgmyTxEWXnsg5GWk9aK5O+JpXSac2eWfEcO3Ytw+i5dMbIgQJy/7
         J/h4mIzMb8aueFzeqEL82e8ewETP6oS7j6z16uHJz2TYgE0OoIehTio9kPAr3TNKOK5U
         Ve0gMNIsoLuVgRIX5V4M8HXS5SKan5tVt2Odecnmv1/A189c6mSLvrnFtzpqqFOS8xCx
         N8lGS4qJ9TpqxEHmqvywotFxHjCnUNEnz0+oijDC/H3LO6+qEzjcnV+fgL93TZyIfW0x
         J6jQ==
X-Gm-Message-State: AC+VfDwyWTWxeuwpIbMTo25xzXdUMGuV2TnBJA/q2KP0WUlvBnNW1mFg
        1g9SJZSkbnwHcqnm3yWoQHLolcrVDd9cIUWRZz9bM8NF5xRLru7ZW7I6qUZSu13uyGFIWAFicG5
        6RBzBWtiwy9pOeIbNVJ0QC9FP8MiODmaotuih+1LNtg==
X-Received: by 2002:aa7:d450:0:b0:50d:dba8:c64a with SMTP id q16-20020aa7d450000000b0050ddba8c64amr4485733edr.18.1686151283817;
        Wed, 07 Jun 2023 08:21:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7FsbB/VMu7FXOSfXOBHP9tswUg4dyT9SVSoTyTpn3BCc8/hYEvTcd57G89c35Nc13dQtyncg==
X-Received: by 2002:aa7:d450:0:b0:50d:dba8:c64a with SMTP id q16-20020aa7d450000000b0050ddba8c64amr4485727edr.18.1686151283632;
        Wed, 07 Jun 2023 08:21:23 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id w17-20020a056402129100b005147503a238sm6263441edv.17.2023.06.07.08.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:21:23 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 05/14] ceph: allow idmapped symlink inode op
Date:   Wed,  7 Jun 2023 17:20:29 +0200
Message-Id: <20230607152038.469739-6-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607152038.469739-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230607152038.469739-1-aleksandr.mikhalitsyn@canonical.com>
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

Enable ceph_symlink() to handle idmapped mounts. This is just a matter
of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 8d3fedb3629b..3996572060da 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -956,6 +956,7 @@ static int ceph_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	req->r_num_caps = 2;
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL;
 	req->r_dentry_unless = CEPH_CAP_FILE_EXCL;
+	req->r_mnt_idmap = idmap;
 	if (as_ctx.pagelist) {
 		req->r_pagelist = as_ctx.pagelist;
 		as_ctx.pagelist = NULL;
-- 
2.34.1

