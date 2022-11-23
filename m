Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A2D636AC2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238856AbiKWUS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239555AbiKWURH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:17:07 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BC76455E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 12:16:59 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id r18so17653747pgr.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 12:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OIFoNBLa7BYURFlxQcFcpdXU2Rg82ywkO8IDAgROWHU=;
        b=Y8Yycm4Rl7KJcmnJrrix2givTqZv+PvfZ6oAN1RsxUW8MTU9MNzXh6EV341qRi8tKU
         /x3x6NJxfnmjdWl6gmbLiXAT79x8cxrxbNajgCIB5zAuucFQ5H0tGvFaqr6+S/yWYIGH
         6yBdFs3FtCo3gLc6rnnRlXM6vk4xK12fiheC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OIFoNBLa7BYURFlxQcFcpdXU2Rg82ywkO8IDAgROWHU=;
        b=S2Rxo+6DqCiuRLdSv8ANdvfYwhUE5zu6Okv9TB+/4WSxKvQb9T0rfQJg6VrmkcadXF
         UIKKaU6yeRrMJrfsOBfhsCGUr/AgJkDsxUhcJDnU/2PjmBeyMn8yQLSPWuH2SXkVhjsP
         2zhgJnonizti6eNS+lP2krnCniArbZ1jGBKBjvqZqkBUMdwPmpSgo112g2dJIWshhb/4
         smpQTSid/hnUeMHWVxW2rS97A+zknPWL6UFcLbURd5Pf1UCdE8uJZxyp90IRwkOrR0w/
         VXPH2pBar61r2H2QoaDmpXkdg05Qjw3d4QBsC0HtURblHaRH7cn2Txxo6E1GtWn5MmEi
         l73g==
X-Gm-Message-State: ANoB5pkHmk/rCXhm6lhP1/VfYIpolwr7VEEbx8ekYN276Wr7gOBzJiGT
        QFM+r8k7lum4DBivYR9sOQa/Ow==
X-Google-Smtp-Source: AA0mqf5zIONAlhPLlmEX4AzB26dFYV+eRWkYaSEfrqVDlBz4qZA6nsDP4x0aoyykJSYe0pgSOTfI7Q==
X-Received: by 2002:a05:6a00:22ca:b0:56e:64c8:f222 with SMTP id f10-20020a056a0022ca00b0056e64c8f222mr32101937pfj.71.1669234618753;
        Wed, 23 Nov 2022 12:16:58 -0800 (PST)
Received: from li-cloudtop.c.googlers.com.com (30.161.125.34.bc.googleusercontent.com. [34.125.161.30])
        by smtp.gmail.com with ESMTPSA id 85-20020a621958000000b0056b4c5dde61sm13474210pfz.98.2022.11.23.12.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 12:16:58 -0800 (PST)
From:   Li Li <dualli@chromium.org>
To:     dualli@google.com, gregkh@linuxfoundation.org, arve@android.com,
        tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        brauner@kernel.org, cmllamas@google.com, surenb@google.com,
        arnd@arndb.de, masahiroy@kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, hridya@google.com,
        smoreland@google.com
Cc:     kernel-team@android.com
Subject: [PATCH v3 0/1] binder: return pending info for frozen async txns
Date:   Wed, 23 Nov 2022 12:16:53 -0800
Message-Id: <20221123201654.589322-1-dualli@chromium.org>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

This patch adds a new return value, BR_TRANSACTION_PENDING_FROZEN, to
fix this issue. Similar to BR_TRANSACTION_COMPLETE, it means the async
binder transaction has been put in the queue of the target process, but
it's waiting for the target process to be unfrozen.

v1: checkpatch.pl --strict passed
v2: protect proc->is_frozen with lock, fix typo in comments
v3: rename BR_TRANSACTION_PENDING to BR_TRANSACTION_PENDING_FROZEN to
    signify the frozen scenario and avoid potential confusion

Li Li (1):
  binder: return pending info for frozen async txns

 drivers/android/binder.c            | 32 +++++++++++++++++++++++------
 drivers/android/binder_internal.h   |  3 ++-
 include/uapi/linux/android/binder.h |  7 ++++++-
 3 files changed, 34 insertions(+), 8 deletions(-)

-- 
2.38.1.584.g0f3c55d4c2-goog

