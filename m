Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B4361882B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 20:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiKCTGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 15:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiKCTF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 15:05:57 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A385FCB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 12:05:56 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id g129so2476205pgc.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 12:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xTPyVtvwLQJHw9GIZEAspcuqMem8SnG9GJ/cx57p+QY=;
        b=NSiUbzUjU9/BG/mNkp6zWKE1oIVW4/YEy2Mq5C77lqgnE1na+uP1bu5KbKY7zz/Dlq
         h5FFfqVSHeay/uc3T9IG9KqLTzY4noe0Uiy53kDkglT1/H1pp0XqqXYuSUBSTDBJNFZ6
         k3fz8aOOKEp2yyNwlE8XZJ5i4TbxL3EB99t3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xTPyVtvwLQJHw9GIZEAspcuqMem8SnG9GJ/cx57p+QY=;
        b=1o3OeoIIJqJXYTPbKLr+71EM8nn42/sLYRI3cMXcf2NXMQCVsLZB+8914caYodJgOr
         Ha1khwnXs68ibIC7PlxHsZWpKO5nbsN1kXcXAvsUTqUza5XfAVGcxa51GMn7W2/oEurs
         PHlmmpXbMXfiMmmleDkNN/5FyAwYPltGivj5E/UrPHrkJzNjA0d6QbZOVrkuXsLIuR8R
         B5MKNd2qKuZzFcE0uGtrf7qQTXln8Tg64pV4AOWcnzGU+fonWzP7u0QCxWHniCBM5aEn
         gv6CKuI/atAwJiAGfjSXO+gY9UYYNqEDqkRL/cInCRQ5Zr+0zV61M7fWwj3Bi2k7/NNM
         maXQ==
X-Gm-Message-State: ACrzQf3IRQnldk1VSPNExTkaXaIInRe+gxVLbl8zbzvdPjjoc16+mIlW
        L1MoDW56f9fm0ypdNxGh/1IMPTkYO0ogFA==
X-Google-Smtp-Source: AMsMyM7Ylop0fVj1dPQAh/0l7kc0yYBdAaiFk0ZRnROC2B2qyS8JfT69r5GIBsaZlnDFzG4SbUxRaQ==
X-Received: by 2002:a63:1145:0:b0:46a:e00c:579c with SMTP id 5-20020a631145000000b0046ae00c579cmr27519259pgr.279.1667502355638;
        Thu, 03 Nov 2022 12:05:55 -0700 (PDT)
Received: from li-cloudtop.c.googlers.com.com (30.161.125.34.bc.googleusercontent.com. [34.125.161.30])
        by smtp.gmail.com with ESMTPSA id q13-20020a63d60d000000b0046ae5cfc3d5sm1070973pgg.61.2022.11.03.12.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 12:05:54 -0700 (PDT)
From:   Li Li <dualli@chromium.org>
To:     dualli@google.com, gregkh@linuxfoundation.org, arve@android.com,
        tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        brauner@kernel.org, cmllamas@google.com, surenb@google.com,
        arnd@arndb.de, masahiroy@kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, hridya@google.com,
        smoreland@google.com
Cc:     kernel-team@android.com
Subject: [PATCH v1 0/1] binder: return pending info for frozen async txns
Date:   Thu,  3 Nov 2022 12:05:48 -0700
Message-Id: <20221103190549.3446167-1-dualli@chromium.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Li <dualli@google.com>

User applications need to know if their binder transactions reach a
frozen process or not. For sync binder calls, Linux kernel already
has a dedicated return value BR_FROZEN_REPLY, indicating this sync
binder transaction will be rejected (similar to BR_DEAD_REPLY) as the
target process is frozen. But for async binder calls, the user space
application doesn't have a way to know if the target process is frozen.

This patch add a new return value, BR_TRANSACTION_PENDING, to fix this
issue. Similar to BR_TRANSACTION_COMPLETE, it means the async binder
transaction has been put in the queue of the target process, but it's
waiting for the target process to be unfrozen.

v1: checkpatch.pl --strict passed

Li Li (1):
  binder: return pending info for frozen async txns

 drivers/android/binder.c            | 23 ++++++++++++++++++++---
 drivers/android/binder_internal.h   |  3 ++-
 include/uapi/linux/android/binder.h |  7 ++++++-
 3 files changed, 28 insertions(+), 5 deletions(-)

-- 
2.38.1.431.g37b22c650d-goog

