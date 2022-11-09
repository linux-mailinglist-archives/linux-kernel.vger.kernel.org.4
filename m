Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B2F622B18
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiKIMEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIMEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:04:49 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1B82A726
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 04:04:47 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id k5so16508924pjo.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 04:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0s3cxJ3sHKa2IH5jImaelb3lptAzKadDfKWm7RrmSM=;
        b=0u+Y1bvrB+uIJ9r45t2leywA/j6CnxdI1J/xGQRyBrlkq3/VCcnwFR/8f2ibOZadFm
         5uM539JlnXwUbiluDGLqvTSpy/ST1xSTyMbQ7so++YUpSb4TUsnrd9eWceowvzcgxx1Z
         htGJesNlZHDHg9hTP0Hf4HnvT3z/vyJpnTMMkn9NcwUIYqzIfTZMqjFtt2Zd9Mdvr4Y3
         wmB3mRqs36bIrzRAt3Wwbym8nXv0ceyK5M9Wp/qqWU1bJZGRoj254ueThRqnkHSxikUL
         Io0sDALIzRZEW8gjrD4L+cO88bu8kf5P0M3QGnGxvRnCcDd33aA1jqW80vrPBDwKdo7o
         SjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0s3cxJ3sHKa2IH5jImaelb3lptAzKadDfKWm7RrmSM=;
        b=Bj3cG8iNxM9lVkrinD8NeXBj3Csvt+GcFNSW7o8OSI2V6k+Mh1crtFX7/yUnY7Jbrc
         +/2hAGP/vqwrQOnTgnoO63GZchfluVXB/G99BpFIzW5E+6wAzTi4Wjx/v/lTE1qvuO8D
         f0dPwKr+NiEQFY73a1ScZr29swXvdlCDi7Fqc3YFVYKdzFlsEVxxt7SP//KRrADD0ki/
         vBsiOJOxWablKyO/1xfnLFG0V+ANV6TGBDQdtQjWklrJFZY87vx+fm6KV/JJIuXUrwVL
         x8MqXAsgdp9LxrKNMyky/GWnN6/J2L7DJM8/1maeDQYbYO75l6cQLGLQkZWvOXiF5ovf
         p0Nw==
X-Gm-Message-State: ACrzQf36NicqweB/lfgWuOKT4EmNNOs0i7gA8VFr/oseDpGlfILrQB1P
        mIejrJPae9/glxxx7X+QF+53QQ==
X-Google-Smtp-Source: AMsMyM6+yQNvNpRFLjzNuxSJuVgzbKZDHv9zB27pklJIi+LG2NXDhfnwxqFIhpwjxakNw2m3JyR4VQ==
X-Received: by 2002:a17:903:264b:b0:186:af7a:391d with SMTP id je11-20020a170903264b00b00186af7a391dmr60835852plb.19.1667995487443;
        Wed, 09 Nov 2022 04:04:47 -0800 (PST)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id c195-20020a621ccc000000b00550724f8ea0sm8064581pfc.128.2022.11.09.04.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 04:04:46 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     gregkh@linuxfoundation.org, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        syzbot+2fdf66e68f5f882c1074@syzkaller.appspotmail.com
Subject: [PATCH] fs/kernfs: Fix lockdep warning in kernfs_active()
Date:   Wed,  9 Nov 2022 20:04:15 +0800
Message-Id: <20221109120415.55759-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <0000000000002473fd05eca7540a@google.com>
References: <0000000000002473fd05eca7540a@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot found a lockdep warning in kernfs_find_and_get_node_by_id(),
bisected to the commit c25491747b21 ("kernfs: Add KERNFS_REMOVING flags"),
which didn't hold kernfs_rwsem before call kernfs_active(kn).

Since kernfs_find_and_get_node_by_id() doesn't have to get active count
of kn, only need to get a stable refcount of kn, so it should be enough
to just check kn has been KERNFS_ACTIVATED.

Reported-by: syzbot+2fdf66e68f5f882c1074@syzkaller.appspotmail.com
Fixes: c25491747b21 ("kernfs: Add KERNFS_REMOVING flags")
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 fs/kernfs/dir.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 6acd9c3d4cff..08f0f1570cd7 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -705,7 +705,13 @@ struct kernfs_node *kernfs_find_and_get_node_by_id(struct kernfs_root *root,
 			goto err_unlock;
 	}
 
-	if (unlikely(!kernfs_active(kn) || !atomic_inc_not_zero(&kn->count)))
+	/*
+	 * ACTIVATED is protected with kernfs_mutex but it was clear when
+	 * @kn was added to idr and we just wanna see it set.  No need to
+	 * grab kernfs_mutex.
+	 */
+	if (unlikely(!(kn->flags & KERNFS_ACTIVATED) ||
+		     !atomic_inc_not_zero(&kn->count)))
 		goto err_unlock;
 
 	spin_unlock(&kernfs_idr_lock);
-- 
2.37.2

