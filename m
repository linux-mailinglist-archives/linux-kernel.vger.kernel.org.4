Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339076C9460
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 14:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjCZM50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 08:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjCZM5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 08:57:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8F77DAA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 05:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679835402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=47SSw0FAIC6XRUpZxGWJ69o8W+2IBdufTOfNiRZChbc=;
        b=anJzAu5lQiL31+lV5t3Jv1WXe+JzsRa38HArQWvkJqaNQM4BHwfw9UryezYaYvgOOjdwu3
        QIe59YNq6/fGgOkI0ONB6gK40dxrcMzpRy7JLOd/bHHo3pTQfsOLF/XoVayakeSeawGGHA
        1sC4aSFk+Unvad9r5UgWsqM4l/Gjuuc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-4kGO0NRZN-CNK5sFLKMs2Q-1; Sun, 26 Mar 2023 08:56:41 -0400
X-MC-Unique: 4kGO0NRZN-CNK5sFLKMs2Q-1
Received: by mail-qt1-f197.google.com with SMTP id u1-20020a05622a198100b003e12a0467easo4199500qtc.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 05:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679835400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47SSw0FAIC6XRUpZxGWJ69o8W+2IBdufTOfNiRZChbc=;
        b=vRaWR/IYnhdrNBaKG49i5irIfZ6jfr1YZhPt7fSu335Gixd+MLKNTBEI6DIUHQG9lC
         Zlx+JmfSCkf0AuFf7iMZBJ2+Wl6+J2unpInxYJZuH3o/jK0NiGpR8Q92Kg3IslglTmL7
         EIuIhqB8fDHAp3XsKVIyZ+b28nSg9E+eiFhAxHpo0W/PVAkDKyABKTPDv3UInbC6tKyA
         XfRWR2B1o+d1AHIhWdYT/tiErsLQKPaQ4fsEw3qzUIc8lwuY6fMwGpmiWp1TPNU7fCWa
         kRgG8G5eWA2wj/+6dW3ROgHvqc7mJyiRg5JMpu4uVAaRXJqL4xoN249chK1OeuRTAEAB
         mmRg==
X-Gm-Message-State: AAQBX9c3CoaaE1MgptmhkfM3KxzwxC5SsUuaJbwup0BoD+fhFnP7jBRx
        qoP6jL58675CB4/UOHRMNhKLr8sMR6M3gLs60Ic8160NcT/crg3mvrzXPfTMoogupdw6AUb94NQ
        Sg0xrHORXhB17PExqvl+qamp/UkorEztb
X-Received: by 2002:a05:6214:1250:b0:5bd:74a7:e6f0 with SMTP id r16-20020a056214125000b005bd74a7e6f0mr14502202qvv.20.1679835400645;
        Sun, 26 Mar 2023 05:56:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350bhx11T/RNLAJdDBA6Mssd67CsVxPgrDHm9hYyEZVFHfIDz4wjUNY5I3aS4EEt4hazRV+cDfA==
X-Received: by 2002:a05:6214:1250:b0:5bd:74a7:e6f0 with SMTP id r16-20020a056214125000b005bd74a7e6f0mr14502188qvv.20.1679835400391;
        Sun, 26 Mar 2023 05:56:40 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id r80-20020a374453000000b007465ee178a3sm14628954qka.96.2023.03.26.05.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 05:56:40 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     song@kernel.org, nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] md/raid5: remove unused working_disks variable
Date:   Sun, 26 Mar 2023 08:56:37 -0400
Message-Id: <20230326125637.1352895-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang with W=1 reports
drivers/md/raid5.c:7719:6: error: variable 'working_disks'
  set but not used [-Werror,-Wunused-but-set-variable]
        int working_disks = 0;
            ^
This variable is not used so remove it.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/md/raid5.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 7b820b81d8c2..2b1e78c46817 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7716,7 +7716,6 @@ static void raid5_set_io_opt(struct r5conf *conf)
 static int raid5_run(struct mddev *mddev)
 {
 	struct r5conf *conf;
-	int working_disks = 0;
 	int dirty_parity_disks = 0;
 	struct md_rdev *rdev;
 	struct md_rdev *journal_dev = NULL;
@@ -7913,7 +7912,6 @@ static int raid5_run(struct mddev *mddev)
 			goto abort;
 		}
 		if (test_bit(In_sync, &rdev->flags)) {
-			working_disks++;
 			continue;
 		}
 		/* This disc is not fully in-sync.  However if it
-- 
2.27.0

