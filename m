Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A9C70FA53
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbjEXPf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236329AbjEXPfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:35:03 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEED2E46
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:34:43 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 57F033F187
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 15:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684942442;
        bh=xxg/uwnVyZOP2Ay/FSpDiOkYB17FXWwEBwZ7vkk162A=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=X081nxL6/uAvTf2GM0fAkg8hm+G7OTDi0PWioMjaajqKZHjRAKxUP4cCZ/oKIqwlG
         uFS7bbJB1dhdpf+tkNJMm4dp1s/33I+SxqKO1NEebND+/Yhvgupqj5F8lqnZSrTbuQ
         hsbX0jBhx/ndP3lB4Qj9OSf+V77UppjdvQdwbRFIFBugcNQYcAfOP/7VwivG2mjBla
         JbkuxgTgOMuclgZNX2uHmuwPpKGu646r3pnEqW5w421xvZ1AQlusnpZGDOMAMP53tL
         8cx/XzBY1gSkhr9EJU3f36T7dze9oBLG4f3/AFYqcVBWtY6sVrV7v6fYxI/FPSw9Ws
         ReknYqyKkVo5A==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-510d8e4416cso1503891a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684942441; x=1687534441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxg/uwnVyZOP2Ay/FSpDiOkYB17FXWwEBwZ7vkk162A=;
        b=dYdolCj+4GIv95tE0kofD7riFAbizLo39brC2p8I03HlioyQK/70nrqP9TvEQqLyC5
         LKwXxRyF6LZP0KRIrAaDIKrXd31Q5TbS/nUQqI488N5tZUNORLPOxpmP0y8yLWUpOIFn
         MFdc/u7qL4PuZvfeDpw8cPbvNN4UjdZBNXb2ZdgaNStt/kpdVxmxENbTXTBgGoV/IDCe
         3TJ1cwoWn6e9hg9iZbtgHw/79b2DtcxpHj36Yw2+GQuAKDO12v9BzDEmb1ELs10pggU7
         IoyAXwpULqxyt5VBixG2ZwA7n1/UpSQxfAD8IP1eojZfi67kOiBE9hgCJr6mwc+o9Rs5
         T+KA==
X-Gm-Message-State: AC+VfDytsBTaIPzWIsxm9Ti6XQ+dvDqp/ibbtb+NqN5RD7EERRvfjHRE
        ikHmNakLIOCQ2rDJPVDLktDwfZSCbU/f3xl+6BWqRdMNNcdCJiiBvw+ra6WkxUT7txYxcW89H6E
        pG2GNIj5O2JzHDdWQq76v6nM8LkKHVKmOjU9bDBwKRA==
X-Received: by 2002:a17:907:728c:b0:96f:f6a6:58cc with SMTP id dt12-20020a170907728c00b0096ff6a658ccmr9115839ejc.15.1684942441741;
        Wed, 24 May 2023 08:34:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Q7Lsu20tS8hE/7FwlwR1NjZ7p+guAstMYuytSVHgRos67j/I/Z+zrmEJ9DtP+ZasFoivgRg==
X-Received: by 2002:a17:907:728c:b0:96f:f6a6:58cc with SMTP id dt12-20020a170907728c00b0096ff6a658ccmr9115823ejc.15.1684942441514;
        Wed, 24 May 2023 08:34:01 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-074-206-207.088.074.pools.vodafone-ip.de. [88.74.206.207])
        by smtp.gmail.com with ESMTPSA id p26-20020a17090664da00b0096f7105b3a6sm5986979ejn.189.2023.05.24.08.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 08:34:01 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/13] ceph: allow idmapped mknod inode op
Date:   Wed, 24 May 2023 17:33:06 +0200
Message-Id: <20230524153316.476973-5-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable ceph_mknod() to handle idmapped mounts. This is just a matter of
passing down the mount's idmapping.

Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index cb67ac821f0e..8d3fedb3629b 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -884,6 +884,7 @@ static int ceph_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	req->r_parent = dir;
 	ihold(dir);
 	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
+	req->r_mnt_idmap = idmap;
 	req->r_args.mknod.mode = cpu_to_le32(mode);
 	req->r_args.mknod.rdev = cpu_to_le32(rdev);
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL;
-- 
2.34.1

