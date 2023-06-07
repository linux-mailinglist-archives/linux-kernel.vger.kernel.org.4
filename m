Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAADB726817
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjFGSLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjFGSLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:11:01 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173391FFF
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:10:49 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2356F3F1D1
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 18:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686161446;
        bh=6uQHZNltQASHUIIPvj6JLa2X5jqdjHd99JgtiW/BGQk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=h3W7GllYcOrBm4yfYbz4BcQL+3CI72qW+DWDt5eiX/jgVzlcDYpnDhLFmaFWXvKyJ
         64mc+j2uyHUk7AlfwIWode4+eGsXfjd2LKKzhE6E3viq+oq3s3ZU3UTy0I6P0YpoSe
         tnudjz1uui3/92exROfVCJqAUMnOoE5mqP1kwU+h2qIkPVT1cs67n4kGcvDAxujktF
         UF6pKCa3pn/XVyJLLpzQBpTg6bG0tBQnWqIW7DH1VOZR/V4gGuBFbhZiBeobCw9jK8
         11irsLs13jHxic2ARpkbELtyKP+zA0nWf1kI3sYSe8rP432RyjeoDdm2oXyuYYOPhM
         DjwMcO6xl2VcA==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-977d0333523so459070066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 11:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686161446; x=1688753446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uQHZNltQASHUIIPvj6JLa2X5jqdjHd99JgtiW/BGQk=;
        b=jIy5weLtZgUWYJWvefqxJ0SGtKzBUP1EMBVgQaeAb5awk1wksb7F9JwkLZ7T4JX6v3
         ootVdMvohrmkIU1RAX5KBxS4mpcLyyh2pNLDAx9bbaYo1h/jVjYvFCfDfshf+fp0HbjG
         PhCpKu2YDw3xfK3oPMi/uGITNRyJfVwLhyQSBj2FJVAN76FVZGuTn44p2x3E48dtxKYW
         CnTwhmY0kJdKgUqq+fjZFMkUYM9Q/i4c6HVxKr8KP4/B8VM2KZ1JG/cfoKmsBk9gLk3T
         I5K6vIEr1qvZB4pxMD9829wPHmowryJ2AsCI8XiXsFUQLMMouoh+9xJFDmuWSDRJteG9
         /dAQ==
X-Gm-Message-State: AC+VfDxK7CuB+qnlQq3jpuHr4v/8c6JYOghUsMOe57sC3VcG9rJWsf5z
        hJq278rfpGHpxDcZdizvT3djTcdRSElFg9hcbrDpgTb5pPmMAHuWe6OEhBm1xfFclrkYd4ZRxKJ
        asW+S+jy1qf2kuQaxhhTulL9U9GL7VEBkosjIKVMnlA==
X-Received: by 2002:a17:907:3e99:b0:96a:29c0:8515 with SMTP id hs25-20020a1709073e9900b0096a29c08515mr7106337ejc.58.1686161445977;
        Wed, 07 Jun 2023 11:10:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7AWxbyPvcXlQw3axgBfuZq1pyMG2G2W86d1AY82qx9seAOayCbRG2bCQML7fs+V7QljuN2tw==
X-Received: by 2002:a17:907:3e99:b0:96a:29c0:8515 with SMTP id hs25-20020a1709073e9900b0096a29c08515mr7106326ejc.58.1686161445803;
        Wed, 07 Jun 2023 11:10:45 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id oz17-20020a170906cd1100b009745edfb7cbsm7170494ejb.45.2023.06.07.11.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 11:10:45 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/14] ceph: allow idmapped mkdir inode op
Date:   Wed,  7 Jun 2023 20:09:49 +0200
Message-Id: <20230607180958.645115-7-aleksandr.mikhalitsyn@canonical.com>
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

Enable ceph_mkdir() to handle idmapped mounts. This is just a matter of
passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v4:
	- call mnt_idmap_get
---
 fs/ceph/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 5025b570683d..5ef90a49b156 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1024,6 +1024,7 @@ static int ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	ihold(dir);
 	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
 	req->r_args.mkdir.mode = cpu_to_le32(mode);
+	req->r_mnt_idmap = mnt_idmap_get(idmap);
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL;
 	req->r_dentry_unless = CEPH_CAP_FILE_EXCL;
 	if (as_ctx.pagelist) {
-- 
2.34.1

