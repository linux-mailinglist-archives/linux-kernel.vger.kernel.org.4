Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF95624BE0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 21:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiKJUeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 15:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiKJUeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 15:34:11 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DFFD6F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:34:10 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so5926488pjk.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 12:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fveASnawEKq49sScldsH7xrgcmtVfcP4IVtANZfOHI4=;
        b=I8kyV2WKMz19LsPkoABC4KCBlLbb6sBq8zHFxRiOQcZ2FYzU+B4dzHpSA5b1OQ4sa7
         robQmEgo1Lm9tM24LRMkGesNQaMKi15AKLbsfsJ/8TfL41FeUwzcSZYmSrdECkoP/t//
         255edwZnDyeamI3tMATmSuFv+LAkkOCy4z3i4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fveASnawEKq49sScldsH7xrgcmtVfcP4IVtANZfOHI4=;
        b=S3JKGeWIepmpaOEgYD8tQe1MfPAQK3pxmJsmiGeCiuybDG0G5zXLICtE7O0pEcX/zm
         1TU939JvORA3ouJOG/azy+ZCJZPOZhr2FwLk84r0+0X/phjNUCzEPRisqcjoHEeqQUSl
         qukleiqsNu0dtZrtNBy0q3zb1my7xIvY/qYMN/dKd/GSr8EonHu8N857EVK4CYAjODTT
         +CZaFucBddYkHeFtaO6kp20rFFtihC1O3vcUhW4dY1Yo7zBK0zufgpPyzTdlLlmUfSLO
         pPYwaHlC+fYYO7a9DNAOsv5V3460IkRmR57G0cctEM3Gt5N1beLQEONylle0Q86jgeDF
         Zt5A==
X-Gm-Message-State: ACrzQf2VLgFiBgj2ujuv+k6E0Wa7R1xsV+sGpyQigwyZX2gawI1FoKxB
        lDdnqC1Xmc9IDOa+6nniW574VA==
X-Google-Smtp-Source: AMsMyM5oQevfguO7LmmIkR07MxOIUi+I2j37Ge7D8DUhPHBUiQcC3nQUzu9J/EoU25HgI3LiIAk9zQ==
X-Received: by 2002:a17:902:b20a:b0:178:6f5b:f903 with SMTP id t10-20020a170902b20a00b001786f5bf903mr67857044plr.39.1668112449765;
        Thu, 10 Nov 2022 12:34:09 -0800 (PST)
Received: from li-cloudtop.c.googlers.com.com (30.161.125.34.bc.googleusercontent.com. [34.125.161.30])
        by smtp.gmail.com with ESMTPSA id d207-20020a621dd8000000b0056be1581126sm67703pfd.143.2022.11.10.12.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 12:34:09 -0800 (PST)
From:   Li Li <dualli@chromium.org>
To:     dualli@google.com, gregkh@linuxfoundation.org, arve@android.com,
        tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        brauner@kernel.org, cmllamas@google.com, surenb@google.com,
        arnd@arndb.de, masahiroy@kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, hridya@google.com,
        smoreland@google.com
Cc:     kernel-team@android.com
Subject: [PATCH v2 0/1] binder: return pending info for frozen async txns
Date:   Thu, 10 Nov 2022 12:34:04 -0800
Message-Id: <20221110203405.611600-1-dualli@chromium.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
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

This patch adds a new return value, BR_TRANSACTION_PENDING, to fix this
issue. Similar to BR_TRANSACTION_COMPLETE, it means the async binder
transaction has been put in the queue of the target process, but it's
waiting for the target process to be unfrozen.

v1: checkpatch.pl --strict passed
v2: protect proc->is_frozen with lock, fix typo in comments

Li Li (1):
  binder: return pending info for frozen async txns

 drivers/android/binder.c            | 31 +++++++++++++++++++++++------
 drivers/android/binder_internal.h   |  3 ++-
 include/uapi/linux/android/binder.h |  7 ++++++-
 3 files changed, 33 insertions(+), 8 deletions(-)

-- 
2.38.1.431.g37b22c650d-goog

