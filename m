Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8437404FF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjF0U2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjF0U2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:28:50 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069F526BC
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 13:28:49 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7836272f36eso91628439f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 13:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687897728; x=1690489728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PFLrb4WV2M4S89RJ5tGpysGkvtpZPYvXfwu8Q/oJAtk=;
        b=YqGAEVAB7jKY3SC7JMS+YVlGCMX3bcVrEjuve8PF40RpF5EQXfMiKRzEisKlIoDjiZ
         EwIwa+P4b2OvYAHRGqWpivlALLBlzKRWraPtNato/tW1mRff5lW4YJrCJx/mSG5elsif
         9lU1eNeWLShQXNeyrpCXNtFkGVKh1IW9i/VFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687897728; x=1690489728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PFLrb4WV2M4S89RJ5tGpysGkvtpZPYvXfwu8Q/oJAtk=;
        b=RxrVOTvaBIDfRV680BoPsfcXQqElZ9Cn/MmFZihOZp/FMIEmvP84s0pjs41jYswZRH
         NwxwPaFPf9JW2psPuE/V875mOyfCSzxdDws30r2odS78eMtHIyIFVzNQwiE4vq/NBKoz
         INAq/fHbXpfPlMjyVoUa3sUP+UjvNPAJBXMwhhKaFLgh1IT/2lvU8p1Ft73las3Iher2
         RR7/kCRoFiHe7LXO1S2H5FPm2QMlCuOJwXaay6oBQQYmM2Qj/rDT0yeq1JXwSduFBEMi
         I3Ojr8V8Zn934vmgwQu0KgWkWjNaSsWmrzHVLbcj47TxtMolkGOHzujPtBrG0wUqXUEw
         vJsw==
X-Gm-Message-State: AC+VfDyplVjJYC6ompX5IQ3plHmCCZNB+c9U5vpoU0dK0Tz+2Lxc5T9G
        6vrjQNkagjRLcswNi4+gENchbg==
X-Google-Smtp-Source: ACHHUZ4CnWXfi9m6352atFGPgRiUKQ3JmiGDS7T3mcdhVwx+G6CYu1eAyxSrRz6q3TcqDXotxz0Gcg==
X-Received: by 2002:a92:d08a:0:b0:345:8373:4ca8 with SMTP id h10-20020a92d08a000000b0034583734ca8mr10285835ilh.27.1687897728420;
        Tue, 27 Jun 2023 13:28:48 -0700 (PDT)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id k11-20020a02c64b000000b0042ae80a56d6sm387463jan.73.2023.06.27.13.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 13:28:48 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>, stable@vger.kernel.org
Subject: [PATCH] dm: verity-loadpin: Add NULL pointer check for 'bdev' parameter
Date:   Tue, 27 Jun 2023 20:28:01 +0000
Message-ID: <20230627202800.1.Id63f7f59536d20f1ab83e1abdc1fda1471c7d031@changeid>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a NULL check for the 'bdev' parameter of
dm_verity_loadpin_is_bdev_trusted(). The function is called
by loadpin_check(), which passes the block device that
corresponds to the super block of the file system from which
a file is being loaded. Generally a super_block structure has
an associated block device, however that is not always the
case (e.g. tmpfs).

Cc: stable@vger.kernel.org # v6.0+
Fixes: b6c1c5745ccc ("dm: Add verity helpers for LoadPin")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 drivers/md/dm-verity-loadpin.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/md/dm-verity-loadpin.c b/drivers/md/dm-verity-loadpin.c
index 4f78cc55c251..0666699b6858 100644
--- a/drivers/md/dm-verity-loadpin.c
+++ b/drivers/md/dm-verity-loadpin.c
@@ -58,6 +58,9 @@ bool dm_verity_loadpin_is_bdev_trusted(struct block_device *bdev)
 	int srcu_idx;
 	bool trusted = false;
 
+	if (bdev == NULL)
+		return false;
+
 	if (list_empty(&dm_verity_loadpin_trusted_root_digests))
 		return false;
 
-- 
2.41.0.255.g8b1d071c50-goog

