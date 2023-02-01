Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A7368614F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 09:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjBAIKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 03:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjBAIKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 03:10:31 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291D322A22;
        Wed,  1 Feb 2023 00:10:31 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so1241349pjl.0;
        Wed, 01 Feb 2023 00:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4z+xa/ZOS4lg8JgsJpJcIgnYCYncFcyrb0bhc7tc1UM=;
        b=iYQlW31fvbyXVLjXTe6OP40e+MO0N6txv06HbybCw/ww1D5R7S8QZ50bK/3gIQcYcV
         dJg8glVQ6xlxGDZVxxqSemYLsrjEnY8HX0c0VDQpErG/OF36j/uMiROeZZAO6LlSrQ89
         Xo+WYFvpjzL+XtjCugj5EE4jfDB0VRp2Mda9VINqjQWUXMdDNSYhd6J7OkbIzWjJFAsG
         1CE94Z06+f1ILfo/eIdTElR5C7ckIySM86CDOr86ZhhUgGwDgEO2B9K7ZOEyRbk5MeGY
         +RbzZt6W0VYboZAlvhqeymvH+bteCXbRjXjI3x6oOFuCnRpTUw51I/wccDoCcTThyNSE
         MKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4z+xa/ZOS4lg8JgsJpJcIgnYCYncFcyrb0bhc7tc1UM=;
        b=NcrOF0qpT1dc1OVB2v0jhFsKEBe223wFOGFFQcf+XUDMXRavtjp9OaHoQFc44y89Lp
         CuWbX/wm5E6qy/xcHjsaWtzBsQMm8aj5oDwQ8sjLKcuAxdxXjNpRLR6Nh523u2/VipR0
         he50G0zOs6UKhvswx6XOgdcp/Jl3h2I2fXEstTnjEq/SFFcj+O1jZtt0RLXLMSiRqLGi
         SDpIPF1XcqTUUgDENAZ2kymKlue+kuG0liMQbWketqlPV+n3f4kmQIzSmJuGp7XGQ7kt
         PmevWIyHPi8AbHeDGCrsRwcPU5ETnaTdR8jeXbUpNfKB1rhxFmu0oohwFjh5gKic+STN
         /cpQ==
X-Gm-Message-State: AO0yUKUaMidaL8MXxHnHQ5hJLWm67rBTn8uPF8QRemCDesF+1gpQGTBV
        LK8j6OvrWr93iifjTwRA71gd+QeK1YLMxw==
X-Google-Smtp-Source: AK7set+D6hQE2PoMqJ60RX22kdP39VVJZPsldfFGc2h+t22OE5ujHWY4p9yHxqoxRzCIZom0eYvFUA==
X-Received: by 2002:a05:6a20:5488:b0:bf:6e8:39a7 with SMTP id i8-20020a056a20548800b000bf06e839a7mr2091617pzk.4.1675239030715;
        Wed, 01 Feb 2023 00:10:30 -0800 (PST)
Received: from hbh25y.. ([129.227.150.140])
        by smtp.gmail.com with ESMTPSA id w79-20020a627b52000000b0058193135f6bsm10751985pfc.84.2023.02.01.00.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 00:10:30 -0800 (PST)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     linkinjeon@kernel.org, sfrench@samba.org, senozhatsky@chromium.org,
        tom@talpey.com, hyc.lee@gmail.com, lsahlber@redhat.com
Cc:     linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] ksmbd: fix possible memory leak in smb2_lock()
Date:   Wed,  1 Feb 2023 16:10:10 +0800
Message-Id: <20230201081010.17446-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

argv needs to be free when setup_async_work fails or when the current
process is woken up.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 fs/ksmbd/smb2pdu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index d681f91947d9..5b7668c04f76 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -7050,6 +7050,7 @@ int smb2_lock(struct ksmbd_work *work)
 						      smb2_remove_blocked_lock,
 						      argv);
 				if (rc) {
+					kfree(argv);
 					err = -ENOMEM;
 					goto out;
 				}
@@ -7061,6 +7062,8 @@ int smb2_lock(struct ksmbd_work *work)
 
 				ksmbd_vfs_posix_lock_wait(flock);
 
+				work->cancel_fn = NULL;
+				kfree(argv);
 				if (work->state != KSMBD_WORK_ACTIVE) {
 					list_del(&smb_lock->llist);
 					spin_lock(&work->conn->llist_lock);
-- 
2.34.1

